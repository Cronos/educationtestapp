//
//  UITableView+EDAExtensions.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "UITableView+EDAExtensions.h"

@implementation UITableView (EDAExtensions)

- (void)updateWithBlock:(EDATableViewVoidBlock)block {
    if (block) {
        [self beginUpdates];
        block();
        [self endUpdates];
    }
}

- (void)insertCellsAtIndexPaths:(NSArray <NSIndexPath *> *)rows withRowAnimation:(UITableViewRowAnimation)animation {
    [self updateWithBlock:^{
        [self insertRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationFade];
    }];
    
}

- (void)insertCellAtRow:(NSInteger)row section:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    [self insertCellsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:animation];
}

@end
