//
//  PauseMultiPlayerLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 10/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface PauseMultiPlayerLayer : CCLayerColor
{
    CGSize screenSize;
    
    CCLabelTTF *labelPlayerLevel;
    CCLabelTTF *labelEnemyLevel;
    CCLabelTTF *labelGold;
    CCLabelTTF *labelVictories;
    CCLabelTTF *labelPlayerLevelVal;
    CCLabelTTF *labelEnemyLevelVal;
    CCLabelTTF *labelGoldVal;
    CCLabelTTF *labelVictoriesVal;
        
    CCMenu *menuChoice;
    CCMenu *menuReturn;
    
    CCMenuItem *itemTurnSoundOff;
    CCMenuItem *itemTurnSoundOn;
    CCMenuItem *itemExitGame;
    
    CCMenuItemImage *itemResumeGame;
    
    CCMenuItemToggle *itemSoundToggle;
    
    uint64_t battle_gold;
}

-(id)initWithCoins:(uint64_t)coins;

@end
