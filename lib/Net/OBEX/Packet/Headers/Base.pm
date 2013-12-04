
package Net::OBEX::Packet::Headers::Base;

use strict;
use warnings;
use Carp;

our $VERSION = '0.005';

sub new {
    my ( $class, $hi, $value ) = @_;

    croak "Missing header name or HI identifier"
        unless defined $hi;

    $value = ''
        unless defined $value;

    return bless {
        value  => $value,
        hi     => $hi,
    }, $class;
}

sub make {
    my $self = shift;

    my $value = $self->value;
    unless ( length $value ) {
        return $self->hi;
    }

    my $header = $self->hi . $value;
    return $self->header($header);
}

sub header {
    my $self = shift;
    if ( @_ ) {
        $self->{ header } = shift;
    }
    return $self->{ header };
}

sub value {
    my $self = shift;
    if ( @_ ) {
        $self->{ value } = shift;
    }
    return $self->{ value };
}

sub hi {
    my $self = shift;
    if ( @_ ) {
        $self->{ hi } = shift;
    }
    return $self->{ hi };
}

1;

__END__

=encoding utf8

=head1 NAME

Net::OBEX::Packet::Headers::Byte4 - construct
"4-byte sequence" OBEX headers.

=head1 SYNOPSIS

    package Net::OBEX::Packet::Headers;

    use strict;
    use warnings;

    use base 'Net::OBEX::Packet::Headers::Base';

    our $VERSION = '0.001';

    sub make {
        my $self = shift;

        my $value = $self->value;
        unless ( length $value ) {
            return $self->hi . "\x00\x03";
        }

        $value = pack 'n*', unpack 'U*', encode_utf8($value);

        my $header = $self->hi; # header code
        $header .= pack 'n', 4 + length $value;
        $header .= $value . "\x00";
        return $self->header($header);
    }

    1;

    __END__

=head1 DESCRIPTION

B<WARNING!!! This module is still in alpha stage. Use it for test purposes
only as interface might change in the future>.

The module is a base class for OBEX packet headers.

It defines C<new()>, C<make()>, C<header()>, C<value()> and C<hi()> methods.
The default C<make()> method is:

    sub make {
        my $self = shift;

        my $value = $self->value;
        unless ( length $value ) {
            return $self->hi;
        }

        my $header = $self->hi . $value;
        return $self->header($header);
    }

Refer to the documentation of either:
L<Net::OBEX::Packet::Headers::Byte1>,
L<Net::OBEX::Packet::Headers::Byte4>,
L<Net::OBEX::Packet::Headers::ByteSeq>
or L<Net::OBEX::Packet::Headers::Unicode> for the documentation of the
methods.

=head1 AUTHOR

Zoffix Znet, C<< <zoffix at cpan.org> >>
(L<http://zoffix.com>, L<http://haslayout.net>)

=head1 BUGS

Please report any bugs or feature requests to C<bug-net-obex-packet-headers at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-OBEX-Packet-Headers>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::OBEX::Packet::Headers::Base

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-OBEX-Packet-Headers>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net-OBEX-Packet-Headers>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Net-OBEX-Packet-Headers>

=item * Search CPAN

L<http://search.cpan.org/dist/Net-OBEX-Packet-Headers>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 Zoffix Znet, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
