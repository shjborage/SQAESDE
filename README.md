SQAESDE
======

Safe&Quick AES256 Encrypt and Decrypt, which support both hex and base64 output.

###Relase Note:

V0.1.1

1. ARC support
2. Add Kiwi unit test and demo project.

V0.1

1.	Not Support ARC
2.	Requires iOS 5.0 and later.


###Brief

```
+ (NSString *)enCrypt:(NSString *)strContent key:(NSString *)strKey;
+ (NSString *)deCrypt:(NSString *)strContent key:(NSString *)strKey;

+ (NSString *)enCryptBase64:(NSString *)strContent key:(NSString *)strKey;
+ (NSString *)deCryptBase64:(NSString *)strContent key:(NSString *)strKey;
```


###Installing

####CocoaPods
CocoaPods automates 3rd party dependencies in Objective-C.

#####Install the ruby gem.

```
$ sudo gem install cocoapods
$ pod setup
```

Depending on your Ruby installation, you may not have to run as sudo to install the cocoapods gem. Create a Podfile. You must be running on iOS 5 or above.

```
platform :ios, '5.0'
pod 'SQAESDE', '~> 0.1.1'
```

Install dependencies.

```
$ pod install
```

When using CocoaPods, you must open the .xcworkspace file instead of the project file when building your project.

###License

The MIT License (MIT)

Copyright (c) 2013 Eric

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
