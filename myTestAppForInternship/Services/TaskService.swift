//
//  TaskService.swift
//  myTestAppForInternship
//
//  Created by Max
//

import Foundation
import RealmSwift

class TaskService {
    static let shared = TaskService()
    private let realm = try! Realm()
    
    func create(task: Task) {
        try! realm.write {
            realm.add(task, update: .modified)
        }
        // Convert the saved task to JSON and print it
        if let jsonString = taskToJSON(task: task) {
            print(jsonString)
        }
    }
    
    func read(id: Int) -> Task? {
        return realm.object(ofType: Task.self, forPrimaryKey: id)
    }
    
    func update(task: Task, newTask: Task) {
        try! realm.write {
            task.date_start = newTask.date_start
            task.date_finish = newTask.date_finish
            task.name = newTask.name
            task.taskDescription = newTask.taskDescription
        }
    }
    
    func delete(task: Task) {
        try! realm.write {
            realm.delete(task)
        }
    }
    
    func tasksForDate(date: Date) -> Results<Task> {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let fromDate = startOfDay.timeIntervalSince1970
        let toDate = endOfDay.timeIntervalSince1970
        return realm.objects(Task.self).filter("date_start >= %@ AND date_start < %@", fromDate, toDate).sorted(byKeyPath: "date_start")
    }
    
    func taskToJSON(task: Task) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .secondsSince1970
        do {
            let jsonData = try encoder.encode(task)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding task to JSON: \(error)")
            return nil
        }
    }
}

