//
//  ProductViewModel.swift
//  MVVMPattern-eCart
//
//  Created by Mekala Vamsi Krishna on 14/02/23.
//

import Foundation

// The communicatio b/w ViewModel and View is known as Data Binding, this can be done by using protocols ans delegates or closures

final class ProductViewModel {
    
    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    
    /*
    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts { result in
            self.eventHandler?(.stopLoading)
            switch result {
            case .success(let products):
                print(products)
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
     */
    
    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.request(modelType: [Product].self, type: ProductEndPoint.products) { result in
            self.eventHandler?(.stopLoading)
            switch result {
            case .success(let products):
                print(products)
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func addProduct(parameters: AddProduct) {
        APIManager.shared.request(modelType: AddProduct.self, type: ProductEndPoint.addProduct(product: parameters)) { results in
            switch results {
            case .success(let product):
                self.eventHandler?(.newProductAdded(product: product))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
}

extension ProductViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newProductAdded(product: AddProduct)
    }
    
}
