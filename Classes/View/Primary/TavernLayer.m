//
//  TavernLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 01/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "TavernLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "TavernHelpLayer.h"
#import "Utility.h"

#pragma mark - TavernLayer

@implementation TavernLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	TavernLayer *layer = [TavernLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {        
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"Menu.png"];
        tavernBG = [CCSprite spriteWithFile:@"QuestsMenu.png"];
        repBar = [CCSprite spriteWithFile:@"repBar.png"];
        repBar2 = [CCSprite spriteWithFile:@"repBar2.png"];
        menuBar01 = [CCSprite spriteWithFile:@"menubar.png"];
        menuBar02 = [CCSprite spriteWithFile:@"menubar.png"];
        
        [self setupTavernMenu];
        
        if (screenSize.height == 568.00) {
            [self setupUpperBar];
        }
                        
        labelTavern = [Utility labelWithString:NSLocalizedString(@"TavernLabel", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelQuestsDone = [Utility labelWithString:NSLocalizedString(@"Quests", nil)
                                          fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                             color:ccc3(0, 255, 127) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelQuestsDoneVal = [Utility labelWithString:[NSString stringWithFormat:@"%lld",
                                                       [[GameCenterManager sharedGameCenterManager] totalQuests]]
                                             fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                                color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelRumors = [Utility labelWithString:NSLocalizedString(@"TavernMsg", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelQuest1 = [Utility labelWithString:msgQuest1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelQuest2 = [Utility labelWithString:msgQuest2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        if ([[Player sharedPlayer] getReputationRewards] == 0) {
            labelReputation = [Utility labelWithString:NSLocalizedString(@"Reputation01", nil)
                                              fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        }
        else {            
            NSString *reward;
            
            if ([[Player sharedPlayer] getReputationRewards] >= 9) {
                reward = NSLocalizedString(@"Reputation02", nil);
            }
            else if ([[Player sharedPlayer] getReputationRewards] >= 7) {
                reward = NSLocalizedString(@"Reputation03", nil);
            }
            else if ([[Player sharedPlayer] getReputationRewards] >= 5) {
                reward = NSLocalizedString(@"Reputation04", nil);
            }
            else if ([[Player sharedPlayer] getReputationRewards] >= 3) {
                reward = NSLocalizedString(@"Reputation05", nil);
            }
            else if ([[Player sharedPlayer] getReputationRewards] >= 1) {
                reward = NSLocalizedString(@"Reputation06", nil);
            }
            
            labelReputation = [Utility labelWithString:reward
                                              fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        }
        
        itemShop = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"ShopLabel", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:26]
                                                                             color:ccWHITE
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                           selectedSprite:[Utility labelWithString:NSLocalizedString(@"ShopLabel", nil)
                                                                          fontName:@"Shark Crash"
                                                                          fontSize:[Utility getFontSize:26]
                                                                             color:ccc3(255, 204, 102)
                                                                        strokeSize:[Utility getFontSize:1.5]
                                                                        stokeColor:ccBLACK]
                    
                                                   target:self selector:@selector(showShop)];
        
        itemTrainer = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"TrainerLabel", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:26]
                                                                                color:ccWHITE
                                                                           strokeSize:[Utility getFontSize:1.5]
                                                                           stokeColor:ccBLACK]
                       
                                              selectedSprite:[Utility labelWithString:NSLocalizedString(@"TrainerLabel", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:26]
                                                                                color:ccc3(255, 204, 102)
                                                                           strokeSize:[Utility getFontSize:1.5]
                                                                           stokeColor:ccBLACK]
                       
                                                      target:self selector:@selector(showTrainer)];
        
        itemBrewery = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Brewery", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:26]
                                                                                color:ccWHITE
                                                                           strokeSize:[Utility getFontSize:1.5]
                                                                           stokeColor:ccBLACK]
                       
                                              selectedSprite:[Utility labelWithString:NSLocalizedString(@"Brewery", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:26]
                                                                                color:ccWHITE
                                                                           strokeSize:[Utility getFontSize:1.5]
                                                                           stokeColor:ccBLACK]];
        
        itemQuest1 = [CCMenuItemImage itemWithNormalImage:@"questBtn.png"
                                            selectedImage:@"questBtn_pressed.png"
                                                   target:self
                                                 selector:@selector(showQuest1)];
        
        itemQuest2 = [CCMenuItemImage itemWithNormalImage:@"questBtn.png"
                                            selectedImage:@"questBtn_pressed.png"
                                                   target:self
                                                 selector:@selector(showQuest2)];
        
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
                    
                                                   target:self selector:@selector(showPlay)];
		
        menuChoice = [CCMenu menuWithItems:itemShop, itemTrainer, nil];
        menuQuests = [CCMenu menuWithItems:itemQuest1, itemQuest2, nil];
        menuBrew = [CCMenu menuWithItems:itemBrewery, nil];
        menuOptions = [CCMenu menuWithItems:itemHelp, itemMenu, nil];
        
        [labelQuestsDone setAnchorPoint:ccp(0, 0)];
        [labelQuestsDoneVal setAnchorPoint:ccp(1, 0)];
        [repBar setAnchorPoint:ccp(0,0)];
        [repBar2 setAnchorPoint:ccp(0,0)];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [tavernBG setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263.5)];
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 268.5)];
                
                [menuOptions alignItemsHorizontallyWithPadding:180];
                [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - 263)];
            }
            else {
                [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 234.5)];
                
                [menuOptions alignItemsHorizontallyWithPadding:180];
                [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - 225)];
            }
            
            [itemShop setPosition:ccp(0, 218)];
            [itemTrainer setPosition:ccp(100, 218)];
            [labelTavern setPosition:ccp(screenSize.width/2 - 100, screenSize.height/2 + 218)];
            
            [labelQuestsDone setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 167)];
            [labelQuestsDoneVal setPosition:ccp(screenSize.width/2 + 143, screenSize.height/2 + 166)];
            [labelRumors setPosition:ccp(screenSize.width/2, screenSize.height/2 + 108)];

            [labelQuest1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 25)];
            [labelQuest2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 51)];
            [menuBrew setPosition:ccp(screenSize.width/2, screenSize.height/2 - 125)];
            
            [menuQuests alignItemsVerticallyWithPadding:18];
            [menuQuests setPosition:ccp(screenSize.width/2, screenSize.height/2 - 14)];
            
            [labelReputation setPosition:ccp(screenSize.width/2, screenSize.height/2 - 187)];
            
            [repBar setPosition:ccp(screenSize.width/2 - 160, screenSize.height/2 - 210)];
            [repBar2 setPosition:ccp(screenSize.width/2 - 160, screenSize.height/2 - 210)];
        }
        else {
            [itemShop setPosition:ccp(0, (218.5 * 2.133f))];
            [itemTrainer setPosition:ccp((100 * 2.4f), (218.5 * 2.133f))];
            [labelTavern setPosition:ccp(screenSize.width/2 - (100 * 2.4f), screenSize.height/2 + (218.5 * 2.133f))];
            
            [menuBar01 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (228 * 2.133f))];
            [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (233 * 2.133f))];
                        
            [labelQuestsDone setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (167 * 2.133f))];
            [labelQuestsDoneVal setPosition:ccp(screenSize.width/2 + (143 * 2.4f), screenSize.height/2 + (165 * 2.133f))];
            [labelRumors setPosition:ccp(screenSize.width/2, screenSize.height/2 + (109 * 2.133f))];
            
            [labelQuest1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (25 * 2.133f))];
            [labelQuest2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (51 * 2.133f))];
            [menuBrew setPosition:ccp(screenSize.width/2, screenSize.height/2 - (125 * 2.133f))];
            
            [menuQuests alignItemsVerticallyWithPadding:(18 * 2.133f)];
            [menuQuests setPosition:ccp(screenSize.width/2, screenSize.height/2 - (14 * 2.133f))];
            
            [labelReputation setPosition:ccp(screenSize.width/2, screenSize.height/2 - (187 * 2.133f))];
            
            [repBar setPosition:ccp(screenSize.width/2 - (156 * 2.4f), screenSize.height/2 - (210 * 2.133f))];
            [repBar2 setPosition:ccp(screenSize.width/2 - (156 * 2.4f), screenSize.height/2 - (210 * 2.133f))];
            
            [menuOptions alignItemsHorizontallyWithPadding:(180 * 2.4f)];
            [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - (224 * 2.133f))];
        }
        
        [self addChild:background z:-2 tag:0];
        [self addChild:tavernBG z:-1 tag:1];
        [self addChild:menuBar02 z:0 tag:2];
        [self addChild:labelTavern z:1 tag:3];
        [self addChild:labelQuestsDone z:1 tag:4];
        [self addChild:labelQuestsDoneVal z:1 tag:5];
        [self addChild:labelRumors z:1 tag:6];
        [self addChild:labelQuest1 z:2 tag:7];
        [self addChild:labelQuest2 z:2 tag:8];
        [self addChild:menuBrew z:1 tag:9];
        [self addChild:labelReputation z:1 tag:10];
        [self addChild:repBar z:-2 tag:11];
        [self addChild:repBar2 z:-2 tag:12];
        [self addChild:menuQuests z:1 tag:13];
        [self addChild:menuChoice z:1 tag:14];
        [self addChild:menuOptions z:1 tag:15];
                
        if ([[Player sharedPlayer] getReputationRewards] == 10) {
            [repBar setScaleX:1.0];
            [repBar2 setScaleX:1.0];
        }
        else if ([[Player sharedPlayer] getReputationRewards] == 9) {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 100000.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 100000.0)];
        }
        else if ([[Player sharedPlayer] getReputationRewards] == 8) {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 50000.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 50000.0)];
        }
        else if ([[Player sharedPlayer] getReputationRewards] == 7) {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 25000.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 25000.0)];
        }
        else if ([[Player sharedPlayer] getReputationRewards] == 6) {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 10000.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 10000.0)];
        }
        else if ([[Player sharedPlayer] getReputationRewards] == 5) {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 5000.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 5000.0)];
        }
        else if ([[Player sharedPlayer] getReputationRewards] == 4) {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 2500.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 2500.0)];
        }
        else if ([[Player sharedPlayer] getReputationRewards] == 3) {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 1000.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 1000.0)];
        }
        else if ([[Player sharedPlayer] getReputationRewards] == 2) {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 500.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 500.0)];
        }
        else if ([[Player sharedPlayer] getReputationRewards] == 1) {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 250.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 250.0)];
        }
        else {
            [repBar setScaleX:((float)[[Player sharedPlayer] reputation] / 100.0)];
            [repBar2 setScaleX:((float)[[Player sharedPlayer] reputation] / 100.0)];
        }
        
        repBar2.opacity = 80.0f;
        shouldGlow = YES;
        
        if ([[Player sharedPlayer] getReputationRewards] >= 2) {
            showSecondReward = YES;
            [self schedule:@selector(updateRewards:) interval:2.0f];
        }
        
        if (screenSize.height == 568.00) {
            [self addChild:menuBar01 z:0 tag:16];
            [self addChild:labelMsg z:1 tag:17];
        }
        
        [self scheduleUpdate];
	}
    
	return self;
}

