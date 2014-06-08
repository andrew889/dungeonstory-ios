//
//  ArenaLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 09/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "ArenaLayer.h"
#import "GameManager.h"
#import "GameCenterManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "Tile.h"
#import "BattleLine.h"
#import "ArenaEventsLayer.h"
#import "PauseMultiPlayerLayer.h"
#import "Utility.h"

#pragma mark - ArenaLayer

@implementation ArenaLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	ArenaLayer *layer = [ArenaLayer node];
    
	[scene addChild:layer z:0];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {
        [[CCDirector sharedDirector] purgeCachedData];
        
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"BattleMenu.png"];
        battleInterface = [CCSprite spriteWithFile:@"BattleInterface.png"];
        healthbars = [CCSprite spriteWithFile:@"Healthbars.png"];
        expbar = [CCSprite spriteWithFile:@"Expbar.png"];
        energybar = [CCSprite spriteWithFile:@"Energybar.png"];
        energybarFull = [CCSprite spriteWithFile:@"Energybar2.png"];
        playerStats = [CCSprite spriteWithFile:@"PlayerStatus.png"];
        enemyStats = [CCSprite spriteWithFile:@"EnemyStatus.png"];
        
        if (screenSize.height == 568.00) {
            battleBar = [CCSprite spriteWithFile:@"battlebar-iphone5.png"];
        }
        
        wait_layer = [[ArenaEventsLayer alloc] initWithWaitingTurn];
        
        [self setupPuzzle];
        [self setupBattle];
        [self setupBattleStats];
        
        healthbar1 = [[CCSprite alloc] initWithSpriteFrameName:@"Healthbar.png"];
        healthbar2 = [[CCSprite alloc] initWithSpriteFrameName:@"Healthbar.png"];
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        
        labelTime = [CCLabelTTF labelWithString:[formatter stringFromDate:[NSDate date]]
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
        
        labelPlayerClass = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleClass", nil)
                                              fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelPlayerAttack = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleAttack", nil)
                                               fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelPlayerDefence = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleDefence", nil)
                                                fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelPlayerMagic = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleMagic", nil)
                                              fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelPlayerLuck = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleLuck", nil)
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelPlayerStatus = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleStatus", nil)
                                               fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelPlayerStatusVal = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleStatus01", nil)
                                                  fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        
        labelEnemyClass = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleClass", nil)
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelEnemyAttack = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleAttack", nil)
                                              fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelEnemyDefence = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleDefence", nil)
                                               fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelEnemyMagic = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleMagic", nil)
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelEnemyLuck = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleLuck", nil)
                                            fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelEnemyStatus = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleStatus", nil)
                                              fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelEnemyStatusVal = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleStatus01", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        
        [labelPlayerClass setColor:ccBLACK];
        [labelPlayerClassVal setColor:[[Player sharedPlayer] classColor]];
        [labelPlayerAttack setColor:ccBLACK];
        [labelPlayerAttackVal setColor:ccBLACK];
        [labelPlayerDefence setColor:ccBLACK];
        [labelPlayerDefenceVal setColor:ccBLACK];
        [labelPlayerMagic setColor:ccBLACK];
        [labelPlayerMagicVal setColor:ccBLACK];
        [labelPlayerLuck setColor:ccBLACK];
        [labelPlayerLuckVal setColor:ccBLACK];
        [labelPlayerStatus setColor:ccBLACK];
        [labelPlayerStatusVal setColor:ccBLACK];
        [labelEnemyClass setColor:ccBLACK];
        [labelEnemyClassVal setColor:
         [[Player sharedPlayer] getClassColor:
          [[GameCenterManager sharedGameCenterManager] opponentClassVal]]];
        [labelEnemyAttack setColor:ccBLACK];
        [labelEnemyAttackVal setColor:ccBLACK];
        [labelEnemyDefence setColor:ccBLACK];
        [labelEnemyDefenceVal setColor:ccBLACK];
        [labelEnemyMagic setColor:ccBLACK];
        [labelEnemyMagicVal setColor:ccBLACK];
        [labelEnemyLuck setColor:ccBLACK];
        [labelEnemyLuckVal setColor:ccBLACK];
        [labelEnemyStatus setColor:ccBLACK];
        [labelEnemyStatusVal setColor:ccBLACK];
                
        itemBtn1 = [CCMenuItemImage itemWithNormalImage:@"itemBtnActivated1.png"
                                          selectedImage:@"itemBtnPressed.png"
                                          disabledImage:@"itemBtn1.png"
                                                 target:self
                                               selector:@selector(useItemBtn1)];
        
        if ([[Player sharedPlayer] potion] == 1) {
            itemBtn2 = [CCMenuItemImage itemWithNormalImage:@"itemBtnActivated2.png"
                                              selectedImage:@"itemBtnPressed.png"
                                              disabledImage:@"itemBtn2.png"
                                                     target:self
                                                   selector:@selector(useItemBtn2)];
        }
        else if ([[Player sharedPlayer] potion] == 0) {
            itemBtn2 = [CCMenuItemImage itemWithNormalImage:@"itemBtn2.png"
                                              selectedImage:@"itemBtn2.png"];
        }
        
        if ([[Player sharedPlayer] bomb] == 1) {
            itemBtn3 = [CCMenuItemImage itemWithNormalImage:@"itemBtnActivated3.png"
                                              selectedImage:@"itemBtnPressed.png"
                                              disabledImage:@"itemBtn3.png"
                                                     target:self
                                                   selector:@selector(useItemBtn3)];
            
        }
        else if ([[Player sharedPlayer] bomb] == 0) {
            itemBtn3 = [CCMenuItemImage itemWithNormalImage:@"itemBtn3.png"
                                              selectedImage:@"itemBtn3.png"];
            
        }
        
        itemPauseBtn = [CCMenuItemImage itemWithNormalImage:@"menuBtn.png"
                                              selectedImage:@"menuBtnPressed.png"
                                              disabledImage:nil
                                                     target:self
                                                   selector:@selector(pauseGame)];
        
        menuButtons = [CCMenu menuWithItems:itemBtn1, itemBtn2, itemBtn3, nil];
        menuPause = [CCMenu menuWithItems:itemPauseBtn, nil];
        
        [healthbar1 setAnchorPoint:ccp(0, 0)];
        [healthbar2 setAnchorPoint:ccp(0, 0)];
        [expbar setAnchorPoint:ccp(0, 0)];
        [energybar setAnchorPoint:ccp(0, 0)];
        [energybarFull setAnchorPoint:ccp(0, 0)];
        [labelPlayerClass setAnchorPoint:ccp(0, 0)];
        [labelPlayerClassVal setAnchorPoint:ccp(1, 0)];
        [labelPlayerAttack setAnchorPoint:ccp(0, 0)];
        [labelPlayerAttackVal setAnchorPoint:ccp(1, 0)];
        [labelPlayerDefence setAnchorPoint:ccp(0, 0)];
        [labelPlayerDefenceVal setAnchorPoint:ccp(1, 0)];
        [labelPlayerMagic setAnchorPoint:ccp(0, 0)];
        [labelPlayerMagicVal setAnchorPoint:ccp(1, 0)];
        [labelPlayerLuck setAnchorPoint:ccp(0, 0)];
        [labelPlayerLuckVal setAnchorPoint:ccp(1, 0)];
        [labelPlayerStatus setAnchorPoint:ccp(0, 0)];
        [labelPlayerStatusVal setAnchorPoint:ccp(1, 0)];
        [labelEnemyClass setAnchorPoint:ccp(0, 0)];
        [labelEnemyClassVal setAnchorPoint:ccp(1, 0)];
        [labelEnemyAttack setAnchorPoint:ccp(0, 0)];
        [labelEnemyAttackVal setAnchorPoint:ccp(1, 0)];
        [labelEnemyDefence setAnchorPoint:ccp(0, 0)];
        [labelEnemyDefenceVal setAnchorPoint:ccp(1, 0)];
        [labelEnemyMagic setAnchorPoint:ccp(0, 0)];
        [labelEnemyMagicVal setAnchorPoint:ccp(1, 0)];
        [labelEnemyLuck setAnchorPoint:ccp(0, 0)];
        [labelEnemyLuckVal setAnchorPoint:ccp(1, 0)];
        [labelEnemyStatus setAnchorPoint:ccp(0, 0)];
        [labelEnemyStatusVal setAnchorPoint:ccp(1, 0)];
                
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [battleInterface setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [healthbars setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (screenSize.height == 568.00) {
            [battleBar setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [healthbar1 setPosition:ccp(screenSize.width/2 - 159, screenSize.height/2 + 174)];
            [healthbar2 setPosition:ccp(screenSize.width/2 + 159, screenSize.height/2 + 174)];
            [expbar setPosition:ccp(screenSize.width/2 - 41, screenSize.height/2 + 195)];
            [energybar setPosition:ccp(screenSize.width/2 - 41, screenSize.height/2 + 175)];
            [energybarFull setPosition:ccp(screenSize.width/2 - 41, screenSize.height/2 + 175)];
            
            [labelTime setPosition:ccp(screenSize.width/2, screenSize.height/2 + 220)];
            [labelName setPosition:ccp(screenSize.width/2 - 104, screenSize.height/2 + 220)];
            [labelEnemyName setPosition:ccp(screenSize.width/2 + 104, screenSize.height/2 + 220)];
            [labelPlayerHPVal setPosition:ccp(screenSize.width/2 - 104, screenSize.height/2 + 192)];
            [labelEnemyHPVal setPosition:ccp(screenSize.width/2 + 104, screenSize.height/2 + 192)];
            
            [playerStats setPosition:ccp(screenSize.width/2 - 73, screenSize.height/2 + 102)];
            [labelPlayerClass setPosition:ccp(28, 117)];
            [labelPlayerClassVal setPosition:ccp(148, 117)];
            [labelPlayerAttack setPosition:ccp(28, 93)];
            [labelPlayerAttackVal setPosition:ccp(148, 93)];
            [labelPlayerDefence setPosition:ccp(28, 75)];
            [labelPlayerDefenceVal setPosition:ccp(148, 75)];
            [labelPlayerMagic setPosition:ccp(28, 57)];
            [labelPlayerMagicVal setPosition:ccp(148, 57)];
            [labelPlayerLuck setPosition:ccp(28, 39)];
            [labelPlayerLuckVal setPosition:ccp(148, 39)];
            [labelPlayerStatus setPosition:ccp(28, 17)];
            [labelPlayerStatusVal setPosition:ccp(148, 17)];
            
            [enemyStats setPosition:ccp(screenSize.width/2 + 73, screenSize.height/2 + 102.5)];
            [labelEnemyClass setPosition:ccp(34, 117)];
            [labelEnemyClassVal setPosition:ccp(154, 117)];
            [labelEnemyAttack setPosition:ccp(34, 93)];
            [labelEnemyAttackVal setPosition:ccp(154, 93)];
            [labelEnemyDefence setPosition:ccp(34, 75)];
            [labelEnemyDefenceVal setPosition:ccp(154, 75)];
            [labelEnemyMagic setPosition:ccp(34, 57)];
            [labelEnemyMagicVal setPosition:ccp(154, 57)];
            [labelEnemyLuck setPosition:ccp(34, 39)];
            [labelEnemyLuckVal setPosition:ccp(154, 39)];
            [labelEnemyStatus setPosition:ccp(34, 17)];
            [labelEnemyStatusVal setPosition:ccp(154, 17)];
            
            [menuButtons alignItemsHorizontallyWithPadding:2.5];
            [menuButtons setPosition:ccp(screenSize.width/2 - 39, screenSize.height/2 - 212)];
            [menuPause setPosition:ccp(screenSize.width/2 + 118.5, screenSize.height/2 - 212)];
        }
        else {
            [healthbar1 setPosition:ccp(screenSize.width/2 - (159 * 2.4f), screenSize.height/2 + (174 * 2.133f))];
            [healthbar2 setPosition:ccp(screenSize.width/2 + (159 * 2.4f), screenSize.height/2 + (174 * 2.133f))];
            [expbar setPosition:ccp(screenSize.width/2 - (41 * 2.4f), screenSize.height/2 + (195 * 2.133f))];
            [energybar setPosition:ccp(screenSize.width/2 - (41 * 2.4f), screenSize.height/2 + (175 * 2.133f))];
            [energybarFull setPosition:ccp(screenSize.width/2 - (41 * 2.4f), screenSize.height/2 + (175 * 2.133f))];
            
            [labelTime setPosition:ccp(screenSize.width/2, screenSize.height/2 + (220 * 2.133f))];
            [labelName setPosition:ccp(screenSize.width/2 - (104 * 2.4f), screenSize.height/2 + (220 * 2.133f))];
            [labelEnemyName setPosition:ccp(screenSize.width/2 + (104 * 2.4f), screenSize.height/2 + (220 * 2.133f))];
            [labelPlayerHPVal setPosition:ccp(screenSize.width/2 - (104 * 2.4f), screenSize.height/2 + (192 * 2.133f))];
            [labelEnemyHPVal setPosition:ccp(screenSize.width/2 + (104 * 2.4f), screenSize.height/2 + (192 * 2.133f))];
            
            [playerStats setPosition:ccp(screenSize.width/2 - (73 * 2.4f), screenSize.height/2 + (97 * 2.133f))];
            [labelPlayerClass setPosition:ccp(25 * 2.4f, 120 * 2.133f)];
            [labelPlayerClassVal setPosition:ccp(140 * 2.4f, 120 * 2.133f)];
            [labelPlayerAttack setPosition:ccp(25 * 2.4f, 95 * 2.133f)];
            [labelPlayerAttackVal setPosition:ccp(140 * 2.4f, 95 * 2.133f)];
            [labelPlayerDefence setPosition:ccp(25 * 2.4f, 77 * 2.133f)];
            [labelPlayerDefenceVal setPosition:ccp(140 * 2.4f, 77 * 2.133f)];
            [labelPlayerMagic setPosition:ccp(25 * 2.4f, 59 * 2.133f)];
            [labelPlayerMagicVal setPosition:ccp(140 * 2.4f, 59 * 2.133f)];
            [labelPlayerLuck setPosition:ccp(25 * 2.4f, 41 * 2.133f)];
            [labelPlayerLuckVal setPosition:ccp(140 * 2.4f, 41 * 2.133f)];
            [labelPlayerStatus setPosition:ccp(25 * 2.4f, 17 * 2.133f)];
            [labelPlayerStatusVal setPosition:ccp(140 * 2.4f, 17 * 2.133f)];
            
            [enemyStats setPosition:ccp(screenSize.width/2 + (73 * 2.4f), screenSize.height/2 + (98 * 2.133f))];
            [labelEnemyClass setPosition:ccp(30 * 2.4f, 117 * 2.133f)];
            [labelEnemyClassVal setPosition:ccp(144 * 2.4f, 117 * 2.133f)];
            [labelEnemyAttack setPosition:ccp(30 * 2.4f, 93 * 2.133f)];
            [labelEnemyAttackVal setPosition:ccp(144 * 2.4f, 93 * 2.133f)];
            [labelEnemyDefence setPosition:ccp(30 * 2.4f, 75 * 2.133f)];
            [labelEnemyDefenceVal setPosition:ccp(144 * 2.4f, 75 * 2.133f)];
            [labelEnemyMagic setPosition:ccp(30 * 2.4f, 57 * 2.133f)];
            [labelEnemyMagicVal setPosition:ccp(144 * 2.4f, 57 * 2.133f)];
            [labelEnemyLuck setPosition:ccp(30 * 2.4f, 39 * 2.133f)];
            [labelEnemyLuckVal setPosition:ccp(144 * 2.4f, 39 * 2.133f)];
            [labelEnemyStatus setPosition:ccp(30 * 2.4f, 17 * 2.133f)];
            [labelEnemyStatusVal setPosition:ccp(144 * 2.4f, 17 * 2.133f)];
            
            [menuButtons alignItemsHorizontallyWithPadding:(12 * 2.4f)];
            [menuButtons setPosition:ccp(screenSize.width/2 - (39 * 2.4f), screenSize.height/2 - (212 * 2.11f))];
            [menuPause setPosition:ccp(screenSize.width/2 + 271.2, screenSize.height/2 - (212 * 2.11f))];
        }
        
        [self addChild:background z:-4 tag:0];
        [self addChild:battleInterface z:3 tag:1];
        [self addChild:healthbar1 z:4 tag:2];
        [self addChild:healthbar2 z:4 tag:3];
        [self addChild:expbar z:4 tag:4];
        [self addChild:energybar z:4 tag:5];
        [self addChild:energybarFull z:5 tag:6];
        [self addChild:healthbars z:6 tag:7];
        [self addChild:playerStats z:16 tag:8];
        [self addChild:enemyStats z:16 tag:9];
        [self addChild:labelTime z:7 tag:10];
		[self addChild:labelName z:7 tag:11];
        [self addChild:labelEnemyName z:7 tag:12];
        [self addChild:labelPlayerHPVal z:7 tag:13];
        [self addChild:labelEnemyHPVal z:7 tag:14];
        [self addChild:menuButtons z:7 tag:15];
        [self addChild:menuPause z:7 tag:16];
        [self addChild:wait_layer z:15 tag:17];
        
        if (screenSize.height == 568.00) {
            [self addChild:battleBar z:8 tag:18];
        }
        
        [playerStats addChild:labelPlayerClass z:0];
        [playerStats addChild:labelPlayerClassVal z:0];
        [playerStats addChild:labelPlayerAttack z:0];
        [playerStats addChild:labelPlayerAttackVal z:0];
        [playerStats addChild:labelPlayerDefence z:0];
        [playerStats addChild:labelPlayerDefenceVal z:0];
        [playerStats addChild:labelPlayerMagic z:0];
        [playerStats addChild:labelPlayerMagicVal z:0];
        [playerStats addChild:labelPlayerLuck z:0];
        [playerStats addChild:labelPlayerLuckVal z:0];
        [playerStats addChild:labelPlayerStatus z:0];
        [playerStats addChild:labelPlayerStatusVal z:0];
        
        [enemyStats addChild:labelEnemyClass z:0];
        [enemyStats addChild:labelEnemyClassVal z:0];
        [enemyStats addChild:labelEnemyAttack z:0];
        [enemyStats addChild:labelEnemyAttackVal z:0];
        [enemyStats addChild:labelEnemyDefence z:0];
        [enemyStats addChild:labelEnemyDefenceVal z:0];
        [enemyStats addChild:labelEnemyMagic z:0];
        [enemyStats addChild:labelEnemyMagicVal z:0];
        [enemyStats addChild:labelEnemyLuck z:0];
        [enemyStats addChild:labelEnemyLuckVal z:0];
        [enemyStats addChild:labelEnemyStatus z:0];
        [enemyStats addChild:labelEnemyStatusVal z:0];
        
        [self setupItemSlots];
        
        healthbar2.scaleX = -1;
        
        playerStats.visible = NO;
        enemyStats.visible = NO;
        tileChanged = NO;
        touchValueIsActive = NO;
        
        [itemBtn1 setIsEnabled:NO];
        [itemBtn2 setIsEnabled:NO];
        [itemBtn3 setIsEnabled:NO];
        
        [self scheduleUpdate];
        [self schedule:@selector(timeSchedule:) interval:5.0f];
        
        self.isTouchEnabled = YES;
        wait_layer.visible = NO;
        
        shouldEnergyGlow = YES;
        lowHealthTexture_dt = 0;
	}
    
	return self;
}

#pragma mark - scene setup

// setups battle
-(void)setupBattle
{
    if ([[GameCenterManager sharedGameCenterManager] isPlayer1]) {
        [[GameCenterManager sharedGameCenterManager] setIsPlayersTurn:YES];
        tileTouchesAllowed = YES;
    }
    else {
        [[GameCenterManager sharedGameCenterManager] setIsPlayersTurn:NO];
        tileTouchesAllowed = NO;
    }
    
    coins = 0;
    
    [[Player sharedPlayer] setupForBattle];
    
    if (![[Player sharedPlayer] name]) {
        msgName = [NSString stringWithFormat:@"%@",
                   [[Player sharedPlayer] className]];
    }
    else {
        msgName = [NSString stringWithFormat:@"%@",
                   [[Player sharedPlayer] name]];
    }
    
    enemyName = [[GameCenterManager sharedGameCenterManager] opponentName];
        
    if (enemyName.length > 11) {
        enemyName = [enemyName substringToIndex:10];
        enemyName = [NSString stringWithFormat:@"%@...", enemyName];
    }
    
    enemyMaxHP = [[GameCenterManager sharedGameCenterManager] opponentMaxHP];
    enemyCurrentHP = enemyMaxHP;
    
    labelName = [CCLabelTTF labelWithString:msgName fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
    labelEnemyName = [CCLabelTTF labelWithString:enemyName
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
    
    labelPlayerHPVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d/%d",
                                                    [[Player sharedPlayer] currentHP],
                                                    [[Player sharedPlayer] maxHP]]
                                          fontName:@"Shark Crash" fontSize:[Utility getFontSize:16]];
    labelEnemyHPVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d/%d",
                                                   enemyCurrentHP, enemyMaxHP]
                                         fontName:@"Shark Crash" fontSize:[Utility getFontSize:16]];
    
    labelPlayerClassVal = [CCLabelTTF labelWithString:[[Player sharedPlayer] className]
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelPlayerAttackVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelPlayerDefenceVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelPlayerMagicVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelPlayerLuckVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    
    labelEnemyClassVal = [CCLabelTTF
                          labelWithString:[[Player sharedPlayer] getCLassName:
                                           [[GameCenterManager sharedGameCenterManager] opponentClassVal]]
                          fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelEnemyAttackVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",
                                                       [[GameCenterManager sharedGameCenterManager] opponentAttack]]
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelEnemyDefenceVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",
                                                        [[GameCenterManager sharedGameCenterManager] opponentDefence]]
                                              fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelEnemyMagicVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",
                                                      [[GameCenterManager sharedGameCenterManager] opponentMagic]]
                                            fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelEnemyLuckVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",
                                                     [[GameCenterManager sharedGameCenterManager] opponentLuck]]
                                           fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
}

