//
//  ShopLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 09/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "ShopLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "ShopUpgradeLayer.h"
#import "ShopHelpLayer.h"
#import "Utility.h"

#pragma mark - ShopLayer

@implementation ShopLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	ShopLayer *layer = [ShopLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {        
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"Menu.png"];
        shopBG = [CCSprite spriteWithFile:@"ShopMenu.png"];
        menuBar01 = [CCSprite spriteWithFile:@"menubar.png"];
        menuBar02 = [CCSprite spriteWithFile:@"menubar.png"];
        
        spriteAbility1 = [CCSprite spriteWithFile:@"ability1.png"];
        spriteAbility2 = [CCSprite spriteWithFile:@"ability2.png"];
        spriteAbility3 = [CCSprite spriteWithFile:@"ability3.png"];
        spriteAbility4 = [CCSprite spriteWithFile:@"ability4.png"];
        spriteAbility5 = [CCSprite spriteWithFile:@"ability5.png"];
        spriteAbility6 = [CCSprite spriteWithFile:@"ability6.png"];
        spriteAbility7 = [CCSprite spriteWithFile:@"ability7.png"];
        spriteAbility8 = [CCSprite spriteWithFile:@"ability8.png"];
        spriteAbility9 = [CCSprite spriteWithFile:@"ability9.png"];
        
        currentAbility = 1;
        
        [self setupShopMenu];
        
        if (screenSize.height == 568.00) {
            [self setupUpperBar];
        }
        
        labelShop = [Utility labelWithString:NSLocalizedString(@"ShopLabel", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]
                                       color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelMerchant = [Utility labelWithString:NSLocalizedString(@"ShopMerchant", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                           color:ccc3(0, 255, 127) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
                        
        itemTavern = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"TavernLabel", nil)
                                                                            fontName:@"Shark Crash"
                                                                            fontSize:[Utility getFontSize:26]
                                                                               color:ccWHITE
                                                                          strokeSize:[Utility getFontSize:1.5]
                                                                          stokeColor:ccBLACK]
                      
                                             selectedSprite:[Utility labelWithString:NSLocalizedString(@"TavernLabel", nil)
                                                                            fontName:@"Shark Crash"
                                                                            fontSize:[Utility getFontSize:26]
                                                                               color:ccc3(255, 204, 102)
                                                                          strokeSize:[Utility getFontSize:1.5]
                                                                          stokeColor:ccBLACK]
                      
                                                     target:self selector:@selector(showTavern)];
        
        itemTrainer = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"TrainerLabel", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:26]
                                                                                color:ccWHITE
                                                                           strokeSize:[Utility getFontSize:1.5]
                                                                           stokeColor:ccBLACK]
                       
                                              selectedSprite:[Utility labelWithString:NSLocalizedString(@"TrainerLabel", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:26]
                                                                                color:ccc3(255, 204, 102)
                                                                           strokeSize:[Utility getFontSize:1.5]
                                                                           stokeColor:ccBLACK]
                       
                                                      target:self selector:@selector(showTrainer)];
        
        itemAbilityOff1 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];

        itemAbilityOn1 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn0.png"
                                              selectedImage:@"abilityBtn0.png"];
        
        itemAbility1 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(chooseAbility1:)
                                                  items:itemAbilityOff1, itemAbilityOn1, nil];
        
        [itemAbility1 setSelectedIndex:1];
        
        itemAbilityOff2 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
        
        itemAbilityOn2 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn0.png"
                                                selectedImage:@"abilityBtn0.png"];
        
        itemAbility2 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(chooseAbility2:)
                                                  items:itemAbilityOff2, itemAbilityOn2, nil];
        
        itemAbilityOff3 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
        
        itemAbilityOn3 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn0.png"
                                                selectedImage:@"abilityBtn0.png"];
        
        itemAbility3 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(chooseAbility3:)
                                                  items:itemAbilityOff3, itemAbilityOn3, nil];
        
        itemAbilityOff4 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
        
        itemAbilityOn4 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn0.png"
                                                selectedImage:@"abilityBtn0.png"];
        
        itemAbility4 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(chooseAbility4:)
                                                  items:itemAbilityOff4, itemAbilityOn4, nil];
        
        itemAbilityOff5 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
        
        itemAbilityOn5 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn0.png"
                                                selectedImage:@"abilityBtn0.png"];
        
        itemAbility5 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(chooseAbility5:)
                                                  items:itemAbilityOff5, itemAbilityOn5, nil];
        
        itemAbilityOff6 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
        
        itemAbilityOn6 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn0.png"
                                                selectedImage:@"abilityBtn0.png"];
        
        itemAbility6 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(chooseAbility6:)
                                                  items:itemAbilityOff6, itemAbilityOn6, nil];
        
        itemAbilityOff7 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
        
        itemAbilityOn7 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn0.png"
                                                selectedImage:@"abilityBtn0.png"];
        
        itemAbility7 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(chooseAbility7:)
                                                  items:itemAbilityOff7, itemAbilityOn7, nil];
        
        itemAbilityOff8 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
        
        itemAbilityOn8 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn0.png"
                                                selectedImage:@"abilityBtn0.png"];
        
        itemAbility8 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(chooseAbility8:)
                                                  items:itemAbilityOff8, itemAbilityOn8, nil];
        
        itemAbilityOff9 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
        
        itemAbilityOn9 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn0.png"
                                                selectedImage:@"abilityBtn0.png"];
        
        itemAbility9 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(chooseAbility9:)
                                                  items:itemAbilityOff9, itemAbilityOn9, nil];
                
        itemUpgradeShop = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn_big.png"
                                                 selectedImage:@"upgrade_btn_big_pressed.png"
                                                 disabledImage:@"upgrade_btn2_big.png"
                                                        target:self
                                                      selector:@selector(upgradeShop)];
                
        itemHelp = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Help", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccWHITE
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                           selectedSprite:[Utility labelWithString:NSLocalizedString(@"Help", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccc3(255, 204, 102)
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                                   target:self selector:@selector(showHelp)];
        
        itemMenu = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Return", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccWHITE
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                           selectedSprite:[Utility labelWithString:NSLocalizedString(@"Return", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccc3(255, 204, 102)
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                                   target:self selector:@selector(showPlay)];
		
		menuChoice = [CCMenu menuWithItems:itemTavern, itemTrainer, nil];
        menuAbilities = [CCMenu menuWithItems:itemAbility1, itemAbility2, itemAbility3, itemAbility4,
                         itemAbility5, itemAbility6, itemAbility7, itemAbility8, itemAbility9, nil];
        menuUpgrades = [CCMenu menuWithItems:itemUpgradeShop, nil];
        menuOptions = [CCMenu menuWithItems:itemHelp, itemMenu, nil];
        
        [labelMerchant setAnchorPoint:ccp(0, 0)];
        [labelMerchantLevel setAnchorPoint:ccp(1, 0)];
        [labelAbilityName setAnchorPoint:ccp(0, 0)];
        [labelAbility setAnchorPoint:ccp(0, 0)];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [shopBG setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263.5)];
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 268.5)];
                
                [menuOptions alignItemsHorizontallyWithPadding:180];
                [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - 263)];
            }
            else {
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 234.5)];
                
                [menuOptions alignItemsHorizontallyWithPadding:180];
                [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - 225)];
            }
            
            [itemTavern setPosition:ccp(-100, 218)];
            [itemTrainer setPosition:ccp(100, 218)];
            [labelShop setPosition:ccp(screenSize.width/2, screenSize.height/2 + 218)];
            
            [labelMerchant setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 166)];
            [labelMerchantLevel setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 166)];
            
            [labelAbilityName setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 165)];
            [labelAbility setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 192)];
                        
            [itemAbility1 setPosition:ccp(-100, 105)];
            [itemAbility2 setPosition:ccp(0, 105)];
            [itemAbility3 setPosition:ccp(100, 105)];
            [itemAbility4 setPosition:ccp(-100, 10)];
            [itemAbility5 setPosition:ccp(0, 10)];
            [itemAbility6 setPosition:ccp(100, 10)];
            [itemAbility7 setPosition:ccp(-100, -85)];
            [itemAbility8 setPosition:ccp(0, -85)];
            [itemAbility9 setPosition:ccp(100, -85)];
            
            [spriteAbility1 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility2 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility3 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility4 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility5 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility6 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility7 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility8 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility9 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            
            [itemUpgradeShop setPosition:ccp(115, -170)];
        }
        else {
            [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (233 * 2.133f))];

            [itemTavern setPosition:ccp(-(100 * 2.4f), (218.5 * 2.133f))];
            [itemTrainer setPosition:ccp(100 * 2.4f, (218.5 * 2.133f))];
            [labelShop setPosition:ccp(screenSize.width/2, screenSize.height/2 + (218.5 * 2.133f))];
            
            [labelMerchant setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (164 * 2.133f))];
            [labelMerchantLevel setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (164 * 2.133f))];
            
            [labelAbilityName setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (165 * 2.133f))];
            [labelAbility setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (192 * 2.133f))];
            
            [itemAbility1 setPosition:ccp(-(100 * 2.4f), 105 * 2.133f)];
            [itemAbility2 setPosition:ccp(0, 105 * 2.133f)];
            [itemAbility3 setPosition:ccp(100 * 2.4f, 105 * 2.133f)];
            [itemAbility4 setPosition:ccp(-(100 * 2.4f), 10 * 2.133f)];
            [itemAbility5 setPosition:ccp(0, 10 * 2.133f)];
            [itemAbility6 setPosition:ccp(100 * 2.4f, 10 * 2.133f)];
            [itemAbility7 setPosition:ccp(-(100 * 2.4f), -(85 * 2.133f))];
            [itemAbility8 setPosition:ccp(0, -(85 * 2.133f))];
            [itemAbility9 setPosition:ccp(100 * 2.4f, -(85 * 2.133f))];
            
            [spriteAbility1 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility2 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility3 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility4 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility5 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility6 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility7 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility8 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            [spriteAbility9 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
            
            [itemUpgradeShop setPosition:ccp(115 * 2.4f, -(170 * 2.133f))];
            
            [menuOptions alignItemsHorizontallyWithPadding:(180 * 2.4f)];
            [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - (224 * 2.133f))];
        }
        
        [self addChild:background z:-2 tag:0];
        [self addChild:shopBG z:-1 tag:1];
        [self addChild:menuBar02 z:0 tag:2];
        [self addChild:labelShop z:1 tag:3];
		[self addChild:labelMerchant z:1 tag:4];
        [self addChild:labelMerchantLevel z:1 tag:5];
        [self addChild:labelAbilityName z:1 tag:6];
        [self addChild:labelAbility z:1 tag:7];
        [self addChild:menuChoice z:1 tag:8];
        [self addChild:menuAbilities z:1 tag:9];
        [self addChild:menuUpgrades z:1 tag:10];
        [self addChild:menuOptions z:1 tag:11];
                
        [itemAbility1 addChild:spriteAbility1 z:0 tag:0];
        [itemAbility2 addChild:spriteAbility2 z:0 tag:0];
        [itemAbility3 addChild:spriteAbility3 z:0 tag:0];
        [itemAbility4 addChild:spriteAbility4 z:0 tag:0];
        [itemAbility5 addChild:spriteAbility5 z:0 tag:0];
        [itemAbility6 addChild:spriteAbility6 z:0 tag:0];
        [itemAbility7 addChild:spriteAbility7 z:0 tag:0];
        [itemAbility8 addChild:spriteAbility8 z:0 tag:0];
        [itemAbility9 addChild:spriteAbility9 z:0 tag:0];
        
        if (screenSize.height == 568.00) {
            [self addChild:menuBar01 z:0 tag:12];
            [self addChild:labelMsg z:1 tag:13];
        }
        
        [self updateAbilityUpgradeButton];
        
        [self scheduleUpdate];
	}
    
	return self;
}

