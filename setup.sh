#!/bin/bash

# Claude Code Spec-Driven Development Setup Script

echo "======================================="
echo "Claude Code Spec-Driven Development"
echo "Project Setup Script"
echo "======================================="
echo ""

# Get project directory
read -p "Enter target project directory (. for current directory): " PROJECT_DIR
if [ "$PROJECT_DIR" = "." ]; then
    PROJECT_DIR=$(pwd)
fi

# Validate directory
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Directory $PROJECT_DIR does not exist."
    exit 1
fi

# Get project information
read -p "Enter project name: " PROJECT_NAME
echo "Enter project description (press Enter twice when done):"
PROJECT_DESCRIPTION=""
while IFS= read -r line; do
    [ -z "$line" ] && break
    PROJECT_DESCRIPTION="${PROJECT_DESCRIPTION}${line}
"
done

# Remove trailing newline
PROJECT_DESCRIPTION=$(echo -n "$PROJECT_DESCRIPTION" | sed 's/[[:space:]]*$//')

# Get development guidelines
echo "Enter development guidelines (optional, press Enter twice to skip):"
DEVELOPMENT_GUIDELINES=""
while IFS= read -r line; do
    [ -z "$line" ] && break
    DEVELOPMENT_GUIDELINES="${DEVELOPMENT_GUIDELINES}${line}
"
done

# Remove trailing newline
DEVELOPMENT_GUIDELINES=$(echo -n "$DEVELOPMENT_GUIDELINES" | sed 's/[[:space:]]*$//')

# Set default guidelines if empty
if [ -z "$DEVELOPMENT_GUIDELINES" ]; then
    DEVELOPMENT_GUIDELINES="- Follow project coding standards
- Write clean, maintainable code
- Add appropriate documentation"
fi

echo ""
echo "Setting up Claude Code Spec-Driven Development..."

# Create directories
echo "Creating directory structure..."
mkdir -p "$PROJECT_DIR/.claude/commands"
mkdir -p "$PROJECT_DIR/.kiro/steering"
mkdir -p "$PROJECT_DIR/.kiro/specs"

# Copy command files
echo "Copying command files..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp "$SCRIPT_DIR"/.claude/commands/kiro-*.md "$PROJECT_DIR/.claude/commands/" 2>/dev/null

if [ $? -ne 0 ]; then
    echo "Warning: Could not copy command files. Make sure they exist in the boilerplate directory."
fi

# Check if CLAUDE.md already exists
if [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    echo "Backing up existing CLAUDE.md to CLAUDE.md.backup..."
    cp "$PROJECT_DIR/CLAUDE.md" "$PROJECT_DIR/CLAUDE.md.backup"
fi

# Create CLAUDE.md from template
echo "Creating CLAUDE.md..."
if [ -f "$SCRIPT_DIR/CLAUDE.md.template" ]; then
    # Use sed to replace placeholders
    sed -e "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
        -e "s/{{PROJECT_DESCRIPTION}}/$PROJECT_DESCRIPTION/g" \
        -e "s/{{DEVELOPMENT_GUIDELINES}}/$DEVELOPMENT_GUIDELINES/g" \
        "$SCRIPT_DIR/CLAUDE.md.template" > "$PROJECT_DIR/CLAUDE.md"
else
    echo "Error: CLAUDE.md.template not found in boilerplate directory."
    exit 1
fi

# Create .gitkeep files
touch "$PROJECT_DIR/.kiro/steering/.gitkeep"
touch "$PROJECT_DIR/.kiro/specs/.gitkeep"

echo ""
echo "======================================="
echo "Setup Complete!"
echo "======================================="
echo ""
echo "Project: $PROJECT_NAME"
echo "Location: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "1. cd $PROJECT_DIR"
echo "2. Open Claude Code in this directory"
echo "3. Run /kiro:steering to create initial steering documents"
echo "4. Start creating specifications with /kiro:spec-init"
echo ""
echo "For more information, see README.md in the boilerplate directory."