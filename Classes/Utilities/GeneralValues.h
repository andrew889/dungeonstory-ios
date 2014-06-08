//
//  GeneralValues.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#ifndef DS_GeneralValues_h
#define DS_GeneralValues_h

#define kPuzzleWidth 6
#define kPuzzleHeight 6
#define kPuzzleMarginX 156
#define kPuzzleMarginY 158
#define kPuzzleMarginX_ipad 348
#define kPuzzleMarginY_ipad 352
#define kTileSize 52
#define kTileSize_ipad 116

// Enumaration containing tiles
typedef enum {
    kTileSword,
    kTileMagic,
    kTileGold,
    kTileHeart,
    kTileEmblem1,
    kTileEmblem2,
    kTileEmblem3,
    kTileEmblem4,
    kTileHeroShield
} TileType;

// Enumaration containing battle line direction
typedef enum {
    kBattleLineDirectionUp,
    kBattleLineDirectionUpRight,
    kBattleLineDirectionRight,
    kBattleLineDirectionDownRight,
    kBattleLineDirectionDown,
    kBattleLineDirectionDownLeft,
    kBattleLineDirectionLeft,
    kBattleLineDirectionUpLeft
} BattleLineDirection;

// Enumaration containing scenes
typedef enum {
    kSceneNone,
    kSceneMenu,
    kScenePlay,
    kSceneMultiplayer,
    kSceneOptions,
    kSceneStats,
    kSceneInventory,
    kSceneStory,
    kSceneTavern,
    kSceneShop,
    kSceneTrainer,
    kSceneBattle,
    kSceneQuest,
    kSceneArena,
    kSceneVictory,
    kSceneCredits,
    kSceneStore,
    kSceneDonate
} SceneType;

// Enumeration containing dungeons
typedef enum {
    kDungeonNone,
    kDungeonBloodyDungeon,
    kDungeonUndergroundLake,
    kDungeonForgottenCatacombs,
    kDungeonTempleOfOldOnes,
    kDungeonSanctumOfDestiny,
    kDungeonRealmOfMadness,
    kDungeonArena
} Dungeon;

// Enumeration containing hyperlinks
typedef enum {
    kHyperlinkTwitter,
    kHyperlinkFacebook
} Hyperlink;

// Enumeration containing quests
typedef enum {
    kQuestType0,
    kQuestType1,
    kQuestType2,
    kQuestType3,
    kQuestType4,
    kQuestType5,
    kQuestType6,
    kQuestType7,
    kQuestType8,
    kQuestType9,
    kQuestType10,
    kQuestType11,
    kQuestType12
} QuestType;

#endif
