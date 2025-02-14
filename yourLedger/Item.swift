//
//  Item.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
