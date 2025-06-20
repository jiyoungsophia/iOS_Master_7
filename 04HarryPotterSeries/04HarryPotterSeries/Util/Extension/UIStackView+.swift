//
//  UIStackView+.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/20/25.
//

import UIKit

extension UIStackView {
    func clearArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func addArrangedSubviews<T>(from data: [T], viewBuilder: (T, Int) -> UIView) {
        data.enumerated().forEach { index, item in
            let view = viewBuilder(item, index)
            addArrangedSubview(view)
        }
    }
}
