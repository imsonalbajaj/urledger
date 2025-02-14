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

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State var path: [String] = []
    @State var ourAppState: OurAppState = .launch

    var body: some View {
        switch ourAppState {
        case .launch:
            SplashView(ourAppState: $ourAppState)
        case .foreground:
            NavigationStack(path: $path) {
                TabView {
                    Group {
                        Text("a")
                            .tabItem {
                                Image(systemName: "book")
                                Text("Expenses")
                            }
                            .tag(0)
                        
                        Text("b")
                            .tabItem {
                                Image(systemName: "indianrupeesign.circle")
                                Text("Income")
                            }
                            .tag(1)
                    }
                }
            }
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

struct SplashView: View {
    @State var iconShown = false
    @Binding var ourAppState: OurAppState
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .ignoresSafeArea(.all)
            
            if iconShown {
                Text("\u{20B9}")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.white)
                    .transition(.scale)
            }
        }
        .onAppear {
            withAnimation {
                iconShown = true
            } completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    ourAppState = .foreground
                }
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
