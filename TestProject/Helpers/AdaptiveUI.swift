//
//  AdaptiveUI.swift
//  Denotebeam
//
//  Created by Vladimir Kravets on 10.10.2023.
//

import Foundation
import SwiftUI
class AdaptiveUI: ObservableObject {
    static let shared = AdaptiveUI()
    @Environment(\.horizontalSizeClass) var deviceType
    @Published var currentIphoneSize: ScreenSizeType!
    enum ScreenSizeType {
        case smallIphone
        case iphone
        case ipad
    }
    private init() {
        self.getCurrentDevice()
    }
}
//MARK: - GetCurrentDevice
typealias AdaptiveUICurrentDevice = AdaptiveUI
extension AdaptiveUICurrentDevice {
    private func getCurrentDevice() {
        let deviceType = UIScreen.main.traitCollection.horizontalSizeClass
        if deviceType != .compact {
            self.currentIphoneSize = .ipad
        } else {
            let screenHeight = UIScreen.main.nativeBounds.height
            self.currentIphoneSize = screenHeight <= 1792 ? .smallIphone : .iphone
        }
    }
}
//MARK: - Methods to make adaptive UI
typealias AdaptiveUIMethods = AdaptiveUI
extension AdaptiveUIMethods {
    func setImageSize() -> CGFloat {
        switch self.currentIphoneSize {
        case .ipad:
            return 1.5
        case .iphone:
            return 1
        case .smallIphone:
            return 0.8
        case .none:
            return 0
        }
    }
    func setFrameSize(valueByDesign: CGFloat) -> CGFloat {
        switch self.currentIphoneSize {
        case .ipad:
            return valueByDesign * 1.5
        case .iphone:
            return valueByDesign
        case .smallIphone:
            return valueByDesign / 0.8
        case .none:
            return valueByDesign
        }
    }
    func setPadding(paddingByDesign: CGFloat) -> CGFloat {
        switch self.currentIphoneSize {
        case .ipad:
            return paddingByDesign * 1.5
        case .iphone:
            return paddingByDesign
        case .smallIphone:
            return paddingByDesign * 0.8
        case .none:
            return 0
        }
    }
    func setFontSize(fontSizeByDesign: CGFloat) -> CGFloat {
        switch self.currentIphoneSize {
        case .ipad:
            return fontSizeByDesign * 1.5
        case .iphone:
            return fontSizeByDesign
        case .smallIphone:
            return fontSizeByDesign
        case .none:
            return 24
        }
    }
    func setGridColumns() -> [GridItem] {
        switch self.currentIphoneSize {
        case .ipad:
            return [GridItem(.flexible()),
                    GridItem(.flexible())]
        case .iphone:
            return [GridItem(.flexible()),
                    GridItem(.flexible())]
        case .smallIphone:
            return [GridItem(.flexible()),
                    GridItem(.flexible())]
        case .none:
            return []
        }
    }
}
