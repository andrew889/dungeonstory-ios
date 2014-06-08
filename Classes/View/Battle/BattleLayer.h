//
//  BattleLayer.h
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

@interface BattleLayer : CCLayer
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
    CCLabelTTF *labelEnemyPower;
    CCLabelTTF *labelEnemyPowerVal;
    CCLabelTTF *labelEnemyExp;
    CCLabelTTF *labelEnemyExpVal;
    CCLabelTTF *labelEnemyAbility;
    CCLabelTTF *labelPlayerAbility1;
    CCLabelTTF *labelPlayerAbility1Val;
    CCLabelTTF *labelPlayerAbility1Lvl;
    CCLabelTTF *labelPlayerAbility2;
    CCLabelTTF *labelPlayerAbility2Val;
    CCLabelTTF *labelPlayerAbility2Lvl;
    CCLabelTTF *labelPlayerAbility3;
    CCLabelTTF *labelPlayerAbility3Val;
    CCLabelTTF *labelPlayerAbility3Lvl;
    CCLabelTTF *labelPlayerAbility4;
    CCLabelTTF *labelPlayerAbility4Val;
    CCLabelTTF *labelPlayerAbility4Lvl;
    CCLabelTTF *labelPlayerAbility5;
    CCLabelTTF *labelPlayerAbility5Val;
    CCLabelTTF *labelPlayerAbility5Lvl;
    CCLabelTTF *labelPlayerAbility6;
    CCLabelTTF *labelPlayerAbility6Val;
    CCLabelTTF *labelPlayerAbility6Lvl;
    CCLabelTTF *labelPlayerAbility7;
    CCLabelTTF *labelPlayerAbility7Val;
    CCLabelTTF *labelPlayerAbility7Lvl;
    CCLabelTTF *labelPlayerAbility8;
    CCLabelTTF *labelPlayerAbility8Val;
    CCLabelTTF *labelPlayerAbility8Lvl;
    CCLabelTTF *labelPlayerAbility9;
    CCLabelTTF *labelPlayerAbility9Val;
    CCLabelTTF *labelPlayerAbility9Lvl;
    
    CCMenu *menuButtons;
    CCMenu *menuPause;
    CCMenu *menuShop;
    
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
    
    CCMenuItemImage *itemAbilitySlotOff1;
    CCMenuItemImage *itemAbilitySlotOn1;
    CCMenuItemImage *itemAbilitySlotOff2;
    CCMenuItemImage *itemAbilitySlotOn2;
    CCMenuItemImage *itemAbilitySlotOff3;
    CCMenuItemImage *itemAbilitySlotOn3;
    CCMenuItemImage *itemAbilitySlotOff4;
    CCMenuItemImage *itemAbilitySlotOn4;
    
    CCMenuItemSprite *itemShopConfirm;
    CCMenuItemSprite *itemShopNoGold;
    
    CCMenuItemToggle *itemAbilitySlot1;
    CCMenuItemToggle *itemAbilitySlot2;
    CCMenuItemToggle *itemAbilitySlot3;
    CCMenuItemToggle *itemAbilitySlot4;
    
    CCSprite *spriteAbility1;
    CCSprite *spriteAbility2;
    CCSprite *spriteAbility3;
    CCSprite *spriteAbility4;
    
    CCSprite *shopLabel;
    CCSprite *itemDescription;
    CCSprite *shopExit;
    
    int ability1;
    int ability2;
    int ability3;
    int ability4;
    int ability5;
    int ability6;
    int ability7;
    int ability8;
    int ability9;
    
    int currentSlot1;
    int currentSlot2;
    int currentSlot3;
    
    int selectedSlot;
    
    NSDateFormatter *formatter;
    
    NSMutableArray *puzzleContents;
    NSMutableArray *toRemoveTiles;
    NSMutableArray *battleLines;
    
    NSString *msgName;
        
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
    int enemyRage;
    
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
    BOOL hasLeveledUp;
    BOOL hasUnlockedClasses;
    BOOL hasFoundHeroShield;
    BOOL uniqueTileExists;
    BOOL isValidTouch;
    BOOL isTouching;
    BOOL isShopOpen;
}

+(CCScene*)scene;

-(void)resumeGameWithHelp:(BOOL)value;

@end
