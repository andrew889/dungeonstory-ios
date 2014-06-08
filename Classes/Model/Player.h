//
//  Player.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 19/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "cocos2d.h"

@interface Player : NSObject
{
    NSString *name;
    NSString *className;
    
    int classVal;
    int level;
    int requiredExperience;
    int maxHP;
    int attack;
    int defence;
    int magic;
    int luck;
    
    int base_physical_damage;
    int base_magical_damage;
    int damage_reduction;
    int critical_hit_percentage;
    int critical_heal_percentage;
    int extra_gold_percentage;
    int extra_exp_percentage;
    
    int64_t currentGold;
    int weapon;
    int spellbook;
    int armor;
    int ring;
    int amulet;
    int shield;
    int potion;
    int bomb;
    int ale;
    int rune;
    int mirror;
    int flute;
    
    int classRank1;
    int classRank2;
    int classRank3;
    int classRank4;
    int classRank5;
    int classRank6;
    int classRank7;
    int classRank8;
    int classRank9;
    
    int ability1;
    int ability2;
    int ability3;
    int ability4;
    int ability5;
    int ability6;
    int ability7;
    int ability8;
    int ability9;
    
    int combatSkill1;
    int combatSkill2;
    int combatSkill3;
    int survivalSkill1;
    int survivalSkill2;
    int survivalSkill3;
    int practicalSkill1;
    int practicalSkill2;
    int practicalSkill3;
    
    int emblems;
    
    int reputation;
    
    ccColor3B classColor;
    
    /* Battle stats */
    
    int currentHP;
    int energy;
    int shieldTurns;
    int aleTurns;
    int runeTurns;
    int mirrorTurns;
    int poisonTurns;
    
    BOOL isConfused;
    BOOL isBlind;
}

@property (readwrite, nonatomic, copy) NSString *name;
@property (readwrite, nonatomic, copy) NSString *className;

@property (readwrite) int classVal;
@property (readwrite) int level;
@property (readwrite) int requiredExperience;
@property (readwrite) int maxHP;
@property (readwrite) int attack;
@property (readwrite) int defence;
@property (readwrite) int magic;
@property (readwrite) int luck;

@property (readwrite) int base_physical_damage;
@property (readwrite) int base_magical_damage;
@property (readwrite) int damage_reduction;
@property (readwrite) int critical_hit_percentage;
@property (readwrite) int critical_heal_percentage;
@property (readwrite) int extra_gold_percentage;
@property (readwrite) int extra_exp_percentage;

@property (readwrite) int64_t currentGold;
@property (readwrite) int weapon;
@property (readwrite) int spellbook;
@property (readwrite) int armor;
@property (readwrite) int ring;
@property (readwrite) int amulet;
@property (readwrite) int shield;
@property (readwrite) int potion;
@property (readwrite) int bomb;
@property (readwrite) int ale;
@property (readwrite) int rune;
@property (readwrite) int mirror;
@property (readwrite) int flute;

@property (readwrite) int classRank1;
@property (readwrite) int classRank2;
@property (readwrite) int classRank3;
@property (readwrite) int classRank4;
@property (readwrite) int classRank5;
@property (readwrite) int classRank6;
@property (readwrite) int classRank7;
@property (readwrite) int classRank8;
@property (readwrite) int classRank9;

@property (readwrite) int ability1;
@property (readwrite) int ability2;
@property (readwrite) int ability3;
@property (readwrite) int ability4;
@property (readwrite) int ability5;
@property (readwrite) int ability6;
@property (readwrite) int ability7;
@property (readwrite) int ability8;
@property (readwrite) int ability9;

@property (readwrite) int combatSkill1;
@property (readwrite) int combatSkill2;
@property (readwrite) int combatSkill3;
@property (readwrite) int survivalSkill1;
@property (readwrite) int survivalSkill2;
@property (readwrite) int survivalSkill3;
@property (readwrite) int practicalSkill1;
@property (readwrite) int practicalSkill2;
@property (readwrite) int practicalSkill3;

@property (readwrite) int emblems;
@property (readwrite) int reputation;

@property (readwrite) int currentHP;
@property (readwrite) int energy;
@property (readwrite) int shieldTurns;
@property (readwrite) int aleTurns;
@property (readwrite) int runeTurns;
@property (readwrite) int mirrorTurns;
@property (readwrite) int poisonTurns;
@property (readwrite) BOOL isConfused;
@property (readwrite) BOOL isBlind;

@property (readonly) ccColor3B classColor;

+(Player*)sharedPlayer;

-(void)updatePlayer;
-(void)levelUp:(int)exp;
-(void)rankUp;

-(void)setupForBattle;

-(int)physicalAttack:(int)tiles
        withCritical:(BOOL*)critical;

-(int)magicalAttack:(int)tiles
     withMagicType1:(int)magicType1
     withMagicType2:(int)magicType2
          withCombo:(int*)combo;

-(int)getClassRank;
-(NSString*)getClassRankName;
-(int)getRankedAttack;
-(int)getRankedDefence;
-(int)getRankedMagic;
-(int)getRankedLuck;
-(int)getUnlockedClasses;
-(NSString*)getCLassName:(int)value;
-(ccColor3B)getClassColor:(int)value;

-(int)getReputationRewards;

@end
