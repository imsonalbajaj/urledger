//
//  IncomeView.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI

struct IncomeView: View {
    @Environment(\.incomeModelContext) private var context
    @Binding var path: [AppScreen]

    var body: some View {
        TransactionOverviewView<IncomeSource, Income>(
            path: $path,
            title: "Your Income",
            destinationScreen: .addincomeview,
            context: context,
            fetch: TransactionFilterManager.getUpdateIncome,
            getAmount: { $0.amount },
            getDate: { $0.timestamp },
            getSource: { $0.source },
            getSourceLabel: { IncomeSource(rawValue: $0)?.getTitleString() ?? $0 }
        )
    }
}
