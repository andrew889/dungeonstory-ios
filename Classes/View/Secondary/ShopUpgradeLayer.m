//
//  ShopUpgradeLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 21/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "ShopUpgradeLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "InventoryLayer.h"
#import "ShopLayer.h"
#import "Utility.h"

#pragma mark - ShopUpgradeLayer

@implementation ShopUpgradeLayer

-(id)initWithChoice:(int)choice
           withItem:(NSString*)item
{
	if((self=[super initWithColor:ccc4(0, 0, 0, 255)
                         fadingTo:ccc4(40, 40, 40, 255)])) {
        
		screenSize = [[CCDirector sharedDirector] winSize];
        
        choiceVal = choice;
        itemName = item;
        
        [self setupShopMenu];
        
        labelGold = [CCLabelTTF labelWithString:NSLocalizedString(@"UpgradeMsg01", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]];
        labelShop = [CCLabelTTF labelWithString:NSLocalizedString(@"UpgradeMsg02", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]];
        
        [CCMenuItemFont setFontSize:[Utility getFontSize:32]];
        [CCMenuItemFont setFontName:@"Shark Crash"];
        
        [labelGold setColor:ccc3(255, 182, 18)];
        [labelShop setColor:ccc3(0, 255, 127)];
        [labelMsg2 setColor:ccc3(255, 204, 102)];
        [labelCostVal setColor:ccc3(255, 182, 18)];
        
        itemMsg1 = [CCMenuItemLabel itemWithLabel:labelMsg1];
        itemMsg2 = [CCMenuItemLabel itemWithLabel:labelMsg2];
        itemCost = [CCMenuItemLabel itemWithLabel:labelCost];
        itemCostVal = [CCMenuItemLabel itemWithLabel:labelCostVal];
        
        itemCancel = [CCMenuItemFont itemWithString:NSLocalizedString(@"Cancel", nil)
                                             target:self selector:@selector(cancel)];
        itemUpgrade = [CCMenuItemFont itemWithString:NSLocalizedString(@"Upgrade", nil)
                                              target:self selector:@selector(upgrade)];
		
        menuItem = [CCMenu menuWithItems:itemMsg1, itemMsg2, nil];
        menuCost = [CCMenu menuWithItems:itemCost, itemCostVal, nil];
		menuChoice = [CCMenu menuWithItems:itemCancel, itemUpgrade, nil];
        
        [labelGold setAnchorPoint:ccp(0, 0)];
        [labelGoldVal setAnchorPoint:ccp(1, 0)];
        
        [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [labelGold setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 244)];
                [labelGoldVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 244)];
                
                [labelShop setPosition:ccp(screenSize.width/2, screenSize.height/2 + 184)];
                [menuItem alignItemsHorizontallyWithPadding:10];
                [menuItem setPosition:ccp(screenSize.width/2, screenSize.height/2 + 90)];
                [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 10)];
                
                [menuCost alignItemsHorizontallyWithPadding:10];
                [menuCost setPosition:ccp(screenSize.width/2, screenSize.height/2 - 70)];
                [menuChoice alignItemsHorizontallyWithPadding:80];
                [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 164)];
            }
            else {
                [labelGold setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 200)];
                [labelGoldVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 200)];
                
                [labelShop setPosition:ccp(screenSize.width/2, screenSize.height/2 + 140)];
                [menuItem alignItemsHorizontallyWithPadding:10];
                [menuItem setPosition:ccp(screenSize.width/2, screenSize.height/2 + 70)];
                [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 10)];
                
                [menuCost alignItemsHorizontallyWithPadding:10];
                [menuCost setPosition:ccp(screenSize.width/2, screenSize.height/2 - 50)];
                [menuChoice alignItemsHorizontallyWithPadding:80];
                [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 120)];
            }
        }
        else {
            [labelGold setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (200 * 2.133f))];
            [labelGoldVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (200 * 2.133f))];
            
            [labelShop setPosition:ccp(screenSize.width/2, screenSize.height/2 + (110 * 2.133f))];
            [menuItem alignItemsHorizontallyWithPadding:(10 * 2.4f)];
            [menuItem setPosition:ccp(screenSize.width/2, screenSize.height/2 + (40 * 2.133f))];
            [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (20 * 2.133f))];
            
            [menuCost alignItemsHorizontallyWithPadding:(10 * 2.4f)];
            [menuCost setPosition:ccp(screenSize.width/2, screenSize.height/2 - (80 * 2.133f))];
            [menuChoice alignItemsHorizontallyWithPadding:(80 * 2.4f)];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - (150 * 2.133f))];
        }
        
        [self addChild:labelGold z:1 tag:0];
        [self addChild:labelGoldVal z:1 tag:1];
        [self addChild:labelShop z:1 tag:2];
        [self addChild:menuItem z:1 tag:3];
        [self addChild:labelMsg3 z:1 tag:4];
        [self addChild:menuCost z:1 tag:5];
		[self addChild:menuChoice z:1 tag:6];
        
        [self scheduleUpdate];
        
        menuItem.isTouchEnabled = NO;
        menuCost.isTouchEnabled = NO;
        
        if (([[Player sharedPlayer] currentGold] < requiredGold) ||
            (([[Player sharedPlayer] potion] == 0 ||
             [[Player sharedPlayer] bomb] == 0) &&
            (choiceVal == 8 || choiceVal == 9 ||
             choiceVal == 10 || choiceVal == 11))) {
                
            itemUpgrade.isEnabled = NO;
        }
	}
    
	return self;
}

