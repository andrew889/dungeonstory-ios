//
//  BattleLine.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 12/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "BattleLine.h"

@implementation BattleLine

@synthesize lineSprite;

-(id)initWithStart:(CGPoint)start
           withEnd:(CGPoint)end
{
    if ((self = [super init])) {        
        position = start;
        
        [self getDirectionWithStart:start WithEnd:end];
        
        if (direction == kBattleLineDirectionUp ||
            direction == kBattleLineDirectionDown ||
            direction == kBattleLineDirectionRight ||
            direction == kBattleLineDirectionLeft) {
            
            lineSprite = [[CCSprite alloc] initWithSpriteFrameName:@"line1.png"];
        }
        else {
            lineSprite = [[CCSprite alloc] initWithSpriteFrameName:@"line2.png"];
        }
        
        [lineSprite setAnchorPoint:ccp(0, 0.5)];
        [lineSprite setPosition:position];
        
        [self setRotation];
    }
    
    return self;
}

// gets the direction of the battle line
-(void)getDirectionWithStart:(CGPoint)start
                     WithEnd:(CGPoint)end
{
    if (start.x == end.x && start.y < end.y) {
        direction = kBattleLineDirectionUp;
    }
    else if (start.x == end.x && start.y > end.y) {
        direction = kBattleLineDirectionDown;
    }
    else if (start.x < end.x && start.y == end.y) {
        direction = kBattleLineDirectionRight;
    }
    else if (start.x > end.x && start.y == end.y) {
        direction = kBattleLineDirectionLeft;
    }
    else if (start.x < end.x && start.y < end.y) {
        direction = kBattleLineDirectionUpRight;
    }
    else if (start.x < end.x && start.y > end.y) {
        direction = kBattleLineDirectionDownRight;
    }
    else if (start.x > end.x && start.y < end.y) {
        direction = kBattleLineDirectionUpLeft;
    }
    else if (start.x > end.x && start.y > end.y) {
        direction = kBattleLineDirectionDownLeft;
    }
}

// sets the rotation of the battle line
-(void)setRotation
{
    if (direction == kBattleLineDirectionUp) {
        [lineSprite setRotation:270.0f];
    }
    else if (direction == kBattleLineDirectionUpRight) {
        [lineSprite setRotation:315.0f];
    }
    else if (direction == kBattleLineDirectionRight) {
        [lineSprite setRotation:0.0f];
    }
    else if (direction == kBattleLineDirectionDownRight) {
        [lineSprite setRotation:45.0f];
    }
    else if (direction == kBattleLineDirectionDown) {
        [lineSprite setRotation:90.0f];
    }
    else if (direction == kBattleLineDirectionDownLeft) {
        [lineSprite setRotation:135.0f];
    }
    else if (direction == kBattleLineDirectionLeft) {
        [lineSprite setRotation:180.0f];
    }
    else if (direction == kBattleLineDirectionUpLeft) {
        [lineSprite setRotation:225.0f];
    }
}

@end
