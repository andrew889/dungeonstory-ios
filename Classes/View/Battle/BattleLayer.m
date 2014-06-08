//
//  BattleLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "BattleLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "Enemy.h"
#import "Tile.h"
#import "BattleLine.h"
#import "BattleEventsLayer.h"
#import "BattleDefeatLayer.h"
#import "PauseLayer.h"
#import "BattleHelpLayer.h"
#import "Utility.h"
#import "GameCenterManager.h"

#pragma mark - BattleLayer

@implementation BattleLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	BattleLayer *layer = [BattleLayer node];
    
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
        playerStats = [CCSprite spriteWithFile:@"PlayerStatus2.png"];
        enemyStats = [CCSprite spriteWithFile:@"EnemyStatus2.png"];
        
        if (screenSize.height == 568.00) {
            battleBar = [CCSprite spriteWithFile:@"battlebar-iphone5.png"];
        }
        
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
        
        labelPlayerAbility1 = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleShopName01", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
        labelPlayerAbility2 = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleShopName02", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
        labelPlayerAbility3 = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleShopName03", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
        labelPlayerAbility4 = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleShopName04", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
        labelPlayerAbility5 = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleShopName05", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
        labelPlayerAbility6 = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleShopName06", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
        labelPlayerAbility7 = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleShopName07", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
        labelPlayerAbility8 = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleShopName08", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
        labelPlayerAbility9 = [CCLabelTTF labelWithString:NSLocalizedString(@"BattleShopName09", nil)
                                                 fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
        
        labelEnemyPower = [CCLabelTTF labelWithString:NSLocalizedString(@"MonsterPower", nil)
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
        labelEnemyExp = [CCLabelTTF labelWithString:NSLocalizedString(@"MonsterExp", nil)
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
        [labelPlayerAbility1 setColor:ccc3(0, 82, 50)];
        [labelPlayerAbility1Lvl setColor:ccc3(205, 152, 18)];
        [labelPlayerAbility1Val setColor:ccBLACK];
        [labelPlayerAbility2 setColor:ccc3(0, 82, 50)];
        [labelPlayerAbility2Lvl setColor:ccc3(205, 152, 18)];
        [labelPlayerAbility2Val setColor:ccBLACK];
        [labelPlayerAbility3 setColor:ccc3(0, 82, 50)];
        [labelPlayerAbility3Lvl setColor:ccc3(205, 152, 18)];
        [labelPlayerAbility3Val setColor:ccBLACK];
        [labelPlayerAbility4 setColor:ccc3(0, 82, 50)];
        [labelPlayerAbility4Lvl setColor:ccc3(205, 152, 18)];
        [labelPlayerAbility4Val setColor:ccBLACK];
        [labelPlayerAbility5 setColor:ccc3(0, 82, 50)];
        [labelPlayerAbility5Lvl setColor:ccc3(205, 152, 18)];
        [labelPlayerAbility5Val setColor:ccBLACK];
        [labelPlayerAbility6 setColor:ccc3(0, 82, 50)];
        [labelPlayerAbility6Lvl setColor:ccc3(205, 152, 18)];
        [labelPlayerAbility6Val setColor:ccBLACK];
        [labelPlayerAbility7 setColor:ccc3(0, 82, 50)];
        [labelPlayerAbility7Lvl setColor:ccc3(205, 152, 18)];
        [labelPlayerAbility7Val setColor:ccBLACK];
        [labelPlayerAbility8 setColor:ccc3(0, 82, 50)];
        [labelPlayerAbility8Lvl setColor:ccc3(205, 152, 18)];
        [labelPlayerAbility8Val setColor:ccBLACK];
        [labelPlayerAbility9 setColor:ccc3(0, 82, 50)];
        [labelPlayerAbility9Lvl setColor:ccc3(205, 152, 18)];
        [labelPlayerAbility9Val setColor:ccBLACK];
        [labelEnemyPower setColor:ccBLACK];
        [labelEnemyPowerVal setColor:ccBLACK];
        [labelEnemyExp setColor:ccBLACK];
        [labelEnemyExpVal setColor:ccBLACK];
        [labelEnemyAbility setColor:ccBLACK];
        
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
        [labelPlayerAbility1 setAnchorPoint:ccp(0, 0)];
        [labelPlayerAbility1Lvl setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility1Val setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility2 setAnchorPoint:ccp(0, 0)];
        [labelPlayerAbility2Lvl setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility2Val setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility3 setAnchorPoint:ccp(0, 0)];
        [labelPlayerAbility3Lvl setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility3Val setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility4 setAnchorPoint:ccp(0, 0)];
        [labelPlayerAbility4Lvl setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility4Val setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility5 setAnchorPoint:ccp(0, 0)];
        [labelPlayerAbility5Lvl setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility5Val setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility6 setAnchorPoint:ccp(0, 0)];
        [labelPlayerAbility6Lvl setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility6Val setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility7 setAnchorPoint:ccp(0, 0)];
        [labelPlayerAbility7Lvl setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility7Val setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility8 setAnchorPoint:ccp(0, 0)];
        [labelPlayerAbility8Lvl setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility8Val setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility9 setAnchorPoint:ccp(0, 0)];
        [labelPlayerAbility9Lvl setAnchorPoint:ccp(1, 0)];
        [labelPlayerAbility9Val setAnchorPoint:ccp(1, 0)];
        [labelEnemyPower setAnchorPoint:ccp(0, 0)];
        [labelEnemyPowerVal setAnchorPoint:ccp(1, 0)];
        [labelEnemyExp setAnchorPoint:ccp(0, 0)];
        [labelEnemyExpVal setAnchorPoint:ccp(1, 0)];
        
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
            
            [playerStats setPosition:ccp(screenSize.width/2 - 1.4, screenSize.height/2 + 17.9)];
            [labelPlayerClass setPosition:ccp(35, 287)];
            [labelPlayerClassVal setPosition:ccp(155, 287)];
            [labelPlayerAttack setPosition:ccp(35, 263)];
            [labelPlayerAttackVal setPosition:ccp(155, 263)];
            [labelPlayerDefence setPosition:ccp(35, 245)];
            [labelPlayerDefenceVal setPosition:ccp(155, 245)];
            [labelPlayerMagic setPosition:ccp(35, 227)];
            [labelPlayerMagicVal setPosition:ccp(155, 227)];
            [labelPlayerLuck setPosition:ccp(35, 209)];
            [labelPlayerLuckVal setPosition:ccp(155, 209)];
            [labelPlayerStatus setPosition:ccp(35, 187)];
            [labelPlayerStatusVal setPosition:ccp(155, 187)];
            
            [labelPlayerAbility1 setPosition:ccp(35, 152)];
            [labelPlayerAbility2 setPosition:ccp(35, 121.5)];
            [labelPlayerAbility3 setPosition:ccp(35, 91)];
            [labelPlayerAbility4 setPosition:ccp(35, 60.5)];
            [labelPlayerAbility5 setPosition:ccp(35, 28)];
            
            [labelPlayerAbility1Lvl setPosition:ccp(155, 153)];
            [labelPlayerAbility2Lvl setPosition:ccp(155, 122.5)];
            [labelPlayerAbility3Lvl setPosition:ccp(155, 92)];
            [labelPlayerAbility4Lvl setPosition:ccp(155, 61.5)];
            [labelPlayerAbility5Lvl setPosition:ccp(155, 29)];
            
            [labelPlayerAbility1Val setPosition:ccp(155, 139)];
            [labelPlayerAbility2Val setPosition:ccp(155, 108.5)];
            [labelPlayerAbility3Val setPosition:ccp(155, 78)];
            [labelPlayerAbility4Val setPosition:ccp(155, 47.5)];
            [labelPlayerAbility5Val setPosition:ccp(155, 15)];
            
            [labelPlayerAbility6 setPosition:ccp(186, 142)];
            [labelPlayerAbility7 setPosition:ccp(186, 106.5)];
            [labelPlayerAbility8 setPosition:ccp(186, 71)];
            [labelPlayerAbility9 setPosition:ccp(186, 35.5)];
            
            [labelPlayerAbility6Lvl setPosition:ccp(306, 143)];
            [labelPlayerAbility7Lvl setPosition:ccp(306, 107.5)];
            [labelPlayerAbility8Lvl setPosition:ccp(306, 72)];
            [labelPlayerAbility9Lvl setPosition:ccp(306, 36.5)];
            
            [labelPlayerAbility6Val setPosition:ccp(306, 128)];
            [labelPlayerAbility7Val setPosition:ccp(306, 93.5)];
            [labelPlayerAbility8Val setPosition:ccp(306, 58)];
            [labelPlayerAbility9Val setPosition:ccp(306, 22.5)];
            
            [enemyStats setPosition:ccp(screenSize.width/2 + 73, screenSize.height/2 + 102)];
            [labelEnemyPower setPosition:ccp(34, 65)];
            [labelEnemyPowerVal setPosition:ccp(154, 65)];
            [labelEnemyExp setPosition:ccp(34, 47)];
            [labelEnemyExpVal setPosition:ccp(154, 47)];
            [labelEnemyAbility setPosition:ccp(enemyStats.contentSize.width/2 + 4, 29)];
            
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
                        
            [playerStats setPosition:ccp(screenSize.width/2 - (1 * 2.4f), screenSize.height/2 + (12 * 2.133f))];
            [labelPlayerClass setPosition:ccp(32 * 2.4f, 294 * 2.133f)];
            [labelPlayerClassVal setPosition:ccp(147 * 2.4f, 294 * 2.133f)];
            [labelPlayerAttack setPosition:ccp(32 * 2.4f, 270 * 2.133f)];
            [labelPlayerAttackVal setPosition:ccp(147 * 2.4f, 270 * 2.133f)];
            [labelPlayerDefence setPosition:ccp(32 * 2.4f, 252 * 2.133f)];
            [labelPlayerDefenceVal setPosition:ccp(147 * 2.4f, 252 * 2.133f)];
            [labelPlayerMagic setPosition:ccp(32 * 2.4f, 234 * 2.133f)];
            [labelPlayerMagicVal setPosition:ccp(147 * 2.4f, 234 * 2.133f)];
            [labelPlayerLuck setPosition:ccp(32 * 2.4f, 216 * 2.133f)];
            [labelPlayerLuckVal setPosition:ccp(147 * 2.4f, 216 * 2.133f)];
            [labelPlayerStatus setPosition:ccp(32 * 2.4f, 194 * 2.133f)];
            [labelPlayerStatusVal setPosition:ccp(147 * 2.4f, 194 * 2.133f)];
            
            [labelPlayerAbility1 setPosition:ccp(32 * 2.4f, 154 * 2.133f)];
            [labelPlayerAbility2 setPosition:ccp(32 * 2.4f, 123.5 * 2.133f)];
            [labelPlayerAbility3 setPosition:ccp(32 * 2.4f, 93 * 2.133f)];
            [labelPlayerAbility4 setPosition:ccp(32 * 2.4f, 62.5 * 2.133f)];
            [labelPlayerAbility5 setPosition:ccp(32 * 2.4f, 30 * 2.133f)];
            
            [labelPlayerAbility1Lvl setPosition:ccp(147 * 2.4f, 155 * 2.133f)];
            [labelPlayerAbility2Lvl setPosition:ccp(147 * 2.4f, 124.5 * 2.133f)];
            [labelPlayerAbility3Lvl setPosition:ccp(147 * 2.4f, 94 * 2.133f)];
            [labelPlayerAbility4Lvl setPosition:ccp(147 * 2.4f, 63.5 * 2.133f)];
            [labelPlayerAbility5Lvl setPosition:ccp(147 * 2.4f, 31 * 2.133f)];
            
            [labelPlayerAbility1Val setPosition:ccp(147 * 2.4f, 141 * 2.133f)];
            [labelPlayerAbility2Val setPosition:ccp(147 * 2.4f, 110.5 * 2.133f)];
            [labelPlayerAbility3Val setPosition:ccp(147 * 2.4f, 80 * 2.133f)];
            [labelPlayerAbility4Val setPosition:ccp(147 * 2.4f, 49.5 * 2.133f)];
            [labelPlayerAbility5Val setPosition:ccp(147 * 2.4f, 17 * 2.133f)];
            
            [labelPlayerAbility6 setPosition:ccp(170 * 2.4f, 144 * 2.133f)];
            [labelPlayerAbility7 setPosition:ccp(170 * 2.4f, 108.5 * 2.133f)];
            [labelPlayerAbility8 setPosition:ccp(170 * 2.4f, 73 * 2.133f)];
            [labelPlayerAbility9 setPosition:ccp(170 * 2.4f, 37.5 * 2.133f)];
            
            [labelPlayerAbility6Lvl setPosition:ccp(283 * 2.4f, 145 * 2.133f)];
            [labelPlayerAbility7Lvl setPosition:ccp(283 * 2.4f, 109.5 * 2.133f)];
            [labelPlayerAbility8Lvl setPosition:ccp(283 * 2.4f, 74 * 2.133f)];
            [labelPlayerAbility9Lvl setPosition:ccp(283 * 2.4f, 38.5 * 2.133f)];
            
            [labelPlayerAbility6Val setPosition:ccp(283 * 2.4f, 130 * 2.133f)];
            [labelPlayerAbility7Val setPosition:ccp(283 * 2.4f, 95.5 * 2.133f)];
            [labelPlayerAbility8Val setPosition:ccp(283 * 2.4f, 60 * 2.133f)];
            [labelPlayerAbility9Val setPosition:ccp(283 * 2.4f, 24.5 * 2.133f)];
            
            [enemyStats setPosition:ccp(screenSize.width/2 + (67.2 * 2.4f), screenSize.height/2 + (99.2 * 2.133f))];
            [labelEnemyPower setPosition:ccp(30 * 2.4f, 70 * 2.133f)];
            [labelEnemyPowerVal setPosition:ccp(144 * 2.4f, 70 * 2.133f)];
            [labelEnemyExp setPosition:ccp(30 * 2.4f, 53 * 2.133f)];
            [labelEnemyExpVal setPosition:ccp(144 * 2.4f, 53 * 2.133f)];
            [labelEnemyAbility setPosition:ccp(enemyStats.contentSize.width/2 + (4 * 2.4f), 33 * 2.133f)];
            
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
        [self addChild:playerStats z:11 tag:8];
        [self addChild:enemyStats z:11 tag:9];
        [self addChild:labelTime z:7 tag:10];
		[self addChild:labelName z:7 tag:11];
        [self addChild:labelEnemyName z:7 tag:12];
        [self addChild:labelPlayerHPVal z:7 tag:13];
        [self addChild:labelEnemyHPVal z:7 tag:14];
        [self addChild:menuButtons z:7 tag:15];
        [self addChild:menuPause z:7 tag:16];
        
        if (screenSize.height == 568.00) {
            [self addChild:battleBar z:8 tag:17];
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
        [playerStats addChild:labelPlayerAbility1 z:0];
        [playerStats addChild:labelPlayerAbility2 z:0];
        [playerStats addChild:labelPlayerAbility3 z:0];
        [playerStats addChild:labelPlayerAbility4 z:0];
        [playerStats addChild:labelPlayerAbility5 z:0];
        [playerStats addChild:labelPlayerAbility6 z:0];
        [playerStats addChild:labelPlayerAbility7 z:0];
        [playerStats addChild:labelPlayerAbility8 z:0];
        [playerStats addChild:labelPlayerAbility9 z:0];
        [playerStats addChild:labelPlayerAbility1Lvl z:0];
        [playerStats addChild:labelPlayerAbility2Lvl z:0];
        [playerStats addChild:labelPlayerAbility3Lvl z:0];
        [playerStats addChild:labelPlayerAbility4Lvl z:0];
        [playerStats addChild:labelPlayerAbility5Lvl z:0];
        [playerStats addChild:labelPlayerAbility6Lvl z:0];
        [playerStats addChild:labelPlayerAbility7Lvl z:0];
        [playerStats addChild:labelPlayerAbility8Lvl z:0];
        [playerStats addChild:labelPlayerAbility9Lvl z:0];
        [playerStats addChild:labelPlayerAbility1Val z:0];
        [playerStats addChild:labelPlayerAbility2Val z:0];
        [playerStats addChild:labelPlayerAbility3Val z:0];
        [playerStats addChild:labelPlayerAbility4Val z:0];
        [playerStats addChild:labelPlayerAbility5Val z:0];
        [playerStats addChild:labelPlayerAbility6Val z:0];
        [playerStats addChild:labelPlayerAbility7Val z:0];
        [playerStats addChild:labelPlayerAbility8Val z:0];
        [playerStats addChild:labelPlayerAbility9Val z:0];
        
        [enemyStats addChild:labelEnemyPower z:0];
        [enemyStats addChild:labelEnemyPowerVal z:0];
        [enemyStats addChild:labelEnemyExp z:0];
        [enemyStats addChild:labelEnemyExpVal z:0];
        [enemyStats addChild:labelEnemyAbility z:0];
                
        healthbar2.scaleX = -1;
        
        playerStats.visible = NO;
        enemyStats.visible = NO;
        tileChanged = NO;
        touchValueIsActive = NO;
        isTouching = NO;
        isShopOpen = NO;
        
        [itemBtn1 setIsEnabled:NO];
        [itemBtn2 setIsEnabled:NO];
        [itemBtn3 setIsEnabled:NO];
                
        [self scheduleUpdate];
        [self schedule:@selector(timeSchedule:) interval:5.0f];
        
        self.isTouchEnabled = YES;
        
        shouldEnergyGlow = YES;
        lowHealthTexture_dt = 0;
        
        [self setupItemSlots];
        
        if ([[GameManager sharedGameManager] battleHelp]) {
            [[GameManager sharedGameManager] setBattleHelp:NO];
            [[GameManager sharedGameManager] writeMenuHelp];
            
            [self showHelp];
        }
	}
    
	return self;
}

#pragma mark - scene setup

// setups battle
-(void)setupBattle
{
    hasBattleEnded = NO;
    hasLeveledUp = NO;
    hasUnlockedClasses = NO;
    hasFoundHeroShield = NO;
    uniqueTileExists = NO;
    battleRound = 1;
    totalExp = 0;
    coins = 0;
    enemyRage = 0;
    
    ability1 = 0;
    ability2 = 0;
    ability3 = 0;
    ability4 = 0;
    ability5 = 0;
    ability6 = 0;
    ability7 = 0;
    ability8 = 0;
    ability9 = 0;
    
    [[Player sharedPlayer] setupForBattle];
    
    enemy = [[Enemy alloc] initWithBattleRound:battleRound];
    nextEnemy = nil;

    if (![[Player sharedPlayer] name]) {
        msgName = [NSString stringWithFormat:@"%@",
                   [[Player sharedPlayer] className]];
    }
    else {
        msgName = [NSString stringWithFormat:@"%@",
                   [[Player sharedPlayer] name]];
    }
    
    int enemyHpFontSize = [Utility getFontSize:16];
    
    if ([enemy maxHP] > 999999) enemyHpFontSize = [Utility getFontSize:11];
    else if ([enemy maxHP] > 99999) enemyHpFontSize = [Utility getFontSize:14];
    
    labelName = [CCLabelTTF labelWithString:msgName fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
    labelEnemyName = [CCLabelTTF labelWithString:[enemy name] fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
    
    labelPlayerHPVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d/%d",
                                                    [[Player sharedPlayer] currentHP],
                                                    [[Player sharedPlayer] maxHP]]
                                          fontName:@"Shark Crash" fontSize:[Utility getFontSize:16]];
    labelEnemyHPVal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d/%d",
                                                   [enemy currentHP], [enemy maxHP]]
                                         fontName:@"Shark Crash" fontSize:enemyHpFontSize];
    
    labelPlayerClassVal = [CCLabelTTF labelWithString:[[Player sharedPlayer] className]
                                             fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelPlayerAttackVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelPlayerDefenceVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelPlayerMagicVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelPlayerLuckVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    
    labelPlayerAbility1Lvl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:10]];
    labelPlayerAbility2Lvl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:10]];
    labelPlayerAbility3Lvl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:10]];
    labelPlayerAbility4Lvl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:10]];
    labelPlayerAbility5Lvl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:10]];
    labelPlayerAbility6Lvl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:10]];
    labelPlayerAbility7Lvl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:10]];
    labelPlayerAbility8Lvl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:10]];
    labelPlayerAbility9Lvl = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:10]];
    
    labelPlayerAbility1Val = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:9]];
    labelPlayerAbility2Val = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:9]];
    labelPlayerAbility3Val = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:9]];
    labelPlayerAbility4Val = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:9]];
    labelPlayerAbility5Val = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:9]];
    labelPlayerAbility6Val = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:9]];
    labelPlayerAbility7Val = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:9]];
    labelPlayerAbility8Val = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:9]];
    labelPlayerAbility9Val = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:9]];
    
    labelEnemyPowerVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelEnemyExpVal = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:14]];
    labelEnemyAbility = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:[Utility getFontSize:11]];
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
    
    [labelPlayerAbility1Lvl setString:[NSString stringWithFormat:NSLocalizedString(@"BattleAbilityLevel", nil), ability1]];
    [labelPlayerAbility2Lvl setString:[NSString stringWithFormat:NSLocalizedString(@"BattleAbilityLevel", nil), ability2]];
    [labelPlayerAbility3Lvl setString:[NSString stringWithFormat:NSLocalizedString(@"BattleAbilityLevel", nil), ability3]];
    [labelPlayerAbility4Lvl setString:[NSString stringWithFormat:NSLocalizedString(@"BattleAbilityLevel", nil), ability4]];
    [labelPlayerAbility5Lvl setString:[NSString stringWithFormat:NSLocalizedString(@"BattleAbilityLevel", nil), ability5]];
    [labelPlayerAbility6Lvl setString:[NSString stringWithFormat:NSLocalizedString(@"BattleAbilityLevel", nil), ability6]];
    [labelPlayerAbility7Lvl setString:[NSString stringWithFormat:NSLocalizedString(@"BattleAbilityLevel", nil), ability7]];
    [labelPlayerAbility8Lvl setString:[NSString stringWithFormat:NSLocalizedString(@"BattleAbilityLevel", nil), ability8]];
    [labelPlayerAbility9Lvl setString:[NSString stringWithFormat:NSLocalizedString(@"BattleAbilityLevel", nil), ability9]];
    
    [labelPlayerAbility1Val setString:[NSString stringWithFormat:NSLocalizedString(@"BattleShopAbility01", nil),
                                       (6 * ability1)]];
    
    [labelPlayerAbility2Val setString:[NSString stringWithFormat:NSLocalizedString(@"BattleShopAbility02", nil),
                                       ability2]];
    
    [labelPlayerAbility3Val setString:[NSString stringWithFormat:NSLocalizedString(@"BattleShopAbility03", nil),
                                       (6 * ability3)]];
    
    [labelPlayerAbility4Val setString:[NSString stringWithFormat:NSLocalizedString(@"BattleShopAbility04", nil),
                                       (6 * ability4)]];
    
    [labelPlayerAbility5Val setString:[NSString stringWithFormat:NSLocalizedString(@"BattleShopAbility05", nil),
                                       (6 * ability5)]];
    
    [labelPlayerAbility6Val setString:[NSString stringWithFormat:NSLocalizedString(@"BattleShopAbility06", nil),
                                       (6 * ability6)]];
    
    [labelPlayerAbility7Val setString:[NSString stringWithFormat:NSLocalizedString(@"BattleShopAbility07", nil),
                                       (6 * ability7)]];
    
    [labelPlayerAbility8Val setString:[NSString stringWithFormat:NSLocalizedString(@"BattleShopAbility08", nil),
                                       (2 * ability8)]];
    
    [labelPlayerAbility9Val setString:[NSString stringWithFormat:NSLocalizedString(@"BattleShopAbility09", nil),
                                       (2 * ability9)]];
    
    if (battleRound == 1) {
        enemyRank = [[CCSprite alloc] initWithSpriteFrameName:@"EnemyRank1.png"];
    }
    else {
        [enemyStats removeChild:enemyRank cleanup:YES];

        if ([enemy rank] == kEnemyRankMerchant) {
            enemyRank = [[CCSprite alloc] initWithSpriteFrameName:@"EnemyRank4.png"];
        }
        else if ([enemy rank] == kEnemyRankBoss) {
            enemyRank = [[CCSprite alloc] initWithSpriteFrameName:@"EnemyRank3.png"];
        }
        else if ([enemy rank] == kEnemyRankSpecial) {
            enemyRank = [[CCSprite alloc] initWithSpriteFrameName:@"EnemyRank2.png"];
        }
        else {
            enemyRank = [[CCSprite alloc] initWithSpriteFrameName:@"EnemyRank1.png"];
        }
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [enemyRank setPosition:ccp(enemyStats.contentSize.width/2 + 4, 110)];
    }
    else {
        [enemyRank setPosition:ccp(enemyStats.contentSize.width/2 + (4 * 2.4f), 115 * 2.133f)];
    }
    
    [enemyStats addChild:enemyRank z:1];
    
    [labelEnemyPowerVal setString:[NSString stringWithFormat:@"%d", [enemy damage]]];
        
    if ([enemy rank] == kEnemyRankMerchant) {
        [labelEnemyExp setString:NSLocalizedString(@"MonsterGold", nil)];
        
        if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
            [labelEnemyExpVal setString:[NSString stringWithFormat:@"%lld", 20 * battleRound]];
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
            [labelEnemyExpVal setString:[NSString stringWithFormat:@"%lld", 10 * battleRound]];
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
            [labelEnemyExpVal setString:[NSString stringWithFormat:@"%lld", 8 * battleRound]];
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
            [labelEnemyExpVal setString:[NSString stringWithFormat:@"%lld", 6 * battleRound]];
        }
        else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
            [labelEnemyExpVal setString:[NSString stringWithFormat:@"%lld", 4 * battleRound]];
        }
        else {
            [labelEnemyExpVal setString:[NSString stringWithFormat:@"%lld", 2 * battleRound]];
        }
    }
    else if ([enemy ability] == kEnemyAbilityExperience) {
        [labelEnemyExp setString:NSLocalizedString(@"MonsterExp", nil)];
        [labelEnemyExpVal setString:[NSString stringWithFormat:@"%d", [enemy exp] * 2]];
    }
    else {
        [labelEnemyExp setString:NSLocalizedString(@"MonsterExp", nil)];
        [labelEnemyExpVal setString:[NSString stringWithFormat:@"%d", [enemy exp]]];
    }
    
    [labelEnemyAbility setString:[enemy getAbilityName]];
}

