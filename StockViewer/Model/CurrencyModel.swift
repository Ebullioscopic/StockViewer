//
//  CurrencyModel.swift
//  StockApp
//
//  Created by hariharan mudaliar on 17/10/2024.
//

import Foundation

struct CurrencyModel: Identifiable {
    let currencyCode:String
    let currencyName:String
    
    var id:String {
        return currencyCode
    }
}
