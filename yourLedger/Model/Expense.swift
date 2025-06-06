//
//  Expense.swift
//  yourLedger
//
//  Created by Sonal on 04/06/25.
//

import Foundation
import SwiftData

@Model
final class Expense {
    var timestamp: Date
    var amount: Int
    var source: String
    
    init(timestamp: Date, amount: Int, source: String) {
        self.timestamp = timestamp
        self.amount = amount
        self.source = source
    }
}
