# Devcontainers

Devcontainers often get a bad reputation—and sometimes deservedly so. Running Docker for a simple webpage feels like swatting a fly with a sledgehammer, especially when the container is bloated and slow.

But the *idea* behind devcontainers is sound: **a reproducible, isolated development environment**.

## The Real Problem

It's not about Docker. It's about maintaining focus and productivity by keeping your working environment clean:

- VS Code extensions that conflict or clutter
- System binaries that drift between machines
- "Works on my machine" debugging sessions
- Configuration that accumulates like sediment

A devcontainer solves this by declaring exactly what your environment should contain—nothing more, nothing less.

> **macOS Users:** If you're developing locally, use [OrbStack](https://orbstack.dev/) instead of Docker Desktop. It's significantly faster, lighter on resources, and makes devcontainer iteration actually pleasant. The trial is generous enough to evaluate whether the speed gains justify the cost.

## Starting Minimal

This template's initial devcontainer ([cc11da7](https://github.com/alycda/dev/commit/cc11da7273691c76e44d6317dc5547561d078024)) was intentionally sparse:

```json
{
    "image": "debian:bookworm-slim",
    "features": {
        "ghcr.io/devcontainers/features/nix:1": {
            "packages": ["direnv"]
        }
    },
    "customizations": {
        "vscode": {
            "extensions": ["jnoortheen.nix-ide"],
            "settings": {
                "editor.wordWrap": "on",
                "git.autofetch": true
            }
        }
    }
}
```

That's it:
- **Debian slim** - A minimal base, not Ubuntu with kitchen sink
- **Nix + direnv** - The foundation for reproducible tooling (more on this later)
- **One extension** - Nix language support
- **Sensible defaults** - Word wrap, auto-fetch

## Why This Matters

The devcontainer is the *second* commit in this repository's history (after `.gitignore`). This ordering is intentional:

1. **Step 0**: Ignore the right files
2. **Step 1**: Define the environment

Everything else—the actual code, the tools, the configuration—builds on this foundation. When you open this repository in VS Code or GitHub Codespaces, you get exactly the environment the project expects.

## The Nix Connection

Notice that we install Nix immediately. The devcontainer itself stays minimal because Nix (via `shell.nix` and `direnv`) handles the actual development tools. This separation means:

- The container is fast to build
- Tools are managed declaratively in Nix
- You can use the same Nix configuration outside Docker

We'll cover Nix in detail in the next [chapter](./nix/README.md).

## When to Use Devcontainers

Use them when:
- **Onboarding matters** - New contributors should be productive in minutes
- **Environment consistency is critical** - CI/CD should match local dev
- **You're using Codespaces** - It's the native way to define the environment

Skip them when:
- The project is simple enough that a README suffices
- Docker overhead genuinely hurts your workflow
- You're the only developer and prefer native tooling

The goal isn't Docker for Docker's sake—it's having a single source of truth for "what does this project need to run?"

---

- https://learnxinyminutes.com/docker/
- https://containers.dev/
- https://code.visualstudio.com/docs/devcontainers/containers
