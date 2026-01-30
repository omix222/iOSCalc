# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SwiftUI iOS Todo app using MVVM architecture. iOS 17.0+, Swift 5.9, Xcode 15.0+. No external dependencies. Project files are generated with XcodeGen from `project.yml`.

## Commands

```bash
# Generate Xcode project from project.yml (required after cloning or modifying project.yml)
xcodegen generate

# Build
xcodebuild build -scheme TodoApp -destination 'platform=iOS Simulator,name=iPhone 16'

# Run all tests
xcodebuild test -scheme TodoApp -destination 'platform=iOS Simulator,name=iPhone 16'

# Run a single test class
xcodebuild test -scheme TodoApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:TodoAppTests/TodoItemTests

# Run a single test method
xcodebuild test -scheme TodoApp -destination 'platform=iOS Simulator,name=iPhone 16' -only-testing:TodoAppTests/TodoViewModelTests/testAddTodoWithValidTitle
```

## Architecture

MVVM with SwiftUI's `@Observable` (Observation framework). Single `TodoViewModel` is created in `TodoAppApp` and injected via `.environment()` to the view hierarchy.

**Data flow:** `TodoAppApp` → `ContentView` → `TodoListView` → `TodoRowView`. Add/Edit use modal sheets (`AddTodoView`, `EditTodoView`).

**Persistence:** `TodoViewModel` serializes `[TodoItem]` to JSON and stores in `UserDefaults` under key `"SavedTodos"`. Every mutation (add, toggle, delete, update) triggers a save.

**Threading:** `TodoViewModel` is `@MainActor` and `final`.

## Key Conventions

- UI text is in Japanese (e.g. "シンプルTODOアプリ", "TODOがありません")
- New todos are inserted at index 0 (newest first)
- All title inputs are trimmed; empty/whitespace-only titles are rejected
- Tests clear `UserDefaults` in setUp/tearDown for isolation
