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
}

struct SettingsViewModel: SettingsViewModelProtocol {
    
    var rateLabel: String
    var rateText: String

    init(currentRate: String) {
        self.rateLabel = "insira sua cotação"
        self.rateText = currentRate
    }

}

