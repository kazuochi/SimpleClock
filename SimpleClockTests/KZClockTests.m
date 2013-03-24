//
//  KZClockTests.m
//  SimpleClock
//
//  Created by Kazuhito Ochiai on 3/20/13.
//  Copyright (c) 2013 Kazuhito Ochiai. All rights reserved.
//

#import "KZClockTests.h"
#import "KZClock.h"
@implementation KZClockTests


- (void)testDateFormatter{
    
    KZClock *testClock = [[KZClock alloc] init];
    testClock.dateFormat = @"MM_DD";
    testClock.timeFormat = @"HH_mm_ss";
   
    NSDateFormatter *testFormatter = [[NSDateFormatter alloc] init];
    
    [testFormatter setDateFormat:@"MM_DD|HH_mm_ss"];
    STAssertTrue([testClock.currentDateFormat isEqualToString:[testFormatter dateFormat]], @"");
   
}

-(void) testCurrentFormattedDateAndTimeString{
    
    KZClock *testClock = [[KZClock alloc] init];
    NSDateFormatter *testFormatter = [[NSDateFormatter alloc] init];
    
    [testFormatter setDateFormat:@"HH_mm_ss"];
    STAssertFalse([testClock.currentFormattedTimeString isEqualToString:[testFormatter stringFromDate:[NSDate date]]], @"");
     testClock.timeFormat = @"HH_mm_ss";
    STAssertTrue([testClock.currentFormattedTimeString isEqualToString:[testFormatter stringFromDate:[NSDate date]]], @"");
    
    
    [testFormatter setDateFormat:@"MM_DD"];
    STAssertFalse([testClock.currentFormattedDateString isEqualToString:[testFormatter stringFromDate:[NSDate date]]], @"");
    testClock.dateFormat = @"MM_DD";
    STAssertTrue([testClock.currentFormattedDateString isEqualToString:[testFormatter stringFromDate:[NSDate date]]], @"");

}

@end
