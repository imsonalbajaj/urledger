//
//  IncomeView.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI

struct IncomeView: View {
    @Binding var path: [String]
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Button {
                    path.append("AddIncomeView")
                } label: {
                    Text("add income")
                }
            }
        }
        
    }
}
