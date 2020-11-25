//
//  FilterManager.swift
//  fotoroid
//
//  Created by Thiago Antonio Ramalho on 24/11/20.
//  Copyright © 2020 Tramalho. All rights reserved.
//

import UIKit

enum FilterType: Int {
    case comic
    case sepia
    case halftone
    case crystallize
    case vignette
    case noir
}

class FilterManager {
    
    private let originalImage: UIImage
    private let context = CIContext(options: nil)
    private let filterNames = [
        "CIComicEffect",
        "CISepiaTone",
        "CICMYHalftone",
        "CICrystallize",
        "CIVignette",
        "CIPhotoEffectNoir"
    ]
    
    init(image: UIImage) {
        self.originalImage = image
    }
    
    func apply(filterType: FilterType) -> UIImage {
        let ciImage = CIImage(image: originalImage)
        let filter = CIFilter(name: filterNames[filterType.rawValue])
        
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        switch filterType {
        case .sepia:
            filter?.setValue(1, forKey: kCIInputIntensityKey)
        case .halftone:
            filter?.setValue(25, forKey: kCIInputWidthKey)
        case .crystallize:
            filter?.setValue(25, forKey: kCIInputRadiusKey)
        case .vignette:
            filter?.setValue(3, forKey: kCIInputIntensityKey)
            filter?.setValue(30, forKey: kCIInputRadiusKey)
        case .comic:
            break
        case .noir:
            break
        }
        
        let filteredImage = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent)
        
        return UIImage(cgImage: cgImage!)
    }
}
