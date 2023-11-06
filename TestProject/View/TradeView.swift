//
//  TradeView.swift
//  TestProject
//
//  Created by Vladimir Kravets on 19.10.2023.
//

import SwiftUI
import LightweightCharts

struct TradeView: View {
    @ObservedObject var viewModel: TradeViewModel

    
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.12, blue: 0.18).ignoresSafeArea()
            VStack(spacing: 8) {
                HStack {
                    Spacer()
                    Text("Trade")
                        .font(Font.custom("Inter", size: 22).weight(.bold))
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.bottom,35)
                HStack{
                    VStack{
                        Text("Balance")
                            .font(
                                Font.custom("Inter", size: 12)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.78, green: 0.78, blue: 0.78))
                            .padding(.bottom,3)
                        
                        Text(String(format: "%.0f", viewModel.totalAmount)) // Displays totalAmount as a string
                            .font(Font.custom("SF Pro Text", size: 16).weight(.bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }.padding(.top, 4)
                        .padding(.bottom, 6)
                }
                .frame(width: 315, height: 54)
                .background(Color(red: 0.2, green: 0.22, blue: 0.29))
                
                .cornerRadius(12)
                VStack{
                    
                    LightweightChartsView(data: $viewModel.data)
                }
                .frame(width: 375, height: 375)
                VStack{
                    Button {
                        if !viewModel.isInitialSelectionMade {
                             viewModel.selectedCurrencyPair = .GBPUSD
                            viewModel.isInitialSelectionMade = true
                         }
                         viewModel.coordinator.pushView(view: .curencyView)
                    } label: {
                        Text(viewModel.selectedCurrencyPair?.name ?? CurrencyPairEnum.GBPUSD.name)
                            .font(
                                Font.custom("SF Pro Text", size: 16)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 315, height: 54)
                .background(Color(red: 0.2, green: 0.22, blue: 0.29))
                .cornerRadius(12)
                HStack{
                    VStack{
                        Text("Timer")
                            .font(
                                Font.custom("Inter", size: 12)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.78, green: 0.78, blue: 0.78))
                        HStack{
                            Button {
                                if let currentTime = getTime(from: viewModel.timerField) {
                                    if let updatedTime = Calendar.current.date(byAdding: .second, value: -1, to: currentTime) {
                                        viewModel.timerField = getString(from: updatedTime)
                                    } else {
                                        // Handle the case where subtraction results in an invalid time (e.g., negative seconds)
                                        viewModel.timerField = "00:00" // You can set it to any suitable value in such cases
                                    }
                                }
                            } label: {
                                Image("minus-cirlce")
                            }
                            TextField("", text: $viewModel.timerField)
                                .font(Font.custom("SF Pro Text", size: 16).weight(.bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            Button {
                                if let currentTime = getTime(from: viewModel.timerField) {
                                    let updatedTime = Calendar.current.date(byAdding: .second, value: 1, to: currentTime)
                                    viewModel.timerField = getString(from: updatedTime)
                                }
                            } label: {
                                Image("add-circle")
                            }
                        }.padding(.horizontal, 15)
                    }.padding(.vertical,6)
                        .frame(width: 152, height: 54)
                        .background(Color(red: 0.2, green: 0.22, blue: 0.29))
                    
                        .cornerRadius(12)
                    VStack{
                        Text("Investment")
                            .font(
                                Font.custom("Inter", size: 12)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.78, green: 0.78, blue: 0.78))
                        HStack{
                            Button {
                                if viewModel.investmentAmount >= 1000 {
                                    viewModel.investmentAmount -= 1000
                                }
                            } label: {
                                Image("minus-cirlce")
                            }
                            TextField("", text: Binding(get: {
                                return "\(Int(viewModel.investmentAmount))"
                            }, set: { newValue in
                                if let newInvestment = Double(newValue) {
                                    if newInvestment <= viewModel.totalAmount {
                                        viewModel.investmentAmount = newInvestment
                                    } else {
                                        viewModel.investmentAmount = viewModel.totalAmount
                                    }
                                }
                            }))
                            .font(Font.custom("SF Pro Text", size: 16).weight(.bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            Button {
                                if viewModel.investmentAmount + 1000 <= viewModel.totalAmount {
                                    viewModel.investmentAmount += 1000
                                }
                            } label: {
                                Image("add-circle")
                            }
                        }.padding(.horizontal, 15)
                    }.padding(.vertical,6)
                        .frame(width: 152, height: 54)
                        .background(Color(red: 0.2, green: 0.22, blue: 0.29))
                    
                        .cornerRadius(12)
                }
                HStack{
                    VStack{
                        Button {
                            let randomOpen = Double.random(in: 1.200...1.3500)
                            let randomHigh = Double.random(in: 1.320...1.3760)
                            let randomLow = Double.random(in: 1.200...1.2878)
                            let randomClose = Double.random(in: 1.200...1.3500)
                            
                            viewModel.totalAmount += viewModel.investmentAmount
                            viewModel.data.append(CandlestickData(time: .string(formatDate(viewModel.currentDate)), open: randomOpen, high: randomHigh, low: randomLow, close: randomClose))
                            viewModel.currentDate = Calendar.current.date(byAdding: .day, value: 1, to: viewModel.currentDate) ?? viewModel.currentDate
                            viewModel.showingAlert = true
                        } label: {
                            Text("Sell")
                                .font(
                                    Font.custom("Inter", size: 24)
                                        .weight(.medium)
                                )
                                .foregroundColor(.white)
                        }.disabled(viewModel.investmentAmount == 0)
                        
                    }.frame(width: 152, height: 54)
                        .background(viewModel.investmentAmount == 0 ? Color.gray : Color(red: 1, green: 0.24, blue: 0.26))
                    
                        .cornerRadius(12)
                    VStack{
                        Button {
                            let randomOpen = Double.random(in: 1.200...1.3500)
                            let randomHigh = Double.random(in: 1.320...1.3760)
                            let randomLow = Double.random(in: 1.200...1.2878)
                            let randomClose = Double.random(in: 1.200...1.3500)
                            
                            viewModel.totalAmount -= viewModel.investmentAmount
                            
                            viewModel.data.append(CandlestickData(time: .string(formatDate(viewModel.currentDate)), open: randomOpen, high: randomHigh, low: randomLow, close: randomClose))
                            viewModel.currentDate = Calendar.current.date(byAdding: .day, value: 1, to: viewModel.currentDate) ?? viewModel.currentDate
                            viewModel.showingAlert = true
                        } label: {
                            Text("Buy")
                                .font(
                                    Font.custom("Inter", size: 24)
                                        .weight(.medium)
                                )
                                .foregroundColor(.white)
                        }.disabled(viewModel.investmentAmount == 0)
                        
                    }.frame(width: 152, height: 54)
                        .background(viewModel.investmentAmount == 0 ? Color.gray : Color(red: 0.21, green: 0.73, blue: 0.45))
                    
                        .cornerRadius(12)
                    
                }
            }.padding(.bottom,60)
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Your transaction was successful."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    // Helper function to convert a formatted time string to a Date object
    func getTime(from timeString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss" // Use "mm" for minutes and "ss" for seconds
        return formatter.date(from: timeString)
    }
    
    // Helper function to convert a Date object to a formatted time string
    func getString(from date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss" // Use "mm" for minutes and "ss" for seconds
        return formatter.string(from: date)
    }
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}


struct LightweightChartsView: UIViewRepresentable {
    @Binding var data: [CandlestickData]
    
    
    
    func makeUIView(context: Context) -> LightweightCharts {
        let chart = LightweightCharts()
        chart.clearWebViewBackground()
        chart.backgroundColor = UIColor.clear
        
        return chart
    }
    
    func updateUIView(_ uiView: LightweightCharts, context: Context) {
        let series = uiView.addCandlestickSeries(options: nil)
        
        // Update the chart with the new data
        series.setData(data: data)
    }
}
