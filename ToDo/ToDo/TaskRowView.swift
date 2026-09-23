//
//  TaskRowView.swift
//  ToDo
//
//  Created by Arnold Dominguez on 04/09/26.
//

import SwiftUI

struct TaskRowView: View {
    @Binding var task: Task
    
    let tapAction: () -> Void
    let swipeAction: () -> Void
    
    var body: some View {
        HStack {
            if task.isCompleted {
                Image(systemName: "circle.fill")
                    .onTapGesture {
                        task.isCompleted.toggle()
                        tapAction()
                    }
            } else {
                Image(systemName: "circle")
                    .onTapGesture {
                        task.isCompleted.toggle()
                        tapAction()
                    }
            }
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
        }
        .contentShape(Rectangle())
        .swipeActions {
            Button(role: .destructive) {
                swipeAction()
            } label: {
                Image(systemName: "trash")
            }
        }
    }
}
