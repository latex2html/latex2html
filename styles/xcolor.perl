package main;

do_require_package('color');

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
    local($val) = "[0-9A-Za-z]";
    local($r,$g,$b) = ($html =~ /($val$val)($val$val)($val$val)/);
    local($str)=sprintf("%2x%2x%2x",255-hex $r,255-hex $g,255-hex $b);
    $str=~s/\s/0/g;
    $str;
}

sub get_HTML_complement_color {
    local($html) = @_;
    local($val) = "[0-9A-Za-z]";
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

1;
