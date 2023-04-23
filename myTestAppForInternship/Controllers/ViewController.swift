//
//  ViewController.swift
//  myTestAppForInternship
//
//  Created by Max
//
import FSCalendar
import UIKit

class ViewController: UIViewController {
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTaskButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.select(Date())
        calendar.configureAppearance(for: traitCollection)

        let switchButton = CalendarSwitchButton(calendar: calendar)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: switchButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register the cell class
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "taskCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedDate = calendar.selectedDate {
            tasks = Array(TaskService.shared.tasksForDate(date: selectedDate))
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetails",
           let taskDetailsViewController = segue.destination as? TaskDetailsViewController,
           let selectedTask = sender as? Task {
            taskDetailsViewController.task = selectedTask
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            calendar.configureAppearance(for: traitCollection)
        }
    }

}


// MARK: - FSCalendarDelegate
extension ViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasks = Array(TaskService.shared.tasksForDate(date: date))
        tableView.reloadData()
    }
    
}

// MARK: - FSCalendarDataSource
extension ViewController: FSCalendarDataSource {
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let task = tasks[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let startDate = Date(timeIntervalSince1970: task.date_start)
        let endDate = Date(timeIntervalSince1970: task.date_finish)
        cell.textLabel?.text = "\(task.name) (\(dateFormatter.string(from: startDate))-\(dateFormatter.string(from: endDate))) - \(task.taskDescription)"
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = tasks[indexPath.row]
        performSegue(withIdentifier: "showTaskDetails", sender: selectedTask)
    }
    
    
}


