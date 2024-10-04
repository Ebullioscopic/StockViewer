//
//  MarketStatus.swift
//  StockViewer
//
//  Created by admin63 on 04/10/24.
//


struct MarketStatus: Decodable {
    let isOpen: Bool
    
    enum CodingKeys: String, CodingKey {
        case isOpen = "market_is_open" // Change according to the API response
    }
}
