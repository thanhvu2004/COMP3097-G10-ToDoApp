import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context

    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: []
    ) var task: FetchedResults<Task>

    var body: some View {
        NavigationView {
            VStack {
                Text("To-Do Tasks")
                    .font(.title)
                    .padding(.top, 20)

                List {
                    ForEach(task, id: \.self) { task in
                        NavigationLink(destination: TaskDetailView(task: task)) {
                            VStack(alignment: .leading) {
                                Text(task.taskTitle ?? "No Title")
                                    .font(.headline)
                                Text("Category: \(task.taskCategory ?? "No Category")")
                                    .font(.subheadline)
                                if let dueDate = task.taskDueDate {
                                    Text("Due: \(dueDate, style: .date)")
                                        .font(.subheadline)
                                        .bold()
                                } else {
                                    Text("Due: No Due Date")
                                        .font(.subheadline)
                                        .bold()
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }

                Spacer()

                NavigationLink(destination: AddTaskView()) {
                    Text("+")
                        .font(.largeTitle)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ContentView()
}
