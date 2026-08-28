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
    @State private var addCategory = ""
    
    //    新規追加用の変数
    @State private var productName = ""
    @State private var productPrice = 0
    @State private var productCategory = ""
    @State private var selectedCategory: Category?
    @State private var productStock: Int? = nil
    
    //    製品編集用の変数
    @State private var editProductName = ""
    @State private var editProductPrice = 0
    @State private var editProductCategoryName = ""
    @State private var editSelectedCategory: Category?
    @State private var editProductStock: Int? = nil

    @State private var editingProduct: Product?
    
    @State private var editProduct: Bool = false
    
    //    列数を3列にする
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                            ScrollView{
                                ForEach(categories) { category in
                                    ZStack {

                                            Text(category.name)
                                                .frame(maxWidth: .infinity)
                                                .multilineTextAlignment(.center)
                                        
                                        HStack {
                                            Spacer()
                                            
                                            if category.name != "すべて"{
                                                Button {
                                                    context.delete(category)
                                                    try? context.save()
                                                } label: {
                                                    Image(systemName: "trash")
                                                }
                                            }
                                        }
                                    }
                                    .foregroundStyle(.black)
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
                                Text("商品設定")
                            .font(.title2)
                            //                            List {
                            ScrollView {
                                LazyVGrid(columns: columns) {
                                    ForEach(products.indices, id: \.self) { index in
                                        let product = products[index]
                                        Button{
                                            editingProduct = product
                                            editProductName = product.name
                                            editProductPrice = product.price
                                            editSelectedCategory = product.category
                                            editProductCategoryName = product.category?.name ?? ""
                                            editProductStock = product.stock
                                            editProduct = true
                                        }label:{
                                            VStack(alignment: .leading, spacing: 8) {
                                                
                                                HStack {
                                                    Text(product.name)
                                                        .font(.headline)
                                                    Text(
                                                        product.stock == nil
                                                            ? "在庫管理なし"
                                                            : "在庫: \(product.stock!)"
                                                    )
                                                    
                                                    Spacer()
                                                    
                                                    Button {
                                                        product.is_hidden.toggle()
                                                        
                                                        do {
                                                            try context.save()
                                                        } catch {
                                                            print("保存失敗:", error)
                                                        }
                                                    } label: {
                                                        Image(systemName: product.is_hidden ? "eye.slash.fill" : "eye.fill")
                                                    }
                                                    
                                                }
                                                HStack{
                                                    Text("ジャンル: \(product.category?.name ?? "なし")")
                                                        .font(.subheadline)
                                                        .foregroundStyle(.gray)
                                                    
                                                    Spacer()
                                                    
                                                    Text("¥\(product.price)")
                                                        .bold()
                                                }
                                            }
                                            .padding()
                                            .background(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                            )
                                            .cornerRadius(12)
                                            .padding(.vertical, 4)
                                        }
                                        .foregroundStyle(.black)
                                    }
                                }
                            }
                            //                                .overScreenCover(isPresented: $editProduct) {
                            
                            //                            }
                        }
                        .padding()
                        .frame(width: geometry.size.width * 0.6)
//                        .padding()
                        
                        // 右のカート
                        
                        VStack {
                            Text("商品追加欄")
                                .font(.title2)
                            Spacer()
                            
                            Text("商品名")
                            TextField("商品名を入力", text: $productName)
                            
                            Text("価格")
                            TextField("商品名を入力", value: $productPrice, format: .number)
                                .keyboardType(.numberPad)
                            
                            VStack {
                                Text("カテゴリ")
                                    .frame(width: 70, alignment: .leading)
                                Picker("カテゴリ", selection: $selectedCategory) {
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
                            
                            Text("在庫")
                            TextField("商品名を入力", value: $productStock, format: .number)
                                .keyboardType(.numberPad)
                            
                            Button{
                                let product = Product(
                                    category: selectedCategory,
                                    name: productName,
                                    stock: productStock,
                                    price: productPrice,
                                    summary: ""
                                )
                                
                                context.insert(product)
                                try? context.save()
                            }label:{
                                Text("保存")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .foregroundStyle(.white)
                                    .background(Color.blue)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8)
                                    )
                                
                            }
                        }
//                        .padding()
                        .padding()
                        .frame(width: geometry.size.width * 0.2)
                        .background(Color.orange.opacity(0.1))
                    }
                }
                .padding()
                // フッター
                HStack {
                    Spacer()
                    Button("オーダー画面へ") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if editProduct {

                Color.black.opacity(0.3)
                    .ignoresSafeArea()

                if let editingProduct {
                    ProductEditView(
                        product: editingProduct,
                        productName: $editProductName,
                        productPrice: $editProductPrice,
                        productCategory: $editSelectedCategory,
                        productStock: $editProductStock,
                        isPresented: $editProduct
                    )
                }
            }
        }
    }
}
