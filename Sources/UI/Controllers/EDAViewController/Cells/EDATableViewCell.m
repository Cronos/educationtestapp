//
//  EDATableViewCell.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 04.01.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "EDATableViewCell.h"
#import "EDAData.h"

@interface EDATableViewCell()
@property (nonatomic, strong) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong) IBOutlet UILabel *indexLabel;

- (void)willDisplay;
- (void)didEndDisplaying;
- (void)updateViewsWithData:(EDAData *)data;

@end

@implementation EDATableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)prepareForReuse {
    self.data.updateDataBlock = nil;
    self.data = nil;
}

- (void)setData:(EDAData *)data {
    if (_data != data) {
        _data = data;
        typeof(self) __weak weakSelf = self;
        _data.updateDataBlock = ^(EDAData *data) {
            typeof(weakSelf) __weak strongSelf = weakSelf;
            [strongSelf updateViewsWithData:data];
        };        
    }
}

- (void)willDisplay {
    [self.data fetchData];
}

- (void)didEndDisplaying {
    [self.data cancelFetchData];
}

- (void)updateViewsWithData:(EDAData *)data {
    self.indexLabel.text = @(data.index).stringValue;
    self.contentLabel.text = data.content;
}

@end
