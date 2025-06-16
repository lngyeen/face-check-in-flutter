# face-check-in-flutter
Flutter app for face recognition and smart check-in functionality.

## ⚡ Quick Start

### Prerequisites
- **Flutter 3.29.0** (managed via FVM)
- **Dart SDK 3.7.0+**
- **FVM (Flutter Version Management)**

### Setup for New Developers

1. **Clone the repository:**
   ```bash
   git clone <repo-url>
   cd face-check-in-flutter
   ```

2. **Install FVM (if not already installed):**
   ```bash
   dart pub global activate fvm
   ```

3. **Setup Flutter version and dependencies:**
   ```bash
   make setup
   ```
   Or manually:
   ```bash
   fvm install 3.29.0
   fvm use 3.29.0
   fvm flutter pub get
   ```

4. **Run the app:**
   ```bash
   make run
   # or
   fvm flutter run
   ```

### Available Commands
Run `make help` to see all available commands:
- `make setup` - Install Flutter 3.29.0 and dependencies
- `make run` - Run the app
- `make build` - Build APK
- `make test` - Run tests
- `make clean` - Clean and refresh dependencies

### 🚨 Important Notes
- This project **requires Flutter 3.29.0** specifically
- Use `fvm flutter` instead of `flutter` for all commands
- VS Code will automatically use the correct Flutter version if configured properly

## TODO - Development Process Improvements

### 🚀 Vibe Coding Optimization
1. **Optimize sprint planning files for vibe coding compatibility:**
   - [ ] `bmad-agent/tasks/create-sprint-planning.md` - Update workflow to align with vibe coding patterns
   - [ ] `bmad-agent/templates/sprint-planning-tmpl.md` - Adjust template for AI-enhanced development with vibe coding
   - [ ] `bmad-agent/checklists/sprint-planning-checklist.md` - Optimize checklist for vibe coding workflow

2. **Create branch naming rule:**
   - [ ] Create rule in `.cursor/rules/` to define branch naming convention when agents perform tasks
   - [ ] Ensure consistent naming convention across all agents
   - [ ] Integrate into workflow of dev agents (Flutter Dev, Full Stack Dev, Frontend Dev)

### 📋 Improvement Details

#### Sprint Planning Files Optimization
- **Vibe Coding Integration**: Optimize sprint planning files to better leverage vibe coding capabilities for rapid and efficient code generation
- **AI-Human Collaboration**: Improve coordination process between AI and humans in sprint planning
- **Context Management**: Optimize context management for AI tools during sprint execution

#### Branch Naming Rule
- **Consistency**: Ensure all agents use the same convention when creating branches
- **Traceability**: Easy to trace back from branch to task and the agent that performed it
- **Integration**: Integrate with git workflow and CI/CD pipeline

---
