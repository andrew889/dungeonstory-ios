//
//  PlayLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "PlayLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "PlayHelpLayer.h"
#import "Utility.h"

#pragma mark - PlayLayer

@implementation PlayLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	PlayLayer *layer = [PlayLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {
        [[CCDirector sharedDirector] purgeCachedData];

		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"Menu.png"];
        menuBar01 = [CCSprite spriteWithFile:@"menubar.png"];
        menuBar02 = [CCSprite spriteWithFile:@"menubar.png"];
        
        [self setupMenu];
        
        labelBtn01 = [Utility labelWithString:NSLocalizedString(@"HeroMenu", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:40]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:1.5]
                                   stokeColor:ccBLACK];
        
        labelBtn02 = [Utility labelWithString:NSLocalizedString(@"TownMenu", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:40]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:1.5]
                                   stokeColor:ccBLACK];
        
        labelBtn03 = [Utility labelWithString:NSLocalizedString(@"Dungeon01", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:40]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:1.5]
                                   stokeColor:ccBLACK];
        
        labelBtn04 = [Utility labelWithString:NSLocalizedString(@"Dungeon02", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:40]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:1.5]
                                   stokeColor:ccBLACK];
        
        labelBtn05 = [Utility labelWithString:NSLocalizedString(@"Dungeon03", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:40]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:1.5]
                                   stokeColor:ccBLACK];
        
        labelBtn06 = [Utility labelWithString:NSLocalizedString(@"Dungeon04", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:40]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:1.5]
                                   stokeColor:ccBLACK];
        
        labelBtn07 = [Utility labelWithString:NSLocalizedString(@"Dungeon05", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:40]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:1.5]
                                   stokeColor:ccBLACK];
        
        labelBtn08 = [Utility labelWithString:NSLocalizedString(@"Dungeon06", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:70]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:3]
                                   stokeColor:ccBLACK];
        
        itemDungeon1 = [CCMenuItemImage itemWithNormalImage:@"dungeonBtn1.png"
                                              selectedImage:@"dungeonBtn1_pressed.png"
                                                     target:self
                                                   selector:@selector(showDungeon1)];
        
        itemDungeon2 = [CCMenuItemImage itemWithNormalImage:@"dungeonBtn2.png"
                                              selectedImage:@"dungeonBtn2_pressed.png"
                                              disabledImage:@"dungeonBtn0.png"
                                                     target:self
                                                   selector:@selector(showDungeon2)];
        
        itemDungeon3 = [CCMenuItemImage itemWithNormalImage:@"dungeonBtn3.png"
                                              selectedImage:@"dungeonBtn3_pressed.png"
                                              disabledImage:@"dungeonBtn0.png"
                                                     target:self
                                                   selector:@selector(showDungeon3)];
        
        itemDungeon4 = [CCMenuItemImage itemWithNormalImage:@"dungeonBtn4.png"
                                              selectedImage:@"dungeonBtn4_pressed.png"
                                              disabledImage:@"dungeonBtn0.png"
                                                     target:self
                                                   selector:@selector(showDungeon4)];
        
        itemDungeon5 = [CCMenuItemImage itemWithNormalImage:@"dungeonBtn5.png"
                                              selectedImage:@"dungeonBtn5_pressed.png"
                                              disabledImage:@"dungeonBtn0.png"
                                                     target:self
                                                   selector:@selector(showDungeon5)];
        
        itemDungeon6 = [CCMenuItemImage itemWithNormalImage:@"dungeonBtn6.png"
                                              selectedImage:@"dungeonBtn6_pressed.png"
                                                     target:self
                                                   selector:@selector(showDungeon6)];
        
        itemCharacter = [CCMenuItemImage itemWithNormalImage:@"heroBtn.png"
                                               selectedImage:@"heroBtn_pressed.png"
                                                      target:self
                                                    selector:@selector(showStats)];
        
        itemTown = [CCMenuItemImage itemWithNormalImage:@"townBtn.png"
                                          selectedImage:@"townBtn_pressed.png"
                                                 target:self
                                               selector:@selector(showTavern)];
        
        if (![[GameManager sharedGameManager] hasPurchasedHardMode]) {
            itemHardOff = [CCMenuItemImage itemWithNormalImage:@"hardBtn0.png"
                                                 selectedImage:@"hardBtn0.png"];
        }
        else {
            itemHardOff = [CCMenuItemImage itemWithNormalImage:@"hardBtn.png"
                                                 selectedImage:@"hardBtn_pressed.png"];
        }
        
        itemHardOn = [CCMenuItemImage itemWithNormalImage:@"hardBtn2.png"
                                            selectedImage:@"hardBtn2_pressed.png"];
        
        itemHardToggle = [CCMenuItemToggle itemWithTarget:self
                                                 selector:@selector(activateHardMode:)
                                                    items:itemHardOff, itemHardOn, nil];
        
        if (![[GameManager sharedGameManager] isHardModeOn]) [itemHardToggle setSelectedIndex:0];
        else [itemHardToggle setSelectedIndex:1];
        
        itemHelp = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Help", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccWHITE
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                           selectedSprite:[Utility labelWithString:NSLocalizedString(@"Help", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:22]
                                                                             color:ccc3(255, 204, 102)
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                                   target:self selector:@selector(showHelp)];
        
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
		
		menuDungeon1 = [CCMenu menuWithItems:itemDungeon1, itemDungeon2, itemDungeon3,
                       itemDungeon4, itemDungeon5, nil];
        menuDungeon2 = [CCMenu menuWithItems:itemDungeon6, nil];
        menuChoice = [CCMenu menuWithItems:itemCharacter, itemHardToggle, itemTown, nil];
        menuOptions = [CCMenu menuWithItems:itemHelp, itemMenu, nil];
        
        [labelName setAnchorPoint:ccp(0, 0)];
        [labelLevel setAnchorPoint:ccp(1, 0)];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [labelBtn01 setPosition:ccp(itemCharacter.contentSize.width/2, itemCharacter.contentSize.height/2)];
        [labelBtn02 setPosition:ccp(itemTown.contentSize.width/2, itemTown.contentSize.height/2)];
        [labelBtn03 setPosition:ccp(itemDungeon1.contentSize.width/2, itemDungeon1.contentSize.height/2)];
        [labelBtn04 setPosition:ccp(itemDungeon2.contentSize.width/2, itemDungeon2.contentSize.height/2)];
        [labelBtn05 setPosition:ccp(itemDungeon3.contentSize.width/2, itemDungeon3.contentSize.height/2)];
        [labelBtn06 setPosition:ccp(itemDungeon4.contentSize.width/2, itemDungeon4.contentSize.height/2)];
        [labelBtn07 setPosition:ccp(itemDungeon5.contentSize.width/2, itemDungeon5.contentSize.height/2)];
        [labelBtn08 setPosition:ccp(itemDungeon6.contentSize.width/2, itemDungeon6.contentSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263.5)];
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 268.5)];
                
                [labelName setPosition:ccp(screenSize.width/2 - 145, screenSize.height/2 + 252)];
                [labelLevel setPosition:ccp(screenSize.width/2 + 145, screenSize.height/2 + 252)];
                
                [menuDungeon1 alignItemsVerticallyWithPadding:26];
                [menuDungeon1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 41)];
                
                [itemDungeon6 setPosition:ccp(0, 30)];
                
                [itemCharacter setPosition:ccp(-82, -192)];
                [itemHardToggle setPosition:ccp(0, -192)];
                [itemTown setPosition:ccp(82, -192)];
                
                [menuOptions alignItemsHorizontallyWithPadding:180];
                [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - 263)];
            }
            else {
                [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 229.5)];
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 234.5)];
                
                [labelName setPosition:ccp(screenSize.width/2 - 145, screenSize.height/2 + 212)];
                [labelLevel setPosition:ccp(screenSize.width/2 + 145, screenSize.height/2 + 212)];
                
                [menuDungeon1 alignItemsVerticallyWithPadding:16];
                [menuDungeon1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 31)];
                
                [itemDungeon6 setPosition:ccp(0, 30)];
                
                [itemCharacter setPosition:ccp(-82, -170)];
                [itemHardToggle setPosition:ccp(0, -170)];
                [itemTown setPosition:ccp(82, -170)];
                
                [menuOptions alignItemsHorizontallyWithPadding:180];
                [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - 225)];
            }
        }
        else {
            [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (228 * 2.133f))];
            [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (233 * 2.133f))];

            [labelName setPosition:ccp(screenSize.width/2 - (145 * 2.4f), screenSize.height/2 + (212 * 2.133f))];
            [labelLevel setPosition:ccp(screenSize.width/2 + (145 * 2.4f), screenSize.height/2 + (212 * 2.133f))];
            
            [menuDungeon1 alignItemsVerticallyWithPadding:(11 * 2.133f)];
            [menuDungeon1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (31 * 2.133f))];
            
            [itemDungeon6 setPosition:ccp(0, (30 * 2.133f))];

            [itemCharacter setPosition:ccp(-(82 * 2.4f), -(170 * 2.133f))];
            [itemHardToggle setPosition:ccp(0, -(170 * 2.133f))];
            [itemTown setPosition:ccp(82 * 2.4f, -(170 * 2.133f))];

            [menuOptions alignItemsHorizontallyWithPadding:(180 * 2.4f)];
            [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - (224 * 2.133f))];
        }
        
        [self addChild:background z:-1 tag:0];
        [self addChild:menuBar01 z:0 tag:1];
        [self addChild:menuBar02 z:0 tag:2];
		[self addChild:labelName z:1 tag:3];
		[self addChild:labelLevel z:1 tag:4];
		[self addChild:menuDungeon1 z:1 tag:5];
        [self addChild:menuDungeon2 z:1 tag:6];
        [self addChild:menuChoice z:1 tag:7];
        [self addChild:menuOptions z:1 tag:8];
        
        [itemCharacter addChild:labelBtn01];
        [itemTown addChild:labelBtn02];
        [itemDungeon1 addChild:labelBtn03];
        [itemDungeon2 addChild:labelBtn04];
        [itemDungeon3 addChild:labelBtn05];
        [itemDungeon4 addChild:labelBtn06];
        [itemDungeon5 addChild:labelBtn07];
        [itemDungeon6 addChild:labelBtn08];
        
        [self scheduleUpdate];
        
        if (![[GameManager sharedGameManager] hasPurchasedHardMode]) {
            itemHardToggle.isEnabled = NO;
        }
        else {
            itemHardToggle.isEnabled = YES;
        }
        
        if (![[GameManager sharedGameManager] isHardModeOn]) {
            if ([[Player sharedPlayer] emblems] == 0) {
                itemDungeon5.isEnabled = NO;
                itemDungeon4.isEnabled = NO;
                itemDungeon3.isEnabled = NO;
                itemDungeon2.isEnabled = NO;
                
                labelBtn04.visible = NO;
                labelBtn05.visible = NO;
                labelBtn06.visible = NO;
                labelBtn07.visible = NO;
            }
            else if ([[Player sharedPlayer] emblems] == 1) {
                itemDungeon5.isEnabled = NO;
                itemDungeon4.isEnabled = NO;
                itemDungeon3.isEnabled = NO;
                
                labelBtn05.visible = NO;
                labelBtn06.visible = NO;
                labelBtn07.visible = NO;
            }
            else if ([[Player sharedPlayer] emblems] == 2) {
                itemDungeon5.isEnabled = NO;
                itemDungeon4.isEnabled = NO;
                
                labelBtn06.visible = NO;
                labelBtn07.visible = NO;
            }
            else if ([[Player sharedPlayer] emblems] == 3) {
                itemDungeon5.isEnabled = NO;
                
                labelBtn07.visible = NO;
            }
            
            itemDungeon6.visible = NO;
            itemDungeon6.isEnabled = NO;
            
            labelBtn08.visible = NO;
        }
        else {
            itemDungeon1.visible = NO;
            itemDungeon1.isEnabled = NO;
            itemDungeon2.visible = NO;
            itemDungeon2.isEnabled = NO;
            itemDungeon3.visible = NO;
            itemDungeon3.isEnabled = NO;
            itemDungeon4.visible = NO;
            itemDungeon4.isEnabled = NO;
            itemDungeon5.visible = NO;
            itemDungeon5.isEnabled = NO;
            
            itemDungeon6.visible = YES;
            itemDungeon6.isEnabled = YES;
            
            labelBtn03.visible = NO;
            labelBtn04.visible = NO;
            labelBtn05.visible = NO;
            labelBtn06.visible = NO;
            labelBtn07.visible = NO;
            labelBtn08.visible = YES;
        }
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
    
    if (itemHelp.isSelected || itemMenu.isSelected ||
        itemDungeon1.isSelected || itemDungeon2.isSelected ||
        itemDungeon3.isSelected || itemDungeon4.isSelected ||
        itemDungeon5.isSelected || itemCharacter.isSelected ||
        itemTown.isSelected || itemHardToggle.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemHelp.isSelected && !itemMenu.isSelected &&
             !itemDungeon1.isSelected && !itemDungeon2.isSelected &&
             !itemDungeon3.isSelected && !itemDungeon4.isSelected &&
             !itemDungeon5.isSelected && !itemCharacter.isSelected &&
             !itemTown.isSelected && !itemHardToggle.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// shows the battle scene for dungeon 1
-(void)showDungeon1
{
    [[SoundManager sharedSoundManager] fadeOutBackgroundMusic];
    [[GameManager sharedGameManager] setCurrentDungeon:kDungeonBloodyDungeon];
    [[GameManager sharedGameManager] runSceneWithID:kSceneBattle withTransition:YES];
}

// shows the battle scene for dungeon 2
-(void)showDungeon2
{
    [[SoundManager sharedSoundManager] fadeOutBackgroundMusic];
    [[GameManager sharedGameManager] setCurrentDungeon:kDungeonUndergroundLake];
    [[GameManager sharedGameManager] runSceneWithID:kSceneBattle withTransition:YES];
}

// shows the battle scene for dungeon 3
-(void)showDungeon3
{
    [[SoundManager sharedSoundManager] fadeOutBackgroundMusic];
    [[GameManager sharedGameManager] setCurrentDungeon:kDungeonForgottenCatacombs];
    [[GameManager sharedGameManager] runSceneWithID:kSceneBattle withTransition:YES];
}

// shows the battle scene for dungeon 4
-(void)showDungeon4
{
    [[SoundManager sharedSoundManager] fadeOutBackgroundMusic];
    [[GameManager sharedGameManager] setCurrentDungeon:kDungeonTempleOfOldOnes];
    [[GameManager sharedGameManager] runSceneWithID:kSceneBattle withTransition:YES];
}

// shows the battle scene for dungeon 5
-(void)showDungeon5
{
    [[SoundManager sharedSoundManager] fadeOutBackgroundMusic];
    [[GameManager sharedGameManager] setCurrentDungeon:kDungeonSanctumOfDestiny];
    [[GameManager sharedGameManager] runSceneWithID:kSceneBattle withTransition:YES];
}

// shows the battle scene for dungeon 6
-(void)showDungeon6
{
    [[SoundManager sharedSoundManager] fadeOutBackgroundMusic];
    [[GameManager sharedGameManager] setCurrentDungeon:kDungeonRealmOfMadness];
    [[GameManager sharedGameManager] runSceneWithID:kSceneBattle withTransition:YES];
}

// shows the stats scene
-(void)showStats
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats withTransition:NO];
}

