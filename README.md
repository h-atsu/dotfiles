# dotfiles

nix-darwin + home-manager によるmacOS環境管理

## ディレクトリ構成

```
dotfiles/
├── flake.nix                  # エントリーポイント
├── modules/
│   ├── darwin/
│   │   ├── default.nix        # システムパッケージ、ユーザー設定
│   │   └── system.nix         # macOS設定（Dock, Finder, キーリピート等）
│   └── home/
│       ├── default.nix        # home-managerエントリーポイント
│       ├── wezterm.nix        # WezTermのインストール＋設定
│       └── emacs.nix          # Emacsのインストール＋設定
└── config/
    ├── wezterm/
    │   └── wezterm.lua        # WezTerm設定ファイル
    └── emacs/
        └── init.el            # Emacs設定ファイル
```

## 初回セットアップ

### 前提条件

- [Determinate Nix](https://determinate.systems/nix/) がインストール済みであること
- `nix-command` と `flakes` が有効であること（Determinate Nixはデフォルトで有効）

### 初回適用

nix-darwin が未インストールの状態から適用する場合:

```bash
cd ~/dotfiles
sudo nix run nix-darwin -- switch --flake .
```

> ホスト名（`HadanoMacBook-Air`）を自動検出するため `#HadanoMacBook-Air` は省略できます。

## 日常的な使い方

設定を変更した後は以下のコマンドで適用します:

```bash
cd ~/dotfiles
darwin-rebuild switch --flake .
```

### よく使うコマンド

| コマンド | 説明 |
|---|---|
| `darwin-rebuild switch --flake .` | 設定を適用 |
| `darwin-rebuild check --flake .` | 適用前に構文チェック |
| `nix flake update` | すべての入力を最新に更新 |
| `nix flake update nixpkgs` | nixpkgsだけ更新 |

## 設定の追加方法

### 新しいアプリをhome-managerで管理する場合

1. `modules/home/` に `<app>.nix` を作成
2. `modules/home/default.nix` の `imports` に追加
3. `darwin-rebuild switch` で適用

例: `modules/home/git.nix`

```nix
{ ... }: {
  programs.git = {
    enable = true;
    userName = "atsu";
    userEmail = "your@email.com";
  };
}
```

### macOSシステム設定を変更する場合

`modules/darwin/system.nix` を編集します。利用できるオプションは以下で確認:

```bash
darwin-rebuild --help
# または
man 5 configuration.nix
```

## トラブルシューティング

### ロールバック

適用した設定を直前の世代に戻す:

```bash
darwin-rebuild rollback
```

世代の一覧を確認する:

```bash
nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### nix-darwin を完全に削除する場合

```bash
nix run nix-darwin -- uninstall
```