#pragma mark - scene setup

// setups the shop menu
-(void)setupShopMenu
{
    int level = 1;
    
    if ([[Player sharedPlayer] ability1] == 2) level++;
    if ([[Player sharedPlayer] ability2] == 2) level++;
    if ([[Player sharedPlayer] ability3] == 2) level++;
    if ([[Player sharedPlayer] ability4] == 2) level++;
    if ([[Player sharedPlayer] ability5] == 2) level++;
    if ([[Player sharedPlayer] ability6] == 2) level++;
    if ([[Player sharedPlayer] ability7] == 2) level++;
    if ([[Player sharedPlayer] ability8] == 2) level++;
    if ([[Player sharedPlayer] ability9] == 2) level++;
    
    if ([[Player sharedPlayer] ability1] == 3) level += 2;
    if ([[Player sharedPlayer] ability2] == 3) level += 2;
    if ([[Player sharedPlayer] ability3] == 3) level += 2;
    if ([[Player sharedPlayer] ability4] == 3) level += 2;
    if ([[Player sharedPlayer] ability5] == 3) level += 2;
    if ([[Player sharedPlayer] ability6] == 3) level += 2;
    if ([[Player sharedPlayer] ability7] == 3) level += 2;
    if ([[Player sharedPlayer] ability8] == 3) level += 2;
    if ([[Player sharedPlayer] ability9] == 3) level += 2;
    
    if (level < 19) {
        labelMerchantLevel = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"UpperMsgLevel", nil),
                                                       level]
                                             fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    }
    else {
        labelMerchantLevel = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"MaxLevel", nil)]
                                             fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    }
    
    [self setupAbilitiesDescriptions];
    
    labelAbilityName = [Utility labelWithString:msgAbilityName fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelAbility = [Utility labelWithString:msgAbility fontName:@"Shark Crash" fontSize:[Utility getFontSize:14]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
}

// resets the shop menu
-(void)resetShopMenu
{
    [self removeChild:labelMerchantLevel cleanup:YES];
    [self removeChild:labelAbilityName cleanup:YES];
    [self removeChild:labelAbility cleanup:YES];
    
    [itemAbility1 removeChild:spriteAbility1 cleanup:YES];
    [itemAbility2 removeChild:spriteAbility2 cleanup:YES];
    [itemAbility3 removeChild:spriteAbility3 cleanup:YES];
    [itemAbility4 removeChild:spriteAbility4 cleanup:YES];
    [itemAbility5 removeChild:spriteAbility5 cleanup:YES];
    [itemAbility6 removeChild:spriteAbility6 cleanup:YES];
    [itemAbility7 removeChild:spriteAbility7 cleanup:YES];
    [itemAbility8 removeChild:spriteAbility8 cleanup:YES];
    [itemAbility9 removeChild:spriteAbility9 cleanup:YES];
    
    [self setupShopMenu];
    
    [labelMerchantLevel setAnchorPoint:ccp(1, 0)];
    [labelAbilityName setAnchorPoint:ccp(0, 0)];
    [labelAbility setAnchorPoint:ccp(0, 0)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [labelMerchantLevel setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 166)];
        
        [labelAbilityName setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 165)];
        [labelAbility setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 192)];
        
        [spriteAbility1 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility2 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility3 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility4 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility5 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility6 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility7 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility8 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility9 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
    }
    else {
        [labelMerchantLevel setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (166 * 2.133f))];
        
        [labelAbilityName setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (165 * 2.133f))];
        [labelAbility setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (192 * 2.133f))];
        
        [spriteAbility1 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility2 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility3 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility4 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility5 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility6 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility7 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility8 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
        [spriteAbility9 setPosition:ccp(itemAbility1.contentSize.width/2, itemAbility1.contentSize.height/2)];
    }
    
    [self addChild:labelMerchantLevel z:1 tag:5];
    [self addChild:labelAbilityName z:1 tag:6];
    [self addChild:labelAbility z:1 tag:7];
    
    [itemAbility1 addChild:spriteAbility1 z:0 tag:0];
    [itemAbility2 addChild:spriteAbility2 z:0 tag:0];
    [itemAbility3 addChild:spriteAbility3 z:0 tag:0];
    [itemAbility4 addChild:spriteAbility4 z:0 tag:0];
    [itemAbility5 addChild:spriteAbility5 z:0 tag:0];
    [itemAbility6 addChild:spriteAbility6 z:0 tag:0];
    [itemAbility7 addChild:spriteAbility7 z:0 tag:0];
    [itemAbility8 addChild:spriteAbility8 z:0 tag:0];
    [itemAbility9 addChild:spriteAbility9 z:0 tag:0];
    
    [self updateAbilityUpgradeButton];
}

