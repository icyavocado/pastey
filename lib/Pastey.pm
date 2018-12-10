package pastey;
use lib "../local";
use Dancer2;
use Pastey::Schema;
use Data::UUID;
use Digest::SHA qw(sha1);
use Dancer2::Serializer::JSON;
our $VERSION = '0.1';
use Data::Dumper;

hook before => sub {
  my $schema = Pastey::Schema->connect(
    "dbi:SQLite:dbname=../database/pastey_bin.sqlite");
  var rs       => $schema->resultset('PasteyBin');
  var app_name => '🐈 Pastey';
};

get qr{ ^/(?<name>\w+)?(\.(?<format>.\w+)?)?/?(?<type>(raw|ajax))? }x => sub {
  my $name   = captures->{name};
  my $format = captures->{format};
  my $type   = captures->{type};
  if ( !$name ) {
    template 'index' => { title => var 'app_name', name => '2' };
  }
  else {
    my $pastey_bin = var 'rs';
    my $result = $pastey_bin->find( { name => $name } );
    if ($result) {
      if ($type) {
        if ( $type eq 'raw' ) {
          template 'raw' => { name => $result->name, value => $result->value };
        }
        elsif ( $type eq 'ajax' ) {
	  header 'Access-Control-Allow-Origin' => '*';
          header 'Content-Type' => 'application/json';
	  my $value = decode_json($result->value);
          return to_json { name => $result->name, value => $value };
        }
        else {
          status 404;
          template '404';
        }
      }
      else {
        my $app_name = var 'app_name';
        template 'index' => {
          title  => $app_name,
          name   => $result->name,
          value  => $result->value,
          format => $format
        };
      }
    }
    else {
      redirect '/';
    }
  }
};

post qr{ ^/(?<name>\w+)? }x => sub {
  my $name  = captures->{name};
  my $value = body_parameters->get('value');
  if ($name) {
    status 404;
    template '404';
  }
  else {
    if ($value) {
      my $ug  = Data::UUID->new;
      my $sha = Digest::SHA->new();
      $sha->add( $ug->create() );
      my $name = lc( $sha->b64digest );
      $name =~ tr/0-9a-zA-Z//cd;
      $name = substr( $name, 0, 10 );
      my $pastey_bin = var 'rs';
      my $result = $pastey_bin->new( { name => $name, value => $value } );
      $result->insert();
      return to_json(
        { message => 'Success',
          name    => $result->name
        }
      );
    }
    else {
      status 404;
      template '404';
    }
  }
};

true;
