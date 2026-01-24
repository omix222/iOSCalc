import XCTest
@testable import TodoApp

@MainActor
final class TodoViewModelTests: XCTestCase {

    private var viewModel: TodoViewModel!
    private let testSaveKey = "SavedTodos"

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: testSaveKey)
        viewModel = TodoViewModel()
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: testSaveKey)
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Add Todo Tests

    func testAddTodoWithValidTitle() {
        viewModel.addTodo(title: "New Task")

        XCTAssertEqual(viewModel.todos.count, 1)
        XCTAssertEqual(viewModel.todos.first?.title, "New Task")
        XCTAssertFalse(viewModel.todos.first?.isCompleted ?? true)
    }

    func testAddTodoWithEmptyTitleDoesNothing() {
        viewModel.addTodo(title: "")

        XCTAssertTrue(viewModel.todos.isEmpty)
    }

    func testAddTodoWithWhitespaceOnlyTitleDoesNothing() {
        viewModel.addTodo(title: "   ")

        XCTAssertTrue(viewModel.todos.isEmpty)
    }

    func testAddTodoTrimsWhitespace() {
        viewModel.addTodo(title: "  Trimmed Task  ")

        XCTAssertEqual(viewModel.todos.first?.title, "Trimmed Task")
    }

    func testAddTodoInsertsAtBeginning() {
        viewModel.addTodo(title: "First Task")
        viewModel.addTodo(title: "Second Task")

        XCTAssertEqual(viewModel.todos.count, 2)
        XCTAssertEqual(viewModel.todos[0].title, "Second Task")
        XCTAssertEqual(viewModel.todos[1].title, "First Task")
    }

    // MARK: - Toggle Completion Tests

    func testToggleCompletionFromFalseToTrue() {
        viewModel.addTodo(title: "Test Task")
        let todo = viewModel.todos[0]

        XCTAssertFalse(viewModel.todos[0].isCompleted)

        viewModel.toggleCompletion(for: todo)

        XCTAssertTrue(viewModel.todos[0].isCompleted)
    }

    func testToggleCompletionFromTrueToFalse() {
        viewModel.addTodo(title: "Test Task")
        let todo = viewModel.todos[0]

        viewModel.toggleCompletion(for: todo)
        XCTAssertTrue(viewModel.todos[0].isCompleted)

        let updatedTodo = viewModel.todos[0]
        viewModel.toggleCompletion(for: updatedTodo)

        XCTAssertFalse(viewModel.todos[0].isCompleted)
    }

    func testToggleCompletionWithNonExistentTodoDoesNothing() {
        viewModel.addTodo(title: "Existing Task")
        let nonExistentTodo = TodoItem(title: "Non-existent")

        viewModel.toggleCompletion(for: nonExistentTodo)

        XCTAssertEqual(viewModel.todos.count, 1)
        XCTAssertFalse(viewModel.todos[0].isCompleted)
    }

    // MARK: - Delete Todo Tests

    func testDeleteTodoAtOffset() {
        viewModel.addTodo(title: "Task 1")
        viewModel.addTodo(title: "Task 2")
        viewModel.addTodo(title: "Task 3")

        viewModel.deleteTodo(at: IndexSet(integer: 1))

        XCTAssertEqual(viewModel.todos.count, 2)
        XCTAssertEqual(viewModel.todos[0].title, "Task 3")
        XCTAssertEqual(viewModel.todos[1].title, "Task 1")
    }

    func testDeleteTodoByItem() {
        viewModel.addTodo(title: "Task 1")
        viewModel.addTodo(title: "Task 2")
        let todoToDelete = viewModel.todos[0]

        viewModel.deleteTodo(todoToDelete)

        XCTAssertEqual(viewModel.todos.count, 1)
        XCTAssertEqual(viewModel.todos[0].title, "Task 1")
    }

    func testDeleteNonExistentTodoDoesNothing() {
        viewModel.addTodo(title: "Existing Task")
        let nonExistentTodo = TodoItem(title: "Non-existent")

        viewModel.deleteTodo(nonExistentTodo)

        XCTAssertEqual(viewModel.todos.count, 1)
    }

    // MARK: - Update Todo Tests

    func testUpdateTodoTitle() {
        viewModel.addTodo(title: "Original Title")
        let todo = viewModel.todos[0]

        viewModel.updateTodo(todo, newTitle: "Updated Title")

        XCTAssertEqual(viewModel.todos[0].title, "Updated Title")
    }

    func testUpdateTodoTrimsWhitespace() {
        viewModel.addTodo(title: "Original")
        let todo = viewModel.todos[0]

        viewModel.updateTodo(todo, newTitle: "  Updated  ")

        XCTAssertEqual(viewModel.todos[0].title, "Updated")
    }

    func testUpdateNonExistentTodoDoesNothing() {
        viewModel.addTodo(title: "Existing Task")
        let nonExistentTodo = TodoItem(title: "Non-existent")

        viewModel.updateTodo(nonExistentTodo, newTitle: "New Title")

        XCTAssertEqual(viewModel.todos.count, 1)
        XCTAssertEqual(viewModel.todos[0].title, "Existing Task")
    }

    // MARK: - Persistence Tests

    func testTodosArePersisted() {
        viewModel.addTodo(title: "Persistent Task")

        let newViewModel = TodoViewModel()

        XCTAssertEqual(newViewModel.todos.count, 1)
        XCTAssertEqual(newViewModel.todos[0].title, "Persistent Task")
    }

    func testDeletedTodosArePersistedCorrectly() {
        viewModel.addTodo(title: "Task 1")
        viewModel.addTodo(title: "Task 2")
        viewModel.deleteTodo(viewModel.todos[0])

        let newViewModel = TodoViewModel()

        XCTAssertEqual(newViewModel.todos.count, 1)
        XCTAssertEqual(newViewModel.todos[0].title, "Task 1")
    }

    func testCompletionStatusIsPersisted() {
        viewModel.addTodo(title: "Task")
        viewModel.toggleCompletion(for: viewModel.todos[0])

        let newViewModel = TodoViewModel()

        XCTAssertTrue(newViewModel.todos[0].isCompleted)
    }
}
