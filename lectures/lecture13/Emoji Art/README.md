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
```PaletteEditor``` have a whole bunch of stuff for editing the palette.<br/>



Add ```PaletteEditor``` view on ```PaletteChooser``` through ```.sheet``` modifier.

<br/>

### `.sheet`

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

<br/>

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

<br/>

<br/>

### `TextField`


```TextField``` makes text editable. It has two arguments.
One is a kind of placeholder or a word that can help the user understand what the field is asking for here.
And then a second argument called "text", with is the actual text that's being edited inside this text field.
<br/>

```swift
  Form {
    Section(header: Text("Name")) {
      TextField("Name", text: palette.name)
    }
    Section(header: Text("Emojis")) {
      Text("Add Emojis Here")
        .font(emojiFont)
      removeEmojis
    }
  }
  .frame(minWidth: 300, minHeight: 350)
}
```
<br/>

The `TextField` knows that it doesn't want to hold a copy of what's being edited. It wants to edit that thing directly.
So it request you to give a binding to that source of truth. And the source of truth for `palette.name` is in ViewModel, `PaletteStore`.<br/>
By making `palette` an `@Binding`, it forces whoever creates the `PaletteEditor` to give us a binding to the source of truth.
<br/><br/>

```swift
struct PaletteEditor: View {
  @Binding var palette: Palette
  
  private let emojiFont = Font.system(size: 40)
  
  var body: some View {
    // Form is an extremely powerful VStack-like thing
    // for when you want to collect information from the user.
    Form {
      Section(header: Text("Name")) {
        TextField("Name", text: $palette.name)
      }
      Section(header: Text("Emojis")) {
        Text("Add Emojis Here")
          .font(emojiFont)
        removeEmojis
      }
    }
    .frame(minWidth: 300, minHeight: 350)
  }
```

The `$`, projected value of a binding, is another binding to that binding. So `$Palette.name` means a binding to the binding to `Palette` which is going to be bound all the way back to our ViewModel.
<br/>

Modify `.sheet` view to refer the true `store`.

```swift
  .sheet(isPresented: $showPaletteEditor) {
    PaletteEditor(palette: $store.palettes[store.cursorIndex])
      .font(nil)
  }
```

<br/>
<br/>

### `FocusState`

`FocusState` keeps track of which of the `TextField`s has the focus of the keyboard.<br/>
Oftentimes, this is a bool because you'll only have one `TextField` and it's either focus or not.<br/>
Since we have two TextFields, make focused be little `Enum`.<br/>
It has to be optional because neither of them might be focused.<br/>

```swift
 // PaletteEditor.swift
 
 enum Focused {
   case name
   case addEmojis
 }
 
 @FocusState private var focused: Focused?

 Section(header: Text("Name")) {
   TextField("Name", text: $palette.name)
     .focused($focused, equals: .name)
 }
```

<br/>
Using this `.focused` modifier, it tells the system which thing to set to what when TextField becomes focused and vice versa.
