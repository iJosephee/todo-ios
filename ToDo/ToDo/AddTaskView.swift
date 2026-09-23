//
//  AddTaskView.swift
//  ToDo
//
//  Created by Arnold Dominguez on 31/08/26.
//

import SwiftUI

struct AddTaskView: View {
    // Receive optional binding from TaskList
    @Binding var task: Task?
    
    // Local states for safe handle before save
    @State private var taskName = ""
    @State private var selectedCategory = Category.Personal
    @State private var selectedPriority = Priority.Low
    @State private var dueDate = Date()
    
    var closing: (Task?) -> Void
    
    var navigation: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    sheet
                }
            } else {
                NavigationView {
                    sheet
                }
            }
        }
    }
    
    var sheet: some View {
        Form {
            TextField("Comprar comida", text: $taskName)
            Picker("Categoria", selection: $selectedCategory) {
                Text("Personal").tag(Category.Personal)
                Text("Trabajo").tag(Category.Work)
                Text("Estudio").tag(Category.Study)
            }
            Picker("Prioridad", selection: $selectedPriority) {
                Text("Alta").tag(Priority.High)
                Text("Media").tag(Priority.Medium)
                Text("Baja").tag(Priority.Low)
            }
            DatePicker(
                "Fecha Límite",
                selection: $dueDate,
                displayedComponents: [.date]
            )
            .navigationTitle(task == nil ? "New Task": "Update Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancelar", role: .cancel) {
                        closing(nil)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Listo") {
                        let finalTask: Task
                        if var task = task {
                            task.title = taskName
                            task.priority = selectedPriority
                            task.category = selectedCategory
                            task.dueDate = dueDate
                            finalTask = task
                        } else {
                            finalTask = Task(
                                title: taskName,
                                category: selectedCategory,
                                priority: selectedPriority,
                                dueDate: dueDate,
                                isCompleted: false
                            )
                        }
                        closing(finalTask)
                    }
                    .disabled(task?.title.isEmpty ?? taskName.isEmpty)
                }
            }
            .onAppear {
                if let task = task {
                    taskName = task.title
                    selectedCategory = task.category
                    selectedPriority = task.priority
                    dueDate = task.dueDate
                }
            }
        }
    }
    
    var body: some View {
        navigation
    }
}

#Preview {
    //AddTaskView { name, category, priority, date in
    //    print("Done")
    //}
}
