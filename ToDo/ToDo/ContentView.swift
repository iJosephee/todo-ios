//
//  ContentView.swift
//  ToDo
//
//  Created by Arnold Dominguez on 12/08/26.
//

import SwiftUI

struct ContentView: View {
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
                    Text(task.title)
                    Spacer()
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
            NewTaskSheet { ( taskName, category) in
                showAlert = false
                addTask(name: taskName, category: category)
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
    
    func addTask(name: String, category: Category) {
        let newTask = Task(title: name, category: category, priority: 0, dueDate: Date(), isCompleted: false)
        self.tasks.append(newTask)
        saveTasks()
    }
}

#Preview {
    ContentView()
}
