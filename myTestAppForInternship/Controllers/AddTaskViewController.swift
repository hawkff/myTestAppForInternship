//
//  AddTaskViewController.swift
//  myTestAppForInternship
//
//  Created by Max
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup, if necessary
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else {
            showAlert(title: "Error", message: "Please enter a task name")
            return
        }
        
        _ = taskDescriptionTextView.text
        let startDate = datePicker.date
        _ = startDate.addingTimeInterval(3600) // Assuming a 1-hour duration
        
        
        
        saveTask()
        
        
        // Close the AddTaskViewController and return to the main ViewController
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func saveTask() {
        let task = Task()
        task.id = Int(Date().timeIntervalSince1970) // Use the current timestamp as a unique ID
        task.name = taskNameTextField.text ?? ""
        task.date_start = datePicker.date.timeIntervalSince1970
        task.date_finish = datePicker.date.timeIntervalSince1970 + 3600 // Add 1 hour to the start time
        task.taskDescription = taskDescriptionTextView.text ?? ""
        
        TaskService.shared.create(task: task)
    }
    
}

