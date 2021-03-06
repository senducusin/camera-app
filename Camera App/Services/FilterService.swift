//
//  FilterService.swift
//  Camera App
//
//  Created by Jansen Ducusin on 2/22/21.
//

import Foundation
import UIKit
import CoreImage

class FilterService {
    private var context :CIContext
    
    init (){
        self.context = CIContext()
    }
    
    static func all() -> [CIFilter]{
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValue(5.0, forKey: kCIInputRadiusKey)
        
        let halfToneFilter = CIFilter(name: "CICMYKHalftone")!
        halfToneFilter.setValue(5.0, forKey: kCIInputWidthKey)
        
        let crystallizeFilter = CIFilter(name: "CICrystallize")!
        crystallizeFilter.setValue(5.0, forKey: kCIInputRadiusKey)
        
        let monochromeFilter = CIFilter(name: "CIColorMonochrome")!
        monochromeFilter.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: kCIInputColorKey)
        monochromeFilter.setValue(10.0, forKey: kCIInputIntensityKey)
        
        let sepiaFilter = CIFilter(name: "CISepiaTone")!
        sepiaFilter.setValue(10.0, forKey: kCIInputIntensityKey)
        
        return [blurFilter, crystallizeFilter, halfToneFilter, monochromeFilter, sepiaFilter]
    }
    
    func applyFilter(filter:CIFilter, to inputImage: UIImage, completion:@escaping((UIImage) -> ())){
        let sourceImage = CIImage(image: inputImage)!
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        if let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
            completion(processedImage)
        }
    }
}
