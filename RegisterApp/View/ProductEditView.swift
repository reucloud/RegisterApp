//
//  ProductEditView.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/06/21.
//

import SwiftUI
import SwiftData

struct ProductEditView: View {
    @Query private var categories: [Category]
    @Environment(\.modelContext) private var context

    var product: Product

    @Binding var productName: String
    @Binding var productPrice: Int
    @Binding var productCategory: Category?
    @Binding var productStock: Int

    @Binding var isPresented: Bool

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("商品編集")
                .font(.title2)
                .bold()

            HStack {
                Text("名前")
                    .frame(width: 70, alignment: .leading)

                TextField(
                    "商品名",
                    text: $productName
                )
                .textFieldStyle(.roundedBorder)
            }

            HStack {
                Text("価格")
                    .frame(width: 70, alignment: .leading)

                TextField(
                    "価格",
                    value: $productPrice,
                    format: .number
                )
                .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("カテゴリ")
                    .frame(width: 70, alignment: .leading)
                Picker("カテゴリ", selection: $productCategory) {
                    ForEach(categories) { category in
                        Text(category.name)
                            .tag(category as Category?)
                    }
                }
                .pickerStyle(.menu)
                .tint(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            }

            HStack {
                Text("在庫")
                    .frame(width: 70, alignment: .leading)

                TextField(
                    "在庫",
                    value: $productStock,
                    format: .number
                )
                .textFieldStyle(.roundedBorder)
            }

            HStack {

                Button("キャンセル") {
                    isPresented = false
                }

                Spacer()

                Button("保存") {
                    product.category = productCategory
                    product.name = productName
                    product.price = productPrice
                    product.stock = productStock
                    try? context.save()
                    isPresented = false
                }
            }
        }
        .padding()
        .frame(width: 400)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}
