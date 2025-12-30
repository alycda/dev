# Just

[Just](https://github.com/casey/just) is a command runner—like `make`, but without the baggage.

No build system complexity. No implicit rules. No tabs-vs-spaces drama. Just simple commands you can remember.

## Why Not Make?

Make is powerful but optimized for building C programs in the 1970s. For modern development tasks, you fight against it:

- Recipes are file-based by default (you want `.PHONY` everywhere)
- Tab-only indentation causes invisible bugs
- The syntax is arcane and full of surprises
- Error messages assume you're compiling object files

Just drops all that. It's a command runner, not a build system.

## The Initial Setup

Just was introduced alongside the Nix shell configuration ([8b951a5](https://github.com/alycda/dev/commit/8b951a56c38efb96b6f7533d6b10a946b7d3c233)):

```just
_default:
    @just --list
```

That's the entire initial justfile—a single recipe that lists available commands. The underscore prefix hides it from the list output.

## Current Recipes

The template's justfile has grown to include:

```just
_default:
    @just --list

rebuild:
    home-manager switch -b backup -f .devcontainer/home.nix

cheats:
    cheat -l

present:
    presenterm slides.md

[working-directory: 'book']
book:
    mdbook serve --open

[working-directory: 'book']
build-book:
    mdbook build
```

Each recipe is a memorable alias for a longer command. Can't remember the exact `home-manager` incantation? `just rebuild`.

## Key Features

### Self-Documenting

Running `just` with no arguments shows all available recipes:

```
$ just
Available recipes:
    book
    build-book
    cheats
    present
    rebuild
```

### Working Directory Control

```just
[working-directory: 'book']
book:
    mdbook serve --open
```

This runs the command from `book/`, regardless of where you invoke `just`.

### Variables and Exports

```just
export USER := shell("whoami")
```

Environment variables and shell commands work naturally.

### Recipe Dependencies

```just
build-book-gha:
    just build-book
    mv book ../_site
```

Recipes can call other recipes.

## The Pattern

A good justfile follows a simple pattern:

1. **Start minimal** - One `_default` recipe that lists commands
2. **Add as needed** - When you type a command more than twice, make it a recipe
3. **Keep it obvious** - Recipe names should be guessable (`build`, `test`, `deploy`)

Don't over-engineer it. The goal is to avoid memorizing flags, not to build a complex automation system.

## Why It Lives in shell.nix

Just is a project tool—you need it when working on *this* project, not globally. That's why it's in `shell.nix`:

```nix
buildInputs = with pkgs; [ just cheat asciinema presenterm tmux mdbook ];
```

When you `cd` into the project, direnv activates the Nix shell, and `just` becomes available.

---

- https://github.com/casey/just
- https://just.systems/man/en/
- https://learnxinyminutes.com/make/
