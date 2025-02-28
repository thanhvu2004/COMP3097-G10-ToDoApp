import SwiftUI

struct TaskDetailView: View {
    let task: Task

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(task.title)
                    .font(.largeTitle)
                if task.isUrgent {
                    Text("[!]")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }
            Text(task.category)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Description: \(task.description)")
                .font(.body)
                .padding(.top, 20)
            Text("Due Date: \(task.dueDate)")
                .font(.body)
                .padding(.top, 20)
            Text("Added on: \(task.addedOn)")
                .font(.footnote)
                .foregroundColor(.gray)
            Text("Additional details:")
                .padding(.top, 20)
            Text(task.additionalDetails)
                .font(.body)
                            
            VStack {
                HStack {
                    Button(action: {
                        // Delete action
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        // Edit action
                    }) {
                        HStack {
                            Image(systemName: "pencil")
                            Text("Edit")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                Button(action: {
                    // Mark as Complete action
                }) {
                    HStack {
                        Image(systemName: "checkmark")
                        Text("Complete")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding([.top, .trailing])
        }
        .padding(.leading, 25)
        .navigationTitle("Task Details")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    TaskDetailView(task: Task(title: "Buy groceries", category: "Personal", description: "Buy milk, eggs, and bread", dueDate: "2023-10-10", addedOn: "2025-09-25", isUrgent: true, additionalDetails: "Remember to check for discounts"))
}
