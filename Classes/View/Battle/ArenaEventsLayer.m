//
//  ArenaEventsLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 09/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "ArenaEventsLayer.h"
#import "GameManager.h"
#import "GameCenterManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "ArenaLayer.h"
#import "Utility.h"

#pragma mark - ArenaEventsLayer

@implementation ArenaEventsLayer

// showing a message for waiting opponents move
-(id)initWithWaitingTurn
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"WaitingOpponent", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:50]
                                       color:ccWHITE strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        
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

// showing a message for enemy damage
-(id)initWithEnemyDamage:(int)dmg
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"MonsterAttacks03", nil)
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
        
        [[SoundManager sharedSoundManager] playMonster1Effect];
	}
        
	return self;
}

// showing a message for enemy heal
-(id)initWithEnemyHeal:(int)heal
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];

        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAttack01", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:30]
                                       color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        
        labelDamage = [Utility labelWithString:[NSString stringWithFormat:@"%d", heal]
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:78]
                                         color:ccc3(220, 20, 60) strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        
        labelMsg2 = [Utility labelWithString:NSLocalizedString(@"ArenaAttack02", nil)
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
        
        [[SoundManager sharedSoundManager] playHeartEffect];
	}
        
	return self;
}

// showing a message for enemy picking up coins
-(id)initWithEnemyPickUpCoins
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility01", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:30]
                                       color:ccWHITE strokeSize:[Utility getFontSize:4.4] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        [[SoundManager sharedSoundManager] playCoinPickedUpEffect];
	}
    
	return self;
}

// showing a message for enemy's shield use
-(id)initWithEnemyShield
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        if ([[GameCenterManager sharedGameCenterManager] opponentClassVal] == 2) {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility02", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:44]
                                           color:ccc3(0, 255, 255) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        }
        else {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility03", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:44]
                                           color:ccc3(0, 255, 255) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
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
        
        [[SoundManager sharedSoundManager] playShieldEffect];
	}
    
	return self;
}

// showing a message for enemy's potion use
-(id)initWithEnemyPotion
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility04", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:44]
                                       color:ccc3(152, 251, 152) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        [[SoundManager sharedSoundManager] playPotionEffect];
	}
    
	return self;
}

// showing a message for enemy's bomb use
-(id)initWithEnemyBomb:(int)dmg
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        if (dmg > 999999) dmgFontSize = 78;
        else if (dmg > 99999) dmgFontSize = 90;
        else dmgFontSize = 120;
        
        if ([[GameCenterManager sharedGameCenterManager] opponentClassVal] == 8) {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility05", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]
                                           color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        }
        else {
            labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility06", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:30]
                                           color:ccc3(212, 0, 204) strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        }
        
        labelDamage = [Utility labelWithString:[NSString stringWithFormat:@"%d", dmg]
                                      fontName:@"Shark Crash" fontSize:dmgFontSize
                                         color:ccc3(220, 20, 60) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelMsg2 = [Utility labelWithString:NSLocalizedString(@"ArenaAttack03", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:44]
                                       color:ccc3(212, 0, 204) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 100)];
            [labelDamage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [labelMsg2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 100)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (100 * 2.133f))];
            [labelDamage setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [labelMsg2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (100 * 2.133f))];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        [self addChild:labelMsg2 z:1 tag:2];
        [self addChild:labelDamage z:1 tag:3];
        
        [[SoundManager sharedSoundManager] playBombEffect];
	}
    
	return self;
}

// showing a message for enemy's ale use
-(id)initWithEnemyAle
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility07", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:44]
                                       color:ccc3(152, 251, 152) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        [[SoundManager sharedSoundManager] playPotionEffect];
	}
    
	return self;
}

// showing a message for enemy's rune use
-(id)initWithEnemyRune
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility08", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:44]
                                       color:ccc3(152, 251, 152) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        [[SoundManager sharedSoundManager] playShieldEffect];
	}
    
	return self;
}

// showing a message for enemy's mirror use
-(id)initWithEnemyMirror
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility09", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:44]
                                       color:ccc3(152, 251, 152) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        [[SoundManager sharedSoundManager] playMagicHitEffect];
	}
    
	return self;
}

// showing a message for enemy's flute use
-(id)initWithEnemyFlute
{
	if((self=[super init]))
    {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleEffectsMenu.png"];
        
        labelMsg1 = [Utility labelWithString:NSLocalizedString(@"ArenaAbility10", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:44]
                                       color:ccc3(152, 251, 152) strokeSize:[Utility getFontSize:3] stokeColor:ccBLACK];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        [self addChild:background z:-1 tag:0];
		[self addChild:labelMsg1 z:1 tag:1];
        
        [[SoundManager sharedSoundManager] playVictoryEffect];
	}
    
	return self;
}

@end
