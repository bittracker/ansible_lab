#!/bin/bash
# (c) 2016 Sebastian Gerhardt <oss@bittracker.org>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################
# Variablen mit Globalen Einstellungen:                                      #
##############################################################################
PROVISIONDIR="/vagrant/provisioning"
VAGRANT_KEY_URL="https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant"
VAGRANT_KEY_PATH="/home/vagrant/.ssh/id_rsa"






##############################################################################
# Provisioning Script:                                                       #
##############################################################################
if [ "$UID" -ne 0 ]; then
	echo "Ich mache nur als root weiter ;-)"
	sudo $0
	exit $?
fi

# Generieren einer Hosts TXT
if [ -f $PROVISIONDIR/hosts.txt ]; then
echo erzeuge eine Angepasste /etc/hosts Datei...
HOSTS=$(cat $PROVISIONDIR/hosts.txt | grep -v $HOSTNAME)

cat > /etc/hosts << EOF
127.0.0.1	localhost
127.0.1.1 	$HOSTNAME

# Hosts im Lokalen Netzwerk
$HOSTS

#IPv6 Kram
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF
fi

echo "Führe ein apt-get update aus..."
	apt-get update &> /dev/null

# Deployment des "Vagrant Insecure Private Keys"
if [ ! -f $VAGRANT_KEY_PATH ]; then
  echo Lade den Vagrant private Key herunter...
	wget -q $VAGRANT_KEY_URL -O $VAGRANT_KEY_PATH && chmod 400 $VAGRANT_KEY_PATH && chown vagrant:vagrant $VAGRANT_KEY_PATH
else
	echo "HINWEIS: ein id_rsa file exestiert schon das deployment wird übersprungen!"
fi

# Instalieren Zusätzlicher Pakete
if [ -f $PROVISIONDIR/$HOSTNAME\_packages.txt ]; then
	PKGLIST=$(cat $PROVISIONDIR/$HOSTNAME\_packages.txt |tr -d '\r' | tr '\n' ' ')
	# Sicherstellen das APT keine Prompts öffnet
	export DEBIAN_FRONTEND="noninteractive" 
	if [ "$PKGLIST" != "" ]; then
    echo Installiere die folgenen Pakete: $PKGLIST ...
		apt-get install -qqq -yf $PKGLIST &> /dev/null
	fi
else
	echo "Es sind keine Installationen für $HOSTNAME erforderlich ($HOSTNAME\_packages.txt)"
fi

# Installation der Management Tools auf den Admin Boxen
for H in $(cat $PROVISIONDIR/adminboxes.txt)
do 
  if [ "$HOSTNAME" == $H ]; then
    echo INFO: bei $HOSTNAME handelt es sich um eine Adminbox!
    source $PROVISIONDIR/adminbox-setup.sh
  fi
done