// setups item slots
-(void)setupItemSlots
{
    if ([[Player sharedPlayer] shield] == 2) {
        item1 = [CCSprite spriteWithFile:@"shield_item_2.png"];
    }
    else {
        item1 = [CCSprite spriteWithFile:@"shield_item.png"];
    }
    
    if ([[Player sharedPlayer] potion] == 1) {
        item2 = [CCSprite spriteWithFile:@"potion_item.png"];
    }
    else {
        item2 = [CCSprite spriteWithFile:@"potion_item_2.png"];
    }
    
    if ([[Player sharedPlayer] bomb] == 1) {
        item3 = [CCSprite spriteWithFile:@"bomb_item.png"];
    }
    else {
        item3 = [CCSprite spriteWithFile:@"bomb_item_2.png"];
    }
    
    item4 = [CCSprite spriteWithFile:@"ale_item.png"];
    item5 = [CCSprite spriteWithFile:@"rune_item.png"];
    item6 = [CCSprite spriteWithFile:@"mirror_item.png"];
    item7 = [CCSprite spriteWithFile:@"flute_item.png"];
    
    [item1 setScale:0.7];
    [item2 setScale:0.7];
    [item3 setScale:0.7];
    [item4 setScale:0.7];
    [item5 setScale:0.7];
    [item6 setScale:0.7];
    [item7 setScale:0.7];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [item1 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2 + 5)];
        [item2 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2 + 5)];
        [item3 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2 + 5)];
        [item4 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2 + 5)];
        [item5 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2 + 5)];
        [item6 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2 + 5)];
        [item7 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2 + 5)];
    }
    else {
        [item1 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2)];
        [item2 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2)];
        [item3 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2)];
        [item4 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2)];
        [item5 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2)];
        [item6 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2)];
        [item7 setPosition:ccp(itemBtn1.contentSize.width/2, itemBtn1.contentSize.height/2)];
    }
    
    if ([[GameManager sharedGameManager] itemSlot1] == 1) [itemBtn1 addChild:item1 z:1];
    else if ([[GameManager sharedGameManager] itemSlot1] == 2) [itemBtn1 addChild:item2 z:1];
    else if ([[GameManager sharedGameManager] itemSlot1] == 3) [itemBtn1 addChild:item3 z:1];
    else if ([[GameManager sharedGameManager] itemSlot1] == 4) [itemBtn1 addChild:item4 z:1];
    else if ([[GameManager sharedGameManager] itemSlot1] == 5) [itemBtn1 addChild:item5 z:1];
    else if ([[GameManager sharedGameManager] itemSlot1] == 6) [itemBtn1 addChild:item6 z:1];
    else if ([[GameManager sharedGameManager] itemSlot1] == 7) [itemBtn1 addChild:item7 z:1];
    
    if ([[GameManager sharedGameManager] itemSlot2] == 1) [itemBtn2 addChild:item1 z:1];
    else if ([[GameManager sharedGameManager] itemSlot2] == 2) [itemBtn2 addChild:item2 z:1];
    else if ([[GameManager sharedGameManager] itemSlot2] == 3) [itemBtn2 addChild:item3 z:1];
    else if ([[GameManager sharedGameManager] itemSlot2] == 4) [itemBtn2 addChild:item4 z:1];
    else if ([[GameManager sharedGameManager] itemSlot2] == 5) [itemBtn2 addChild:item5 z:1];
    else if ([[GameManager sharedGameManager] itemSlot2] == 6) [itemBtn2 addChild:item6 z:1];
    else if ([[GameManager sharedGameManager] itemSlot2] == 7) [itemBtn2 addChild:item7 z:1];
    
    if ([[GameManager sharedGameManager] itemSlot3] == 1) [itemBtn3 addChild:item1 z:1];
    else if ([[GameManager sharedGameManager] itemSlot3] == 2) [itemBtn3 addChild:item2 z:1];
    else if ([[GameManager sharedGameManager] itemSlot3] == 3) [itemBtn3 addChild:item3 z:1];
    else if ([[GameManager sharedGameManager] itemSlot3] == 4) [itemBtn3 addChild:item4 z:1];
    else if ([[GameManager sharedGameManager] itemSlot3] == 5) [itemBtn3 addChild:item5 z:1];
    else if ([[GameManager sharedGameManager] itemSlot3] == 6) [itemBtn3 addChild:item6 z:1];
    else if ([[GameManager sharedGameManager] itemSlot3] == 7) [itemBtn3 addChild:item7 z:1];
}

