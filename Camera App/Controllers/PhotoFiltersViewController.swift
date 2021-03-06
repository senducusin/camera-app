//
//  PhotoFiltersViewController.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/19/21.
//

import Foundation
import UIKit

protocol PhotoFilterViewControllerDelegate {
    func photoFilterDone()
    func photoFilterCancel()
}

class PhotoFiltersViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filtersScrollView: FiltersScrollView!
    
    var delegate: PhotoFilterViewControllerDelegate?
    var image: UIImage?
    private var filterService: FilterService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBAction func cancelButtonPressed(){
        self.delegate?.photoFilterCancel()
    }
    
    @IBAction func doneButtonPressed(){
        guard let selectedImage = self.photoImageView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_ : didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error {
            print(error.localizedDescription)
        }else {
            self.delegate?.photoFilterDone()
        }
    }
    
    private func setupUI(){
        self.filterService = FilterService()
        self.filtersScrollView.filterDelegate = self
        self.photoImageView.image = self.image
    }
}

extension PhotoFiltersViewController: FiltersScrollViewDelegate{
    func filtersScrollViewDidSelectFilter(filter: CIFilter) {
        self.filterService.applyFilter(filter: filter, to: self.image!){
            self.photoImageView.image = $0
        }
    }
}
