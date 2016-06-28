//
//  ECCreditCard.m
//  CreditCardValidator
//
//  Created by Debaprio Banik on 4/23/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import "ECCreditCard.h"


@interface ECCreditCard ()

@property(nonatomic, readwrite) NSString* cardIssuer;
@property(nonatomic, readwrite) BOOL isValid;
@property(nonatomic, readwrite) NSString* cardNumberStr;

@end

@implementation ECCreditCard

- (instancetype)initWithCreditCardNumber:(NSString*)creditCardNumber
{
    self = [super init];
    if (self)
    {
        self.cardNumberStr = creditCardNumber;
        self.isValid = NO;
        self.cardIssuer = kUnknown;
        
        if (YES == [self scanForNonDigits])
        {
            if (YES == [self validateIdentificationNumber])
            {
                if (YES == [self validateCheckDigit])
                {
                    self.isValid = YES;
                }
            }
        }
    }
    return self;
}

/**
 *  Private method to scan the credit card number for any non-acceptable digits
 */
- (BOOL)scanForNonDigits
{
    if (self.cardNumberStr.length > 0)
    {
        NSString *tempString = [NSString string];
        NSCharacterSet* digits = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        NSScanner *scanner = [NSScanner scannerWithString:self.cardNumberStr];
        [scanner scanCharactersFromSet:digits intoString:&tempString];
        if(self.cardNumberStr.length == tempString.length)
        {
            return YES;
        }
    }
    return NO;
}

/**
 *  Private method to validate IIN and set the card issuer
 */
- (BOOL)validateIdentificationNumber
{
    if (self.cardNumberStr.length == 13)
    {
        //Length is 13, we need to check for Visa only.
        NSInteger iin = [self.cardNumberStr substringToIndex:1].integerValue;
        if (4 == iin)
        {
            self.cardIssuer = kVisa;
            return YES;
        }
        return NO;
    }
    else if (self.cardNumberStr.length == 15)
    {
        //Length is 15, we need to check for AmEx only.
        NSInteger iin = [self.cardNumberStr substringToIndex:2].integerValue;
        if (34 == iin || 37 == iin)
        {
            self.cardIssuer = kAmericanExpress;
            return YES;
        }
        return NO;
    }
    else if (self.cardNumberStr.length == 16)
    {
        //Length is 16. It can be MasterCard, Visa or Discover.
        
        //Lets test IIN validation range 1.
        NSInteger iin = [self.cardNumberStr substringToIndex:1].integerValue;
        if (4 == iin)
        {
            self.cardIssuer = kVisa;
            return YES;
        }
        
        //Lets test IIN validation range 2.
        iin = [self.cardNumberStr substringToIndex:2].integerValue;
        if (65 == iin)
        {
            self.cardIssuer = kDiscover;
            return YES;
        }
        for (NSInteger i=51; i<=55; i++)
        {
            if (i == iin)
            {
                self.cardIssuer = kMasterCard;
                return YES;
            }
        }
        
        //Lets test IIN validation range 3.
        iin = [self.cardNumberStr substringToIndex:3].integerValue;
        for (NSInteger i=644; i<=649; i++)
        {
            if (i == iin)
            {
                self.cardIssuer = kDiscover;
                return YES;
            }
        }
        
        //Lets test IIN validation range 4.
        iin = [self.cardNumberStr substringToIndex:4].integerValue;
        if (6011 == iin)
        {
            self.cardIssuer = kDiscover;
            return YES;
        }
        for (NSInteger i=2221; i<=2720; i++)
        {
            if (i == iin)
            {
                self.cardIssuer = kMasterCard;
                return YES;
            }
        }
        
        //Lets test IIN validation range 6.
        iin = [self.cardNumberStr substringToIndex:6].integerValue;
        for (NSInteger i=622126; i<=622925; i++)
        {
            if (i == iin)
            {
                self.cardIssuer = kDiscover;
                return YES;
            }
        }
        return NO;
    }
    else if (self.cardNumberStr.length == 19)
    {
        //Length is 16. It can be Visa or Discover.
        
        //Lets test IIN validation range 1.
        NSInteger iin = [self.cardNumberStr substringToIndex:1].integerValue;
        if (4 == iin)
        {
            self.cardIssuer = kVisa;
            return YES;
        }
        
        //Lets test IIN validation range 2.
        iin = [self.cardNumberStr substringToIndex:2].integerValue;
        if (65 == iin)
        {
            self.cardIssuer = kDiscover;
            return YES;
        }
        
        //Lets test IIN validation range 3.
        iin = [self.cardNumberStr substringToIndex:3].integerValue;
        for (NSInteger i=644; i<=649; i++)
        {
            if (i == iin)
            {
                self.cardIssuer = kDiscover;
                return YES;
            }
        }
        
        //Lets test IIN validation range 4.
        iin = [self.cardNumberStr substringToIndex:4].integerValue;
        if (6011 == iin)
        {
            self.cardIssuer = kDiscover;
            return YES;
        }

        //Lets test IIN validation range 6.
        iin = [self.cardNumberStr substringToIndex:6].integerValue;
        for (NSInteger i=622126; i<=622925; i++)
        {
            if (i == iin)
            {
                self.cardIssuer = kDiscover;
                return YES;
            }
        }
    }
    
    return NO;
}

/**
 *  Private method to validate the check digit
 */
- (BOOL)validateCheckDigit
{
    NSInteger creditCardLength = self.cardNumberStr.length;
    NSInteger checkDigit = [self.cardNumberStr substringFromIndex:creditCardLength-1].integerValue;
    NSInteger checksum = 0;
    
    for (NSInteger i=creditCardLength-2; i>=0; i-=2)
    {
        NSInteger doubleVal = 2 * [self.cardNumberStr substringWithRange:NSMakeRange(i, 1)].integerValue;
        if (doubleVal > 9)
        {
            doubleVal -=9;
        }
        checksum +=doubleVal;
    }
    
    for (NSInteger i=creditCardLength-3; i>=0; i-=2)
    {
        checksum +=[self.cardNumberStr substringWithRange:NSMakeRange(i, 1)].integerValue;
    }
    
    checksum = checksum * 9;
    checksum = checksum % 10;
    
    if (checksum == checkDigit)
    {
        return YES;
    }
    
    return NO;
}

@end
