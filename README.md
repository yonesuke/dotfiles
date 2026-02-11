# dotfiles

設定ファイルを管理するリポジトリです。

## 構成

```
dotfiles/
├── nvim/            # Neovim (LazyVim)
├── scoopfile.json   # Scoop パッケージ一覧
├── install.ps1      # Windows 用インストールスクリプト
├── install.sh       # Linux / macOS 用インストールスクリプト
└── README.md
```

| アプリ | Windows | Linux / macOS |
|--------|---------|---------------|
| nvim   | `%LOCALAPPDATA%\nvim` | `~/.config/nvim` |

## セットアップ

```sh
git clone https://github.com/yonesuke/dotfiles.git ~/dotfiles
```

### Linux / macOS

```sh
cd ~/dotfiles && bash install.sh
```

### Windows

管理者権限の PowerShell で実行:

```powershell
powershell -ExecutionPolicy Bypass -File ~/dotfiles/install.ps1
```

## TODO

- [ ] シェル設定 (`.bashrc` / `.zshrc` / PowerShell `$PROFILE`)
- [ ] ターミナル設定 (Windows Terminal / Alacritty 等)
- [ ] パッケージ管理 (Brewfile)
- [x] パッケージ管理 (scoop export)

## 設定の追加

1. `dotfiles/` 以下に設定フォルダを追加
2. 各 OS のインストールスクリプトにマッピングを追記