// setups battle stats
-(void)setupBattleStats
{
    [labelPlayerAttackVal setString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] getRankedAttack]]];
    [labelPlayerDefenceVal setString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] getRankedDefence]]];
    [labelPlayerMagicVal setString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] getRankedMagic]]];
    [labelPlayerLuckVal setString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] getRankedLuck]]];
}

#pragma mark - puzzle setup

// setups puzzle
-(void)setupPuzzle
{
    spriteBatchNodeTiles = [CCSpriteBatchNode batchNodeWithFile:@"gameatlas.png"];
    spriteBatchNodeAnimatedTiles = [CCSpriteBatchNode batchNodeWithFile:@"gameatlas.png"];
    spriteBatchNodeLines = [CCSpriteBatchNode batchNodeWithFile:@"gameatlas.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameatlas.plist"];
    [self addChild:spriteBatchNodeTiles z:2];
    [self addChild:spriteBatchNodeAnimatedTiles z:8];
    [self addChild:spriteBatchNodeLines z:1];
    
    puzzleContents = [[NSMutableArray alloc] initWithCapacity:(kPuzzleWidth * kPuzzleHeight)];
    toRemoveTiles = [[NSMutableArray alloc] initWithCapacity:(kPuzzleWidth * kPuzzleHeight)];
    battleLines = [[NSMutableArray alloc] initWithCapacity:(kPuzzleWidth * kPuzzleHeight) - 1];
    
    numOfBattleLines = 0;
    
    for (int i = 0; i < (kPuzzleWidth * kPuzzleHeight); i++) {
        Tile *tile = [self createRandomTileAtIndex:i
                                          withDrop:NO];
        
        [spriteBatchNodeTiles addChild:tile.tileSprite z:1];
        [puzzleContents addObject:tile];
    }
}

// returns a randomly created tile
-(Tile*)createRandomTileAtIndex:(int)idx
                       withDrop:(BOOL)drop
{
    TileType tileType;
    
    int random = arc4random_uniform(4);
    
    if (random == 0) tileType = kTileSword;
    else if (random == 1) tileType = kTileMagic;
    else if (random == 2) tileType = kTileHeart;
    else if (random == 3) tileType = kTileGold;
    
    int x = idx % kPuzzleHeight;
    int y = (idx - x) / kPuzzleHeight;
    
    return [[Tile alloc] initWithType:tileType withX:x withY:y withDrop:drop];
}

// removes the chosen tiles and rebuilds puzzle
-(void)rebuildsPuzzle:(ccTime)dt
{
    for (Tile *checkedTile in puzzleContents) {
        [[checkedTile tileSprite] setOpacity:255];
    }
    
    for (Tile *toBeRemovedTile in toRemoveTiles) {
        int xVal = [toBeRemovedTile x];
        int yVal = [toBeRemovedTile y];
        
        [spriteBatchNodeTiles removeChild:[toBeRemovedTile tileSprite] cleanup:YES];
        
        for (int y = yVal + 1; y < kPuzzleHeight; y++) {
            Tile *nextTile = [puzzleContents objectAtIndex:(y * kPuzzleHeight + xVal)];
            
            [nextTile drops];
            [puzzleContents replaceObjectAtIndex:[nextTile tileID] withObject:nextTile];
        }
        
        Tile *newTile = [self createRandomTileAtIndex:((kPuzzleHeight - 1) * kPuzzleHeight + xVal)
                                             withDrop:YES];
        
        [spriteBatchNodeTiles addChild:[newTile tileSprite] z:1];
        [puzzleContents replaceObjectAtIndex:[newTile tileID] withObject:newTile];
    }
    
    removedTiles = [toRemoveTiles count];
    [toRemoveTiles removeAllObjects];
}

// transmuting puzzle
-(void)transmutePuzzle:(ccTime)dt
{
    for (Tile *checkedTile in puzzleContents) {
        [[checkedTile tileSprite] setOpacity:255];
    }
    
    for (Tile *toBeRemovedTile in toRemoveTiles) {
        int xVal = [toBeRemovedTile x];
        int yVal = [toBeRemovedTile y];
        
        [spriteBatchNodeTiles removeChild:[toBeRemovedTile tileSprite] cleanup:YES];
        
        Tile *newTile;
        
        if (hasUsedFlute) {
            newTile = [[Tile alloc] initWithType:kTileGold withX:xVal withY:yVal withDrop:NO];
        }
        else {
            int random = arc4random_uniform(3);
            
            if (random == 0) {
                newTile = [[Tile alloc] initWithType:kTileSword withX:xVal withY:yVal withDrop:NO];
            }
            else if (random == 1) {
                newTile = [[Tile alloc] initWithType:kTileMagic withX:xVal withY:yVal withDrop:NO];
            }
            else {
                newTile = [[Tile alloc] initWithType:kTileHeart withX:xVal withY:yVal withDrop:NO];
            }
        }
        
        [spriteBatchNodeTiles addChild:[newTile tileSprite] z:1];
        [puzzleContents replaceObjectAtIndex:[newTile tileID] withObject:newTile];
    }
    
    removedTiles = [toRemoveTiles count];
    [toRemoveTiles removeAllObjects];
    
    if (hasUsedFlute) {
        hasUsedFlute = NO;
        [[GameCenterManager sharedGameCenterManager] sendFlute];
    }
}

// clears selection of to be removed tiles
-(void)resetsToBeRemovedTiles
{
    for (Tile *checkedTile in puzzleContents) {
        [[checkedTile tileSprite] setOpacity:255];
        [[checkedTile tileSprite] setScale:1];
    }
    
    [toRemoveTiles removeAllObjects];
}

#pragma mark - update schedulers

