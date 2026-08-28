//
//  Task.swift
//  ToDo
//
//  Created by Arnold Dominguez on 17/08/26.
//
import Foundation

struct Task: Hashable, Codable {
    var title: String
    var isCompleted: Bool
}
