#!/bin/bash

## Symlink Ubersicht and create the network.out file to display network data

# Symlink
ln -fs $HOME/dotfiles/conf/osx/ubersicht/WidgetSettings.json $HOME/Library/Application\ Support/tracesOf.Uebersicht/

# Create the network.out file
touch $HOME/dotfiles/conf/osx/ubersicht/widgets/nerdbar.widget/scripts/network.out
