//
//  BattleDefeatLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 13/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "BattleDefeatLayer.h"
#import "AppDelegate.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "BattleLayer.h"
#import "Utility.h"
#import "GameCenterManager.h"

#pragma mark - BattleDefeatLayer

@implementation BattleDefeatLayer

-(id)initWithExp:(int)exp
       withCoins:(uint64_t)coins
      withRounds:(uint64_t)battleRounds
{
	if((self=[super init])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"DefeatMenu.png"];
        
        battle_gold = coins;
        battle_rounds = battleRounds;
        battle_exp = exp;
                        
        if ([[Player sharedPlayer] classVal] == 1) battle_gold += (int)(coins * 15 / 100);
        
        battle_gold += (int)(battle_gold * [[Player sharedPlayer] extra_gold_percentage] / 100);

        battle_score = battle_gold + (battleRounds * 10);
        
        labelTotalScore = [CCLabelTTF labelWithString:NSLocalizedString(@"DefeatMsg01", nil)
                                             fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        labelTotalScoreVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lld",
                                                          [[GameCenterManager sharedGameCenterManager] totalScore]]
                                                fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        labelTotalRuns = [CCLabelTTF labelWithString:NSLocalizedString(@"DefeatMsg02", nil)
                                            fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        labelTotalRunsVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lld",
                                                         [[GameCenterManager sharedGameCenterManager] totalRuns]]        
                                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        labelGold = [CCLabelTTF labelWithString:NSLocalizedString(@"DefeatMsg03", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        labelGoldVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lld",
                                                    [[Player sharedPlayer] currentGold]]
                                          fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        labelBattleRounds = [CCLabelTTF labelWithString:NSLocalizedString(@"DefeatMsg04", nil)
                                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        labelBattleRoundsVal = [CCLabelTTF labelWithString:@"0"
                                                  fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        labelExp = [CCLabelTTF labelWithString:NSLocalizedString(@"DefeatMsg05", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        labelExpVal = [CCLabelTTF labelWithString:@"0"
                                         fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        
        [labelTotalScore setAnchorPoint:ccp(0, 0)];
        [labelTotalScoreVal setAnchorPoint:ccp(1, 0)];
        [labelTotalRuns setAnchorPoint:ccp(0, 0)];
        [labelTotalRunsVal setAnchorPoint:ccp(1, 0)];
        [labelBattleRounds setAnchorPoint:ccp(0, 0)];
        [labelBattleRoundsVal setAnchorPoint:ccp(1, 0)];
        [labelExp setAnchorPoint:ccp(0, 0)];
        [labelExpVal setAnchorPoint:ccp(1, 0)];
        [labelGold setAnchorPoint:ccp(0, 0)];
        [labelGoldVal setAnchorPoint:ccp(1, 0)];
        
        tweetButton = [CCMenuItemImage itemWithNormalImage:@"tweetbutton.png"
                                             selectedImage:@"tweetbutton.png"
                                             disabledImage:nil
                                                    target:self
                                                  selector:@selector(sendTweet:)];
		
		tweetMenu = [CCMenu menuWithItems:tweetButton, nil];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelTotalScore setPosition:ccp(screenSize.width/2 - 130, screenSize.height/2 - 30)];
            [labelTotalScoreVal setPosition:ccp(screenSize.width/2 + 130, screenSize.height/2 - 30)];
            [labelTotalRuns setPosition:ccp(screenSize.width/2 - 130, screenSize.height/2 - 70)];
            [labelTotalRunsVal setPosition:ccp(screenSize.width/2 + 130, screenSize.height/2 - 70)];
            [labelGold setPosition:ccp(screenSize.width/2 - 130, screenSize.height/2 - 110)];
            [labelGoldVal setPosition:ccp(screenSize.width/2 + 130, screenSize.height/2 - 110)];
            [labelBattleRounds setPosition:ccp(screenSize.width/2 - 130, screenSize.height/2 - 150)];
            [labelBattleRoundsVal setPosition:ccp(screenSize.width/2 + 130, screenSize.height/2 - 150)];
            [labelExp setPosition:ccp(screenSize.width/2 - 130, screenSize.height/2 - 190)];
            [labelExpVal setPosition:ccp(screenSize.width/2 + 130, screenSize.height/2 - 190)];
            [tweetMenu setPosition:ccp(screenSize.width/2, screenSize.height/2 + 200)];
        }
        else {
            [labelTotalScore setPosition:ccp(screenSize.width/2 - (130 * 2.4f), screenSize.height/2 - (30 * 2.133f))];
            [labelTotalScoreVal setPosition:ccp(screenSize.width/2 + (130 * 2.4f), screenSize.height/2 - (30 * 2.133f))];
            [labelTotalRuns setPosition:ccp(screenSize.width/2 - (130 * 2.4f), screenSize.height/2 - (70 * 2.133f))];
            [labelTotalRunsVal setPosition:ccp(screenSize.width/2 + (130 * 2.4f), screenSize.height/2 - (70 * 2.133f))];
            [labelGold setPosition:ccp(screenSize.width/2 - (130 * 2.4f), screenSize.height/2 - (110 * 2.133f))];
            [labelGoldVal setPosition:ccp(screenSize.width/2 + (130 * 2.4f), screenSize.height/2 - (110 * 2.133f))];
            [labelBattleRounds setPosition:ccp(screenSize.width/2 - (130 * 2.4f), screenSize.height/2 - (150 * 2.133f))];
            [labelBattleRoundsVal setPosition:ccp(screenSize.width/2 + (130 * 2.4f), screenSize.height/2 - (150 * 2.133f))];
            [labelExp setPosition:ccp(screenSize.width/2 - (130 * 2.4f), screenSize.height/2 - (190 * 2.133f))];
            [labelExpVal setPosition:ccp(screenSize.width/2 + (130 * 2.4f), screenSize.height/2 - (190 * 2.133f))];
            [tweetMenu setPosition:ccp(screenSize.width/2, screenSize.height/2 + (200 * 2.133f))];
        }
        
        [self addChild:background z:-1 tag:0];
        [self addChild:labelTotalScore z:1 tag:1];
        [self addChild:labelTotalScoreVal z:1 tag:2];
        [self addChild:labelTotalRuns z:1 tag:3];
        [self addChild:labelTotalRunsVal z:1 tag:4];
        [self addChild:labelGold z:1 tag:5];
        [self addChild:labelGoldVal z:1 tag:6];
        [self addChild:labelBattleRounds z:1 tag:7];
        [self addChild:labelBattleRoundsVal z:1 tag:8];
        [self addChild:labelExp z:1 tag:9];
        [self addChild:labelExpVal z:1 tag:10];
        [self addChild:tweetMenu z:1 tag:11];
        
        self.isTouchEnabled = YES;
        
        scoreCounter = 0;
        gainedGoldCounter = 0;
        survivedRoundsCounter = 0;
        gainedExpCounter = 0;
        
        [self schedule:@selector(scoreSchedule:) interval:0.1 repeat:battle_score delay:0.3f];
        [self scheduleOnce:@selector(runsSchedule:) delay:0.3f];
        [self schedule:@selector(goldSchedule:) interval:0.1 repeat:battle_gold delay:0.3f];
        [self schedule:@selector(roundsSchedule:) interval:0.1 repeat:battle_rounds delay:0.3f];
        [self schedule:@selector(expSchedule:) interval:0.1 repeat:battle_exp delay:0.3f];
        
        [[SoundManager sharedSoundManager] playDefeatEffect];
	}
    
	return self;
}

#pragma mark - update schedulers

// scheduler for score
-(void)scoreSchedule:(ccTime)dt
{
    if (scoreCounter < battle_score) {
        scoreCounter++;
        
        [labelTotalScoreVal
         setString:[NSString stringWithFormat:@"%lld",
                    [[GameCenterManager sharedGameCenterManager] totalScore] + scoreCounter]];
    }
}

// scheduler for runs
-(void)runsSchedule:(ccTime)dt
{
    [labelTotalRunsVal
     setString:[NSString stringWithFormat:@"%lld",
                [[GameCenterManager sharedGameCenterManager] totalRuns] + 1]];
}

// scheduler for gold
-(void)goldSchedule:(ccTime)dt
{
    if (gainedGoldCounter < battle_gold) {
        gainedGoldCounter++;
        
        [labelGoldVal
         setString:[NSString stringWithFormat:@"%lld", [[Player sharedPlayer] currentGold] + gainedGoldCounter]];
    }
}

// scheduler for battle rounds
-(void)roundsSchedule:(ccTime)dt
{
    if (survivedRoundsCounter < battle_rounds) {
        survivedRoundsCounter++;
        
        [labelBattleRoundsVal setString:[NSString stringWithFormat:@"%lld", survivedRoundsCounter]];
    }
}

// scheduler for exp
-(void)expSchedule:(ccTime)dt
{
    if (gainedExpCounter < battle_exp) {
        gainedExpCounter++;
        
        [labelExpVal
         setString:[NSString stringWithFormat:@"%d", gainedExpCounter]];
    }
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    if (scoreCounter < battle_score || gainedGoldCounter < battle_gold ||
        survivedRoundsCounter < battle_rounds || gainedExpCounter < battle_exp) {
                
        [self unscheduleAllSelectors];

        [labelTotalScoreVal setString:[NSString stringWithFormat:@"%lld",
                                       [[GameCenterManager sharedGameCenterManager] totalScore] + battle_score]];
        [labelTotalRunsVal setString:[NSString stringWithFormat:@"%lld",
                                      [[GameCenterManager sharedGameCenterManager] totalRuns] + 1]];
        [labelGoldVal setString:[NSString stringWithFormat:@"%lld",
                                 [[Player sharedPlayer] currentGold] + battle_gold]];
        [labelBattleRoundsVal setString:[NSString stringWithFormat:@"%lld", battle_rounds]];
        [labelExpVal setString:[NSString stringWithFormat:@"%d", battle_exp]];
        
        scoreCounter = battle_score;
        gainedGoldCounter = battle_gold;
        survivedRoundsCounter = battle_rounds;
        gainedExpCounter = battle_exp;
    }
    else {
        if ([[GameManager sharedGameManager] questType] == kQuestType0) {
            if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
                [[GameCenterManager sharedGameCenterManager] updateDungeonTurnsDungeon06:battle_rounds];
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
                [[GameCenterManager sharedGameCenterManager] updateDungeonTurnsDungeon05:battle_rounds];
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
                [[GameCenterManager sharedGameCenterManager] updateDungeonTurnsDungeon04:battle_rounds];
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
                [[GameCenterManager sharedGameCenterManager] updateDungeonTurnsDungeon03:battle_rounds];
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
                [[GameCenterManager sharedGameCenterManager] updateDungeonTurnsDungeon02:battle_rounds];
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonBloodyDungeon) {
                [[GameCenterManager sharedGameCenterManager] updateDungeonTurnsDungeon01:battle_rounds];
            }
            
            [[GameCenterManager sharedGameCenterManager] checkAchievementsFirstRun];
            
            if ([[GameManager sharedGameManager] isDoubleCoin]) battle_gold += battle_gold;

            [[GameManager sharedGameManager] setCurrentDungeon:kDungeonNone];
            [[GameManager sharedGameManager] writeGatheredGold:battle_gold];
            [[GameManager sharedGameManager] writeTotalRuns];
            [[GameManager sharedGameManager] writeHighestRounds:battle_rounds];
            [[SoundManager sharedSoundManager] stopSoundEffect];
            [[SoundManager sharedSoundManager] playMainTheme];
            [[GameManager sharedGameManager] runSceneWithID:kScenePlay withTransition:YES];

        }
        else {
            [[GameManager sharedGameManager] setQuestType:kQuestType0];
            [[GameManager sharedGameManager] setCurrentDungeon:kDungeonNone];
            [[SoundManager sharedSoundManager] stopSoundEffect];
            [[SoundManager sharedSoundManager] playMainTheme];
            [[GameManager sharedGameManager] runSceneWithID:kSceneTavern withTransition:YES];
        }
    }
}

// send a tweet
-(IBAction)sendTweet:(id)sender
{
    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        
        NSString *tweet = [NSString stringWithFormat:@"I just defeated %lld monsters in #DungeonStory !! https://itunes.apple.com/us/app/dungeon-story/id560744147", battle_rounds];
        
        [tweetSheet setInitialText:tweet];
        
        AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
        [[app navController] presentModalViewController:tweetSheet animated:YES];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry!"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

@end
