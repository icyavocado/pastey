package pastey;
use Dancer2;
use Pastey::Schema;
use Data::UUID;
use Digest::SHA qw(sha1);

our $VERSION = '0.1';

hook before => sub {
  if ( !session('schema') ) {
    my $schema
      = Pastey::Schema->connect("dbi:SQLite:dbname=dbfile/pastey_bin.sqlite");
    session( 'PasteyBin', $schema->resultset('PasteyBin') );
  }
};

get '/' => sub {
  my $ug  = Data::UUID->new;
  my $sha = Digest::SHA->new();
  $sha->add( $ug->create() );
  my $id = lc( $sha->b64digest );
  $id =~ tr/0-9a-zA-Z//cd;
  $id = substr( $id, 0, 10 );
  my $result = session('PasteyBin')->new( { name => $id } );
  $result->insert();
  redirect "/" . $result->name;
};

get '/:idandext' => sub {
  pass if route_parameters->get('idandext') =~ /A-Za-z0-9.$/;
  my @idandext = split( /\./, route_parameters->get('idandext') );
  use Data::Dumper;
  warn Dumper( route_parameters->get('idandext') );
  my $id     = $idandext[0];
  my $ext    = $idandext[1];
  my $result = session('PasteyBin')->find( { name => $id } );
  template 'index' => {
    'title'   => 'pastey',
    id        => $id,
    value     => $result->{value},
    extention => $ext
  };
};

true;
