//
//  PlayLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface PlayLayer : CCLayer <MultiplayerDelegate>
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *menuBar01;
    CCSprite *menuBar02;
    
    CCSprite *labelName;
    CCSprite *labelLevel;
    
    CCSprite *labelBtn01;
    CCSprite *labelBtn02;
    CCSprite *labelBtn03;
    CCSprite *labelBtn04;
    CCSprite *labelBtn05;
    CCSprite *labelBtn06;
    CCSprite *labelBtn07;
    CCSprite *labelBtn08;
    
    CCMenu *menuDungeon1;
    CCMenu *menuDungeon2;
    CCMenu *menuChoice;
    CCMenu *menuOptions;
    
    CCMenuItemImage *itemCharacter;
    CCMenuItemImage *itemTown;
    CCMenuItemImage *itemHardOff;
    CCMenuItemImage *itemHardOn;
    CCMenuItemImage *itemDungeon1;
    CCMenuItemImage *itemDungeon2;
    CCMenuItemImage *itemDungeon3;
    CCMenuItemImage *itemDungeon4;
    CCMenuItemImage *itemDungeon5;
    CCMenuItemImage *itemDungeon6;
    
    CCMenuItemToggle *itemHardToggle;
    
    CCMenuItemSprite *itemHelp;
    CCMenuItemSprite *itemMenu;
    
    NSString *msgName;
    NSString *msgLevel;
}

+(CCScene*)scene;

-(void)resumeFromHelp;

@end
