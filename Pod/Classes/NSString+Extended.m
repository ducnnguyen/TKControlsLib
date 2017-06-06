//
//  NSString+Extended.m
//  ZaoDich
//
//  Created by Ta Phuoc Hai on 9/9/14.
//  Copyright (c) 2014 TPH. All rights reserved.
//

#import "NSString+Extended.h"

#define HEXColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA1Color(r, g, b, a)   [UIColor colorWithRed:r green:g blue:b alpha:a]
#define RGB255Color(r, g, b)     [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:1.0]

@implementation NSString (Extended)

- (NSString *)urlencode
{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' ||
                   thisChar == '-' ||
                   thisChar == '_' ||
                   thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSInteger )getNumberInString {
        NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    NSArray *componentStr = [self componentsSeparatedByCharactersInSet:nonDigitCharacterSet];
    if (componentStr.count > 0) {
        NSString *numberInStr =  [componentStr componentsJoinedByString:@""];
        return [numberInStr integerValue];
        
    }
    return -1;
}

/*viết hoa chữ cái đầu tiên trong câu*/
-(NSString*)uppercaseFirstCharactor
{
    NSString *result = [self lowercaseString];
    if (result.length > 0) {
        result=[[[result substringToIndex:1] uppercaseString] stringByAppendingString:[result substringFromIndex:1]];
        return result;
    }
    return nil;
}

/* Đảo ngược chuỗi */
- (NSString *)reverseString
{
    NSUInteger stringLength = self.length;
    
    NSMutableString *reversedString = [[NSMutableString alloc] initWithCapacity:stringLength];
    while (stringLength) {
        [reversedString appendFormat:@"%C", [self characterAtIndex:--stringLength]];
    }
    return reversedString;
}

/* Cắt chuỗi */
- (NSString*)getWordInFirstCharactor:(int)len
{
    if (self.length <= len) {
        return self;
    }
    
    NSRange range;
    range.location = 0;
    range.length = len;
    
    NSString *cutString = [self substringWithRange:range];
    
    NSString *reverseString = [cutString reverseString];
    
    // Tìm ra khoảng trắng đầu tiên
    NSRange rgWhiteCharactor = [reverseString rangeOfString:@" "];
    rgWhiteCharactor.length = rgWhiteCharactor.location + 1;
    rgWhiteCharactor.location = 0;
    
    // Remove nó
    if (rgWhiteCharactor.length > self.length || rgWhiteCharactor.location > self.length) {
        return self;
    }
    NSString *result = [reverseString stringByReplacingCharactersInRange:rgWhiteCharactor withString:@""];
    result = [result reverseString];
    result = [result stringByAppendingString:@" ..."];
    return result;
}
- (NSMutableAttributedString*)tikiAttributeString:(CGFloat)size {
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attributedString beginEditing];
    [attributedString enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedString.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value) {
            UIFont *oldFont = (UIFont *)value;
            if ([oldFont.fontName isEqualToString:@"TimesNewRomanPSMT"]) {
                UIFont *tempFont = [UIFont systemFontOfSize:size];
                [attributedString addAttribute:NSFontAttributeName value:tempFont range:range];
                [attributedString addAttribute:NSForegroundColorAttributeName value:HEXColor(0x01579b) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldMT"]) {
                UIFont *tempFont = [UIFont boldSystemFontOfSize:size];
                [attributedString addAttribute:NSFontAttributeName value:tempFont range:range];
                [attributedString addAttribute:NSForegroundColorAttributeName value:HEXColor(0x01579b) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldItalicMT"]) {
                UIFont *tempFont = [UIFont italicSystemFontOfSize:size];
                [attributedString addAttribute:NSFontAttributeName value:tempFont range:range];
                [attributedString addAttribute:NSForegroundColorAttributeName value:HEXColor(0x01579b) range:range];
            }
        }
    }];
    
    [attributedString endEditing];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.3f];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    return attributedString;
}
- (NSMutableAttributedString*)descriptionAttributeString{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attributedString beginEditing];
    [attributedString enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attributedString.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value) {
            UIFont *oldFont = (UIFont *)value;
            if ([oldFont.fontName isEqualToString:@"TimesNewRomanPSMT"]) {
                UIFont *tempFont = [UIFont systemFontOfSize:14];
                [attributedString addAttribute:NSFontAttributeName value:tempFont range:range];
                [attributedString addAttribute:NSForegroundColorAttributeName value:RGB255Color(122, 121, 123) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldMT"]) {
                UIFont *tempFont = [UIFont boldSystemFontOfSize:14];
                [attributedString addAttribute:NSFontAttributeName value:tempFont range:range];
                [attributedString addAttribute:NSForegroundColorAttributeName value:RGBA255(0, 0, 0, 0.8) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldItalicMT"]) {
                UIFont *tempFont = [UIFont italicSystemFontOfSize:14];
                [attributedString addAttribute:NSFontAttributeName value:tempFont range:range];
            }
        }
    }];
    
    [attributedString endEditing];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.3f];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    return attributedString;
}
- (NSMutableAttributedString*)promotionAttributeString {
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attrStr beginEditing];
    
    [attrStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attrStr.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value) {
            UIFont *oldFont = (UIFont *)value;
            if ([oldFont.fontName isEqualToString:@"TimesNewRomanPSMT"]) {
                UIFont *tempFont = [UIFont systemFontOfSize:14];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
                [attrStr addAttribute:NSForegroundColorAttributeName value:RGB255Color(122, 121, 123) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldMT"]) {
                UIFont *tempFont = [UIFont boldSystemFontOfSize:14];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
                [attrStr addAttribute:NSForegroundColorAttributeName value:RGB255Color(255, 0, 0) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldItalicMT"]) {
                UIFont *tempFont = [UIFont italicSystemFontOfSize:14];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
            }
        }
    }];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.3f];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
    
    [attrStr endEditing];
    return attrStr;
}
- (NSMutableAttributedString *)promotionDetailAttributeString {
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attrStr beginEditing];
    
    [attrStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attrStr.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value) {
            UIFont *oldFont = (UIFont *)value;
            if ([oldFont.fontName isEqualToString:@"TimesNewRomanPSMT"]) {
                UIFont *tempFont = [UIFont systemFontOfSize:oldFont.pointSize > 14.f ? oldFont.pointSize : 14.f];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldMT"]) {
                UIFont *tempFont = [UIFont boldSystemFontOfSize:oldFont.pointSize > 14.f ? oldFont.pointSize : 14.f];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
                [attrStr addAttribute:NSForegroundColorAttributeName value:RGB255Color(255, 0, 0) range:range];
            }
        }
    }];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.2f];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
    
    [attrStr endEditing];
    return attrStr;
}
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
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

