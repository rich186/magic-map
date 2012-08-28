//
//  ViewController.h
//  MagicMap
//
//  Created by Richard Francis on 28/08/2012.
//  Copyright (c) 2012 Richard Francis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMagicMap.h"

@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIMagicMap *magicMap;

- (IBAction)toggleMarkerFixing:(id)sender;
- (IBAction)toggleAnimated:(id)sender;
- (IBAction)gotoCity:(id)sender;

@end
