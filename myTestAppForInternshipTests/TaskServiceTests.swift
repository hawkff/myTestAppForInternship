//
//  TaskServiceTests.swift
//  myTestAppForInternship
//
//  Created by Max
//

import XCTest
@testable import myTestAppForInternship
import RealmSwift
import Realm

class TaskServiceTests: XCTestCase {
    var taskService: TaskService!

    override func setUp() {
        super.setUp()
        taskService = TaskService.shared
    }

    override func tearDown() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        taskService = nil
        super.tearDown()
    }

    func testCreateTask() {
        let task = Task()
        task.id = Int(Date().timeIntervalSince1970)
        task.name = "Test Task"
        task.date_start = Date().timeIntervalSince1970
        task.date_finish = Date().timeIntervalSince1970 + 3600
        task.taskDescription = "Test Task Description"

        taskService.create(task: task)

        let fetchedTask = taskService.read(id: task.id)

        XCTAssertNotNil(fetchedTask, "Task should be created and saved correctly")
        XCTAssertEqual(fetchedTask?.name, task.name, "Created task should have the correct name")
    }

    func testReadTask() {
        let task = Task()
        task.id = Int(Date().timeIntervalSince1970)
        task.name = "Test Task"
        task.date_start = Date().timeIntervalSince1970
        task.date_finish = Date().timeIntervalSince1970 + 3600
        task.taskDescription = "Test Task Description"

        taskService.create(task: task)

        let fetchedTask = taskService.read(id: task.id)

        XCTAssertNotNil(fetchedTask, "Task should be readable by its ID")
        XCTAssertEqual(fetchedTask?.name, task.name, "Fetched task should have the correct name")
    }

    func testUpdateTask() {
        let task = Task()
        task.id = Int(Date().timeIntervalSince1970)
        task.name = "Test Task"
        task.date_start = Date().timeIntervalSince1970
        task.date_finish = Date().timeIntervalSince1970 + 3600
        task.taskDescription = "Test Task Description"

        taskService.create(task: task)

        let newTask = Task()
        newTask.name = "Updated Task"
        newTask.date_start = Date().timeIntervalSince1970 + 7200
        newTask.date_finish = Date().timeIntervalSince1970 + 10800
        newTask.taskDescription = "Updated Task Description"

        taskService.update(task: task, newTask: newTask)

        let fetchedTask = taskService.read(id: task.id)

        XCTAssertNotNil(fetchedTask, "Task should be updated correctly")
        XCTAssertEqual(fetchedTask?.name, newTask.name, "Updated task should have the correct name")
    }

    func testDeleteTask() {
        // Given
        let task = Task()
        task.id = 1
        task.name = "Test Task"
        task.date_start = Date().timeIntervalSince1970
        task.date_finish = Date().timeIntervalSince1970 + 3600
        task.taskDescription = "Test task description"
        
        TaskService.shared.create(task: task)
        let taskId = task.id
        
        // When
        if let taskToDelete = TaskService.shared.read(id: taskId) {
            TaskService.shared.delete(task: taskToDelete)
        } else {
            XCTFail("The task with ID \(taskId) could not be found.")
        }
        
        // Then
        let fetchedTask = TaskService.shared.read(id: taskId)
        XCTAssertNil(fetchedTask, "The task should be deleted.")
    }



    
}

