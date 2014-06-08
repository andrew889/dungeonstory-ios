//
//  StoryLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "StoryLayer.h"
#import "GameManager.h"
#import "GameCenterManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "Utility.h"

#pragma mark - StoryLayer

@implementation StoryLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	StoryLayer *layer = [StoryLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"Menu.png"];
        inventoryBG = [CCSprite spriteWithFile:@"StoryMenu.png"];
        menuBar01 = [CCSprite spriteWithFile:@"menubar.png"];
        menuBar02 = [CCSprite spriteWithFile:@"menubar.png"];
        spriteEmblem1Msg = [CCSprite spriteWithFile:@"MenuHelp6.png"];
        spriteEmblem2Msg = [CCSprite spriteWithFile:@"MenuHelp7.png"];
        spriteEmblem3Msg = [CCSprite spriteWithFile:@"MenuHelp7.png"];
        spriteEmblem4Msg = [CCSprite spriteWithFile:@"MenuHelp6.png"];
        
        [self setupStoryMenu];
        
        if (screenSize.height == 568.00) [self setupUpperBar];
        
        labelStory = [Utility labelWithString:NSLocalizedString(@"QuestLabel", nil)
                                     fontName:@"Shark Crash" fontSize:[Utility getFontSize:26]
                                        color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelEmblem = [Utility labelWithString:NSLocalizedString(@"Emblems", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccc3(255, 182, 18) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        labelProgress = [Utility labelWithString:NSLocalizedString(@"Leaderboard", nil)
                                        fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                           color:ccc3(255, 182, 18) strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
        
        labelEmblem1Msg =[CCLabelTTF labelWithString:NSLocalizedString(@"EmblemMsg01", nil)
                                            fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        labelEmblem2Msg =[CCLabelTTF labelWithString:NSLocalizedString(@"EmblemMsg02", nil)
                                            fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        labelEmblem3Msg =[CCLabelTTF labelWithString:NSLocalizedString(@"EmblemMsg03", nil)
                                            fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        labelEmblem4Msg =[CCLabelTTF labelWithString:NSLocalizedString(@"EmblemMsg04", nil)
                                            fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        [labelEmblem1Msg setColor:ccBLACK];
        [labelEmblem2Msg setColor:ccBLACK];
        [labelEmblem3Msg setColor:ccBLACK];
        [labelEmblem4Msg setColor:ccBLACK];
        
        itemStats = [CCMenuItemSprite itemWithNormalSprite:[Utility labelWithString:NSLocalizedString(@"StatsLabel", nil)
                                                                           fontName:@"Shark Crash"
                                                                           fontSize:[Utility getFontSize:26]
                                                                              color:ccWHITE
                                                                         strokeSize:[Utility getFontSize:1.5]
                                                                         stokeColor:ccBLACK]
                     
                                            selectedSprite:[Utility labelWithString:NSLocalizedString(@"StatsLabel", nil)
                                                                           fontName:@"Shark Crash"
                                                                           fontSize:[Utility getFontSize:26]
                                                                              color:ccc3(255, 204, 102)
                                                                         strokeSize:[Utility getFontSize:1.5]
                                                                         stokeColor:ccBLACK]
                     
                                                    target:self selector:@selector(showStats)];
        
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
        
        if ([[Player sharedPlayer] emblems] == 0) {
            itemEmblem1 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
            itemEmblem2 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
            itemEmblem3 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
            itemEmblem4 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
        }
        else if ([[Player sharedPlayer] emblems] == 1) {
            itemEmblem1 = [CCMenuItemImage itemWithNormalImage:@"fireEmblem.png"
                                                 selectedImage:@"fireEmblem_pressed.png"];
            itemEmblem2 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
            itemEmblem3 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
            itemEmblem4 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
        }
        else if ([[Player sharedPlayer] emblems] == 2) {
            itemEmblem1 = [CCMenuItemImage itemWithNormalImage:@"fireEmblem.png"
                                                 selectedImage:@"fireEmblem_pressed.png"];
            itemEmblem2 = [CCMenuItemImage itemWithNormalImage:@"iceEmblem.png"
                                                 selectedImage:@"iceEmblem_pressed.png"];
            itemEmblem3 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
            itemEmblem4 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
        }
        else if ([[Player sharedPlayer] emblems] == 3) {
            itemEmblem1 = [CCMenuItemImage itemWithNormalImage:@"fireEmblem.png"
                                                 selectedImage:@"fireEmblem_pressed.png"];
            itemEmblem2 = [CCMenuItemImage itemWithNormalImage:@"iceEmblem.png"
                                                 selectedImage:@"iceEmblem_pressed.png"];
            itemEmblem3 = [CCMenuItemImage itemWithNormalImage:@"moonEmblem.png"
                                                 selectedImage:@"moonEmblem_pressed.png"];
            itemEmblem4 = [CCMenuItemImage itemWithNormalImage:@"noEmblem.png"
                                                 selectedImage:@"noEmblem.png"];
        }
        else if ([[Player sharedPlayer] emblems] == 4) {
            itemEmblem1 = [CCMenuItemImage itemWithNormalImage:@"fireEmblem.png"
                                                 selectedImage:@"fireEmblem_pressed.png"];
            itemEmblem2 = [CCMenuItemImage itemWithNormalImage:@"iceEmblem.png"
                                                 selectedImage:@"iceEmblem_pressed.png"];
            itemEmblem3 = [CCMenuItemImage itemWithNormalImage:@"moonEmblem.png"
                                                 selectedImage:@"moonEmblem_pressed.png"];
            itemEmblem4 = [CCMenuItemImage itemWithNormalImage:@"sunEmblem.png"
                                                 selectedImage:@"sunEmblem_pressed.png"];
        }
		
		menuChoice = [CCMenu menuWithItems:itemStats, itemInventory, nil];
        menuEmblems = [CCMenu menuWithItems:itemEmblem1, itemEmblem2, itemEmblem3, itemEmblem4, nil];
        menuOptions = [CCMenu menuWithItems:itemHelp, itemMenu, nil];
        
        [labelEmblem setAnchorPoint:ccp(0, 0)];
        [labelEmblemVal setAnchorPoint:ccp(1, 0)];
        [labelPlayer1 setAnchorPoint:ccp(0, 0)];
        [labelPlayer2 setAnchorPoint:ccp(0, 0)];
        [labelPlayer3 setAnchorPoint:ccp(0, 0)];
        [labelPlayer4 setAnchorPoint:ccp(0, 0)];
        [labelPlayer5 setAnchorPoint:ccp(0, 0)];
        [labelPlayer6 setAnchorPoint:ccp(0, 0)];
        [labelPlayerVal1 setAnchorPoint:ccp(1, 0)];
        [labelPlayerVal2 setAnchorPoint:ccp(1, 0)];
        [labelPlayerVal3 setAnchorPoint:ccp(1, 0)];
        [labelPlayerVal4 setAnchorPoint:ccp(1, 0)];
        [labelPlayerVal5 setAnchorPoint:ccp(1, 0)];
        [labelPlayerVal6 setAnchorPoint:ccp(1, 0)];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [inventoryBG setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
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
            
            [itemStats setPosition:ccp(-100, 218)];
            [itemInventory setPosition:ccp(0, 218)];
            [labelStory setPosition:ccp(screenSize.width/2 + 100, screenSize.height/2 + 218)];
            
            [labelEmblem setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 166)];
            [labelEmblemVal setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 165)];
            
            [labelProgress setPosition:ccp(screenSize.width/2, screenSize.height/2 + 123)];
            [labelPlayer1 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 78)];
            [labelPlayer2 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 46)];
            [labelPlayer3 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 14)];
            [labelPlayer4 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 19)];
            [labelPlayer5 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 50)];
            [labelPlayer6 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 82)];
            [labelPlayerVal1 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 78)];
            [labelPlayerVal2 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 46)];
            [labelPlayerVal3 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 14)];
            [labelPlayerVal4 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 19)];
            [labelPlayerVal5 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 50)];
            [labelPlayerVal6 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 82)];
            
            [spriteEmblem1Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 80)];
            [spriteEmblem2Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 80)];
            [spriteEmblem3Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 80)];
            [spriteEmblem4Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 80)];
            [labelEmblem1Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 67)];
            [labelEmblem2Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 67)];
            [labelEmblem3Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 67)];
            [labelEmblem4Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 67)];
            
            [menuEmblems alignItemsHorizontallyWithPadding:5];
            [menuEmblems setPosition:ccp(screenSize.width/2, screenSize.height/2 - 158)];
        }
        else {
            [menuBar02 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (233 * 2.133f))];
            
            [itemStats setPosition:ccp(-(100 * 2.4f), 218.5 * 2.133f)];
            [itemInventory setPosition:ccp(0, 218.5 * 2.133f)];
            [labelStory setPosition:ccp(screenSize.width/2 + (100 * 2.4f), screenSize.height/2 + (218.5 * 2.133f))];
            
            [labelEmblem setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (166 * 2.133f))];
            [labelEmblemVal setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (164 * 2.133f))];
            
            [labelProgress setPosition:ccp(screenSize.width/2, screenSize.height/2 + (122 * 2.133f))];
            [labelPlayer1 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (77 * 2.133f))];
            [labelPlayer2 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (45 * 2.133f))];
            [labelPlayer3 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (13 * 2.133f))];
            [labelPlayer4 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (20 * 2.133f))];
            [labelPlayer5 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (51 * 2.133f))];
            [labelPlayer6 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (83 * 2.133f))];
            [labelPlayerVal1 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (77 * 2.133f))];
            [labelPlayerVal2 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (45 * 2.133f))];
            [labelPlayerVal3 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (13 * 2.133f))];
            [labelPlayerVal4 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (20 * 2.133f))];
            [labelPlayerVal5 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (51 * 2.133f))];
            [labelPlayerVal6 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (83 * 2.133f))];
            
            [spriteEmblem1Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (80 * 2.133f))];
            [spriteEmblem2Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (80 * 2.133f))];
            [spriteEmblem3Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (80 * 2.133f))];
            [spriteEmblem4Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (80 * 2.133f))];
            [labelEmblem1Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (67 * 2.133f))];
            [labelEmblem2Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (67 * 2.133f))];
            [labelEmblem3Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (67 * 2.133f))];
            [labelEmblem4Msg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (67 * 2.133f))];
            
            [menuEmblems alignItemsHorizontallyWithPadding:(15 * 2.4f)];
            [menuEmblems setPosition:ccp(screenSize.width/2, screenSize.height/2 - (158 * 2.133f))];
            [menuOptions alignItemsHorizontallyWithPadding:(180 * 2.4f)];
            [menuOptions setPosition:ccp(screenSize.width/2, screenSize.height/2 - (224 * 2.133f))];
        }
        
        [self addChild:background z:-2 tag:0];
        [self addChild:inventoryBG z:-1 tag:1];
        [self addChild:menuBar02 z:0 tag:2];
        [self addChild:labelStory z:1 tag:3];
        [self addChild:labelEmblem z:1 tag:4];
        [self addChild:labelEmblemVal z:1 tag:5];
        [self addChild:labelProgress z:1 tag:6];
        [self addChild:labelPlayer1 z:1 tag:7];
        [self addChild:labelPlayer2 z:1 tag:8];
        [self addChild:labelPlayer3 z:1 tag:9];
        [self addChild:labelPlayer4 z:1 tag:10];
        [self addChild:labelPlayer5 z:1 tag:11];
        [self addChild:labelPlayer6 z:1 tag:12];
        [self addChild:labelPlayerVal1 z:1 tag:13];
        [self addChild:labelPlayerVal2 z:1 tag:14];
        [self addChild:labelPlayerVal3 z:1 tag:15];
        [self addChild:labelPlayerVal4 z:1 tag:16];
        [self addChild:labelPlayerVal5 z:1 tag:17];
        [self addChild:labelPlayerVal6 z:1 tag:18];
        [self addChild:spriteEmblem1Msg z:2 tag:19];
        [self addChild:spriteEmblem2Msg z:2 tag:20];
        [self addChild:spriteEmblem3Msg z:2 tag:21];
        [self addChild:spriteEmblem4Msg z:2 tag:22];
        [self addChild:labelEmblem1Msg z:3 tag:23];
        [self addChild:labelEmblem2Msg z:3 tag:24];
        [self addChild:labelEmblem3Msg z:3 tag:25];
        [self addChild:labelEmblem4Msg z:3 tag:26];
		[self addChild:menuChoice z:1 tag:27];
        [self addChild:menuEmblems z:1 tag:28];
        [self addChild:menuOptions z:1 tag:29];
        
        if (screenSize.height == 568.00) {
            [self addChild:menuBar01 z:0 tag:30];
            [self addChild:labelMsg z:1 tag:31];
        }
        
        [self scheduleUpdate];
        
        [spriteEmblem3Msg setScaleX:-1.0f];
        [spriteEmblem4Msg setScaleX:-1.0f];
                
        spriteEmblem1Msg.visible = NO;
        spriteEmblem2Msg.visible = NO;
        spriteEmblem3Msg.visible = NO;
        spriteEmblem4Msg.visible = NO;
        labelEmblem1Msg.visible = NO;
        labelEmblem2Msg.visible = NO;
        labelEmblem3Msg.visible = NO;
        labelEmblem4Msg.visible = NO;
        
        itemHelp.isEnabled = NO;
        itemHelp.visible = NO;
	}
    
	return self;
}

