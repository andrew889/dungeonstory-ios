//
//  IAPManager.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 10/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "cocos2d.h"

UIKIT_EXTERN NSString *const IAPManagerProductPurchasedNotification;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray *products);

@interface IAPManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    SKProductsRequest *productsRequest;
    
    RequestProductsCompletionHandler completionHandler;
    
    NSSet *productIdentifiers;
    NSMutableSet *purchasedProductIdentifiers;
}

+(IAPManager*)sharedIAPManager;

-(id)initWithProductIdentifiers:(NSSet*)productIdentifiers;

-(void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

-(void)buyProduct:(SKProduct*)product;
-(void)restoreCompletedTransactions;

-(BOOL)productPurchased:(NSString*)productIdentifier;

@end
