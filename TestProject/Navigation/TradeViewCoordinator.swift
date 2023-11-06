//
//  TradeViewCoordinator.swift
//  TestProject
//
//  Created by Vladimir Kravets on 22.10.2023.
//

import Foundation
class TradeViewCoordinator: ObservableObject {
    
    internal unowned var rootCoordinator: RootCoordinator
    
    @Published var viewModel: TradeViewModel!
    @Published var currentView: TradeEnum?
   @Published var navigationStack: [TradeEnum] = []
    
    
    init(rootCoordinator: RootCoordinator) {
        self.rootCoordinator = rootCoordinator
        self.viewModel = TradeViewModel(coordinator: self)

        start()
    }
}
    //MARK: - Navigation
    typealias tradeCoordinatorNavigation = TradeViewCoordinator
extension tradeCoordinatorNavigation {
    func start() {
        self.navigationStack.append(.tradeView)
        if let view = navigationStack.last {
            self.currentView = view
        }
    }
    
    func pushView(view: TradeEnum) {
        if view == .tradeView {
            self.navigationStack.removeAll()
        }
        self.navigationStack.append(view)
        if let view = navigationStack.last {
            self.currentView = view
        }
    }
}
