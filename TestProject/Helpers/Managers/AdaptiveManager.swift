//
//  AdaptiveManager.swift
//  NewApp
//
//  Created by Vladimir Kravets on 14.07.2023.
//

import Foundation
import SwiftUI
class AdaptiveManager:ObservableObject {
  @Published var isIpad: Bool = UIDevice.current.userInterfaceIdiom == .pad
  @Published var deviceWidth: CGFloat = UIScreen.main.bounds.width
  @Published var deviceHeight: CGFloat = UIScreen.main.bounds.height
}
var height = UIScreen.main.bounds.height
var width = UIScreen.main.bounds.height
var isIpad: Bool = UIDevice.current.userInterfaceIdiom == .pad

