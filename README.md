# ESSDynamicForm

Creating form as easy as calling API.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Supporting UI Elements

- UITextfield
    - number
    - text
- ImagePicker
- DatePicker
- UITextView

## Requirements

- iOS 9.0+
- Xcode 9

## Integration

#### CocoaPods (iOS 9.0+)

You can use [CocoaPods](http://cocoapods.org/) to install `ESSDynamicForm` by adding it to your `Podfile`:

```ruby
platform :ios, '9.0'
use_frameworks!

target 'ESSDynamicForm' do
    pod 'ESSDynamicForm', '~> 1.0'
end
```

## Usage

```python
import ESSDynamicForm
```

Programmatically
```python
let essForm = ESSDynamicForm(with: self, frame: view.frame, delegate: self)

essForm.setElements(with: formElementElements)
essForm.build()
```

Storyboard
#### Simply change class of UIView to ESSDynamicForm

```python

essForm.setElements(with: formElementElements)
essForm.setViewController(with: self)
essForm.build()
```

Please make sure to set viewController as base container.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
