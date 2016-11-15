# ansible_lab

Unterlagen zu einer kleinen Einführung in Ansible.

Zur verwendung dieses Labs bitte die nachfolgenden Installations Anweisungen Beachten.


## Vorausetzungen
Auf deinem Rechner müssen die Folgenden dinge Bereits installiert sein:

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

### Windows:
Unter Windos solltest du ausserdem noch die Folgenden Programme und Tools Installieten

* [Cygwin](https://www.cygwin.com/)
  * Das Cygwin Paket für - rsync
  * Das Cygwin Paket für - openssh

Sollte es zu Problemen mit mit den Gast erweiterungen kommen kann ausserdem das folgende
Vagrant plugin installirt werden: `vagrant-vbguest`

```bash
~$ vagrant plugin install vagrant-vbguest
```
