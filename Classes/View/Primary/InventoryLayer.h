//
//  InventoryLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface InventoryLayer : CCLayer <MultiplayerDelegate>
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *inventoryBG;
    CCSprite *menuBar01;
    CCSprite *menuBar02;
        
    CCSprite *labelInventory;
    CCSprite *labelItemCounter;
    CCSprite *labelItemCounterVal;
    CCSprite *labelGold;
    CCSprite *labelGoldVal;
    CCSprite *labelWeapon;
    CCSprite *labelSpellbook;
    CCSprite *labelArmor;
    CCSprite *labelRing;
    CCSprite *labelAmulet;
    CCSprite *labelWeaponVal;
    CCSprite *labelSpellbookVal;
    CCSprite *labelArmorVal;
    CCSprite *labelRingVal;
    CCSprite *labelAmuletVal;
    
    CCMenu *menuChoice;
    CCMenu *menuUpgrades;
    CCMenu *menuItems;
    CCMenu *menuSndItems;
    CCMenu *menuOptions;
    
    CCMenuItemSprite *itemStats;
    CCMenuItemSprite *itemStory;
    CCMenuItemSprite *itemHelp;
    CCMenuItemSprite *itemMenu;
    
    CCMenuItemImage *itemUpgradeWeapon;
    CCMenuItemImage *itemUpgradeSpellbook;
    CCMenuItemImage *itemUpgradeArmor;
    CCMenuItemImage *itemUpgradeRing;
    CCMenuItemImage *itemUpgradeAmulet;
    
    CCMenuItemImage *itemSlot1;
    CCMenuItemImage *itemSlot2;
    CCMenuItemImage *itemSlot3;
    CCMenuItemImage *itemSnd1;
    CCMenuItemImage *itemSnd2;
    CCMenuItemImage *itemSnd3;
    CCMenuItemImage *itemSnd4;
    CCMenuItemImage *itemSndPressed1;
    CCMenuItemImage *itemSndPressed2;
    CCMenuItemImage *itemSndPressed3;
    CCMenuItemImage *itemSndPressed4;
    
    CCMenuItemToggle *itemSnd1Toggle;
    CCMenuItemToggle *itemSnd2Toggle;
    CCMenuItemToggle *itemSnd3Toggle;
    CCMenuItemToggle *itemSnd4Toggle;
    
    CCSprite *spriteSlot1Msg;
    CCSprite *spriteSlot2Msg;
    CCSprite *spriteSlot3Msg;
    CCLabelTTF *labelSlot1Msg;
    CCLabelTTF *labelSlot2Msg;
    CCLabelTTF *labelSlot3Msg;
    CCLabelTTF *labelSlot1MsgVal;
    CCLabelTTF *labelSlot2MsgVal;
    CCLabelTTF *labelSlot3MsgVal;
        
    CCSprite *item1;
    CCSprite *item2;
    CCSprite *item3;
    CCSprite *item4;
    CCSprite *item5;
    CCSprite *item6;
    CCSprite *item7;
    
    int selectedSnd;
    
    NSString *currentGold;
    NSString *itemCounter;
    NSString *weapon;
    NSString *spellbook;
    NSString *armor;
    NSString *ring;
    NSString *amulet;
    
    CCSprite *labelMsg;
    NSString *msg;
}

+(CCScene*)scene;

-(void)resumeGame;
-(void)resumeFromHelp;

@end
