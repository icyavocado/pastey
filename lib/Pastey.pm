package pastey;
use lib qw(~/perl5/lib/perl5/ ~/perl5/ ~/perl5/perlbrew/perls/perl-5.26.1 ~/perl5/perlbrew/perls/perl-5.26.1/lib/5.26.1 ~/perl5/perlbew/perls/perl-5.24.1 ~/perl5/perlbew/perls/perl-5.24.1/perl/5.24.1);
use Dancer2;
use Pastey::Schema;
use Data::UUID;
use Digest::SHA qw(sha1);
use Dancer2::Serializer::JSON;
our $VERSION = '0.1';

hook before => sub {
  if ( !session('schema') ) {
    my $schema
      = Pastey::Schema->connect("dbi:SQLite:dbname=../dbfile/pastey_bin.sqlite");
    session( 'PasteyBin', $schema->resultset('PasteyBin') );
  }
};

get '/' => sub {
  template 'index' => { title => '🐈 Pastey' };
};

post '/' => sub {
  my $value = body_parameters->get('value');
  if ($value) {
    my $ug  = Data::UUID->new;
    my $sha = Digest::SHA->new();
    $sha->add( $ug->create() );
    my $name = lc( $sha->b64digest );
    $name =~ tr/0-9a-zA-Z//cd;
    $name = substr( $name, 0, 10 );
    my $result
      = session('PasteyBin')->new( { name => $name, value => $value } );
    $result->insert();
    return to_json(
      { message => 'Success',
        name    => $result->name
      }
    );
  }
  else {
    status 404;
    return to_json( { message => 'Nothing to save' } );
  }
};

get '/:nameandformat' => sub {
  pass if route_parameters->get('nameandformat') =~ /A-Za-z0-9.$/;
  my @nameandformat = split( /\./, route_parameters->get('nameandformat') );
  my $name       = $nameandformat[0];
  my $format        = $nameandformat[1];
  my $result     = session('PasteyBin')->find( { name => $name } );
  if ($result) {
    template 'index' => {
      title   => '🐈 Pastey',
      name      => $result->name,
      value     => $result->value,
      format => $format
    };
  }
  else {
    redirect '/';
  }

};

get 'raw/:nameandformat' => sub {
  pass if route_parameters->get('nameandformat') =~ /A-Za-z0-9.$/;
  my @nameandformat = split( /\./, route_parameters->get('nameandformat') );
  my $name       = $nameandformat[0];
  my $format        = $nameandformat[1];
  my $result     = session('PasteyBin')->find( { name => $name } );
  if ($result) {
    template 'raw' => {
      title     => '🐈 Pastey',
      name      => $result->name,
      value     => $result->value,
      format => $format
    };
  }
  else {
    template 'raw' => {
      title => '🐈 Pastey',
      value => 'Failed to find anything',
    };
  }
};

get 'ajax/:nameandformat' => sub {
  pass if route_parameters->get('nameandformat') =~ /A-Za-z0-9.$/;
  my @nameandformat = split( /\./, route_parameters->get('nameandformat') );
  my $name       = $nameandformat[0];
  my $result     = session('PasteyBin')->find( { name => $name } );
  if ($result) {
    return to_json(
      { service => '🐈 Pastey',
        name    => $result->name,
        value   => $result->value
      }
    );
  }
  else {
    return to_json( { value => 'Failed to find anything' } );
  }

};

post '/:nameandformat' => sub {
  pass if route_parameters->get('nameandformat') =~ /A-Za-z0-9.$/;
  my @nameandformat = split( /\./, route_parameters->get('nameandformat') );
  my $name       = $nameandformat[0];
  my $value      = body_parameters->get('value');
  if ($value) {
    my $result = session('PasteyBin')->find( { name => $name } );
    if ( $result->{value} ) {
      status 404;
      return to_json( { data => 'Failed to Save' } );
    }
    else {
      $result->update( { value => $value } );
    }
  }
  status 200;
  return to_json( { data => 'Success' } );
};

true;
