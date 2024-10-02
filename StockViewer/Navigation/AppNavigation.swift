//
//  AppNavigation.swift
//  StockApp
//
//  Created by hariharan mudaliar on 06/10/2024.
//

import Foundation
import Combine
import SwiftUI


enum TickerViewRoute: Hashable {
    case tickerDetail(sym:String)
}

class AppNavigation : ObservableObject {
    
    @Published var tickerNavigation = NavigationPath()
    @Published var topTickerNavigation = NavigationPath()
}
