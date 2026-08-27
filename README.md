# Sopel

Sopel is a simple, lightweight, open source, easy-to-use IRC utility bot, written in Python. It's designed to be easy to use, run and extend.

sopel.chat

<img src="https://raw.githubusercontent.com/sopel-irc/sopel/master/docs/source/_static/sopel-black.png" width="30%" height="auto" alt="Sopel logo">

## How to use this Makejail

1. Configure Sopel if you haven't already.

   ```console
   $ mkdir -p etc log db
   $ SUFFIX=$(openssl rand -hex 6)
   $ appjail oci run -i \
       -o ephemeral \
       -o overwrite=force \
       -o virtualnet=":<random> default" \
       -o nat \
       -o fstab="$PWD/etc /usr/local/etc/sopel" \
       -o fstab="$PWD/log /var/log/sopel" \
       -o fstab="$PWD/db /var/db/sopel" \
       ghcr.io/appjail-makejails/sopel sopel-${SUFFIX} \
       sopel configure && \
     appjail stop sopel-${SUFFIX}
   ```

2. Profit!

   ```console
   $ appjail oci run -Pd \
       -o overwrite=force \
       -o virtualnet=":<random> default" \
       -o nat \
       -o fstab="$PWD/etc /usr/local/etc/sopel" \
       -o fstab="$PWD/log /var/log/sopel" \
       -o fstab="$PWD/db /var/db/sopel" \
       ghcr.io/appjail-makejails/sopel sopel
   ```

### Arguments (stage: build)

* `sopel_from` (default: `ghcr.io/appjail-makejails/sopel`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `sopel_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).

### Environment (OCI image)

* `PGID` (default: `1000`): Equivalent to `PUID` but for the Process Group ID.
* `PUID` (default: `1000`): Process User ID for the container's main process, allowing you to match the owner of files written to mounted host volumes to your host system's user. Writable volumes are changed based on this environment variable.
* `UMASK` (default: `0022`): Override default umask setting.

## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.1
      containerfile: Containerfile
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.1"
        PYVER: "312"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
```