// setups next battle
-(void)setupNextBattle
{
    battleRound++;
    enemy = nextEnemy;
    enemyRage = 0;
    
    [labelEnemyName setString:[enemy name]];
    [labelEnemyHPVal setString:[NSString stringWithFormat:@"%d/%d", [enemy currentHP], [enemy maxHP]]];
    
    [self setupBattleStats];
    
    if ([enemy rank] == kEnemyRankMerchant) {
        self.isTouchEnabled = NO;
        menuPause.isTouchEnabled = YES;
        isShopOpen = YES;
        
        [self setupShop];
    }
    else {
        self.isTouchEnabled = YES;
        menuButtons.isTouchEnabled = YES;
        menuPause.isTouchEnabled = YES;
    }
}

// setups the merchant shop
-(void)setupShop
{
    for (Tile *checkedTile in puzzleContents) {
        [[checkedTile tileSprite] setOpacity:20];
    }
    
    shopLabel = [Utility labelWithString:NSLocalizedString(@"MerchantMsg01", nil)
                                fontName:@"Shark Crash" fontSize:[Utility getFontSize:36]
                                   color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    itemDescription = [Utility labelWithString:NSLocalizedString(@"MerchantMsg02", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:28]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    shopExit = [Utility labelWithString:@"x"
                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:100]
                                  color:ccc3(255, 130, 71) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];

    
    int randomSlot1 = arc4random_uniform(3);
    int randomSlot2 = arc4random_uniform(3) + 3;
    int randomSlot3 = arc4random_uniform(3) + 6;
    
    if (randomSlot1 == 0) {
        spriteAbility1 = [CCSprite spriteWithFile:@"ability1.png"];
        currentSlot1 = 1;
    }
    else if (randomSlot1 == 1) {
        spriteAbility1 = [CCSprite spriteWithFile:@"ability2.png"];
        currentSlot1 = 2;
    }
    else if (randomSlot1 == 2) {
        spriteAbility1 = [CCSprite spriteWithFile:@"ability3.png"];
        currentSlot1 = 3;
    }
    
    if (randomSlot2 == 3) {
        spriteAbility2 = [CCSprite spriteWithFile:@"ability4.png"];
        currentSlot2 = 4;
    }
    else if (randomSlot2 == 4) {
        spriteAbility2 = [CCSprite spriteWithFile:@"ability5.png"];
        currentSlot2 = 5;
    }
    else if (randomSlot2 == 5) {
        spriteAbility2 = [CCSprite spriteWithFile:@"ability6.png"];
        currentSlot2 = 6;
    }
    
    if (randomSlot3 == 6) {
        spriteAbility3 = [CCSprite spriteWithFile:@"ability7.png"];
        currentSlot3 = 7;
    }
    else if (randomSlot3 == 7) {
        spriteAbility3 = [CCSprite spriteWithFile:@"ability8.png"];
        currentSlot3 = 8;
    }
    else if (randomSlot3 == 8) {
        spriteAbility3 = [CCSprite spriteWithFile:@"ability9.png"];
        currentSlot3 = 9;
    }
        
    itemAbilitySlotOff1 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
    
    itemAbilitySlotOn1 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn_pressed.png"
                                                selectedImage:@"abilityBtn_pressed.png"];
    
    itemAbilitySlot1 = [CCMenuItemToggle itemWithTarget:self selector:@selector(buySlot1:)
                                                  items:itemAbilitySlotOff1, itemAbilitySlotOn1, nil];
    
    itemAbilitySlotOff2 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
    
    itemAbilitySlotOn2 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn_pressed.png"
                                                selectedImage:@"abilityBtn_pressed.png"];
    
    itemAbilitySlot2 = [CCMenuItemToggle itemWithTarget:self selector:@selector(buySlot2:)
                                                  items:itemAbilitySlotOff2, itemAbilitySlotOn2, nil];
    
    itemAbilitySlotOff3 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
    
    itemAbilitySlotOn3 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn_pressed.png"
                                                selectedImage:@"abilityBtn_pressed.png"];
    
    itemAbilitySlot3 = [CCMenuItemToggle itemWithTarget:self selector:@selector(buySlot3:)
                                                  items:itemAbilitySlotOff3, itemAbilitySlotOn3, nil];
    
    itemAbilitySlotOff4 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn.png"
                                                 selectedImage:@"abilityBtn_pressed.png"];
    
    itemAbilitySlotOn4 = [CCMenuItemImage itemWithNormalImage:@"abilityBtn_pressed.png"
                                                selectedImage:@"abilityBtn_pressed.png"];
    
    itemAbilitySlot4 = [CCMenuItemToggle itemWithTarget:self selector:@selector(exitShop:)
                                                  items:itemAbilitySlotOff4, itemAbilitySlotOn4, nil];
    
    itemShopConfirm = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"Confirm", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:28]
                                                                                color:ccc3(0, 255, 127)
                                                                           strokeSize:[Utility getFontSize:1.5]
                                                                           stokeColor:ccBLACK]
                       
                                              selectedSprite:[Utility labelWithString:NSLocalizedString(@"Confirm", nil)
                                                                             fontName:@"Shark Crash"
                                                                             fontSize:[Utility getFontSize:28]
                                                                                color:ccc3(255, 204, 102)
                                                                           strokeSize:[Utility getFontSize:1.5]
                                                                           stokeColor:ccBLACK]
                       
                                                      target:self selector:@selector(confirmShop)];
    
    itemShopNoGold = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"NoGold", nil)
                                                                            fontName:@"Shark Crash"
                                                                            fontSize:[Utility getFontSize:28]
                                                                               color:ccc3(90, 90 , 90)
                                                                          strokeSize:[Utility getFontSize:1.5]
                                                                          stokeColor:ccBLACK]
                      
                                             selectedSprite:[Utility labelWithString:NSLocalizedString(@"NoGold", nil)
                                                                            fontName:@"Shark Crash"
                                                                            fontSize:[Utility getFontSize:28]
                                                                               color:ccc3(90, 90 , 90)
                                                                          strokeSize:[Utility getFontSize:1.5]
                                                                          stokeColor:ccBLACK]];
    
    menuShop = [CCMenu menuWithItems:itemAbilitySlot1, itemAbilitySlot2,
                itemAbilitySlot3, itemAbilitySlot4, itemShopConfirm, itemShopNoGold, nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [shopLabel setPosition:ccp(screenSize.width/2, screenSize.height/2 + 141)];
        [itemDescription setPosition:ccp(screenSize.width/2, screenSize.height/2 -100)];
        [itemShopConfirm setPosition:ccp(0, -150)];
        [itemShopNoGold setPosition:ccp(0, -150)];
        
        [shopExit setPosition:ccp(itemAbilitySlot4.contentSize.width/2,
                                  itemAbilitySlot4.contentSize.height/2 + 15)];
        
        [itemAbilitySlot1 setPosition:ccp(-60, 70)];
        [itemAbilitySlot2 setPosition:ccp(60, 70)];
        [itemAbilitySlot3 setPosition:ccp(-60, -23)];
        [itemAbilitySlot4 setPosition:ccp(60, -23)];
    }
    else {
        [shopLabel setPosition:ccp(screenSize.width/2, screenSize.height/2 + (141 * 2.133f))];
        [itemDescription setPosition:ccp(screenSize.width/2, screenSize.height/2 - (100 * 2.133f))];
        [itemShopConfirm setPosition:ccp(0, -(150 * 2.133f))];
        [itemShopNoGold setPosition:ccp(0, -(150 * 2.133f))];
        
        [shopExit setPosition:ccp(itemAbilitySlot4.contentSize.width/2,
                                  itemAbilitySlot4.contentSize.height/2 + (15 * 2.133f))];
        
        [itemAbilitySlot1 setPosition:ccp(-(60 * 2.4f), 70 * 2.133f)];
        [itemAbilitySlot2 setPosition:ccp(60 * 2.4f, 70 * 2.133f)];
        [itemAbilitySlot3 setPosition:ccp(-(60 * 2.4f), -(23 * 2.133f))];
        [itemAbilitySlot4 setPosition:ccp(60 * 2.4f, -(23 * 2.133f))];
    }
    
    [spriteAbility1 setPosition:ccp(itemAbilitySlot1.contentSize.width/2,
                                    itemAbilitySlot1.contentSize.height/2)];
    [spriteAbility2 setPosition:ccp(itemAbilitySlot2.contentSize.width/2,
                                    itemAbilitySlot2.contentSize.height/2)];
    [spriteAbility3 setPosition:ccp(itemAbilitySlot3.contentSize.width/2,
                                    itemAbilitySlot3.contentSize.height/2)];
    
    [self addChild:menuShop z:9 tag:18];
    [self addChild:shopLabel z:9 tag:19];
    [self addChild:itemDescription z:9 tag:20];
    [itemAbilitySlot1 addChild:spriteAbility1 z:1 tag:0];
    [itemAbilitySlot2 addChild:spriteAbility2 z:1 tag:0];
    [itemAbilitySlot3 addChild:spriteAbility3 z:1 tag:0];
    [itemAbilitySlot4 addChild:shopExit z:1 tag:0];
    
    itemShopConfirm.visible = NO;
    itemShopConfirm.isEnabled = NO;
    itemShopNoGold.visible = NO;
    itemShopNoGold.isEnabled = NO;
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
    
    if (!uniqueTileExists && [[Player sharedPlayer] emblems] == 0 &&
        [[GameManager sharedGameManager] currentDungeon] == kDungeonBloodyDungeon &&
        battleRound >= 10) {
        
        tileType = kTileEmblem1;
        uniqueTileExists = YES;
    }
    else if (!uniqueTileExists && [[Player sharedPlayer] emblems] == 1 &&
             [[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake &&
             battleRound >= 15) {
        
        tileType = kTileEmblem2;
        uniqueTileExists = YES;
    }
    else if (!uniqueTileExists && [[Player sharedPlayer] emblems] == 2 &&
             [[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs &&
             battleRound >= 25) {
        
        tileType = kTileEmblem3;
        uniqueTileExists = YES;
    }
    else if (!uniqueTileExists && [[Player sharedPlayer] emblems] == 3 &&
             [[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes &&
             battleRound >= 35) {
        
        tileType = kTileEmblem4;
        uniqueTileExists = YES;
    }
    else if (!uniqueTileExists && [[Player sharedPlayer] shield] == 1 &&
             [[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny &&
             battleRound >= 40 && arc4random_uniform(1000) >= 999) {
        
        tileType = kTileHeroShield;
        uniqueTileExists = YES;
    }
    else {
        if (random == 0) tileType = kTileSword;
        else if (random == 1) tileType = kTileMagic;
        else if (random == 2) tileType = kTileHeart;
        else if (random == 3) tileType = kTileGold;
    }
    
    int x = idx % kPuzzleHeight;
    int y = (idx - x) / kPuzzleHeight;
    
    return [[Tile alloc] initWithType:tileType withX:x withY:y withDrop:drop];
}

// removes the chosen tiles and rebuilds puzzle
-(void)rebuildsPuzzle:(ccTime)dt
{
    if (hasUsedBomb) hasUsedBomb = NO;
    if (hasUsedFlute) hasUsedFlute = NO;

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
    int randomFlute = arc4random_uniform(3);
    
    for (Tile *checkedTile in puzzleContents) {
        [[checkedTile tileSprite] setOpacity:255];
    }
    
    for (Tile *toBeRemovedTile in toRemoveTiles) {
        int xVal = [toBeRemovedTile x];
        int yVal = [toBeRemovedTile y];
        
        [spriteBatchNodeTiles removeChild:[toBeRemovedTile tileSprite] cleanup:YES];
        
        Tile *newTile;
        
        if (hasUsedFlute) {            
            if (randomFlute == 0) {
                newTile = [[Tile alloc] initWithType:kTileSword withX:xVal withY:yVal withDrop:NO];
            }
            else if (randomFlute == 1) {
                newTile = [[Tile alloc] initWithType:kTileMagic withX:xVal withY:yVal withDrop:NO];
            }
            else {
                newTile = [[Tile alloc] initWithType:kTileHeart withX:xVal withY:yVal withDrop:NO];
            }
        }
        else if (hasUsedBomb) {
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
        else if ([enemy ability] == kEnemyAbilityTransmutation) {
            newTile = [[Tile alloc] initWithType:kTileGold withX:xVal withY:yVal withDrop:NO];
        }
        else if ([enemy ability] == kEnemyAbilityGold) {
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
    
    if (hasUsedBomb) hasUsedBomb = NO;
    if (hasUsedFlute) hasUsedFlute = NO;
    if (enemyUsedBomb) enemyUsedBomb = NO;
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
    [healthbar1 setScaleX:((float)[[Player sharedPlayer] currentHP] /
                           (float)[[Player sharedPlayer] maxHP])];
    
    if (hasStatusChanged) {
        hasStatusChanged = NO;
        [self removeChild:healthbar1 cleanup:YES];
        
        if ([[Player sharedPlayer] poisonTurns] > 0) {
            healthbar1 = [[CCSprite alloc] initWithSpriteFrameName:@"HealthbarPoison.png"];
        }
        else if ([[Player sharedPlayer] shieldTurns] > 0) {
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
    
    if (hasLeveledUp) {
        [expbar setScaleX:1.0f];
    }
    else {
        [expbar setScaleX:(float)(([[Player sharedPlayer] level] * 10) -
                                  [[Player sharedPlayer] requiredExperience]) /
         (float)([[Player sharedPlayer] level] * 10)];
    }
    
    [energybar setScaleX:(float)[[Player sharedPlayer] energy] / (float)18];
    
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
    
    if ([enemy currentHP] == 0) [healthbar2 setScaleX:0];
    else if ((float)[enemy currentHP] / (float)[enemy maxHP] <= 0.05f) [healthbar2 setScaleX:-0.05f];
    else [healthbar2 setScaleX:-((float)[enemy currentHP] / (float)[enemy maxHP])];
    
    [labelPlayerHPVal setString:[NSString stringWithFormat:@"%d/%d",
                                 [[Player sharedPlayer] currentHP],
                                 [[Player sharedPlayer] maxHP]]];
    
    [labelEnemyHPVal setString:[NSString stringWithFormat:@"%d/%d", [enemy currentHP], [enemy maxHP]]];
        
    [self updateInterface];
    
    if (isTouching && isValidTouch) {
        [self updateBattleLines];
    }
    else if (toRemoveTiles.count == 0 && numOfBattleLines > 0) {
        [battleLines removeAllObjects];
        [spriteBatchNodeLines removeAllChildrenWithCleanup:YES];
        
        numOfBattleLines = 0;
    }
    
    if ([toRemoveTiles count] > 0) {
        [self updateTouchedMsg];
    }
    else {
        if (touchValueIsActive) {
            [self removeChild:labelTouchValue cleanup:YES];
            touchValueIsActive = NO;
        }
    }
        
    [self updateBattleSound];
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

    if ([[Player sharedPlayer] isBlind]) {
        [labelPlayerStatusVal setString:NSLocalizedString(@"BattleStatus08", nil)];
        [labelPlayerStatusVal setColor:ccc3(139, 69, 19)];
    }
    else if ([[Player sharedPlayer] isConfused]) {
        [labelPlayerStatusVal setString:NSLocalizedString(@"BattleStatus07", nil)];
        [labelPlayerStatusVal setColor:ccc3(205, 0, 205)];
    }
    else if ([[Player sharedPlayer] poisonTurns] > 0) {
        [labelPlayerStatusVal setString:NSLocalizedString(@"BattleStatus06", nil)];
        [labelPlayerStatusVal setColor:ccc3(46, 139, 87)];
    }
    else if ([[Player sharedPlayer] mirrorTurns] > 0) {
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
}

// updates the msg when player touches a tile
-(void)updateTouchedMsg
{
    if ([(Tile*)[toRemoveTiles lastObject] tileType] == kTileSword ||
        [(Tile*)[toRemoveTiles lastObject] tileType] == kTileMagic ||
        [(Tile*)[toRemoveTiles lastObject] tileType] == kTileHeart ||
        [(Tile*)[toRemoveTiles lastObject] tileType] == kTileGold) {
        
        if (tileChanged) {
            if (touchValueIsActive) {
                [self removeChild:labelTouchValue cleanup:YES];
                touchValueIsActive = NO;
            }
            
            int value = 0;
            
            if ([(Tile*)[toRemoveTiles lastObject] tileType] == kTileSword) {
                if (![[Player sharedPlayer] isBlind]) {
                    value = [[Player sharedPlayer] base_physical_damage];
                    value += (int)(([[Player sharedPlayer] base_physical_damage] * 0.2 * [toRemoveTiles count])
                                   + ([[Player sharedPlayer] weapon] * [toRemoveTiles count]));
                    
                    if ([[Player sharedPlayer] aleTurns] > 0) {
                        if (shieldRank == 3) value += (int)(value * 0.5);
                        else if (shieldRank == 2) value += (int)(value * 0.4);
                        else value += (int)(value * 0.2);
                    }
                    
                    if ([enemy ability] == kEnemyAbilityPhysicalDefence) {
                        value = (int)(value / 2);
                    }
                    else if ([enemy ability] == kEnemyAbilityTemporalSwift) {
                        value = (int)(value * 1.5);
                    }
                    
                    if (ability5 > 0) value += (int)(value * 6 * ability5 / 100);
                }
                                
                labelTouchValue = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"TouchDmg", nil),
                                                            value]
                                                  fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]
                                                     color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
            }
            else if ([(Tile*)[toRemoveTiles lastObject] tileType] == kTileMagic) {
                if (![[Player sharedPlayer] isBlind]) {
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
                    
                    if ([enemy ability] == kEnemyAbilityMagicalDefence) {
                        value = (int)(value / 2);
                    }
                    else if ([enemy ability] == kEnemyAbilityTemporalSwift) {
                        value = (int)(value * 1.5);
                    }
                    
                    if (ability6 > 0) value += (int)(value * 6 * ability6 / 100);
                }
                
                labelTouchValue = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"TouchDmg", nil),
                                                            value]
                                                  fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]
                                                     color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
            }
            else if ([(Tile*)[toRemoveTiles lastObject] tileType] == kTileHeart) {
                value = (int)([[Player sharedPlayer] maxHP] * (10 * [toRemoveTiles count]) / 100);
                
                if ([enemy ability] == kEnemyAbilityNullification) {
                    value = (int)(value / 2);
                }
                
                if (ability1 > 0) value += (int)(value * 6 * ability1 / 100);
                
                if ([[Player sharedPlayer] currentHP] == [[Player sharedPlayer] maxHP]) {
                    value = 0;
                }
                else if (value + [[Player sharedPlayer] currentHP] > [[Player sharedPlayer] maxHP]) {
                    value = [[Player sharedPlayer] maxHP] - [[Player sharedPlayer] currentHP];
                }
                                
                labelTouchValue = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"TouchLife", nil),
                                                            value]
                                                  fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]
                                                     color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
            }
            else if ([(Tile*)[toRemoveTiles lastObject] tileType] == kTileGold) {
                value = [toRemoveTiles count];
                
                if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
                    if (ability2 > 0) value = value * (10 + ability2);
                    else value = value * 10;
                }
                else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
                    if (ability2 > 0) value = value * (5 + ability2);
                    else value = value * 5;
                }
                else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
                    if (ability2 > 0) value = value * (4 + ability2);
                    else value = value * 4;
                }
                else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
                    if (ability2 > 0) value = value * (3 + ability2);
                    else value = value * 3;
                }
                else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
                    if (ability2 > 0) value = value * (2 + ability2);
                    else value = value * 2;
                }
                else {
                    if (ability2 > 0) value = value * (1 + ability2);
                }
                                
                labelTouchValue = [Utility labelWithString:[NSString stringWithFormat:NSLocalizedString(@"TouchGold", nil),
                                                            value]
                                                  fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]
                                                     color:ccWHITE strokeSize:[Utility getFontSize:2] stokeColor:ccBLACK];
            }
            else {
                labelTouchValue = [Utility labelWithString:@"" fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]
                                                     color:ccWHITE strokeSize:0 stokeColor:ccBLACK];
            }
            
            [self addChild:labelTouchValue z:12];
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

