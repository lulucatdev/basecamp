#!/usr/bin/env bash
set -euo pipefail

# Rename this project from "basecamp" to a new name.
# Usage: ./scripts/rename.sh my_app

cd "$(dirname "$0")/.."

if [ $# -ne 1 ]; then
  echo "Usage: ./rename.sh <new_name>"
  echo "  <new_name>  lowercase, underscore-separated (e.g. my_app)"
  exit 1
fi

NEW_NAME="$1"

# Validate: must be lowercase, start with letter, only a-z, 0-9, _
if [[ ! "$NEW_NAME" =~ ^[a-z][a-z0-9_]*$ ]]; then
  echo "Error: name must be lowercase, start with a letter, and contain only a-z, 0-9, _"
  exit 1
fi

OLD_SNAKE="basecamp"
OLD_PASCAL="Basecamp"

# Build PascalCase from snake_case (my_cool_app -> MyCoolApp)
NEW_PASCAL=""
IFS='_' read -ra PARTS <<< "$NEW_NAME"
for part in "${PARTS[@]}"; do
  NEW_PASCAL+="$(tr '[:lower:]' '[:upper:]' <<< "${part:0:1}")${part:1}"
done

echo "Renaming: $OLD_SNAKE -> $NEW_NAME ($OLD_PASCAL -> $NEW_PASCAL)"
echo ""

# 1. Replace file contents (order matters: PascalCase first to avoid partial matches)
echo "Replacing file contents..."
find . -type f \
  -not -path './.git/*' \
  -not -path './_build/*' \
  -not -path './deps/*' \
  -not -path './.elixir_ls/*' \
  -not -path './assets/node_modules/*' \
  -not -path './rename.sh' \
  -not -name 'mix.lock' \
  -not -name 'package-lock.json' \
  | while read -r file; do
    if file --mime-type "$file" | grep -q 'text/'; then
      if grep -q "$OLD_PASCAL\|$OLD_SNAKE" "$file" 2>/dev/null; then
        sed -i '' "s/${OLD_PASCAL}/${NEW_PASCAL}/g; s/${OLD_SNAKE}/${NEW_NAME}/g" "$file"
        echo "  updated: $file"
      fi
    fi
  done

# 2. Rename files containing old name
echo ""
echo "Renaming files..."
find . -type f -name "*${OLD_SNAKE}*" \
  -not -path './.git/*' \
  -not -path './_build/*' \
  -not -path './deps/*' \
  -not -path './.elixir_ls/*' \
  -not -path './assets/node_modules/*' \
  | while read -r file; do
    new_file="$(dirname "$file")/$(basename "$file" | sed "s/${OLD_SNAKE}/${NEW_NAME}/g")"
    mv "$file" "$new_file"
    echo "  $file -> $new_file"
  done

# 3. Rename directories (deepest first to avoid path conflicts)
echo ""
echo "Renaming directories..."
find . -depth -type d -name "*${OLD_SNAKE}*" \
  -not -path './.git/*' \
  -not -path './_build/*' \
  -not -path './deps/*' \
  -not -path './.elixir_ls/*' \
  -not -path './assets/node_modules/*' \
  | while read -r dir; do
    new_dir="$(dirname "$dir")/$(basename "$dir" | sed "s/${OLD_SNAKE}/${NEW_NAME}/g")"
    mv "$dir" "$new_dir"
    echo "  $dir -> $new_dir"
  done

# 4. Clean build artifacts
echo ""
echo "Cleaning build artifacts..."
rm -rf _build .elixir_ls

echo ""
echo "Done! Now run:"
echo ""
echo "  mix setup"
echo "  make run-dev"
echo ""