// updates battle
-(void)update:(ccTime)dt
{
    if ([[Player sharedPlayer] currentHP] == 0 ||
        enemyCurrentHP == 0) {
        
        self.isTouchEnabled = NO;
        menuButtons.isTouchEnabled = NO;
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn]) {
        wait_layer.visible = NO;
        
        if ([[GameCenterManager sharedGameCenterManager] opponentShieldTurns] == 0 ||
            [[GameCenterManager sharedGameCenterManager] opponentAleTurns] == 0 ||
            [[GameCenterManager sharedGameCenterManager] opponentRuneTurns] == 0 ||
            [[GameCenterManager sharedGameCenterManager] opponentMirrorTurns] == 0) {
            hasEnemyStatusChanged = YES;
        }
    }
    else if (![[GameCenterManager sharedGameCenterManager] isPlayersTurn]) {
        wait_layer.visible = YES;
    }
    
    if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
             [[GameCenterManager sharedGameCenterManager] opponentUsedShield]) {
        
        [[GameCenterManager sharedGameCenterManager] setOpponentUsedShield:NO];
        [self enemyUsedShield];
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
             [[GameCenterManager sharedGameCenterManager] opponentUsedPotion]) {
        
        enemyHeal = [[GameCenterManager sharedGameCenterManager] heal];
        
        [[GameCenterManager sharedGameCenterManager] setHeal:0];
        [[GameCenterManager sharedGameCenterManager] setOpponentUsedPotion:NO];
        [self enemyUsedPotion];
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
             [[GameCenterManager sharedGameCenterManager] opponentUsedBomb]) {
        
        enemyDamage = [[GameCenterManager sharedGameCenterManager] damage];
                
        [[GameCenterManager sharedGameCenterManager] setDamage:0];
        [[GameCenterManager sharedGameCenterManager] setOpponentUsedBomb:NO];
        [self enemyUsedBomb];
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
             [[GameCenterManager sharedGameCenterManager] opponentUsedAle]) {
        
        [[GameCenterManager sharedGameCenterManager] setOpponentUsedAle:NO];
        [self enemyUsedAle];
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
             [[GameCenterManager sharedGameCenterManager] opponentUsedRune]) {
        
        [[GameCenterManager sharedGameCenterManager] setOpponentUsedRune:NO];
        [self enemyUsedRune];
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
             [[GameCenterManager sharedGameCenterManager] opponentUsedMirror]) {
        
        [[GameCenterManager sharedGameCenterManager] setOpponentUsedMirror:NO];
        [self enemyUsedMirror];
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
             [[GameCenterManager sharedGameCenterManager] opponentUsedFlute]) {
        
        [[GameCenterManager sharedGameCenterManager] setOpponentUsedFlute:NO];
        [self enemyUsedFlute];
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
        [[GameCenterManager sharedGameCenterManager] damage] > 0) {
        
        enemyDamage = [[GameCenterManager sharedGameCenterManager] damage];
        
        [[GameCenterManager sharedGameCenterManager] setDamage:0];
        [self enemyAttack];
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
        [[GameCenterManager sharedGameCenterManager] heal] > 0) {
        
        enemyHeal = [[GameCenterManager sharedGameCenterManager] heal];
        
        [[GameCenterManager sharedGameCenterManager] setHeal:0];
        [self enemyHeal];
    }
    else if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn] &&
             [[GameCenterManager sharedGameCenterManager] opponentPickedUpCoins]) {
        
        [[GameCenterManager sharedGameCenterManager] setOpponentPickedUpCoins:NO];
        [self enemyPicksUpCoins];
    }
    
    [healthbar1 setScaleX:((float)[[Player sharedPlayer] currentHP] /
                           (float)[[Player sharedPlayer] maxHP])];
    
    if (hasPlayerStatusChanged) {
        hasPlayerStatusChanged = NO;
        [self removeChild:healthbar1 cleanup:YES];
        
        if ([[Player sharedPlayer] shieldTurns] > 0) {
            healthbar1 = [[CCSprite alloc] initWithSpriteFrameName:@"HealthbarShield.png"];
        }
        else {
            healthbar1 = [[CCSprite alloc] initWithSpriteFrameName:@"Healthbar.png"];
        }
        
        [healthbar1 setAnchorPoint:ccp(0, 0)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [healthbar1 setPosition:ccp(screenSize.width/2 - 159, screenSize.height/2 + 174)];
        }
        else {
            [healthbar1 setPosition:ccp(screenSize.width/2 - (159 * 2.4f), screenSize.height/2 + (174 * 2.133f))];
        }
        
        [healthbar1 setScaleX:((float)[[Player sharedPlayer] currentHP] /
                               (float)[[Player sharedPlayer] maxHP])];
        
        [self addChild:healthbar1 z:4 tag:2];
    }
    
    if (hasEnemyStatusChanged) {
        hasEnemyStatusChanged = NO;
        [self removeChild:healthbar2 cleanup:YES];
        
        if ([[GameCenterManager sharedGameCenterManager] opponentShieldTurns] > 0) {
            healthbar2 = [[CCSprite alloc] initWithSpriteFrameName:@"HealthbarShield.png"];
        }
        else {
            healthbar2 = [[CCSprite alloc] initWithSpriteFrameName:@"Healthbar.png"];
        }
        
        [healthbar2 setAnchorPoint:ccp(0, 0)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [healthbar2 setPosition:ccp(screenSize.width/2 + 159, screenSize.height/2 + 174)];
        }
        else {
            [healthbar2 setPosition:ccp(screenSize.width/2 + (159 * 2.4f), screenSize.height/2 + (174 * 2.133f))];
        }
        
        if (enemyCurrentHP == 0) [healthbar2 setScaleX:0];
        else if ((float)enemyCurrentHP / enemyMaxHP <= 0.05f) [healthbar2 setScaleX:-0.05f];
        else [healthbar2 setScaleX:-((float)enemyCurrentHP / (float)enemyMaxHP)];
        
        [self addChild:healthbar2 z:4 tag:3];
    }
    
    if ((float)[[Player sharedPlayer] currentHP] / (float)[[Player sharedPlayer] maxHP] <= 0.2f) {
        if (lowHealthTexture_dt == 90) {
            lowHealthTexture_dt = 0;
        }
        else if (lowHealthTexture_dt < 20) {
            if (healthbar1.visible) healthbar1.visible = NO;
            lowHealthTexture_dt++;
        }
        else if (lowHealthTexture_dt >= 20) {
            if (!healthbar1.visible) healthbar1.visible = YES;
            lowHealthTexture_dt++;
        }
    }
    else {
        if (!healthbar1.visible) healthbar1.visible = YES;
        if (lowHealthTexture_dt != 0) lowHealthTexture_dt = 0;
    }
    
    [expbar setScaleX:(float)(([[Player sharedPlayer] level] * 10) - [[Player sharedPlayer] requiredExperience]) /
     (float)([[Player sharedPlayer] level] * 10)];
    
    [energybar setScaleX:((float)[[Player sharedPlayer] energy] / (float)18)];
    
    if ([[Player sharedPlayer] energy] == 18) [energybarFull setScaleX:1.0f];
    else if ([[Player sharedPlayer] energy] >= 12) [energybarFull setScaleX:12.0f / 18.0f];
    else if ([[Player sharedPlayer] energy] >= 6) [energybarFull setScaleX:6.0f / 18.0f];
    else [energybarFull setScaleX:0.0f];
    
    if (shouldEnergyGlow) {
        energybarFull.opacity += 5.0f;
        
        if (energybarFull.opacity >= 245.0f) shouldEnergyGlow = NO;
    }
    else {
        energybarFull.opacity -= 5.0f;
        
        if (energybarFull.opacity <= 80.0f) shouldEnergyGlow = YES;
    }
    
    if (enemyCurrentHP == 0) [healthbar2 setScaleX:0];
    else if ((float)enemyCurrentHP / enemyMaxHP <= 0.05f) [healthbar2 setScaleX:-0.05f];
    else [healthbar2 setScaleX:-((float)enemyCurrentHP / (float)enemyMaxHP)];
    
    [labelPlayerHPVal setString:[NSString stringWithFormat:@"%d/%d",
                                 [[Player sharedPlayer] currentHP],
                                 [[Player sharedPlayer] maxHP]]];
    
    [labelEnemyHPVal setString:[NSString stringWithFormat:@"%d/%d", enemyCurrentHP, enemyMaxHP]];
    
    [self updateInterface];
    
    if (!hasUsedBomb || !hasUsedFlute) [self updateBattleLines];
    
    if ([toRemoveTiles count] > 0) {
        [self updateTouchedMsg];
    }
    else {
        if (touchValueIsActive) {
            [self removeChild:labelTouchValue cleanup:YES];
            touchValueIsActive = NO;
        }
    }
    
    if (!hasPaused) [self updateBattleSound];
}

// scheduler for the time
-(void)timeSchedule:(ccTime)dt
{
    [labelTime setString:[formatter stringFromDate:[NSDate date]]];
}

// updates the interface
-(void)updateInterface
{
    if ([[Player sharedPlayer] energy] >= 6) {
        [itemBtn1 setIsEnabled:YES];
        [itemBtn2 setIsEnabled:YES];
        [itemBtn3 setIsEnabled:YES];
    }
    else {
        [itemBtn1 setIsEnabled:NO];
        [itemBtn2 setIsEnabled:NO];
        [itemBtn3 setIsEnabled:NO];
    }
    
    if ([[Player sharedPlayer] mirrorTurns] > 0) {
        [labelPlayerStatusVal setString:NSLocalizedString(@"BattleStatus05", nil)];
        [labelPlayerStatusVal setColor:ccc3(142, 56, 142)];
    }
    else if ([[Player sharedPlayer] runeTurns] > 0) {
        [labelPlayerStatusVal setString:NSLocalizedString(@"BattleStatus04", nil)];
        [labelPlayerStatusVal setColor:ccc3(220, 20, 60)];
    }
    else if ([[Player sharedPlayer] aleTurns] > 0) {
        [labelPlayerStatusVal setString:NSLocalizedString(@"BattleStatus03", nil)];
        [labelPlayerStatusVal setColor:ccc3(139, 117, 0)];
    }
    else if ([[Player sharedPlayer] shieldTurns] > 0) {
        [labelPlayerStatusVal setString:NSLocalizedString(@"BattleStatus02", nil)];
        [labelPlayerStatusVal setColor:ccc3(0, 104, 139)];
    }
    else {
        [labelPlayerStatusVal setString:NSLocalizedString(@"BattleStatus01", nil)];
        [labelPlayerStatusVal setColor:ccBLACK];
    }
    
    if ([[GameCenterManager sharedGameCenterManager] opponentMirrorTurns] > 0) {
        [labelEnemyStatusVal setString:NSLocalizedString(@"BattleStatus05", nil)];
        [labelEnemyStatusVal setColor:ccc3(255, 182, 18)];
    }
    else if ([[GameCenterManager sharedGameCenterManager] opponentRuneTurns] > 0) {
        [labelEnemyStatusVal setString:NSLocalizedString(@"BattleStatus04", nil)];
        [labelEnemyStatusVal setColor:ccc3(255, 182, 18)];
    }
    else if ([[GameCenterManager sharedGameCenterManager] opponentAleTurns] > 0) {
        [labelEnemyStatusVal setString:NSLocalizedString(@"BattleStatus03", nil)];
        [labelEnemyStatusVal setColor:ccc3(255, 182, 18)];
    }
    else if ([[GameCenterManager sharedGameCenterManager] opponentShieldTurns] > 0) {
        [labelEnemyStatusVal setString:NSLocalizedString(@"BattleStatus02", nil)];
        [labelEnemyStatusVal setColor:ccc3(0, 104, 139)];
    }
    else {
        [labelEnemyStatusVal setString:NSLocalizedString(@"BattleStatus01", nil)];
        [labelEnemyStatusVal setColor:ccBLACK];
    }
}

