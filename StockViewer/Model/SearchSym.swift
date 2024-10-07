//
//  SearchSym.swift
//  StockApp
//
//  Created by hariharan mudaliar on 02/10/2024.
//

//import Foundation
//import SwiftData
//
//
//class SearchSym: Codable {
//    let bestMatches: [BestMatch]
//}
//
//@Model
//class BestMatch: Codable , Hashable {
//    @Attribute(.unique) var the1Symbol:String
//    var the2Name: String
//    var the3Type:String
//    var the4Region:String
//    var the5MarketOpen:String
//    var the6MarketClose:String
//    var the7Timezone:String
//    var the8Currency: String
//    var the9MatchScore: String
//    
//    enum CodingKeys: String, CodingKey {
//           case the1Symbol = "1. symbol"
//           case the2Name = "2. name"
//           case the3Type = "3. type"
//           case the4Region = "4. region"
//           case the5MarketOpen = "5. marketOpen"
//           case the6MarketClose = "6. marketClose"
//           case the7Timezone = "7. timezone"
//           case the8Currency = "8. currency"
//           case the9MatchScore = "9. matchScore"
//       }
//    init(the1Symbol: String, the2Name: String, the3Type: String, the4Region: String, the5MarketOpen: String, the6MarketClose: String, the7Timezone: String, the8Currency: String, the9MatchScore: String) {
//        self.the1Symbol = the1Symbol
//        self.the2Name = the2Name
//        self.the3Type = the3Type
//        self.the4Region = the4Region
//        self.the5MarketOpen = the5MarketOpen
//        self.the6MarketClose = the6MarketClose
//        self.the7Timezone = the7Timezone
//        self.the8Currency = the8Currency
//        self.the9MatchScore = the9MatchScore
//    }
//    
//    required init(from decoder:Decoder) throws{
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        
//        self.the1Symbol = try values.decodeIfPresent(String.self,forKey: .the1Symbol)!
//        self.the2Name = try values.decodeIfPresent(String.self,forKey: .the2Name)!
//        self.the3Type = try values.decodeIfPresent(String.self,forKey: .the3Type)!
//        self.the4Region = try values.decodeIfPresent(String.self,forKey: .the4Region)!
//        self.the5MarketOpen = try values.decodeIfPresent(String.self,forKey: .the5MarketOpen)!
//        self.the6MarketClose = try values.decodeIfPresent(String.self,forKey: .the6MarketClose)!
//        self.the7Timezone = try values.decodeIfPresent(String.self,forKey: .the7Timezone)!
//        self.the8Currency = try values.decodeIfPresent(String.self,forKey: .the8Currency)!
//        self.the9MatchScore = try values.decodeIfPresent(String.self,forKey: .the9MatchScore)!
//    }
//    
//    func encode(to encoder: Encoder) throws {
//          var container = encoder.container(keyedBy: CodingKeys.self)
//          try container.encode(the1Symbol, forKey: .the1Symbol)
//          try container.encode(the2Name, forKey: .the2Name)
//          try container.encode(the3Type, forKey: .the3Type)
//          try container.encode(the4Region, forKey: .the4Region)
//          try container.encode(the5MarketOpen, forKey: .the5MarketOpen)
//          try container.encode(the6MarketClose, forKey: .the6MarketClose)
//          try container.encode(the7Timezone, forKey: .the7Timezone)
//          try container.encode(the8Currency, forKey: .the8Currency)
//          try container.encode(the9MatchScore, forKey: .the9MatchScore)
//      }
//    
//   
//}
import Foundation
import SwiftData

class SearchSym: Codable {
    let bestMatches: [BestMatch]
    
    enum CodingKeys: String, CodingKey {
        case bestMatches = "bestMatches"
    }
}

@Model
final class BestMatch: Codable, Identifiable {
    @Attribute(.unique) var id: String
    var symbol: String
    var name: String
    var type: String
    var region: String
    var marketOpen: String
    var marketClose: String
    var timezone: String
    var currency: String
    var matchScore: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case region = "4. region"
        case marketOpen = "5. marketOpen"
        case marketClose = "6. marketClose"
        case timezone = "7. timezone"
        case currency = "8. currency"
        case matchScore = "9. matchScore"
    }
    
    init(symbol: String, name: String, type: String, region: String, marketOpen: String, marketClose: String, timezone: String, currency: String, matchScore: String) {
        self.id = symbol // Use symbol as the unique identifier
        self.symbol = symbol
        self.name = name
        self.type = type
        self.region = region
        self.marketOpen = marketOpen
        self.marketClose = marketClose
        self.timezone = timezone
        self.currency = currency
        self.matchScore = matchScore
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let symbol = try container.decode(String.self, forKey: .symbol)
        self.id = symbol
        self.symbol = symbol
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.region = try container.decode(String.self, forKey: .region)
        self.marketOpen = try container.decode(String.self, forKey: .marketOpen)
        self.marketClose = try container.decode(String.self, forKey: .marketClose)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.matchScore = try container.decode(String.self, forKey: .matchScore)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(region, forKey: .region)
        try container.encode(marketOpen, forKey: .marketOpen)
        try container.encode(marketClose, forKey: .marketClose)
        try container.encode(timezone, forKey: .timezone)
        try container.encode(currency, forKey: .currency)
        try container.encode(matchScore, forKey: .matchScore)
    }
}
