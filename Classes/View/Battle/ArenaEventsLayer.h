//
//  ArenaEventsLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 09/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface ArenaEventsLayer : CCLayer
{
    CGSize screenSize;
    CCSprite *background;
    
    CCSprite *labelMsg1;
    CCSprite *labelMsg2;
    CCSprite *labelDamage;
    
    int dmgFontSize;
}

-(id)initWithWaitingTurn;

-(id)initWithEnemyDamage:(int)dmg;
-(id)initWithEnemyHeal:(int)heal;
-(id)initWithEnemyPickUpCoins;

-(id)initWithEnemyShield;
-(id)initWithEnemyPotion;
-(id)initWithEnemyBomb:(int)dmg;
-(id)initWithEnemyAle;
-(id)initWithEnemyRune;
-(id)initWithEnemyMirror;
-(id)initWithEnemyFlute;

@end
