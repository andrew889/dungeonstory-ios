//
//  GameCenterManager.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 26/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "GameCenterManager.h"
#import "AppDelegate.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "GameCenterValues.h"
#import "MultiplayLayer.h"

@implementation GameCenterManager

static GameCenterManager *_sharedGameCenterManager = nil;

@synthesize delegate;
@synthesize totalScore;
@synthesize totalRuns;
@synthesize totalQuests;
@synthesize highestRounds;
@synthesize monstersKilled;
@synthesize arenaVictories;
@synthesize match;
@synthesize pendingInvite;
@synthesize pendingPlayersToInvite;
@synthesize arenaState;
@synthesize arenaEndReason;
@synthesize opponentName;
@synthesize opponentLevel;
@synthesize opponentMaxHP;
@synthesize opponentClassVal;
@synthesize opponentAttack;
@synthesize opponentDefence;
@synthesize opponentMagic;
@synthesize opponentLuck;
@synthesize opponentShield;
@synthesize opponentDamage_reduction;
@synthesize damage;
@synthesize heal;
@synthesize opponentShieldTurns;
@synthesize opponentAleTurns;
@synthesize opponentRuneTurns;
@synthesize opponentMirrorTurns;
@synthesize opponentShieldRank;
@synthesize opponentMirrorRank;
@synthesize gameCenterAvailable;
@synthesize userAuthenticated;
@synthesize shouldFightSimilarLevel;
@synthesize hasMatchStarted;
@synthesize isPlayer1;
@synthesize isPlayersTurn;
@synthesize opponentPickedUpCoins;
@synthesize opponentUsedShield;
@synthesize opponentUsedPotion;
@synthesize opponentUsedBomb;
@synthesize opponentUsedAle;
@synthesize opponentUsedRune;
@synthesize opponentUsedMirror;
@synthesize opponentUsedFlute;

+(GameCenterManager*)sharedGameCenterManager
{
    static dispatch_once_t pred = 0;
    
    __strong static id _sharedGameCenterManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedGameCenterManager = [[self alloc] init];
    });
    
    return _sharedGameCenterManager;
}

+(id)alloc
{
    @synchronized ([GameCenterManager class])
    {
        NSAssert(_sharedGameCenterManager == nil,
                 @"Attempted to allocate a second instance of the Game Center Manager singleton");
        _sharedGameCenterManager = [super alloc];
        
        return _sharedGameCenterManager;
    }
    
    return nil;
}

-(id)init
{
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        userAuthenticated = NO;
        
        pendingInvite = nil;
        pendingPlayersToInvite = nil;
        
        if (gameCenterAvailable) {
            earnedAchievementCache = nil;
            
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            
            [nc addObserver:self
                   selector:@selector(authenticationChanged)
                       name:GKPlayerAuthenticationDidChangeNotificationName
                     object:nil];
        }
    }
    
    return self;
}

#pragma mark - game center authentication

// checks if game center is available
-(BOOL)isGameCenterAvailable
{
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

// if authentication has changed
-(void)authenticationChanged
{
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = YES;
        
        //[self resetAchievements];
        [self checkAchievementsHeroShield];
        [self checkAchievementsPotion];
        [self checkAchievementsBomb];
        [self checkAchievementsDungeonProgress];
        [self checkAchievementsLevelUp];
        [self checkAchievementsClassUnlocks];
        [self checkAchievementsClassRanks];
        [self checkAchievementsMaster];
        [self checkAchievementsItems];
        [self checkAchievementsSkills];
        [self checkAchievementsMonsterKillsInRow];
        [self checkAchievementsMonsterKills];
        [self checkAchievementsArena];
                
        [GKMatchmaker sharedMatchmaker].inviteHandler = ^(GKInvite *acceptedInvite, NSArray *playersToInvite) {
            NSLog(@"Received invite");
            
            pendingInvite = acceptedInvite;
            pendingPlayersToInvite = playersToInvite;
        };
    }
    else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = NO;
    }
}

// authenticates user
-(void)authenticateUser
{
    if (!gameCenterAvailable) return;
    
    NSLog(@"Authenticating local user...");
    
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    }
    else {
        NSLog(@"Already authenticated!");
    }
}

#pragma mark - leaderboard

// updates total score
-(void)updateTotalScore:(int)value
{
    totalScore += value;

    if (!gameCenterAvailable) return;
        
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardHighestScore];
    
    scoreReporter.value = totalScore;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the total score leaderboard!");
    }];
}

// updates highest level
-(void)updateHighestLevel
{
    if (!gameCenterAvailable) return;
    
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardHighestLevel];
    
    scoreReporter.value = [[Player sharedPlayer] level];
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the highest level leaderboard!");
    }];
}

// updates total runs
-(void)updateTotalRuns
{
    totalRuns++;
    
    if (!gameCenterAvailable) return;
        
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardTotalRuns];
    
    scoreReporter.value = totalRuns;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the highest runs leaderboard!");
    }];
}

// updates total quests
-(void)updateTotalQuests
{
    totalQuests++;

    if (!gameCenterAvailable) return;
        
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardTotalQuests];
    
    scoreReporter.value = totalQuests;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the highest quests leaderboard!");
    }];
}

// updates battle rounds survived in dungeon 01
-(void)updateDungeonTurnsDungeon01:(int)value
{
    if (!gameCenterAvailable) return;
    
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardDungeonTurns01];
    
    scoreReporter.value = value;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the dungeon turns 01 leaderboard!");
    }];
}

// updates battle rounds survived in dungeon 02
-(void)updateDungeonTurnsDungeon02:(int)value
{
    if (!gameCenterAvailable) return;
    
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardDungeonTurns02];
    
    scoreReporter.value = value;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the dungeon turns 02 leaderboard!");
    }];
}

