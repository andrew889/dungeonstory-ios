//
//  MultiplayLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 10/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface MultiplayLayer : CCLayer <MultiplayerDelegate>
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
    
    CCMenu *menuChoice;
    CCMenu *menuOptions;
    
    CCMenuItemImage *itemArena;
    CCMenuItemImage *itemTournament;
    CCMenuItemImage *itemTrainingYard;
    
    CCMenuItemSprite *itemPreferences;
    CCMenuItemSprite *itemMenu;
    
    NSString *msgName;
    NSString *msgLevel;
}

+(CCScene*)scene;

-(void)resume;

@end
