import SwiftUI

struct ContentView: View {
    @Environment(TodoViewModel.self) private var viewModel
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            TodoListView()
                .navigationTitle("TODO")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showingAddSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddSheet) {
                    AddTodoView()
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(TodoViewModel())
}
