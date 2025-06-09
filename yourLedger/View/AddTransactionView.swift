//
//  AddTransactionView.swift
//  yourLedger
//
//  Created by Sonal on 09/06/25.
//

import SwiftUI
import SwiftData

struct AddTransactionView<SourceType: Hashable & CaseIterable & RawRepresentable, ModelType: PersistentModel>: View where SourceType.RawValue == String {
    @Environment(\.presentationMode) var presentationMode
    let context: ModelContext
    let title: String
    let buttonTitle: String
    @State var viewModel: AddTransactionViewModel<SourceType>
    let createModel: (Date, Int, String) -> ModelType

    @FocusState private var textFieldFocused: Bool
    @State private var onAppearCalled = false

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea(.all)

            VStack(alignment: .leading, spacing: 0) {
                Spacer()

                TextField("Enter amount", text: $viewModel.amount)
                    .focused($textFieldFocused)
                    .keyboardType(.numberPad)
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.bottom, 20)

                Text("Sources:")
                    .foregroundStyle(Color.secondary)
                    .padding(.bottom, 12)

                VStack(alignment: .leading, spacing: 4) {
                    ForEach(viewModel.imageSources, id: \.self) { source in
                        HStack(spacing: 4) {
                            Image.getImg(.system(viewModel.source == source ? .checkmarksquarefill : .square))
                            Text(source.rawValue.capitalized)
                        }
                        .foregroundStyle(viewModel.source == source ? Color.primary : Color.secondary)
                        .font(.body)
                        .onTapGesture {
                            viewModel.source = source
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 20)

                Spacer()

                Button {
                    if viewModel.save(using: context, createModel: createModel) {
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text(buttonTitle)
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
        .navigationTitle(title)
        .onAppear {
            if !onAppearCalled {
                textFieldFocused = true
                onAppearCalled = true
            }
        }
        .onTapGesture {
            textFieldFocused = false
        }
        .onChange(of: viewModel.amount) { oldVal, newVal in
            if !viewModel.validateAmount() {
                viewModel.amount = oldVal
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showInvalidAmountAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}
