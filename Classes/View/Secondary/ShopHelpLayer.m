//
//  ShopHelpLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 24/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "ShopHelpLayer.h"
#import "GameManager.h"
#import "ShopLayer.h"
#import "Utility.h"

#pragma mark - ShopHelpLayer

@implementation ShopHelpLayer

-(id)initWithColor:(ccColor4B)color
{
	if((self=[super initWithColor:color])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        spriteHelp1 = [CCSprite spriteWithFile:@"MenuHelp1.png"];
        spriteHelp2 = [CCSprite spriteWithFile:@"MenuHelp3.png"];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"HelpShop01", nil)
                                      fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];

        [labelMsg setColor:ccBLACK];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 85)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 70)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (85 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (70 * 2.133f))];
        }
        
        [self addChild:spriteHelp1 z:0 tag:0];
        [self addChild:spriteHelp2 z:0 tag:1];
        [self addChild:labelMsg z:1 tag:2];
        
        self.isTouchEnabled = YES;
        
        spriteHelp2.visible = NO;
                
        [spriteHelp1 setScaleY:1.4f];
        
        helpTurn = 2;
	}
    
	return self;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    if (helpTurn == 2) {
        [labelMsg setString:NSLocalizedString(@"HelpShop02", nil)];
        
        [spriteHelp1 setScaleX:-1.0f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 1) {
        [labelMsg setString:NSLocalizedString(@"HelpShop03", nil)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 46)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 66)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (46 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (66 * 2.133f))];
        }
        
        [spriteHelp1 setScaleX:1.0f];
        [spriteHelp1 setScaleY:1.9f];
        
        helpTurn += -1;
    }
    else {
        ShopLayer *shopLayer = (ShopLayer*)self.parent;
        [shopLayer resumeFromHelp];
        [self.parent removeChild:self cleanup:YES];
    }
}

@end
