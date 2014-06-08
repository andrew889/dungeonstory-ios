//
//  TrainerLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 09/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface TrainerLayer : CCLayer <MultiplayerDelegate>
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *trainerBG;
    CCSprite *menuBar01;
    CCSprite *menuBar02;
    
    CCSprite *labelTrainer;
    CCSprite *labelCombat;
    CCSprite *labelSurvival;
    CCSprite *labelPractical;
    CCSprite *labelCombatVal;
    CCSprite *labelSurvivalVal;
    CCSprite *labelPracticalVal;
    CCSprite *labelCombatSkill1;
    CCSprite *labelCombatSkill1Val;
    CCSprite *labelCombatSkill2;
    CCSprite *labelCombatSkill2Val;
    CCSprite *labelCombatSkill3;
    CCSprite *labelCombatSkill3Val;
    CCSprite *labelSurvivalSkill1;
    CCSprite *labelSurvivalSkill1Val;
    CCSprite *labelSurvivalSkill2;
    CCSprite *labelSurvivalSkill2Val;
    CCSprite *labelSurvivalSkill3;
    CCSprite *labelSurvivalSkill3Val;
    CCSprite *labelPracticalSkill1;
    CCSprite *labelPracticalSkill1Val;
    CCSprite *labelPracticalSkill2;
    CCSprite *labelPracticalSkill2Val;
    CCSprite *labelPracticalSkill3;
    CCSprite *labelPracticalSkill3Val;
    
    CCMenu *menuChoice;
    CCMenu *menuUpgrades;
    CCMenu *menuOptions;
    
    CCMenuItemSprite *itemTavern;
    CCMenuItemSprite *itemShop;
    CCMenuItemSprite *itemHelp;
    CCMenuItemSprite *itemMenu;
    
    CCMenuItemImage *itemUpgradeCombat1;
    CCMenuItemImage *itemUpgradeCombat2;
    CCMenuItemImage *itemUpgradeCombat3;
    CCMenuItemImage *itemUpgradeSurvival1;
    CCMenuItemImage *itemUpgradeSurvival2;
    CCMenuItemImage *itemUpgradeSurvival3;
    CCMenuItemImage *itemUpgradePractical1;
    CCMenuItemImage *itemUpgradePractical2;
    CCMenuItemImage *itemUpgradePractical3;
    
    NSString *combatSkill1;
    NSString *combatSkill2;
    NSString *combatSkill3;
    NSString *survivalSkill1;
    NSString *survivalSkill2;
    NSString *survivalSkill3;
    NSString *practicalSkill1;
    NSString *practicalSkill2;
    NSString *practicalSkill3;
    NSString *totalCombat;
    NSString *totalSurvival;
    NSString *totalPractical;
    
    CCSprite *labelMsg;
    NSString *msg;
}

+(CCScene*)scene;

-(void)resumeGame;
-(void)resumeFromHelp;

@end
