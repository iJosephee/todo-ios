//
//  TaskDetailView.swift
//  ToDo
//
//  Created by Arnold Dominguez on 24/09/26.
//

import SwiftUI

struct TaskDetailView: View {
    let task: Task
    
    @State private var selectedCategory = Category.Personal
    @State private var selectedPriority = Priority.Low
    @State private var dueDate = Date()
    @State private var showOptions = false
    
    var body: some View {
        Form {
            Text(task.title)
            HStack {
                Text("Categoria")
                Spacer()
                Text(selectedCategory.rawValue)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Prioridad")
                Spacer()
                Text(selectedPriority.rawValue)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Fecha límite")
                Spacer()
                Text(task.dueDate.formatted(date: .abbreviated, time: .omitted))
            }
            HStack {
                Text("Estado")
                Spacer()
                Text(task.isCompleted == true ? "Completada" : "Pendiente")
            }
        }
        .toolbar {
            Button {
                showOptions = true
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
        .confirmationDialog("¿Que quieres hacer con esta tarea?", isPresented: $showOptions, titleVisibility: .visible) {
            Button("Marcar como \(task.isCompleted == true ? "pendiente": "terminada")"){}
            Button("Modificar") {}
            Button("Eliminar", role: .destructive) {}
        }
    }
}
