{
  config,
  lib,
  pkgs,
  ...
}:

let
  webapps = [
    {
      name = "Copilot";
      url = "https://github.com/copilot";
      icon = "https://raw.githubusercontent.com/gilbarbara/logos/refs/heads/main/logos/github-copilot.svg";
    }
    {
      name = "Excalidraw";
      url = "https://excalidraw.com";
      icon = "https://avatars.githubusercontent.com/u/59452120?s=48&v=4";
    }
  ];

  mkDesktopFile = app: ''
    mkdir -p "${config.xdg.dataHome}/applications" "${config.xdg.dataHome}/icons"

    safeName="$(echo "${app.name}" | tr ' ' '_' | tr -cd '[:alnum:]_.-')"
    desktopPath="${config.xdg.dataHome}/applications/$safeName.desktop"
    iconDest="${config.xdg.dataHome}/icons/$safeName.png"

    if echo "${app.icon}" | grep -qE '^https?://'; then
      if [ ! -f "$iconDest" ]; then
        ${pkgs.curl}/bin/curl -fsSL "${app.icon}" -o "$iconDest" || rm -f "$iconDest"
      fi
      iconPath="$iconDest"
    else
      iconPath="${app.icon}"
    fi

    cat > "$desktopPath" <<EOF
    [Desktop Entry]
    Name=${app.name}
    Exec=brave --app='${app.url}'
    Icon=$iconPath
    Type=Application
    Categories=Network;WebBrowser;
    EOF

    chmod 644 "$desktopPath"
  '';

in
{
  home.activation.webapps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${lib.concatStringsSep "\n" (map mkDesktopFile webapps)}
  '';
}
