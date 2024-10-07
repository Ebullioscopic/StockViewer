//
//  StockService.swift
//  StockApp
//
//  Created by hariharan mudaliar on 02/10/2024.
//

//import Foundation
//
//class StockService: ServiceProtocol {
//        
//    func forexExchangePoly(fromCurrency: String, toCurrency: String) async throws -> ForexExchangePolyModel {
//        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/C:\(fromCurrency + toCurrency)/prev?adjusted=true&apiKey=\(Helper.POLYGON_API_KEY)")
//        else {  throw URLError(.badURL) }
//        
//        let (data,response) = try await URLSession.shared.data(from: url)
//        
//        
//        guard let response = response as? HTTPURLResponse,
//              
//                response.statusCode == 200
//                
//                
//        else { throw URLError(.badServerResponse) }
//        
//        if let string = String(data: data, encoding: .utf8) {
//                    print(string)
//                }
//        
//        
//        let decodeResponse = try JSONDecoder().decode(ForexExchangePolyModel.self, from: data)
//        
//        return decodeResponse
//    }
//    
//    
//    
//    
//    func forexExchange(fromCurrency:String,toCurrency:String) async throws -> ForexExchangeModel {
//        guard let url = URL(string: "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(fromCurrency)&to_currency=\(toCurrency)&apikey=\(Helper.API_kEY)")
//        else {  throw URLError(.badURL) }
//        
//        let (data,response) = try await URLSession.shared.data(from: url)
//        
//        
//        guard let response = response as? HTTPURLResponse,
//              
//                response.statusCode == 200
//                
//                
//        else { throw URLError(.badServerResponse) }
//        
//        let decodeResponse = try JSONDecoder().decode(ForexExchangeModel.self, from: data)
//        
//        return decodeResponse
//    }
//    
//    
//    func newsSentiment() async throws -> NewSentimentModel {
//        //guard let url = URL(string: "https://www.alphavantage.co/query?function=NEWS_SENTIMENT&apikey=\(Helper.API_kEY)")
//        guard let url = URL(string: "https://www.alphavantage.co/query?function=NEWS_SENTIMENT&apikey=demo")
//        else {  throw URLError(.badURL) }
//        
//        let (data,response) = try await URLSession.shared.data(from: url)
//        
//        
//        guard let response = response as? HTTPURLResponse,
//              
//                response.statusCode == 200
//                
//                
//        else { throw URLError(.badServerResponse) }
//        
//        let decodeResponse = try JSONDecoder().decode(NewSentimentModel.self, from: data)
//        print("News Sentiment: \(decodeResponse)")
//        return decodeResponse
//    }
//    
//    
//    
//    
//    func topTraded() async throws -> TopTraded {
//        guard let url = URL(string: "https://www.alphavantage.co/query?function=TOP_GAINERS_LOSERS&apikey=\(Helper.API_kEY)")
//        else {  throw URLError(.badURL) }
//        
//        let (data,response) = try await URLSession.shared.data(from: url)
//        
//        
//        guard let response = response as? HTTPURLResponse,
//              
//                response.statusCode == 200
//                
//                
//        else { throw URLError(.badServerResponse) }
//        
//        let decodeResponse = try JSONDecoder().decode(TopTraded.self, from: data)
//        
//        return decodeResponse
//        
//    }
//    
//    
//    func previousClose(sym: String) async throws -> IntraDay {
//        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/\(sym)/prev?adjusted=true&apiKey=\(Helper.POLYGON_API_KEY)")
//        else {  throw URLError(.badURL) }
//        
//        let (data,response) = try await URLSession.shared.data(from: url)
//        
//        
//        guard let response = response as? HTTPURLResponse,
//              
//                response.statusCode == 200
//                
//                
//        else { throw URLError(.badServerResponse) }
//        
//        
//        let decodeResponse = try JSONDecoder().decode(IntraDay.self, from: data)
//        
//        return decodeResponse
//    }
//    
//    func tickerDetail(sym: String) async throws -> IntraDay {
//        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/\(sym)/range/5/day/1673089582/1688727933326?adjusted=true&sort=asc&limit=120&apiKey=\(Helper.POLYGON_API_KEY)")
//        else {  throw URLError(.badURL) }
//        
//        let (data,response) = try await URLSession.shared.data(from: url)
//        
//        
//        guard let response = response as? HTTPURLResponse,
//              
//                response.statusCode == 200
//                
//                
//        else { throw URLError(.badServerResponse) }
//        
//        
//        let decodeResponse = try JSONDecoder().decode(IntraDay.self, from: data)
//        
//        return decodeResponse
//    }
//    
//    func searchTicker(sym: String) async throws -> SearchSym {
//        guard let url = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(sym)&apikey=\(Helper.API_kEY)")
//        else {  throw URLError(.badURL) }
//        
//        let (data,response) = try await URLSession.shared.data(from: url)
//        
//        
//        guard let response = response as? HTTPURLResponse,
//              
//                response.statusCode == 200
//                
//                
//        else { throw URLError(.badServerResponse) }
//        
//        let decodeResponse = try JSONDecoder().decode(SearchSym.self, from: data)
//        print(decodeResponse)
//        return decodeResponse
//    }
//    
//    
//    func fetchMarketStatus() async throws -> MarketStatus {
//        //let url = URL(string: "https://www.alphavantage.co/query?function=MARKET_STATUS&apikey=\(Helper.API_kEY)")!
//        let url = URL(string: "https://www.alphavantage.co/query?function=MARKET_STATUS&apikey=demo")!
//        let (data, _) = try await URLSession.shared.data(from: url)
//        
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        let marketStatus = try decoder.decode(MarketStatus.self, from: data)
//        print("Market Status: \(marketStatus)")
//        return marketStatus
//    }
//    
//}
import Foundation