// setups the upper bar
-(void)setupUpperBar
{
    labelMsg = [Utility labelWithString:[Utility setupRandomMsg]
                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:16]
                                  color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263)];
}

-(void)updateAbilityUpgradeButton
{
    if (currentAbility == 1) {
        if ([[Player sharedPlayer] ability1] == 3) {
            [itemUpgradeShop setIsEnabled:NO];
        }
        else {
            [itemUpgradeShop setIsEnabled:YES];
        }
    }
    else if (currentAbility == 2) {
        if ([[Player sharedPlayer] ability2] == 3) {
            [itemUpgradeShop setIsEnabled:NO];
        }
        else {
            [itemUpgradeShop setIsEnabled:YES];
        }
    }
    else if (currentAbility == 3) {
        if ([[Player sharedPlayer] ability3] == 3) {
            [itemUpgradeShop setIsEnabled:NO];
        }
        else {
            [itemUpgradeShop setIsEnabled:YES];
        }
    }
    else if (currentAbility == 4) {
        if ([[Player sharedPlayer] ability4] == 3) {
            [itemUpgradeShop setIsEnabled:NO];
        }
        else {
            [itemUpgradeShop setIsEnabled:YES];
        }
    }
    else if (currentAbility == 5) {
        if ([[Player sharedPlayer] ability5] == 3) {
            [itemUpgradeShop setIsEnabled:NO];
        }
        else {
            [itemUpgradeShop setIsEnabled:YES];
        }
    }
    else if (currentAbility == 6) {
        if ([[Player sharedPlayer] ability6] == 3) {
            [itemUpgradeShop setIsEnabled:NO];
        }
        else {
            [itemUpgradeShop setIsEnabled:YES];
        }
    }
    else if (currentAbility == 7) {
        if ([[Player sharedPlayer] ability7] == 3) {
            [itemUpgradeShop setIsEnabled:NO];
        }
        else {
            [itemUpgradeShop setIsEnabled:YES];
        }
    }
    else if (currentAbility == 8) {
        if ([[Player sharedPlayer] ability8] == 3) {
            [itemUpgradeShop setIsEnabled:NO];
        }
        else {
            [itemUpgradeShop setIsEnabled:YES];
        }
    }
    else if (currentAbility == 9) {
        if ([[Player sharedPlayer] ability9] == 3) {
            [itemUpgradeShop setIsEnabled:NO];
        }
        else {
            [itemUpgradeShop setIsEnabled:YES];
        }
    }
}