- (NSUInteger)numberOfWords {
    __block NSUInteger count = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                            options:NSStringEnumerationByWords|NSStringEnumerationSubstringNotRequired
                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                             count++;
                         }];
    return count;
}
- (NSMutableAttributedString*)informationAttributeString {
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attrStr beginEditing];
    
    [attrStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attrStr.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value) {
            UIFont *oldFont = (UIFont *)value;
            if ([oldFont.fontName isEqualToString:@"TimesNewRomanPSMT"]) {
                UIFont *tempFont = [UIFont systemFontOfSize:14];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
                [attrStr addAttribute:NSForegroundColorAttributeName value:RGBA1Color(0, 0, 0, 0.54) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldMT"]) {
                UIFont *tempFont = [UIFont boldSystemFontOfSize:14];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
                [attrStr addAttribute:NSForegroundColorAttributeName value:RGBA1Color(0, 0, 0, 0.87) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldItalicMT"]) {
                UIFont *tempFont = [UIFont italicSystemFontOfSize:14];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
            }
        }
    }];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineHeightMultiple:1.3f];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
    
    [attrStr endEditing];
    return attrStr;
}
- (NSMutableAttributedString*)informationAttributeStringWithFontSize:(int)fontSize {
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attrStr beginEditing];
    
    [attrStr enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attrStr.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value) {
            UIFont *oldFont = (UIFont *)value;
            if ([oldFont.fontName isEqualToString:@"TimesNewRomanPSMT"]) {
                UIFont *tempFont = [UIFont systemFontOfSize:fontSize];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
                [attrStr addAttribute:NSForegroundColorAttributeName value:RGBA1Color(0, 0, 0, 0.54) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldMT"]) {
                UIFont *tempFont = [UIFont boldSystemFontOfSize:fontSize];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
                [attrStr addAttribute:NSForegroundColorAttributeName value:RGBA1Color(0, 0, 0, 0.87) range:range];
            } else if ([oldFont.fontName isEqualToString:@"TimesNewRomanPS-BoldItalicMT"]) {
                UIFont *tempFont = [UIFont italicSystemFontOfSize:fontSize];
                [attrStr addAttribute:NSFontAttributeName value:tempFont range:range];
            }
        }
    }];
    
    [attrStr endEditing];
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


@end
