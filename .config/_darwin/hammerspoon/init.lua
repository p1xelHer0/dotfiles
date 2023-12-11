hs.hotkey.bind({ "cmd" }, "return", function()
  hs.applescript(
    --   [[do shell script "open -n $HOME/.nix-profile/Applications/Alacritty.app --args --config-file $HOME/.config/alacritty/live.yml"]]
    [[do shell script "open -n $HOME/.nix-profile/Applications/Kitty.app"]]
  )
end)
