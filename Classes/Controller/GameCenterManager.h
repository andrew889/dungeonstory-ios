//
//  GameCenterManager.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 26/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "MultiplayerValues.h"

@protocol MultiplayerDelegate

-(void)setupArenaView;

@end

@interface GameCenterManager : NSObject <GKMatchmakerViewControllerDelegate, GKMatchDelegate>
{
    __weak id <MultiplayerDelegate> delegate;
    
    UIViewController *multiplayerViewController;
    
    NSMutableDictionary *earnedAchievementCache;
    
    uint64_t totalScore;
    uint64_t totalRuns;
    uint64_t totalQuests;
    uint64_t highestRounds;
    uint64_t monstersKilled;
    uint64_t arenaVictories;
    
    GKMatch *match;
    GKInvite *pendingInvite;
    NSArray *pendingPlayersToInvite;
    
    ArenaState arenaState;
    ArenaEndReason arenaEndReason;
    
    NSString *opponentName;
    uint32_t opponentLevel;
    uint32_t opponentMaxHP;
    uint32_t opponentClassVal;
    uint32_t opponentAttack;
    uint32_t opponentDefence;
    uint32_t opponentMagic;
    uint32_t opponentLuck;
    uint32_t opponentShield;
    uint32_t opponentDamage_reduction;
    
    uint32_t damage;
    uint32_t heal;
    int opponentShieldTurns;
    int opponentAleTurns;
    int opponentRuneTurns;
    int opponentMirrorTurns;
    int opponentShieldRank;
    int opponentMirrorRank;
    
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    BOOL shouldFightSimilarLevel;
    
    uint32_t randomNumber;
    BOOL hasMatchStarted;
    BOOL receivedOpponentStatus;
    BOOL hasOpponentSetup;
    BOOL isPlayer1;
    BOOL isPlayersTurn;
    BOOL opponentPickedUpCoins;
    BOOL opponentUsedShield;
    BOOL opponentUsedPotion;
    BOOL opponentUsedBomb;
    BOOL opponentUsedAle;
    BOOL opponentUsedRune;
    BOOL opponentUsedMirror;
    BOOL opponentUsedFlute;
}

@property (weak) id <MultiplayerDelegate> delegate;

@property (readwrite) uint64_t totalScore;
@property (readwrite) uint64_t totalRuns;
@property (readwrite) uint64_t totalQuests;
@property (readwrite) uint64_t highestRounds;
@property (readwrite) uint64_t monstersKilled;
@property (readwrite) uint64_t arenaVictories;

@property (readwrite, nonatomic, strong) GKMatch *match;
@property (readwrite, nonatomic, strong) GKInvite *pendingInvite;
@property (readwrite, nonatomic, strong) NSArray *pendingPlayersToInvite;

@property (readonly) ArenaState arenaState;
@property (readonly) ArenaEndReason arenaEndReason;

@property (readwrite, nonatomic, copy) NSString *opponentName;
@property (readonly) uint32_t opponentLevel;
@property (readonly) uint32_t opponentMaxHP;
@property (readonly) uint32_t opponentClassVal;
@property (readonly) uint32_t opponentAttack;
@property (readonly) uint32_t opponentDefence;
@property (readonly) uint32_t opponentMagic;
@property (readonly) uint32_t opponentLuck;
@property (readonly) uint32_t opponentShield;
@property (readonly) uint32_t opponentDamage_reduction;

@property (readwrite) uint32_t damage;
@property (readwrite) uint32_t heal;
@property (readwrite) int opponentShieldTurns;
@property (readwrite) int opponentAleTurns;
@property (readwrite) int opponentRuneTurns;
@property (readwrite) int opponentMirrorTurns;
@property (readwrite) int opponentShieldRank;
@property (readwrite) int opponentMirrorRank;

@property (readonly) BOOL gameCenterAvailable;
@property (readonly) BOOL userAuthenticated;
@property (readwrite) BOOL shouldFightSimilarLevel;

@property (readwrite) BOOL hasMatchStarted;
@property (readonly) BOOL isPlayer1;
@property (readwrite) BOOL isPlayersTurn;
@property (readwrite) BOOL opponentPickedUpCoins;
@property (readwrite) BOOL opponentUsedShield;
@property (readwrite) BOOL opponentUsedPotion;
@property (readwrite) BOOL opponentUsedBomb;
@property (readwrite) BOOL opponentUsedAle;
@property (readwrite) BOOL opponentUsedRune;
@property (readwrite) BOOL opponentUsedMirror;
@property (readwrite) BOOL opponentUsedFlute;

+(GameCenterManager*)sharedGameCenterManager;

-(void)authenticateUser;

-(void)updateTotalScore:(int)value;
-(void)updateHighestLevel;
-(void)updateTotalRuns;
-(void)updateTotalQuests;
-(void)updateDungeonTurnsDungeon01:(int)value;
-(void)updateDungeonTurnsDungeon02:(int)value;
-(void)updateDungeonTurnsDungeon03:(int)value;
-(void)updateDungeonTurnsDungeon04:(int)value;
-(void)updateDungeonTurnsDungeon05:(int)value;
-(void)updateDungeonTurnsDungeon06:(int)value;
-(void)updateMonstersKilled;
-(void)updateArenaVictories;

-(GKLeaderboard*)retrieveLeaderboard;

-(void)checkAchievementsHeroName;
-(void)checkAchievementsHeroShield;
-(void)checkAchievementsPotion;
-(void)checkAchievementsBomb;
-(void)checkAchievementsDungeonProgress;
-(void)checkAchievementsLevelUp;
-(void)checkAchievementsClassUnlocks;
-(void)checkAchievementsClassRanks;
-(void)checkAchievementsMaster;
-(void)checkAchievementsItems;
-(void)checkAchievementsSkills;
-(void)checkAchievementsMonsterKillsInRow;
-(void)checkAchievementsMonsterKills;
-(void)checkAchievementsSpecialMonsterKill;
-(void)checkAchievementsBossMonsterKill;
-(void)checkAchievementsArena;
-(void)checkAchievementsFirstRun;
-(void)checkAchievementsSurviveWithShield;
-(void)checkAchievementsShieldThirdRank;
-(void)checkAchievementsLowHealthPotion;
-(void)checkAchievementsPotionThirdRank;
-(void)checkAchievementsKillWithABomb;
-(void)checkAchievementsBombThirdRank;
-(void)checkAchievementsFeelingRich;
-(void)checkAchievementsQuake;
-(void)checkAchievementsDragonSlayer;

-(void)resetAchievements;

-(void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController*)viewController delegate:(id<MultiplayerDelegate>)theDelegate;

-(void)getOpponentData;

-(void)sendDamage:(int)value;
-(void)sendHeal:(int)value;
-(void)sendPass;
-(void)sendShield:(int)value;
-(void)sendPotion:(int)value;
-(void)sendBomb:(int)value;
-(void)sendAle;
-(void)sendRune;
-(void)sendMirror:(int)value;
-(void)sendFlute;
-(void)sendGameExit;
-(void)sendGameOver;

@end
