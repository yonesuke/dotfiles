#!/bin/bash
# dotfiles install script for Linux / macOS
# Creates symbolic links from dotfiles to their expected locations.

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

declare -A links
# source (dotfiles)        => target (system location)
links["$DOTFILES_DIR/nvim"]="$HOME/.config/nvim"
links["$DOTFILES_DIR/wezterm"]="$HOME/.config/wezterm"
links["$DOTFILES_DIR/yazi"]="$HOME/.config/yazi"

for src in "${!links[@]}"; do
    dest="${links[$src]}"

    if [ -L "$dest" ]; then
        echo "[skip] $dest (symlink already exists)"
        continue
    fi

    if [ -e "$dest" ]; then
        echo "[warn] $dest already exists and is not a symlink. Back it up manually."
        continue
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "[ok]   $dest -> $src"
done

echo ""
echo "Done!"
