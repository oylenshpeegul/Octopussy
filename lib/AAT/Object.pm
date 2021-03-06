
=head1 NAME

AAT::Object - AAT Object module

=cut

package AAT::Object;

use strict;
use warnings;

use AAT::Application;
use AAT::DB;
use AAT::XML;

=head1 FUNCTIONS

=head2 Configuration($object)

Returns Object configuration

=cut

sub Configuration
{
    my $object = shift;

    my $dir = AAT::Application::Directory('AAT', 'objects');
    my $conf = AAT::XML::Read("$dir${object}.xml");

    return ($conf);
}

=head2 Data($appli, $object)

Returns Object data

=cut

sub Data
{
    my ($appli, $object) = @_;
    my ($conf_list, $list) = (undef, undef);

    my $conf = Configuration($object);
    if ($conf->{backend} eq 'XML')
    {
        $conf_list = AAT::XML::Read($conf->{source});
        $object    = lc $object;
        $list      = $conf_list->{$object};
    }
    elsif ($conf->{backend} eq 'DB')
    {
        my @data = AAT::DB::Query($appli, "SELECT * FROM $conf->{source}");
        $list = \@data;
    }

    return ($list);
}

1;

=head1 AUTHOR

Sebastien Thebert <octopussy@onetool.pm>

=cut
