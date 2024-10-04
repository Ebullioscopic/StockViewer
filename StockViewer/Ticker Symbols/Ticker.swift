//
//  Ticker.swift
//  StockApp
//
//  Created by hariharan mudaliar on 02/10/2024.
//

import SwiftUI
import Observation
import SwiftData

struct Ticker: View {
    
    @State private var tickerViewModel = TickerViewModel(stockService: StockService())
    @EnvironmentObject var appNavigation: AppNavigation
    @Environment(\.modelContext) private var modelContext
    
    @Query()
    var bestMatch: [BestMatch]
    
    @State var task: Task<Void, Never>? = nil
    
    var body: some View {
        VStack{
            switch tickerViewModel.tickerState{
            case .Initial:
                if(bestMatch.isEmpty || bestMatch.count <= 1){ Text("Search Ticker") }
                else { List(bestMatch){value in
                    HStack{
                        Text(value.the1Symbol)
                        Spacer()
                        Text(value.the2Name)
                    }
                    .onTapGesture {
                        appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: value.the1Symbol))
                    }
                    
                } }
                

            case .Loading:
                ProgressView()
            case .Loaded(let data):
                List(data.bestMatches,id:\.self){bestMatches in
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text(bestMatches.the1Symbol)
                                .padding(.bottom,4)
                            Text(bestMatches.the2Name)
                        }
                        .onTapGesture {
                            appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: bestMatches.the1Symbol))
                        }
                        
                        Spacer()
                        Button {
                            modelContext.insert(bestMatches)
                            
                        } label: {
                            Image(systemName: bestMatch.contains { value in value.the1Symbol == bestMatches.the1Symbol } ? "heart.fill" : "heart")
                        }

                    }
                   
                   
                    
                    
                    
                }
            case .Error(let error):
                Text(error)
                    
            }
        }
        .searchable(text: $tickerViewModel.searchSymbol,prompt: "Search Ticker")
        .navigationTitle("Symbol")
        .onChange(of: tickerViewModel.searchSymbol, initial: false) { oldValue, newValue in
            
            self.task?.cancel()
            
            self.task = Task(priority: .medium) {
                await tickerViewModel.getSearchStock()
            }
            
        }
        
        
    }
}

#Preview {
    NavigationStack{
        Ticker()
    }
}
////////////////////___________________________________________________
//import SwiftUI
//import Observation
//import SwiftData
//
//struct Ticker: View {
//    
//    @State private var tickerViewModel = TickerViewModel(stockService: StockService())
//    @EnvironmentObject var appNavigation: AppNavigation
//    @Environment(\.modelContext) private var modelContext
//    
//    @Query()
//    var bestMatch: [BestMatch]
//    
//    @State var task: Task<Void, Never>? = nil
//    
//    var body: some View {
//        VStack {
//            marketStatusView
//            
//            List {
//                favoriteTickersSection
//                searchResultsSection
//            }
//            .searchable(text: $tickerViewModel.searchSymbol, prompt: "Search Ticker")
//            .navigationTitle("Tickers")
//            .onAppear {
//                fetchMarketStatus()
//            }
//            .onChange(of: tickerViewModel.searchSymbol) { _ in
//                self.task?.cancel()
//                self.task = Task(priority: .medium) {
//                    await tickerViewModel.getSearchStock()
//                }
//            }
//        }
//    }
//    
//    // Market Status View
//    var marketStatusView: some View {
//        VStack {
//            Text("Market Status")
//                .font(.headline)
//                .padding(.top)
//            
//            // Add some placeholder for market status. You can replace this with a proper graph view.
//            Text("Graph or Data Here")
//                .font(.subheadline)
//                .padding(.bottom)
//        }
//    }
//    
//    // Favorite Tickers Section
//    var favoriteTickersSection: some View {
//        Group {
//            if !bestMatch.isEmpty {
//                Section(header: Text("Favorites")) {
//                    ForEach(bestMatch) { value in
//                        TickerRowView(symbol: value.the1Symbol, name: value.the2Name) {
//                            appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: value.the1Symbol))
//                        }
//                    }
//                }
//            } else {
//                EmptyView() // Ensures the return type is consistent
//            }
//        }
//    }
//    
//    // Search Results Section
//    var searchResultsSection: some View {
//        Group {
//            switch tickerViewModel.tickerState {
//            case .Initial:
//                Text("Search for a ticker above")
//                    .foregroundColor(.gray)
//                    .multilineTextAlignment(.center)
//            case .Loading:
//                ProgressView()
//                    .padding()
//            case .Loaded(let data):
//                ForEach(data.bestMatches, id: \.self) { bestMatch in
//                    TickerRowView(symbol: bestMatch.the1Symbol, name: bestMatch.the2Name) {
//                        appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: bestMatch.the1Symbol))
//                    }
//                    .swipeActions {
//                        Button {
//                            modelContext.insert(bestMatch)
//                        } label: {
//                            Image(systemName: bestMatch.contains { value in
//                                value.the1Symbol == bestMatch.the1Symbol
//                            } ? "heart.fill" : "heart")
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
//            case .Error(let error):
//                Text(error)
//                    .foregroundColor(.red)
//                    .multilineTextAlignment(.center)
//            }
//        }
//    }
//    
//    // Placeholder function to fetch market status data
//    func fetchMarketStatus() {
//        // Implement your market status fetching logic here
// 
//    }
//}
//
//#Preview {
//    NavigationStack {
//        Ticker()
//    }
//}
