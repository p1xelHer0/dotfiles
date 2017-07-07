# https://superuser.com/questions/270214/how-can-i-change-the-colors-of-my-xterm-using-ansi-escape-sequences
colortest() {
  text='dank'

  printf "\n";

  for FG in {0..7}; do
    printf "\e[38;5;${FG}mcolor${FG} ";
    for BG in {0..7}; do
      printf " \e[38;5;${FG}m\e[48;5;${BG}m ${text} \e[0m";
    done

    printf "\n"

    printf "\e[1;38;5;${FG}mcolor${FG}\e[0m ";
    for BG in {0..7}; do
      printf " \e[1;38;5;${FG}m\e[48;5;${BG}m ${text} \e[0m";
    done

    printf "\n"
  done
}

colortest_small() {
  for BG in {0..7}; do
    printf "\e[48;5;${BG}m   ";
  done

  printf "\e[0m\n";
}
