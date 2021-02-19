//
//  PhotoListCollectionViewController.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/19/21.
//

import Foundation
import UIKit
import Photos

class PhotoListCollectionViewController: UICollectionViewController{
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.populatePhotos()
    }
    
    private func requestPermission(completion:@escaping(PHAuthorizationStatus) -> ()){
        PHPhotoLibrary.requestAuthorization{ status in
            DispatchQueue.main.async {
                completion(status)
            }
        }
    }
    
    private func populatePhotos(){
        
        self.requestPermission(){ [weak self] status in
            if status == .authorized {
                
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects{  (objects, count, stop) in
                    self?.images.append(objects)
                }
                
                self?.images.reverse()
                self?.collectionView.reloadData()
                print(self?.images)
                
            }
            
        }
    }
    
}
