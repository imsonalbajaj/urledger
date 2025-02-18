//
//  AddIncomeView.swift
//  yourLedger
//
//  Created by Sonal on 18/02/25.
//

import SwiftUI

struct AddIncomeView : View {
    @State var amount: String = ""
    var body: some View {
        ZStack{
            Color.secondary
                .ignoresSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                
                TextField("Add your income here", text: $amount)
                    .padding(16)
                    .frame(width: .infinity, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    .background(Color.white.opacity(1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Spacer().frame(height: 10)
                
                Text("sources: ")
                
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Image(systemName: "square")
                        Text("income")
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "square")
                        Text("interest")
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "square")
                        Text("divident and stocks")
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "square")
                        Text("others..")
                    }
                }
                .foregroundStyle(Color.secondary)
                .padding(.horizontal)
                
                Spacer().frame(height: 10)
                
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
        .navigationTitle("Add Your income")
        
    }
}
