#!/usr/bin/env bash
# ============================================================
#  brimb0r dotfiles — bootstrap a fresh machine
#  Usage:  git clone <repo> ~/dotfiles && cd ~/dotfiles && ./install.sh
# ============================================================
set -uo pipefail
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$HOME/.local/bin"
mkdir -p "$BIN" "$HOME/.config"

link(){ ln -sfnv "$1" "$2"; }

echo "==> symlinking configs"
link "$DOTFILES/bash/bashrc"            "$HOME/.bashrc"
link "$DOTFILES/tmux/tmux.conf"         "$HOME/.tmux.conf"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

echo "==> Claude Code"
command -v claude >/dev/null 2>&1 || curl -fsSL https://claude.ai/install.sh | bash

echo "==> prompt tools (no sudo): starship, zoxide, atuin"
command -v starship >/dev/null 2>&1 || curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$BIN"
command -v zoxide   >/dev/null 2>&1 || curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
command -v atuin    >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

echo "==> apt tools (needs sudo; skipped if unavailable)"
if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update && sudo apt-get install -y \
    eza bat fd-find ripgrep fzf btop tmux git curl unzip direnv || true
fi

echo "==> jq + yq (static binaries)"
command -v jq >/dev/null 2>&1 || { curl -fsSL https://github.com/jqlang/jq/releases/latest/download/jq-linux-amd64 -o "$BIN/jq" && chmod +x "$BIN/jq"; }
command -v yq >/dev/null 2>&1 || { curl -fsSL https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o "$BIN/yq" && chmod +x "$BIN/yq"; }

echo "==> Rust CLI tools (via cargo-binstall, if cargo present)"
if command -v cargo >/dev/null 2>&1; then
  export PATH="$HOME/.cargo/bin:$PATH"
  command -v cargo-binstall >/dev/null 2>&1 || \
    curl -L --proto '=https' --tlsv1.2 -sSf \
      https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
  cargo binstall -y du-dust procs sd xh tealdeer gping || true
  command -v tldr >/dev/null 2>&1 && tldr --update >/dev/null 2>&1 || true
fi

echo
echo "==> done. Open a new shell, or run:  source ~/.bashrc"
