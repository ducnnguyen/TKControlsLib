//
//  NSString+Extended.m
//  ZaoDich
//
//  Created by Ta Phuoc Hai on 9/9/14.
//  Copyright (c) 2014 TPH. All rights reserved.
//

#import "NSString+Extended.h"
#import <DTCoreText/DTCoreText.h>

@implementation NSString (Extended)

+ (NSString *)hexStringForColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    return hexString;
}

- (NSMutableAttributedString*)tikiAttributeString:(CGFloat)size
                                  foregroundColor:(UIColor*)foregroundColor
                                      strongColor:(UIColor*)strongColor
                                        linkColor:(UIColor*)linkColor {
    NSString *fontName = [UIFont systemFontOfSize:[UIFont systemFontSize]].familyName;
    NSString *foreGroundColorString = [NSString hexStringForColor:foregroundColor];
    NSString *strongColorString = [NSString hexStringForColor:strongColor];
    NSString *linkColorString = [NSString hexStringForColor:linkColor];
    
    NSString *tempContent = [NSString stringWithFormat:@"<style>strong{color:#%@;} a {color:#%@;text-decoration: none;}</style><span style=\"font-family: %@; font-size: %.0f;color:#%@;\">%@</span>",strongColorString, linkColorString, fontName, size, foreGroundColorString, self];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithHTMLData:[tempContent dataUsingEncoding:NSUTF8StringEncoding] options:0 documentAttributes:nil]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.3f];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
    [attrStr enumerateAttributesInRange:NSMakeRange(0, [attrStr length]) options:NSAttributedStringEnumerationReverse usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
         if ([attributes valueForKey:@"DTGUID"] != nil) {
             [attrStr removeAttribute:@"CTForegroundColorFromContext" range:range];
         }
     }];
    
    return attrStr;
}

- (NSMutableAttributedString*)tikiAttributeString:(CGFloat)size{
   
    NSString *fontName = [UIFont systemFontOfSize:[UIFont systemFontSize]].familyName;
    NSString *tempContent = [NSString stringWithFormat:@"<style>strong{color:#01579b;} a {color:#1BA8FF;text-decoration: none;}</style><span style=\"font-family: %@; font-size: %.0f;color:#01579b;\">%@</span>",fontName,size, self];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithHTMLData:[tempContent dataUsingEncoding:NSUTF8StringEncoding] options:0 documentAttributes:nil]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.3f];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
    [attrStr enumerateAttributesInRange:NSMakeRange(0, [attrStr length]) options:NSAttributedStringEnumerationReverse usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
         if ([attributes valueForKey:@"DTGUID"] != nil) {
             [attrStr removeAttribute:@"CTForegroundColorFromContext" range:range];
         }
     }];
    
    return attrStr;
}

- (NSMutableAttributedString*)descriptionAttributeString{
    NSString *fontName = [UIFont systemFontOfSize:[UIFont systemFontSize]].familyName;
    
    NSString *tempContent = [NSString stringWithFormat:@"<style>strong{color:rgba(0,0,0,0.87);} a {color:#1BA8FF;text-decoration: none;}</style><span style=\"font-family: %@; font-size: 14;color:rgba(0,0,0,0.54);\">%@</span>",fontName, self];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithHTMLData:[tempContent dataUsingEncoding:NSUTF8StringEncoding] options:0 documentAttributes:nil]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.3f];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
    [attrStr enumerateAttributesInRange:NSMakeRange(0, [attrStr length]) options:NSAttributedStringEnumerationReverse usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
         if ([attributes valueForKey:@"DTGUID"] != nil) {
             [attrStr removeAttribute:@"CTForegroundColorFromContext" range:range];
         }
     }];
    
    return attrStr;
}

- (NSMutableAttributedString*)promotionAttributeString {
    NSString *fontName = [UIFont systemFontOfSize:[UIFont systemFontSize]].familyName;
    
    NSString *tempContent = [NSString stringWithFormat:@"<style>strong{color:rgb(255,0,0);} a {color:#1BA8FF;text-decoration: none;}</style><span style=\"font-family: %@; font-size: 14;color:rgba(0,0,0,0.54);\">%@</span>",fontName, self];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithHTMLData:[tempContent dataUsingEncoding:NSUTF8StringEncoding] options:0 documentAttributes:nil]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.3f];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
    [attrStr enumerateAttributesInRange:NSMakeRange(0, [attrStr length]) options:NSAttributedStringEnumerationReverse usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
         if ([attributes valueForKey:@"DTGUID"] != nil) {
             [attrStr removeAttribute:@"CTForegroundColorFromContext" range:range];
         }
     }];
    
    return attrStr;
}


