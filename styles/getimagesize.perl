#======================================================================
# The following patches get_image_size to 
#  1) use imagefile's extension (not $IMAGE_TYPE) to determine type
#  2) and adds support for jpeg.
#  3) to return the width & height as the 3rd & 4th values
sub get_image_size { # clean
    my ($imagefile, $scale) = @_;
    $scale = '' if ($scale == 1);
    my ($imgID,$size) = ('','');
    my ($img_w,$img_h);
    $imagefile =~ /\.(\w*)$/;
    my $type = lc($1);
    $type = $IMAGE_TYPE unless $type =~ /(gif|png|jpe?g)/;
    if (open(IMAGE, "<$imagefile")) {
        my ($buffer,$magic,$dummy,$width,$height) = ('','','',0,0);
	binmode(IMAGE); # not harmful un UNIX
#       if ($IMAGE_TYPE =~ /gif/) {
	if ($type =~ /gif/){
	  read(IMAGE,$buffer,10);
	    ($magic,$width,$height) = unpack('a6vv',$buffer);
                        # is this image sane?
	    unless($magic =~ /^GIF8[79]a$/ && ($width * $height) > 0) {
                $width = $height = 0;
	    }
        }
#        elsif ($IMAGE_TYPE =~ /png/) {
        elsif ($type =~ /png/) {
            read(IMAGE,$buffer,24);
	    ($magic,$dummy,$width,$height) = unpack('a4a12NN',$buffer);
	    unless($magic eq "\x89PNG" && ($width * $height) > 0) {
                $width = $height = 0;
            }
	}
	elsif ($type =~ /jpe?g/){
	  ($width,$height)=jpegsize(*IMAGE);
	}
	else {
	  warn "\nUnknown image type for $imagefile"; }
	close(IMAGE);

	# adjust for non-trivial $scale factor.
	($img_w,$img_h) = ($width,$height);
	if ($scale && ($width * $height) > 0) {
            $img_w = int($width / $scale + .5);
            $img_h = int($height / $scale + .5);
	}
	$size = qq{WIDTH="$img_w" HEIGHT="$img_h"};

	# allow height/width to be stored in the stylesheet
	my ($img_name,$imgID);
	if ($SCALABLE_IMAGES && $USING_STYLES) {
	    if ($imagefile =~ /(^|[$dd$dd])([^$dd$dd]+)\.(\Q$IMAGE_TYPE\E|old)$/o) {
		$img_name = $2;
		$imgID = $img_name . ($img_name =~ /img/ ? '' : $IMAGE_TYPE);
	    }
	    if ($imgID) {
		$width = $width/$LATEX_FONT_SIZE/$MATH_SCALE_FACTOR;
		$height = 1.8 * $height/$LATEX_FONT_SIZE/$MATH_SCALE_FACTOR;
		# How wide is an em in the most likely browser font ?
		if ($scale) {
		# How high is an ex in the most likely browser font ?
		    $width = $width/$scale; $height = $height/$scale;
		}
		$width = int(100*$width + .5)/100;
		$height = int(100*$height + .5)/100;
		$img_style{$imgID} = qq(width:${width}em ; height:${height}ex );
		#join('','width:',$width,'em ; height:',$height,'ex ');
		$imgID = qq{ CLASS="$imgID"};
	    }
	}
    }
    ($size, $imgID,$img_w,$img_h);
}

# This subr grabbed from wwwis (http://www.bloodyeck.com/wwwis/)
# jpegsize : gets the width and height (in pixels) of a jpeg file
# Andrew Tong, werdna@ugcs.caltech.edu           February 14, 1995
# modified slightly by alex@ed.ac.uk
sub jpegsize {
  my($JPEG) = @_;
  my($done)=0;
  my($c1,$c2,$ch,$s,$length, $dummy)=(0,0,0,0,0,0);
  my($a,$b,$c,$d);

  if(defined($JPEG)             &&
     read($JPEG, $c1, 1)        &&
     read($JPEG, $c2, 1)        &&
     ord($c1) == 0xFF           &&
     ord($c2) == 0xD8           ){
    while (ord($ch) != 0xDA && !$done) {
      # Find next marker (JPEG markers begin with 0xFF)
      # This can hang the program!!
      while (ord($ch) != 0xFF) { return(0,0) unless read($JPEG, $ch, 1); }
      # JPEG markers can be padded with unlimited 0xFF's
      while (ord($ch) == 0xFF) { return(0,0) unless read($JPEG, $ch, 1); }
      # Now, $ch contains the value of the marker.
      if ((ord($ch) >= 0xC0) && (ord($ch) <= 0xC3)) {
        return(0,0) unless read ($JPEG, $dummy, 3);
        return(0,0) unless read($JPEG, $s, 4);
        ($a,$b,$c,$d)=unpack("C"x4,$s);
        return ($c<<8|$d, $a<<8|$b );
      } else {
        # We **MUST** skip variables, since FF's within variable names are
        # NOT valid JPEG markers
        return(0,0) unless read ($JPEG, $s, 2);
        ($c1, $c2) = unpack("C"x2,$s);
        $length = $c1<<8|$c2;
        last if (!defined($length) || $length < 2);
        read($JPEG, $dummy, $length-2);
      }
    }
  }
  return (0,0);
}

#======================================================================
1;
