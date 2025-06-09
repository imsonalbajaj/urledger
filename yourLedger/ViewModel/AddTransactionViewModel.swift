//
//  AddTransactionViewModel.swift
//  yourLedger
//
//  Created by Sonal on 09/06/25.
//

import SwiftUI
import SwiftData

@Observable
class AddTransactionViewModel<SourceType: Hashable & CaseIterable & RawRepresentable> where SourceType.RawValue == String {
    var source: SourceType
    var amount: String = ""
    var showInvalidAmountAlert = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    let imageSources: [SourceType]

    init(defaultSource: SourceType) {
        self.source = defaultSource
        self.imageSources = Array(SourceType.allCases)
    }

    func validateAmount() -> Bool {
        guard !amount.isEmpty else { return false }
        let isNumeric = amount.allSatisfy { "0123456789".contains($0) }
        if !isNumeric {
            showValidationAlert(message: "Amount must be numeric.")
            return false
        }

        if let value = Double(amount), value < 10_000_000 {
            return true
        } else {
            showValidationAlert(message: "Amount must be less than 1 crore.")
            return false
        }
    }

    func addValidation() -> Bool {
        if let value = Double(amount), value >= 10 {
            return true
        }
        showValidationAlert(message: "Please enter a minimal amount.")
        return false
    }

    func save<T: PersistentModel>(using context: ModelContext, createModel: (Date, Int, String) -> T) -> Bool {
        guard addValidation() else { return false }
        let model = createModel(Date(), Int(amount) ?? 0, source.rawValue)
        context.insert(model)

        do {
            try context.save()
            amount = ""
            return true
        } catch {
            print("Error saving model: \(error)")
            return false
        }
    }

    private func showValidationAlert(message: String) {
        alertTitle = "Invalid Amount"
        alertMessage = message
        showInvalidAmountAlert = true
    }
}
