# ABOUT

This is an implementation of hastebin in Perl.


# INSTALL

#### Install Dancer 2

```bash
sudo apt-get install libdancer2-perl
```

#### Install SQLite3

```
sudo apt install sqlite3
```

#### Install CPANM modules
##### Install CPANM support tools
```bash
sudo apt install cpanminus
sudo apt install build-essential
sudo apt install unzip
perl -mCPAN -e'CPAN::Shell->look("DBIx::Class")'
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
```
##### Install CPAN modules
```bash
cpanm WWW::Form::UrlEncoded::XS
cpanm Data::UUID
cpanm DBIx::Class
cpanm DBIx::Class::Schema::Loader
cpanm Template::Plugin::JSON
cpanm Sanitize
```
# START UP
In the root folder of the app:
```bash
# pwd should be path/to/pastey/
plackup -p 5000 bin/app.psgi
```