// updates the msg when player touches a tile
-(void)updateTouchedMsg
{
    if (tileChanged) {
        if (touchValueIsActive) {
            [self removeChild:labelTouchValue cleanup:YES];
            touchValueIsActive = NO;
        }
        
        int value = 0;
        
        if ([(Tile*)[toRemoveTiles lastObject] tileType] == kTileSword) {
            value = [[Player sharedPlayer] base_physical_damage];
            value += (int)(([[Player sharedPlayer] base_physical_damage] * 0.2 * [toRemoveTiles count])
                           + ([[Player sharedPlayer] weapon] * [toRemoveTiles count]));
            
            if ([[Player sharedPlayer] aleTurns] > 0) {
                if (shieldRank == 3) value += (int)(value * 0.5);
                else if (shieldRank == 2) value += (int)(value * 0.4);
                else value += (int)(value * 0.2);
            }
            
            value -= (int)(playerDamage * [[GameCenterManager sharedGameCenterManager]
                                           opponentDamage_reduction] / 100);
            
            if ([[GameCenterManager sharedGameCenterManager] opponentShieldTurns] > 0) {
                if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 2) {
                    if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                        value = (int)(value * 0.5);
                    }
                    else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                        value = (int)(value * 0.7);
                    }
                    else {
                        value = (int)(value * 0.9);
                    }
                }
                else if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 1) {
                    if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                        value = (int)(value * 0.3);
                    }
                    else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                        value = (int)(value * 0.5);
                    }
                    else {
                        value = (int)(value * 0.7);
                    }
                }
            }
            
            labelTouchValue = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"TouchDmg", nil),
                                                        value]
                                              fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        }
        else if ([(Tile*)[toRemoveTiles lastObject] tileType] == kTileMagic) {
            int magicType1 = 0;
            int magicType2 = 0;
            
            for (Tile *toBeRemovedTile in toRemoveTiles) {
                if ([toBeRemovedTile tileNum] == 1) magicType1++;
                else magicType2++;
            }
            
            value = [[Player sharedPlayer] base_magical_damage];
            value += (int)(([[Player sharedPlayer] base_magical_damage] * 0.2 * [toRemoveTiles count])
                           + ([[Player sharedPlayer] spellbook] * [toRemoveTiles count]));
            
            if ([[Player sharedPlayer] classVal] == 3 && magicType1 >= 3 && magicType2 >= 3) {
                value = (int)(value * 1.4f);
            }
            else if (magicType1 >= 2 && magicType2 >= 2) {
                value = (int)(value * 1.2f);
            }
            
            if ([[Player sharedPlayer] aleTurns] > 0) {
                if (shieldRank == 3) value += (int)(value * 0.5);
                else if (shieldRank == 2) value += (int)(value * 0.4);
                else value += (int)(value * 0.2);
            }
            
            value -= (int)(playerDamage * [[GameCenterManager sharedGameCenterManager]
                                           opponentDamage_reduction] / 100);
            
            if ([[GameCenterManager sharedGameCenterManager] opponentShieldTurns] > 0) {
                if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 2) {
                    if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                        value = (int)(value * 0.5);
                    }
                    else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                        value = (int)(value * 0.7);
                    }
                    else {
                        value = (int)(value * 0.9);
                    }
                }
                else if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 1) {
                    if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                        value = (int)(value * 0.3);
                    }
                    else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                        value = (int)(value * 0.5);
                    }
                    else {
                        value = (int)(value * 0.7);
                    }
                }
            }
            
            labelTouchValue = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"TouchDmg", nil),
                                                        value]
                                              fontName:@"Marker Felt" fontSize:[Utility getFontSize:32]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        }
        else if ([(Tile*)[toRemoveTiles lastObject] tileType] == kTileHeart) {
            value = (int)([[Player sharedPlayer] maxHP] * (10 * [toRemoveTiles count]) / 100);
            
            if ([[Player sharedPlayer] currentHP] == [[Player sharedPlayer] maxHP]) {
                value = 0;
            }
            else if (value + [[Player sharedPlayer] currentHP] > [[Player sharedPlayer] maxHP]) {
                value = [[Player sharedPlayer] maxHP] - [[Player sharedPlayer] currentHP];
            }
            
            labelTouchValue = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"TouchLife", nil),
                                                        value]
                                              fontName:@"Marker Felt" fontSize:[Utility getFontSize:32]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        }
        else if ([(Tile*)[toRemoveTiles lastObject] tileType] == kTileGold) {
            value = [toRemoveTiles count] * 5;
                        
            labelTouchValue = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"TouchGold", nil),
                                                        value]
                                              fontName:@"Marker Felt" fontSize:[Utility getFontSize:32]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
        }
        else {
            labelTouchValue = [Utility labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:32]
                                                 color:ccWHITE strokeSize:0 stokeColor:ccBLACK];
        }
        
        [self addChild:labelTouchValue z:12 tag:15];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (touchLocation.x + labelTouchValue.boundingBox.size.width/2 > screenSize.width - 10 &&
            touchLocation.y + labelTouchValue.boundingBox.size.height/2 + 80 > screenSize.height - 10) {
            [labelTouchValue setPosition:ccp(screenSize.width - labelTouchValue.boundingBox.size.width/2 - 10,
                                             screenSize.height - labelTouchValue.boundingBox.size.width/2 + 10)];
        }
        else if (touchLocation.x - labelTouchValue.boundingBox.size.width/2 < 10 &&
                 touchLocation.y + labelTouchValue.boundingBox.size.height/2 + 80 > screenSize.height - 10) {
            [labelTouchValue setPosition:ccp(labelTouchValue.boundingBox.size.width/2 + 10,
                                             screenSize.height - labelTouchValue.boundingBox.size.width/2 + 10)];
        }
        else if (touchLocation.x + labelTouchValue.boundingBox.size.width/2 > screenSize.width - 10) {
            [labelTouchValue setPosition:ccp(screenSize.width - labelTouchValue.boundingBox.size.width/2 - 10,
                                             touchLocation.y + 80)];
        }
        else if (touchLocation.x - labelTouchValue.boundingBox.size.width/2 < 10) {
            [labelTouchValue setPosition:ccp(labelTouchValue.boundingBox.size.width/2 + 10,
                                             touchLocation.y + 80)];
        }
        else if (touchLocation.y + labelTouchValue.boundingBox.size.height/2 + 80 > screenSize.height - 10) {
            [labelTouchValue setPosition:ccp(touchLocation.x,
                                             screenSize.height - labelTouchValue.boundingBox.size.width/2 + 10)];
        }
        else {
            [labelTouchValue setPosition:ccp(touchLocation.x, touchLocation.y + 80)];
        }
    }
    else {
        if (touchLocation.x + labelTouchValue.boundingBox.size.width/2 > screenSize.width - (10 * 2.4f) &&
            touchLocation.y + labelTouchValue.boundingBox.size.height/2 + (80 * 2.133f) >
            screenSize.height - (10 * 2.133f)) {
            [labelTouchValue setPosition:ccp(screenSize.width - labelTouchValue.boundingBox.size.width/2 - (10 * 2.4f),
                                             screenSize.height - labelTouchValue.boundingBox.size.width/2 + (10 * 2.133f))];
        }
        else if (touchLocation.x - labelTouchValue.boundingBox.size.width/2 < (10 * 2.4f) &&
                 touchLocation.y + labelTouchValue.boundingBox.size.height/2 + (80 * 2.133f) >
                 screenSize.height - (10 * 2.133f)) {
            [labelTouchValue setPosition:ccp(labelTouchValue.boundingBox.size.width/2 + (10 * 2.4f),
                                             screenSize.height - labelTouchValue.boundingBox.size.width/2 + (10 * 2.133f))];
        }
        else if (touchLocation.x + labelTouchValue.boundingBox.size.width/2 > screenSize.width - (10 * 2.4f)) {
            [labelTouchValue setPosition:ccp(screenSize.width - labelTouchValue.boundingBox.size.width/2 - (10 * 2.4f),
                                             touchLocation.y + (80 * 2.133f))];
        }
        else if (touchLocation.x - labelTouchValue.boundingBox.size.width/2 < (10 * 2.4f)) {
            [labelTouchValue setPosition:ccp(labelTouchValue.boundingBox.size.width/2 + (10 * 2.4f),
                                             touchLocation.y + (80 * 2.133f))];
        }
        else if (touchLocation.y + labelTouchValue.boundingBox.size.height/2 + (80 * 2.133f) >
                 screenSize.height - (10 * 2.133f)) {
            [labelTouchValue setPosition:ccp(touchLocation.x,
                                             screenSize.height - labelTouchValue.boundingBox.size.width/2 + (10 * 2.133f))];
        }
        else {
            [labelTouchValue setPosition:ccp(touchLocation.x, touchLocation.y + (80 * 2.133f))];
        }
    }
    
    tileChanged = NO;
    touchValueIsActive = YES;
}

// updates battle lines
-(void)updateBattleLines
{
    if (toRemoveTiles.count > 0 && numOfBattleLines != toRemoveTiles.count - 1) {
        
        if (numOfBattleLines > 0) {
            [battleLines removeAllObjects];
            [spriteBatchNodeLines removeAllChildrenWithCleanup:YES];
            
            numOfBattleLines = 0;
        }
        
        for (int i = 0; i < [toRemoveTiles count] - 1; i++) {
            CGPoint start = ccp([[(Tile*)[toRemoveTiles objectAtIndex:i] tileSprite] position].x,
                                [[(Tile*)[toRemoveTiles objectAtIndex:i] tileSprite] position].y);
            
            CGPoint end = ccp([[(Tile*)[toRemoveTiles objectAtIndex:i + 1] tileSprite] position].x,
                              [[(Tile*)[toRemoveTiles objectAtIndex:i + 1] tileSprite] position].y);
            
            BattleLine *line = [[BattleLine alloc] initWithStart:start
                                                         withEnd:end];
            
            [spriteBatchNodeLines addChild:line.lineSprite z:1];
            [battleLines addObject:line];
            
            numOfBattleLines++;
        }
    }
    else if (toRemoveTiles.count == 0 && numOfBattleLines > 0) {
        [battleLines removeAllObjects];
        [spriteBatchNodeLines removeAllChildrenWithCleanup:YES];
        
        numOfBattleLines = 0;
    }
}

