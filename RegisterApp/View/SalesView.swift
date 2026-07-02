//
//  SalesView.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/07/01.
//

import SwiftUI
import SwiftData

struct SalesView: View {
    @Environment(\.modelContext) private var context
    @Query private var products: [Product]
    @Query private var categories: [Category]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SalesView()
}
