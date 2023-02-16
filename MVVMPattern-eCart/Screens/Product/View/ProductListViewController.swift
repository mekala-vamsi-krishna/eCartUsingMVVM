//
//  ProductListViewController.swift
//  MVVMPattern-eCart
//
//  Created by Mekala Vamsi Krishna on 14/02/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet var productTableView: UITableView!
    
    private var viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.dataSource = self

        configuration()
    }
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let product = AddProduct(title: "iPhone")
        viewModel.addProduct(parameters: product)
    }
    
}

extension ProductListViewController {
    
    func configuration() {
        productTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    // Data Binding event - Communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            
            switch event {
            case .loading:
                print("Product Loading...")
            case .stopLoading:
                print("Stop Loding...")
            case .dataLoaded:
                print("Data Loaded.")
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            case .newProductAdded(let newProduct):
                print(newProduct)
            }
        }
    }
    
}


extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
}
