//
//  NewsView.swift
//  StockApp
//
//  Created by hariharan mudaliar on 13/10/2024.
//

//import SwiftUI
//
//struct NewsView: View {
//    @State private var newsViewModel = NewsViewModel(stockService: StockService())
//    var body: some View {
//        VStack {
//            switch newsViewModel.newsViewState{
//            case .initial:
//                ProgressView()
//            case .loading:
//                ProgressView()
//            case .loaded(let data):
//                
//                List(data.feed,id: \.timePublished){feed in
//                    
//                    Link(destination: URL(string: feed.url)!, label: {
//                        VStack(alignment:.leading){
//                            AsyncImage(url: URL(string: feed.bannerImage)) { image in
//                                image.resizable()
//                                    .frame(maxWidth:.infinity,maxHeight:150)
//                                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                            } placeholder: {
//                                ProgressView()
//                            }
//
//                                
//                                
//                            Text(feed.title)
//                                .font(.title3)
//                                .fontWeight(.semibold)
//                                .lineLimit(1)
//                                .padding(.bottom,6)
//                            
//                            Text(feed.summary)
//                                .font(.subheadline)
//                                .fontWeight(.medium)
//                                .lineLimit(2)
//                            
//                        }
//                    })
//                    
//                   
//                    
//                }
//                .listStyle(.plain)
//            case .error(let error):
//                Text(error)
//            }
//        }
//        .navigationTitle("News")
//        .task {
//            await newsViewModel.getNewsAndSentiment()
//        }
//    }
//}
//
//#Preview {
//    
//    NavigationStack{
//        NewsView()
//    }
//}
/////////////////////////////////////////////____________________________________________________
import SwiftUI

struct NewsView: View {
    @State private var newsViewModel = NewsViewModel(stockService: StockService())
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                switch newsViewModel.newsViewState {
                case .initial, .loading:
                    ProgressView()
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Center ProgressView
                        .background(Color.clear) // Transparent background
                
                case .loaded(let data):
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(data.feed, id: \.timePublished) { feed in
                                Link(destination: URL(string: feed.url)!) {
                                    VStack(alignment: .leading) {
                                        // News Image
                                        AsyncImage(url: URL(string: feed.bannerImage)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill() // Ensure image scales properly
                                                .frame(height: 200)
                                                .clipped()
                                                .cornerRadius(10)
                                                .shadow(radius: 5)
                                        } placeholder: {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(height: 200)
                                                .overlay(
                                                    ProgressView()
                                                        .scaleEffect(1.5)
                                                )
                                        }
                                        
                                        // News Title
                                        Text(feed.title)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                            .padding(.top, 5)
                                            .lineLimit(2)
                                        
                                        // News Summary
                                        Text(feed.summary)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(3)
                                            .padding(.top, 1)
                                        
                                        // Convert Unix timestamp to Date and format
                                        if let timeInterval = Double(feed.timePublished) {
                                            let date = Date(timeIntervalSince1970: timeInterval)
                                            Text(date.formatted(.dateTime.month().day().hour().minute()))
                                                .font(.footnote)
                                                .foregroundColor(.gray)
                                                .padding(.top, 5)
                                        }
                                    }
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                                    .frame(maxWidth: geometry.size.width * 0.9) // Ensure card fits the screen
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                case .error(let error):
                    VStack {
                        Text("Oops, something went wrong!")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)
                        
                        Text(error)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Center the error message
                }
            }
            .navigationTitle("News")
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .task {
                await newsViewModel.getNewsAndSentiment()
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewsView()
    }
}
