//
//  ConverterView.swift
//  REasy Converter
//
//  Created by Raphael on 12/03/23.
//

import UIKit

class ConverterView: UIView {

    private let firstCountryImageView: UIImageView
    private let firstCountryTextField: UITextField
    private let secondCountryImageView: UIImageView
    private let secondCountryTextField: UITextField
    
    var viewModel: ConverterViewModelProtocol? {
        didSet {
            update()
        }
    }
    
    init(delegate: UITextFieldDelegate) {
        firstCountryImageView = UIImageView()
        firstCountryTextField = UITextField()
        secondCountryImageView = UIImageView()
        secondCountryTextField = UITextField()

        firstCountryTextField.delegate = delegate
        secondCountryTextField.delegate = delegate

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
        if !model.firstValue.isEmpty {
            firstCountryTextField.text = model.firstValue
        }
        if model.secondValue.isEmpty, let doubleValue = Double(model.firstValue) {
            let convertedValue = doubleValue * model.rate
            secondCountryTextField.text = String(convertedValue)
        }
        
    }
}

extension ConverterView: ViewCodable {
    
    func configureViews() {
        backgroundColor = .white

        firstCountryImageView.translatesAutoresizingMaskIntoConstraints = false
        firstCountryImageView.contentMode = .scaleAspectFill
        firstCountryImageView.layer.cornerRadius = 5
        firstCountryImageView.clipsToBounds = true
        firstCountryImageView.image = UIImage(named: "chile")
        
        secondCountryImageView.translatesAutoresizingMaskIntoConstraints = false
        secondCountryImageView.contentMode = .scaleAspectFill
        secondCountryImageView.layer.cornerRadius = 5
        secondCountryImageView.clipsToBounds = true
        secondCountryImageView.image = UIImage(named: "brazil")
        
        firstCountryTextField.text = "5000"
        firstCountryTextField.borderStyle = .roundedRect
        firstCountryTextField.translatesAutoresizingMaskIntoConstraints = false
        firstCountryTextField.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        firstCountryTextField.keyboardType = .numberPad
        firstCountryTextField.tag = 0
                
        secondCountryTextField.text = "30"
        secondCountryTextField.borderStyle = .roundedRect
        secondCountryTextField.translatesAutoresizingMaskIntoConstraints = false
        secondCountryTextField.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        secondCountryTextField.keyboardType = .numberPad
        secondCountryTextField.tag = 1
    }

    func buildHierarchy() {
        addViews(
            firstCountryImageView,
            firstCountryTextField,
            secondCountryImageView,
            secondCountryTextField
        )
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
                        
            firstCountryImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            firstCountryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            firstCountryImageView.widthAnchor.constraint(equalToConstant: 48),
            firstCountryImageView.heightAnchor.constraint(equalToConstant: 48),
            
            firstCountryTextField.topAnchor.constraint(equalTo: firstCountryImageView.bottomAnchor, constant: 24),
            firstCountryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            firstCountryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            secondCountryImageView.topAnchor.constraint(equalTo: firstCountryTextField.bottomAnchor, constant: 32),
            secondCountryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            secondCountryImageView.widthAnchor.constraint(equalToConstant: 48),
            secondCountryImageView.heightAnchor.constraint(equalToConstant: 48),
            
            secondCountryTextField.topAnchor.constraint(equalTo: secondCountryImageView.bottomAnchor, constant: 24),
            secondCountryTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            secondCountryTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
             
        ])
        
    }
    
    func setupAccessibility() {
        
    }

    
}

