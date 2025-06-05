//
//  AddIncomeViewModel.swift
//  yourLedger
//
//  Created by Sonal on 05/06/25.
//

import SwiftUI
import SwiftData

@Observable
class AddIncomeViewModel {
    var incomeSource: IncomeSource = .income
    var amount: String = ""
    var showInvalidAmountAlert = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    let imageSources: [IncomeSource] = [.income, .interest, .dividentandstocks, .other]
    
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
    
    func addToIncomeValidate() -> Bool {
        if let amount = Double(amount), amount >= 10 {
            return true
        }
        showValidationAlert(message: "Please enter a minimal amount.")
        return false
    }
    
    func saveIncome(using context: ModelContext) -> Bool {
        guard addToIncomeValidate() else { return false }
        let newIncome = Income(timestamp: Date(),
                               amount: Int(amount) ?? 0,
                               source: incomeSource.rawValue)
        
        context.insert(newIncome)
        do {
            try context.save()
            amount = ""
            
            let incomes = try context.fetch(FetchDescriptor<Income>())
            print("Total incomes after save: \(incomes.count)")
            
            return true
        } catch {
            print("Error saving income: \(error)")
            return false
        }
    }
    
    func showValidationAlert(message: String) {
        alertTitle = "Invalid Amount"
        alertMessage = message
        showInvalidAmountAlert = true
    }
}
