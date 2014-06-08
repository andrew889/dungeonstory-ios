//
//  PauseMultiPlayerLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 10/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "PauseMultiPlayerLayer.h"
#import "GameManager.h"
#import "GameCenterManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "ArenaLayer.h"
#import "Utility.h"

#pragma mark - PauseMultiPlayerLayer

@implementation PauseMultiPlayerLayer

-(id)initWithCoins:(uint64_t)coins
{
	if((self=[super initWithColor:ccc4(0, 0, 0, 230)])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        battle_gold = coins;
        
        [self setupPauseMenu];
        
        labelPlayerLevel = [CCLabelTTF labelWithString:NSLocalizedString(@"HeroLevel", nil)
                                              fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
        labelEnemyLevel = [CCLabelTTF labelWithString:NSLocalizedString(@"EnemyLevel", nil)
                                             fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
        labelGold = [CCLabelTTF labelWithString:NSLocalizedString(@"GatheredCoins", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
        labelVictories = [CCLabelTTF labelWithString:NSLocalizedString(@"ArenaVictories", nil)
                                            fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
        
        [CCMenuItemFont setFontSize:[Utility getFontSize:32]];
        [CCMenuItemFont setFontName:@"Shark Crash"];

        [labelPlayerLevel setColor:ccc3(0, 255, 127)];
        [labelEnemyLevel setColor:ccc3(170, 212, 0)];
        [labelGold setColor:ccc3(255, 182, 18)];
        [labelVictories setColor:ccc3(255, 130, 71)];
        
        itemResumeGame = [CCMenuItemImage itemWithNormalImage:@"back_btn.png"
                                                selectedImage:@"back_btn_pressed.png"
                                                       target:self
                                                     selector:@selector(resumeGame)];
        
        itemTurnSoundOff = [CCMenuItemFont itemWithString:NSLocalizedString(@"TurnSoundOff", nil)];
        itemTurnSoundOn = [CCMenuItemFont itemWithString:NSLocalizedString(@"TurnSoundOn", nil)];
        
        itemSoundToggle = [CCMenuItemToggle itemWithTarget:self
                                                  selector:@selector(setupSound:)
                                                     items:itemTurnSoundOff, itemTurnSoundOn, nil];
        
        if ([[SoundManager sharedSoundManager] isSoundON]) [itemSoundToggle setSelectedIndex:0];
        else [itemSoundToggle setSelectedIndex:1];
        
        itemExitGame = [CCMenuItemFont itemWithString:NSLocalizedString(@"ExitArena", nil)
                                               target:self selector:@selector(exitGame)];
		
		menuChoice = [CCMenu menuWithItems:itemSoundToggle, itemExitGame, nil];
        menuReturn =[CCMenu menuWithItems:itemResumeGame, nil];
        
        [labelPlayerLevel setAnchorPoint:ccp(0, 0)];
        [labelPlayerLevelVal setAnchorPoint:ccp(1, 0)];
        [labelEnemyLevel setAnchorPoint:ccp(0, 0)];
        [labelEnemyLevelVal setAnchorPoint:ccp(1, 0)];
        [labelGold setAnchorPoint:ccp(0, 0)];
        [labelGoldVal setAnchorPoint:ccp(1, 0)];
        [labelVictories setAnchorPoint:ccp(0, 0)];
        [labelVictoriesVal setAnchorPoint:ccp(1, 0)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [labelPlayerLevel setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 244)];
                [labelPlayerLevelVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 244)];
                [labelEnemyLevel setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 219)];
                [labelEnemyLevelVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 219)];
                [labelGold setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 194)];
                [labelGoldVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 194)];
                [labelVictories setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 169)];
                [labelVictoriesVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 169)];
                
                [menuChoice alignItemsVerticallyWithPadding:60];
                [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 25)];
                [menuReturn setPosition:ccp(screenSize.width/2 + 114, screenSize.height/2 - 205)];
            }
            else {
                [labelPlayerLevel setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 200)];
                [labelPlayerLevelVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 200)];
                [labelEnemyLevel setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 175)];
                [labelEnemyLevelVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 175)];
                [labelGold setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 150)];
                [labelGoldVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 150)];
                [labelVictories setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 125)];
                [labelVictoriesVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 125)];
                
                [menuChoice alignItemsVerticallyWithPadding:60];
                [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 25)];
                [menuReturn setPosition:ccp(screenSize.width/2 + 114, screenSize.height/2 - 190)];
            }
        }
        else {
            [labelPlayerLevel setPosition:ccp(screenSize.width/2 - (140 * 2.4f), screenSize.height/2 + (200 * 2.133f))];
            [labelPlayerLevelVal setPosition:ccp(screenSize.width/2 + (140 * 2.4f), screenSize.height/2 + (200 * 2.133f))];
            [labelEnemyLevel setPosition:ccp(screenSize.width/2 - (140 * 2.4f), screenSize.height/2 + (175 * 2.133f))];
            [labelEnemyLevelVal setPosition:ccp(screenSize.width/2 + (140 * 2.4f), screenSize.height/2 + (175 * 2.133f))];
            [labelGold setPosition:ccp(screenSize.width/2 - (140 * 2.4f), screenSize.height/2 + (150 * 2.133f))];
            [labelGoldVal setPosition:ccp(screenSize.width/2 + (140 * 2.4f), screenSize.height/2 + (150 * 2.133f))];
            [labelVictories setPosition:ccp(screenSize.width/2 - (140 * 2.4f), screenSize.height/2 + (125 * 2.133f))];
            [labelVictoriesVal setPosition:ccp(screenSize.width/2 + (140 * 2.4f), screenSize.height/2 + (125 * 2.133f))];

            [menuChoice alignItemsVerticallyWithPadding:(60 * 2.4f)];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - (25 * 2.133f))];
            [menuReturn setPosition:ccp(screenSize.width/2 + (110 * 2.4f), screenSize.height/2 - (190 * 2.133f))];
        }
        
        [self addChild:labelPlayerLevel z:1 tag:0];
        [self addChild:labelPlayerLevelVal z:1 tag:1];
        [self addChild:labelEnemyLevel z:1 tag:2];
        [self addChild:labelEnemyLevelVal z:1 tag:3];
        [self addChild:labelGold z:1 tag:4];
        [self addChild:labelGoldVal z:1 tag:5];
        [self addChild:labelVictories z:1 tag:6];
        [self addChild:labelVictoriesVal z:1 tag:7];
		[self addChild:menuChoice z:1 tag:8];
        [self addChild:menuReturn z:1 tag:9];
        
        [self scheduleUpdate];
        
        self.isTouchEnabled = YES;
	}
    
	return self;
}

