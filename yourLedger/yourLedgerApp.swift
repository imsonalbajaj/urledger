//
//  yourLedgerApp.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI
import SwiftData

// MARK: - Custom Environment Key for Income Context

private struct IncomeModelContextKey: EnvironmentKey {
    static let defaultValue: ModelContext? = nil
}

extension EnvironmentValues {
    var incomeModelContext: ModelContext? {
        get { self[IncomeModelContextKey.self] }
        set { self[IncomeModelContextKey.self] = newValue }
    }
}

// MARK: - App Entry Point

@main
struct yourLedgerApp: App {
    let incomeContainer: ModelContainer

    init() {
        let incomeSchema = Schema([Income.self])
        let incomeConfig = ModelConfiguration(for: Income.self, isStoredInMemoryOnly: false)
        
        do {
            self.incomeContainer = try ModelContainer(for: incomeSchema, configurations: [incomeConfig])
        } catch {
            fatalError("Could not create incomeContainer: \(error)")
        }
    
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(\.incomeModelContext, incomeContainer.mainContext)
    }
}
