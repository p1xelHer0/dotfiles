# command: "$HOME/dotfiles/conf/osx/ubersicht/widgets/nerdbar.widget/scripts/spotify"

refreshFrequency: 1000 # ms

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="/nerdbar.widget/colors.css" />
    <div class="color8"></div>
  """

style: """
  font: 14px GohuFont
  width: 100%
  top: 8px
  text-align: center
  text-transform: lowercase
  """
