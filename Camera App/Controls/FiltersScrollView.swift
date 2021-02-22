//
//  FiltersScrollView.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/22/21.
//

import Foundation
import UIKit
import CoreImage

class FiltersScrollView: UIScrollView{
    
    private var filterService: FilterService!
    
    init(parentView: UIView, frame: CGRect = CGRect.zero){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        delegate = self
        self.filterService = FilterService()
        setupFilters()
    }
    
    private func setupFilters(){
        var offset: CGFloat = 10.0
        
        for (index, filter) in FilterService.all().enumerated(){
            
            let filterImageView = UIImageView.imageForFilterView()
            self.addSubview(filterImageView)
            
            filterImageView.tag = index
            filterImageView.frame.origin.x = offset
            filterImageView.center.y = self.frame.height/2 - 15
            
            offset += filterImageView.frame.width + filterImageView.frame.width/4
            self.contentSize = CGSize(width: offset, height: self.frame.height)
            
            self.filterService.applyFilter(filter: filter, to: filterImageView.image!) { filterImageView.image = $0 }
        }
    }
}

extension FiltersScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0
    }
}
