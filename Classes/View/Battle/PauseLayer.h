//
//  PauseLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 19/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface PauseLayer : CCLayerColor
{
    CGSize screenSize;
    
    CCLabelTTF *labelLevel;
    CCLabelTTF *labelExp;
    CCLabelTTF *labelGold;
    CCLabelTTF *labelBattleRound;
    CCLabelTTF *labelLevelVal;
    CCLabelTTF *labelExpVal;
    CCLabelTTF *labelGoldVal;
    CCLabelTTF *labelBattleRoundVal;
        
    CCMenu *menuChoice;
    CCMenu *menuReturn;
    
    CCMenuItem *itemTurnSoundOff;
    CCMenuItem *itemTurnSoundOn;
    CCMenuItem *itemHelp;
    CCMenuItem *itemExitGame;
    
    CCMenuItemImage *itemResumeGame;
    
    CCMenuItemToggle *itemSoundToggle;
    
    int battle_exp;
    uint64_t battle_gold;
    uint64_t battle_rounds;
}

-(id)initWithExp:(int)exp
       withCoins:(uint64_t)coins
       withRound:(uint64_t)battleRound;

@end
