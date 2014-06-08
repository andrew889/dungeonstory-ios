//
//  StatsLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "StatsLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "StatsHelpLayer.h"
#import "Utility.h"

#pragma mark - StatsLayer

@implementation StatsLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	StatsLayer *layer = [StatsLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {
		screenSize = [[CCDirector sharedDirector] winSize];        
        background = [CCSprite spriteWithFile:@"Menu.png"];
        statsBG = [CCSprite spriteWithFile:@"StatsMenu.png"];
        rankBar = [CCSprite spriteWithFile:@"rankBar.png"];
        rankBar2 = [CCSprite spriteWithFile:@"rankBar2.png"];
        menuBar01 = [CCSprite spriteWithFile:@"menubar.png"];
        menuBar02 = [CCSprite spriteWithFile:@"menubar.png"];
        keyboard = [CCSprite spriteWithFile:@"Keyboard.png"];
        
        [self setupStatsMenu];
        [self setupKeyboard];
        
        if (screenSize.height == 568.00) [self setupUpperBar];
        
        labelStats = [Utility labelWithString:NSLocalizedString(@"StatsLabel", nil)
                                     fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelName = [Utility labelWithString:NSLocalizedString(@"StatsName", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                          color:ccc3(0, 255, 127) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelLevel = [Utility labelWithString:NSLocalizedString(@"StatsLevel", nil)
                                     fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelReqExp = [Utility labelWithString:NSLocalizedString(@"StatsExp", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelHP = [Utility labelWithString:NSLocalizedString(@"StatsHp", nil)
                                  fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelAttack = [Utility labelWithString:NSLocalizedString(@"StatsAttack", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelDefence = [Utility labelWithString:NSLocalizedString(@"StatsDefence", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelMagic = [Utility labelWithString:NSLocalizedString(@"StatsMagic", nil)
                                     fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelLuck = [Utility labelWithString:NSLocalizedString(@"StatsLuck", nil)
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelClass = [Utility labelWithString:NSLocalizedString(@"StatsClass", nil)
                                     fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                          color:ccc3(0, 255, 127) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelClassRank = [Utility labelWithString:NSLocalizedString(@"StatsRank", nil)
                                         fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelScore = [Utility labelWithString:NSLocalizedString(@"StatsScore", nil)
                                     fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelVictories = [Utility labelWithString:NSLocalizedString(@"StatsArena", nil)
                                         fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccc3(255, 182, 18) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelMonsters = [Utility labelWithString:NSLocalizedString(@"StatsMonsters", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccc3(255, 90, 71) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelRounds = [Utility labelWithString:NSLocalizedString(@"StatsRounds", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccc3(255, 130, 71) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        itemInventory = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"ItemsLabel", nil)
                                                                               fontName:@"Shark Crash"
                                                                               fontSize:[Utility getFontSize:26]
                                                                                  color:ccWHITE
                                                                             strokeSize:[Utility getFontSize:1.5]
                                                                             stokeColor:ccBLACK]
                         
                                                selectedSprite:[Utility labelWithString:NSLocalizedString(@"ItemsLabel", nil)
                                                                               fontName:@"Shark Crash"
                                                                               fontSize:[Utility getFontSize:26]
                                                                                  color:ccc3(255, 204, 102)
                                                                             strokeSize:[Utility getFontSize:1.5]
                                                                             stokeColor:ccBLACK]
                         
                                                        target:self selector:@selector(showInventory)];
        
        itemStory = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"QuestLabel", nil)
                                                                           fontName:@"Shark Crash"
                                                                           fontSize:[Utility getFontSize:26]
                                                                              color:ccWHITE
                                                                         strokeSize:[Utility getFontSize:1.5]
                                                                         stokeColor:ccBLACK]
                     
                                            selectedSprite:[Utility labelWithString:NSLocalizedString(@"QuestLabel", nil)
                                                                           fontName:@"Shark Crash"
                                                                           fontSize:[Utility getFontSize:26]
                                                                              color:ccc3(255, 204, 102)
                                                                         strokeSize:[Utility getFontSize:1.5]
                                                                         stokeColor:ccBLACK]
                     
                                                    target:self selector:@selector(showStory)];
        
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
        
        if ([[Player sharedPlayer] classVal] == 1) {
            itemClass1 = [CCMenuItemImage itemWithNormalImage:@"adventurer_icon.png"
                                                selectedImage:@"adventurer_icon.png"];
        }
        else {
            itemClass1 = [CCMenuItemImage itemWithNormalImage:@"adventurer_icon_2.png"
                                                selectedImage:@"adventurer_icon.png"
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(chooseClass1)];
        }
        
        if ([[Player sharedPlayer] classRank2] == 0) {
            itemClass2 = [CCMenuItemImage itemWithNormalImage:@"no_class_icon.png"
                                                selectedImage:@"no_class_icon.png"];
        }
        else if ([[Player sharedPlayer] classVal] == 2) {
            itemClass2 = [CCMenuItemImage itemWithNormalImage:@"knight_icon.png"
                                                selectedImage:@"knight_icon.png"];
        }
        else {
            itemClass2 = [CCMenuItemImage itemWithNormalImage:@"knight_icon_2.png"
                                                selectedImage:@"knight_icon.png"
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(chooseClass2)];
        }
        
        if ([[Player sharedPlayer] classRank3] == 0) {
            itemClass3 = [CCMenuItemImage itemWithNormalImage:@"no_class_icon.png"
                                                selectedImage:@"no_class_icon.png"];
        }
        else if ([[Player sharedPlayer] classVal] == 3) {
            itemClass3 = [CCMenuItemImage itemWithNormalImage:@"wizard_icon.png"
                                                selectedImage:@"wizard_icon.png"];
        }
        else {
            itemClass3 = [CCMenuItemImage itemWithNormalImage:@"wizard_icon_2.png"
                                                selectedImage:@"wizard_icon.png"
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(chooseClass3)];
        }
        
        if ([[Player sharedPlayer] classRank4] == 0) {
            itemClass4 = [CCMenuItemImage itemWithNormalImage:@"no_class_icon.png"
                                                selectedImage:@"no_class_icon.png"];
        }
        else if ([[Player sharedPlayer] classVal] == 4) {
            itemClass4 = [CCMenuItemImage itemWithNormalImage:@"alchemist_icon.png"
                                                selectedImage:@"alchemist_icon.png"];
        }
        else {
            itemClass4 = [CCMenuItemImage itemWithNormalImage:@"alchemist_icon_2.png"
                                                selectedImage:@"alchemist_icon.png"
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(chooseClass4)];
        }
        
        if ([[Player sharedPlayer] classRank5] == 0) {
            itemClass5 = [CCMenuItemImage itemWithNormalImage:@"no_class_icon.png"
                                                selectedImage:@"no_class_icon.png"];
        }
        else if ([[Player sharedPlayer] classVal] == 5) {
            itemClass5 = [CCMenuItemImage itemWithNormalImage:@"thief_icon.png"
                                                selectedImage:@"thief_icon.png"];
        }
        else {
            itemClass5 = [CCMenuItemImage itemWithNormalImage:@"thief_icon_2.png"
                                                selectedImage:@"thief_icon.png"
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(chooseClass5)];
        }
        
        if ([[Player sharedPlayer] classRank6] == 0) {
            itemClass6 = [CCMenuItemImage itemWithNormalImage:@"no_class_icon.png"
                                                selectedImage:@"no_class_icon.png"];
        }
        else if ([[Player sharedPlayer] classVal] == 6) {
            itemClass6 = [CCMenuItemImage itemWithNormalImage:@"bard_icon.png"
                                                selectedImage:@"bard_icon.png"];
        }
        else {
            itemClass6 = [CCMenuItemImage itemWithNormalImage:@"bard_icon_2.png"
                                                selectedImage:@"bard_icon.png"
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(chooseClass6)];
        }
        
        if ([[Player sharedPlayer] classRank7] == 0) {
            itemClass7 = [CCMenuItemImage itemWithNormalImage:@"no_class_icon.png"
                                                selectedImage:@"no_class_icon.png"];
        }
        else if ([[Player sharedPlayer] classVal] == 7) {
            itemClass7 = [CCMenuItemImage itemWithNormalImage:@"assassin_icon.png"
                                                selectedImage:@"assassin_icon.png"];
        }
        else {
            itemClass7 = [CCMenuItemImage itemWithNormalImage:@"assassin_icon_2.png"
                                                selectedImage:@"assassin_icon.png"
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(chooseClass7)];
        }
        
        if ([[Player sharedPlayer] classRank8] == 0) {
            itemClass8 = [CCMenuItemImage itemWithNormalImage:@"no_class_icon.png"
                                                selectedImage:@"no_class_icon.png"];
        }
        else if ([[Player sharedPlayer] classVal] == 8) {
            itemClass8 = [CCMenuItemImage itemWithNormalImage:@"engineer_icon.png"
                                                selectedImage:@"engineer_icon.png"];
        }
        else {
            itemClass8 = [CCMenuItemImage itemWithNormalImage:@"engineer_icon_2.png"
                                                selectedImage:@"engineer_icon.png"
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(chooseClass8)];
        }
        
        if ([[Player sharedPlayer] classRank9] == 0) {
            itemClass9 = [CCMenuItemImage itemWithNormalImage:@"no_class_icon.png"
                                                selectedImage:@"no_class_icon.png"];
        }
        else if ([[Player sharedPlayer] classVal] == 9) {
            itemClass9 = [CCMenuItemImage itemWithNormalImage:@"dragoon_icon.png"
                                                selectedImage:@"dragoon_icon.png"];
        }
        else {
            itemClass9 = [CCMenuItemImage itemWithNormalImage:@"dragoon_icon_2.png"
                                                selectedImage:@"dragoon_icon.png"
                                                disabledImage:nil
                                                       target:self
                                                     selector:@selector(chooseClass9)];
        }
		
		menuChoice = [CCMenu menuWithItems:itemInventory, itemStory, nil];
        menuClasses = [CCMenu menuWithItems:itemClass1, itemClass2, itemClass3, itemClass4,
                       itemClass5, itemClass6, itemClass7, itemClass8, itemClass9, nil];
        menuOptions = [CCMenu menuWithItems:itemHelp, itemMenu, nil];
        
        [labelName setAnchorPoint:ccp(0, 0)];
        
        [labelNameVal setAnchorPoint:ccp(1, 0)];
        
        [labelLevel setAnchorPoint:ccp(0, 0)];
        [labelReqExp setAnchorPoint:ccp(0, 0)];
        [labelHP setAnchorPoint:ccp(0, 0)];
        [labelAttack setAnchorPoint:ccp(0, 0)];
        [labelDefence setAnchorPoint:ccp(0, 0)];
        [labelMagic setAnchorPoint:ccp(0, 0)];
        [labelLuck setAnchorPoint:ccp(0, 0)];
        [labelLevelVal setAnchorPoint:ccp(1, 0)];
        [labelReqExpVal setAnchorPoint:ccp(1, 0)];
        [labelHPVal setAnchorPoint:ccp(1, 0)];
        [labelAttackVal setAnchorPoint:ccp(1, 0)];
        [labelDefenceVal setAnchorPoint:ccp(1, 0)];
        [labelMagicVal setAnchorPoint:ccp(1, 0)];
        [labelLuckVal setAnchorPoint:ccp(1, 0)];
        [labelClass setAnchorPoint:ccp(0, 0)];
        [labelClassVal setAnchorPoint:ccp(1, 0)];
        [labelClassRank setAnchorPoint:ccp(0, 0)];
        [labelClassRankVal setAnchorPoint:ccp(1, 0)];
        [labelAbility setAnchorPoint:ccp(0, 0)];
        [labelAbilityVal setAnchorPoint:ccp(1, 0)];
        [labelScore setAnchorPoint:ccp(0, 0)];
        [labelScoreVal setAnchorPoint:ccp(1, 0)];
        [labelVictories setAnchorPoint:ccp(0, 0)];
        [labelVictoriesVal setAnchorPoint:ccp(1, 0)];
        [labelMonsters setAnchorPoint:ccp(0, 0)];
        [labelMonstersVal setAnchorPoint:ccp(1, 0)];
        [labelRounds setAnchorPoint:ccp(0, 0)];
        [labelRoundsVal setAnchorPoint:ccp(1, 0)];
        [rankBar setAnchorPoint:ccp(0,0)];
        [rankBar2 setAnchorPoint:ccp(0,0)];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [statsBG setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
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
            
            [labelStats setPosition:ccp(screenSize.width/2 - 100, screenSize.height/2 + 218)];
            [itemInventory setPosition:ccp(0, 218)];
            [itemStory setPosition:ccp(100, 218)];
            
            [labelName setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 167)];
            [labelNameVal setPosition:ccp(screenSize.width/2 - 13, screenSize.height/2 + 167)];
            [labelLevel setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 137)];
            [labelLevelVal setPosition:ccp(screenSize.width/2 - 13, screenSize.height/2 + 137)];
            [labelReqExp setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 112)];
            [labelReqExpVal setPosition:ccp(screenSize.width/2 - 13, screenSize.height/2 + 112)];
            
            [labelHP setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 77)];
            [labelHPVal setPosition:ccp(screenSize.width/2 - 13, screenSize.height/2 + 77)];
            [labelAttack setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 52)];
            [labelAttackVal setPosition:ccp(screenSize.width/2 - 13, screenSize.height/2 + 52)];
            [labelDefence setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 27)];
            [labelDefenceVal setPosition:ccp(screenSize.width/2 - 13, screenSize.height/2 + 27)];
            [labelMagic setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 2)];
            [labelMagicVal setPosition:ccp(screenSize.width/2 - 13, screenSize.height/2 + 2)];
            [labelLuck setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 23)];
            [labelLuckVal setPosition:ccp(screenSize.width/2 - 13, screenSize.height/2 - 23)];
            
            [labelClass setPosition:ccp(screenSize.width/2 + 12, screenSize.height/2 + 167)];
            [labelClassVal setPosition:ccp(screenSize.width/2 + 144, screenSize.height/2 + 167)];
            [labelClassRank setPosition:ccp(screenSize.width/2 + 12, screenSize.height/2 - 32)];
            [labelClassRankVal setPosition:ccp(screenSize.width/2 + 144, screenSize.height/2 - 31)];
            
            [rankBar setPosition:ccp(screenSize.width/2 + 3, screenSize.height/2 - 33)];
            [rankBar2 setPosition:ccp(screenSize.width/2 + 3, screenSize.height/2 - 33)];
            
            [itemClass1 setPosition:ccp(26, 129)];
            [itemClass2 setPosition:ccp(78, 129)];
            [itemClass3 setPosition:ccp(130, 129)];
            [itemClass4 setPosition:ccp(26, 76)];
            [itemClass5 setPosition:ccp(78, 76)];
            [itemClass6 setPosition:ccp(130, 76)];
            [itemClass7 setPosition:ccp(26, 23)];
            [itemClass8 setPosition:ccp(78, 23)];
            [itemClass9 setPosition:ccp(130, 23)];
            
            [labelAbility setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 66)];
            [labelAbilityVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 85)];
            
            [labelScore setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 124)];
            [labelScoreVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 124)];
            [labelVictories setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 149)];
            [labelVictoriesVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 149)];
            [labelMonsters setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 174)];
            [labelMonstersVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 174)];
            [labelRounds setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 199)];
            [labelRoundsVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 199)];
        }
        else {
            [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (233 * 2.133f))];

            [labelStats setPosition:ccp(screenSize.width/2 - (80 * 2.4f), screenSize.height/2 + (218.5 * 2.133f))];
            [itemInventory setPosition:ccp(80 * 2.4f, (218.5 * 2.133f))];
            
            [labelStats setPosition:ccp(screenSize.width/2 - (100 * 2.4f), screenSize.height/2 + (218.5 * 2.133f))];
            [itemInventory setPosition:ccp(0, 218.5 * 2.133f)];
            [itemStory setPosition:ccp(100 * 2.4f, 218.5 * 2.133f)];
            
            [labelName setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (166 * 2.133f))];
            [labelNameVal setPosition:ccp(screenSize.width/2 - (13 * 2.4f), screenSize.height/2 + (166 * 2.133f))];
            [labelLevel setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (136 * 2.133f))];
            [labelLevelVal setPosition:ccp(screenSize.width/2 - (13 * 2.4f), screenSize.height/2 + (136 * 2.133f))];
            [labelReqExp setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (111 * 2.133f))];
            [labelReqExpVal setPosition:ccp(screenSize.width/2 - (13 * 2.4f), screenSize.height/2 + (111 * 2.133f))];
            
            [labelHP setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (76 * 2.133f))];
            [labelHPVal setPosition:ccp(screenSize.width/2 - (13 * 2.4f), screenSize.height/2 + (76 * 2.133f))];
            [labelAttack setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (51 * 2.133f))];
            [labelAttackVal setPosition:ccp(screenSize.width/2 - (13 * 2.4f), screenSize.height/2 + (51 * 2.133f))];
            [labelDefence setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (26 * 2.133f))];
            [labelDefenceVal setPosition:ccp(screenSize.width/2 - (13 * 2.4f), screenSize.height/2 + (26 * 2.133f))];
            [labelMagic setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (1 * 2.133f))];
            [labelMagicVal setPosition:ccp(screenSize.width/2 - (13 * 2.4f), screenSize.height/2 + (1 * 2.133f))];
            [labelLuck setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (24 * 2.133f))];
            [labelLuckVal setPosition:ccp(screenSize.width/2 - (13 * 2.4f), screenSize.height/2 - (24 * 2.133f))];
            
            [labelClass setPosition:ccp(screenSize.width/2 + (12 * 2.4f), screenSize.height/2 + (166 * 2.133f))];
            [labelClassVal setPosition:ccp(screenSize.width/2 + (144 * 2.4f), screenSize.height/2 + (166 * 2.133f))];
            [labelClassRank setPosition:ccp(screenSize.width/2 + (12 * 2.4f), screenSize.height/2 - (33 * 2.133f))];
            [labelClassRankVal setPosition:ccp(screenSize.width/2 + (144 * 2.4f), screenSize.height/2 - (32 * 2.133f))];
            
            [rankBar setPosition:ccp(screenSize.width/2 + (3 * 2.4f), screenSize.height/2 - (34 * 2.133f))];
            [rankBar2 setPosition:ccp(screenSize.width/2 + (3 * 2.4f), screenSize.height/2 - (34 * 2.133f))];
            
            [itemClass1 setPosition:ccp((26 * 2.4f), (129 * 2.133f))];
            [itemClass2 setPosition:ccp((78 * 2.4f), (129 * 2.133f))];
            [itemClass3 setPosition:ccp((130 * 2.4f), (129 * 2.133f))];
            [itemClass4 setPosition:ccp((26 * 2.4f), (76 * 2.133f))];
            [itemClass5 setPosition:ccp((78 * 2.4f), (76 * 2.133f))];
            [itemClass6 setPosition:ccp((130 * 2.4f), (76 * 2.133f))];
            [itemClass7 setPosition:ccp((26 * 2.4f), (23 * 2.133f))];
            [itemClass8 setPosition:ccp((78 * 2.4f), (23 * 2.133f))];
            [itemClass9 setPosition:ccp((130 * 2.4f), (23 * 2.133f))];
            
            [labelAbility setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (67 * 2.133f))];
            [labelAbilityVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (88 * 2.133f))];
            
            [labelScore setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (125 * 2.133f))];
            [labelScoreVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (125 * 2.133f))];
            [labelVictories setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (150 * 2.133f))];
            [labelVictoriesVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (150 * 2.133f))];
            [labelMonsters setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (175 * 2.133f))];
            [labelMonstersVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (175 * 2.133f))];
            [labelRounds setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (200 * 2.133f))];
            [labelRoundsVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (200 * 2.133f))];
                        
            [menuOptions alignItemsHorizontallyWithPadding:(180 * 2.4f)];
            [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - (224 * 2.133f))];
        }
        
        [self addChild:background z:-2 tag:0];
        [self addChild:statsBG z:-1 tag:1];
        [self addChild:menuBar02 z:0 tag:2];
        [self addChild:labelStats z:1 tag:3];
		[self addChild:menuChoice z:1 tag:4];
        [self addChild:labelName z:1 tag:5];
        [self addChild:labelNameVal z:1 tag:6];
        [self addChild:labelLevel z:1 tag:7];
        [self addChild:labelLevelVal z:1 tag:8];
        [self addChild:labelReqExp z:1 tag:9];
        [self addChild:labelReqExpVal z:1 tag:10];
        [self addChild:labelHP z:1 tag:11];
        [self addChild:labelHPVal z:1 tag:12];
        [self addChild:labelAttack z:1 tag:13];
        [self addChild:labelAttackVal z:1 tag:14];
        [self addChild:labelDefence z:1 tag:15];
        [self addChild:labelDefenceVal z:1 tag:16];
        [self addChild:labelMagic z:1 tag:17];
        [self addChild:labelMagicVal z:1 tag:18];
        [self addChild:labelLuck z:1 tag:19];
        [self addChild:labelLuckVal z:1 tag:20];
        [self addChild:labelClass z:1 tag:21];
        [self addChild:labelClassVal z:1 tag:22];
        [self addChild:labelClassRank z:1 tag:23];
        [self addChild:labelClassRankVal z:1 tag:24];
        [self addChild:labelAbility z:1 tag:25];
        [self addChild:labelAbilityVal z:1 tag:26];
        [self addChild:labelScore z:1 tag:27];
        [self addChild:labelScoreVal z:1 tag:28];
        [self addChild:labelVictories z:1 tag:29];
        [self addChild:labelVictoriesVal z:1 tag:30];
        [self addChild:labelMonsters z:1 tag:31];
        [self addChild:labelMonstersVal z:1 tag:32];
        [self addChild:labelRounds z:1 tag:33];
        [self addChild:labelRoundsVal z:1 tag:34];
        [self addChild:keyboard z:2 tag:35];
        [self addChild:labelVerticalLine z:2 tag:36];
        [self addChild:rankBar z:-2 tag:37];
        [self addChild:rankBar2 z:-2 tag:38];
        [self addChild:menuClasses z:1 tag:39];
        [self addChild:menuOptions z:1 tag:40];
        
        if (screenSize.height == 568.00) {
            [self addChild:menuBar01 z:0 tag:41];
            [self addChild:labelMsg z:1 tag:42];
        }
        
        [keyboard addChild:menuKeyboardUpper z:1 tag:0];
        [keyboard addChild:menuKeyboardMiddle z:1 tag:1];
        [keyboard addChild:menuKeyboardLower z:1 tag:2];
        [keyboard addChild:menuKeyboard z:1 tag:3];
        
        [self scheduleUpdate];
        
        self.isTouchEnabled = YES;
        
        keyboard.visible = NO;
        
        int currentClassRank;
        
        if ([[Player sharedPlayer] classVal] == 1) currentClassRank = [[Player sharedPlayer] classRank1];
        else if ([[Player sharedPlayer] classVal] == 2) currentClassRank = [[Player sharedPlayer] classRank2];
        else if ([[Player sharedPlayer] classVal] == 3) currentClassRank = [[Player sharedPlayer] classRank3];
        else if ([[Player sharedPlayer] classVal] == 4) currentClassRank = [[Player sharedPlayer] classRank4];
        else if ([[Player sharedPlayer] classVal] == 5) currentClassRank = [[Player sharedPlayer] classRank5];
        else if ([[Player sharedPlayer] classVal] == 6) currentClassRank = [[Player sharedPlayer] classRank6];
        else if ([[Player sharedPlayer] classVal] == 7) currentClassRank = [[Player sharedPlayer] classRank7];
        else if ([[Player sharedPlayer] classVal] == 8) currentClassRank = [[Player sharedPlayer] classRank8];
        else if ([[Player sharedPlayer] classVal] == 9) currentClassRank = [[Player sharedPlayer] classRank9];

        if (currentClassRank < 250) {
            [rankBar setScaleX:((float)currentClassRank / 250.0)];
            [rankBar2 setScaleX:((float)currentClassRank / 250.0)];
        }
        else if (currentClassRank < 500) {
            [rankBar setScaleX:((float)currentClassRank / 500.0)];
            [rankBar2 setScaleX:((float)currentClassRank / 500.0)];
        }
        else if (currentClassRank < 750) {
            [rankBar setScaleX:((float)currentClassRank / 750.0)];
            [rankBar2 setScaleX:((float)currentClassRank / 750.0)];
        }
        else {
            [rankBar setScaleX:((float)currentClassRank / 1000.0)];
            [rankBar2 setScaleX:((float)currentClassRank / 1000.0)];
        }
                
        rankBar2.opacity = 0.0f;
        shouldGlow = YES;
	}
    
	return self;
}

