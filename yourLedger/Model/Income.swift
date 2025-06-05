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
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