// updates battle rounds survived in dungeon 03
-(void)updateDungeonTurnsDungeon03:(int)value
{
    if (!gameCenterAvailable) return;
    
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardDungeonTurns03];
    
    scoreReporter.value = value;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the dungeon turns 03 leaderboard!");
    }];
}

// updates battle rounds survived in dungeon 04
-(void)updateDungeonTurnsDungeon04:(int)value
{
    if (!gameCenterAvailable) return;
    
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardDungeonTurns04];
    
    scoreReporter.value = value;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the dungeon turns 04 leaderboard!");
    }];
}

// updates battle rounds survived in dungeon 05
-(void)updateDungeonTurnsDungeon05:(int)value
{
    if (!gameCenterAvailable) return;
    
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardDungeonTurns05];
    
    scoreReporter.value = value;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the dungeon turns 05 leaderboard!");
    }];
}

// updates battle rounds survived in dungeon 06
-(void)updateDungeonTurnsDungeon06:(int)value
{
    if (!gameCenterAvailable) return;
    
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardDungeonTurns06];
    
    scoreReporter.value = value;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the dungeon turns 06 leaderboard!");
    }];
}

// updates monsters killed
-(void)updateMonstersKilled
{
    monstersKilled++;

    if (!gameCenterAvailable) return;
        
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardMonstersKilled];
    
    scoreReporter.value = monstersKilled;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the monsters killed leaderboard!");
    }];
}

// updates arena victories
-(void)updateArenaVictories
{
    arenaVictories++;

    if (!gameCenterAvailable) return;
        
    GKScore *scoreReporter = [[GKScore alloc] initWithCategory:kLeaderboardArenaVictories];
    
    scoreReporter.value = arenaVictories;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error)  NSLog(@"Error: could not submit to the arena victories leaderboard!");
    }];
}

// retrieves leaderboard based on friend list
-(GKLeaderboard*)retrieveLeaderboard
{
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
    
    if (leaderboardRequest != nil) {
        leaderboardRequest.playerScope = GKLeaderboardPlayerScopeFriendsOnly;
        leaderboardRequest.timeScope = GKLeaderboardTimeScopeWeek;
        leaderboardRequest.category = kLeaderboardMonstersKilled;
        leaderboardRequest.range = NSMakeRange(1,6);
    }
    
    return leaderboardRequest;
}

#pragma mark - achievements

// report an achievement to the game center
-(void)reportAchievementIdentifier:(NSString*)identifier
                   percentComplete:(float)percent
{
    if(earnedAchievementCache == NULL) {
        [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
            NSMutableDictionary *tempCache = [NSMutableDictionary dictionaryWithCapacity:[achievements count]];
            
            for (GKAchievement *achievement in achievements) [tempCache setObject:achievement
                                                                           forKey:achievement.identifier];
            
            earnedAchievementCache = tempCache;
            
            [self reportAchievementIdentifier:identifier percentComplete:percent];
            
            if(error) NSLog(@"Error in loading the achievements list!");
        }];
    }
    else {
        GKAchievement *achievement = [earnedAchievementCache objectForKey:identifier];
        
        if (achievement) {
            if (achievement.percentComplete >= 100.0 ||
                achievement.percentComplete >= percent) {
                
                achievement = NULL;
            }
            
            achievement.percentComplete = percent;
        }
        else {
            achievement = [[GKAchievement alloc] initWithIdentifier:identifier];
            
            achievement.percentComplete = percent;
            
            [earnedAchievementCache setObject:achievement forKey:achievement.identifier];
        }
        
        if (achievement) {
            if (achievement.percentComplete == 100) achievement.showsCompletionBanner = YES;
            
            [achievement reportAchievementWithCompletionHandler:^(NSError *error) {
                if (error) NSLog(@"Error: could not submit the achievement!");
            }];
        }
    }
}

// resets achievements
-(void)resetAchievements
{
    earnedAchievementCache = [[NSMutableDictionary alloc] init];
    
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error) {
         if (error != nil) NSLog(@"Error!");
     }];
}

// checks hero name achievement
-(void)checkAchievementsHeroName
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementHeroName percentComplete:100.0];
}

// checks hero shield achievement
-(void)checkAchievementsHeroShield
{
    if (!gameCenterAvailable) return;
    
    if ([[Player sharedPlayer] shield] == 2) {
        [self reportAchievementIdentifier:kAchievementHeroShield percentComplete:100.0];
    }
}

// checks potion achievement
-(void)checkAchievementsPotion
{
    if (!gameCenterAvailable) return;
    
    if ([[Player sharedPlayer] potion] == 1) {
        [self reportAchievementIdentifier:kAchievementPotion percentComplete:100.0];
    }
}

// checks bomb achievement
-(void)checkAchievementsBomb
{
    if (!gameCenterAvailable) return;
    
    if ([[Player sharedPlayer] bomb] == 1) {
        [self reportAchievementIdentifier:kAchievementBomb percentComplete:100.0];
    }
}

// checks dungeon progress achievements
-(void)checkAchievementsDungeonProgress
{
    if (!gameCenterAvailable) return;
    
    if ([[Player sharedPlayer] emblems] == 4) {
        [self reportAchievementIdentifier:kAchievementDungeon04 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] emblems] >= 3) {
        [self reportAchievementIdentifier:kAchievementDungeon03 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] emblems] >= 2) {
        [self reportAchievementIdentifier:kAchievementDungeon02 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] emblems] >= 1) {
        [self reportAchievementIdentifier:kAchievementDungeon01 percentComplete:100.0];
    }
}

