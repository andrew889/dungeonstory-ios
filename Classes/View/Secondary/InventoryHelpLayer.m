//
//  InventoryHelpLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 24/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "InventoryHelpLayer.h"
#import "GameManager.h"
#import "InventoryLayer.h"
#import "Utility.h"

#pragma mark - InventoryHelpLayer

@implementation InventoryHelpLayer

-(id)initWithColor:(ccColor4B)color
{
	if((self=[super initWithColor:color])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        spriteHelp1 = [CCSprite spriteWithFile:@"MenuHelp1.png"];
        spriteHelp2 = [CCSprite spriteWithFile:@"MenuHelp3.png"];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"HelpInventory01", nil)
                                      fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];
        
        [labelMsg setColor:ccBLACK];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 92)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 77)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (92 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (77 * 2.133f))];
        }
        
        [self addChild:spriteHelp1 z:0 tag:0];
        [self addChild:spriteHelp2 z:0 tag:1];
        [self addChild:labelMsg z:1 tag:2];
        
        self.isTouchEnabled = YES;
        
        spriteHelp2.visible = NO;
        
        helpTurn = 7;
        
        [spriteHelp1 setScaleY:1.4f];
	}
    
	return self;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    if (helpTurn == 7) {
        [labelMsg setString:NSLocalizedString(@"HelpInventory02", nil)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 55)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 43)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (56 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (43 * 2.133f))];
        }
        
        [spriteHelp1 setScaleY:1.2f];
        [spriteHelp1 setScaleX:-1.0f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 6) {
        [labelMsg setString:NSLocalizedString(@"HelpInventory03", nil)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 29)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 17)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (29 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (17 * 2.133f))];
        }
        
        helpTurn += -1;
    }
    else if (helpTurn == 5) {
        [labelMsg setString:NSLocalizedString(@"HelpInventory04", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 2)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 8)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (2 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (8 * 2.133f))];
        }
        
        [spriteHelp1 setScaleY:1.0f];
                
        helpTurn += -1;
    }
    else if (helpTurn == 4) {
        [labelMsg setString:NSLocalizedString(@"HelpInventory05", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 25)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 36)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (25 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (36 * 2.133f))];
        }
        
        [spriteHelp1 setScaleY:1.2f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 3) {
        [labelMsg setString:NSLocalizedString(@"HelpInventory06", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 52)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 62)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (52 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (62 * 2.133f))];
        }
        
        [spriteHelp1 setScaleY:1.0f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 2) {
        [labelMsg setString:NSLocalizedString(@"HelpInventory07", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 27)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 39)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (27 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (39 * 2.133f))];
        }
        
        spriteHelp1.visible = NO;
        spriteHelp2.visible = YES;
        
        helpTurn += -1;
    }
    else if (helpTurn == 1) {
        [labelMsg setString:NSLocalizedString(@"HelpInventory08", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 68)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 56)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (68 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (56 * 2.133f))];
        }
        
        [spriteHelp1 setScaleY:0.9f];
                
        helpTurn += -1;
    }
    else {
        InventoryLayer *inventoryLayer = (InventoryLayer*)self.parent;
        [inventoryLayer resumeFromHelp];
        [self.parent removeChild:self cleanup:YES];
    }
}

@end
