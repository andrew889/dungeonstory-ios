//
//  StatsLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface StatsLayer : CCLayer <MultiplayerDelegate>
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *statsBG;
    CCSprite *rankBar;
    CCSprite *rankBar2;
    CCSprite *menuBar01;
    CCSprite *menuBar02;
    CCSprite *keyboard;
    
    CCSprite *labelStats;
    CCSprite *labelName;
    
    CCSprite *labelNameVal;
    
    CCSprite *labelLevel;
    CCSprite *labelReqExp;
    CCSprite *labelHP;
    CCSprite *labelAttack;
    CCSprite *labelDefence;
    CCSprite *labelMagic;
    CCSprite *labelLuck;
    CCSprite *labelLevelVal;
    CCSprite *labelReqExpVal;
    CCSprite *labelHPVal;
    CCSprite *labelAttackVal;
    CCSprite *labelDefenceVal;
    CCSprite *labelMagicVal;
    CCSprite *labelLuckVal;
    CCSprite *labelClass;
    CCSprite *labelClassVal;
    CCSprite *labelClassRank;
    CCSprite *labelClassRankVal;
    CCSprite *labelAbility;
    CCSprite *labelAbilityVal;
    CCSprite *labelScore;
    CCSprite *labelScoreVal;
    CCSprite *labelMonsters;
    CCSprite *labelMonstersVal;
    CCSprite *labelVictories;
    CCSprite *labelVictoriesVal;
    CCSprite *labelRounds;
    CCSprite *labelRoundsVal;
    CCSprite *labelVerticalLine;
    
    CCMenu *menuChoice;
    CCMenu *menuClasses;
    CCMenu *menuOptions;
    
    CCMenuItemSprite *itemInventory;
    CCMenuItemSprite *itemStory;
    CCMenuItemSprite *itemHelp;
    CCMenuItemSprite *itemMenu;
    
    CCMenuItemImage *itemClass1;
    CCMenuItemImage *itemClass2;
    CCMenuItemImage *itemClass3;
    CCMenuItemImage *itemClass4;
    CCMenuItemImage *itemClass5;
    CCMenuItemImage *itemClass6;
    CCMenuItemImage *itemClass7;
    CCMenuItemImage *itemClass8;
    CCMenuItemImage *itemClass9;
    
    CCMenu *menuKeyboardUpper;
    CCMenu *menuKeyboardMiddle;
    CCMenu *menuKeyboardLower;
    CCMenu *menuKeyboard;
    
    CCMenuItemImage *keyboardQ;
    CCMenuItemImage *keyboardW;
    CCMenuItemImage *keyboardE;
    CCMenuItemImage *keyboardR;
    CCMenuItemImage *keyboardT;
    CCMenuItemImage *keyboardY;
    CCMenuItemImage *keyboardU;
    CCMenuItemImage *keyboardI;
    CCMenuItemImage *keyboardO;
    CCMenuItemImage *keyboardP;
    CCMenuItemImage *keyboardA;
    CCMenuItemImage *keyboardS;
    CCMenuItemImage *keyboardD;
    CCMenuItemImage *keyboardF;
    CCMenuItemImage *keyboardG;
    CCMenuItemImage *keyboardH;
    CCMenuItemImage *keyboardJ;
    CCMenuItemImage *keyboardK;
    CCMenuItemImage *keyboardL;
    CCMenuItemImage *keyboardZ;
    CCMenuItemImage *keyboardX;
    CCMenuItemImage *keyboardC;
    CCMenuItemImage *keyboardV;
    CCMenuItemImage *keyboardB;
    CCMenuItemImage *keyboardN;
    CCMenuItemImage *keyboardM;
    CCMenuItemImage *keyboardUp_on;
    CCMenuItemImage *keyboardUp_off;
    CCMenuItemImage *keyboardDel;
    CCMenuItemImage *keyboardDone;
    CCMenuItemImage *keyboardSpace;
    
    BOOL isCapital;
    BOOL shouldGlow;
    
    NSString *playerName;
    NSString *playerLevel;
    NSString *playerHP;
    NSString *playerAttack;
    NSString *playerDefence;
    NSString *playerMagic;
    NSString *playerLuck;
    NSString *requiredExperience;
    NSString *playerClass;
    NSString *abilityName;
    NSString *abilityVal;
    NSString *totalScore;
    NSString *highestRounds;
    NSString *monstersKilled;
    NSString *victories;
    
    CCSprite *labelMsg;
    NSString *msg;
}

+(CCScene*)scene;

-(void)resumeFromHelp;

@end
