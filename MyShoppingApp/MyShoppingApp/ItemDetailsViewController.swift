//
//  ItemDetailsViewController.swift
//  MyShoppingApp
//
//  Created by aspire on 8/17/20.
//  Copyright © 2020 aspire. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDescription: UITextView!
    var itemList: [String: Any] = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let name = itemList["item"] as? String, let description = itemList["description"] as? String, let image = itemList["image"] as? String {
            lblProductName.text = name
            lblProductDescription.text = description
            imageView.image = UIImage(named: image)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
