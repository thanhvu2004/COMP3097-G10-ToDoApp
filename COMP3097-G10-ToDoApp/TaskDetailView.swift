import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var showEditView = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(task.taskTitle ?? "No Title")
                    .font(.largeTitle)
                if task.taskIsUrgent {
                    Text("[!]")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }
            Text(task.taskCategory ?? "No Category")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Description: \(task.taskDescription ?? "No Description")")
                .font(.body)
                .padding(.top, 20)
            if let dueDate = task.taskDueDate {
                Text("Due Date: \(dueDate, style: .date)")
                    .font(.body)
                    .padding(.top, 20)
            } else {
                Text("Due Date: No Due Date")
                    .font(.body)
                    .padding(.top, 20)
            }
            if let addedOn = task.taskAddedOn {
                Text("Added on: \(addedOn, style: .date)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            } else {
                Text("Added on: No Date")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Text("Additional details:")
                .padding(.top, 20)
            Text(task.taskAdditionalDetails ?? "No Additional Details")
                .font(.body)
                            
            VStack {
                VStack {
                    Button(action: { // delete button
                        showAlert = true
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
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Delete Task"),
                            message: Text("Are you sure you want to delete this task?"),
                            primaryButton: .destructive(Text("Delete")) {
                                deleteTask()
                            },
                            secondaryButton: .cancel()
                        )
                    }

                    if task.taskIsCompleted {
                        Button(action: { // uncomplete button
                            markAsIncomplete()
                        }) {
                            HStack {
                                Image(systemName: "arrow.uturn.backward")
                                Text("Uncomplete")
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    } else {
                        Button(action: { // edit button
                            showEditView = true
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
                        .sheet(isPresented: $showEditView) {
                            EditTaskView(task: task)
                        }

                        Button(action: { // complete button
                            markAsComplete()
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
                }
            }
            .padding([.top, .trailing])
        }
        .padding(.leading, 25)
        .navigationTitle("Task Details")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private func deleteTask() {
        context.delete(task)
        do {
            try context.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to delete task: \(error.localizedDescription)")
        }
    }

    private func markAsComplete() {
        task.taskIsCompleted = true
        do {
            try context.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to mark task as complete: \(error.localizedDescription)")
        }
    }

    private func markAsIncomplete() {
        task.taskIsCompleted = false
        do {
            try context.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to mark task as incomplete: \(error.localizedDescription)")
        }
    }
}
