let
  day = {
    fg = "#080807";
    bg = "#b5a488";
    con = "#bf9d88";
    pro = "#9da488";
    ok = "#d1a47f";
    fg1 = "#080807";
    fg2 = "#080807";
    fg3 = "#080807";
    dim = "#30302c";
    bg1 = "#0d0d0b";
    bg2 = "#121210";
    bg3 = "#1a1917";
    bg4 = "#242320";
    bg5 = "#2b2b27";
  };

  night = {
    fg = "#faeed7";
    bg = "#080807";
    con = "#23730";
    pro = "#585c4c";
    ok = "#30261b";
    fg1 = "#faeed7";
    fg2 = "#faeed7";
    fg3 = "#faeed7";
    dim = "#c9bfad";
    bg1 = "#f2e6d0";
    bg2 = "#ebdfca";
    bg3 = "#e3d7c3";
    bg4 = "#dbd0bd";
    bg5 = "#d4c9b6";
  };

in {
  imports = [ ../modules/colors.nix ];
  colors = night;
}
