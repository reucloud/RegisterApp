//
//  ContentView.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/05/17.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var products: [Product]
    @Query private var categories: [Category]
    
    @State private var showEditView = false
    @State var totalPrice = 0
    @State var productCount = 0
    @State var selectedCategory: String = "すべて"
    
    @State private var cartItems: [CartItem] = [] // カートに入れた商品を格納する配列
    
    //    列数を3列にする
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // ヘッダー
            HStack {
                Text("レジ管理システム")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Text("2026/05/17")
                Button("商品編集") {
                    showEditView = true
                }
                .buttonStyle(.borderedProminent)
            }
            .fullScreenCover(isPresented: $showEditView) {
                MenuEditView()
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
                                    selectedCategory = category.name
                                }label:{
                                    Text(category.name)
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.2)
                    .background(Color.gray.opacity(0.1))
                    
                    // 中央の商品一覧
                    VStack {
                        Spacer()
                        Text("商品一覧(\(selectedCategory))")
                            .font(.title2)
                        ScrollView{
                            VStack(alignment: .leading) {
                                LazyVGrid(columns: columns) {
                                    ForEach(products){ product in
                                        if selectedCategory == "すべて" || product.category?.name == selectedCategory {
                                            
                                            Button {
                                                if let index = cartItems.firstIndex(where: {
                                                    
                                                    $0.product.id == product.id
                                                    
                                                }) {
                                                    cartItems[index].quantity += 1
                                                }else{
                                                    cartItems.append(
                                                        CartItem(
                                                            product: product,
                                                            quantity: 1
                                                        )
                                                    )
                                                }
                                            } label: {
                                                VStack(alignment: .leading, spacing: 8) {
                                                    
                                                    HStack {
                                                        Text(product.name)
                                                            .font(.headline)
                                                        
                                                        Spacer()
                                                        
                                                        Text("¥\(product.price)")
                                                            .bold()
                                                    }
                                                        Text("ジャンル: \(product.category?.name ?? "なし")")
                                                            .font(.subheadline)
                                                            .foregroundStyle(.gray)
                                                        Spacer()
                                                    Text(product.stock == nil ? "余裕あり" : "在庫: \(product.stock!)")
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
                                            .buttonStyle(.plain)
                                            //                                .padding()
                                        }
                                    }
                                    .scrollContentBackground(.hidden)
                                    .background(Color.white)
                                }
                            }
                        }
                        .padding()
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.6)
                    
                    // 右のカート
                    VStack {
                        Text("カート")
                            .font(.title2)
                        ScrollView{
                            ForEach(cartItems.indices, id: \.self) { index in
                                let item = cartItems[index]
                                
                                VStack{
                                    VStack(alignment: .leading){
                                        HStack{
                                            Text("\(item.product.name)")
                                                .bold()
                                            Spacer()
                                            Button{
                                                cartItems.remove(at: index)
                                            }label:{
                                                Image(systemName: "trash")
                                            }
                                        }
                                        HStack{
                                            Text("¥\(item.product.price)")
                                            Spacer()
                                        }
                                    }
                                    HStack{
                                        Button("-"){
                                            cartItems[index].quantity -= 1
                                        }
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                        .font(.title2)
                                        .foregroundStyle(.black)
                                        
                                        Spacer()
                                        
                                        Text("\(item.quantity)")
                                            .font(.title2)
                                            .bold()
                                        
                                        Spacer()
                                        
                                        Button("+"){
                                            cartItems[index].quantity += 1
                                        }
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                        .font(.title2)
                                        .foregroundStyle(.black)
                                    }
                                    .frame(maxWidth: .infinity)
                                    Text("小計: ¥\(item.product.price * item.quantity)")
                                }
                                .padding()
                                .bold()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                            }
                        }
                        
                        Spacer()
                        let totalQuantity = cartItems.reduce(0) { total, item in
                            total + item.quantity
                        }
                        let totalPrice = cartItems.reduce(0) { total, item in
                            total + item.product.price * item.quantity
                        }
                        Text("合計:\(totalQuantity)点 ¥\(totalPrice)")
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
                Button("取消") {
                    totalPrice = 0
                    productCount = 0
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("会計") {
                    
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.05))
        }
    }
}

