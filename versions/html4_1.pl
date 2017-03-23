# -*- perl -*-
#
### File: html4.01.pl
### Language definitions for HTML 4.01


$DOCTYPE = "-//W3C//DTD HTML 4.01";
$DTD_URL = "http://www.w3.org/TR/html4/strict.dtd";

$USING_STYLES = 1;
$math_class = ' ALIGN="CENTER" CLASS="mathdisplay"';
$eqno_class = ' CLASS="eqno"';

# Note that htmlx.x.pl prior modules are *NOT*already loaded.

$declarations{'tiny'} = '<SMALL CLASS="TINY"></SMALL>';
$declarations{'Tiny'} = '<SMALL CLASS="XTINY"></SMALL>';
$declarations{'scriptsize'} = '<SMALL CLASS="SCRIPTSIZE"></SMALL>';
$declarations{'small'} = '<SMALL CLASS="SMALL"></SMALL>';
$declarations{'Small'} = '<SMALL CLASS="FOOTNOTESIZE"></SMALL>';
$declarations{'SMALL'} = '<SMALL CLASS="SCRIPTSIZE"></SMALL>';
$declarations{'footnotesize'} = '<SMALL CLASS="FOOTNOTESIZE"></SMALL>';
$declarations{'large'} = '<BIG CLASS="LARGE"></BIG>';
$declarations{'Large'} = '<BIG CLASS="XLARGE"></BIG>';
$declarations{'LARGE'} = '<BIG CLASS="XXLARGE"></BIG>';
$declarations{'huge'} = '<BIG CLASS="HUGE"></BIG>';
$declarations{'Huge'} = '<BIG CLASS="XHUGE"></BIG>';

$declarations{'sl'} = '<I CLASS="slanted"></I>';
$declarations{'slshape'} = '<I CLASS="slanted"></I>';
$declarations{'sf'} = '<I CLASS="sans"></I>';
$declarations{'sffamily'} = '<I CLASS="sans"></I>';
$declarations{'scshape'} = '<I CLASS="smcaps"></I>';

### Allow for alignment to work

sub do_env_center { &declared_env('center', @_) }
sub do_env_centering { &declared_env('center', @_) }
sub do_env_flushright { &declared_env('flushright', @_) }
sub do_env_flushleft { &declared_env('flushleft', @_) }
sub do_env_raggedright { &declared_env('flushleft', @_) }
sub do_env_raggedleft { &declared_env('flushright', @_) }

sub do_cmd_centering { 
    # MRO *opentags has no effect
    local($_)= @_; &declared_env('center', $_) }
sub do_cmd_raggedright {
    # MRO *opentags has no effect
    local($_) = @_; &declared_env('flushleft', $_) }
sub do_cmd_raggedleftt {
    # MRO *opentags has no effect
    local($_) = @_; &declared_env('flushright', $_) }

sub do_cmd_underline {
    &styled_text_chunk('U','','text','decoration','underline','',@_)}

sub do_cmd_centerline { 
    &styled_text_block('DIV','ALIGN','CENTER','centerline',@_)}
sub do_cmd_leftline { 
    &styled_text_block('DIV','ALIGN','LEFT','leftline',@_)}
sub do_cmd_rightline { 
    &styled_text_block('DIV','ALIGN','RIGHT','rightline',@_)}


# Color support
#require("$LATEX2HTMLSTYLES/color.perl");


####
####  HTML 4.0 specific extensions
####  by Ross Moore <ross@mpce.mq.edu.au>, 7 Oct 1997.
####

$num_type = "\^\\d+\$";
$fontsize_type = "\^+?[1-7]\$";
$percent_type = "\^\\d+(%|\\%|$percent_mark)?\$";
$coord_type = "\^\\s*(\$|\\d+(\\s*,\\s*\\d+)+\\s*\$)";  # comma-separated list of numbers
$pixel_type = "\^\\d+\$";
$length_type = "\^\\d+\%?\$";
$param_type = "\&\#[\\dA-Za-z]+\;";
$mime_type = "^\\s*\\w+\/\\w+\\s*\$";
$mime_type_list = "^\\s*(?:\\w+\/\\w+,\\s*)*\\w+\/\\w+\\s*\$";
$name_type = "\^[A-Za-z][A-Za-z_\\d\\-\\.:]*\$";
$string_type = $URL_type = $script_type = $ISOdate_type = $Internet_type =
	$CDATA_type = "\^.*\$";
$id_list_type = "\^\\s*\$name_type(\\s+$name_type)*\\s*\$";

$event_attribs_rx = "on((dbl)?click|mouse(up|down|over|move|out)|key(press|down|up))";

$dir_type = ",ltr,rtl,";
$halign_type = ",left,right,center,justify,";
$calign_type = $halign_type."char,";
$valign_type = ",top,middle,bottom,baseline,";
$Ialign_type = $halign_type.$valign_type; $Ialign_type = s/center,justify|baseline,//g;
$bullet_type = ",disc,square,circle,";
$shape_type = ",rect,circle,poly,default,";
$scroll_type = ",yes,no,auto,";
#$fontsize_type = ",1,2,3,4,5,6,7,";
$numstyle_type = "1,a,A,i,I,";
$boolean_type = "0,1";
$frame_type = ",void,above,below,hsides,lhs,rhs,vsides,box,border,";
$rules_type = ",none,groups,rows,cols,all,";
$scope_type = ",row,col,rowgroup,colgroup,";

$color_names_list = "Black|Silver|Gray|White|Maroon|Red|Purple|Fuchsia|"
        . "Green|Lime|Olive|Yellow|Navy|Blue|Teal|Aqua";
$color_type = "\^($color_names_list|\\\\?\#?\\w{6})\$";



%closed_tags_list = (
	  'A' , '' 
	, 'ABBR' , ''
	, 'ACRONYM' , ''
	, 'ADDRESS' , ''
	, 'APPLET' , '(CODE|OBJECT),HEIGHT,WIDTH'
	, 'B' , ''
	, 'BDO' , 'DIR'
	, 'BIG' , ''
	, 'BLOCKQUOTE' , ''
	, 'BODY' , ''
	, 'BUTTON' , ''
	, 'CAPTION' , ''
	, 'CENTER' , ''
	, 'CITE' , ''
	, 'CODE' , ''
	, 'COLGROUP' , ''
	, 'DD' , ''
	, 'DEL' , ''
	, 'DFN' , ''
	, 'DIR' , ''
	, 'DIV' , ''
	, 'DL' , ''
	, 'DT' , ''
	, 'EM' , ''
	, 'FIELDSET' , ''
	, 'FONT' , ''
	, 'FORM' , 'ACTION'
	, 'FRAMESET' , ''
	, 'H1','','H2','','H3','','H4','','H5','','H6',''
	, 'HEAD' , ''
	, 'HTML' , ''
	, 'I' , ''
	, 'IFRAME' , ''
	, 'INS' , ''
 	, 'KBD' , ''
  	, 'LABEL' , ''
  	, 'LEGEND' , ''
  	, 'LI' , ''
  	, 'MAP' , ''
  	, 'MENU' , ''
  	, 'NOFRAMES' , ''
  	, 'NOSCRIPT' , ''
  	, 'OBJECT' , ''
  	, 'OL' , ''
  	, 'OPTGROUP' , 'LABEL'
  	, 'OPTION' , ''
   	, 'P' , ''
  	, 'PRE' , ''
   	, 'Q' , ''
   	, 'S' , ''
   	, 'SAMP' , ''
   	, 'SCRIPT' , ''
   	, 'SELECT' , 'NAME'
    	, 'SMALL' , ''
    	, 'SPAN' , ''
   	, 'STRIKE' , ''
   	, 'STRONG' , ''
   	, 'STYLE' , 'TYPE'
   	, 'SUB' , '', 'SUP' , ''
   	, 'TABLE' , '', 'TD', '', 'TH', '', 'TR', ''
   	, 'TBODY' , ''
   	, 'TFOOT' , ''
   	, 'THEAD' , ''
   	, 'TEXTAREA' , 'ROWS,COLS'
   	, 'TITLE' , ''
   	, 'TT' , ''
   	, 'U' , ''
   	, 'UL' , ''
   	, 'VAR' , ''
    );

%unclosed_tags_list = (
	  'AREA' , 'ALT' 
	, 'BASE' , 'HREF' 
	, 'BASEFONT' , 'SIZE' 
	, 'BR' , '' 
	, 'COL' , '' 
	, 'FRAME' , '' 
	, 'HR' , '' 
	, 'IMG' , 'SRC,ALT' 
	, 'INPUT' , '' 
	, 'ISINDEX' , '' 
	, 'LINK' , 'HREF' 
	, 'META' , 'CONTENT' 
	, 'PARAM' , 'NAME' 
    );


$core_attribs = "ID,CLASS,STYLE,TITLE,";
$i18n_attribs = "LANG,DIR,";
$event_attribs = "ONCLICK,ONDBLCLICK,ONMOUSEUP,ONMOUSEDOWN,ONMOUSEOVER,ONMOUSEMOVE,ONMOUSEOUT,ONKEYPRESS,ONKEYDOWN,ONKEYUP,";
$style_attribs = join('',",", $core_attribs, $i18n_attribs, $event_attribs);

$__ID_rx = $__LANG_rx = $name_type_rx;
$__DIR_rx_list = $dir_type;
$__CLASS_rx = $__STYLE_rx = $__TITLE_rx = $cdata_type_rx;

$__ONCLICK_rx = $__ONDBLCLICK_rx = 
    $__ONMOUSEUP_rx = $__ONMOUSEDOWN_rx = $__ONMOUSEOVER_rx = $__ONMOUSEMOVE_rx =
    $__ONMOUSEOUT_rx = $__ONKEYPRESS_rx = $__ONKEYDOWN_rx = $__ONKEYUP_rx = $script_type;



$A_attribs = ",SHAPE,DIR,";
$A__SHAPE = $shape_type;
$A__DIR = $dir_type;
$A_attribs_rx_list = join('',",HREF,HREFLANG,NAME,TYPE,REL,REV,CHARSET,TARGET,ACCESSKEY,COORDS,TABINDEX,ONFOCUS,ONBLUR",$style_attribs);
$A__HREF_rx = $URL_type;
$A__HREFLANG_rx = $name_type;
$A__NAME_rx = $A__REL_rx = $A__REV_rx = $string_type; 
$A__TYPE_rx = $mime_type;
$A__CHARSET_rx = $A__TARGET_rx = $A__ACCESSKEY_rx = $CDATA_type;
$A__COORDS_rx = $coord_type;
$A__TABINDEX_rx = $num_type;
$A__ONFOCUS_rx = $A__ONBLUR_rx = $script_type;

