//
//  UserCell.swift
//  CodingExercise
//
//  Copyright © 2021 slack. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var imageViewAvatar: LazyUIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var constrainNameWidth: NSLayoutConstraint!
    
    
    func render(user: UserSearchResult) {
        lblName.text = user.displayName
        lblUsername.text = user.username
        imageViewAvatar.urlString = user.avatarUrlStr
        let fontAttributes = [NSAttributedString.Key.font: lblName.font]
        let box = (lblName.text! as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        constrainNameWidth.constant = box.width
        imageViewAvatar.layer.cornerRadius = Constants.cellImageCornerRadius
    }


}













