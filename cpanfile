requires 'perl', '5.26.1';

requires "Dancer2" => "0.205002";

recommends "YAML"             => "0";
recommends "URL::Encode::XS"  => "0";
recommends "CGI::Deurl::XS"   => "0";
recommends "HTTP::Parser::XS" => "0";

on "test" => sub {
    requires "Test::More"            => "0";
    requires "HTTP::Request::Common" => "0";
};

requires "Function::Parameters", "2.001003";
requires "Path::Tiny", "0.108";
requires "WWW::Form::UrlEncoded::XS", "0.25";
requires "Data::UUID", "1.221";
requires "DBIx::Class", "0.082841";
requires "Template::Plugin::JSON", "0.07";
requires "DBIx::Class::Storage::DBI";
requires "DBIx::Class::Schema::Loader";
requires "Plack::Handler::Starman";
requires "File::Tail";
requires "Plack::Middleware::Deflater";
requires "Dancer2::Plugin::Ajax";
requires "Dancer2::Plugin::DBIC";