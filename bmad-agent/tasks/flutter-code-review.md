# Flutter Code Review Task

## Purpose

To perform comprehensive code review of pull requests by analyzing the code changes against story requirements, project standards, and Flutter best practices. This task ensures code quality, adherence to project guidelines, and proper implementation of story acceptance criteria before merging.

## Inputs for this Task

- **Branch name** (provided by user when task is initiated)
- **Story file** (automatically located based on branch naming convention or user specification)
- **Project standards** (from `docs/operational-guidelines.md`)
- **Current codebase** (for context and comparison)
- **DoD checklist** (from `bmad-agent/checklists/story-dod-checklist.md`)

## Task Execution Instructions

### 1. Gather Review Context

**Branch Information Collection:**
- Ask user: "What branch should I review? Please provide the branch name."
- If branch follows naming convention (e.g., `feature/epic-X-story-Y`), extract story reference
- If no clear story reference in branch name, ask: "Which story file should I reference for this review? (e.g., `1.2.story.md`)"

**Pull Code and Analyze Changes:**
- Execute: `git fetch origin`
- Execute: `git checkout {branch-name}`
- Execute: `git diff main...{branch-name} --name-only` to get changed files
- Execute: `git diff main...{branch-name}` to get detailed changes
- Document all changed files and their modification types (new, modified, deleted)

### 2. Load Story Context

**Story File Analysis:**
- Locate and read story file: `docs/stories/{epic}.{story}.story.md`
- Extract and document:
  - Story title and description
  - Acceptance criteria (ACs)
  - Technical requirements
  - Dependencies mentioned
  - DoD requirements specific to this story
- If story file is not found or unclear, ask user for clarification

### 3. Load Project Standards

**Reference Documentation Review:**
- Read `docs/operational-guidelines.md` for coding standards
- Read `docs/project-structure.md` for architecture compliance
- Read `docs/tech-stack.md` for technology alignment
- Read `bmad-agent/checklists/story-dod-checklist.md` for quality standards

### 4. Perform Comprehensive Flutter Code Review

**A. Story Compliance Review:**
- Verify each acceptance criteria is implemented correctly
- Check that all story requirements are addressed
- Validate that no scope creep has occurred
- Ensure story-specific technical requirements are met

**B. Flutter/Dart Code Quality Review:**
- **Widget Structure & Composition:**
  - Proper widget hierarchy and composition
  - Efficient widget rebuilding strategies
  - Correct use of StatelessWidget vs StatefulWidget
  - Proper key usage for widget identification
- **State Management (BLoC):**
  - Correct BLoC pattern implementation
  - Proper event/state definitions
  - Appropriate state transitions
  - Error state handling
  - Stream disposal and resource cleanup
- **Dependency Injection:**
  - Correct GetIt/Injectable setup
  - Proper service registration
  - Appropriate scope management
  - Clean dependency graph
- **Navigation (GoRouter):**
  - Proper route configuration
  - Correct parameter passing
  - Navigation state management
  - Deep linking implementation
- **Networking (Dio/Retrofit):**
  - Proper API client setup
  - Error handling and retry logic
  - Request/response interceptors
  - Timeout and caching strategies
- **Camera & Image Processing:**
  - Proper camera lifecycle management
  - Image processing pipeline efficiency
  - Memory management for image data
  - Stream handling for real-time processing
- **WebSocket Integration:**
  - Connection lifecycle management
  - Message serialization/deserialization
  - Error handling and reconnection logic
  - Stream disposal and cleanup

**C. Clean Architecture Compliance:**
- **Presentation Layer:**
  - Proper separation of UI and business logic
  - Correct BLoC/Cubit usage
  - Widget composition best practices
  - State management implementation
- **Domain Layer:**
  - Pure business logic implementation
  - Proper entity definitions
  - Use case implementation
  - Repository interface definitions
- **Data Layer:**
  - Repository pattern implementation
  - Data source abstraction
  - Model/Entity mapping
  - Error handling and validation

**D. Testing Coverage:**
- **Unit Tests:**
  - Business logic coverage
  - Use case testing
  - Repository implementation tests
  - BLoC/Cubit state testing
- **Widget Tests:**
  - UI component testing
  - User interaction testing
  - Widget state verification
  - Golden tests for UI consistency
- **Integration Tests:**
  - End-to-end flow testing
  - API integration testing
  - Database integration testing
  - Camera and real-time features testing

**E. Security & Performance:**
- **Security:**
  - Input validation and sanitization
  - Secure data storage
  - Authentication/authorization
  - Sensitive data protection
  - Network security (SSL/TLS)
- **Performance:**
  - Memory leak detection
  - Efficient widget rebuilding
  - Image loading optimization
  - Network request optimization
  - Stream and subscription management

### 5. Generate Flutter-Specific Review Report

