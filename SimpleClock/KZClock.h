//
//  KZClock.h
//  SimpleClock
//
//  Created by Kazuhito Ochiai on 3/14/13.
//  Copyright (c) 2013 Kazuhito Ochiai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZClock : NSObject
  
@property (copy, nonatomic) NSString *dateFormat; //default format string is @"EEE, MMM d, yyyy"
@property (copy, nonatomic) NSString *timeFormat;  //default format string is @"h:mm:ss a"
@property (retain, nonatomic) NSTimeZone *timezone;         //default value is the system's timezone
@property (readonly, nonatomic) NSString *currentDateFormat; //returns current dateformat

-(NSString *)currentFormattedDateString; //return date string in current dateFormat form
-(NSString *)currentFormattedTimeString; //return time string in in current dateFormat 

@end
