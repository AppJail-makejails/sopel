# sopel

Sopel is a simple, lightweight, open source, easy-to-use IRC utility bot, written in Python. It's designed to be easy to use, run and extend.

sopel.chat

<img src="https://raw.githubusercontent.com/sopel-irc/sopel/master/docs/source/_static/sopel-black.png" alt="sopel logo" width="%60" height="auto">

## How to use this Makejail

### Basic usage

```
INCLUDE options/network.makejail
INCLUDE gh+AppJail-makejails/sopel
```

Where `options/network.makejail` are the options that suit your environment, for example:

```
ARG network
ARG interface=sopel

OPTION virtualnet=${network}:${interface} default
OPTION nat
```

Open a shell and run `appjail makejail`:

```sh
appjail makejail -j sopel
```

This Makejail uses the built-in rc script features to configure sopel interactively. After installing sopel and its dependencies, the Makejail will prompt you for some settings.

### Plugins

This framework allows you to create cool plugins to exploit IRC capabilities. The Makejail for sopel provides a simple way to install your plugins, though, nor their dependencies so you need to carefully install them in your Makejail when needed.

```
appjail makejail -j sopel \
    --network testing \
    --sopel_plugins /tmp/plugins
```

### Profiles

The rc script can run many instances of sopel, but first you need to create profiles: just configuration files for each instance of sopel. The rule is to use `sopel-<profile>.cfg` where `<profile>` is the name of the profile. That file must be in `/usr/local/etc/sopel` and you must set the name in `/etc/rc.conf` with `sopel_profiles` before starting sopel. Of course, you need to configure each instance. However, this Makejail simplifies a lot and you only need to provide one parameter and configure the profiles interactively. The Makejail will start each instance of sopel after configuring them.

```
appjail makejail -j sopel \
    --network testing \
    --sopel_profiles "profile1 profile2"
```

### Arguments

* `sopel_interactive` (default: `1`): If different from `0`, the Makejail will create many profiles as indicated by the `sopel_profiles` argument. Also, you must configure each profile interactively.
* `sopel_profiles` (default: `default`): Profiles to create.
* `sopel_plugins` (optional): Directory where the plugins will be copied.