#pragma mark - scene setup

// setups the pause menu
-(void)setupPauseMenu
{
    labelPlayerLevelVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] level]]
                                             fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
    labelEnemyLevelVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",
                                                      [[GameCenterManager sharedGameCenterManager] opponentLevel]]
                                            fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
    labelGoldVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lld", battle_gold]
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
    labelVictoriesVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lld",
                                                     [[GameCenterManager sharedGameCenterManager] arenaVictories]]
                                           fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if (itemResumeGame.isSelected || itemSoundToggle.isSelected ||
        itemExitGame.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemResumeGame.isSelected && !itemSoundToggle.isSelected &&
             !itemExitGame.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// setups game sounds
-(void)setupSound:(id)sender
{
    if ([[SoundManager sharedSoundManager] isSoundON]) {
        [[GameManager sharedGameManager] writeConfigurationSound:NO];
    }
    else {
        [[GameManager sharedGameManager] writeConfigurationSound:YES];
    }
}

#pragma mark - pausing and resuming

// resumes the current arena
-(void)resumeGame
{
    ArenaLayer *arenaLayer = (ArenaLayer*)self.parent;
    [arenaLayer resumeArena];
    [self.parent removeChild:self cleanup:YES];
}

// exits the current battle and returns to the play menu
-(void)exitGame
{
    menuChoice.isTouchEnabled = NO;
    
    ArenaLayer *arenaLayer = (ArenaLayer*)self.parent;
    [arenaLayer exitArena];
}

@end