// checks level up achievements
-(void)checkAchievementsLevelUp
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementLevelUp09
                      percentComplete:((float)[[Player sharedPlayer] level] / 999.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementLevelUp08
                      percentComplete:((float)[[Player sharedPlayer] level] / 750.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementLevelUp07
                      percentComplete:((float)[[Player sharedPlayer] level] / 500.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementLevelUp06
                      percentComplete:((float)[[Player sharedPlayer] level] / 250.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementLevelUp05
                      percentComplete:((float)[[Player sharedPlayer] level] / 100.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementLevelUp04
                      percentComplete:((float)[[Player sharedPlayer] level] / 50.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementLevelUp03
                      percentComplete:((float)[[Player sharedPlayer] level] / 20.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementLevelUp03
                      percentComplete:((float)[[Player sharedPlayer] level] / 20.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementLevelUp02
                      percentComplete:((float)[[Player sharedPlayer] level] / 10.0) * 100.0];
    
    if ([[Player sharedPlayer] level] > 1) {
        [self reportAchievementIdentifier:kAchievementLevelUp01 percentComplete:100.0];
    }
}

// checks class unlock achievements
-(void)checkAchievementsClassUnlocks
{
    if (!gameCenterAvailable) return;
    
    if ([[Player sharedPlayer] classRank7] > 0 &&
        [[Player sharedPlayer] classRank8] > 0 &&
        [[Player sharedPlayer] classRank9] > 0) {
        
        [self reportAchievementIdentifier:kAchievementClassesTier03 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] classRank4] > 0 &&
        [[Player sharedPlayer] classRank5] > 0 &&
        [[Player sharedPlayer] classRank6] > 0) {
        
        [self reportAchievementIdentifier:kAchievementClassesTier02 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] classRank2] > 0 &&
        [[Player sharedPlayer] classRank3] > 0) {
        
        [self reportAchievementIdentifier:kAchievementClassesTier01 percentComplete:100.0];
    }
}

// checks class rank achievements
-(void)checkAchievementsClassRanks
{
    if (!gameCenterAvailable) return;
    
    if ([[Player sharedPlayer] classRank1] == 1000 &&
        [[Player sharedPlayer] classRank2] == 1000 &&
        [[Player sharedPlayer] classRank3] == 1000 &&
        [[Player sharedPlayer] classRank4] == 1000 &&
        [[Player sharedPlayer] classRank5] == 1000 &&
        [[Player sharedPlayer] classRank6] == 1000 &&
        [[Player sharedPlayer] classRank7] == 1000 &&
        [[Player sharedPlayer] classRank8] == 1000 &&
        [[Player sharedPlayer] classRank9] == 1000) {
        
        [self reportAchievementIdentifier:kAchievementClassesMaster percentComplete:100.0];
    }
    
    [self reportAchievementIdentifier:kAchievementClassesMaster01
                      percentComplete:((float)[[Player sharedPlayer] classRank1] / 1000.0) * 100.0];
    
    if ([[Player sharedPlayer] classRank2] > 0) {
        [self reportAchievementIdentifier:kAchievementClassesMaster02
                          percentComplete:((float)[[Player sharedPlayer] classRank2] / 1000.0) * 100.0];
    }
    
    if ([[Player sharedPlayer] classRank3] > 0) {
        [self reportAchievementIdentifier:kAchievementClassesMaster03
                          percentComplete:((float)[[Player sharedPlayer] classRank3] / 1000.0) * 100.0];
    }
    
    if ([[Player sharedPlayer] classRank4] > 0) {
        [self reportAchievementIdentifier:kAchievementClassesMaster04
                          percentComplete:((float)[[Player sharedPlayer] classRank4] / 1000.0) * 100.0];
    }
    
    if ([[Player sharedPlayer] classRank5] > 0) {
        [self reportAchievementIdentifier:kAchievementClassesMaster05
                          percentComplete:((float)[[Player sharedPlayer] classRank5] / 1000.0) * 100.0];
    }
    
    if ([[Player sharedPlayer] classRank6] > 0) {
        [self reportAchievementIdentifier:kAchievementClassesMaster06
                          percentComplete:((float)[[Player sharedPlayer] classRank6] / 1000.0) * 100.0];
    }
    
    if ([[Player sharedPlayer] classRank7] > 0) {
        [self reportAchievementIdentifier:kAchievementClassesMaster07
                          percentComplete:((float)[[Player sharedPlayer] classRank7] / 1000.0) * 100.0];
    }
    
    if ([[Player sharedPlayer] classRank8] > 0) {
        [self reportAchievementIdentifier:kAchievementClassesMaster08
                          percentComplete:((float)[[Player sharedPlayer] classRank8] / 1000.0) * 100.0];
    }
    
    if ([[Player sharedPlayer] classRank9] > 0) {
        [self reportAchievementIdentifier:kAchievementClassesMaster09
                          percentComplete:((float)[[Player sharedPlayer] classRank9] / 1000.0) * 100.0];
    }
}

// checks master achievement
-(void)checkAchievementsMaster
{
    if ([[Player sharedPlayer] weapon] == 10 &&
        [[Player sharedPlayer] spellbook] == 10 &&
        [[Player sharedPlayer] armor] == 10 &&
        [[Player sharedPlayer] ring] == 10 &&
        [[Player sharedPlayer] amulet] == 10 &&
        [[Player sharedPlayer] shield] == 2 &&
        [[Player sharedPlayer] potion] == 1 &&
        [[Player sharedPlayer] bomb] == 1 &&
        [[Player sharedPlayer] emblems] == 4 &&
        [[Player sharedPlayer] combatSkill1] == 10 &&
        [[Player sharedPlayer] combatSkill2] == 10 &&
        [[Player sharedPlayer] combatSkill3] == 10 &&
        [[Player sharedPlayer] survivalSkill1] == 10 &&
        [[Player sharedPlayer] survivalSkill2] == 10 &&
        [[Player sharedPlayer] survivalSkill3] == 10 &&
        [[Player sharedPlayer] practicalSkill1] == 10 &&
        [[Player sharedPlayer] practicalSkill2] == 10 &&
        [[Player sharedPlayer] practicalSkill3] == 10) {
        
        [self reportAchievementIdentifier:kAchievementMaster percentComplete:100.0];
    }
}

// checks item achievements
-(void)checkAchievementsItems
{
    if (!gameCenterAvailable) return;
        
    if ([[Player sharedPlayer] weapon] == 10 &&
        [[Player sharedPlayer] spellbook] == 10 &&
        [[Player sharedPlayer] armor] == 10 &&
        [[Player sharedPlayer] ring] == 10 &&
        [[Player sharedPlayer] amulet] == 10 &&
        [[Player sharedPlayer] shield] == 2 &&
        [[Player sharedPlayer] potion] == 1 &&
        [[Player sharedPlayer] bomb] == 1 &&
        [[Player sharedPlayer] emblems] == 4) {
        
        [self reportAchievementIdentifier:kAchievementItemMaster percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] weapon] == 10 &&
        [[Player sharedPlayer] spellbook] == 10 &&
        [[Player sharedPlayer] armor] == 10 &&
        [[Player sharedPlayer] ring] == 10 &&
        [[Player sharedPlayer] amulet] == 10) {
        
        [self reportAchievementIdentifier:kAchievementItemEquipment percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] weapon] == 10) {
        [self reportAchievementIdentifier:kAchievementItemWeapon percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] spellbook] == 10) {
        [self reportAchievementIdentifier:kAchievementItemSpellbook percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] armor] == 10) {
        [self reportAchievementIdentifier:kAchievementItemArmor percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] ring] == 10) {
        [self reportAchievementIdentifier:kAchievementItemRing percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] amulet] == 10) {
        [self reportAchievementIdentifier:kAchievementItemAmulet percentComplete:100.0];
    }
}

