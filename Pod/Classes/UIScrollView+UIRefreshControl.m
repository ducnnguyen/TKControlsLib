//
//  UIScrollView+UIRefreshControl.m
//  TikiProject
//
//  Created by Duc Nguyen on 6/16/16.
//  Copyright © 2016 ABA. All rights reserved.
//

#import "UIScrollView+UIRefreshControl.h"
#import <objc/runtime.h>

static char UIScrollViewRefreshControl;
static char UIScrollViewRefreshAction;

@implementation UIScrollView (UIRefreshControl)
@dynamic pullToRefreshControl, refreshAction;

- (void)addRefreshControlWithActionHandler:(void (^)(void))actionHandler {
    if(!self.pullToRefreshControl) {
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(fetchData) forControlEvents:(UIControlEventValueChanged)];
        [self addSubview:refreshControl];
        self.pullToRefreshControl = refreshControl;
        self.refreshAction = actionHandler;
    }
}

- (void)fetchData {
    self.refreshAction();
}

- (void)setPullToRefreshControl:(UIRefreshControl *)pullToRefreshControl {
    [self willChangeValueForKey:@"UIRefreshControl"];
    objc_setAssociatedObject(self, &UIScrollViewRefreshControl,
                             pullToRefreshControl,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"UIRefreshControl"];
}

- (UIRefreshControl *)pullToRefreshControl {
    return objc_getAssociatedObject(self, &UIScrollViewRefreshControl);
}

- (void)setRefreshAction:(RefreshAction)refreshAction {
    [self willChangeValueForKey:@"RefreshAction"];
    objc_setAssociatedObject(self, &UIScrollViewRefreshAction,
                             refreshAction,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"RefreshAction"];
}

- (RefreshAction)refreshAction {
    return objc_getAssociatedObject(self, &UIScrollViewRefreshAction);
}

@end