**Create Comprehensive Review Summary:**
- **Overall Assessment:** APPROVE / REQUEST CHANGES / NEEDS DISCUSSION
- **Story Compliance:** ✅ Met / ⚠️ Partially Met / ❌ Not Met
- **Flutter Code Quality:** High / Medium / Low
- **Architecture Compliance:** ✅ Clean / ⚠️ Minor Issues / ❌ Major Issues
- **Critical Issues:** List any blocking issues
- **Recommendations:** List improvement suggestions

**Detailed Flutter Review Report:**

```markdown
# Flutter Code Review Report

## Branch: {branch-name}
## Story: {story-reference}
## Reviewer: David (Flutter Dev)
## Date: {current-date}

---

## ✅ Story Compliance
- [ ] AC1: {acceptance-criteria-1} - {status-and-notes}
- [ ] AC2: {acceptance-criteria-2} - {status-and-notes}
- [ ] AC3: {acceptance-criteria-3} - {status-and-notes}

## 🏗️ Clean Architecture
- [ ] Presentation layer separation
- [ ] Domain layer purity
- [ ] Data layer abstraction
- [ ] Dependency direction compliance

## 📱 Flutter/Dart Best Practices
- [ ] Widget composition
- [ ] State management (BLoC)
- [ ] Dependency injection (GetIt)
- [ ] Navigation (GoRouter)
- [ ] Networking (Dio/Retrofit)
- [ ] Camera integration
- [ ] WebSocket handling

## 🔧 Code Quality
- [ ] Dart conventions
- [ ] Naming consistency
- [ ] Code readability
- [ ] Error handling
- [ ] Resource management

## 🧪 Testing Coverage
- [ ] Unit tests
- [ ] Widget tests
- [ ] Integration tests
- [ ] Test quality & coverage

## 🔒 Security & Performance
- [ ] Input validation
- [ ] Data protection
- [ ] Memory management
- [ ] Performance optimization

## 📁 Changed Files Analysis
### Core Files
{dart-files-analysis}

### UI Components
{widget-files-analysis}

### Business Logic
{bloc-cubit-files-analysis}

### Data Layer
{repository-datasource-analysis}

### Tests
{test-files-analysis}

## 🚨 Critical Issues
{blocking-issues-specific-to-flutter}

## 💡 Flutter-Specific Recommendations
{flutter-dart-improvements}

## 📋 DoD Compliance
{story-dod-checklist-verification}

---
## Final Recommendation: {APPROVE/REQUEST_CHANGES/NEEDS_DISCUSSION}
```

### 6. Interactive Flutter Review Session

**Present Flutter-Specific Findings:**
- Highlight Flutter/Dart specific issues
- Explain BLoC pattern compliance
- Discuss Clean Architecture adherence
- Review camera and WebSocket implementations
- Analyze real-time processing efficiency

**Handle Technical Discussions:**
- Explain Flutter best practices
- Discuss alternative implementation approaches
- Provide Flutter-specific code examples
- Suggest performance optimizations

### 7. Flutter-Specific Follow-up Actions

**If APPROVE:**
- Confirm Flutter best practices are followed
- Suggest minor Flutter optimizations
- Validate camera/WebSocket implementation
- Confirm story meets Flutter standards

**If REQUEST CHANGES:**
- Provide Flutter-specific code examples
- Explain Clean Architecture violations
- Suggest BLoC pattern improvements
- Recommend testing enhancements

**If NEEDS DISCUSSION:**
- Discuss Flutter architecture decisions
- Clarify state management approaches
- Review performance implications
- Address security considerations

## Flutter Review Commands

- `*flutter-analysis` - Run Flutter analyzer on changed files
- `*bloc-review` - Focus on BLoC pattern implementation
- `*widget-review` - Analyze widget composition and performance
- `*camera-review` - Review camera integration and image processing
- `*websocket-review` - Analyze WebSocket and streaming implementation
- `*clean-arch-check` - Verify Clean Architecture compliance
- `*performance-check` - Analyze Flutter performance implications
- `*test-flutter` - Run Flutter tests for changed code

## Flutter-Specific Review Patterns

### State Management Excellence
- Proper BLoC lifecycle management
- Correct event/state handling
- Efficient state transitions
- Error state management
- Stream disposal best practices

### Widget Performance
- Efficient widget rebuilding
- Correct use of const constructors
- Proper key usage
- Widget composition over inheritance
- Performance-conscious design

### Clean Architecture in Flutter
- Presentation: BLoC + Widgets
- Domain: Use cases + Entities
- Data: Repositories + Data sources
- Proper dependency injection

### Camera & Real-time Processing
- Camera lifecycle management
- Image processing efficiency
- Memory management
- Stream handling optimization
- Real-time data transmission

### WebSocket Integration
- Connection management
- Message handling
- Error recovery
- Stream processing
- Resource cleanup

## Quality Gates for Flutter

- **Code Quality:** Flutter analyzer passing
- **Architecture:** Clean Architecture compliance
- **State Management:** Proper BLoC implementation
- **Testing:** Comprehensive test coverage
- **Performance:** No memory leaks, efficient rebuilds
- **Security:** Secure data handling
- **Real-time Features:** Proper camera/WebSocket integration 