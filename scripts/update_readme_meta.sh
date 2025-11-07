#!/usr/bin/env bash
set -euo pipefail

README_FILE="README.md"

if [[ ! -f "$README_FILE" ]]; then
  echo "README.md not found. Run this from the repo root."
  exit 1
fi

# 1. Determine focus:
# Priority:
#   - $1 (explicit CLI argument)
#   - $FOCUS env var
#   - Weekday-based preset (UTC)
if [[ $# -gt 0 && -n "${1:-}" ]]; then
  FOCUS="$1"
elif [[ -n "${FOCUS:-}" ]]; then
  FOCUS="$FOCUS"
else
  # Weekday in UTC: 1=Mon ... 7=Sun
  DOW="$(date -u +%u)"
  case "$DOW" in
    1)
      FOCUS="Smooth Operator & inbox clears"
      ;;
    2)
      FOCUS="shadow-scripts & network lab"
      ;;
    3)
      FOCUS="Quantum Autopilot routines"
      ;;
    4)
      FOCUS="3D commerce surfaces & devtools"
      ;;
    5)
      FOCUS="DevOps pipelines & deployment"
      ;;
    6)
      FOCUS="R&D, system design, and experiments"
      ;;
    7)
      FOCUS="Refactors, journaling, and reset"
      ;;
    *)
      FOCUS="QPS/v1 surface & Smooth Operator stack"
      ;;
  esac
fi

# 2. Date (UTC)
DATE="$(date -u +%Y-%m-%d)"

META_BLOCK="<!-- qp:meta:start -->
Last updated: ${DATE} · Current focus: ${FOCUS}.
<!-- qp:meta:end -->"

# 3. Replace or insert the meta block
if grep -q "<!-- qp:meta:start -->" "$README_FILE"; then
  META_BLOCK_ESCAPED="$(printf '%s\n' "$META_BLOCK" | sed -e 's/[&/\]/\\&/g')"
  perl -0pi -e '
    my $block = $ENV{META_BLOCK_ESCAPED};
    s/<!-- qp:meta:start -->.*?<!-- qp:meta:end -->/$block/s;
  ' "$README_FILE"
else
  printf "\n%s\n" "$META_BLOCK" >> "$README_FILE"
fi

echo "Updated meta block: ${DATE} · ${FOCUS}"
