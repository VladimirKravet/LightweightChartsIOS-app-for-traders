//
//  CustomAlertView.swift
//  TestProject
//
//  Created by Vladimir Kravets on 19.10.2023.
//

import SwiftUI

struct CustomAlertView<Content: View>: View {

    @Environment(\.colorScheme) var colorScheme

    let title: String
    let description: String

    var cancelAction: (() -> Void)?
    var cancelActionTitle: String?

    var primaryAction: (() -> Void)?
    var primaryActionTitle: String?

    var customContent: Content?

    init(title: String,
         description: String,
         cancelAction: (() -> Void)? = nil,
         cancelActionTitle: String? = nil,
         primaryAction: (() -> Void)? = nil,
         primaryActionTitle: String? = nil,
         customContent: Content? = EmptyView()) {
        self.title = title
        self.description = description
        self.cancelAction = cancelAction
        self.cancelActionTitle = cancelActionTitle
        self.primaryAction = primaryAction
        self.primaryActionTitle = primaryActionTitle
        self.customContent = customContent
    }

    var body: some View {
        HStack {
            VStack(spacing: 0) {
                VStack{
                    Text(title)
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .lineLimit(2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 16)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 16)
                    
                    Text(description)
                        .font(.system(size: 13, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding([.bottom, .trailing, .leading])
                    
                    
                    Divider()
                        .background(Color(red: 0.33, green: 0.33, blue: 0.35).opacity(0.65))
                }.frame(height: 144)
                
                HStack {
                    if let cancelAction, let cancelActionTitle {
                        Button { cancelAction() } label: {
                            Text(cancelActionTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        }
                    }

                    if cancelActionTitle != nil && primaryActionTitle != nil {
                        Divider()
                            .background(Color(red: 0.33, green: 0.33, blue: 0.35).opacity(0.65))
                    }

                    if let primaryAction, let primaryActionTitle {
                        Button { primaryAction() } label: {
                            Text("**\(primaryActionTitle)**")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 44)
            }
            .frame(minWidth: 0, maxWidth: 400, alignment: .center)
            .background(Color(hex: "1B1A1B"))
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
        }
        .zIndex(1)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(
            colorScheme == .light
            ? Color(red: 0, green: 0, blue: 0, opacity: 0.4)
            : Color(red: 1, green: 1, blue: 1, opacity: 0.4)
        )
    }
}
