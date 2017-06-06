//
//  TDBadgedCell.h
//  TDBadgedTableCell
//	TDBageView
//
//	Any rereleasing of this code is prohibited.
//	Please attribute use of this code within your application
//
//	Any Queries should be directed to hi@tmdvs.me | http://www.tmdvs.me
//	
//  Created by Tim
//  Copyright 2011 Tim Davies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface TDBadgeView : UIView
{
    UIColor *__defaultColor;
    UIColor *__defaultHighlightColor;
}

@property (nonatomic, readonly)     NSUInteger width;
@property (nonatomic, strong)    NSString *badgeString;
@property (nonatomic, weak)      UITableViewCell *parent;
@property (nonatomic, strong)    UIColor *badgeColor;
@property (nonatomic, strong)    UIColor *badgeTextColor;
@property (nonatomic, strong)    UIColor *badgeColorHighlighted;
@property (nonatomic, strong)    UIColor *badgeTextColorHighlighted;
@property (nonatomic, assign)       BOOL boldFont;
@property (nonatomic, assign)       CGFloat fontSize;
@property (nonatomic, assign)       CGFloat radius;

@end

@interface TDBadgedCell : UITableViewCell {

}

@property (nonatomic, strong)    NSString *badgeString;
@property (readonly,  strong)    TDBadgeView *badge;
@property (nonatomic, strong)    UIColor *badgeColor;
@property (nonatomic, strong)    UIColor *badgeTextColor;
@property (nonatomic, strong)    UIColor *badgeColorHighlighted;
@property (nonatomic, strong)    UIColor *badgeTextColorHighlighted;
@property (nonatomic, assign)       CGFloat badgeLeftOffset;
@property (nonatomic, assign)       CGFloat badgeRightOffset;
@property (nonatomic, assign)       CGFloat badgeHorizPadding;
@property (nonatomic, assign)       CGFloat badgeVertPadding;
@property (nonatomic, strong)    NSMutableArray *resizeableLabels;

@end
