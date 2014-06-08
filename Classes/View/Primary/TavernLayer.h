//
//  TavernLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 01/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface TavernLayer : CCLayer <MultiplayerDelegate>
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *tavernBG;
    CCSprite *repBar;
    CCSprite *repBar2;
    CCSprite *menuBar01;
    CCSprite *menuBar02;
    
    CCSprite *labelTavern;
    CCSprite *labelQuestsDone;
    CCSprite *labelQuestsDoneVal;
    CCSprite *labelRumors;
    CCSprite *labelReputation;
    CCSprite *labelQuest1;
    CCSprite *labelQuest2;
    
    CCMenu *menuChoice;
    CCMenu *menuQuests;
    CCMenu *menuBrew;
    CCMenu *menuOptions;
    
    CCMenuItemImage *itemQuest1;
    CCMenuItemImage *itemQuest2;
    
    CCMenuItemSprite *itemShop;
    CCMenuItemSprite *itemTrainer;
    CCMenuItemSprite *itemBrewery;
    CCMenuItemSprite *itemHelp;
    CCMenuItemSprite *itemMenu;
    
    BOOL shouldGlow;
    BOOL showSecondReward;
    
    NSString *msgName;
    NSString *msgLevel;
    NSString *msgQuest1;
    NSString *msgQuest2;
    
    int questGen1;
    int questGen2;
    
    CCSprite *labelMsg;
    NSString *msg;
}

+(CCScene*)scene;

-(void)resumeFromHelp;

@end
