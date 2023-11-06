//
//  RootViewsEnum.swift
//  TestProject
//
//  Created by Vladimir Kravets on 19.10.2023.
//

import Foundation

enum RootViewsEnum: CaseIterable, Identifiable {
    case tradeScreen
    case topScreen


    
    var id: Self {self}
    
    var imageNameInactiveState: String {
        switch self {
        case .tradeScreen:
            return "tradingInactivity"
        case .topScreen:
           return "topInactive"
        }
    }
    
    var imageNameActiveState: String {
        switch self {
        case .tradeScreen:
            return "tradingActivity"
        case .topScreen:
            return "topActive"

        }
    }
    var Name: String {
        switch self {
        case .tradeScreen:
            return "Trade"
        case .topScreen:
            return "Top"
        }
    }
}
