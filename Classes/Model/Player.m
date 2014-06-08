//
//  Player.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 19/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "Player.h"
#import "GameManager.h"
#import "GameCenterManager.h"

@implementation Player

static Player *_sharedPlayer = nil;

@synthesize name;
@synthesize className;
@synthesize classVal;
@synthesize level;
@synthesize requiredExperience;
@synthesize maxHP;
@synthesize attack;
@synthesize defence;
@synthesize magic;
@synthesize luck;
@synthesize base_physical_damage;
@synthesize base_magical_damage;
@synthesize damage_reduction;
@synthesize critical_hit_percentage;
@synthesize critical_heal_percentage;
@synthesize extra_gold_percentage;
@synthesize extra_exp_percentage;
@synthesize currentGold;
@synthesize weapon;
@synthesize spellbook;
@synthesize armor;
@synthesize ring;
@synthesize amulet;
@synthesize shield;
@synthesize potion;
@synthesize bomb;
@synthesize ale;
@synthesize rune;
@synthesize mirror;
@synthesize flute;
@synthesize classRank1;
@synthesize classRank2;
@synthesize classRank3;
@synthesize classRank4;
@synthesize classRank5;
@synthesize classRank6;
@synthesize classRank7;
@synthesize classRank8;
@synthesize classRank9;
@synthesize ability1;
@synthesize ability2;
@synthesize ability3;
@synthesize ability4;
@synthesize ability5;
@synthesize ability6;
@synthesize ability7;
@synthesize ability8;
@synthesize ability9;
@synthesize combatSkill1;
@synthesize combatSkill2;
@synthesize combatSkill3;
@synthesize survivalSkill1;
@synthesize survivalSkill2;
@synthesize survivalSkill3;
@synthesize practicalSkill1;
@synthesize practicalSkill2;
@synthesize practicalSkill3;
@synthesize emblems;
@synthesize reputation;
@synthesize classColor;
@synthesize currentHP;
@synthesize energy;
@synthesize shieldTurns;
@synthesize aleTurns;
@synthesize runeTurns;
@synthesize mirrorTurns;
@synthesize poisonTurns;
@synthesize isConfused;
@synthesize isBlind;

+(Player*)sharedPlayer
{
    static dispatch_once_t pred = 0;
    
    __strong static id _sharedPlayer = nil;
    
    dispatch_once(&pred, ^{
        _sharedPlayer = [[self alloc] init];
    });
    
    return _sharedPlayer;
}

+(id)alloc
{
    @synchronized ([Player class])
    {
        NSAssert(_sharedPlayer == nil,
                 @"Attempted to allocate a second instance of the Player singleton");
        _sharedPlayer = [super alloc];
        
        return _sharedPlayer;
    }
    
    return nil;
}

#pragma mark - character progresses

// levels up player
-(void)levelUp:(int)exp
{
    level++;
    maxHP += kLifePerLevelUp;
    attack += kAttackPerLevelUp;
    defence += kDefencePerLevelUp;
    magic += kMagicPerLevelUp;
    luck += kLuckPerLevelUp;
    
    requiredExperience = (10 * level) - exp;
    
    if (requiredExperience <= 0) requiredExperience = 1;
    
    [self updatePlayer];
}

// ranks up current class
-(void)rankUp
{
    if (classVal == 1 && classRank1 < 1000) classRank1++;
    else if (classVal == 2 && classRank2 < 1000) classRank2++;
    else if (classVal == 3 && classRank3 < 1000) classRank3++;
    else if (classVal == 4 && classRank4 < 1000) classRank4++;
    else if (classVal == 5 && classRank5 < 1000) classRank5++;
    else if (classVal == 6 && classRank6 < 1000) classRank6++;
    else if (classVal == 7 && classRank7 < 1000) classRank7++;
    else if (classVal == 8 && classRank8 < 1000) classRank8++;
    else if (classVal == 9 && classRank9 < 1000) classRank9++;
}

#pragma mark - update player stats

// updates player stats
-(void)updatePlayer
{
    className = [self getCLassName:classVal];
    classColor = [self getClassColor:classVal];
    
    [self updatePhysicalDamage];
    [self updateMagicalDamage];
    [self updatePlayerDamageReduction];
    [self updateCriticalHitPercentage];
    [self updateCriticalHealPercentage];
    [self updateExtraGoldPercentage];
    [self updateExtraExpPercentage];
}

