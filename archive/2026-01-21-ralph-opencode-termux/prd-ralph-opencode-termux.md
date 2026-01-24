# PRD: Ralph for OpenCode on Termux

## Introduction

Create a standalone script `ralph-opencode-termux.sh` that enables running the Ralph agent loop on Termux devices using the OpenCode CLI (`opencode`) instead of the Claude CLI. This ensures OpenCode users can run the autonomous loop with proper Termux path handling and dependency checks.

## Goals

- Enable Ralph agent loop for OpenCode users on Termux
- specific handling of Termux environment variables and temporary paths
- robust dependency checking for `jq` and `opencode`
- identical behavior to `ralph-termux.sh` but with the OpenCode engine

## User Stories

### US-001: Create script scaffolding and Termux checks
**Description:** As a user, I want a script that validates it is running on Termux and has the correct environment permissions.

**Acceptance Criteria:**
- [ ] Create `ralph-opencode-termux.sh` (copy of `ralph-termux.sh` as base)
- [ ] Verify `is_termux` function works
- [ ] Verify `check_tmp_access` logic (using `$PREFIX/tmp`)
- [ ] Script is executable

### US-002: Adapt dependency checks for OpenCode
**Description:** As a user, I want the script to verify I have the `opencode` CLI installed instead of `claude`.

**Acceptance Criteria:**
- [ ] Remove check for `claude`
- [ ] Add check for `opencode` CLI
- [ ] Provide helpful installation instructions if missing
- [ ] Keep `jq` check
- [ ] Verify bash syntax with `bash -n`

### US-003: Implement OpenCode Agent Loop
**Description:** As a user, I want the script to invoke `opencode` in a loop to process the Ralph prompt.

**Acceptance Criteria:**
- [ ] Replace `claude -p` call with `opencode run`
- [ ] Capture output correctly for the completion signal `<promise>COMPLETE</promise>`
- [ ] Ensure the prompt is passed correctly from `prompt.md`
- [ ] Maintain loop logic (max iterations, progress logging)

## Functional Requirements

- FR-1: Script must be named `ralph-opencode-termux.sh`
- FR-2: Must use `$PREFIX/tmp` for temporary files on Termux
- FR-3: Must use `opencode run "$PROMPT"` to execute the agent
- FR-4: Must fail gracefully if `opencode` is not installed
- FR-5: Must support the standard `[max_iterations]` argument

## Non-Goals

- Installing `opencode` automatically (just warn)
- Supporting non-Termux environments (use `ralph.sh` or `ralph-opencode.sh` for that)

## Technical Considerations

- `opencode run` output might differ slightly from `claude`, ensure stdout/stderr handling is robust.
- OpenCode CLI might have different flags for non-interactive mode (verified: `run` command).

## Success Metrics

- Script runs successfully on a Termux environment with OpenCode installed.
- Agent loop functions and terminates upon receiving the completion signal.
