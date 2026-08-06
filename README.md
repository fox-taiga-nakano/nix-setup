# nix-setup

NixOS-WSL / Home Manager / chezmoi(Windows・WSL共通dotfiles) / 初期セットアップスクリプトを1つのGitリポジトリで管理します。

## ディレクトリ構成

```text
~/projects/nix-setup/
├── .chezmoiroot
├── .gitignore
├── README.md
├── mise.toml
│
├── bootstrap/
│   ├── windows/
│   │   └── install-windows-apps.ps1
│   └── wsl/
│       └── download-nixos-wsl.sh
│
├── assets/
│   └── .gitignore
│
├── nix/
│   ├── flake.nix
│   ├── flake.lock
│   ├── hosts/
│   │   └── wsl/
│   │       └── configuration.nix
│   ├── home/
│   │   └── taiga/
│   │       └── home.nix
│   └── modules/
│       ├── nixos/
│       └── home-manager/
│
└── chezmoi/
    ├── .chezmoi.toml.tmpl
    ├── .chezmoiignore
    ├── .chezmoiscripts/
    ├── dot_gitconfig.tmpl
    ├── Documents/
    │   └── PowerShell/
    │       └── Microsoft.PowerShell_profile.ps1.tmpl
    ├── AppData/
    │   ├── Roaming/
    │   │   └── Code/
    │   │       └── User/
    │   │           └── settings.json
    │   └── Local/
    │       └── Packages/
    │           └── Microsoft.WindowsTerminal_8wekyb3d8bbwe/
    │               └── LocalState/
    │                   └── settings.json
    └── dot_config/
        └── wezterm/
            └── wezterm.lua.tmpl
```

## 管理範囲

| 対象                                        | 管理元              |
| ------------------------------------------- | -------------------- |
| NixOSサービス・ユーザー・システムパッケージ | `configuration.nix`  |
| WSLのユーザーパッケージ・Zsh・mise          | Home Manager         |
| Windows PowerShell設定                      | chezmoi              |
| Windows Terminal設定                        | chezmoi              |
| Windows VS Code設定                         | chezmoi              |
| Windowsアプリ                               | wingetスクリプト     |
| NixOS-WSLの導入                             | bootstrapスクリプト  |
| 操作コマンド                                | miseタスク           |

同じファイルをHome Managerとchezmoiの双方で管理しないこと（`.chezmoiignore`でOSごとに切り替える）。

## `.chezmoiroot`

リポジトリ直下の `.chezmoiroot` に `chezmoi` と書くことで、chezmoiのsource stateを `chezmoi/` サブディレクトリに限定しています。これにより `nix/` や `bootstrap/` がホームディレクトリへ反映されることはありません。

## 使い方

### 1. NixOS-WSL イメージをダウンロード

```bash
./bootstrap/wsl/download-nixos-wsl.sh
```

別ディレクトリに保存したい場合:

```bash
./bootstrap/wsl/download-nixos-wsl.sh /path/to/output-dir
```

実行後、`assets/nixos.wsl`（または指定先）に保存されます。

PowerShell からインストールする例:

```powershell
wsl --install --from-file ".\assets\nixos.wsl"
```

### 2. Windows アプリを一括インストール

PowerShell で実行:

```powershell
./bootstrap/windows/install-windows-apps.ps1
```

### 3. chezmoi をセットアップ(WSL / Windows 共通)

```bash
cd ~/projects/nix-setup
chezmoi init --source "$PWD"
chezmoi doctor
```

### 4. NixOS-WSL構成・dotfilesを反映(WSL)

```bash
mise run dotfiles:diff
mise run apply:wsl
```

### 5. dotfilesを反映(Windows)

```powershell
mise run apply:windows
```

## miseタスク一覧

- `dotfiles:diff` / `dotfiles:apply`: chezmoiの差分表示・反映
- `nix:check` / `nix:build` / `nix:switch` / `nix:update`: Nix Flakeの検査・構築・反映・更新
- `apply:wsl`: chezmoi反映 → flake検査 → NixOS-WSL反映を順番に実行
- `apply:windows`: Windows側のdotfilesを反映