// update base physical damage
-(void)updatePhysicalDamage
{
    base_physical_damage = [self getRankedAttack];
    
    base_physical_damage += combatSkill1 * 2;
}

// updates base magical damage
-(void)updateMagicalDamage
{
    base_magical_damage = [self getRankedMagic];
    
    base_magical_damage += combatSkill2 * 2;
}

// updates players damage reduction
-(void)updatePlayerDamageReduction
{
    damage_reduction = [self getRankedDefence] * 0.02f;
    
    damage_reduction += survivalSkill2 * 2;
    
    if (classVal == 9) damage_reduction += 15;
    if (damage_reduction > 90) damage_reduction = 90;
}

// updates the critical hit percentage
-(void)updateCriticalHitPercentage
{
    critical_hit_percentage = (int)([self getRankedLuck] * 0.02f);
    
    critical_hit_percentage += combatSkill3;
    
    if (classVal == 7) critical_hit_percentage += 15;
    if (critical_hit_percentage > 90) critical_hit_percentage = 90;
}

// updates critical heal percentage
-(void)updateCriticalHealPercentage
{
    critical_heal_percentage = (int)([self getRankedLuck] * 0.02f);
    
    critical_heal_percentage += survivalSkill3;
    
    if (classVal == 6) critical_heal_percentage += 15;
    if (critical_heal_percentage > 90) critical_heal_percentage = 90;
}

// updates the extra gold percentage
-(void)updateExtraGoldPercentage
{
    extra_gold_percentage = practicalSkill1 * 2;
}

// updates the extra exp percentage
-(void)updateExtraExpPercentage
{
    extra_exp_percentage = practicalSkill2 * 2;
}

#pragma mark - battle commands

// setups player for battle
-(void)setupForBattle
{
    currentHP = maxHP;
    energy = 0;
    shieldTurns = 0;
    poisonTurns = 0;
    isConfused = NO;
    isBlind = NO;
}

// the player makes a physical attack
-(int)physicalAttack:(int)tiles
        withCritical:(BOOL*)critical
{    
    *critical = NO;
    int damage = base_physical_damage;
    damage += (int)((base_physical_damage * 0.2 * tiles) + (weapon * tiles));
    
    if (arc4random_uniform(100) < critical_hit_percentage) {
        damage = (int)(damage * 1.5f);
        *critical = YES;
    }
    
    return damage;
}

// the player makes a magical attack
-(int)magicalAttack:(int)tiles
     withMagicType1:(int)magicType1
     withMagicType2:(int)magicType2
          withCombo:(int*)combo
{
    *combo = 0;
    
    int damage = base_magical_damage;
    damage += (int)((base_magical_damage * 0.2 * tiles) + (spellbook * tiles));
    
    if (classVal == 3 && magicType1 >= 3 && magicType2 >= 3) {
        damage = (int)(damage * 1.4f);
        *combo = 2;
    }
    else if (magicType1 >= 2 && magicType2 >= 2) {
        damage = (int)(damage * 1.2f);
        *combo = 1;
    }
    
    return damage;
}

#pragma mark - various

// returns the class rank
-(int)getClassRank
{
    int currentClassRank;
    int rank;
    
    if (classVal == 1) currentClassRank = classRank1;
    else if (classVal == 2) currentClassRank = classRank2;
    else if (classVal == 3) currentClassRank = classRank3;
    else if (classVal == 4) currentClassRank = classRank4;
    else if (classVal == 5) currentClassRank = classRank5;
    else if (classVal == 6) currentClassRank = classRank6;
    else if (classVal == 7) currentClassRank = classRank7;
    else if (classVal == 8) currentClassRank = classRank8;
    else if (classVal == 9) currentClassRank = classRank9;
    
    if (currentClassRank == 1000) rank = 5;
    else if (currentClassRank >= 750) rank = 4;
    else if (currentClassRank >= 500) rank = 3;
    else if (currentClassRank >= 250) rank = 2;
    else rank = 1;
    
    return rank;
}

