import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let dueDate: String
}

struct ContentView: View {
    let tasks = [ // temporary data
        Task(title: "Buy groceries", category: "Personal", dueDate: "2023-10-10"),
        Task(title: "Finish project", category: "Work", dueDate: "2023-10-12"),
        Task(title: "Call plumber", category: "Home", dueDate: "2023-10-15")
    ]
    
    var body: some View {
        VStack {
            Text("To-Do Tasks")
                .font(.title)
                .padding(.top, 20)
            
            List(tasks) { task in
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
            
            Spacer()
            
            Button(action: {
                // navigate to the new task screen
                
            }) {
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

#Preview {
    ContentView()
}
