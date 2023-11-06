//
//  CustomTabBar.swift
//  TestProject
//
//  Created by Vladimir Kravets on 19.10.2023.
//

import Foundation
import SwiftUI
import Combine

struct CustomTabBar: View {
    
    @Environment(\.horizontalSizeClass) var screenSize
    @ObservedObject var coordinator: RootCoordinator
    
    var body: some View {
        ZStack {
            Divider()
                .background(Color(red: 0.33, green: 0.33, blue: 0.35).opacity(0.65))
            HStack {
                Spacer()
                ForEach(RootViewsEnum.allCases) { view in
                        Button {
                            coordinator.navigateTo(to: view)
                        } label: {
                            VStack{
                                Image(coordinator.currentView == view ? view.imageNameActiveState : view.imageNameInactiveState)
                                    .resizable()
                                    .frame(maxWidth: screenSize == .compact ? (UIScreen.main.nativeBounds.height <= 1792 ? 20:20):20, maxHeight: screenSize == .compact ? (UIScreen.main.nativeBounds.height <= 1792 ? 20:20):20)
                                Text(coordinator.currentView == view ? view.Name : view.Name)
                                    .foregroundColor(coordinator.currentView == view ? Color(red: 0.21, green: 0.73, blue: 0.45) : Color(red: 0.47, green: 0.49, blue: 0.56))

                            }
                        }
                        Spacer()
                }
            }
            .frame(height: 50)
            .background(Color.init(hex: "1E202E"))

        }
    }
}

