#!/usr/bin/perl

package PayPal;

use URI::Escape;
use Data::Dumper;

sub pp_link {
  my $i = @_[0];
  my $retval = 'https://www.paypal.com/cgi-bin/webscr?cmd=_xclick';
  $retval .= '&business='.uri_escape($i->{from}->{paypal});
  $retval .= '&amount='.uri_escape($i->{price_total});
  $retval .= '&currency_code='.uri_escape($i->{currency});
  $retval .= '&item_name='.uri_escape($i->{id});
  return $retval;
}

sub pp_qr {
  my ($id, $text) = @_;
  my $qrcode = Imager::QRCode->new(
    size          => 3,
    margin        => 3,
    version       => 0,
    level         => 'L',
    casesensitive => 1,
    lightcolor    => Imager::Color->new(255, 255, 255),
    darkcolor     => Imager::Color->new(0, 0, 0),
  ); 
  my $img = $qrcode->plot($text);
  $img->write(file => "tmp/${id}_qr.jpeg") or die "Problem writing QR image file".$img->errstr;
}

1;
