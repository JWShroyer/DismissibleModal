//
//  ContentView.swift
//  DismissibleModal
//
//  Created by Joshua Shroyer on 5/19/22.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case one
    case two
    
    var id: String {
        switch self {
            case .one: return "one"
            case .two: return "two"
        }
    }
}

struct ContentView: View {
    @State private var showModal = false
    @State private var activeSheet: ActiveSheet? = nil
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Hello, world!")
                .padding()
            
            Button("Show Sheet") {
                showModal.toggle()
            }
            .padding()
            
            Button("Show Full Screen Cover") {
                activeSheet = .one
            }
            .padding()
        }
        .dismissibleSheet(isPresented: $showModal, onDismiss: onDismiss) {
            ModalView()
        }
        .dismissibleFullScreenCover(item: $activeSheet, onDismiss: onDismiss) { item in
            switch item {
            case .one:
                ModalView(input: "One")
            case .two:
                ModalView(input: "Two")
            }
        }
    }
    
    func onDismiss() {
        print("ON_DISMISS")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
