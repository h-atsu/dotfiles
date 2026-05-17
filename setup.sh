#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This setup script currently supports macOS only." >&2
  exit 1
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
HOST="${HOST:-macbook}"

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Install Xcode Command Line Tools, then run this script again." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v nix >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
    | sh -s -- install --determinate
fi

export PATH="/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:$PATH"

cd "$SCRIPT_DIR"
sudo --preserve-env=PATH nix run nix-darwin -- switch --flake ".#$HOST"
