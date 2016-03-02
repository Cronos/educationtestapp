//
//  EDATableViewCell.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDAData;

@interface EDATableViewCell : UITableViewCell
@property (nonatomic, strong) EDAData *data;

- (void)willDisplay;
- (void)didEndDisplaying;

@end
