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


## ```PaletteEditor``` View
```PaletteEditor``` have a whole bunch of stuff for editing the palette.
Add this view 

### ```.sheet```

```sheet(isPresented:)``` presents a sheet when a binding to a Boolean value that you provide is true.

```swift
struct PaletteChooser: View {
  @EnvironmentObject var store: PaletteStore
  
  @State private var showPaletteEditor = false
  
  var body: some View {
    HStack {
      chooser
      view(for: store.palettes[store.cursorIndex])
    }
    .clipped()
    .sheet(isPresented: $showPaletteEditor) {
      // It's a ViewBuilder.
      PaletteEditor()
    }
  }
  
  private var chooser: some View {
    AnimatedActionButton(systemImage: "paintpalette") {
      store.cursorIndex += 1
    }
    .contextMenu {
      ...
      AnimatedActionButton("Edit", systemImage: "pencil") {
        showPaletteEditor = true
      }
    }
  }
  
  ...
}
```

There's another way to put something up on screen, which is a "```popover```".

### ```popover(isPresented:)```
This modifier presents a popover when a given condition is true.
Kind of like a sheet, but it's not huge. It points to whatever it's modifying or whatever the context is.
<br/>
If you have something that's very context-specific, like, it wants to point at the button that brought it up or some piece of text, you can use a ```popover```.

<br/>
```swift
  var body: some View {
    HStack {
      chooser
        .popover(isPresented: $showPaletteEditor) {
          PaletteEditor()
         }
      view(for: store.palettes[store.cursorIndex])
    }
    .clipped()
```
