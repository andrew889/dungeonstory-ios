//
//  StoreLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 23/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "StoreLayer.h"
#import "GameManager.h"
#import "IAPManager.h"
#import "Player.h"
#import "SoundManager.h"
#import "Utility.h"

#pragma mark - StoreLayer

@implementation StoreLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	StoreLayer *layer = [StoreLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
    if((self=[super init])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"BecomeAwesome", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:28]];
        
        [labelMsg setColor:ccc3(255, 204, 102)];
        
        [CCMenuItemFont setFontSize:[Utility getFontSize:32]];
        [CCMenuItemFont setFontName:@"Shark Crash"];
        
        itemUnlock01 = [CCMenuItemFont itemWithString:NSLocalizedString(@"UnlockMsg01", nil)
                                               target:self selector:@selector(showUnlock01)];
        itemUnlock02 = [CCMenuItemFont itemWithString:NSLocalizedString(@"UnlockMsg02", nil)
                                               target:self selector:@selector(showUnlock02)];
        itemUnlock03 = [CCMenuItemFont itemWithString:NSLocalizedString(@"UnlockMsg03", nil)
                                               target:self selector:@selector(showUnlock03)];
        itemUnlock04 = [CCMenuItemFont itemWithString:NSLocalizedString(@"UnlockMsg04", nil)
                                               target:self selector:@selector(showUnlock04)];
        itemUnlock05 = [CCMenuItemFont itemWithString:NSLocalizedString(@"UnlockMsg05", nil)
                                               target:self selector:@selector(showUnlock05)];
        
        itemGold01 = [CCMenuItemFont itemWithString:NSLocalizedString(@"BuyGold01", nil)
                                             target:self selector:@selector(showGold01)];
        itemGold02 = [CCMenuItemFont itemWithString:NSLocalizedString(@"BuyGold02", nil)
                                             target:self selector:@selector(showGold02)];
        itemGold03 = [CCMenuItemFont itemWithString:NSLocalizedString(@"BuyGold03", nil)
                                             target:self selector:@selector(showGold03)];
        itemGold04 = [CCMenuItemFont itemWithString:NSLocalizedString(@"BuyGold04", nil)
                                             target:self selector:@selector(showGold04)];
        itemGold05 = [CCMenuItemFont itemWithString:NSLocalizedString(@"BuyGold05", nil)
                                             target:self selector:@selector(showGold05)];
        
        nextPage1 = [CCMenuItemFont itemWithString:NSLocalizedString(@"nextPage", nil)
                                            target:self selector:@selector(showNextPage)];
        nextPage2 = [CCMenuItemFont itemWithString:NSLocalizedString(@"nextPage", nil)
                                            target:self selector:@selector(showNextPage)];
        
        itemExit = [CCMenuItemImage itemWithNormalImage:@"back_btn.png"
                                          selectedImage:@"back_btn_pressed.png"
                                                 target:self
                                               selector:@selector(cancel)];
		
		menuChoice1 = [CCMenu menuWithItems:itemUnlock04, itemUnlock02, itemUnlock03,
                       itemUnlock01, itemUnlock05, nextPage1, nil];
        menuChoice2 = [CCMenu menuWithItems:itemGold01, itemGold02, itemGold03, itemGold04,
                       itemGold05, nextPage2, nil];
        menuReturn = [CCMenu menuWithItems:itemExit, nil];
        
        [menuChoice1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [menuChoice2 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {            
            if (screenSize.height == 568.00) {
                [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 240)];
                
                [menuReturn setPosition:ccp(screenSize.width/2 + 114, screenSize.height/2 - 225)];
            }
            else {
                [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 200)];
                
                [menuReturn setPosition:ccp(screenSize.width/2 + 114, screenSize.height/2 - 190)];
            }
            
            [menuChoice1 alignItemsVerticallyWithPadding:25];
            [menuChoice1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [menuChoice2 alignItemsVerticallyWithPadding:25];
            [menuChoice2 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (200 * 2.133f))];
            
            [menuChoice1 alignItemsVerticallyWithPadding:(25 * 2.4f)];
            [menuChoice1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [menuChoice2 alignItemsVerticallyWithPadding:(25 * 2.4f)];
            [menuChoice2 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [menuReturn setPosition:ccp(screenSize.width/2 + (110 * 2.4f), screenSize.height/2 - (190 * 2.133f))];
        }
        
        [self addChild:labelMsg z:1 tag:0];
		[self addChild:menuChoice1 z:1 tag:1];
        [self addChild:menuChoice2 z:1 tag:2];
        [self addChild:menuReturn z:1 tag:3];
        
        menuChoice2.visible = NO;
        
        [self scheduleUpdate];

        if ([[Player sharedPlayer] emblems] == 4) {
            itemUnlock01.isEnabled = NO;
        }
        
        if ([[Player sharedPlayer] shield] == 2) {
            itemUnlock02.isEnabled = NO;
        }
        
        if ([[Player sharedPlayer] potion] == 1 &&
            [[Player sharedPlayer] bomb] == 1 &&
            [[Player sharedPlayer] ale] == 1 &&
            [[Player sharedPlayer] rune] == 1 &&
            [[Player sharedPlayer] mirror] == 1 &&
            [[Player sharedPlayer] flute] == 1) {
            
            itemUnlock03.isEnabled = NO;
        }
        
        if ([[GameManager sharedGameManager] isDoubleCoin]) {
            itemUnlock04.isEnabled = NO;
        }
        
        if ([[GameManager sharedGameManager] hasPurchasedHardMode]) {
            itemUnlock05.isEnabled = NO;
        }

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
    if (itemUnlock01.isSelected || itemUnlock02.isSelected ||
        itemUnlock03.isSelected || itemUnlock04.isSelected ||
        itemExit.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemUnlock01.isSelected && !itemUnlock02.isSelected &&
             !itemUnlock03.isSelected && !itemUnlock04.isSelected &&
             !itemExit.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// cancels the selection
-(void)cancel
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneMenu withTransition:NO];
}

-(void)showNextPage
{
    if (menuChoice1.visible == YES) {
        menuChoice1.visible = NO;
        menuChoice2.visible = YES;
    }
    else {
        menuChoice1.visible = YES;
        menuChoice2.visible = NO;
    }
}

-(void)showUnlock01
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:12];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 1;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showUnlock02
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:13];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 2;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showUnlock03
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:14];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 3;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showUnlock04
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:0];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 4;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showUnlock05
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:6];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 5;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showGold01
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:1];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 6;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showGold02
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:2];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 7;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showGold03
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:3];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 8;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showGold04
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:4];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 9;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)showGold05
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
	
    [dialog setDelegate:self];
    
    SKProduct *product = (SKProduct*)[productArray objectAtIndex:5];
    
    [priceFormatter setLocale:product.priceLocale];
    
    purchaseChoice = 10;
    
    [dialog setTitle:product.localizedTitle];
    [dialog setMessage:[NSString stringWithFormat:NSLocalizedString(@"UpgradeWorths", nil), product.localizedDescription,
                        [priceFormatter stringFromNumber:product.price]]];
	
    [dialog addButtonWithTitle:NSLocalizedString(@"TipNope", nil)];
	[dialog addButtonWithTitle:NSLocalizedString(@"TipSure", nil)];
    
    [dialog show];
}

