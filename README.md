# dotfiles

nix-darwin + home-manager によるmacOS環境管理

## ディレクトリ構成

```
dotfiles/
├── flake.nix                  # エントリーポイント
├── setup.sh                   # 初回bootstrap
└── nix/
    ├── hosts/
    │   └── macbook/           # ホストごとの構成入口
    ├── darwin/                # macOS全体の設定
    │   ├── default.nix
    │   ├── system.nix         # Dock, Finder, キーリピート等
    │   ├── users.nix
    │   ├── nix.nix            # Determinate Nixとの責務分担
    │   └── homebrew.nix       # GUIアプリのHomebrew cask
    ├── home/                  # home-managerの土台
    ├── cli/                   # CLIツールをツール単位で管理
    └── apps/                  # GUIアプリをアプリ単位で管理
        ├── wezterm/
        │   ├── default.nix
        │   └── wezterm.lua
        └── emacs/
            ├── default.nix
            └── init.el
```

## 初回セットアップ

### bootstrap

Homebrew と Determinate Nix が未インストールの場合は `setup.sh` がインストールし、そのまま nix-darwin を適用します。

```bash
cd ~/dotfiles
./setup.sh
```

`HOST` を指定すると別の flake output を適用できます。

```bash
HOST=macbook ./setup.sh
```

### 初回適用

手動で nix-darwin を適用する場合:

```bash
cd ~/dotfiles
sudo nix run nix-darwin -- switch --flake '.#macbook'
```

> `darwinConfigurations` 名を `macbook` にしているので、`#macbook` を明示して適用します。

## 日常的な使い方

設定を変更した後は以下のコマンドで適用します:

```bash
sudo darwin-rebuild switch --flake "$HOME/dotfiles#macbook"
```

### アプリ設定の運用

各アプリのディレクトリに設定ファイルを同居させ、Home Manager が `~/.config` や `~/.emacs.d` に配置します。
GUI アプリ本体も `nix/apps/<app>/default.nix` で Homebrew cask 経由でインストールします。
CLI ツールは `nix/cli/<tool>/default.nix` で管理します。
言語ランタイムやプロジェクト依存のCLIは mise で管理し、global tools は `nix/cli/mise/config.toml` に宣言します。

- `nix/apps/wezterm/wezterm.lua` → `~/.config/wezterm/wezterm.lua`
- `nix/apps/emacs/init.el` → `~/.emacs.d/init.el`

そのため、普段の試行錯誤は `nix/apps/<app>/` 配下のファイルを直接編集するのが基本です。
WezTerm のようにリロードできるアプリは、設定を編集してすぐ見た目を確認できます。

新しいファイルを追加したり、配置先を変えたりした場合は `sudo darwin-rebuild switch --flake "$HOME/dotfiles#macbook"` を実行してください。

### よく使うコマンド

| コマンド | 説明 |
|---|---|
| `mise install` | `~/.config/mise/config.toml` に宣言したツールをインストール |
| `pre-commit run --all-files` | formatter / lintを手動実行 |
| `nix flake check` | flake評価を検証 |
| `sudo darwin-rebuild switch --flake "$HOME/dotfiles#macbook"` | 設定を適用 |
| `darwin-rebuild check --flake "$HOME/dotfiles#macbook"` | 適用前に構文チェック |
| `nix flake update` | すべての入力を最新に更新 |
| `nix flake update nixpkgs` | nixpkgsだけ更新 |

### pre-commit

pre-commit hooks は `.pre-commit-config.yaml` で管理しています。
初回、または hook を入れ直したい場合:

```bash
pre-commit install
```

現在の hook は以下を実行します:

- `alejandra`
- `deadnix`
- `statix`

これらのNix用formatter/linterは `flake.nix` の devShell で管理し、hook実行時に `nix develop -c ...` 経由で呼び出します。
GitHub Actions では `nix flake check --print-build-logs` と `pre-commit run --all-files` を実行します。

## 設定の追加方法

### 新しいアプリをhome-managerで管理する場合

1. `nix/apps/<app>/default.nix` を作成
2. 設定ファイルがある場合は同じディレクトリに置く
3. `nix/apps/default.nix` の `imports` に追加
4. GUIアプリ本体が必要な場合は同じ `default.nix` に cask を追加
5. `sudo darwin-rebuild switch --flake "$HOME/dotfiles#macbook"` で適用

例: `nix/apps/example/default.nix`

```nix
{ ... }: {
  homebrew.casks = [
    "example"
  ];

  home-manager.users.atsu = {
    xdg.configFile."example/config.toml".source = ./config.toml;
  };
}
```

### 新しいCLIツールを管理する場合

`nix/cli/<tool>/default.nix` を作成して、`nix/cli/default.nix` の `imports` に追加します。
ただし、Node.js / Python / Rust などの言語ランタイムや、プロジェクトごとにバージョンを揃えたい CLI は mise 側で管理します。

mise の global tool を追加する場合は `nix/cli/mise/config.toml` を編集します。

例: `nix/cli/mise/config.toml`

```toml
[tools]
node = "22"
python = "3.12"
uv = "latest"
```

プロジェクトでだけ必要な CLI は、そのリポジトリの `.mise.toml` に追加します。

例:

```toml
[tools]
oras = "latest"
```

例: `nix/cli/ripgrep/default.nix`

```nix
{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.ripgrep
  ];
}
```

### 新しいCLI設定をhome-managerで管理する場合

1. `nix/cli/<tool>/default.nix` を作成
2. `nix/home/default.nix` または `nix/cli/default.nix` から import する
3. `sudo darwin-rebuild switch --flake "$HOME/dotfiles#macbook"` で適用

例: `nix/cli/git/default.nix`

```nix
{ ... }: {
  programs.git = {
    enable = true;
    userName = "hardy";
    userEmail = "your@email.com";
  };
}
```

### macOSシステム設定を変更する場合

`nix/darwin/system.nix` を編集します。利用できるオプションは以下で確認:

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
