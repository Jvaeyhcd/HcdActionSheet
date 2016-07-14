HcdActionSheet
------
![License](https://img.shields.io/cocoapods/l/TWPhotoPicker.svg)
![Platform](https://img.shields.io/cocoapods/p/TWPhotoPicker.svg)
A custom ActionSheet.

![图片](https://raw.githubusercontent.com/Jvaeyhcd/HcdActionSheet/master/screen.gif)

### Requirements
* Xcode 6 or higher
* iOS 7.0 or higher
* ARC

### Installation
#### Manual Install

All you need to do is drop `HcdActionSheet` files into your project, and add `#include "HcdActionSheet.h"` to the top of classes that will use it.

#### Cocoapods

Change to the directory of your Xcode project:
``` bash
$ cd /path/to/YourProject
$ touch Podfile
$ edit Podfile
```

Edit your Podfile and add HcdActionSheet:
``` bash
pod 'HcdActionSheet'
```
Install into your Xcode project:
``` bash
$ pod install
```
Open your project in Xcode from the .xcworkspace file (not the usual project file)
``` bash
$ open YourProject.xcworkspace
```

### Example Usage

``` objc
HcdActionSheet *sheet = [[HcdActionSheet alloc] initWithCancelStr:@"Cancle"
                                                otherButtonTitles:@[@"Log Out"]
                                                      attachTitle:@"Are you sure Log Out?"];

sheet.selectButtonAtIndex = ^(NSInteger index) {
    NSLog(@"%ld", (long)index);
};
[[UIApplication sharedApplication].keyWindow addSubview:sheet];
[sheet showHcdActionSheet];
```
You can write this in which ViewController you want to show HcdActionSheet.
