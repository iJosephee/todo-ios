//
//  Task.swift
//  ToDo
//
//  Created by Arnold Dominguez on 17/08/26.
//
import Foundation

enum Category: Codable {
    case Personal
    case Work
    case Study
}

struct Task: Hashable, Codable {
    var title: String
    var category: Category
    var priority: Int
    var dueDate: Date
    var isCompleted: Bool
}
