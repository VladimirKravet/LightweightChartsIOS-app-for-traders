//
//  ContentView.swift
//  TestProject
//
//  Created by Vladimir Kravets on 19.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var traders: [Trader] = [
        Trader(number: 8, country: "UK", name: "John", deposit: 10000, profit: 5000),
        Trader(number: 4, country: "UKR", name: "Alice", deposit: 12000, profit: 6000),
        Trader(number: 6, country: "CA", name: "Bob", deposit: 11000, profit: 5500),
        Trader(number: 7, country: "MD", name: "Emma", deposit: 10500, profit: 5250),
        Trader(number: 2, country: "JP", name: "David", deposit: 13000, profit: 6500),
        Trader(number: 9, country: "EU", name: "Sophia", deposit: 9500, profit: 4750),
        Trader(number: 10, country: "CH", name: "James", deposit: 9000, profit: 4500),
        Trader(number: 5, country: "IT", name: "Olivia", deposit: 11500, profit: 5750),
        Trader(number: 1, country: "BR", name: "Liam", deposit: 14000, profit: 7000),
        Trader(number: 3, country: "RU", name: "Ava", deposit: 12500, profit: 6250)
    ]
    
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.12, blue: 0.18).ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Text("TOP 10 Traders")
                        .font(Font.custom("Inter", size: 22).weight(.bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                
                List {
                    HStack {
                        Text("№")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Country")
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("Name")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Deposit")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Profit")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.76, green: 0.76, blue: 0.78))
                    .padding(.vertical,7)
                    .listRowBackground(Color(red: 0.18, green: 0.19, blue: 0.24))
                    
                    ForEach(sortedTraders) { trader in
                        HStack {
                            Text("\(trader.number)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(Font.custom("Inter", size: 13).weight(.medium))
                                .foregroundColor(.white)
                            Image(trader.country)
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text(trader.name)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(Font.custom("Inter", size: 13).weight(.medium))
                                .foregroundColor(.white)
                            Text("$" + String(format: "%.0f", trader.deposit))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(Font.custom("Inter", size: 13).weight(.medium))
                                .foregroundColor(.white)
                            Text("$" + String(format: "%.0f", trader.profit))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(Font.custom("Inter", size: 13).weight(.medium))
                                .foregroundColor(Color(red: 0.21, green: 0.73, blue: 0.45))
                        }
                        .padding(.vertical,7)
                        .listRowBackground(trader.number % 2 == 0 ? Color(red: 0.18, green: 0.19, blue: 0.24) : Color(red: 0.11, green: 0.12, blue: 0.18))
                    }
                }
                .listStyle(PlainListStyle())
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal,12)
                .padding(.top, 29)
                .padding(.bottom, 54)
            }
        }
        .onAppear {
                startRandomUpdates()
        }
    }
    
    func startRandomUpdates() {
        // Используем Timer для запуска обновлений каждые 5 секунд
        let _ = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            updateTraders()
        }
    }
    
    private var sortedTraders: [Trader] {
        // Отсортировать трейдеров по убыванию profit
        return traders.sorted { $0.profit > $1.profit }
    }
    
    func updateTraders() {
        // Рандомное изменение deposit и profit для каждого трейдера
        traders = traders.map { trader in
            var updatedTrader = trader
            updatedTrader.deposit += Double.random(in: -50.0...150.0)
            updatedTrader.profit += Double.random(in: -50.0...150.0)
            return updatedTrader
        }
        
        // Пересортировать трейдеров по profit
        let sortedTraders = traders.sorted { $0.profit > $1.profit }
        
        // Присвоить новые номера от 1 до 10 в зависимости от сортировки
        traders = sortedTraders.enumerated().map { index, trader in
            var updatedTrader = trader
            updatedTrader.number = index + 1
            return updatedTrader
        }
    }
}

struct Trader: Identifiable {
    let id = UUID()
    var number: Int
    let country: String
    var name: String
    var deposit: Double
    var profit: Double
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        scanner.scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

