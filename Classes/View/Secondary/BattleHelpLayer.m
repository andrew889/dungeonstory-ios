//
//  BattleHelpLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 25/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "BattleHelpLayer.h"
#import "GameManager.h"
#import "BattleLayer.h"
#import "Utility.h"

#pragma mark - BattleHelpLayer

@implementation BattleHelpLayer

-(id)initWithColor:(ccColor4B)color
{
	if((self=[super initWithColor:color])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        spriteHelp1 = [CCSprite spriteWithFile:@"MenuHelp1.png"];
        spriteHelp2 = [CCSprite spriteWithFile:@"MenuHelp2.png"];
        spriteHelp3 = [CCSprite spriteWithFile:@"MenuHelp4.png"];
        spriteHelp4 = [CCSprite spriteWithFile:@"MenuHelp5.png"];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"HelpBattle01", nil)
                                      fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        [labelMsg setColor:ccBLACK];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 125)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 115)];
        }
        else {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (125 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (115 * 2.133f))];
        }
        
        [self addChild:spriteHelp1 z:0 tag:0];
        [self addChild:spriteHelp2 z:0 tag:1];
        [self addChild:spriteHelp3 z:0 tag:2];
        [self addChild:spriteHelp4 z:0 tag:3];
        [self addChild:labelMsg z:1 tag:4];
        
        self.isTouchEnabled = YES;
                
        [spriteHelp3 setScaleY:-1.0f];
        
        spriteHelp1.visible = NO;
        spriteHelp2.visible = NO;
        spriteHelp4.visible = NO;
        
        helpTurn = 11;
	}
    
	return self;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    if (helpTurn == 11) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle02", nil)];
        
        [spriteHelp3 setScaleX:-1.0f];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 125)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 115)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (125 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (115 * 2.133f))];
        }
        
        helpTurn += -1;
    }
    else if (helpTurn == 10) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle03", nil)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 125)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 115)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (125 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (115 * 2.133f))];
        }
        
        helpTurn += -1;
    }
    else if (helpTurn == 9) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle04", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp4 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 126)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 112)];
        }
        else {
            [spriteHelp4 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (126 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (112 * 2.133f))];
        }
        
        [spriteHelp4 setScaleY:-1.2f];
        
        spriteHelp3.visible = NO;
        spriteHelp4.visible = YES;
        
        helpTurn += -1;
    }
    else if (helpTurn == 8) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle05", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp4 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 115)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 101)];
        }
        else {
            [spriteHelp4 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (115 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (101 * 2.133f))];
        }
        
        [spriteHelp4 setScaleY:-1.2f];
        
        spriteHelp3.visible = NO;
        spriteHelp4.visible = YES;
        
        helpTurn += -1;
    }
    else if (helpTurn == 7) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle06", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 60)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 70)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (60 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (70 * 2.133f))];
        }
        
        [spriteHelp2 setScaleY:-1.2f];
        
        spriteHelp4.visible = NO;
        spriteHelp2.visible = YES;
        
        helpTurn += -1;
    }
    else if (helpTurn == 6) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle07", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 49)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 59)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (49 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (59 * 2.133f))];
        }
        
        [spriteHelp2 setScaleY:-1.0f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 5) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle08", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 60)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 72)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (60 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (72 * 2.133f))];
        }
        
        [spriteHelp2 setScaleY:-1.2f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 4) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle09", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 70)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 83)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (70 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (83 * 2.133f))];
        }
        
        [spriteHelp2 setScaleY:-1.4f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 3) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle10", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 60)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 71)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (60 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (71 * 2.133f))];
        }
        
        [spriteHelp2 setScaleY:-1.2f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 2) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle11", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 49)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 60)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (49 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (60 * 2.133f))];
        }
        
        [spriteHelp2 setScaleY:-1.0f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 1) {
        [labelMsg setString:NSLocalizedString(@"HelpBattle12", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 106)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 89)];
        }
        else {
            [spriteHelp3 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (106 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (89 * 2.133f))];
        }
        
        [spriteHelp3 setScaleX:1.0f];
        [spriteHelp3 setScaleY:1.4f];
        
        spriteHelp2.visible = NO;
        spriteHelp3.visible = YES;
        
        helpTurn += -1;
    }
    else {
        BattleLayer *battleLayer = (BattleLayer*)self.parent;
        [battleLayer resumeGameWithHelp:NO];
        [self.parent removeChild:self cleanup:YES];
    }
}

@end