#pragma mark - setup abilities

// setups ability descriptions
-(void)setupAbilitiesDescriptions
{
    int allowedLevel = 5;
    
    if (currentAbility == 1) {
        msgAbilityName = [NSString stringWithFormat:NSLocalizedString(@"ShopName01", nil),
                          [[Player sharedPlayer] ability1]];
        
        if ([[Player sharedPlayer] ability1] == 0) [[GameManager sharedGameManager] writeAbility1UpgradeData];
        
        if ([[Player sharedPlayer] ability1] == 2) allowedLevel = 10;
        else if ([[Player sharedPlayer] ability1] == 3) allowedLevel = 15;
        
        msgAbility = [NSString stringWithFormat:NSLocalizedString(@"ShopAbility01", nil), allowedLevel];
    }
    else if (currentAbility == 2) {
        msgAbilityName = [NSString stringWithFormat:NSLocalizedString(@"ShopName02", nil),
                          [[Player sharedPlayer] ability2]];
        
        if ([[Player sharedPlayer] ability2] == 0) [[GameManager sharedGameManager] writeAbility2UpgradeData];
        
        if ([[Player sharedPlayer] ability2] == 2) allowedLevel = 10;
        else if ([[Player sharedPlayer] ability2] == 3) allowedLevel = 15;
        
        msgAbility = [NSString stringWithFormat:NSLocalizedString(@"ShopAbility02", nil), allowedLevel];
    }
    else if (currentAbility == 3) {
        msgAbilityName = [NSString stringWithFormat:NSLocalizedString(@"ShopName03", nil),
                          [[Player sharedPlayer] ability3]];

        if ([[Player sharedPlayer] ability3] == 0) [[GameManager sharedGameManager] writeAbility3UpgradeData];
        
        if ([[Player sharedPlayer] ability3] == 2) allowedLevel = 10;
        else if ([[Player sharedPlayer] ability3] == 3) allowedLevel = 15;
        
        msgAbility = [NSString stringWithFormat:NSLocalizedString(@"ShopAbility03", nil), allowedLevel];
    }
    else if (currentAbility == 4) {
        msgAbilityName = [NSString stringWithFormat:NSLocalizedString(@"ShopName04", nil),
                          [[Player sharedPlayer] ability4]];
        
        if ([[Player sharedPlayer] ability4] == 0) [[GameManager sharedGameManager] writeAbility4UpgradeData];
        
        if ([[Player sharedPlayer] ability4] == 2) allowedLevel = 10;
        else if ([[Player sharedPlayer] ability4] == 3) allowedLevel = 15;
        
        msgAbility = [NSString stringWithFormat:NSLocalizedString(@"ShopAbility04", nil), allowedLevel];
    }
    else if (currentAbility == 5) {
        msgAbilityName = [NSString stringWithFormat:NSLocalizedString(@"ShopName05", nil),
                          [[Player sharedPlayer] ability5]];
        
        if ([[Player sharedPlayer] ability5] == 0) [[GameManager sharedGameManager] writeAbility5UpgradeData];
        
        if ([[Player sharedPlayer] ability5] == 2) allowedLevel = 10;
        else if ([[Player sharedPlayer] ability5] == 3) allowedLevel = 15;
        
        msgAbility = [NSString stringWithFormat:NSLocalizedString(@"ShopAbility05", nil), allowedLevel];
    }
    else if (currentAbility == 6) {
        msgAbilityName = [NSString stringWithFormat:NSLocalizedString(@"ShopName06", nil),
                          [[Player sharedPlayer] ability6]];
        
        if ([[Player sharedPlayer] ability6] == 0) [[GameManager sharedGameManager] writeAbility6UpgradeData];
        
        if ([[Player sharedPlayer] ability6] == 2) allowedLevel = 10;
        else if ([[Player sharedPlayer] ability6] == 3) allowedLevel = 15;
        
        msgAbility = [NSString stringWithFormat:NSLocalizedString(@"ShopAbility06", nil), allowedLevel];
    }
    else if (currentAbility == 7) {
        msgAbilityName = [NSString stringWithFormat:NSLocalizedString(@"ShopName07", nil),
                          [[Player sharedPlayer] ability7]];
        
        if ([[Player sharedPlayer] ability7] == 0) [[GameManager sharedGameManager] writeAbility7UpgradeData];
        
        if ([[Player sharedPlayer] ability7] == 2) allowedLevel = 10;
        else if ([[Player sharedPlayer] ability7] == 3) allowedLevel = 15;
        
        msgAbility = [NSString stringWithFormat:NSLocalizedString(@"ShopAbility07", nil), allowedLevel];
    }
    else if (currentAbility == 8) {
        msgAbilityName = [NSString stringWithFormat:NSLocalizedString(@"ShopName08", nil),
                          [[Player sharedPlayer] ability8]];
        
        if ([[Player sharedPlayer] ability8] == 0) [[GameManager sharedGameManager] writeAbility8UpgradeData];
        
        if ([[Player sharedPlayer] ability8] == 2) allowedLevel = 10;
        else if ([[Player sharedPlayer] ability8] == 3) allowedLevel = 15;
        
        msgAbility = [NSString stringWithFormat:NSLocalizedString(@"ShopAbility08", nil), allowedLevel];
    }
    else if (currentAbility == 9) {
        msgAbilityName = [NSString stringWithFormat:NSLocalizedString(@"ShopName09", nil),
                          [[Player sharedPlayer] ability9]];
        
        if ([[Player sharedPlayer] ability9] == 0) [[GameManager sharedGameManager] writeAbility9UpgradeData];
        
        if ([[Player sharedPlayer] ability9] == 2) allowedLevel = 10;
        else if ([[Player sharedPlayer] ability9] == 3) allowedLevel = 15;
        
        msgAbility = [NSString stringWithFormat:NSLocalizedString(@"ShopAbility09", nil), allowedLevel];
    }
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if ([[GameCenterManager sharedGameCenterManager] pendingInvite]) {
        [self setupArenaView];
    }
    
    if (itemHelp.isSelected || itemMenu.isSelected ||
        itemTavern.isSelected || itemTrainer.isSelected ||
        itemUpgradeShop.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemHelp.isSelected && !itemMenu.isSelected &&
             !itemTavern.isSelected && !itemTrainer.isSelected &&
             !itemUpgradeShop.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - upgrade shop

// upgrades shop
-(void)upgradeShop
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:currentAbility];
    
    [self addChild:shop_layer z:10];
}

