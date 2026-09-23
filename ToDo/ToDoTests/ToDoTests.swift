//
//  ToDoTests.swift
//  ToDoTests
//
//  Created by Arnold Dominguez on 18/09/26.
//

import XCTest
import SwiftUI

@testable import ToDo

final class ToDoTests: XCTestCase {
    
    var sut: AddTaskView!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = AddTaskView(task: .constant(nil), closing: { task in
            
        })
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        sut = nil
    }

    func testTaskNameValidation() throws {
        // Given
        // When
        // Then
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
