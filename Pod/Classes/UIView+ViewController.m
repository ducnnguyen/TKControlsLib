//
//  UIView+ViewController.m
//  TikiProject
//
//  Created by Duc Nguyen on 4/21/16.
//  Copyright © 2016 ABA. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

+ (instancetype)viewFromSameNib {
    return [self viewFromSameNib:nil];
}

+ (instancetype)viewFromSameNib:(NSBundle *)bundle {
    return [self viewFromNibName:NSStringFromClass([self class]) bundle:bundle];
}

+ (instancetype)viewFromNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    if (bundle == nil) {
        bundle = [NSBundle mainBundle];
    }
    
    NSArray *topLevelObjects = [bundle loadNibNamed:nibName owner:nil options:nil];
    for (id currentObject in topLevelObjects) {
        if ([currentObject isKindOfClass:[self class]]) {
            return currentObject;
        }
    }
    
    return nil;
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (CGSize)getScreenFrameForCurrentOrientation {
    return [self getScreenFrameForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (CGSize)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGSize fullScreenRect = screen.bounds.size;
    BOOL statusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    
    //implicitly in Portrait orientation.
    if(orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft){
        CGSize temp = CGSizeZero;
        temp.width = fullScreenRect.height;
        temp.height = fullScreenRect.width;
        fullScreenRect = temp;
    }
    
    if(!statusBarHidden){
        CGFloat statusBarHeight = 20;//Needs a better solution, FYI statusBarFrame reports wrong in some cases..
        fullScreenRect.height -= statusBarHeight;
    }
    
    return fullScreenRect;
}

@end
