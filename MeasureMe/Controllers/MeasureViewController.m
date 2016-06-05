//
//  MeasureViewController.m
//  MeasureMe
//
//  Created by Navid Mia on 2016-01-12.
//  Copyright © 2016 Navid Mia. All rights reserved.
//

#import "MeasureViewController.h"
#import "NetworkMeasurementsClient.h"
#import "ApplicationStyle.h"
#import <UIKitPlus/UIKitPlus.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "MeasureCellView.h"
#import "LengthCellView.h"
#import "TableSectionHeaderView.h"

@interface MeasureViewController () <UITableViewDelegate, UITableViewDataSource, MeasureCellViewDelegate, LengthCellViewDelegate>
{
    UIRefreshControl *refreshControl;
    UITableView *tableView;
}
@property (nonatomic, strong) NSMutableArray *champions;
@property (nonatomic, strong) NSMutableArray *savedLengths;
@property (nonatomic, strong) NSMutableArray *savedDescriptions;
@end

@implementation MeasureViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"MeasureMe";
    [self buildUI];
    [self refreshData];
}

static NSString *kSavedLengths = @"com.MeasureMe.SavedLengths";
static NSString *kSavedDetails = @"com.MeasureMe.SavedDetails";

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) buildUI
{
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ApplicationStyle screenWidth], [ApplicationStyle screenHeight] - [ApplicationStyle navigationAndStatusBarHeight])];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.allowsMultipleSelectionDuringEditing = NO;
    [self.view addSubview:tableView];
}

- (void) saveLength:(CGFloat)length
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *savedLengths = [[defaults objectForKey:kSavedLengths] mutableCopy];
    if (!savedLengths) {
        savedLengths = [[NSMutableArray alloc] initWithArray:@[@(length)]];
    } else {
        [savedLengths addObject:@(length)];
    }
    self.savedLengths = savedLengths;
    
    NSMutableArray *savedDetails = [[defaults objectForKey:kSavedDetails] mutableCopy];
    if (!savedDetails) {
        savedDetails = [[NSMutableArray alloc] initWithArray:@[@""]];
    } else {
        [savedDetails addObject:@""];
    }
    self.savedDescriptions = savedDetails;
    
    [tableView reloadData];
    
    [defaults setObject:savedLengths forKey:kSavedLengths];
    [defaults setObject:savedDetails forKey:kSavedDetails];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [defaults synchronize];
    });
}

- (void) saveDescription:(NSString *)description forObject:(LengthCellView *)cell
{
    for (UITableViewCell *tableViewCell in [tableView visibleCells]) {
        LengthCellView *cellView = [tableViewCell.contentView subviewOfClass:[LengthCellView class]];
        if ([cellView isEqual:cell]) {
            NSIndexPath *index = [tableView indexPathForCell:tableViewCell];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray *savedDetails = [[defaults objectForKey:kSavedDetails] mutableCopy];
            savedDetails[index.row] = description;
            self.savedDescriptions = savedDetails;
            
            [defaults setObject:savedDetails forKey:kSavedDetails];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                [defaults synchronize];
            });
        }
    }
}

- (void) refreshData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.savedLengths = [[defaults objectForKey:kSavedLengths] mutableCopy];
    self.savedDescriptions = [[defaults objectForKey:kSavedDetails] mutableCopy];
    [tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.savedLengths.count) {
        return 2;
    }
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.savedLengths.count;
    }
    return 0;
}

NSString * const MeasureCellIdentifier = @"MeasureCellIdentifier";
NSString * const LengthCellIdentifier = @"LengthCellIdentifier";


- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tv dequeueReusableCellWithIdentifier:MeasureCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MeasureCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            MeasureCellView *measureCellView = [MeasureCellView cellView];
            measureCellView.delegate = self;
            [cell.contentView addSubview:measureCellView];
        }
    } else if (indexPath.section == 1) {
        cell = [tv dequeueReusableCellWithIdentifier:LengthCellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LengthCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            LengthCellView *lengthCellView = [LengthCellView cellView];
            [cell.contentView addSubview:lengthCellView];
        }
    }

    [self configureCell:cell forIndexPath:indexPath inTableView:tv];
    return cell;
}

- (void) configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tv
{
    if (indexPath.section == 1) {
        LengthCellView *cellView = [cell.contentView subviewOfClass:[LengthCellView class]];
        cellView.length = [self lengthAtIndexPath:indexPath inTableView:tv];
        cellView.details = [self detailsAtIndexPath:indexPath inTableView:tv];
        cellView.delegate = self;
    }
}

- (CGFloat)lengthAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
    CGFloat length = 0;
    if (self.savedLengths.count > indexPath.row) {
        length = [[self.savedLengths objectAtIndex:indexPath.row] floatValue];
    }
    return length;
}

- (NSString *)detailsAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
    NSString *details = @"";
    if (self.savedDescriptions.count > indexPath.row) {
        details = [self.savedDescriptions objectAtIndex:indexPath.row];
    }
    return details;
}

#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [ApplicationStyle screenHeight] - [ApplicationStyle navigationAndStatusBarHeight];
    }
    return 40.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [UIView new];
    } else if (section == 1) {
        return [TableSectionHeaderView headerViewWithTitle:@"Saved Lengths"];
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0f;
    } if (section == 1) {
        return 50.0f;
    }
    return 0.0f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *savedLengths = [[defaults objectForKey:kSavedLengths] mutableCopy];
        if (savedLengths[indexPath.row]) {
            [savedLengths removeObjectAtIndex:indexPath.row];
        }
        self.savedLengths = savedLengths;
        
        NSMutableArray *savedDetails = [[defaults objectForKey:kSavedDetails] mutableCopy];
        if (savedDetails[indexPath.row]) {
            [savedDetails removeObjectAtIndex:indexPath.row];
        }
        self.savedDescriptions = savedDetails;
        
        [tableView reloadData];
        
        [defaults setObject:savedLengths forKey:kSavedLengths];
        [defaults setObject:savedDetails forKey:kSavedDetails];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [defaults synchronize];
        });
    }
}

@end
