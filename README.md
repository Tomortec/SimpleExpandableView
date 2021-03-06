# SimpleExpandableView

<img src="./screenshot.png" alt="Banner" width="400">

[中文说明](./README-zh.md)

<img src="./demo.gif" alt="Demo" width="200"> 

## ExpandableView structure
<img src="./pic-structure.png" alt="Structure" width="400">

## Example

``` Swift
ExpandableView(
    headerSize: CGSize(width: 250.0, height: 50.0),
    cardSize: CGSize(width: 250.0, height: 250.0), header: {
        Text("Hello world")
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom))
    }, content: {
        VStack {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 180, height: 180)
            Text("Hi")
                .font(.title2)
        }
        .foregroundColor(.white)
    })
.cardBackgroundColor(.cyan)
.shadow(shadowRadius: 0.0)
.listRowSeparator(.hidden)
.frame(maxWidth: .infinity) // align center
.padding(.vertical, 5.0)
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## ExpandableView Interfaces
### Initialization
``` swift
init(
    headerSize: CGSize,
    cardSize: CGSize,
    @ViewBuilder header: () -> Header,
    @ViewBuilder content: () -> Content,
    onTapped action: (() -> ())? = nil // action to do when the header view is tapped
)
```

### Methods
``` swift
// Change the background color of header view
func headerBackgroundColor(_ color: Color)

// Change the background color of the card view
func cardBackgroundColor(_ color: Color)

// Change the corner radius of the header view
func headerCornerRadius(_ radius: CGFloat)

// Change the corner radius of the card view
func cardCornerRadius(_ radius: CGFloat)

// Change the shadow of the whole view (both header view and card view will render shadow)
func shadow(shadowRadius: CGFloat = 6.0, color: Color = .gray, x: CGFloat = 0.0, y: CGFloat = 0.0)

// Determine the height of the card view by the `contentView` you passed instead of a fixed height
func dynamicCardHeight()
```

## ExpandableViewsGroup Interfaces
### Initialization
``` swift
// Share the same `headerView`
init<Header>(
    headerSize: CGSize,
    cardSize: CGSize,
    headerView:  () -> Header,
    contentViews: () -> [AnyView]
) where Header : View

// Using generics
init<Header, Content>(
    headerSize: CGSize,
    cardSize: CGSize,
    headerViews:  () -> [Header],
    contentViews: () -> [Content]
)  where Header : View, Content : View

// Using AnyView array
init(
    headerSize: CGSize,
    cardSize: CGSize,
    headerViews:  () -> [AnyView],
    contentViews: () -> [AnyView]
)

// Using variadic parameters
init(
    headerSize: CGSize,
    cardSize: CGSize,
    headerViews:  AnyView...,
    contentViews: AnyView...
)
```

### Methods
``` swift
// Set the vertical spacing between two `ExpandableView`
func verticalSpacing(_ spacing: CGFloat)

// Change the background color of the group
func backgroundColor(_ color: Color)

// Change the background color of all header views
func headersBackgroundColor(_ color: Color)

// Change the background color of all card views
func cardBackgroundColor(_ color: Color)

// Change the corner radius of all header views
func headerCornerRadius(_ radius: CGFloat)

// Change the corner radius of all card views
func cardCornerRadius(_ radius: CGFloat)

// Change the shadow of all views in the group (header views and card views included)
func shadow(shadowRadius: CGFloat = 6.0, color: Color = .gray, x: CGFloat = 0.0, y: CGFloat = 0.0)

// Set all `ExpandableView` in the group with `.dynamicCardHeight()`
func dynamicCardHeight()
```

Execute Xcode's `Product > Build Documentation` and go to `SimpleExpandableView`'s documentation for more details.

## Requirements

Swift >= 5.0

## Installation

SimpleExpandableView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SimpleExpandableView'

# Note that if cocoapods cannot find `SimpleExpandableView`, please try the command below
# pod `SimpleExpandableView`, :git => 'https://github.com/Tomortec/SimpleExpandableView.git'
```

## Author

Tomortec, everything@tomortec.com

## License

SimpleExpandableView is available under the MIT license. See the LICENSE file for more info.
