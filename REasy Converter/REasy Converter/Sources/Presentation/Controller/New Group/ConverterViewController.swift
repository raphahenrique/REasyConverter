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

    var viewModel: ConverterViewModelProtocol? {
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
        theView = ConverterView()
        theView.delegate = self
        view = theView
    }

    private func loadData() {
        let rate = UserDefaults.standard.double(forKey: "RATE")
        let inverted = UserDefaults.standard.bool(forKey: "INVERT_RATE")
        viewModel = ConverterViewModel(rate: rate, isInverted: inverted)
    }
}

extension ConverterViewController: ConverterViewDelegate {

    func didSetFirstCountry(valueDouble: Double?) {
        guard let newValue = valueDouble else { return }
        viewModel?.setFirstToSecondValues(value: newValue)
    }
    
    func didSetSecondCountry(valueDouble: Double?) {
        guard let newValue = valueDouble else { return }
        viewModel?.setSecondToFirstValues(value: newValue)
    }
    
}
