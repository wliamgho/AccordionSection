//
//  Ext+View.swift
//  AccordionSection
//
//  Created by William on 13/01/22.
//

import UIKit

public extension UIView {
    /// add Multiple subviews using Variadic
    func addSubviews(_ view: UIView...) {
        view.forEach { self.addSubview($0) }
    }
}

extension UIStackView {
    func addMultipleArrangeSubviews(_ view: UIView...) {
        view.forEach {
            self.addArrangedSubview($0)
        }
    }
}