#pragma mark - merchant events

// buy slot 1 ability
-(void)buySlot1:(id)sender
{
    selectedSlot = currentSlot1;
    
    [itemAbilitySlot1 setSelectedIndex:1];
    [itemAbilitySlot2 setSelectedIndex:0];
    [itemAbilitySlot3 setSelectedIndex:0];
    [itemAbilitySlot4 setSelectedIndex:0];
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    [self setupItemDescription];
    [self setupShopConfirmButton];
}

// buy slot 2 ability
-(void)buySlot2:(id)sender
{
    selectedSlot = currentSlot2;
    
    [itemAbilitySlot1 setSelectedIndex:0];
    [itemAbilitySlot2 setSelectedIndex:1];
    [itemAbilitySlot3 setSelectedIndex:0];
    [itemAbilitySlot4 setSelectedIndex:0];
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    [self setupItemDescription];
    [self setupShopConfirmButton];
}

// buy slot 3 ability
-(void)buySlot3:(id)sender
{
    selectedSlot = currentSlot3;
    
    [itemAbilitySlot1 setSelectedIndex:0];
    [itemAbilitySlot2 setSelectedIndex:0];
    [itemAbilitySlot3 setSelectedIndex:1];
    [itemAbilitySlot4 setSelectedIndex:0];
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    [self setupItemDescription];
    [self setupShopConfirmButton];    
}

