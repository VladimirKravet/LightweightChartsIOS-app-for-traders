//
//  TradeViewModel.swift
//  TestProject
//
//  Created by Vladimir Kravets on 22.10.2023.
//

import Foundation
import SwiftUI
import LightweightCharts

enum QRAlertType {
    case geolocationAccess
    case errorIfIncorrect
}

class TradeViewModel: ObservableObject {
    
    internal unowned var coordinator: TradeViewCoordinator
    @Published  var selectedCurrencyPair: CurrencyPairEnum?
    @Published var timerField: String = "00:01"
    @Published  var totalAmount: Double = 10000 // Use a Double for calculations
    @Published  var investmentAmount: Double = 1000 // Initial investment
    @Published  var currentDate: Date = Date()
    @Published  var showingAlert = false
    @Published  var isInitialSelectionMade = false
    
    
    @Published var data: [CandlestickData] = [
        // Existing data points
        CandlestickData(time: .string("2023-09-01"), open: 1.3000, high: 1.3150, low: 1.2790, close: 1.3020),
        CandlestickData(time: .string("2023-09-02"), open: 1.3020, high: 1.3380, low: 1.2795, close: 1.3065),
        CandlestickData(time: .string("2023-09-03"), open: 1.3065, high: 1.3160, low: 1.2155, close: 1.2590),
        CandlestickData(time: .string("2023-09-04"), open: 1.2590, high: 1.3320, low: 1.2100, close: 1.2795),
        CandlestickData(time: .string("2023-09-05"), open: 1.2795, high: 1.3020, low: 1.2600, close: 1.3195),
        CandlestickData(time: .string("2023-09-06"), open: 1.3195, high: 1.3320, low: 1.2900, close: 1.3495),
        CandlestickData(time: .string("2023-09-07"), open: 1.3495, high: 1.3620, low: 1.3100, close: 1.3695),
        CandlestickData(time: .string("2023-09-08"), open: 1.3695, high: 1.3920, low: 1.3200, close: 1.3495),
        CandlestickData(time: .string("2023-09-09"), open: 1.3495, high: 1.3620, low: 1.3000, close: 1.3295),
        CandlestickData(time: .string("2023-09-10"), open: 1.3295, high: 1.3420, low: 1.2800, close: 1.2995),
        CandlestickData(time: .string("2023-09-11"), open: 1.2995, high: 1.3320, low: 1.2650, close: 1.3195),
        CandlestickData(time: .string("2023-09-12"), open: 1.3195, high: 1.3520, low: 1.2450, close: 1.3395),
        CandlestickData(time: .string("2023-09-13"), open: 1.3395, high: 1.3620, low: 1.2760, close: 1.3695),
        CandlestickData(time: .string("2023-09-14"), open: 1.3000, high: 1.3150, low: 1.2790, close: 1.3020),
        CandlestickData(time: .string("2023-09-15"), open: 1.3020, high: 1.3380, low: 1.2795, close: 1.3065),
        CandlestickData(time: .string("2023-09-16"), open: 1.3065, high: 1.3160, low: 1.2155, close: 1.2590),
        CandlestickData(time: .string("2023-09-17"), open: 1.2590, high: 1.3320, low: 1.2100, close: 1.2795),
        CandlestickData(time: .string("2023-09-18"), open: 1.2795, high: 1.3020, low: 1.2600, close: 1.3195),
        CandlestickData(time: .string("2023-09-19"), open: 1.3195, high: 1.3320, low: 1.2900, close: 1.3495),
        CandlestickData(time: .string("2023-09-20"), open: 1.3495, high: 1.3620, low: 1.3100, close: 1.3695),
        CandlestickData(time: .string("2023-09-21"), open: 1.3695, high: 1.3920, low: 1.3200, close: 1.3495),
        CandlestickData(time: .string("2023-09-22"), open: 1.3495, high: 1.3620, low: 1.3000, close: 1.3295),
        CandlestickData(time: .string("2023-09-23"), open: 1.3295, high: 1.3420, low: 1.2800, close: 1.2995),
        CandlestickData(time: .string("2023-09-24"), open: 1.2995, high: 1.3320, low: 1.2650, close: 1.3195),
        CandlestickData(time: .string("2023-09-25"), open: 1.3195, high: 1.3520, low: 1.2450, close: 1.3395),
        CandlestickData(time: .string("2023-09-26"), open: 1.3395, high: 1.3620, low: 1.2760, close: 1.3695),
        CandlestickData(time: .string("2023-09-27"), open: 1.3000, high: 1.3150, low: 1.2790, close: 1.3020),
        CandlestickData(time: .string("2023-09-28"), open: 1.3020, high: 1.3380, low: 1.2795, close: 1.3065),
        CandlestickData(time: .string("2023-09-29"), open: 1.3065, high: 1.3160, low: 1.2155, close: 1.2590),
        CandlestickData(time: .string("2023-09-30"), open: 1.2590, high: 1.3320, low: 1.2100, close: 1.2795),
        CandlestickData(time: .string("2023-10-02"), open: 1.2795, high: 1.3020, low: 1.2600, close: 1.3195),
        CandlestickData(time: .string("2023-10-03"), open: 1.3195, high: 1.3320, low: 1.2900, close: 1.3495),
        CandlestickData(time: .string("2023-10-04"), open: 1.3495, high: 1.3620, low: 1.3100, close: 1.3695),
        CandlestickData(time: .string("2023-10-05"), open: 1.3695, high: 1.3920, low: 1.3200, close: 1.3495),
        CandlestickData(time: .string("2023-10-09"), open: 1.3495, high: 1.3620, low: 1.3000, close: 1.3295),
        CandlestickData(time: .string("2023-10-10"), open: 1.3295, high: 1.3420, low: 1.2800, close: 1.2995),
        CandlestickData(time: .string("2023-10-11"), open: 1.2995, high: 1.3320, low: 1.2650, close: 1.3195),
        CandlestickData(time: .string("2023-10-12"), open: 1.3195, high: 1.3520, low: 1.2450, close: 1.3395),
        CandlestickData(time: .string("2023-10-13"), open: 1.3395, high: 1.3620, low: 1.2760, close: 1.3695),
        CandlestickData(time: .string("2023-10-14"), open: 1.3000, high: 1.3150, low: 1.2790, close: 1.3020),
        CandlestickData(time: .string("2023-10-15"), open: 1.3020, high: 1.3380, low: 1.2795, close: 1.3065),
        CandlestickData(time: .string("2023-10-16"), open: 1.3065, high: 1.3160, low: 1.2155, close: 1.2590),
        CandlestickData(time: .string("2023-10-17"), open: 1.2590, high: 1.3320, low: 1.2100, close: 1.2795),
        CandlestickData(time: .string("2023-10-18"), open: 1.2795, high: 1.3020, low: 1.2600, close: 1.3195),
        CandlestickData(time: .string("2023-10-19"), open: 1.3195, high: 1.3320, low: 1.2900, close: 1.3495),
        CandlestickData(time: .string("2023-10-20"), open: 1.3495, high: 1.3620, low: 1.3100, close: 1.3695),
//        CandlestickData(time: .string("2023-10-21"), open: 1.3695, high: 1.3920, low: 1.3200, close: 1.3495),
//        CandlestickData(time: .string("2018-11-22"), open: 1.3495, high: 1.3620, low: 1.3000, close: 1.3295),
//        CandlestickData(time: .string("2018-11-23"), open: 1.3295, high: 1.3420, low: 1.2800, close: 1.2995),
//        CandlestickData(time: .string("2018-11-24"), open: 1.2995, high: 1.3320, low: 1.2650, close: 1.3195),
//        CandlestickData(time: .string("2018-11-25"), open: 1.3195, high: 1.3520, low: 1.2450, close: 1.3395),
//        CandlestickData(time: .string("2018-11-26"), open: 1.3395, high: 1.3620, low: 1.2760, close: 1.3695),
    ]
    
    
    init(coordinator: TradeViewCoordinator) {
        self.coordinator = coordinator

    }
}


