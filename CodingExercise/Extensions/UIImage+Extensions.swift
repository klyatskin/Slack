//
//  UIImage+Extensions.swift
//  CodingExercise
//
//  Copyright © 2021 slack. All rights reserved.
//

import UIKit

extension UIImage {
    
//    https://nshipster.com/image-resizing/
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }

}
