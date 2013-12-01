SQAESDE
======

Safe&Quick AES256 Encrypt and Decrypt

###Relase Note:

V0.1

1.	Not Support ARC
2.	Requires iOS 4.0 and later.


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
pod 'SQAESDE', '0.1'
```

Install dependencies.

```
$ pod install
```

When using CocoaPods, you must open the .xcworkspace file instead of the project file when building your project.