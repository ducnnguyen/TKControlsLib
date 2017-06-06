//
//  NSString+Additions.h
//  TikiProject
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)
+ (NSNumberFormatter*)sharedNumberFormatter;

+ (NSString *)converToVNKhongDau:(NSString *)originalString;
+ (NSString *)thousandSeparatorFromNumber:(double)number
                            withGroupSize:(NSInteger)groupSize
                         andFractionDigit:(NSInteger)fraction;
+ (NSString *)priceWithNumber:(float)number; //1000 000 - >1000.000 ₫
- (NSString *)appendingNotNullString:(NSString *)input;
- (BOOL)isEmptyString;
+ (NSString *)thousandWithNumber:(float)number;
+ (NSString *)timeFormatForInterval:(double)interval;
- (NSString *)stringByStrippingHTML;
- (NSString *)trimString;

@end
