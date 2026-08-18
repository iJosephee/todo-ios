//
//  ContentView.swift
//  ToDo
//
//  Created by Arnold Dominguez on 12/08/26.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [String] = [
        "Comprar comida",
        "Estudiar Swift",
        "Hacer ejercicio"
    ]
    @State private var completedTasks: [String] = [
        "Comprar comida",
        "Estudiar Swift"
    ]
    @State private var taskName = ""
    @State private var showAlert = false
    
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
            ForEach(tasks, id: \.self) { task in
                HStack {
                    Text(task)
                    Spacer()
                    if completedTasks.contains(task) {
                        Image(systemName: "checkmark")
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        let index = tasks.firstIndex(of: task)!
                        tasks.remove(at: index)
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
        .alert("New Task", isPresented: $showAlert) {
            TextField("Comprar comida", text: $taskName)
            Button("Cancelar", role: .cancel) { }
            Button("Agregar") {
                saveTask(name: taskName)
            }
        }
    }
    
    var body: some View {
        navigation
    }
    
    func saveTask(name: String) {
        self.tasks.append(name)
        taskName = ""
    }
}

#Preview {
    ContentView()
}
