//
//  UIImageView+Extensions.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/22/21.
//

import Foundation
import UIKit

extension UIImageView{
    static func imageForFilterView() -> UIImageView {
        let filterImageView = UIImageView(image: UIImage(named: "default-preview"))
        filterImageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 70, height: 70))
        filterImageView.layer.cornerRadius = 6.0
        filterImageView.layer.masksToBounds = true
        return filterImageView
    }
}
