//
//  Enemy.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 11/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "Enemy.h"
#import "Player.h"

@implementation Enemy

@synthesize name;
@synthesize type;
@synthesize rank;
@synthesize ability;
@synthesize maxHP;
@synthesize currentHP;
@synthesize damage;
@synthesize exp;

-(id)initWithBattleRound:(int)battleRound
{
    [self generateEnemyRank:battleRound];
    [self generateEnemyType];
    [self generateEnemy];
    [self setupMultipliers];
    [self generateEnemyHealth:battleRound];
    [self generateEnemyDamage:battleRound];
    [self generateEnemyExperience:battleRound];
    [self generateEnemyAbility];
    
    currentHP = maxHP;
    
    return self;
}

// generates enemy rank
-(void)generateEnemyRank:(int)battleRound
{    
    int rankGen = arc4random_uniform(11);

    if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
        if (rankGen >= 5) rank = kEnemyRankBoss;
        else rank = kEnemyRankSpecial;
    }
    else {
        if (rankGen == 10 && battleRound >= 5 &&
            [[Player sharedPlayer] level] >= 10) {
            
            rank = kEnemyRankBoss;
        }
        else if (rankGen >= 5 && battleRound >= 3 &&
                 [[Player sharedPlayer] level] >= 5) {
            
            rank = kEnemyRankSpecial;
        }
        else {
            rank = kEnemyRankNormal;
        }
    }
    
    if ([[GameManager sharedGameManager] questType] == kQuestType3) {
        rank = kEnemyRankSpecial;
    }
    else if ([[GameManager sharedGameManager] questType] == kQuestType6 ||
             [[GameManager sharedGameManager] questType] == kQuestType11) {
        rank = kEnemyRankBoss;
    }
    
    if ([[GameManager sharedGameManager] questType] == kQuestType0 &&
        battleRound % 5 == 0) {
        rank = kEnemyRankMerchant;
    }
}

// generates enemy type
-(void)generateEnemyType
{
    int typeGen = arc4random_uniform(5);
    
    if ([[Player sharedPlayer] level] >= 10) {
        if (typeGen == 4) type = kEnemyType5;
        else if (typeGen == 3) type = kEnemyType4;
        else if (typeGen == 2) type = kEnemyType3;
        else if (typeGen == 1) type = kEnemyType2;
        else type = kEnemyType1;
    }
    else if ([[Player sharedPlayer] level] >= 7) {
        if (typeGen == 4) type = kEnemyType4;
        else if (typeGen == 3) type = kEnemyType3;
        else if (typeGen == 2) type = kEnemyType2;
        else type = kEnemyType1;
    }
    else if ([[Player sharedPlayer] level] >= 5) {
        if (typeGen == 4) type = kEnemyType3;
        else if (typeGen >= 2) type = kEnemyType2;
        else type = kEnemyType1;
    }
    else if ([[Player sharedPlayer] level] >= 3) {
        if (typeGen >= 3) type = kEnemyType2;
        else type = kEnemyType1;
    }
    else {
        type = kEnemyType1;
    }
    
    if ([[GameManager sharedGameManager] questType] == kQuestType11) {
        type = kEnemyType5;
    }
}

