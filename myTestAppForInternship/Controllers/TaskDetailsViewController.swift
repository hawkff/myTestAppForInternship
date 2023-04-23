//
//  TaskDetailsViewController.swift
//  myTestAppForInternship
//
//  Created by Max
//

import UIKit

class TaskDetailsViewController: UIViewController {
    
    var task: Task?
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            taskNameLabel.text = task.name
            startTimeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: task.date_start))
            endTimeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: task.date_finish))
            taskDescriptionTextView.text = task.taskDescription
        }
    }
}

