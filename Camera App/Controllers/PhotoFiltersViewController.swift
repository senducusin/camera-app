//
//  PhotoFiltersViewController.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/19/21.
//

import Foundation
import UIKit

class PhotoFiltersViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filtersScrollView: FiltersScrollView!
    
    var image: UIImage?
    private var filterService: FilterService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
