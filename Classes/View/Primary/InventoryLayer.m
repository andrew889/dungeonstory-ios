//
//  InventoryLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "InventoryLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "ShopUpgradeLayer.h"
#import "InventoryHelpLayer.h"
#import "Utility.h"

#pragma mark - InventoryLayer

@implementation InventoryLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	InventoryLayer *layer = [InventoryLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"Menu.png"];
        inventoryBG = [CCSprite spriteWithFile:@"InventoryMenu.png"];
        menuBar01 = [CCSprite spriteWithFile:@"menubar.png"];
        menuBar02 = [CCSprite spriteWithFile:@"menubar.png"];
        spriteSlot1Msg = [CCSprite spriteWithFile:@"InventoryHelp1.png"];
        spriteSlot2Msg = [CCSprite spriteWithFile:@"InventoryHelp2.png"];
        spriteSlot3Msg = [CCSprite spriteWithFile:@"InventoryHelp1.png"];
        
        if ([[Player sharedPlayer] shield] == 2) {
            item1 = [CCSprite spriteWithFile:@"shield_item_2.png"];
        }
        else {
            item1 = [CCSprite spriteWithFile:@"shield_item.png"];
        }
        
        if ([[Player sharedPlayer] potion] == 1) {
            item2 = [CCSprite spriteWithFile:@"potion_item.png"];
        }
        else {
            item2 = [CCSprite spriteWithFile:@"potion_item_2.png"];
        }
        
        if ([[Player sharedPlayer] bomb] == 1) {
            item3 = [CCSprite spriteWithFile:@"bomb_item.png"];
        }
        else {
            item3 = [CCSprite spriteWithFile:@"bomb_item_2.png"];
        }
        
        if ([[Player sharedPlayer] ale] == 1) {
            item4 = [CCSprite spriteWithFile:@"ale_item.png"];
        }
        else {
            item4 = [CCSprite spriteWithFile:@"ale_item_2.png"];
        }
        
        if ([[Player sharedPlayer] rune] == 1) {
            item5 = [CCSprite spriteWithFile:@"rune_item.png"];
        }
        else {
            item5 = [CCSprite spriteWithFile:@"rune_item_2.png"];
        }
        
        if ([[Player sharedPlayer] mirror] == 1) {
            item6 = [CCSprite spriteWithFile:@"mirror_item.png"];
        }
        else {
            item6 = [CCSprite spriteWithFile:@"mirror_item_2.png"];
        }
        
        if ([[Player sharedPlayer] flute] == 1) {
            item7 = [CCSprite spriteWithFile:@"flute_item.png"];
        }
        else {
            item7 = [CCSprite spriteWithFile:@"flute_item_2.png"];
        }
        
        [self setupInventoryMenu];
        
        if (screenSize.height == 568.00) [self setupUpperBar];
        
        labelInventory = [Utility labelWithString:NSLocalizedString(@"ItemsLabel", nil)
                                         fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]
                                            color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelItemCounter = [Utility labelWithString:NSLocalizedString(@"ItemCounter", nil)
                                           fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                              color:ccc3(170, 212, 0) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelGold = [Utility labelWithString:NSLocalizedString(@"GoldCounter", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                       color:ccc3(255, 182, 18) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelWeapon = [Utility labelWithString:NSLocalizedString(@"ItemWeapon", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelSpellbook = [Utility labelWithString:NSLocalizedString(@"ItemSpellbook", nil)
                                         fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                            color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelArmor = [Utility labelWithString:NSLocalizedString(@"ItemArmor", nil)
                                     fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelRing = [Utility labelWithString:NSLocalizedString(@"ItemRing", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                       color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelAmulet = [Utility labelWithString:NSLocalizedString(@"ItemAmulet", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
                
        labelSlot1Msg =[CCLabelTTF labelWithString:[self setupItemHelpText:[[GameManager sharedGameManager] itemSlot1]]
                                          fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        labelSlot2Msg =[CCLabelTTF labelWithString:[self setupItemHelpText:[[GameManager sharedGameManager] itemSlot2]]
                                                                  fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        labelSlot3Msg =[CCLabelTTF labelWithString:[self setupItemHelpText:[[GameManager sharedGameManager] itemSlot3]]
                                                                  fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        labelSlot1MsgVal =[CCLabelTTF labelWithString:[self setupItemHelpTextRanks:[[GameManager sharedGameManager] itemSlot1]]
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        labelSlot2MsgVal =[CCLabelTTF labelWithString:[self setupItemHelpTextRanks:[[GameManager sharedGameManager] itemSlot2]]
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        labelSlot3MsgVal =[CCLabelTTF labelWithString:[self setupItemHelpTextRanks:[[GameManager sharedGameManager] itemSlot3]]
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        [labelSlot1Msg setColor:ccBLACK];
        [labelSlot2Msg setColor:ccBLACK];
        [labelSlot3Msg setColor:ccBLACK];
        [labelSlot1MsgVal setColor:ccBLACK];
        [labelSlot2MsgVal setColor:ccBLACK];
        [labelSlot3MsgVal setColor:ccBLACK];
        
        itemStats = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"StatsLabel", nil)
                                                                           fontName:@"Shark Crash"
                                                                           fontSize:[Utility getFontSize:26]
                                                                              color:ccWHITE
                                                                         strokeSize:[Utility getFontSize:1.5]
                                                                         stokeColor:ccBLACK]
                     
                                            selectedSprite:[Utility labelWithString:NSLocalizedString(@"StatsLabel", nil)
                                                                           fontName:@"Shark Crash"
                                                                           fontSize:[Utility getFontSize:26]
                                                                              color:ccc3(255, 204, 102)
                                                                         strokeSize:[Utility getFontSize:1.5]
                                                                         stokeColor:ccBLACK]
                     
                                                    target:self selector:@selector(showStats)];
        
        itemStory = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"QuestLabel", nil)
                                                                           fontName:@"Shark Crash"
                                                                           fontSize:[Utility getFontSize:26]
                                                                              color:ccWHITE
                                                                         strokeSize:[Utility getFontSize:1.5]
                                                                         stokeColor:ccBLACK]
                     
                                            selectedSprite:[Utility labelWithString:NSLocalizedString(@"QuestLabel", nil)
                                                                           fontName:@"Shark Crash"
                                                                           fontSize:[Utility getFontSize:26]
                                                                              color:ccc3(255, 204, 102)
                                                                         strokeSize:[Utility getFontSize:1.5]
                                                                         stokeColor:ccBLACK]
                     
                                                    target:self selector:@selector(showStory)];
        
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
        
        itemSlot1 = [CCMenuItemImage itemWithNormalImage:@"itemSlot.png"
                                           selectedImage:@"itemSlot_pressed.png"
                                           disabledImage:nil
                                                  target:self
                                                selector:@selector(swapSlot1)];
        
        if ([[Player sharedPlayer] potion] == 1) {
            itemSlot2 = [CCMenuItemImage itemWithNormalImage:@"itemSlot.png"
                                               selectedImage:@"itemSlot_pressed.png"
                                               disabledImage:nil
                                                      target:self
                                                    selector:@selector(swapSlot2)];
        }
        else {
            itemSlot2 = [CCMenuItemImage itemWithNormalImage:@"itemSlot.png"
                                               selectedImage:@"itemSlot_pressed.png"
                                               disabledImage:nil
                                                      target:self
                                                    selector:@selector(upgradePotion)];
        }
        
        if ([[Player sharedPlayer] bomb] == 1) {
            itemSlot3 = [CCMenuItemImage itemWithNormalImage:@"itemSlot.png"
                                               selectedImage:@"itemSlot_pressed.png"
                                               disabledImage:nil
                                                      target:self
                                                    selector:@selector(swapSlot3)];
        }
        else {
            itemSlot3 = [CCMenuItemImage itemWithNormalImage:@"itemSlot.png"
                                               selectedImage:@"itemSlot_pressed.png"
                                               disabledImage:nil
                                                      target:self
                                                    selector:@selector(upgradeBomb)];
        }
        
        if ([[Player sharedPlayer] ale] == 0) {
            itemSnd1 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                              selectedImage:@"sndSlot_pressed.png"];
            
            itemSndPressed1 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                                     selectedImage:@"sndSlot_pressed.png"];
            
            itemSnd1Toggle = [CCMenuItemToggle itemWithTarget:self
                                                     selector:@selector(upgradeAle:)
                                                        items:itemSnd1, itemSndPressed1, nil];
        }
        else {
            itemSnd1 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                              selectedImage:@"noItem.png"];
            
            itemSndPressed1 = [CCMenuItemImage itemWithNormalImage:@"sndSlot_pressed.png"
                                                     selectedImage:@"sndSlot_pressed.png"];
            
            itemSnd1Toggle = [CCMenuItemToggle itemWithTarget:self
                                                     selector:@selector(swapSnd1:)
                                                        items:itemSnd1, itemSndPressed1, nil];
        }
        
        if ([[Player sharedPlayer] rune] == 0) {
            itemSnd2 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                              selectedImage:@"sndSlot_pressed.png"];
            
            itemSndPressed2 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                                     selectedImage:@"sndSlot_pressed.png"];
            
            itemSnd2Toggle = [CCMenuItemToggle itemWithTarget:self
                                                     selector:@selector(upgradeRune:)
                                                        items:itemSnd2, itemSndPressed2, nil];
        }
        else {
            itemSnd2 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                              selectedImage:@"noItem.png"];
            
            itemSndPressed2 = [CCMenuItemImage itemWithNormalImage:@"sndSlot_pressed.png"
                                                     selectedImage:@"sndSlot_pressed.png"];
            
            itemSnd2Toggle = [CCMenuItemToggle itemWithTarget:self
                                                     selector:@selector(swapSnd2:)
                                                        items:itemSnd2, itemSndPressed2, nil];
        }
        
        if ([[Player sharedPlayer] mirror] == 0) {
            itemSnd3 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                              selectedImage:@"sndSlot_pressed.png"];
            
            itemSndPressed3 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                                     selectedImage:@"sndSlot_pressed.png"];
            
            itemSnd3Toggle = [CCMenuItemToggle itemWithTarget:self
                                                     selector:@selector(upgradeMirror:)
                                                        items:itemSnd3, itemSndPressed3, nil];
        }
        else {
            itemSnd3 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                              selectedImage:@"noItem.png"];
            
            itemSndPressed3 = [CCMenuItemImage itemWithNormalImage:@"sndSlot_pressed.png"
                                                     selectedImage:@"sndSlot_pressed.png"];
            
            itemSnd3Toggle = [CCMenuItemToggle itemWithTarget:self
                                                     selector:@selector(swapSnd3:)
                                                        items:itemSnd3, itemSndPressed3, nil];
        }
        
        if ([[Player sharedPlayer] flute] == 0) {
            itemSnd4 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                              selectedImage:@"sndSlot_pressed.png"];
            
            itemSndPressed4 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                                     selectedImage:@"sndSlot_pressed.png"];
            
            itemSnd4Toggle = [CCMenuItemToggle itemWithTarget:self
                                                     selector:@selector(upgradeFlute:)
                                                        items:itemSnd4, itemSndPressed4, nil];
        }
        else {
            itemSnd4 = [CCMenuItemImage itemWithNormalImage:@"noItem.png"
                                              selectedImage:@"noItem.png"];
            
            itemSndPressed4 = [CCMenuItemImage itemWithNormalImage:@"sndSlot_pressed.png"
                                                     selectedImage:@"sndSlot_pressed.png"];
            
            itemSnd4Toggle = [CCMenuItemToggle itemWithTarget:self
                                                     selector:@selector(swapSnd4:)
                                                        items:itemSnd4, itemSndPressed4, nil];
        }
        
		menuChoice = [CCMenu menuWithItems:itemStats, itemStory, nil];
        menuUpgrades = [CCMenu menuWithItems:itemUpgradeWeapon, itemUpgradeSpellbook,
                        itemUpgradeArmor, itemUpgradeRing, itemUpgradeAmulet, nil];
        menuItems = [CCMenu menuWithItems:itemSlot1, itemSlot2, itemSlot3, nil];
        menuSndItems = [CCMenu menuWithItems:itemSnd1Toggle, itemSnd2Toggle,
                        itemSnd3Toggle, itemSnd4Toggle, nil];
        menuOptions = [CCMenu menuWithItems:itemHelp, itemMenu, nil];
        
        [labelItemCounter setAnchorPoint:ccp(0, 0)];
        [labelItemCounterVal setAnchorPoint:ccp(1, 0)];
        [labelGold setAnchorPoint:ccp(0, 0)];
        [labelGoldVal setAnchorPoint:ccp(1, 0)];
        [labelWeapon setAnchorPoint:ccp(0, 0)];
        [labelSpellbook setAnchorPoint:ccp(0, 0)];
        [labelArmor setAnchorPoint:ccp(0, 0)];
        [labelRing setAnchorPoint:ccp(0, 0)];
        [labelAmulet setAnchorPoint:ccp(0, 0)];
        [labelWeaponVal setAnchorPoint:ccp(1, 0)];
        [labelSpellbookVal setAnchorPoint:ccp(1, 0)];
        [labelArmorVal setAnchorPoint:ccp(1, 0)];
        [labelRingVal setAnchorPoint:ccp(1, 0)];
        [labelAmuletVal setAnchorPoint:ccp(1, 0)];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [inventoryBG setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
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
            
            [itemStats setPosition:ccp(-100, 218)];
            [labelInventory setPosition:ccp(screenSize.width/2, screenSize.height/2 + 218)];
            [itemStory setPosition:ccp(100, 218)];
            
            [labelItemCounter setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 173)];
            [labelItemCounterVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 172)];
            [labelGold setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 149)];
            [labelGoldVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 148)];
            
            [labelWeapon setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 108)];
            [labelSpellbook setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 81)];
            [labelArmor setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 54)];
            [labelRing setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 27)];
            [labelAmulet setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 0)];
            [labelWeaponVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 108)];
            [labelSpellbookVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 81)];
            [labelArmorVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 54)];
            [labelRingVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 27)];
            [labelAmuletVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 0)];
            
            [itemUpgradeWeapon setPosition:ccp(120, 116.2)];
            [itemUpgradeSpellbook setPosition:ccp(120, 89.4)];
            [itemUpgradeArmor setPosition:ccp(120, 62.6)];
            [itemUpgradeRing setPosition:ccp(120, 35.8)];
            [itemUpgradeAmulet setPosition:ccp(120, 9)];
            
            [spriteSlot1Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 62)];
            [spriteSlot2Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 62)];
            [spriteSlot3Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 62)];
            
            [labelSlot1Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 109)];
            [labelSlot2Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 109)];
            [labelSlot3Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 109)];
            [labelSlot1MsgVal setPosition:ccp(screenSize.width/2, screenSize.height/2 + 37)];
            [labelSlot2MsgVal setPosition:ccp(screenSize.width/2, screenSize.height/2 + 37)];
            [labelSlot3MsgVal setPosition:ccp(screenSize.width/2, screenSize.height/2 + 37)];
            
            [menuItems alignItemsHorizontallyWithPadding:2];
            [menuItems setPosition:ccp(screenSize.width/2, screenSize.height/2 - 61.5)];
            [menuSndItems alignItemsHorizontallyWithPadding:5];
            [menuSndItems setPosition:ccp(screenSize.width/2, screenSize.height/2 - 158)];
        }
        else {
            [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (233 * 2.133f))];
            
            [itemStats setPosition:ccp(-(100 * 2.4f), 218.5 * 2.133f)];
            [labelInventory setPosition:ccp(screenSize.width/2, screenSize.height/2 + (218.5 * 2.133f))];
            [itemStory setPosition:ccp((100 * 2.4f), 218.5 * 2.133f)];
            
            [labelItemCounter setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (172 * 2.133f))];
            [labelItemCounterVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (170 * 2.133f))];
            [labelGold setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (148 * 2.133f))];
            [labelGoldVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (146 * 2.133f))];
            
            [labelWeapon setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (107 * 2.133f))];
            [labelSpellbook setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (80 * 2.133f))];
            [labelArmor setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (53 * 2.133f))];
            [labelRing setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (26 * 2.133f))];
            [labelAmulet setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (1 * 2.133f))];
            [labelWeaponVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (107 * 2.133f))];
            [labelSpellbookVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (80 * 2.133f))];
            [labelArmorVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (53 * 2.133f))];
            [labelRingVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (26 * 2.133f))];
            [labelAmuletVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (1 * 2.133f))];
            
            [itemUpgradeWeapon setPosition:ccp((120 * 2.4f), (116.2 * 2.133f))];
            [itemUpgradeSpellbook setPosition:ccp((120 * 2.4f), (89.4 * 2.133f))];
            [itemUpgradeArmor setPosition:ccp((120 * 2.4f), (62.6 * 2.133f))];
            [itemUpgradeRing setPosition:ccp((120 * 2.4f), (35.8 * 2.133f))];
            [itemUpgradeAmulet setPosition:ccp((120 * 2.4f), (9 * 2.133f))];
            
            [spriteSlot1Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (62 * 2.133f))];
            [spriteSlot2Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (62 * 2.133f))];
            [spriteSlot3Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (62 * 2.133f))];
            
            [labelSlot1Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (113 * 2.133f))];
            [labelSlot2Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (113 * 2.133f))];
            [labelSlot3Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (113 * 2.133f))];
            [labelSlot1MsgVal setPosition:ccp(screenSize.width/2, screenSize.height/2 + (34 * 2.133f))];
            [labelSlot2MsgVal setPosition:ccp(screenSize.width/2, screenSize.height/2 + (34 * 2.133f))];
            [labelSlot3MsgVal setPosition:ccp(screenSize.width/2, screenSize.height/2 + (34 * 2.133f))];
            
            [menuItems alignItemsHorizontallyWithPadding:(10 * 2.4f)];
            [menuItems setPosition:ccp(screenSize.width/2, screenSize.height/2 - (61.5 * 2.133f))];
            [menuSndItems alignItemsHorizontallyWithPadding:(15 * 2.4f)];
            [menuSndItems setPosition:ccp(screenSize.width/2, screenSize.height/2 - (158 * 2.133f))];
            [menuOptions alignItemsHorizontallyWithPadding:(180 * 2.4f)];
            [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - (224 * 2.133f))];
        }
        
        [self addChild:background z:-2 tag:0];
        [self addChild:inventoryBG z:-1 tag:1];
        [self addChild:menuBar02 z:0 tag:2];
        [self addChild:labelInventory z:1 tag:3];
        [self addChild:labelItemCounter z:1 tag:4];
        [self addChild:labelItemCounterVal z:1 tag:5];
        [self addChild:labelGold z:1 tag:6];
        [self addChild:labelGoldVal z:1 tag:7];
        [self addChild:labelWeapon z:1 tag:8];
        [self addChild:labelSpellbook z:1 tag:9];
        [self addChild:labelArmor z:1 tag:10];
        [self addChild:labelRing z:1 tag:11];
        [self addChild:labelAmulet z:1 tag:12];
        [self addChild:labelWeaponVal z:1 tag:13];
        [self addChild:labelSpellbookVal z:1 tag:14];
        [self addChild:labelArmorVal z:1 tag:15];
        [self addChild:labelRingVal z:1 tag:16];
        [self addChild:labelAmuletVal z:1 tag:17];
        [self addChild:spriteSlot1Msg z:2 tag:18];
        [self addChild:spriteSlot2Msg z:2 tag:19];
        [self addChild:spriteSlot3Msg z:2 tag:20];
        [self addChild:labelSlot1Msg z:3 tag:21];
        [self addChild:labelSlot1MsgVal z:3 tag:22];
        [self addChild:labelSlot2Msg z:3 tag:23];
        [self addChild:labelSlot2MsgVal z:3 tag:24];
        [self addChild:labelSlot3Msg z:3 tag:25];
        [self addChild:labelSlot3MsgVal z:3 tag:26];
		[self addChild:menuChoice z:1 tag:27];
        [self addChild:menuUpgrades z:1 tag:28];
        [self addChild:menuItems z:1 tag:29];
        [self addChild:menuSndItems z:1 tag:30];
        [self addChild:menuOptions z:1 tag:31];
                
        if (screenSize.height == 568.00) {
            [self addChild:menuBar01 z:0 tag:32];
            [self addChild:labelMsg z:1 tag:33];
        }
        
        selectedSnd = 0;
        
        [self setupItemSlots];
        
        [self scheduleUpdate];
        
        [spriteSlot3Msg setScaleX:-1.0f];
        [spriteSlot1Msg setScaleY:1.05f];
        [spriteSlot2Msg setScaleY:1.15f];
        [spriteSlot3Msg setScaleY:1.05f];
        
        spriteSlot1Msg.visible = NO;
        spriteSlot2Msg.visible = NO;
        spriteSlot3Msg.visible = NO;
        labelSlot1Msg.visible = NO;
        labelSlot1MsgVal.visible = NO;
        labelSlot2Msg.visible = NO;
        labelSlot2MsgVal.visible = NO;
        labelSlot3Msg.visible = NO;
        labelSlot3MsgVal.visible = NO;
	}
    
	return self;
}

