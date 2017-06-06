//
//  UIViewController+Popup.h
//  TikiProject
//
//  Created by Duc Nguyen on 8/10/16.
//  Copyright © 2016 ABA. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapOnBackgroundAction)();

@interface UIViewController (Popup)

@property (nonatomic, readwrite) UIViewController *popupViewController;
@property (nonatomic, readwrite) CGPoint popupViewOffset;
@property (nonatomic, copy, readonly) TapOnBackgroundAction tapAction;
@property (nonatomic, strong, readonly) UIControl *fadeView;

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                        completion:(void (^)(void))completion
                            handle:(TapOnBackgroundAction)handle;

- (void)dismissPopupViewControllerAnimated:(BOOL)flag
                                completion:(void (^)(void))completion;
@end
