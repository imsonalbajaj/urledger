//
//  ExpensesView.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI

struct ExpensesView: View {
    @Binding var path: [AppScreen]
    
    var body: some View {
        VStack {
            Button {
                path.append(.addexpensesview)
            } label: {
                Text("add expenses")
            }
        }
        .navigationTitle("Your Expenses")
//        .ignoresSafeArea(.all)
    }
}


struct AddExpensesView : View {
    var body: some View {
        Text("AddExpensesView")
    }
}
