import SwiftUI

struct AddTodoView: View {
    @Environment(TodoViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("TODOを入力", text: $title)
                        .focused($isFocused)
                }
            }
            .navigationTitle("新規TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("追加") {
                        viewModel.addTodo(title: title)
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
    AddTodoView()
        .environment(TodoViewModel())
}
