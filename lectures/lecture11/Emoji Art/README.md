#  Lecture 11

## ```@escaping```

<br/>

```swift
struct AnimatedActionButton: View {
    ...
    let action: () -> Void
    
    init(_ title: String? = nil,
         systemImage: String? = nil,
         role: ButtonRole? = nil,
         action: @escaping () -> Void
    ) {
      ...
    }
    
    ...
}
```

This function, init, is going to hold on to that closure and call it later, so it "escapes" from this init.
<br/>
Why does Swift want to know that? Because it's going to inline closures that can't escape, inline some words.