#pragma mark - menu choices

// shows the tavern scene
-(void)showTavern
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneTavern withTransition:NO];
}

// shows the trainer scene
-(void)showTrainer
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneTrainer withTransition:NO];
}

// chooses ability 1
-(void)chooseAbility1:(id)sender
{
    currentAbility = 1;
    
    [itemAbility1 setSelectedIndex:1];
    [itemAbility2 setSelectedIndex:0];
    [itemAbility3 setSelectedIndex:0];
    [itemAbility4 setSelectedIndex:0];
    [itemAbility5 setSelectedIndex:0];
    [itemAbility6 setSelectedIndex:0];
    [itemAbility7 setSelectedIndex:0];
    [itemAbility8 setSelectedIndex:0];
    [itemAbility9 setSelectedIndex:0];

    [self resetShopMenu];
}

// chooses ability 2
-(void)chooseAbility2:(id)sender
{
    currentAbility = 2;
    
    [itemAbility1 setSelectedIndex:0];
    [itemAbility2 setSelectedIndex:1];
    [itemAbility3 setSelectedIndex:0];
    [itemAbility4 setSelectedIndex:0];
    [itemAbility5 setSelectedIndex:0];
    [itemAbility6 setSelectedIndex:0];
    [itemAbility7 setSelectedIndex:0];
    [itemAbility8 setSelectedIndex:0];
    [itemAbility9 setSelectedIndex:0];
    
    [self resetShopMenu];
}

