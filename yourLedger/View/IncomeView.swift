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
    @State private var selectedDate: DateKind = .currMonth
    
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                DatePickerView(selectedDate: $selectedDate)
            }
        }
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
}

enum DateKind: Int, CaseIterable, Identifiable {
    case currMonth
    case prevMonth
    case last3Months
    case thisYear
    case alltime

    var id: Int { self.rawValue }
    
    var titleString: String {
        switch self {
        case .currMonth:
            return "curr month"
        case .prevMonth:
            return "prev month"
        case .last3Months:
            return "last three month"
        case .thisYear:
            return "this year"
        case .alltime:
            return "all time"
        }
    }
}

struct DatePickerView: View {
    @Binding var selectedDate: DateKind

    var body: some View {
        Picker("Select Period", selection: $selectedDate) {
            ForEach(DateKind.allCases) { date in
                Text(date.titleString).tag(date)
            }
        }
    }
}

#Preview {
    IncomeView(path: .constant([]))
}
