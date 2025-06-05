//
//  ContentView.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI
import SwiftData

enum OurAppState {
    case launch
    case foreground
}

enum AppScreen: String {
    case addexpensesview
    case addincomeview
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State var path: [AppScreen] = []
    @State var ourAppState: OurAppState = .launch
    
    var body: some View {
        switch ourAppState {
        case .launch:
            SplashView(ourAppState: $ourAppState)
        case .foreground:
            NavigationStack(path: $path) {
                TabView {
                    Group {
                        ExpensesView(path: $path)
                            .tabItem {
                                Image(systemName: "book")
                                Text("Expenses")
                            }
                            .tag(0)
                        
                        IncomeView(path: $path)
                            .tabItem {
                                Image(systemName: "indianrupeesign.circle")
                                Text("Income")
                            }
                            .tag(1)
                    }
                }
                
                .navigationDestination(for: AppScreen.self) { screen in
                    switch screen {
                    case .addexpensesview:
                        AddExpensesView()
                    case .addincomeview:
                        AddIncomeView()
                    }
                }
            }
            .ignoresSafeArea(.all)
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
    
}

/*
 NavigationSplitView {
 List {
 ForEach(items) { item in
 NavigationLink {
 Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
 } label: {
 Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
 }
 }
 .onDelete(perform: deleteItems)
 }
 .toolbar {
 ToolbarItem(placement: .navigationBarTrailing) {
 EditButton()
 }
 ToolbarItem {
 Button(action: addItem) {
 Label("Add Item", systemImage: "plus")
 }
 }
 }
 } detail: {
 Text("Select an item")
 }
 */
