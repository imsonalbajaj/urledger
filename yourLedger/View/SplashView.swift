//
//  SplashView.swift
//  yourLedger
//
//  Created by Sonal on 04/06/25.
//

import SwiftUI

struct SplashView: View {
    @State var iconShown = false
    @Binding var ourAppState: OurAppState
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(uiColor: UIColor.systemBackground))
                .ignoresSafeArea(.all)
            
            if iconShown {
                Text(rupeeIcon)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.primary)
                    .transition(.scale)
            }
        }
        .task {
            withAnimation {
                iconShown = true
            }
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            ourAppState = .foreground
        }
    }
}
