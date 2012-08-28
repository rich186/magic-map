//
//  ViewController.m
//  MagicMap
//
//  Created by Richard Francis on 28/08/2012.
//  Copyright (c) 2012 Richard Francis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize magicMap = _magicMap;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMagicMap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [_magicMap release];
    [super dealloc];
}

#pragma mark - IBActions

- (void)toggleMarkerFixing:(id)sender
{
    if ([(UISwitch *)sender isOn]) {
        [_magicMap setFixed:YES];
    } else {
        [_magicMap setFixed:NO];
    }
}

- (void)toggleAnimated:(id)sender
{
    if ([(UISwitch *)sender isOn]) {
        [_magicMap setAnimated:YES];
    } else {
        [_magicMap setAnimated:NO];
    }
}

- (void)gotoCity:(id)sender
{
    if ([sender tag] == 1) { // London
        [_magicMap setLocation:CLLocationCoordinate2DMake(51.502118,-0.155182)];
    } else if ([sender tag] == 2) { // New York
        [_magicMap setLocation:CLLocationCoordinate2DMake(40.755287,-73.983994)];
    } else if ([sender tag] == 3) { // Tokyo
        [_magicMap setLocation:CLLocationCoordinate2DMake(35.6916,139.751158)];
    }
}

@end
