//
//  UIMagicMap.m
//  Magic Map
//
//  Created by Richard Francis on 18/07/2012.
//  Copyright (c) 2012 Richard Francis. All rights reserved.
//

#import "UIMagicMap.h"

@interface UIMagicMap ()

@property (retain, nonatomic) UIView *mapContainer;
@property (retain, nonatomic) UIImageView *map;
@property (retain, nonatomic) UIImageView *marker;
@property (assign, nonatomic) BOOL fixed;
@property (assign, nonatomic) BOOL markerDown;
@property (assign, nonatomic) CLLocationCoordinate2D location;
@property (assign, nonatomic) CGPoint markerPoint;
@property (assign, nonatomic) CGPoint mapPoint;

@end

// Define constants for map
const CGFloat MERCATOR_OFFSET = 1000;
const CGFloat MERCATOR_RADIUS = 318.30988618; // MERCATOR_OFFSET divided by pi

@implementation UIMagicMap

@synthesize mapContainer = _mapContainer;
@synthesize map = _map;
@synthesize marker = _marker;
@synthesize fixed = _fixed;
@synthesize markerDown = _markerDown;
@synthesize location = _location;
@synthesize markerPoint = _markerPoint;
@synthesize mapPoint = _mapPoint;
@synthesize animated = _animated;

- (void)dealloc
{
    [_mapContainer release];
    [_map release];
    [_marker release];
    [super dealloc];
}

- (void)initialize
{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.clipsToBounds = YES;
    self.alwaysBounceHorizontal = YES;
    self.alwaysBounceVertical = YES;
    self.delegate = self;
    
    // Defaults
    _markerDown = NO;
    _fixed = NO;
    _animated = YES;
    
    // Load map image
    UIImage *mapImage = [UIImage imageNamed:@"magicMap.jpg"];
    _map = [[UIImageView alloc] initWithImage:mapImage];
    
    // Load the marker
    UIImage *markerImage = [UIImage imageNamed:@"mapMarker.png"];
    _marker = [[UIImageView alloc] initWithImage:markerImage];
    
    // Create a container for the map and add the elements
    _mapContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _map.frame.size.width, _map.frame.size.height)];
    [_mapContainer addSubview:_map];
    
    self.contentSize = _mapContainer.frame.size;
    
    // Add the map container to the view
    [self addSubview:_mapContainer];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame location:(CLLocationCoordinate2D)location fixed:(BOOL)fixed animated:(BOOL)animated
{
    if ((self = [super initWithFrame:frame])) {
        _animated = animated;
        
        [self initialize];
        [self setLocation:location];
        
        [self setFixed:fixed];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

#pragma mark - Setters and getters
- (void)setFixed:(BOOL)fixed
{
    _fixed = fixed;
    
    if (_fixed) {
        [self positionMap: _animated];
    } else {
        [self unfixMap];
    }
}

#pragma mark - Public methods

- (void)setLocation:(CLLocationCoordinate2D)location
{
    _location = location;
    
    if (_fixed) [self unfixMap];
    
    // Place the marker
    [self placeMarker];
    
    // Don't animate if this is the fist position
    if (CGPointEqualToPoint(_mapPoint, CGPointZero)) {
        [self positionMap:NO];
    } else {
        [self positionMap:_animated];
    }

}

#pragma mark - Private methods

- (void)placeMarker
{
    // Calculate the points on map based on lat and long
    CGFloat x = lroundf(MERCATOR_OFFSET + MERCATOR_RADIUS * _location.longitude * M_PI / 180.0) + 160 - (_marker.frame.size.width / 2);
    CGFloat y = lroundf(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(_location.latitude * M_PI / 180.0)) / (1 - sinf(_location.latitude * M_PI / 180.0))) / 2.0) - (_marker.frame.size.height / 2);
    _markerPoint = CGPointMake(x, y);
    
    [_marker setFrame:CGRectMake(x, y, _marker.frame.size.width, _marker.frame.size.height)];
    
    if (! _markerDown) {
        [_mapContainer addSubview:_marker];
        _markerDown = YES;
    }
}

- (void)positionMap:(BOOL)animated
{
    CGFloat x = _markerPoint.x - (self.frame.size.width / 2) + (_marker.frame.size.width / 2);
    CGFloat y = _markerPoint.y - (self.frame.size.height / 2) + (_marker.frame.size.height / 2);
    _mapPoint = CGPointMake(x, y);
    
    //NSLog(@"_mapPoint: %f, %f", _mapPoint.x, _mapPoint.y);
    //NSLog(@"self.contentOffset: %f, %f", self.contentOffset.x, self.contentOffset.y);
    
    if (CGPointEqualToPoint(_mapPoint, self.contentOffset)) {
        if (_fixed) [self fixMap];
    } else {
        if (animated) {
            [self setContentOffset:_mapPoint animated:YES];
        } else {
            [self setContentOffset:_mapPoint];
            if (_fixed) [self fixMap];
        }
    }
}

- (void)fixMap
{
    // Fix the map whilst keeping bouncing effect
    self.contentSize = self.frame.size;
    _mapContainer.frame = CGRectMake((- _mapPoint.x), (- _mapPoint.y), _mapContainer.frame.size.width, _mapContainer.frame.size.height);
}

- (void)unfixMap
{
    _mapContainer.frame = CGRectMake(0, 0, _mapContainer.frame.size.width, _mapContainer.frame.size.height);
    self.contentSize = _mapContainer.frame.size;
    [self setContentOffset:_mapPoint];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_fixed) {
        [self fixMap];
    }
}

@end
