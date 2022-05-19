//
//  PushedModalView.swift
//  DismissibleModal
//
//  Created by Joshua Shroyer on 5/19/22.
//

import SwiftUI

struct PushedModalView: View {
    
    @Environment(\.dismissModal)
    private var dismissModal
    
    @State private var showModal = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("Hello, pushed!")
                    .padding()
                
                Button("Present New Flow") {
                    showModal.toggle()
                }
                .padding()
                
                Button("Dismiss Modal") {
                    dismissModal()
                }
                .padding()
            }
            .navigationTitle("Pushed")
            .addNavigationCloseButton()
            .dismissibleSheet(isPresented: $showModal) {
                ModalView()
            }
        }
    }
}

struct PushedModalView_Previews: PreviewProvider {
    static var previews: some View {
        PushedModalView()
    }
}
