//
//  String+Extension.swift
//  REasy Converter
//
//  Created by Raphael on 19/03/23.
//

import UIKit

extension String {

    func replace(this: String, with newString: String) -> String {
        let text = self.replacingOccurrences(of: this,
                                             with: newString)
        return text
    }
}
