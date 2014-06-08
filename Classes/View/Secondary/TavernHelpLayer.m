//
//  TavernHelpLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 24/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "TavernHelpLayer.h"
#import "GameManager.h"
#import "TavernLayer.h"
#import "Utility.h"

#pragma mark - TavernHelpLayer

@implementation TavernHelpLayer

-(id)initWithColor:(ccColor4B)color
{
	if((self=[super initWithColor:color])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        spriteHelp1 = [CCSprite spriteWithFile:@"MenuHelp1.png"];
        spriteHelp2 = [CCSprite spriteWithFile:@"MenuHelp3.png"];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"HelpTavern01", nil)
                                      fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];

        [labelMsg setColor:ccBLACK];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 85)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 69)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (85 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (69 * 2.133f))];
        }
        
        [self addChild:spriteHelp1 z:0 tag:0];
        [self addChild:spriteHelp2 z:0 tag:1];
        [self addChild:labelMsg z:1 tag:2];
        
        self.isTouchEnabled = YES;
        
        spriteHelp2.visible = NO;
                
        [spriteHelp1 setScaleY:1.6f];
        
        helpTurn = 1;
	}
    
	return self;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    if (helpTurn == 1) {
        [labelMsg setString:NSLocalizedString(@"HelpTavern02", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 53)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 74)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (53 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (74 * 2.133f))];
        }
        
        [spriteHelp1 setScaleY:-1.9f];
        
        helpTurn += -1;
    }
    else {
        TavernLayer *tavernLayer = (TavernLayer*)self.parent;
        [tavernLayer resumeFromHelp];
        [self.parent removeChild:self cleanup:YES];
    }
}

@end
