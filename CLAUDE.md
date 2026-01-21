# Ralph Agent Instructions

## Overview

Ralph is an autonomous AI agent loop that runs Claude repeatedly until all PRD items are complete. Each iteration is a fresh Claude instance with clean context.

## Commands

```bash
# Run the flowchart dev server
cd flowchart && npm run dev

# Build the flowchart
cd flowchart && npm run build

# Run Ralph (from your project that has prd.json)
./ralph.sh [max_iterations]

# Run Ralph on Termux (Android)
./ralph-termux.sh [max_iterations]

# Run Ralph OpenCode on Termux
./ralph-opencode-termux.sh [max_iterations]
```

## Key Files

- `ralph.sh` - The bash loop that spawns fresh Claude instances
- `ralph-termux.sh` - Termux-compatible version with dependency checks
- `ralph-opencode-termux.sh` - OpenCode version for Termux
- `prompt.md` - Instructions given to each Claude instance
- `prd.json.example` - Example PRD format
- `flowchart/` - Interactive React Flow diagram explaining how Ralph works

## Flowchart

The `flowchart/` directory contains an interactive visualization built with React Flow. It's designed for presentations - click through to reveal each step with animations.

To run locally:
```bash
cd flowchart
npm install
npm run dev
```

## Patterns

- Each iteration spawns a fresh Claude instance with clean context
- Memory persists via git history, `progress.txt`, and `prd.json`
- Stories should be small enough to complete in one context window
- Always update CLAUDE.md with discovered patterns for future iterations
- Use `opencode run "$PROMPT"` for non-interactive execution of opencode CLI

## Current State (2026-01-21)

**Branch:** `ralph/unified-ralph-opencode`

**Completed:**
- Created `tasks/prd-ralph-unified.md` for refactoring `ralph.sh` to support `--opencode`
- Archived old PRD artifacts (`prd.json`, `progress.txt`, `prd-ralph-opencode-termux.md`)

**Recent Work:**
- Created `ralph-opencode-termux.sh`
- Created `ralph-termux.sh` with dependency checks and Termux-compatible paths
- Added Termux detection to `ralph.sh`
- Archived completed stories for `ralph-opencode-termux.sh`
- Planning `ralph.sh` unification with OpenCode support

## Termux Notes

- Use `ralph-termux.sh` instead of `ralph.sh` on Termux
- `ralph-termux.sh` includes:
  - Dependency checks for `jq` (install with `pkg install jq`)
  - Termux-compatible temp paths (`$PREFIX/tmp`)
  - Automatic Termux environment detection
- Running `ralph.sh` on Termux will show a warning suggesting `ralph-termux.sh`
- TypeScript check: `/data/data/com.termux/files/home/projects/ralph/flowchart/node_modules/.bin/tsc --noEmit -p /data/data/com.termux/files/home/projects/ralph/flowchart/tsconfig.json`
- Note: Running Ralph inside Claude Code on Termux may not work due to nested sandbox issues - run `ralph-termux.sh` directly from terminal instead
