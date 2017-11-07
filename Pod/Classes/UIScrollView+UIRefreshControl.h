//
//  UIScrollView+UIRefreshControl.h
//  TikiProject
//
//  Created by Duc Nguyen on 6/16/16.
//  Copyright © 2016 ABA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RefreshAction)(void);

@interface UIScrollView (UIRefreshControl)

- (void)addRefreshControlWithActionHandler:(void (^)(void))actionHandler;

@property (nonatomic, strong, readonly) UIRefreshControl *pullToRefreshControl;
@property (nonatomic, copy, readonly) RefreshAction refreshAction;

@end