$ABBR_attribs = ",DIR,";
$ABBR__DIR = $dir_type;
$ABBR_attribs_rx_list =  $style_attribs;

$ACRONYM_attribs = ",DIR,";
$ACRONYM__DIR = $dir_type;
$ACRONYM_attribs_rx_list =  $style_attribs;

$ADDRESS_attribs = ",DIR,";
$ADDRESS__DIR = $dir_type;
$ADDRESS_attribs_rx_list = $style_attribs;

$APPLET_attribs = ",ALIGN,DIR,";
$APPLET_attribs_rx_list = join('',",CODE,CODEBASE,OBJECT,ARCHIVE,NAME,ALT,HEIGHT,WIDTH,HSPACE,VSPACE",$style_attribs);
$APPLET__CODEBASE = $URL_type;
$APPLET__CODE = $APPLET__OBJECT = $CDATA_type;      # either is required
$APPLET__NAME = $APPLET__ALT = $APPLET__ARCHIVE = $CDATA_type;
$APPLET__HEIGHT = $APPLET__WIDTH = $pixel_type;     # required
$APPLET__HSPACE = $APPLET__VSPACE = $pixel_type;

$AREA_attribs = ",SHAPE,NOHREF,DIR,";
$AREA__SHAPE = $shape_type;
$AREA_attribs_rx_list = join('',",HREF,COORDS,ALT,TABINDEX,ACCESSKEY,TARGET",$style_attribs);
$AREA__HREF_rx = $URL_type;
$AREA__COORDS_rx = $coord_type;
$AREA__TABINDEX_rx = $num_type;
$AREA__ALT_rx = $AREA__ACCESSKEY_rx = $AREA__TARGET_rx = $string_type;


$B_attribs = ",DIR,";
$B__DIR = $dir_type;
$B_attribs_rx_list = $style_attribs;

$BASE_attribs_rx_list = ",HREF,TARGET,";
$BASE__HREF_rx = $URL_type;           # required
$BASE__TARGET_rx = $CDATA_type;

$BASEFONT_attribs_rx_list = ",ID,SIZE,COLOR,FACE,";
$BASEFONT__SIZE_rx = $fontsize_type;
$BASEFONT__COLOR_rx = $color_type;
$BASEFONT__FACE_rx = $CDATA_type;
$BASEFONT__ID_rx = $name_type;

$BDO_attribs = ",DIR,";
$BDO__DIR = $dir_type;
$BDO_attribs_rx_list = join('',",LANG,", $core_attribs);
$BDO__LANG_rx = $name_type;

$BIG_attribs = ",DIR,";
$BIG__DIR = $dir_type;
$BIG_attribs_rx_list = $style_attribs;

$BLOCKQUOTE_attribs = ",DIR,";
$BLOCKQUOTE__DIR = $dir_type;
$BLOCKQUOTE_attribs_rx_list = join('',",CITE",$style_attribs);
$BLOCKQUOTE__CITE_rx = $URL_type;

$BODY_attribs = ",DIR,";
$BODY__DIR = $dir_type;
$BODY_attribs_rx_list = join('',",TEXT,BGCOLOR,LINK,VLINK,ALINK,BACKGROUND,ONLOAD,ONUNLOAD",$style_attribs);
$BODY__BGCOLOR_rx = $BODY__LINK_rx = $BODY__VLINK_rx  = $BODY__ALINK_rx = 
    $BODY__TEXT_rx = $color_type;
$BODY__BACKGROUND_rx = $string_type;
$BODY__ONLOAD_rx = $BODY__ONUNLOAD_rx = $script_type;

$BR_attribs = ",CLEAR,";
$BR__CLEAR = ",left,all,right,none,";
$BODY_attribs_rx_list = join('',",",$core_attribs);

$BUTTON_attribs = ",TYPE,DISABLED,DIR,";
$BUTTON__TYPE = ",button,submit,reset,";
$BUTTON__DIR = $dir_type;
$BUTTON_attribs_rx_list = join('',",NAME,VALUE,TABINDEX,ACCESSKEY,ONFOCUS,ONBLUR",$style_attribs);
$BUTTON__NAME_rx = $name_type;
$BUTTON__VALUE_rx = $BUTTON__ACCESSKEY_rx = $CDATA_type;
$BUTTON__TABINDEX_rx = $num_type;
$BUTTON__ONFOCUS_rx = $BUTTON__ONBLUR_rx = $script_type;


$CAPTION_attribs = ",ALIGN,DIR,";
$CAPTION__ALIGN = ",top,bottom,left,right,";
$CAPTION_attribs_rx_list = $style_attribs;

$CITE_attribs = ",DIR,";
$CITE__DIR = $dir_type;
$CITE_attribs_rx_list = $style_attribs;

$CODE_attribs = ",DIR,";
$CODE__DIR = $dir_type;
$CODE_attribs_rx_list = $style_attribs;

