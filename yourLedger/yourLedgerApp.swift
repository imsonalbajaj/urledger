//
//  yourLedgerApp.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI
import SwiftData

private struct IncomeModelContextKey: EnvironmentKey {
    static let defaultValue: ModelContext? = nil
}

extension EnvironmentValues {
    var incomeModelContext: ModelContext? {
        get { self[IncomeModelContextKey.self] }
        set { self[IncomeModelContextKey.self] = newValue }
    }
}

@main
struct yourLedgerApp: App {
    let sharedModelContainer: ModelContainer
    let incomeContainer: ModelContainer

    init() {
        let itemSchema = Schema([Item.self])
        let incomeSchema = Schema([Income.self])

        let itemConfig = ModelConfiguration(schema: itemSchema, isStoredInMemoryOnly: false)
        let incomeConfig = ModelConfiguration(schema: incomeSchema, isStoredInMemoryOnly: false)

        do {
            self.sharedModelContainer = try ModelContainer(for: itemSchema, configurations: [itemConfig])
            self.incomeContainer = try ModelContainer(for: incomeSchema, configurations: [incomeConfig])
        } catch {
            fatalError("Could not create ModelContainers: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(\.modelContext, sharedModelContainer.mainContext)
        .environment(\.incomeModelContext, incomeContainer.mainContext)
    }
}
