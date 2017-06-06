command: "$HOME/.kwm/scripts/stats.sh"

refreshFrequency: 3000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='stats'></div>
  """

style: """
  -webkit-font-smoothing: antialiased
  font: 12px Fira Code
  text-transform: lowercase
  right: 155px
  top: 4px
  height: 16px
"""


getCPU: (cpu) ->
  cpuNum = parseFloat(cpu)
  cpuNum = cpuNum / 4
  cpuNum = cpuNum.toFixed(1)
  cpuString = String(cpuNum)
  if cpuNum < 10
    cpuString = '0' + cpuString
  return "<span class='color0B'>❖ </span><span class='color05'>#{cpuString}%</span>"

getMem: (mem) ->
  memNum = parseFloat(mem)
  memNum = memNum.toFixed(1)
  memString = String(memNum)
  if memNum < 10
    memString = '0' + memString

  return "<span class='color0C'>✱ </span><span class='color05'>#{memString}%</span>"

convertBytes: (bytes) ->
  kb = bytes / 1024
  return @usageFormat(kb)

usageFormat: (kb) ->
    mb = kb / 1024
    "#{parseFloat(mb.toFixed(2))}MB"

getNetTraffic: (down, up) ->
  downString = @convertBytes(parseInt(down))
  upString = @convertBytes(parseInt(up))
  return "<span><span class='color0B'>▼ </span><span class='color05'>#{downString} </span></span><span class='color08'>▲ </span><span class='color05'>#{upString}</span>"

getFreeSpace: (space) ->
  return "<span class='color0E'></span><span class='color05'>#{space}gb</span>"

update: (output, domEl) ->

  # split the output of the script
  values = output.split('@')

  cpu = values[0]
  mem = values[1]
  down = values[2]
  up   = values[3]
  free = values[4].replace(/[^0-9]/g,'')

  # create an HTML string to be displayed by the widget
  htmlString =  @getNetTraffic(down, up) + "<span> </span>" +
                @getMem(mem) + "<span> </span>" +
                @getCPU(cpu) + "<span> </span>" +
                @getFreeSpace(free)

  $(domEl).find('.stats').html(htmlString)

