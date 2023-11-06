//
//  RootCoordinator.swift
//  TestProject
//
//  Created by Vladimir Kravets on 19.10.2023.
//

import Foundation
import SwiftUI



final class RootCoordinator: ObservableObject {
    
    @Published var currentView: RootViewsEnum!
    @Published var tradeViewModel: TradeViewModel!
    @Published var tradeCoordinator: TradeViewCoordinator!

    
    init() {
        self.currentView = .topScreen
        self.tradeCoordinator = TradeViewCoordinator(rootCoordinator: self)
    }
}

//MARK: - Navigation
typealias RootCoordinatorNavigationMethods = RootCoordinator
extension RootCoordinatorNavigationMethods {
    func navigateTo(to view: RootViewsEnum) {
        self.currentView = view
    }
}