// generates enemy name
-(void)generateEnemy
{
    if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny ||
        [[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
        
        if (type == kEnemyType5) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName515", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName514", nil);
            else name = NSLocalizedString(@"EnemyName513", nil);
        }
        else if (type == kEnemyType4) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName512", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName511", nil);
            else name = NSLocalizedString(@"EnemyName510", nil);
        }
        else if (type == kEnemyType3) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName509", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName508", nil);
            else name = NSLocalizedString(@"EnemyName507", nil);
        }
        else if (type == kEnemyType2) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName506", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName505", nil);
            else name = NSLocalizedString(@"EnemyName504", nil);
        }
        else if (type == kEnemyType1) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName503", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName502", nil);
            else name = NSLocalizedString(@"EnemyName501", nil);
        }
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes ||
             [[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
        
        if (type == kEnemyType5) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName415", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName414", nil);
            else name = NSLocalizedString(@"EnemyName413", nil);
        }
        else if (type == kEnemyType4) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName412", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName411", nil);
            else name = NSLocalizedString(@"EnemyName410", nil);
        }
        else if (type == kEnemyType3) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName409", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName408", nil);
            else name = NSLocalizedString(@"EnemyName407", nil);
        }
        else if (type == kEnemyType2) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName406", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName405", nil);
            else name = NSLocalizedString(@"EnemyName404", nil);
        }
        else if (type == kEnemyType1) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName403", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName402", nil);
            else name = NSLocalizedString(@"EnemyName401", nil);
        }
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs ||
             [[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
        
        if (type == kEnemyType5) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName315", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName314", nil);
            else name = NSLocalizedString(@"EnemyName313", nil);
        }
        else if (type == kEnemyType4) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName312", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName311", nil);
            else name = NSLocalizedString(@"EnemyName310", nil);
        }
        else if (type == kEnemyType3) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName309", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName308", nil);
            else name = NSLocalizedString(@"EnemyName307", nil);
        }
        else if (type == kEnemyType2) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName306", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName305", nil);
            else name = NSLocalizedString(@"EnemyName304", nil);
        }
        else if (type == kEnemyType1) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName303", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName302", nil);
            else name = NSLocalizedString(@"EnemyName301", nil);
        }
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake ||
             [[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
        
        if (type == kEnemyType5) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName215", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName214", nil);
            else name = NSLocalizedString(@"EnemyName213", nil);
        }
        else if (type == kEnemyType4) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName212", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName211", nil);
            else name = NSLocalizedString(@"EnemyName210", nil);
        }
        else if (type == kEnemyType3) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName209", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName208", nil);
            else name = NSLocalizedString(@"EnemyName207", nil);
        }
        else if (type == kEnemyType2) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName206", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName205", nil);
            else name = NSLocalizedString(@"EnemyName204", nil);
        }
        else if (type == kEnemyType1) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName203", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName202", nil);
            else name = NSLocalizedString(@"EnemyName201", nil);
        }
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonBloodyDungeon ||
             [[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
        
        if (type == kEnemyType5) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName115", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName114", nil);
            else name = NSLocalizedString(@"EnemyName113", nil);
        }
        else if (type == kEnemyType4) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName112", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName111", nil);
            else name = NSLocalizedString(@"EnemyName110", nil);
        }
        else if (type == kEnemyType3) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName109", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName108", nil);
            else name = NSLocalizedString(@"EnemyName107", nil);
        }
        else if (type == kEnemyType2) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName106", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName105", nil);
            else name = NSLocalizedString(@"EnemyName104", nil);
        }
        else if (type == kEnemyType1) {
            if (rank == kEnemyRankBoss) name = NSLocalizedString(@"EnemyName103", nil);
            else if (rank == kEnemyRankSpecial) name = NSLocalizedString(@"EnemyName102", nil);
            else name = NSLocalizedString(@"EnemyName101", nil);
        }
    }
    
    if (rank == kEnemyRankMerchant) name = NSLocalizedString(@"Merchant", nil);
}

// generates enemy health
-(void)generateEnemyHealth:(int)battleRound
{
    if (rank == kEnemyRankMerchant) {
        maxHP = 1;
    }
    else {
        maxHP = (int)([[Player sharedPlayer] level] * multiplierEnemy * 0.5);
        
        if (rank == kEnemyRankBoss) {
            maxHP = maxHP * 4 * multiplierHealth;
        }
        else if (rank == kEnemyRankSpecial) {
            maxHP = maxHP * 3 * multiplierHealth;
        }
        else {
            maxHP = maxHP * 2 * multiplierHealth;
        }
        
        if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
            maxHP += 10 * battleRound * 15 * multiplierHealth;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
            maxHP += 10 * battleRound * 12 * multiplierHealth;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
            maxHP += 10 * battleRound * 6 * multiplierHealth;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
            maxHP += 10 * battleRound * 4 * multiplierHealth;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
            maxHP += 10 * battleRound * 2 * multiplierHealth;
        }
        else {
            maxHP += 10 * battleRound * multiplierHealth;
        }
        
        if ([[GameManager sharedGameManager] questType] == kQuestType11) {
            maxHP = maxHP * 5;
        }
        
        if (arc4random_uniform(2) == 1) maxHP +=
            arc4random_uniform([[Player sharedPlayer] level]);
        else maxHP -= arc4random_uniform([[Player sharedPlayer] level]);
    }
}

