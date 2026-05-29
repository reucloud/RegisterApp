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
                        Text("商品一覧")
                            .font(.title2)
                        ScrollView{
                            VStack(alignment: .leading) {
                                ForEach(products) { product in
                                    
                                    Button {
                                        totalPrice += product.price
                                        productCount += 1
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
                                .scrollContentBackground(.hidden)
                                .background(Color.white)
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
                        Spacer()
                        
                        Text("合計:\(productCount)点 ¥\(totalPrice)")
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

