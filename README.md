#### Install Dancer 2

```bash
sudo apt-get install libdancer2-perl
```

#### Install SQLite3

```
sudo apt install sqlite3
```

#### Install CPANM modules

```bash
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
cpanm WWW::Form::UrlEncoded::XS
cpanm DBD::SQLite
cpanm Data::UUID
```
