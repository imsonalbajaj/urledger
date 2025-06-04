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
    var incomeSource: IncomeSouce?
    var amount: String = ""
}

struct AddIncomeView : View {
    @State var viewModel = AddIncomeViewModel()
    
    @FocusState var textFieldFocued: Bool
    let imageSources: [IncomeSouce] = [.income, .interest, .dividentandstocks, .other]
    
    @State private var showInvalidAmountAlert = false
    
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
                    ForEach(imageSources, id: \.self) { source in
                        HStack(spacing: 4) {
                            Image.getImg(.system(viewModel.incomeSource == source ? .checkmarksquarefill : .square))
                            Text(source.getTitleString())
                        }
                        .onTapGesture {
                            viewModel.incomeSource =  viewModel.incomeSource == source ? nil : source
                        }
                    }
                }
                .foregroundStyle(Color.secondary)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 20, trailing: 8))
                
                Spacer()
                
                Button {
                    
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
                showInvalidAmountAlert = true
            }
        }
        .navigationTitle("Add Your income")
        .alert("Invalid Input", isPresented: $showInvalidAmountAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please enter a valid numeric amount.")
        }
    }
}

#Preview {
    AddIncomeView()
}
