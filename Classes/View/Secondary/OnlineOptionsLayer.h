//
//  OnlineOptionsLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 14/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface OnlineOptionsLayer : CCLayerColor
{
    CGSize screenSize;
    
    CCLabelTTF *labelMsg;
        
    CCMenu *menuChoice;
    
    CCMenuItem *itemSimilarLevel;
    CCMenuItem *itemAnyLevel;
    CCMenuItem *itemConfirm;
    
    CCMenuItemToggle *itemOpponentsLevel;
}

@end
