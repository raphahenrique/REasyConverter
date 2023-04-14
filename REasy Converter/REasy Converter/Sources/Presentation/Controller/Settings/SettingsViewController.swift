//
//  SettingsViewController.swift
//  REasy Converter
//
//  Created by Raphael on 18/03/23.
//

import UIKit

class SettingsViewController: UIViewController {

    var theView: SettingsView!

    var viewModel: SettingsViewModelProtocol? {
        didSet {
            theView.viewModel = viewModel
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    override func loadView() {
        theView = SettingsView(textFieldDelegate: self)
        theView.delegate = self
        view = theView
    }

    private func loadData() {
        let rate = UserDefaults.standard.double(forKey: "RATE")
        let inverted = UserDefaults.standard.bool(forKey: "INVERT_RATE")
        
        viewModel = SettingsViewModel(currentRate: rate.isZero ? "0.00639" : String(rate), isInverted: inverted)
        
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        var text = textField.text ?? String()
        text = text.replace(this: ",", with: ".")
        if !text.isEmpty, let newValue = Double(text) {
            saveRate(rate: newValue)
        }
    }

    private func saveRate(rate: Double) {
        UserDefaults.standard.set(rate, forKey: "RATE")
    }

}

extension SettingsViewController: SettingsViewDelegate {

    func didPressInvert(value: Double) {
        guard let inverted = viewModel?.isInverted else { return }
        let rate = UserDefaults.standard.double(forKey: "RATE")
        let currentRate = (1/rate)
        viewModel = SettingsViewModel(currentRate: String(currentRate), isInverted: !inverted)
        UserDefaults.standard.set(!inverted, forKey: "INVERT_RATE")
        UserDefaults.standard.set(currentRate, forKey: "RATE")
    }
    
}
