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
        view = theView
    }

    private func loadData() {
        let rate = UserDefaults.standard.double(forKey: "RATE")
        
        viewModel = SettingsViewModel(currentRate: rate.isZero ? "0.00639" : String(rate))
        
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        var text = textField.text ?? String()
        text = text.replace(this: ",", with: ".")
        if !text.isEmpty, let newValue = Double(text) {
            UserDefaults.standard.set(newValue, forKey: "RATE")
        }
    }

}
