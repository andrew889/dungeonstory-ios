//
//  VictoryLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 13/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "VictoryLayer.h"
#import "AppDelegate.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "GameCenterManager.h"

#pragma mark - VictoryLayer

@implementation VictoryLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	VictoryLayer *layer = [VictoryLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        if ([[GameManager sharedGameManager] questType] != kQuestType0) {
            background = [CCSprite spriteWithFile:@"QuestDoneMenu.png"];
            
            [[SoundManager sharedSoundManager] playVictoryEffect];
        }
        else {
            if ([[GameCenterManager sharedGameCenterManager] arenaEndReason] == kArenaEndReasonWin) {
                background = [CCSprite spriteWithFile:@"ArenaWinMenu.png"];
                
                [[SoundManager sharedSoundManager] playVictoryEffect];
            }
            else {
                background = [CCSprite spriteWithFile:@"ArenaLoseMenu.png"];
                
                [[SoundManager sharedSoundManager] playDefeatEffect];
            }
        }
        
        tweetButton = [CCMenuItemImage itemWithNormalImage:@"tweetbutton.png"
                                             selectedImage:@"tweetbutton.png"
                                             disabledImage:nil
                                                    target:self
                                                  selector:@selector(sendTweet:)];
		
		tweetMenu = [CCMenu menuWithItems:tweetButton, nil];

        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [tweetMenu setPosition:ccp(screenSize.width/2, screenSize.height/2 - 150)];
        }
        else {
            [tweetMenu setPosition:ccp(screenSize.width/2, screenSize.height/2 - (150 * 2.133f))];
        }
        
        [self addChild:background z:-1 tag:0];
        
        if (([[GameCenterManager sharedGameCenterManager] arenaEndReason] == kArenaEndReasonWin) ||
            ([[GameManager sharedGameManager] questType] != kQuestType0)) {
            
            [self addChild:tweetMenu z:1 tag:1];
        }
        
        self.isTouchEnabled = YES;
	}
    
	return self;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    [[SoundManager sharedSoundManager] stopSoundEffect];
    [[SoundManager sharedSoundManager] playMainTheme];

    if ([[GameManager sharedGameManager] questType] != kQuestType0) {
        [[GameManager sharedGameManager] setQuestType:kQuestType0];
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonNone];
        [[GameManager sharedGameManager] runSceneWithID:kSceneTavern withTransition:YES];
    }
    else {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonNone];
        [[GameManager sharedGameManager] runSceneWithID:kSceneMultiplayer withTransition:YES];
    }
}

// send a tweet
-(IBAction)sendTweet:(id)sender
{
    NSString *tweet;
    
    if ([[GameManager sharedGameManager] questType] != kQuestType0) {
        tweet = @"I just completed a tavern quest in #DungeonStory !! https://itunes.apple.com/us/app/dungeon-story/id560744147";
    }
    else {
        tweet = @"I annihilated my online opponent in #DungeonStory !! https://itunes.apple.com/us/app/dungeon-story/id560744147";
    }
    
    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];

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
