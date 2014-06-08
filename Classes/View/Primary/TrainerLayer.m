//
//  TrainerLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 09/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "TrainerLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "TrainerUpgradeLayer.h"
#import "SkillsHelpLayer.h"
#import "Utility.h"

#pragma mark - TrainerLayer

@implementation TrainerLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	TrainerLayer *layer = [TrainerLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {        
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"Menu.png"];
        trainerBG = [CCSprite spriteWithFile:@"SkillsMenu.png"];
        menuBar01 = [CCSprite spriteWithFile:@"menubar.png"];
        menuBar02 = [CCSprite spriteWithFile:@"menubar.png"];
        
        [self setupSkillMenu];
        
        if (screenSize.height == 568.00) {
            [self setupUpperBar];
        }
        
        labelTrainer = [Utility labelWithString:NSLocalizedString(@"TrainerLabel", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelCombat = [Utility labelWithString:NSLocalizedString(@"Combat", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                        color:ccc3(0, 255, 127) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelSurvival = [Utility labelWithString:NSLocalizedString(@"Survival", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                        color:ccc3(0, 255, 127) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelPractical = [Utility labelWithString:NSLocalizedString(@"Practical", nil)
                                         fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                        color:ccc3(0, 255, 127) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];

        labelCombatSkill1 = [Utility labelWithString:NSLocalizedString(@"TrainerName01", nil)
                                            fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                               color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelCombatSkill2 = [Utility labelWithString:NSLocalizedString(@"TrainerName02", nil)
                                            fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                               color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelCombatSkill3 = [Utility labelWithString:NSLocalizedString(@"TrainerName03", nil)
                                            fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                               color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelSurvivalSkill1 = [Utility labelWithString:NSLocalizedString(@"TrainerName04", nil)
                                              fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelSurvivalSkill2 = [Utility labelWithString:NSLocalizedString(@"TrainerName05", nil)
                                              fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelSurvivalSkill3 = [Utility labelWithString:NSLocalizedString(@"TrainerName06", nil)
                                              fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelPracticalSkill1 = [Utility labelWithString:NSLocalizedString(@"TrainerName07", nil)
                                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                  color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelPracticalSkill2 = [Utility labelWithString:NSLocalizedString(@"TrainerName08", nil)
                                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                  color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelPracticalSkill3 = [Utility labelWithString:NSLocalizedString(@"TrainerName09", nil)
                                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                  color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
                
        itemTavern = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"TavernLabel", nil)
                                                                            fontName:@"Shark Crash"
                                                                            fontSize:[Utility getFontSize:26]
                                                                               color:ccWHITE
                                                                          strokeSize:[Utility getFontSize:1.5]
                                                                          stokeColor:ccBLACK]
                      
                                             selectedSprite:[Utility labelWithString:NSLocalizedString(@"TavernLabel", nil)
                                                                            fontName:@"Shark Crash"
                                                                            fontSize:[Utility getFontSize:26]
                                                                               color:ccc3(255, 204, 102)
                                                                          strokeSize:[Utility getFontSize:1.5]
                                                                          stokeColor:ccBLACK]
                      
                                                     target:self selector:@selector(showTavern)];
        
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
        
        itemUpgradeCombat1 = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                    selectedImage:@"upgrade_btn_pressed.png"
                                                    disabledImage:@"upgrade_btn2.png"
                                                           target:self
                                                         selector:@selector(upgradeCombatSkill1)];
        itemUpgradeCombat2 = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                    selectedImage:@"upgrade_btn_pressed.png"
                                                    disabledImage:@"upgrade_btn2.png"
                                                           target:self
                                                         selector:@selector(upgradeCombatSkill2)];
        itemUpgradeCombat3 = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                    selectedImage:@"upgrade_btn_pressed.png"
                                                    disabledImage:@"upgrade_btn2.png"
                                                           target:self
                                                         selector:@selector(upgradeCombatSkill3)];
        
        itemUpgradeSurvival1 = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                      selectedImage:@"upgrade_btn_pressed.png"
                                                      disabledImage:@"upgrade_btn2.png"
                                                             target:self
                                                           selector:@selector(upgradeSurvivalSkill1)];
        itemUpgradeSurvival2 = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                      selectedImage:@"upgrade_btn_pressed.png"
                                                      disabledImage:@"upgrade_btn2.png"
                                                             target:self
                                                           selector:@selector(upgradeSurvivalSkill2)];
        itemUpgradeSurvival3 = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                      selectedImage:@"upgrade_btn_pressed.png"
                                                      disabledImage:@"upgrade_btn2.png"
                                                             target:self
                                                           selector:@selector(upgradeSurvivalSkill3)];
        
        itemUpgradePractical1 = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                       selectedImage:@"upgrade_btn_pressed.png"
                                                       disabledImage:@"upgrade_btn2.png"
                                                              target:self
                                                            selector:@selector(upgradePracticalSkill1)];
        itemUpgradePractical2 = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                       selectedImage:@"upgrade_btn_pressed.png"
                                                       disabledImage:@"upgrade_btn2.png"
                                                              target:self
                                                            selector:@selector(upgradePracticalSkill2)];
        itemUpgradePractical3 = [CCMenuItemImage itemWithNormalImage:@"upgrade_btn.png"
                                                       selectedImage:@"upgrade_btn_pressed.png"
                                                       disabledImage:@"upgrade_btn2.png"
                                                              target:self
                                                            selector:@selector(upgradePracticalSkill3)];
        
        [self updateSkillCounters];
        [self updateSkillButtons];
        
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
		
		menuChoice = [CCMenu menuWithItems:itemTavern, itemShop, nil];
        menuUpgrades = [CCMenu menuWithItems:itemUpgradeCombat1, itemUpgradeCombat2, itemUpgradeCombat3,
                        itemUpgradeSurvival1, itemUpgradeSurvival2, itemUpgradeSurvival3,
                        itemUpgradePractical1, itemUpgradePractical2, itemUpgradePractical3, nil];
        menuOptions = [CCMenu menuWithItems:itemHelp, itemMenu, nil];
        
        [labelCombat setAnchorPoint:ccp(0, 0)];
        [labelSurvival setAnchorPoint:ccp(0, 0)];
        [labelPractical setAnchorPoint:ccp(0, 0)];
        [labelCombatVal setAnchorPoint:ccp(1, 0)];
        [labelSurvivalVal setAnchorPoint:ccp(1, 0)];
        [labelPracticalVal setAnchorPoint:ccp(1, 0)];
        [labelCombatSkill1 setAnchorPoint:ccp(0, 0)];
        [labelCombatSkill2 setAnchorPoint:ccp(0, 0)];
        [labelCombatSkill3 setAnchorPoint:ccp(0, 0)];
        [labelSurvivalSkill1 setAnchorPoint:ccp(0, 0)];
        [labelSurvivalSkill2 setAnchorPoint:ccp(0, 0)];
        [labelSurvivalSkill3 setAnchorPoint:ccp(0, 0)];
        [labelPracticalSkill1 setAnchorPoint:ccp(0, 0)];
        [labelPracticalSkill2 setAnchorPoint:ccp(0, 0)];
        [labelPracticalSkill3 setAnchorPoint:ccp(0, 0)];
        [labelCombatSkill1Val setAnchorPoint:ccp(1, 0)];
        [labelCombatSkill2Val setAnchorPoint:ccp(1, 0)];
        [labelCombatSkill3Val setAnchorPoint:ccp(1, 0)];
        [labelSurvivalSkill1Val setAnchorPoint:ccp(1, 0)];
        [labelSurvivalSkill2Val setAnchorPoint:ccp(1, 0)];
        [labelSurvivalSkill3Val setAnchorPoint:ccp(1, 0)];
        [labelPracticalSkill1Val setAnchorPoint:ccp(1, 0)];
        [labelPracticalSkill2Val setAnchorPoint:ccp(1, 0)];
        [labelPracticalSkill3Val setAnchorPoint:ccp(1, 0)];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [trainerBG setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
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
            
            [itemTavern setPosition:ccp(-100, 218)];
            [itemShop setPosition:ccp(0, 218)];
            [labelTrainer setPosition:ccp(screenSize.width/2 + 100, screenSize.height/2 + 218)];
            
            [labelCombat setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 169)];
            [labelSurvival setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 33)];
            [labelPractical setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 103)];
            [labelCombatVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 168)];
            [labelSurvivalVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 32)];
            [labelPracticalVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 104)];
            
            [labelCombatSkill1 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 128)];
            [labelCombatSkill2 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 102)];
            [labelCombatSkill3 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 76)];
            [labelSurvivalSkill1 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 9)];
            [labelSurvivalSkill2 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 35)];
            [labelSurvivalSkill3 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 61)];
            [labelPracticalSkill1 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 144)];
            [labelPracticalSkill2 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 170)];
            [labelPracticalSkill3 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 196)];
            
            [labelCombatSkill1Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 128)];
            [labelCombatSkill2Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 102)];
            [labelCombatSkill3Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 76)];
            [labelSurvivalSkill1Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 9)];
            [labelSurvivalSkill2Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 35)];
            [labelSurvivalSkill3Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 61)];
            [labelPracticalSkill1Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 144)];
            [labelPracticalSkill2Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 170)];
            [labelPracticalSkill3Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 196)];
            
            [itemUpgradeCombat1 setPosition:ccp(120, 136)];
            [itemUpgradeCombat2 setPosition:ccp(120, 111)];
            [itemUpgradeCombat3 setPosition:ccp(120, 86)];
            [itemUpgradeSurvival1 setPosition:ccp(120, -1)];
            [itemUpgradeSurvival2 setPosition:ccp(120, -26)];
            [itemUpgradeSurvival3 setPosition:ccp(120, -51)];
            [itemUpgradePractical1 setPosition:ccp(120, -136)];
            [itemUpgradePractical2 setPosition:ccp(120, -161)];
            [itemUpgradePractical3 setPosition:ccp(120, -186)];
        }
        else {
            [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (233 * 2.133f))];

            [itemTavern setPosition:ccp(-(100 * 2.4f), (218.5 * 2.133f))];
            [itemShop setPosition:ccp(0, (218.5 * 2.133f))];
            [labelTrainer setPosition:ccp(screenSize.width/2 + (100 * 2.4f), screenSize.height/2 + (218.5 * 2.133f))];
            
            [labelCombat setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (168 * 2.133f))];
            [labelSurvival setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (32 * 2.133f))];
            [labelPractical setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (104 * 2.133f))];
            [labelCombatVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (166 * 2.133f))];
            [labelSurvivalVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (30 * 2.133f))];
            [labelPracticalVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (106 * 2.133f))];
            
            [labelCombatSkill1 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (127 * 2.133f))];
            [labelCombatSkill2 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (101 * 2.133f))];
            [labelCombatSkill3 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (75 * 2.133f))];
            [labelSurvivalSkill1 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (10 * 2.133f))];
            [labelSurvivalSkill2 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (36 * 2.133f))];
            [labelSurvivalSkill3 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (62 * 2.133f))];
            [labelPracticalSkill1 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (145 * 2.133f))];
            [labelPracticalSkill2 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (171 * 2.133f))];
            [labelPracticalSkill3 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (197 * 2.133f))];
            
            [labelCombatSkill1Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (127 * 2.133f))];
            [labelCombatSkill2Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (101 * 2.133f))];
            [labelCombatSkill3Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (75 * 2.133f))];
            [labelSurvivalSkill1Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (10 * 2.133f))];
            [labelSurvivalSkill2Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (36 * 2.133f))];
            [labelSurvivalSkill3Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (62 * 2.133f))];
            [labelPracticalSkill1Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (145 * 2.133f))];
            [labelPracticalSkill2Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (171 * 2.133f))];
            [labelPracticalSkill3Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (197 * 2.133f))];
            
            [itemUpgradeCombat1 setPosition:ccp(120 * 2.4f, 136 * 2.133f)];
            [itemUpgradeCombat2 setPosition:ccp(120 * 2.4f, 111 * 2.133f)];
            [itemUpgradeCombat3 setPosition:ccp(120 * 2.4f, 86 * 2.133f)];
            [itemUpgradeSurvival1 setPosition:ccp(120 * 2.4f, -(1 * 2.133f))];
            [itemUpgradeSurvival2 setPosition:ccp(120 * 2.4f, -(26 * 2.133f))];
            [itemUpgradeSurvival3 setPosition:ccp(120 * 2.4f, -(51 * 2.133f))];
            [itemUpgradePractical1 setPosition:ccp(120 * 2.4f, -(136 * 2.133f))];
            [itemUpgradePractical2 setPosition:ccp(120 * 2.4f, -(161 * 2.133f))];
            [itemUpgradePractical3 setPosition:ccp(120 * 2.4f, -(186 * 2.133f))];
            
            [menuOptions alignItemsHorizontallyWithPadding:(180 * 2.4f)];
            [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - (224 * 2.133f))];
        }
        
        [self addChild:background z:-2 tag:0];
        [self addChild:trainerBG z:-1 tag:1];
        [self addChild:menuBar02 z:0 tag:2];
        [self addChild:labelTrainer z:1 tag:3];
		[self addChild:labelCombat z:1 tag:4];
        [self addChild:labelSurvival z:1 tag:5];
        [self addChild:labelPractical z:1 tag:6];
        [self addChild:labelCombatVal z:1 tag:7];
        [self addChild:labelSurvivalVal z:1 tag:8];
        [self addChild:labelPracticalVal z:1 tag:9];
        [self addChild:labelCombatSkill1 z:1 tag:10];
        [self addChild:labelCombatSkill2 z:1 tag:11];
        [self addChild:labelCombatSkill3 z:1 tag:12];
        [self addChild:labelSurvivalSkill1 z:1 tag:13];
        [self addChild:labelSurvivalSkill2 z:1 tag:14];
        [self addChild:labelSurvivalSkill3 z:1 tag:15];
        [self addChild:labelPracticalSkill1 z:1 tag:16];
        [self addChild:labelPracticalSkill2 z:1 tag:17];
        [self addChild:labelPracticalSkill3 z:1 tag:18];
        [self addChild:labelCombatSkill1Val z:1 tag:19];
        [self addChild:labelCombatSkill2Val z:1 tag:20];
        [self addChild:labelCombatSkill3Val z:1 tag:21];
        [self addChild:labelSurvivalSkill1Val z:1 tag:22];
        [self addChild:labelSurvivalSkill2Val z:1 tag:23];
        [self addChild:labelSurvivalSkill3Val z:1 tag:24];
        [self addChild:labelPracticalSkill1Val z:1 tag:25];
        [self addChild:labelPracticalSkill2Val z:1 tag:26];
        [self addChild:labelPracticalSkill3Val z:1 tag:27];
        [self addChild:menuChoice z:1 tag:28];
        [self addChild:menuUpgrades z:1 tag:29];
        [self addChild:menuOptions z:1 tag:30];
        
        if (screenSize.height == 568.00) {
            [self addChild:menuBar01 z:0 tag:31];
            [self addChild:labelMsg z:1 tag:32];
        }
        
        [self scheduleUpdate];
        
        if ([[Player sharedPlayer] level] < 20) {
            [itemUpgradeCombat3 setIsEnabled:NO];
            [itemUpgradeSurvival3 setIsEnabled:NO];
        }
        
        if ([[Player sharedPlayer] level] < 30) {
            [itemUpgradePractical3 setIsEnabled:NO];
        }
	}
    
	return self;
}

