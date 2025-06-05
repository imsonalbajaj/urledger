//
//  AddIncomeViewModel.swift
//  yourLedger
//
//  Created by Sonal on 05/06/25.
//

import SwiftUI

@Observable
class AddIncomeViewModel {
    var incomeSource: IncomeSouce = .income
    var amount: String = ""
    var showInvalidAmountAlert = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    let imageSources: [IncomeSouce] = [.income, .interest, .dividentandstocks, .other]
    
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
    
    func addToYourIncome() -> Bool {
        if let amount = Double(amount), amount >= 10 {
            return true
        }
        showValidationAlert(message: "Please enter a minimal amount.")
        return false
    }
    
    func showValidationAlert(message: String) {
        alertTitle = "Invalid Amount"
        alertMessage = message
        showInvalidAmountAlert = true
    }
}