// updates battle sounds
-(void)updateBattleSound
{
    if (itemPauseBtn.isSelected || itemBtn1.isSelected ||
        itemBtn2.isSelected || itemBtn3.isSelected) {
                
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemPauseBtn.isSelected && !itemBtn1.isSelected &&
             !itemBtn2.isSelected && !itemBtn3.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - battle events

// progresses battle
-(void)progressBattle
{
    tileTouchesAllowed = NO;
    menuButtons.isTouchEnabled = NO;
    
    TileType type = [[toRemoveTiles lastObject] tileType];
        
    if (type == kTileSword) {
        if ([[Player sharedPlayer] classVal] == 5) {
            coins += [toRemoveTiles count];
        }
        
        [self animatePlayerMoves];
        
        [self scheduleOnce:@selector(rebuildsPuzzle:) delay:0.0f];
        [self scheduleOnce:@selector(attackPhysical:) delay:0.6f];
    }
    else if (type == kTileMagic) {
        tileMagicType1 = 0;
        tileMagicType2 = 0;
        
        for (Tile *toBeRemovedTile in toRemoveTiles) {
            if ([toBeRemovedTile tileNum] == 1) tileMagicType1++;
            else tileMagicType2++;
        }
        
        [self animatePlayerMoves];
        
        [self scheduleOnce:@selector(rebuildsPuzzle:) delay:0.0f];
        [self scheduleOnce:@selector(attackMagic:) delay:0.6f];
    }
    else if (type == kTileHeart) {
        [self animatePlayerMoves];
        
        [self scheduleOnce:@selector(rebuildsPuzzle:) delay:0.0f];
        [self scheduleOnce:@selector(playerHeals:) delay:0.6f];
    }
    else if (type == kTileGold) {
        [self animatePlayerMoves];
        
        [self scheduleOnce:@selector(rebuildsPuzzle:) delay:0.0f];
        [self scheduleOnce:@selector(playerGathersCoins:) delay:0.6f];
    }
}

// animates player moves
-(void)animatePlayerMoves
{
    float finalPosW;
    float finalPosH;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([[toRemoveTiles lastObject] tileType] == kTileSword ||
            [[toRemoveTiles lastObject] tileType] == kTileMagic) {
            
            finalPosW = screenSize.width/2 + 104;
            finalPosH = screenSize.height/2 + 192;
        }
        else if ([[toRemoveTiles lastObject] tileType] == kTileHeart) {
            finalPosW = screenSize.width/2 - 104;
            finalPosH = screenSize.height/2 + 192;
        }
        else if ([[toRemoveTiles lastObject] tileType] == kTileGold) {
            finalPosW = screenSize.width/2 + 104;
            finalPosH = screenSize.height/2 - 192;
        }
    }
    else {
        if ([[toRemoveTiles lastObject] tileType] == kTileSword ||
            [[toRemoveTiles lastObject] tileType] == kTileMagic) {
            
            finalPosW = screenSize.width/2 + (104 * 2.4f);
            finalPosH = screenSize.height/2 + (192 * 2.133f);
        }
        else if ([[toRemoveTiles lastObject] tileType] == kTileHeart) {
            finalPosW = screenSize.width/2 - (104 * 2.4f);
            finalPosH = screenSize.height/2 + (192 * 2.133f);
        }
        else if ([[toRemoveTiles lastObject] tileType] == kTileGold) {
            finalPosW = screenSize.width/2 + (104 * 2.4f);
            finalPosH = screenSize.height/2 - (192 * 2.133f);
        }
    }
    
    for (Tile *toBeRemovedTile in toRemoveTiles) {
        CCSprite *sprite = [toBeRemovedTile copySprite];
        
        [spriteBatchNodeAnimatedTiles addChild:sprite z:1];
        
        id action = [CCSpawn actions:
                     [CCScaleTo actionWithDuration:0.6f scale:0.7f],
                     [CCFadeOut actionWithDuration:0.5f],
                     [CCEaseSineOut actionWithAction:
                      [CCMoveTo actionWithDuration:0.6f
                                          position:ccp(finalPosW, finalPosH)]],
                     nil];
        
        [sprite runAction:action];
    }
}

// checks if player won or lost the battle
-(void)checkBattleOutcome
{
    if (enemyCurrentHP <= 0) {
        enemyCurrentHP = 0;
        
        if ([[Player sharedPlayer] classVal] == 1) coins += (int)(coins * 15 / 100);
        
        coins += (int)(coins * [[Player sharedPlayer] extra_gold_percentage] / 100);
        
        if ([[GameManager sharedGameManager] isDoubleCoin]) coins += coins;
        
        [[GameManager sharedGameManager] writeGatheredGold:coins];
    }
    
    if ([[Player sharedPlayer] currentHP] <= 0) {
        [[Player sharedPlayer] setCurrentHP:0];
        
        if ([[Player sharedPlayer] classVal] == 1) coins += (int)(coins * 15 / 100);
        
        coins += (int)(coins * [[Player sharedPlayer] extra_gold_percentage] / 100);
        
        if ([[GameManager sharedGameManager] isDoubleCoin]) coins += coins;
        
        [[GameManager sharedGameManager] writeGatheredGold:coins];
        [[GameCenterManager sharedGameCenterManager] sendGameOver];
    }
}

// cleans battle msg layer
-(void)cleanLayer:(ccTime)dt
{
    [self removeChild:events_layer cleanup:YES];
}

#pragma mark - player events

// attacks with physical damage
-(void)attackPhysical:(ccTime)dt
{
    BOOL critical;
    playerDamage = [[Player sharedPlayer] physicalAttack:removedTiles
                                            withCritical:&critical];
    
    if ([[Player sharedPlayer] aleTurns] > 0) {
        if (aleRank == 3) playerDamage += (int)(playerDamage * 0.5);
        else if (aleRank == 2) playerDamage += (int)(playerDamage * 0.4);
        else playerDamage += (int)(playerDamage * 0.2);
    }
    
    if ([[Player sharedPlayer] runeTurns] > 0) {
        int crit_chance;
        
        if (runeRank == 3) crit_chance = 80;
        else if (runeRank == 2) crit_chance = 50;
        else crit_chance = 20;
        
        if (arc4random_uniform(100) < crit_chance) {
            playerDamage = (int)(playerDamage * 1.5f);
        }
    }
    
    playerDamage -= (int)(playerDamage * [[GameCenterManager sharedGameCenterManager]
                                          opponentDamage_reduction] / 100);
    
    if ([[GameCenterManager sharedGameCenterManager] opponentShieldTurns] > 0) {
        if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 2) {
            if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                playerDamage = (int)(playerDamage * 0.5);
            }
            else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                playerDamage = (int)(playerDamage * 0.7);
            }
            else {
                playerDamage = (int)(playerDamage * 0.9);
            }
        }
        else if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 1) {
            if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                playerDamage = (int)(playerDamage * 0.3);
            }
            else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                playerDamage = (int)(playerDamage * 0.5);
            }
            else {
                playerDamage = (int)(playerDamage * 0.7);
            }
        }
    }
    
    [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
    [self scheduleOnce:@selector(enemyGetsDamaged:) delay:0.0f];
    [[SoundManager sharedSoundManager] playSwordHitEffect];
}

// attacks with magic damage
-(void)attackMagic:(ccTime)dt
{
    int combo = 0;
    playerDamage = [[Player sharedPlayer] magicalAttack:removedTiles
                                         withMagicType1:tileMagicType1
                                         withMagicType2:tileMagicType2
                                              withCombo:&combo];
    
    if ([[Player sharedPlayer] aleTurns] > 0) {
        if (aleRank == 3) playerDamage += (int)(playerDamage * 0.5);
        else if (aleRank == 2) playerDamage += (int)(playerDamage * 0.4);
        else playerDamage += (int)(playerDamage * 0.2);
    }
    
    if ([[Player sharedPlayer] runeTurns] > 0) {
        int crit_chance;
        
        if (runeRank == 3) crit_chance = 80;
        else if (runeRank == 2) crit_chance = 50;
        else crit_chance = 20;
        
        if (arc4random_uniform(100) < crit_chance) {
            playerDamage = (int)(playerDamage * 1.5f);
        }
    }
    
    playerDamage -= (int)(playerDamage * [[GameCenterManager sharedGameCenterManager]
                                          opponentDamage_reduction] / 100);
    
    if ([[GameCenterManager sharedGameCenterManager] opponentShieldTurns] > 0) {
        if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 2) {
            if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                playerDamage = (int)(playerDamage * 0.5);
            }
            else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                playerDamage = (int)(playerDamage * 0.7);
            }
            else {
                playerDamage = (int)(playerDamage * 0.9);
            }
        }
        else if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 1) {
            if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                playerDamage = (int)(playerDamage * 0.3);
            }
            else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                playerDamage = (int)(playerDamage * 0.5);
            }
            else {
                playerDamage = (int)(playerDamage * 0.7);
            }
        }
    }
    
    [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
    [self scheduleOnce:@selector(enemyGetsDamaged:) delay:0.0f];
    [[SoundManager sharedSoundManager] playMagicHitEffect];
}

// player heals
-(void)playerHeals:(ccTime)dt
{
    playerHealing = (int)([[Player sharedPlayer] maxHP] * (10 * removedTiles) / 100);
    
    if (arc4random_uniform(100) < [[Player sharedPlayer] critical_heal_percentage]) {
        playerHealing = playerHealing * 2;
    }
    
    if ([[Player sharedPlayer] runeTurns] > 0) {
        int crit_chance;
        
        if (runeRank == 3) crit_chance = 80;
        else if (runeRank == 2) crit_chance = 50;
        else crit_chance = 20;
        
        if (arc4random_uniform(100) < crit_chance) {
            playerHealing = (int)(playerHealing * 1.5f);
        }
    }
    
    [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] + playerHealing];
    
    if ([[Player sharedPlayer] currentHP] > [[Player sharedPlayer] maxHP]) {
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] maxHP]];
    }
    
    [[GameCenterManager sharedGameCenterManager] sendHeal:playerHealing];
    
    [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
    [[SoundManager sharedSoundManager] playHeartEffect];
}

// player gathers coins
-(void)playerGathersCoins:(ccTime)dt
{
    coins += removedTiles * 5;
    
    if ([[Player sharedPlayer] classVal] == 4 &&
        arc4random_uniform(100) < 50) {
        
        playerHealing = (int)([[Player sharedPlayer] maxHP] * (5 * removedTiles) / 100);
        
        if (arc4random_uniform(100) < [[Player sharedPlayer] critical_heal_percentage]) {
            playerHealing = playerHealing * 2;
        }
        
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] + playerHealing];
        
        if ([[Player sharedPlayer] currentHP] > [[Player sharedPlayer] maxHP]) {
            [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] maxHP]];
        }
        
        [[GameCenterManager sharedGameCenterManager] sendHeal:playerHealing];
    }
    else {
        [[GameCenterManager sharedGameCenterManager] sendPass];
    }
    
    [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
    [[SoundManager sharedSoundManager] playCoinPickedUpEffect];
}

// uses item button 1
-(void)useItemBtn1
{
    [itemBtn1 setIsEnabled:NO];
    
    if ([[GameManager sharedGameManager] itemSlot1] == 1) [self useItemShield];
    else if ([[GameManager sharedGameManager] itemSlot1] == 2) [self useItemPotion];
    else if ([[GameManager sharedGameManager] itemSlot1] == 3) [self useItemBomb];
    else if ([[GameManager sharedGameManager] itemSlot1] == 4) [self useItemAle];
    else if ([[GameManager sharedGameManager] itemSlot1] == 5) [self useItemRune];
    else if ([[GameManager sharedGameManager] itemSlot1] == 6) [self useItemMirror];
    else if ([[GameManager sharedGameManager] itemSlot1] == 7) [self useItemFlute];
}

// uses item button 2
-(void)useItemBtn2
{
    [itemBtn2 setIsEnabled:NO];
    
    if ([[GameManager sharedGameManager] itemSlot2] == 1) [self useItemShield];
    else if ([[GameManager sharedGameManager] itemSlot2] == 2) [self useItemPotion];
    else if ([[GameManager sharedGameManager] itemSlot2] == 3) [self useItemBomb];
    else if ([[GameManager sharedGameManager] itemSlot2] == 4) [self useItemAle];
    else if ([[GameManager sharedGameManager] itemSlot2] == 5) [self useItemRune];
    else if ([[GameManager sharedGameManager] itemSlot2] == 6) [self useItemMirror];
    else if ([[GameManager sharedGameManager] itemSlot2] == 7) [self useItemFlute];
}

// uses item button 3
-(void)useItemBtn3
{
    [itemBtn3 setIsEnabled:NO];
    
    if ([[GameManager sharedGameManager] itemSlot3] == 1) [self useItemShield];
    else if ([[GameManager sharedGameManager] itemSlot3] == 2) [self useItemPotion];
    else if ([[GameManager sharedGameManager] itemSlot3] == 3) [self useItemBomb];
    else if ([[GameManager sharedGameManager] itemSlot3] == 4) [self useItemAle];
    else if ([[GameManager sharedGameManager] itemSlot3] == 5) [self useItemRune];
    else if ([[GameManager sharedGameManager] itemSlot3] == 6) [self useItemMirror];
    else if ([[GameManager sharedGameManager] itemSlot3] == 7) [self useItemFlute];
}

// uses the shield item
-(void)useItemShield
{
    tileTouchesAllowed = NO;
    menuButtons.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    if ([[Player sharedPlayer] classVal] == 2) [[Player sharedPlayer] setShieldTurns:5];
    else [[Player sharedPlayer] setShieldTurns:3];
    
    if ([[Player sharedPlayer] energy] == 18) {
        shieldRank = 3;
                
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 18];
    }
    else if ([[Player sharedPlayer] energy] >= 12) {
        shieldRank = 2;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 12];
    }
    else {
        shieldRank = 1;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
    }
    
    if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
    
    hasPlayerStatusChanged = YES;
    
    [[SoundManager sharedSoundManager] playShieldEffect];
    
    [[GameCenterManager sharedGameCenterManager] sendShield:shieldRank];
}

// uses the potion item
-(void)useItemPotion
{
    tileTouchesAllowed = NO;
    menuButtons.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    if ([[Player sharedPlayer] energy] == 18) {
        playerHealing = [[Player sharedPlayer] maxHP];
                
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 18];
    }
    else if ([[Player sharedPlayer] energy] >= 12) {
        playerHealing = (int)([[Player sharedPlayer] maxHP] * 0.75);
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 12];
    }
    else {
        playerHealing = (int)([[Player sharedPlayer] maxHP] * 0.5);
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
    }
    
    if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
        
    [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] + playerHealing];
    
    if ([[Player sharedPlayer] currentHP] > [[Player sharedPlayer] maxHP]) {
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] maxHP]];
    }
    
    [[SoundManager sharedSoundManager] playPotionEffect];
    
    [[GameCenterManager sharedGameCenterManager] sendPotion:playerHealing];
}

