//
//  BattleQuestLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@class Tile;
@class Enemy;
@class BattleEventsLayer;

@interface BattleQuestLayer : CCLayer
{
    CGSize screenSize;
    CCSprite *background;
    CCSprite *battleInterface;
    CCSprite *battleBar;
    CCSprite *healthbars;
    CCSprite *healthbar1;
    CCSprite *healthbar2;
    CCSprite *expbar;
    CCSprite *energybar;
    CCSprite *energybarFull;
    CCSprite *playerStats;
    CCSprite *enemyStats;
    CCSprite *enemyRank;
    
    BattleEventsLayer *events_layer;
    
    CCSpriteBatchNode *spriteBatchNodeTiles;
    CCSpriteBatchNode *spriteBatchNodeAnimatedTiles;
    CCSpriteBatchNode *spriteBatchNodeLines;
        
    CCLabelTTF *labelQuest;
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
    CCLabelTTF *labelEnemyPower;
    CCLabelTTF *labelEnemyPowerVal;
    CCLabelTTF *labelEnemyExp;
    CCLabelTTF *labelEnemyExpVal;
    CCLabelTTF *labelEnemyAbility;
        
    CCMenu *menuButtons;
    
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
    
    int questMax;
    int questValue;
        
    uint64_t battleRound;
    uint64_t coins;
    int totalExp;    
    int playerDamage;
    int shieldRank;
    int aleRank;
    int runeRank;
    int mirrorRank;
    
    Enemy *enemy;
    Enemy *nextEnemy;
    int enemyDamage;
    
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
    
    BOOL hasUsedBomb;
    BOOL hasUsedFlute;
    BOOL enemyUsedBomb;
    BOOL hasStatusChanged;
    BOOL hasBattleEnded;
    BOOL isValidTouch;
    BOOL isTouching;
}

+(CCScene*)scene;

-(void)resumeGameWithHelp:(BOOL)value;

@end
