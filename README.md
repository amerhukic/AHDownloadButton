<p align="center">
<img src="https://raw.githubusercontent.com/amerhukic/AHDownloadButton/master/Logo.png" width="420" max-width="80%" alt="Logo" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-4.2-orange.svg" />
    <a href="https://cocoapods.org/pods/AHDownloadButton">
        <img src="https://img.shields.io/cocoapods/v/AHDownloadButton.svg?style=flat" alt="Pod Version">
    </a>
    <a href="">
        <img src="https://img.shields.io/badge/Licence-MIT-green.svg" alt="License">
    </a>
    <a href="https://twitter.com/hukicamer">
        <img src="https://img.shields.io/badge/contact-%40hukicamer-blue.svg?style=flat" alt="Twitter: @hukicamer" />
    </a>
</p>

**AHDownloadButton** is a customizable download button similar to the download button in the latest version of Apple's App Store app (since iOS 11).
It features download progress animation as well as animated transitions between download states: start download, pending, downloading and downloaded. [You can find more details about the implementation on my blog](https://amerhukic.com/replicating-app-store-download-button).

<p align="center"><img src="https://raw.githubusercontent.com/amerhukic/AHDownloadButton/master/Demo.gif"/>
</p>

## Requirements

- iOS 8.0+
- Xcode 9.0+
- Swift 4.0+

## Usage

### Code
To use `AHDownloadButton` in code, you simply create a new instance and add it as a subview to your desired view:
```swift
  let downloadButton = AHDownloadButton()
  downloadButton.frame = CGRect(origin: origin, size: size)
  view.addSubview(downloadButton)
```
The button can have 4 different states:
- `startDownload` - initial state before downloading
- `pending` - state for preparing for download
- `downloading` - state when the user is downloading
- `downloaded` - state when the user finished downloading

The state of the button can be changed through its `state` property.

### Delegate
You can use the `AHDownloadButtonDelegate` to monitor taps on the button and update button's state if needed. To update the current download progress, use the `progress` property. Here is an example how it could be implemented:  

```swift
extension DownloadViewController: AHDownloadButtonDelegate {

    func didTapDownloadButton(withCurrentState state: AHDownloadButton.State) {
        switch state {
        case .startDownload:

            // set the download progress to 0
            downloadButton.progress = 0

            // change state to pending and wait for download to start
            downloadButton.state = .pending

            // initiate download and update state to .downloading
            startDownloadingFile()

        case .pending:

            // button tapped while in pending state
            break

        case .downloading:

            // button tapped while in downloading state - stop downloading
            downloadButton.progress = 0
            downloadButton.state = .startDownload

        case .downloaded:

            // file is downloaded and can be opened
            openDownloadedFile()

        }
    }
}
```

### Customisation

`AHDownloadButton` can be customized. These are the properties that can be used for customizing the button:

1. Customization properties when button is in `startDownload` state:

  - `startDownloadButtonTitle` - button's title
  - `startDownloadButtonTitleFont` - button's title font
  - `startDownloadButtonTitleSidePadding` - padding for left and right side of button's title
  - `startDownloadButtonHighlightedBackgroundColor` - background color for the button when it's in highlighted state (when the user presses the button)
  - `startDownloadButtonNonhighlightedBackgroundColor` - background color for the button when it's in nonhighlighted state (when the button is not pressed)
  - `startDownloadButtonHighlightedTitleColor` - title color for the button when it's in highlighted state (when the user presses the button)
  - `startDownloadButtonNonhighlightedTitleColor` - title color for the button when it's in nonhighlighted state (when the button is not pressed)


2. Customization properties when button is in `pending` state:

  - `pendingCircleColor` - color of the pending circle
  - `pendingCircleLineWidth` - width of the pending circle


3. Customization properties when button is in `downloading` state:

  - `downloadingButtonHighlightedTrackCircleColor` - color for the track circle when it's in highlighted state (when the user presses the button)
  - `downloadingButtonNonhighlightedTrackCircleColor` - color for the track circle when it's in nonhighlighted state (when the button is not pressed)
  - `downloadingButtonHighlightedProgressCircleColor` - color for the progress circle when it's in highlighted state (when the user presses the button)
  - `downloadingButtonNonhighlightedProgressCircleColor` - color for the progress circle when it's in nonhighlighted state (when the button is not pressed)
  - `downloadingButtonHighlightedStopViewColor` - color for the stop view in the middle of the progress circle when it's in highlighted state (when the user presses the button)
  - `downloadingButtonNonhighlightedStopViewColor` - color for the stop view in the middle of the progress circle when it's in nonhighlighted state (when the button is not pressed)


4. Customization properties when button is in `downloaded` state:

  - `downloadedButtonTitle` - button's title
  - `downloadedButtonTitleFont` - button's title font
  - `downloadedButtonTitleSidePadding` - padding for left and right side of button's title
  - `downloadedButtonHighlightedBackgroundColor` - background color for the button when it's in highlighted state (when the user presses the button)
  - `downloadedButtonNonhighlightedBackgroundColor` - background color for the button when it's in nonhighlighted state (when the button is not pressed)
  - `downloadedButtonHighlightedTitleColor` - title color for the button when it's in highlighted state (when the user presses the button)
  - `downloadedButtonNonhighlightedTitleColor` - title color for the button when it's in nonhighlighted state (when the button is not pressed)
  
### Special note

`AHDownloadButton` in `startDownload` and `downloaded` states calculates its width based on **button title**. Use the `startDownloadButtonTitleSidePadding` and `downloadedButtonTitleSidePadding` properties to customise the width when the button is in the aforementioned states.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate AHDownloadButton into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'AHDownloadButton'
end
```

Then, run the following command:

```bash
$ pod install
```

## Author

[Amer Hukić](https://amerhukic.com)

## License

AHDownloadButton is licensed under the MIT license. Check the [LICENSE](LICENSE) file for details.