// generates enemy damage
-(void)generateEnemyDamage:(int)battleRound
{
    if (rank == kEnemyRankMerchant) {
        damage = 1;
    }
    else {
        damage = (int)([[Player sharedPlayer] level] * multiplierEnemy * 0.5);
        
        if (rank == kEnemyRankBoss) {
            damage = (int)(damage * multiplierDamage * 1.2);
        }
        else if (rank == kEnemyRankSpecial) {
            damage = (int)(damage * multiplierDamage * 1.1);
        }
        else {
            damage = damage * multiplierDamage;
        }
        
        if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
            if (battleRound >= 200) damage += battleRound * 20 * multiplierDamage;
            else if (battleRound >= 150) damage += battleRound * 19 * multiplierDamage;
            else if (battleRound >= 100) damage += battleRound * 18 * multiplierDamage;
            else if (battleRound >= 75) damage += battleRound * 17 * multiplierDamage;
            else if (battleRound >= 50) damage += battleRound * 16 * multiplierDamage;
            else damage += battleRound * 15 * multiplierDamage;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
            if (battleRound >= 200) damage += battleRound * 15 * multiplierDamage;
            else if (battleRound >= 150) damage += battleRound * 14 * multiplierDamage;
            else if (battleRound >= 100) damage += battleRound * 13 * multiplierDamage;
            else if (battleRound >= 75) damage += battleRound * 12 * multiplierDamage;
            else if (battleRound >= 50) damage += battleRound * 11 * multiplierDamage;
            else damage += battleRound * 10 * multiplierDamage;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
            if (battleRound >= 200) damage += battleRound * 10 * multiplierDamage;
            else if (battleRound >= 150) damage += battleRound * 9 * multiplierDamage;
            else if (battleRound >= 100) damage += battleRound * 8 * multiplierDamage;
            else if (battleRound >= 75) damage += battleRound * 7 * multiplierDamage;
            else if (battleRound >= 50) damage += battleRound * 6 * multiplierDamage;
            else damage += battleRound * 5 * multiplierDamage;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
            if (battleRound >= 200) damage += battleRound * 8 * multiplierDamage;
            else if (battleRound >= 150) damage += battleRound * 7 * multiplierDamage;
            else if (battleRound >= 100) damage += battleRound * 6 * multiplierDamage;
            else if (battleRound >= 75) damage += battleRound * 5 * multiplierDamage;
            else if (battleRound >= 50) damage += battleRound * 4 * multiplierDamage;
            else damage += battleRound * 3 * multiplierDamage;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
            if (battleRound >= 200) damage += battleRound * 7 * multiplierDamage;
            else if (battleRound >= 150) damage += battleRound * 6 * multiplierDamage;
            else if (battleRound >= 100) damage += battleRound * 5 * multiplierDamage;
            else if (battleRound >= 75) damage += battleRound * 4 * multiplierDamage;
            else if (battleRound >= 50) damage += battleRound * 3 * multiplierDamage;
            else damage += battleRound * 2 * multiplierDamage;
        }
        else {
            if (battleRound >= 200) damage += battleRound * 6 * multiplierDamage;
            else if (battleRound >= 150) damage += battleRound * 5 * multiplierDamage;
            else if (battleRound >= 100) damage += battleRound * 4 * multiplierDamage;
            else if (battleRound >= 75) damage += battleRound * 3 * multiplierDamage;
            else if (battleRound >= 50) damage += battleRound * 2 * multiplierDamage;
            else damage += battleRound * multiplierDamage;
        }
    }
}

// generates enemy experience
-(void)generateEnemyExperience:(int)battleRound
{
    if (rank == kEnemyRankMerchant) {
        exp = 1;
    }
    else {
        if (rank == kEnemyRankBoss) {
            exp = (int)(20 * multiplierEnemy * multiplierExperience);
        }
        else if (rank == kEnemyRankSpecial) {
            exp = (int)(15 * multiplierEnemy * multiplierExperience);
        }
        else {
            exp = (int)(10 * multiplierEnemy * multiplierExperience);
        }
        
        if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
            exp += battleRound * 3 * 20;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
            exp += battleRound * 3 * 10;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
            if (battleRound > 65) exp += 1000;
            else exp += battleRound * 3 * 5;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
            if (battleRound > 55) exp += 500;
            else exp += battleRound * 3 * 3;
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
            if (battleRound > 45) exp += 200;
            else exp += battleRound * 3 * 1.5;
        }
        else {
            if (battleRound > 35) exp += 100;
            else exp += battleRound * 3;
        }
        
        if ([[Player sharedPlayer] getReputationRewards] == 10) {
            exp += (int)(exp * 0.25);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 8) {
            exp += (int)(exp * 0.20);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 6) {
            exp += (int)(exp * 0.15);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 4) {
            exp += (int)(exp * 0.10);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 2) {
            exp += (int)(exp * 0.05);
        }
                
        if ([[GameManager sharedGameManager] questType] != kQuestType0) exp = 0;
    }
}

