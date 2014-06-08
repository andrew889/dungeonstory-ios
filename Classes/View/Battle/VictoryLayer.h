//
//  VictoryLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 13/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import <Twitter/Twitter.h>

@interface VictoryLayer : CCLayer
{
    CGSize screenSize;
    CCSprite *background;
    CCMenu *tweetMenu;
    CCMenuItemImage *tweetButton;
}

+(CCScene*)scene;

@end
