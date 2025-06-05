//
//  IncomeView.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct IncomeView: View {
    @Binding var path: [AppScreen]
    @Environment(\.incomeModelContext) private var incomeContext
    @Query(sort: \Income.timestamp, order: .reverse) private var incomes: [Income]
    @State private var rotationAngle: Angle = .degrees(0)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                ForEach(incomes) { income in
                    VStack(alignment: .leading) {
                        Text("Amount: ₹\(income.amount)")
                        Text("Source: \(income.source)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("Date: \(income.timestamp.formatted(date: .abbreviated, time: .shortened))")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(.insetGrouped)
            
            addBtn
        }
        .navigationTitle("Your Income")
        
    }
    
    var addBtn: some View {
        Image.getImg(.system(.pluscirclefill))
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundStyle(Color.primary)
            .background(Color(uiColor: .systemBackground))
            .clipShape(.circle)
            .padding(2)
            .clipShape(.circle)
            .background(
                VStack {
                    Circle()
                        .fill(AngularGradient(
                            gradient: Gradient(colors: [.teal, .cyan, .blue, .purple, .pink, .red, .orange, .yellow, .green, .teal]),
                            center: .center)
                        )
                        .rotationEffect(rotationAngle)
                }
            )
            .offset(x: -16, y: -40)
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    rotationAngle = .degrees(360)
                }
            }
            .onTapGesture {
                path.append(.addincomeview)
            }
    }
}

#Preview {
    IncomeView(path: .constant([]))
}