// checks skill achievements
-(void)checkAchievementsSkills
{
    if (!gameCenterAvailable) return;
        
    if ([[Player sharedPlayer] combatSkill1] == 10 &&
        [[Player sharedPlayer] combatSkill2] == 10 &&
        [[Player sharedPlayer] combatSkill3] == 10 &&
        [[Player sharedPlayer] survivalSkill1] == 10 &&
        [[Player sharedPlayer] survivalSkill2] == 10 &&
        [[Player sharedPlayer] survivalSkill3] == 10 &&
        [[Player sharedPlayer] practicalSkill1] == 10 &&
        [[Player sharedPlayer] practicalSkill2] == 10 &&
        [[Player sharedPlayer] practicalSkill3] == 10) {
        
        [self reportAchievementIdentifier:kAchievementSkillsMaster percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] combatSkill1] == 10 &&
        [[Player sharedPlayer] combatSkill2] == 10 &&
        [[Player sharedPlayer] combatSkill3] == 10) {
        
        [self reportAchievementIdentifier:kAchievementSkillsMaster01 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] survivalSkill1] == 10 &&
        [[Player sharedPlayer] survivalSkill2] == 10 &&
        [[Player sharedPlayer] survivalSkill3] == 10) {
        
        [self reportAchievementIdentifier:kAchievementSkillsMaster02 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] practicalSkill1] == 10 &&
        [[Player sharedPlayer] practicalSkill2] == 10 &&
        [[Player sharedPlayer] practicalSkill3] == 10) {
        
        [self reportAchievementIdentifier:kAchievementSkillsMaster03 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] combatSkill1] == 10) {
        [self reportAchievementIdentifier:kAchievementSkills01 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] combatSkill2] == 10) {
        [self reportAchievementIdentifier:kAchievementSkills02 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] combatSkill3] == 10) {
        [self reportAchievementIdentifier:kAchievementSkills03 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] survivalSkill1] == 10) {
        [self reportAchievementIdentifier:kAchievementSkills04 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] survivalSkill2] == 10) {
        [self reportAchievementIdentifier:kAchievementSkills05 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] survivalSkill3] == 10) {
        [self reportAchievementIdentifier:kAchievementSkills06 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] practicalSkill1] == 10) {
        [self reportAchievementIdentifier:kAchievementSkills07 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] practicalSkill2] == 10) {
        [self reportAchievementIdentifier:kAchievementSkills08 percentComplete:100.0];
    }
    
    if ([[Player sharedPlayer] practicalSkill3] == 10) {
        [self reportAchievementIdentifier:kAchievementSkills09 percentComplete:100.0];
    }
}


