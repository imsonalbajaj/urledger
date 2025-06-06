//
//  AddExpensesView.swift
//  yourLedger
//
//  Created by Sonal on 06/06/25.
//

import SwiftUI

struct AddExpensesView : View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.expenseModelContext) private var expenseModelContext
    
    @State var viewModel = AddExpenseViewModel()
    @FocusState var textFieldFocued: Bool
    @State var onappearcalled = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                TextField("Add your expense here", text: $viewModel.amount)
                    .focused($textFieldFocued)
                    .keyboardType(.numberPad)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.bottom, 20)
                
                Text("sources: ")
                    .foregroundStyle(Color.secondary)
                    .padding(.bottom, 12)
                
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(ExpenseSource.allCases, id: \.self) { source in
                        HStack(spacing: 4) {
                            Image.getImg(.system(viewModel.expenseSource == source ? .checkmarksquarefill : .square))
                            Text(source.getTitleString())
                        }
                        .foregroundStyle(viewModel.expenseSource == source ? Color.primary :  Color.secondary)
                        .font(.body)
                        .onTapGesture {
                            viewModel.expenseSource = source
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 20, trailing: 8))
                
                Spacer()
                
                Button {
                    saveExpense()
                } label: {
                    Text("Add to your expense")
                        .foregroundStyle(Color.white)
                        .padding(16)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                }
                .padding(.horizontal, 50)
                
                Spacer()
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
        }
        .navigationTitle("Add Your Expense")
        .onAppear {
            if !onappearcalled {
                textFieldFocued = true
                onappearcalled = true
            }
        }
        .onTapGesture {
            textFieldFocued = false
        }
        .onChange(of: viewModel.amount) { oldval, newval in
            let isValid = viewModel.validateAmount()
            if !isValid {
                viewModel.amount = oldval
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showInvalidAmountAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    func saveExpense() {
        if let expenseModelContext, viewModel.saveExpense(using: expenseModelContext) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}


struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        AddExpensesView().preferredColorScheme(.light)
    }
}
