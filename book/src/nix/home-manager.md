# Nix: Home Manager

The previous chapter covered `shell.nix` for project-specific tools. But what about tools you want *everywhere*—your editor, your shell configuration, your personal utilities?

That's what [Home Manager](https://github.com/nix-community/home-manager) solves.

## shell.nix vs home.nix

Think of it this way:

| | shell.nix | home.nix |
|---|---|---|
| **Scope** | Per-project | Per-user |
| **Activates** | When you `cd` into directory | Always available |
| **Use for** | Project dependencies | Personal tools and config |

`shell.nix` gives you `just` and `mdbook` when working on this template. `home.nix` gives you `helix` and `ripgrep` no matter what directory you're in.

## The Initial Setup

Home Manager was introduced in commit [c8ec56a](https://github.com/alycda/dev/commit/c8ec56a009f579f012a17566f5862dd2bd42cd81):

```nix
{ pkgs, ... }:
{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    helix
    ripgrep
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.stateVersion = "24.05";
  home.username = "root";
  home.homeDirectory = "/root";
}
```

This declares:
- **Core packages** - `helix` (editor) and `ripgrep` (search) available globally
- **direnv integration** - With `nix-direnv` for faster Nix shell loading
- **Self-management** - Home Manager can update itself

## Beyond Packages

Home Manager doesn't just install tools—it *configures* them. The current `home.nix` includes:

```nix
home.sessionVariables = {
  EDITOR = "hx";
  VISUAL = "code";
};

programs.bash = {
  enable = true;
  initExtra = ''
    # Custom shell initialization
  '';
};
```

Your editor preferences, shell configuration, environment variables—all declarative, all version-controlled.

## The Rebuild Command

When you modify `home.nix`, apply changes with:

```bash
just rebuild
```

Which runs:

```bash
home-manager switch -b backup -f .devcontainer/home.nix
```

The `-b backup` flag preserves any existing dotfiles that would be overwritten.

## Current State

The template's `home.nix` has grown to include:

```nix
home.packages = with pkgs; [
  helix       # Terminal editor
  ripgrep     # Fast search
  jujutsu     # Git-compatible VCS
  gh          # GitHub CLI
  claude-code # AI assistant
];
```

Each tool is available immediately in any new shell, not just project directories.

## Why Two Layers?

This separation—`shell.nix` for projects, `home.nix` for user—mirrors how you actually work:

1. **Personal tools** (editor, shell, utilities) follow you everywhere
2. **Project tools** (build systems, language toolchains) activate per-project

A Node.js project needs `nodejs` in its `shell.nix`. But you want `helix` and `ripgrep` regardless of what project you're in.

## Up Next: Just

You've seen `just rebuild` above. The [next chapter](./tools/just.md) covers Just—a command runner that ties these tools together with simple, memorable commands.

---

- https://github.com/nix-community/home-manager
- https://nix-community.github.io/home-manager/
- https://home-manager-options.extranix.com/
