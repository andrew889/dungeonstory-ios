//
//  ArenaLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 09/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@class Tile;
@class Enemy;
@class ArenaEventsLayer;

@interface ArenaLayer : CCLayer
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *battleInterface;
    CCSprite *battleBar;
    CCSprite *healthbars;
    CCSprite *healthbar1;
    CCSprite *healthbar2;
    CCSprite *expbar;
    CCSprite *energybarFull;
    CCSprite *energybar;
    CCSprite *playerStats;
    CCSprite *enemyStats;
    
    ArenaEventsLayer *wait_layer;
    ArenaEventsLayer *events_layer;
    
    CCSpriteBatchNode *spriteBatchNodeTiles;
    CCSpriteBatchNode *spriteBatchNodeAnimatedTiles;
    CCSpriteBatchNode *spriteBatchNodeLines;
        
    CCLabelTTF *labelTime;
    CCLabelTTF *labelName;
    CCLabelTTF *labelEnemyName;
    CCLabelTTF *labelPlayerHPVal;
    CCLabelTTF *labelEnemyHPVal;
    CCLabelTTF *labelPlayerClass;
    CCLabelTTF *labelPlayerClassVal;
    CCLabelTTF *labelPlayerAttack;
    CCLabelTTF *labelPlayerAttackVal;
    CCLabelTTF *labelPlayerDefence;
    CCLabelTTF *labelPlayerDefenceVal;
    CCLabelTTF *labelPlayerMagic;
    CCLabelTTF *labelPlayerMagicVal;
    CCLabelTTF *labelPlayerLuck;
    CCLabelTTF *labelPlayerLuckVal;
    CCLabelTTF *labelPlayerStatus;
    CCLabelTTF *labelPlayerStatusVal;
    CCLabelTTF *labelEnemyClass;
    CCLabelTTF *labelEnemyClassVal;
    CCLabelTTF *labelEnemyAttack;
    CCLabelTTF *labelEnemyAttackVal;
    CCLabelTTF *labelEnemyDefence;
    CCLabelTTF *labelEnemyDefenceVal;
    CCLabelTTF *labelEnemyMagic;
    CCLabelTTF *labelEnemyMagicVal;
    CCLabelTTF *labelEnemyLuck;
    CCLabelTTF *labelEnemyLuckVal;
    CCLabelTTF *labelEnemyStatus;
    CCLabelTTF *labelEnemyStatusVal;
    
    CCMenu *menuButtons;
    CCMenu *menuPause;
    
    CCMenuItemImage *itemBtn1;
    CCMenuItemImage *itemBtn2;
    CCMenuItemImage *itemBtn3;
    CCMenuItemImage *itemPauseBtn;
    
    CCSprite *item1;
    CCSprite *item2;
    CCSprite *item3;
    CCSprite *item4;
    CCSprite *item5;
    CCSprite *item6;
    CCSprite *item7;
    
    NSDateFormatter *formatter;
    
    NSMutableArray *puzzleContents;
    NSMutableArray *toRemoveTiles;
    NSMutableArray *battleLines;
        
    NSString *msgName;
        
    uint64_t coins;
    int playerDamage;
    int playerHealing;
    int shieldRank;
    int aleRank;
    int runeRank;
    int mirrorRank;
    
    NSString *enemyName;
    NSString *enemyClass;
    int enemyMaxHP;
    int enemyCurrentHP;
    int enemyDamage;
    int enemyHeal;
    
    Tile *selectedTile;
    int touchX;
    int touchY;
    
    CCSprite *labelTouchValue;
    CGPoint touchLocation;
    BOOL tileChanged;
    BOOL touchValueIsActive;
    
    int tileMagicType1;
    int tileMagicType2;
    int removedTiles;
    
    BOOL shouldEnergyGlow;
    int lowHealthTexture_dt;
    int numOfBattleLines;
    
    BOOL isPlayersTurn;
    BOOL hasUsedBomb;
    BOOL hasUsedFlute;
    BOOL hasPlayerStatusChanged;
    BOOL hasEnemyStatusChanged;
    BOOL hasPaused;
    BOOL isValidTouch;
    BOOL tileTouchesAllowed;
}

+(CCScene*)scene;

-(void)resumeArena;
-(void)exitArena;

@end
