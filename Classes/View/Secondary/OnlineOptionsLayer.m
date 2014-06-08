//
//  OnlineOptionsLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 23/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "OnlineOptionsLayer.h"
#import "GameManager.h"
#import "GameCenterManager.h"
#import "SoundManager.h"
#import "MultiplayLayer.h"
#import "Utility.h"

#pragma mark - OnlineOptionsLayer

@implementation OnlineOptionsLayer

-(id)init
{
	if((self=[super initWithColor:ccc4(0, 0, 0, 255)])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"LevelOptionMsg", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:28]];
        
        [CCMenuItemFont setFontSize:[Utility getFontSize:32]];
        [CCMenuItemFont setFontName:@"Shark Crash"];
        
        itemSimilarLevel = [CCMenuItemFont itemWithString:NSLocalizedString(@"SimilarLevel", nil)];
        itemAnyLevel = [CCMenuItemFont itemWithString:NSLocalizedString(@"AnyLevel", nil)];
        
        itemOpponentsLevel = [CCMenuItemToggle itemWithTarget:self
                                                     selector:@selector(chooseOpponentsLevel:)
                                                        items:itemSimilarLevel, itemAnyLevel, nil];
        
        if ([[GameCenterManager sharedGameCenterManager] shouldFightSimilarLevel]) {
            [itemOpponentsLevel setSelectedIndex:0];
        }
        else {
            [itemOpponentsLevel setSelectedIndex:1];
        }
        
        itemConfirm = [CCMenuItemFont itemWithString:NSLocalizedString(@"Confirm", nil)
                                              target:self selector:@selector(closeMenu)];
                		
		menuChoice = [CCMenu menuWithItems:itemOpponentsLevel, itemConfirm, nil];
        
        [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 20)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 100)];
            
            [menuChoice alignItemsVerticallyWithPadding:70];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 60)];
        }
        else {
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (100 * 2.133f))];
            
            [menuChoice alignItemsVerticallyWithPadding:(70 * 2.4f)];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - (60 * 2.133f))];
        }
        
        [self addChild:labelMsg z:1 tag:0];
		[self addChild:menuChoice z:1 tag:1];
        
        [self scheduleUpdate];        
	}
    
	return self;
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if (itemSimilarLevel.isSelected || itemAnyLevel.isSelected ||
        itemConfirm.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemSimilarLevel.isSelected && !itemAnyLevel.isSelected &&
             !itemConfirm.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// user chooses opponents level
-(void)chooseOpponentsLevel:(id)sender
{
    if ([[GameCenterManager sharedGameCenterManager] shouldFightSimilarLevel]) {
        [[GameManager sharedGameManager] writeConfigurationOnlineSimilarLevel:NO];
    }
    else {
        [[GameManager sharedGameManager] writeConfigurationOnlineSimilarLevel:YES];
    }
}

// closes the multiplayer preferences menu
-(void)closeMenu
{
    MultiplayLayer *multiplayLayer = (MultiplayLayer*)self.parent;
    [multiplayLayer resume];
    [self.parent removeChild:self cleanup:YES];
}

@end