// checks amulet kills in row achievements
-(void)checkAchievementsMonsterKillsInRow
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementMonsters05
                      percentComplete:((float)highestRounds / 100.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementMonsters04
                      percentComplete:((float)highestRounds / 50.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementMonsters03
                      percentComplete:((float)highestRounds / 20.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementMonsters02
                      percentComplete:((float)highestRounds / 10.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementMonsters01
                      percentComplete:((float)highestRounds / 5.0) * 100.0];
}

// checks monster kills achievements
-(void)checkAchievementsMonsterKills
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementMonstersKills08
                      percentComplete:((float)monstersKilled / 10000.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementMonstersKills07
                      percentComplete:((float)monstersKilled / 6000.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementMonstersKills06
                      percentComplete:((float)monstersKilled / 1000.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementMonstersKills05
                      percentComplete:((float)monstersKilled / 600.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementMonstersKills04
                      percentComplete:((float)monstersKilled / 300.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementMonstersKills03
                      percentComplete:((float)monstersKilled / 60.0) * 100.0];

    [self reportAchievementIdentifier:kAchievementMonstersKills02
                      percentComplete:((float)monstersKilled / 30.0) * 100.0];

    [self reportAchievementIdentifier:kAchievementMonstersKills01
                      percentComplete:((float)monstersKilled / 15.0) * 100.0];
}

// checks monster special kill achievement
-(void)checkAchievementsSpecialMonsterKill
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementMonsters06 percentComplete:100.0];
}

// checks monster boss kill achievement
-(void)checkAchievementsBossMonsterKill
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementMonsters07 percentComplete:100.0];
}

// checks arena achievements
-(void)checkAchievementsArena
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementArena04
                      percentComplete:((float)arenaVictories / 100.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementArena03
                      percentComplete:((float)arenaVictories / 50.0) * 100.0];
    
    [self reportAchievementIdentifier:kAchievementArena02
                      percentComplete:((float)arenaVictories / 10.0) * 100.0];
    
    if (arenaVictories > 0) {
        [self reportAchievementIdentifier:kAchievementArena01 percentComplete:100.0];
    }
}

// checks first run achievement
-(void)checkAchievementsFirstRun
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementRun01 percentComplete:100.0];
}

// checks shield survive achievement
-(void)checkAchievementsSurviveWithShield
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementShield01 percentComplete:100.0];
}

// checks shield third rank achievement
-(void)checkAchievementsShieldThirdRank
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementShield02 percentComplete:100.0];
}

// checks drunk potion at low health achievement
-(void)checkAchievementsLowHealthPotion
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementPotion01 percentComplete:100.0];
}

// checks potion third rank achievement
-(void)checkAchievementsPotionThirdRank
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementPotion02 percentComplete:100.0];
}

// checks kill with a bomb achievement
-(void)checkAchievementsKillWithABomb
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementBomb01 percentComplete:100.0];
}

// checks bomb third rank achievement
-(void)checkAchievementsBombThirdRank
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementBomb02 percentComplete:100.0];
}

// checks feeling rich achievement
-(void)checkAchievementsFeelingRich
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementGold01 percentComplete:100.0];
}

// checks quake achievement
-(void)checkAchievementsQuake
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementQuake01 percentComplete:100.0];
}

// checks dragon slayer achievement
-(void)checkAchievementsDragonSlayer
{
    if (!gameCenterAvailable) return;
    
    [self reportAchievementIdentifier:kAchievementDragon01 percentComplete:100.0];
}

#pragma mark - multiplayer matchmaking

-(void)findMatchWithMinPlayers:(int)minPlayers
                    maxPlayers:(int)maxPlayers
                viewController:(UIViewController*)viewController
                      delegate:(id<MultiplayerDelegate>)theDelegate
{
    if (!gameCenterAvailable) return;
    
    hasMatchStarted = NO;
    match = nil;
    multiplayerViewController = viewController;
    delegate = theDelegate;
    
    if (pendingInvite) {
        [multiplayerViewController dismissModalViewControllerAnimated:NO];
        
        GKMatchmakerViewController *mmvc = [[GKMatchmakerViewController alloc] initWithInvite:pendingInvite];
        mmvc.matchmakerDelegate = self;
        
        [multiplayerViewController presentModalViewController:mmvc animated:YES];
        
        self.pendingInvite = nil;
        self.pendingPlayersToInvite = nil;
    }
    else {
        [multiplayerViewController dismissModalViewControllerAnimated:NO];
        
        GKMatchRequest *request = [[GKMatchRequest alloc] init];
        request.minPlayers = minPlayers;
        request.maxPlayers = maxPlayers;
        request.playersToInvite = pendingPlayersToInvite;
        
        GKMatchmakerViewController *mmvc = [[GKMatchmakerViewController alloc] initWithMatchRequest:request];
        mmvc.matchmakerDelegate = self;
        
        [multiplayerViewController presentModalViewController:mmvc animated:YES];
        
        self.pendingInvite = nil;
        self.pendingPlayersToInvite = nil;
    }
}

// user has cancelled matchmaking
-(void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController*)viewController
{
	[multiplayerViewController dismissModalViewControllerAnimated:YES];
}

// matchmaking has failed with an error
- (void)matchmakerViewController:(GKMatchmakerViewController*)viewController didFailWithError:(NSError*)error
{
	[multiplayerViewController dismissModalViewControllerAnimated:YES];
    
    NSLog(@"Error finding match: %@", error.localizedDescription);
}

// peer-to-peer match has been found, the game should start
- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)theMatch {
	[multiplayerViewController dismissModalViewControllerAnimated:YES];
    
    match = theMatch;
    match.delegate = self;
    
    if (!hasMatchStarted && match.expectedPlayerCount == 0) {
        NSLog(@"Ready to start match!");
        
        [self getOpponentData];
    }
}

#pragma mark - multiplayer match

// player state changed (eg. connected or disconnected)
-(void)match:(GKMatch*)theMatch player:(NSString*)playerID didChangeState:(GKPlayerConnectionState)state
{
    if (match != theMatch) return;
    
    switch (state) {
        case GKPlayerStateConnected:
            NSLog(@"Player connected!");
            
            if (!hasMatchStarted && theMatch.expectedPlayerCount == 0) {
                NSLog(@"Ready to start match!");
                [self getOpponentData];
            }
            
            break;
            
        case GKPlayerStateDisconnected:
            NSLog(@"Player disconnected!");
            hasMatchStarted = NO;
            
            [self matchEnded];
            
            break;
    }
}