// exit shop without buying
-(void)exitShop:(id)sender
{
    selectedSlot = 10;
    
    [itemAbilitySlot1 setSelectedIndex:0];
    [itemAbilitySlot2 setSelectedIndex:0];
    [itemAbilitySlot3 setSelectedIndex:0];
    [itemAbilitySlot4 setSelectedIndex:1];
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    [self setupItemDescription];
    
    itemShopConfirm.visible = YES;
    itemShopConfirm.isEnabled = YES;
    itemShopNoGold.visible = NO;
    itemShopNoGold.isEnabled = NO;
}

// setups item description
-(void)setupItemDescription
{
    NSString *description;
    
    [self removeChild:itemDescription cleanup:YES];
    
    if (selectedSlot == 1) {
        if (ability1 == 15) {
            description = NSLocalizedString(@"MerchantAbility01", nil);
        }
        else if (ability1 == 14) {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility01x", nil),
                           [self getUpgradeCost:ability1]];
        }
        else {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility01xx", nil),
                           ability1 + 1, [self getUpgradeCost:ability1]];
        }
    }
    else if (selectedSlot == 2) {
        if (ability2 == 15) {
            description = NSLocalizedString(@"MerchantAbility02", nil);
        }
        else if (ability2 == 14) {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility02x", nil),
                           [self getUpgradeCost:ability2]];
        }
        else {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility02xx", nil),
                           ability2 + 1, [self getUpgradeCost:ability2]];
        }
    }
    else if (selectedSlot == 3) {
        if (ability3 == 15) {
            description = NSLocalizedString(@"MerchantAbility03", nil);
        }
        else if (ability3 == 14) {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility03x", nil),
                           [self getUpgradeCost:ability3]];
        }
        else {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility03xx", nil),
                           ability3 + 1, [self getUpgradeCost:ability3]];
        }
    }
    else if (selectedSlot == 4) {
        if (ability4 == 15) {
            description = NSLocalizedString(@"MerchantAbility04", nil);
        }
        else if (ability4 == 14) {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility04x", nil),
                           [self getUpgradeCost:ability4]];
        }
        else {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility04xx", nil),
                           ability4 + 1, [self getUpgradeCost:ability4]];
        }
    }
    else if (selectedSlot == 5) {
        if (ability5 == 15) {
            description = NSLocalizedString(@"MerchantAbility05", nil);
        }
        else if (ability5 == 10) {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility05x", nil),
                           [self getUpgradeCost:ability5]];
        }
        else {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility05xx", nil),
                           ability5 + 1, [self getUpgradeCost:ability5]];
        }
    }
    else if (selectedSlot == 6) {
        if (ability6 == 15) {
            description = NSLocalizedString(@"MerchantAbility06", nil);
        }
        else if (ability6 == 14) {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility06x", nil),
                           [self getUpgradeCost:ability6]];
        }
        else {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility06xx", nil),
                           ability6 + 1, [self getUpgradeCost:ability6]];
        }
    }
    else if (selectedSlot == 7) {
        if (ability7 == 15) {
            description = NSLocalizedString(@"MerchantAbility07", nil);
        }
        else if (ability7 == 14) {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility07x", nil),
                           [self getUpgradeCost:ability7]];
        }
        else {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility07xx", nil),
                           ability7 + 1, [self getUpgradeCost:ability7]];
        }
    }
    else if (selectedSlot == 8) {
        if (ability8 == 15) {
            description = NSLocalizedString(@"MerchantAbility08", nil);
        }
        else if (ability8 == 14) {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility08x", nil),
                           [self getUpgradeCost:ability8]];
        }
        else {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility08xx", nil),
                           ability8 + 1, [self getUpgradeCost:ability8]];
        }
    }
    else if (selectedSlot == 9) {
        if (ability9 == 15) {
            description = NSLocalizedString(@"MerchantAbility09", nil);
        }
        else if (ability9 == 14) {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility09x", nil),
                           [self getUpgradeCost:ability9]];
        }
        else {
            description = [NSString stringWithFormat:NSLocalizedString(@"MerchantAbility09xx", nil),
                           ability9 + 1, [self getUpgradeCost:ability9]];
        }
    }
    else if (selectedSlot == 10) {
        description = NSLocalizedString(@"MerchantMsg03", nil);
    }
    
    itemDescription = [Utility labelWithString:description
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [itemDescription setPosition:ccp(screenSize.width/2, screenSize.height/2 -100)];
    }
    else {
        [itemDescription setPosition:ccp(screenSize.width/2, screenSize.height/2 - (100 * 2.133f))];
    }
    
    [self addChild:itemDescription z:9 tag:20];
}

