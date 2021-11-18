//
//  NSString+Additions.m
//  TikiProject
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

+ (NSNumberFormatter*)sharedNumberFormatter
{
    static NSNumberFormatter *sharedNumberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNumberFormatter = [[NSNumberFormatter alloc] init];
        [sharedNumberFormatter setGroupingSeparator:@"."];
        [sharedNumberFormatter setUsesGroupingSeparator:YES];
        [sharedNumberFormatter setDecimalSeparator:@","];
        [sharedNumberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        // Do any other initialisation stuff here
    });
    return sharedNumberFormatter;
}

+ (NSString *)converToVNKhongDau:(NSString *)originalString
{
    NSMutableArray  *stringCompares = [[NSMutableArray alloc] initWithObjects:
                                       @"á",@"à",@"ả",@"ã",@"ạ",
                                       @"ă",@"ắ",@"ằ",@"ẳ",@"ẵ",@"ặ",
                                       @"â",@"ấ",@"ầ",@"ẩ",@"ẫ",@"ậ",@"đ",
                                       @"é",@"è",@"ẻ",@"ẽ",@"ẹ",
                                       @"ê",@"ế",@"ề",@"ể",@"ễ",@"ệ",
                                       @"í",@"ì",@"ỉ",@"ĩ",@"ị",
                                       @"ó",@"ò",@"ỏ",@"õ",@"ọ",
                                       @"ô",@"ố",@"ồ",@"ổ",@"ỗ",@"ộ",
                                       @"ơ",@"ớ",@"ờ",@"ở",@"ỡ",@"ợ",
                                       @"ú",@"ù",@"ủ",@"ũ",@"ụ",
                                       @"ư",@"ứ",@"ừ",@"ử",@"ữ",@"ự",
                                       @"ý",@"ỳ",@"ỷ",@"ỹ",@"ỵ",
                                       
                                       @"Á",@"À",@"Ả",@"Ã",@"Ạ",
                                       @"Ă",@"Ắ",@"Ằ",@"Ẳ",@"Ẵ",@"Ặ",
                                       @"Â",@"Ấ",@"Ầ",@"Ẩ",@"Ẫ",@"Ậ",
                                       @"Đ",
                                       @"É",@"È",@"Ẻ",@"Ẽ",@"Ẹ",
                                       @"Ê",@"Ế",@"Ề",@"Ể",@"Ễ",@"Ệ",
                                       @"Í",@"Ì",@"Ỉ",@"Ĩ",@"Ị",
                                       @"Ó",@"Ò",@"Ỏ",@"Õ",@"Ọ",
                                       @"Ô",@"Ố",@"Ồ",@"Ổ",@"Ỗ",@"Ộ",
                                       @"Ơ",@"Ớ",@"Ờ",@"Ở",@"Ỡ",@"Ợ",
                                       @"Ú",@"Ù",@"Ủ",@"Ũ",@"Ụ",
                                       @"Ư",@"Ứ",@"Ừ",@"Ử",@"Ữ",@"Ự",
                                       @"Ý",@"Ỳ",@"Ỷ",@"Ỹ",@"Ỵ"
                                       ,nil];
    NSMutableArray *stringReplace = [[NSMutableArray alloc] initWithObjects:@"a",@"a",@"a",@"a",@"a",
                                     @"a",@"a",@"a",@"a",@"a",@"a",
                                     @"a",@"a",@"a",@"a",@"a",@"a",
                                     @"d",
                                     @"e",@"e",@"e",@"e",@"e",
                                     @"e",@"e",@"e",@"e",@"e",@"e",
                                     @"i",@"i",@"i",@"i",@"i",
                                     @"o",@"o",@"o",@"o",@"o",
                                     @"o",@"o",@"o",@"o",@"o",@"o",
                                     @"o",@"o",@"o",@"o",@"o",@"o",
                                     @"u",@"u",@"u",@"u",@"u",
                                     @"u",@"u",@"u",@"u",@"u",@"u",
                                     @"y",@"y",@"y",@"y",@"y",
                                     
                                     @"A",@"A",@"A",@"A",@"A",
                                     @"A",@"A",@"A",@"A",@"A",@"A",
                                     @"A",@"A",@"A",@"A",@"A",@"A",
                                     @"D",
                                     @"E",@"E",@"E",@"E",@"E",
                                     @"E",@"E",@"E",@"E",@"E",@"E",
                                     @"I",@"I",@"I",@"I",@"I",
                                     @"O",@"O",@"O",@"O",@"O",
                                     @"O",@"O",@"O",@"O",@"O",@"O",
                                     @"O",@"O",@"O",@"O",@"O",@"O",
                                     @"U",@"U",@"U",@"U",@"U",
                                     @"U",@"U",@"U",@"U",@"U",@"U",
                                     @"Y",@"Y",@"Y",@"Y",@"Y",nil];
    
    NSString * result = [originalString copy];
    for (int i=0; i < result.length; i++ ) {
        unichar subchar = [result characterAtIndex:i];
        NSString *substring = [NSString stringWithFormat:@"%C",subchar];
        for (int j = 0; j < [stringCompares count]; j++) {
            if ([substring isEqualToString:[stringCompares objectAtIndex:j]]) {
                result = [result stringByReplacingOccurrencesOfString:substring withString:[stringReplace objectAtIndex:j]];
            }
        }
    }
    return result;
}

