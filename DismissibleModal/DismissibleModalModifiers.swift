//
//  DismissibleModalModifiers.swift
//  DismissibleModal
//
//  Created by Joshua Shroyer on 5/19/22.
//

import SwiftUI

// MARK: - Modifiers
extension View {
    func dismissibleSheet<Item: Identifiable, Content: View>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        self.sheet(item: item, onDismiss: onDismiss) { unwrappedItem in
            ItemDismissibleModalModifier(item: item, content: { content(unwrappedItem) })
        }
    }
    
    func dismissibleSheet<Content: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.sheet(isPresented: isPresented, onDismiss: onDismiss) {
            DismissibleModalModifier(isPresented: isPresented, content: content)
        }
    }
    
    func dismissibleFullScreenCover<Item: Identifiable, Content: View>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        self.fullScreenCover(item: item, onDismiss: onDismiss) { unwrappedItem in
            ItemDismissibleModalModifier(item: item, content: { content(unwrappedItem) })
        }
    }
    
    func dismissibleFullScreenCover<Content: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.fullScreenCover(isPresented: isPresented, onDismiss: onDismiss) {
            DismissibleModalModifier(isPresented: isPresented, content: content)
        }
    }
}

// MARK: - Environment
struct DismissModalAction {
    private let action: () -> Void
    
    fileprivate init(action: @escaping () -> Void) {
        self.action = action
    }
    
    func callAsFunction() {
        action()
    }
}

private struct DismissModal: EnvironmentKey {
    static let defaultValue = DismissModalAction(action: {})
}

extension EnvironmentValues {
    var dismissModal: DismissModalAction {
        get { self[DismissModal.self] }
        set { self[DismissModal.self] = newValue }
    }
}

// MARK: - Wrapper Types

private struct ItemDismissibleModalModifier<Item: Identifiable, Content: View>: View {

    @Binding
    var item: Item?

    let content: () -> Content

    var body: some View {
        content()
            .environment(\.dismissModal, DismissModalAction(action: {
                item = nil
            }))
    }
}

private struct DismissibleModalModifier<Content: View>: View {
    @Binding
    var isPresented: Bool

    let content: () -> Content

    var body: some View {
        content()
            .environment(\.dismissModal, DismissModalAction(action: {
                isPresented = false
            }))
    }
}
