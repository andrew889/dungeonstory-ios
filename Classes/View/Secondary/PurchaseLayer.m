//
//  PurchaseLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 23/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "PurchaseLayer.h"
#import "GameManager.h"
#import "IAPManager.h"
#import "SoundManager.h"
#import "Utility.h"

#pragma mark - PurchaseLayer

@implementation PurchaseLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	PurchaseLayer *layer = [PurchaseLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
    if((self=[super init])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"SupportTheDeveloper", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:28]];
                
        [labelMsg setColor:ccc3(255, 204, 102)];
        
        [CCMenuItemFont setFontSize:32];
        [CCMenuItemFont setFontName:@"Shark Crash"];
        
        itemTip1 = [CCMenuItemFont itemWithString:NSLocalizedString(@"TipMsg01", nil)
                                           target:self selector:@selector(showTip1)];
        itemTip2 = [CCMenuItemFont itemWithString:NSLocalizedString(@"TipMsg02", nil)
                                           target:self selector:@selector(showTip2)];
        itemTip3 = [CCMenuItemFont itemWithString:NSLocalizedString(@"TipMsg03", nil)
                                           target:self selector:@selector(showTip3)];
        itemTip4 = [CCMenuItemFont itemWithString:NSLocalizedString(@"TipMsg04", nil)
                                           target:self selector:@selector(showTip4)];
        itemTip5 = [CCMenuItemFont itemWithString:NSLocalizedString(@"TipMsg05", nil)
                                           target:self selector:@selector(showTip5)];
        
        itemExit = [CCMenuItemImage itemWithNormalImage:@"back_btn.png"
                                          selectedImage:@"back_btn_pressed.png"
                                                 target:self
                                               selector:@selector(cancel)];
		
		menuChoice = [CCMenu menuWithItems:itemTip1, itemTip2, itemTip3, itemTip4,
                      itemTip5, nil];
        menuReturn = [CCMenu menuWithItems:itemExit, nil];
        
        [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {            
            if (screenSize.height == 568.00) {
                [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 240)];
                
                [menuReturn setPosition:ccp(screenSize.width/2 + 114, screenSize.height/2 - 225)];
            }
            else {
                [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 200)];
                
                [menuReturn setPosition:ccp(screenSize.width/2 + 114, screenSize.height/2 - 190)];
            }
            
            [menuChoice alignItemsVerticallyWithPadding:25];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (200 * 2.133f))];
            
            [menuChoice alignItemsVerticallyWithPadding:(25 * 2.4f)];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [menuReturn setPosition:ccp(screenSize.width/2 + (110 * 2.4f), screenSize.height/2 - (190 * 2.133f))];
        }
        
        [self addChild:labelMsg z:1 tag:0];
		[self addChild:menuChoice z:1 tag:1];
        [self addChild:menuReturn z:1 tag:2];
        
        [self scheduleUpdate];
        
        productArray = nil;
        
        [[IAPManager sharedIAPManager] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
            if (success) {
                productArray = products;
            }
        }];
        
        purchaseChoice = 0;
        
        priceFormatter = [[NSNumberFormatter alloc] init];
        
        [priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(productPurchased:)
                   name:IAPManagerProductPurchasedNotification
                 object:nil];
	}
    
	return self;
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if (itemTip1.isSelected || itemTip2.isSelected ||
        itemTip3.isSelected || itemTip4.isSelected ||
        itemTip5.isSelected || itemExit.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemTip1.isSelected && !itemTip2.isSelected &&
             !itemTip3.isSelected && !itemTip4.isSelected &&
             !itemTip5.isSelected && !itemExit.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// cancels the selection
-(void)cancel
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneMenu withTransition:NO];
}

-(void)showTip1
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:7];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 1;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"TipWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showTip2
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:8];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 2;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"TipWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showTip3
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:9];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 3;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"TipWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showTip4
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:10];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 4;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"TipWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showTip5
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:11];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 5;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"TipWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1 && purchaseChoice == 1) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:7];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 2) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:8];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 3) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:9];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 4) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:10];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 5) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:11];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
}

-(void)productPurchased:(NSNotification *)notification
{
    NSString *productIdentifier = notification.object;
    
    [productArray enumerateObjectsUsingBlock:^(SKProduct *product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {            
            *stop = YES;
        }
    }];
}

#pragma mark - various

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
