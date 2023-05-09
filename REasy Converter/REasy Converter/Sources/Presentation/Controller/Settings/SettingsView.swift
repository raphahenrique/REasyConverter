//
//  SettingsView.swift
//  REasy Converter
//
//  Created by Raphael on 19/03/23.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func didPressInvert(value: Double)
    func didPressSync()
}

class SettingsView: UIView {
    
    private let rateLabel: UILabel
    private let rateTextField: UITextField
    private let invertButton: UIButton
    private let syncButton: UIButton
    
    var viewModel: SettingsViewModelProtocol? {
        didSet {
            update()
        }
    }
    
    weak var delegate: SettingsViewDelegate?
    
    init(textFieldDelegate: UITextFieldDelegate) {
        rateLabel = UILabel()
        rateTextField = UITextField()
        invertButton = UIButton(type: .system)
        syncButton = UIButton(type: .system)
        
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
        if model.isInverted {
            invertButton.setTitleColor(.red, for: .normal)
        } else {
            invertButton.setTitleColor(.green, for: .normal)
        }
        invertButton.setTitle(model.invertButton, for: .normal)
        syncButton.setTitle("download data", for: .normal)
    }
    
    @objc private func invertButtonTapped() {
        let value = rateTextField.text ?? "0.0"
        delegate?.didPressInvert(value: Double(value) ?? 0.0)
    }

    @objc private func syncButtonTapped() {
        delegate?.didPressSync()
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
        
        invertButton.translatesAutoresizingMaskIntoConstraints = false
        invertButton.addTarget(self, action: #selector(invertButtonTapped), for: .touchUpInside)

        syncButton.translatesAutoresizingMaskIntoConstraints = false
        syncButton.addTarget(self, action: #selector(syncButtonTapped), for: .touchUpInside)
    }

    func buildHierarchy() {
        addViews(
            rateLabel,
            rateTextField,
            invertButton,
            syncButton
        )
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
                        
            rateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            rateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            rateTextField.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 8),
            rateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            rateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            invertButton.topAnchor.constraint(equalTo: rateTextField.bottomAnchor, constant: 8),
            invertButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            syncButton.topAnchor.constraint(equalTo: invertButton.bottomAnchor, constant: 32),
            syncButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
        
    }
    
    func setupAccessibility() {
        
    }

}