+ (NSString *)thousandSeparatorFromNumber:(double)number
                            withGroupSize:(NSInteger)groupSize
                         andFractionDigit:(NSInteger)fraction
{
    // Vietnamese number format
    NSNumberFormatter *numberFormatter = [NSString sharedNumberFormatter];
    [numberFormatter setGroupingSize:groupSize];
    [numberFormatter setMaximumFractionDigits:fraction];
    NSString * resultString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return resultString;
}

+ (NSString *)thousandWithNumber:(float)number {
    long numberOfInt = number;
    
    long partNatural = numberOfInt /1000 ;
    
    if (partNatural > 0) {
        
        partNatural = partNatural + ((numberOfInt % 1000  > 0) ? 1 : 0);
        
        return [NSString stringWithFormat:@"%@K",[NSString thousandSeparatorFromNumber:partNatural
                                                                         withGroupSize:3
                                                                      andFractionDigit:0]];
    }
    
    return nil;
}
+ (NSString *)priceWithNumber:(float)number {
    NSString *price = [NSString thousandSeparatorFromNumber:number
                                              withGroupSize:3
                                           andFractionDigit:0];
    price = [price stringByAppendingString:@" ₫"];
    return price;
}

- (NSString *)appendingNotNullString:(NSString *)input
{
    return input.length ? [NSString stringWithFormat:@"%@\n%@", self, input] : self;
}

- (BOOL)isEmptyString {
    if ((NSNull *) self == [NSNull null]) {
        return YES;
    }
    if (self == nil) {
        return YES;
    }
    if ([self length] == 0) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)timeFormatForInterval:(double)interval {
    unsigned long milliseconds = interval;
    unsigned long seconds = milliseconds / 1000;
//    milliseconds %= 1000;
    unsigned long minutes = seconds / 60;
    seconds %= 60;
    unsigned long hours = minutes / 60;
    minutes %= 60;
    
    NSMutableString * result = [NSMutableString new];
    
    if(hours)
        [result appendFormat: @"%lu:", hours];
    
    if (minutes < 10)
        [result appendFormat:@"0%lu", minutes];
    else
        [result appendFormat: @"%lu:", minutes];
    
    if (seconds < 10)
        [result appendFormat:@"0%lu", seconds];
    else
        [result appendFormat: @"%lu", seconds];
    
    return result;
}

- (NSString *)stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceCharacterSet]];
}

@end