// gets the upgrade cost
-(int)getUpgradeCost:(int)value
{
    int cost;
    
    if (value == 0) cost = 10;
    else if (value == 1) cost = 20;
    else if (value == 2) cost = 50;
    else if (value == 3) cost = 100;
    else if (value == 4) cost = 150;
    else if (value == 5) cost = 300;
    else if (value == 6) cost = 500;
    else if (value == 7) cost = 750;
    else if (value == 8) cost = 1000;
    else if (value == 9) cost = 1250;
    else if (value == 10) cost = 1500;
    else if (value == 11) cost = 2000;
    else if (value == 12) cost = 2500;
    else if (value == 13) cost = 3500;
    else if (value == 14) cost = 5000;
    
    if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
        cost = cost * 10;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
        cost = cost * 5;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
        cost = cost * 4;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
        cost = cost * 3;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
        cost = cost * 2;
    }
    
    return cost;
}

// setups shop confirm button
-(void)setupShopConfirmButton
{
    if (selectedSlot == 1) {
        if (coins < [self getUpgradeCost:ability1] ||
            ([[Player sharedPlayer] ability1] <= 1 && ability1 == 5) ||
            ([[Player sharedPlayer] ability1] == 2 && ability1 == 10) ||
            ([[Player sharedPlayer] ability1] == 3 && ability1 == 15)) {
            
            itemShopConfirm.isEnabled = NO;
            itemShopNoGold.isEnabled = YES;
        }
        else {
            itemShopConfirm.isEnabled = YES;
            itemShopNoGold.isEnabled = NO;
        }
    }
    else if (selectedSlot == 2) {
        if (coins < [self getUpgradeCost:ability2] ||
            ([[Player sharedPlayer] ability2] <= 1 && ability2 == 5) ||
            ([[Player sharedPlayer] ability2] == 2 && ability2 == 10) ||
            ([[Player sharedPlayer] ability2] == 3 && ability2 == 15)) {
            
            itemShopConfirm.isEnabled = NO;
            itemShopNoGold.isEnabled = YES;
        }
        else {
            itemShopConfirm.isEnabled = YES;
            itemShopNoGold.isEnabled = NO;
        }
    }
    else if (selectedSlot == 3) {
        if (coins < [self getUpgradeCost:ability3] ||
            ([[Player sharedPlayer] ability3] <= 1 && ability3 == 5) ||
            ([[Player sharedPlayer] ability3] == 2 && ability3 == 10) ||
            ([[Player sharedPlayer] ability3] == 3 && ability3 == 15)) {
            
            itemShopConfirm.isEnabled = NO;
            itemShopNoGold.isEnabled = YES;
        }
        else {
            itemShopConfirm.isEnabled = YES;
            itemShopNoGold.isEnabled = NO;
        }
    }
    else if (selectedSlot == 4) {
        if (coins < [self getUpgradeCost:ability4] ||
            ([[Player sharedPlayer] ability4] <= 1 && ability4 == 5) ||
            ([[Player sharedPlayer] ability4] == 2 && ability4 == 10) ||
            ([[Player sharedPlayer] ability4] == 3 && ability4 == 15)) {
            
            itemShopConfirm.isEnabled = NO;
            itemShopNoGold.isEnabled = YES;
        }
        else {
            itemShopConfirm.isEnabled = YES;
            itemShopNoGold.isEnabled = NO;
        }
    }
    else if (selectedSlot == 5) {
        if (coins < [self getUpgradeCost:ability5] ||
            ([[Player sharedPlayer] ability5] <= 1 && ability5 == 5) ||
            ([[Player sharedPlayer] ability5] == 2 && ability5 == 10) ||
            ([[Player sharedPlayer] ability5] == 3 && ability5 == 15)) {
            
            itemShopConfirm.isEnabled = NO;
            itemShopNoGold.isEnabled = YES;
        }
        else {
            itemShopConfirm.isEnabled = YES;
            itemShopNoGold.isEnabled = NO;
        }
    }
    else if (selectedSlot == 6) {
        if (coins < [self getUpgradeCost:ability6] ||
            ([[Player sharedPlayer] ability6] <= 1 && ability6 == 5) ||
            ([[Player sharedPlayer] ability6] == 2 && ability6 == 10) ||
            ([[Player sharedPlayer] ability6] == 3 && ability6 == 15)) {
            
            itemShopConfirm.isEnabled = NO;
            itemShopNoGold.isEnabled = YES;
        }
        else {
            itemShopConfirm.isEnabled = YES;
            itemShopNoGold.isEnabled = NO;
        }
    }
    else if (selectedSlot == 7) {
        if (coins < [self getUpgradeCost:ability7] ||
            ([[Player sharedPlayer] ability7] <= 1 && ability7 == 5) ||
            ([[Player sharedPlayer] ability7] == 2 && ability7 == 10) ||
            ([[Player sharedPlayer] ability7] == 3 && ability7 == 15)) {
            
            itemShopConfirm.isEnabled = NO;
            itemShopNoGold.isEnabled = YES;
        }
        else {
            itemShopConfirm.isEnabled = YES;
            itemShopNoGold.isEnabled = NO;
        }
    }
    else if (selectedSlot == 8) {
        if (coins < [self getUpgradeCost:ability8] ||
            ([[Player sharedPlayer] ability8] <= 1 && ability8 == 5) ||
            ([[Player sharedPlayer] ability8] == 2 && ability8 == 10) ||
            ([[Player sharedPlayer] ability8] == 3 && ability8 == 15)) {
            
            itemShopConfirm.isEnabled = NO;
            itemShopNoGold.isEnabled = YES;
        }
        else {
            itemShopConfirm.isEnabled = YES;
            itemShopNoGold.isEnabled = NO;
        }
    }
    else if (selectedSlot == 9) {
        if (coins < [self getUpgradeCost:ability9] ||
            ([[Player sharedPlayer] ability9] <= 1 && ability9 == 5) ||
            ([[Player sharedPlayer] ability9] == 2 && ability9 == 10) ||
            ([[Player sharedPlayer] ability9] == 3 && ability9 == 15)) {
            
            itemShopConfirm.isEnabled = NO;
            itemShopNoGold.isEnabled = YES;
        }
        else {
            itemShopConfirm.isEnabled = YES;
            itemShopNoGold.isEnabled = NO;
        }
    }
    
    if (!itemShopConfirm.isEnabled) itemShopConfirm.visible = NO;
    else itemShopConfirm.visible = YES;
    
    if (!itemShopNoGold.isEnabled) itemShopNoGold.visible = NO;
    else itemShopNoGold.visible = YES;
}

