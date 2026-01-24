import SwiftUI

struct TodoRowView: View {
    @Environment(TodoViewModel.self) private var viewModel
    let todo: TodoItem
    @State private var showingEditSheet = false

    var body: some View {
        HStack {
            Button {
                viewModel.toggleCompletion(for: todo)
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(todo.isCompleted ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(.plain)

            Text(todo.title)
                .strikethrough(todo.isCompleted)
                .foregroundStyle(todo.isCompleted ? .secondary : .primary)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showingEditSheet = true
        }
        .sheet(isPresented: $showingEditSheet) {
            EditTodoView(todo: todo)
        }
    }
}

#Preview {
    List {
        TodoRowView(todo: TodoItem(title: "サンプルTODO"))
        TodoRowView(todo: TodoItem(title: "完了済みTODO", isCompleted: true))
    }
    .environment(TodoViewModel())
}
