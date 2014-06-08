//
//  PauseLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 19/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "PauseLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "BattleLayer.h"
#import "Utility.h"

#pragma mark - PauseLayer

@implementation PauseLayer

-(id)initWithExp:(int)exp
       withCoins:(uint64_t)coins
       withRound:(uint64_t)battleRound
{
	if((self=[super initWithColor:ccc4(0, 0, 0, 230)])) {
		screenSize = [[CCDirector sharedDirector] winSize];
                
        battle_exp = exp;
        battle_gold = coins;
        battle_rounds = battleRound;
        
        [self setupPauseMenu];
        
        labelLevel = [CCLabelTTF labelWithString:NSLocalizedString(@"HeroLevel", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
        labelExp = [CCLabelTTF labelWithString:NSLocalizedString(@"ExpLevel", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
        labelGold = [CCLabelTTF labelWithString:NSLocalizedString(@"GatheredCoins", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
        labelBattleRound = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleRound", nil)
                                              fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
        
        [CCMenuItemFont setFontSize:[Utility getFontSize:32]];
        [CCMenuItemFont setFontName:@"Shark Crash"];

        [labelLevel setColor:ccc3(0, 255, 127)];
        [labelExp setColor:ccc3(170, 212, 0)];
        [labelGold setColor:ccc3(255, 182, 18)];
        [labelBattleRound setColor:ccc3(255, 130, 71)];
        
        itemResumeGame = [CCMenuItemImage itemWithNormalImage:@"back_btn.png"
                                                selectedImage:@"back_btn_pressed.png"
                                                       target:self
                                                     selector:@selector(resumeGame)];
        
        itemHelp = [CCMenuItemFont itemWithString:NSLocalizedString(@"Help", nil)
                                           target:self selector:@selector(helpGame)];
        
        itemTurnSoundOff = [CCMenuItemFont itemWithString:NSLocalizedString(@"TurnSoundOff", nil)];
        itemTurnSoundOn = [CCMenuItemFont itemWithString:NSLocalizedString(@"TurnSoundOn", nil)];
        
        itemSoundToggle = [CCMenuItemToggle itemWithTarget:self
                                                  selector:@selector(setupSound:)
                                                     items:itemTurnSoundOff, itemTurnSoundOn, nil];
        
        if ([[SoundManager sharedSoundManager] isSoundON]) [itemSoundToggle setSelectedIndex:0];
        else [itemSoundToggle setSelectedIndex:1];

        
        itemExitGame = [CCMenuItemFont itemWithString:NSLocalizedString(@"ExitDungeon", nil)
                                               target:self selector:@selector(exitGame)];
		
		if ([[GameManager sharedGameManager] questType] == kQuestType0) {
            menuChoice = [CCMenu menuWithItems:itemHelp, itemSoundToggle, itemExitGame, nil];
        }
        else {
            menuChoice = [CCMenu menuWithItems:itemSoundToggle, itemExitGame, nil];
        }
		
        menuReturn = [CCMenu menuWithItems:itemResumeGame, nil];
        
        [labelLevel setAnchorPoint:ccp(0, 0)];
        [labelLevelVal setAnchorPoint:ccp(1, 0)];
        [labelExp setAnchorPoint:ccp(0, 0)];
        [labelExpVal setAnchorPoint:ccp(1, 0)];
        [labelGold setAnchorPoint:ccp(0, 0)];
        [labelGoldVal setAnchorPoint:ccp(1, 0)];
        [labelBattleRound setAnchorPoint:ccp(0, 0)];
        [labelBattleRoundVal setAnchorPoint:ccp(1, 0)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [labelLevel setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 244)];
                [labelLevelVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 244)];
                [labelExp setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 219)];
                [labelExpVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 219)];
                [labelGold setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 194)];
                [labelGoldVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 194)];
                [labelBattleRound setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 169)];
                [labelBattleRoundVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 169)];
                
                [menuChoice alignItemsVerticallyWithPadding:40];
                [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 25)];
                [menuReturn setPosition:ccp(screenSize.width/2 + 114, screenSize.height/2 - 205)];
            }
            else {
                [labelLevel setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 200)];
                [labelLevelVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 200)];
                [labelExp setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 175)];
                [labelExpVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 175)];
                [labelGold setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 150)];
                [labelGoldVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 150)];
                [labelBattleRound setPosition:ccp(screenSize.width/2 - 140, screenSize.height/2 + 125)];
                [labelBattleRoundVal setPosition:ccp(screenSize.width/2 + 140, screenSize.height/2 + 125)];
                
                [menuChoice alignItemsVerticallyWithPadding:40];
                [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 25)];
                [menuReturn setPosition:ccp(screenSize.width/2 + 114, screenSize.height/2 - 190)];
            }
        }
        else {
            [labelLevel setPosition:ccp(screenSize.width/2 - (140 * 2.4f), screenSize.height/2 + (200 * 2.133f))];
            [labelLevelVal setPosition:ccp(screenSize.width/2 + (140 * 2.4f), screenSize.height/2 + (200 * 2.133f))];
            [labelExp setPosition:ccp(screenSize.width/2 - (140 * 2.4f), screenSize.height/2 + (175 * 2.133f))];
            [labelExpVal setPosition:ccp(screenSize.width/2 + (140 * 2.4f), screenSize.height/2 + (175 * 2.133f))];
            [labelGold setPosition:ccp(screenSize.width/2 - (140 * 2.4f), screenSize.height/2 + (150 * 2.133f))];
            [labelGoldVal setPosition:ccp(screenSize.width/2 + (140 * 2.4f), screenSize.height/2 + (150 * 2.133f))];
            [labelBattleRound setPosition:ccp(screenSize.width/2 - (140 * 2.4f), screenSize.height/2 + (125 * 2.133f))];
            [labelBattleRoundVal setPosition:ccp(screenSize.width/2 + (140 * 2.4f), screenSize.height/2 + (125 * 2.133f))];

            [menuChoice alignItemsVerticallyWithPadding:(40 * 2.4f)];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - (25 * 2.133f))];
            [menuReturn setPosition:ccp(screenSize.width/2 + (110 * 2.4f), screenSize.height/2 - (190 * 2.133f))];
        }
        
        [self addChild:labelLevel z:1 tag:0];
        [self addChild:labelLevelVal z:1 tag:1];
        [self addChild:labelExp z:1 tag:2];
        [self addChild:labelExpVal z:1 tag:3];
        [self addChild:labelGold z:1 tag:4];
        [self addChild:labelGoldVal z:1 tag:5];
        [self addChild:labelBattleRound z:1 tag:6];
        [self addChild:labelBattleRoundVal z:1 tag:7];
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
    labelLevelVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] level]]
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
    labelExpVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", battle_exp]
                                     fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
    labelGoldVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lld", battle_gold]
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
    labelBattleRoundVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lld", battle_rounds]
                                             fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]];
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if (itemResumeGame.isSelected || itemHelp.isSelected ||
        itemSoundToggle.isSelected || itemExitGame.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemResumeGame.isSelected && !itemHelp.isSelected &&
             !itemSoundToggle.isSelected && !itemExitGame.isSelected) {
        
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

// resumes the current battle with help
-(void)helpGame
{
    BattleLayer *battleLayer = (BattleLayer*)self.parent;
    [battleLayer resumeGameWithHelp:YES];
    [self.parent removeChild:self cleanup:YES];
}

// resumes the current battle
-(void)resumeGame
{
    BattleLayer *battleLayer = (BattleLayer*)self.parent;
    [battleLayer resumeGameWithHelp:NO];
    [self.parent removeChild:self cleanup:YES];
}

// exits the current battle and returns to the play menu
-(void)exitGame
{
    if ([[GameManager sharedGameManager] isDoubleCoin]) battle_gold += battle_gold;
    
    [[GameManager sharedGameManager] writeGatheredGold:battle_gold];
    [[SoundManager sharedSoundManager] playMainTheme];
    
    if ([[GameManager sharedGameManager] questType] != kQuestType0) {
        [[GameManager sharedGameManager] setQuestType:kQuestType0];
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonNone];
        [[GameManager sharedGameManager] runSceneWithID:kSceneTavern withTransition:YES];
    }
    else {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonNone];
        [[GameManager sharedGameManager] runSceneWithID:kScenePlay withTransition:YES];
    }
}

@end
