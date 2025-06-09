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
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
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
}

//#Preview {
//    ContentView()
//}
