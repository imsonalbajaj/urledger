//
//  AddIncomeView.swift
//  yourLedger
//
//  Created by Sonal on 18/02/25.
//

import SwiftUI
import SwiftData

struct AddIncomeView: View {
    @Environment(\.incomeModelContext) private var context

    var body: some View {
        AddTransactionView<IncomeSource, Income>(
            context: context!,
            title: "Add Your Income",
            buttonTitle: "Add to your income",
            viewModel: AddTransactionViewModel(defaultSource: IncomeSource.income),
            createModel: { date, amount, source in
                Income(timestamp: date, amount: amount, source: source)
            }
        )
    }
}

// Generic ViewModel

