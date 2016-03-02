//
//  UIViewController+EDAAlert.h
//  EducationTestApp
//
//  Created by Voropaev Vitali on 16.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (EDAAlert)

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction *action))handler;

@end
