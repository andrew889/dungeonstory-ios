//
//  CreditsLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 23/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "CreditsLayer.h"
#import "GameManager.h"
#import "Utility.h"

#pragma mark - CreditsLayer

@implementation CreditsLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	CreditsLayer *layer = [CreditsLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super initWithColor:ccc4(0, 0, 0, 255)
                         fadingTo:ccc4(10, 30, 30, 255)])) {
        
		screenSize = [[CCDirector sharedDirector] winSize];
        
        labelCreator = [CCLabelTTF labelWithString:NSLocalizedString(@"Credits01", nil)
                                          fontName:@"Shark Crash" fontSize:[Utility getFontSize:40]];
        labelMsg1 = [CCLabelTTF labelWithString:NSLocalizedString(@"Credits02", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:32]];
        labelMsg2 = [CCLabelTTF labelWithString:NSLocalizedString(@"Credits03", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:24]];
        labelMsg3 = [CCLabelTTF labelWithString:NSLocalizedString(@"Credits04", nil)
                                       fontName:@"Shark Crash" fontSize:[Utility getFontSize:24]];
        
        [labelMsg1 setColor:ccc3(0, 255, 127)];
        [labelCreator setColor:ccc3(255, 204, 102)];
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 234)];
                [labelCreator setPosition:ccp(screenSize.width/2, screenSize.height/2 + 159)];
                [labelMsg2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 10)];
                [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 215)];
            }
            else {
                [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + 190)];
                [labelCreator setPosition:ccp(screenSize.width/2, screenSize.height/2 + 125)];
                [labelMsg2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 10)];
                [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 - 175)];
            }
        }
        else {
            [labelMsg1 setPosition:ccp(screenSize.width/2, screenSize.height/2 + (190 * 2.133f))];
            [labelCreator setPosition:ccp(screenSize.width/2, screenSize.height/2 + (125 * 2.133f))];
            [labelMsg2 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (10 * 2.133f))];
            [labelMsg3 setPosition:ccp(screenSize.width/2, screenSize.height/2 - (175 * 2.133f))];
        }
        
        [self addChild:labelCreator z:1 tag:0];
        [self addChild:labelMsg1 z:1 tag:1];
        [self addChild:labelMsg2 z:1 tag:2];
        [self addChild:labelMsg3 z:1 tag:3];
        
        self.isTouchEnabled = YES;
	}
    
	return self;
}

#pragma mark - touch events

-(void)ccTouchesBegan:(NSSet*)touches
            withEvent:(UIEvent*)event
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneOptions withTransition:YES];
}

@end