#pragma mark - scene setup

// setups the inventory menu
-(void)setupInventoryMenu
{
    itemUpgradeWeapon = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                               selectedImage:@"upgrade_btn_pressed.png"
                                               disabledImage:@"upgrade_btn2.png"
                                                      target:self
                                                    selector:@selector(upgradeWeapon)];
    itemUpgradeSpellbook = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                  selectedImage:@"upgrade_btn_pressed.png"
                                                  disabledImage:@"upgrade_btn2.png"
                                                         target:self
                                                       selector:@selector(upgradeSpellbook)];
    itemUpgradeArmor = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                              selectedImage:@"upgrade_btn_pressed.png"
                                              disabledImage:@"upgrade_btn2.png"
                                                     target:self
                                                   selector:@selector(upgradeArmor)];
    itemUpgradeRing = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                             selectedImage:@"upgrade_btn_pressed.png"
                                             disabledImage:@"upgrade_btn2.png"
                                                    target:self
                                                  selector:@selector(upgradeRing)];
    itemUpgradeAmulet = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                               selectedImage:@"upgrade_btn_pressed.png"
                                               disabledImage:@"upgrade_btn2.png"
                                                      target:self
                                                    selector:@selector(upgradeAmulet)];
    
    [self setupItems];
    
    labelItemCounterVal = [Utility labelWithString:itemCounter fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                             color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelGoldVal = [Utility labelWithString:currentGold fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelWeaponVal = [Utility labelWithString:weapon fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSpellbookVal = [Utility labelWithString:spellbook fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                           color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelArmorVal = [Utility labelWithString:armor fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                       color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelRingVal = [Utility labelWithString:ring fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelAmuletVal = [Utility labelWithString:amulet fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
}

// setups item slots
-(void)setupItemSlots
{
    if ([[GameManager sharedGameManager] itemSlot1] != 1 &&
        [[GameManager sharedGameManager] itemSlot2] != 1 &&
        [[GameManager sharedGameManager] itemSlot3] != 1) {
        
        [item1 setScale:0.7];
        [item1 setPosition:ccp(itemSnd1Toggle.contentSize.width/2, itemSnd1Toggle.contentSize.height/2)];
    }
    else {
        [item1 setScale:1.0];
        [item1 setPosition:ccp(itemSlot1.contentSize.width/2, itemSlot1.contentSize.height/2)];
    }
    
    if ([[GameManager sharedGameManager] itemSlot1] != 2 &&
        [[GameManager sharedGameManager] itemSlot2] != 2 &&
        [[GameManager sharedGameManager] itemSlot3] != 2) {
        
        [item2 setScale:0.7];
        [item2 setPosition:ccp(itemSnd1Toggle.contentSize.width/2, itemSnd1Toggle.contentSize.height/2)];
    }
    else {
        [item2 setScale:1.0];
        [item2 setPosition:ccp(itemSlot1.contentSize.width/2, itemSlot1.contentSize.height/2)];
    }
    
    if ([[GameManager sharedGameManager] itemSlot1] != 3 &&
        [[GameManager sharedGameManager] itemSlot2] != 3 &&
        [[GameManager sharedGameManager] itemSlot3] != 3) {
        
        [item3 setScale:0.7];
        [item3 setPosition:ccp(itemSnd1Toggle.contentSize.width/2, itemSnd1Toggle.contentSize.height/2)];
    }
    else {
        [item3 setScale:1.0];
        [item3 setPosition:ccp(itemSlot1.contentSize.width/2, itemSlot1.contentSize.height/2)];
    }
    
    if ([[GameManager sharedGameManager] itemSlot1] != 4 &&
        [[GameManager sharedGameManager] itemSlot2] != 4 &&
        [[GameManager sharedGameManager] itemSlot3] != 4) {
        
        [item4 setScale:0.7];
        [item4 setPosition:ccp(itemSnd1Toggle.contentSize.width/2, itemSnd1Toggle.contentSize.height/2)];
    }
    else {
        [item4 setScale:1.0];
        [item4 setPosition:ccp(itemSlot1.contentSize.width/2, itemSlot1.contentSize.height/2)];
    }
    
    if ([[GameManager sharedGameManager] itemSlot1] != 5 &&
        [[GameManager sharedGameManager] itemSlot2] != 5 &&
        [[GameManager sharedGameManager] itemSlot3] != 5) {
        
        [item5 setScale:0.7];
        [item5 setPosition:ccp(itemSnd1Toggle.contentSize.width/2, itemSnd1Toggle.contentSize.height/2)];
    }
    else {
        [item5 setScale:1.0];
        [item5 setPosition:ccp(itemSlot1.contentSize.width/2, itemSlot1.contentSize.height/2)];
    }
    
    if ([[GameManager sharedGameManager] itemSlot1] != 6 &&
        [[GameManager sharedGameManager] itemSlot2] != 6 &&
        [[GameManager sharedGameManager] itemSlot3] != 6) {
        
        [item6 setScale:0.7];
        [item6 setPosition:ccp(itemSnd1Toggle.contentSize.width/2, itemSnd1Toggle.contentSize.height/2)];
    }
    else {
        [item6 setScale:1.0];
        [item6 setPosition:ccp(itemSlot1.contentSize.width/2, itemSlot1.contentSize.height/2)];
    }
    
    if ([[GameManager sharedGameManager] itemSlot1] != 7 &&
        [[GameManager sharedGameManager] itemSlot2] != 7 &&
        [[GameManager sharedGameManager] itemSlot3] != 7) {
        
        [item7 setScale:0.7];
        [item7 setPosition:ccp(itemSnd1Toggle.contentSize.width/2, itemSnd1Toggle.contentSize.height/2)];
    }
    else {
        [item7 setScale:1.0];
        [item7 setPosition:ccp(itemSlot1.contentSize.width/2, itemSlot1.contentSize.height/2)];
    }
    
    if ([[GameManager sharedGameManager] itemSlot1] == 1) [itemSlot1 addChild:item1 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot1] == 2) [itemSlot1 addChild:item2 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot1] == 3) [itemSlot1 addChild:item3 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot1] == 4) [itemSlot1 addChild:item4 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot1] == 5) [itemSlot1 addChild:item5 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot1] == 6) [itemSlot1 addChild:item6 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot1] == 7) [itemSlot1 addChild:item7 z:1 tag:0];
    
    if ([[GameManager sharedGameManager] itemSlot2] == 1) [itemSlot2 addChild:item1 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot2] == 2) [itemSlot2 addChild:item2 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot2] == 3) [itemSlot2 addChild:item3 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot2] == 4) [itemSlot2 addChild:item4 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot2] == 5) [itemSlot2 addChild:item5 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot2] == 6) [itemSlot2 addChild:item6 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot2] == 7) [itemSlot2 addChild:item7 z:1 tag:0];
    
    if ([[GameManager sharedGameManager] itemSlot3] == 1) [itemSlot3 addChild:item1 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot3] == 2) [itemSlot3 addChild:item2 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot3] == 3) [itemSlot3 addChild:item3 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot3] == 4) [itemSlot3 addChild:item4 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot3] == 5) [itemSlot3 addChild:item5 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot3] == 6) [itemSlot3 addChild:item6 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot3] == 7) [itemSlot3 addChild:item7 z:1 tag:0];
    
    if ([[GameManager sharedGameManager] itemSlot4] == 1) [itemSnd1Toggle addChild:item1 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot4] == 2) [itemSnd1Toggle addChild:item2 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot4] == 3) [itemSnd1Toggle addChild:item3 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot4] == 4) [itemSnd1Toggle addChild:item4 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot4] == 5) [itemSnd1Toggle addChild:item5 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot4] == 6) [itemSnd1Toggle addChild:item6 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot4] == 7) [itemSnd1Toggle addChild:item7 z:1 tag:0];
    
    if ([[GameManager sharedGameManager] itemSlot5] == 1) [itemSnd2Toggle addChild:item1 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot5] == 2) [itemSnd2Toggle addChild:item2 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot5] == 3) [itemSnd2Toggle addChild:item3 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot5] == 4) [itemSnd2Toggle addChild:item4 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot5] == 5) [itemSnd2Toggle addChild:item5 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot5] == 6) [itemSnd2Toggle addChild:item6 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot5] == 7) [itemSnd2Toggle addChild:item7 z:1 tag:0];
    
    if ([[GameManager sharedGameManager] itemSlot6] == 1) [itemSnd3Toggle addChild:item1 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot6] == 2) [itemSnd3Toggle addChild:item2 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot6] == 3) [itemSnd3Toggle addChild:item3 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot6] == 4) [itemSnd3Toggle addChild:item4 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot6] == 5) [itemSnd3Toggle addChild:item5 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot6] == 6) [itemSnd3Toggle addChild:item6 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot6] == 7) [itemSnd3Toggle addChild:item7 z:1 tag:0];
    
    if ([[GameManager sharedGameManager] itemSlot7] == 1) [itemSnd4Toggle addChild:item1 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot7] == 2) [itemSnd4Toggle addChild:item2 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot7] == 3) [itemSnd4Toggle addChild:item3 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot7] == 4) [itemSnd4Toggle addChild:item4 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot7] == 5) [itemSnd4Toggle addChild:item5 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot7] == 6) [itemSnd4Toggle addChild:item6 z:1 tag:0];
    else if ([[GameManager sharedGameManager] itemSlot7] == 7) [itemSnd4Toggle addChild:item7 z:1 tag:0];
}

