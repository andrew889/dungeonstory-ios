//
//  SkillsHelpLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 24/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "SkillsHelpLayer.h"
#import "GameManager.h"
#import "TrainerLayer.h"
#import "Utility.h"

#pragma mark - SkillsHelpLayer

@implementation SkillsHelpLayer

-(id)initWithColor:(ccColor4B)color
{
	if((self=[super initWithColor:color])) {
		screenSize = [[CCDirector sharedDirector] winSize];
        
        spriteHelp1 = [CCSprite spriteWithFile:@"MenuHelp1.png"];
        spriteHelp2 = [CCSprite spriteWithFile:@"MenuHelp3.png"];
        
        labelMsg = [CCLabelTTF labelWithString:NSLocalizedString(@"HelpTrainer01", nil)
                                      fontName:@"Marker Felt" fontSize:[Utility getFontSize:20]];

        [labelMsg setColor:ccBLACK];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 65)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 50)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (65 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (50 * 2.133f))];
        }
        
        [self addChild:spriteHelp1 z:0 tag:0];
        [self addChild:spriteHelp2 z:0 tag:1];
        [self addChild:labelMsg z:1 tag:2];
        
        self.isTouchEnabled = YES;
        
        spriteHelp2.visible = NO;
                
        [spriteHelp1 setScaleY:1.4f];
        
        helpTurn = 3;
	}
    
	return self;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    if (helpTurn == 3) {
        [labelMsg setString:NSLocalizedString(@"HelpTrainer02", nil)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 126)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + 116)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (126 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 + (116 * 2.133f))];
        }
        
        [spriteHelp1 setScaleY:0.9f];
        
        helpTurn += -1;
    }
    else if (helpTurn == 2) {
        [labelMsg setString:NSLocalizedString(@"HelpTrainer03", nil)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 10)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 19)];
        }
        else {
            [spriteHelp1 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (10 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (19 * 2.133f))];
        }
        
        helpTurn += -1;
    }
    else if (helpTurn == 1) {
        [labelMsg setString:NSLocalizedString(@"HelpTrainer04", nil)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 33)];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - 22)];
        }
        else {
            [spriteHelp2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (33 * 2.133f))];
            [labelMsg setPosition:ccp(screenSize.width/2, screenSize.height/2 - (22 * 2.133f))];
        }
        
        spriteHelp1.visible = NO;
        spriteHelp2.visible = YES;
                
        helpTurn += -1;
    }
    else {
        TrainerLayer *trainerLayer = (TrainerLayer*)self.parent;
        [trainerLayer resumeFromHelp];
        [self.parent removeChild:self cleanup:YES];
    }
}

@end
