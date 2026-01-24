# PRD: Unified Ralph with OpenCode Support

## Introduction/Overview
Currently, `ralph.sh` is hardcoded to use the `claude` (Claude Code) CLI tool. This PRD outlines the requirements to refactor `ralph.sh` to support an optional `--opencode` flag, allowing it to use the `opencode` CLI tool as an alternative backend while maintaining `claude` as the default.

## Goals
- Add support for an optional `--opencode` flag in `ralph.sh`.
- Maintain backward compatibility (default to `claude` if no flag is provided).
- Ensure the iteration count argument still works alongside the new flag.
- Provide clear error messages if the selected tool is missing.

## User Stories

### US-001: Support --opencode flag in ralph.sh
**Description:** As a user, I want to run Ralph using the `opencode` CLI by passing a flag so that I can use my preferred AI agent tool.

**Acceptance Criteria:**
- [ ] `./ralph.sh --opencode` triggers the loop using the `opencode` command.
- [ ] `./ralph.sh` (without flag) continues to use the `claude` command.
- [ ] The flag can be placed before or after the `max_iterations` argument.
- [ ] Script successfully parses the flag and identifies the target tool.

### US-002: Dynamic Tool Execution
**Description:** As a developer, I want the script to abstract the tool invocation so that it correctly passes the prompt and iterations regardless of the backend.

**Acceptance Criteria:**
- [ ] The `claude` command is called with its specific flags (`-p "$PROMPT" --dangerously-skip-permissions`).
- [ ] The `opencode` command is called with its specific flags (likely `-p "$PROMPT"` or similar, to be verified).
- [ ] Completion signal (`<promise>COMPLETE</promise>`) is correctly captured for both tools.

### US-003: Dependency Validation
**Description:** As a user, I want the script to tell me if I'm missing the required CLI tool before starting the loop.

**Acceptance Criteria:**
- [ ] If `claude` is selected (default) but not found, exit with error: "Error: 'claude' CLI not found."
- [ ] If `--opencode` is selected but not found, exit with error: "Error: 'opencode' CLI not found."
- [ ] Error messages provide basic guidance on what is missing.

## Functional Requirements
- FR-1: The script must parse command line arguments to detect `--opencode`.
- FR-2: The script must extract the `max_iterations` numeric argument regardless of flag position.
- FR-3: The script must check if the chosen executable (`claude` or `opencode`) exists in the `$PATH`.
- FR-4: The script must use the appropriate command syntax for the selected tool.
- FR-5: The existing logic for branch tracking, archiving, and progress logging must remain intact and work for both tools.

## Non-Goals
- Unifying `ralph-termux.sh` into `ralph.sh` (keep separate for now).
- Supporting other AI CLI tools (e.g., `aider`, `gpt-me`) in this iteration.
- Complex model configuration flags (e.g., `--model`, `--temperature`).

## Technical Considerations
- Argument parsing in Bash should handle cases like `./ralph.sh 5 --opencode` and `./ralph.sh --opencode 20`.
- `opencode` might have different flag requirements than `claude`. Based on standard patterns, `-p` for prompt is expected, but should be verified during implementation.
- Use `command -v [tool]` to check for existence.

## Success Metrics
- Successful execution of a multi-iteration loop using `opencode`.
- No regression in default `claude` functionality.
- Clear failure when tools are missing.

## Open Questions
- Does `opencode` support the exact same `--dangerously-skip-permissions` flag? (Likely not, flags should be tool-specific).
- Does `opencode` output the same `<promise>COMPLETE</promise>` token? (Yes, Ralph relies on the agent emitting this token in its final response).
