//
//  NewTaskSheet.swift
//  ToDo
//
//  Created by Arnold Dominguez on 31/08/26.
//

import SwiftUI

struct NewTaskSheet: View {
    @State private var taskName = ""
    @State private var selectedCategory = Category.Personal
    @State private var currentPriority = Priority.Low
    
    var closing: (String?, Category, Priority) -> Void
    
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
            Picker("Prioridad", selection: $currentPriority) {
                Text("Alta").tag(Priority.High)
                Text("Media").tag(Priority.Medium)
                Text("Baja").tag(Priority.Low)
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancelar", role: .cancel) {
                        closing(nil, selectedCategory, currentPriority)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Listo") {
                        closing(taskName, selectedCategory, currentPriority)
                    }
                    .disabled(taskName.isEmpty)
                }
            }
        }
    }
    
    var body: some View {
        navigation
    }
}

#Preview {
    NewTaskSheet { name, category, priority in
        print("Done")
    }
}
