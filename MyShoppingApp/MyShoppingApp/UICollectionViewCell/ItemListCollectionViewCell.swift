//
//  ItemListCollectionViewCell.swift
//  MyShoppingApp
//
//  Created by aspire on 8/17/20.
//  Copyright © 2020 aspire. All rights reserved.
//

import UIKit

class ItemListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var imageName: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imageView.image = UIImage(named: imageName)
    }

}
