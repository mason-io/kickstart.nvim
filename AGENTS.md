# Repository Guidelines

## Project Structure & Module Organization
`init.lua` bootstraps lazy.nvim and the Kickstart defaults; treat it as the entry point for any global behaviour changes. Keep upstream logic in `lua/kickstart/` untouched and extend features under `lua/custom/`, grouping one concern per plugin spec file in `lua/custom/plugins/`. Shared helpers belong alongside those specs. Repository docs (`README.md`, `doc/kickstart.txt`, custom guides) explain feature intent, while automated checks live in `tests/` (name specs `<feature>_spec.lua`). `lazy-lock.json` pins plugin revisions—regenerate only when you intentionally update dependencies.

## Build, Test, and Development Commands
- `nvim --headless "+Lazy! sync" +qa` installs or updates all pinned plugins; run after dependency or lockfile changes.
- `nvim --headless "+Lazy! check" +qa` validates plugin health and surfaces missing native build steps.
- `stylua --search-parent-directories lua tests` formats Lua modules and specs using project-aware settings detected by conform.nvim.
- Launch Neovim and run `:MasonToolsUpdate` to reconcile formatters and linters declared in `lua/custom/plugins/mason-tools.lua`.

## Coding Style & Naming Conventions
This config defers indentation, width, and newline rules to project `.editorconfig`, formatter configs, or `vim-sleuth`; if none are present, default to two-space indentation. Use descriptive, lower_snake_case identifiers in Lua, and keep plugin spec filenames kebab-cased (for example, `project-settings.lua`). Rely on conform.nvim (`<leader>f`) for async format-on-save, and prefer local formatter configs over LSP formatting when both exist.

## Testing Guidelines
Tests rely on plenary’s busted harness. Run `nvim --headless -c "PlenaryBustedDirectory tests" -c "qa"` to execute all specs; set `NVIM_APPNAME` or `XDG_*` vars when running in CI to isolate caches (`NVIM_APPNAME=nvim-ci XDG_CACHE_HOME=$(pwd)/.cache ...`). Place new specs in `tests/` and suffix with `_spec.lua`. Keep assertions focused on pure functions so they can run without a GUI, and mirror fixture layouts under `tests/fixtures/` if interactive data is needed.

## Commit & Pull Request Guidelines
Write imperative commit subjects ("Add project-aware formatter"), optionally prefixed with Conventional Commit types (`feat:`, `fix:`) to match existing history. Update the relevant doc alongside behavioural changes and capture lockfile diffs when dependencies move. Before opening a PR, run the commands above, link any tracking issue, and describe UX-visible changes (screenshots or terminal recordings for theme updates help reviewers). Highlight manual verification steps so others can reproduce them quickly.

## State & Configuration Tips
Use `NVIM_APPNAME` (for example, `NVIM_APPNAME=nvim-kickstart-dev nvim`) to experiment without clobbering your daily config. When scripting headless tasks, redirect cache and state directories inside the repo (`XDG_CACHE_HOME`, `XDG_STATE_HOME`, `XDG_DATA_HOME`) to avoid permission issues and to keep CI artifacts isolated.
