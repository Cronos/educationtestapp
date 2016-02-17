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

static NSString *   const EDATableViewCellIdentifier    = @"EDATableViewCell";
static CGFloat      const EDATableViewCellHeigth        = 80.0;
static NSUInteger   const EDATableViewSectionCount      = 1;
static NSUInteger   const EDATableViewDefaultFetchCount = 20;

@interface EDAViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation EDAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:EDATableViewCellIdentifier bundle:nil] forCellReuseIdentifier:EDATableViewCellIdentifier];
    self.index = 0;
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
    [cell prepareForReuse];
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO: дозагрузка приложений
    if (indexPath.row >= ([EDADataManager sharedManager].count - EDATableViewDefaultFetchCount/2)) {
        [self fetchData];
    }
}

#pragma mark -
#pragma mark Private

- (void)fetchData {

    [[EDADataManager sharedManager] fetchDataForRecordsFromIndex:self.index count:EDATableViewDefaultFetchCount completion:^(NSError *error) {
        self.index += EDATableViewDefaultFetchCount;

        //TODO: handle error?
        if (error) {
            [self showAlertWithTitle:@"ERROR" message:error.localizedDescription handler:nil];
        } else {
            [self.tableView reloadData];
        }
    }];
}

@end
