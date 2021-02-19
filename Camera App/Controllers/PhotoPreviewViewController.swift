//
//  PhotoPreviewViewController.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/19/21.
//

import Foundation
import UIKit

class PhotoPreviewViewController:UIViewController{
    
    @IBOutlet weak var photoImageView: UIImageView!
    var previewImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoImageView.image = self.previewImage
    }
}
