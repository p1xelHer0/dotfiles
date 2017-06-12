command: "/usr/local/bin/kwmc query window focused name"

refreshFrequency: 2000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class='kwmmode'></div>
  """

style: """
  text-transform: lowercase
  text-align: center
  font: 14px GohuFont
  top: 5px
  width: 100%
"""

update: (output, domEl) ->
  file = ""
  screenhtml = ""
  wins = output
  win = ""
  i = 0
  winseg = wins.split('/')
  file = winseg[winseg.length - 1]
  j = winseg.length - 1
  flag = 0

  if j > 1
    while j >= 1
      j -= 1
      if (win + file).length >= 65
        win = '…/' + win
        break
      else
        win = winseg[j] + '/' + win

   while file.length >= 65
    file = file.slice(0, -1)
    flag = 1

   if flag >= 1
     file = file + '…'


  $(domEl).find('.kwmmode').html("<span class='color06'>░▓</span><span class='color07bg'> #{win}</span><span class='color06bg'> #{file}</span><span class='color06'>▓░</span>")
