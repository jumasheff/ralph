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
```

## Key Files

- `ralph.sh` - The bash loop that spawns fresh Claude instances
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

## Current State (2026-01-14)

**Branch:** `ralph/amp-to-claude-code-migration`

**Completed:**
- US-001: Updated flowchart references from Amp to Claude Code
- US-002: Committed all migration changes

**Migration Summary:**
- Renamed `AGENTS.md` → `CLAUDE.md` (Claude Code convention)
- Updated `README.md` with Claude Code references and credits
- Updated `prompt.md` for Claude Code usage
- Updated `skills/ralph/SKILL.md` for Claude Code
- Updated `flowchart/src/App.tsx`:
  - Title: "How Ralph Works with Claude Code"
  - Node label: "Claude Code picks a story"
  - Note: "Also updates CLAUDE.md with..."

**PRD Location:** `tasks/prd-amp-to-claude-code-migration.md`
**prd.json:** Both stories marked `passes: true`

## Termux Notes

- Running on Termux (Android) - `/tmp` is not accessible
- Use `$PREFIX/tmp` for temp files
- TypeScript check: `/data/data/com.termux/files/home/projects/ralph/flowchart/node_modules/.bin/tsc --noEmit -p /data/data/com.termux/files/home/projects/ralph/flowchart/tsconfig.json`
- `ralph.sh` may not work in Termux due to nested Claude sandbox issues - implement stories manually instead
