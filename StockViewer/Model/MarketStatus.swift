//
//  MarketStatus.swift
//  StockViewer
//
//  Created by admin63 on 04/10/24.
//


//import Foundation
//
//struct MarketStatus: Decodable {
//    let endpoint: String
//    let markets: [Market]
//    
//    struct Market: Decodable {
//        let marketType: String
//        let region: String
//        let primaryExchanges: String
//        let localOpen: String
//        let localClose: String
//        let currentStatus: String
//        let notes: String
//        
//        enum CodingKeys: String, CodingKey {
//            case marketType = "market_type"
//            case region
//            case primaryExchanges = "primary_exchanges"
//            case localOpen = "local_open"
//            case localClose = "local_close"
//            case currentStatus = "current_status"
//            case notes
//        }
//    }
//}
import Foundation

struct MarketStatus: Decodable {
    let endpoint: String
    let markets: [Market]
    
    struct Market: Decodable, Identifiable {
        var id: UUID { UUID() }
        
        let marketType: String?
        let region: String?
        let primaryExchanges: String?
        let localOpen: String?
        let localClose: String?
        let currentStatus: String?
        let notes: String?
        
        enum CodingKeys: String, CodingKey {
            case marketType = "market_type"
            case region
            case primaryExchanges = "primary_exchanges"
            case localOpen = "local_open"
            case localClose = "local_close"
            case currentStatus = "current_status"
            case notes
        }
    }
}
