import SwiftUI

struct TodoListView: View {
    @Environment(TodoViewModel.self) private var viewModel

    var body: some View {
        Group {
            if viewModel.todos.isEmpty {
                ContentUnavailableView(
                    "TODOがありません",
                    systemImage: "checklist",
                    description: Text("右上の + ボタンから追加できます")
                )
            } else {
                List {
                    ForEach(viewModel.todos) { todo in
                        TodoRowView(todo: todo)
                    }
                    .onDelete { offsets in
                        viewModel.deleteTodo(at: offsets)
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
    }
}

#Preview {
    TodoListView()
        .environment(TodoViewModel())
}
