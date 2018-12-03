#!/usr/bin/env perl

use DBIx::Class::Schema::Loader qw/ make_schema_at /;
make_schema_at(
    'Pastey::Schema',
    { debug => 1,
      dump_directory => '../lib',
    },
    [ 'dbi:SQLite:dbname=pastey_bin.sqlite', '', ''],
);