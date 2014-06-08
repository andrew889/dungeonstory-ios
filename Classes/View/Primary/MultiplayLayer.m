//
//  MultiplayLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 10/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "MultiplayLayer.h"
#import "AppDelegate.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "OnlineOptionsLayer.h"
#import "Utility.h"

#pragma mark - MultiplayLayer

@implementation MultiplayLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	MultiplayLayer *layer = [MultiplayLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {        
		screenSize = [[CCDirector sharedDirector] winSize];        
        background = [CCSprite spriteWithFile:@"Menu.png"];
        menuBar01 = [CCSprite spriteWithFile:@"menubar.png"];
        menuBar02 = [CCSprite spriteWithFile:@"menubar.png"];
        
        [self setupMenu];
        
        itemArena = [CCMenuItemImage itemWithNormalImage:@"multiplayerButton1.png"
                                           selectedImage:@"multiplayerButton1_pressed.png"
                                                   block:^(id sender) {
                                                       [self setupArenaView];
                                                   }];
        
        itemTournament = [CCMenuItemImage itemWithNormalImage:@"multiplayerButton0.png"
                                                selectedImage:@"multiplayerButton0.png"
                                                disabledImage:@"multiplayerButton0.png"
                                                        block:^(id sender) {
                                                            NSLog(@"Feature is not implemented yet.");
                                                        }];
        
        itemTrainingYard = [CCMenuItemImage itemWithNormalImage:@"multiplayerButton0.png"
                                                  selectedImage:@"multiplayerButton0.png"
                                                  disabledImage:@"multiplayerButton0.png"
                                                          block:^(id sender) {
                                                              NSLog(@"Feature is not implemented yet.");
                                                          }];
        
        labelBtn01 = [Utility labelWithString:NSLocalizedString(@"Arena", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:65]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:3]
                                   stokeColor:ccBLACK];
        
        labelBtn02 = [Utility labelWithString:NSLocalizedString(@"ComingSoon", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:65]
                                        color:ccc3(60, 60 , 60)
                                   strokeSize:[Utility getFontSize:3]
                                   stokeColor:ccBLACK];
        
        labelBtn03 = [Utility labelWithString:NSLocalizedString(@"ComingSoon", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:65]
                                        color:ccc3(60, 60 , 60)
                                   strokeSize:[Utility getFontSize:3]
                                   stokeColor:ccBLACK];
        
        itemPreferences = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Options", nil)
                                                                                 fontName:@"Shark Crash"
                                                                                 fontSize:[Utility getFontSize:22]
                                                                                    color:ccWHITE
                                                                               strokeSize:[Utility getFontSize:1.5]
                                                                               stokeColor:ccBLACK]
                           
                                                  selectedSprite:[Utility labelWithString:NSLocalizedString(@"Options", nil)
                                                                                 fontName:@"Shark Crash"
                                                                                 fontSize:[Utility getFontSize:22]
                                                                                    color:ccc3(255, 204, 102)
                                                                               strokeSize:[Utility getFontSize:1.5]
                                                                               stokeColor:ccBLACK]
                           
                                                          target:self selector:@selector(showPreferences)];
        
        itemMenu = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Return", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccWHITE
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                           selectedSprite:[Utility labelWithString:@"Return"
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccc3(255, 204, 102)
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                                   target:self selector:@selector(showMenu)];
		
		menuChoice = [CCMenu menuWithItems:itemArena, itemTournament, itemTrainingYard, nil];
        menuOptions = [CCMenu menuWithItems:itemPreferences, itemMenu, nil];
        
        [labelName setAnchorPoint:ccp(0, 0)];
        [labelLevel setAnchorPoint:ccp(1, 0)];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [labelBtn01 setPosition:ccp(itemArena.contentSize.width/2, itemArena.contentSize.height/2)];
        [labelBtn02 setPosition:ccp(itemTournament.contentSize.width/2, itemTournament.contentSize.height/2)];
        [labelBtn03 setPosition:ccp(itemTrainingYard.contentSize.width/2, itemTrainingYard.contentSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263.5)];
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 268.5)];
                
                [labelName setPosition:ccp(screenSize.width/2 - 145, screenSize.height/2 + 252)];
                [labelLevel setPosition:ccp(screenSize.width/2 + 145, screenSize.height/2 + 252)];
                
                [menuChoice alignItemsVerticallyWithPadding:25];
                
                [menuOptions alignItemsHorizontallyWithPadding:180];
                [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - 263)];
            }
            else {
                [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 229.5)];
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 234.5)];
                
                [labelName setPosition:ccp(screenSize.width/2 - 145, screenSize.height/2 + 212)];
                [labelLevel setPosition:ccp(screenSize.width/2 + 145, screenSize.height/2 + 212)];
                
                [menuChoice alignItemsVerticallyWithPadding:15];
                
                [menuOptions alignItemsHorizontallyWithPadding:180];
                [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - 225)];
            }
                        
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 3)];
        }
        else {
            [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (228 * 2.133f))];
            [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (233 * 2.133f))];

            [labelName setPosition:ccp(screenSize.width/2 - (145 * 2.4f), screenSize.height/2 + (212 * 2.133f))];
            [labelLevel setPosition:ccp(screenSize.width/2 + (145 * 2.4f), screenSize.height/2 + (212 * 2.133f))];
            
            [menuChoice alignItemsVerticallyWithPadding:(4 * 2.133f)];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - (3 * 2.133f))];
            
            [menuOptions alignItemsHorizontallyWithPadding:(156.5 * 2.4f)];
            [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - (224 * 2.133f))];
        }
        
        [self addChild:background z:-1 tag:0];
        [self addChild:menuBar01 z:0 tag:1];
        [self addChild:menuBar02 z:0 tag:2];
		[self addChild:labelName z:1 tag:3];
		[self addChild:labelLevel z:1 tag:4];
		[self addChild:menuChoice z:1 tag:5];
        [self addChild:menuOptions z:1 tag:6];
        
        [itemArena addChild:labelBtn01];
        [itemTournament addChild:labelBtn02];
        [itemTrainingYard addChild:labelBtn03];
        
        [self scheduleUpdate];
        
        itemTournament.isEnabled = NO;
        itemTrainingYard.isEnabled = NO;
	}
        
	return self;
}

