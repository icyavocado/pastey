#!/usr/bin/env perl

use strict;
use warnings;
use JSON;

my $dancer_config;

BEGIN {
  my $contents = do { local ( @ARGV, $/ ) = 'config.json'; <> };
  $dancer_config = decode_json $contents;
}
use lib "$dancer_config->{path}/lib";
use lib "$dancer_config->{path}/local/lib/perl5";

use DBIx::Class::Schema::Loader qw/ make_schema_at /;
use DBIx::Class;
use Pastey::Schema;
use Function::Parameters;
use Data::Dumper;

my $path     = $dancer_config->{path};
my $sql_path = "$path/bin/scripts/schema.sql";

my $path_to_dbfile = "$path/database/pastey_bin.sqlite";
createFile($path_to_dbfile);

my $schema
  = Pastey::Schema->connect( "dbi:SQLite:uri=file:$path_to_dbfile", "", "" );

my $result = qx\sqlite3 $path_to_dbfile < $sql_path\;

make_schema_at(
  'Pastey::Schema',
  { debug          => 1,
    dump_directory => '../lib'
  },
  [ "dbi:SQLite:uri=file:$path_to_dbfile", '', '' ],
);

fun createFile($file) {
  if ( !-e $file ) {
    open my $fc, ">", $file;
    close $fc;
  }
}

fun init() {
  open( my $sqlfile, "<", $sql_path );
  my $string = join '', <$sqlfile>;
  return $string;
}
