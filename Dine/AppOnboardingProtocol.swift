//
//  AppOnboardingProtocol.swift
//  Dine
//
//  Created by doss-zstch1212 on 07/02/24.
//

import Foundation

protocol AppOnboardingProtocol {
    func getLoginStatus() -> Bool
    func updateLoginStatus()
    func getInitialSetupStatus() -> Bool
    func updateInitialSetup()
}
