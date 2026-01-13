# PRD: Amp to Claude Code Migration

## Introduction

Complete the migration of Ralph from Amp (the original AI agent) to Claude Code (Anthropic's CLI). This involves updating all references, documentation, and the interactive flowchart to reflect Claude Code as the underlying agent instead of Amp.

## Goals

- Replace all "Amp" references with "Claude Code" throughout the codebase
- Update the interactive flowchart to reflect Claude Code branding
- Ensure documentation is consistent and accurate for Claude Code users
- Commit all existing uncommitted migration changes cohesively

## User Stories

### US-001: Update flowchart title and header
**Description:** As a user viewing the flowchart, I want to see "Claude Code" in the title so I understand which AI agent Ralph uses.

**Acceptance Criteria:**
- [ ] Change `<h1>How Ralph Works with Amp</h1>` to `<h1>How Ralph Works with Claude Code</h1>` in `flowchart/src/App.tsx`
- [ ] Typecheck passes

### US-002: Update flowchart node label
**Description:** As a user viewing the flowchart, I want the step labels to reference Claude Code so the workflow is clear.

**Acceptance Criteria:**
- [ ] Change node label `'Amp picks a story'` to `'Claude Code picks a story'` in `flowchart/src/App.tsx` (line 44)
- [ ] Typecheck passes

### US-003: Update flowchart note about CLAUDE.md
**Description:** As a user viewing the flowchart, I want the annotation note to reference CLAUDE.md (not AGENTS.md) since that's the Claude Code convention.

**Acceptance Criteria:**
- [ ] Change note content from `Also updates AGENTS.md with` to `Also updates CLAUDE.md with` in `flowchart/src/App.tsx` (around line 75-77)
- [ ] Typecheck passes

### US-004: Commit all migration changes
**Description:** As a maintainer, I want all Amp-to-Claude-Code migration changes committed together so the git history reflects this as a cohesive update.

**Acceptance Criteria:**
- [ ] Stage all modified files: README.md, prompt.md, skills/ralph/SKILL.md, flowchart/src/App.tsx
- [ ] Stage new file: CLAUDE.md
- [ ] Stage deleted file: AGENTS.md
- [ ] Commit with message: `feat: complete Amp to Claude Code migration`
- [ ] All files in working tree are clean after commit

## Functional Requirements

- FR-1: The flowchart title must read "How Ralph Works with Claude Code"
- FR-2: The flowchart step 4 node must read "Claude Code picks a story"
- FR-3: The flowchart note for step 8 must reference "CLAUDE.md" instead of "AGENTS.md"
- FR-4: All migration changes must be committed in a single cohesive commit

## Non-Goals

- No changes to flowchart styling or layout
- No changes to the ralph.sh script logic
- No updates to external links or URLs
- No changes to the skills beyond what's already been done

## Technical Considerations

- The flowchart is a React application using @xyflow/react
- Changes are isolated to `flowchart/src/App.tsx`
- Existing uncommitted changes in README.md, prompt.md, skills/ralph/SKILL.md, and CLAUDE.md should be included

## Success Metrics

- Zero references to "Amp" remain in the codebase (excluding package-lock.json integrity hashes)
- Flowchart correctly displays "Claude Code" in title and relevant nodes
- Clean git status after commit

## Open Questions

None - all clarifications have been addressed.