+ (BOOL)compareVersion:(NSString*)versionOne biggerToVersion:(NSString*)versionTwo {
    NSArray* versionOneComp = [versionOne componentsSeparatedByString:@"."];
    NSArray* versionTwoComp = [versionTwo componentsSeparatedByString:@"."];
    
    NSInteger pos = 0;
    
    while ([versionOneComp count] > pos || [versionTwoComp count] > pos) {
        NSInteger v1 = [versionOneComp count] > pos ? [[versionOneComp objectAtIndex:pos] integerValue] : 0;
        NSInteger v2 = [versionTwoComp count] > pos ? [[versionTwoComp objectAtIndex:pos] integerValue] : 0;
        if (v1 < v2) {
            return NO;
        }
        pos++;
    }
    
    return YES;
}

- (NSMutableAttributedString*)informationAttributeString {
    return [self informationAttributeStringWithFontSize:14];
}
- (NSMutableAttributedString*)informationAttributeStringWithFontSize:(CGFloat)fontSize {
    NSString *fontName = [UIFont systemFontOfSize:[UIFont systemFontSize]].familyName;
    
    NSString *tempContent = [NSString stringWithFormat:@"<style>strong{color:rgba(0,0,0,0.87);} a {color:#1BA8FF;text-decoration: none;}</style><span style=\"font-family: %@; font-size: %.0f;color:rgba(0,0,0,0.54);\">%@</span>",fontName,fontSize, self];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithHTMLData:[tempContent dataUsingEncoding:NSUTF8StringEncoding] options:0 documentAttributes:nil]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.3f];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
    [attrStr enumerateAttributesInRange:NSMakeRange(0, [attrStr length]) options:NSAttributedStringEnumerationReverse usingBlock:
     ^(NSDictionary *attributes, NSRange range, BOOL *stop) {
         if ([attributes valueForKey:@"DTGUID"] != nil) {
             [attrStr removeAttribute:@"CTForegroundColorFromContext" range:range];
         }
     }];
    
    return attrStr;
}
- (NSString *)stringByDeletingWordsFromStringToFit:(CGRect)rect
                                         withInset:(CGFloat)inset
                                         usingFont:(UIFont *)font
{
    NSString *result = [self copy];
    CGSize maxSize = CGSizeMake(rect.size.width  - (inset * 2), FLT_MAX);
    if (!font) font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGRect boundingRect = [result boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font, } context:nil];
    CGSize size = boundingRect.size;
    NSRange range;
    
    if (rect.size.height < size.height)
        while (rect.size.height < size.height) {
            
            range = [result rangeOfString:@" "
                                  options:NSBackwardsSearch];
            
            if (range.location != NSNotFound && range.location > 0 ) {
                result = [result substringToIndex:range.location];
            } else {
                result = [result substringToIndex:result.length - 1];
            }
            
            if (!font) font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
            CGRect boundingRect = [result boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font, } context:nil];
            size = boundingRect.size;
        }
    
    return result;
}

- (NSString *)stringByDeletingWordsFromStringToFit:(CGRect)rect
                                         withInset:(CGFloat)inset
                                         usingFont:(UIFont *)font
                                          withText:(NSString *)text
                                    withExpandText:(NSString *)expandText {
    NSString *result = [text copy];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@" \n"];
    if (!font) font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize maxSize = CGSizeMake(rect.size.width  - (inset * 2), FLT_MAX);
    CGRect boundingRect = [result boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font, } context:nil];
    CGSize size = boundingRect.size;
    NSRange range;
    if (rect.size.height < size.height)
    while (rect.size.height < size.height) {
        range = [result rangeOfString:@" "
                              options:NSBackwardsSearch];
        if (range.location != NSNotFound && range.location > 0 ) {
            result = [result substringToIndex:range.location];
        } else {
            result = [result substringToIndex:result.length - 1];
        }
        NSString *temp = [result copy];
        temp = [temp stringByAppendingString:expandText];
        if (!font) font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        CGRect boundingRect = [temp boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font, } context:nil];
        size = boundingRect.size;
    }
    return result;
}
@end
