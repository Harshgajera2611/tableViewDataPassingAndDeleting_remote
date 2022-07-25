//
//  DetailViewController.swift
//  tableViewDataPassingAndDeleting
//
//  Created by Harsh Gajera on 13/06/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productDetailLabel: UILabel!
    
    var imageProduct: UIImage!
    var name: String!
    var detail: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = imageProduct
        productNameLabel.text = name
        productDetailLabel.text = detail
    }
    


}
