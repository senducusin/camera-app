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
        let screenRect = UIScreen.main.bounds
        print(screenRect.width)
        
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
        self.showPhotoFiltersViewController(for: originalImage)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func showPhotoFiltersViewController(for image:UIImage){
        guard let photoFilterVC = self.storyboard?.instantiateViewController(identifier: "PhotoFiltersViewController") as? PhotoFiltersViewController else {
            
            fatalError("PhotoFiltersViewController is not found!")
        }
        
        photoFilterVC.image = image
        photoFilterVC.delegate = self
        self.addChildController(photoFilterVC)
    }
}

extension AppContainerViewController: PhotoFilterViewControllerDelegate{
    func photoFilterCancel() {
        self.showPhotosList()
    }
    
    func photoFilterDone() {
        self.showPhotosList()
    }
    
    private func showPhotosList(){
        self.view.subviews.forEach{
            $0.removeFromSuperview()
        }
        
        guard let photoListCVC = self.storyboard?.instantiateViewController(identifier: "PhotoListCollectionViewController") as?  PhotoListCollectionViewController else {
            fatalError("PhotoListCollectionViewController is not found!")
        }
        
        photoListCVC.delegate = self
        self.addChildController(photoListCVC)
    }
}
