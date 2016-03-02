//
//  UITableView+EDAExtensions.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 02.03.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EDATableViewVoidBlock)();

@interface UITableView (EDAExtensions)

- (void)updateWithBlock:(EDATableViewVoidBlock)block;

- (void)insertCellsAtIndexPaths:(NSArray <NSIndexPath *> *)rows withRowAnimation:(UITableViewRowAnimation)animation;
- (void)insertCellAtRow:(NSInteger)row section:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

@end