#pragma mark - scene setup

// setups the skills menu
-(void)setupSkillMenu
{
    [self setupSkills];
    
    labelCombatVal = [Utility labelWithString:totalCombat fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSurvivalVal = [Utility labelWithString:totalSurvival fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPracticalVal = [Utility labelWithString:totalPractical fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                           color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelCombatSkill1Val = [Utility labelWithString:combatSkill1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                              color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelCombatSkill2Val = [Utility labelWithString:combatSkill2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                              color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelCombatSkill3Val = [Utility labelWithString:combatSkill3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                              color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSurvivalSkill1Val = [Utility labelWithString:survivalSkill1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSurvivalSkill2Val = [Utility labelWithString:survivalSkill2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSurvivalSkill3Val = [Utility labelWithString:survivalSkill3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPracticalSkill1Val = [Utility labelWithString:practicalSkill1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPracticalSkill2Val = [Utility labelWithString:practicalSkill2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPracticalSkill3Val = [Utility labelWithString:practicalSkill3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
}

// setups the upper bar
-(void)setupUpperBar
{
    labelMsg = [Utility labelWithString:[Utility setupRandomMsg]
                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:16]
                                  color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263)];
}

-(void)updateSkillCounters
{
    if ([[Player sharedPlayer] combatSkill1] == 10 &&
        [[Player sharedPlayer] combatSkill2] == 10 &&
        [[Player sharedPlayer] combatSkill3] == 10) {
        [labelCombatVal setColor:ccc3(255, 204, 102)];
    }
    
    if ([[Player sharedPlayer] survivalSkill1] == 10 &&
        [[Player sharedPlayer] survivalSkill2] == 10 &&
        [[Player sharedPlayer] survivalSkill3] == 10) {
        [labelSurvivalVal setColor:ccc3(255, 204, 102)];
    }
    
    if ([[Player sharedPlayer] practicalSkill1] == 10 &&
        [[Player sharedPlayer] practicalSkill2] == 10 &&
        [[Player sharedPlayer] practicalSkill3] == 10) {
        [labelPracticalVal setColor:ccc3(255, 204, 102)];
    }
}

-(void)updateSkillButtons
{
    if ([[Player sharedPlayer] combatSkill1] == 10) [itemUpgradeCombat1 setIsEnabled:NO];
    if ([[Player sharedPlayer] combatSkill2] == 10) [itemUpgradeCombat2 setIsEnabled:NO];
    if ([[Player sharedPlayer] combatSkill3] == 10) [itemUpgradeCombat3 setIsEnabled:NO];
    if ([[Player sharedPlayer] survivalSkill1] == 10) [itemUpgradeSurvival1 setIsEnabled:NO];
    if ([[Player sharedPlayer] survivalSkill2] == 10) [itemUpgradeSurvival2 setIsEnabled:NO];
    if ([[Player sharedPlayer] survivalSkill3] == 10) [itemUpgradeSurvival3 setIsEnabled:NO];
    if ([[Player sharedPlayer] practicalSkill1] == 10) [itemUpgradePractical1 setIsEnabled:NO];
    if ([[Player sharedPlayer] practicalSkill2] == 10) [itemUpgradePractical2 setIsEnabled:NO];
    if ([[Player sharedPlayer] practicalSkill3] == 10) [itemUpgradePractical3 setIsEnabled:NO];
}

#pragma mark - setup skills descriptions

// setups skills descriptions
-(void)setupSkills
{
    int skillValue = 0;
    
    totalCombat = [NSString stringWithFormat:@"%d / 30",
                   ([[Player sharedPlayer] combatSkill1] +
                    [[Player sharedPlayer] combatSkill2] +
                    [[Player sharedPlayer] combatSkill3])];
    
    totalSurvival = [NSString stringWithFormat:@"%d / 30",
                     ([[Player sharedPlayer] survivalSkill1] +
                      [[Player sharedPlayer] survivalSkill2] +
                      [[Player sharedPlayer] survivalSkill3])];
    
    totalPractical = [NSString stringWithFormat:@"%d / 30",
                      ([[Player sharedPlayer] practicalSkill1] +
                       [[Player sharedPlayer] practicalSkill2] +
                       [[Player sharedPlayer] practicalSkill3])];
    
    if ([[Player sharedPlayer] combatSkill1] == 0) {
        combatSkill1 = NSLocalizedString(@"TrainerSkillInit01", nil);
    }
    else {
        if ([[Player sharedPlayer] combatSkill1] == 1) skillValue = 2;
        else if ([[Player sharedPlayer] combatSkill1] == 2) skillValue = 4;
        else if ([[Player sharedPlayer] combatSkill1] == 3) skillValue = 6;
        else if ([[Player sharedPlayer] combatSkill1] == 4) skillValue = 8;
        else if ([[Player sharedPlayer] combatSkill1] == 5) skillValue = 10;
        else if ([[Player sharedPlayer] combatSkill1] == 6) skillValue = 12;
        else if ([[Player sharedPlayer] combatSkill1] == 7) skillValue = 14;
        else if ([[Player sharedPlayer] combatSkill1] == 8) skillValue = 16;
        else if ([[Player sharedPlayer] combatSkill1] == 9) skillValue = 18;
        else if ([[Player sharedPlayer] combatSkill1] == 10) skillValue = 20;
        
        combatSkill1 = [NSString stringWithFormat:NSLocalizedString(@"TrainerSkill01", nil), skillValue];
    }
        
    if ([[Player sharedPlayer] combatSkill2] == 0) {
        combatSkill2 = NSLocalizedString(@"TrainerSkillInit02", nil);
    }
    else {
        if ([[Player sharedPlayer] combatSkill2] == 1) skillValue = 2;
        else if ([[Player sharedPlayer] combatSkill2] == 2) skillValue = 4;
        else if ([[Player sharedPlayer] combatSkill2] == 3) skillValue = 6;
        else if ([[Player sharedPlayer] combatSkill2] == 4) skillValue = 8;
        else if ([[Player sharedPlayer] combatSkill2] == 5) skillValue = 10;
        else if ([[Player sharedPlayer] combatSkill2] == 6) skillValue = 12;
        else if ([[Player sharedPlayer] combatSkill2] == 7) skillValue = 14;
        else if ([[Player sharedPlayer] combatSkill2] == 8) skillValue = 16;
        else if ([[Player sharedPlayer] combatSkill2] == 9) skillValue = 18;
        else if ([[Player sharedPlayer] combatSkill2] == 10) skillValue = 20;
        
        combatSkill2 = [NSString stringWithFormat:NSLocalizedString(@"TrainerSkill02", nil), skillValue];
    }
    
    if ([[Player sharedPlayer] level] < 20) {
        combatSkill3 = NSLocalizedString(@"TrainerUnlock01", nil);
    }
    else if ([[Player sharedPlayer] combatSkill3] == 0) {
        combatSkill3 = NSLocalizedString(@"TrainerSkillInit03", nil);
    }
    else {
        if ([[Player sharedPlayer] combatSkill3] == 1) skillValue = 1;
        else if ([[Player sharedPlayer] combatSkill3] == 2) skillValue = 2;
        else if ([[Player sharedPlayer] combatSkill3] == 3) skillValue = 3;
        else if ([[Player sharedPlayer] combatSkill3] == 4) skillValue = 4;
        else if ([[Player sharedPlayer] combatSkill3] == 5) skillValue = 5;
        else if ([[Player sharedPlayer] combatSkill3] == 6) skillValue = 6;
        else if ([[Player sharedPlayer] combatSkill3] == 7) skillValue = 7;
        else if ([[Player sharedPlayer] combatSkill3] == 8) skillValue = 8;
        else if ([[Player sharedPlayer] combatSkill3] == 9) skillValue = 9;
        else if ([[Player sharedPlayer] combatSkill3] == 10) skillValue = 10;
        
        combatSkill3 = [NSString stringWithFormat:NSLocalizedString(@"TrainerSkill03", nil), skillValue];
    }
    
    if ([[Player sharedPlayer] survivalSkill1] == 0) {
        survivalSkill1 = NSLocalizedString(@"TrainerSkillInit04", nil);
    }
    else {
        if ([[Player sharedPlayer] survivalSkill1] == 1) skillValue = 10;
        else if ([[Player sharedPlayer] survivalSkill1] == 2) skillValue = 30;
        else if ([[Player sharedPlayer] survivalSkill1] == 3) skillValue = 60;
        else if ([[Player sharedPlayer] survivalSkill1] == 4) skillValue = 100;
        else if ([[Player sharedPlayer] survivalSkill1] == 5) skillValue = 150;
        else if ([[Player sharedPlayer] survivalSkill1] == 6) skillValue = 210;
        else if ([[Player sharedPlayer] survivalSkill1] == 7) skillValue = 280;
        else if ([[Player sharedPlayer] survivalSkill1] == 8) skillValue = 360;
        else if ([[Player sharedPlayer] survivalSkill1] == 9) skillValue = 450;
        else if ([[Player sharedPlayer] survivalSkill1] == 10) skillValue = 550;
        
        survivalSkill1 = [NSString stringWithFormat:NSLocalizedString(@"TrainerSkill04", nil), skillValue];
    }
    
    if ([[Player sharedPlayer] survivalSkill2] == 0) {
        survivalSkill2 = NSLocalizedString(@"TrainerSkillInit05", nil);
    }
    else {
        if ([[Player sharedPlayer] survivalSkill2] == 1) skillValue = 2;
        else if ([[Player sharedPlayer] survivalSkill2] == 2) skillValue = 4;
        else if ([[Player sharedPlayer] survivalSkill2] == 3) skillValue = 6;
        else if ([[Player sharedPlayer] survivalSkill2] == 4) skillValue = 8;
        else if ([[Player sharedPlayer] survivalSkill2] == 5) skillValue = 10;
        else if ([[Player sharedPlayer] survivalSkill2] == 6) skillValue = 12;
        else if ([[Player sharedPlayer] survivalSkill2] == 7) skillValue = 14;
        else if ([[Player sharedPlayer] survivalSkill2] == 8) skillValue = 16;
        else if ([[Player sharedPlayer] survivalSkill2] == 9) skillValue = 18;
        else if ([[Player sharedPlayer] survivalSkill2] == 10) skillValue = 20;
        
        survivalSkill2 = [NSString stringWithFormat:NSLocalizedString(@"TrainerSkill05", nil), skillValue];
    }
    
    if ([[Player sharedPlayer] level] < 20) {
        survivalSkill3 = NSLocalizedString(@"TrainerUnlock01", nil);
    }
    else if ([[Player sharedPlayer] survivalSkill3] == 0) {
        survivalSkill3 = NSLocalizedString(@"TrainerSkillInit06", nil);
    }
    else {
        if ([[Player sharedPlayer] survivalSkill3] == 1) skillValue = 1;
        else if ([[Player sharedPlayer] survivalSkill3] == 2) skillValue = 2;
        else if ([[Player sharedPlayer] survivalSkill3] == 3) skillValue = 3;
        else if ([[Player sharedPlayer] survivalSkill3] == 4) skillValue = 4;
        else if ([[Player sharedPlayer] survivalSkill3] == 5) skillValue = 5;
        else if ([[Player sharedPlayer] survivalSkill3] == 6) skillValue = 6;
        else if ([[Player sharedPlayer] survivalSkill3] == 7) skillValue = 7;
        else if ([[Player sharedPlayer] survivalSkill3] == 8) skillValue = 8;
        else if ([[Player sharedPlayer] survivalSkill3] == 9) skillValue = 9;
        else if ([[Player sharedPlayer] survivalSkill3] == 10) skillValue = 10;
        
        survivalSkill3 = [NSString stringWithFormat:NSLocalizedString(@"TrainerSkill06", nil), skillValue];
    }
    
    if ([[Player sharedPlayer] practicalSkill1] == 0) {
        practicalSkill1 = NSLocalizedString(@"TrainerSkillInit07", nil);
    }
    else {
        if ([[Player sharedPlayer] practicalSkill1] == 1) skillValue = 2;
        else if ([[Player sharedPlayer] practicalSkill1] == 2) skillValue = 4;
        else if ([[Player sharedPlayer] practicalSkill1] == 3) skillValue = 6;
        else if ([[Player sharedPlayer] practicalSkill1] == 4) skillValue = 8;
        else if ([[Player sharedPlayer] practicalSkill1] == 5) skillValue = 10;
        else if ([[Player sharedPlayer] practicalSkill1] == 6) skillValue = 12;
        else if ([[Player sharedPlayer] practicalSkill1] == 7) skillValue = 14;
        else if ([[Player sharedPlayer] practicalSkill1] == 8) skillValue = 16;
        else if ([[Player sharedPlayer] practicalSkill1] == 9) skillValue = 18;
        else if ([[Player sharedPlayer] practicalSkill1] == 10) skillValue = 20;
        
        practicalSkill1 = [NSString stringWithFormat:NSLocalizedString(@"TrainerSkill07", nil), skillValue];
    }
    
    if ([[Player sharedPlayer] practicalSkill2] == 0) {
        practicalSkill2 = NSLocalizedString(@"TrainerSkillInit08", nil);
    }
    else {
        if ([[Player sharedPlayer] practicalSkill2] == 1) skillValue = 2;
        else if ([[Player sharedPlayer] practicalSkill2] == 2) skillValue = 4;
        else if ([[Player sharedPlayer] practicalSkill2] == 3) skillValue = 6;
        else if ([[Player sharedPlayer] practicalSkill2] == 4) skillValue = 8;
        else if ([[Player sharedPlayer] practicalSkill2] == 5) skillValue = 10;
        else if ([[Player sharedPlayer] practicalSkill2] == 6) skillValue = 12;
        else if ([[Player sharedPlayer] practicalSkill2] == 7) skillValue = 14;
        else if ([[Player sharedPlayer] practicalSkill2] == 8) skillValue = 16;
        else if ([[Player sharedPlayer] practicalSkill2] == 9) skillValue = 18;
        else if ([[Player sharedPlayer] practicalSkill2] == 10) skillValue = 20;
        
        practicalSkill2 = [NSString stringWithFormat:NSLocalizedString(@"TrainerSkill08", nil), skillValue];
    }
    
    if ([[Player sharedPlayer] level] < 30) {
        practicalSkill3 = NSLocalizedString(@"TrainerUnlock02", nil);
    }
    else if ([[Player sharedPlayer] practicalSkill3] == 0) {
        practicalSkill3 = NSLocalizedString(@"TrainerSkillInit09", nil);
    }
    else {
        if ([[Player sharedPlayer] practicalSkill3] == 1) skillValue = 4;
        else if ([[Player sharedPlayer] practicalSkill3] == 2) skillValue = 12;
        else if ([[Player sharedPlayer] practicalSkill3] == 3) skillValue = 24;
        else if ([[Player sharedPlayer] practicalSkill3] == 4) skillValue = 40;
        else if ([[Player sharedPlayer] practicalSkill3] == 5) skillValue = 60;
        else if ([[Player sharedPlayer] practicalSkill3] == 6) skillValue = 84;
        else if ([[Player sharedPlayer] practicalSkill3] == 7) skillValue = 112;
        else if ([[Player sharedPlayer] practicalSkill3] == 8) skillValue = 144;
        else if ([[Player sharedPlayer] practicalSkill3] == 9) skillValue = 180;
        else if ([[Player sharedPlayer] practicalSkill3] == 10) skillValue = 220;
        
        practicalSkill3 = [NSString stringWithFormat:NSLocalizedString(@"TrainerSkill09", nil), skillValue];
    }
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if ([[GameCenterManager sharedGameCenterManager] pendingInvite]) {
        [self setupArenaView];
    }
    
    if (itemHelp.isSelected || itemMenu.isSelected ||
        itemTavern.isSelected || itemShop.isSelected ||
        itemUpgradeCombat1.isSelected || itemUpgradeCombat2.isSelected ||
        itemUpgradeCombat3.isSelected || itemUpgradeSurvival1.isSelected ||
        itemUpgradeSurvival2.isSelected || itemUpgradeSurvival3.isSelected ||
        itemUpgradePractical1.isSelected || itemUpgradePractical2.isSelected ||
        itemUpgradePractical3.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemHelp.isSelected && !itemMenu.isSelected &&
             !itemTavern.isSelected && !itemShop.isSelected &&
             !itemUpgradeCombat1.isSelected && !itemUpgradeCombat2.isSelected &&
             !itemUpgradeCombat3.isSelected && !itemUpgradeSurvival1.isSelected &&
             !itemUpgradeSurvival2.isSelected && !itemUpgradeSurvival3.isSelected &&
             !itemUpgradePractical1.isSelected && !itemUpgradePractical2.isSelected &&
             !itemUpgradePractical3.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - upgrade skills

// upgrades combat skill 1
-(void)upgradeCombatSkill1
{
    [self pauseGame];
    
    TrainerUpgradeLayer *trainer_layer = [[TrainerUpgradeLayer alloc] initWithChoice:1
                                                                            withItem:combatSkill1];
    
    [self addChild:trainer_layer z:10];
}

// upgrades combat skill 2
-(void)upgradeCombatSkill2
{
    [self pauseGame];
    
    TrainerUpgradeLayer *trainer_layer = [[TrainerUpgradeLayer alloc] initWithChoice:2
                                                                            withItem:combatSkill2];
    
    [self addChild:trainer_layer z:10];
}

// upgrades combat skill 3
-(void)upgradeCombatSkill3
{
    [self pauseGame];
    
    TrainerUpgradeLayer *trainer_layer = [[TrainerUpgradeLayer alloc] initWithChoice:3
                                                                            withItem:combatSkill3];
    
    [self addChild:trainer_layer z:10];
}

// upgrades survival skill 1
-(void)upgradeSurvivalSkill1
{
    [self pauseGame];
    
    TrainerUpgradeLayer *trainer_layer = [[TrainerUpgradeLayer alloc] initWithChoice:4
                                                                            withItem:survivalSkill1];
    
    [self addChild:trainer_layer z:10];
}

// upgrades survival skill 2
-(void)upgradeSurvivalSkill2
{
    [self pauseGame];
    
    TrainerUpgradeLayer *trainer_layer = [[TrainerUpgradeLayer alloc] initWithChoice:5
                                                                            withItem:survivalSkill2];
    
    [self addChild:trainer_layer z:10];
}

// upgrades survival skill 3
-(void)upgradeSurvivalSkill3
{
    [self pauseGame];
    
    TrainerUpgradeLayer *trainer_layer = [[TrainerUpgradeLayer alloc] initWithChoice:6
                                                                            withItem:survivalSkill3];
    
    [self addChild:trainer_layer z:10];
}

// upgrades practical skill 1
-(void)upgradePracticalSkill1
{
    [self pauseGame];
    
    TrainerUpgradeLayer *trainer_layer = [[TrainerUpgradeLayer alloc] initWithChoice:7
                                                                            withItem:practicalSkill1];
    
    [self addChild:trainer_layer z:10];
}

// upgrades practical skill 2
-(void)upgradePracticalSkill2
{
    [self pauseGame];
    
    TrainerUpgradeLayer *trainer_layer = [[TrainerUpgradeLayer alloc] initWithChoice:8
                                                                            withItem:practicalSkill2];
    
    [self addChild:trainer_layer z:10];
}

// upgrades practical skill 3
-(void)upgradePracticalSkill3
{
    [self pauseGame];
    
    TrainerUpgradeLayer *trainer_layer = [[TrainerUpgradeLayer alloc] initWithChoice:9
                                                                            withItem:practicalSkill3];
    
    [self addChild:trainer_layer z:10];
}

#pragma mark - menu choices

// shows the tavern scene
-(void)showTavern
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneTavern withTransition:NO];
}

// shows the shop scene
-(void)showShop
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneShop withTransition:NO];
}

// shows the help scene
-(void)showHelp
{
    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    menuUpgrades.isTouchEnabled = NO;
    
    ccColor4B colour = {0, 0, 0, 0};
    SkillsHelpLayer *help_layer = [[SkillsHelpLayer alloc] initWithColor:colour];
    
    [self addChild:help_layer z:10];
}

// shows the play scene
-(void)showPlay
{
    [[GameManager sharedGameManager] runSceneWithID:kScenePlay withTransition:NO];
}

#pragma mark - pausing and resuming

// pauses the game to allow the player to train
-(void)pauseGame
{
    [self pauseSchedulerAndActions];
    
    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    menuUpgrades.isTouchEnabled = NO;
}

// resumes the game after player has trained
-(void)resumeGame
{
    [self resumeSchedulerAndActions];
    
    self.isTouchEnabled = YES;
    menuChoice.isTouchEnabled = YES;
    menuOptions.isTouchEnabled = YES;
    menuUpgrades.isTouchEnabled = YES;
    
    [self setupSkills];
    
    [self removeChild:labelCombatVal cleanup:YES];
    [self removeChild:labelSurvivalVal cleanup:YES];
    [self removeChild:labelPracticalVal cleanup:YES];
    [self removeChild:labelCombatSkill1Val cleanup:YES];
    [self removeChild:labelCombatSkill2Val cleanup:YES];
    [self removeChild:labelCombatSkill3Val cleanup:YES];
    [self removeChild:labelSurvivalSkill1Val cleanup:YES];
    [self removeChild:labelSurvivalSkill2Val cleanup:YES];
    [self removeChild:labelSurvivalSkill3Val cleanup:YES];
    [self removeChild:labelPracticalSkill1Val cleanup:YES];
    [self removeChild:labelPracticalSkill2Val cleanup:YES];
    [self removeChild:labelPracticalSkill3Val cleanup:YES];
    
    labelCombatVal = [Utility labelWithString:totalCombat fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSurvivalVal = [Utility labelWithString:totalSurvival fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPracticalVal = [Utility labelWithString:totalPractical fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                           color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelCombatSkill1Val = [Utility labelWithString:combatSkill1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                              color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelCombatSkill2Val = [Utility labelWithString:combatSkill2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                              color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelCombatSkill3Val = [Utility labelWithString:combatSkill3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                              color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSurvivalSkill1Val = [Utility labelWithString:survivalSkill1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSurvivalSkill2Val = [Utility labelWithString:survivalSkill2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelSurvivalSkill3Val = [Utility labelWithString:survivalSkill3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPracticalSkill1Val = [Utility labelWithString:practicalSkill1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPracticalSkill2Val = [Utility labelWithString:practicalSkill2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPracticalSkill3Val = [Utility labelWithString:practicalSkill3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                                 color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    [labelCombatVal setAnchorPoint:ccp(1, 0)];
    [labelSurvivalVal setAnchorPoint:ccp(1, 0)];
    [labelPracticalVal setAnchorPoint:ccp(1, 0)];
    [labelCombatSkill1Val setAnchorPoint:ccp(1, 0)];
    [labelCombatSkill2Val setAnchorPoint:ccp(1, 0)];
    [labelCombatSkill3Val setAnchorPoint:ccp(1, 0)];
    [labelSurvivalSkill1Val setAnchorPoint:ccp(1, 0)];
    [labelSurvivalSkill2Val setAnchorPoint:ccp(1, 0)];
    [labelSurvivalSkill3Val setAnchorPoint:ccp(1, 0)];
    [labelPracticalSkill1Val setAnchorPoint:ccp(1, 0)];
    [labelPracticalSkill2Val setAnchorPoint:ccp(1, 0)];
    [labelPracticalSkill3Val setAnchorPoint:ccp(1, 0)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [labelCombatVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 168)];
        [labelSurvivalVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 32)];
        [labelPracticalVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 104)];
        [labelCombatSkill1Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 128)];
        [labelCombatSkill2Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 102)];
        [labelCombatSkill3Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 + 76)];
        [labelSurvivalSkill1Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 9)];
        [labelSurvivalSkill2Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 35)];
        [labelSurvivalSkill3Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 61)];
        [labelPracticalSkill1Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 144)];
        [labelPracticalSkill2Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 170)];
        [labelPracticalSkill3Val setPosition:ccp(screenSize.width/2 + 88, screenSize.height/2 - 196)];
    }
    else {
        [labelCombatVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (166 * 2.133f))];
        [labelSurvivalVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (30 * 2.133f))];
        [labelPracticalVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (106 * 2.133f))];        
        [labelCombatSkill1Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (127 * 2.133f))];
        [labelCombatSkill2Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (101 * 2.133f))];
        [labelCombatSkill3Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 + (75 * 2.133f))];
        [labelSurvivalSkill1Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (10 * 2.133f))];
        [labelSurvivalSkill2Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (36 * 2.133f))];
        [labelSurvivalSkill3Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (62 * 2.133f))];
        [labelPracticalSkill1Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (145 * 2.133f))];
        [labelPracticalSkill2Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (171 * 2.133f))];
        [labelPracticalSkill3Val setPosition:ccp(screenSize.width/2 + (88 * 2.4f), screenSize.height/2 - (197 * 2.133f))];
    }
    
    [self addChild:labelCombatVal z:1 tag:7];
    [self addChild:labelSurvivalVal z:1 tag:8];
    [self addChild:labelPracticalVal z:1 tag:9];
    [self addChild:labelCombatSkill1Val z:1 tag:19];
    [self addChild:labelCombatSkill2Val z:1 tag:20];
    [self addChild:labelCombatSkill3Val z:1 tag:21];
    [self addChild:labelSurvivalSkill1Val z:1 tag:22];
    [self addChild:labelSurvivalSkill2Val z:1 tag:23];
    [self addChild:labelSurvivalSkill3Val z:1 tag:24];
    [self addChild:labelPracticalSkill1Val z:1 tag:25];
    [self addChild:labelPracticalSkill2Val z:1 tag:26];
    [self addChild:labelPracticalSkill3Val z:1 tag:27];
    
    [self updateSkillCounters];
    [self updateSkillButtons];
}

// resumes after help
-(void)resumeFromHelp
{
    self.isTouchEnabled = YES;
    menuChoice.isTouchEnabled = YES;
    menuOptions.isTouchEnabled = YES;
    menuUpgrades.isTouchEnabled = YES;
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
