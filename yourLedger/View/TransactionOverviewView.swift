//
//  TransactionOverviewView.swift
//  yourLedger
//
//  Created by Sonal on 09/06/25.
//

import SwiftUI
import SwiftData
import Charts

struct TransactionOverviewView<SourceType: RawRepresentable & Hashable, ModelType: PersistentModel & Identifiable>: View where SourceType.RawValue == String {
    @Binding var path: [AppScreen]
    let title: String
    let destinationScreen: AppScreen
    let context: ModelContext?
    let fetch: (ModelContext, DateKind) -> [ModelType]
    let getAmount: (ModelType) -> Int
    let getDate: (ModelType) -> Date
    let getSource: (ModelType) -> String
    let getSourceLabel: (String) -> String

    @State private var models: [ModelType] = []
    @State private var rotationAngle: Angle = .degrees(0)
    @State private var selectedDate: DateKind = .currMonth

    var body: some View {
        List {
            Text("Showing: \(selectedDate.titleString.capitalized)")
                .font(.caption)
                .foregroundStyle(.secondary)

            if !models.isEmpty {
                chart
                transactionList
            }
        }
        .listStyle(.plain)
        .overlay(alignment: .bottomTrailing) {
            addBtn
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    ForEach(DateKind.allCases) { date in
                        Button {
                            selectedDate = date
                            updateView()
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
            updateView()
        }
    }

    var transactionList: some View {
        ForEach(models) { model in
            VStack(alignment: .leading) {
                Text("Amount: ₹\(getAmount(model))")

                Text(getSourceLabel(getSource(model)))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("Date: \(getDate(model).formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
    }

    var chart: some View {
        Chart(models) { model in
            SectorMark(
                angle: .value("Amount", getAmount(model)),
                innerRadius: .ratio(0.6),
                angularInset: 8
            )
            .foregroundStyle(
                by: .value("Source", getSource(model))
            )
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 6.0))
        .padding(6)
        .background(Color(.secondarySystemBackground))
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
                path.append(destinationScreen)
            }
    }

    func updateView() {
        guard let context else { return }
        models = fetch(context, selectedDate)
    }
}
