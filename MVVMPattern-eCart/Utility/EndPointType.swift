//
//  EndPointType.swift
//  MVVMPattern-eCart
//
//  Created by Mekala Vamsi Krishna on 15/02/23.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
}

enum EndPointItems {
    case products
}

//https://fakestoreapi.com/products

extension EndPointItems: EndPointType {
    
    var path: String {
        return "products"
    }
    
    var baseURL: String {
        return "https://fakestoreapi.com/"
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        }
//        return .get
    }
    
}
