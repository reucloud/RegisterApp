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

    var id: UUID
    var category: Category?
    var name: String
    var stock: Int?
    var is_soldout: Bool
    var is_hidden: Bool
    var price: Int
//    var image: Data?
    var summary: String

    init(category: Category? = nil, name: String, stock: Int?, price: Int, summary: String) {
        self.id = UUID()
        self.category = category //後からカテゴリを選択したらそのidを格納する設計にする
        self.name = name
        self.stock = stock
        self.is_soldout = false
        self.is_hidden = false
        self.price = price
//        self.image = nil
        self.summary = summary
    }
}
