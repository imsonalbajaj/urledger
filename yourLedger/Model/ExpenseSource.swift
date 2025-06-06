//
//  ExpenseSource.swift
//  yourLedger
//
//  Created by Sonal on 06/06/25.
//

enum ExpenseSource: String, Hashable, CaseIterable {
    case food
    case travel
    case bills
    case entertainment
    case shopping
    case healthcare
    case education
    case other

    func getTitleString() -> String {
        switch self {
        case .food:
            return "Food"
        case .travel:
            return "Travel"
        case .bills:
            return "Bills"
        case .entertainment:
            return "Entertainment"
        case .shopping:
            return "Shopping"
        case .healthcare:
            return "Healthcare"
        case .education:
            return "Education"
        case .other:
            return "Other"
        }
    }
}
