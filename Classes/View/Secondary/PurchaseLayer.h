//
//  PurchaseLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 23/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface PurchaseLayer : CCLayer
{
    CGSize screenSize;
    
    CCLabelTTF *labelMsg;
        
    CCMenu *menuChoice;
    CCMenu *menuReturn;
    
    CCMenuItem *itemTip1;
    CCMenuItem *itemTip2;
    CCMenuItem *itemTip3;
    CCMenuItem *itemTip4;
    CCMenuItem *itemTip5;
    
    CCMenuItemImage *itemExit;
    
    NSArray *productArray;
    int purchaseChoice;
    NSNumberFormatter *priceFormatter;
}

+(CCScene*)scene;

@end