// generates enemy ability
-(void)generateEnemyAbility
{
    if (rank == kEnemyRankSpecial || rank == kEnemyRankBoss) {
        if (type == kEnemyType5) {
            int abilityGen = arc4random_uniform(11);
            
            if (abilityGen == 10) ability = kEnemyAbilityTemporalSwift;
            else if (abilityGen == 9) ability = kEnemyAbilityReflect;
            else if (abilityGen == 8) ability = kEnemyAbilityNullification;
            else if (abilityGen == 7) ability = kEnemyAbilityPoison;
            else if (abilityGen == 6) ability = kEnemyAbilityFreezeTime;
            else if (abilityGen == 5) ability = kEnemyAbilityNegateEnergy;
            else if (abilityGen == 4) ability = kEnemyAbilityMagicalDefence;
            else if (abilityGen == 3) ability = kEnemyAbilityPhysicalDefence;
            else if (abilityGen == 2) ability = kEnemyAbilityDragonFire;
            else if (abilityGen == 1) ability = kEnemyAbilityExperience;
            else ability = kEnemyAbilityGold;
        }
        else if (type == kEnemyType4) {
            int abilityGen = arc4random_uniform(14);
            
            if (abilityGen == 13) ability = kEnemyAbilityTransmutation;
            else if (abilityGen == 12) ability = kEnemyAbilityTeleport;
            else if (abilityGen == 11) ability = kEnemyAbilityNullification;
            else if (abilityGen == 10) ability = kEnemyAbilitySabotage;
            else if (abilityGen == 9) ability = kEnemyAbilityConfusion;
            else if (abilityGen == 8) ability = kEnemyAbilityFreezeTime;
            else if (abilityGen == 7) ability = kEnemyAbilityNegateEnergy;
            else if (abilityGen == 6) ability = kEnemyAbilityPoison;
            else if (abilityGen == 5) ability = kEnemyAbilityMagicalDefence;
            else if (abilityGen == 4) ability = kEnemyAbilityPhysicalDefence;
            else if (abilityGen == 3) ability = kEnemyAbilityDrainLife;
            else if (abilityGen == 2) ability = kEnemyAbilityHeal;
            else if (abilityGen == 1) ability = kEnemyAbilityExperience;
            else ability = kEnemyAbilityGold;
        }
        else if (type == kEnemyType3) {
            int abilityGen = arc4random_uniform(10);
            
            if (abilityGen == 9) ability = kEnemyAbilityTemporalSwift;
            else if (abilityGen == 8) ability = kEnemyAbilityReflect;
            else if (abilityGen == 7) ability = kEnemyAbilityBlind;
            else if (abilityGen == 6) ability = kEnemyAbilityNegateEnergy;
            else if (abilityGen == 5) ability = kEnemyAbilityMagicalDefence;
            else if (abilityGen == 4) ability = kEnemyAbilityPhysicalDefence;
            else if (abilityGen == 3) ability = kEnemyAbilityPoison;
            else if (abilityGen == 2) ability = kEnemyAbilityDoubleStrike;
            else if (abilityGen == 1) ability = kEnemyAbilityExperience;
            else ability = kEnemyAbilityGold;
        }
        else if (type == kEnemyType2) {
            int abilityGen = arc4random_uniform(13);
            
            if (abilityGen == 12) ability = kEnemyAbilityTransmutation;
            else if (abilityGen == 11) ability = kEnemyAbilityTeleport;
            else if (abilityGen == 10) ability = kEnemyAbilityEarthquake;
            else if (abilityGen == 9) ability = kEnemyAbilityNullification;
            else if (abilityGen == 8) ability = kEnemyAbilityFreezeTime;
            else if (abilityGen == 7) ability = kEnemyAbilityNegateEnergy;
            else if (abilityGen == 6) ability = kEnemyAbilityMagicalDefence;
            else if (abilityGen == 5) ability = kEnemyAbilityPhysicalDefence;
            else if (abilityGen == 4) ability = kEnemyAbilityPoison;
            else if (abilityGen == 3) ability = kEnemyAbilityDrainLife;
            else if (abilityGen == 2) ability = kEnemyAbilityHeal;
            else if (abilityGen == 1) ability = kEnemyAbilityExperience;
            else ability = kEnemyAbilityGold;
        }
        else {
            int abilityGen = arc4random_uniform(12);
            
            if (abilityGen == 11) ability = kEnemyAbilityTransmutation;
            else if (abilityGen == 10) ability = kEnemyAbilityEarthquake;
            else if (abilityGen == 9) ability = kEnemyAbilityBlind;
            else if (abilityGen == 8) ability = kEnemyAbilitySabotage;
            else if (abilityGen == 7) ability = kEnemyAbilityConfusion;
            else if (abilityGen == 6) ability = kEnemyAbilityNegateEnergy;
            else if (abilityGen == 5) ability = kEnemyAbilityPoison;
            else if (abilityGen == 4) ability = kEnemyAbilityMagicalDefence;
            else if (abilityGen == 3) ability = kEnemyAbilityPhysicalDefence;
            else if (abilityGen == 2) ability = kEnemyAbilityDoubleStrike;
            else if (abilityGen == 1) ability = kEnemyAbilityExperience;
            else ability = kEnemyAbilityGold;
        }
        
        if ([[GameManager sharedGameManager] questType] == kQuestType11) {
            ability = kEnemyAbilityDragonFire;
        }
    }
    else if (rank == kEnemyRankMerchant) {
        ability = kEnemyAbilityShop;
    }
    else {
        ability = kEnemyAbilityNone;
    }
}

