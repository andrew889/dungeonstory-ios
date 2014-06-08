//
//  Tile.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 16/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "cocos2d.h"
#import "GameManager.h"

@interface Tile : NSObject
{
    CGSize screenSize;
    CCSprite *tileSprite;
    
    TileType tileType;
    
    int tileID;
    int tileNum;
    int x;
    int y;
    
    int random1;
    int random2;
}

@property (nonatomic, retain) CCSprite *tileSprite;
@property (readonly) TileType tileType;
@property (readonly) int tileID;
@property (readonly) int tileNum;
@property (readonly) int x;
@property (readonly) int y;

-(id)initWithType:(TileType)type
            withX:(int)xVal
            withY:(int)yVal
         withDrop:(BOOL)drop;

-(BOOL)isNeighbourWith:(Tile*)otherTile;
-(void)topOfPuzzle;
-(void)drops;

-(CCSprite*)copySprite;

@end
