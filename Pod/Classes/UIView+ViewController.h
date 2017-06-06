//
//  UIView+ViewController.h
//  TikiProject
//
//  Created by Duc Nguyen on 4/21/16.
//  Copyright © 2016 ABA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewController)

+ (instancetype)viewFromSameNib;
+ (instancetype)viewFromSameNib:(NSBundle *)bundle;
+ (instancetype)viewFromNibName:(NSString *)nibName bundle:(NSBundle *)bundle;

- (UIViewController*)viewController ;

- (CGSize)getScreenFrameForCurrentOrientation;

- (CGSize)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation;

@end
