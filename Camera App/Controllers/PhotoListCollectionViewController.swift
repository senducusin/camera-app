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
                
            }
            
        }
    }
    
}

extension PhotoListCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoListCollectionViewCell", for: indexPath) as? PhotoListCollectionViewCell else {
            fatalError("PhotoListCollectionViewCell is not found!")
        }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil){ (image, _) in
            
            DispatchQueue.main.async {
                cell.photoImage.image = image
            }
            
        }
        return cell
    }
}
