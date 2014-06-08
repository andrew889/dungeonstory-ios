//
//  StoreLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 23/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface StoreLayer : CCLayer
{
    CGSize screenSize;
    
    CCLabelTTF *labelMsg;
        
    CCMenu *menuChoice1;
    CCMenu *menuChoice2;
    CCMenu *menuReturn;
    
    CCMenuItem *itemUnlock01;
    CCMenuItem *itemUnlock02;
    CCMenuItem *itemUnlock03;
    CCMenuItem *itemUnlock04;
    CCMenuItem *itemUnlock05;
    CCMenuItem *itemGold01;
    CCMenuItem *itemGold02;
    CCMenuItem *itemGold03;
    CCMenuItem *itemGold04;
    CCMenuItem *itemGold05;
    CCMenuItem *nextPage1;
    CCMenuItem *nextPage2;
    
    CCMenuItemImage *itemExit;
    
    NSArray *productArray;
    int purchaseChoice;
    NSNumberFormatter *priceFormatter;
}

+(CCScene*)scene;

@end
