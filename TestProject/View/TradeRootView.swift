//
//  TradeRootView.swift
//  TestProject
//
//  Created by Vladimir Kravets on 22.10.2023.
//

import SwiftUI

struct TradeRootView: View {
    @ObservedObject var tradeCoordinator: TradeViewCoordinator
    @Environment(\.horizontalSizeClass) var screenSize
    
    
    var body: some View {
        switch tradeCoordinator.currentView {
        case .tradeView:
            TradeView(viewModel: tradeCoordinator.viewModel)
        case .curencyView:
            GroupCurrencyView(viewModel: tradeCoordinator.viewModel)
        default:
            EmptyView()
        }
    }
}