-(id)initWithChoice:(int)choice
{
	if((self=[super initWithColor:ccc4(0, 0, 0, 255)
                         fadingTo:ccc4(40, 40, 40, 255)])) {
        
		screenSize = [[CCDirector sharedDirector] winSize];
        
        choiceVal = choice;
        
        [self setupMerchantMenu];
        
        labelGold = [CCLabelTTF labelWithString:NSLocalizedString(@"UpgradeMsg01", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]];
        labelShop = [CCLabelTTF labelWithString:NSLocalizedString(@"UpgradeMsg02", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]];
        
        [CCMenuItemFont setFontSize:[Utility getFontSize:32]];
        [CCMenuItemFont setFontName:@"Shark Crash"];
        
        [labelGold setColor:ccc3(255, 182, 18)];
        [labelShop setColor:ccc3(0, 255, 127)];
        [labelMsg2 setColor:ccc3(255, 204, 102)];
        [labelCostVal setColor:ccc3(255, 182, 18)];
        
        itemMsg1 = [CCMenuItemLabel itemWithLabel:labelMsg1];
        itemMsg2 = [CCMenuItemLabel itemWithLabel:labelMsg2];
        itemCost = [CCMenuItemLabel itemWithLabel:labelCost];
        itemCostVal = [CCMenuItemLabel itemWithLabel:labelCostVal];
        
        itemCancel = [CCMenuItemFont itemWithString:NSLocalizedString(@"Cancel", nil)
                                             target:self selector:@selector(cancel2)];
        itemUpgrade = [CCMenuItemFont itemWithString:NSLocalizedString(@"Upgrade", nil)
                                              target:self selector:@selector(upgrade2)];
		
        menuItem = [CCMenu menuWithItems:itemMsg1, itemMsg2, nil];
        menuCost = [CCMenu menuWithItems:itemCost, itemCostVal, nil];
		menuChoice = [CCMenu menuWithItems:itemCancel, itemUpgrade, nil];
        
        [labelGold setAnchorPoint:ccp(0, 0)];
        [labelGoldVal setAnchorPoint:ccp(1, 0)];
        
        [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [labelGold setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 244)];
                [labelGoldVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 244)];
                
                [labelShop setPosition:ccp(screenSize.width/2, screenSize.height/2 + 184)];
                [menuItem alignItemsHorizontallyWithPadding:10];
                [menuItem setPosition:ccp(screenSize.width/2, screenSize.height/2 + 90)];
                [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 10)];
                
                [menuCost alignItemsHorizontallyWithPadding:10];
                [menuCost setPosition:ccp(screenSize.width/2, screenSize.height/2 - 70)];
                [menuChoice alignItemsHorizontallyWithPadding:80];
                [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 164)];
            }
            else {
                [labelGold setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 200)];
                [labelGoldVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 200)];
                
                [labelShop setPosition:ccp(screenSize.width/2, screenSize.height/2 + 140)];
                [menuItem alignItemsHorizontallyWithPadding:10];
                [menuItem setPosition:ccp(screenSize.width/2, screenSize.height/2 + 70)];
                [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 10)];
                
                [menuCost alignItemsHorizontallyWithPadding:10];
                [menuCost setPosition:ccp(screenSize.width/2, screenSize.height/2 - 50)];
                [menuChoice alignItemsHorizontallyWithPadding:80];
                [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 120)];
            }
        }
        else {
            [labelGold setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (200 * 2.133f))];
            [labelGoldVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (200 * 2.133f))];
            
            [labelShop setPosition:ccp(screenSize.width/2, screenSize.height/2 + (110 * 2.133f))];
            [menuItem alignItemsHorizontallyWithPadding:(10 * 2.4f)];
            [menuItem setPosition:ccp(screenSize.width/2, screenSize.height/2 + (40 * 2.133f))];
            [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (20 * 2.133f))];
            
            [menuCost alignItemsHorizontallyWithPadding:(10 * 2.4f)];
            [menuCost setPosition:ccp(screenSize.width/2, screenSize.height/2 - (80 * 2.133f))];
            [menuChoice alignItemsHorizontallyWithPadding:(80 * 2.4f)];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - (150 * 2.133f))];
        }
        
        [self addChild:labelGold z:1 tag:0];
        [self addChild:labelGoldVal z:1 tag:1];
        [self addChild:labelShop z:1 tag:2];
        [self addChild:menuItem z:1 tag:3];
        [self addChild:labelMsg3 z:1 tag:4];
        [self addChild:menuCost z:1 tag:5];
		[self addChild:menuChoice z:1 tag:6];
        
        [self scheduleUpdate];
        
        menuItem.isTouchEnabled = NO;
        menuCost.isTouchEnabled = NO;
        
        if ([[Player sharedPlayer] currentGold] < requiredGold) {
            itemUpgrade.isEnabled = NO;
        }
	}
    
	return self;
}

