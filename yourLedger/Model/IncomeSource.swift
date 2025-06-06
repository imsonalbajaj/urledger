//
//  IncomeSource.swift
//  yourLedger
//
//  Created by Sonal on 05/06/25.
//

enum IncomeSource: String, Hashable, CaseIterable {
    case income
    case interest
    case dividentandstocks
    case other

    func getTitleString() -> String {
        switch self {
        case .income:
            return "income"
        case .interest:
            return "interest"
        case .dividentandstocks:
            return "divident and stocks"
        case .other:
            return "others"
        }
    }
}
