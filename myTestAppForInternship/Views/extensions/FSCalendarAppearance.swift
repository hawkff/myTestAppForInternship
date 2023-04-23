//
//  FSCalendarAppearance.swift
//  myTestAppForInternship
//
//  Created by Max
//

import FSCalendar
import UIKit

extension FSCalendar {
    func configureAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            appearance.titleDefaultColor = .white
            appearance.subtitleDefaultColor = .white
        } else {
            appearance.titleDefaultColor = .black
            appearance.subtitleDefaultColor = .black
        }
    }
}
