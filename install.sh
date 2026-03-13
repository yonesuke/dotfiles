#!/bin/bash
# dotfiles install script for Linux / macOS
# Creates symbolic links from dotfiles to their expected locations.

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link() {
    src="$1"
    dest="$2"

    if [ -L "$dest" ]; then
        echo "[skip] $dest (symlink already exists)"
        return
    fi

    if [ -e "$dest" ]; then
        echo "[warn] $dest already exists and is not a symlink. Back it up manually."
        return
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "[ok]   $dest -> $src"
}

link "$DOTFILES_DIR/nvim"    "$HOME/.config/nvim"
link "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
link "$DOTFILES_DIR/yazi"    "$HOME/.config/yazi"

echo ""
echo "Done!"
