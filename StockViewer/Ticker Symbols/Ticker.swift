//
//  Ticker.swift
//  StockApp
//
//  Created by hariharan mudaliar on 02/10/2024.
//

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
//        VStack{
//            switch tickerViewModel.tickerState{
//            case .Initial:
//                if(bestMatch.isEmpty || bestMatch.count <= 1){ Text("Search Ticker") }
//                else { List(bestMatch){value in
//                    HStack{
//                        Text(value.the1Symbol)
//                        Spacer()
//                        Text(value.the2Name)
//                    }
//                    .onTapGesture {
//                        appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: value.the1Symbol))
//                    }
//                    
//                } }
//                
//
//            case .Loading:
//                ProgressView()
//            case .Loaded(let data):
//                List(data.bestMatches,id:\.self){bestMatches in
//                    
//                    HStack{
//                        VStack(alignment: .leading){
//                            Text(bestMatches.the1Symbol)
//                                .padding(.bottom,4)
//                            Text(bestMatches.the2Name)
//                        }
//                        .onTapGesture {
//                            appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: bestMatches.the1Symbol))
//                        }
//                        
//                        Spacer()
//                        Button {
//                            modelContext.insert(bestMatches)
//                            
//                        } label: {
//                            Image(systemName: bestMatch.contains { value in value.the1Symbol == bestMatches.the1Symbol } ? "heart.fill" : "heart")
//                        }
//
//                    }
//                   
//                   
//                    
//                    
//                    
//                }
//            case .Error(let error):
//                Text(error)
//                    
//            }
//        }
//        .searchable(text: $tickerViewModel.searchSymbol,prompt: "Search Ticker")
//        .navigationTitle("Symbol")
//        .onChange(of: tickerViewModel.searchSymbol, initial: false) { oldValue, newValue in
//            
//            self.task?.cancel()
//            
//            self.task = Task(priority: .medium) {
//                await tickerViewModel.getSearchStock()
//            }
//            
//        }
//        
//        
//    }
//}
//
//#Preview {
//    NavigationStack{
//        Ticker()
//    }
//}
////////////////////___________________________________________________working below
//import SwiftUI
//import Observation
//import SwiftData
//
//struct Ticker: View {
//    @State private var tickerViewModel = TickerViewModel(stockService: StockService())
//    @EnvironmentObject var appNavigation: AppNavigation
//    @Environment(\.modelContext) private var modelContext
//    
//    @Query(sort: \BestMatch.symbol)
//    var favoriteMatches: [BestMatch]
//    
//    @State var task: Task<Void, Never>? = nil
//    @State private var selectedMarketType: String = "Equity"
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                marketStatusView
//                
//                favoriteTickersView
//                
//                marketListView
//                
//                searchResultsView
//            }
//            .padding()
//        }
//        .searchable(text: $tickerViewModel.searchSymbol, prompt: "Search Ticker")
//        .navigationTitle("Market Status")
//        .onAppear {
//            Task {
//                await tickerViewModel.fetchMarketStatus()
//            }
//        }
//        .onChange(of: tickerViewModel.searchSymbol) { oldValue, newValue in
//            self.task?.cancel()
//            self.task = Task(priority: .medium) {
//                await tickerViewModel.getSearchStock()
//            }
//        }
//    }
//    
//    private var marketStatusView: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Global Market Status")
//                .font(.headline)
//            
//            if case .Loaded(let status) = tickerViewModel.marketStatusState {
//                Picker("Market Type", selection: $selectedMarketType) {
//                    Text("Equity").tag("Equity")
//                    Text("Forex").tag("Forex")
//                    Text("Crypto").tag("Cryptocurrency")
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.bottom, 10)
//                
//                ForEach(status.markets.filter { $0.marketType == selectedMarketType }) { market in
//                    marketCard(for: market)
//                }
//            } else if case .Error(let error) = tickerViewModel.marketStatusState {
//                Text("Error: \(error)")
//                    .foregroundColor(.red)
//            } else {
//                ProgressView()
//            }
//        }
//    }
//    
//    private func marketCard(for market: MarketStatus.Market) -> some View {
//        VStack(alignment: .leading, spacing: 5) {
//            HStack {
//                Text(market.region)
//                    .font(.headline)
//                Spacer()
//                Text(market.currentStatus.capitalized)
//                    .font(.subheadline)
//                    .padding(5)
//                    .background(market.currentStatus == "open" ? Color.green : Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(5)
//            }
//            Text(market.primaryExchanges)
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//            Text("Hours: \(market.localOpen) - \(market.localClose)")
//                .font(.caption)
//            if !market.notes.isEmpty {
//                Text(market.notes)
//                    .font(.caption2)
//                    .foregroundColor(.secondary)
//            }
//        }
//        .padding()
//        .background(Color(UIColor.systemBackground))
//        .cornerRadius(10)
//        .shadow(radius: 2)
//    }
//    
////    private var favoriteTickersView: some View {
////        VStack(alignment: .leading) {
////            Text("Favorites")
////                .font(.headline)
////            ScrollView(.horizontal, showsIndicators: false) {
////                HStack {
////                    ForEach(favoriteMatches) { match in
////                        VStack {
////                            Text(match.the1Symbol)
////                                .font(.subheadline)
////                            Text(match.the2Name)
////                                .font(.caption)
////                                .lineLimit(1)
////                        }
////                        .padding(8)
////                        .background(Color(UIColor.secondarySystemBackground))
////                        .cornerRadius(8)
////                        .onTapGesture {
////                            appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: match.the1Symbol))
////                        }
////                    }
////                }
////            }
////        }
////        .padding(.vertical)
////    }
//    private var favoriteTickersView: some View {
//        VStack(alignment: .leading) {
//            Text("Favorites")
//                .font(.headline)
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(favoriteMatches) { match in
//                        VStack {
//                            Text(match.symbol)
//                                .font(.subheadline)
//                            Text(match.name)
//                                .font(.caption)
//                                .lineLimit(1)
//                        }
//                        .padding(8)
//                        .background(Color(UIColor.secondarySystemBackground))
//                        .cornerRadius(8)
//                        .onTapGesture {
//                            appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: match.symbol))
//                        }
//                    }
//                }
//            }
//        }
//        .padding(.vertical)
//    }
//    private var marketListView: some View {
//        VStack(alignment: .leading) {
//            Text("Markets")
//                .font(.headline)
//            if case .Loaded(let status) = tickerViewModel.marketStatusState {
//                ForEach(status.markets.filter { $0.marketType == "Equity" }.prefix(5)) { market in
//                    HStack {
//                        Text(market.region)
//                        Spacer()
//                        Text(market.currentStatus.capitalized)
//                            .foregroundColor(market.currentStatus == "open" ? .green : .red)
//                    }
//                    .padding(.vertical, 5)
//                }
//            }
//        }
//    }
//    
//    private var searchResultsView: some View {
//        VStack(alignment: .leading) {
//            Text("Search Results")
//                .font(.headline)
//            
//            switch tickerViewModel.tickerState {
//            case .Initial:
//                if favoriteMatches.isEmpty {
//                    Text("Search for a ticker symbol")
//                        .foregroundColor(.secondary)
//                }
//            case .Loading:
//                ProgressView()
//            case .Loaded(let data):
//                ForEach(data.bestMatches, id: \.self) { bestMatch in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(bestMatch.symbol)
//                                .font(.headline)
//                            Text(bestMatch.the2Name)
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        Spacer()
//                        Button {
//                            toggleFavorite(bestMatch)
//                        } label: {
//                            Image(systemName: isFavorite(bestMatch) ? "heart.fill" : "heart")
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                    .padding(.vertical, 5)
//                    .onTapGesture {
//                        appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: bestMatch.the1Symbol))
//                    }
//                }
//            case .Error(let error):
//                Text(error)
//                    .foregroundColor(.red)
//            }
//        }
//    }
//    
//    private func toggleFavorite(_ match: BestMatch) {
//        if let existingMatch = favoriteMatches.first(where: { $0.the1Symbol == match.the1Symbol }) {
//            modelContext.delete(existingMatch)
//        } else {
//            modelContext.insert(match)
//        }
//    }
//    
//    private func isFavorite(_ match: BestMatch) -> Bool {
//        favoriteMatches.contains { $0.the1Symbol == match.the1Symbol }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        Ticker()
//            .environmentObject(AppNavigation())
//            .modelContainer(for: BestMatch.self, inMemory: true)
//    }
//}
//////////////////////////////////__________________________________best working below
//import SwiftUI
//import Observation
//import SwiftData
//
//struct Ticker: View {
//    @State private var tickerViewModel = TickerViewModel(stockService: StockService())
//    @EnvironmentObject var appNavigation: AppNavigation
//    @Environment(\.modelContext) private var modelContext
//    
//    @Query(sort: \BestMatch.symbol)
//    var favoriteMatches: [BestMatch]
//    
//    @State var task: Task<Void, Never>? = nil
//    @State private var selectedMarketType: String = "Equity"
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                marketStatusView
//                
//                favoriteTickersView
//                
//                marketListView
//                
//                searchResultsView
//            }
//            .padding()
//        }
//        .searchable(text: $tickerViewModel.searchSymbol, prompt: "Search Ticker")
//        .navigationTitle("Market Status")
//        .onAppear {
//            Task {
//                await tickerViewModel.fetchMarketStatus()
//            }
//        }
//        .onChange(of: tickerViewModel.searchSymbol) { oldValue, newValue in
//            self.task?.cancel()
//            self.task = Task(priority: .medium) {
//                await tickerViewModel.getSearchStock()
//            }
//        }
//    }
//    
//    private var marketStatusView: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Global Market Status")
//                .font(.headline)
//            
//            if case .Loaded(let status) = tickerViewModel.marketStatusState {
//                Picker("Market Type", selection: $selectedMarketType) {
//                    Text("Equity").tag("Equity")
//                    Text("Forex").tag("Forex")
//                    Text("Crypto").tag("Cryptocurrency")
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.bottom, 10)
//                
//                ForEach(status.markets.filter { $0.marketType == selectedMarketType }) { market in
//                    marketCard(for: market)
//                }
//            } else if case .Error(let error) = tickerViewModel.marketStatusState {
//                Text("Error: \(error)")
//                    .foregroundColor(.red)
//            } else {
//                ProgressView()
//            }
//        }
//    }
//    
//    private func marketCard(for market: MarketStatus.Market) -> some View {
//        VStack(alignment: .leading, spacing: 5) {
//            HStack {
//                Text(market.region!)
//                    .font(.headline)
//                Spacer()
//                Text(market.currentStatus?.capitalized ?? "Open")
//                    .font(.subheadline)
//                    .padding(5)
//                    .background(market.currentStatus == "open" ? Color.green : Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(5)
//            }
//            Text(market.primaryExchanges ?? "Primary Exchanges")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//            Text("Hours: \(String(describing: market.localOpen)) - \(String(describing: market.localClose))")
//                .font(.caption)
//            if ((market.notes?.isEmpty) == nil) {
//                Text(market.notes ?? "Notes")
//                    .font(.caption2)
//                    .foregroundColor(.secondary)
//            }
//        }
//        .padding()
//        .background(Color(UIColor.systemBackground))
//        .cornerRadius(10)
//        .shadow(radius: 2)
//    }
//    
//    private var favoriteTickersView: some View {
//        VStack(alignment: .leading) {
//            Text("Favorites")
//                .font(.headline)
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(favoriteMatches) { match in
//                        VStack {
//                            Text(match.symbol)
//                                .font(.subheadline)
//                            Text(match.name)
//                                .font(.caption)
//                                .lineLimit(1)
//                        }
//                        .padding(8)
//                        .background(Color(UIColor.secondarySystemBackground))
//                        .cornerRadius(8)
//                        .onTapGesture {
//                            appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: match.symbol))
//                        }
//                    }
//                }
//            }
//        }
//        .padding(.vertical)
//    }
//    
//    private var marketListView: some View {
//        VStack(alignment: .leading) {
//            Text("Markets")
//                .font(.headline)
//            if case .Loaded(let status) = tickerViewModel.marketStatusState {
//                ForEach(status.markets.filter { $0.marketType == "Equity" }.prefix(5)) { market in
//                    HStack {
//                        Text(market.region ?? "India")
//                        Spacer()
//                        Text(market.currentStatus?.capitalized ?? "India")
//                            .foregroundColor(market.currentStatus == "open" ? .green : .red)
//                    }
//                    .padding(.vertical, 5)
//                }
//            }
//        }
//    }
//    
//    private var searchResultsView: some View {
//        VStack(alignment: .leading) {
//            Text("Search Results")
//                .font(.headline)
//            
//            switch tickerViewModel.tickerState {
//            case .Initial:
//                if favoriteMatches.isEmpty {
//                    Text("Search for a ticker symbol")
//                        .foregroundColor(.secondary)
//                }
//            case .Loading:
//                ProgressView()
//            case .Loaded(let data):
//                ForEach(data.bestMatches, id: \.symbol) { bestMatch in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(bestMatch.symbol)
//                                .font(.headline)
//                            Text(bestMatch.name)
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                        }
//                        Spacer()
//                        Button {
//                            toggleFavorite(bestMatch)
//                        } label: {
//                            Image(systemName: isFavorite(bestMatch) ? "heart.fill" : "heart")
//                        }
//                        .buttonStyle(PlainButtonStyle())
//                    }
//                    .padding(.vertical, 5)
//                    .onTapGesture {
//                        appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: bestMatch.symbol))
//                    }
//                }
//            case .Error(let error):
//                Text(error)
//                    .foregroundColor(.red)
//            }
//        }
//    }
//    
//    private func toggleFavorite(_ match: BestMatch) {
//        if let existingMatch = favoriteMatches.first(where: { $0.symbol == match.symbol }) {
//            modelContext.delete(existingMatch)
//        } else {
//            modelContext.insert(match)
//        }
//    }
//    
//    private func isFavorite(_ match: BestMatch) -> Bool {
//        favoriteMatches.contains { $0.symbol == match.symbol }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        Ticker()
//            .environmentObject(AppNavigation())
//            .modelContainer(for: BestMatch.self, inMemory: true)
//    }
//}
//////////////////////////////////////____________________
import SwiftUI
import SwiftData
import Observation

