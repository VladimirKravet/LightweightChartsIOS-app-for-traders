//
//  LaunchScreenView.swift
//  Denotebeam
//
//  Created by Vladimir Kravets on 10.10.2023.
//

import SwiftUI

struct LaunchScreenView: View {
    @Environment(\.openURL) var openURL
    @Binding var isAgree: Bool
    @State var isChecked: Bool = false
    let adaptive = AdaptiveUI.shared
    @StateObject var adaptiveUI: AdaptiveUI = AdaptiveUI.shared
    @Environment(\.horizontalSizeClass) var screenSize
    @State private var percent: CGFloat = 0
    var width: CGFloat = 300
    @State private var timer: Timer?
    @State private var isShowingAlert = false
    
    
    @State private var showAlert = false
    var body: some View {
        let multiplier = width / 100
        ZStack{
            Image("backgroundImage")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            if !isShowingAlert {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: width, height: 24)
                        .foregroundColor(Color(red: 0.36, green: 0.35, blue: 0.38))
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: percent * multiplier, height: 24)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 0.21, green: 0.73, blue: 0.45), Color(red: 0.21, green: 0.73, blue: 0.45)]), startPoint: .leading, endPoint: .trailing)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        )
                        .foregroundColor(.clear)
                    
                    Text(String(format: "%.0f%%", percent))
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .padding(.horizontal, 135)
                }.blur(radius: isShowingAlert ? 5 : 0)
            }
            if isShowingAlert {
                CustomAlertView(
                    title: "“App” would like to Send You Notifications",
                    description: "Notifications may include alerts, sounds and icon badges. These can be configured in Settings.",
                    cancelAction: {
                        // Cancel action here
                        withAnimation {
                            isShowingAlert.toggle()
                            isAgree = true
                        }
                    },
                    cancelActionTitle: "Don’t Allow",
                    primaryAction: {
                      // Primary action here
                        withAnimation {
                            isShowingAlert.toggle()
                            isAgree = true
                        }
                    },
                    primaryActionTitle: "Allow"

                )
            }
        }
        .onAppear {
            // Create a timer to update the loading progress every second
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                withAnimation {
                    percent += 2 // Increase the progress by 20% each second
                }
                
                if percent >= 100 {
                    // Once the progress reaches 100%, stop the timer
                    timer.invalidate()
                    isShowingAlert = true
                }
            }
        }
    }
}

