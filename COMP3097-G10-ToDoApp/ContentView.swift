import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let description: String
    let dueDate: String
    let addedOn: String
    let isUrgent: Bool
    let additionalDetails: String
}

struct ContentView: View {
    let tasks = [ // temporary data
        Task(title: "Buy groceries", category: "Personal", description: "Buy milk, eggs, and bread", dueDate: "2025-10-10", addedOn: "2025-09-25", isUrgent: true, additionalDetails: "Remember to check for discounts"),
        Task(title: "Finish project", category: "Work", description: "Complete the final report", dueDate: "2025-10-12", addedOn: "2025-09-25", isUrgent: false, additionalDetails: "Submit before the deadline"),
        Task(title: "Call plumber", category: "Home", description: "Fix the kitchen sink", dueDate: "2025-10-15", addedOn: "2025-09-25", isUrgent: false, additionalDetails: "Get a quote first")
    ]
    var body: some View {
        NavigationView {
            VStack {
                Text("To-Do Tasks")
                    .font(.title)
                    .padding(.top, 20)
                
                List(tasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                            Text("Category: \(task.category)")
                                .font(.subheadline)
                            Text("Due: \(task.dueDate)")
                                .font(.subheadline)
                                .bold()
                        }
                        .padding(.vertical, 5)
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
