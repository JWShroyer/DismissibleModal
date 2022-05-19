# Dismissible Modals
## Motivation
In SwiftUI Navigation, if you want to present a modal screen, there are a couple of options. We have the `sheet` and `fullScreenCover` modifiers that take in a `Binding` of some kind and any content you'd like to show in the new modal screen.

When the modal is dismissed, it will automatically assign the `Binding` provided to `false` or `nil` depending on which overload was used.

Conversely, the `Binding` can be programmatically assigned to `false` or `nil` to dismiss the presented modal flow.

Apple has also provided a couple `Environment` values to programmatically dismiss the view including `presentationMode` (which is now deprecated) and `dismiss` (which is the replacement as of this writing). The problem with these environment values is that they can only dismiss the top-most screen and it can't be used to dismiss an entire modal flow.

If your application or your designers have need for a "Close" button on each screen in a modal navigation flow, there doesn't seem to be a great built-in solution for this situation.

## A Solution
There may be better ways to accomplish the use-case above, but one way my team and I found ourselves leaning often is through the usage of Environment keys as well.

I decided to write something up that may be a bit more general purpose and avoid the need to provide the environment inside the `sheet` and `fullScreenCover` modifier content block.

In this project, you will find additional modifiers that have the same overloads as Apple's built-in modifiers for both `sheet` and `fullScreenCover` and I've named them `dismissibleSheet` and `dismissibleFullScreenCover` appropriately.

These two new modifiers wrap the provided content in either a `DismissibleModalModifier` or `ItemDismissibleModalModifier` depending on which overload was used. These objects simply provide a way to set the provided `Binding` to `false` or `nil` respectively.


### Examples

Here's an example of using the new modifier:
```swift
@State private var showModal = false

var body: some View {
  VStack {
    // ...
  }
  .dismissibleSheet(isPresented: $showModal) {
    ModalView()
  }
}
```

From a Modal View usage standpoint, you can opt into using the newly-provided Environment as follows:
```swift
@Environment(\.dismissModal)
private var dismissModal
```

And you can call it like a function similarly to how `dismiss` (and `DismissAction`) is implemented.

```swift
var body: some View {
  // ...

  Button("Dismiss Modal") {
    dismissModal()
  }

  // ...
}
```

Using the above, you can dismiss entire modal flows programmatically

## Where does it fall down?
While the above works, it can have issues if you need to present another modal flow over top of the existing modal flow. The issue is only present if the second modal flow does not use the above newly-added modifiers. 

i.e. Mixing the above custom modifiers with the built-in modifiers during the same presentation state

As far as I can tell, it works well when you only use the above modifiers, but I understand that's not possible in all use-cases. For instance, if you have your SwiftUI navigation split across modules.