#pragma mark - scene setup

// setups the tavern menu
-(void)setupTavernMenu
{
    questGen1 = arc4random_uniform(6);
    questGen2 = arc4random_uniform(6) + 6;
        
    msgQuest1 = [self setupQuestMsg:questGen1];
    msgQuest2 = [self setupQuestMsg:questGen2];
}

// setups the quest msg
-(NSString*)setupQuestMsg:(int)value
{
    NSString *questMsg;
    
    if (value == 0) questMsg = NSLocalizedString(@"Quest01", nil);
    else if (value == 1) questMsg = NSLocalizedString(@"Quest02", nil);
    else if (value == 2) questMsg = NSLocalizedString(@"Quest03", nil);
    else if (value == 3) questMsg = NSLocalizedString(@"Quest04", nil);
    else if (value == 4) questMsg = NSLocalizedString(@"Quest05", nil);
    else if (value == 5) questMsg = NSLocalizedString(@"Quest06", nil);
    else if (value == 6) questMsg = NSLocalizedString(@"Quest07", nil);
    else if (value == 7) questMsg = NSLocalizedString(@"Quest08", nil);
    else if (value == 8) questMsg = NSLocalizedString(@"Quest09", nil);
    else if (value == 9) questMsg = NSLocalizedString(@"Quest10", nil);
    else if (value == 10) questMsg = NSLocalizedString(@"Quest11", nil);
    else if (value == 11) questMsg = NSLocalizedString(@"Quest12", nil);
    
    return questMsg;
}

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
    
    if (shouldGlow) {
        repBar2.opacity += 2.0f;
        
        if (repBar2.opacity >= 150.0f) shouldGlow = NO;
    }
    else {
        repBar2.opacity -= 2.0f;
        
        if (repBar2.opacity <= 80.0f) shouldGlow = YES;
    }
    
    if (itemMenu.isSelected) {
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemMenu.isSelected) {
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

// updates rewards
-(void)updateRewards:(ccTime)dt
{
    NSString *reward;
    
    if (showSecondReward) {
        if ([[Player sharedPlayer] getReputationRewards] == 10) {
            reward = NSLocalizedString(@"Reputation07", nil);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 8) {
            reward = NSLocalizedString(@"Reputation08", nil);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 6) {
            reward = NSLocalizedString(@"Reputation09", nil);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 4) {
            reward = NSLocalizedString(@"Reputation10", nil);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 2) {
            reward = NSLocalizedString(@"Reputation11", nil);
        }
        
        showSecondReward = NO;
    }
    else {
        if ([[Player sharedPlayer] getReputationRewards] >= 9) {
            reward = NSLocalizedString(@"Reputation02", nil);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 7) {
            reward = NSLocalizedString(@"Reputation03", nil);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 5) {
            reward = NSLocalizedString(@"Reputation04", nil);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 3) {
            reward = NSLocalizedString(@"Reputation05", nil);
        }
        else if ([[Player sharedPlayer] getReputationRewards] >= 1) {
            reward = NSLocalizedString(@"Reputation06", nil);
        }
        
        showSecondReward = YES;
    }
    
    [self removeChild:labelReputation cleanup:YES];
    
    labelReputation = [Utility labelWithString:reward
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [labelReputation setPosition:ccp(screenSize.width/2, screenSize.height/2 - 187)];
    }
    else {
        [labelReputation setPosition:ccp(screenSize.width/2, screenSize.height/2 - (187 * 2.133f))];
    }
    
    [self addChild:labelReputation z:1 tag:10];
}

#pragma mark - menu choices

// shows the help scene
-(void)showHelp
{
    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuQuests.isTouchEnabled = NO;
    menuBrew.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    
    ccColor4B colour = {0, 0, 0, 0};
    TavernHelpLayer *help_layer = [[TavernHelpLayer alloc] initWithColor:colour];
    
    [self addChild:help_layer z:10];
}

// shows the play scene
-(void)showPlay
{
    [[GameManager sharedGameManager] runSceneWithID:kScenePlay withTransition:NO];
}

// shows the quest 1 scene
-(void)showQuest1
{
    [[SoundManager sharedSoundManager] fadeOutBackgroundMusic];
    
    if (questGen1 == 0) [[GameManager sharedGameManager] setQuestType:kQuestType1];
    else if (questGen1 == 1) [[GameManager sharedGameManager] setQuestType:kQuestType2];
    else if (questGen1 == 2) [[GameManager sharedGameManager] setQuestType:kQuestType3];
    else if (questGen1 == 3) [[GameManager sharedGameManager] setQuestType:kQuestType4];
    else if (questGen1 == 4) [[GameManager sharedGameManager] setQuestType:kQuestType5];
    else if (questGen1 == 5) [[GameManager sharedGameManager] setQuestType:kQuestType6];
    else if (questGen1 == 6) [[GameManager sharedGameManager] setQuestType:kQuestType7];
    else if (questGen1 == 7) [[GameManager sharedGameManager] setQuestType:kQuestType8];
    else if (questGen1 == 8) [[GameManager sharedGameManager] setQuestType:kQuestType9];
    else if (questGen1 == 9) [[GameManager sharedGameManager] setQuestType:kQuestType10];
    else if (questGen1 == 10) [[GameManager sharedGameManager] setQuestType:kQuestType11];
    else if (questGen1 == 11) [[GameManager sharedGameManager] setQuestType:kQuestType12];
    
    if ([[Player sharedPlayer] emblems] == 4) {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonSanctumOfDestiny];
    }
    else if ([[Player sharedPlayer] emblems] == 3) {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonTempleOfOldOnes];
    }
    else if ([[Player sharedPlayer] emblems] == 2) {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonForgottenCatacombs];
    }
    else if ([[Player sharedPlayer] emblems] == 1) {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonUndergroundLake];
    }
    else {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonBloodyDungeon];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneQuest withTransition:YES];
}

