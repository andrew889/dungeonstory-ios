//
//  ConfirmationLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 23/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "ConfirmationLayer.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "OptionsLayer.h"
#import "Utility.h"

#pragma mark - ConfirmationLayer

@implementation ConfirmationLayer

-(id)initWithColor:(ccColor4B)color
{
	if((self=[super initWithColor:color])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"ResetDataMsg", nil)
                                      fontName:@"Shark Crash" fontSize:[Utility getFontSize:28]];
        
        [CCMenuItemFont setFontSize:[Utility getFontSize:32]];
        [CCMenuItemFont setFontName:@"Shark Crash"];
        
        itemCancel = [CCMenuItemFont itemWithString:NSLocalizedString(@"Cancel", nil)
                                             target:self selector:@selector(cancel)];
        itemConfirm = [CCMenuItemFont itemWithString:NSLocalizedString(@"Confirm", nil)
                                              target:self selector:@selector(confirm)];
		
		menuChoice = [CCMenu menuWithItems:itemCancel, itemConfirm, nil];
        
        [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 20)];
            
            [menuChoice alignItemsHorizontallyWithPadding:80];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - 110)];
        }
        else {
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (20 * 2.133f))];
            
            [menuChoice alignItemsHorizontallyWithPadding:(80 * 2.4f)];
            [menuChoice setPosition:ccp(screenSize.width/2, screenSize.height/2 - (110 * 2.133f))];
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
    if (itemCancel.isSelected || itemConfirm.isSelected) {
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemCancel.isSelected && !itemConfirm.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - menu choices

// confirms the selection
-(void)confirm
{
    [[GameManager sharedGameManager] deleteGameData];
    [[GameManager sharedGameManager] readGameData];
    [[GameManager sharedGameManager] runSceneWithID:kSceneMenu withTransition:YES];
}

// cancels the selection
-(void)cancel
{
    OptionsLayer *optionsLayer = (OptionsLayer*)self.parent;
    [optionsLayer resume];
    [self.parent removeChild:self cleanup:YES];
}

@end
