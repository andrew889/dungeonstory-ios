//
//  BattleEventsLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 22/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "BattleValues.h"

@class Enemy;

@interface BattleEventsLayer : CCLayer
{
    CGSize screenSize;
    CCSprite *background;
    
    CCSprite *labelMsg1;
    CCSprite *labelMsg2;
    CCSprite *labelDamage;
    
    int dmgFontSize;
}

-(id)initWithMiss;

-(id)initWithEnemy:(Enemy*)enemy
        withDamage:(int)dmg;

-(id)initWithEnemyMessage:(Enemy*)enemy;


-(id)initWithNewEnemy:(Enemy*)enemy;
-(id)initWithLevelUp;
-(id)initWithUnlockClasses;
-(id)initWithProgressStory;

@end
