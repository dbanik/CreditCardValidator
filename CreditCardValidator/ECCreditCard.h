//
//  ECCreditCard.h
//  CreditCardValidator
//
//  Created by Debaprio Banik on 4/23/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECCreditCardConstants.h"

@interface ECCreditCard : NSObject

/*!
 cardIssuer
 @details  String property to hold the name of the card issuer
 */
@property(nonatomic, readonly) NSString* cardIssuer;

/*!
 isValid
 @details  BOOL property to hold the validity of the credit card
 */
@property(nonatomic, readonly) BOOL isValid;


/**
 *  Method to initialize ECCreditCard instance
 *  @param creditCardNumber     A string containing the credit card number.
 */
- (instancetype)initWithCreditCardNumber:(NSString*)creditCardNumber;

@end
