# Tools

This section covers the tools included in this template's `shell.nix`. They're available automatically when you enter the project directory thanks to direnv.

These aren't arbitrary choices—each solves a specific friction point in development workflows:

- **Just** - Command runner for memorable aliases
- **cheat** - Quick reference for commands you forget
- **Jujutsu** - Git-compatible VCS with better UX
- **Presenterm** - Terminal-based presentations
- **Asciinema** - Record terminal sessions
- **mdbook** - Generate documentation sites

All are installed via Nix, so they're reproducible across machines and don't pollute your global system.
