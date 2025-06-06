//
//  TransactionFilterManager.swift
//  yourLedger
//
//  Created by Sonal on 06/06/25.
//

import SwiftUI
import SwiftData

class TransactionFilterManager {
    static func getUpdateIncome(context: ModelContext, selectedDate: DateKind) -> [Income] {
        let calendar = Calendar.current
        let now = Date()

        do {
            let descriptor: FetchDescriptor<Income>

            switch selectedDate {
            case .currMonth:
                if let start = calendar.date(from: calendar.dateComponents([.year, .month], from: now)),
                   let end = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: start) {
                    descriptor = FetchDescriptor(
                        predicate: #Predicate { $0.timestamp >= start && $0.timestamp <= end },
                        sortBy: [SortDescriptor(\Income.timestamp, order: .reverse)]
                    )
                } else {
                    return []
                }

            case .prevMonth:
                if let start = calendar.date(byAdding: .month, value: -1, to: now)?.startOfMonth(),
                   let end = calendar.date(byAdding: .month, value: -1, to: now)?.endOfMonth() {
                    descriptor = FetchDescriptor(
                        predicate: #Predicate { $0.timestamp >= start && $0.timestamp <= end },
                        sortBy: [SortDescriptor(\Income.timestamp, order: .reverse)]
                    )
                } else {
                    return []
                }

            case .last3Months:
                if let start = calendar.date(byAdding: .month, value: -3, to: now) {
                    descriptor = FetchDescriptor(
                        predicate: #Predicate { $0.timestamp >= start },
                        sortBy: [SortDescriptor(\Income.timestamp, order: .reverse)]
                    )
                } else {
                    return []
                }

            case .thisYear:
                if let start = calendar.date(from: calendar.dateComponents([.year], from: now)),
                   let end = calendar.date(byAdding: .year, value: 1, to: start) {
                    descriptor = FetchDescriptor(
                        predicate: #Predicate { $0.timestamp >= start && $0.timestamp < end },
                        sortBy: [SortDescriptor(\Income.timestamp, order: .reverse)]
                    )
                } else {
                    return []
                }

            default:
                descriptor = FetchDescriptor<Income>(sortBy: [SortDescriptor(\Income.timestamp, order: .reverse)])
            }

            return try context.fetch(descriptor)
        } catch {
            print("Error updating incomes: \(error)")
        }
        return []
    }
    
    static func getUpdateExpense(context: ModelContext, selectedDate: DateKind) -> [Expense] {
        let calendar = Calendar.current
        let now = Date()

        do {
            let descriptor: FetchDescriptor<Expense>

            switch selectedDate {
            case .currMonth:
                if let start = calendar.date(from: calendar.dateComponents([.year, .month], from: now)),
                   let end = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: start) {
                    descriptor = FetchDescriptor(
                        predicate: #Predicate { $0.timestamp >= start && $0.timestamp <= end },
                        sortBy: [SortDescriptor(\Expense.timestamp, order: .reverse)]
                    )
                } else {
                    return []
                }

            case .prevMonth:
                if let start = calendar.date(byAdding: .month, value: -1, to: now)?.startOfMonth(),
                   let end = calendar.date(byAdding: .month, value: -1, to: now)?.endOfMonth() {
                    descriptor = FetchDescriptor(
                        predicate: #Predicate { $0.timestamp >= start && $0.timestamp <= end },
                        sortBy: [SortDescriptor(\Expense.timestamp, order: .reverse)]
                    )
                } else {
                    return []
                }

            case .last3Months:
                if let start = calendar.date(byAdding: .month, value: -3, to: now) {
                    descriptor = FetchDescriptor(
                        predicate: #Predicate { $0.timestamp >= start },
                        sortBy: [SortDescriptor(\Expense.timestamp, order: .reverse)]
                    )
                } else {
                    return []
                }

            case .thisYear:
                if let start = calendar.date(from: calendar.dateComponents([.year], from: now)),
                   let end = calendar.date(byAdding: .year, value: 1, to: start) {
                    descriptor = FetchDescriptor(
                        predicate: #Predicate { $0.timestamp >= start && $0.timestamp < end },
                        sortBy: [SortDescriptor(\Expense.timestamp, order: .reverse)]
                    )
                } else {
                    return []
                }

            default:
                descriptor = FetchDescriptor<Expense>(sortBy: [SortDescriptor(\Expense.timestamp, order: .reverse)])
            }

            return try context.fetch(descriptor)
        } catch {
            print("Error updating incomes: \(error)")
        }
        return []
    }
}
