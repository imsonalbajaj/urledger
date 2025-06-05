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
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