// setups multipliers
-(void)setupMultipliers
{
    if (type == kEnemyType5) multiplierEnemy = kMultiplierEnemy5;
    else if (type == kEnemyType4) multiplierEnemy = kMultiplierEnemy4;
    else if (type == kEnemyType3) multiplierEnemy = kMultiplierEnemy3;
    else if (type == kEnemyType2) multiplierEnemy = kMultiplierEnemy2;
    else multiplierEnemy = kMultiplierEnemy1;
    
    if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
        multiplierHealth = 10;
        multiplierDamage = 6;
        multiplierExperience = 16;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
        multiplierHealth = 5;
        multiplierDamage = 3;
        multiplierExperience = 8;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
        multiplierHealth = 4;
        multiplierDamage = 2.5;
        multiplierExperience = 6;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
        multiplierHealth = 3;
        multiplierDamage = 2;
        multiplierExperience = 4;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
        multiplierHealth = 2;
        multiplierDamage = 1.5;
        multiplierExperience = 2;
    }
    else {
        multiplierHealth = 1;
        multiplierDamage = 1;
        multiplierExperience = 1;
    }
}

// returns ability name
-(NSString*)getAbilityName
{
    NSString *abilityName;
    
    if (ability == kEnemyAbilityTemporalSwift) abilityName = NSLocalizedString(@"EnemyAbility22", nil);
    else if (ability == kEnemyAbilityTransmutation) abilityName = NSLocalizedString(@"EnemyAbility21", nil);
    else if (ability == kEnemyAbilityTeleport) abilityName = NSLocalizedString(@"EnemyAbility20", nil);
    else if (ability == kEnemyAbilityEarthquake) abilityName = NSLocalizedString(@"EnemyAbility19", nil);
    else if (ability == kEnemyAbilityReflect) abilityName = NSLocalizedString(@"EnemyAbility18", nil);
    else if (ability == kEnemyAbilityBlind) abilityName = NSLocalizedString(@"EnemyAbility17", nil);
    else if (ability == kEnemyAbilityNullification) abilityName = NSLocalizedString(@"EnemyAbility16", nil);
    else if (ability == kEnemyAbilitySabotage) abilityName = NSLocalizedString(@"EnemyAbility15", nil);
    else if (ability == kEnemyAbilityConfusion) abilityName = NSLocalizedString(@"EnemyAbility14", nil);
    else if (ability == kEnemyAbilityFreezeTime) abilityName = NSLocalizedString(@"EnemyAbility13", nil);
    else if (ability == kEnemyAbilityNegateEnergy) abilityName = NSLocalizedString(@"EnemyAbility12", nil);
    else if (ability == kEnemyAbilityMagicalDefence) abilityName = NSLocalizedString(@"EnemyAbility11", nil);
    else if (ability == kEnemyAbilityPhysicalDefence) abilityName = NSLocalizedString(@"EnemyAbility10", nil);
    else if (ability == kEnemyAbilityDragonFire) abilityName = NSLocalizedString(@"EnemyAbility09", nil);
    else if (ability == kEnemyAbilityPoison) abilityName = NSLocalizedString(@"EnemyAbility08", nil);
    else if (ability == kEnemyAbilityDoubleStrike) abilityName = NSLocalizedString(@"EnemyAbility07", nil);
    else if (ability == kEnemyAbilityDrainLife) abilityName = NSLocalizedString(@"EnemyAbility06", nil);
    else if (ability == kEnemyAbilityHeal) abilityName = NSLocalizedString(@"EnemyAbility05", nil);
    else if (ability == kEnemyAbilityExperience) abilityName = NSLocalizedString(@"EnemyAbility04", nil);
    else if (ability == kEnemyAbilityGold) abilityName = NSLocalizedString(@"EnemyAbility03", nil);
    else if (ability == kEnemyAbilityShop) abilityName = NSLocalizedString(@"EnemyAbility02", nil);
    else abilityName = NSLocalizedString(@"EnemyAbility01", nil);
    
    return abilityName;
}

@end
