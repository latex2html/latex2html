package main;

do_require_package('color');

sub get_wave_color {
    # cf: From xcolor package documentation (v3.02 (2024/09/29)), we can define
    # a color from its wave length (considering a visible spectrum of [380, 780]).
    # We have (r,g,b) =
    #   - if $l in [380, 440[: ((440-$l) / (440-380), 0, 1)
    #   - if $l in [440, 490[: (0, ($l-440) / (490-440), 1)
    #   - if $l in [490, 510[: (0, 1, (510-$l) / (510-490))
    #   - if $l in [510, 580[: (($l-510) / (580-510), 1, 0)
    #   - if $l in [580, 645[: (1, (645-$l) / (645-580), 0)
    #   - if $l in [645, 780]: (1, 0, 0)
    # Then, in order to let the intensity fall off near the vision limits, we
    # define f() as
    #   - if $l in [380, 420[: 0.3 + 0.7*( ($l-380) / (420-380) )
    #   - if $l in [420, 700[: 1
    #   - if $l in [700, 780]: 0.3 + 0.7*( (780-$l) / (780-700) )
    # And we apply f() to each component to get the final value (to the power
    # gamma):
    #   (red,green,blue)=(f*r)^gamma, (f*g)^gamma, (f*b)^gamma),
    #       where gamma is a real number > 0 (in the xcolor package, value is set
    #       at 0.8).
    local($_) = @_;
    local($r,$g,$b);
    if    ($_ < 380) { ($r,$g,$b) = (0, 0, 0); }
    elsif ($_ < 440) { ($r,$g,$b) = ((440-$_) / (440-380), 0, 1); }
    elsif ($_ < 490) { ($r,$g,$b) = (0, ($_-440) / (490-440), 1); }
    elsif ($_ < 510) { ($r,$g,$b) = (0, 1, (510-$_) / (510-490)); }
    elsif ($_ < 580) { ($r,$g,$b) = (($_-510) / (580-510), 1, 0); }
    elsif ($_ < 645) { ($r,$g,$b) = (1, (645-$_) / (645-580), 0); }
    elsif ($_ < 780) { ($r,$g,$b) = (1, 0, 0); }
    else             { ($r,$g,$b) = (0, 0, 0); }
    local($f);
    if    ($_ < 420) { $f = 0.3 + 0.7*( ($_-380) / (420-380) ); }
    elsif ($_ > 700) { $f = 0.3 + 0.7*( (780-$_) / (780-700) ); }
    else             { $f = 1; }
    &get_rgb_color(($f*$r)**.8, ($f*$g)**.8, ($f*$b)**.8);
}

sub get_WAVE_color {
    local($_) = @_;
    local($r,$g,$b);
    if    ($_ < 380) { ($r,$g,$b) = (0, 0, 0); }
    elsif ($_ < 440) { ($r,$g,$b) = ((440-$_) / (440-380), 0, 1); }
    elsif ($_ < 490) { ($r,$g,$b) = (0, ($_-440) / (490-440), 1); }
    elsif ($_ < 510) { ($r,$g,$b) = (0, 1, (510-$_) / (510-490)); }
    elsif ($_ < 580) { ($r,$g,$b) = (($_-510) / (580-510), 1, 0); }
    elsif ($_ < 645) { ($r,$g,$b) = (1, (645-$_) / (645-580), 0); }
    elsif ($_ < 780) { ($r,$g,$b) = (1, 0, 0); }
    else             { ($r,$g,$b) = (0, 0, 0); }
    local($f);
    if    ($_ < 420) { $f = 0.3 + 0.7*( ($_-380) / (420-380) ); }
    elsif ($_ > 700) { $f = 0.3 + 0.7*( (780-$_) / (780-700) ); }
    else             { $f = 1; }
    &get_rgb_color(($f*$r)**.8, ($f*$g)**.8, ($f*$b)**.8);
}

1;
