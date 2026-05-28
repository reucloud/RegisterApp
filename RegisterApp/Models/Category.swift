//
//  Category.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/05/29.
//

import Foundation
import SwiftData

@Model
class Category {

    var id: UUID
    var name: String

    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}
