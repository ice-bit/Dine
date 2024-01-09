//
//  OnboardingConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/01/24.
//

import Foundation

enum OnboardingOptions: Int {
    case login = 1
    case signUp = 2
    case forgotPassword = 3
}

class OnboardingConsoleView {
    func displayOnboardingPrompt() {
        print("| Welcome to Restaurant Managment App")
        print("")
        print("Pleaser login to continue - ")
        print("")
        print("~ 1 - Sign Up.")
        print("~ 2 - Already have an account? Login!")
        print("~ 3 - Forgot password?")
    }
}
