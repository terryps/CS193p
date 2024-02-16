#  Lecture 13

Big Demo
  + ```.sheet```
  + ```.popover```
  + ```@Binding```
  + ```TextField```
  + Form List Section
  + ```.toolbar```
  + ```@FocusState```
  + ```NavigationStack```/```SplitView``` + ```NavigationLink``` + ```.navigationDestination(for:)```
  + Deleting/moving items in a ```ForEach``` with ```.onDelete``` / ```.onMove```

<br/><br/>

```swift
  private var gotoMenu: some View {
    Menu {
      ForEach(store.palettes) { palette in
        AnimatedActionButton(palette.name) {
          if let index = store.palettes.firstIndex(where: { $0.id == palette.id }) {
            store.cursorIndex = index
          }
        }
      }
    } label: {
      Label("Go To", systemImage: "text.inset")
    }
  }
```
