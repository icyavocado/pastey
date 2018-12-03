use utf8;
package Pastey::Schema::Result::PasteyBin;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Pastey::Schema::Result::PasteyBin

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<pastey_bin>

=cut

__PACKAGE__->table("pastey_bin");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 value

  data_type: 'text'
  is_nullable: 1

=head2 expiration

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "value",
  { data_type => "text", is_nullable => 1 },
  "expiration",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name_unique>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name_unique", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2018-12-02 21:41:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mv7xU2kzdG64+8Y5mW/0Ug


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
