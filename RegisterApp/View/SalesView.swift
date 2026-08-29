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
    
    let calendar = Calendar.current
    let currentYear = Calendar.current.component(.year, from: Date())
    let years = Array(2020...Calendar.current.component(.year, from: Date()))
    let months = Array(1...12)
    let days = Array(1...31)
    
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            
                            // 年別ボタン
                            Button {
                                selectedPeriod = "年別"
                            } label: {
                                Text("年別")
                            }
                            
                            // 月別ボタン
                            Button {
                                selectedPeriod = "月別"
                            } label: {
                                Text("月別")
                            }
                            
                            // 日別ボタン
                            Button {
                                selectedPeriod = "日別"
                            } label: {
                                Text("日別")
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
                                
                                // 月別
                            } else if selectedPeriod == "月別" {
                                
                                Picker("年", selection: $selectedYear) {
                                    ForEach(2020...currentYear, id: \.self) { year in
                                        Text("\(year)年")
                                            .tag(year)
                                    }
                                }
                                .pickerStyle(.menu)
                                
                                Picker("月", selection: $selectedMonth) {
                                    ForEach(1...12, id: \.self) { month in
                                        Text("\(month)月")
                                            .tag(month)
                                    }
                                }
                                .pickerStyle(.menu)
                                
                                // 日別
                            } else {
                                
                                Picker("年", selection: $selectedYear) {
                                    ForEach(2020...currentYear, id: \.self) { year in
                                        Text("\(year)年")
                                            .tag(year)
                                    }
                                }
                                .pickerStyle(.menu)
                                
                                Picker("月", selection: $selectedMonth) {
                                    ForEach(1...12, id: \.self) { month in
                                        Text("\(month)月")
                                            .tag(month)
                                    }
                                }
                                .pickerStyle(.menu)
                                
                                Picker("日", selection: $selectedDay) {
                                    ForEach(1...31, id: \.self) { day in
                                        Text("\(day)日")
                                            .tag(day)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
    }
}
