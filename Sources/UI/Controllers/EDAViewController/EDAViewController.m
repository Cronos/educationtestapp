//
//  ViewController.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDAViewController.h"
#import "EDATableViewCell.h"
#import "EDADataManager.h"
#import "UIViewController+EDAAlert.h"
#import "UITableView+EDAExtensions.h"

static NSString *   const EDATableViewCellIdentifier    = @"EDATableViewCell";
static CGFloat      const EDATableViewCellHeigth        = 80.0;
static NSUInteger   const EDATableViewSectionCount      = 1;
static NSUInteger   const EDATableViewDefaultFetchCount = 10;

@interface EDAViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation EDAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:EDATableViewCellIdentifier bundle:nil] forCellReuseIdentifier:EDATableViewCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self fetchData];
}

#pragma mark -
#pragma mark UITableView delegate/datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EDATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EDATableViewCellIdentifier];
    if (!cell) {
        cell = [[EDATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EDATableViewCellIdentifier];
    }
    cell.data = [EDADataManager sharedManager][indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [EDADataManager sharedManager].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return EDATableViewSectionCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return EDATableViewCellHeigth;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(EDATableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= ([EDADataManager sharedManager].count - EDATableViewDefaultFetchCount)) {
        [self fetchData];
    }
    [cell willDisplay];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(EDATableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    [cell didEndDisplaying];
}

#pragma mark -
#pragma mark Private

- (void)insertRowsFromIndex:(NSUInteger)index count:(NSUInteger)count {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger idx = index; idx < index + count; idx++) {
        [array addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
    }
    
    [self.tableView insertCellsAtIndexPaths:[array copy] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)fetchData {
    [[EDADataManager sharedManager] fetchDataCount:EDATableViewDefaultFetchCount completion:^(NSUInteger index, NSUInteger count) {
        [self insertRowsFromIndex:index count:count];
    } error:^(NSError *error) {
        [self showAlertWithTitle:@"ERROR" message:error.localizedDescription handler:nil];
    }];
}

@end
