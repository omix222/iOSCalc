import XCTest
@testable import TodoApp

final class TodoItemTests: XCTestCase {

    // MARK: - Initialization Tests

    func testInitWithDefaultValues() {
        let todo = TodoItem(title: "Test Task")

        XCTAssertFalse(todo.title.isEmpty)
        XCTAssertEqual(todo.title, "Test Task")
        XCTAssertFalse(todo.isCompleted)
        XCTAssertNotNil(todo.id)
        XCTAssertNotNil(todo.createdAt)
    }

    func testInitWithCustomValues() {
        let customDate = Date(timeIntervalSince1970: 1000)
        let customId = UUID()

        let todo = TodoItem(
            id: customId,
            title: "Custom Task",
            isCompleted: true,
            createdAt: customDate
        )

        XCTAssertEqual(todo.id, customId)
        XCTAssertEqual(todo.title, "Custom Task")
        XCTAssertTrue(todo.isCompleted)
        XCTAssertEqual(todo.createdAt, customDate)
    }

    // MARK: - Codable Tests

    func testEncodingAndDecoding() throws {
        let originalTodo = TodoItem(
            title: "Encodable Task",
            isCompleted: true
        )

        let encoder = JSONEncoder()
        let data = try encoder.encode(originalTodo)

        let decoder = JSONDecoder()
        let decodedTodo = try decoder.decode(TodoItem.self, from: data)

        XCTAssertEqual(originalTodo, decodedTodo)
    }

    func testDecodingFromJSON() throws {
        let json = """
        {
            "id": "550e8400-e29b-41d4-a716-446655440000",
            "title": "JSON Task",
            "isCompleted": false,
            "createdAt": 0
        }
        """

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        let data = json.data(using: .utf8)!
        let todo = try decoder.decode(TodoItem.self, from: data)

        XCTAssertEqual(todo.title, "JSON Task")
        XCTAssertFalse(todo.isCompleted)
    }

    // MARK: - Equatable Tests

    func testEquality() {
        let id = UUID()
        let date = Date()

        let todo1 = TodoItem(id: id, title: "Task", isCompleted: false, createdAt: date)
        let todo2 = TodoItem(id: id, title: "Task", isCompleted: false, createdAt: date)

        XCTAssertEqual(todo1, todo2)
    }

    func testInequalityWithDifferentId() {
        let date = Date()

        let todo1 = TodoItem(id: UUID(), title: "Task", isCompleted: false, createdAt: date)
        let todo2 = TodoItem(id: UUID(), title: "Task", isCompleted: false, createdAt: date)

        XCTAssertNotEqual(todo1, todo2)
    }

    func testInequalityWithDifferentTitle() {
        let id = UUID()
        let date = Date()

        let todo1 = TodoItem(id: id, title: "Task 1", isCompleted: false, createdAt: date)
        let todo2 = TodoItem(id: id, title: "Task 2", isCompleted: false, createdAt: date)

        XCTAssertNotEqual(todo1, todo2)
    }

    func testInequalityWithDifferentCompletionStatus() {
        let id = UUID()
        let date = Date()

        let todo1 = TodoItem(id: id, title: "Task", isCompleted: false, createdAt: date)
        let todo2 = TodoItem(id: id, title: "Task", isCompleted: true, createdAt: date)

        XCTAssertNotEqual(todo1, todo2)
    }
}
