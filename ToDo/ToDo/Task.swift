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
    case High = "Alta"
    case Medium = "Media"
    case Low = "Baja"
}

struct Task: Hashable, Codable {
    var title: String
    var category: Category
    var priority: Priority
    var dueDate: Date
    var isCompleted: Bool
}
