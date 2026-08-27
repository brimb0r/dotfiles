# dotfiles

My portable shell setup for Linux / WSL. Clone it on any machine and run the
bootstrap to get the same terminal everywhere.

## Install

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
exec bash        # or open a new terminal
```

## What's inside

| Path | Symlinks to | What it is |
|------|-------------|------------|
| `bash/bashrc` | `~/.bashrc` | Shell config: PATH, history, colors, git-aware fallback prompt, aliases, tmux helpers, `helpme` cheat sheet, ext4 filesystem guard, tool hooks |
| `starship/starship.toml` | `~/.config/starship.toml` | Prompt theme: git + Terraform + Go/Rust/.NET + Azure/K8s context |
| `tmux/tmux.conf` | `~/.tmux.conf` | `Ctrl-a` prefix, mouse, `\|`/`-` splits, status bar |
| `install.sh` | — | Bootstrap: symlinks the above + installs Claude Code and the CLI toolkit |

## Tooling the bootstrap installs

- **Prompt/nav:** starship, zoxide, atuin, fzf, eza, bat, fd
- **Per-project env:** direnv
- **CLI power tools:** jq, yq, dust, duf, procs, sd, xh, glow, tldr, gping
- **Claude Code**

## Editing

The live dotfiles are symlinks into this repo, so editing `~/.bashrc` edits
`bash/bashrc` here. Commit and push to sync other machines.
