//
//  SettingsViewModel.swift
//  REasy Converter
//
//  Created by Raphael on 19/03/23.
//

import Foundation

protocol SettingsViewModelProtocol {
    var rateLabel: String { get }
    var rateText: String { get }
    var invertButton: String { get }
    var isInverted: Bool { get }
}

struct SettingsViewModel: SettingsViewModelProtocol {
    
    var rateLabel: String
    var rateText: String
    var invertButton: String
    var isInverted: Bool

    init(currentRate: String, isInverted: Bool = false) {
        self.rateLabel = "insira sua cotação"
        self.rateText = currentRate
        self.invertButton = "inverter"
        self.isInverted = isInverted
    }

}

