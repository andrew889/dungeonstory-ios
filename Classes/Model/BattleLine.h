//
//  BattleLine.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 12/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "cocos2d.h"
#import "GameManager.h"

@interface BattleLine : NSObject
{
    CCSprite *lineSprite;
    
    BattleLineDirection direction;
    
    CGPoint position;
}

@property (nonatomic, retain) CCSprite *lineSprite;

-(id)initWithStart:(CGPoint)start
           withEnd:(CGPoint)end;

@end
