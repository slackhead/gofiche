gofiche [![fork of fiche](https://github.com/solusipse/fiche)](https://github.com/solusipse/fiche)
=====

Command line pastebin for sharing terminal output that also serves
back a gopher URL if -g is set.

# Client-side usage

Self-explanatory live examples (using public server):

```
echo just testing! | nc rot.uk 9999
```

```
cat file.txt | nc r0t.uk 9999
```

In case you installed and started gofiche on localhost:

```
ls -la | nc localhost 9999
```

You will get an url to your paste as a response, e.g.:

```
http://r0t.uk/ydxh
```

-------------------------------------------------------------------------------

## Useful aliases

You can make your life easier by adding a termbin alias to your rc file. We list some of them here:

-------------------------------------------------------------------------------

### Pure-bash alternative to netcat

__Linux/macOS:__
```
alias tb="(exec 3<>/dev/tcp/r0t.uk/9999; cat >&3; cat <&3; exec 3<&-)"
```

```
echo less typing now! | tb
```

-------------------------------------------------------------------------------

### `tb` alias

__Linux (Bash):__
```
echo 'alias tb="nc r0t.uk 9999"' >> .bashrc
```

```
echo less typing now! | tb
```

__macOS:__

```
echo 'alias tb="nc r0t.uk 9999"' >> .bash_profile
```

```
echo less typing now! | tb
```

-------------------------------------------------------------------------------

### Copy output to clipboard

__Linux (Bash):__
```
echo 'alias tbc="netcat r0t.uk 9999 | xclip -selection c"' >> .bashrc
```

```
echo less typing now! | tbc
```

__macOS:__

```
echo 'alias tbc="nc r0t.uk 9999 | pbcopy"' >> .bash_profile
```

```
echo less typing now! | tbc
```

__Remember__ to restart your terminal session after adding any of provided above!

-------------------------------------------------------------------------------

## Requirements
To use gofiche (as a client) you have to have netcat installed. You probably already have it - try typing `nc` or `netcat` into your terminal!

-------------------------------------------------------------------------------

# Server-side usage

## Installation

1. Clone:

    ```
    git clone https://github.com/slackhead/gofiche.git
    ```

2. Build:

    ```
    make
    ```
    
3. Install:

    ```
    sudo make install
    ```

-------------------------------------------------------------------------------

## Usage

```
usage: gofiche [-D6epsdSolBug].
             [-d domain] [-p port] [-s slug size]
             [-o output directory] [-B buffer size] [-u user name]
             [-l log file] [-S]
						 [-g gopher domain]
```

These are command line arguments. You don't have to provide any of them to run the application. Default settings will be used in such case. See section below for more info.

### Settings

-------------------------------------------------------------------------------

#### Output directory `-o`

Relative or absolute path to the directory where you want to store user-posted pastes.

```
gofiche -o ./code
```

```
gofiche -o /home/www/code/
```

__Default value:__ `./code`

-------------------------------------------------------------------------------

#### Domain `-d`

This will be used as a prefix for an output received by the client.
Value will be prepended with `http`.

```
gofiche -d domain.com
```

```
gofiche -d subdomain.domain.com
```

```
gofiche -d subdomain.domain.com/some_directory
```

__Default value:__ `localhost`

-------------------------------------------------------------------------------

#### Gopher Domain `-g`

This will be used as a prefix for an output received by the client.
Value will be prepended with `http`.

```
gofiche -g domain.com
```

```
gofiche -g subdomain.domain.com
```

```
gofiche -g subdomain.domain.com/some_directory
```

__Default value:__ `NULL`

-------------------------------------------------------------------------------

#### Slug size `-s`

This will force slugs to be of required length:

```
gofiche -s 6
```

__Output url with default value__: `http://localhost/xxxx`,
where x is a randomized character

__Output url with example value 6__: `http://localhost/xxxx`,
where is a randomized character

__Default value:__ 4

-------------------------------------------------------------------------------

#### HTTPS `-S`

If set, gofiche returns url with https prefix instead of http

```
gofiche -S
```

__Output url with this parameter__: `https://localhost/xxxx`,
where x is a randomized character

-------------------------------------------------------------------------------

#### User name `-u`

gofiche will try to switch to the requested user on startup if any is provided.

```
gofiche -u _gofiche
```

__Default value:__ not set

__WARNING:__ This requires that gofiche is started as a root.

-------------------------------------------------------------------------------

#### Buffer size `-B`

This parameter defines size of the buffer used for getting data from the user.
Maximum size (in bytes) of all input files is defined by this value.

```
gofiche -B 2048
```

__Default value:__ 32768

-------------------------------------------------------------------------------

#### Log file `-l`

```
gofiche -l /home/www/gofiche-log.txt
```

__Default value:__ not set

__WARNING:__ this file has to be user-writable

-------------------------------------------------------------------------------

### Running as a service

There's a simple systemd example:
```
[Unit]
Description=GOFICHE-SERVER

[Service]
ExecStart=/usr/local/bin/gofiche -d yourdomain.com -o /path/to/output -l /path/to/log -u youruser

[Install]
WantedBy=multi-user.target
```

__WARNING:__ In service mode you have to set output directory with `-o` parameter.

-------------------------------------------------------------------------------

### Example nginx config

gofiche has no http server built-in, thus you need to setup one if you want to make files available through http.

There's a sample configuration for nginx:

```
server {
    listen 80;
    server_name mysite.com www.mysite.com;
    charset utf-8;

    location / {
            root /home/www/code/;
            index index.txt index.html;
    }
}
```

## License

gofiche is MIT licensed.