// setups the upper bar
-(void)setupUpperBar
{
    labelMsg = [Utility labelWithString:[Utility setupRandomMsg]
                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:16]
                                  color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263)];
}

#pragma mark - setup item descriptions

// setups item descriptions
-(void)setupItems
{
    if ([[Player sharedPlayer] weapon] == 1) weapon = NSLocalizedString(@"Weapon01", nil);
    else if ([[Player sharedPlayer] weapon] == 2) weapon = NSLocalizedString(@"Weapon02", nil);
    else if ([[Player sharedPlayer] weapon] == 3) weapon = NSLocalizedString(@"Weapon03", nil);
    else if ([[Player sharedPlayer] weapon] == 4) weapon = NSLocalizedString(@"Weapon04", nil);
    else if ([[Player sharedPlayer] weapon] == 5) weapon = NSLocalizedString(@"Weapon05", nil);
    else if ([[Player sharedPlayer] weapon] == 6) weapon = NSLocalizedString(@"Weapon06", nil);
    else if ([[Player sharedPlayer] weapon] == 7) weapon = NSLocalizedString(@"Weapon07", nil);
    else if ([[Player sharedPlayer] weapon] == 8) weapon = NSLocalizedString(@"Weapon08", nil);
    else if ([[Player sharedPlayer] weapon] == 9) weapon = NSLocalizedString(@"Weapon09", nil);
    else if ([[Player sharedPlayer] weapon] == 10) weapon = NSLocalizedString(@"Weapon10", nil);
    
    if ([[Player sharedPlayer] spellbook] == 1) spellbook = NSLocalizedString(@"Spellbook01", nil);
    else if ([[Player sharedPlayer] spellbook] == 2) spellbook = NSLocalizedString(@"Spellbook02", nil);
    else if ([[Player sharedPlayer] spellbook] == 3) spellbook = NSLocalizedString(@"Spellbook03", nil);
    else if ([[Player sharedPlayer] spellbook] == 4) spellbook = NSLocalizedString(@"Spellbook04", nil);
    else if ([[Player sharedPlayer] spellbook] == 5) spellbook = NSLocalizedString(@"Spellbook05", nil);
    else if ([[Player sharedPlayer] spellbook] == 6) spellbook = NSLocalizedString(@"Spellbook06", nil);
    else if ([[Player sharedPlayer] spellbook] == 7) spellbook = NSLocalizedString(@"Spellbook07", nil);
    else if ([[Player sharedPlayer] spellbook] == 8) spellbook = NSLocalizedString(@"Spellbook08", nil);
    else if ([[Player sharedPlayer] spellbook] == 9) spellbook = NSLocalizedString(@"Spellbook09", nil);
    else if ([[Player sharedPlayer] spellbook] == 10) spellbook = NSLocalizedString(@"Spellbook10", nil);
    
    if ([[Player sharedPlayer] armor] == 0) armor = NSLocalizedString(@"ItemEmpty", nil);
    else if ([[Player sharedPlayer] armor] == 1) armor = NSLocalizedString(@"Armor01", nil);
    else if ([[Player sharedPlayer] armor] == 2) armor = NSLocalizedString(@"Armor02", nil);
    else if ([[Player sharedPlayer] armor] == 3) armor = NSLocalizedString(@"Armor03", nil);
    else if ([[Player sharedPlayer] armor] == 4) armor = NSLocalizedString(@"Armor04", nil);
    else if ([[Player sharedPlayer] armor] == 5) armor = NSLocalizedString(@"Armor05", nil);
    else if ([[Player sharedPlayer] armor] == 6) armor = NSLocalizedString(@"Armor06", nil);
    else if ([[Player sharedPlayer] armor] == 7) armor = NSLocalizedString(@"Armor07", nil);
    else if ([[Player sharedPlayer] armor] == 8) armor = NSLocalizedString(@"Armor08", nil);
    else if ([[Player sharedPlayer] armor] == 9) armor = NSLocalizedString(@"Armor09", nil);
    else if ([[Player sharedPlayer] armor] == 10) armor = NSLocalizedString(@"Armor10", nil);
    
    if ([[Player sharedPlayer] ring] == 0) ring = NSLocalizedString(@"ItemEmpty", nil);
    else if ([[Player sharedPlayer] ring] == 1) ring = NSLocalizedString(@"Ring01", nil);
    else if ([[Player sharedPlayer] ring] == 2) ring = NSLocalizedString(@"Ring02", nil);
    else if ([[Player sharedPlayer] ring] == 3) ring = NSLocalizedString(@"Ring03", nil);
    else if ([[Player sharedPlayer] ring] == 4) ring = NSLocalizedString(@"Ring04", nil);
    else if ([[Player sharedPlayer] ring] == 5) ring = NSLocalizedString(@"Ring05", nil);
    else if ([[Player sharedPlayer] ring] == 6) ring = NSLocalizedString(@"Ring06", nil);
    else if ([[Player sharedPlayer] ring] == 7) ring = NSLocalizedString(@"Ring07", nil);
    else if ([[Player sharedPlayer] ring] == 8) ring = NSLocalizedString(@"Ring08", nil);
    else if ([[Player sharedPlayer] ring] == 9) ring = NSLocalizedString(@"Ring09", nil);
    else if ([[Player sharedPlayer] ring] == 10) ring = NSLocalizedString(@"Ring10", nil);
    
    if ([[Player sharedPlayer] amulet] == 0) amulet = NSLocalizedString(@"ItemEmpty", nil);
    else if ([[Player sharedPlayer] amulet] == 1) amulet = NSLocalizedString(@"Amulet01", nil);
    else if ([[Player sharedPlayer] amulet] == 2) amulet = NSLocalizedString(@"Amulet02", nil);
    else if ([[Player sharedPlayer] amulet] == 3) amulet = NSLocalizedString(@"Amulet03", nil);
    else if ([[Player sharedPlayer] amulet] == 4) amulet = NSLocalizedString(@"Amulet04", nil);
    else if ([[Player sharedPlayer] amulet] == 5) amulet = NSLocalizedString(@"Amulet05", nil);
    else if ([[Player sharedPlayer] amulet] == 6) amulet = NSLocalizedString(@"Amulet06", nil);
    else if ([[Player sharedPlayer] amulet] == 7) amulet = NSLocalizedString(@"Amulet07", nil);
    else if ([[Player sharedPlayer] amulet] == 8) amulet = NSLocalizedString(@"Amulet08", nil);
    else if ([[Player sharedPlayer] amulet] == 9) amulet = NSLocalizedString(@"Amulet09", nil);
    else if ([[Player sharedPlayer] amulet] == 10) amulet = NSLocalizedString(@"Amulet10", nil);
    
    itemCounter = [NSString stringWithFormat:@"%d / 58",
                   [[Player sharedPlayer] weapon] +
                   [[Player sharedPlayer] spellbook] +
                   [[Player sharedPlayer] armor] +
                   [[Player sharedPlayer] ring] +
                   [[Player sharedPlayer] amulet] +
                   [[Player sharedPlayer] shield] +
                   [[Player sharedPlayer] potion] +
                   [[Player sharedPlayer] bomb] +
                   [[Player sharedPlayer] ale] +
                   [[Player sharedPlayer] rune] +
                   [[Player sharedPlayer] mirror] +
                   [[Player sharedPlayer] flute]];
    
    currentGold = [NSString stringWithFormat:@"%lld", [[Player sharedPlayer] currentGold]];
    
    if ([[Player sharedPlayer] weapon] == 10 &&
        [[Player sharedPlayer] spellbook] == 10 &&
        [[Player sharedPlayer] armor] == 10 &&
        [[Player sharedPlayer] ring] == 10 &&
        [[Player sharedPlayer] amulet] == 10 &&
        [[Player sharedPlayer] shield] == 2 &&
        [[Player sharedPlayer] potion] == 1 &&
        [[Player sharedPlayer] bomb] == 1 &&
        [[Player sharedPlayer] ale] == 1 &&
        [[Player sharedPlayer] rune] == 1 &&
        [[Player sharedPlayer] mirror] == 1 &&
        [[Player sharedPlayer] flute] == 1) {
        
        [labelItemCounterVal setColor:ccc3(255, 204, 102)];
    }
    
    if ([[Player sharedPlayer] weapon] == 10) [itemUpgradeWeapon setIsEnabled:NO];
    if ([[Player sharedPlayer] spellbook] == 10) [itemUpgradeSpellbook setIsEnabled:NO];
    if ([[Player sharedPlayer] armor] == 10) [itemUpgradeArmor setIsEnabled:NO];
    if ([[Player sharedPlayer] ring] == 10) [itemUpgradeRing setIsEnabled:NO];
    if ([[Player sharedPlayer] amulet] == 10) [itemUpgradeAmulet setIsEnabled:NO];
}

