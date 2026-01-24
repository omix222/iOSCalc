import SwiftUI

struct EditTodoView: View {
    @Environment(TodoViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    let todo: TodoItem
    @State private var title: String
    @FocusState private var isFocused: Bool

    init(todo: TodoItem) {
        self.todo = todo
        self._title = State(initialValue: todo.title)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("TODOを入力", text: $title)
                        .focused($isFocused)
                }

                Section {
                    Button(role: .destructive) {
                        viewModel.deleteTodo(todo)
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("削除")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("編集")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        viewModel.updateTodo(todo, newTitle: title)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onAppear {
                isFocused = true
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    EditTodoView(todo: TodoItem(title: "サンプルTODO"))
        .environment(TodoViewModel())
}
