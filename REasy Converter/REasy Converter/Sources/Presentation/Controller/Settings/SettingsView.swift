//
//  SettingsView.swift
//  REasy Converter
//
//  Created by Raphael on 19/03/23.
//

import UIKit

class SettingsView: UIView {

    private let rateLabel: UILabel
    private let rateTextField: UITextField
    
    
    var viewModel: SettingsViewModelProtocol? {
        didSet {
            update()
        }
    }

    init(textFieldDelegate: UITextFieldDelegate) {
        rateLabel = UILabel()
        rateTextField = UITextField()
        
        rateTextField.delegate = textFieldDelegate
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
        rateLabel.text = model.rateLabel
        rateTextField.text = model.rateText
    }

}

extension SettingsView: ViewCodable {
    
    func configureViews() {
        backgroundColor = .white
        
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        rateLabel.numberOfLines = 0
        
        rateTextField.borderStyle = .roundedRect
        rateTextField.translatesAutoresizingMaskIntoConstraints = false
        rateTextField.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        rateTextField.keyboardType = .decimalPad
    }

    func buildHierarchy() {
        addViews(
            rateLabel,
            rateTextField
        )
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
                        
            rateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            rateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            rateTextField.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 8),
            rateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            rateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
        ])
        
    }
    
    func setupAccessibility() {
        
    }

    
}

