hs.hotkey.bind({ "cmd" }, "return", function()
  hs.applescript([[do shell script "open -n $HOME/.nix-profile/Applications/Alacritty.app"]])
end)
