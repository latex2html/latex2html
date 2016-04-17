### File: lang.pl
### Version 0.1,  October 25, 1997
### Written by Ross Moore <ross@mpce.mq.edu.au>
###
### ISO_639 languages information
###
### extracted from  i18n.pl  contains...

### Language definitions for HTML 2.1 (I18N, Internationalization)
### Written by Marcus E. Hennecke <marcush@leland.stanford.edu>
### Version 0.3,  March 6, 1996
### Version 0.2,  February 2, 1996

## Copyright (C) 1995 by Marcus E. Hennecke
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# $DOCTYPE = '-//IETF//DTD HTML i18n';

#sub do_cmd_oe {
#    join('', &iso_map("oe", "lig"), $_[0]);}
#sub do_cmd_OE {
#    join('', &iso_map("OE", "lig"), $_[0]);}
#sub do_cmd_l {
#    join('', &iso_map("l", "strok"), $_[0]);}
#sub do_cmd_L {
#    join('', &iso_map("L", "strok"), $_[0]);}
#sub do_cmd_ng {
#    join('', &iso_map("eng", ""), $_[0]);}

# Language codes as defined by ISO 639
# http://www.ics.uci.edu/pub/ietf/http/related/iso639.txt
%iso_languages
     = (
	'afar'		=> 'aa',
	'abkhazian'	=> 'ab',
	'afrikaans'	=> 'af',
	'amharic'	=> 'am',
	'arabic'	=> 'ar',
	'assamese'	=> 'as',
	'aymara'	=> 'ay',
	'azerbaijani'	=> 'az',
	'bashkir'	=> 'ba',
	'byelorussian'	=> 'be',
	'bulgarian'	=> 'bg',
	'bihari'	=> 'bh',
	'bislama'	=> 'bi',
	'bengali'	=> 'bn',
	'bangla'	=> 'bn',
	'tibetan'	=> 'bo',
	'breton'	=> 'br',
	'catalan'	=> 'ca',
	'corsican'	=> 'co',
	'czech'		=> 'cs',
	'welsh'		=> 'cy',
	'danish'	=> 'da',
	'german'	=> 'de',
	'austrian'	=> 'de-AT',
	'swiss german'	=> 'de-CH',
	'bhutani'	=> 'dz',
	'greek'		=> 'el',
	'english'	=> 'en',
	'original'	=> 'en',
	'UKenglish'	=> 'en-UK',
	'USenglish'	=> 'en-US',
	'esperanto'	=> 'eo',
	'spanish'	=> 'es',
	'argentinian'	=> 'es-AR',
	'colombian'	=> 'es-CO',
	'mexican'	=> 'es-MX',
	'estonian'	=> 'et',
	'basque'	=> 'eu',
	'persian'	=> 'fa',
	'finnish'	=> 'fi',
	'fiji'		=> 'fj',
	'faeroese'	=> 'fo',
	'french'	=> 'fr',
	'french-belgian'	=> 'fr-BE',
	'french canadian'	=> 'fr-CA',
	'swiss french'	=> 'fr-CH',
	'frisian'	=> 'fy',
	'irish'		=> 'ga',
	'scots gaelic'	=> 'gd',
	'galician'	=> 'gl',
	'guarani'	=> 'gn',
	'gujarati'	=> 'gu',
	'hausa'		=> 'ha',
	'hindi'		=> 'hi',
	'croatian'	=> 'hr',
	'hungarian'	=> 'hu',
	'armenian'	=> 'hy',
	'interlingua'	=> 'ia',
	'interlingue'	=> 'ie',
	'inupiak'	=> 'ik',
	'indonesian'	=> 'id',
# ?	'indonesian'	=> 'in',
	'icelandic'	=> 'is',
	'italian'	=> 'it',
	'hebrew'	=> 'iw',
	'japanese'	=> 'ja',
	'yiddish'	=> 'ji',
	'javanese'	=> 'jw',
	'georgian'	=> 'ka',
	'kazakh'	=> 'kk',
	'greenlandic'	=> 'kl',
	'cambodian'	=> 'km',
	'kannada'	=> 'kn',
	'korean'	=> 'ko',
	'kashmiri'	=> 'ks',
	'kurdish'	=> 'ku',
	'kirghiz'	=> 'ky',
	'latin'		=> 'la',
	'lingala'	=> 'ln',
	'laothian'	=> 'lo',
	'lithuanian'	=> 'lt',
	'latvian'	=> 'lv',
	'lettish'	=> 'lv',
	'malagasy'	=> 'mg',
	'maori'		=> 'mi',
	'macedonian'	=> 'mk',
	'malayalam'	=> 'ml',
	'mongolian'	=> 'mn',
	'moldavian'	=> 'mo',
	'marathi'	=> 'mr',
	'malay'		=> 'ms',
	'maltese'	=> 'mt',
	'burmese'	=> 'my',
	'nauru'		=> 'na',
	'nepali'	=> 'ne',
	'dutch'		=> 'nl',
	'belgian'		=> 'nl-BE',
	'norwegian'	=> 'no',
	'occitan'	=> 'oc',
	'afan'		=> 'om',
	'oromo'		=> 'om',
	'oriya'		=> 'or',
	'punjabi'	=> 'pa',
	'polish'	=> 'pl',
	'pashto'	=> 'ps',
	'pushto'	=> 'ps',
	'portuguese'	=> 'pt',
	'brazilian'	=> 'pt-BR',
	'quechua'	=> 'qu',
	'rhaeto-romance'=> 'rm',
	'kirundi'	=> 'rn',
	'romanian'	=> 'ro',
	'russian'	=> 'ru',
	'kinyarwanda'	=> 'rw',
	'sanskrit'	=> 'sa',
	'sindhi'	=> 'sd',
	'sangro'	=> 'sg',
	'serbo-croatian'=> 'sh',
	'singhalese'	=> 'si',
	'slovak'	=> 'sk',
	'slovenian'	=> 'sl',
	'samoan'	=> 'sm',
	'shona'		=> 'sn',
	'somali'	=> 'so',
	'albanian'	=> 'sq',
	'serbian'	=> 'sr',
	'siswati'	=> 'ss',
	'sesotho'	=> 'st',
	'sundanese'	=> 'su',
	'swedish'	=> 'sv',
	'swahili'	=> 'sw',
	'tamil'		=> 'ta',
	'telugu'	=> 'te',
	'tajik'		=> 'tg',
	'thai'		=> 'th',
	'tigrinya'	=> 'ti',
	'turkmen'	=> 'tk',
	'tagalog'	=> 'tl',
	'setswana'	=> 'tn',
	'tonga'		=> 'to',
	'turkish'	=> 'tr',
	'tsonga'	=> 'ts',
	'tatar'		=> 'tt',
	'twi'		=> 'tw',
	'ukrainian'	=> 'uk',
	'urdu'		=> 'ur',
	'uzbek'		=> 'uz',
	'vietnamese'	=> 'vi',
	'volapuk'	=> 'vo',
	'wolof'		=> 'wo',
	'xhosa'		=> 'xh',
	'yoruba'	=> 'yo',
	'chinese'	=> 'zh',
	'CNchinese'	=> 'zh-CN',
	'taiwanese'	=> 'zh-TW',
	'zulu'		=> 'zu'
	);


1;
