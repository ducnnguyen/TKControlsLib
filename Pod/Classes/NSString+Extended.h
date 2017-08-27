//
//  NSString+Extended.h
//  ZaoDich
//
//  Created by Ta Phuoc Hai on 9/9/14.
//  Copyright (c) 2014 TPH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extended)

- (NSString *)urlencode;
- (NSString*)uppercaseFirstCharactor;
- (NSString *)reverseString;
- (NSString*)getWordInFirstCharactor:(int)len;
- (NSInteger)getNumberInString;
- (NSMutableAttributedString*)promotionAttributeString;
- (NSMutableAttributedString*)descriptionAttributeString;
- (NSMutableAttributedString*)tikiAttributeString:(CGFloat)size;
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
- (NSUInteger)numberOfWords;
+ (BOOL)compareVersion:(NSString*)versionOne biggerToVersion:(NSString*)versionTwo;
- (NSMutableAttributedString*)informationAttributeString;
- (NSString *)stringByDeletingWordsFromStringToFit:(CGRect)rect
                                         withInset:(CGFloat)inset
                                         usingFont:(UIFont *)font;
- (NSMutableAttributedString*)informationAttributeStringWithFontSize:(int)fontSize;

@end
