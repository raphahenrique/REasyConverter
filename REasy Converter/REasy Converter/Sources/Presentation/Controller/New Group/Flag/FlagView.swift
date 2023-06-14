//
//  FlagView.swift
//  PocketChange ConvMoeda
//
//  Created by Raphael on 13/06/23.
//

import UIKit

class FlagView: UIView {

    private let flagImageView: UIImageView
    private let flagService = FlagsService()
    
    init() {
        flagImageView = UIImageView()

        flagImageView.image = UIImage(named: "brazil")
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        showFlagOptions()
    }
    
    private func showFlagOptions() {
        let alertController = UIAlertController(title: "Select Country", message: nil, preferredStyle: .actionSheet)
        
        let countryOptions = ["BR", "CL", "US"]
        for country in countryOptions {
            let action = UIAlertAction(title: country, style: .default) { [weak self] _ in
                self?.fetchFlagImage(for: country)
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if let viewController = findViewController() {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func fetchFlagImage(for countryCode: String) {
        flagService.fetchFlagImage(for: countryCode) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.flagImageView.image = image
                }
            case .failure(let error):
                print("Failed to fetch flag image: \(error)")
            }
        }
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}

extension FlagView: ViewCodable {
    
    func configureViews() {
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.isUserInteractionEnabled = true
        flagImageView.layer.cornerRadius = 6
        flagImageView.layer.borderWidth = 1.0
        flagImageView.layer.borderColor = UIColor.gray.cgColor
        flagImageView.clipsToBounds = true
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        flagImageView.addGestureRecognizer(gesture)
    }
    
    func buildHierarchy() {
        addViews(
            flagImageView
        )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            flagImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            flagImageView.topAnchor.constraint(equalTo: topAnchor),
            flagImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAccessibility() {
        
    }
}
