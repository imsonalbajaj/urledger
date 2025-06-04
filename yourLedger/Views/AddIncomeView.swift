//
//  AddIncomeView.swift
//  yourLedger
//
//  Created by Sonal on 18/02/25.
//

import SwiftUI

enum IncomeSouce: String, Hashable {
    case income
    case interest
    case dividentandstocks
    case other
    
    func getTitleString() -> String {
        switch self {
        case .income:
            return "income"
        case .interest:
            return "interest"
        case .dividentandstocks:
            return "divident and stocks"
        case .other:
            return "others"
        }
    }
}

@Observable
class AddIncomeViewModel {
    var incomeSource: IncomeSouce? = .income
    var amount: String = ""
    var showInvalidAmountAlert = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    let imageSources: [IncomeSouce] = [.income, .interest, .dividentandstocks, .other]
}

struct AddIncomeView : View {
    @State var viewModel = AddIncomeViewModel()
    @FocusState var textFieldFocued: Bool
    
    var body: some View {
        ZStack{
            Color.secondary
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                TextField("Add your income here", text: $viewModel.amount)
                    .focused($textFieldFocued)
                    .keyboardType(.numberPad)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.bottom, 20)
                
                Text("sources: ")
                    .padding(.bottom, 12)
                
                
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(viewModel.imageSources, id: \.self) { source in
                        HStack(spacing: 4) {
                            Image.getImg(.system(viewModel.incomeSource == source ? .checkmarksquarefill : .square))
                            Text(source.getTitleString())
                        }
                        .onTapGesture {
                            viewModel.incomeSource = source
                        }
                    }
                }
                .foregroundStyle(Color.secondary)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 20, trailing: 8))
                
                Spacer()
                
                Button {
                    if let amount = Double(viewModel.amount), amount >= 10 {
                        
                    } else {
                        showAlertForMinimalAmount()
                    }
                } label: {
                    Text("Add to your income")
                        .foregroundStyle(Color.white)
                        .padding(16)
                        .frame(height: 40)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 50)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
        }
        .onTapGesture{
            textFieldFocued = false
        }
        .onChange(of: viewModel.amount) { oldval, newval in
            let filtered = newval.filter { "0123456789.".contains($0) }
            let decimalCount = filtered.filter { $0 == "." }.count
            
            if filtered != newval || decimalCount > 1 || newval.first == "." || (Double(newval) ?? 0) >= 100_000_000 {
                viewModel.amount = oldval
                
                showAlertForInvalidAmout()
            }
        }
        .navigationTitle(viewModel.alertTitle)
        .alert("Invalid Input", isPresented: $viewModel.showInvalidAmountAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    func showAlertForInvalidAmout() {
        viewModel.alertTitle = "Add Your income"
        viewModel.alertMessage = "Please enter a valid numeric amount."
        viewModel.showInvalidAmountAlert = true
    }
    
    func showAlertForMinimalAmount() {
        viewModel.alertTitle = "Amount"
        viewModel.alertMessage = "Please enter a minimal amount."
        viewModel.showInvalidAmountAlert = true
    }
}

#Preview {
    AddIncomeView()
}
