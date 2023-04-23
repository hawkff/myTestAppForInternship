//
//  Task.swift
//  myTestAppForInternship
//
//  Created by Max
//

import Foundation
import RealmSwift

class Task: Object, Encodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var date_start: TimeInterval = 0
    @objc dynamic var date_finish: TimeInterval = 0
    @objc dynamic var name: String = ""
    @objc dynamic var taskDescription: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case date_start
        case date_finish
        case name
        case taskDescription = "description"
    }
}
