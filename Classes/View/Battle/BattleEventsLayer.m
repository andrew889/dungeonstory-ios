//
//  BattleEventsLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 22/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "BattleEventsLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "Enemy.h"
#import "BattleLayer.h"
#import "Utility.h"

#pragma mark - BattleEventsLayer

@implementation BattleEventsLayer

// showing a message for missing damage
-(id)initWithMiss
{
	if((self=[super init])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelDamage = [Utility labelWithString:NSLocalizedString(@"AttackMissed", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:78]
                                         color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelDamage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelDamage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
        [self addChild:labelDamage z:1 tag:1];
	}
    
	return self;
}

// showing a message for enemy damage
-(id)initWithEnemy:(Enemy *)enemy
        withDamage:(int)dmg
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"MonsterAttacks01", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:30]
                                       color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        
        labelDamage = [Utility labelWithString:[NSString stringWithFormat:@"%d", dmg]
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:78]
                                         color:ccc3(220, 20, 60) strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        
        labelMsg2 = [Utility labelWithString:NSLocalizedString(@"MonsterAttacks02", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:30]
                                       color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 80)];
            [labelDamage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [labelMsg2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 80)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (80 * 2.133f))];
            [labelDamage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [labelMsg2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (80 * 2.133f))];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        [self addChild:labelMsg2 z:1 tag:2];
        [self addChild:labelDamage z:1 tag:3];
        
        int random = arc4random_uniform(3);
        id action1, action2, ease;
        id delay = [CCDelayTime actionWithDuration:0.2];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (random == 0) {
                action1 = [CCSpawn actions: [CCScaleTo actionWithDuration:0.4f scale:0.3f],
                           [CCMoveTo actionWithDuration:0.4f
                                               position:ccp(screenSize.width/2 - 80,
                                                            screenSize.height/2 + 135)], nil];
            }
            else if (random == 1) {
                action1 = [CCSpawn actions: [CCScaleTo actionWithDuration:0.4f scale:0.3f],
                           [CCMoveTo actionWithDuration:0.4f
                                               position:ccp(screenSize.width/2 - 100,
                                                            screenSize.height/2 + 150)], nil];
            }
            else {
                action1 = [CCSpawn actions: [CCScaleTo actionWithDuration:0.4f scale:0.3f],
                           [CCMoveTo actionWithDuration:0.4f
                                               position:ccp(screenSize.width/2 - 70,
                                                            screenSize.height/2 + 120)], nil];
            }
            
            action2 = [CCMoveTo actionWithDuration:0.1f
                                          position:ccp(screenSize.width/2 - 104,
                                                       screenSize.height/2 + 192)];
        }
        else {
            if (random == 0) {
                action1 = [CCSpawn actions: [CCScaleTo actionWithDuration:0.4f scale:0.3f],
                           [CCMoveTo actionWithDuration:0.4f
                                               position:ccp(screenSize.width/2 - (80 * 2.4f),
                                                            screenSize.height/2 + (135 * 2.133f))], nil];
                
            }
            else if (random == 1) {
                action1 = [CCSpawn actions: [CCScaleTo actionWithDuration:0.4f scale:0.3f],
                           [CCMoveTo actionWithDuration:0.4f
                                               position:ccp(screenSize.width/2 - (100 * 2.4f),
                                                            screenSize.height/2 + (150 * 2.133f))], nil];
            }
            else {
                action1 = [CCSpawn actions: [CCScaleTo actionWithDuration:0.4f scale:0.3f],
                           [CCMoveTo actionWithDuration:0.4f
                                               position:ccp(screenSize.width/2 - (70 * 2.4f),
                                                            screenSize.height/2 + (120 * 2.133f))], nil];
            }
            
            action2 = [CCMoveTo actionWithDuration:0.1f
                                          position:ccp(screenSize.width/2 - (104 * 2.4f),
                                                       screenSize.height/2 + (192 * 2.133f))];
        }
        
        ease = [CCEaseOut actionWithAction:action2 rate:3];
        
        [labelDamage runAction:[CCSequence actions:delay, action1, ease, nil]];
        [background runAction:[CCSequence actions:delay, [CCEaseOut actionWithAction:
                                                          [CCFadeOut actionWithDuration:0.6f] rate:1], nil]];
        [labelMsg1 runAction:[CCSequence actions:delay, [CCEaseOut actionWithAction:
                                                         [CCFadeOut actionWithDuration:0.6f] rate:1], nil]];
        [labelMsg2 runAction:[CCSequence actions:delay, [CCEaseOut actionWithAction:
                                                         [CCFadeOut actionWithDuration:0.6f] rate:1], nil]];
        [labelDamage runAction:[CCSequence actions:delay, [CCEaseOut actionWithAction:
                                                           [CCFadeOut actionWithDuration:0.8f] rate:1], nil]];
        
        if ([enemy type] == kEnemyType1 || [enemy type] == kEnemyType4) {
            [[SoundManager sharedSoundManager] playMonster1Effect];
        }
        else if ([enemy type] == kEnemyType2) {
            [[SoundManager sharedSoundManager] playMonster2Effect];
        }
        else if ([enemy type] == kEnemyType3 || [enemy type] == kEnemyType5) {
            [[SoundManager sharedSoundManager] playMonster3Effect];
        }
	}
    
	return self;
}

