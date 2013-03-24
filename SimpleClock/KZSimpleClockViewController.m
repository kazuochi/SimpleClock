//
//  KZSimpleClockViewController.m
//  SimpleClock
//
//  Created by Kazuhito Ochiai on 3/14/13.
//  Copyright (c) 2013 Kazuhito Ochiai. All rights reserved.
//

#import "KZSimpleClockViewController.h"
#import "UINavigationController+allOrientation.h"
#import "KZClock.h"

@interface KZSimpleClockViewController ()
@property (retain, nonatomic) KZClock *clock;
@property (assign, nonatomic) BOOL isShowingLandscapeView;
@property (retain, nonatomic) UIPopoverController* timeZonePopoverController;
@end

@implementation KZSimpleClockViewController

#pragma  mark - orientation support
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (void)orientationChanged:(NSNotification *)notification
{
    if(self.navigationController.visibleViewController == self){
        UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
        
        if (UIDeviceOrientationIsLandscape(deviceOrientation) &&
            !self.isShowingLandscapeView)
        {
            NSString *simpleClockInterfaceName;
             if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                 
                  simpleClockInterfaceName = @"KZSimpleClockViewController_iPhone-landscape";
             }
             else{
                  simpleClockInterfaceName = @"KZSimpleClockViewController_iPad-landscape";
             }
            KZSimpleClockViewController* landscapeView = [[[KZSimpleClockViewController alloc] initWithNibName:simpleClockInterfaceName bundle:nil] autorelease];
            landscapeView.clock = self.clock;
            [self.navigationController pushViewController:landscapeView animated:NO];
            self.isShowingLandscapeView = YES;
        }
        else if (UIDeviceOrientationIsPortrait(deviceOrientation) &&
                 self.isShowingLandscapeView)
        {
            [self.navigationItem setHidesBackButton:NO];
            [self.navigationController popViewControllerAnimated:NO];
            self.isShowingLandscapeView = NO;
        }
    }
}


#pragma mark - getters/setters
-(KZClock *)clock{
    if(!_clock){
        _clock = [[KZClock alloc] init];
    }
    return _clock;
}

#pragma mark - main methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initController];
    [self initUI];
    
}

-(void)initController{

    self.isShowingLandscapeView = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    [self startClock];
}

-(void)startClock{
    
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(updateUI)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)initUI{
    
    [self.navigationItem setHidesBackButton:YES];
    /* create button on navigation bar */
    UIBarButtonItem *timezoneSettingButton = [[[UIBarButtonItem alloc]initWithTitle:@"Change Timezone" style:UIBarButtonItemStyleBordered target:self action:@selector(timezoneSettingButtonPressed:)] autorelease];
    self.navigationItem.rightBarButtonItem = timezoneSettingButton;  
    
    /* apply custom font to the labels */
    UIFont *digiFont = [UIFont fontWithName:@"DS-Digital-Bold" size:24.0];
    [self.dateLabel setFont:digiFont];
    [self.timeLabel setFont:digiFont];
    [self.timezoneLabel setFont:digiFont];
    
    [self updateUI];
}

//sync labels with clock
-(void)updateUI{
    
    self.dateLabel.text = [self.clock currentFormattedDateString];
    self.timeLabel.text = [self.clock currentFormattedTimeString];
    self.timezoneLabel.text = [self.clock.timezone name];
    
}

- (void)dealloc {
    [_dateLabel release];
    [_clock release];
    [_timeLabel release];
    [_timezoneLabel release];
    [super dealloc];
}

-(void)timezoneSettingButtonPressed:(id)sender{
    
    KZTimeZoneSettingViewController *timesettingViewController = [[[KZTimeZoneSettingViewController alloc] initWithNibName:@"KZTimeZoneSettingViewController" bundle:nil] autorelease];
    timesettingViewController.currentTimezone = self.clock.timezone;
    timesettingViewController.delegate = self;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        if(self.timeZonePopoverController){
            if(![self.timeZonePopoverController isPopoverVisible]){
                
                ((KZTimeZoneSettingViewController *)self.timeZonePopoverController.contentViewController).currentTimezone = self.clock.timezone;
                
                [self.timeZonePopoverController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
            else{
                [self.timeZonePopoverController dismissPopoverAnimated:YES];
            }
        }
        else{
            
            self.timeZonePopoverController = [[[UIPopoverController alloc] initWithContentViewController:timesettingViewController] autorelease];
            [self.timeZonePopoverController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
    else{
        [self.navigationController pushViewController:timesettingViewController animated:YES];
    }
    
}

#pragma mark - KZTimeZoneSettingViewDelegateMathod
-(void)KZTimeZoneSettingViewControllerDidFinish:(NSTimeZone *)newTimezone{
    
    [self.timeZonePopoverController dismissPopoverAnimated:YES];
    self.clock.timezone = newTimezone;
    [self updateUI];
    
}

-(void)KZTimeZoneSettingViewControllerCanceled{
     [self.timeZonePopoverController dismissPopoverAnimated:YES];
}


@end
