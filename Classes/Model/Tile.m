//
//  Tile.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 16/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "Tile.h"

@implementation Tile

@synthesize tileSprite;
@synthesize tileType;
@synthesize tileID;
@synthesize tileNum;
@synthesize x;
@synthesize y;

-(id)initWithType:(TileType)type
            withX:(int)xVal
            withY:(int)yVal
         withDrop:(BOOL)drop
{
    if ((self = [super init])) {
        screenSize = [[CCDirector sharedDirector] winSize];
        
        tileType = type;
        tileID = yVal * kPuzzleHeight + xVal;
        x = xVal;
        y = yVal;
        
        random1 = arc4random_uniform(3);
        random2 = arc4random_uniform(2);
                
        tileSprite = [self setupSprite];
        
        if (drop) {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                [tileSprite
                 setPosition:ccp((screenSize.width/2 - kPuzzleMarginX) + x * kTileSize + kTileSize / 2,
                                 (screenSize.height/2 - kPuzzleMarginY) + (kPuzzleHeight + y + 1) * kTileSize +
                                 kTileSize / 2 - kTileSize * kPuzzleHeight)];
            }
            else {
                [tileSprite
                 setPosition:ccp((screenSize.width/2 - kPuzzleMarginX_ipad) + x * kTileSize_ipad + kTileSize_ipad / 2,
                                 (screenSize.height/2 - kPuzzleMarginY_ipad) + (kPuzzleHeight + y + 1) * kTileSize_ipad +
                                 kTileSize_ipad / 2 - kTileSize_ipad * kPuzzleHeight)];
            }
            
            id action;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                action = [CCMoveTo
                          actionWithDuration:0.2f
                          position:ccp((screenSize.width/2 - kPuzzleMarginX) + x * kTileSize + kTileSize / 2,
                                       (screenSize.height/2 - kPuzzleMarginY) + (kPuzzleHeight + y) * kTileSize +
                                       kTileSize / 2 - kTileSize * kPuzzleHeight)];
            }
            else {
                action = [CCMoveTo
                          actionWithDuration:0.2f
                          position:ccp((screenSize.width/2 - kPuzzleMarginX_ipad) + x * kTileSize_ipad + kTileSize_ipad / 2,
                                       (screenSize.height/2 - kPuzzleMarginY_ipad) + (kPuzzleHeight + y) * kTileSize_ipad +
                                       kTileSize_ipad / 2 - kTileSize_ipad * kPuzzleHeight)];
            }
            
            id ease = [CCEaseSineIn actionWithAction:action];
            
            [tileSprite runAction:[CCSequence actions:ease, nil]];
        }
        else {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                [tileSprite setPosition:ccp((screenSize.width/2 - kPuzzleMarginX) + x * kTileSize + kTileSize / 2,
                                            (screenSize.height/2 - kPuzzleMarginY) + (kPuzzleHeight + y) * kTileSize +
                                            kTileSize / 2 - kTileSize * kPuzzleHeight)];
            }
            else {
                [tileSprite setPosition:ccp((screenSize.width/2 - kPuzzleMarginX_ipad) + x * kTileSize_ipad + kTileSize_ipad / 2,
                                            (screenSize.height/2 - kPuzzleMarginY_ipad) + (kPuzzleHeight + y) * kTileSize_ipad +
                                            kTileSize_ipad / 2 - kTileSize_ipad * kPuzzleHeight)];
            }
        }
    }
    
    return self;
}

// setups sprite
-(CCSprite*)setupSprite
{
    CCSprite *tempSprite;
    
    if (tileType == kTileSword) {
        if (random1 == 0) {
            tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"sword01.png"];
            tileNum = 1;
        }
        else if (random1 == 1) {
            tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"sword02.png"];
            tileNum = 1;
        }
        else if (random1 == 2) {
            tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"sword03.png"];
            tileNum = 1;
        }
    }
    else if (tileType == kTileMagic) {
        if (random2 == 0) {
            if (random1 == 0) {
                tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"magic01.png"];
            }
            else if (random1 == 1) {
                tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"magic02.png"];
            }
            else if (random1 == 2) {
                tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"magic03.png"];
            }
            
            tileNum = 1;
        }
        else if (random2 == 1) {
            if (random1 == 0) {
                tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"magic04.png"];
            }
            else if (random1 == 1) {
                tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"magic05.png"];
            }
            else if (random1 == 2) {
                tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"magic06.png"];
            }
            
            tileNum = 2;
        }
    }
    else if (tileType == kTileGold) {
        if (random1 == 0) {
            tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"coin01.png"];
            tileNum = 1;
        }
        else if (random1 == 1) {
            tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"coin02.png"];
            tileNum = 1;
        }
        else if (random1 == 2) {
            tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"coin03.png"];
            tileNum = 1;
        }
    }
    else if (tileType == kTileHeart) {
        if (random1 == 0) {
            tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"heart01.png"];
            tileNum = 1;
        }
        else if (random1 == 1) {
            tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"heart02.png"];
            tileNum = 1;
        }
        else if (random1 == 2) {
            tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"heart03.png"];
            tileNum = 1;
        }
    }
    else if (tileType == kTileEmblem1) {
        tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"emblem1.png"];
        tileNum = 1;
    }
    else if (tileType == kTileEmblem2) {
        tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"emblem2.png"];
        tileNum = 1;
    }
    else if (tileType == kTileEmblem3) {
        tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"emblem3.png"];
        tileNum = 1;
    }
    else if (tileType == kTileEmblem4) {
        tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"emblem4.png"];
        tileNum = 1;
    }
    else if (tileType == kTileHeroShield) {
        tempSprite = [[CCSprite alloc] initWithSpriteFrameName:@"heroShield.png"];
        tileNum = 1;
    }
    
    return tempSprite;
}

