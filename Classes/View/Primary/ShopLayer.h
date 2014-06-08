//
//  ShopLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 09/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface ShopLayer : CCLayer <MultiplayerDelegate>
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *shopBG;
    CCSprite *menuBar01;
    CCSprite *menuBar02;
    
    CCSprite *labelShop;
    CCSprite *labelMerchant;
    CCSprite *labelMerchantLevel;
    
    CCSprite *labelAbilityName;
    CCSprite *labelAbility;
    
    CCSprite *spriteAbility1;
    CCSprite *spriteAbility2;
    CCSprite *spriteAbility3;
    CCSprite *spriteAbility4;
    CCSprite *spriteAbility5;
    CCSprite *spriteAbility6;
    CCSprite *spriteAbility7;
    CCSprite *spriteAbility8;
    CCSprite *spriteAbility9;
    
    CCMenuItemImage *itemAbilityOff1;
    CCMenuItemImage *itemAbilityOn1;
    CCMenuItemImage *itemAbilityOff2;
    CCMenuItemImage *itemAbilityOn2;
    CCMenuItemImage *itemAbilityOff3;
    CCMenuItemImage *itemAbilityOn3;
    CCMenuItemImage *itemAbilityOff4;
    CCMenuItemImage *itemAbilityOn4;
    CCMenuItemImage *itemAbilityOff5;
    CCMenuItemImage *itemAbilityOn5;
    CCMenuItemImage *itemAbilityOff6;
    CCMenuItemImage *itemAbilityOn6;
    CCMenuItemImage *itemAbilityOff7;
    CCMenuItemImage *itemAbilityOn7;
    CCMenuItemImage *itemAbilityOff8;
    CCMenuItemImage *itemAbilityOn8;
    CCMenuItemImage *itemAbilityOff9;
    CCMenuItemImage *itemAbilityOn9;
    
    CCMenuItemToggle *itemAbility1;
    CCMenuItemToggle *itemAbility2;
    CCMenuItemToggle *itemAbility3;
    CCMenuItemToggle *itemAbility4;
    CCMenuItemToggle *itemAbility5;
    CCMenuItemToggle *itemAbility6;
    CCMenuItemToggle *itemAbility7;
    CCMenuItemToggle *itemAbility8;
    CCMenuItemToggle *itemAbility9;
    
    CCMenu *menuChoice;
    CCMenu *menuAbilities;
    CCMenu *menuUpgrades;
    CCMenu *menuOptions;
    
    CCMenuItemSprite *itemTavern;
    CCMenuItemSprite *itemTrainer;
    CCMenuItemSprite *itemHelp;
    CCMenuItemSprite *itemMenu;
    
    CCMenuItemImage *itemUpgradeShop;
    
    NSString *msgAbilityName;
    NSString *msgAbility;
    int currentAbility;
    
    CCSprite *labelMsg;
    NSString *msg;
}

+(CCScene*)scene;

-(void)resumeGame;
-(void)resumeFromHelp;

@end
