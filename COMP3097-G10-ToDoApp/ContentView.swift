import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context

    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: []
    ) var tasks: FetchedResults<Task>

    @State private var isUpcomingExpanded = true
    @State private var isOverdueExpanded = true
    @State private var isCompletedExpanded = false

    var body: some View {
        NavigationView {
            VStack {
                Text("To-Do Tasks")
                    .font(.title)
                    .padding(.top, 20)

                List {
                    DisclosureGroup("Upcoming Tasks", isExpanded: $isUpcomingExpanded) {
                        ForEach(tasks.filter { $0.taskDueDate ?? Date() >= Date() && !$0.taskIsCompleted }, id: \.self) { task in
                            TaskRow(task: task)
                        }
                    }

                    DisclosureGroup("Overdue Tasks", isExpanded: $isOverdueExpanded) {
                        ForEach(tasks.filter { $0.taskDueDate ?? Date() < Date() && !$0.taskIsCompleted }, id: \.self) { task in
                            TaskRow(task: task)
                        }
                    }

                    DisclosureGroup("Completed Tasks", isExpanded: $isCompletedExpanded) {
                        ForEach(tasks.filter { $0.taskIsCompleted }, id: \.self) { task in
                            TaskRow(task: task)
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

struct TaskRow: View {
    var task: Task

    var body: some View {
        NavigationLink(destination: TaskDetailView(task: task)) {
            VStack(alignment: .leading) {
                HStack {
                    Text(task.taskTitle ?? "No Title")
                        .font(.headline)
                    if task.taskIsUrgent {
                        Text("[!]")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                    if let dueDate = task.taskDueDate, dueDate < Date() {
                        Text("[overdue]")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                }
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
            .cornerRadius(10)
        }
    }
}

#Preview {
    ContentView()
}
