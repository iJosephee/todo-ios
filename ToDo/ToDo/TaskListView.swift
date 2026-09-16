//
//  ContentView.swift
//  ToDo
//
//  Created by Arnold Dominguez on 12/08/26.
//

import SwiftUI

struct TaskListView: View {
    @State private var tasks: [Task]
    @State private var showAddTask = false
    @State private var showSorting = false
    @State private var selectedCategory = Category.Personal
    @State private var selectedTab = 0
    @State private var selectedSort = SortingType.Name
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedTasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            self.tasks = decoded
            return
        }
        tasks = []
    }
    
    var body: some View {
        navigation
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
        Picker("Choose", selection: $selectedTab) {
            Text("Todas").tag(0)
            Text("Pendientes").tag(1)
            Text("Completadas").tag(2)
            Text("Vencidas").tag(3)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    var taskList: some View {
        VStack {
            if tasks.isEmpty {
                Spacer()
                Text("No task yet")
                Text("Create your first task")
                Button {
                    showAddTask = true
                } label: {
                    Image(systemName: "plus")
                }
                .padding(10)
                Spacer()
            } else {
                List {
                     ForEach($tasks, id: \.self) { $task in
                         if selectedTab == 3 {
                             // Expired
                             if Calendar.current.component(.day, from: task.dueDate) < Calendar.current.component(.day, from: Date.now) {
                                 TaskRowView(task: $task) {
                                     saveTasks()
                                 } swipeAction: {
                                     deleteTask(task)
                                 }
                             }
                         } else if selectedTab == 2 {
                             // Completed
                             if task.isCompleted {
                                 TaskRowView(task: $task) {
                                     saveTasks()
                                 } swipeAction: {
                                     deleteTask(task)
                                 }
                             }
                         } else if selectedTab == 1 {
                             // Pending
                             if !task.isCompleted {
                                 TaskRowView(task: $task) {
                                     saveTasks()
                                 } swipeAction: {
                                     deleteTask(task)
                                 }
                             }
                         } else { // Show all
                             TaskRowView(task: $task) {
                                 saveTasks()
                             } swipeAction: {
                                 deleteTask(task)
                             }
                         }
                     }
                 }
            }
        }
        .navigationTitle("To Do")
        .toolbar {
             ToolbarItem(placement: .cancellationAction) {
                 Button {
                     showSorting = true
                 } label: {
                     Image(systemName: "line.3.horizontal.decrease")
                 }
             }
             ToolbarItem(placement: .confirmationAction) {
                 Button {
                     showAddTask = true
                 } label: {
                     Image(systemName: "plus")
                 }
             }
         }
        .confirmationDialog("Ordenar por: ", isPresented: $showSorting, titleVisibility: .visible) {
             Button("Nombre") { sort(by: .Name) }
             Button("Fecha") { sort(by: .Date) }
             Button("Prioridad") { sort(by: .Priority) }
             Button("Ninguno") { sort(by: .None) }
             Button("Cancel", role: .cancel) {}
         }
        .sheet(isPresented: $showAddTask) {
             AddTaskView { ( name, category, priority, dueDate) in
                 if let name = name {
                     addTask(name, category, priority, dueDate)
                 }
                 showAddTask = false
             }
         }
     }
    
    func sort(by type: SortingType) {
        if type == .None {
            tasks.sort { $0.category.rawValue < $1.category.rawValue }
        }
        if type == .Name {
            tasks.sort { $0.title < $1.title }
        } else if type == .Date {
            tasks.sort { $0.dueDate < $1.dueDate }
        } else if type == .Priority {
            tasks.sort {
                if $0.priority == .Low && ($1.priority == .Medium || $1.priority == .High) {
                    return true
                } else if $0.priority == .Medium && $1.priority == .High {
                    return true
                } else {
                    return false
                }
            }
        }
    }
    
    func addTask(_ name: String, _ category: Category, _ priority: Priority, _ dueDate: Date) {
        let newTask = Task(title: name, category: category, priority: priority, dueDate: dueDate, isCompleted: false)
        self.tasks.append(newTask)
        saveTasks()
    }
    
    func deleteTask(_ task: Task) {
        let index = tasks.firstIndex(of: task)!
        tasks.remove(at: index)
        saveTasks()
    }
    
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "SavedTasks")
        }
    }
}

#Preview {
    TaskListView()
}