// uses the bomb item
-(void)useItemBomb
{
    tileTouchesAllowed = NO;
    menuButtons.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    hasUsedBomb = YES;
    
    for (Tile *tile in puzzleContents) [toRemoveTiles addObject:tile];
    
    if ([[Player sharedPlayer] energy] == 18) {
        playerDamage = (int)(enemyMaxHP * 0.75);
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 18];
    }
    else if ([[Player sharedPlayer] energy] >= 12) {
        playerDamage = (int)(enemyMaxHP * 0.5);
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 12];
    }
    else {
        playerDamage = (int)(enemyMaxHP * 0.25);
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
    }
    
    if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
    
    if ([[Player sharedPlayer] classVal] == 8) {
        playerDamage += (int)(enemyMaxHP * 0.20);
    }
    
    if ([[GameCenterManager sharedGameCenterManager] opponentShieldTurns] > 0) {
        if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 2) {
            if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                playerDamage = (int)(playerDamage * 0.5);
            }
            else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                playerDamage = (int)(playerDamage * 0.7);
            }
            else {
                playerDamage = (int)(playerDamage * 0.9);
            }
        }
        else if ([[GameCenterManager sharedGameCenterManager] opponentShield] == 1) {
            if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 3) {
                playerDamage = (int)(playerDamage * 0.3);
            }
            else if ([[GameCenterManager sharedGameCenterManager] opponentShieldRank] == 2) {
                playerDamage = (int)(playerDamage * 0.5);
            }
            else {
                playerDamage = (int)(playerDamage * 0.7);
            }
        }
    }
    
    [[SoundManager sharedSoundManager] playBombEffect];
    
    [self scheduleOnce:@selector(transmutePuzzle:) delay:0.0f];
    [self scheduleOnce:@selector(enemyGetsDamaged:) delay:0.0f];
}

// uses the ale item
-(void)useItemAle
{
    tileTouchesAllowed = NO;
    menuButtons.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    [[Player sharedPlayer] setAleTurns:3];
    
    if ([[Player sharedPlayer] energy] == 18) {
        aleRank = 3;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 18];
    }
    else if ([[Player sharedPlayer] energy] >= 12) {
        aleRank = 2;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 12];
    }
    else {
        aleRank = 1;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
    }
    
    if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
    
    hasPlayerStatusChanged = YES;
    
    [[SoundManager sharedSoundManager] playPotionEffect];
    
    [[GameCenterManager sharedGameCenterManager] sendAle];
}

// uses the rune item
-(void)useItemRune
{
    tileTouchesAllowed = NO;
    menuButtons.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    [[Player sharedPlayer] setRuneTurns:3];
    
    if ([[Player sharedPlayer] energy] == 18) {
        runeRank = 3;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 18];
    }
    else if ([[Player sharedPlayer] energy] >= 12) {
        runeRank = 2;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 12];
    }
    else {
        runeRank = 1;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
    }
    
    if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
    
    hasPlayerStatusChanged = YES;
    
    [[SoundManager sharedSoundManager] playShieldEffect];
    
    [[GameCenterManager sharedGameCenterManager] sendRune];
}

// uses the mirror item
-(void)useItemMirror
{
    tileTouchesAllowed = NO;
    menuButtons.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    [[Player sharedPlayer] setMirrorTurns:3];
    
    if ([[Player sharedPlayer] energy] == 18) {
        mirrorRank = 3;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 18];
    }
    else if ([[Player sharedPlayer] energy] >= 12) {
        mirrorRank = 2;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 12];
    }
    else {
        mirrorRank = 1;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
    }
    
    if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
    
    hasPlayerStatusChanged = YES;
    
    [[SoundManager sharedSoundManager] playMagicHitEffect];
    
    [[GameCenterManager sharedGameCenterManager] sendMirror:mirrorRank];
}

// uses the flute item
-(void)useItemFlute
{
    tileTouchesAllowed = NO;
    menuButtons.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    for (Tile *tile in puzzleContents) [toRemoveTiles addObject:tile];
    
    hasUsedFlute = YES;
    
    [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
    
    if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
    
    [[SoundManager sharedSoundManager] playVictoryEffect];
    
    [self scheduleOnce:@selector(transmutePuzzle:) delay:0.0f];
}

// enemy gets damaged and UI is updated
-(void)enemyGetsDamaged:(ccTime)dt
{
    enemyCurrentHP = enemyCurrentHP - playerDamage;
    
    if ([[GameCenterManager sharedGameCenterManager] opponentMirrorTurns] > 0) {
        int reflected_dmg = 1;
        
        if ([[GameCenterManager sharedGameCenterManager] opponentMirrorRank] == 3) {
            reflected_dmg += (int)(playerDamage * 0.3);
        }
        else if ([[GameCenterManager sharedGameCenterManager] opponentMirrorRank] == 2) {
            reflected_dmg += (int)(playerDamage * 0.2);
        }
        else {
            reflected_dmg += (int)(playerDamage * 0.1);
        }
        
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] - reflected_dmg];
        if ([[Player sharedPlayer] currentHP] <= 0) [[Player sharedPlayer] setCurrentHP:1];
    }
    
    if (hasUsedBomb) {
        hasUsedBomb = NO;
        [[GameCenterManager sharedGameCenterManager] sendBomb:playerDamage];
    }
    else {
        [[GameCenterManager sharedGameCenterManager] sendDamage:playerDamage];
    }
    
    [self checkBattleOutcome];
}

#pragma mark - enemy events

// enemy attacks the player
-(void)enemyAttack
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    if ([[Player sharedPlayer] mirrorTurns] > 0) {
        int reflected_dmg = 1;
        
        if (mirrorRank == 3) reflected_dmg += (int)(enemyDamage * 0.3);
        else if (mirrorRank == 2) reflected_dmg += (int)(enemyDamage * 0.2);
        else reflected_dmg += (int)(enemyDamage * 0.1);
        
        enemyCurrentHP = enemyCurrentHP - reflected_dmg;
        if (enemyCurrentHP <= 0) enemyCurrentHP = 1;
    }
        
    events_layer = [[ArenaEventsLayer alloc] initWithEnemyDamage:enemyDamage];
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(cleanLayer:) delay:0.8f];
    [self scheduleOnce:@selector(playerGetsDamaged:) delay:0.8f];
}

// player gets damaged and UI is updated
-(void)playerGetsDamaged:(ccTime)dt
{    
    [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] - enemyDamage];
    
    if ([[Player sharedPlayer] shieldTurns] > 0) {
        [[Player sharedPlayer] setShieldTurns:[[Player sharedPlayer] shieldTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] aleTurns] > 0) {
        [[Player sharedPlayer] setAleTurns:[[Player sharedPlayer] aleTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] runeTurns] > 0) {
        [[Player sharedPlayer] setRuneTurns:[[Player sharedPlayer] runeTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] mirrorTurns] > 0) {
        [[Player sharedPlayer] setMirrorTurns:[[Player sharedPlayer] mirrorTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if (hasUsedBomb) hasUsedBomb = NO;
    
    [self checkBattleOutcome];
    
    if (enemyCurrentHP > 0 && [[Player sharedPlayer] currentHP] > 0) {
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] + 1];
        
        if ([[Player sharedPlayer] energy] > 18) [[Player sharedPlayer] setEnergy:18];
        
        tileTouchesAllowed = YES;
        menuButtons.isTouchEnabled = YES;
    }
}

// enemy heals
-(void)enemyHeal
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
        
    if (enemyHeal + enemyCurrentHP > enemyMaxHP) {
        events_layer = [[ArenaEventsLayer alloc] initWithEnemyHeal:enemyMaxHP - enemyCurrentHP];
    }
    else {
        events_layer = [[ArenaEventsLayer alloc] initWithEnemyHeal:enemyHeal];
    }
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(enemyGetsHealed:) delay:0.8f];
}

// enemy picks up some coins
-(void)enemyPicksUpCoins
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    events_layer = [[ArenaEventsLayer alloc] initWithEnemyPickUpCoins];
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(enemyFinishedTurn:) delay:0.8f];
}

// enemy uses shield
-(void)enemyUsedShield
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    hasEnemyStatusChanged = YES;
    
    events_layer = [[ArenaEventsLayer alloc] initWithEnemyShield];
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(enemyFinishedTurn:) delay:0.8f];    
}

// enemy uses potion
-(void)enemyUsedPotion
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    events_layer = [[ArenaEventsLayer alloc] initWithEnemyPotion];
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(enemyGetsHealed:) delay:0.8f];
}

// enemy used bomb
-(void)enemyUsedBomb
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    tileTouchesAllowed = NO;
    menuButtons.isTouchEnabled = NO;
    
    events_layer = [[ArenaEventsLayer alloc] initWithEnemyBomb:enemyDamage];
    
    [self addChild:events_layer z:10];
        
    [self scheduleOnce:@selector(cleanLayer:) delay:0.8f];
    [self scheduleOnce:@selector(playerGetsDamaged:) delay:0.8f];
}

// enemy used ale
-(void)enemyUsedAle
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    events_layer = [[ArenaEventsLayer alloc] initWithEnemyAle];
    
    hasEnemyStatusChanged = YES;
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(enemyFinishedTurn:) delay:0.8f];
}

// enemy used rune
-(void)enemyUsedRune
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    events_layer = [[ArenaEventsLayer alloc] initWithEnemyRune];
    
    hasEnemyStatusChanged = YES;
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(enemyFinishedTurn:) delay:0.8f];
}

// enemy used mirror
-(void)enemyUsedMirror
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    events_layer = [[ArenaEventsLayer alloc] initWithEnemyMirror];
    
    hasEnemyStatusChanged = YES;
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(enemyFinishedTurn:) delay:0.8f];
}

// enemy used flute
-(void)enemyUsedFlute
{
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    events_layer = [[ArenaEventsLayer alloc] initWithEnemyFlute];
    
    hasEnemyStatusChanged = YES;
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(enemyFinishedTurn:) delay:0.8f];
}

