//
//  Helper.swift
//  StockApp
//
//  Created by hariharan mudaliar on 02/10/2024.
//

import Foundation

class Helper {
    static var POLYGON_API_KEY: String {
        return getAPIKey(for: "POLYGON_API_KEY")
    }

    static var API_kEY: String {
        return getAPIKey(for: "API_kEY")
    }

    private static func getAPIKey(for key: String) -> String {
        guard let filePath = Bundle.main.path(forResource: "APIKeys", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist[key] as? String else {
            fatalError("Couldn't find key \(key) in APIKeys.plist")
        }
        return value
    }
}