// chooses ability 3
-(void)chooseAbility3:(id)sender
{
    currentAbility = 3;
    
    [itemAbility1 setSelectedIndex:0];
    [itemAbility2 setSelectedIndex:0];
    [itemAbility3 setSelectedIndex:1];
    [itemAbility4 setSelectedIndex:0];
    [itemAbility5 setSelectedIndex:0];
    [itemAbility6 setSelectedIndex:0];
    [itemAbility7 setSelectedIndex:0];
    [itemAbility8 setSelectedIndex:0];
    [itemAbility9 setSelectedIndex:0];
    
    [self resetShopMenu];
}

// chooses ability 4
-(void)chooseAbility4:(id)sender
{
    currentAbility = 4;
    
    [itemAbility1 setSelectedIndex:0];
    [itemAbility2 setSelectedIndex:0];
    [itemAbility3 setSelectedIndex:0];
    [itemAbility4 setSelectedIndex:1];
    [itemAbility5 setSelectedIndex:0];
    [itemAbility6 setSelectedIndex:0];
    [itemAbility7 setSelectedIndex:0];
    [itemAbility8 setSelectedIndex:0];
    [itemAbility9 setSelectedIndex:0];
    
    [self resetShopMenu];
}

// chooses ability 5
-(void)chooseAbility5:(id)sender
{
    currentAbility = 5;
    
    [itemAbility1 setSelectedIndex:0];
    [itemAbility2 setSelectedIndex:0];
    [itemAbility3 setSelectedIndex:0];
    [itemAbility4 setSelectedIndex:0];
    [itemAbility5 setSelectedIndex:1];
    [itemAbility6 setSelectedIndex:0];
    [itemAbility7 setSelectedIndex:0];
    [itemAbility8 setSelectedIndex:0];
    [itemAbility9 setSelectedIndex:0];
    
    [self resetShopMenu];
}