// setups the item help text
-(NSString*)setupItemHelpText:(int)value
{
    NSString *string;
    
    if (value == 1) string = NSLocalizedString(@"BattleItem01", nil);
    else if (value == 2) string = NSLocalizedString(@"BattleItem02", nil);
    else if (value == 3) string = NSLocalizedString(@"BattleItem03", nil);
    else if (value == 4) string = NSLocalizedString(@"BattleItem04", nil);
    else if (value == 5) string = NSLocalizedString(@"BattleItem05", nil);
    else if (value == 6) string = NSLocalizedString(@"BattleItem06", nil);
    else if (value == 7) string = NSLocalizedString(@"BattleItem07", nil);
    
    return string;
}

// setups the item help text
-(NSString*)setupItemHelpTextRanks:(int)value
{
    NSString *string;
    
    if (value == 1) {
        if ([[Player sharedPlayer] shield] == 2) string = NSLocalizedString(@"BattleItemRank01x", nil);
        else string = NSLocalizedString(@"BattleItemRank01", nil);
    }
    else if (value == 2) string = NSLocalizedString(@"BattleItemRank02", nil);
    else if (value == 3) {
        if ([[Player sharedPlayer] classVal] == 8) string = NSLocalizedString(@"BattleItemRank03x", nil);
        else string = NSLocalizedString(@"BattleItemRank03", nil);
    }
    else if (value == 4) string = NSLocalizedString(@"BattleItemRank04", nil);
    else if (value == 5) string = NSLocalizedString(@"BattleItemRank05", nil);
    else if (value == 6) string = NSLocalizedString(@"BattleItemRank06", nil);
    else if (value == 7) string = NSLocalizedString(@"BattleItemRank07", nil);
    
    return string;
}

