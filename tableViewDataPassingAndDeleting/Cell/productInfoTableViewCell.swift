//
//  productInfoTableViewCell.swift
//  tableViewDataPassingAndDeleting
//
//  Created by Harsh Gajera on 13/06/22.
//

import UIKit

class productInfoTableViewCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLbl: UILabel!
    @IBOutlet var productDetailLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