// match was unable to connect with the player due to an error.
-(void)match:(GKMatch*)theMatch connectionWithPlayerFailed:(NSString*)playerID withError:(NSError*)error
{
    if (match != theMatch) return;
    
    NSLog(@"Failed to connect to player with error: %@", error.localizedDescription);
    
    hasMatchStarted = NO;
    
    [self matchEnded];
}

// match was unable to be established with any players due to an error.
-(void)match:(GKMatch*)theMatch didFailWithError:(NSError*)error
{
    if (match != theMatch) return;
    
    NSLog(@"Match failed with error: %@", error.localizedDescription);
    
    hasMatchStarted = NO;
    
    [self matchEnded];
}

// match started
-(void)matchStarted
{
    NSLog(@"Match started");
    
    arenaState = kArenaStateWaitingForRandomNumber;
    
    [self sendRandomNumber];
}

// match ended
-(void)matchEnded
{
    NSLog(@"Match ended");
    
    [match disconnect];
    
    match = nil;
    hasMatchStarted = NO;
    receivedOpponentStatus = NO;
    hasOpponentSetup = NO;
    isPlayer1 = NO;
    isPlayersTurn = NO;
    opponentPickedUpCoins = NO;
    opponentUsedShield = NO;
    opponentUsedPotion = NO;
    opponentUsedBomb = NO;
    
    if (arenaEndReason == kArenaEndReasonWin) {
        [[GameManager sharedGameManager] writeArenaVictory];
        [[GameManager sharedGameManager] runSceneWithID:kSceneVictory withTransition:YES];
    }
    else if (arenaEndReason == kArenaEndReasonLose) {
        [[GameManager sharedGameManager] runSceneWithID:kSceneVictory withTransition:YES];
    }
    else {
        [[GameManager sharedGameManager] setCurrentDungeon:kDungeonNone];
        [[SoundManager sharedSoundManager] playMainTheme];
        [[GameManager sharedGameManager] runSceneWithID:kSceneMultiplayer withTransition:YES];
    }
}

