=head1 NAME

Octopussy::Plugin::Network - Octopussy Plugin Network

=cut

package Octopussy::Plugin::Network;

use strict;
use warnings;

use AAT::List;
use AAT::Utils qw( ARRAY );

my %services = ();

=head1 FUNCTIONS

=head2 Init()

=cut

sub Init
{
  my $conf_port = AAT::List::Configuration('AAT_Port');

  foreach my $i (ARRAY($conf_port->{item}))
  {
    $services{$i->{value}} = $i->{label};
  }

  return (1);
}

=head2 Mask_8($addr)

Only shows the first 8 bits of an IP address (--> 10.XXX.XXX.XXX)

=cut

sub Mask_8
{
  my $addr = shift;

  $addr =~ s/(\d+)\.\d+\.\d+\.\d+/$1.XXX.XXX.XXX/;

  return ($addr);
}

=head2 Mask_16($addr)

Only shows the first 16 bits of an IP address (--> 10.1.XXX.XXX)

=cut

sub Mask_16
{
  my $addr = shift;

  $addr =~ s/(\d+\.\d+)\.\d+\.\d+/$1.XXX.XXX/;

  return ($addr);
}

=head2 Mask_24($addr)

Only shows the first 24 bits of an IP address (--> 10.1.2.XXX)

=cut

sub Mask_24
{
  my $addr = shift;

  $addr =~ s/(\d+\.\d+\.\d+)\.\d+/$1.XXX/;

  return ($addr);
}

=head2 Ripe_Info($addr)

Returns link to get information from Ripe

=cut

sub Ripe_Info
{
  my $addr = shift;

  my $url =
      '<a href="http://ripe.net/fcgi-bin/whois?form_type=simple&'
    . 'full_query_string=&searchtext=+'
    . $addr
    . '&do_search=Search">'
    . $addr . '</a>';

  return ($url);
}

=head2 Service($port)

=cut

sub Service
{
  my $port = shift;

  return ($services{$port} || $port);
}

1;

=head1 AUTHOR

Sebastien Thebert <octopussy@onetool.pm>

=cut
