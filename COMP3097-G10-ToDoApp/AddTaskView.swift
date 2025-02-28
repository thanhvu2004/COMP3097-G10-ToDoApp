import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var category: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Date()
    @State private var isUrgent: Bool = false
    @State private var additionalDetails: String = ""

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
                }
                
                // Save Button
                Button(action: {
                    // Save the task
                }) {
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
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddTaskView()
}
