//
//  ItemListViewController.swift
//  MyShoppingApp
//
//  Created by aspire on 8/17/20.
//  Copyright © 2020 aspire. All rights reserved.
//

import UIKit
import Alamofire

class ItemListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var itemList: [Any] = [Any]()
    var estimateWidth = 160.0
    var cellMarginSize = 16.0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: "ItemListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemListCollectionViewCell")
        
        AF.request("URL_REQUEST", method: .get).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let jsonValue = value as? [String: Any] {
                    if let list = jsonValue["items"] as? [Any] {
                        self.itemList = list
                        self.collectionView.reloadData()
                    }
                }
                break
            case .failure(let error):
                print("Error:\(error)")
                break
            }
        })
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

extension ItemListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemListCollectionViewCell", for: indexPath) as? ItemListCollectionViewCell, let item = self.itemList[indexPath.row] as? [String: Any], let itemName = item["item"] as? String, let itemPrice = item["price"] as? String, let itemImg = item["image"] as? String else  {
            return UICollectionViewCell()
        }
        cell.lblItemName.text = itemName
        cell.lblItemPrice.text = itemPrice
        cell.imageView.image = UIImage(named: itemImg)
        cell.backgroundColor = #colorLiteral(red: 0.03137254902, green: 0.2980392157, blue: 0.3803921569, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "ItemDetailsViewController") as? ItemDetailsViewController, let item = self.itemList[indexPath.row] as? [String: Any] {
            vc.itemList = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ItemListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width)
    }
    
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
    
}
