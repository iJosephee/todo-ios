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
    var closing: (String, Category) -> Void
    
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
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancelar", role: .cancel) {
                        print("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Listo") {
                        closing(taskName, selectedCategory)
                    }
                }
            }
        }
    }
    
    var body: some View {
        navigation
    }
}

#Preview {
    NewTaskSheet { name, category in
        print("Done")
    }
}
