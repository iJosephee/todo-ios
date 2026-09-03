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
                     taskList
                 }
             } else {
                 NavigationView {
                     taskList
                 }
             }
         }
    }
    
    var taskList: some View {
        List {
            ForEach($tasks, id: \.self) { $task in
                HStack {
                    Image(systemName: task.priority == Priority.Medium ? "exclamationmark" : task.priority == Priority.High ? "exclamationmark.2" : "")
                        .foregroundColor(task.priority == Priority.Medium ? .orange : task.priority == Priority.High ? .red : .accentColor)
                    VStack {
                        HStack {
                            Text(task.title)
                            Spacer()
                        }
                        HStack {
                            Text(task.category.rawValue)
                            Text("-")
                            Text(task.priority.rawValue)
                            Spacer()
                        }
                        HStack {
                            if Calendar.current.component(.day, from: task.dueDate) == Calendar.current.component(.day, from: Date.now) {
                                Text("Hoy")
                                Spacer()
                            } else if Calendar.current.component(.day, from: task.dueDate) < Calendar.current.component(.day, from: Date.now) {
                                Text("Vencida")
                                Spacer()
                            } else if Calendar.current.component(.day, from: task.dueDate) > Calendar.current.component(.day, from: Date.now) {
                                Text("\(task.dueDate.formatted(date: .long, time: .omitted))")
                                Spacer()
                            }
                        }
                    }
                    if task.isCompleted {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    task.isCompleted.toggle()
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
