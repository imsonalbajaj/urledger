//
//  ExpensesView.swift
//  yourLedger
//
//  Created by Sonal on 14/02/25.
//

import SwiftUI
import Charts

struct ExpensesView: View {
    @Binding var path: [AppScreen]
    @Environment(\.incomeModelContext) private var incomeContext
    @State private var incomes: [Income] = []
    @State private var rotationAngle: Angle = .degrees(0)
    @State private var selectedDate: DateKind = .currMonth
    
    var body: some View {
        List {
            Text("Showing: \(selectedDate.titleString.capitalized)")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            incomeChart
            
            incomesTransactionsView
        }
        .listStyle(.plain)
        .overlay(alignment: .bottomTrailing) {
            addBtn
        }
        .navigationTitle("Your Income")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    ForEach(DateKind.allCases) { date in
                        Button {
                            selectedDate = date
                            updateIncomeView()
                        } label: {
                            Text(date.titleString)
                        }
                    }
                } label: {
                    Image.getImg(.system(.line3horizontaldecrease))
                }
            }
        }
        .task {
            updateIncomeView()
        }
    }
    
    var incomesTransactionsView: some View {
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
        .padding()
        .background{
            Color(.systemBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 6.0))
        .padding(6)
        .background {
            Color(.secondarySystemBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 6.0))
        
    }
    
    var addBtn: some View {
        Image.getImg(.system(.pluscirclefill))
            .resizable()
            .font(.system(size: 40, weight: .light))
            .frame(width: 40, height: 40)
            .foregroundStyle(Color(uiColor: .systemBackground))
            .background(Color.primary)
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
    
    func updateIncomeView() {
        guard let context = incomeContext else { return }
        incomes = TransactionFilterManager.getUpdateIncome(context: context, selectedDate: selectedDate)
    }
}