// returns the class rank name
-(NSString*)getClassRankName
{
    NSString *classRankName;
    int currentClassRank;
    
    if (classVal == 1) currentClassRank = classRank1;
    else if (classVal == 2) currentClassRank = classRank2;
    else if (classVal == 3) currentClassRank = classRank3;
    else if (classVal == 4) currentClassRank = classRank4;
    else if (classVal == 5) currentClassRank = classRank5;
    else if (classVal == 6) currentClassRank = classRank6;
    else if (classVal == 7) currentClassRank = classRank7;
    else if (classVal == 8) currentClassRank = classRank8;
    else if (classVal == 9) currentClassRank = classRank9;
    
    if (currentClassRank == 1000) classRankName = NSLocalizedString(@"HeroRank05", nil);
    else if (currentClassRank >= 750) classRankName = NSLocalizedString(@"HeroRank04", nil);
    else if (currentClassRank >= 500) classRankName = NSLocalizedString(@"HeroRank03", nil);
    else if (currentClassRank >= 250) classRankName =NSLocalizedString(@"HeroRank02", nil);
    else classRankName = NSLocalizedString(@"HeroRank01", nil);
    
    return classRankName;
}

// returns the ranked attack
-(int)getRankedAttack
{
    int rankedAttack;
    
    if (classVal == 1) {
        if ([self getClassRank] == 5) rankedAttack = attack + (int)(attack * 0.2);
        else if ([self getClassRank] == 4) rankedAttack = attack + (int)(attack * 0.16);
        else if ([self getClassRank] == 3) rankedAttack = attack + (int)(attack * 0.12);
        else if ([self getClassRank] == 2) rankedAttack = attack + (int)(attack * 0.08);
        else rankedAttack = attack + (int)(attack * 0.04);
    }
    else if (classVal == 5 || classVal == 7 || classVal == 9) {
        if ([self getClassRank] == 5) rankedAttack = attack + (int)(attack * 0.1);
        else if ([self getClassRank] == 4) rankedAttack = attack + (int)(attack * 0.08);
        else if ([self getClassRank] == 3) rankedAttack = attack + (int)(attack * 0.06);
        else if ([self getClassRank] == 2) rankedAttack = attack + (int)(attack * 0.04);
        else rankedAttack = attack + (int)(attack * 0.02);
    }
    else if (classVal == 2 || classVal == 3 || classVal == 4 ||
             classVal == 6 || classVal == 8) {
        
        rankedAttack = attack;
    }
    
    return rankedAttack;
}

// returns the ranked defence
-(int)getRankedDefence
{
    int rankedDefence;
    
    if (classVal == 2) {
        if ([self getClassRank] == 5) rankedDefence = defence + (int)(defence * 0.2);
        else if ([self getClassRank] == 4) rankedDefence = defence + (int)(defence * 0.16);
        else if ([self getClassRank] == 3) rankedDefence = defence + (int)(defence * 0.12);
        else if ([self getClassRank] == 2) rankedDefence = defence + (int)(defence * 0.08);
        else rankedDefence = defence + (int)(defence * 0.04);
    }
    else if (classVal == 4 || classVal == 8 || classVal == 9) {
        if ([self getClassRank] == 5) rankedDefence = defence + (int)(defence * 0.1);
        else if ([self getClassRank] == 4) rankedDefence = defence + (int)(defence * 0.08);
        else if ([self getClassRank] == 3) rankedDefence = defence + (int)(defence * 0.06);
        else if ([self getClassRank] == 2) rankedDefence = defence + (int)(defence * 0.04);
        else rankedDefence = defence + (int)(defence * 0.02);
    }
    else if (classVal == 1 || classVal == 3 || classVal == 5 ||
             classVal == 6 || classVal == 7) {
        
        rankedDefence = defence;
    }
    
    return rankedDefence;
}

