//
//  StoryLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface StoryLayer : CCLayer <MultiplayerDelegate>
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *inventoryBG;
    CCSprite *menuBar01;
    CCSprite *menuBar02;
        
    CCSprite *labelStory;
    CCSprite *labelEmblem;
    CCSprite *labelEmblemVal;
    CCSprite *labelProgress;
    CCSprite *labelPlayer1;
    CCSprite *labelPlayer2;
    CCSprite *labelPlayer3;
    CCSprite *labelPlayer4;
    CCSprite *labelPlayer5;
    CCSprite *labelPlayer6;
    CCSprite *labelPlayerVal1;
    CCSprite *labelPlayerVal2;
    CCSprite *labelPlayerVal3;
    CCSprite *labelPlayerVal4;
    CCSprite *labelPlayerVal5;
    CCSprite *labelPlayerVal6;
    
    CCMenu *menuChoice;
    CCMenu *menuEmblems;
    CCMenu *menuOptions;
    
    CCMenuItemSprite *itemStats;
    CCMenuItemSprite *itemInventory;
    CCMenuItemSprite *itemHelp;
    CCMenuItemSprite *itemMenu;
        
    CCMenuItemImage *itemEmblem1;
    CCMenuItemImage *itemEmblem2;
    CCMenuItemImage *itemEmblem3;
    CCMenuItemImage *itemEmblem4;
    
    CCSprite *spriteEmblem1Msg;
    CCSprite *spriteEmblem2Msg;
    CCSprite *spriteEmblem3Msg;
    CCSprite *spriteEmblem4Msg;
    CCLabelTTF *labelEmblem1Msg;
    CCLabelTTF *labelEmblem2Msg;
    CCLabelTTF *labelEmblem3Msg;
    CCLabelTTF *labelEmblem4Msg;
    
    GKLeaderboard *leaderboard;
    NSMutableArray *identifiers;
    
    NSString *currentEmblem;
    NSString *friendName1;
    NSString *friendName2;
    NSString *friendName3;
    NSString *friendName4;
    NSString *friendName5;
    NSString *friendName6;
    NSString *friendScore1;
    NSString *friendScore2;
    NSString *friendScore3;
    NSString *friendScore4;
    NSString *friendScore5;
    NSString *friendScore6;
    
    CCSprite *labelMsg;
    NSString *msg;
}

+(CCScene*)scene;

@end
