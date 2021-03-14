//
//  UIImage+Extensions.swift
//  CodingExercise
//
//  Created by Konstantin Klyatskin on 2021-03-13.
//  Copyright © 2021 slack. All rights reserved.
//

import UIKit

extension UIImage {

    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }

}
