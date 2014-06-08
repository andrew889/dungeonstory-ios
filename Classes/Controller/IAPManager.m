//
//  IAPManager.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 10/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "IAPManager.h"

@implementation IAPManager

static IAPManager *_sharedIAPManager = nil;

NSString *const IAPManagerProductPurchasedNotification = @"IAPManagerProductPurchasedNotification";

+(IAPManager*)sharedIAPManager
{
    static dispatch_once_t pred = 0;
    
    __strong static id _sharedIAPManager = nil;
    
    dispatch_once(&pred, ^{
        NSSet *productIdentifiers = [NSSet setWithObjects:
                                     @"com.pantazisdeligiannis.dungeonstory.doublecoins",
                                     @"com.pantazisdeligiannis.dungeonstory.tipjar01",
                                     @"com.pantazisdeligiannis.dungeonstory.tipjar02",
                                     @"com.pantazisdeligiannis.dungeonstory.tipjar03",
                                     @"com.pantazisdeligiannis.dungeonstory.tipjar04",
                                     @"com.pantazisdeligiannis.dungeonstory.tipjar05",
                                     @"com.pantazisdeligiannis.dungeonstory.unlock01",
                                     @"com.pantazisdeligiannis.dungeonstory.unlock02",
                                     @"com.pantazisdeligiannis.dungeonstory.unlock03",
                                     @"com.pantazisdeligiannis.dungeonstory.gold01",
                                     @"com.pantazisdeligiannis.dungeonstory.gold02",
                                     @"com.pantazisdeligiannis.dungeonstory.gold03",
                                     @"com.pantazisdeligiannis.dungeonstory.gold04",
                                     @"com.pantazisdeligiannis.dungeonstory.gold05",
                                     @"com.pantazisdeligiannis.dungeonstory.specialdungeon01",
                                     nil];
        
        _sharedIAPManager = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    
    return _sharedIAPManager;
}


+(id)alloc
{
    @synchronized ([IAPManager class])
    {
        NSAssert(_sharedIAPManager == nil,
                 @"Attempted to allocate a second instance of the IAP Manager singleton");
        _sharedIAPManager = [super alloc];
        
        return _sharedIAPManager;
    }
    
    return nil;
}

-(id)initWithProductIdentifiers:(NSSet*)productIds
{    
    if ((self = [super init])) {
        productIdentifiers = productIds;
        
        purchasedProductIdentifiers = [NSMutableSet set];
        
        for (NSString *productIdentifier in productIdentifiers) {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            
            if (productPurchased) {
                [purchasedProductIdentifiers addObject:productIdentifier];
                NSLog(@"Previously purchased: %@", productIdentifier);
            }
            else {
                NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    
    return self;
}

#pragma mark - in application purchases

-(void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)ch
{    
    completionHandler = [ch copy];
    
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
}

-(void)productsRequest:(SKProductsRequest*)request
    didReceiveResponse:(SKProductsResponse*)response
{
    NSLog(@"Loaded list of products...");
    
    productsRequest = nil;
    
    NSArray * skProducts = response.products;
    
    for (SKProduct * skProduct in skProducts) {
        NSLog(@"Found product: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
    }
    
    completionHandler(YES, skProducts);
    completionHandler = nil;
}

-(void)request:(SKRequest*)request didFailWithError:(NSError*)error
{
    NSLog(@"Failed to load list of products.");
    
    productsRequest = nil;
    
    completionHandler(NO, nil);
    completionHandler = nil;
}

-(BOOL)productPurchased:(NSString*)productIdentifier
{
    return [purchasedProductIdentifiers containsObject:productIdentifier];
}

-(void)buyProduct:(SKProduct*)product
{    
    NSLog(@"Buying %@...", product.productIdentifier);
    
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

-(void)paymentQueue:(SKPaymentQueue*)queue updatedTransactions:(NSArray*)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            
            default:
                break;
        }
    };
}

-(void)completeTransaction:(SKPaymentTransaction*)transaction
{
    NSLog(@"completeTransaction...");
    
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)restoreTransaction:(SKPaymentTransaction*)transaction
{
    NSLog(@"restoreTransaction...");
    
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)failedTransaction:(SKPaymentTransaction*)transaction
{    
    NSLog(@"failedTransaction...");
    
    if (transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)provideContentForProductIdentifier:(NSString*)productIdentifier
{
    [purchasedProductIdentifiers addObject:productIdentifier];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:IAPManagerProductPurchasedNotification
                                                        object:productIdentifier
                                                      userInfo:nil];
}

-(void)restoreCompletedTransactions
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

@end
