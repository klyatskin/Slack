//
//  String+Extensions.swift
//  CodingExerciseTests
//
//  Copyright © 2021 slack. All rights reserved.
//

import Foundation


extension String {

    func random(_ n: Int) -> String {
        let digits = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String(Array(0..<n).map { _ in digits.randomElement()! })
    }


}
