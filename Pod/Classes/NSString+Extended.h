//
//  NSString+Extended.h
//  ZaoDich
//
//  Created by Ta Phuoc Hai on 9/9/14.
//  Copyright (c) 2014 TPH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extended)

- (NSMutableAttributedString*)tikiAttributeString:(CGFloat)size
                                  foregroundColor:(UIColor*)foregroundColor
                                      strongColor:(UIColor*)strongColor
                                        linkColor:(UIColor*)linkColor;

- (NSMutableAttributedString*)promotionAttributeString;
- (NSMutableAttributedString*)descriptionAttributeString;
- (NSMutableAttributedString*)tikiAttributeString:(CGFloat)size;
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

+ (BOOL)compareVersion:(NSString*)versionOne biggerToVersion:(NSString*)versionTwo;
- (NSMutableAttributedString*)informationAttributeString;
- (NSString *)stringByDeletingWordsFromStringToFit:(CGRect)rect
                                         withInset:(CGFloat)inset
                                         usingFont:(UIFont *)font;
- (NSMutableAttributedString*)informationAttributeStringWithFontSize:(CGFloat)fontSize;
- (NSString *)stringByDeletingWordsFromStringToFit:(CGRect)rect
                                         withInset:(CGFloat)inset
                                         usingFont:(UIFont *)font
                                          withText:(NSString *)text
                                    withExpandText:(NSString *)expandText;
@end
