//
//  WorldMapView.h
//  Trailmakr
//
//  Created by Richard Francis on 18/07/2012.
//  Copyright (c) 2012 Viadeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface UIMagicMap : UIScrollView <UIScrollViewDelegate>

@property (assign, nonatomic) BOOL animated;

- (void)setFixed:(BOOL)fixed;
- (void)setLocation:(CLLocationCoordinate2D)location;
- (id)initWithFrame:(CGRect)frame fixed:(BOOL)fixed animated:(BOOL)animated;

@end