// chooses ability 6
-(void)chooseAbility6:(id)sender
{
    currentAbility = 6;
    
    [itemAbility1 setSelectedIndex:0];
    [itemAbility2 setSelectedIndex:0];
    [itemAbility3 setSelectedIndex:0];
    [itemAbility4 setSelectedIndex:0];
    [itemAbility5 setSelectedIndex:0];
    [itemAbility6 setSelectedIndex:1];
    [itemAbility7 setSelectedIndex:0];
    [itemAbility8 setSelectedIndex:0];
    [itemAbility9 setSelectedIndex:0];
    
    [self resetShopMenu];
}

// chooses ability 7
-(void)chooseAbility7:(id)sender
{
    currentAbility = 7;
    
    [itemAbility1 setSelectedIndex:0];
    [itemAbility2 setSelectedIndex:0];
    [itemAbility3 setSelectedIndex:0];
    [itemAbility4 setSelectedIndex:0];
    [itemAbility5 setSelectedIndex:0];
    [itemAbility6 setSelectedIndex:0];
    [itemAbility7 setSelectedIndex:1];
    [itemAbility8 setSelectedIndex:0];
    [itemAbility9 setSelectedIndex:0];
    
    [self resetShopMenu];
}

// chooses ability 8
-(void)chooseAbility8:(id)sender
{
    currentAbility = 8;
    
    [itemAbility1 setSelectedIndex:0];
    [itemAbility2 setSelectedIndex:0];
    [itemAbility3 setSelectedIndex:0];
    [itemAbility4 setSelectedIndex:0];
    [itemAbility5 setSelectedIndex:0];
    [itemAbility6 setSelectedIndex:0];
    [itemAbility7 setSelectedIndex:0];
    [itemAbility8 setSelectedIndex:1];
    [itemAbility9 setSelectedIndex:0];
    
    [self resetShopMenu];
}