struct Ticker: View {
    @State private var tickerViewModel = TickerViewModel(stockService: StockService())
    @EnvironmentObject var appNavigation: AppNavigation
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \BestMatch.symbol)
    var favoriteMatches: [BestMatch]
    
    @State var task: Task<Void, Never>? = nil
    @State private var selectedMarketType: String = "Equity"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                marketStatusCarouselView  // Updated the market status view to use a carousel
                
                favoriteTickersView
                
                marketListView
                
                searchResultsView
            }
            .padding()
        }
        .searchable(text: $tickerViewModel.searchSymbol, prompt: "Search Ticker")
        .navigationTitle("Market Status")
        .onAppear {
            Task {
                await tickerViewModel.fetchMarketStatus()
            }
        }
        .onChange(of: tickerViewModel.searchSymbol) { oldValue, newValue in
            self.task?.cancel()
            self.task = Task(priority: .medium) {
                await tickerViewModel.getSearchStock()
            }
        }
    }
    
    // Carousel-like market status view using TabView
    private var marketStatusCarouselView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Global Market Status")
                .font(.headline)
            
            if case .Loaded(let status) = tickerViewModel.marketStatusState {
                Picker("Market Type", selection: $selectedMarketType) {
                    Text("Equity").tag("Equity")
                    Text("Forex").tag("Forex")
                    Text("Crypto").tag("Cryptocurrency")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                
                // TabView to create a horizontal scrolling carousel
                TabView {
                    ForEach(status.markets.filter { $0.marketType == selectedMarketType || $0.marketType == nil }) { market in
                        marketCard(for: market)
                            .frame(maxWidth: .infinity)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 150)  // Adjust the height of the carousel
            } else if case .Error(let error) = tickerViewModel.marketStatusState {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
    }
    
    private func marketCard(for market: MarketStatus.Market) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(market.region ?? "Unknown Region")
                    .font(.headline)
                Spacer()
                // Showing market status with fallback and background color for open/closed status
                Text(market.currentStatus?.capitalized ?? "Unknown Status")
                    .font(.subheadline)
                    .padding(5)
                    .background(market.currentStatus == "open" ? Color.green : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            // Displaying primary exchanges with fallback
            Text(market.primaryExchanges ?? "Unknown Exchanges")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Displaying local open and close times with fallback
            Text("Hours: \(market.localOpen ?? "Unknown Open") - \(market.localClose ?? "Unknown Close")")
                .font(.caption)
            
            // Displaying notes if present
            if let notes = market.notes, !notes.isEmpty {
                Text(notes)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
    
    private var favoriteTickersView: some View {
        VStack(alignment: .leading) {
            Text("Favorites")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(favoriteMatches) { match in
                        VStack {
                            Text(match.symbol)
                                .font(.subheadline)
                            Text(match.name)
                                .font(.caption)
                                .lineLimit(1)
                        }
                        .padding(8)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                        .onTapGesture {
                            appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: match.symbol))
                        }
                    }
                }
            }
        }
        .padding(.vertical)
    }
    
    private var marketListView: some View {
        VStack(alignment: .leading) {
            Text("Markets")
                .font(.headline)
            if case .Loaded(let status) = tickerViewModel.marketStatusState {
                ForEach(status.markets.filter { $0.marketType == "Equity" }.prefix(5)) { market in
                    HStack {
                        Text(market.region ?? "Unknown")
                        Spacer()
                        Text(market.currentStatus?.capitalized ?? "Unknown")
                            .foregroundColor(market.currentStatus == "open" ? .green : .red)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
    
    private var searchResultsView: some View {
        VStack(alignment: .leading) {
            Text("Search Results")
                .font(.headline)
            
            switch tickerViewModel.tickerState {
            case .Initial:
                if favoriteMatches.isEmpty {
                    Text("Search for a ticker symbol")
                        .foregroundColor(.secondary)
                }
            case .Loading:
                ProgressView()
            case .Loaded(let data):
                ForEach(data.bestMatches, id: \.symbol) { bestMatch in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(bestMatch.symbol)
                                .font(.headline)
                            Text(bestMatch.name)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button {
                            toggleFavorite(bestMatch)
                        } label: {
                            Image(systemName: isFavorite(bestMatch) ? "heart.fill" : "heart")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.vertical, 5)
                    .onTapGesture {
                        appNavigation.tickerNavigation.append(TickerViewRoute.tickerDetail(sym: bestMatch.symbol))
                    }
                }
            case .Error(let error):
                Text(error)
                    .foregroundColor(.red)
            }
        }
    }
    
    private func toggleFavorite(_ match: BestMatch) {
        if let existingMatch = favoriteMatches.first(where: { $0.symbol == match.symbol }) {
            modelContext.delete(existingMatch)
        } else {
            modelContext.insert(match)
        }
    }
    
    private func isFavorite(_ match: BestMatch) -> Bool {
        favoriteMatches.contains { $0.symbol == match.symbol }
    }
}

#Preview {
    NavigationStack {
        Ticker()
            .environmentObject(AppNavigation())
            .modelContainer(for: BestMatch.self, inMemory: true)
    }
}
