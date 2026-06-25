# nix-setup

Windows + NixOS on WSL の初期セットアップを補助するためのスクリプト集です。

- `download-nixos-wsl.sh`: `nix-community/NixOS-WSL` の最新 `nixos.wsl` をダウンロード
- `install-windows-apps.ps1`: `winget` でよく使う Windows アプリを一括インストール

## ディレクトリ構成

```text
.
├─ download-nixos-wsl.sh
├─ install-windows-apps.ps1
└─ assets/
   └─ nixos.wsl
```

## 前提条件

### 共通

- インターネット接続

### `download-nixos-wsl.sh`

- Bash 実行環境（Git Bash / WSL など）
- `curl` または `wget`

### `install-windows-apps.ps1`

- Windows 10/11
- `winget` が利用可能であること
- PowerShell

## 使い方

## 1. NixOS-WSL イメージをダウンロード

プロジェクトルートで実行:

```bash
./download-nixos-wsl.sh
```

別ディレクトリに保存したい場合:

```bash
./download-nixos-wsl.sh /path/to/output-dir
```

実行後、`assets/nixos.wsl`（または指定先）に保存されます。

PowerShell からインストールする例:

```powershell
wsl --install --from-file ".\assets\nixos.wsl"
```

## 2. Windows アプリを一括インストール

PowerShell で実行:

```powershell
./install-windows-apps.ps1
```

スクリプト内の `winget` ID:

- `Google.Chrome`
- `Figma.Figma`
- `SlackTechnologies.Slack`
- `Raycast.Raycast`
- `AutoHotkey.AutoHotkey`
- `Docker.DockerDesktop`
- `Microsoft.VisualStudioCode`
- `Postman.Postman`
- `Microsoft.PowerToys`
- `Git.Git`
- `Logitech.GHUB`
- `Microsoft.VCRedist.2015+.x64`

## 補足

- 既にインストール済みのアプリは `winget` 側の判定によりスキップまたは失敗として表示される場合があります。
- 必要に応じて `install-windows-apps.ps1` 内のアプリ一覧を編集してください。
- 実行ポリシーの設定によっては、PowerShell 実行前にポリシー変更が必要な場合があります。
