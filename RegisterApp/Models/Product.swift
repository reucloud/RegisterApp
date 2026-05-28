//
//  Product.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/05/17.
//

import Foundation
import SwiftData

@Model
class Product {

    var name: String
    var price: Int
    var junre: String
    var category: Int

    init(name: String, price: Int) {
        self.name = name
        self.price = price
        self.junre = ""
        self.category = 0
    }
}
