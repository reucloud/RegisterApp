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
    @Query private var products: [Product]
    
        var body: some View {
            VStack(spacing: 0) {
                // ヘッダー
                HeaderView()
                // メイン
                MainView()
                // フッター
                FooterView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
}

private struct HeaderView: View {
    @State private var showEditView = false
    
    var body: some View {
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
    }
}

private struct MainView: View {
    @Query private var products: [Product]
    @State private var productName = ""
    @State private var productPrice = 0
    @State private var productCategory = ""
    @State private var productStock = 0
    
    var body: some View {
        HStack(spacing: 0) {
            // 左メニュー
            VStack {
                Text("カテゴリ")
                    .font(.headline)
                Button{
                    
                }label:{
                    Text("全て")
                }
                Button{
                    
                }label:{
                    Text("飲み物")
                }
                Button{
                    
                }label:{
                    Text("お菓子")
                }
                
                Spacer()
            }
            .padding()
            .frame(width: 200)
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
            .frame(maxWidth: .infinity)
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
            .frame(width: 300)
            .background(Color.orange.opacity(0.1))
        }
    }
}

private struct FooterView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HStack {
            Button("キャンセル") {
                dismiss()
            }
            .buttonStyle(.bordered)
            
            Spacer()

            Button("保存") {
                let product = Product(name: "コーラ", price: 150)
                context.insert(product)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MenuEditView()
}
