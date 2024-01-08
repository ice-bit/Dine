//
//  ContentConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/01/24.
//

import Foundation

class ContentConsoleView {
    private let userManager: UserManagabale = UserManager()
    
    func start() {
        let onboardingConsoleView = OnboardingConsoleView()
        onboardingConsoleView.displayOnboardingPrompt()
    }
}
