//
//  PlayHelpLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 24/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "PlayHelpLayer.h"
#import "GameManager.h"
#import "PlayLayer.h"
#import "Utility.h"

#pragma mark - PlayHelpLayer

@implementation PlayHelpLayer

-(id)initWithColor:(ccColor4B)color
{
	if((self=[super initWithColor:color])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        spriteHelp1 = [CCSprite spriteWithFile:@"MenuHelp1.png"];
        spriteHelp2 = [CCSprite spriteWithFile:@"MenuHelp3.png"];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"HelpPlay01", nil)
                                      fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        [labelMsg setColor:ccBLACK];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 155)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 144)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (155 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (144 * 2.133f))];
        }
        
        [self addChild:spriteHelp1 z:0 tag:0];
        [self addChild:spriteHelp2 z:0 tag:1];
        [self addChild:labelMsg z:1 tag:2];
        
        self.isTouchEnabled = YES;
        
        spriteHelp2.visible = NO;
        
        helpTurn = 4;
	}
    
	return self;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    if (helpTurn == 4) {
        [labelMsg setString:NSLocalizedString(@"HelpPlay02", nil)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 80)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 67)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (80 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (67 * 2.133f))];
        }
        
        [spriteHelp1 setScaleX:-1.0f];
        [spriteHelp1 setScaleY:1.2f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 3) {
        [labelMsg setString:NSLocalizedString(@"HelpPlay03", nil)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 45)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 57)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (45 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (57 * 2.133f))];
        }
        
        [spriteHelp1 setScaleX:1.0f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 2) {
        [labelMsg setString:NSLocalizedString(@"HelpPlay04", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 95)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 80)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (95 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (80 * 2.133f))];
        }
        
        spriteHelp1.visible = NO;
        spriteHelp2.visible = YES;
        
        [spriteHelp2 setScaleY:1.2f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 1) {
        [labelMsg setString:NSLocalizedString(@"HelpPlay05", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 86)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 71)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (86 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (71 * 2.133f))];
        }
        
        [spriteHelp2 setScaleX:-1.0f];
        [spriteHelp2 setScaleY:1.4f];
        
        helpTurn += -1;
    }
    else {
        PlayLayer *playLayer = (PlayLayer*)self.parent;
        [playLayer resumeFromHelp];
        [self.parent removeChild:self cleanup:YES];
    }
}

@end
