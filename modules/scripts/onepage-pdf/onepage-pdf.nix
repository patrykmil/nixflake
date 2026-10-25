{ pkgs, ... }:
let
  python = pkgs.python3.withPackages (ps: [ ps.markdown ]);
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "onepage-pdf" ''
      export NODE_PATH="${pkgs.puppeteer-cli}/lib/node_modules/puppeteer-cli/node_modules"
      export PUPPETEER_EXECUTABLE_PATH="${pkgs.chromium}/bin/chromium"
      export MARKDOWN_PYTHON="${python}/bin/python3"
      exec "${pkgs.nodejs}/bin/node" "${./onepage-pdf.cjs}" "$@"
    '')
  ];
}
