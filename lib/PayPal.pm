#!/usr/bin/perl

package PayPal;

use URI::Escape;

sub pp_link {
  my %i = @_; 
  foreach my $k (%i) {
	  $i{$k} = uri_escape($i{$k});
  }
  my @retval;
  $retval[0] = $i{id};
  $retval[1] = 'https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business='.$i{business}.'&amount='.$i{amount};
  $retval[1] .= '&currency_code='.$i{currency};
  $retval[1] .= '&item_name='.$i{ident};
  return @retval;
}

sub pp_qr {
  my ($id, $text) = pp_link(@_);
  my $qrcode = Imager::QRCode->new(
    size          => 10,
    margin        => 3,
    version       => 4,
    level         => 'H',
    casesensitive => 1,
    lightcolor    => Imager::Color->new(255, 255, 255),
    darkcolor     => Imager::Color->new(0, 0, 0),
  ); 
  my $img = $qrcode->plot($text);
  print Dumper $img;
  $img->write(file => "out/${id}_qr.png") or die "Problem writing QR image file".$img->errstr;
}

1;
