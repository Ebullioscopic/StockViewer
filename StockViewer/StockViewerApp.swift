//
//  StockViewerApp.swift
//  StockViewer
//
//  Created by admin63 on 02/10/24.
//

import SwiftUI
import SwiftData

@main
struct StockViewer: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: BestMatch.self)
        }
    }
}
