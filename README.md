# Claude Code Spec-Driven Development Boilerplate

A boilerplate template for implementing Kiro-style Spec-Driven Development methodology with Claude Code using slash commands, hooks, and agents.

## Overview

This boilerplate provides a structured approach to software development that leverages Claude Code's capabilities for specification-driven development. It includes pre-configured commands and directory structures to help teams maintain consistent development practices.

## Features

- **Specification-driven workflow**: Requirements → Design → Tasks → Implementation
- **Steering documents**: Project-wide context and guidelines
- **Interactive approval system**: Built-in review checkpoints
- **Pre-configured commands**: 8 kiro commands for complete workflow
- **Flexible architecture**: Supports various project types and technologies

## Quick Start

### 1. Clone or Download

```bash
git clone https://github.com/yourusername/claude-code-spec-boilerplate.git
cd claude-code-spec-boilerplate
```

### 2. Run Setup Script

```bash
chmod +x setup.sh
./setup.sh
```

The setup script will:
- Prompt for your project name and description
- Create necessary directory structure
- Copy command files to your project
- Generate customized CLAUDE.md from template

### 3. Manual Setup (Alternative)

If you prefer manual setup:

```bash
# Copy the directory structure
cp -r .claude /path/to/your/project/
cp -r .kiro /path/to/your/project/

# Customize CLAUDE.md.template
cp CLAUDE.md.template /path/to/your/project/CLAUDE.md
# Edit the placeholders: {{PROJECT_NAME}}, {{PROJECT_DESCRIPTION}}, {{DEVELOPMENT_GUIDELINES}}
```

## Directory Structure

```
your-project/
├── .claude/
│   └── commands/        # Kiro slash commands
├── .kiro/
│   ├── steering/        # Project-wide context documents
│   └── specs/           # Feature specifications
└── CLAUDE.md            # Claude Code configuration
```

## Available Commands

### Initialization & Steering

- `/kiro:init` - Initialize Claude Code Spec-Driven Development in existing project
- `/kiro:steering` - Create/update project steering documents
- `/kiro:steering-custom` - Create custom steering for specialized contexts

### Specification Workflow

1. `/kiro:spec-init [description]` - Initialize new feature specification
2. `/kiro:spec-requirements [feature]` - Generate requirements document
3. `/kiro:spec-design [feature]` - Generate design document (with approval check)
4. `/kiro:spec-tasks [feature]` - Generate implementation tasks (with approval check)
5. `/kiro:spec-status [feature]` - Check specification progress

## Workflow Overview

### Phase 0: Project Setup (Optional)
- Run `/kiro:steering` to establish project context
- Creates product.md, tech.md, and structure.md

### Phase 1: Specification Creation
1. Initialize spec with detailed description
2. Generate requirements in EARS format
3. Create technical design (requires requirements approval)
4. Define implementation tasks (requires design approval)

### Phase 2: Implementation
- Follow generated tasks
- Update task status as you progress
- Maintain alignment with specifications

## Steering vs Specifications

### Steering Documents (`.kiro/steering/`)
- **Purpose**: Project-wide guidelines and context
- **Scope**: Applies to entire codebase
- **Files**:
  - `product.md`: Business context and objectives
  - `tech.md`: Technology stack and constraints
  - `structure.md`: Code organization patterns

### Specifications (`.kiro/specs/`)
- **Purpose**: Feature-specific development plans
- **Scope**: Individual features or modules
- **Structure**: Requirements → Design → Tasks

## Best Practices

1. **Start with Steering**: Run `/kiro:steering` for new projects
2. **Detailed Descriptions**: Provide comprehensive feature descriptions
3. **Review Checkpoints**: Take approval prompts seriously
4. **Update Regularly**: Keep steering current after major changes
5. **Track Progress**: Use `/kiro:spec-status` to monitor development

## Customization

### CLAUDE.md Template Variables
- `{{PROJECT_NAME}}`: Your project's name
- `{{PROJECT_DESCRIPTION}}`: Brief project description
- `{{DEVELOPMENT_GUIDELINES}}`: Project-specific guidelines

### Adding Custom Commands
Place new command files in `.claude/commands/` following the existing format:
```markdown
---
description: Command description
allowed-tools: Tool1, Tool2, Tool3
---

# Command Name

Command implementation...
```

## Language Support

The default configuration supports Japanese responses while maintaining English thinking:
```
## Development Guidelines
- Think in English, but generate responses in Japanese (思考は英語、回答の生成は日本語で行うように)
```

Modify this in CLAUDE.md for your preferred language configuration.

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for improvements.

## License

This boilerplate is released under the MIT License. See LICENSE file for details.