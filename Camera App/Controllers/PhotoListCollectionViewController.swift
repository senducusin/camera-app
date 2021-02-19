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
        self.requestPermission(){ status in
            if status == .authorized {
                print("Authorized!")
            }
        }
    }
    
}
