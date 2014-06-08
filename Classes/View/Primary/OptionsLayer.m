//
//  OptionsLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "OptionsLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "ConfirmationLayer.h"
#import "Utility.h"

#pragma mark - OptionsLayer

@implementation OptionsLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	OptionsLayer *layer = [OptionsLayer node];
	
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
        
        [self setupUpperBar];
        
        itemSupport = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Support", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:36]
                                                                                color:ccWHITE
                                                                           strokeSize:[Utility getFontSize:3]
                                                                           stokeColor:ccBLACK]
                       
                                              selectedSprite:[Utility labelWithString:NSLocalizedString(@"Support", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:36]
                                                                                color:ccc3(255, 204, 102)
                                                                           strokeSize:[Utility getFontSize:3]
                                                                           stokeColor:ccBLACK]
                       
                                                      target:self selector:@selector(donate)];
        
        itemCredits = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Credits", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:36]
                                                                                color:ccWHITE
                                                                           strokeSize:[Utility getFontSize:3]
                                                                           stokeColor:ccBLACK]
                       
                                              selectedSprite:[Utility labelWithString:NSLocalizedString(@"Credits", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:36]
                                                                                color:ccc3(255, 204, 102)
                                                                           strokeSize:[Utility getFontSize:3]
                                                                           stokeColor:ccBLACK]
                       
                                                      target:self selector:@selector(showCredits)];
        
        itemTurnMusicOff = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"TurnMusicOff", nil)
                                                                                  fontName:@"Shark Crash"
                                                                                  fontSize:[Utility getFontSize:36]
                                                                                     color:ccWHITE
                                                                                strokeSize:[Utility getFontSize:3]
                                                                                stokeColor:ccBLACK]
                            
                                                   selectedSprite:[Utility labelWithString:NSLocalizedString(@"TurnMusicOff", nil)
                                                                                  fontName:@"Shark Crash"
                                                                                  fontSize:[Utility getFontSize:36]
                                                                                     color:ccc3(255, 204, 102)
                                                                                strokeSize:[Utility getFontSize:3]
                                                                                stokeColor:ccBLACK]];
        
        itemTurnMusicOn = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"TurnMusicOn", nil)
                                                                                 fontName:@"Shark Crash"
                                                                                 fontSize:[Utility getFontSize:36]
                                                                                    color:ccWHITE
                                                                               strokeSize:[Utility getFontSize:3]
                                                                               stokeColor:ccBLACK]
                           
                                                  selectedSprite:[Utility labelWithString:NSLocalizedString(@"TurnMusicOn", nil)
                                                                                 fontName:@"Shark Crash"
                                                                                 fontSize:[Utility getFontSize:36]
                                                                                    color:ccc3(255, 204, 102)
                                                                               strokeSize:[Utility getFontSize:3]
                                                                               stokeColor:ccBLACK]];

        
        itemMusicToggle = [CCMenuItemToggle itemWithTarget:self
                                                  selector:@selector(setupMusic:)
                                                     items:itemTurnMusicOff, itemTurnMusicOn, nil];
        
        if ([[SoundManager sharedSoundManager] isMusicON]) [itemMusicToggle setSelectedIndex:0];
        else [itemMusicToggle setSelectedIndex:1];
        
        itemTurnSoundOff = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"TurnSoundOff", nil)
                                                                               fontName:@"Shark Crash"
                                                                               fontSize:[Utility getFontSize:36]
                                                                                  color:ccWHITE
                                                                             strokeSize:[Utility getFontSize:3]
                                                                             stokeColor:ccBLACK]
                         
                                                selectedSprite:[Utility labelWithString:NSLocalizedString(@"TurnSoundOff", nil)
                                                                               fontName:@"Shark Crash"
                                                                               fontSize:[Utility getFontSize:36]
                                                                                  color:ccc3(255, 204, 102)
                                                                             strokeSize:[Utility getFontSize:3]
                                                                             stokeColor:ccBLACK]];
        
        itemTurnSoundOn = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"TurnSoundOn", nil)
                                                                               fontName:@"Shark Crash"
                                                                               fontSize:[Utility getFontSize:36]
                                                                                  color:ccWHITE
                                                                             strokeSize:[Utility getFontSize:3]
                                                                             stokeColor:ccBLACK]
                         
                                                selectedSprite:[Utility labelWithString:NSLocalizedString(@"TurnSoundOn", nil)
                                                                               fontName:@"Shark Crash"
                                                                               fontSize:[Utility getFontSize:36]
                                                                                  color:ccc3(255, 204, 102)
                                                                             strokeSize:[Utility getFontSize:3]
                                                                             stokeColor:ccBLACK]];
        
        itemSoundToggle = [CCMenuItemToggle itemWithTarget:self
                                                  selector:@selector(setupSound:)
                                                     items:itemTurnSoundOff, itemTurnSoundOn, nil];
        
        if ([[SoundManager sharedSoundManager] isSoundON]) [itemSoundToggle setSelectedIndex:0];
        else [itemSoundToggle setSelectedIndex:1];
                
        itemResetData = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"ResetGameData", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:36]
                                                                             color:ccWHITE
                                                                        strokeSize:[Utility getFontSize:3]
                                                                        stokeColor:ccBLACK]
                    
                                           selectedSprite:[Utility labelWithString:NSLocalizedString(@"ResetGameData", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:36]
                                                                             color:ccc3(255, 204, 102)
                                                                        strokeSize:[Utility getFontSize:3]
                                                                        stokeColor:ccBLACK]
                    
                                                   target:self selector:@selector(resetGameData)];
        
        itemMenu = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Return", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccWHITE
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                           selectedSprite:[Utility labelWithString:NSLocalizedString(@"Return", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccc3(255, 204, 102)
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                                   target:self selector:@selector(showMenu)];
		
		menuChoice = [CCMenu menuWithItems:itemSupport, itemCredits, itemMusicToggle, itemSoundToggle,
                      itemResetData, nil];
        menuOptions = [CCMenu menuWithItems:itemMenu, nil];
                
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263.5)];
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 268.5)];
                
                [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 261)];
                
                [menuChoice alignItemsVerticallyWithPadding:45];
                
                [itemMenu setPosition:ccp(104, -263)];
            }
            else {
                [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 229.5)];
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 234.5)];
                
                [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 222)];
                
                [menuChoice alignItemsVerticallyWithPadding:35];
                
                [itemMenu setPosition:ccp(104, -225)];
            }            
        }
        else {
            [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (228 * 2.133f))];
            [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (233 * 2.133f))];
            
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (222 * 2.133f))];
            
            [menuChoice alignItemsVerticallyWithPadding:(30 * 2.4f)];
            
            [itemMenu setPosition:ccp((102.6 * 2.4f), -(226 * 2.133f))];
        }
        
        [self addChild:background z:-1 tag:0];
        [self addChild:menuBar01 z:1 tag:2];
        [self addChild:menuBar02 z:1 tag:3];
		[self addChild:labelMsg z:2 tag:4];
		[self addChild:menuChoice z:2 tag:5];
        [self addChild:menuOptions z:2 tag:6];
        
        [self scheduleUpdate];
	}
    
	return self;
}

