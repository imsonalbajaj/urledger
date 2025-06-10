//
//  yourLedgerApp.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI
import SwiftData

@main
struct yourLedgerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Income.self, Expense.self])
    }
}
 
