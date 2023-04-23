//
//  CalendarSwitchButton.swift
//  myTestAppForInternship
//
//  Created by Max
//

import UIKit
import FSCalendar

class CalendarSwitchButton: UIButton {
    
    weak var calendar: FSCalendar?
    
    init(calendar: FSCalendar) {
        self.calendar = calendar
        super.init(frame: .zero)
        setTitleColor(.systemBlue, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        updateButtonTitle()
        addTarget(self, action: #selector(switchCalendarScope), for: .touchUpInside)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateButtonTitle() {
        guard let calendar = calendar else { return }
        let title = calendar.scope == .month ? "Weekly" : "Month"
        setTitle(title, for: .normal)
    }
    
    @objc private func switchCalendarScope() {
        guard let calendar = calendar else { return }
        if calendar.scope == .month {
            calendar.scope = .week
        } else {
            calendar.scope = .month
        }
        updateButtonTitle()
    }
}