#pragma mark - scene setup

// setups the shop menu
-(void)setupShopMenu
{
    [self setupTradeValues];
    
    msg1 = NSLocalizedString(@"Upgrade", nil);
    
    if (choiceVal == 1) {
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem01", nil),
                ([[Player sharedPlayer] weapon] + 1) * 4];
    }
    else if (choiceVal == 2) {
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem02", nil),
                ([[Player sharedPlayer] spellbook] + 1) * 4];
    }
    else if (choiceVal == 3) {
        if ([[Player sharedPlayer] armor] == 0) {
            msg1 = NSLocalizedString(@"Buy", nil);
            itemName = NSLocalizedString(@"Armor01", nil);
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem03", nil),
                ([[Player sharedPlayer] armor] + 1) * 4];
    }
    else if (choiceVal == 4) {
        if ([[Player sharedPlayer] ring] == 0) {
            msg1 = NSLocalizedString(@"Buy", nil);
            itemName = NSLocalizedString(@"Ring01", nil);
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem04", nil),
                ([[Player sharedPlayer] ring] + 1) * 4];
    }
    else if (choiceVal == 5) {
        if ([[Player sharedPlayer] amulet] == 0) {
            msg1 = NSLocalizedString(@"Buy", nil);
            itemName = NSLocalizedString(@"Amulet01", nil);
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem05", nil),
                ([[Player sharedPlayer] amulet] + 1) * 10];
    }
    else if (choiceVal == 6) {
        msg1 = NSLocalizedString(@"Buy", nil);
        itemName = NSLocalizedString(@"BattleItemName02", nil);
        msg3 = NSLocalizedString(@"UpgradeItem06", nil);
    }
    else if (choiceVal == 7) {
        msg1 = NSLocalizedString(@"Buy", nil);
        itemName = NSLocalizedString(@"BattleItemName03", nil);
        msg3 = NSLocalizedString(@"UpgradeItem07", nil);
    }
    else if (choiceVal == 8) {
        msg1 = NSLocalizedString(@"Buy", nil);
        itemName = NSLocalizedString(@"BattleItemName04", nil);
        msg3 = NSLocalizedString(@"UpgradeItem08", nil);
    }
    else if (choiceVal == 9) {
        msg1 = NSLocalizedString(@"Buy", nil);
        itemName = NSLocalizedString(@"BattleItemName05", nil);
        msg3 = NSLocalizedString(@"UpgradeItem09", nil);
    }
    else if (choiceVal == 10) {
        msg1 = NSLocalizedString(@"Buy", nil);
        itemName = NSLocalizedString(@"BattleItemName06", nil);
        msg3 = NSLocalizedString(@"UpgradeItem10", nil);
    }
    else if (choiceVal == 11) {
        msg1 = NSLocalizedString(@"Buy", nil);
        itemName = NSLocalizedString(@"BattleItemName07", nil);
        msg3 = NSLocalizedString(@"UpgradeItem11", nil);
    }
    
    currentGold = [NSString stringWithFormat:@"%lld", [[Player sharedPlayer] currentGold]];
    
    if (([[Player sharedPlayer] potion] == 0 ||
        [[Player sharedPlayer] bomb] == 0) &&
        (choiceVal == 8 || choiceVal == 9 ||
         choiceVal == 10 || choiceVal == 11)) {
        
        costVal = NSLocalizedString(@"UpgradeMsg06", nil);
    }
    else {
        costVal = [NSString stringWithFormat:NSLocalizedString(@"UpgradeMsg05", nil), requiredGold];
    }
    
    labelGoldVal = [CCLabelTTF labelWithString:currentGold
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]];
    labelMsg1 = [CCLabelTTF labelWithString:msg1
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]];
    labelMsg2 = [CCLabelTTF labelWithString:itemName
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]];
    labelMsg3 = [CCLabelTTF labelWithString:msg3
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]];
    labelCost = [CCLabelTTF labelWithString:NSLocalizedString(@"UpgradeMsg04", nil)
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
    labelCostVal = [CCLabelTTF labelWithString:costVal
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
}

// setups the merchant menu
-(void)setupMerchantMenu
{
    [self setupTradeValues2];
    
    msg1 = NSLocalizedString(@"Upgrade", nil);
    
    if (choiceVal == 1) {
        itemName = NSLocalizedString(@"ShopAbilityName01", nil);
        msg3 = NSLocalizedString(@"UpgradeItem12", nil);
    }
    else if (choiceVal == 2) {
        itemName = NSLocalizedString(@"ShopAbilityName02", nil);
        msg3 = NSLocalizedString(@"UpgradeItem13", nil);
    }
    else if (choiceVal == 3) {
        itemName = NSLocalizedString(@"ShopAbilityName03", nil);
        msg3 = NSLocalizedString(@"UpgradeItem14", nil);
    }
    else if (choiceVal == 4) {
        itemName = NSLocalizedString(@"ShopAbilityName04", nil);
        msg3 = NSLocalizedString(@"UpgradeItem15", nil);
    }
    else if (choiceVal == 5) {
        itemName = NSLocalizedString(@"ShopAbilityName05", nil);
        msg3 = NSLocalizedString(@"UpgradeItem16", nil);
    }
    else if (choiceVal == 6) {
        itemName = NSLocalizedString(@"ShopAbilityName06", nil);
        msg3 = NSLocalizedString(@"UpgradeItem17", nil);
    }
    else if (choiceVal == 7) {
        itemName = NSLocalizedString(@"ShopAbilityName07", nil);
        msg3 = NSLocalizedString(@"UpgradeItem18", nil);
    }
    else if (choiceVal == 8) {
        itemName = NSLocalizedString(@"ShopAbilityName08", nil);
        msg3 = NSLocalizedString(@"UpgradeItem19", nil);
    }
    else if (choiceVal == 9) {
        itemName = NSLocalizedString(@"ShopAbilityName09", nil);
        msg3 = NSLocalizedString(@"UpgradeItem20", nil);
    }
    
    currentGold = [NSString stringWithFormat:@"%lld", [[Player sharedPlayer] currentGold]];
    costVal = [NSString stringWithFormat:NSLocalizedString(@"UpgradeMsg05", nil), requiredGold];
    
    labelGoldVal = [CCLabelTTF labelWithString:currentGold
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]];
    labelMsg1 = [CCLabelTTF labelWithString:msg1
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]];
    labelMsg2 = [CCLabelTTF labelWithString:itemName
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]];
    labelMsg3 = [CCLabelTTF labelWithString:msg3
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]];
    labelCost = [CCLabelTTF labelWithString:NSLocalizedString(@"UpgradeMsg04", nil)
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
    labelCostVal = [CCLabelTTF labelWithString:costVal
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
}

// setups item trade values
-(void)setupTradeValues
{
    if (choiceVal == 11) {
        requiredGold = 2000;
    }
    else if (choiceVal == 10) {
        requiredGold = 1000;
    }
    else if (choiceVal == 8 || choiceVal == 9) {
        requiredGold = 750;
    }
    else if (choiceVal == 7) {
        requiredGold = 500;
    }
    else if (choiceVal == 6) {
        requiredGold = 250;
    }
    else {
        int upgrade_rank;
        
        if (choiceVal == 1) {
            upgrade_rank = [[Player sharedPlayer] weapon];
        }
        else if (choiceVal == 2) {
            upgrade_rank = [[Player sharedPlayer] spellbook];
        }
        else if (choiceVal == 3) {
            upgrade_rank = [[Player sharedPlayer] armor];
        }
        else if (choiceVal == 4) {
            upgrade_rank = [[Player sharedPlayer] ring];
        }
        else if (choiceVal == 5) {
            upgrade_rank = [[Player sharedPlayer] amulet];
        }
        
        if (upgrade_rank == 9) {
            requiredGold = 250000;
        }
        else if (upgrade_rank == 8) {
            requiredGold = 100000;
        }
        else if (upgrade_rank == 7) {
            requiredGold = 50000;
        }
        else if (upgrade_rank == 6) {
            requiredGold = 10000;
        }
        else if (upgrade_rank == 5) {
            requiredGold = 3200;
        }
        else if (upgrade_rank == 4) {
            requiredGold = 1500;
        }
        else if (upgrade_rank == 3) {
            requiredGold = 800;
        }
        else if (upgrade_rank == 2) {
            requiredGold = 400;
        }
        else if (upgrade_rank == 1) {
            requiredGold = 200;
        }
        else if (upgrade_rank == 0) {
            requiredGold = 100;
        }
    }
    
    if ([[Player sharedPlayer] getReputationRewards] >= 9) {
        requiredGold = (int)(requiredGold * 0.75);
    }
    else if ([[Player sharedPlayer] getReputationRewards] >= 7) {
        requiredGold = (int)(requiredGold * 0.80);
    }
    else if ([[Player sharedPlayer] getReputationRewards] >= 5) {
        requiredGold = (int)(requiredGold * 0.85);
    }
    else if ([[Player sharedPlayer] getReputationRewards] >= 3) {
        requiredGold = (int)(requiredGold * 0.90);
    }
    else if ([[Player sharedPlayer] getReputationRewards] >= 1) {
        requiredGold = (int)(requiredGold * 0.95);
    }
}

// setups item trade values for merchant
-(void)setupTradeValues2
{
    int upgrade_rank;
    
    if (choiceVal == 1) {
        upgrade_rank = [[Player sharedPlayer] ability1];
    }
    else if (choiceVal == 2) {
        upgrade_rank = [[Player sharedPlayer] ability2];
    }
    else if (choiceVal == 3) {
        upgrade_rank = [[Player sharedPlayer] ability3];
    }
    else if (choiceVal == 4) {
        upgrade_rank = [[Player sharedPlayer] ability4];
    }
    else if (choiceVal == 5) {
        upgrade_rank = [[Player sharedPlayer] ability5];
    }
    else if (choiceVal == 6) {
        upgrade_rank = [[Player sharedPlayer] ability6];
    }
    else if (choiceVal == 7) {
        upgrade_rank = [[Player sharedPlayer] ability7];
    }
    else if (choiceVal == 8) {
        upgrade_rank = [[Player sharedPlayer] ability8];
    }
    else if (choiceVal == 9) {
        upgrade_rank = [[Player sharedPlayer] ability9];
    }
    
    if (upgrade_rank == 3) {
        requiredGold = 10000;
    }
    else if (upgrade_rank == 2) {
        requiredGold = 5000;
    }
    else if (upgrade_rank == 1) {
        requiredGold = 1000;
    }
    
    if ([[Player sharedPlayer] getReputationRewards] >= 9) {
        requiredGold = (int)(requiredGold * 0.75);
    }
    else if ([[Player sharedPlayer] getReputationRewards] >= 7) {
        requiredGold = (int)(requiredGold * 0.80);
    }
    else if ([[Player sharedPlayer] getReputationRewards] >= 5) {
        requiredGold = (int)(requiredGold * 0.85);
    }
    else if ([[Player sharedPlayer] getReputationRewards] >= 3) {
        requiredGold = (int)(requiredGold * 0.90);
    }
    else if ([[Player sharedPlayer] getReputationRewards] >= 1) {
        requiredGold = (int)(requiredGold * 0.95);
    }
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if (itemCancel.isSelected || itemUpgrade.isSelected) {
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemCancel.isSelected && !itemUpgrade.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// upgrades the selected by the user item
-(void)upgrade
{
    if (choiceVal == 1) {
        [[GameManager sharedGameManager] writeWeaponUpgradeData];
    }
    else if (choiceVal == 2) {
        [[GameManager sharedGameManager] writeSpellbookUpgradeData];
    }
    else if (choiceVal == 3) {
        [[GameManager sharedGameManager] writeArmorUpgradeData];
    }
    else if (choiceVal == 4) {
        [[GameManager sharedGameManager] writeRingUpgradeData];
    }
    else if (choiceVal == 5) {
        [[GameManager sharedGameManager] writeAmuletUpgradeData];
    }
    else if (choiceVal == 6) {
        [[GameManager sharedGameManager] writePotionUpgradeData];
    }
    else if (choiceVal == 7) {
        [[GameManager sharedGameManager] writeBombUpgradeData];
    }
    else if (choiceVal == 8) {
        [[GameManager sharedGameManager] writeAleUpgradeData];
    }
    else if (choiceVal == 9) {
        [[GameManager sharedGameManager] writeRuneUpgradeData];
    }
    else if (choiceVal == 10) {
        [[GameManager sharedGameManager] writeMirrorUpgradeData];
    }
    else if (choiceVal == 11) {
        [[GameManager sharedGameManager] writeFluteUpgradeData];
    }
    
    [[GameManager sharedGameManager] writeSpendingGold:requiredGold];
    
    [self confirm];
}

// upgrades the selected by the user ability
-(void)upgrade2
{
    if (choiceVal == 1) {
        [[GameManager sharedGameManager] writeAbility1UpgradeData];
    }
    else if (choiceVal == 2) {
        [[GameManager sharedGameManager] writeAbility2UpgradeData];
    }
    else if (choiceVal == 3) {
        [[GameManager sharedGameManager] writeAbility3UpgradeData];
    }
    else if (choiceVal == 4) {
        [[GameManager sharedGameManager] writeAbility4UpgradeData];
    }
    else if (choiceVal == 5) {
        [[GameManager sharedGameManager] writeAbility5UpgradeData];
    }
    else if (choiceVal == 6) {
        [[GameManager sharedGameManager] writeAbility6UpgradeData];
    }
    else if (choiceVal == 7) {
        [[GameManager sharedGameManager] writeAbility7UpgradeData];
    }
    else if (choiceVal == 8) {
        [[GameManager sharedGameManager] writeAbility8UpgradeData];
    }
    else if (choiceVal == 9) {
        [[GameManager sharedGameManager] writeAbility9UpgradeData];
    }
    
    [[GameManager sharedGameManager] writeSpendingGold:requiredGold];
    
    [self confirm2];
}

// accepts shopping and returns to the underlying menu
-(void)confirm
{
    InventoryLayer *layer = (InventoryLayer*)self.parent;
    [layer resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

// accepts shopping and returns to the underlying menu
-(void)confirm2
{
    ShopLayer *layer = (ShopLayer*)self.parent;
    [layer resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

// cancels shopping and returns to the underlying menu
-(void)cancel
{
    InventoryLayer *layer = (InventoryLayer*)self.parent;
    [layer resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

// cancels shopping and returns to the underlying menu
-(void)cancel2
{
    ShopLayer *layer = (ShopLayer*)self.parent;
    [layer resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

@end
