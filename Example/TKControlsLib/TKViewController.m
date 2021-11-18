//
//  TKViewController.m
//  TKControlsLib
//
//  Created by duc.nguyen@tiki.vn on 06/06/2017.
//  Copyright (c) 2017 duc.nguyen@tiki.vn. All rights reserved.
//

#import "TKViewController.h"
@import TKControlsLib;
@interface TKViewController ()

@end

@implementation TKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog([[UIDevice currentDevice] readableModel]);
    NSLog([UIApplication userAgentWithAppName:@"TIki"]);
    BBBadgeBarButtonItem *item = [[BBBadgeBarButtonItem alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