#pragma mark - update schedulers

// updates battle
-(void)update:(ccTime)dt
{
    if ([[GameCenterManager sharedGameCenterManager] pendingInvite]) {
        [self setupArenaView];
    }
    
    if (itemSlot1.isSelected && (selectedSnd == 0)) {
        spriteSlot1Msg.visible = YES;
        labelSlot1Msg.visible = YES;
        labelSlot1MsgVal.visible = YES;
    }
    else {
        spriteSlot1Msg.visible = NO;
        labelSlot1Msg.visible = NO;
        labelSlot1MsgVal.visible = NO;
    }
    
    if (itemSlot2.isSelected && [[Player sharedPlayer] potion] == 1
        && (selectedSnd == 0)) {
        
        spriteSlot2Msg.visible = YES;
        labelSlot2Msg.visible = YES;
        labelSlot2MsgVal.visible = YES;
    }
    else {
        spriteSlot2Msg.visible = NO;
        labelSlot2Msg.visible = NO;
        labelSlot2MsgVal.visible = NO;
    }
    
    if (itemSlot3.isSelected && [[Player sharedPlayer] bomb] == 1
        && (selectedSnd == 0)) {
        
        spriteSlot3Msg.visible = YES;
        labelSlot3Msg.visible = YES;
        labelSlot3MsgVal.visible = YES;
    }
    else {
        spriteSlot3Msg.visible = NO;
        labelSlot3Msg.visible = NO;
        labelSlot3MsgVal.visible = NO;
    }
    
    if (itemHelp.isSelected || itemMenu.isSelected ||
        itemStats.isSelected ||
        itemUpgradeWeapon.isSelected || itemUpgradeSpellbook.isSelected ||
        itemUpgradeArmor.isSelected || itemUpgradeRing.isSelected ||
        itemUpgradeAmulet.isSelected || itemSlot1.isSelected ||
        itemSlot2.isSelected || itemSlot3.isSelected ||
        itemSnd1.isSelected || itemSnd2.isSelected ||
        itemSnd3.isSelected || itemSnd4.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemHelp.isSelected && !itemMenu.isSelected &&
             !itemStats.isSelected &&
             !itemUpgradeWeapon.isSelected && !itemUpgradeSpellbook.isSelected &&
             !itemUpgradeArmor.isSelected && !itemUpgradeRing.isSelected &&
             !itemUpgradeAmulet.isSelected && !itemSlot1.isSelected &&
             !itemSlot2.isSelected && !itemSlot3.isSelected &&
             !itemSnd1.isSelected && !itemSnd2.isSelected &&
             !itemSnd3.isSelected && !itemSnd4.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - upgrade inventory

// upgrades the weapon
-(void)upgradeWeapon
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:1
                                                                   withItem:weapon];
    
    [self addChild:shop_layer z:10];
}

