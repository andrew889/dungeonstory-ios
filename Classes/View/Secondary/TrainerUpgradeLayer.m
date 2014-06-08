//
//  TrainerUpgradeLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 22/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "TrainerUpgradeLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "TrainerLayer.h"
#import "Utility.h"

#pragma mark - TrainerUpgradeLayer

@implementation TrainerUpgradeLayer

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
        labelShop = [CCLabelTTF labelWithString:NSLocalizedString(@"UpgradeMsg03", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]];
        
        [CCMenuItemFont setFontSize:32];
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
            
            [labelShop setPosition:ccp(screenSize.width/2, screenSize.height/2 + (140 * 2.133f))];
            [menuItem alignItemsHorizontallyWithPadding:(10 * 2.4f)];
            [menuItem setPosition:ccp(screenSize.width/2, screenSize.height/2 + (70 * 2.133f))];
            [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (10 * 2.133f))];
            
            [menuCost alignItemsHorizontallyWithPadding:(10 * 2.4f)];
            [menuCost setPosition:ccp(screenSize.width/2, screenSize.height/2 - (50 * 2.133f))];
            [menuChoice alignItemsHorizontallyWithPadding:(80 * 2.4f)];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - (120 * 2.133f))];
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
    [self setupMessages];
    
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

// setups menu messages
-(void)setupMessages
{
    int gainedValue = 0;
    
    if (choiceVal == 1) {
        itemName = NSLocalizedString(@"TrainerSkillName01", nil);
        
        if ([[Player sharedPlayer] combatSkill1] == 0) {
            msg1 = NSLocalizedString(@"Learn", nil);
            gainedValue = 2;
        }
        else {
            msg1 = NSLocalizedString(@"Train", nil);
            
            if ([[Player sharedPlayer] combatSkill1] == 1) gainedValue = 4;
            else if ([[Player sharedPlayer] combatSkill1] == 2) gainedValue = 6;
            else if ([[Player sharedPlayer] combatSkill1] == 3) gainedValue = 8;
            else if ([[Player sharedPlayer] combatSkill1] == 4) gainedValue = 10;
            else if ([[Player sharedPlayer] combatSkill1] == 5) gainedValue = 12;
            else if ([[Player sharedPlayer] combatSkill1] == 6) gainedValue = 14;
            else if ([[Player sharedPlayer] combatSkill1] == 7) gainedValue = 16;
            else if ([[Player sharedPlayer] combatSkill1] == 8) gainedValue = 18;
            else if ([[Player sharedPlayer] combatSkill1] == 9) gainedValue = 20;
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem21", nil), gainedValue];
    }
    else if (choiceVal == 2) {
        itemName = NSLocalizedString(@"TrainerSkillName02", nil);
        
        if ([[Player sharedPlayer] combatSkill2] == 0) {
            msg1 = NSLocalizedString(@"Learn", nil);
            gainedValue = 2;
        }
        else {
            msg1 = NSLocalizedString(@"Train", nil);
            
            if ([[Player sharedPlayer] combatSkill2] == 1) gainedValue = 4;
            else if ([[Player sharedPlayer] combatSkill2] == 2) gainedValue = 6;
            else if ([[Player sharedPlayer] combatSkill2] == 3) gainedValue = 8;
            else if ([[Player sharedPlayer] combatSkill2] == 4) gainedValue = 10;
            else if ([[Player sharedPlayer] combatSkill2] == 5) gainedValue = 12;
            else if ([[Player sharedPlayer] combatSkill2] == 6) gainedValue = 14;
            else if ([[Player sharedPlayer] combatSkill2] == 7) gainedValue = 16;
            else if ([[Player sharedPlayer] combatSkill2] == 8) gainedValue = 18;
            else if ([[Player sharedPlayer] combatSkill2] == 9) gainedValue = 20;
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem22", nil), gainedValue];
    }
    else if (choiceVal == 3) {
        itemName = NSLocalizedString(@"TrainerSkillName03", nil);
        
        if ([[Player sharedPlayer] combatSkill3] == 0) {
            msg1 = NSLocalizedString(@"Learn", nil);
            gainedValue = 1;
        }
        else {
            msg1 = NSLocalizedString(@"Train", nil);
            
            if ([[Player sharedPlayer] combatSkill3] == 1) gainedValue = 2;
            else if ([[Player sharedPlayer] combatSkill3] == 2) gainedValue = 3;
            else if ([[Player sharedPlayer] combatSkill3] == 3) gainedValue = 4;
            else if ([[Player sharedPlayer] combatSkill3] == 4) gainedValue = 5;
            else if ([[Player sharedPlayer] combatSkill3] == 5) gainedValue = 6;
            else if ([[Player sharedPlayer] combatSkill3] == 6) gainedValue = 7;
            else if ([[Player sharedPlayer] combatSkill3] == 7) gainedValue = 8;
            else if ([[Player sharedPlayer] combatSkill3] == 8) gainedValue = 9;
            else if ([[Player sharedPlayer] combatSkill3] == 9) gainedValue = 10;
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem23", nil), gainedValue];
    }
    else if (choiceVal == 4) {
        itemName = NSLocalizedString(@"TrainerSkillName04", nil);
        
        if ([[Player sharedPlayer] survivalSkill1] == 0) {
            msg1 = NSLocalizedString(@"Learn", nil);
            gainedValue = 10;
        }
        else {
            msg1 = NSLocalizedString(@"Train", nil);
            
            if ([[Player sharedPlayer] survivalSkill1] == 1) gainedValue = 30;
            else if ([[Player sharedPlayer] survivalSkill1] == 2) gainedValue = 60;
            else if ([[Player sharedPlayer] survivalSkill1] == 3) gainedValue = 100;
            else if ([[Player sharedPlayer] survivalSkill1] == 4) gainedValue = 150;
            else if ([[Player sharedPlayer] survivalSkill1] == 5) gainedValue = 210;
            else if ([[Player sharedPlayer] survivalSkill1] == 6) gainedValue = 280;
            else if ([[Player sharedPlayer] survivalSkill1] == 7) gainedValue = 360;
            else if ([[Player sharedPlayer] survivalSkill1] == 8) gainedValue = 450;
            else if ([[Player sharedPlayer] survivalSkill1] == 9) gainedValue = 550;
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem24", nil), gainedValue];
    }
    else if (choiceVal == 5) {
        itemName = NSLocalizedString(@"TrainerSkillName05", nil);
        
        if ([[Player sharedPlayer] survivalSkill2] == 0) {
            msg1 = NSLocalizedString(@"Learn", nil);
            gainedValue = 2;
        }
        else {
            msg1 = NSLocalizedString(@"Train", nil);
            
            if ([[Player sharedPlayer] survivalSkill2] == 1) gainedValue = 4;
            else if ([[Player sharedPlayer] survivalSkill2] == 2) gainedValue = 6;
            else if ([[Player sharedPlayer] survivalSkill2] == 3) gainedValue = 8;
            else if ([[Player sharedPlayer] survivalSkill2] == 4) gainedValue = 10;
            else if ([[Player sharedPlayer] survivalSkill2] == 5) gainedValue = 12;
            else if ([[Player sharedPlayer] survivalSkill2] == 6) gainedValue = 14;
            else if ([[Player sharedPlayer] survivalSkill2] == 7) gainedValue = 16;
            else if ([[Player sharedPlayer] survivalSkill2] == 8) gainedValue = 18;
            else if ([[Player sharedPlayer] survivalSkill2] == 9) gainedValue = 20;
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem25", nil), gainedValue];
    }
    else if (choiceVal == 6) {
        itemName = NSLocalizedString(@"TrainerSkillName06", nil);
        
        if ([[Player sharedPlayer] survivalSkill3] == 0) {
            msg1 = NSLocalizedString(@"Learn", nil);
            gainedValue = 1;
        }
        else {
            msg1 = NSLocalizedString(@"Train", nil);
            
            if ([[Player sharedPlayer] survivalSkill3] == 1) gainedValue = 2;
            else if ([[Player sharedPlayer] survivalSkill3] == 2) gainedValue = 3;
            else if ([[Player sharedPlayer] survivalSkill3] == 3) gainedValue = 4;
            else if ([[Player sharedPlayer] survivalSkill3] == 4) gainedValue = 5;
            else if ([[Player sharedPlayer] survivalSkill3] == 5) gainedValue = 6;
            else if ([[Player sharedPlayer] survivalSkill3] == 6) gainedValue = 7;
            else if ([[Player sharedPlayer] survivalSkill3] == 7) gainedValue = 8;
            else if ([[Player sharedPlayer] survivalSkill3] == 8) gainedValue = 9;
            else if ([[Player sharedPlayer] survivalSkill3] == 9) gainedValue = 10;
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem26", nil), gainedValue];
    }
    else if (choiceVal == 7) {
        itemName = NSLocalizedString(@"TrainerSkillName07", nil);
        
        if ([[Player sharedPlayer] practicalSkill1] == 0) {
            msg1 = NSLocalizedString(@"Learn", nil);
            gainedValue = 2;
        }
        else {
            msg1 = NSLocalizedString(@"Train", nil);
            
            if ([[Player sharedPlayer] practicalSkill1] == 1) gainedValue = 4;
            else if ([[Player sharedPlayer] practicalSkill1] == 2) gainedValue = 6;
            else if ([[Player sharedPlayer] practicalSkill1] == 3) gainedValue = 8;
            else if ([[Player sharedPlayer] practicalSkill1] == 4) gainedValue = 10;
            else if ([[Player sharedPlayer] practicalSkill1] == 5) gainedValue = 12;
            else if ([[Player sharedPlayer] practicalSkill1] == 6) gainedValue = 14;
            else if ([[Player sharedPlayer] practicalSkill1] == 7) gainedValue = 16;
            else if ([[Player sharedPlayer] practicalSkill1] == 8) gainedValue = 18;
            else if ([[Player sharedPlayer] practicalSkill1] == 9) gainedValue = 20;
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem27", nil), gainedValue];
    }
    else if (choiceVal == 8) {
        itemName = NSLocalizedString(@"TrainerSkillName08", nil);
        
        if ([[Player sharedPlayer] practicalSkill2] == 0) {
            msg1 = NSLocalizedString(@"Learn", nil);
            gainedValue = 2;
        }
        else {
            msg1 = NSLocalizedString(@"Train", nil);
            
            if ([[Player sharedPlayer] practicalSkill2] == 1) gainedValue = 4;
            else if ([[Player sharedPlayer] practicalSkill2] == 2) gainedValue = 6;
            else if ([[Player sharedPlayer] practicalSkill2] == 3) gainedValue = 8;
            else if ([[Player sharedPlayer] practicalSkill2] == 4) gainedValue = 10;
            else if ([[Player sharedPlayer] practicalSkill2] == 5) gainedValue = 12;
            else if ([[Player sharedPlayer] practicalSkill2] == 6) gainedValue = 14;
            else if ([[Player sharedPlayer] practicalSkill2] == 7) gainedValue = 16;
            else if ([[Player sharedPlayer] practicalSkill2] == 8) gainedValue = 18;
            else if ([[Player sharedPlayer] practicalSkill2] == 9) gainedValue = 20;
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem28", nil), gainedValue];
    }
    else if (choiceVal == 9) {
        itemName = NSLocalizedString(@"TrainerSkillName09", nil);
        
        if ([[Player sharedPlayer] practicalSkill3] == 0) {
            msg1 = NSLocalizedString(@"Learn", nil);
            gainedValue = 4;
        }
        else {
            msg1 = NSLocalizedString(@"Train", nil);
            
            if ([[Player sharedPlayer] practicalSkill3] == 1) gainedValue = 12;
            else if ([[Player sharedPlayer] practicalSkill3] == 2) gainedValue = 24;
            else if ([[Player sharedPlayer] practicalSkill3] == 3) gainedValue = 40;
            else if ([[Player sharedPlayer] practicalSkill3] == 4) gainedValue = 60;
            else if ([[Player sharedPlayer] practicalSkill3] == 5) gainedValue = 84;
            else if ([[Player sharedPlayer] practicalSkill3] == 6) gainedValue = 112;
            else if ([[Player sharedPlayer] practicalSkill3] == 7) gainedValue = 144;
            else if ([[Player sharedPlayer] practicalSkill3] == 8) gainedValue = 180;
            else if ([[Player sharedPlayer] practicalSkill3] == 9) gainedValue = 220;
        }
        
        msg3 = [NSString stringWithFormat:NSLocalizedString(@"UpgradeItem29", nil), gainedValue];
    }
}

// setups item trade values
-(void)setupTradeValues
{
    int upgrade_rank;
    
    if (choiceVal == 1) {
        upgrade_rank = [[Player sharedPlayer] combatSkill1];
    }
    else if (choiceVal == 2) {
        upgrade_rank = [[Player sharedPlayer] combatSkill2];
    }
    else if (choiceVal == 3) {
        upgrade_rank = [[Player sharedPlayer] combatSkill3];
    }
    else if (choiceVal == 4) {
        upgrade_rank = [[Player sharedPlayer] survivalSkill1];
    }
    else if (choiceVal == 5) {
        upgrade_rank = [[Player sharedPlayer] survivalSkill2];
    }
    else if (choiceVal == 6) {
        upgrade_rank = [[Player sharedPlayer] survivalSkill3];
    }
    else if (choiceVal == 7) {
        upgrade_rank = [[Player sharedPlayer] practicalSkill1];
    }
    else if (choiceVal == 8) {
        upgrade_rank = [[Player sharedPlayer] practicalSkill2];
    }
    else if (choiceVal == 9) {
        upgrade_rank = [[Player sharedPlayer] practicalSkill3];
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
        [[GameManager sharedGameManager] writeCombatSkill1UpgradeData];
    }
    else if (choiceVal == 2) {
        [[GameManager sharedGameManager] writeCombatSkill2UpgradeData];
    }
    else if (choiceVal == 3) {
        [[GameManager sharedGameManager] writeCombatSkill3UpgradeData];
    }
    else if (choiceVal == 4) {
        [[GameManager sharedGameManager] writeSurvivalSkill1UpgradeData];
    }
    else if (choiceVal == 5) {
        [[GameManager sharedGameManager] writeSurvivalSkill2UpgradeData];
    }
    else if (choiceVal == 6) {
        [[GameManager sharedGameManager] writeSurvivalSkill3UpgradeData];
    }
    else if (choiceVal == 7) {
        [[GameManager sharedGameManager] writePracticalSkill1UpgradeData];
    }
    else if (choiceVal == 8) {
        [[GameManager sharedGameManager] writePracticalSkill2UpgradeData];
    }
    else if (choiceVal == 9) {
        [[GameManager sharedGameManager] writePracticalSkill3UpgradeData];
    }
    
    [[GameManager sharedGameManager] writeSpendingGold:requiredGold];
    
    [self confirm];
}

// accepts training and returns to the underlying menu
-(void)confirm
{
    TrainerLayer *layer = (TrainerLayer*)self.parent;
    [layer resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

// cancels training and returns to the underlying menu
-(void)cancel
{
    TrainerLayer *layer = (TrainerLayer*)self.parent;
    [layer resumeGame];
    [self.parent removeChild:self cleanup:YES];
}

@end