// confirm shop choice
-(void)confirmShop
{
    for (Tile *checkedTile in puzzleContents) {
        [[checkedTile tileSprite] setOpacity:255];
    }
    
    [itemAbilitySlot1 removeChild:spriteAbility1 cleanup:YES];
    [itemAbilitySlot2 removeChild:spriteAbility2 cleanup:YES];
    [itemAbilitySlot3 removeChild:spriteAbility3 cleanup:YES];
    [itemAbilitySlot4 removeChild:shopExit cleanup:YES];
    [self removeChild:menuShop cleanup:YES];
    [self removeChild:shopLabel cleanup:YES];
    [self removeChild:itemDescription cleanup:YES];
    
    if (selectedSlot == 1) {
        coins -= [self getUpgradeCost:ability1];
        ability1++;
    }
    else if (selectedSlot == 2) {
        coins -= [self getUpgradeCost:ability2];
        ability2++;
    }
    else if (selectedSlot == 3) {
        coins -= [self getUpgradeCost:ability3];
        ability3++;
    }
    else if (selectedSlot == 4) {
        coins -= [self getUpgradeCost:ability4];
        ability4++;
    }
    else if (selectedSlot == 5) {
        coins -= [self getUpgradeCost:ability5];
        ability5++;
    }
    else if (selectedSlot == 6) {
        coins -= [self getUpgradeCost:ability6];
        ability6++;
    }
    else if (selectedSlot == 7) {
        coins -= [self getUpgradeCost:ability7];
        ability7++;
    }
    else if (selectedSlot == 8) {
        coins -= [self getUpgradeCost:ability8];
        ability8++;
    }
    else if (selectedSlot == 9) {
        coins -= [self getUpgradeCost:ability9];
        ability9++;
    }
        
    if (selectedSlot != 10) {
        isShopOpen = NO;
        self.isTouchEnabled = NO;
        menuPause.isTouchEnabled = NO;
        hasBattleEnded = YES;
        selectedSlot = 0;
        
        nextEnemy = [[Enemy alloc] initWithBattleRound:battleRound + 1];
        
        events_layer = [[BattleEventsLayer alloc] initWithNewEnemy:nextEnemy];
        
        [self scheduleOnce:@selector(addLayer:) delay:0.8f];
        [self scheduleOnce:@selector(cleanLayer:) delay:1.6f];
    }
    else {
        isShopOpen = NO;
        selectedSlot = 0;
        self.isTouchEnabled = YES;
        menuButtons.isTouchEnabled = YES;
    }
}

#pragma mark - battle events

// progresses battle
-(void)progressBattle
{
    self.isTouchEnabled = NO;
    menuButtons.isTouchEnabled = NO;
    menuPause.isTouchEnabled = NO;
    
    TileType type = [[toRemoveTiles lastObject] tileType];
    
    if ([[Player sharedPlayer] isConfused]) {
        [[Player sharedPlayer] setIsConfused:NO];
        
        int confusionRandom = arc4random_uniform(4);
        
        if (confusionRandom == 3) type = kTileSword;
        else if (confusionRandom == 2) type = kTileMagic;
        else if (confusionRandom == 1) type = kTileGold;
        else if (confusionRandom == 0) type = kTileHeart;
    }
    
    if ([[Player sharedPlayer] poisonTurns] > 0) {
        [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
         (int)([[Player sharedPlayer] currentHP] * 0.1)];
        
        if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
        
        hasStatusChanged = YES;
    }
        
    if (type == kTileSword) {
        if ([[Player sharedPlayer] classVal] == 5) {
            if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
                coins += 10 * [toRemoveTiles count];
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
                coins += 5 * [toRemoveTiles count];
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
                coins += 4 * [toRemoveTiles count];
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
                coins += 3 * [toRemoveTiles count];
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
                coins += 2 * [toRemoveTiles count];
            }
            else {
                coins += [toRemoveTiles count];
            }
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
    else if (type == kTileEmblem1 || type == kTileEmblem2 ||
             type == kTileEmblem3 || type == kTileEmblem4) {
        
        [[GameManager sharedGameManager] writeEmblemProgress];
        
        [self scheduleOnce:@selector(rebuildsPuzzle:) delay:0.0f];
        [self scheduleOnce:@selector(progressStory:) delay:0.2f];
    }
    else if (type == kTileHeroShield) {
        hasFoundHeroShield = YES;
        
        [self scheduleOnce:@selector(rebuildsPuzzle:) delay:0.0f];
        [self scheduleOnce:@selector(progressStory:) delay:0.3f];
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

// checks if player won the battle
-(void)checkIfBattleWon:(ccTime)dt
{
    if (ability8 > 0) {
        [[Player sharedPlayer] setCurrentHP:
         (int)([[Player sharedPlayer] currentHP] + 5 +
               (2 * ability8 * [[Player sharedPlayer] maxHP] / 100))];
        
        if ([[Player sharedPlayer] currentHP] > [[Player sharedPlayer] maxHP]) {
            [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] maxHP]];
        }
    }
    
    if (ability9 > 0) {
        [enemy setCurrentHP:
         (int)([enemy currentHP] - 5 -
               (2 * ability9 * [[Player sharedPlayer] maxHP] / 100))];
    }
    
    if ([enemy currentHP] <= 0) {
        [enemy setCurrentHP:0];
        
        if ([enemy rank] == kEnemyRankBoss) {
            [[GameCenterManager sharedGameCenterManager] checkAchievementsBossMonsterKill];
        }
        else if ([enemy rank] == kEnemyRankSpecial) {
            [[GameCenterManager sharedGameCenterManager] checkAchievementsSpecialMonsterKill];
        }
        
        if ([enemy ability] == kEnemyAbilityEarthquake) {
            [[GameCenterManager sharedGameCenterManager] checkAchievementsQuake];
        }
        
        if ([enemy ability] == kEnemyAbilityDragonFire &&
            [[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
            
            [[GameCenterManager sharedGameCenterManager] checkAchievementsDragonSlayer];
        }
        
        if ([enemy rank] == kEnemyRankMerchant) {
            if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
                coins += 20 * battleRound;
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
                coins += 10 * battleRound;
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
                coins += 8 * battleRound;
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
                coins += 6 * battleRound;
            }
            else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
                coins += 4 * battleRound;
            }
            else {
                coins += 2 * battleRound;
            }
        }
        
        if ([enemy ability] == kEnemyAbilityExperience) totalExp += [enemy exp] * 2;
        else totalExp += [enemy exp];
        
        if (ability3 > 0) totalExp += (int)([enemy exp] * 6 * ability3 / 100);
        
        hasBattleEnded = YES;
        
        if ([[Player sharedPlayer] level] < 999 &&
            ([[Player sharedPlayer] requiredExperience] - [enemy exp]) <= 0) {
            
            [[GameManager sharedGameManager] writeExp:[enemy exp]];
            [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] + kLifePerLevelUp];
            
            nextEnemy = [[Enemy alloc] initWithBattleRound:battleRound + 1];
            hasLeveledUp = YES;
            
            events_layer = [[BattleEventsLayer alloc] initWithLevelUp];
            
            [self scheduleOnce:@selector(addLayer:) delay:0.8f];
            [self schedule:@selector(cleanLayer:) interval:1.6f];
        }
        else {
            [[GameManager sharedGameManager] writeExp:[enemy exp]];
            
            nextEnemy = [[Enemy alloc] initWithBattleRound:battleRound + 1];
                        
            events_layer = [[BattleEventsLayer alloc] initWithNewEnemy:nextEnemy];
            
            [self scheduleOnce:@selector(addLayer:) delay:0.8f];
            [self scheduleOnce:@selector(cleanLayer:) delay:1.6f];
        }
    }
    else {
        [self scheduleOnce:@selector(enemyAttack:) delay:0.4f];
    }
}

// checks if player lost the battle
-(void)checkIfBattleLost
{
    if ([[Player sharedPlayer] currentHP] <= 0) {
        [[Player sharedPlayer] setCurrentHP:0];
        
        [self update:0];
        [self pauseSchedulerAndActions];
        
        hasBattleEnded = YES;
        
        if (hasFoundHeroShield) [[GameManager sharedGameManager] writeShieldUpgradeData];
        
        BattleDefeatLayer *defeat_layer = [[BattleDefeatLayer alloc] initWithExp:totalExp
                                                                       withCoins:coins
                                                                      withRounds:battleRound - 1];
        
        [self addChild:defeat_layer z:10];
    }
}

// adds battle msg layer
-(void)addLayer:(ccTime)dt
{
    [self addChild:events_layer z:10];
}

// cleans battle msg layer
-(void)cleanLayer:(ccTime)dt
{
    [self removeChild:events_layer cleanup:YES];
        
    if (hasLeveledUp) {
        hasLeveledUp = NO;
        
        if ([[Player sharedPlayer] level] == 100 ||
            [[Player sharedPlayer] level] == 40 ||
            [[Player sharedPlayer] level] == 12)
        {
            hasUnlockedClasses = YES;
            
            events_layer = [[BattleEventsLayer alloc] initWithUnlockClasses];
        }
        else {
            events_layer = [[BattleEventsLayer alloc] initWithNewEnemy:nextEnemy];
        }
        
        [self addChild:events_layer z:10];        
    }
    else if (hasUnlockedClasses) {
        hasUnlockedClasses = NO;
        
        events_layer = [[BattleEventsLayer alloc] initWithNewEnemy:nextEnemy];
        
        [self addChild:events_layer z:10];
    }
    else if (hasBattleEnded) {
        hasBattleEnded = NO;
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] + 1];
        
        if (ability4 > 0) {
            if (6 * ability4 > arc4random_uniform(100)) {
                [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] + 1];
            }
        }
        
        if ([[Player sharedPlayer] energy] > 18) [[Player sharedPlayer] setEnergy:18];
        
        [self unschedule:@selector(cleanLayer:)];
        [self setupNextBattle];
    }
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
    
    if ([enemy ability] == kEnemyAbilityPhysicalDefence) {
        playerDamage = (int)(playerDamage / 2);
    }
    else if ([enemy ability] == kEnemyAbilityTemporalSwift) {
        playerDamage = (int)(playerDamage * 1.5);
    }
    
    if (ability5 > 0) playerDamage += (int)(playerDamage * 6 * ability5 / 100);
    
    if ([[Player sharedPlayer] isBlind] ||
        ([[Player sharedPlayer] aleTurns] > 0 &&
         arc4random_uniform(100) < 10)) {
        
        playerDamage = 0;
        
        events_layer = [[BattleEventsLayer alloc] initWithMiss];
        
        [self addChild:events_layer z:10];
        
        [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
        [self scheduleOnce:@selector(cleanLayer:) delay:0.8f];
        [self scheduleOnce:@selector(enemyGetsDamaged:) delay:0.8f];
        [[SoundManager sharedSoundManager] playSwordHitEffect];
    }
    else {
        [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
        [self scheduleOnce:@selector(enemyGetsDamaged:) delay:0.0f];
        [[SoundManager sharedSoundManager] playSwordHitEffect];
    }
}

// attacks with magic damage
-(void)attackMagic:(ccTime)dt
{
    int combo = 0;
    
    if (tileMagicType1 > 2 && tileMagicType2 > 2 &&
        [[GameManager sharedGameManager] questType] == kQuestType8) {
    }
    
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
    
    if ([enemy ability] == kEnemyAbilityMagicalDefence) {
        playerDamage = (int)(playerDamage / 2);
    }
    else if ([enemy ability] == kEnemyAbilityTemporalSwift) {
        playerDamage = (int)(playerDamage * 1.5);
    }
    
    if (ability6 > 0) playerDamage += (int)(playerDamage * 6 * ability6 / 100);
    
    if ([[Player sharedPlayer] isBlind] ||
        ([[Player sharedPlayer] aleTurns] > 0 &&
         arc4random_uniform(100) < 10)) {
        
        playerDamage = 0;
        
        events_layer = [[BattleEventsLayer alloc] initWithMiss];
        
        [self addChild:events_layer z:10];
        
        [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
        [self scheduleOnce:@selector(cleanLayer:) delay:0.8f];
        [self scheduleOnce:@selector(enemyGetsDamaged:) delay:0.8f];
        [[SoundManager sharedSoundManager] playMagicHitEffect];
    }
    else {
        [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
        [self scheduleOnce:@selector(enemyGetsDamaged:) delay:0.0f];
        [[SoundManager sharedSoundManager] playMagicHitEffect];
    }
}

// player heals
-(void)playerHeals:(ccTime)dt
{
    int healing = (int)([[Player sharedPlayer] maxHP] * (10 * removedTiles) / 100);
    
    if (arc4random_uniform(100) < [[Player sharedPlayer] critical_heal_percentage]) {
        healing = healing * 2;
    }
    
    if (ability1 > 0) healing += (int)(healing * 6 * ability1 / 100);
    
    if ([[Player sharedPlayer] runeTurns] > 0) {
        int crit_chance;
        
        if (runeRank == 3) crit_chance = 80;
        else if (runeRank == 2) crit_chance = 50;
        else crit_chance = 20;
        
        if (arc4random_uniform(100) < crit_chance) {
            healing = (int)(healing * 1.5f);
        }
    }
    
    if ([enemy ability] == kEnemyAbilityNullification) {
        healing = (int)(healing / 2);
    }
    
    [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] + healing];
    
    if ([[Player sharedPlayer] currentHP] > [[Player sharedPlayer] maxHP]) {
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] maxHP]];
    }
        
    [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
    [self scheduleOnce:@selector(checkIfBattleWon:) delay:0.3f];
    [[SoundManager sharedSoundManager] playHeartEffect];
}