#pragma mark - scene setup

// setups the menu
-(void)setupMenu
{
    if (![[Player sharedPlayer] name]) {
        msgName = [NSString stringWithFormat:NSLocalizedString(@"UpperMsgNoName", nil),
                   [[Player sharedPlayer] className]];
    }
    else {
        msgName = [NSString stringWithFormat:NSLocalizedString(@"UpperMsgName", nil),
                   [[Player sharedPlayer] name],
                   [[Player sharedPlayer] className]];
    }
    
    msgLevel = [NSString stringWithFormat:NSLocalizedString(@"UpperMsgLevel", nil), [[Player sharedPlayer] level]];
    
    labelName = [Utility labelWithString:msgName fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                   color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelLevel = [Utility labelWithString:msgLevel fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                    color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if ([[GameCenterManager sharedGameCenterManager] pendingInvite]) {
        [self setupArenaView];
    }

    if (itemMenu.isSelected || itemArena.isSelected ||
        itemTournament.isSelected || itemTrainingYard.isSelected ||
        itemPreferences.isSelected) {
                
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemMenu.isSelected && !itemArena.isSelected &&
             !itemTournament.isSelected && !itemTrainingYard.isSelected &&
             !itemPreferences.isSelected) {
                
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// shows the multiplayer preferences
-(void)showPreferences
{
    [self pauseSchedulerAndActions];
    
    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    
    OnlineOptionsLayer *preferences_layer = [[OnlineOptionsLayer alloc] init];
    
    [self addChild:preferences_layer z:10];
}

// shows the menu scene
-(void)showMenu
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneMenu withTransition:YES];
}

#pragma mark - pausing and resuming

// resumes the options menu
-(void)resume
{
    [self resumeSchedulerAndActions];
    
    self.isTouchEnabled = YES;
    menuChoice.isTouchEnabled = YES;
    menuOptions.isTouchEnabled = YES;
}

#pragma mark Game Center multiplayer

// setups multiplayer view
-(void)setupArenaView
{
    [[GameCenterManager sharedGameCenterManager] findMatchWithMinPlayers:2
                                                              maxPlayers:2
                                                          viewController:[CCDirector sharedDirector]
                                                                delegate:self];
}

@end
