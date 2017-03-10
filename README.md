# Mail-all-in-one

A mail solution takes lots of inspiration from nextcloud snap and iRedMail open source project. It puts all open source components that make up a whole mail solution into one snap.

* LAMP       an open source web development platform
* postfix    a widely-used sendmail program
* dovecot    a secure IMAP and POP3 server
* roundcube  a free and open source webmail
* iRedAdmin  a web admin panel for mail server

## Snap

If you would like to build mail-all-in-one as a snap package, please make sure
you have snapd(> 2.21) and snapcraft(2.26) packages installed firstly.

```
sudo apt-get install snapd snapcraft
sudo snap install core
```

Then run the following command to create a snap package.

```
snapcraft
```

After it's done, you can run the following command to install it locally.

```
sudo snap install --dangerous mail-all-in-one_[VER]_[ARCH].snap
```

Also you can install mail-all-in-one from the store by simply running the following
command.

```
sudo snap install --edge --devmode mail-all-in-one
```

## How to use

After installation, Open your browser, you can access with the services in your browser by navigating the following addresses.

* Roundcube  `http://<device address>`:8089
* iRedAdmin  `http://<device address>`:8090

To view all default configuration settings and how to change default admin account, please run the following command.
```
sudo mail-all-in-one.help
```

Only amd64 target is supported at this moment.

## Todo list

* SSL connection support
* Amavisd-new integration 
* Sieve support for dovecot
* Roundcube configure panel
