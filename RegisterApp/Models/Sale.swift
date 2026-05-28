//
//  Sale.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/05/29.
//

import Foundation
import SwiftData

@Model
class Sale {

    var id: UUID
    var cart_id: Int
    var product: Product?
    var category: Category?
    var created_at: Date

    init(cart_id: Int, product: Product?, category: Category?) {
        self.id = UUID()
        self.cart_id = cart_id
        self.product = product
        self.category = category
        self.created_at = Date()
    }
}
