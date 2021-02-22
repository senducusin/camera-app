//
//  FiltersScrollView.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/22/21.
//

import Foundation
import UIKit
import CoreImage

protocol FiltersScrollViewDelegate{
    func filtersScrollViewDidSelectFilter(filter:CIFilter)
}

class FiltersScrollView: UIScrollView{
    var filterDelegate: FiltersScrollViewDelegate?
    var filterSelectors = [UIImageView]()
    
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
            
            self.registerTapGestureRecognizer(for: filterImageView)
            
            filterImageView.isUserInteractionEnabled = true
            filterImageView.tag = index
            filterImageView.frame.origin.x = offset
            filterImageView.center.y = self.frame.height/2 - 15
            
            filterSelectors.append(filterImageView)
            
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

extension FiltersScrollView {
    private func registerTapGestureRecognizer(for view: UIView){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapped(recognizer: UITapGestureRecognizer){
        guard let selectedFilterView = recognizer.view as? UIImageView else {
            return
        }
        
        self.clearFilterSelected()
        self.showFilterIsSelected(selectedFilterView: selectedFilterView)
        
        self.filterDelegate?.filtersScrollViewDidSelectFilter(filter: FilterService.all()[selectedFilterView.tag])
    }
    
    private func clearFilterSelected(){
        for filterSelector in filterSelectors {
            filterSelector.layer.borderWidth = 0.0
        }
    }
    
    private func showFilterIsSelected(selectedFilterView:UIImageView){
        selectedFilterView.layer.masksToBounds = true
        selectedFilterView.layer.borderColor = UIColor.white.cgColor
        selectedFilterView.layer.borderWidth = 2.0
    }
}
