//
//  KZTimeZoneSettingViewViewController.m
//  SimpleClock
//
//  Created by Kazuhito Ochiai on 3/15/13.
//  Copyright (c) 2013 Kazuhito Ochiai. All rights reserved.
//

#import "KZTimeZoneSettingViewController.h"


@interface KZTimeZoneSettingViewController ()
@property (retain, nonatomic) NSIndexPath *currentTimezoneIndexPath;
@end

@implementation KZTimeZoneSettingViewController

#pragma  mark - orientation support
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

#pragma  mark -  main methods
-(void)viewWillAppear:(BOOL)animated{
    [self initializeCellCheckMark];  //initialize checkmark here popover controller calls viewDidLoad only once. 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Change Timezone";
}

-(void)initializeCellCheckMark{
    
    __block NSUInteger currentTimezoneIndex;
    
    [[NSTimeZone knownTimeZoneNames] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[NSString class]] && [((NSString*)obj) isEqualToString:[self.currentTimezone name]]){
            currentTimezoneIndex = idx;
            *stop = YES;
            [self.timezoneTable reloadData];
        }
    }];
    self.currentTimezoneIndexPath = [NSIndexPath indexPathForRow:currentTimezoneIndex inSection:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_currentTimezone release];
    [_timezoneTable release];
    [_currentTimezoneIndexPath release];
    [super dealloc];
}

-(IBAction)doneButtonPressed:(id)sender{
    
    [self.delegate KZTimeZoneSettingViewControllerDidFinish:[self selectedTimeZone]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)cancelButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate KZTimeZoneSettingViewControllerCanceled];
}

//returns currently selected timezone
-(NSTimeZone *)selectedTimeZone{
    return [NSTimeZone timeZoneWithName:[NSTimeZone knownTimeZoneNames][self.currentTimezoneIndexPath.row]];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if ([viewControllers indexOfObject:self] == NSNotFound) {
        // View is disappearing because it was popped from the stack
        [self.delegate KZTimeZoneSettingViewControllerDidFinish:[self selectedTimeZone]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.delegate KZTimeZoneSettingViewControllerDidFinish:[self selectedTimeZone]];
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[NSTimeZone knownTimeZoneNames] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if([self.currentTimezoneIndexPath compare:indexPath] == NSOrderedSame){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = [UIColor colorWithRed:0.529 green:0.808 blue:0.980 alpha:1.000]; //87cefa
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.textLabel.text = [NSTimeZone knownTimeZoneNames][indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentTimezoneIndexPath = indexPath;
    [self.timezoneTable reloadData];
}


@end
