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
    
    @State private var selectedPeriod: String = "日別"
    @State private var selectedDate: Date = Date()
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
    
    let currentYear = Calendar.current.component(.year, from: Date())
    let years = Array(2020...Calendar.current.component(.year, from: Date()))
    let months = Array(1...12)
    let days = Array(1...31)
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // ヘッダー
                HStack {
                    Text("売上確認画面")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Text("2026/05/17(年、月、日別)")
                    Button("オーダー画面へ") {
                        dismiss()
                    }
                }
                .padding()
                //                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.2))
                
                // メイン
                VStack(alignment: .leading) {
                    Spacer()
                    ScrollView(.vertical, showsIndicators: true) {

                        VStack(alignment: .leading, spacing: 20) {
                            // ボタン・ドロップダウン
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {

                                    ForEach(["年別", "月別", "日別"], id: \.self) { period in
                                        Button {
                                            selectedPeriod = period
                                        } label: {
                                            Text(period)
                                                .font(.headline)
                                                .foregroundStyle(.black)
                                                .frame(width: 80, height: 40)
                                                .background(
                                                    selectedPeriod == period
                                                    ? Color.blue.opacity(0.2)
                                                    : Color.white
                                                )
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.black, lineWidth: 1)
                                                )
                                                .cornerRadius(8)
                                        }
                                    }

                                    // 年別
                                    if selectedPeriod == "年別" {

                                        Picker("年", selection: $selectedYear) {
                                            ForEach(2020...currentYear, id: \.self) { year in
                                                Text("\(year)年")
                                                    .tag(year)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .tint(.black)
                                        .frame(minWidth: 80, minHeight: 40)
                                        .padding(.horizontal, 8)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                        .cornerRadius(8)

                                    // 月別
                                    } else if selectedPeriod == "月別" {

                                        Picker("年", selection: $selectedYear) {
                                            ForEach(2020...currentYear, id: \.self) { year in
                                                Text("\(year)年")
                                                    .tag(year)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .tint(.black)
                                        .frame(minWidth: 80, minHeight: 40)
                                        .padding(.horizontal, 8)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                        .cornerRadius(8)

                                        Picker("月", selection: $selectedMonth) {
                                            ForEach(1...12, id: \.self) { month in
                                                Text("\(month)月")
                                                    .tag(month)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .tint(.black)
                                        .frame(minWidth: 80, minHeight: 40)
                                        .padding(.horizontal, 8)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                        .cornerRadius(8)

                                    // 日別
                                    } else {

                                        Picker("年", selection: $selectedYear) {
                                            ForEach(2020...currentYear, id: \.self) { year in
                                                Text("\(year)年")
                                                    .tag(year)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .tint(.black)
                                        .frame(minWidth: 80, minHeight: 40)
                                        .padding(.horizontal, 8)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                        .cornerRadius(8)

                                        Picker("月", selection: $selectedMonth) {
                                            ForEach(1...12, id: \.self) { month in
                                                Text("\(month)月")
                                                    .tag(month)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .tint(.black)
                                        .frame(minWidth: 80, minHeight: 40)
                                        .padding(.horizontal, 8)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                        .cornerRadius(8)

                                        Picker("日", selection: $selectedDay) {
                                            ForEach(1...31, id: \.self) { day in
                                                Text("\(day)日")
                                                    .tag(day)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                        .tint(.black)
                                        .frame(minWidth: 80, minHeight: 40)
                                        .padding(.horizontal, 8)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                        .cornerRadius(8)
                                    }
                                }
                            }

                            // 売上情報
                            LazyVGrid(
                                columns: columns,
                                spacing: 20
                            ) {

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("売上件数")
                                        .font(.headline)
                                    Spacer()

                                        HStack {
                                            Spacer()

                                            Text("0件")
                                                .font(.title2)
                                                .bold()

                                            Spacer()
                                        }

                                        Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: 50, alignment: .topLeading)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            Color.gray.opacity(0.4),
                                            lineWidth: 1
                                        )
                                )
                                .cornerRadius(12)

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("合計売上")
                                        .font(.headline)
                                    Spacer()

                                        HStack {
                                            Spacer()

                                            Text("￥0")
                                                .font(.title2)
                                                .bold()

                                            Spacer()
                                        }

                                        Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            Color.gray.opacity(0.4),
                                            lineWidth: 1
                                        )
                                )
                                .cornerRadius(12)

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("平均会計金額")
                                        .font(.headline)
                                    Spacer()

                                        HStack {
                                            Spacer()

                                            Text("￥0")
                                                .font(.title2)
                                                .bold()

                                            Spacer()
                                        }

                                        Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            Color.gray.opacity(0.4),
                                            lineWidth: 1
                                        )
                                )
                                .cornerRadius(12)

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("商品販売数")
                                        .font(.headline)
                                    Spacer()

                                        HStack {
                                            Spacer()

                                            Text("0点")
                                                .font(.title2)
                                                .bold()

                                            Spacer()
                                        }

                                        Spacer()
                                }
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            Color.gray.opacity(0.4),
                                            lineWidth: 1
                                        )
                                )
                                .cornerRadius(12)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
    }
}