// enemy gets healed and UI is updated
-(void)enemyGetsHealed:(ccTime)dt
{
    [self removeChild:events_layer cleanup:YES];
    
    enemyCurrentHP = enemyCurrentHP + enemyHeal;
    
    if (enemyCurrentHP > enemyMaxHP) enemyCurrentHP = enemyMaxHP;
    
    if ([[Player sharedPlayer] shieldTurns] > 0) {
        [[Player sharedPlayer] setShieldTurns:[[Player sharedPlayer] shieldTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] aleTurns] > 0) {
        [[Player sharedPlayer] setAleTurns:[[Player sharedPlayer] aleTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] runeTurns] > 0) {
        [[Player sharedPlayer] setRuneTurns:[[Player sharedPlayer] runeTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] mirrorTurns] > 0) {
        [[Player sharedPlayer] setMirrorTurns:[[Player sharedPlayer] mirrorTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] + 1];
    
    if ([[Player sharedPlayer] energy] > 18) [[Player sharedPlayer] setEnergy:18];
    
    tileTouchesAllowed = YES;
    menuButtons.isTouchEnabled = YES;
}

// enemy finished turn and UI is updated
-(void)enemyFinishedTurn:(ccTime)dt
{
    [self removeChild:events_layer cleanup:YES];
    
    if ([[Player sharedPlayer] shieldTurns] > 0) {
        [[Player sharedPlayer] setShieldTurns:[[Player sharedPlayer] shieldTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] aleTurns] > 0) {
        [[Player sharedPlayer] setAleTurns:[[Player sharedPlayer] aleTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] runeTurns] > 0) {
        [[Player sharedPlayer] setRuneTurns:[[Player sharedPlayer] runeTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] mirrorTurns] > 0) {
        [[Player sharedPlayer] setMirrorTurns:[[Player sharedPlayer] mirrorTurns] - 1];
        
        hasPlayerStatusChanged = YES;
    }
    
    [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] + 1];
    
    if ([[Player sharedPlayer] energy] > 18) [[Player sharedPlayer] setEnergy:18];
    
    tileTouchesAllowed = YES;
    menuButtons.isTouchEnabled = YES;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    location = [[CCDirector sharedDirector] convertToGL:location];

    [self getPuzzleCoordinates:location];
    
    if ((playerStats.visible &&
         !(location.x >= healthbar2.position.x - healthbar2.contentSize.width &&
           location.x <= healthbar2.position.x &&
           location.y >= healthbar2.position.y &&
           location.y <= healthbar2.position.y + healthbar2.contentSize.height)) ||
        (enemyStats.visible &&
         !(location.x >= healthbar1.position.x &&
           location.x <= healthbar1.position.x + healthbar1.contentSize.width &&
           location.y >= healthbar1.position.y &&
           location.y <= healthbar1.position.y + healthbar1.contentSize.height))) {
             
             if (playerStats.visible) playerStats.visible = NO;
             if (enemyStats.visible) enemyStats.visible = NO;
    }
    else if (location.x >= healthbar1.position.x &&
             location.x <= healthbar1.position.x + healthbar1.contentSize.width &&
             location.y >= healthbar1.position.y &&
             location.y <= healthbar1.position.y + healthbar1.contentSize.height) {
        playerStats.visible = YES;
    }
    else if (location.x >= healthbar2.position.x - healthbar2.contentSize.width &&
             location.x <= healthbar2.position.x &&
             location.y >= healthbar2.position.y &&
             location.y <= healthbar2.position.y + healthbar2.contentSize.height) {
        enemyStats.visible = YES;
    }
    else if (tileTouchesAllowed) {
        if (isValidTouch == NO) {
            [self resetsToBeRemovedTiles];
        }
        else {
            @try {
                Tile *currentTile = [puzzleContents objectAtIndex:(touchY * kPuzzleHeight + touchX)];
                [[currentTile tileSprite] setScale:0.8f];
                [self playTileSoundEffect:[currentTile tileType]];
                
                [toRemoveTiles addObject:currentTile];
                
                touchLocation = location;
                tileChanged = YES;
                
                for (Tile *checkedTile in puzzleContents) {
                    if (checkedTile.tileType != currentTile.tileType) {
                        [[checkedTile tileSprite] setOpacity:45];
                    }
                }
            }
            @catch (NSException *exception) {
                NSLog(@"ccTouchesBegan: Caught %@: %@", [exception name], [exception reason]);
            }
        }
    }
}

-(void)ccTouchesMoved:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    location = [[CCDirector sharedDirector] convertToGL:location];
    touchLocation = location;
    
    [self getPuzzleCoordinates:location];
    
    if (isValidTouch == NO) {
        [self resetsToBeRemovedTiles];
    }
    else if (tileTouchesAllowed) {
        @try {
            if ((touchY * kPuzzleHeight + touchX) < kPuzzleHeight * kPuzzleWidth) {
                Tile *touchedTile = [puzzleContents objectAtIndex:(touchY * kPuzzleHeight + touchX)];
                BOOL nearbyTouch = NO;
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                    if (abs(location.x - touchedTile.tileSprite.position.x < (kTileSize / 2) * 0.6) &&
                        abs(location.y - touchedTile.tileSprite.position.y < (kTileSize / 2) * 0.6)) {
                        
                        nearbyTouch = YES;
                    }
                }
                else {
                    if (abs(location.x - touchedTile.tileSprite.position.x < (kTileSize_ipad / 2) * 0.6) &&
                        abs(location.y - touchedTile.tileSprite.position.y < (kTileSize_ipad / 2) * 0.6)) {
                        
                        nearbyTouch = YES;
                    }
                }
                
                if (nearbyTouch) {
                    if ([toRemoveTiles containsObject:touchedTile]) {
                        [self removeTilesDuringTouchMove:touchedTile];
                    }
                    else {
                        int x = [(Tile*)[toRemoveTiles lastObject] x];
                        int y = [(Tile*)[toRemoveTiles lastObject] y];
                        
                        if (touchX == x) {
                            if (touchY < y) {
                                for (int idx = ((y - 1) * kPuzzleHeight + x);
                                     idx >= [touchedTile tileID]; idx -= 6) {
                                    
                                    [self addTileDuringTouchMove:idx];
                                }
                            }
                            else if (touchY > y) {
                                for (int idx = ((y + 1) * kPuzzleHeight + x);
                                     idx <= [touchedTile tileID]; idx += 6) {
                                    
                                    [self addTileDuringTouchMove:idx];
                                }
                            }
                        }
                        else if (touchY == y) {
                            if (touchX < x) {
                                for (int idx = (y * kPuzzleHeight + (x - 1));
                                     idx >= [touchedTile tileID]; idx--) {
                                    
                                    [self addTileDuringTouchMove:idx];
                                }
                            }
                            else if (touchX > x) {
                                for (int idx = (y * kPuzzleHeight + (x + 1));
                                     idx <= [touchedTile tileID]; idx++) {
                                    
                                    [self addTileDuringTouchMove:idx];
                                }
                            }
                        }
                        else if (touchX != x && touchY != y) {
                            if (touchX < x && touchY < y) {
                                for (int idx = ((y - 1) * kPuzzleHeight + (x - 1));
                                     idx >= [touchedTile tileID]; idx -= 7) {
                                    
                                    [self addTileDuringTouchMove:idx];
                                }
                            }
                            else if (touchX < x && touchY > y) {
                                for (int idx = ((y + 1) * kPuzzleHeight + (x - 1));
                                     idx <= [touchedTile tileID]; idx += 5) {
                                    
                                    [self addTileDuringTouchMove:idx];
                                }
                            }
                            else if (touchX > x && touchY < y) {
                                for (int idx = ((y - 1) * kPuzzleHeight + (x + 1));
                                     idx >= [touchedTile tileID]; idx -= 5) {
                                    
                                    [self addTileDuringTouchMove:idx];
                                }
                            }
                            else if (touchX > x && touchY > y) {
                                for (int idx = ((y + 1) * kPuzzleHeight + (x + 1));
                                     idx <= [touchedTile tileID]; idx += 7) {
                                    
                                    [self addTileDuringTouchMove:idx];
                                }
                            }
                        }
                    }
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"ccTouchesMoved: Caught %@: %@", [exception name], [exception reason]);
        }
    }
}

-(void)ccTouchesEnded:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    if ([toRemoveTiles count] > 2) {
        [self progressBattle];
    }
    else {
        [self resetsToBeRemovedTiles];
    }
}

// check a tile during touch move
-(void)addTileDuringTouchMove:(int)idx
{
    Tile *previousTile = [toRemoveTiles lastObject];
    Tile *potentialTile = [puzzleContents objectAtIndex:idx];
    
    if ([previousTile tileID] != [potentialTile tileID] &&
        ![toRemoveTiles containsObject:potentialTile] &&
        ([previousTile tileType] == [potentialTile tileType]) &&
        [previousTile isNeighbourWith:potentialTile]) {
        
        [[potentialTile tileSprite] setScale:0.8f];
        [self playTileSoundEffect:[potentialTile tileType]];
        
        [toRemoveTiles addObject:potentialTile];
        
        tileChanged = YES;
    }
    else if ([toRemoveTiles containsObject:potentialTile]) {
        [self removeTilesDuringTouchMove:potentialTile];
    }
}

// remove tiles during touch move
-(void)removeTilesDuringTouchMove:(Tile*)tile
{
    while ([[toRemoveTiles lastObject] tileID] != [tile tileID]) {
        [[[toRemoveTiles lastObject] tileSprite] setScale:1];
        [self playTileSoundEffect:[tile tileType]];
        
        [toRemoveTiles removeLastObject];
        
        tileChanged = YES;
    }
}

// play sound effects for tile touch
-(void)playTileSoundEffect:(TileType)type
{
    if (type == kTileSword) [[SoundManager sharedSoundManager] playSwordTouchedEffect];
    else if (type == kTileMagic) [[SoundManager sharedSoundManager] playMagicTouchedEffect];
    else if (type == kTileGold) [[SoundManager sharedSoundManager] playCoinTouchedEffect];
    else if (type == kTileHeart) [[SoundManager sharedSoundManager] playHeartEffect];
}

// get touch coordinates in puzzle
-(void)getPuzzleCoordinates:(CGPoint)location
{
    isValidTouch = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (location.y < (screenSize.height/2 - kPuzzleMarginY - 40) ||
            location.y > ((screenSize.height/2 - kPuzzleMarginY) + (kTileSize * kPuzzleHeight)) + 40) {
            isValidTouch = NO;
        }
    }
    else {
        if (location.y < (screenSize.height/2 - kPuzzleMarginY_ipad - (40 * 2.133f)) ||
            location.y > ((screenSize.height/2 - kPuzzleMarginY_ipad) + (kTileSize_ipad * kPuzzleHeight)) + (40 * 2.133f)) {
            isValidTouch = NO;
        }
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        touchX = (location.x - (screenSize.width/2 - kPuzzleMarginX)) / (kTileSize);
        touchY = (location.y - (screenSize.height/2 - kPuzzleMarginY)) / (kTileSize);
    }
    else {
        touchX = (location.x - (screenSize.width/2 - kPuzzleMarginX_ipad)) / (kTileSize_ipad);
        touchY = (location.y - (screenSize.height/2 - kPuzzleMarginY_ipad)) / (kTileSize_ipad);
    }
}

#pragma mark - pausing and resuming

// pauses the game
-(void)pauseGame
{
    self.isTouchEnabled = NO;
    menuButtons.isTouchEnabled = NO;
    menuPause.isTouchEnabled = NO;
    
    hasPaused = YES;
    
    PauseMultiPlayerLayer *pause_layer = [[PauseMultiPlayerLayer alloc] initWithCoins:coins];
    
    [self addChild:pause_layer z:20];
}

// resumes the game after a pause
-(void)resumeArena
{    
    self.isTouchEnabled = YES;
    menuPause.isTouchEnabled = YES;
    
    if ([[GameCenterManager sharedGameCenterManager] isPlayersTurn]) {
        tileTouchesAllowed = YES;
        menuButtons.isTouchEnabled = YES;
    }
    
    hasPaused = NO;
}

// exits arena
-(void)exitArena
{
    [self pauseSchedulerAndActions];
    
    if ([[Player sharedPlayer] classVal] == 1) coins += (int)(coins * 15 / 100);
    
    coins += (int)(coins * [[Player sharedPlayer] extra_gold_percentage] / 100);
    
    if ([[GameManager sharedGameManager] isDoubleCoin]) coins += coins;

    [[GameManager sharedGameManager] setCurrentDungeon:kDungeonNone];
    [[GameManager sharedGameManager] writeGatheredGold:coins];
    [[SoundManager sharedSoundManager] playMainTheme];
    [[GameCenterManager sharedGameCenterManager] sendGameExit];
}

@end
