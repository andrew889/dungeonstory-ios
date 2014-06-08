//
//  BattleDefeatLayer.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 13/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <GameKit/GameKit.h>
#import <Twitter/Twitter.h>
#import "cocos2d.h"

@interface BattleDefeatLayer : CCLayer
{
    CGSize screenSize;
    CCSprite *background;
    
    CCLabelTTF *labelTotalScore;
    CCLabelTTF *labelTotalScoreVal;
    CCLabelTTF *labelTotalRuns;
    CCLabelTTF *labelTotalRunsVal;
    CCLabelTTF *labelBattleRounds;
    CCLabelTTF *labelBattleRoundsVal;
    CCLabelTTF *labelExp;
    CCLabelTTF *labelExpVal;
    CCLabelTTF *labelGold;
    CCLabelTTF *labelGoldVal;
    CCMenu *tweetMenu;
    CCMenuItemImage *tweetButton;
    
    uint64_t battle_score;
    uint64_t battle_gold;
    uint64_t battle_rounds;
    int battle_exp;
        
    uint64_t scoreCounter;
    uint64_t gainedGoldCounter;
    uint64_t survivedRoundsCounter;
    int gainedExpCounter;
}

-(id)initWithExp:(int)exp
       withCoins:(uint64_t)coins
      withRounds:(uint64_t)battleRounds;

@end
