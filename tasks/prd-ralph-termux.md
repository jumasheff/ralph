# PRD: Ralph Termux Compatibility

## Introduction

Create a Termux-compatible version of ralph.sh that works reliably on Android/Termux environments. The main script will be `ralph-termux.sh` which addresses Termux-specific limitations.

## Goals

- Create a ralph-termux.sh script that runs reliably on Termux
- Handle Termux-specific path and environment differences
- Maintain feature parity with the original ralph.sh
- Add helpful error messages for missing dependencies

## User Stories

### US-001: Create ralph-termux.sh with dependency checks
**Description:** As a Termux user, I want ralph-termux.sh to check for required dependencies and provide clear installation instructions if they're missing.

**Acceptance Criteria:**
- [ ] Create `ralph-termux.sh` based on `ralph.sh`
- [ ] Add dependency check for `jq` at startup
- [ ] If `jq` is missing, print: `Error: jq is required. Install with: pkg install jq`
- [ ] Exit with code 1 if dependencies are missing
- [ ] Script is executable (`chmod +x`)

### US-002: Use Termux-compatible temp paths
**Description:** As a Termux user, I want the script to use `$PREFIX/tmp` instead of `/tmp` for any temporary files.

**Acceptance Criteria:**
- [ ] Define `TEMP_DIR="${PREFIX:-/data/data/com.termux/files/usr}/tmp"`
- [ ] Use `$TEMP_DIR` for any temporary file operations
- [ ] Ensure temp directory exists before use

### US-003: Add Termux environment detection
**Description:** As a user, I want the script to detect if it's running on Termux and warn if the wrong script variant is being used.

**Acceptance Criteria:**
- [ ] Add function to detect Termux environment (check for `$PREFIX` or `/data/data/com.termux`)
- [ ] Print informational message: `Running on Termux` when detected
- [ ] Original `ralph.sh` should suggest using `ralph-termux.sh` if Termux is detected

## Functional Requirements

- FR-1: ralph-termux.sh must check for jq dependency before running
- FR-2: ralph-termux.sh must use Termux-compatible paths
- FR-3: ralph-termux.sh must maintain identical core logic to ralph.sh
- FR-4: ralph.sh should detect Termux and warn users to use ralph-termux.sh

## Non-Goals

- No changes to prompt.md or the Claude interaction model
- No changes to prd.json format
- No GUI or interactive mode additions

## Technical Considerations

- Termux uses `$PREFIX` (typically `/data/data/com.termux/files/usr`) as the system root
- `/tmp` is not accessible in Termux; use `$PREFIX/tmp` instead
- `jq` must be installed via `pkg install jq`
- The `claude` CLI is assumed to be installed and in PATH

## Success Metrics

- ralph-termux.sh runs successfully on Termux without errors
- Clear error messages guide users to install missing dependencies
- Script completes iteration loop identical to ralph.sh

## Open Questions

None.