// showing a message for enemy abilities
-(id)initWithEnemyMessage:(Enemy*)enemy
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        NSString *msg;
        
        if ([enemy ability] == kEnemyAbilityTransmutation) {
            msg = NSLocalizedString(@"EventAbilityTransmutation", nil);
        }
        else if ([enemy ability] == kEnemyAbilityGold) {
            msg = NSLocalizedString(@"EventAbilityGold", nil);
        }
        else if ([enemy ability] == kEnemyAbilityEarthquake) {
            msg = NSLocalizedString(@"EventAbilityEarthquake", nil);
        }
        else if ([enemy ability] == kEnemyAbilityBlind) {
            msg = NSLocalizedString(@"EventAbilityBlind", nil);
        }
        else if ([enemy ability] == kEnemyAbilityConfusion) {
            msg = NSLocalizedString(@"EventAbilityConfusion", nil);
        }
        else if ([enemy ability] == kEnemyAbilityNegateEnergy) {
            msg = NSLocalizedString(@"EventAbilityNegateEnergy", nil);
        }
        else if ([enemy ability] == kEnemyAbilityDragonFire) {
            msg = NSLocalizedString(@"EventAbilityDragonFire", nil);
        }
        else if ([enemy ability] == kEnemyAbilityPoison) {
            msg = NSLocalizedString(@"EventAbilityPoison", nil);
        }
        else if ([enemy ability] == kEnemyAbilityDoubleStrike) {
            msg = NSLocalizedString(@"EventAbilityDoubleStrike", nil);
        }
        else if ([enemy ability] == kEnemyAbilityDrainLife) {
            msg = NSLocalizedString(@"EventAbilityDrainLife", nil);
        }
        else if ([enemy ability] == kEnemyAbilityHeal) {
            msg = NSLocalizedString(@"EventAbilityHeal", nil);
        }
        
        labelMsg1 = [Utility labelWithString:msg
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:46]
                                       color:ccc3(238, 0, 238) strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        if ([enemy type] == kEnemyType1 || [enemy type] == kEnemyType4) {
            [[SoundManager sharedSoundManager] playMonster1Effect];
        }
        else if ([enemy type] == kEnemyType2) {
            [[SoundManager sharedSoundManager] playMonster2Effect];
        }
        else if ([enemy type] == kEnemyType3 || [enemy type] == kEnemyType5) {
            [[SoundManager sharedSoundManager] playMonster3Effect];
        }
	}
    
	return self;
}

// showing a message for new enemy appearance
-(id)initWithNewEnemy:(Enemy*)enemy
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        if ([enemy rank] == kEnemyRankMerchant) {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"EventMerchant", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:64]
                                           color:ccWHITE strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        }
        else if ([enemy rank] == kEnemyRankBoss) {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"EventBoss", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:100]
                                           color:ccWHITE strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        }
        else if ([enemy rank] == kEnemyRankSpecial) {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"EventSpecial", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:64]
                                           color:ccWHITE strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        }
        else {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"EventMonster", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:64]
                                           color:ccWHITE strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        }
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
	}
    
	return self;
}

// showing a message for leveling up
-(id)initWithLevelUp
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"EventLevelUp", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:76]
                                       color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        [[SoundManager sharedSoundManager] playUnlockEffect];
	}
    
	return self;
}

// showing a message for unlocking new classes
-(id)initWithUnlockClasses
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"EventNewClasses", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:50]
                                       color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        [[SoundManager sharedSoundManager] playUnlockEffect];
	}
    
	return self;
}

// showing a message for progressing story
-(id)initWithProgressStory
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
                
        if ([[Player sharedPlayer] shield] == 2) {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"EventHeroShield", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:48]
                                           color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        }
        else {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"NEW DUNGEON\nUNLOCKED!", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:48]
                                           color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        }
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        [[SoundManager sharedSoundManager] playUnlockEffect];
	}
    
	return self;
}

@end