$COL_attribs = ",ALIGN,VALIGN,DIR,";
$COL__ALIGN = $calign_type;
$COL__VALIGN = $valign_type;
$COL__DIR = $dir_type;
$COL_attribs_rx_list = join('',",SPAN,WIDTH,CHAR,CHAROFF,$style_attribs);
$COL__SPAN = $num_type;
$COL__WIDTH = $length_type;
$COL__CHAR = $COL__CHAROFF = $string_type;

$COLGROUP_attribs = ",ALIGN,VALIGN,DIR,";
$COLGROUP__ALIGN = $calign_type;
$COLGROUP__VALIGN = $valign_type;
$COLGROUP__DIR = $dir_type;
$COLGROUP_attribs_rx_list = join('',",SPAN,WIDTH,CHAR,CHAROFF,$style_attribs);
$COLGROUP__SPAN = $num_type;
$COLGROUP__WIDTH = $length_type;
$COLGROUP__CHAR = $COLGROUP__CHAROFF = $string_type;


$DFN_attribs = ",DIR,";
$DFN__DIR = $dir_type;
$DFN_attribs_rx_list = $style_attribs;

$DIR_attribs = $DL_attribs = $MENU_attribs = ",COMPACT,DIR,";
$DIR__DIR = $MENU__DIR = $DL__DIR = $dir_type;
$DIR_attribs_rx_list = $DL_attribs_rx_list = $MENU_attribs_rx_list = $style_attribs;

$DD_attribs = $DT_attribs = ",DIR,";
$DD__DIR = $DT__DIR = $dir_type;
$DD_attribs_rx_list = $DT_attribs_rx_list = $style_attribs;

$DEL_attribs = $INS_attribs = ",DIR,";
$DEL__DIR = $INS__DIR = $dir_type;
$DEL_attribs_rx_list = $INS_attribs_rx_list = join('',",CITE,DATETIME",$style_attribs);
$DEL__CITE = $INS__CITE = $URL_type;
$DEL__DATETIME = $INS__DATETIME = $ISOdate_type;

$DIV_attribs = ",ALIGN,DIR,";
$DIV__ALIGN = $halign_type;
$DIV__DIR = $dir_type;
$DIV_attribs_rx_list = $style_attribs;


$EM_attribs = ",DIR,";
$EM__DIR = $dir_type;
$EM_attribs_rx_list = $style_attribs;


$FIELDSET_attribs = ",DIR,";
$FIELDSET__DIR = $dir_type;
$FIELDSET_attribs_rx_list = $style_attribs;

$FONT_attribs_rx_list = join('',",SIZE,COLOR,FACE,",$core_attribs);
$FONT__SIZE_rx = $fontsize_type;
$FONT__COLOR_rx = $color_type;
$FONT__FACE_rx = $CDATA_type;

$FORM_attribs = ",METHOD,ENCTYPE,DIR,";
$FORM__METHOD = ",get,post,";
$FORM__DIR = $dir_type;
$FORM__ENCTYPE = ",text\/plain,application\/x\-www\-form\-urlencoded,multipart\/form\-data,";
$FORM_attribs_rx_list = join('',",ACTION,TARGET,ACCEPT,ACCEPT-CHARSET,ONSUBMIT,ONRESET",$style_attribs);
$FORM__ACTION_rx = $URL_type;               # required
$FORM__TARGET_rx = ${FORM__ACCEPT-CHARSET_rx} = $CDATA_type;
$FORM__ONSUBMIT_rx = $FORM__ONRESET_rx = $script_type;
$FORM__ACCEPT_rx = $mime_type_list;

$FRAME_attribs = ",FRAMEBORDER,NORESIZE,SCROLLING,";
$FRAME__FRAMEBORDER = $boolean_type;
$FRAME__SCROLLING = $scroll_type;
$FRAME_attribs_rx_list = ",ID,TITLE,NAME,SOURCE,MARGINWIDTH,MARGINHEIGHT,";
$FRAME__ID_rx = $name_type;
$FRAME__NAME_rx = $FRAME__TITLE_rx = $CDATA_type;
$FRAME__SOURCE_rx = $URL_type;
$FRAME__MARGINWIDTH_rx = $FRAME__MARGINHEIGHT_rx = $pixel_type;

$FRAMESET_attribs_rx_list = ",ID,TITLE,ROWS,COLS,ONLOAD,ONUNLOAD,";
$FRAMESET__ID_rx = $name_type;
$FRAMESET__TITLE_rx = $CDATA_type;
$FRAME__ROWS_rx = $FRAME__COLS_rx = $pixel_type;
$FRAME__ONLOAD_rx = $FRAME__ONUNLOAD_rx = $script_type;


$H1_attribs = $H2_attribs = $H3_attribs = $H4_attribs = 
 $H5_attribs = $H6_attribs = ",ALIGN,DIR,";
$H1__ALIGN = $H2__ALIGN = $H3__ALIGN = $H4__ALIGN = $H5__ALIGN = $H6__ALIGN = $halign_type;
$H1_attribs_rx = $H2_attribs_rx = $H3_attribs_rx = $H4_attribs_rx = 
 $H5_attribs_rx = $H6_attribs_rx = $style_attribs;

$HEAD_attribs = ",DIR,";
$HEAD__DIR = $dir_type;
$HEAD_attribs_rx = ",PROFILE,LANG,";
$HEAD__PROFILE_rx = $URL_type;
$HEAD__LANG_rx = $CDATA_type;

$HR_attribs = ",ALIGN,NOSHADE,";
$HR__ALIGN = $halign_type;
$HR_attribs_rx_list = join('',",SIZE,WIDTH,",$core_attribs,$event_attribs);
$HR__SIZE_rx = $pixel_type;
$HR__WIDTH_rx = $length_type;

$HTML_attribs = ",DIR,";
$HTML_attribs_rx_list = ",VERSION,LANG,";
$HTML__VERSION_rx = $string_type;
$HTML__LANG_rx = $cdata_type;


$I_attribs = ",DIR,";
$I__DIR = $dir_type;
$I_attribs_rx_list = $style_attribs;

$IFRAME_attribs = ",FRAMEBORDER,ALIGN,SCROLLING,";
$IFRAME__FRAMEBORDER = $boolean_type;
$IFRAME__SCROLLING = $scroll_type;
$IFRAME__ALIGN = $Ialign_type;
$IFRAME_attribs_rx_list = ",ID,TITLE,NAME,SOURCE,HEIGHT,WIDTH,MARGINWIDTH,MARGINHEIGHT,";
$IFRAME__ID_rx = $name_type;
$IFRAME__NAME_rx = $FRAME__TITLE_rx = $CDATA_type;
$IFRAME__SOURCE_rx = $URL_type;
$IFRAME__WIDTH_rx = $FRAME__HEIGHT_rx = $length_type;
$IFRAME__MARGINWIDTH_rx = $FRAME__MARGINHEIGHT_rx = $pixel_type;

$IMG_attribs = ",ALIGN,ISMAP,DIR,";
$IMG__ALIGN =  $Ialign_type;
$IMG__DIR = $dir_type;
$IMG_attribs_rx_list = join('',",NAME,WIDTH,HEIGHT,BORDER,HSPACE,VSPACE,SRC,USEMAP,ALT,LONGDESC",$style_attribs);
$IMG__WIDTH_rx = $IMG__HEIGHT_rx = $IMG__BORDER_rx = $IMG__HSPACE_rx = $IMG__VSPACE_rx = $pixel_type;
$IMG__SRC_rx = $URL_type;      # required
$IMG__USEMAP_rx = $IMG__LONGDESC_rx = $URL_type;
$IMG__ALT_rx = $string_type;
$IMG__NAME_rx = $name_type;


$INPUT_attribs = ",TYPE,ISMAP,CHECKED,DISABLED,READONLY,ALIGN,DIR,";
$INPUT__TYPE = ",text,password,checkbox,radio,submit,reset,file,hidden,image,button";
$INPUT__ALIGN = $Ialign_type;
$INPUT__DIR = $dir_type;
$INPUT_attribs_rx_list = join('',",SIZE,MAXLENGTH,NAME,VALUE,SRC,ALT,USEMAP,TABINDEX,ACCESSKEY,ACCEPT,"
	,"ONFOCUS,ONBLUR,ONSELECT,ONCHANGE",$style_attribs);
$INPUT__TABINDEX_rx = $INPUT__MAXLENGTH_rx = $num_type;
$INPUT__SIZE_rx = $INPUT__ACCESSKEY_rx = $INPUT__NAME_rx = $INPUT__VALUE_rx = 
        $INPUT__ALT_rx = $CDATA_type;
$INPUT__SRC_rx = $INPUT__USEMAP_rx = $URL_type;
$INPUT__ONFOCUS_rx = $INPUT__ONBLUR_rx = $INPUT__ONSELECT_rx = $INPUT__ONCHANGE_rx = $script_type;
$INPUT__ACCEPT_rx = $mime_type_list;

$ISINDEX_attribs = ",DIR,";
$ISINDEX__DIR = $dir_type;
$ISINDEX_attribs_rx_list = join('',",PROMPT,LANG,",$core_attribs);
$ISINDEX__PROMPT_rx = $string_type;
$ISINDEX__LANG_rx = $CDATA_type;


$KBD_attribs = ",DIR,";
$KBD__DIR = $dir_type;
$KBD_attribs_rx_list = $style_attribs;


$LABEL_attribs = ",DISABLED,DIR,";
$LABEL__DIR = $dir_type;
$LABEL_attribs_rx_list = join('',",FOR,ACCESSKEY,ONFOCUS,ONBLUR",$style_attribs);
$LABEL__FOR_rx = $LABEL__ACCESSKEY_rx = $CDATA_type;
$LABEL__ONFOCUS_rx = $LABEL__ONBLUR_rx = $script_type;

$LI_attribs = ",TYPE,";
$LI__TYPE = $bullet_type . $numstyle_type; $LI_TYPE =~ s/,,/,/g;
$LI_attribs_rx_list = ",VALUE,";
$LI__VALUE_rx = $num_type;

$LINK_attribs_rx_list = ",HREF,TITLE,REL,REV,";
$LINK__HREF_rx = $URL_type;        # required
$LINK__TITLE_rx = $LINK__REL_rx = $LINK__REV_rx = $string_type;

$MAP_attribs_rx_list = ",NAME,";
$MAP__NAME_rx = $string_type;

$META_attribs_rx_list = ",CONTENT,NAME,HTTP\-EQUIV,";
$META__CONTENT_rx = $string_type;   # required
$META__NAME_rx = $string_type;
${META__HTTP-EQUIV_rx} = $string_type;

$OL_attribs = ",COMPACT,TYPE,";
$OL__TYPE = $numstyle_type;
$OL_attribs_rx_list = ",START,";
$OL__START_rx = $num_type;

$OBJECT_attribs = ",DECLARE,";
$OBJECT_attribs_rx_list = ",CLASSID,CODEBASE,DATA,TYPE,CODETYPE,ARCHIVE,STANDBY,HEIGHT,WIDTH,USEMAP,NAME,TABINDEX,";
$OBJECT__CLASSID_rx = $OBJECT__CODEBASE_rx = $OBJECT__DATA_rx = $OBJECT__ARCHIVE_rx =
  $OBJECT__USEMAP_rx = $URL_type;
$OBJECT__TYPE_rx = $OBJECT__CODETYPE_rx = $OBJECT__STANDBY_rx = $string_type;
$OBJECT__NAME_rx = $CDATA_type;
$OBJECT__WIDTH_rx = $OBJECT__HEIGHT_rx = $length_type;
$OBJECT__TABINDEX_rx = $num_type;

$OPTGROUP_attribs = ",DISABLED,";
$OPTGROUP_attribs_rx_list = ",LABEL,";
$OPTGROUP__LABEL_rx = $name_type;

$OPTION_attribs = ",SELECTED,DISABLED,";
$OPTION_attribs_rx_list = ",LABEL,VALUE,";
$OPTION__LABEL_rx = $name_type;
$OPTION__VALUE_rx = $CDATA_type;

$PARAM_attribs_rx_list = ",NAME,VALUE,";
$PARAM__NAME_rx = $string_type;   # required
$PARAM__VALUE_rx = $string_type;

$PRE_attribs_rx_list = ",WIDTH,";
$PRE__WIDTH = $num_type;

$P_attribs = ",ALIGN,";
$P__ALIGN = $halign_type;


$Q_attribs = ",DIR,";
$Q__DIR = $dir_type;
$Q_attribs_rx_list = join('',",CITE",$style_attribs);
$Q__CITE_rx = $URL_type;


$S_attribs = ",DIR,";
$S__DIR = $dir_type;
$S_attribs_rx_list = $style_attribs;

$SAMP_attribs = ",DIR,";
$SAMP__DIR = $dir_type;
$SAMP_attribs_rx_list = $style_attribs;

$SELECT_attribs = ",MULTIPLE,";
$SELECT_attribs_rx_list = ",SIZE,NAME,";
$SELECT__SIZE_rx = $num_type;
$SELECT__NAME_rx = $string_type;

$SMALL_attribs = ",DIR,";
$SMALL__DIR = $dir_type;
$SMALL_attribs_rx_list = $style_attribs;

$SPAN_attribs = ",DIR,";
$SPAN__DIR = $dir_type;
$SPAN_attribs_rx_list = $style_attribs;

$STRIKE_attribs = ",DIR,";
$STRIKE__DIR = $dir_type;
$STRIKE_attribs_rx_list = $style_attribs;

$STRONG_attribs = ",DIR,";
$STRONG__DIR = $dir_type;
$STRONG_attribs_rx_list = $style_attribs;

$STYLE_attribs = ",DIR,";
$STYLE__DIR = $dir_type;
$STYLE_attribs_rx_list = ",LANG,TYPE,MEDIA,TITLE,";
$STYLE__TYPE_rx = $STYLE__MEDIA_rx = $STYLE__TITLE_rx = $STYLE__LANG_rx = $cdata_type;

$SUB_attribs = $SUP_attribs = ",DIR,";
$SUB__DIR = $SUP__DIR = $dir_type;
$SUB_attribs_rx_list = $SUP_attribs_rx_list = $style_attribs;


$TABLE_attribs = ",ALIGN,DIR,FRAME,RULES,";
$TABLE__ALIGN = $halign_type;
$TABLE__DIR = $dir_type;
$TABLE__FRAME = $frame_type;
$TABLE__RULES = $rules_type;
$TABLE_attribs_rx_list = join('',",CELLPADDING,WIDTH,CELLSPACING,BORDER,BGCOLOR,SUMMARY,COLS",$style_attribs);
$TABLE__WIDTH_rx = $percent_type;
$TABLE__BORDER_rx = $TABLE__CELLSPACING_rx = $TABLE__CELLPADDING_rx = $TABLE__COLS_rx = $num_type;
$TABLE__BGCOLOR_rx = $color_type;
$TABLE__SUMMARY_rx = $cdata_type;

$THEAD_attribs = $TFOOT_attribs = $TBODY_attribs = ",DIR,HALIGN,VALIGN,";
$THEAD__DIR = $TFOOT__DIR = $TBODY__DIR = $dir_type;
$THEAD__HALIGN = $TFOOT__HALIGN = $TBODY__HALIGN = $calign_type;
$THEAD__VALIGN = $TFOOT__VALIGN = $TBODY__VALIGN = $valign_type;
$THEAD_attribs_rx = $TFOOT_attribs_rx = $TBODY_attribs_rx = join('',",CHAR,CHAROFF",$style_attribs);
$THEAD__CHAR_rx = $TFOOT__CHAR_rx = $TBODY__CHAR_rx = $cdata_type;
$THEAD__CHAROFF_rx = $TFOOT__CHAROFF_rx = $TBODY__CHAROFF_rx = $num_type;


$TD_attribs = $TH_attribs = ",ALIGN,VALIGN,NOWRAP,DIR,";
$TR_attribs = ",ALIGN,VALIGN,DIR,";
$TD__ALIGN = $TH__ALIGN = $TR__ALIGN = $calign_type;
$TD__VALIGN = $TH__VALIGN = $TR__VALIGN = $valign_type;
$TD__DIR = $TH__DIR = $TR__DIR = $dir_type;
$TD_attribs_rx_list = $TH_attribs_rx_list = join('',
     ",COLSPAN,ROWSPAN,WIDTH,HEIGHT,CHAR,CHAROFF,BGCOLOR,ABBR,AXIS,HEADERS,SCOPE,"
    , $style_attribs);
$TD__COLSPAN_rx = $TD__ROWSPAN_rx = $TD__WIDTH_rx = $TD__HEIGHT_rx = $TD__CHAROFF_rx = $num_type;
$TH__COLSPAN_rx = $TH__ROWSPAN_rx = $TH__WIDTH_rx = $TH__HEIGHT_rx = $TH__CHAROFF_rx = $num_type;
$TD__CHAR_rx = $TH__CHAR_rx = $cdata_type;
$TD__BGCOLOR_rx = $TH__BGCOLOR_rx = $color_type;
$TD__ABBR_rx = $TH__ABBR_rx  = $TD__AXIS_rx = $TH__AXIS_rx = $cdata_type;
$TD__SCOPE_rx = $TH__SCOPE_rx = $scope_type;
$TD__HEADERS_rx = $TH__HEADERS_rx = $id_list_type;


$TEXTAREA_attribs = ",DISABLED,READONLY,DIR,";
$TEXTAREA__DIR = $dir_type;
$TEXTAREA_attribs_rx_list = ",COLS,ROWS,NAME,TABINDEX,";
$TEXTAREA__COLS = $TEXTAREA__ROWS = $num_type;  # required
$TEXTAREA__TABINDEX = $num_type;
$TEXTAREA__NAME = $cdata_type;
$TEXTAREA__ONFOCUS = $TEXTAREA__ONBLUR = $TEXTAREA__ONSELECT = $TEXTAREA__ONCHANGE = $script_type;

$TT_attribs = ",DIR,";
$TT__DIR = $dir_type;
$TT_attribs_rx_list = $style_attribs;


$U_attribs = ",DIR,";
$U__DIR = $dir_type;
$U_attribs_rx_list = $style_attribs;

$UL_attribs = ",TYPE,COMPACT,DIR,";
$UL__TYPE = $bullet_type;
$UL__DIR = $dir_type;
$UL_attribs_rx_list = $style_attribs;


$VAR_attribs = ",DIR,";
$VAR__DIR = $dir_type;
$VAR_attribs_rx_list = $style_attribs;


if ($FIGURE_CAPTION_ALIGN) {
    if (!($TABLE_CAPTION_ALIGN =~ /^(TOP|BOTTOM|LEFT|RIGHT)/i))
	{ &table_caption_warning('FIGURE') };
} else { $FIGURE_CAPTION_ALIGN = 'BOTTOM' }

if (($TABLE_CAPTION_ALIGN)&&!($TABLE_CAPTION_ALIGN =~ /^(TOP|BOTTOM|LEFT|RIGHT)/i))
	{ &table_caption_warning('TABLE') };

sub table_caption_warning {
    local($which) = @_;
    &write_warnings("\n \$${which}_CAPTION_ALIGN should be 'TOP' or 'BOTTOM'");
}


###   HTML3.2  tables,  based upon...
###
### File: html2.2.pl
### Language definitions for HTML 2.2 (Tables)
### Written by Marcus E. Hennecke <marcush@leland.stanford.edu>

### This file simplifies the earlier code, to be compatible with
### the simpler model used in  HTML 3.2 
### Two subroutines are redefined.
###   ----  Ross Moore <ross@mpce.mq.edu.au>,  21 Feb 1997

# Translates LaTeX column specifications to HTML. Again, Netscape
# needs some extra work with its width attributes in the <td> tags.

$content_mark = "<cellcontents>";
$wrap_parbox_rx = "(\\\\begin$O\\d+${C}tex2html_deferred$O\\d+$C)?"
    . "\\\\parbox(\\s*\\\[[^]]*])*\\s*$O(\\d+)$C([\\w\\W]*)$O\\3$C\\s*$O(\\d+)$C([\\w\\W]*)$O\\5$C"
    . "(\\end<<\\d+>>tex2html_deferred<<\\d+>>)?";

sub translate_colspec {
    local($colspec,$celltag) = @_;
    local($cellopen) = "<$celltag ALIGN";
    local($cellclose) = "</$celltag>\n";
    local($len,$pts,@colspec,$char,$cols,$repeat,$celldata,$at_text,$after_text);
    local($frames, $rules, $prefix,$border)=('','','','');
#    local($NOWRAP) = " NOWRAP";
    local($NOWRAP) = "";

    if ($colspec =~ /$dol_mark/) {
	local($math_colspec) = $`."\\mathon ";
	local($next_dol) = "off ";
	$colspec = $';
	while ($colspec =~ /$dol_mark/) {
	    $colspec = $';
	    $math_colspec .= $`."\\math".$next_dol;
	    $next_dol = (($next_dol =~/off/)? "on " : "off ");
	}
	$colspec = $math_colspec . $colspec;
    }

    $colspec = &revert_to_raw_tex($colspec);
    $frames  = "l" if ( $colspec =~ s/^\|+// );
    $frames .= "r" if ( $colspec =~ s/\|+$// );
    $rules = "c" if ( $colspec =~ /\|/ );
    $border = " BORDER=\"1\"" if (($frames)||($rules));
    $colspec =~ s/\\[chv]line//g;

    $cols = 0; local($art_br) = '';
    while ( length($colspec) > 0 ) {
	$char = substr($colspec,0,1);
	$colspec = substr($colspec,1);
	if ( $char eq "c" ) {
	    if ($at_text) { $at_text = $art_br.$at_text; $after_text = $art_br; }
	    push(@colspec
	        ,"$cellopen=\"CENTER\"$NOWRAP>$at_text$content_mark$after_text$cellclose");
	    $at_text = $after_text = '';
	    $cols++;

	} elsif ( $char =~ /^(l|X)$/ ) {
	    if ($at_text) { $at_text = $art_br.$at_text; $after_text = $art_br; }
	    push(@colspec
	        ,"$cellopen=\"LEFT\"$NOWRAP>$at_text$content_mark$after_text$cellclose");
	    $at_text = $after_text = '';
	    $cols++;

	} elsif ( $char eq "r" ) {
	    if ($at_text) { $at_text = $art_br.$at_text; $after_text = $art_br; }
	    push(@colspec
	        ,"$cellopen=\"RIGHT\"$NOWRAP>$at_text$content_mark$after_text$cellclose");
	    $at_text = $after_text = '';
	    $cols++;

	} elsif ( $char =~ /^(p|m|b|t)$/ ) {
	    local($valign);
	    $valign = (($char eq "b")? "BOTTOM" : (($char eq "m")? "MIDDLE" : "TOP"));
	    $valign = " VALIGN=\"${valign}\"";
	    $colspec =~ s/^\s*\{([^\}]*)\}\s*/$celldata=$1;''/e;

	    local($pxs,$len) = &convert_length($celldata) if ($celldata);
	    if ($pxs) {
		if ($pxs=~/\%/) { $pxs=~s/(\d+)\%/$1*5/e; }
		$pxs = "\"$pxs\"" if ($pxs=~/\%/);
		$celldata = " WIDTH=$pxs";
	    }
	    if ($at_text) { $at_text = $art_br.$at_text; $after_text = $art_br; }
	    push(@colspec
		,"$cellopen=\"LEFT\"${valign}$celldata>$at_text$content_mark$after_text$cellclose");
	    $at_text = $after_text = '';
	    $cols++;

	} elsif ( $char eq "|" ) {
	    #RRM currently ignored; presence already detected for $rules

	} elsif ( $char =~ /(\@|\!)/ ) {
# RRM: the following assumes text of the @-expression to be constant for each row.
# Usually this will be true, but LaTeX allows otherwise
	    $colspec =~ s/\s*\{([^\}]*)\}\s*/$celldata=$1;''/e; 
	    if ($celldata =~ /\{/ ) {
		local($databit) = $celldata;
		local($numopens); $celldata =~ s/\{/$numopens++;"\{"/eg;
		while (($colspec)&& $numopens) {
		    if ($colspec =~ s/^([^\}]*)\}//) {
			$databit=$1; $celldata.="\}".$databit;
			$databit =~ s/\{/$numopens++;"\{"/eg;
			--$numopens;
		    } else { $databit = ''; }
		}
		do { local($_) = $celldata; &pre_process; $celldata = $_ };
	    }
	    $celldata .= ' ' if ($celldata =~ /\\\w+$/);

	    $celldata =~ s/$wrap_parbox_rx/$6/gm;
#	    $at_text .= $celldata;
#	    if ( $#colspec > -1) {
#	        $colspec[$#colspec] .= join('', "<TD ALIGN=\"LEFT\">",$celldata,'</TD>');
#	    } else { $at_text .= join ('', $celldata , '</TD><TD>' ) }
	    push (@colspec, join('', "<TD ALIGN=\"LEFT\">",$celldata,'</TD>'));
	    $celldata = '';

	} elsif ( $char =~ /\>/ ) {
# RRM: the following assumes text of the @-expression to be constant for each row.
# Usually this will be true, but LaTeX allows otherwise
	    $colspec =~ s/\s*\{([^\}]*)\}\s*/$celldata=$1;''/e; 
	    if ($celldata =~ /\{/ ) {
		local($databit) = $celldata;
		local($numopens); $celldata =~ s/\{/$numopens++;"\{"/eg;
		while (($colspec)&& $numopens) {
		    if ($colspec =~ s/^([^\}]*)\}//) {
			$databit=$1; $celldata.="\}".$databit;
			$databit =~ s/\{/$numopens++;"\{"/eg;
			--$numopens;
		    } else { $databit = ''; }
		}
		do { local($_) = $celldata; &pre_process; $celldata = $_ };
	    }
	    $celldata .= ' ' if ($celldata =~ /\\\w+$/);

	    $celldata =~ s/$wrap_parbox_rx/$6/gm;
	    $at_text .= $celldata;

	} elsif ( $char =~ /;|\&/ ) {
	    if ($colspec =~ s/^(SPM)?lt;//) {
		$colspec =~ s/\s*\{([^\}]*)\}\s*/$celldata=$1;''/e;
		$celldata .= ' ' if ($celldata =~ /\\\w+$/);
		$colspec[$#colspec] =~ s/(($art_br)?$cellclose)/$1$celldata$1/;
	    } else {
		print "\n*** unknown entity in table-spec ***\n";
	    }

	} elsif ( $char =~ /\</ ) {
	    $colspec =~ s/^\s*\{([^\}]*)\}\s*/$celldata=$1;''/e;
	    if ($celldata =~ /\{/ ) {
		local($databit) = $celldata;
		local($numopens); $celldata =~ s/\{/$numopens++;"\{"/eg;
		while (($colspec)&& $numopens) {
		    if ($colspec =~ s/^([^\}]*)\}//) {
			$databit=$1; $celldata.="\}".$databit;
			$databit =~ s/\{/$numopens++;"\{"/eg;
			--$numopens;
		    } else { $databit = ''; }
		}
		do { local($_) = $celldata; &pre_process; $celldata = $_ };
	    }
	    $celldata .= ' ' if ($celldata =~ /\\\w+$/);

	    $celldata =~ s/$wrap_parbox_rx/$6/g;
	    if ($#colspec > -1) {	        
		$colspec[$#colspec] =~ s/($art_br)?$cellclose/$celldata$1$cellclose/;
	    } else { $at_text .=  $celldata }

	} elsif ( $char =~ /\!/ ) {
	    $colspec =~ s/^\s*\{([^\}]*)\}\s*/$celldata=$1;''/e;
	    if ($celldata =~ /\{/ ) {
		local($databit) = $celldata;
		local($numopens); $celldata =~ s/\{/$numopens++;"\{"/eg;
		while (($colspec)&& $numopens) {
		    if ($colspec =~ s/^([^\}]*)\}//) {
			$databit=$1; $celldata.="\}".$databit;
			$databit =~ s/\{/$numopens++;"\{"/eg;
			--$numopens;
		    } else { $databit = ''; }
		}
		do { local($_) = $celldata; &pre_process; $celldata = $_ };
	    }
	    $celldata .= ' ' if ($celldata =~ /\\\w+$/);

	    $celldata =~ s/$wrap_parbox_rx/$6/g;
	    if ($#colspec > -1) {	        
		$colspec[$#colspec] =~ s/($art_br)?$cellclose/$celldata$1$cellclose/;
	    } else { $at_text .=  $celldata }

	} elsif ( $char eq "*" ) {
	    $colspec =~ s/^\s*\{([^\}]*)\}\s*/$repeat=$1;''/e; 
	    $colspec =~ s/^\s*\{([^\}]*)\}\s*/$celldata=$1;''/e; 
	    if ($celldata =~ /\{/ ) {
		local($databit) = $celldata;
		local($numopens); $celldata =~ s/\{/$numopens++;"\{"/eg;
		while (($colspec)&& $numopens) {
		    if ($colspec =~ s/^([^\}]*)\}//) {
			$databit=$1; $celldata.="\}".$databit;
			$databit =~ s/\{/$numopens++;"\{"/eg;
			--$numopens;
		    } else { $databit = ''; }
		}
	    }

	    while ($repeat > 1) {
		$colspec = $celldata . $colspec;
#		&make_unique_p($colspec) if ($colspec =~ /$OP/);
#		&make_unique($colspec) if ($colspec =~ /$O/);
		$repeat--;
	    };
	    $colspec = $celldata . $colspec;
	};
    };
    $colspec[$#colspec] =~ s/($art_br)?$cellclose/$at_text$1$cellclose/
	if ($at_text);

    $colspec[0] = $prefix . $colspec[0];
    ('',$frames,$rules,$cols,@colspec);
}

# convert \\s inside \parbox commands to <BR>s;
sub convert_parbox_newlines {
    local($ptext) = @_;
    $ptext =~ s/\\\\\s*/\\newline /og;
    $ptext;
}

sub do_cmd_mathon {
    local($_) = @_;
    s/\\mathoff\b//;
    local($thismath) = $`; $_=$';
    join ('', &do_env_math("$thismath")
            , &translate_commands($_));
}

sub process_quote {
    local($lquo, $text, $rquo) = @_;
    local($lang) = &get_current_language();
    join('','<Q', $lang , '>'
	, &translate_commands( &translate_environments ($text))
	, '</Q>' );
}

sub do_env_tabular { &process_tabular(0,@_[0]); }
sub do_env_tabularx { &do_env_tabularstar(@_); }


sub do_env_tabularstar {
    local($_) = @_;
    local($width,$pxs);
    $width = &missing_braces unless (
        (s/$next_pair_pr_rx/$width = $2;''/e)
        ||(s/$next_pair_rx/$width = $2;''/e));
    ($pxs,$width) = &convert_length($width);
    $pxs = (100 x $pxs)."$percent_mark" if (($pxs)&&($pxs <= 1 ));
    &process_tabular($pxs,$_);
}

sub do_cmd_tablehead {
   local($_) = @_;
   local($text);
   $text = &missing_braces unless (
        (s/$next_pair_pr_rx/$text = $2;''/e)
        ||(s/$next_pair_rx/$text = $2;''/e));
   $TABLE_TITLE_TEXT = $text;
   $_;
}
sub do_cmd_tabletail {
   local($_) = @_;
   local($text);
   $text = &missing_braces unless (
        (s/$next_pair_pr_rx/$text = $2;''/e)
        ||(s/$next_pair_rx/$text = $2;''/e));
   $TABLE_TAIL_TEXT = $text;
   $_;
}


sub process_tabular {
    local($tab_width,$_) = @_;
    local(@save_open_tags_tabular) = @saved_tags;
    local($open_tags_R) = [];
    local(@save_open_tags) = ();

    &get_next_optional_argument;
    local($colspec);
    $colspec = &missing_braces unless (
        (s/$next_pair_pr_rx/$colspec = $2;''/e)
        ||(s/$next_pair_rx/$colspec = $2;''/e));
    s/\\\\\s*\[([^]]+)\]/\\\\/g;  # TKM - get rid of [N.n pc] on end of rows...
    s/\\newline\s*\[([^]]+)\]/\\newline/g;
    s/\n\s*\n/\n/g;	# Remove empty lines (otherwise will have paragraphs!)
    local($i,@colspec,$char,$cols,$cell,$htmlcolspec,$frames,$rules);
    local(@rows,@cols,$border,$frame);
    local($colspan,$cellcount);
    
    # set a flag to indicate whether there are any \multirow cells
    my $has_multirow = 1 if (/\\multirow/s);
    
    # convert \\s inside \parbox commands to \newline s;
    # catch nestings

    while (/\\parbox/) {
	local($parlength) = length($_);
	s/$wrap_parbox_rx/&convert_parbox_newlines($6)/egm;

	if ($parlength == length($_)) {
	    print "\n*** \\parbox's remain in table!!\n";
	    last; # avoid looping
	}
    }

    # save start and end tags for cells, inherited from outside
    $open_tags_R = [ @save_open_tags_tabular ];
    local($closures,$reopens) = &preserve_open_tags;
    $open_tags_R = [ @save_open_tags_tabular ];

    if ($color_env) {
	local($color_test) = join(',',@$open_tags_R);
	if ($color_test =~ /(color\{[^}]*})/g ) {
	    $color_env = $1;
	}
    }

    # catch outer captions, so they cannot get caught by sub-tabulars
    local($table_captions);
    if ($TABLE_CAPTIONS) { # captions for super-tabular environment
	$cap_env = 'table' unless $cap_env;
	$captions = $TABLE_CAPTIONS;
	$TABLE_CAPTIONS = '';
    }
    if ($cap_env && $captions) {
	$captions =~ s/\n+/\n/g;
	$table_captions = "\n<CAPTION>$captions</CAPTION>";
	$captions = '';
#	$cap_anchors = '';
    }

    # *must* process any nested table-like sub-environments,
    # so might as well do *all* sub-environments
    # using styles inherited from outside

    local($inside_tabular) = 1;
    $_ = &translate_environments($_)
	if (/$begin_env_rx|$begin_cmd_rx/);

    # kill all tags
    @save_open_tags = ();
    $open_tags_R = [];

    $_ =~ s/<\#rm\#>/\\rm /g;
    # environments may be re-processed within a cell
    $_ =~ s/$OP(\d+)$CP/$O$1$C/g;
    undef $inside_tabular;
    
    $border = ""; $frame = "";
    ($htmlcolspec,$frames,$rules,$cols,@colspec) =
	&translate_colspec($colspec, 'TD');
    local($ecell) = '</TD>';

    print "\nCOLSPEC: ", join('',@colspec),"\n" if ($VERBOSITY > 3);

    $frames .= "t" if ( s/^\s*\\hline// );
    $frames .= "b" if ( s/\\hline\s*$// );
    $rules  .= "r" if ( s/\\[hv]line//g );
    #RRM:  retain any \cline to gobble its argument

    if ( $frames || $rules ) { $border = " BORDER=\"1\""; };

    # convert \\s inside \parbox commands to \newline s;
    # catch nestings

    s/\\\\[ \t]*\[[^\]]*]/\\\\/g; # remove forced line-heights
    @rows = split(/\\\\/);

    $#rows-- if ( $rows[$#rows] =~ /^\s*$/ );
    if ($tab_width) {
	if ($tab_width =~ /(\%|$percent_mark)/) { $tab_width = "\"$tab_width\"" }
	elsif ($tab_width <= 1) {$tab_width = "\"".(100 x $tab_width)."\"" }
	$tab_width = " WIDTH=$tab_width";
    } else { $tab_width = '' }

#    if ($TABLE_CAPTIONS) { # captions for super-tabular environment
#	$cap_env = 'table' unless $cap_env;
#	$captions = $TABLE_CAPTIONS;
#	$TABLE_CAPTIONS = '';
#    }

    local($lang) = &get_current_language();
    local($return);

    if ($table_captions) {
	$return = join('', (($cap_anchors)? "$cap_anchors\n" : '')
		, "<TABLE$env_id$lang CELLPADDING=3"
		, $border
		, ($halign ? " ALIGN=\"$halign\"" : '')
		, $tab_width, ">");
	$return .= $table_captions;
#	$return .= "\n<CAPTION$lang>$captions</CAPTION>";
#	$captions = '';
#	$cap_anchors = '';
    } else { 
	$return = join('', "<TABLE$env_id$lang CELLPADDING=3"
		, $border
		, ($halign ? " ALIGN=\"$halign\"" : '')
		, $tab_width, ">");
    }
    $env_id = '';

    local($firstrow) = 1;
    local($lastrow) = '';
    local($headcell) = 0;
    local($table_tail_marker) = "<table_tail_mark>";
    @rows = ($TABLE_TITLE_TEXT, @rows) if ($TABLE_TITLE_TEXT);
    @rows = (@rows, $table_tail_marker . $TABLE_TAIL_TEXT)
	if ($TABLE_TAIL_TEXT);

    local @row_spec = map {'0'} @colspec if ($has_multirow);
    foreach (@rows) {
	#ignore lone <P> caused by extra blank line in table; e.g. at end
	next if (/^\s*(<[<#]\d+[#>]>)<P[^>]*>\1\s*$/s);
	next if (/^\s*${closures}<P[^>]*>${reopens}\s*$/s);

	#ignore <P> at the start of a row
	s/^\s*(${closures})\s*<P[^>]*>\n/$1/s;

	# discard long-table headers, footers and kill-rows;
	s/^.*\\end(first|last)?(head|foot)//mg if $firstrow;
	next if /\\kill/;
	next if ((/^\s*$/)&&($firstrow));
	#ignore widowed \hline and \cline commands; e.g. on last line
	next if (
  (/^\s*\\(hline|cline(<[<#]\d+[#>]>)(<[<#]\d+[#>]>)?\d+\3?\-(<[<#]\d+[#>]>)?\d+\4?\2)?\s*$/)
	    &&($border));
	$lastrow = 1 if (s/^$table_tail_marker//);

	print "\nTABLE-ROW: $_\n" if ($VERBOSITY > 3);

	local($valign) = ' VALIGN=';
	if ($NETSCAPE_HTML) { $valign .= '"BASELINE"' }
	else { $valign = '' }
	$return .= "\n<TR$valign>";
	@cols = split(/$html_specials{'&'}/o);

	if ($has_multirow) {
	    # decrement the counters for multi-row cells 
	    my @trow_spec = map {$_>0? --$_ : 0 } @row_spec;
	    @row_spec = @trow_spec;
	}

	for ( $i = 0; $i <= $#colspec; $i++ ) {
	    # skip this cell if it is covered by a \multirow
	    next if ($has_multirow && @row_spec[$i] > 0);

	    $colspec = $colspec[$i];
	    if (!($colspec =~ $content_mark)) {
		# no data required in this column
		$colspec = &translate_environments($colspec);
		$colspec = &translate_commands($colspec)
		    if ($colspec =~ /\\/);
		$return .= $colspec;
		next;
	    }
	    $colspan = 0; $cell_done = '';
	    $cell = shift(@cols);
	    # Attempt to identify title cells
	    if (($firstrow || !$i)
		    && ($cell =~ /^\s*\\((text)?(bf|it|sf)|large)/i)) {
		$headcell = 'TH';
	    } else { $headcell = '' }
	    $colspec =~ s/(<\/?T)D/$1H/g
		if (($firstrow &&($TABLE_TITLE_TEXT))
		    ||($lastrow &&($TABLE_TAIL_TEXT)));

	    print "\nTABLE-CELL: $cell\n" if ($VERBOSITY > 3);

	    # remove any \parbox commands, leaving the contents
	    #RRM:  actually, there shouldn't be any left  :-) 
	    $cell =~ s/\\parbox[^<]*<<(\d*)>>([\w\W]*)<<\1>>/$1/g;

	    local($num);
	    # May modify $colspec
	    if ($cell =~ /\s*\\(multicolumn|omit)/) {
		$cell_done = 1 if ($1 =~ /omit/);
		if(@save_open_tags_tabular) {
		    $open_tags_R = [ @save_open_tags_tabular ];
		    @save_open_tags = @save_open_tags_tabular;
		}
		$cell = &translate_environments($cell);
		$cell = $reopens . &translate_commands($cell);
		$cell .= &close_all_tags() if (@$open_tags_R);
	    } elsif ($colspec =~ /\\/g) {
		local($tmp, $cmd, $endspec);
		$colspec =~ /$content_mark/; $colspec = $`.$&;
		$endspec = $'; $endspec =~ s/$ecell\s*//;
		$colspec .= $endspec;
		local($orig_spec) = $colspec;
		local(@cmds) = (split(/\\/,$colspec));
		$colspec = '';
		while ($tmp = pop @cmds) {
		    $cmd = '';
		    $tmp =~ s/^([a-zA-Z]+)\s*/$cmd=$1;''/e;
		    if ($declarations{$cmd}||
	($cmd =~ /($sizechange_rx)|($image_switch_rx)|($env_switch_rx)/)) {
			$id = ++$global{'max_id'};
			$colspec = join('',"$O$id$C","\\$cmd"
			    , (($tmp =~/^[a-zA-Z]/)? " ":'')
			    , "$tmp", $colspec, "$O$id$C");
		    } else {
			$colspec = join('',"\\$cmd"
			    , (($tmp =~/^[a-zA-Z]/)? " ":''), "$tmp", $colspec);
		    }
		}
		$colspec =~ s/^\\//; #remove unwanted initial \
		$colspec = join('',@cmds,$colspec);
		if ($colspec =~ /\\/) {
		    $colspec =~ s/$content_mark/$cell/;
		} else { 
		    $colspec =~ s/$content_mark${O}1$C/$cell${O}1$C/;
		}
		$colspec =~ s/\\mathon([.\n]*)\\mathoff/
		    local($tmp) = ++$global{'max_id'};
	"\\begin$OP$tmp${CP}math$OP$tmp$CP$1\\end$OP$tmp${CP}math$OP$tmp$CP"
		    /eg;
		undef $cmd; undef $tmp; undef $endspec; undef @cmds;

		local($tmp) = ++$global{'max_id'};
		if(@save_open_tags_tabular) {
		    $open_tags_R = [ @save_open_tags_tabular ];
		    @save_open_tags = @save_open_tags_tabular;
		}
		$colspec = &translate_environments("$OP$tmp$CP$colspec$OP$tmp$CP");
		$colspec = &translate_commands($colspec);
		while ($colspec =~ s/<(\w+)>\s*<\/\1>//gm) {};
		$colspec = ';SPMnbsp;' if ($colspec =~ /^\s*$/);
		$colspec = join('', $reopens, $colspec
		        , (@$open_tags_R ? &close_all_tags() : '')
		        , $ecell, "\n" );
		local($cell_done);
	    } else {
		local($tmp) = ++$global{'max_id'};
		if(@save_open_tags_tabular) {
		    $open_tags_R = [ @save_open_tags_tabular ];
		    @save_open_tags = @save_open_tags_tabular;
		}
		$cell = &translate_environments("$OP$tmp$CP$cell$OP$tmp$CP");
		$cell = &translate_commands($cell) if ($cell =~ /\\/);
		$cell = join('', $reopens, $cell
			, (@$open_tags_R ? &close_all_tags() : '')
			);
	    }
	    # remove remains of empty braces
	    $cell =~ s/(($O|$OP)\d+($C|$CP))//g;
	    # remove leading/trailing space
	    $cell =~ s/^\s*|\s*$//g;
	    $cell = ";SPMnbsp;" if ($cell eq '');

	    if ( $colspan ) {
		for ( $cellcount = 0; $colspan > 0; $colspan-- ) {
#		    $colspec[$i++] =~ s/<TD/$cellcount++;"<$celltype"/ge;
		    $i++; $cellcount++;
		}
		$i--;
		$colspec =~ s/>$content_mark/ COLSPAN=$cellcount$&/;
	    };

	    $colspec =~ s/$content_mark/$cell/ unless ($cell_done);

	    if ($headcell) {
		$colspec =~ s/<TD/<$headcell/g;
		$colspec =~ s/<\/TD/<\/$headcell/g;
	    }
	    $return .= $colspec;
	    undef $cell_done;
	};
	$return .= "</TR>";
	$firstrow = 0;
    };
    $open_tags_R = [ @save_open_tags_tabular ];
    $TABLE_TITLE_TEXT = '';
    $TABLE_TAIL_TEXT = '';
    $return =~ s/$OP\d+$CP//g;
    $return =~ s/<(T[DH])( [^>]+)?>\s*($content_mark)?(<\/\1>)/<$1$2>;SPMnbsp;$4/g;
    $return . "\n</TABLE>";
}

### Define the multicolumn command
# Modifies the $colspec and $colspan variables of the tabular subroutine
sub do_cmd_multicolumn {
    local($_) = @_;
    local($dmy1,$dmy2,$dmy3,$dmy4,$spancols,$malign,$text);
    $spancols = &missing_braces unless (
	(s/$next_pair_pr_rx/$spancols=$2;''/eo)
        ||(s/$next_pair_rx/$spancols=$2;''/eo));
    $colspan = 0+$spancols;
    $colspec =~ /^<([A-Z]+)/;
    local($celltag) = $1;
    $malign = &missing_braces unless (
	(s/$next_pair_pr_rx/$malign=$2;''/eo)
	||(s/$next_pair_rx/$malign=$2;''/eo));

    # catch cases where the \textwidth has been discarded
    $malign =~s!^(\w)($OP\d+$CP)\s*(\d|\d*\.\d+)\2$!$1\{$3\\textwidth\}!;

    ($dmy1,$dmy2,$dmy3,$dmy4,$colspec) = &translate_colspec($malign, $celltag);
    $text = &styled_text_chunk('SPAN','mcol','','','','', $_);
    $text = &translate_commands($text) if ($text =~ /\\/);
    $text;
}
sub do_cmd_multirow {
    local($_) = @_;
    local($dmy1,$dmy2,$dmy3,$dmy4,$spanrows,$pxs,$rwidth,$valign,$vspec,$text);
    $spanrows = &missing_braces unless (
	(s/$next_pair_pr_rx/$spanrows=$2;''/eo)
        ||(s/$next_pair_rx/$spanrows=$2;''/eo));
    my $rowspan = 0+$spanrows;
    # set the counter for this column to the number of rows covered
    @row_spec[$i] = $rowspan;

    $colspec =~ /^<([A-Z]+)/;
    local($celltag) = $1;

    # read the width, but ignore it
    $rwidth = &missing_braces unless (
	(s/$next_pair_pr_rx/$rwidth=$2;''/eo)
	||(s/$next_pair_rx/$rwidth=$2;''/eo));

    # catch cases where the \textwidth has been discarded
    $rwidth =~s!^(\w)($OP\d+$CP)\s*(\d|\d*\.\d+)\2$!$1\{$3\\textwidth\}!;

    ($pxs,$rwidth) = &convert_length($rwidth);

    $valign = &missing_braces unless (
        (s/$next_pair_pr_rx/$valign=$2;''/eo)
        ||(s/$next_pair_rx/$valign=$2;''/eo));
    $vspec = ' VALIGN="TOP"' if $valign;
    if ($valign =~ /m/i) { $vspec =~ s/TOP/MIDDLE/ }
    elsif ($valign =~ /b/i) { $vspec =~ s/TOP/BOTTOM/ }

    $colspec =~ s/VALIGN="\w+"// if $vspec; # avoid duplicate tags
    $colspec =~ s/>$content_mark/$vspec ROWSPAN=$rowspan WIDTH=$pxs$&/;

    $text = &styled_text_chunk('SPAN','mrow','','','','', $_);
    $text = &translate_commands($text) if ($text =~ /\\/);
    $text;
}

## Mathematics environments

sub process_math_env {
    local($mode,$_) = @_;
    local($labels, $comment);
    ($_,$labels) = &extract_labels($_); # extract labels
    $comment = &make_math_comment($_);
    local($max_id) = ++$global{'max_id'};
    if ($failed) { return($labels, $comment, $_) };
    $_ = &simple_math_env($_);
    if ($BOLD_MATH) {
        ($labels, $comment, join('','<SPAN CLASS="BOLDMATH">', $_, '</SPAN>'))
    } else { 
        ($labels, $comment, join('','<SPAN CLASS="MATH">', $_ ,'</SPAN>')) 
    }
}

sub make_math_comment{
    local($_) = @_;
    local($scomm,$ecomm)=("\$","\$");
    return() if ($inside_tabbing||(/$image_mark/));
    do {
        $scomm = "\\begin{$env}\n";
	$ecomm = "\n\\end{$env}";
    } unless ($env =~/tex2html/);
    $_ = &revert_to_raw_tex;
    s/^\s+//s; s/\s+$//sm;
    $_ = $scomm . $_ . $ecomm;
    return() if (length($_) < 16);
    $global{'verbatim_counter'}++;
    $verbatim{$global{'verbatim_counter'}} = $_;
    &write_mydb('verbatim_counter', $global{'verbatim_counter'}, $_ );
    join('', "\n", $verbatim_mark, '#math' , $global{'verbatim_counter'},'#')
} 

sub do_env_math {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment, $img_params) = ("inline",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    $saved =~ s/^\s*(\$|\\\()?\s*/\$/;
    $saved =~ s/\s*(\$|\\\))?\s*$/\$/;
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    $comment =~ s/^\n//; # remove the leading \n
    if ($failed) {
	$_ = join ('', $comment, $labels
	    , '<SPAN CLASS="MATH">'
            , &process_undefined_environment("tex2html_wrap_inline", $id, $saved)
	    , '</SPAN>' );
    } else { $_ = join('', $comment, $labels, $_ ) }
    if ($border||($attributes)) {
        &make_table( $border, $attribs, '', '', '', $_ )
    } else { $_ }
}

sub do_env_tex2html_wrap {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment,$img_params) = ("inline",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    s/^\\\(//;    s/\\\)$//;
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    $comment =~ s/^\n//; # remove the leading \n
    if ($failed) {
	$_ = join ('', $comment, $labels 
             , &process_undefined_environment("tex2html_wrap", $id, $saved));
    } else { $_ = $comment . $labels ." ".$_; }
    if ($border||($attribs)) {
        &make_table( $border, $attribs, '', '', '', $_ )
    } else { $_ }
}

sub do_env_tex2html_wrap_inline {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment) = ("inline",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    s/(^\s*(\$|\\\()\s*|\s*(\$|\\\))\s*$)//g; # remove the \$ signs or \(..\)

    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    $comment =~ s/^\n//; # remove the leading \n
    if ($failed) {
	if ($USING_STYLES) {
	    $env_id =~ s/\"$/ image\"/;
	    $env_id = ' CLASS="MATH"' if ($env_id =~ /^\s*$/);
	    $_ = join ('', $labels, $comment, "<SPAN$env_id>"
		, &process_undefined_environment("tex2html_wrap_inline", $id, $saved)
		, "</SPAN>");
	    $env_id = '';
	} else {
	    $_ = join ('', $labels, $comment 
	    , &process_undefined_environment("tex2html_wrap_inline", $id, $saved));
	}
    } else { $_ = join('', $labels, $comment, $_); }
    if ($border||($attribs)) { 
	&make_table( $border, $attribs, '', '', '', $_ ) 
    } else { $_ }
}

# Allocate a fixed width for the equation-numbers:
#$seqno = "\n<TD WIDTH=1 ALIGN=\"CENTER\">\n";

sub do_env_equation {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment) = ("equation",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    local($sbig,$ebig,$falign) = ('','','CENTER');
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 ));
    local($math_start,$math_end)= ($sbig,$ebig);

    local($eqno);
    local($seqno) = join('',"\n<TD$eqno_class WIDTH=10 ALIGN=\""
                         , (($EQN_TAGS =~ /L/)? 'LEFT': 'RIGHT')
		         , "\">\n");
    do { # get the equation number
	$global{'eqn_number'}++;
	$eqno = &translate_commands('\theequation');
    } unless ((s/(\\nonumber|\\notag)//gm)||(/\\tag/));
    if (/\\tag(\*)?/){
	# AmS-TEX line-number tags.
	if (defined  &get_eqn_number ) {
	    ($eqno, $_) = &get_eqn_number(1,$_);
	} else {
	    s/\\tag(\*)?//m;
	    local($nobrack,$before) = ($1,$`);
	    $_ = $';
	    s/next_pair_pr_rx//om;
	    if ($nobrack) { $eqno = $2; }
	    else { $eqno = join('',$EQNO_START, $2, $EQNO_END) };
	    $_ = $before;
	}
    } elsif ($eqno) {
	$eqno = join('',$EQNO_START, $eqno, $EQNO_END)
    } else { $eqno = '&nbsp;' } # spacer, when no numbering

    # include the equation-number, using a <TABLE>
    local($halign) = " ALIGN=\"CENTER\"" unless $FLUSH_EQN;
    local($lang) = &get_current_language();
    if ($EQN_TAGS =~ /L/) {
	# equation number on left
	($math_start,$math_end) =
	    ("\n<TABLE$env_id$lang WIDTH=\"100%\" ALIGN=\"CENTER\""
		. (($border)? " BORDER=\"$border\"" : '')
		. (($attribs)? " $attribs" : '')
		. ">\n<TR VALIGN=\"MIDDLE\">". $seqno . $eqno
		. "</TD>\n<TD$halign NOWRAP>$sbig"
	    , "$ebig</TD>\n</TR></TABLE>");
	$border = $attribs = $env_id = '';
    } else {
	# equation number on right
	($math_start,$math_end) =
	    ("\n<TABLE$env_id$lang WIDTH=\"100%\" ALIGN=\"CENTER\""
		. (($border)? " BORDER=\"$border\"" : '')
		. (($attribs)? " $attribs" : '')
		. ">\n<TR VALIGN=\"MIDDLE\"><TD></TD>"
		. "<TD$halign NOWRAP>$sbig"
	    , $ebig .'</TD>'. $seqno . $eqno ."</TD></TR>\n</TABLE>");
	$border = $attribs = $env_id = '';
    }

    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    if ($failed) {
	$_ = join ('', $comment, $labels, $math_start
	    , &process_undefined_environment('displaymath', $id, $saved)
	    , $math_end );
    } else {
	s/^[ \t]*\n?/\n/; s/\n?[ \t]*$/\n/;
	$_ = join('', $comment, $labels, $math_start, $_, $math_end );
    }
    if ($border||($attribs)) { 
	join('',"<BR>\n<DIV$math_class>\n"
	    , &make_table( $border, $attribs, '', '', '', $_ )
	    , "\n<BR CLEAR=\"ALL\">");
    } elsif ($failed) {
	$falign = (($EQN_TAGS =~ /L/)? 'LEFT' : 'RIGHT') if ($eqno);
	local($fclass) = $math_class;
	$fclass =~ s/(ALIGN=\")[^"]*/$1$falign/;
	join('',"<BR>\n<DIV$fclass>\n"
	    , $_ , "\n<BR CLEAR=\"ALL\"></DIV><P></P>")
    } else { 
	join('', "<BR><P></P>\n<DIV$math_class>\n"
	    , $_ ."\n</DIV><BR CLEAR=\"ALL\"><P></P>");
    }
}

sub do_env_displaymath {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment) = ("display",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    local($halign) = " ALIGN=\"CENTER\"" unless $FLUSH_EQN;
    local($sbig,$ebig);
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 ));
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    if ($failed) {
	$_ = &process_undefined_environment("displaymath", $id, $saved);
	s/^[ \t]*\n?/\n/; s/\n?[ \t]*$/\n/; 
	$_ = (($comment.$labels)? "$comment$labels\n":''). $_;
    } else {
	s/^[ \t]*\n?/\n/; s/\n?[ \t]*$/\n/;
	$_ = (($comment.$labels)? "$comment$labels\n":'').$sbig.$_.$ebig;
    }
    if ($border||($attribs)) {
	join('',"<BR>\n<DIV$math_class>\n"
            , &make_table( $border, $attribs, '', '', '', $_ )
	    , "</DIV>\n<BR CLEAR=\"ALL\">");
    } else { 
        join('',"<BR><P></P>\n<DIV$math_class>",$_
            ,"</DIV><BR CLEAR=\"ALL\">\n<P></P>");
    }
}


### Multiline formulas

sub do_env_eqnarray {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment, $doimage) = ("equation",'','');
    local($attribs, $border);
    if (s/$htmlborder_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    elsif (s/$htmlborder_pr_rx//o) { $attribs = $2; $border = (($4)? "$4" : 1) }
    local($saved) = $_;
    local($sbig,$ebig,$falign) = ('','','CENTER');
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 ));
    local($valign) = join('', ' VALIGN="', 
	($NETSCAPE_HTML)? "BASELINE" : "MIDDLE", '"');
    $failed = 1; # simplifies the next call
    ($labels, $comment, $_) = &process_math_env($math_mode,$_);
    $failed = 0 unless ($no_eqn_numbers);
    if ((($failed)&&($NO_SIMPLE_MATH))
	||(/$htmlimage_rx|$htmlimage_pr_rx/)) {
#	||((/$htmlimage_rx|$htmlimage_pr_rx/)&&($& =~/thumb/))) {
	# image of whole environment, no equation-numbers
	$failed = 1;
	$falign = (($EQN_TAGS =~ /L/)? 'LEFT' : 'RIGHT')
	    unless $no_eqn_numbers;
	$_ = join ('', $comment
	    , &process_undefined_environment(
		"eqnarray".(($no_eqn_numbers) ? "star" : '')
		, $id, $saved));
	local($fclass) = $math_class;
	$fclass =~ s/(ALIGN=\")[^"]*/$1$falign/;
	$_ = join('',"<P></P><DIV$fclass>"
	    , $_, "</DIV><BR CLEAR=\"ALL\"><P></P>\n");
    } else {
	$failed = 0;
	s/$htmlimage_rx/$doimage = $&;''/eo ; # force an image
	s/$htmlimage_pr_rx/$doimage .= $&;''/eo ; # force an image
	local($sarray, $srow, $slcell, $elcell, $srcell, $ercell, $erow, $earray);
	($sarray, $elcell, $srcell, $erow, $earray, $sempty) = ( 
	    "\n<TABLE$env_id$lang CELLPADDING=\"0\" ALIGN=\"CENTER\""
	    , "</TD>\n<TD ALIGN=\"CENTER\" NOWRAP>"
	    , "</TD>\n<TD ALIGN=\"LEFT\" NOWRAP>"
	    , "</TD></TR>", "\n</TABLE>", "</TD>\n<TD>" );
	$env_id = '';
	$sarray .= (($no_eqn_numbers) ? ">" :  " WIDTH=\"100%\">" );
	local($seqno) = join('',"\n<TD$eqno_class WIDTH=10 ALIGN=\""
		, (($EQN_TAGS =~ /L/)? 'LEFT': 'RIGHT')
		, "\">\n");
	if ($EQN_TAGS =~ /L/) { # number on left
	    ($srow, $slcell, $ercell) = (
		"\n<TR$valign>" . $seqno
		, "</TD>\n<TD NOWRAP ALIGN=", '');
	} else { # equation number on right
	    ($srow, $slcell, $ercell) = ("\n<TR$valign>"
		, "<TD NOWRAP ALIGN="
		, '</TD>'. $seqno );
	}

	$_ = &protect_array_envs($_);

	local(@rows,@cols,$eqno,$return,$thismath,$savemath);
	s/\\\\[ \t]*\[[^\]]*]/\\\\/g; # remove forced line-heights
	@rows = split(/\\\\/);
	$#rows-- if ( $rows[$#rows] =~ /^\s*$/ );
	$return = join(''
	    , (($border||($attribs))? '': "<BR>")
	    , (($doimage)? '' : "\n<DIV ALIGN=\"CENTER\">")
	    , (($labels)? $labels : "\n") , $comment, $sarray);
	foreach (@rows) { # displaymath
	    $eqno = '';
	    do { 
		$global{'eqn_number'}++ ;
		$eqno = &simplify(&translate_commands('\theequation'));
	    } unless ((s/\\nonumber//)||($no_eqn_numbers));
	    if (/\\tag(\*)?/){
		if (defined &get_eqn_number) {
		    # AmS-TEX line-number tags.
		    ($eqno, $_) = &get_eqn_number(1,$_);
		} else {
		    s/\\tag(\*)?//;
		    local($nobrack,$before) = ($1,$`);
		    $_ = $';
		    s/next_pair_pr_rx//o;
		    if ($nobrack) { $eqno = $2 }
		    else { $eqno = join('',$EQNO_START,$2,$EQNO_END) }
		    $_ = $before;
		}
	    } elsif ($eqno) {
		$eqno = join('',$EQNO_START, $eqno, $EQNO_END)
	    } else { $eqno = '&nbsp;' } # spacer, when no numbering

	    $return .= $srow;
	    $return .= $eqno if ($EQN_TAGS =~ /L/);
	    $return .= $slcell;
#	    if (s/\\lefteqn$OP(\d+)$CP(.*)$OP\1$CP/ $2 /) {
	    if (s/\\lefteqn//) {
		$return .= "\"LEFT\" COLSPAN=\"3\">";
		s/(^\s*|$html_specials{'&'}|\s*$)//gm;
		if (($NO_SIMPLE_MATH)||($doimage)||($failed)) {
		    $_ = (($_)? &process_math_in_latex(
		        "indisplay" , '', '', $doimage.$_ ):'');
		    $return .= join('', $_, $erow) if ($_);
		} elsif ($_ ne '') {
		    $savemath = $_; $failed = 0;
		    $_ = &simple_math_env($_);
		    if ($failed) {
			$_ = &process_math_in_latex(
			    "indisplay",'','',$savemath);
			$return .= join('', $_, $erow) if ($_);
		    } elsif ($_ ne '') {
			$return .= join('', $sbig, $_, $ebig, $erow)
		    }
		}
		$return .= join('',";SPMnbsp;", $erow) if ($_ eq ''); 
		next;
	    }

	    # columns to be set using math-modes
	    @cols = split(/$html_specials{'&'}/o);

	    # left column, set using \displaystyle
	    $thismath = shift(@cols); $failed = 0;
	    $thismath =~ s/(^\s*|\s*$)//gm;
	    if (($NO_SIMPLE_MATH)||($doimage)||($failed)) {
		$thismath = (($thismath ne '')? &process_math_in_latex(
		    "indisplay" , '', '', $doimage.$thismath ):'');
		$return .= join('',"\"RIGHT\">",$thismath) if ($thismath ne '');
	    } elsif ($thismath ne '') { 
		$savemath = $thismath;
		$thismath = &simple_math_env($thismath);
		if ($failed) {
		    $thismath = &process_math_in_latex(
			"indisplay",'','',$savemath);
		    $return .= join('',"\"RIGHT\">",$thismath)
		} elsif ($thismath ne '') {
		    $return .= join('',"\"RIGHT\">$sbig",$thismath,"$ebig")
		}
	    }
	    $return .= "\"RIGHT\">\&nbsp;" if ($thismath eq '');

	    # center column, set using \textstyle
	    $thismath = shift(@cols); $failed = 0;
	    $thismath =~ s/(^\s*|\s*$)//gm;
	    if (($NO_SIMPLE_MATH)||($doimage)||($failed)) {
		$thismath = (($thismath ne '')? &process_math_in_latex(
		    "indisplay" , 'text', '', $doimage.$thismath ):'');
		$return .= join('', $elcell, $thismath) if ($thismath ne '');
	    } elsif ($thismath ne '') { 
		$savemath = $thismath;
		$thismath = &simple_math_env($thismath);
		if ($failed) {
		    $thismath = &process_math_in_latex(
			"indisplay",'text','',$savemath);
		    $return .= join('', $elcell, $thismath)
		} elsif ($thismath ne '') {
		    $return .= join('', $elcell, $sbig , $thismath, $ebig)
		}
	    }
	    $return .= join('', $sempty,"\&nbsp;") if ($thismath eq '');

	    # right column, set using \displaystyle
	    $thismath = shift(@cols); $failed = 0;
	    $thismath =~ s/(^\s*|\s*$)//gm;
	    if (($NO_SIMPLE_MATH)||($doimage)||($failed)) {
		$thismath = (($thismath ne '')? &process_math_in_latex(
		    "indisplay" , '', '', $doimage.$thismath ):'');
		$return .= join('', $srcell, $thismath, $ercell)
		    if ($thismath ne '');
	    } elsif ($thismath ne '') {
		$savemath = $thismath;
		$thismath = &simple_math_env($thismath);
		if ($failed) {
		    $thismath = &process_math_in_latex(
			"indisplay",'','',$savemath);
		    $return .= join('', $srcell, $thismath, $ercell)
		} elsif ($thismath ne '') {
		    $return .= join('', $srcell, $sbig, $thismath, $ebig, $ercell)
		}
	    }
	    $return .= join('', $sempty, "\&nbsp;", $ercell) if ($thismath eq '');

	    $return .= $eqno unless ($EQN_TAGS =~ /L/);
	    $return .= $erow;
	}
	$_ = join('', $return , $earray, (($doimage)? '' : "</DIV>" ));
    }
    if ($border||($attribs)) { 
	join('' #,"<BR>\n<DIV$math_class>"
	    , &make_table( $border, $attribs, '', '', '', $_ )
	    , "\n</DIV><P></P><BR CLEAR=\"ALL\">");
    } else {
	join('', $_ ,"<BR CLEAR=\"ALL\"><P></P>");
    }
}

sub do_env_eqnarraystar {
    local($_) = @_;
    local($math_mode, $failed, $labels, $comment) = ("equation",'','');
    $failed = (/$htmlimage_rx|$htmlimage_pr_rx/); # force an image
    local($attribs, $border);
    local($saved) = $_;
    local($sbig,$ebig);
    ($sbig,$ebig) = ('<BIG>','</BIG>')
	if (($DISP_SCALE_FACTOR)&&($DISP_SCALE_FACTOR >= 1.2 ));

    if (($NO_SIMPLE_MATH)||($failed)) {
	local($no_eqn_numbers) = 1;
	$_ = &do_env_eqnarray($_) unless ($failed);
	if ($failed) {
	    if ($saved =~ s/$htmlborder_rx//o) {
		$attribs = $2; $border = (($4)? "$4" : 1)
	    } elsif ($saved =~ s/$htmlborder_pr_rx//o) {
		$attribs = $2; $border = (($4)? "$4" : 1)
	    }
	    $_ = join('', $labels
		, &process_undefined_environment("eqnarray*", $id, $saved));
	}
    } else {
	if (s/$htmlborder_rx//o) {
	    $attribs = $2; $border = (($4)? "$4" : 1)
	} elsif (s/$htmlborder_pr_rx//o) {
	    $attribs = $2; $border = (($4)? "$4" : 1)
	}
	$saved = $_;
	($labels, $comment, $_) = &process_math_env($math_mode,$_);
	if ($failed) {
	    $_ = join('', $labels
		, &process_undefined_environment("eqnarray*", $id, $saved));
	}
    }
    if ($border||($attribs)) { 
	join('' #,"<BR>\n<DIV$math_class>"
	    , &make_table( $border, $attribs, '', '', '', $_ )
	    , "\n</DIV><P></P><BR CLEAR=\"ALL\">");
    } elsif ($failed) {
	$_ =~ s/^[ \t]*\n?/\n/; 
	$_ =~ s/\n?[ \t]*/\n/;
	join('', "<BR><P></P>\n<DIV$math_class>"
	    , $_ ,"\n</DIV><P></P><BR CLEAR=\"ALL\">");
    } elsif ($_ =~ s!(</TABLE></DIV>)\s*(<BR[^>]*><P></P>)?\s*$!$1!si) {
	join('', $_ ,"<BR>\n");
    } elsif ($_ =~ m!<P></P>\s*$!si) { # below-display space present 
	$_
    } else {
	join('', $_ ,"<BR CLEAR=\"ALL\"><P></P>");
    }
}


$raw_arg_cmds{tabular} = 1;
$raw_arg_cmds{tabularstar} = 1;
$raw_arg_cmds{longtable} = 1;
$raw_arg_cmds{longtablestar} = 1;
$raw_arg_cmds{supertabular} = 1;
$raw_arg_cmds{supertabularstar} = 1;


#RRM: this package is automatically supported for {tabular} extensions
#     so suppress the warning message:
$styles_loaded{'array'} = 1;


&ignore_commands( <<_IGNORED_CMDS_);
extracolsep # {}
PreserveBackslash # {}
_IGNORED_CMDS_


&process_commands_wrap_deferred (<<_RAW_ARG_DEFERRED_CMDS_);
tablehead # {}
tabletail # {}
centerline # {}
leftline # {}
rightline # {}
_RAW_ARG_DEFERRED_CMDS_

1;

