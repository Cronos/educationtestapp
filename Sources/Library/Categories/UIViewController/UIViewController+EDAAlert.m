//
//  UIViewController+EDAAlert.m
//  EducationTestApp
//
//  Created by Voropaev Vitali on 16.02.16.
//  Copyright © 2016 Voropaev Vitali. All rights reserved.
//

#import "UIViewController+EDAAlert.h"

@implementation UIViewController (EDAAlert)

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction *action))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:handler];
    
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
