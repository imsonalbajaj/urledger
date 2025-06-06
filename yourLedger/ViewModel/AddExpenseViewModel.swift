//
//  AddExpenseViewModel.swift
//  yourLedger
//
//  Created by Sonal on 06/06/25.
//

import SwiftUI
import SwiftData

@Observable
class AddExpenseViewModel {
    var expenseSource: ExpenseSource = .food
    var amount: String = ""
    var showInvalidAmountAlert = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    let imageSources: [ExpenseSource] = ExpenseSource.allCases
    
    func validateAmount() -> Bool {
        guard !amount.isEmpty else {
            return false
        }
        
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
    
    func addToExpenseValidate() -> Bool {
        if let amount = Double(amount), amount >= 10 {
            return true
        }
        showValidationAlert(message: "Please enter a minimal amount.")
        return false
    }
    
    func saveExpense(using context: ModelContext) -> Bool {
        guard addToExpenseValidate() else { return false }
        let newExpense = Expense(timestamp: Date(),
                                 amount: Int(amount) ?? 0,
                                 source: expenseSource.rawValue)

        context.insert(newExpense)
        do {
            try context.save()
            amount = ""

            let expenses = try context.fetch(FetchDescriptor<Expense>())
            print("Total expenses after save: \(expenses.count)")

            return true
        } catch {
            print("Error saving expense: \(error)")
            return false
        }
    }
    
    func showValidationAlert(message: String) {
        alertTitle = "Invalid Amount"
        alertMessage = message
        showInvalidAmountAlert = true
    }
}
