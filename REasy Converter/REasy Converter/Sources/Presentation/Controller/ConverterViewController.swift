//
//  ConverterViewController.swift
//  REasy Converter
//
//  Created by Raphael on 12/03/23.
//

import UIKit


// TO-DO:
/*
 
 https://flagsapi.com/#themes
 
 <img src="https://flagsapi.com/:country_code/:style/:size.png">
 <img src="https://flagsapi.com/BE/flat/64.png">
 <img src="https://flagsapi.com/BE/shiny/64.png">
 16 for 16px wide flags
 24 for 24px wide flags
 32 for 32px wide flags
 48 for 48px wide flags
 64 for 64px wide flags
 */

class ConverterViewController: UIViewController {

    var theView: ConverterView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func loadView() {
        theView = ConverterView(delegate: self)
        view = theView
    }

}

extension ConverterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if textField.tag == 0 {
            theView.viewModel = ConverterViewModel(firstValue: text, secondValue: "")
        } else if textField.tag == 1 {
            theView.viewModel = ConverterViewModel(firstValue: "", secondValue: text)
        }
        return true
    }

}
