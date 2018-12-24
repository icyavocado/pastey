# Setup

## Front-end VueJS

Our project has the standard setup of Vue Cli 3. You can find out more here [https://cli.vuejs.org/ | Vue Cli 3](https://cli.vuejs.org/)

```bash
# Install npm packages
# -- To install all updated packages
npm install
# -- To install from package-lock.json
npm ci

# Build process
npm run build

# Development process
npm run serve
```

vue.config.js

```bash
cp vue.config.js.dist vue.config.js
```

config.json

```bash
cp config.json.dist config.json
```

```js
// UPDATE this file to match your own setup
"path": "/icyavocado/pastey",
"base_url": "https://pastey.ovacoda.com",
"plugins": {
"DBIC": {
  "default": {
    "dsn": "dbi:SQLite:dbname=/icyavocado/pastey/database/pastey_bin.sqlite",
    "schema_class": "Pastey::Schema"
  }
}
```

## Back-end Perl Dancer 2

Setup Perl / Carton and install dependencies for our backend, this will take a bit longer

```bash
# Install a local version of Perl, admin-free perl installation
sudo apt install perlbrew
perlbrew init
# Add the path to bashrc
source ~/perl5/perlbrew/etc/bashrc
# Install perl version 5.26.1
perlbrew install -n -j 5 perl-5.26.1
# Add carton to perlbrew
perlbrew lib create carton
perlbrew switch perl-5.26.1@carton
# Install carton, package manager
sudo apt install carton
# Fetch dependencies
carton install --deployment
```

Create database with definition from `pastey/bin/scripts/schema.sql`

```bash
bin/loaddb
```

Start up the webapp using a restart script, this will create a `pastey.pid` contains the pid of the Starman.

```bash
# Example bin/restart --port 5000
bin/restart [--port] [--workers]
```

Stop the app

```bash
kill [pid number from pastey.pid]
```

#### Resources

- Perlbrew: perlbrew is an admin-free perl installation management tool - [https://perlbrew.pl/ | Perlbrew ](https://perlbrew.pl/)
- Carton: Package manager for Perl project - [https://metacpan.org/pod/Carton | Carton](https://metacpan.org/pod/Carton)
