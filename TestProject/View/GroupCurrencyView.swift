//
//  GroupCurrencyView.swift
//  TestProject
//
//  Created by Vladimir Kravets on 22.10.2023.
//

import SwiftUI

enum CurrencyPairEnum: CaseIterable, Identifiable {
    case EURUSD
    case GBPUSD
    case AUDUSD
    case USDJPY
    case USDCAD
    case USDCHF
    case NZDUSD
    case EURGBP
    case EURJPY
    case GBPJPY
    case AUDJPY
    case EURAUD
    case EURCAD
    case AUDNZD
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .EURUSD: return "EUR/USD"
        case .GBPUSD: return "GBP/USD"
        case .AUDUSD: return "AUD/USD"
        case .USDJPY: return "USD/JPY"
        case .USDCAD: return "USD/CAD"
        case .USDCHF: return "USD/CHF"
        case .NZDUSD: return "NZD/USD"
        case .EURGBP: return "EUR/GBP"
        case .EURJPY: return "EUR/JPY"
        case .GBPJPY: return "GBP/JPY"
        case .AUDJPY: return "AUD/JPY"
        case .EURAUD: return "EUR/AUD"
        case .EURCAD: return "EUR/CAD"
        case .AUDNZD: return "AUD/NZD"
        }
    }
}

struct GroupCurrencyView: View {
    @ObservedObject var viewModel: TradeViewModel
    @StateObject var adaptiveUI: AdaptiveUI = AdaptiveUI.shared
    
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.12, blue: 0.18).ignoresSafeArea()
            VStack(spacing: 8) {
                VStack{
                    HStack {
                        
                        Button {
                            viewModel.coordinator.pushView(view: .tradeView)
                        } label: {
                            Image("arrow-left")
                                .resizable()
                                .frame(width: 24,height: 24)
                        }
                        Spacer()
                        Text("Currency pair")
                            .font(Font.custom("Inter", size: 22).weight(.bold))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.horizontal,16)
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: adaptiveUI.setGridColumns(), spacing: adaptiveUI.setPadding(paddingByDesign: 16)) {
                                ForEach(CurrencyPairEnum.allCases, id: \.self) { pair in
                                    VStack {
                                        Button {
                                            if viewModel.selectedCurrencyPair != pair {
                                                viewModel.selectedCurrencyPair = pair
                                                viewModel.coordinator.pushView(view: .tradeView)
                                            } else {
                                                viewModel.selectedCurrencyPair = pair // Устанавливаем выбранную валютную пару
                                            }
                                        } label: {
                                            Text(pair.name)
                                                .font(
                                                    Font.custom("SF Pro Text", size: 14)
                                                        .weight(.semibold)
                                                )
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .padding(.horizontal,16)
                                    .padding(.vertical,16)
                                    .frame(width: 152, height: 54)
                                    .background(viewModel.selectedCurrencyPair == pair ? Color(red: 0.21, green: 0.73, blue: 0.45) : Color(red: 0.2, green: 0.22, blue: 0.29))
                                    .cornerRadius(12)
                                    .disabled(viewModel.selectedCurrencyPair == pair) // Делаем некликабельными невыбранные валютные пары
                                }
                            }
                        }.padding(.top, 60)
                    }
                    
                    
                    
                    
                    
                }
            }
        }
    }
}

