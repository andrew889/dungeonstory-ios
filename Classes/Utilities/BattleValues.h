//
//  BattleValues.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 11/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#ifndef DS_BattleValues_h
#define DS_BattleValues_h

#define kMultiplierEnemy1 1.0f
#define kMultiplierEnemy2 1.1f
#define kMultiplierEnemy3 1.2f
#define kMultiplierEnemy4 1.1f
#define kMultiplierEnemy5 2.0f

// Enumaration containing enemy ranks
typedef enum {
    kEnemyRankMerchant,
    kEnemyRankNormal,
    kEnemyRankSpecial,
    kEnemyRankBoss
} EnemyRank;

// Enumaration containing enemy types
typedef enum {
    kEnemyType1,
    kEnemyType2,
    kEnemyType3,
    kEnemyType4,
    kEnemyType5
} EnemyType;

// Enumaration containing enemy abilities
typedef enum {
    kEnemyAbilityNone,
    kEnemyAbilityShop,
    kEnemyAbilityGold,
    kEnemyAbilityExperience,
    kEnemyAbilityHeal,
    kEnemyAbilityReflect,
    kEnemyAbilityDrainLife,
    kEnemyAbilityDoubleStrike,
    kEnemyAbilityBlind,
    kEnemyAbilityDragonFire,
    kEnemyAbilityEarthquake,
    kEnemyAbilityTeleport,
    kEnemyAbilityPoison,
    kEnemyAbilityPhysicalDefence,
    kEnemyAbilityMagicalDefence,
    kEnemyAbilityNegateEnergy,
    kEnemyAbilityFreezeTime,
    kEnemyAbilityConfusion,
    kEnemyAbilitySabotage,
    kEnemyAbilityTransmutation,
    kEnemyAbilityNullification,
    kEnemyAbilityTemporalSwift
} EnemyAbility;

#endif
