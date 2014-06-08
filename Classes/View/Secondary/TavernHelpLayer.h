//
//  TavernHelpLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 24/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface TavernHelpLayer : CCLayerColor
{
    CGSize screenSize;
    CCSprite *spriteHelp1;
    CCSprite *spriteHelp2;
    
    CCLabelTTF *labelMsg;
    
    int helpTurn;
}

@end
