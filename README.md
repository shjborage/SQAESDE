SQLibs
======

Lots of libs by others or myself.  Just manage it for people easy to use.

1.Copy the directory "SQLibs_include" to your appropriate path and add this path
to your target's Header Search Paths in Build Settings.

2.Add "libSQLibs.a" to your projects and Check the target's Library Search Paths
 in Build Settings. 
    You can use the SQLibs_StaticLibrary project to build "libSQLibs.a". Further more,
    a fat library maybe needed. Use lipo command. (lipo -create libSQLibs_i386.a libSQLibs_arm7.a -output libSQLibs.a)
    
3.#import "SQLibs.h", so begin your journey.


Samples
-------
SQLibs_Samples.xcworkspace

An Xcworkspace for all the tests.

1.Each Guide is located in AppDelegate.h's header.


Later version:
1.How to build SQLibs maybe complex, I will try to write a shell script to simplify it.
2.The include directory "SQLibs_include" is now Empty, Later I will try to write
a simply app on the mac to move them from src path.