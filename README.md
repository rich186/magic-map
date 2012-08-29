Magic Map
=========

A super simple, easy-to-use, beautiful world map for iOS.

![MagicMap Sample App (Included)](http://i.imgur.com/FbDwJ.png "MagicMap Sample App (Included)")

Features
--------
* Simply parse a `CLLocationCoordinate2D` object (latitude and longitude) to position the marker on the map.
* Changes in marker position are animated by default.
* Easily fix the map to the marker. The map will first animate to the marker location (if animation is enabled), then respond to touch events by bouncing but not moving.
* Built for both standard definition and retina screens.

Implementation
--------------
1. Be sure to link the `CoreLocation` framework to your target in Xcode.
2. Copy the following files into your project:
   * `UIMagicMap.h`
   * `UIMagicMap.m`
   * `magicMap.jpg`
   * `magicMap@2x.jpg`
   * `mapMarker.png`
   * `mapMarker@2x.png`
3. There are two ways to use the magic map.
   * The easy way is to drop a UIView into your storyboard/NIB, give it a custom class of `UIMagicMap`, then link it to an outlet in your `ViewController`'s header file. If you are implementing it this way be sure to add the `UIMagicMap` class files in the "Compile Sources" of your target's build phases. You will probably also want to call the `setLocation` method on the `UIMagicMap` as soon your view loads. Note that the first `setLocation` is never animated.
   * To insert the `UIMagicMap` component programatically, just allocate the object then initialize it with `(id)initWithFrame:(CGRect)frame location:(CLLocationCoordinate2D)location fixed:(BOOL)fixed animated:(BOOL)animated`.
4. __To position a marker on the map (and scroll to/show the location):__ call the `setLocation` method.
5. __To turn animations off:__ call the `setAnimated` method.
6. __To fix the map to the marker:__ call the `setFixed` method. Note that if the map is currently not positioned over the marker then it will animate/move the map accordingly.

Credits
-------
* For the map I used the colors and textures from [this world map & pin](http://www.premiumpixels.com/freebies/world-map-pin-psd/) by [Thom van der Weerd](http://dribbble.com/thom). I then added Antarctica to the map and made adjustments to ensure its geographical accuracy, reflecting the [mercator projection](http://en.wikipedia.org/wiki/Mercator_projection) rather than the [equirectangluar projection](http://en.wikipedia.org/wiki/Equirectangular_projection).
* I used [this great blog post](http://troybrant.net/blog/2010/01/mkmapview-and-zoom-levels-a-visual-guide/) to help calculate the target map marker point from latitude and longitude coordinates.

License
-------
Copyright (c) 2012 Richard Francis

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.