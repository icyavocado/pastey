use Test::More;

use strict;
use warnings;

use Test::DBIx::Class {
  schema_class  => 'Pastey::Schema',
  connect_info  => ["dbi:SQLite:dbname=database/pasteybin.sqlite"],
  connect_opts  => { name_sep => '.', quote_char => '`', },
  fixture_class => '::Populate',
};

## Your testing code below ##

## Your testing code above ##

done_testing;
