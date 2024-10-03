//
//  TickerDetailView.swift
//  StockApp
//
//  Created by hariharan mudaliar on 06/10/2024.
//

//import SwiftUI
//import Charts
//
//struct TickerDetailView: View {
//    
//    @State private var tickerDetailViewModel:TickerDetailViewModel = TickerDetailViewModel(stockService: StockService())
//    
//    var sym : String
//    
//    var body: some View {
//        VStack(alignment:.leading){
//            switch tickerDetailViewModel.tickerDetailState{
//            case .Initial:
//                ProgressView()
//                
//            case .Loading:
//                ProgressView()
//            case .Loaded(let data,let previousClose):
//                    Chart{
//                        ForEach(data.results){value in
//                            LineMark(
//                                x: .value("Shape Type", value.customDate),
//                                y: .value("Total Count", value.c)
//                            )
//                            .foregroundStyle(.blue)
//                            
//                            AreaMark(x: .value("x", value.customDate), yStart: .value("start", data.results.map { $0.c }.min()! ), yEnd: .value("end", value.c))
//                                .foregroundStyle(.blue.opacity(0.2))
//                        }
//                    }
//                    .clipShape(Rectangle())
//                    .chartYScale(domain: data.results.map { $0.c }.min()! ... (data.results.map { $0.c }.max()!) )
//                    .frame(height:350)
//                
//                
//                    Spacer()
//                    VStack(alignment:.leading){
//                        Text("High \(previousClose.results.first!.h)")
//                        Text("Low \(previousClose.results.first!.l)")
//                        Text("Open \(previousClose.results.first!.o)")
//                        Text("Close \(previousClose.results.first!.c)")
//                        Text("Volume \(previousClose.results.first!.v)")
//                        Text(" \( Date(timeIntervalSince1970: Double((previousClose.results.first!.t)/1000)) )")
//                    }
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    Spacer()
// 
//                
//            case .Error(let error):
//                Text(error)
//            }
//        }
//        .padding()
//        .navigationTitle(sym)
//        .task {
//            await tickerDetailViewModel.getTickerDetail(sym: sym)
//        }
//    }
//}
//
//#Preview {
//    NavigationStack{
//        TickerDetailView(sym: "AAPL")
//        
//    }
//}
////////////////////////////////////__________________________________________________
import SwiftUI
import Charts

struct TickerDetailView: View {
    
    @State private var tickerDetailViewModel: TickerDetailViewModel = TickerDetailViewModel(stockService: StockService())
    
    var sym: String
    
    var body: some View {
        VStack(alignment: .leading) {
            switch tickerDetailViewModel.tickerDetailState {
            case .Initial, .Loading:
                ProgressView()
                
            case .Loaded(let data, let previousClose):
                Chart {
                    ForEach(data.results) { value in
                        LineMark(
                            x: .value("Date", value.customDate),
                            y: .value("Price", value.c)
                        )
                        .foregroundStyle(.blue)
                        
                        AreaMark(x: .value("x", value.customDate),
                                 yStart: .value("start", data.results.map { $0.c }.min()!),
                                 yEnd: .value("end", value.c))
                            .foregroundStyle(.blue.opacity(0.2))
                    }
                }
                .clipShape(Rectangle())
                .chartYScale(domain: data.results.map { $0.c }.min()! ... (data.results.map { $0.c }.max()!))
                .frame(height: 350)

                Spacer()
                
                // Using List to display the data in a structured way
                List {
                    HStack {
                        Text("High")
                        Spacer()
                        Text("\(previousClose.results.first!.h)")
                    }
                    HStack {
                        Text("Low")
                        Spacer()
                        Text("\(previousClose.results.first!.l)")
                    }
                    HStack {
                        Text("Open")
                        Spacer()
                        Text("\(previousClose.results.first!.o)")
                    }
                    HStack {
                        Text("Close")
                        Spacer()
                        Text("\(previousClose.results.first!.c)")
                    }
                    HStack {
                        Text("Volume")
                        Spacer()
                        Text("\(previousClose.results.first!.v)")
                    }
                }
                .listStyle(PlainListStyle()) // Optionally change the list style here

                Spacer()
                
            case .Error(let error):
                Text(error)
            }
        }
        .padding()
        .navigationTitle(sym)
        .task {
            await tickerDetailViewModel.getTickerDetail(sym: sym)
        }
    }
}

#Preview {
    NavigationStack {
        TickerDetailView(sym: "AAPL")
    }
}
