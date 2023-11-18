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

    // MARK: Private Functions

    private func loadData() {
//        let rate = UserDefaults.standard.double(forKey: "RATE")
//        let inverted = UserDefaults.standard.bool(forKey: "INVERT_RATE")
    
        if isFirstAppLaunch() {
            createCurrencyPairs()
            setAppLaunched()
            
            // ********* APAGAR QUANDO OK
            UserDefaults.standard.set(true, forKey: "HasLaunchedBefore")
        }
        
        
        if let chile = CurrencyService.fetchCurrency(forCountry: .chile),
           let brazil = CurrencyService.fetchCurrency(forCountry: .brazil),
           let initialPair = CurrencyService.fetchExchangeRate(
            fromCurrency: chile,
            toCurrency: brazil
           ) {
            viewModel = ConverterViewModel(exchangeRate: initialPair)
        }
                
    }
    
    private func isFirstAppLaunch() -> Bool {
        let key = "HasLaunchedBefore"
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: key)
        return !hasLaunchedBefore
    }

    private func setAppLaunched() {
        let key = "HasLaunchedBefore"
        UserDefaults.standard.set(true, forKey: key)
    }
    
    private func createCurrencyPairs() {
        CurrencyService.deleteAllData()
        CurrencyService.createDefaultCurrenciesAndRates()
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
