//
//  c.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI

struct ExpensesView: View {
    @Environment(\.expenseModelContext) private var context
    @Binding var path: [AppScreen]

    var body: some View {
        TransactionOverviewView<ExpenseSource, Expense>(
            path: $path,
            title: "Your Expenses",
            destinationScreen: .addexpensesview,
            context: context,
            fetch: TransactionFilterManager.getUpdateExpense,
            getAmount: { $0.amount },
            getDate: { $0.timestamp },
            getSource: { $0.source },
            getSourceLabel: { ExpenseSource(rawValue: $0)?.getTitleString() ?? $0 }
        )
    }
}
