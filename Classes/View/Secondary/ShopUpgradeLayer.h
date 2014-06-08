//
//  ShopUpgradeLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 21/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface ShopUpgradeLayer : CCLayerGradient
{
    CGSize screenSize;
    
    CCLabelTTF *labelGold;
    CCLabelTTF *labelGoldVal;
    CCLabelTTF *labelShop;
    CCLabelTTF *labelMsg1;
    CCLabelTTF *labelMsg2;
    CCLabelTTF *labelMsg3;
    CCLabelTTF *labelCost;
    CCLabelTTF *labelCostVal;
    
    CCMenu *menuItem;
    CCMenu *menuCost;
    CCMenu *menuChoice;
    
    CCMenuItemLabel *itemMsg1;
    CCMenuItemLabel *itemMsg2;
    CCMenuItemLabel *itemCost;
    CCMenuItemLabel *itemCostVal;
    CCMenuItem *itemCancel;
    CCMenuItem *itemUpgrade;
    
    int choiceVal;
    int requiredGold;
    
    NSString *currentGold;
    NSString *itemName;
    NSString *msg1;
    NSString *msg3;
    NSString *costVal;
}

-(id)initWithChoice:(int)choice
           withItem:(NSString*)item;

-(id)initWithChoice:(int)choice;

@end