// match received data sent from the player.
-(void)match:(GKMatch*)theMatch didReceiveData:(NSData*)data fromPlayer:(NSString*)playerID
{
    Message *message = (Message*)[data bytes];
    
    if (message->messageType == kMessageTypeRandomNumber) {
        MessageRandomNumber *messageInit = (MessageRandomNumber*)[data bytes];
                
        
        if (randomNumber > messageInit->randomNumber) {
            NSLog(@"You are player 1");
            isPlayer1 = YES;
        }
        else if (randomNumber < messageInit->randomNumber) {
            NSLog(@"You are player 2");
            isPlayer1 = NO;
        }
        else {
            NSMutableArray *names = [[NSMutableArray alloc]
                                     initWithObjects:[GKLocalPlayer localPlayer].alias,
                                     opponentName, nil];
            
            [names sortUsingSelector:@selector(caseInsensitiveCompare:)];
            
            if ([[GKLocalPlayer localPlayer].alias isEqualToString:[names objectAtIndex:0]]) {
                NSLog(@"TIE: You are player 1");
                isPlayer1 = YES;
            }
            else {
                NSLog(@"TIE: You are player 2");
                isPlayer1 = NO;
            }
        }
                
        if (arenaState == kArenaStateWaitingForRandomNumber) {
            arenaState = kArenaStateWaitingForConfirmation;
        }
        
        [self sendConfirmation];
    }
    else if (message->messageType == kMessageTypeConfirmation) {
        MessageConfirmation *messageInit = (MessageConfirmation*)[data bytes];
        
        if (isPlayer1 == messageInit->isPlayer1) {
            if (arenaState == kArenaStateWaitingForConfirmation) {
                arenaState = kArenaStateWaitingForRandomNumber;
            }
            
            NSLog(@"Not confirmed Player");
            
            [self sendRandomNumber];
        }
        else {
            if (arenaState == kArenaStateWaitingForConfirmation) {
                arenaState = kArenaStateWaitingForOpponentStatus;
            }
            
            NSLog(@"Confirmed Player");
            
            [self sendPlayerStatus];
        }
    }
    else if (message->messageType == kMessageTypePlayerStatus) {
        MessagePlayerStatus *messageInit = (MessagePlayerStatus*)[data bytes];
        
        opponentLevel = messageInit->level;
        opponentMaxHP = messageInit->maxHP;
        opponentClassVal = messageInit->classVal;
        opponentAttack = messageInit->attack;
        opponentDefence = messageInit->defence;
        opponentMagic = messageInit->magic;
        opponentLuck = messageInit->luck;
        opponentShield = messageInit->shield;
        opponentDamage_reduction = messageInit->damage_reduction;
        receivedOpponentStatus = YES;
        
        if (arenaState == kArenaStateWaitingForOpponentStatus) {
            arenaState = kArenaStateWaitingForStart;
        }
        
        [self sendGameBegin];
    }
    else if (message->messageType == kMessageTypeGameBegin) {
        MessageGameBegin *messageInit = (MessageGameBegin*)[data bytes];
        NSLog(@"Received opponent status status: %d", messageInit->confirmation);
        
        if (receivedOpponentStatus && messageInit->confirmation == 1) {
            
            if (arenaState == kArenaStateWaitingForStart) {
                arenaState = kArenaStateActive;
            }
            
            [[SoundManager sharedSoundManager] fadeOutBackgroundMusic];
            [[GameManager sharedGameManager] setCurrentDungeon:kDungeonArena];
            [[GameManager sharedGameManager] runSceneWithID:kSceneArena withTransition:YES];
        }
        else {
            [self sendGameBegin];
        }
    }
    else if (message->messageType == kMessageTypeDamage) {
        if (!isPlayersTurn) {
            MessageDamage *messageInit = (MessageDamage*)[data bytes];
            
            damage = messageInit->damage;
            isPlayersTurn = YES;
            
            if (opponentShieldTurns > 0) opponentShieldTurns--;
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            if (opponentMirrorTurns > 0) opponentMirrorTurns--;
            
            NSLog(@"Received damage: %d", damage);
        }
    }
    else if (message->messageType == kMessageTypeHeal) {
        if (!isPlayersTurn) {
            MessageHeal *messageInit = (MessageHeal*)[data bytes];
            
            heal = messageInit->heal;
            isPlayersTurn = YES;
            
            if (opponentShieldTurns > 0) opponentShieldTurns--;
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            if (opponentMirrorTurns > 0) opponentMirrorTurns--;
            
            NSLog(@"Opponent healed: %d", heal);
        }
    }
    else if (message->messageType == kMessageTypeGold) {
        if (!isPlayersTurn) {
            isPlayersTurn = YES;
            opponentPickedUpCoins = YES;
            
            if (opponentShieldTurns > 0) opponentShieldTurns--;
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            if (opponentMirrorTurns > 0) opponentMirrorTurns--;
            
            NSLog(@"Opponent gathered some coins");
        }
    }
    else if (message->messageType == kMessageTypeShield) {
        if (!isPlayersTurn) {
            MessageShield *messageInit = (MessageShield*)[data bytes];

            opponentShieldTurns = 3;
            opponentShieldRank = messageInit->shieldRank;
            isPlayersTurn = YES;
            opponentUsedShield = YES;
            
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            if (opponentMirrorTurns > 0) opponentMirrorTurns--;
            
            NSLog(@"Opponent used shield");
        }
    }
    else if (message->messageType == kMessageTypePotion) {
        if (!isPlayersTurn) {
            MessagePotion *messageInit = (MessagePotion*)[data bytes];

            heal = messageInit->heal;
            isPlayersTurn = YES;
            opponentUsedPotion = YES;
            
            if (opponentShieldTurns > 0) opponentShieldTurns--;
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            if (opponentMirrorTurns > 0) opponentMirrorTurns--;
            
            NSLog(@"Opponent used potion");
        }
    }
    else if (message->messageType == kMessageTypeBomb) {
        if (!isPlayersTurn) {
            MessageBomb *messageInit = (MessageBomb*)[data bytes];
            
            damage = messageInit->damage;
            isPlayersTurn = YES;
            opponentUsedBomb = YES;
                        
            if (opponentShieldTurns > 0) opponentShieldTurns--;
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            if (opponentMirrorTurns > 0) opponentMirrorTurns--;
            
            NSLog(@"Opponent used bomb: %d", damage);
        }
    }
    else if (message->messageType == kMessageTypeAle) {
        if (!isPlayersTurn) {
            opponentAleTurns = 3;
            isPlayersTurn = YES;
            opponentUsedAle = YES;
            
            if (opponentShieldTurns > 0) opponentShieldTurns--;
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            if (opponentMirrorTurns > 0) opponentMirrorTurns--;
            
            NSLog(@"Opponent used ale");
        }
    }
    else if (message->messageType == kMessageTypeRune) {
        if (!isPlayersTurn) {
            opponentRuneTurns = 3;
            isPlayersTurn = YES;
            opponentUsedRune = YES;
            
            if (opponentShieldTurns > 0) opponentShieldTurns--;
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            if (opponentMirrorTurns > 0) opponentMirrorTurns--;
            
            NSLog(@"Opponent used rune");
        }
    }
    else if (message->messageType == kMessageTypeMirror) {
        if (!isPlayersTurn) {
            MessageMirror *messageInit = (MessageMirror*)[data bytes];
            
            opponentMirrorTurns = 3;
            opponentMirrorRank = messageInit->mirrorRank;
            isPlayersTurn = YES;
            opponentUsedMirror = YES;
            
            if (opponentShieldTurns > 0) opponentShieldTurns--;
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            
            NSLog(@"Opponent used mirror");
        }
    }
    else if (message->messageType == kMessageTypeFlute) {
        if (!isPlayersTurn) {
            isPlayersTurn = YES;
            opponentUsedFlute = YES;
            
            if (opponentShieldTurns > 0) opponentShieldTurns--;
            if (opponentAleTurns > 0) opponentAleTurns--;
            if (opponentRuneTurns > 0) opponentRuneTurns--;
            if (opponentMirrorTurns > 0) opponentMirrorTurns--;
                        
            NSLog(@"Opponent used flute");
        }
    }
    else if (message->messageType == kMessageTypeGameExit) {
        NSLog(@"Received game exit");
        arenaEndReason = kArenaEndReasonDisconnect;
        
        [self matchEnded];
    }
    else if (message->messageType == kMessageTypeGameOver) {        
        arenaEndReason = kArenaEndReasonWin;
        
        [self matchEnded];
    }
}

// send data to both players
-(void)sendData:(NSData*)data
{
    NSError *error;
    BOOL success = [match sendDataToAllPlayers:data withDataMode:GKMatchSendDataReliable error:&error];
    
    if (!success) {
        NSLog(@"Error sending init packet");
                
        [self matchEnded];
    }
}

// sends random number to choose which player starts first
-(void)sendRandomNumber
{
    MessageRandomNumber message;
    message.message.messageType = kMessageTypeRandomNumber;
    message.randomNumber = randomNumber;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageRandomNumber)];
    
    [self sendData:data];
}

// sends message which confirms the player
-(void)sendConfirmation
{
    MessageConfirmation message;
    message.message.messageType = kMessageTypeConfirmation;
    
    if (isPlayer1) message.isPlayer1 = 1;
    else message.isPlayer1 = 0;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageConfirmation)];
    
    [self sendData:data];
}

