//
//  Task.swift
//  ToDo
//
//  Created by Arnold Dominguez on 17/08/26.
//
import Foundation

enum Category: String, Codable {
    case Personal = "Personal"
    case Work = "Trabajo"
    case Study = "Estudio"
}

enum Priority: String, Codable {
    case Low = "Baja"
    case Medium = "Media"
    case High = "Alta"
}

enum SortingType: Int {
    case None = 0
    case Name
    case Date
    case Priority
}

struct Task: Hashable, Codable {
    var id = UUID()
    var title: String
    var category: Category
    var priority: Priority
    var dueDate: Date
    var isCompleted: Bool
    
    init() {
        self.title = ""
        self.category = .Personal
        self.priority = .Low
        self.dueDate = Date()
        self.isCompleted = false
    }
    
    init(title: String, category: Category, priority: Priority, dueDate: Date, isCompleted: Bool) {
        self.title = title
        self.category = category
        self.priority = priority
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}
