//
//  AppContainerViewController.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/19/21.
//

import Foundation
import UIKit

class AppContainerViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photoListCVC = self.children.first as? PhotoListCollectionViewController else {
            return
        }
        
        photoListCVC.delegate = self
    }
    
    @IBAction func cameraButtonPressed(){
        guard let photoFiltersVC = self.storyboard?.instantiateViewController(identifier: "PhotoFiltersViewController") as? PhotoFiltersViewController else {
            fatalError("PhotoFiltersViewController is not found!")
        }
        
        self.addChildController(photoFiltersVC)
    }
    
}

extension AppContainerViewController: PhotoListCollectionViewControllerDelegate{
    func photoListDidSelectImage(selectedImage: UIImage) {
        self.showImagePreview(previewImage: selectedImage)
    }
    
    private func showImagePreview(previewImage: UIImage){
        guard let photoPreviewVC = self.storyboard?.instantiateViewController(identifier: "PhotoPreviewViewController") as? PhotoPreviewViewController else {
            fatalError("PhotoPreviewViewController is not found!")
        }
        
        photoPreviewVC.previewImage = previewImage
        self.navigationController?.pushViewController(photoPreviewVC, animated: true)
    }
}
