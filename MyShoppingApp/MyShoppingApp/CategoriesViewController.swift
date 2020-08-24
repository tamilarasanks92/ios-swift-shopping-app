//
//  CategoriesViewController.swift
//  MyShoppingApp
//
//  Created by aspire on 8/14/20.
//  Copyright © 2020 aspire. All rights reserved.
//

import UIKit
import Alamofire

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categoriesList: [Any] = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        AF.request("URL_REQUEST", method: .get).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                if let jsonValue = value as? [String: Any] {
                    if let list = jsonValue["categories"] as? [Any] {
                        self.categoriesList = list
                        self.tableView.reloadData()
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

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cellID"), let category = self.categoriesList[indexPath.row] as? [String: Any], let categoryName = category["category"] as? String  else {
            return UITableViewCell(frame: CGRect.zero)
        }
        cell.textLabel?.text = categoryName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "ItemListViewController") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
