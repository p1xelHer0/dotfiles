#!/bin/sh
# base16-shell
# see: https://github.com/chriskempson/base16-shell

# this script doesn't support linux console (use 'vconsole' template instead)
if [ "${TERM%%-*}" = 'linux' ]; then
    return 2>/dev/null || exit 0
fi

color00="28/28/28" # base 00 - default background
color18="3e/3d/38" # base 01 - lighter background (Used for status bars)
color19="53/51/47" # base 02 - selection background
color08="69/66/57" # base 03 - comments, invisibles, line highlighting
color20="7e/7a/66" # base 04 - dark foreground (used for status bars)
color07="fd/f3/c0" # base 05 - default foreground, caret, delimiters, operators

color21="fe/f7/d1" # base 06 - light foreground (not often used)
color15="fe/fa/e0" # base 07 - light background (not often used)

color01="ce/98/3f" # base 08 - variables, XML tags, markup link text, markup lists, diff deleted
color16="ce/6e/3f" # base 09 - integers, boolean, constants, XML attributes, markup link url
color03="83/a5/98" # base 0A - classes, markup bold, search text background
color02="a6/b6/57" # base 0B - strings, inherited class, markup code, diff inserted
color06="58/87/78" # base 0C - support, regular expressions, escape characters, markup quotes
color04="7a/92/5d" # base 0D - functions, methods, attribute IDs, headings
color05="ce/98/3f" # base 0E - keywords, storage, selector, markup italic, diff changed
color17="ce/6e/3f" # base 0F - deprecated, opening/closing embedded language tags e.g. <?php ?>

color09=$color01 # base 08
color10=$color02 # base 0B
color11=$color03 # base 0A
color12=$color04 # base 0D
color13=$color05 # base 0E
color14=$color06 # base 0C

color_foreground="fd/f3/c0" # base 05
color_background="28/28/28" # base 00
color_cursor="fd/f3/c0"     # base 05

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # see: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324
  printf_template='\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\'
  printf_template_var='\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\'
  printf_template_custom='\033Ptmux;\033\033]%s%s\033\033\\\033\\'
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template='\033P\033]4;%d;rgb:%s\033\\'
  printf_template_var='\033P\033]%d;rgb:%s\033\\'
  printf_template_custom='\033P\033]%s%s\033\\'
else
  printf_template='\033]4;%d;rgb:%s\033\\'
  printf_template_var='\033]%d;rgb:%s\033\\'
  printf_template_custom='\033]%s%s\033\\'
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg fdf3c0 # foreground
  printf $printf_template_custom Ph 282828 # background
  printf $printf_template_custom Pi fdf3c0 # bold color
  printf $printf_template_custom Pj fdf3c0 # selection color
  printf $printf_template_custom Pk 282828 # selected text color
  printf $printf_template_custom Pl fdf3c0 # cursor
  printf $printf_template_custom Pm 282828 # cursor text
else
  printf $printf_template_var 10 $color_foreground
  printf $printf_template_var 11 $color_background
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
unset color_cursor
