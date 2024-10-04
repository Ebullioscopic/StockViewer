//
//  TickerViewModel.swift
//  StockApp
//
//  Created by hariharan mudaliar on 02/10/2024.
//

//import Foundation
//import Observation
//import SwiftUI
//
//enum TickerState {
//    case Initial
//    case Loading
//    case Loaded(data:SearchSym)
//    case Error(error:String)
//    
//}
//
//
//
//@Observable class TickerViewModel{
//    
//    var searchSymbol:String = ""
//    var tickerState:TickerState = TickerState.Initial
//    
//    private let stockService:StockService
//    
//    
//    init(stockService: StockService) {
//        self.stockService = stockService
//    }
//    
//    func getSearchStock() async {
//        
//        self.tickerState = TickerState.Loading
//        
//        if(searchSymbol.isEmpty){ self.tickerState = TickerState.Initial }
//        
//        if(!searchSymbol.isEmpty && searchSymbol.count > 1){
//            do{
//                try await Task.sleep(nanoseconds: 3_000_000_000)
//                let data = try await self.stockService.searchTicker(sym: searchSymbol.capitalized)
//                self.tickerState = TickerState.Loaded(data: data)
//                
//            }
//            catch let error {
//                self.tickerState = TickerState.Error(error: error.localizedDescription)
//            }
//        }
//        
//    }
//    
//    
//}
/////////////////////////////////////////////////////////
//import Foundation
//import Observation
//import SwiftUI
//
//enum TickerState {
//    case Initial
//    case Loading
//    case Loaded(data: SearchSym)
//    case Error(error: String)
//}
//
//@Observable class TickerViewModel {
//    
//    var searchSymbol: String = ""
//    var tickerState: TickerState = .Initial
//    
//    private let stockService: StockService
//    
//    init(stockService: StockService) {
//        self.stockService = stockService
//    }
//    
//    func getSearchStock() async {
//        // Update state to loading
//        self.tickerState = .Loading
//        
//        // If search symbol is empty, reset to initial
//        if searchSymbol.isEmpty {
//            self.tickerState = .Initial
//            return
//        }
//        
//        // Perform search for stock if symbol is valid
//        if !searchSymbol.isEmpty && searchSymbol.count > 1 {
//            do {
//                // Simulate network delay
//                try await Task.sleep(nanoseconds: 3_000_000_000)
//                
//                // Fetch data from stock service
//                let data = try await self.stockService.searchTicker(sym: searchSymbol.capitalized)
//                
//                // Update the state with the loaded data
//                self.tickerState = .Loaded(data: data)
//            } catch {
//                // Handle error case
//                self.tickerState = .Error(error: error.localizedDescription)
//            }
//        }
//    }
//}
///////////////////////////////////////////////////////////////
import Foundation
import Observation
import SwiftUI

enum TickerState {
    case Initial
    case Loading
    case Loaded(data: SearchSym)
    case Error(error: String)
}

@Observable class TickerViewModel {

    var searchSymbol: String = ""
    var tickerState: TickerState = .Initial
    
    // Ignored for observation tracking
    @ObservationIgnored private let _$observationRegistrar = Observation.ObservationRegistrar()
    
    private let stockService: StockService
    
    init(stockService: StockService) {
        self.stockService = stockService
    }

    // Access tracking to trigger UI updates
    internal nonisolated func access<Member>(keyPath: KeyPath<TickerViewModel, Member>) {
        _$observationRegistrar.access(self, keyPath: keyPath)
    }

    // Mutation tracking to update observed properties
    internal nonisolated func withMutation<Member, MutationResult>(
        keyPath: KeyPath<TickerViewModel, Member>,
        _ mutation: () throws -> MutationResult
    ) rethrows -> MutationResult {
        try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
    }

    // Sample async function fetching stock data
    func getSearchStock() async {
        tickerState = .Loading
        if searchSymbol.isEmpty {
            tickerState = .Initial
            return
        }
        do {
            let data = try await stockService.searchTicker(sym: searchSymbol.capitalized)
            tickerState = .Loaded(data: data)
        } catch {
            tickerState = .Error(error: error.localizedDescription)
        }
    }
}

////////////////////////////////////////__________________________________________________
//import Foundation
//import Observation
//import SwiftUI
//
//enum TickerState {
//    case Initial
//    case Loading
//    case Loaded(data: SearchSym)
//    case Error(error: String)
//}
//
//@Observable class TickerViewModel {
//    var searchSymbol: String = ""
//    var tickerState: TickerState = .Initial
//    
//    @ObservationIgnored private let _$observationRegistrar = Observation.ObservationRegistrar()
//    
//    private let stockService: StockService
//    
//    init(stockService: StockService) {
//        self.stockService = stockService
//    }
//    
//    internal nonisolated func access<Member>(keyPath: KeyPath<TickerViewModel, Member>) {
//        _$observationRegistrar.access(self, keyPath: keyPath)
//    }
//    
//    internal nonisolated func withMutation<Member, MutationResult>(
//        keyPath: KeyPath<TickerViewModel, Member>,
//        _ mutation: () throws -> MutationResult
//    ) rethrows -> MutationResult {
//        try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
//    }
//    
//    func getSearchStock() async {
//        tickerState = .Loading
//        if searchSymbol.isEmpty {
//            tickerState = .Initial
//            return
//        }
//        do {
//            let data = try await stockService.searchTicker(sym: searchSymbol.capitalized)
//            tickerState = .Loaded(data: data)
//        } catch {
//            tickerState = .Error(error: error.localizedDescription)
//        }
//    }
//}
