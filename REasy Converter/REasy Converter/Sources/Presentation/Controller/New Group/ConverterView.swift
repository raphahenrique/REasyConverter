//
//  ConverterView.swift
//  REasy Converter
//
//  Created by Raphael on 12/03/23.
//

import UIKit

protocol ConverterViewDelegate: AnyObject {
    func didSetFirstCountry(valueDouble: Double?)
    func didSetSecondCountry(valueDouble: Double?)
}

class ConverterView: UIView {

    private let firstCountryImageView: FlagView
    private let firstCountryTextField: CurrencyTextField
    private let secondCountryImageView: FlagView
    private let secondCountryTextField: CurrencyTextField
    private let hintLabel: UILabel
    
    var viewModel: ConverterViewModelProtocol? {
        didSet {
            update()
        }
    }
    
    weak var delegate: ConverterViewDelegate?

    init() {
        firstCountryImageView = FlagView()
        firstCountryTextField = CurrencyTextField()
        secondCountryImageView = FlagView()
        secondCountryTextField = CurrencyTextField()
        hintLabel = UILabel()

        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        guard let model = viewModel else {
            return
        }
        firstCountryTextField.text?.removeAll()
        firstCountryTextField.currency = model.firstSelectedCurrency

        secondCountryTextField.text?.removeAll()
        secondCountryTextField.currency = model.secondSelectedCurrency
        
        hintLabel.text = model.hint
    }
}

extension ConverterView: ViewCodable {
    
    func configureViews() {
        backgroundColor = .white

        firstCountryImageView.translatesAutoresizingMaskIntoConstraints = false

        secondCountryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        firstCountryTextField.text = "5000"
        firstCountryTextField.borderStyle = .roundedRect
        firstCountryTextField.translatesAutoresizingMaskIntoConstraints = false
        firstCountryTextField.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        firstCountryTextField.keyboardType = .numberPad
        firstCountryTextField.tag = 0
                
        secondCountryTextField.text = "30"
        secondCountryTextField.borderStyle = .roundedRect
        secondCountryTextField.translatesAutoresizingMaskIntoConstraints = false
        secondCountryTextField.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        secondCountryTextField.keyboardType = .numberPad
        secondCountryTextField.tag = 1
        
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        hintLabel.textColor = .lightGray
        hintLabel.numberOfLines = 0
        
        firstCountryTextField.retrieveTextFieldValues = { [weak self] stringAmount, doubleAmount in
            self?.delegate?.didSetFirstCountry(valueDouble: doubleAmount)
        }
        secondCountryTextField.retrieveTextFieldValues = { [weak self] stringAmount, doubleAmount in
            self?.delegate?.didSetSecondCountry(valueDouble: doubleAmount)
        }
        
    }

    func buildHierarchy() {
        addViews(
            firstCountryImageView,
            firstCountryTextField,
            secondCountryImageView,
            secondCountryTextField,
            hintLabel
        )
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
                        
            firstCountryImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            firstCountryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            firstCountryImageView.widthAnchor.constraint(equalToConstant: 64),
            firstCountryImageView.heightAnchor.constraint(equalToConstant: 64),
            
            firstCountryTextField.topAnchor.constraint(equalTo: firstCountryImageView.bottomAnchor, constant: 24),
            firstCountryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            firstCountryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            secondCountryImageView.topAnchor.constraint(equalTo: firstCountryTextField.bottomAnchor, constant: 32),
            secondCountryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            secondCountryImageView.widthAnchor.constraint(equalToConstant: 64),
            secondCountryImageView.heightAnchor.constraint(equalToConstant: 64),
            
            secondCountryTextField.topAnchor.constraint(equalTo: secondCountryImageView.bottomAnchor, constant: 24),
            secondCountryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            secondCountryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
             
            hintLabel.topAnchor.constraint(equalTo: secondCountryTextField.bottomAnchor, constant: 42),
            hintLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            hintLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
        ])
        
    }
    
    func setupAccessibility() {
        
    }

    
}

