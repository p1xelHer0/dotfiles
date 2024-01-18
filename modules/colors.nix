{ lib, ... }:

with lib; {

  options.colors =
    let
      mkColorOption = name: {
        inherit name;
        value = mkOption {
          type = types.strMatching "#[a-fA-F0-9]{6}";
          description = "Color ${name}.";
        };
      };
    in
    listToAttrs (map mkColorOption [
      "fg"
      "bg"
      "con"
      "pro"
      "ok"
      "fg1"
      "fg2"
      "fg2"
      "fg3"
      "dim"
      "bg1"
      "bg2"
      "bg3"
      "bg4"
      "bg5"
    ]);
}