// player gathers coins
-(void)playerGathersCoins:(ccTime)dt
{
    int newCoin = removedTiles;
    
    if (newCoin == 36) [[GameCenterManager sharedGameCenterManager] checkAchievementsFeelingRich];
    
    if ([[GameManager sharedGameManager] currentDungeon] == kDungeonRealmOfMadness) {
        if (ability2 > 0) newCoin = newCoin * (10 + ability2);
        else newCoin = newCoin * 10;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonSanctumOfDestiny) {
        if (ability2 > 0) newCoin = newCoin * (5 + ability2);
        else newCoin = newCoin * 5;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonTempleOfOldOnes) {
        if (ability2 > 0) newCoin = newCoin * (4 + ability2);
        else newCoin = newCoin * 4;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonForgottenCatacombs) {
        if (ability2 > 0) newCoin = newCoin * (3 + ability2);
        else newCoin = newCoin * 3;
    }
    else if ([[GameManager sharedGameManager] currentDungeon] == kDungeonUndergroundLake) {
        if (ability2 > 0) newCoin = newCoin * (2 + ability2);
        else newCoin = newCoin * 2;
    }
    else {
        if (ability2 > 0) newCoin = newCoin * (1 + ability2);
    }
    
    coins += newCoin;
    
    if ([[Player sharedPlayer] classVal] == 4 &&
        arc4random_uniform(100) < 50) {
        
        int healing = (int)([[Player sharedPlayer] maxHP] * (5 * removedTiles) / 100);
        
        if (arc4random_uniform(100) < [[Player sharedPlayer] critical_heal_percentage]) {
            healing = healing * 2;
        }
        
        if ([enemy ability] == kEnemyAbilityNullification) {
            healing = (int)(healing / 2);
        }
        
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] + healing];
        
        if ([[Player sharedPlayer] currentHP] > [[Player sharedPlayer] maxHP]) {
            [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] maxHP]];
        }
    }
        
    [spriteBatchNodeAnimatedTiles removeAllChildrenWithCleanup:YES];
    [self scheduleOnce:@selector(checkIfBattleWon:) delay:0.3f];
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
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    if ([[Player sharedPlayer] classVal] == 2) [[Player sharedPlayer] setShieldTurns:5];
    else [[Player sharedPlayer] setShieldTurns:3];
    
    if ([[Player sharedPlayer] energy] == 18) {
        shieldRank = 3;
        
        [[GameCenterManager sharedGameCenterManager] checkAchievementsShieldThirdRank];
        
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
    
    if ([[Player sharedPlayer] poisonTurns] > 0) {
        [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
         (int)([[Player sharedPlayer] currentHP] * 0.1)];
        
        if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
        
        hasStatusChanged = YES;
    }
    
    hasStatusChanged = YES;
    
    [[SoundManager sharedSoundManager] playShieldEffect];
}

// uses the potion item
-(void)useItemPotion
{
    self.isTouchEnabled = NO;
    menuButtons.isTouchEnabled = NO;
    menuPause.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    if ([[Player sharedPlayer] currentHP] <= [[Player sharedPlayer] maxHP] * 0.1) {
        [[GameCenterManager sharedGameCenterManager] checkAchievementsLowHealthPotion];
    }
    
    int healing = 0;
    
    if ([[Player sharedPlayer] energy] == 18) {
        healing = [[Player sharedPlayer] maxHP];
        
        [[GameCenterManager sharedGameCenterManager] checkAchievementsPotionThirdRank];
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 18];
    }
    else if ([[Player sharedPlayer] energy] >= 12) {
        healing = (int)([[Player sharedPlayer] maxHP] * 0.75);
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 12];
    }
    else {
        healing = (int)([[Player sharedPlayer] maxHP] * 0.5);
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
    }
    
    if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
    
    if ([enemy ability] == kEnemyAbilityNullification) healing = (int)(healing * 0.5);
    
    [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] + healing];
    
    if ([[Player sharedPlayer] currentHP] > [[Player sharedPlayer] maxHP]) {
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] maxHP]];
    }
    
    if ([[Player sharedPlayer] poisonTurns] > 0) {
        [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
         (int)([[Player sharedPlayer] currentHP] * 0.1)];
        
        if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
        
        hasStatusChanged = YES;
    }
    
    [[SoundManager sharedSoundManager] playPotionEffect];

    [self scheduleOnce:@selector(checkIfBattleWon:) delay:0.0f];
}

// uses the bomb item
-(void)useItemBomb
{
    self.isTouchEnabled = NO;
    menuButtons.isTouchEnabled = NO;
    menuPause.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
    
    if (!([enemy ability] == kEnemyAbilitySabotage)) {
        hasUsedBomb = YES;
        
        for (Tile *tile in puzzleContents) [toRemoveTiles addObject:tile];
    }
    
    if ([[Player sharedPlayer] energy] == 18) {
        playerDamage = (int)([enemy maxHP] * 0.75);
        
        [[GameCenterManager sharedGameCenterManager] checkAchievementsBombThirdRank];
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 18];
    }
    else if ([[Player sharedPlayer] energy] >= 12) {
        playerDamage = (int)([enemy maxHP] * 0.5);
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 12];
    }
    else {
        playerDamage = (int)([enemy maxHP] * 0.25);
        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
    }
    
    if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
    
    if ([[Player sharedPlayer] classVal] == 8) {
        playerDamage += (int)([enemy maxHP] * 0.20);
    }
    
    if ([enemy ability] == kEnemyAbilityTemporalSwift) {
        playerDamage = (int)(playerDamage * 1.5);
    }
    
    if ([enemy currentHP] - playerDamage <= 0) {
        [[GameCenterManager sharedGameCenterManager] checkAchievementsKillWithABomb];
    }
    
    if ([[Player sharedPlayer] poisonTurns] > 0) {
        [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
         (int)([[Player sharedPlayer] currentHP] * 0.1)];
        
        if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
        
        hasStatusChanged = YES;
    }
    
    [[SoundManager sharedSoundManager] playBombEffect];
    
    if (!([enemy ability] == kEnemyAbilitySabotage)) {
        [self scheduleOnce:@selector(transmutePuzzle:) delay:0.0f];
    }
    
    [self scheduleOnce:@selector(enemyGetsDamaged:) delay:0.0f];
}

// uses the ale item
-(void)useItemAle
{
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
    
    if ([[Player sharedPlayer] poisonTurns] > 0) {
        [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
         (int)([[Player sharedPlayer] currentHP] * 0.1)];
        
        if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
        
        hasStatusChanged = YES;
    }
    
    hasStatusChanged = YES;
    
    [[SoundManager sharedSoundManager] playPotionEffect];
}

// uses the rune item
-(void)useItemRune
{
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
    
    if ([[Player sharedPlayer] poisonTurns] > 0) {
        [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
         (int)([[Player sharedPlayer] currentHP] * 0.1)];
        
        if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
        
        hasStatusChanged = YES;
    }
    
    hasStatusChanged = YES;
    
    [[SoundManager sharedSoundManager] playShieldEffect];
}

// uses the mirror item
-(void)useItemMirror
{
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
    
    if ([[Player sharedPlayer] poisonTurns] > 0) {
        [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
         (int)([[Player sharedPlayer] currentHP] * 0.1)];
        
        if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
        
        hasStatusChanged = YES;
    }
    
    hasStatusChanged = YES;
    
    [[SoundManager sharedSoundManager] playMagicHitEffect];
}

// uses the flute item
-(void)useItemFlute
{
    self.isTouchEnabled = NO;
    menuButtons.isTouchEnabled = NO;
    menuPause.isTouchEnabled = NO;
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;
        
    if ([[Player sharedPlayer] energy] == 18) {                
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 18];
        
        if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
        
        if ([[Player sharedPlayer] poisonTurns] > 0) {
            [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
            [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
             (int)([[Player sharedPlayer] currentHP] * 0.1)];
            
            if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
            
            hasStatusChanged = YES;
        }
        
        [[SoundManager sharedSoundManager] playVictoryEffect];
        
        isShopOpen = NO;
        self.isTouchEnabled = NO;
        menuPause.isTouchEnabled = NO;
        hasBattleEnded = YES;
        selectedSlot = 0;
        
        nextEnemy = [[Enemy alloc] initWithBattleRound:5];
        
        events_layer = [[BattleEventsLayer alloc] initWithNewEnemy:nextEnemy];
        
        [self scheduleOnce:@selector(addLayer:) delay:0.8f];
        [self scheduleOnce:@selector(cleanLayer:) delay:1.6f];
    }
    else if ([[Player sharedPlayer] energy] >= 12) {        
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 12];
        
        if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
        
        if ([[Player sharedPlayer] poisonTurns] > 0) {
            [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
            [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
             (int)([[Player sharedPlayer] currentHP] * 0.1)];
            
            if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
            
            hasStatusChanged = YES;
        }
        
        [[SoundManager sharedSoundManager] playVictoryEffect];
        
        isShopOpen = NO;
        self.isTouchEnabled = NO;
        menuPause.isTouchEnabled = NO;
        hasBattleEnded = YES;
        selectedSlot = 0;
        
        nextEnemy = [[Enemy alloc] initWithBattleRound:battleRound + 1];
        
        events_layer = [[BattleEventsLayer alloc] initWithNewEnemy:nextEnemy];
        
        [self scheduleOnce:@selector(addLayer:) delay:0.8f];
        [self scheduleOnce:@selector(cleanLayer:) delay:1.6f];
    }
    else {
        for (Tile *tile in puzzleContents) [toRemoveTiles addObject:tile];
        
        hasUsedFlute = YES;

        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 6];
        
        if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
        
        if ([[Player sharedPlayer] poisonTurns] > 0) {
            [[Player sharedPlayer] setPoisonTurns:[[Player sharedPlayer] poisonTurns] - 1];
            [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
             (int)([[Player sharedPlayer] currentHP] * 0.1)];
            
            if ([[Player sharedPlayer] currentHP] == 0) [[Player sharedPlayer] setCurrentHP:1];
            
            hasStatusChanged = YES;
        }
        
        [[SoundManager sharedSoundManager] playVictoryEffect];
                
        [self scheduleOnce:@selector(transmutePuzzle:) delay:0.0f];
        [self scheduleOnce:@selector(checkIfBattleWon:) delay:0.0f];
    }
}

// enemy gets damaged and UI is updated
-(void)enemyGetsDamaged:(ccTime)dt
{    
    if (playerDamage >= [enemy currentHP]) playerDamage = [enemy currentHP];
    [enemy setCurrentHP:[enemy currentHP] - playerDamage];
    
    if ([enemy currentHP] > 0 && [enemy ability] == kEnemyAbilityReflect) {
        [[Player sharedPlayer] setCurrentHP:
         [[Player sharedPlayer] currentHP] - (int)(playerDamage * 0.5)];
    }
    
    [self scheduleOnce:@selector(checkIfBattleWon:) delay:0.1f];
}

// progressesStory (eg. pick up emblem or hero shield)
-(void)progressStory:(ccTime)dt
{
    events_layer = [[BattleEventsLayer alloc] initWithProgressStory];
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(cleanLayer:) delay:0.8];
    [self scheduleOnce:@selector(enemyAttack:) delay:1.2f];
}

#pragma mark - enemy events

