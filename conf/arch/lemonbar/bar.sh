#!/usr/bin/env dash

###

# -- lemonbar
# based on Dylan Araps bin/bar
# https://github.com/dylanaraps/bin/blob/master/bar


get_mon_width() {
    # get the monitor width
    local resolution

    type -p xrandr --nograb --current >/dev/null 2>&1 && \
      resolution="$(xrandr --nograb --current | \
                   awk -F 'x|\t' '/\*/ {print $1; exit}')"

    printf "%s\\n" "${resolution:-2560}"
}

ws() {
  # format workspace "blocks"
  local ws_bg
  local ws_fg

  # if focused
  if [ "$2" ]; then
    ws_bg="${color2}"
    ws_fg="${color0}"
  fi

  printf "%s%s%s\\n" "%{B${ws_bg:-${color3}}}" \
                     "%{F${ws_fg:-${color8}}}" \
                     "   ${1}   %{F-}%{B-}"
}

get_workspaces() {
  # get the current workspace
  local current_workspace
  local workspaces
  current_workspace="$(wmctrl -d | awk '/\*/ {print $NF}')"

  case "$current_workspace" in
    1) workspaces="$(ws 1 1)$(ws 2)$(ws 3)$(ws 4)$(ws 5)$(ws 6)" ;;
    2) workspaces="$(ws 1)$(ws 2 1)$(ws 3)$(ws 4)$(ws 5)$(ws 6)" ;;
    3) workspaces="$(ws 1)$(ws 2)$(ws 3 1)$(ws 4)$(ws 5)$(ws 6)" ;;
    4) workspaces="$(ws 1)$(ws 2)$(ws 3)$(ws 4 1)$(ws 5)$(ws 6)" ;;
    5) workspaces="$(ws 1)$(ws 2)$(ws 3)$(ws 4)$(ws 5 1)$(ws 6)" ;;
    6) workspaces="$(ws 1)$(ws 2)$(ws 3)$(ws 4)$(ws 5)$(ws 6 1)" ;;
  esac

  printf "%s\\n" "$workspaces"
}

get_date() {
  # get the date using printf's '%(T)' format
  printf "%s\\n" "$(date +"%a %d %b - %l:%M %p")"
}

get_local_ip() {
  # Get the local IP address.
  local local_ip
  local_ip="$(ip route get 1 | awk -F'src | uid' '{print $2; exit}')"
  printf "%s%s\\n" "%{B${color4}}%{F${color8}}" \
         "   local ip ${local_ip}   %{B-}%{F-}"
}

main() {
  local font
  local height
  local width
  local workspaces
  local date
  local local_ip

  source "${HOME}/.cache/wal/colors.sh"

  font="-gohu-gohufont-medium-r-normal--11-80-100-100-c-60-iso10646-1"
  height="30"
  width="$(get_mon_width)"
  local_ip="$(get_local_ip)"

  # loop and print the info
  while :; do
    workspaces="$(get_workspaces)"
    date="$(get_date)"

    printf "%s%s%b\\n" \
           "%{l}${workspaces}" \
           "%{c}${date}" \
           "%{r}${local_ip}"

    sleep .1s
  done |\

  # launch lemonbar
  lemonbar -g "${width}x${height}" \
           -B "${color0}" -F "${color8}"\
           -n "bar" -b -d  -f "$font"
}


main "$@"
