//
//  KZTimeZoneSettingViewViewController.h
//  SimpleClock
//
//  Created by Kazuhito Ochiai on 3/15/13.
//  Copyright (c) 2013 Kazuhito Ochiai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZClock.h"

@protocol KZTimeZoneSettingViewControllerDelegate;

@interface KZTimeZoneSettingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *timezoneTable;
@property (retain, nonatomic) NSTimeZone *currentTimezone;
@property (assign, nonatomic) id<KZTimeZoneSettingViewControllerDelegate> delegate;

@end

@protocol KZTimeZoneSettingViewControllerDelegate

-(void)KZTimeZoneSettingViewControllerDidFinish:(NSTimeZone *)selectedTimezone;
-(void)KZTimeZoneSettingViewControllerCanceled;


@end