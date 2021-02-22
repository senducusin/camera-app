//
//  AppContainerViewController.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/19/21.
//

import Foundation
import UIKit

class AppContainerViewController: UIViewController, UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photoListCVC = self.children.first as? PhotoListCollectionViewController else {
            return
        }
        
        photoListCVC.delegate = self
    }
    
    @IBAction func cameraButtonPressed(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .camera
            imagePickerVC.delegate = self
            
            self.present(imagePickerVC, animated: true, completion: nil)
        }
        
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

extension AppContainerViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
