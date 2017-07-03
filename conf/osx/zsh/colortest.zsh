# https://superuser.com/questions/270214/how-can-i-change-the-colors-of-my-xterm-using-ansi-escape-sequences
colortest() {
  text='•‿•'
  printf "base   ";
  for base in 00 01 02 03 04 05 06 07 08 09 '0A' '0B' '0C' '0D' '0E' '0F'; do
    printf "   ${base}  ";
  done
  printf "\n";
  for FG in 00 18 19 08 20 07 21 15 01 16 03 02 06 04 05 17; do
    printf "\e[38;5;${FG}mcolor${FG}\e[0m ";
    for BG in 00 18 19 08 20 07 21 15 01 16 03 02 06 04 05 17; do
      printf " \e[38;5;${FG}m\e[48;5;${BG}m ${text} \e[0m ";
    done
    printf "\n"

    printf "\e[1;38;5;${FG}mcolor${FG}\e[0m ";
    for BG in 00 18 19 08 20 07 21 15 01 16 03 02 06 04 05 17; do
      printf " \e[1;38;5;${FG}m\e[48;5;${BG}m ${text} \e[0m ";
    done
    printf "\n"
  done
}

colortest_small() {
  declare -a colors=( 00 07 01 16 03 02 06 04 05 17 )
  for (( i = 1; i <= ${#colors[*]}; ++ i )); do
    printf "\e[38;5;${colors[i]}m\e[48;5;${colors[i+1]}m█▓░\e[0m";
  done
  printf "\n";
}
