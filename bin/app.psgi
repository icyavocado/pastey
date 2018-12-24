#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use lib "$FindBin::Bin/../local/lib/perl5";

=begin comment
# use this block if you don't need middleware, and only have a single target Dancer app to run here
use Pastey;

Pastey->to_app;

# use this block if you want to include middleware such as Plack::Middleware::Deflater
=end comment
=cut

use Pastey;
use Plack::Builder;

builder {
  enable 'Deflater';
  Pastey->to_app;
}

=cut

=begin comment
# use this block if you want to mount several applications on different path

use Pastey;
use pastey_admin;

use Plack::Builder;

builder {
    mount '/'      => Pastey->to_app;
    mount '/admin'      => pastey_admin->to_app;
}

=end comment

=cut

