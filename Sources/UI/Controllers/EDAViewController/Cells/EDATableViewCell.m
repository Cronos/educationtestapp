//
//  EDATableViewCell.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDATableViewCell.h"
#import "EDAData.h"

@interface EDATableViewCell() {
    EDAData *cellData;
}

@end

@implementation EDATableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(EDAData *)data {
    cellData = data;
}

@end
