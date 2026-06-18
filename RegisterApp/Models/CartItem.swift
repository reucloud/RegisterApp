//
//  CartItem.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/06/18.
//

import Foundation

struct CartItem: Identifiable {

    let id = UUID()
    var product: Product
    var quantity: Int

}
