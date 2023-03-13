//
//  UIView+Extension.swift
//  REasy Converter
//
//  Created by Raphael on 13/03/23.
//

import UIKit

extension UIView {

    func addViews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }

}
