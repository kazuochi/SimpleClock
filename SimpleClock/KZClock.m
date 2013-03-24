//
//  KZClock.m
//  SimpleClock
//
//  Created by Kazuhito Ochiai on 3/14/13.
//  Copyright (c) 2013 Kazuhito Ochiai. All rights reserved.
//

#import "KZClock.h"

@interface KZClock ()
    @property (retain, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation KZClock
@synthesize dateFormat = _dateFormat, timeFormat = _timeFormat;

-(id)init{
    
    self = [super init];
    if(self){
        _timezone = [NSTimeZone systemTimeZone];  //set default time zone as systemTimeZone
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"EEE, MMM d, yyyy|h:mm:ss a"];
    }
    return self;
}

-(void)dealloc{
    [_dateFormat release];
    [_timeFormat release];
    [_dateFormatter release];
    [_timezone release];
    [super dealloc];
}

#pragma mark - setters and getters
-(NSDateFormatter *)dateFormatter{
    
    if(!_dateFormatter){
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"EEE, MMM d, yyyy|h:mm:ss a"];
    }
    return _dateFormatter;
}

-(void)setDateFormat:(NSString *)dateFormat{

    [_dateFormat release];
    _dateFormat = [dateFormat copy];
    [self.dateFormatter setDateFormat:[_dateFormat stringByAppendingFormat:@"|%@",self.timeFormat]];
}

-(NSString *)dateFormat{
    
    if(!_dateFormat){
        _dateFormat = @"EEE, MMM d, yyyy";
    }
    return _dateFormat;
}

-(NSString *)timeFormat{
    
    if(!_timeFormat){
        _timeFormat = @"h:mm:ss a";
    }
    return _timeFormat;
}

-(void)setTimeFormat:(NSString *)timeFormat{
    
    [_timeFormat release];
    _timeFormat = [timeFormat copy];
    [self.dateFormatter setDateFormat:[self.dateFormat stringByAppendingFormat:@"|%@",_timeFormat]];

}

-(void)setTimezone:(NSTimeZone *)timezone{
    
    [timezone retain];
    [_timezone release];
    _timezone = timezone;
    [self.dateFormatter setTimeZone:timezone];
}

-(NSString *)currentDateFormat{
    return [self.dateFormatter dateFormat];
}

#pragma mark - public methods
-(NSString *)currentFormattedDateString{
    
    NSArray* dateAndTime = [[self.dateFormatter stringFromDate:[NSDate date]] componentsSeparatedByString:@"|"];
    
    return dateAndTime[0];
     
}

-(NSString *)currentFormattedTimeString{
    
    NSArray* dateAndTime = [[self.dateFormatter stringFromDate:[NSDate date]] componentsSeparatedByString:@"|"];
    
    return dateAndTime[1];
    
}

@end
