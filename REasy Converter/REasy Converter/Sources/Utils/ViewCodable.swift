//
//  ViewCodable.swift
//  REasy Converter
//
//  Created by Raphael on 12/03/23.
//

import Foundation

public protocol ViewCodable {

    func configureViews()

    func buildHierarchy()

    func setupConstraints()

    func setupAccessibility()

}

public extension ViewCodable {

    func setupView() {
        configureViews()
        buildHierarchy()
        setupConstraints()
        setupAccessibility()
    }

    func configureViews() {}

    func buildHierarchy() {}

    func setupConstraints() {}
    
    func setupAccessibility() {}

}
