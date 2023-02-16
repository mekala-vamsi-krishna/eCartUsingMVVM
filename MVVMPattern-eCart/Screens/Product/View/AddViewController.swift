//
//  AccountViewController.swift
//  MVVMPattern-eCart
//
//  Created by Mekala Vamsi Krishna on 15/02/23.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addProduct()

        func addProduct() {
            
            guard let url = URL(string: "https://dummyjson.com/products/add") else { return }
            
            let parameters = AddProduct(title: "Volvo")
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(parameters)
            request.allHTTPHeaderFields = [
                "Content-Type": "application/json"
            ]
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else { return }
                
                do {
                    let productResponse = try JSONDecoder().decode(AddProduct.self, from: data)
                    print(productResponse)
                } catch {
                    print(error)
                }
            }.resume()
        }
    
    }

}