#pragma mark - setup scene

// setups the upper bar
-(void)setupUpperBar
{
    labelMsg = [Utility labelWithString:[Utility setupRandomMsg]
                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:16]
                                  color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263)];
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if ([[GameCenterManager sharedGameCenterManager] pendingInvite]) {
        [self setupArenaView];
    }
    
    if (itemCredits.isSelected || itemMenu.isSelected ||
        itemResetData.isSelected || itemMusicToggle.isSelected ||
        itemSoundToggle.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemCredits.isSelected && !itemMenu.isSelected &&
             !itemResetData.isSelected && !itemMusicToggle.isSelected &&
             !itemSoundToggle.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// setups game music
-(void)setupMusic:(id)sender
{
    if ([[SoundManager sharedSoundManager] isMusicON]) {
        [[GameManager sharedGameManager] writeConfigurationMusic:NO];
        [[SoundManager sharedSoundManager] stopBackgroundMusic];
    }
    else {
        [[GameManager sharedGameManager] writeConfigurationMusic:YES];
        [[SoundManager sharedSoundManager] playMainTheme];
    }
}

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

// donate money
-(void)donate
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneDonate withTransition:NO];
}

// resets the game data
-(void)resetGameData
{
    [self pauseSchedulerAndActions];

    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    
    ccColor4B colour = {0, 0, 0, 255};
    ConfirmationLayer *confirmation_layer = [[ConfirmationLayer alloc] initWithColor:colour];
    
    [self addChild:confirmation_layer z:10];
}

// shows the credits scene
-(void)showCredits
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneCredits withTransition:YES];
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