// sends message containing player status
-(void)sendPlayerStatus
{
    MessagePlayerStatus message;
    message.message.messageType = kMessageTypePlayerStatus;
    message.level = [[Player sharedPlayer] level];
    message.maxHP = [[Player sharedPlayer] maxHP];
    message.classVal = [[Player sharedPlayer] classVal];
    message.attack = [[Player sharedPlayer] getRankedAttack];
    message.defence = [[Player sharedPlayer] getRankedDefence];
    message.magic = [[Player sharedPlayer] getRankedMagic];
    message.luck = [[Player sharedPlayer] getRankedLuck];
    message.shield = [[Player sharedPlayer] shield];
    message.damage_reduction = [[Player sharedPlayer] damage_reduction];
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessagePlayerStatus)];
    
    [self sendData:data];
}

// sends message that game began
-(void)sendGameBegin
{
    MessageGameBegin message;
    message.message.messageType = kMessageTypeGameBegin;
    
    if (receivedOpponentStatus) message.confirmation = 1;
    else message.confirmation = 0;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameBegin)];
    
    [self sendData:data];
}

// sends message containing damage info
-(void)sendDamage:(int)value
{
    NSLog(@"Sending damage");
    
    isPlayersTurn = NO;
    
    MessageDamage message;
    message.message.messageType = kMessageTypeDamage;
    message.damage = value;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageDamage)];
    
    [self sendData:data];
}

// sends message containing healing info
-(void)sendHeal:(int)value
{
    NSLog(@"Sending heal");
    
    isPlayersTurn = NO;
    
    MessageHeal message;
    message.message.messageType = kMessageTypeHeal;
    message.heal = value;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageHeal)];
    
    [self sendData:data];
}

// sends message containing gold info
-(void)sendPass
{
    NSLog(@"Sending gold");
    
    isPlayersTurn = NO;
    
    MessageGold message;
    message.message.messageType = kMessageTypeGold;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGold)];
    
    [self sendData:data];
}

// sends message containing shield info
-(void)sendShield:(int)value
{
    NSLog(@"Sending shield");
    
    isPlayersTurn = NO;
    
    MessageShield message;
    message.message.messageType = kMessageTypeShield;
    message.shieldRank = value;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageShield)];
    
    [self sendData:data];
}

// sends message containing potion info
-(void)sendPotion:(int)value
{
    NSLog(@"Sending potion");
    
    isPlayersTurn = NO;
    
    MessagePotion message;
    message.message.messageType = kMessageTypePotion;
    message.heal = value;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessagePotion)];
    
    [self sendData:data];
}

// sends message containing bomb info
-(void)sendBomb:(int)value
{
    NSLog(@"Sending bomb");
    
    isPlayersTurn = NO;
    
    MessageBomb message;
    message.message.messageType = kMessageTypeBomb;
    message.damage = value;
        
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageBomb)];
    
    [self sendData:data];
}

// sends message containing ale info
-(void)sendAle
{
    NSLog(@"Sending ale");
    
    isPlayersTurn = NO;
    
    MessageAle message;
    message.message.messageType = kMessageTypeAle;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageAle)];
    
    [self sendData:data];
}

// sends message containing rune info
-(void)sendRune
{
    NSLog(@"Sending rune");
    
    isPlayersTurn = NO;
    
    MessageRune message;
    message.message.messageType = kMessageTypeRune;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageRune)];
    
    [self sendData:data];
}

// sends message containing mirror info
-(void)sendMirror:(int)value
{
    NSLog(@"Sending mirror");
    
    isPlayersTurn = NO;
    
    MessageMirror message;
    message.message.messageType = kMessageTypeMirror;
    message.mirrorRank = value;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageMirror)];
    
    [self sendData:data];
}

// sends message containing flute info
-(void)sendFlute
{
    NSLog(@"Sending flute");
    
    isPlayersTurn = NO;
    
    MessageFlute message;
    message.message.messageType = kMessageTypeFlute;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageFlute)];
    
    [self sendData:data];
}

// sends message containing game exit
-(void)sendGameExit
{
    NSLog(@"Sending game exit");
    
    MessageGameExit message;
    message.message.messageType = kMessageTypeGameExit;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameExit)];
    
    [self sendData:data];
}

// sends message containing game over
-(void)sendGameOver
{
    NSLog(@"Sending game over");
    
    MessageGameOver message;
    message.message.messageType = kMessageTypeGameOver;
    
    arenaEndReason = kArenaEndReasonLose;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameOver)];
    
    [self sendData:data];
}

// gets opponent's profile data
-(void)getOpponentData
{
    [GKPlayer loadPlayersForIdentifiers:match.playerIDs
                  withCompletionHandler:^(NSArray *players, NSError *error) {
                      
                      if (error != nil) {
                          NSLog(@"Error retrieving player info: %@", error.localizedDescription);
                          
                          hasMatchStarted = NO;
                          
                          [self matchEnded];
                      }
                      else {
                          opponentName = ((GKPlayer*)[players lastObject]).alias;
                          
                          NSLog(@"Found player: %@", opponentName);
                          
                          hasMatchStarted = YES;
                          
                          randomNumber = arc4random_uniform(100);
                          arenaState = kArenaStateWaitingForMatch;
                          arenaEndReason = kArenaEndReasonDisconnect;
                          
                          damage = 0;
                          heal = 0;
                          opponentShieldTurns = 0;
                          opponentAleTurns = 0;
                          opponentRuneTurns = 0;
                          opponentMirrorTurns = 0;
                          
                          [self matchStarted];
                      }
                  }];
}

@end