// upgrades the spellbook
-(void)upgradeSpellbook
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:2
                                                                   withItem:spellbook];
    
    [self addChild:shop_layer z:10];
}

// upgrades the armor
-(void)upgradeArmor
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:3
                                                                   withItem:armor];
    
    [self addChild:shop_layer z:10];
}

// upgrades the ring
-(void)upgradeRing
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:4
                                                                   withItem:ring];
    
    [self addChild:shop_layer z:10];
}

// upgrades the amulet
-(void)upgradeAmulet
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:5
                                                                   withItem:amulet];
    
    [self addChild:shop_layer z:10];
}

// upgrades the potion
-(void)upgradePotion
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:6
                                                                   withItem:@""];
    
    [self addChild:shop_layer z:10];
}

// upgrades the bomb
-(void)upgradeBomb
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:7
                                                                   withItem:@""];
    
    [self addChild:shop_layer z:10];
}

// upgrades the ale
-(void)upgradeAle:(id)sender
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:8
                                                                   withItem:@""];
    
    [self addChild:shop_layer z:10];
}

// upgrades the rune
-(void)upgradeRune:(id)sender
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:9
                                                                   withItem:@""];
    
    [self addChild:shop_layer z:10];
}

// upgrades the mirror
-(void)upgradeMirror:(id)sender
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:10
                                                                   withItem:@""];
    
    [self addChild:shop_layer z:10];
}

