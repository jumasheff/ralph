#!/bin/bash
# Ralph Wiggum - Long-running AI agent loop (Termux version)
# Usage: ./ralph-opencode-termux.sh [max_iterations]

set -e

# --- Termux detection ---
is_termux() {
  [ -n "$PREFIX" ] || [ -d "/data/data/com.termux" ]
}

if is_termux; then
  echo "Running on Termux"
fi

# --- Dependency checks ---
check_dependencies() {
  local missing=()

  if ! command -v jq &> /dev/null; then
    missing+=("jq")
  fi

  if ! command -v opencode &> /dev/null; then
    missing+=("opencode")
  fi

  if [ ${#missing[@]} -ne 0 ]; then
    echo "Error: Missing required dependencies:"
    for dep in "${missing[@]}"; do
      case "$dep" in
        jq)
          echo "  - jq is required. Install with: pkg install jq"
          ;;
        opencode)
          echo "  - opencode is required. Install with: npm install -g @opencode-sh/cli"
          ;;
      esac
    done
    exit 1
  fi
}

check_dependencies

# --- Environment check for /tmp access ---
check_tmp_access() {
  if is_termux; then
    # Use Termux-compatible temp directory
    local termux_tmp="${PREFIX:-/data/data/com.termux/files/usr}/tmp"
    mkdir -p "$termux_tmp"

    # Try to create a temp file in the Termux temp dir to verify access
    if ! touch "$termux_tmp/.ralph-test" 2>/dev/null; then
      echo ""
      echo "Error: Cannot access $termux_tmp directory."
      echo "Please check your Termux permissions."
      exit 1
    else
      rm -f "$termux_tmp/.ralph-test" 2>/dev/null
      # Export TMPDIR for subsequent commands
      export TMPDIR="$termux_tmp"
    fi
  fi
}

check_tmp_access

# --- Termux-compatible paths ---
# Use $PREFIX/tmp for temp files (standard /tmp is not accessible on Termux)
TEMP_DIR="${PREFIX:-/data/data/com.termux/files/usr}/tmp"
mkdir -p "$TEMP_DIR"

# --- Main script ---
MAX_ITERATIONS=${1:-10}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRD_FILE="$SCRIPT_DIR/prd.json"
PROGRESS_FILE="$SCRIPT_DIR/progress.txt"
ARCHIVE_DIR="$SCRIPT_DIR/archive"
LAST_BRANCH_FILE="$SCRIPT_DIR/.last-branch"

# Archive previous run if branch changed
if [ -f "$PRD_FILE" ] && [ -f "$LAST_BRANCH_FILE" ]; then
  CURRENT_BRANCH=$(jq -r '.branchName // empty' "$PRD_FILE" 2>/dev/null || echo "")
  LAST_BRANCH=$(cat "$LAST_BRANCH_FILE" 2>/dev/null || echo "")

  if [ -n "$CURRENT_BRANCH" ] && [ -n "$LAST_BRANCH" ] && [ "$CURRENT_BRANCH" != "$LAST_BRANCH" ]; then
    # Archive the previous run
    DATE=$(date +%Y-%m-%d)
    # Strip "ralph/" prefix from branch name for folder
    FOLDER_NAME=$(echo "$LAST_BRANCH" | sed 's|^ralph/||')
    ARCHIVE_FOLDER="$ARCHIVE_DIR/$DATE-$FOLDER_NAME"

    echo "Archiving previous run: $LAST_BRANCH"
    mkdir -p "$ARCHIVE_FOLDER"
    [ -f "$PRD_FILE" ] && cp "$PRD_FILE" "$ARCHIVE_FOLDER/"
    [ -f "$PROGRESS_FILE" ] && cp "$PROGRESS_FILE" "$ARCHIVE_FOLDER/"
    echo "   Archived to: $ARCHIVE_FOLDER"

    # Reset progress file for new run
    echo "# Ralph Progress Log" > "$PROGRESS_FILE"
    echo "Started: $(date)" >> "$PROGRESS_FILE"
    echo "---" >> "$PROGRESS_FILE"
  fi
fi

# Track current branch
if [ -f "$PRD_FILE" ]; then
  CURRENT_BRANCH=$(jq -r '.branchName // empty' "$PRD_FILE" 2>/dev/null || echo "")
  if [ -n "$CURRENT_BRANCH" ]; then
    echo "$CURRENT_BRANCH" > "$LAST_BRANCH_FILE"
  fi
fi

# Initialize progress file if it doesn't exist
if [ ! -f "$PROGRESS_FILE" ]; then
  echo "# Ralph Progress Log" > "$PROGRESS_FILE"
  echo "Started: $(date)" >> "$PROGRESS_FILE"
  echo "---" >> "$PROGRESS_FILE"
fi

echo "Starting Ralph (Termux) - Max iterations: $MAX_ITERATIONS"

for i in $(seq 1 $MAX_ITERATIONS); do
  echo ""
  echo "══════════════════════════════"
  echo " Ralph: $i / $MAX_ITERATIONS"
  echo "══════════════════════════════"

  # Run opencode with the ralph prompt
  PROMPT=$(cat "$SCRIPT_DIR/prompt.md")
  OUTPUT=$(opencode run "$PROMPT" 2>&1 | tee /dev/stderr) || true

  # Check for completion signal
  if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then
    echo ""
    echo "Ralph completed all tasks!"
    echo "Completed at iteration $i of $MAX_ITERATIONS"
    exit 0
  fi

  echo "Iteration $i complete. Continuing..."
  sleep 2
done

echo ""
echo "Ralph reached max iterations ($MAX_ITERATIONS) without completing all tasks."
echo "Check $PROGRESS_FILE for status."
exit 1