class StockService: ServiceProtocol {
        
    func forexExchangePoly(fromCurrency: String, toCurrency: String) async throws -> ForexExchangePolyModel {
        print("Building URL for Polygon API forex exchange with currencies: \(fromCurrency) to \(toCurrency)")
        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/C:\(fromCurrency + toCurrency)/prev?adjusted=true&apiKey=\(Helper.POLYGON_API_KEY)") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        print("URL created: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        print("Received data from server")
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Server returned an invalid response or non-200 status code")
            throw URLError(.badServerResponse)
        }
        print("Response is valid with status code: \(httpResponse.statusCode)")
        
        if let string = String(data: data, encoding: .utf8) {
            print("Response data as string: \(string)")
        }
        
        let decodeResponse = try JSONDecoder().decode(ForexExchangePolyModel.self, from: data)
        print("Decoded response successfully")
        
        return decodeResponse
    }
    
    func forexExchange(fromCurrency: String, toCurrency: String) async throws -> ForexExchangeModel {
        print("Building URL for AlphaVantage forex exchange with currencies: \(fromCurrency) to \(toCurrency)")
        guard let url = URL(string: "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=\(fromCurrency)&to_currency=\(toCurrency)&apikey=\(Helper.API_kEY)") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        print("URL created: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        print("Received data from server")
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Server returned an invalid response or non-200 status code")
            throw URLError(.badServerResponse)
        }
        print("Response is valid with status code: \(httpResponse.statusCode)")
        
        let decodeResponse = try JSONDecoder().decode(ForexExchangeModel.self, from: data)
        print("Decoded response successfully")
        
        return decodeResponse
    }
    
    func newsSentiment() async throws -> NewSentimentModel {
        print("Building URL for AlphaVantage news sentiment")
        guard let url = URL(string: "https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=AAPL&apikey=demo") else {
        //guard let url = URL(string: "https://www.alphavantage.co/query?function=NEWS_SENTIMENT&apikey=\(Helper.API_kEY)") else{
            print("Invalid URL")
            throw URLError(.badURL)
        }
        print("URL created: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        print("Received data from server")
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Server returned an invalid response or non-200 status code")
            throw URLError(.badServerResponse)
        }
        print("Response is valid with status code: \(httpResponse.statusCode)")
        
        let decodeResponse = try JSONDecoder().decode(NewSentimentModel.self, from: data)
        print("News Sentiment: \(decodeResponse)")
        
        return decodeResponse
    }
    
    func topTraded() async throws -> TopTraded {
        print("Building URL for AlphaVantage top traded stocks")
        guard let url = URL(string: "https://www.alphavantage.co/query?function=TOP_GAINERS_LOSERS&apikey=\(Helper.API_kEY)") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        print("URL created: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        print("Received data from server")
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Server returned an invalid response or non-200 status code")
            throw URLError(.badServerResponse)
        }
        print("Response is valid with status code: \(httpResponse.statusCode)")
        
        let decodeResponse = try JSONDecoder().decode(TopTraded.self, from: data)
        print("Decoded top traded stocks data successfully")
        
        return decodeResponse
    }
    
    func previousClose(sym: String) async throws -> IntraDay {
        print("Building URL for Polygon API previous close for symbol: \(sym)")
        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/\(sym)/prev?adjusted=true&apiKey=\(Helper.POLYGON_API_KEY)") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        print("URL created: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        print("Received data from server")
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Server returned an invalid response or non-200 status code")
            throw URLError(.badServerResponse)
        }
        print("Response is valid with status code: \(httpResponse.statusCode)")
        
        let decodeResponse = try JSONDecoder().decode(IntraDay.self, from: data)
        print("Decoded previous close data successfully")
        
        return decodeResponse
    }
    
    func tickerDetail(sym: String) async throws -> IntraDay {
        print("Building URL for Polygon API ticker details for symbol: \(sym)")
        guard let url = URL(string: "https://api.polygon.io/v2/aggs/ticker/\(sym)/range/5/day/1673089582/1688727933326?adjusted=true&sort=asc&limit=120&apiKey=\(Helper.POLYGON_API_KEY)") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        print("URL created: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        print("Received data from server")
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Server returned an invalid response or non-200 status code")
            throw URLError(.badServerResponse)
        }
        print("Response is valid with status code: \(httpResponse.statusCode)")
        
        let decodeResponse = try JSONDecoder().decode(IntraDay.self, from: data)
        print("Decoded ticker details data successfully")
        
        return decodeResponse
    }
    
    func searchTicker(sym: String) async throws -> SearchSym {
        print("Building URL for AlphaVantage symbol search: \(sym)")
        guard let url = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(sym)&apikey=\(Helper.API_kEY)") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        print("URL created: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        print("Received data from server")
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Server returned an invalid response or non-200 status code")
            throw URLError(.badServerResponse)
        }
        print("Response is valid with status code: \(httpResponse.statusCode)")
        
        let decodeResponse = try JSONDecoder().decode(SearchSym.self, from: data)
        print("Decoded search ticker data: \(decodeResponse)")
        
        return decodeResponse
    }
    
    func fetchMarketStatus() async throws -> MarketStatus {
        print("Building URL for AlphaVantage market status")
        guard let url = URL(string: "https://www.alphavantage.co/query?function=MARKET_STATUS&apikey=demo") else {
        //guard let url = URL(string: "https://www.alphavantage.co/query?function=MARKET_STATUS&apikey=\(Helper.API_kEY)") else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        
        print("URL created: \(url)")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Print raw response data for debugging
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw response data: \(responseString)")
            }
            
            // Check for a valid HTTP response
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP status code: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    throw URLError(.badServerResponse)
                }
            }
            
            print("Received data from server")
            
            // Decode the data into your model
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let marketStatus = try decoder.decode(MarketStatus.self, from: data)
            print("Decoded Market Status: \(marketStatus)")
            
            return marketStatus
            
        } catch {
            // Print the error for debugging
            print("Error fetching or decoding market status: \(error)")
            throw error
        }
    }

}