// enemy attacks the player
-(void)enemyAttack:(ccTime)dt
{
    enemyDamage = [enemy damage];
    
    enemyRage++;
    
    if (([enemy rank] == kEnemyRankBoss && enemyRage > 3) ||
        ([enemy rank] == kEnemyRankSpecial && enemyRage > 5) ||
        ([enemy rank] == kEnemyRankNormal && enemyRage > 7)) {
        
        enemyDamage += (int)(enemyDamage * enemyRage / 20);
    }
        
    if ([[Player sharedPlayer] level] > 5) {
        if (arc4random_uniform(2) == 1) enemyDamage +=
            arc4random_uniform((int)([[Player sharedPlayer] level]/5));
        else enemyDamage -= arc4random_uniform((int)([[Player sharedPlayer] level]/5));
    }
    
    if ([enemy ability] == kEnemyAbilityTemporalSwift) {
        enemyDamage = (int)(enemyDamage * 1.5);
    }
    
    enemyDamage -= (int)(enemyDamage * [[Player sharedPlayer] damage_reduction] / 100);
    
    if (ability7 > 0) enemyDamage -= (int)(enemyDamage * 6 * ability7 / 100);
    
    if ([[Player sharedPlayer] shieldTurns] > 0) {
        int original_damage = enemyDamage;
        
        if ([[Player sharedPlayer] shield] == 2) {
            if (shieldRank == 3) enemyDamage = (int)(enemyDamage * 0.5);
            else if (shieldRank == 2) enemyDamage = (int)(enemyDamage * 0.7);
            else enemyDamage = (int)(enemyDamage * 0.9);
        }
        else if ([[Player sharedPlayer] shield] == 1) {
            if (shieldRank == 3) enemyDamage = (int)(enemyDamage * 0.3);
            else if (shieldRank == 2) enemyDamage = (int)(enemyDamage * 0.5);
            else enemyDamage = (int)(enemyDamage * 0.7);
        }
        
        if ([[Player sharedPlayer] currentHP] - original_damage <= 0 &&
            [[Player sharedPlayer] currentHP] - enemyDamage > 0) {
            
            [[GameCenterManager sharedGameCenterManager] checkAchievementsSurviveWithShield];
        }
    }
    
    if ([enemy rank] == kEnemyRankMerchant) enemyDamage = 1;
    
    if ([[Player sharedPlayer] mirrorTurns] > 0) {
        int reflected_dmg = 1;
        
        if (mirrorRank == 3) reflected_dmg += (int)(enemyDamage * 0.3);
        else if (mirrorRank == 2) reflected_dmg += (int)(enemyDamage * 0.2);
        else reflected_dmg += (int)(enemyDamage * 0.1);
        
        [enemy setCurrentHP:[enemy currentHP] - reflected_dmg];
        if ([enemy currentHP] <= 0) [enemy setCurrentHP:1];
    }
    
    events_layer = [[BattleEventsLayer alloc] initWithEnemy:enemy
                                                 withDamage:enemyDamage];
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(cleanLayer:) delay:0.8f];
    [self scheduleOnce:@selector(playerGetsDamaged:) delay:0.8f];
}

// player gets damaged and UI is updated
-(void)playerGetsDamaged:(ccTime)dt
{
    [self removeChild:events_layer cleanup:YES];
    
    if (enemyDamage >= [[Player sharedPlayer] currentHP]) enemyDamage = [[Player sharedPlayer] currentHP];
    [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] - enemyDamage];
        
    if ([[Player sharedPlayer] shieldTurns] > 0) {
        [[Player sharedPlayer] setShieldTurns:[[Player sharedPlayer] shieldTurns] - 1];
        
        hasStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] aleTurns] > 0) {
        [[Player sharedPlayer] setAleTurns:[[Player sharedPlayer] aleTurns] - 1];
        
        hasStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] runeTurns] > 0) {
        [[Player sharedPlayer] setRuneTurns:[[Player sharedPlayer] runeTurns] - 1];
        
        hasStatusChanged = YES;
    }
    
    if ([[Player sharedPlayer] mirrorTurns] > 0) {
        [[Player sharedPlayer] setMirrorTurns:[[Player sharedPlayer] mirrorTurns] - 1];
        
        hasStatusChanged = YES;
    }
    
    [self checkIfBattleLost];
    
    if (!hasBattleEnded) {
        if ([enemy ability] != kEnemyAbilityFreezeTime) {
            [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] + 1];
            
            if (ability4 > 0) {
                if (6 * ability4 > arc4random_uniform(100)) {
                    [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] + 1];
                }
            }
            
            if ([[Player sharedPlayer] energy] > 18) [[Player sharedPlayer] setEnergy:18];
        }
        
        if ([[Player sharedPlayer] isBlind]) [[Player sharedPlayer] setIsBlind:NO];
        
        if ([enemy ability] == kEnemyAbilityTeleport) {
            hasUsedBomb = YES;
            for (Tile *tile in puzzleContents) [toRemoveTiles addObject:tile];
            [self scheduleOnce:@selector(transmutePuzzle:) delay:0.0f];
        }
        
        if (([enemy ability] == kEnemyAbilityTransmutation &&
             arc4random_uniform(100) < 10) ||
            
            ([enemy ability] == kEnemyAbilityGold &&
             arc4random_uniform(100) < 10) ||
            
            ([enemy ability] == kEnemyAbilityEarthquake &&
             arc4random_uniform(100) < 35) ||
            
            ([enemy ability] == kEnemyAbilityNegateEnergy &&
             arc4random_uniform(100) < 50) ||
            
            ([enemy ability] == kEnemyAbilityDragonFire &&
             arc4random_uniform(100) < 20) ||
            
            ([enemy ability] == kEnemyAbilityPoison &&
             arc4random_uniform(100) < 35) ||
            
            ([enemy ability] == kEnemyAbilityDoubleStrike &&
             arc4random_uniform(100) < 75) ||
            
            ([enemy ability] == kEnemyAbilityBlind &&
             arc4random_uniform(100) < 20) ||
            
            ([enemy ability] == kEnemyAbilityConfusion &&
             arc4random_uniform(100) < 35) ||
            
            ([enemy ability] == kEnemyAbilityDrainLife &&
             arc4random_uniform(100) < 75) ||
            
            ([enemy ability] == kEnemyAbilityHeal && [enemy currentHP] < [enemy maxHP] &&
             arc4random_uniform(100) < 75)) {
                
            [self scheduleOnce:@selector(enemyUsesAbility:) delay:0.3f];
        }
        else {
            self.isTouchEnabled = YES;
            menuButtons.isTouchEnabled = YES;
            menuPause.isTouchEnabled = YES;
        }
    }
}

// enemy uses ability in the end of battle turn
-(void)enemyUsesAbility:(ccTime)dt
{
    events_layer = [[BattleEventsLayer alloc] initWithEnemyMessage:enemy];
    
    [self addChild:events_layer z:10];
    
    [self scheduleOnce:@selector(abilityWasUsed:) delay:0.8f];
}

// enemy ability was used in the end of battle turn
-(void)abilityWasUsed:(ccTime)dt
{
    [self removeChild:events_layer cleanup:YES];
    
    if ([enemy ability] == kEnemyAbilityTransmutation) {
        enemyUsedBomb = YES;
        for (Tile *tile in puzzleContents) {
            if ([tile tileType] == kTileHeart) [toRemoveTiles addObject:tile];
        }        
        [self scheduleOnce:@selector(transmutePuzzle:) delay:0.0f];
    }
    
    else if ([enemy ability] == kEnemyAbilityGold) {
        enemyUsedBomb = YES;
        for (Tile *tile in puzzleContents) [toRemoveTiles addObject:tile];
        [self scheduleOnce:@selector(transmutePuzzle:) delay:0.0f];
    }
    
    else if ([enemy ability] == kEnemyAbilityEarthquake) {
        [[Player sharedPlayer] setCurrentHP:(int)([[Player sharedPlayer] currentHP] * 0.5)];
        if ([[Player sharedPlayer] currentHP] < 1) [[Player sharedPlayer] setCurrentHP:1];
        enemyUsedBomb = YES;
        for (Tile *tile in puzzleContents) [toRemoveTiles addObject:tile];
        [self scheduleOnce:@selector(rebuildsPuzzle:) delay:0.0f];
    }
    
    else if ([enemy ability] == kEnemyAbilityBlind) {
        [[Player sharedPlayer] setIsBlind:YES];
        hasStatusChanged = YES;
    }
    
    else if ([enemy ability] == kEnemyAbilityConfusion) {
        [[Player sharedPlayer] setIsConfused:YES];
        hasStatusChanged = YES;
    }
    
    else if ([enemy ability] == kEnemyAbilityNegateEnergy) {
        [[Player sharedPlayer] setEnergy:[[Player sharedPlayer] energy] - 2];
        if ([[Player sharedPlayer] energy] < 0) [[Player sharedPlayer] setEnergy:0];
    }
    
    else if ([enemy ability] == kEnemyAbilityDragonFire) {
        if ([[Player sharedPlayer] currentHP] == 1) [[Player sharedPlayer] setCurrentHP:0];
        else [[Player sharedPlayer] setCurrentHP:1];
    }
    
    else if ([enemy ability] == kEnemyAbilityPoison) {
        [[Player sharedPlayer] setPoisonTurns:3];
        hasStatusChanged = YES;
    }
    
    else if ([enemy ability] == kEnemyAbilityDoubleStrike) {
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
         (int)([[Player sharedPlayer] maxHP] * 0.15)];
    }
    
    else if ([enemy ability] == kEnemyAbilityDrainLife) {
        [[Player sharedPlayer] setCurrentHP:[[Player sharedPlayer] currentHP] -
         (int)([[Player sharedPlayer] maxHP] * 0.10)];
        [enemy setCurrentHP:[enemy currentHP] + (int)([enemy maxHP] * 0.10)];
        if ([enemy currentHP] >= [enemy maxHP]) [enemy setCurrentHP:[enemy maxHP]];
    }
    
    else if ([enemy ability] == kEnemyAbilityHeal) {
        [enemy setCurrentHP:[enemy currentHP] + (int)([enemy maxHP] * 0.05)];
        if ([enemy currentHP] >= [enemy maxHP]) [enemy setCurrentHP:[enemy maxHP]];
    }
    
    [self checkIfBattleLost];
    
    if (!hasBattleEnded) {
        self.isTouchEnabled = YES;
        menuButtons.isTouchEnabled = YES;
        menuPause.isTouchEnabled = YES;
    }
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
    else {
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
                isTouching = YES;
                                
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
    else {
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
    isTouching = NO;
    
    if ([toRemoveTiles count] > 2 ||
        [(Tile*)[toRemoveTiles lastObject] tileType] == kTileEmblem1 ||
        [(Tile*)[toRemoveTiles lastObject] tileType] == kTileEmblem2 ||
        [(Tile*)[toRemoveTiles lastObject] tileType] == kTileEmblem3 ||
        [(Tile*)[toRemoveTiles lastObject] tileType] == kTileEmblem4 ||
        [(Tile*)[toRemoveTiles lastObject] tileType] == kTileHeroShield) {
        
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

// shows the help scene
-(void)showHelp
{
    self.isTouchEnabled = NO;
    menuButtons.isTouchEnabled = NO;
    menuPause.isTouchEnabled = NO;
    
    ccColor4B colour = {0, 0, 0, 0};
    BattleHelpLayer *help_layer = [[BattleHelpLayer alloc] initWithColor:colour];
    
    [self addChild:help_layer z:20];
}

// pauses the game
-(void)pauseGame
{
    [self pauseSchedulerAndActions];
        
    self.isTouchEnabled = NO;
    menuButtons.isTouchEnabled = NO;
    menuPause.isTouchEnabled = NO;
    
    PauseLayer *pause_layer = [[PauseLayer alloc] initWithExp:[[Player sharedPlayer] requiredExperience]
                                                    withCoins:coins
                                                    withRound:battleRound];
    
    [self addChild:pause_layer z:20];
}

// resumes the game after a pause
-(void)resumeGameWithHelp:(BOOL)value
{
    [self resumeSchedulerAndActions];
    
    if (playerStats.visible) playerStats.visible = NO;
    if (enemyStats.visible) enemyStats.visible = NO;

    if (!isShopOpen) {
        self.isTouchEnabled = YES;
        menuButtons.isTouchEnabled = YES;
    }
    
    menuPause.isTouchEnabled = YES;
    
    if (value) [self showHelp];
}

@end
