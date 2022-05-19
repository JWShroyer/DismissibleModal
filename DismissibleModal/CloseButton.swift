//
//  CloseButton.swift
//  DismissibleModal
//
//  Created by Joshua Shroyer on 5/19/22.
//

import SwiftUI

extension View {
    func addNavigationCloseButton(onClose: (() -> Void)? = nil) -> some View {
        self.toolbar {
            ToolbarItem(placement: .destructiveAction) {
                CloseButton(onClose: onClose)
            }
        }
    }
}

struct CloseButton: View {
    @Environment(\.dismissModal)
    private var dismissModal
    
    private let onClose: (() -> Void)?
    
    init(onClose: (() -> Void)? = nil) {
        self.onClose = onClose
    }
    
    var body: some View {
        Button {
            onClose?()
            dismissModal()
        } label: {
            Image(systemName: "xmark")
                .accessibilityLabel("Close")
        }
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
