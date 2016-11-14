# Notizen zu Ansible

## ansible.cfg

### Suchreinfolge:
1. ANSIBLE_CONFIG (Umgebungs Variable)
2. ./ansible.cfg
3. ~/.ansible.cfg (Benutzer Spezifische Konfiguration)
4. /etc/ansible/ansible.cfg (system weite globale config)


### Beispiel Config
```

[defaults]

inventory      = ~/ansible/inventory.ini
roles_path     = ~/ansible/roles
timeout        = 5
log_path       = ~/ansible/ansible.log
display_skipped_hosts = False


[privilege_escalation]
become=True
become_method=sudo

[paramiko_connection]


[ssh_connection]


[accelerate]

[selinux]

[colors]
highlight = white
verbose = bright blue
warn = bright purple
error = red
debug = dark gray
deprecate = purple
skip = cyan
unreachable = red
ok = green
changed = yellow
diff_add = green
diff_remove = red
diff_lines = cyan

```

## Inventory

Ein (statisches) Inventory ist nur ein Text file in dem eine Reihe von
Servern stehen, diese können `[Gruppen Name]` zu einzelen Gruppen
zusammen gefasst werden z.B. `[dbserver]` oder `[xmppserver]`

ein Inventory könnte dann z.B. so aussehen:
```
[AServer]
as001 ansible_port=10122 ansible_host=127.0.0.1 ansible_user=vagrant ansible_become=true apt_update=false
as002 ansible_port=10122 ansible_host=127.0.0.2 ansible_user=vagrant
as003 ansible_port=10122 ansible_host=127.0.0.3 ansible_user=vagrant
as004 ansible_port=10122 ansible_host=127.0.0.4 ansible_user=vagrant

[BServer]
bs001 ansible_host=10.10.10.11
bs002 ansible_host=10.10.10.12
bs003 ansible_host=10.10.10.13
```

## Playbooks

Grundlegende Struktur:

```
--- # diese Zeile muss am anfang stehen sie sagt das es sich im folgenden um ein .yml file handelt
- hosts: all    # Welche Hosts sind Betroffen
  vars:
    ssh_port: 22    # Variabeln die Später verwendet werden können
  remote_user: root # Benutzer der für die SSH Verbindungen von ansible verwendet wird
  tasks:  # Tasks führen Module in der  Reihenfolge der Tasks aus. - Sie nehemen die Eigentliche Konfiguration vor
  - name: Installieren von NGINX in der letzten version
    apt: name=nginx state=latest

  - name: sicherstellen das Nginx beim Booten gestartet wird
    service: name=nginx state=started enabled=yes

  - name: erstelle vhost
    template: src="nginx_vhost.conf" dst="/etc/sites-available/vhost.conf"
    
  handlers:
    - name: restart nginx
      service: name=nginx state=restarted
```

## Rollen

```
~/meineAnsibleRollen$ ansible-galaxy init <roleName>

```

### Struktur

```
├── README.md
├── defaults
│ └── main.yml
├── files
├── handlers
│ └── main.yml
├── meta
│ └── main.yml
├── tasks
│ └── main.yml
├── templates
└── vars
└── main.yml
```

### Verwendung von Rollen
```
---
- hosts: BServer
  roles:
     - common # Allgemeiner Kram
     - dbserver

```

## Beispiel Struktur eines kleinen Infrastruktur Projektes mit Ansible
```
├── inventory.ini
├── roles
│ └── ... die verschiedenen Rollen 
└── ansible.cfg
```