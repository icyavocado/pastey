package Pastey;

use Dancer2;
use Pastey::Schema;
use Data::UUID;
use Digest::SHA qw(sha1);
use Dancer2::Serializer::JSON;
use Dancer2::Plugin::DBIC;
use Function::Parameters;
our $VERSION = '0.1';

set engines => { serializer => { JSON => { allow_nonref => 1 }, } };

hook before => sub {
  var rs                                => schema->resultset('PasteyBin');
  var app_name                          => config->{'app_name'};
  header 'Access-Control-Allow-Headers' => 'content-type';
  header 'Access-Control-Allow-Origin'  => '*';
  header 'Content-Type'                 => 'application/json';
};

get qr{^/(?<name>(api|ajax)/)?}x => sub {
  pass if captures->{name};
  send_file('index.html');
};

get qr{ ^/ajax/(?<name>\w+)?(\.(?<format>.\w+)?)? }x => sub {
  my $result = getData( captures->{name} );
  return {
    name  => $result->name,
    value => $result->value
  } if $result;
  status 404;
  return { message => "Couldn't find matching result" };
};

get qr{ ^/api/(?<type>(raw|ajax)/)?(?<name>\w+)?(\.(?<format>.\w+)?)?/? }x =>
  sub {
  my $name = captures->{name};
  pass if !$name;
  my $result = getData($name);
  if ($result) {
    my $app_name = var 'app_name';
    return {
      name  => $result->name,
      value => $result->value
    };
  }
  redirect '/';
  };

any [ 'post', 'options' ] => '/api/' => sub {
  my $value = body_parameters->get('value');
  if ($value) {
    my $result = addData($value);
    return {
      name  => $result->name,
      value => $result->value
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

dance;