// returns the ranked magic
-(int)getRankedMagic
{
    int rankedMagic;
    
    if (classVal == 3) {
        if ([self getClassRank] == 5) rankedMagic = magic + (int)(magic * 0.2);
        else if ([self getClassRank] == 4) rankedMagic = magic + (int)(magic * 0.16);
        else if ([self getClassRank] == 3) rankedMagic = magic + (int)(magic * 0.12);
        else if ([self getClassRank] == 2) rankedMagic = magic + (int)(magic * 0.08);
        else rankedMagic = magic + (int)(magic * 0.04);
    }
    else if (classVal == 4 || classVal == 6 || classVal == 7) {
        if ([self getClassRank] == 5) rankedMagic = magic + (int)(magic * 0.1);
        else if ([self getClassRank] == 4) rankedMagic = magic + (int)(magic * 0.08);
        else if ([self getClassRank] == 3) rankedMagic = magic + (int)(magic * 0.06);
        else if ([self getClassRank] == 2) rankedMagic = magic + (int)(magic * 0.04);
        else rankedMagic = magic + (int)(magic * 0.02);
    }
    else if (classVal == 1 || classVal == 2 || classVal == 5 ||
             classVal == 8 || classVal == 9) {
        
        rankedMagic = magic;
    }
    
    return rankedMagic;
}

// returns the ranked luck
-(int)getRankedLuck
{
    int rankedLuck;
    
    if (classVal == 5 || classVal == 6 || classVal == 8) {
        if ([self getClassRank] == 5) rankedLuck = luck + (int)(luck * 0.1);
        else if ([self getClassRank] == 4) rankedLuck = luck + (int)(luck * 0.08);
        else if ([self getClassRank] == 3) rankedLuck = luck + (int)(luck * 0.06);
        else if ([self getClassRank] == 2) rankedLuck = luck + (int)(luck * 0.04);
        else rankedLuck = luck + (int)(luck * 0.02);
    }
    else if (classVal == 1 || classVal == 2 || classVal == 3 ||
             classVal == 4 || classVal == 7 || classVal == 9) {
        
        rankedLuck = luck;
    }
    
    return rankedLuck;
}

// returns num of unlocked classes
-(int)getUnlockedClasses
{
    int unlockedClasses = 1;
    
    if (classRank2 > 0) unlockedClasses++;
    if (classRank3 > 0) unlockedClasses++;
    if (classRank4 > 0) unlockedClasses++;
    if (classRank5 > 0) unlockedClasses++;
    if (classRank6 > 0) unlockedClasses++;
    if (classRank7 > 0) unlockedClasses++;
    if (classRank8 > 0) unlockedClasses++;
    if (classRank9 > 0) unlockedClasses++;
    
    return unlockedClasses;
}

// returns player's class name
-(NSString*)getCLassName:(int)value
{
    NSString *class_name;
    
    if (value == 1) class_name = NSLocalizedString(@"HeroClass01", nil);
    else if (value == 2) class_name = NSLocalizedString(@"HeroClass02", nil);
    else if (value == 3) class_name = NSLocalizedString(@"HeroClass03", nil);
    else if (value == 4) class_name = NSLocalizedString(@"HeroClass04", nil);
    else if (value == 5) class_name = NSLocalizedString(@"HeroClass05", nil);
    else if (value == 6) class_name = NSLocalizedString(@"HeroClass06", nil);
    else if (value == 7) class_name = NSLocalizedString(@"HeroClass07", nil);
    else if (value == 8) class_name = NSLocalizedString(@"HeroClass08", nil);
    else class_name = NSLocalizedString(@"HeroClass09", nil);
    
    return class_name;
}

// returns class color
-(ccColor3B)getClassColor:(int)value
{
    ccColor3B color;
    
    if (value == 1) color = ccc3(142, 142, 142);
    else if (value == 2) color = ccc3(0, 111, 195);
    else if (value == 3) color = ccc3(212, 0, 204);
    else if (value == 4) color = ccc3(195, 0, 83);
    else if (value == 5) color = ccc3(255, 180, 35);
    else if (value == 6) color = ccc3(0, 133, 11);
    else if (value == 7) color = ccc3(208, 72, 0);
    else if (value == 8) color = ccc3(131, 167, 67);
    else color = ccc3(143, 107, 255);
    
    return color;
}

// retuns reputation gains
-(int)getReputationRewards
{
    int gains = 0;
    
    if (reputation >= 100000) gains = 10;
    else if (reputation >= 50000) gains = 9;
    else if (reputation >= 25000) gains = 8;
    else if (reputation >= 10000) gains = 7;
    else if (reputation >= 5000) gains = 6;
    else if (reputation >= 2500) gains = 5;
    else if (reputation >= 1000) gains = 4;
    else if (reputation >= 500) gains = 3;
    else if (reputation >= 250) gains = 2;
    else if (reputation >= 100) gains = 1;
    
    return gains;
}

@end
