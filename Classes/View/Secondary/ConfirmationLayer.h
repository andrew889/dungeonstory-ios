//
//  ConfirmationLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 23/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface ConfirmationLayer : CCLayerColor
{
    CGSize screenSize;
    
    CCLabelTTF *labelMsg;
        
    CCMenu *menuChoice;
    
    CCMenuItem *itemConfirm;
    CCMenuItem *itemCancel;
}

@end
