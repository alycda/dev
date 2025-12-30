# Nix

Nix is a package manager that guarantees reproducibility. Same inputs, same outputs—every time, on every machine.

If you've ever dealt with "it works on my machine" or spent hours debugging environment differences, Nix solves that problem at the root.

## The Core Idea

Traditional package managers install software globally and hope for the best. Nix takes a different approach:

- **Immutable packages** - Each package is stored in isolation with a unique hash
- **Declarative configuration** - You describe *what* you want, not *how* to install it
- **Reproducible builds** - The same `shell.nix` produces the same environment everywhere

## The Initial Setup

This template's first Nix integration ([8b951a5](https://github.com/alycda/dev/commit/8b951a56c38efb96b6f7533d6b10a946b7d3c233)) added three files:

### shell.nix

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [ just ];
}
```

This declares a shell environment with one tool: `just` (a command runner). Want more tools? Add them to the list:

```nix
buildInputs = with pkgs; [ just nodejs python3 rustc ];
```

### .envrc

```bash
use nix
```

This one-liner tells `direnv` to activate the Nix shell automatically when you enter the directory.

### The Hook

The devcontainer's `postCreateCommand` wires it together:

```bash
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc && direnv allow
```

## How It Works

1. You `cd` into the project directory
2. `direnv` detects `.envrc`
3. `.envrc` says `use nix`
4. Nix builds/fetches the packages in `shell.nix`
5. Your shell now has those tools available

Leave the directory, tools disappear. Enter again, they're back. No global pollution.

## Why This Matters

The devcontainer installs Nix, but Nix manages the actual tools. This separation is powerful:

- **Lightweight container** - Just Debian + Nix, nothing else
- **Declarative tools** - `shell.nix` is version-controlled documentation of your dependencies
- **Works anywhere** - Same `shell.nix` works on macOS, Linux, or in Codespaces
- **Easy iteration** - Add a tool to `shell.nix`, run `direnv reload`, done

## Current State

The template's `shell.nix` has grown to include several tools:

```nix
buildInputs = with pkgs; [ just cheat asciinema_3 presenterm tmux mdbook ];
```

Each of these gets its own chapter later. The point is: adding tools is trivial. One line in `shell.nix`, and everyone who clones this repo gets the same environment.

## Finding Packages

Search for packages at [search.nixos.org](https://search.nixos.org/packages). The repository has over 100,000 packages—if it exists, Nix probably has it.

---

- https://nixos.org/
- https://nix.dev/ (tutorials)
- https://direnv.net/
- https://learnxinyminutes.com/nix/
- https://nixcloud.io/tour/
