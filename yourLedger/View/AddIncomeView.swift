//
//  AddIncomeView.swift
//  yourLedger
//
//  Created by Sonal on 18/02/25.
//

import SwiftUI

struct AddIncomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.incomeModelContext) private var incomeModelContext
    
    @State var viewModel = AddIncomeViewModel()
    @FocusState var textFieldFocued: Bool
    @State var onappearcalled = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                TextField("Add your income here", text: $viewModel.amount)
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
                    ForEach(viewModel.imageSources, id: \.self) { source in
                        HStack(spacing: 4) {
                            Image.getImg(.system(viewModel.incomeSource == source ? .checkmarksquarefill : .square))
                            Text(source.getTitleString())
                        }
                        .foregroundStyle(viewModel.incomeSource == source ? Color.primary :  Color.secondary)
                        .font(.body)
                        .onTapGesture {
                            viewModel.incomeSource = source
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 20, trailing: 8))
                
                Spacer()
                
                Button {
                    saveIncome()
                } label: {
                    Text("Add to your income")
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
        .navigationTitle("Add Your income")
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
    
    func saveIncome() {
        if let incomeModelContext, viewModel.saveIncome(using: incomeModelContext) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddIncomeView().preferredColorScheme(.dark)
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        AddIncomeView().preferredColorScheme(.light)
    }
}
*/
