# MICountryPicker

MICountryPicker is a country picker controller for iOS8+ with an option to search. The list of countries is based on the ISO 3166 country code standard (http://en.wikipedia.org/wiki/ISO_3166-1). Also and the library includes a set of 250 public domain flag images from https://github.com/pradyumnad/Country-List.

## Screenshots

![alt tag](https://github.com/mustafaibrahim989/MICountryPicker/blob/master/screen1.png) ![alt tag](https://github.com/mustafaibrahim989/MICountryPicker/blob/master/screen2.png) ![alt tag](https://github.com/mustafaibrahim989/MICountryPicker/blob/master/screen3.png)

## Installation

MICountryPicker is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:
    
    # Swift 3
    use_frameworks!
    pod 'MICountryPicker', :git => 'https://github.com/mustafaibrahim989/MICountryPicker.git', :branch => 'master'
    
    # Swift 2
    use_frameworks!
    pod 'MICountryPicker', :git => 'https://github.com/mustafaibrahim989/MICountryPicker.git', :branch => 'swift-2'

Show MICountryPicker from UIViewController

```swift

let picker = MICountryPicker()
navigationController?.pushViewController(picker, animated: true)

```
## MICountryPickerDelegate protocol

```swift

// delegate
picker.delegate = self

// Optionally, set this to display the country calling codes after the names
picker.showCallingCodes = true

```

```swift

func countryPicker(picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
        print(code)
}

func countryPicker(picker: MICountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        print(dialCode)
}
```

## Closure

```swift

// or closure
picker.didSelectCountryClosure = { name, code in
        print(code)
}

picker.didSelectCountryWithCallingCodeClosure = { name, code, dialCode in
        print(dialCode)
}

```

## Author

Mustafa Ibrahim, mustafa.ibrahim989@gmail.com

Notes
============

Designed for iOS 8+.

## License

MICountryPicker is available under the MIT license. See the LICENSE file for more info.
