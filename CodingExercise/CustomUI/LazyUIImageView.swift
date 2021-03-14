//
//  LazyUIImageView.swift
//  CodingExercise
//
//  Copyright © 2021 slack. All rights reserved.
//

import UIKit


/**
 UIImageView loading a n image asynchronously
 */


class LazyUIImageView: UIImageView {

    
    private var _urlString: String?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImage(named: "WaitIcon")
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        image = UIImage(named: "WaitIcon")
    }
    
    
    var urlString: String? {
        get {
            return _urlString
        }
        set(urlString) {
            _urlString = urlString
            guard let urlString = urlString else {
                setImage(nil)
                return
            }
            if  let url = URL(string: urlString),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                    setImage(image)
            }
        }
    }

    
    private func setImage(_ image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.image = image
        }
    }
    
    
}