// checks if another tile is in a nearby cell
-(BOOL)isNeighbourWith:(Tile*)otherTile
{
    bool isNear = NO;
    
    if ((abs(x - otherTile.x) <= 1) && (abs(y - otherTile.y) <= 1)) {
        isNear = YES;
    }
    
    return isNear;
}

// goes to top line of the puzzle
-(void)topOfPuzzle
{
    y = kPuzzleHeight - 1;
    tileID = y * kPuzzleHeight + x;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [tileSprite setPosition:ccp((screenSize.width/2 - kPuzzleMarginX) + x * kTileSize + kTileSize / 2,
                                    (screenSize.height/2 - kPuzzleMarginY) + (kPuzzleHeight + y) * kTileSize +
                                    kTileSize / 2 - kTileSize * kPuzzleHeight)];
    }
    else {
        [tileSprite setPosition:ccp((screenSize.width/2 - kPuzzleMarginX_ipad) + x * kTileSize_ipad + kTileSize_ipad / 2,
                                    (screenSize.height/2 - kPuzzleMarginY_ipad) + (kPuzzleHeight + y) * kTileSize_ipad +
                                    kTileSize_ipad / 2 - kTileSize_ipad * kPuzzleHeight)];
    }
    
    [tileSprite setVisible:NO];
}

// drops one line in the puzzle
-(void)drops
{
    y = y - 1;
    tileID = tileID - 6;
    
    /*
    id action = [CCSpawn actions:
                 [CCScaleTo actionWithDuration:0.6f scale:0.7f],
                 [CCFadeOut actionWithDuration:0.5f],
                 [CCEaseSineOut actionWithAction:
                  [CCMoveTo actionWithDuration:0.6f
                                      position:ccp(finalPosW, finalPosH)]],
                 nil];
    
    [sprite runAction:action];

    */
    
    id action;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        action = [CCMoveTo
                  actionWithDuration:0.2f
                  position:ccp((screenSize.width/2 - kPuzzleMarginX) + x * kTileSize + kTileSize / 2,
                               (screenSize.height/2 - kPuzzleMarginY) + (kPuzzleHeight + y) * kTileSize +
                               kTileSize / 2 - kTileSize * kPuzzleHeight)];
    }
    else {
        action = [CCMoveTo
                  actionWithDuration:0.2f
                  position:ccp((screenSize.width/2 - kPuzzleMarginX_ipad) + x * kTileSize_ipad + kTileSize_ipad / 2,
                               (screenSize.height/2 - kPuzzleMarginY_ipad) + (kPuzzleHeight + y) * kTileSize_ipad +
                               kTileSize_ipad / 2 - kTileSize_ipad * kPuzzleHeight)];
    }
    
    id ease = [CCEaseSineIn actionWithAction:action];
    
    [tileSprite runAction:[CCSequence actions:ease, nil]];
}

// copies the sprite
-(CCSprite*)copySprite
{
    CCSprite *sprite = [self setupSprite];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [sprite setPosition:ccp((screenSize.width/2 - kPuzzleMarginX) + x * kTileSize + kTileSize / 2,
                                (screenSize.height/2 - kPuzzleMarginY) + (kPuzzleHeight + y) * kTileSize +
                                kTileSize / 2 - kTileSize * kPuzzleHeight)];
    }
    else {
        [sprite setPosition:ccp((screenSize.width/2 - kPuzzleMarginX_ipad) + x * kTileSize_ipad + kTileSize_ipad / 2,
                                (screenSize.height/2 - kPuzzleMarginY_ipad) + (kPuzzleHeight + y) * kTileSize_ipad +
                                kTileSize_ipad / 2 - kTileSize_ipad * kPuzzleHeight)];
    }
    
    return sprite;
}

@end