// upgrades the flute
-(void)upgradeFlute:(id)sender
{
    [self pauseGame];
    
    ShopUpgradeLayer *shop_layer = [[ShopUpgradeLayer alloc] initWithChoice:11
                                                                   withItem:@""];
    
    [self addChild:shop_layer z:10];
}

#pragma mark - menu choices

// shows the stats scene
-(void)showStats
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats withTransition:NO];
}

// shows the story scene
-(void)showStory
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneStory withTransition:NO];
}

// shows the help scene
-(void)showHelp
{
    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuItems.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    menuUpgrades.isTouchEnabled = NO;
    menuSndItems.isTouchEnabled = NO;
    
    ccColor4B colour = {0, 0, 0, 0};
    InventoryHelpLayer *help_layer = [[InventoryHelpLayer alloc] initWithColor:colour];
    
    [self addChild:help_layer z:10];
}

// shows the play scene
-(void)showPlay
{
    [[GameManager sharedGameManager] runSceneWithID:kScenePlay withTransition:NO];
}

// swaps slot 1
-(void)swapSlot1
{
    if (selectedSnd != 0) {
        [[GameManager sharedGameManager] writeSwapSlot:1
                                              withSlot:selectedSnd];
        
        [itemSlot1 removeChildByTag:0 cleanup:YES];
        [itemSlot2 removeChildByTag:0 cleanup:YES];
        [itemSlot3 removeChildByTag:0 cleanup:YES];
        [itemSnd1Toggle removeChildByTag:0 cleanup:YES];
        [itemSnd2Toggle removeChildByTag:0 cleanup:YES];
        [itemSnd3Toggle removeChildByTag:0 cleanup:YES];
        [itemSnd4Toggle removeChildByTag:0 cleanup:YES];
        
        [self setupItemSlots];
        
        selectedSnd = 0;
        
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
        
        [labelSlot1Msg setString:[self setupItemHelpText:[[GameManager sharedGameManager] itemSlot1]]];
        [labelSlot1MsgVal setString:[self setupItemHelpTextRanks:[[GameManager sharedGameManager] itemSlot1]]];
    }
}

