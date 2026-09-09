//
//  TaskCell.swift
//  ToDo
//
//  Created by Arnold Dominguez on 04/09/26.
//

import SwiftUI

struct TaskCell: View {
    var task: Task
    var body: some View {
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
    }
}
