//
//  ExpensesView.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI

struct ExpensesView: View {
    @Binding var path: [String]
    
    var body: some View {
        VStack {
            Button {
                path.append("AddExpensesView")
            } label: {
                Text("add expenses")
            }
        }
//        .ignoresSafeArea(.all)
    }
}


struct AddExpensesView : View {
    var body: some View {
        Text("AddExpensesView")
    }
}
