//
//  SalesView.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/07/01.
//

import SwiftUI
import SwiftData

struct SalesView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @Query private var products: [Product]
    @Query private var categories: [Category]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // ヘッダー
                HStack {
                    Text("商品編集画面")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Text("2026/05/17")
                    Button("オーダー画面へ") {
                        dismiss()
                    }
                }
                .padding()
//                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.2))
                
                
            }
        }
    }
}
