import Foundation
import SwiftUI

@MainActor
@Observable
final class TodoViewModel {
    private(set) var todos: [TodoItem] = []

    private let saveKey = "SavedTodos"

    init() {
        loadTodos()
    }

    func addTodo(title: String) {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let newTodo = TodoItem(title: title.trimmingCharacters(in: .whitespacesAndNewlines))
        todos.insert(newTodo, at: 0)
        saveTodos()
    }

    func toggleCompletion(for todo: TodoItem) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos[index].isCompleted.toggle()
        saveTodos()
    }

    func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
        saveTodos()
    }

    func deleteTodo(_ todo: TodoItem) {
        todos.removeAll { $0.id == todo.id }
        saveTodos()
    }

    func updateTodo(_ todo: TodoItem, newTitle: String) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos[index].title = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        saveTodos()
    }

    private func saveTodos() {
        if let encoded = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    private func loadTodos() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) {
            todos = decoded
        }
    }
}