// chooses ability 9
-(void)chooseAbility9:(id)sender
{
    currentAbility = 9;
    
    [itemAbility1 setSelectedIndex:0];
    [itemAbility2 setSelectedIndex:0];
    [itemAbility3 setSelectedIndex:0];
    [itemAbility4 setSelectedIndex:0];
    [itemAbility5 setSelectedIndex:0];
    [itemAbility6 setSelectedIndex:0];
    [itemAbility7 setSelectedIndex:0];
    [itemAbility8 setSelectedIndex:0];
    [itemAbility9 setSelectedIndex:1];
    
    [self resetShopMenu];
}

// shows the help scene
-(void)showHelp
{
    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuAbilities.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    menuUpgrades.isTouchEnabled = NO;
    
    ccColor4B colour = {0, 0, 0, 0};
    ShopHelpLayer *help_layer = [[ShopHelpLayer alloc] initWithColor:colour];
    
    [self addChild:help_layer z:10];
}

// shows the play scene
-(void)showPlay
{
    [[GameManager sharedGameManager] runSceneWithID:kScenePlay withTransition:NO];
}

#pragma mark - pausing and resuming

// pauses the game to allow the player to train
-(void)pauseGame
{
    [self pauseSchedulerAndActions];
    
    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuAbilities.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    menuUpgrades.isTouchEnabled = NO;
}

// resumes the game after player has trained
-(void)resumeGame
{
    [self resumeSchedulerAndActions];
    
    self.isTouchEnabled = YES;
    menuChoice.isTouchEnabled = YES;
    menuAbilities.isTouchEnabled = YES;
    menuOptions.isTouchEnabled = YES;
    menuUpgrades.isTouchEnabled = YES;

    [self resetShopMenu];
}

// resumes after help
-(void)resumeFromHelp
{
    self.isTouchEnabled = YES;
    menuChoice.isTouchEnabled = YES;
    menuAbilities.isTouchEnabled = YES;
    menuOptions.isTouchEnabled = YES;
    menuUpgrades.isTouchEnabled = YES;
}

#pragma mark Game Center multiplayer

// setups multiplayer view
-(void)setupArenaView
{
    [[GameCenterManager sharedGameCenterManager] findMatchWithMinPlayers:2
                                                              maxPlayers:2
                                                          viewController:[CCDirector sharedDirector]
                                                                delegate:self];
}

@end
