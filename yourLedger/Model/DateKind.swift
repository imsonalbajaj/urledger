//
//  DateKind.swift
//  yourLedger
//
//  Created by Sonal on 06/06/25.
//

import Foundation

enum DateKind: Int, CaseIterable, Identifiable {
    case currMonth
    case prevMonth
    case last3Months
    case thisYear
    case alltime

    var id: Int { self.rawValue }
    
    var titleString: String {
        switch self {
        case .currMonth:
            return "curr month"
        case .prevMonth:
            return "prev month"
        case .last3Months:
            return "last three month"
        case .thisYear:
            return "this year"
        case .alltime:
            return "all time"
        }
    }
}
