//
//  OptionsLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "GameCenterManager.h"

@interface OptionsLayer : CCLayer <MultiplayerDelegate>
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *menuBar01;
    CCSprite *menuBar02;
    
    CCSprite *labelMsg;
    
    CCMenu *menuChoice;
    CCMenu *menuOptions;
    
    CCMenuItemSprite *itemTurnMusicOff;
    CCMenuItemSprite *itemTurnMusicOn;
    CCMenuItemSprite *itemTurnSoundOff;
    CCMenuItemSprite *itemTurnSoundOn;
    CCMenuItemSprite *itemResetData;
    CCMenuItemSprite *itemCredits;
    CCMenuItemSprite *itemSupport;
    CCMenuItemSprite *itemMenu;
    
    CCMenuItemToggle *itemMusicToggle;
    CCMenuItemToggle *itemSoundToggle;
    
    NSString *msg;
}

+(CCScene*)scene;

-(void)resume;

@end
