//
//  AddExpensesView.swift
//  yourLedger
//
//  Created by Sonal on 06/06/25.
//

import SwiftUI

struct AddExpensesView: View {
    @Environment(\.expenseModelContext) private var context

    var body: some View {
        AddTransactionView<ExpenseSource, Expense>(
            context: context!,
            title: "Add Your Expense",
            buttonTitle: "Add to your expense",
            viewModel: AddTransactionViewModel(defaultSource: ExpenseSource.food),
            createModel: { date, amount, source in
                Expense(timestamp: date, amount: amount, source: source)
            }
        )
    }
}
