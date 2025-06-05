//
//  Income.swift
//  yourLedger
//
//  Created by Sonal on 04/06/25.
//

import Foundation
import SwiftData

@Model
final class Income {
    var timestamp: Date
    var amount: Int
    var source: String
    
    init(timestamp: Date, amount: Int, source: String) {
        self.timestamp = timestamp
        self.amount = amount
        self.source = source
    }
}