-(void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1 && purchaseChoice == 1) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:12];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 2) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:13];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 3) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:14];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 4) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:0];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 5) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:6];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 6) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:1];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 7) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:2];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 8) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:3];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 9) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:4];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
    else if(buttonIndex == 1 && purchaseChoice == 10) {
        SKProduct *product = (SKProduct*)[productArray objectAtIndex:5];
        
        NSLog(@"Buying %@...", product.productIdentifier);
        [[IAPManager sharedIAPManager] buyProduct:product];
    }
}

-(void)productPurchased:(NSNotification *)notification
{
    NSString *productIdentifier = notification.object;
    
    [productArray enumerateObjectsUsingBlock:^(SKProduct *product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            if (purchaseChoice == 1) {
                for (int i = [[Player sharedPlayer] emblems]; i < 4; i++) {
                    [[GameManager sharedGameManager] writeEmblemProgress];
                }
                
                itemUnlock01.isEnabled = NO;
            }
            else if (purchaseChoice == 2) {
                [[GameManager sharedGameManager] writeShieldUpgradeData];
                
                itemUnlock02.isEnabled = NO;
            }
            else if (purchaseChoice == 3) {
                if ([[Player sharedPlayer] potion] == 0) {
                    [[GameManager sharedGameManager] writePotionUpgradeData];
                }
                
                if ([[Player sharedPlayer] bomb] == 0) {
                    [[GameManager sharedGameManager] writeBombUpgradeData];
                }
                
                if ([[Player sharedPlayer] ale] == 0) {
                    [[GameManager sharedGameManager] writeAleUpgradeData];
                }
                
                if ([[Player sharedPlayer] rune] == 0) {
                    [[GameManager sharedGameManager] writeRuneUpgradeData];
                }
                
                if ([[Player sharedPlayer] mirror] == 0) {
                    [[GameManager sharedGameManager] writeMirrorUpgradeData];
                }
                
                if ([[Player sharedPlayer] flute] == 0) {
                    [[GameManager sharedGameManager] writeFluteUpgradeData];
                }
                
                itemUnlock03.isEnabled = NO;
            }
            else if (purchaseChoice == 4) {
                [[GameManager sharedGameManager] writeDoubleCoinData];
                
                itemUnlock04.isEnabled = NO;
            }
            else if (purchaseChoice == 5) {
                [[GameManager sharedGameManager] writePurchasedHardModeData];
                
                itemUnlock05.isEnabled = NO;
            }
            else if (purchaseChoice == 6) {
                [[GameManager sharedGameManager] writeGatheredGold:1000];
            }
            else if (purchaseChoice == 7) {
                [[GameManager sharedGameManager] writeGatheredGold:3000];
            }
            else if (purchaseChoice == 8) {
                [[GameManager sharedGameManager] writeGatheredGold:10000];
            }
            else if (purchaseChoice == 9) {
                [[GameManager sharedGameManager] writeGatheredGold:25000];
            }
            else if (purchaseChoice == 10) {
                [[GameManager sharedGameManager] writeGatheredGold:200000];
            }
            
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
