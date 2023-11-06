//
//  TestProjectApp.swift
//  TestProject
//
//  Created by Vladimir Kravets on 19.10.2023.
//

import SwiftUI

@main
struct TestProjectApp: App {
    @AppStorage("isAgree") var isAgree: Bool = false
    
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                if isAgree {
                    RootView()
                } else {
                    LaunchScreenView(isAgree: $isAgree)
                }
            }
            .onDisappear{
                isAgree = false
            }

        }
    }
}