#pragma mark - scene setup

// setups the story menu
-(void)setupStoryMenu
{
    friendName1 = [NSString stringWithFormat:@". . ."];
    friendName2 = [NSString stringWithFormat:@". . ."];
    friendName3 = [NSString stringWithFormat:@". . ."];
    friendName4 = [NSString stringWithFormat:@". . ."];
    friendName5 = [NSString stringWithFormat:@". . ."];
    friendName6 = [NSString stringWithFormat:@". . ."];
    
    friendScore1 = [NSString stringWithFormat:@". . ."];
    friendScore2 = [NSString stringWithFormat:@". . ."];
    friendScore3 = [NSString stringWithFormat:@". . ."];
    friendScore4 = [NSString stringWithFormat:@". . ."];
    friendScore5 = [NSString stringWithFormat:@". . ."];
    friendScore6 = [NSString stringWithFormat:@". . ."];
    
    labelPlayer1 = [Utility labelWithString:friendName1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer2 = [Utility labelWithString:friendName2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer3 = [Utility labelWithString:friendName3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer4 = [Utility labelWithString:friendName4 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer5 = [Utility labelWithString:friendName5 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer6 = [Utility labelWithString:friendName6 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    labelPlayerVal1 = [Utility labelWithString:friendScore1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal2 = [Utility labelWithString:friendScore2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal3 = [Utility labelWithString:friendScore3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal4 = [Utility labelWithString:friendScore4 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal5 = [Utility labelWithString:friendScore5 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal6 = [Utility labelWithString:friendScore6 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    currentEmblem = [NSString stringWithFormat:@"%d / 4", [[Player sharedPlayer] emblems]];
    
    labelEmblemVal = [Utility labelWithString:currentEmblem fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    leaderboard = [[GameCenterManager sharedGameCenterManager] retrieveLeaderboard];
    identifiers = [[NSMutableArray alloc] initWithCapacity:6];
    
    [leaderboard loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
        if (error != nil)  NSLog(@"Error: could not retrieve the leaderboard!");
        
        if (scores != nil) {
            if (scores.count >= 1) {
                friendScore1 = [NSString stringWithFormat:@"%lld", ((GKScore*)[scores objectAtIndex:0]).value];
                [identifiers addObject:((GKScore*)[scores objectAtIndex:0]).playerID];
            }
            
            if (scores.count >= 2) {
                friendScore2 = [NSString stringWithFormat:@"%lld", ((GKScore*)[scores objectAtIndex:1]).value];
                [identifiers addObject:((GKScore*)[scores objectAtIndex:1]).playerID];
            }
            
            if (scores.count >= 3) {
                friendScore3 = [NSString stringWithFormat:@"%lld", ((GKScore*)[scores objectAtIndex:2]).value];
                [identifiers addObject:((GKScore*)[scores objectAtIndex:2]).playerID];
            }
            
            if (scores.count >= 4) {
                friendScore4 = [NSString stringWithFormat:@"%lld", ((GKScore*)[scores objectAtIndex:3]).value];
                [identifiers addObject:((GKScore*)[scores objectAtIndex:3]).playerID];
            }
            
            if (scores.count >= 5) {
                friendScore5 = [NSString stringWithFormat:@"%lld", ((GKScore*)[scores objectAtIndex:4]).value];
                [identifiers addObject:((GKScore*)[scores objectAtIndex:4]).playerID];
            }
            
            if (scores.count == 6) {
                friendScore6 = [NSString stringWithFormat:@"%lld", ((GKScore*)[scores objectAtIndex:5]).value];
                [identifiers addObject:((GKScore*)[scores objectAtIndex:5]).playerID];
            }
            
            [self performSelectorOnMainThread:@selector(updateScoreLabels) withObject:nil waitUntilDone:YES];
        }
    }];
}

// update score labels
-(void)updateScoreLabels
{
    [self removeChild:labelPlayerVal1 cleanup:YES];
    [self removeChild:labelPlayerVal2 cleanup:YES];
    [self removeChild:labelPlayerVal3 cleanup:YES];
    [self removeChild:labelPlayerVal4 cleanup:YES];
    [self removeChild:labelPlayerVal5 cleanup:YES];
    [self removeChild:labelPlayerVal6 cleanup:YES];
    
    labelPlayerVal1 = [Utility labelWithString:friendScore1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal2 = [Utility labelWithString:friendScore2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal3 = [Utility labelWithString:friendScore3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal4 = [Utility labelWithString:friendScore4 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal5 = [Utility labelWithString:friendScore5 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayerVal6 = [Utility labelWithString:friendScore6 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                         color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    [labelPlayerVal1 setAnchorPoint:ccp(1, 0)];
    [labelPlayerVal2 setAnchorPoint:ccp(1, 0)];
    [labelPlayerVal3 setAnchorPoint:ccp(1, 0)];
    [labelPlayerVal4 setAnchorPoint:ccp(1, 0)];
    [labelPlayerVal5 setAnchorPoint:ccp(1, 0)];
    [labelPlayerVal6 setAnchorPoint:ccp(1, 0)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [labelPlayerVal1 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 78)];
        [labelPlayerVal2 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 46)];
        [labelPlayerVal3 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 + 14)];
        [labelPlayerVal4 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 19)];
        [labelPlayerVal5 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 50)];
        [labelPlayerVal6 setPosition:ccp(screenSize.width/2 + 142, screenSize.height/2 - 82)];
    }
    else {
        [labelPlayerVal1 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (77 * 2.133f))];
        [labelPlayerVal2 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (45 * 2.133f))];
        [labelPlayerVal3 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 + (13 * 2.133f))];
        [labelPlayerVal4 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (20 * 2.133f))];
        [labelPlayerVal5 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (51 * 2.133f))];
        [labelPlayerVal6 setPosition:ccp(screenSize.width/2 + (142 * 2.4f), screenSize.height/2 - (83 * 2.133f))];
    }
    
    [self addChild:labelPlayerVal1 z:1 tag:13];
    [self addChild:labelPlayerVal2 z:1 tag:14];
    [self addChild:labelPlayerVal3 z:1 tag:15];
    [self addChild:labelPlayerVal4 z:1 tag:16];
    [self addChild:labelPlayerVal5 z:1 tag:17];
    [self addChild:labelPlayerVal6 z:1 tag:18];
        
    [GKPlayer loadPlayersForIdentifiers:identifiers withCompletionHandler:^(NSArray *players, NSError *error) {
        if (error != nil)  NSLog(@"Error: could not retrieve player information!");

        if (players != nil) {
            if (players.count >= 1) {
                friendName1 = ((GKPlayer*)[players objectAtIndex:0]).alias;
            }
            
            if (players.count >= 2) {
                friendName2 = ((GKPlayer*)[players objectAtIndex:1]).alias;
            }
            
            if (players.count >= 3) {
                friendName3 = ((GKPlayer*)[players objectAtIndex:2]).alias;
            }
            
            if (players.count >= 4) {
                friendName4 = ((GKPlayer*)[players objectAtIndex:3]).alias;
            }
            
            if (players.count >= 5) {
                friendName5 = ((GKPlayer*)[players objectAtIndex:4]).alias;
            }
            
            if (players.count == 6) {
                friendName6 = ((GKPlayer*)[players objectAtIndex:5]).alias;
            }
            
            [self performSelectorOnMainThread:@selector(updatePlayerLabels) withObject:nil waitUntilDone:YES];
        }
    }];
}

// update player labels
-(void)updatePlayerLabels
{
    [self removeChild:labelPlayer1 cleanup:YES];
    [self removeChild:labelPlayer2 cleanup:YES];
    [self removeChild:labelPlayer3 cleanup:YES];
    [self removeChild:labelPlayer4 cleanup:YES];
    [self removeChild:labelPlayer5 cleanup:YES];
    [self removeChild:labelPlayer6 cleanup:YES];
    
    labelPlayer1 = [Utility labelWithString:friendName1 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer2 = [Utility labelWithString:friendName2 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer3 = [Utility labelWithString:friendName3 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer4 = [Utility labelWithString:friendName4 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer5 = [Utility labelWithString:friendName5 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    labelPlayer6 = [Utility labelWithString:friendName6 fontName:@"Shark Crash" fontSize:[Utility getFontSize:20]
                                      color:ccWHITE strokeSize:[Utility getFontSize:1.5] stokeColor:ccBLACK];
    
    [labelPlayer1 setAnchorPoint:ccp(0, 0)];
    [labelPlayer2 setAnchorPoint:ccp(0, 0)];
    [labelPlayer3 setAnchorPoint:ccp(0, 0)];
    [labelPlayer4 setAnchorPoint:ccp(0, 0)];
    [labelPlayer5 setAnchorPoint:ccp(0, 0)];
    [labelPlayer6 setAnchorPoint:ccp(0, 0)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [labelPlayer1 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 78)];
        [labelPlayer2 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 46)];
        [labelPlayer3 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 + 14)];
        [labelPlayer4 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 19)];
        [labelPlayer5 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 50)];
        [labelPlayer6 setPosition:ccp(screenSize.width/2 - 143, screenSize.height/2 - 82)];
    }
    else {
        [labelPlayer1 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (77 * 2.133f))];
        [labelPlayer2 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (45 * 2.133f))];
        [labelPlayer3 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 + (13 * 2.133f))];
        [labelPlayer4 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (20 * 2.133f))];
        [labelPlayer5 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (51 * 2.133f))];
        [labelPlayer6 setPosition:ccp(screenSize.width/2 - (143 * 2.4f), screenSize.height/2 - (83 * 2.133f))];
    }
    
    [self addChild:labelPlayer1 z:1 tag:7];
    [self addChild:labelPlayer2 z:1 tag:8];
    [self addChild:labelPlayer3 z:1 tag:9];
    [self addChild:labelPlayer4 z:1 tag:10];
    [self addChild:labelPlayer5 z:1 tag:11];
    [self addChild:labelPlayer6 z:1 tag:12];
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

// updates battle
-(void)update:(ccTime)dt
{
    if ([[GameCenterManager sharedGameCenterManager] pendingInvite]) {
        [self setupArenaView];
    }
    
    if (itemEmblem1.isSelected && [[Player sharedPlayer] emblems] >= 1) {
        spriteEmblem1Msg.visible = YES;
        labelEmblem1Msg.visible = YES;
    }
    else {
        spriteEmblem1Msg.visible = NO;
        labelEmblem1Msg.visible = NO;
    }
    
    if (itemEmblem2.isSelected && [[Player sharedPlayer] emblems] >= 2) {
        spriteEmblem2Msg.visible = YES;
        labelEmblem2Msg.visible = YES;
    }
    else {
        spriteEmblem2Msg.visible = NO;
        labelEmblem2Msg.visible = NO;
    }
    
    if (itemEmblem3.isSelected && [[Player sharedPlayer] emblems] >= 3) {
        spriteEmblem3Msg.visible = YES;
        labelEmblem3Msg.visible = YES;
    }
    else {
        spriteEmblem3Msg.visible = NO;
        labelEmblem3Msg.visible = NO;
    }
    
    if (itemEmblem4.isSelected && [[Player sharedPlayer] emblems] >= 4) {
        spriteEmblem4Msg.visible = YES;
        labelEmblem4Msg.visible = YES;
    }
    else {
        spriteEmblem4Msg.visible = NO;
        labelEmblem4Msg.visible = NO;
    }
    
    if (itemHelp.isSelected || itemMenu.isSelected ||
        itemStats.isSelected || itemInventory.isSelected ||
        (itemEmblem1.isSelected && [[Player sharedPlayer] emblems] >= 1) ||
        (itemEmblem2.isSelected && [[Player sharedPlayer] emblems] >= 2) ||
        (itemEmblem3.isSelected && [[Player sharedPlayer] emblems] >= 3) ||
        (itemEmblem4.isSelected && [[Player sharedPlayer] emblems] == 4)) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemHelp.isSelected && !itemMenu.isSelected &&
             !itemStats.isSelected && !itemInventory.isSelected &&
             !itemEmblem1.isSelected && !itemEmblem2.isSelected &&
             !itemEmblem3.isSelected && !itemEmblem4.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// shows the stats scene
-(void)showStats
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneStats withTransition:NO];
}

// shows the inventory scene
-(void)showInventory
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneInventory withTransition:NO];
}

// shows the play scene
-(void)showPlay
{
    [[GameManager sharedGameManager] runSceneWithID:kScenePlay withTransition:NO];
}

// shows the help
-(void)showHelp
{
    
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