// swaps slot 2
-(void)swapSlot2
{
    if (selectedSnd != 0) {
        [[GameManager sharedGameManager] writeSwapSlot:2
                                              withSlot:selectedSnd];
        
        [itemSlot1 removeChildByTag:0 cleanup:YES];
        [itemSlot2 removeChildByTag:0 cleanup:YES];
        [itemSlot3 removeChildByTag:0 cleanup:YES];
        [itemSnd1Toggle removeChildByTag:0 cleanup:YES];
        [itemSnd2Toggle removeChildByTag:0 cleanup:YES];
        [itemSnd3Toggle removeChildByTag:0 cleanup:YES];
        [itemSnd4Toggle removeChildByTag:0 cleanup:YES];
        
        [self setupItemSlots];
        
        selectedSnd = 0;
        
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
        
        [labelSlot2Msg setString:[self setupItemHelpText:[[GameManager sharedGameManager] itemSlot2]]];
        [labelSlot2MsgVal setString:[self setupItemHelpTextRanks:[[GameManager sharedGameManager] itemSlot2]]];
    }
}

// swaps slot 3
-(void)swapSlot3
{
    if (selectedSnd != 0) {
        [[GameManager sharedGameManager] writeSwapSlot:3
                                              withSlot:selectedSnd];
        
        [itemSlot1 removeChildByTag:0 cleanup:YES];
        [itemSlot2 removeChildByTag:0 cleanup:YES];
        [itemSlot3 removeChildByTag:0 cleanup:YES];
        [itemSnd1Toggle removeChildByTag:0 cleanup:YES];
        [itemSnd2Toggle removeChildByTag:0 cleanup:YES];
        [itemSnd3Toggle removeChildByTag:0 cleanup:YES];
        [itemSnd4Toggle removeChildByTag:0 cleanup:YES];
        
        [self setupItemSlots];
        
        selectedSnd = 0;
        
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
        
        [labelSlot3Msg setString:[self setupItemHelpText:[[GameManager sharedGameManager] itemSlot3]]];
        [labelSlot3MsgVal setString:[self setupItemHelpTextRanks:[[GameManager sharedGameManager] itemSlot3]]];
    }
}

// swaps first secondary item
-(void)swapSnd1:(id)sender
{
    if ([[Player sharedPlayer] ale] == 1) {
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
        
        if (selectedSnd == 0) selectedSnd = 1;
        else selectedSnd = 0;
    }
    else {
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
    }
}

// swaps second secondary item
-(void)swapSnd2:(id)sender
{
    if ([[Player sharedPlayer] rune] == 1) {
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
        
        if (selectedSnd == 0) selectedSnd = 2;
        else selectedSnd = 0;
    }
    else {
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
    }
}

// swaps third secondary item
-(void)swapSnd3:(id)sender
{
    if ([[Player sharedPlayer] mirror] == 1) {
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
        
        if (selectedSnd == 0) selectedSnd = 3;
        else selectedSnd = 0;
    }
    else {
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
    }
}

// swaps fourth secondary item
-(void)swapSnd4:(id)sender
{
    if ([[Player sharedPlayer] flute] == 1) {
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        
        if (selectedSnd == 0) selectedSnd = 4;
        else selectedSnd = 0;
    }
    else {
        [itemSnd1Toggle setSelectedIndex:0];
        [itemSnd2Toggle setSelectedIndex:0];
        [itemSnd3Toggle setSelectedIndex:0];
        [itemSnd4Toggle setSelectedIndex:0];
    }
}

#pragma mark - pausing and resuming

// pauses the game to allow the player to shop
-(void)pauseGame
{
    [self pauseSchedulerAndActions];
    
    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuItems.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    menuUpgrades.isTouchEnabled = NO;
    menuSndItems.isTouchEnabled = NO;
}

// resumes the game after player has shopped
-(void)resumeGame
{
    [self resumeSchedulerAndActions];
    
    self.isTouchEnabled = YES;
    menuChoice.isTouchEnabled = YES;
    menuItems.isTouchEnabled = YES;
    menuOptions.isTouchEnabled = YES;
    menuUpgrades.isTouchEnabled = YES;
    menuSndItems.isTouchEnabled = YES;
    
    [self setupItems];
    
    [self removeChild:labelItemCounterVal cleanup:YES];
    [self removeChild:labelGoldVal cleanup:YES];
    [self removeChild:labelWeaponVal cleanup:YES];
    [self removeChild:labelSpellbookVal cleanup:YES];
    [self removeChild:labelArmorVal cleanup:YES];
    [self removeChild:labelRingVal cleanup:YES];
    [self removeChild:labelAmuletVal cleanup:YES];
    
    labelItemCounterVal = [Utility labelWithString:itemCounter fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                             color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelGoldVal = [Utility labelWithString:currentGold fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelWeaponVal = [Utility labelWithString:weapon fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSpellbookVal = [Utility labelWithString:spellbook fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                           color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelArmorVal = [Utility labelWithString:armor fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                       color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelRingVal = [Utility labelWithString:ring fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelAmuletVal = [Utility labelWithString:amulet fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    [labelItemCounterVal setAnchorPoint:ccp(1, 0)];
    [labelGoldVal setAnchorPoint:ccp(1, 0)];
    [labelWeaponVal setAnchorPoint:ccp(1, 0)];
    [labelSpellbookVal setAnchorPoint:ccp(1, 0)];
    [labelArmorVal setAnchorPoint:ccp(1, 0)];
    [labelRingVal setAnchorPoint:ccp(1, 0)];
    [labelAmuletVal setAnchorPoint:ccp(1, 0)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [labelItemCounterVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 172)];
        [labelGoldVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 148)];
        [labelWeaponVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 108)];
        [labelSpellbookVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 81)];
        [labelArmorVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 54)];
        [labelRingVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 27)];
        [labelAmuletVal setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 0)];
    }
    else {
        [labelItemCounterVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (170 * 2.133f))];
        [labelGoldVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (146 * 2.133f))];
        [labelWeaponVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (107 * 2.133f))];
        [labelSpellbookVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (80 * 2.133f))];
        [labelArmorVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (53 * 2.133f))];
        [labelRingVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (26 * 2.133f))];
        [labelAmuletVal setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (1 * 2.133f))];
    }
    
    [self addChild:labelItemCounterVal z:1 tag:5];
    [self addChild:labelGoldVal z:1 tag:7];
    [self addChild:labelWeaponVal z:1 tag:13];
    [self addChild:labelSpellbookVal z:1 tag:14];
    [self addChild:labelArmorVal z:1 tag:15];
    [self addChild:labelRingVal z:1 tag:16];
    [self addChild:labelAmuletVal z:1 tag:17];
    
    if ([[Player sharedPlayer] potion] == 1 || [[Player sharedPlayer] bomb] == 1) {
        [[GameManager sharedGameManager] runSceneWithID:kSceneInventory
                                         withTransition:NO];
    }
}

// resumes after help
-(void)resumeFromHelp
{
    self.isTouchEnabled = YES;
    menuChoice.isTouchEnabled = YES;
    menuItems.isTouchEnabled = YES;
    menuOptions.isTouchEnabled = YES;
    menuUpgrades.isTouchEnabled = YES;
    menuSndItems.isTouchEnabled = YES;
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
