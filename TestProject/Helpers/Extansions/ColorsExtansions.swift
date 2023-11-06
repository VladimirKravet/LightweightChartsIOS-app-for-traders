//
//  ColorsExtansions.swift
//  Denotebeam
//
//  Created by Vladimir Kravets on 10.10.2023.
//

import Foundation
import SwiftUI

enum AppColors {
    case textSoftBlack
    case purpleTextColor
    case viewBackground
}
extension Font {
    init(appFonts: AppFonts, fontSize: CGFloat) {
        switch appFonts {
        case .jost:
            self = Font.custom("Jost", size: fontSize)
        case .jostBold:
            self = Font.custom("Jost-Bold", size: fontSize)
            
        }
    }
}
enum AppFonts {
    case jost
    case jostBold
}

