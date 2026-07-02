//
//  CheckoutView.swift
//  RegisterApp
//
//  Created by 戸崎悠真 on 2026/07/01.
//

import SwiftUI
import SwiftData

struct CheckoutView: View {
    @Environment(\.modelContext) private var context
    @Binding var cartItems: [CartItem]
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("カート確認")
                .font(.largeTitle)
                .bold()

            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(cartItems.indices, id: \.self) { index in
                        let item = cartItems[index]

                        HStack {
                            Text(item.product.name)
                            Spacer()
                            Text("¥\(item.product.price)")
                            Spacer()
                            Text("\(item.quantity)点")
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
            }
            HStack{
                Button("購入") {
                    let cartId = Int(Date().timeIntervalSince1970)

                    for item in cartItems {
                        let sale = Sale(
                            cart_id: cartId,
                            product: item.product,
                            category: item.product.category
                        )
                        context.insert(sale)
                    }

                    do {
                        try context.save()
                        cartItems.removeAll()
                        isPresented = false
                    } catch {
                        print("売上保存失敗:", error)
                    }
                }

                Spacer()

                Button("閉じる") {
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(width: 500, height: 500)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

//#Preview {
//    CheckoutView()
//}