// shows the quest 2 scene
-(void)showQuest2
{
    [[SoundManager sharedSoundManager] fadeOutBackgroundMusic];
    
    if (questGen2 == 0) [[GameManager sharedGameManager] setQuestType:kQuestType1];
    else if (questGen2 == 1) [[GameManager sharedGameManager] setQuestType:kQuestType2];
    else if (questGen2 == 2) [[GameManager sharedGameManager] setQuestType:kQuestType3];
    else if (questGen2 == 3) [[GameManager sharedGameManager] setQuestType:kQuestType4];
    else if (questGen2 == 4) [[GameManager sharedGameManager] setQuestType:kQuestType5];
    else if (questGen2 == 5) [[GameManager sharedGameManager] setQuestType:kQuestType6];
    else if (questGen2 == 6) [[GameManager sharedGameManager] setQuestType:kQuestType7];
    else if (questGen2 == 7) [[GameManager sharedGameManager] setQuestType:kQuestType8];
    else if (questGen2 == 8) [[GameManager sharedGameManager] setQuestType:kQuestType9];
    else if (questGen2 == 9) [[GameManager sharedGameManager] setQuestType:kQuestType10];
    else if (questGen2 == 10) [[GameManager sharedGameManager] setQuestType:kQuestType11];
    else if (questGen2 == 11) [[GameManager sharedGameManager] setQuestType:kQuestType12];
    
    if ([[Player sharedPlayer] emblems] == 4) {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonSanctumOfDestiny];
    }
    else if ([[Player sharedPlayer] emblems] == 3) {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonTempleOfOldOnes];
    }
    else if ([[Player sharedPlayer] emblems] == 2) {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonForgottenCatacombs];
    }
    else if ([[Player sharedPlayer] emblems] == 1) {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonUndergroundLake];
    }
    else {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonBloodyDungeon];
    }
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneQuest withTransition:YES];
}

// shows the shop scene
-(void)showShop
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneShop withTransition:NO];
}

// shows the trainer scene
-(void)showTrainer
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneTrainer withTransition:NO];
}

#pragma mark - pausing and resuming

// resumes after help
-(void)resumeFromHelp
{
    self.isTouchEnabled = YES;
    menuChoice.isTouchEnabled = YES;
    menuQuests.isTouchEnabled = YES;
    menuBrew.isTouchEnabled = YES;
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
