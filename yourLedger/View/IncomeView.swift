//
//  IncomeView.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI
import Charts
import SwiftData

struct IncomeView: View {
    @Binding var path: [AppScreen]
    @Environment(\.incomeModelContext) private var incomeContext
    @State private var incomes: [Income] = []
    @State private var rotationAngle: Angle = .degrees(0)
    
    var body: some View {
        List {
            incomeChart
            
            ForEach(incomes) { income in
                VStack(alignment: .leading) {
                    Text("Amount: ₹\(income.amount)")
                    
                    if let kind = IncomeSource(rawValue: income.source) {
                        Text(kind.getTitleString())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Text("Date: \(income.timestamp.formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
        }
        .listStyle(.plain)
        .overlay(alignment: .bottomTrailing) {
            addBtn
        }
        .navigationTitle("Your Income")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                incomes = try incomeContext?.fetch(FetchDescriptor<Income>(sortBy: [SortDescriptor(\Income.timestamp, order: .reverse)])) ?? []
            } catch {
                print("Error fetching income: \(error)")
            }
        }
    }
    
    var incomeChart: some View {
        Chart(incomes) { income in
            SectorMark(
                angle: .value("Amount", income.amount),
                innerRadius: .ratio(0.6),
                angularInset: 8
            )
            .foregroundStyle(
                by: .value("Source", income.source)
            )
        }
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
