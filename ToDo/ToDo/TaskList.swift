//
//  ContentView.swift
//  ToDo
//
//  Created by Arnold Dominguez on 12/08/26.
//

import SwiftUI

struct TaskList: View {
    @State private var tasks: [Task]
    @State private var showAlert = false
    @State private var selectedCategory = Category.Personal
    @State private var selectedFilter = 0
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedTasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            self.tasks = decoded
            return
        }
        tasks = []
    }
    
     var navigation: some View {
         Group {
             if #available (iOS 16.0, *) {
                 NavigationStack {
                     VStack {
                         filters
                         taskList
                     }
                 }
             } else {
                 NavigationView {
                     VStack {
                         filters
                         taskList
                     }
                 }
             }
         }
    }
    
    var filters: some View {
        Picker("Choose", selection: $selectedFilter) {
            Text("Todas").tag(0)
            Text("Pendientes").tag(1)
            Text("Completadas").tag(2)
            Text("Vencidas").tag(3)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    var taskList: some View {
        List {
            ForEach($tasks, id: \.self) { $task in
                if selectedFilter == 3 {
                    if Calendar.current.component(.day, from: task.dueDate) < Calendar.current.component(.day, from: Date.now) {
                        // Expired
                        TaskCell(task: task)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                task.isCompleted.toggle()
                                saveTasks()
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    let index = tasks.firstIndex(of: task)!
                                    tasks.remove(at: index)
                                    saveTasks()
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                } else if selectedFilter == 2 {
                    // Completed
                    if task.isCompleted {
                        TaskCell(task: task)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                task.isCompleted.toggle()
                                saveTasks()
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    let index = tasks.firstIndex(of: task)!
                                    tasks.remove(at: index)
                                    saveTasks()
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                } else if selectedFilter == 1 {
                    // Pending
                    if !task.isCompleted {
                        TaskCell(task: task)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                task.isCompleted.toggle()
                                saveTasks()
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    let index = tasks.firstIndex(of: task)!
                                    tasks.remove(at: index)
                                    saveTasks()
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                } else {
                    // All
                    TaskCell(task: task)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            task.isCompleted.toggle()
                            saveTasks()
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                let index = tasks.firstIndex(of: task)!
                                tasks.remove(at: index)
                                saveTasks()
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                }
            }
        }
        .navigationTitle("To Do")
        .toolbar {
            Button {
                showAlert = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showAlert) {
            NewTaskSheet { ( name, category, priority, dueDate) in
                if let name = name {
                    addTask(name, category, priority, dueDate)
                }
                showAlert = false
            }
        }
    }
    
    var body: some View {
        navigation
    }
    
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "SavedTasks")
        }
    }
    
    func addTask(_ name: String, _ category: Category, _ priority: Priority, _ dueDate: Date) {
        let newTask = Task(title: name, category: category, priority: priority, dueDate: dueDate, isCompleted: false)
        self.tasks.append(newTask)
        saveTasks()
    }
}

#Preview {
    TaskList()
}
