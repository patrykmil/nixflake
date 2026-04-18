{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "unstore" ''
      #!/usr/bin/env bash
      FILE="$1"
      BACKUP="''${FILE}.bak"

      cp "$FILE" "$BACKUP"
      rm "$FILE"
      cp "$BACKUP" "$FILE"
      chmod +w "$FILE"
    '')
  ];
}
