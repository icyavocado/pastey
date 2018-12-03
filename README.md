#### Install Dancer 2

```bash
sudo apt-get install libdancer2-perl
```

#### Install SQLite3

```
sudo apt install sqlite3
```

#### Install CPANM modules
### Install CPANM support tools
```bash
sudo apt install cpanminus
sudo apt install build-essential
sudo apt install unzip
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
```
### Install CPAN modules
```bash
cpanm WWW::Form::UrlEncoded::XS
cpanm Data::UUID
cpanm DBIx::Class
cpanm Sanitize
```
