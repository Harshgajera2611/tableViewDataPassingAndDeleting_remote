//
//  ViewController.swift
//  tableViewDataPassingAndDeleting
//
//  Created by Harsh Gajera on 13/06/22.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {

    // MARK: - Ib Outlets
    @IBOutlet var detalTableview: UITableView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var changeBtn: UIButton!
    
    // MARK: - variables
    var arrProduct = [Product]()
    var selectProduct = [Product]()
    var index = IndexPath()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchbar()
        self.getData()
        detalTableview.register(UINib(nibName: "productInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "productInfoTableViewCell")
        detalTableview.separatorStyle = .none
        self.detalTableview.isEditing = true
        self.detalTableview.allowsMultipleSelectionDuringEditing = true
        self.detalTableview.delegate = self
    }
    
    
    // MARK: - search bar setup
    func setUpSearchbar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    // MARK: - arrar Function
    func getData() {
        arrProduct = [Product(image: UIImage(named: "1"), productName: "Oppo", productDetail: "mobile"),Product(image: UIImage(named: "1"), productName: "vivo", productDetail: "tablet"),Product(image: UIImage(named: "1"), productName: "samsung", productDetail: "smartphone"),Product(image: UIImage(named: "1"), productName: "mi", productDetail: "charger"),Product(image: UIImage(named: "1"), productName: "Oppo", productDetail: "cover"),Product(image: UIImage(named: "1"), productName: "Oppo", productDetail: "mobile"),Product(image: UIImage(named: "1"), productName: "apple", productDetail: "iphone"),Product(image: UIImage(named: "1"), productName: "apple", productDetail: "airpods"),Product(image: UIImage(named: "1"), productName: "vivo", productDetail: "earphone"),Product(image: UIImage(named: "1"), productName: "samsung", productDetail: "battery")]
    }
    
    // MARK: - Button Action
    @IBAction func selectAllButtonTapped(_ sender: UIButton) {
//        self.selectProduct.removeAll()
//        if sender.isSelected {
//            for row in 0..<arrProduct.count {
//                self.detalTableview.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
//            }
//            sender.isSelected = false
//            selectProduct = arrProduct
//        } else {
//            for row in 0..<arrProduct.count {
//                self.detalTableview.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
//            }
//            sender.isSelected = true
//            self.selectProduct.removeAll()
//        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        dump(selectProduct)
    }
    
    
    @IBAction func changeButtonTapped(_ sender: UIButton) {
//        if let cell = detalTableview.cellForRow(at: index) as? productInfoTableViewCell {
//            cell.productNameLbl.text = self.nameTextField.text
//        }
    }
    
    
    @IBAction func textFieldEditChanged(_ sender: UITextField) {
        if let cell = detalTableview.cellForRow(at: index) as? productInfoTableViewCell {
            cell.productNameLbl.text = self.nameTextField.text
        }
    }
    
    
}

// MARK: - extension of table view
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productInfoTableViewCell", for: indexPath) as! productInfoTableViewCell
        cell.productImageView.image = arrProduct[indexPath.row].image
        cell.productNameLbl.text = arrProduct[indexPath.row].productName
        cell.productDetailLbl.text = arrProduct[indexPath.row].productDetail
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath
        self.nameTextField.text = "\(arrProduct[indexPath.row].productName)"
        
//        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        detailViewController.imageProduct = arrProduct[indexPath.row].image
//        detailViewController.name = arrProduct[indexPath.row].productName
//        detailViewController.detail = arrProduct[indexPath.row].productDetail
//        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        
        self.selectDeSelect(tableView: detalTableview, indexPath: indexPath)
//        arrProduct.remove(at: indexPath.row)
//        detalTableview.deleteRows(at: [indexPath], with: .fade)
        print("select")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectDeSelect(tableView: detalTableview, indexPath: indexPath)
        print("did select")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrProduct.remove(at: indexPath.row)
            detalTableview.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity,-60, 0, -60)
        cell.layer.transform = transform
        
        UIView.animate(withDuration: 1) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

// MARK: - extension for cell select and deselect
extension ViewController {
    func selectDeSelect(tableView: UITableView, indexPath: IndexPath) {
        self.selectProduct.removeAll()
        if let arr = detalTableview.indexPathsForSelectedRows {
            for index in arr {
                selectProduct.append(arrProduct[index.row])
            }
        }
        print(selectProduct)
    }
}


// MARK: - extension for searchController
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        if searchText == "" {
            getData()
        } else {
            getData()
            arrProduct = arrProduct.filter {
                $0.productName.contains(searchText)
            }
            self.detalTableview.reloadData()
        }
    }
    
    
}
