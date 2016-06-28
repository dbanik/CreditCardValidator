//
//  CreditCardValidatorTests.m
//  CreditCardValidatorTests
//
//  Created by Debaprio Banik on 4/23/16.
//  Copyright © 2016 Debaprio Banik. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ECCreditCard.h"

@interface CreditCardValidatorTests : XCTestCase

@end

@implementation CreditCardValidatorTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Testing Unknown and Invalid CreditCards

- (void)testInvalidCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"4441222"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kUnknown);
}

- (void)testInvalid13DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"5444411112222"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kUnknown);
}

- (void)testInvalid15DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"544441111222280"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kUnknown);
}

- (void)testInvalid16DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"8111111111111111"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kUnknown);
}

- (void)testInvalid19DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"6099000990139424555"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kUnknown);
}

- (void)testInvalid20DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"60990009901394245559"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kUnknown);
}

#pragma mark - Testing Visa CreditCards

- (void)testVisa13DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"4222222222222"];
    XCTAssertTrue(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kVisa);
}

- (void)testVisa13DigitInvalidCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"4222222002222"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kVisa);
}

- (void)testVisa16DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"4111111111111111"];
    XCTAssertTrue(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kVisa);
}

- (void)testVisa16DigitInvalidCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"4111111555111111"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kVisa);
}

- (void)testVisa19DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"4111111111111111110"];
    XCTAssertTrue(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kVisa);
}

- (void)testVisa19DigitInvalidCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"4012888888881881772"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kVisa);
}

#pragma mark - Testing MasterCard CreditCards

- (void)testMasterCardCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"5105105105105100"];
    XCTAssertTrue(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kMasterCard);
    
    creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"5555555555554444"];
    XCTAssertTrue(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kMasterCard);
}

- (void)testMasterCardInvalidCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"5105105100105100"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kMasterCard);
}

#pragma mark - Testing Discover CreditCards

- (void)testDiscover16DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"6011111111111117"];
    XCTAssertTrue(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kDiscover);
}

- (void)testDiscover16DigitInvlidCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"6011111115991117"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kDiscover);
}

- (void)testDiscover19DigitCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"6011111111111117224"];
    XCTAssertTrue(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kDiscover);
}

- (void)testDiscover19DigitInvalidCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"6011000990139424555"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kDiscover);
}

#pragma mark - Testing American Express CreditCards

- (void)testAmericanExpressCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"378282246310005"];
    XCTAssertTrue(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kAmericanExpress);
    
    creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"371449635398431"];
    XCTAssertTrue(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kAmericanExpress);
}

- (void)testAmericanExpressInvalidCreditCard
{
    ECCreditCard *creditCard = [[ECCreditCard alloc] initWithCreditCardNumber:@"371449635398931"];
    XCTAssertFalse(creditCard.isValid);
    XCTAssertEqualObjects(creditCard.cardIssuer, kAmericanExpress);
}



@end
