command: "$HOME/dotfiles/conf/osx/ubersicht/widgets/nerdbar.widget/scripts/compstatus"

refreshFrequency: 3000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class="compstatus"></div>
  """

style: """
  font: 14px GohuFont
  text-transform: lowercase
  right: 5px
  top: 5px
  """

timeAndDate: (date, time) ->
  # returns a formatted html string with the date and time
  return "<span class='color8'>#{date} #{time} </span>"

batteryStatus: (battery, state) ->
  #returns a formatted html string current battery percentage, a representative icon and adds a lighting bolt if the
  # battery is plugged in and charging
  batnum = parseInt(battery)
  if state == 'AC' and batnum >= 90
    return "<span class='color8'>#{batnum}%+</span>"
  else if state == 'AC' and batnum >= 50 and batnum < 90
    return "<span class='color8'>#{batnum}%+</span>"
  else if state == 'AC' and batnum < 50 and batnum >= 15
    return "<span class='color8'>#{batnum}%+</span>"
  else if state == 'AC' and batnum < 15
    return "<span class='color2'>#{batnum}%+</span>"
  else if batnum >= 90
    return "<span class='color7'>#{batnum}%-</span>"
  else if batnum >= 50 and batnum < 90
    return "<span class='color7'>#{batnum}%-</span>"
  else if batnum < 50 and batnum >= 15
    return "<span class='color7'>#{batnum}%-</span>"
  else if batnum < 15
    return "<span class='color1'>#{batnum}%!</span>"

getWifiStatus: (status) ->
  if status == "Wi-Fi"
    return "<span class='color3'>wifi<span>"
  if status == 'USB 10/100/1000 LAN' or status == 'Apple USB Ethernet Adapter'
    return "<span class='color3'>ethernet</span>"
  else
    return "<span class='color7'>#{status}</span>"

update: (output, domEl) ->

  # split the output of the script
  values = output.split('@')

  time = values[0].replace /^\s+|\s+$/g, ""
  date = values[1]
  battery = values[2]
  isCharging = values[3]
  netStatus = values[4].replace /^\s+|\s+$/g, ""

  # create an HTML string to be displayed by the widget
  htmlString = @getWifiStatus(netStatus) + "<span> </span>" +
               @timeAndDate(date,time) + "<span> </span>" +
               @batteryStatus(battery, isCharging)

  $(domEl).find('.compstatus').html(htmlString)

