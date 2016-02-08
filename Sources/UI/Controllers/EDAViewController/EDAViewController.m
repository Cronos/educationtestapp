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

static NSString * const EDATableViewCellIdentifier = @"EDATableViewCell";

@interface EDAViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation EDAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:EDATableViewCellIdentifier bundle:nil] forCellReuseIdentifier:EDATableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EDATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EDATableViewCellIdentifier];
    [cell prepareForReuse];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[EDADataManager manager] count]+40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

@end
