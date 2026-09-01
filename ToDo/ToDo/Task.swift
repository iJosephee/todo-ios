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

enum Priority: Codable {
    case High
    case Medium
    case Low
}

struct Task: Hashable, Codable {
    var title: String
    var category: Category
    var priority: Priority
    var dueDate: Date
    var isCompleted: Bool
}
