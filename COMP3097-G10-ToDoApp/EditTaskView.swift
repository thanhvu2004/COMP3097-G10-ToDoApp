//
//  EditTaskView.swift
//  COMP3097-G10-ToDoApp
//
//  Created by Thành Vũ Lê on 2025-04-03.
//

import SwiftUI
import CoreData

struct EditTaskView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String
    @State private var category: String
    @State private var description: String
    @State private var dueDate: Date
    @State private var isUrgent: Bool
    @State private var additionalDetails: String
    @State private var showAlert: Bool = false
    @State private var showSuccess: Bool = false

    var task: Task

    init(task: Task) {
        _title = State(initialValue: task.taskTitle ?? "")
        _category = State(initialValue: task.taskCategory ?? "")
        _description = State(initialValue: task.taskDescription ?? "")
        _dueDate = State(initialValue: task.taskDueDate ?? Date())
        _isUrgent = State(initialValue: task.taskIsUrgent)
        _additionalDetails = State(initialValue: task.taskAdditionalDetails ?? "")
        self.task = task
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.top, 5)) {
                    // Title
                    HStack {
                        Text("Title")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(width: 80, alignment: .leading)
                        TextField("Enter task title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                    }

                    // Category
                    HStack {
                        Text("Category")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(width: 80, alignment: .leading)
                        TextField("Enter category", text: $category)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                    }

                    // Description
                    HStack {
                        Text("Description")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(width: 80, alignment: .leading)
                        TextField("Enter description", text: $description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                    }

                    // Urgency Toggle
                    HStack {
                        Text("Urgent")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(width: 80, alignment: .leading)
                        Toggle("", isOn: $isUrgent)
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                            .labelsHidden()
                    }

                    // Due Date Picker
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                        .padding(.horizontal)
                        .datePickerStyle(GraphicalDatePickerStyle())

                    // Additional Details
                    HStack {
                        Text("Additional Details")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(width: 80, alignment: .leading)
                        TextEditor(text: $additionalDetails)
                            .padding(10)
                            .border(Color.gray.opacity(0.3), width: 0.5)
                            .cornerRadius(10)
                            .frame(height: 150)
                            .padding(.horizontal)
                            .font(.body)
                    }
                                
                    // Save Button
                    Button(action: updateTask) {
                        HStack {
                            Image(systemName: "square.and.arrow.down")
                            Text("Save")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.vertical)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text("Title is required"), dismissButton: .default(Text("OK")))
                    }
                    .alert(isPresented: $showSuccess) {
                        Alert(title: Text("Success!"), message: Text("Task updated successfully"), dismissButton: .default(Text("OK")))
                    }
                                
                }
            }
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func updateTask() {
        guard !title.isEmpty else {
            showAlert = true
            return
        }

        task.taskTitle = title
        task.taskCategory = category
        task.taskDescription = description
        task.taskDueDate = dueDate
        task.taskIsUrgent = isUrgent
        task.taskAdditionalDetails = additionalDetails

        do {
            try context.save()
            showSuccess = true
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to update task: \(error.localizedDescription)")
        }
    }
}

#Preview {
    EditTaskView(task: Task())
}
