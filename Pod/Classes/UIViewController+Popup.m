//
//  UIViewController+Popup.m
//  TikiProject
//
//  Created by Duc Nguyen on 8/10/16.
//  Copyright © 2016 ABA. All rights reserved.
//

#import "UIViewController+Popup.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

#define ANIMATION_TIME 0.5f


NSString const *TKPopupKey          = @"TKPopupkey";
NSString const *TKFadeViewKey       = @"TKFadeViewKey";
NSString const *TKPopupViewOffset   = @"TKPopupViewOffset";
NSString const *TKPopupViewHandle   = @"TKPopupViewHandle";

@implementation UIViewController (Popup)

@dynamic popupViewController, popupViewOffset, tapAction, fadeView;

#pragma mark - present/dismiss

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                        completion:(void (^)(void))completion
                            handle:(TapOnBackgroundAction)handle{
    if (self.popupViewController == nil) {
        // initial setup
        self.popupViewController = viewControllerToPresent;
        self.popupViewController.view.autoresizesSubviews = NO;
        self.popupViewController.view.autoresizingMask = UIViewAutoresizingNone;
        [self addChildViewController:viewControllerToPresent];
        CGRect finalFrame = [self getPopupFrameForViewController:viewControllerToPresent];
        viewControllerToPresent.view.layer.cornerRadius = 5.0f;
        viewControllerToPresent.view.layer.masksToBounds = YES;
        self.tapAction = handle;
        UIControl *fadeView = [[UIControl alloc] initWithFrame:CGRectZero];
        [fadeView addTarget:self action:@selector(tapOnBackground) forControlEvents:UIControlEventTouchUpInside];
        fadeView.frame = [UIScreen mainScreen].bounds;
        
        fadeView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        fadeView.alpha = 0.f;
        [self.view addSubview:fadeView];
        self.fadeView = fadeView;
        [viewControllerToPresent beginAppearanceTransition:YES animated:flag];
        // setup
        if (flag) { // animate
            CGRect initialFrame = CGRectMake(finalFrame.origin.x, [UIScreen mainScreen].bounds.size.height + viewControllerToPresent.view.frame.size.height/2, finalFrame.size.width, finalFrame.size.height);
            CGFloat initialAlpha = 1.0;
            CGFloat finalAlpha = 1.0;
            if (self.modalTransitionStyle == UIModalTransitionStyleCrossDissolve) {
                initialFrame = finalFrame;
                initialAlpha = 0.0;
            }
            viewControllerToPresent.view.frame = initialFrame;
            viewControllerToPresent.view.alpha = initialAlpha;
            [self.view addSubview:viewControllerToPresent.view];
            [UIView animateWithDuration:ANIMATION_TIME delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                viewControllerToPresent.view.frame = finalFrame;
                viewControllerToPresent.view.alpha = finalAlpha;
                self.fadeView.alpha = 1.f;
            } completion:^(BOOL finished) {
                [self.popupViewController didMoveToParentViewController:self];
                [self.popupViewController endAppearanceTransition];
                [completion invoke];
            }];
        } else { // don't animate
            viewControllerToPresent.view.frame = finalFrame;
            [self.view addSubview:viewControllerToPresent.view];
            [self.popupViewController didMoveToParentViewController:self];
            [self.popupViewController endAppearanceTransition];
            self.fadeView.alpha = 1.f;
            [completion invoke];
        }
    }
}

- (void)dismissPopupViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self.popupViewController willMoveToParentViewController:nil];
    [self.popupViewController beginAppearanceTransition:NO animated:flag];
    if (flag) { // animate
        CGRect initialFrame = self.popupViewController.view.frame;
        CGRect finalFrame = CGRectMake(initialFrame.origin.x, [UIScreen mainScreen].bounds.size.height + initialFrame.size.height/2, initialFrame.size.width, initialFrame.size.height);
        CGFloat finalAlpha = 1.0;
        if (self.modalTransitionStyle == UIModalTransitionStyleCrossDissolve) {
            finalFrame = initialFrame;
            finalAlpha = 0.0;
        }
        [UIView animateWithDuration:ANIMATION_TIME delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.popupViewController.view.frame = finalFrame;
            self.popupViewController.view.alpha = finalAlpha;
            self.fadeView.alpha = 0.f;
            // uncomment the line below to have slight rotation during the dismissal
        } completion:^(BOOL finished) {
            [self.popupViewController removeFromParentViewController];
            [self.popupViewController endAppearanceTransition];
            [self.popupViewController.view removeFromSuperview];
            [self.fadeView removeFromSuperview];
            self.popupViewController = nil;
            [completion invoke];
        }];
    } else { // don't animate
        [self.popupViewController removeFromParentViewController];
        [self.popupViewController endAppearanceTransition];
        [self.popupViewController.view removeFromSuperview];
        [self.fadeView removeFromSuperview];
        self.popupViewController = nil;
        self.fadeView = nil;
        [completion invoke];
    }
}

- (void)tapOnBackground {
    if (self.tapAction) {
        self.tapAction();
    }
}

#pragma mark - handling screen orientation change

- (CGRect)getPopupFrameForViewController:(UIViewController *)viewController {
    CGRect frame = viewController.view.frame;
    CGFloat x;
    CGFloat y;
    x = ([UIScreen mainScreen].bounds.size.width - frame.size.width)/2;
    y = ([UIScreen mainScreen].bounds.size.height - frame.size.height)/2;
    return CGRectMake(x + viewController.popupViewOffset.x, y + viewController.popupViewOffset.y, frame.size.width, frame.size.height);
}


#pragma mark - popupViewController getter/setter

- (void)setPopupViewController:(UIViewController *)popupViewController {
    objc_setAssociatedObject(self, &TKPopupKey, popupViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)popupViewController {
    return objc_getAssociatedObject(self, &TKPopupKey);
}

- (void)setPopupViewOffset:(CGPoint)popupViewOffset {
    objc_setAssociatedObject(self, &TKPopupViewOffset, [NSValue valueWithCGPoint:popupViewOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)popupViewOffset {
    NSValue *offset = objc_getAssociatedObject(self, &TKPopupViewOffset);
    return [offset CGPointValue];
}

- (void)setTapAction:(TapOnBackgroundAction)tapAction {
    [self willChangeValueForKey:@"TKPopupViewHandle"];
    objc_setAssociatedObject(self, &TKPopupViewHandle,
                             tapAction,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"TKPopupViewHandle"];
}

- (TapOnBackgroundAction)tapAction {
    return objc_getAssociatedObject(self, &TKPopupViewHandle);
}
- (void)setFadeView:(UIControl *)fadeView {
    [self willChangeValueForKey:@"TKFadeViewKey"];
    objc_setAssociatedObject(self, &TKFadeViewKey,
                             fadeView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"TKFadeViewKey"];
}

- (UIControl *)fadeView {
    return objc_getAssociatedObject(self, &TKFadeViewKey);
}
@end