// shows the tavern scene
-(void)showTavern
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneTavern withTransition:NO];
}

// activates hard mode
-(void)activateHardMode:(id)sender
{
    if ([[GameManager sharedGameManager] isHardModeOn]) {
        [[GameManager sharedGameManager] setIsHardModeOn:NO];
        
        itemDungeon1.visible = YES;
        itemDungeon1.isEnabled = YES;
        itemDungeon2.visible = YES;
        itemDungeon2.isEnabled = YES;
        itemDungeon3.visible = YES;
        itemDungeon3.isEnabled = YES;
        itemDungeon4.visible = YES;
        itemDungeon4.isEnabled = YES;
        itemDungeon5.visible = YES;
        itemDungeon5.isEnabled = YES;
        
        itemDungeon6.visible = NO;
        itemDungeon6.isEnabled = NO;
        
        labelBtn03.visible = YES;
        labelBtn04.visible = YES;
        labelBtn05.visible = YES;
        labelBtn06.visible = YES;
        labelBtn07.visible = YES;
        labelBtn08.visible = NO;
    }
    else {
        [[GameManager sharedGameManager] setIsHardModeOn:YES];
        
        itemDungeon1.visible = NO;
        itemDungeon1.isEnabled = NO;
        itemDungeon2.visible = NO;
        itemDungeon2.isEnabled = NO;
        itemDungeon3.visible = NO;
        itemDungeon3.isEnabled = NO;
        itemDungeon4.visible = NO;
        itemDungeon4.isEnabled = NO;
        itemDungeon5.visible = NO;
        itemDungeon5.isEnabled = NO;
        
        itemDungeon6.visible = YES;
        itemDungeon6.isEnabled = YES;
        
        labelBtn03.visible = NO;
        labelBtn04.visible = NO;
        labelBtn05.visible = NO;
        labelBtn06.visible = NO;
        labelBtn07.visible = NO;
        labelBtn08.visible = YES;
    }
}

// shows the help scene
-(void)showHelp
{
    self.isTouchEnabled = NO;
    menuDungeon1.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    
    ccColor4B colour = {0, 0, 0, 0};
    PlayHelpLayer *help_layer = [[PlayHelpLayer alloc] initWithColor:colour];
    
    [self addChild:help_layer z:10];
}

// shows the menu scene
-(void)showMenu
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneMenu withTransition:YES];
}

#pragma mark - pausing and resuming

// resumes after help
-(void)resumeFromHelp
{
    self.isTouchEnabled = YES;
    menuDungeon1.isTouchEnabled = YES;
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
