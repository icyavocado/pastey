package Pastey;
use lib "../local";
use Dancer2;
use Pastey::Schema;
use Data::UUID;
use Digest::SHA qw(sha1);
use Dancer2::Serializer::JSON;
use Dancer2::Plugin::Ajax;
use Function::Parameters;
our $VERSION = '0.1';

hook before => sub {
  my $schema = Pastey::Schema->connect(
    "dbi:SQLite:dbname=/icyavocado/pastey/database/pastey_bin.sqlite");
  var rs       => $schema->resultset('PasteyBin');
  var app_name => '🐈 Pastey';
};

get qr{^/(?<name>(api|ajax)/)?}x => sub {
  pass if captures->{name};
  send_file('index.html');
};

get '/ajax/:name' => sub {
  header 'Access-Control-Allow-Origin' => '*';
  header 'Content-Type'                => 'application/json';
  my $result = getData( route_parameters->get('name') );
  return to_json { value => $result->value };
};

get qr{ ^/api/(?<type>(raw|ajax)/)?(?<name>\w+)?(\.(?<format>.\w+)?)?/? }x =>
  sub {
  my $name   = captures->{name};
  my $format = captures->{format};
  my $type   = captures->{type};
  pass if !$name;
  my $result = getData($name);
  if ($result) {
    header 'Content-Type' => 'application/json';
    my $app_name = var 'app_name';
    return to_json {
      name  => $result->name,
      value => $result->value
    };
  }
  redirect '/';
  };

post '/api/' => sub {
  my $value = body_parameters->get('value');
  if ($value) {
    my $result = addData($value);
    header 'Access-Control-Allow-Origin' => '*';
    header 'Content-Type'                => 'application/json';
    return to_json {
      name   => $result->name,
      value  => $result->value,
      format => guess( $result->value )
    };
  }
};

fun getData($name) {
  my $pastey_bin = var 'rs';
  my $result = $pastey_bin->find( { name => $name } );
  return $result;
};

fun addData($value) {
  my $ug  = Data::UUID->new;
  my $sha = Digest::SHA->new();
  $sha->add( $ug->create() );
  my $name = lc( $sha->b64digest );
  $name =~ tr/0-9a-zA-Z//cd;
  $name = substr( $name, 0, 10 );
  my $pastey_bin = var 'rs';
  my $result = $pastey_bin->new( { name => $name, value => $value } );
  $result->insert();
  return $result;
}

fun guess($text) {
  my @foo    = `echo '$text' | guesslang`;
  my @result = $foo[ scalar @foo - 1 ] =~ /in \s*(\w+)/g;
  return lc $result[0];
}

dance;
