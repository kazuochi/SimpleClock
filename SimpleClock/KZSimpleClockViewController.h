//
//  KZSimpleClockViewController.h
//  SimpleClock
//
//  Created by Kazuhito Ochiai on 3/14/13.
//  Copyright (c) 2013 Kazuhito Ochiai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZTimeZoneSettingViewController.h"

@interface KZSimpleClockViewController : UIViewController<KZTimeZoneSettingViewControllerDelegate, UIPopoverControllerDelegate>
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *timezoneLabel;

@end
