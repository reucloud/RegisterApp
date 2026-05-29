//
//  MenuEditView.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/05/17.
//

import SwiftUI
import SwiftData

struct MenuEditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @Query private var products: [Product]
    @Query private var categories: [Category]
    
    @State private var showEditView = false
    @State private var productName = ""
    @State private var productPrice = 0
    @State private var productCategory = ""
    @State private var addCategory = ""
    @State private var productStock = 0
    
        var body: some View {
            VStack(spacing: 0) {
                // ヘッダー
                HStack {
                    Text("商品編集画面")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Text("2026/05/17")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.2))
                
                // メイン
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        // 左メニュー
                        VStack {
                            Text("カテゴリ")
                                .font(.headline)
                            ForEach(categories) { category in
                                HStack{
                                    Button {
                                        
                                    }label:{
                                        Text(category.name)
                                            .frame(maxWidth: .infinity)
                                            .multilineTextAlignment(.center)
                                    }
                                    Spacer()
                                }
                            }
                            
                            Spacer()
                            TextField("カテゴリを追加", text: $addCategory)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                            Button{
                                let category = Category(name: addCategory)
                                
                                context.insert(category)
                                try? context.save()
                            }label:{
                                Text("+追加")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .foregroundStyle(.white)
                                    .background(Color.blue)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8)
                                    )
                            }
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.2)
                        .background(Color.gray.opacity(0.1))
                        
                        // 中央の商品一覧
                        VStack {
                            HStack{
                                Text("商品設定")
                                Spacer()
                                Text("カテゴリ設定")
                            }
                            .font(.title2)
                            List {
                                ForEach(products) { product in
                                    HStack {
                                        Text(product.name)
                                        Spacer()
                                        Text("¥\(product.price)")
                                    }
                                }
                            }
                        }
                        .frame(width: geometry.size.width * 0.6)
                        .padding()
                        
                        // 右のカート
                        
                        VStack {
                            Text("編集欄")
                                .font(.title2)
                            Spacer()
                            
                            Text("商品名")
                            TextField("商品名を入力", text: $productName)
                            
                            Text("価格")
                            TextField("商品名を入力", value: $productPrice, format: .number)
                                .keyboardType(.numberPad)
                            
                            Text("カテゴリ")
                            TextField("商品名を入力", text: $productCategory)
                            
                            Text("在庫")
                            TextField("商品名を入力", value: $productStock, format: .number)
                                .keyboardType(.numberPad)
                            
                            Text("合計: ¥0")
                                .font(.title)
                                .bold()
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.2)
                        .background(Color.orange.opacity(0.1))
                    }
                }
                // フッター
                HStack {
                    Button("キャンセル") {
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("保存") {
                        let product = Product(
                            name: "コーラ",
                            stock: nil,
                            price: 150,
                            summary: ""
                        )
                        
                        context.insert(product)
                        try? context.save()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
}
