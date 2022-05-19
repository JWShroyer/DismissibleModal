//
//  ModalView.swift
//  DismissibleModal
//
//  Created by Joshua Shroyer on 5/19/22.
//

import SwiftUI

struct ModalView: View {
    
    @Environment(\.dismissModal)
    private var dismissModal

    var input = "Default"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    Text("Hello, modal! - \(input)")
                        .padding()
                    
                    NavigationLink(
                        "Push Next",
                        destination: { PushedModalView() }
                    )
                    .padding()
                    
                    Button("Dismiss Modal") {
                        dismissModal()
                    }
                    .padding()
                }
                .navigationTitle("Modal")
                .addNavigationCloseButton {
                    print("ON_CLOSE")
                }
            }
        }
    }
}


struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
