package main;

do_require_package('color');

sub get_named_complement_color {
    &get_html_complement_color(&get_named_color(@_));
}

sub get_rgb_complement_color {
    # take complement from rgb is the same as taking the corresponding cmy color
    # as cyan is complement to red, magenta is complement to green and yellow is
    # complement to blue.
    &get_cmy_color(@_);
}

sub get_RGB_complement_color {
    # take complement from RGB is the same as taking the corresponding CMY color
    # as cyan is complement to red, magenta is complement to green and yellow is
    # complement to blue.
    &get_CMY_color(@_);
}

sub get_cmy_complement_color {
    # take complement from cmy is the same as taking the corresponding rgb color
    # as cyan is complement to red, magenta is complement to green and yellow is
    # complement to blue.
    &get_rgb_color(@_);
}

sub get_CMY_complement_color {
    # take complement from CMY is the same as taking the corresponding RGB color
    # as cyan is complement to red, magenta is complement to green and yellow is
    # complement to blue.
    &get_RGB_color(@_);
}

sub get_cmyk_complement_color {
    local($c,$m,$y,$k) = @_;
    if (!("$m$y$k")) {($c,$m,$y,$k) = split(',',$c)};
    # first, convert to cmy model:
    # ($c=min(1,$c+$k), $m=min(1,$m+$k), $y=min(1,$y+$k))
    ($c,$m,$y) = ($c+$k,$m+$k,$y+$k);
    $c = 1 unless ($c < 1);
    $m = 1 unless ($m < 1);
    $y = 1 unless ($y < 1);
    &get_cmy_complement_color($c,$m,$y);
}

sub get_CMYK_complement_color {
    local($c,$m,$y,$k) = @_;
    if (!("$m$y$k")) {($c,$m,$y,$k) = split(',',$c)};
    # first, convert to CMY model:
    # ($c=min(255,$c+$k), $m=min(255,$m+$k), $y=min(255,$y+$k))
    ($c,$m,$y) = ($c+$k,$m+$k,$y+$k);
    $c = 255 unless ($c < 255);
    $m = 255 unless ($m < 255);
    $y = 255 unless ($y < 255);
    &get_CMY_complement_color($c,$m,$y);
}

sub get_hsb_complement_color {
    local($h,$s,$v) = @_;
    if (!("$s$v")) {($h,$s,$v) = split(',',$h)};
    # algorithm (and its proof) from the xcolor.sty package documentation.
    local($nh,$ns,$nv);
    if ($h < .5)  { $nh = $h - .5; }
    else          { $nh = $h + .5; }
    $nv = 1 - $v*(1-$s);
    if ($nv eq 0) { $ns = 0; }
    else          { $ns = ($v*$s) / $nv; }
    &get_hsb_color($nh, $ns, $nv);
}

sub get_Hsb_complement_color {
    local($h,$s,$v) = @_;
    if (!("$s$v")) {($h,$s,$v) = split(',',$h)};
    &get_hsb_complement_color($h/360, $s, $v);
}

sub get_HSB_color {
    local($h,$s,$v) = @_;
    if (!("$s$v")) {($h,$s,$v) = split(',',$h)};
    local($inv_m) = 1/240; # mult is faster than div, so prefer mult by the inverse
    &get_hsb_complement_color($h*$inv_m, $s*$inv_m, $v*$inv_m);
}

## cf: still missing tHsb color and tHsb complement color, but shouldn't be needed.

sub get_gray_complement_color {
    local($gray) = @_;
    $gray = int(255*(1-$gray)+.5);
    local($str)=sprintf("%2x%2x%2x",$gray,$gray,$gray);
    $str=~s/\s/0/g;
    $str;
}

sub get_GRAY_complement_color {
    local($gray) = @_;
    $gray = int($gray+.5);
    local($str)=sprintf("%2x%2x%2x",$gray,$gray,$gray);
    $str=~s/\s/0/g;
    $str;
}

sub get_html_complement_color {
    local($html) = @_;
    local($val) = "[0-9A-Fa-f]";
    local($r,$g,$b) = ($html =~ /($val$val)($val$val)($val$val)/);
    local($str)=sprintf("%2x%2x%2x",255-hex $r,255-hex $g,255-hex $b);
    $str=~s/\s/0/g;
    $str;
}

sub get_HTML_complement_color {
    local($html) = @_;
    local($val) = "[0-9A-Fa-f]";
    local($r,$g,$b) = ($html =~ /($val$val)($val$val)($val$val)/);
    local($str)=sprintf("%2x%2x%2x",255-hex $r,255-hex $g,255-hex $b);
    $str=~s/\s/0/g;
    $str;
}

sub get_wave_complement_color {
    local($_) = @_;
    local($html) = &get_wave_color($_);
    &get_html_complement_color($html);
}

sub get_WAVE_complement_color {
    local($_) = @_;
    local($html) = &get_WAVE_color($_);
    &get_HTML_complement_color($html);
}

# cf: calculate col1!dec!col2, where col1 is a HTML coded color and col2 a
#     named colors (or its complement)
sub mix_colors {
    local($val) = "[0-9A-Fa-f]";
    local($col1,$dec,$col2) = @_;
    local($r1,$g1,$b1) = ($col1 =~ /($val$val)($val$val)($val$val)/);
    local($minus2);
    ($minus2,$col2) = ($col2 =~ /([-]*)([^-].*)/);
    $col2 = &get_named_color($col2);
    $col2 = &get_html_complement_color($col2) unless (length($minus2) % 2 == 0);
    $dec = $dec/100;
    local($r2,$g2,$b2) = ($col2 =~ /($val$val)($val$val)($val$val)/);
    $r1 = hex($r1)*$dec;     $g1 = hex($g1)*$dec;     $b1 = hex($b1)*$dec;
    $r2 = hex($r2)*(1-$dec); $g2 = hex($g2)*(1-$dec); $b2 = hex($b2)*(1-$dec);
    &get_RGB_color(int(.5+$r1+$r2), int(.5+$g1+$g2), int(.5+$b1+$b2));
}

# Mixed color corresponds to the usage of ``mix expr'' as defined in the xcolor
# package, section 2.3. An expression in complete if of the form
# col1!dec1!col2!...!decn!coln, while an incomplete is of the form
# col1!dec1!col2!...!decn, in which case the final color is considered to be
# white.
#
# Ensure the first color is already in HTML format, to facilitate the
# computation of a potential complement of the first color, and ensure that the
# expression is complete.
#
# Each iteration we change $_ to have the current color in HTML format in the
# front, and to have it followed by the next percentage and the rest of the
# expression.
#
sub get_mixed_color {
    local($_) = @_;
    s/^/000000!0!/;
    s/!\d+$/$&!white/;
    while (/!/) {
        s/([0-9A-Fa-f]+)!(\d+)!([^!]+)/&mix_colors($1, $2, $3)/eo;
    }
    $_;
}

1;
