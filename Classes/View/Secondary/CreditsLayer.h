//
//  CreditsLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 23/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface CreditsLayer : CCLayerGradient
{
    CGSize screenSize;
    
    CCLabelTTF *labelMsg1;
    CCLabelTTF *labelMsg2;
    CCLabelTTF *labelMsg3;
    CCLabelTTF *labelCreator;        
}

+(CCScene*)scene;

@end
