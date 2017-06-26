command: "$HOME/dotfiles/conf/osx/ubersicht/widgets/nerdbar.widget/scripts/stats.sh"

refreshFrequency: 3000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='stats'></div>
  """

style: """
  font: 14px GohuFont
  text-transform: lowercase
  left: 5px
  top: 5px
  height: 14px
"""


getCPU: (cpu) ->
  cpuNum = parseFloat(cpu)
  cpuNum = cpuNum / 4
  cpuNum = cpuNum.toFixed(1)
  cpuString = String(cpuNum)
  if cpuNum < 10
    cpuString = '0' + cpuString
  return "<span class='color08'>#{cpuString}%<span class='color03'>cpu</span></span>"

getMem: (mem) ->
  memNum = parseFloat(mem)
  memNum = memNum.toFixed(1)
  memString = String(memNum)
  if memNum < 10
    memString = '0' + memString

  return "<span class='color08'>#{memString}%</span><span class='color03'>ram</span>"

convertBytes: (bytes) ->
  kb = bytes / 1024
  return @usageFormat(kb)

usageFormat: (kb) ->
    mb = kb / 1024
    "#{parseFloat(mb.toFixed(2))}MB"

getNetTraffic: (down, up) ->
  downString = @convertBytes(parseInt(down))
  upString = @convertBytes(parseInt(up))
  return "<span class='color08'>#{downString}</span><span class='color05'>down</span> <span class='color08'>#{upString}</span><span class='color02'>up</span>"

getFreeSpace: (space) ->
  return "<span class='color08'></span><span class='color08'>#{space}gb</span>"

update: (output, domEl) ->

  # split the output of the script
  values = output.split('@')

  cpu = values[0]
  mem = values[1]
  down = values[2]
  up   = values[3]
  free = values[4].replace(/[^0-9]/g,'')

  # create an HTML string to be displayed by the widget
  htmlString =  "<span class='color08'>█▓░</span> " + @getNetTraffic(down, up) + "<span> </span>" +
                @getMem(mem) + "<span> </span>" +
                @getCPU(cpu) + "<span> </span>" +
                @getFreeSpace(free)

  $(domEl).find('.stats').html(htmlString)

