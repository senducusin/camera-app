//
//  UIViewController+Extensions.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/19/21.
//

import Foundation
import UIKit

extension UIViewController{
    
    func addChildController(_ childVC: UIViewController){
        self.addChild(childVC)
        childVC.view.frame = self.view.frame
        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
}
