# sopel

Sopel is a simple, lightweight, open source, easy-to-use IRC utility bot, written in Python. It's designed to be easy to use, run and extend.

sopel.chat

<img src="https://raw.githubusercontent.com/sopel-irc/sopel/master/docs/source/_static/sopel-black.png" alt="sopel logo" width="%60" height="auto">

## How to use this Makejail

### Basic usage

```sh
appjail makejail \
    -j sopel \
    -f gh+AppJail-makejails/sopel \
    -o virtualnet=":<random> default" \
    -o nat
```

### Deploy using appjail-director

**appjail-director.yml**:

```yaml
options:
  - virtualnet: ':<random> default'
  - nat:

services:
  irc-bot:
    name: sopel
    makejail: gh+AppJail-makejails/sopel
    arguments:
      - sopel_interactive: 0
      - sopel_tag: 14.2
    volumes:
      - etc: sopel-etc
      - log: sopel-log
      - db: sopel-db

default_volume_type: '<volumefs>'

volumes:
  etc:
    device: .volumes/etc
  log:
    device: .volumes/log
  db:
    device: volumes/db
```

**.env**:

```
DIRECTOR_PROJECT=irc-bot
```

**.volumes/etc/**:

```console
# tree -pug .volumes/etc/
[drwx------ 757      757     ]  .volumes/etc/
├── [-rw-r--r-- 757      757     ]  sopel-default.cfg
└── [-rw-r----- 757      757     ]  sopel-default.cfg.sample

1 directory, 2 file
```

### Arguments

* `sopel_tag` (default: `13.4`): see [#tags](#tags).
* `sopel_interactive` (default: `1`): If different from `0`, the Makejail will create many profiles as indicated by the `sopel_profiles` argument. Also, you must configure each profile interactively.
* `sopel_profiles` (default: `default`): Profiles to create.
* `sopel_plugins` (optional): Directory where the plugins will be copied.

### Volumes

| Name      | Owner | Group | Perm | Type | Mountpoint           |
| --------- | ----- | ----- | ---- | ---- | -------------------- |
| sopel-etc | 757   | 757   |  700 |  -   | /usr/local/etc/sopel |
| sopel-log | 757   | 757   |  700 |  -   | /var/log/sopel       |
| sopel-db  | 757   | 757   |  700 |  -   | /var/db/sopel        |

## Tags

| Tag    | Arch    | Version        | Type   |
| ------ | ------- | -------------- | ------ |
| `13.4` | `amd64` | `13.4-RELEASE` | `thin` |
| `14.2` | `amd64` | `14.2-RELEASE` | `thin` |
