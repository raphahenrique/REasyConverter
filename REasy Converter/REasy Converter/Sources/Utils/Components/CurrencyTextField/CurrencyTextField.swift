//
//  CurrencyTextField.swift
//  REasy Converter
//
//  Created by Raphael on 15/03/23.
//

import UIKit

class CurrencyTextField: UITextField {

    var retrieveTextFieldValues: ((String, Double?) -> Void)?
    private var amountAsDouble: Double?

    var currency: CurrencyTF? {
        didSet {
            guard let currency = currency else { return }
            numberFormatter.currencyCode = currency.code
            numberFormatter.locale = Locale(identifier: currency.locale)

            startingValue = currency.amount
        }
    }
    var startingValue: Double? {
        didSet {
            let nsNumber = NSNumber(value: startingValue ?? 0.0)
            self.text = numberFormatter.string(from: nsNumber)
        }
    }
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    private var roundingPlaces: Int {
        return numberFormatter.maximumFractionDigits
    }
    
    private var isSymbolOnRight = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.textAlignment = .right
        self.keyboardType = .numberPad
        self.contentScaleFactor = 0.5
        delegate = self

        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        updateTextField()
    }
    
    private func updateTextField() {
        var cleanedAmount = ""
        
        for character in self.text ?? "" {
            if character.isNumber {
                cleanedAmount.append(character)
            }
        }
        
        if isSymbolOnRight {
            cleanedAmount = String(cleanedAmount.dropLast())
        }
        
        if self.roundingPlaces > 0 {
            //USD
            let amount = Double(cleanedAmount) ?? 0.0
            amountAsDouble = (amount / 100.0)
            let amountAsString = numberFormatter.string(from: NSNumber(value: amountAsDouble ?? 0.0)) ?? ""
            
            self.text = amountAsString
        } else {
            //JPY
            let amountAsNumber = Double(cleanedAmount) ?? 0.0
            amountAsDouble = amountAsNumber
            self.text = numberFormatter.string(from: NSNumber(value: amountAsNumber)) ?? ""
        }
        
        retrieveTextFieldValues?(self.text!, amountAsDouble)
    }
    
    // Prevent cursor moving
    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning = self.beginningOfDocument
        let end = self.position(from: beginning, offset: self.text?.count ?? 0)
        return end
    }
}


extension CurrencyTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let lastCharacterInTextField = (textField.text ?? "").last
        
        if string == "" && lastCharacterInTextField!.isNumber == false {
            isSymbolOnRight = true
        } else {
            isSymbolOnRight = false
        }

        return true
    }
}
