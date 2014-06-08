//
//  MenuLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface MenuLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate, MultiplayerDelegate>
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *mainLogo;
    CCSprite *mainMenuSword;
    CCSprite *mainMenuGlow;
    
    CCSprite *labelBtn01;
    CCSprite *labelBtn02;
    CCSprite *labelBtn03;
    CCSprite *labelBtn04;
    
    CCMenu *menuChoices;
    CCMenu *menuSocial;
    CCMenu *menuStore;
    CCMenu *menuGameCenter;
    
    CCMenuItemImage *itemPlay;
    CCMenuItemImage *itemOnline;
    CCMenuItemImage *itemOptions;
    CCMenuItemImage *itemStore;
    CCMenuItemImage *itemAchievements;
    CCMenuItemImage *itemLeaderboards;
    CCMenuItemImage *itemTw;
    CCMenuItemImage *itemFb;
    
    BOOL shouldGlow;
    BOOL isPlayButtonMoving;
    BOOL isOnlineButtonMoving;
    BOOL isOptionsButtonMoving;
}

+(CCScene*)scene;

@end
