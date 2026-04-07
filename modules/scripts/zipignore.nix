{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "zipi" ''
      set -euo pipefail

      ZIP="${pkgs.zip}/bin/zip"

      if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "Usage: zipi <directory> [output.zip]"
        echo "Zips tracked files in a git repo or all files in a non-git directory,"
        echo ""
        exit 1
      fi

      REPO_DIR="$1"
      REPO_NAME=$(basename "$(realpath "$REPO_DIR")")
      OUTPUT_ZIP="''${2:-$REPO_NAME.zip}"

      if [ -n "''${2:-}" ]; then
        ZIP_DIR_NAME="''${2%.zip}"
      else
        ZIP_DIR_NAME="$REPO_NAME"
      fi

      TEMP_DIR=$(mktemp -d -t "$REPO_NAME-XXXXXX")
      trap 'rm -rf "$TEMP_DIR"' EXIT

      REPO_TEMP="$TEMP_DIR/$ZIP_DIR_NAME"
      mkdir -p "$REPO_TEMP"

      if [ -d "$REPO_DIR/.git" ]; then
        echo "Processing git repository: $REPO_NAME"

        cd "$REPO_DIR"

        FILE_COUNT=$(git ls-files | wc -l)
        echo "Found $FILE_COUNT tracked files"

        git ls-files | while IFS= read -r file; do
          cp --parents "$file" "$REPO_TEMP/"
        done
      else
        echo "Not a git repository, zipping all files: $REPO_NAME"

        cd "$REPO_DIR"

        FILE_COUNT=$(find . -type f | wc -l)
        echo "Found $FILE_COUNT files"

        find . -type f | while IFS= read -r file; do
          dest="$REPO_TEMP/$file"
          mkdir -p "$(dirname "$dest")"
          cp "$file" "$dest"
        done
      fi

      echo "Creating zip archive: $OUTPUT_ZIP"
      (cd "$TEMP_DIR" && "$ZIP" -r "$OLDPWD/$OUTPUT_ZIP" "$ZIP_DIR_NAME")

      echo "Done. Zip created: $OUTPUT_ZIP"
    '')
  ];
}
