//
//  AppContainerViewController.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/19/21.
//

import Foundation
import UIKit

class AppContainerViewController: UIViewController{
    
    @IBAction func cameraButtonPressed(){
        guard let photoFiltersVC = self.storyboard?.instantiateViewController(identifier: "PhotoFiltersViewController") as? PhotoFiltersViewController else {
            fatalError("PhotoFiltersViewController is not found!")
        }
        
        self.addChild(photoFiltersVC)
        photoFiltersVC.view.frame = self.view.frame
        self.view.addSubview(photoFiltersVC.view)
        photoFiltersVC.didMove(toParent: self)
    }
    
}
