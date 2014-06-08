//
//  StatsHelpLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 24/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "StatsHelpLayer.h"
#import "GameManager.h"
#import "StatsLayer.h"
#import "Utility.h"

#pragma mark - StatsHelpLayer

@implementation StatsHelpLayer

-(id)initWithColor:(ccColor4B)color
{
	if((self=[super initWithColor:color])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        spriteHelp1 = [CCSprite spriteWithFile:@"MenuHelp1.png"];
        spriteHelp2 = [CCSprite spriteWithFile:@"MenuHelp2.png"];
        spriteHelp3 = [CCSprite spriteWithFile:@"MenuHelp3.png"];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"HelpStats01", nil)
                                      fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        [labelMsg setColor:ccBLACK];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 127)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 119)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (127 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (119 * 2.133f))];
        }
        
        [self addChild:spriteHelp1 z:0 tag:0];
        [self addChild:spriteHelp2 z:0 tag:1];
        [self addChild:spriteHelp3 z:0 tag:2];
        [self addChild:labelMsg z:1 tag:3];
        
        self.isTouchEnabled = YES;
        
        helpTurn = 12;
        
        [spriteHelp1 setScaleY:0.7f];
        
        spriteHelp2.visible = NO;
        spriteHelp3.visible = NO;
	}
    
	return self;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    if (helpTurn == 12) {
        [labelMsg setString:NSLocalizedString(@"HelpStats02", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 77)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 68)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (77 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (68 * 2.133f))];
        }
        
        [spriteHelp2 setScaleY:1.2f];
        
        spriteHelp1.visible = NO;
        spriteHelp2.visible = YES;
                
        helpTurn += -1;
    }
    else if (helpTurn == 11) {
        [labelMsg setString:NSLocalizedString(@"HelpStats03", nil)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 63)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 56)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (63 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (56 * 2.133f))];
        }
        
        [spriteHelp2 setScaleY:0.9f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 10) {
        [labelMsg setString:NSLocalizedString(@"HelpStats04", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 27)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 21)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (27 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (21 * 2.133f))];
        }
                
        helpTurn += -1;
    }
    else if (helpTurn == 9) {
        [labelMsg setString:NSLocalizedString(@"HelpStats05", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 4)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 3)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (4 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (3 * 2.133f))];
        }
        
        helpTurn += -1;
    }
    else if (helpTurn == 8) {
        [labelMsg setString:NSLocalizedString(@"HelpStats06", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 21)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 28)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (21 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (28 * 2.133f))];
        }
        
        helpTurn += -1;
    }
    else if (helpTurn == 7) {
        [labelMsg setString:NSLocalizedString(@"HelpStats07", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 47)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 53)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (47 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (53 * 2.133f))];
        }
        
        helpTurn += -1;
    }
    else if (helpTurn == 6) {
        [labelMsg setString:NSLocalizedString(@"HelpStats08", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 62)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 68)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (62 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (68 * 2.133f))];
        }
        
        [spriteHelp2 setScaleY:0.7f];
                        
        helpTurn += -1;
    }
    else if (helpTurn == 5) {
        [labelMsg setString:NSLocalizedString(@"HelpStats09", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 107)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 96)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (107 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (96 * 2.133f))];
        }
        
        [spriteHelp1 setScaleX:-1.0f];
        [spriteHelp1 setScaleY:1.1f];
                
        spriteHelp1.visible = YES;
        spriteHelp2.visible = NO;
        
        helpTurn += -1;
    }
    else if (helpTurn == 4) {
        [labelMsg setString:NSLocalizedString(@"HelpStats10", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 55)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 65)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (55 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (65 * 2.133f))];
        }
        
        [spriteHelp1 setScaleY:0.9f];
                
        helpTurn += -1;
    }
    else if (helpTurn == 3) {
        [labelMsg setString:NSLocalizedString(@"HelpStats11", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 59)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 72)];
        }
        else {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (59 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (72 * 2.133f))];
        }
        
        spriteHelp1.visible = NO;
        spriteHelp3.visible = YES;
        
        [spriteHelp3 setScaleX:-1.0f];
        [spriteHelp3 setScaleY:1.3f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 2) {
        [labelMsg setString:NSLocalizedString(@"HelpStats12", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 17)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 30)];
        }
        else {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (17 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (30 * 2.133f))];
        }
        
        helpTurn += -1;
    }
    else if (helpTurn == 1) {
        [labelMsg setString:NSLocalizedString(@"HelpStats13", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 44)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 31)];
        }
        else {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (44 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (31 * 2.133f))];
        }
        
        helpTurn += -1;
    }
    else {
        StatsLayer *statsLayer = (StatsLayer*)self.parent;
        [statsLayer resumeFromHelp];
        [self.parent removeChild:self cleanup:YES];
    }
}

@end
