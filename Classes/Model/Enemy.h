//
//  Enemy.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 11/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "cocos2d.h"
#import "GameManager.h"

@interface Enemy : NSObject
{
    NSString *name;
    
    EnemyRank rank;
    EnemyType type;
    EnemyAbility ability;
    
    int maxHP;
    int currentHP;
    int damage;
    int exp;
    
    int multiplierEnemy;
    int multiplierHealth;
    int multiplierDamage;
    int multiplierExperience;
}

@property (readonly, nonatomic, copy) NSString *name;
@property (readonly) EnemyRank rank;
@property (readwrite) EnemyType type;
@property (readonly) EnemyAbility ability;
@property (readonly) int maxHP;
@property (readwrite) int currentHP;
@property (readonly) int damage;
@property (readonly) int exp;

-(id)initWithBattleRound:(int)battleRound;

-(NSString*)getAbilityName;

@end