#pragma mark - scene setup

// setups the stats menu
-(void)setupStatsMenu
{
    if (![[Player sharedPlayer] name]) playerName = NSLocalizedString(@"NameTouchHere", nil);
    else playerName = [[Player sharedPlayer] name];
    
    playerLevel = [NSString stringWithFormat:@"%d", [[Player sharedPlayer] level]];
    requiredExperience = [NSString stringWithFormat:@"%d", [[Player sharedPlayer] requiredExperience]];
    playerHP = [NSString stringWithFormat:@"%d", [[Player sharedPlayer] maxHP]];
    playerAttack = [NSString stringWithFormat:@"%d", [[Player sharedPlayer] attack]];
    playerDefence = [NSString stringWithFormat:@"%d", [[Player sharedPlayer] defence]];
    playerMagic = [NSString stringWithFormat:@"%d", [[Player sharedPlayer] magic]];
    playerLuck = [NSString stringWithFormat:@"%d", [[Player sharedPlayer] luck]];
    playerClass = [[Player sharedPlayer] className];
    
    if ([[Player sharedPlayer] classVal] == 1) {
        abilityName = NSLocalizedString(@"ClassAbilityName01", nil);
        abilityVal = NSLocalizedString(@"ClassAbility01", nil);
    }
    else if ([[Player sharedPlayer] classVal] == 2) {
        abilityName = NSLocalizedString(@"ClassAbilityName02", nil);
        abilityVal = NSLocalizedString(@"ClassAbility02", nil);
    }
    else if ([[Player sharedPlayer] classVal] == 3) {
        abilityName = NSLocalizedString(@"ClassAbilityName03", nil);
        abilityVal = NSLocalizedString(@"ClassAbility03", nil);
    }
    else if ([[Player sharedPlayer] classVal] == 4) {
        abilityName = NSLocalizedString(@"ClassAbilityName04", nil);
        abilityVal = NSLocalizedString(@"ClassAbility04", nil);
    }
    else if ([[Player sharedPlayer] classVal] == 5) {
        abilityName = NSLocalizedString(@"ClassAbilityName05", nil);
        abilityVal = NSLocalizedString(@"ClassAbility05", nil);
    }
    else if ([[Player sharedPlayer] classVal] == 6) {
        abilityName = NSLocalizedString(@"ClassAbilityName06", nil);
        abilityVal = NSLocalizedString(@"ClassAbility06", nil);
    }
    else if ([[Player sharedPlayer] classVal] == 7) {
        abilityName = NSLocalizedString(@"ClassAbilityName07", nil);
        abilityVal = NSLocalizedString(@"ClassAbility07", nil);
    }
    else if ([[Player sharedPlayer] classVal] == 8) {
        abilityName = NSLocalizedString(@"ClassAbilityName08", nil);
        abilityVal = NSLocalizedString(@"ClassAbility08", nil);
    }
    else if ([[Player sharedPlayer] classVal] == 9) {
        abilityName = NSLocalizedString(@"ClassAbilityName09", nil);
        abilityVal = NSLocalizedString(@"ClassAbility09", nil);
    }
    
    totalScore = [NSString stringWithFormat:@"%lld", [[GameCenterManager sharedGameCenterManager] totalScore]];
    highestRounds = [NSString stringWithFormat:@"%lld", [[GameCenterManager sharedGameCenterManager] highestRounds]];
    monstersKilled = [NSString stringWithFormat:@"%lld", [[GameCenterManager sharedGameCenterManager] monstersKilled]];
    victories = [NSString stringWithFormat:@"%lld", [[GameCenterManager sharedGameCenterManager] arenaVictories]];
    
    labelNameVal = [Utility labelWithString:playerName fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelLevelVal = [Utility labelWithString:playerLevel fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                       color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelReqExpVal = [Utility labelWithString:requiredExperience fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelHPVal = [Utility labelWithString:playerHP fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                    color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelAttackVal = [Utility labelWithString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] getRankedAttack]]
                                     fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelDefenceVal = [Utility labelWithString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] getRankedDefence]]
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelMagicVal = [Utility labelWithString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] getRankedMagic]]
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                       color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelLuckVal = [Utility labelWithString:[NSString stringWithFormat:@"%d", [[Player sharedPlayer] getRankedLuck]]
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelClassVal = [Utility labelWithString:[[Player sharedPlayer] className]
                                    fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                       color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelClassRankVal = [Utility labelWithString:[[Player sharedPlayer] getClassRankName]
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]
                                           color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelAbility = [Utility labelWithString:abilityName fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:[[Player sharedPlayer] classColor] strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelAbilityVal = [Utility labelWithString:abilityVal fontName:@"Shark Crash" fontSize:[Utility getFontSize:16]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelScoreVal = [Utility labelWithString:totalScore fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                       color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelVictoriesVal = [Utility labelWithString:victories fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                           color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelMonstersVal = [Utility labelWithString:monstersKilled fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                          color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelRoundsVal = [Utility labelWithString:highestRounds fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
    if ([[Player sharedPlayer] classVal] == 1) {
        [labelAttackVal setColor:ccc3(0, 255, 127)];
    }
    else if ([[Player sharedPlayer] classVal] == 2) {
        [labelDefenceVal setColor:ccc3(0, 255, 127)];
    }
    else if ([[Player sharedPlayer] classVal] == 3) {
        [labelMagicVal setColor:ccc3(0, 255, 127)];
    }
    else if ([[Player sharedPlayer] classVal] == 4) {
        [labelDefenceVal setColor:ccc3(0, 255, 127)];
        [labelMagicVal setColor:ccc3(0, 255, 127)];
    }
    else if ([[Player sharedPlayer] classVal] == 5) {
        [labelAttackVal setColor:ccc3(0, 255, 127)];
        [labelLuckVal setColor:ccc3(0, 255, 127)];
    }
    else if ([[Player sharedPlayer] classVal] == 6) {
        [labelMagicVal setColor:ccc3(0, 255, 127)];
        [labelLuckVal setColor:ccc3(0, 255, 127)];
    }
    else if ([[Player sharedPlayer] classVal] == 7) {
        [labelAttackVal setColor:ccc3(0, 255, 127)];
        [labelMagicVal setColor:ccc3(0, 255, 127)];
    }
    else if ([[Player sharedPlayer] classVal] == 8) {
        [labelDefenceVal setColor:ccc3(0, 255, 127)];
        [labelLuckVal setColor:ccc3(0, 255, 127)];
    }
    else if ([[Player sharedPlayer] classVal] == 9) {
        [labelAttackVal setColor:ccc3(0, 255, 127)];
        [labelDefenceVal setColor:ccc3(0, 255, 127)];
    }
}

// setups the upper bar
-(void)setupUpperBar
{
    labelMsg = [Utility labelWithString:[Utility setupRandomMsg]
                               fontName:@"Shark Crash" fontSize:[Utility getFontSize:16]
                                  color:ccc3(255, 204, 102) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 263)];
}

// setups keyboard
-(void)setupKeyboard
{
    keyboardQ = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"Q"];
                                                   else [self type:@"q"];
                                               }];
    
    keyboardW = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"W"];
                                                   else [self type:@"w"];
                                               }];
    
    keyboardE = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"E"];
                                                   else [self type:@"e"];
                                               }];
    
    keyboardR = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"R"];
                                                   else [self type:@"r"];
                                               }];
    
    keyboardT = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"T"];
                                                   else [self type:@"t"];
                                               }];
    
    keyboardY = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"Y"];
                                                   else [self type:@"y"];
                                               }];
    
    keyboardU = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"U"];
                                                   else [self type:@"u"];
                                               }];
    
    keyboardI = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"I"];
                                                   else [self type:@"i"];
                                               }];
    
    keyboardO = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"O"];
                                                   else [self type:@"o"];
                                               }];
    
    keyboardP = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"P"];
                                                   else [self type:@"p"];
                                               }];
    
    keyboardA = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"A"];
                                                   else [self type:@"a"];
                                               }];
    
    keyboardS = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"S"];
                                                   else [self type:@"s"];
                                               }];
    
    keyboardD = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"D"];
                                                   else [self type:@"d"];
                                               }];
    
    keyboardF = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"F"];
                                                   else [self type:@"f"];
                                               }];
    
    keyboardG = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"G"];
                                                   else [self type:@"g"];
                                               }];
    
    keyboardH = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"H"];
                                                   else [self type:@"h"];
                                               }];
    
    keyboardJ = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"J"];
                                                   else [self type:@"j"];
                                               }];
    
    keyboardK = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"K"];
                                                   else [self type:@"k"];
                                               }];
    
    keyboardL = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"L"];
                                                   else [self type:@"l"];
                                               }];
    
    keyboardZ = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"Z"];
                                                   else [self type:@"z"];
                                               }];
    
    keyboardX = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"X"];
                                                   else [self type:@"x"];
                                               }];
    
    keyboardC = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"C"];
                                                   else [self type:@"c"];
                                               }];
    
    keyboardV = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"V"];
                                                   else [self type:@"v"];
                                               }];
    
    keyboardB = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"B"];
                                                   else [self type:@"b"];
                                               }];
    
    keyboardN = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"N"];
                                                   else [self type:@"n"];
                                               }];
    
    keyboardM = [CCMenuItemImage itemWithNormalImage:@"KeyboardButton.png"
                                       selectedImage:@"KeyboardButton_pressed.png"
                                               block:^(id sender){
                                                   if (isCapital) [self type:@"M"];
                                                   else [self type:@"m"];
                                               }];
    
    keyboardSpace = [CCMenuItemImage itemWithNormalImage:@"KeyboardSpace.png"
                                           selectedImage:@"KeyboardSpace_pressed.png"
                                                   block:^(id sender){
                                                       [self type:@" "];
                                                   }];
    
    keyboardUp_on = [CCMenuItemImage itemWithNormalImage:@"KeyboardUp.png"
                                           selectedImage:@"KeyboardUp_pressed.png"
                                                   block:^(id sender){
                                                       isCapital = NO;
                                                       keyboardUp_on.isEnabled = NO;
                                                       keyboardUp_on.visible = NO;
                                                       keyboardUp_off.isEnabled = YES;
                                                       keyboardUp_off.visible = YES;
                                                   }];
    
    keyboardUp_off = [CCMenuItemImage itemWithNormalImage:@"KeyboardUp_2.png"
                                            selectedImage:@"KeyboardUp_2_pressed.png"
                                                    block:^(id sender){
                                                        isCapital = YES;
                                                        keyboardUp_on.isEnabled = YES;
                                                        keyboardUp_on.visible = YES;
                                                        keyboardUp_off.isEnabled = NO;
                                                        keyboardUp_off.visible = NO;
                                                    }];
    
    keyboardDel = [CCMenuItemImage itemWithNormalImage:@"KeyboardDel.png"
                                         selectedImage:@"KeyboardDel_pressed.png"
                                                 block:^(id sender){
                                                     [self deleteLetter];
                                                 }];
    
    keyboardDone = [CCMenuItemImage itemWithNormalImage:@"KeyboardDone.png"
                                          selectedImage:@"KeyboardDone_pressed.png"
                                          disabledImage:@"KeyboardDone_2.png"
                                                  block:^(id sender){
                                                      [self finishTyping];
                                                  }];
    
    UniChar line = 0x2502;
    NSString *verticalLine = [NSString stringWithCharacters:&line length:1];
        
    [keyboardQ addChild:[CCLabelTTF labelWithString:@"Q" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardW addChild:[CCLabelTTF labelWithString:@"W" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardE addChild:[CCLabelTTF labelWithString:@"E" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardR addChild:[CCLabelTTF labelWithString:@"R" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardT addChild:[CCLabelTTF labelWithString:@"T" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardY addChild:[CCLabelTTF labelWithString:@"Y" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardU addChild:[CCLabelTTF labelWithString:@"U" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardI addChild:[CCLabelTTF labelWithString:@"I" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardO addChild:[CCLabelTTF labelWithString:@"O" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardP addChild:[CCLabelTTF labelWithString:@"P" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardA addChild:[CCLabelTTF labelWithString:@"A" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardS addChild:[CCLabelTTF labelWithString:@"S" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardD addChild:[CCLabelTTF labelWithString:@"D" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardF addChild:[CCLabelTTF labelWithString:@"F" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardG addChild:[CCLabelTTF labelWithString:@"G" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardH addChild:[CCLabelTTF labelWithString:@"H" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardJ addChild:[CCLabelTTF labelWithString:@"J" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardK addChild:[CCLabelTTF labelWithString:@"K" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardL addChild:[CCLabelTTF labelWithString:@"L" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardZ addChild:[CCLabelTTF labelWithString:@"Z" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardX addChild:[CCLabelTTF labelWithString:@"X" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardC addChild:[CCLabelTTF labelWithString:@"C" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardV addChild:[CCLabelTTF labelWithString:@"V" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardB addChild:[CCLabelTTF labelWithString:@"B" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardN addChild:[CCLabelTTF labelWithString:@"N" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardM addChild:[CCLabelTTF labelWithString:@"M" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    
    [keyboardSpace addChild:[CCLabelTTF labelWithString:@"Space" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    [keyboardDone addChild:[CCLabelTTF labelWithString:@"Done" fontName:@"Shark Crash" fontSize:[Utility getFontSize:22]]];
    
    labelVerticalLine = [CCLabelTTF labelWithString:verticalLine fontName:@"Shark Crash" fontSize:[Utility getFontSize:18]];
    
    [keyboardQ.children.lastObject setPosition:ccp(keyboardQ.contentSize.width/2, keyboardQ.contentSize.height/2)];
    [keyboardW.children.lastObject setPosition:ccp(keyboardW.contentSize.width/2, keyboardW.contentSize.height/2)];
    [keyboardE.children.lastObject setPosition:ccp(keyboardE.contentSize.width/2, keyboardE.contentSize.height/2)];
    [keyboardR.children.lastObject setPosition:ccp(keyboardR.contentSize.width/2, keyboardR.contentSize.height/2)];
    [keyboardT.children.lastObject setPosition:ccp(keyboardT.contentSize.width/2, keyboardT.contentSize.height/2)];
    [keyboardY.children.lastObject setPosition:ccp(keyboardY.contentSize.width/2, keyboardY.contentSize.height/2)];
    [keyboardU.children.lastObject setPosition:ccp(keyboardU.contentSize.width/2, keyboardU.contentSize.height/2)];
    [keyboardI.children.lastObject setPosition:ccp(keyboardI.contentSize.width/2, keyboardI.contentSize.height/2)];
    [keyboardO.children.lastObject setPosition:ccp(keyboardO.contentSize.width/2, keyboardO.contentSize.height/2)];
    [keyboardP.children.lastObject setPosition:ccp(keyboardP.contentSize.width/2, keyboardP.contentSize.height/2)];
    [keyboardA.children.lastObject setPosition:ccp(keyboardA.contentSize.width/2, keyboardA.contentSize.height/2)];
    [keyboardS.children.lastObject setPosition:ccp(keyboardS.contentSize.width/2, keyboardS.contentSize.height/2)];
    [keyboardD.children.lastObject setPosition:ccp(keyboardD.contentSize.width/2, keyboardD.contentSize.height/2)];
    [keyboardF.children.lastObject setPosition:ccp(keyboardF.contentSize.width/2, keyboardF.contentSize.height/2)];
    [keyboardG.children.lastObject setPosition:ccp(keyboardG.contentSize.width/2, keyboardG.contentSize.height/2)];
    [keyboardH.children.lastObject setPosition:ccp(keyboardH.contentSize.width/2, keyboardH.contentSize.height/2)];
    [keyboardJ.children.lastObject setPosition:ccp(keyboardJ.contentSize.width/2, keyboardJ.contentSize.height/2)];
    [keyboardK.children.lastObject setPosition:ccp(keyboardK.contentSize.width/2, keyboardK.contentSize.height/2)];
    [keyboardL.children.lastObject setPosition:ccp(keyboardL.contentSize.width/2, keyboardL.contentSize.height/2)];
    [keyboardZ.children.lastObject setPosition:ccp(keyboardZ.contentSize.width/2, keyboardZ.contentSize.height/2)];
    [keyboardX.children.lastObject setPosition:ccp(keyboardX.contentSize.width/2, keyboardX.contentSize.height/2)];
    [keyboardC.children.lastObject setPosition:ccp(keyboardC.contentSize.width/2, keyboardC.contentSize.height/2)];
    [keyboardV.children.lastObject setPosition:ccp(keyboardV.contentSize.width/2, keyboardV.contentSize.height/2)];
    [keyboardB.children.lastObject setPosition:ccp(keyboardB.contentSize.width/2, keyboardB.contentSize.height/2)];
    [keyboardN.children.lastObject setPosition:ccp(keyboardN.contentSize.width/2, keyboardN.contentSize.height/2)];
    [keyboardM.children.lastObject setPosition:ccp(keyboardM.contentSize.width/2, keyboardM.contentSize.height/2)];
    [keyboardSpace.children.lastObject setPosition:ccp(keyboardSpace.contentSize.width/2, keyboardSpace.contentSize.height/2)];
    [keyboardDone.children.lastObject setPosition:ccp(keyboardDone.contentSize.width/2, keyboardDone.contentSize.height/2)];
        
    menuKeyboardUpper = [CCMenu menuWithItems:keyboardQ, keyboardW, keyboardE, keyboardR,
                         keyboardT, keyboardY, keyboardU, keyboardI, keyboardO, keyboardP, nil];
    menuKeyboardMiddle = [CCMenu menuWithItems:keyboardA, keyboardS, keyboardD, keyboardF,
                          keyboardG, keyboardH, keyboardJ, keyboardK, keyboardL, nil];
    menuKeyboardLower = [CCMenu menuWithItems:keyboardZ, keyboardX, keyboardC, keyboardV,
                         keyboardB, keyboardN, keyboardM, nil];
    menuKeyboard = [CCMenu menuWithItems:keyboardUp_on, keyboardUp_off, keyboardDel,
                    keyboardDone, keyboardSpace, nil];
    
    [labelVerticalLine setAnchorPoint:ccp(1, 0)];
    
    [menuKeyboard setPosition:ccp(screenSize.width/2, 0)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [menuKeyboardUpper alignItemsHorizontallyWithPadding:0.2f];
        [menuKeyboardUpper setPosition:ccp(screenSize.width/2, 208)];
        [menuKeyboardMiddle alignItemsHorizontallyWithPadding:0.2f];
        [menuKeyboardMiddle setPosition:ccp(screenSize.width/2, 155)];
        [menuKeyboardLower alignItemsHorizontallyWithPadding:0.2f];
        [menuKeyboardLower setPosition:ccp(screenSize.width/2, 102)];
        
        [keyboardUp_on setPosition:ccp(-137, 102)];
        [keyboardUp_off setPosition:ccp(-137, 102)];
        [keyboardDel setPosition:ccp(137, 102)];
        [keyboardDone setPosition:ccp(120, 49)];
        [keyboardSpace setPosition:ccp(0, 49)];
        
        if (screenSize.height == 568.00) {
            [keyboard setPosition:ccp(screenSize.width/2, screenSize.height/2 - 420)];
        }
        else {
            [keyboard setPosition:ccp(screenSize.width/2, screenSize.height/2 - 376)];
        }
        
        [labelVerticalLine setPosition:ccp(screenSize.width/2 - 2, screenSize.height/2 + 167)];
    }
    else {
        [menuKeyboardUpper alignItemsHorizontallyWithPadding:3.2f * 2.4f];
        [menuKeyboardUpper setPosition:ccp(screenSize.width/2, 208 * 2.133f)];
        [menuKeyboardMiddle alignItemsHorizontallyWithPadding:3.2f * 2.4f];
        [menuKeyboardMiddle setPosition:ccp(screenSize.width/2, 155 * 2.133f)];
        [menuKeyboardLower alignItemsHorizontallyWithPadding:3.2f * 2.4f];
        [menuKeyboardLower setPosition:ccp(screenSize.width/2, 102 * 2.133f)];
        
        [keyboardUp_on setPosition:ccp(-(137 * 2.4f), 102 * 2.133f)];
        [keyboardUp_off setPosition:ccp(-(137 * 2.4f), 102 * 2.133f)];
        [keyboardDel setPosition:ccp(137 * 2.4f, 102 * 2.133f)];
        [keyboardDone setPosition:ccp(119 * 2.4f, 49 * 2.133f)];
        [keyboardSpace setPosition:ccp(0, 49 * 2.133f)];
        
        [keyboard setPosition:ccp(screenSize.width/2, screenSize.height/2 - (376 * 2.133f))];
        [labelVerticalLine setPosition:ccp(screenSize.width/2 - (2 * 2.4f), screenSize.height/2 + (168.5 * 2.133f))];
    }
    
    menuKeyboard.isTouchEnabled = NO;
    menuKeyboardUpper.isTouchEnabled = NO;
    menuKeyboardMiddle.isTouchEnabled = NO;
    menuKeyboardLower.isTouchEnabled = NO;
    labelVerticalLine.visible = NO;
}

// finishes typing with the keyboard
-(void)finishTyping
{
    menuKeyboard.isTouchEnabled = NO;
    menuKeyboardUpper.isTouchEnabled = NO;
    menuKeyboardMiddle.isTouchEnabled = NO;
    menuKeyboardLower.isTouchEnabled = NO;
    
    menuChoice.isTouchEnabled = YES;
    menuClasses.isTouchEnabled = YES;
    menuOptions.isTouchEnabled = YES;
    
    labelVerticalLine.visible = NO;
    
    [self unschedule:@selector(updateVerticalLine:)];
    [[GameManager sharedGameManager] writePlayerName:playerName];
        
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [keyboard runAction:[CCMoveTo actionWithDuration:0.3f
                                                position:ccp(screenSize.width/2,
                                                             screenSize.height/2 - 376)]];
    }
    else {
        [keyboard runAction:[CCMoveTo actionWithDuration:0.3f
                                                position:ccp(screenSize.width/2,
                                                             screenSize.height/2 - (376 * 2.133f))]];
    }
    
    [self scheduleOnce:@selector(hideKeyboard:) delay:0.3f];
}

// types a letter
-(void)type:(NSString*)letter
{
    if (playerName.length < 10) {
        playerName = [NSString stringWithFormat:@"%@%@",
                      playerName, letter];
        
        [self writeName];
        
        if (isCapital) {
            isCapital = NO;
            keyboardUp_on.isEnabled = NO;
            keyboardUp_on.visible = NO;
            keyboardUp_off.isEnabled = YES;
            keyboardUp_off.visible = YES;
        }
    }
}

// deletes a letter
-(void)deleteLetter
{
    if (playerName.length > 0) {
        playerName = [playerName substringToIndex:playerName.length - 1];
        
        [self writeName];
        
        if (playerName.length == 0) {
            isCapital = YES;
            keyboardUp_on.isEnabled = YES;
            keyboardUp_on.visible = YES;
            keyboardUp_off.isEnabled = NO;
            keyboardUp_off.visible = NO;
        }
        else {
            isCapital = NO;
            keyboardUp_on.isEnabled = NO;
            keyboardUp_on.visible = NO;
            keyboardUp_off.isEnabled = YES;
            keyboardUp_off.visible = YES;
        }
    }
}

// writes player's name
-(void)writeName
{
    [self removeChild:labelNameVal cleanup:YES];

    labelNameVal = [Utility labelWithString:playerName
                                   fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];

    [labelNameVal setAnchorPoint:ccp(1, 0)];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [labelNameVal setPosition:ccp(screenSize.width/2 - 13, screenSize.height/2 + 167)];
    }
    else {
        [labelNameVal setPosition:ccp(screenSize.width/2 - (13 * 2.4f), screenSize.height/2 + (166 * 2.133f))];
    }
    
    [self addChild:labelNameVal z:1 tag:6];
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if ([[GameCenterManager sharedGameCenterManager] pendingInvite]) {
        [self setupArenaView];
    }
    
    if (keyboardDone.isEnabled && playerName.length == 0) {
        keyboardDone.isEnabled = NO;
        [(CCLabelTTF*)keyboardDone.children.lastObject setColor:ccc3(60, 60, 60)];
    }
    else if (!keyboardDone.isEnabled && playerName.length > 0) {
        keyboardDone.isEnabled = YES;
        [(CCLabelTTF*)keyboardDone.children.lastObject setColor:ccWHITE];
    }
    
    if (shouldGlow) {
        rankBar2.opacity += 2.0f;
        
        if (rankBar2.opacity >= 120.0f) shouldGlow = NO;
    }
    else {
        rankBar2.opacity -= 2.0f;
        
        if (rankBar2.opacity <= 0.0f) shouldGlow = YES;
    }
    
    if (itemHelp.isSelected || itemMenu.isSelected ||
        itemInventory.isSelected ||
        itemClass1.isSelected || itemClass2.isSelected ||
        itemClass3.isSelected || itemClass4.isSelected ||
        itemClass5.isSelected || itemClass6.isSelected ||
        itemClass7.isSelected || itemClass8.isSelected ||
        itemClass9.isSelected || keyboardQ.isSelected ||
        keyboardW.isSelected || keyboardE.isSelected ||
        keyboardR.isSelected || keyboardT.isSelected ||
        keyboardY.isSelected || keyboardU.isSelected ||
        keyboardI.isSelected || keyboardO.isSelected ||
        keyboardP.isSelected || keyboardA.isSelected ||
        keyboardS.isSelected || keyboardD.isSelected ||
        keyboardF.isSelected || keyboardG.isSelected ||
        keyboardH.isSelected || keyboardJ.isSelected ||
        keyboardK.isSelected || keyboardL.isSelected ||
        keyboardZ.isSelected || keyboardX.isSelected ||
        keyboardC.isSelected || keyboardV.isSelected ||
        keyboardB.isSelected || keyboardN.isSelected ||
        keyboardM.isSelected || keyboardUp_on.isSelected ||
        keyboardUp_off.isSelected || keyboardDel.isSelected ||
        keyboardDone.isSelected || keyboardSpace.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemHelp.isSelected && !itemMenu.isSelected &&
             !itemInventory.isSelected &&
             !itemClass1.isSelected && !itemClass2.isSelected &&
             !itemClass3.isSelected && !itemClass4.isSelected &&
             !itemClass5.isSelected && !itemClass6.isSelected &&
             !itemClass7.isSelected && !itemClass8.isSelected &&
             !itemClass9.isSelected && !keyboardQ.isSelected &&
             !keyboardW.isSelected && !keyboardE.isSelected &&
             !keyboardR.isSelected && !keyboardT.isSelected &&
             !keyboardY.isSelected && !keyboardU.isSelected &&
             !keyboardI.isSelected && !keyboardO.isSelected &&
             !keyboardP.isSelected && !keyboardA.isSelected &&
             !keyboardS.isSelected && !keyboardD.isSelected &&
             !keyboardF.isSelected && !keyboardG.isSelected &&
             !keyboardH.isSelected && !keyboardJ.isSelected &&
             !keyboardK.isSelected && !keyboardL.isSelected &&
             !keyboardZ.isSelected && !keyboardX.isSelected &&
             !keyboardC.isSelected && !keyboardV.isSelected &&
             !keyboardB.isSelected && !keyboardN.isSelected &&
             !keyboardM.isSelected && !keyboardUp_on.isSelected &&
             !keyboardUp_off.isSelected && !keyboardDel.isSelected &&
             !keyboardDone.isSelected && !keyboardSpace.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

// updates vertical line in keyboard
-(void)updateVerticalLine:(ccTime)dt
{
    if (labelVerticalLine.visible) {
        labelVerticalLine.visible = NO;
    }
    else {
        labelVerticalLine.visible = YES;
    }
}

// hides keyboard after a specified time
-(void)hideKeyboard:(ccTime)dt
{
    keyboard.visible = NO;
}

#pragma mark - change the character class

// chooses the first class
-(void)chooseClass1
{
    [[GameManager sharedGameManager] writePlayerClass:1];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats
                                     withTransition:NO];
}

// chooses the second class
-(void)chooseClass2
{
    [[GameManager sharedGameManager] writePlayerClass:2];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats
                                     withTransition:NO];
}

// chooses the third class
-(void)chooseClass3
{
    [[GameManager sharedGameManager] writePlayerClass:3];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats
                                     withTransition:NO];
}

// chooses the fourth class
-(void)chooseClass4
{
    [[GameManager sharedGameManager] writePlayerClass:4];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats
                                     withTransition:NO];
}

// chooses the fifth class
-(void)chooseClass5
{
    [[GameManager sharedGameManager] writePlayerClass:5];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats
                                     withTransition:NO];
}

// chooses the sixth class
-(void)chooseClass6
{
    [[GameManager sharedGameManager] writePlayerClass:6];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats
                                     withTransition:NO];
}

// chooses the seventh class
-(void)chooseClass7
{
    [[GameManager sharedGameManager] writePlayerClass:7];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats
                                     withTransition:NO];
}

// chooses the eighth class
-(void)chooseClass8
{
    [[GameManager sharedGameManager] writePlayerClass:8];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats
                                     withTransition:NO];
}

// chooses the ninth class
-(void)chooseClass9
{
    [[GameManager sharedGameManager] writePlayerClass:9];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats
                                     withTransition:NO];
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if (!menuKeyboard.isTouchEnabled &&
        location.x >= labelNameVal.position.x - labelNameVal.contentSize.width &&
        location.x <= labelNameVal.position.x &&
        location.y >= labelNameVal.position.y &&
        location.y <= labelNameVal.position.y + labelNameVal.contentSize.height) {
        
        menuChoice.isTouchEnabled = NO;
        menuClasses.isTouchEnabled = NO;
        menuOptions.isTouchEnabled = NO;
        
        keyboard.visible = YES;
        
        menuKeyboard.isTouchEnabled = YES;
        menuKeyboardUpper.isTouchEnabled = YES;
        menuKeyboardMiddle.isTouchEnabled = YES;
        menuKeyboardLower.isTouchEnabled = YES;
        
        labelVerticalLine.visible = YES;
        
        isCapital = YES;
        keyboardUp_on.isEnabled = YES;
        keyboardUp_on.visible = YES;
        keyboardUp_off.isEnabled = NO;
        keyboardUp_off.visible = NO;
        
        [self schedule:@selector(updateVerticalLine:) interval:0.6f];
        
        if (![[Player sharedPlayer] name]) {
            playerName = @"";
            
            [self writeName];
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [keyboard runAction:[CCMoveTo actionWithDuration:0.3f
                                                        position:ccp(screenSize.width/2,
                                                                     screenSize.height/2 - 176)]];
            }
            else {
                [keyboard runAction:[CCMoveTo actionWithDuration:0.3f
                                                        position:ccp(screenSize.width/2,
                                                                     screenSize.height/2 - 136)]];
            }
        }
        else {
            [keyboard runAction:[CCMoveTo actionWithDuration:0.3f
                                                    position:ccp(screenSize.width/2,
                                                                 screenSize.height/2 - (136 * 2.133f))]];
        }
    }
}

#pragma mark - menu choices

// shows the inventory scene
-(void)showInventory
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneInventory withTransition:NO];
}

// shows the story scene
-(void)showStory
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneStory withTransition:NO];
}

// shows the help scene
-(void)showHelp
{
    self.isTouchEnabled = NO;
    menuChoice.isTouchEnabled = NO;
    menuOptions.isTouchEnabled = NO;
    menuClasses.isTouchEnabled = NO;
    
    ccColor4B colour = {0, 0, 0, 0};
    StatsHelpLayer *help_layer = [[StatsHelpLayer alloc] initWithColor:colour];
    
    [self addChild:help_layer z:10];
}

// shows the play scene
-(void)showPlay
{
    [[GameManager sharedGameManager] runSceneWithID:kScenePlay withTransition:NO];
}

#pragma mark - pausing and resuming

// resumes after help
-(void)resumeFromHelp
{
    self.isTouchEnabled = YES;
    menuChoice.isTouchEnabled = YES;
    menuOptions.isTouchEnabled = YES;
    menuClasses.isTouchEnabled = YES;
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
