# PRD: Test Ralph Termux

## Introduction

A simple test PRD to verify that `ralph-termux.sh` runs correctly outside of Claude Code. Contains minimal, self-contained tasks that can complete in one iteration.

## Goals

- Verify ralph-termux.sh executes correctly on Termux
- Confirm the full Ralph loop works (pick story → implement → commit → update prd.json)
- Test dependency checks and Termux-compatible paths

## User Stories

### US-001: Create test marker file
**Description:** As a tester, I want Ralph to create a simple marker file to prove it ran successfully.

**Acceptance Criteria:**
- [ ] Create file `test-output/ralph-was-here.txt`
- [ ] File contains the text: `Ralph ran successfully at <timestamp>`
- [ ] File exists and is readable

### US-002: Append to progress.txt
**Description:** As a tester, I want Ralph to log a test entry to progress.txt.

**Acceptance Criteria:**
- [ ] Append a line to `progress.txt` with: `Test iteration completed successfully`
- [ ] progress.txt contains the new entry

## Functional Requirements

- FR-1: All file operations should use project-relative paths
- FR-2: Tasks should be completable in a single Claude iteration
- FR-3: No external dependencies beyond what's already available

## Non-Goals

- No complex code changes
- No network operations
- No changes to core Ralph files

## Success Metrics

- ralph-termux.sh completes at least one iteration
- Both user stories marked `passes: true` in prd.json
- `<promise>COMPLETE</promise>` signal emitted when done

## Notes

Run with: `./ralph-termux.sh 2` (2 iterations max, should complete in 1)
