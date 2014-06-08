//
//  GameManager.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "MenuLayer.h"
#import "PlayLayer.h"
#import "OptionsLayer.h"
#import "StatsLayer.h"
#import "InventoryLayer.h"
#import "StoryLayer.h"
#import "TavernLayer.h"
#import "ShopLayer.h"
#import "TrainerLayer.h"
#import "BattleLayer.h"
#import "BattleQuestLayer.h"
#import "VictoryLayer.h"
#import "CreditsLayer.h"
#import "DataStorageValues.h"
#import "MultiplayLayer.h"
#import "ArenaLayer.h"
#import "GameCenterManager.h"
#import "StoreLayer.h"
#import "PurchaseLayer.h"

@implementation GameManager

static GameManager *_sharedGameManager = nil;

@synthesize currentScene;
@synthesize currentDungeon;
@synthesize questType;
@synthesize itemSlot1;
@synthesize itemSlot2;
@synthesize itemSlot3;
@synthesize itemSlot4;
@synthesize itemSlot5;
@synthesize itemSlot6;
@synthesize itemSlot7;
@synthesize isHardModeOn;
@synthesize battleHelp;
@synthesize playHelp;
@synthesize statsHelp;
@synthesize inventoryHelp;
@synthesize tavernHelp;
@synthesize shopHelp;
@synthesize skillsHelp;
@synthesize isEarlyAdopter;
@synthesize isDoubleCoin;
@synthesize hasPurchasedHardMode;

+(GameManager*)sharedGameManager
{
    static dispatch_once_t pred = 0;
    
    __strong static id _sharedGameManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedGameManager = [[self alloc] init];
    });
    
    return _sharedGameManager;
}

+(id)alloc
{
    @synchronized ([GameManager class])
    {
        NSAssert(_sharedGameManager == nil,
                 @"Attempted to allocate a second instance of the Game Manager singleton");
        _sharedGameManager = [super alloc];
        
        return _sharedGameManager;
    }
    
    return nil;
}

-(id)init
{
    if ((self = [super init])) {
        currentScene = kSceneNone;
        currentDungeon = kDungeonNone;
        questType = kQuestType0;
        isHardModeOn = NO;
        isEarlyAdopter = NO;
        isDoubleCoin = NO;
        hasPurchasedHardMode = NO;
    }
    
    return self;
}

#pragma mark - data saving and loading

// saves the game save data
-(void)saveGameData
{
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setObject:[[Player sharedPlayer] name] forKey:kDataName];
    [gamesave setInteger:[[Player sharedPlayer] classVal] forKey:kDataClass];
    
    [gamesave setInteger:[[Player sharedPlayer] level] forKey:kDataLevel];
    [gamesave setInteger:[[Player sharedPlayer] requiredExperience] forKey:kDataExperience];
    
    [gamesave setInteger:[[Player sharedPlayer] maxHP] forKey:kDataHp];
    [gamesave setInteger:[[Player sharedPlayer] attack] forKey:kDataAttack];
    [gamesave setInteger:[[Player sharedPlayer] defence] forKey:kDataDefence];
    [gamesave setInteger:[[Player sharedPlayer] magic] forKey:kDataMagic];
    [gamesave setInteger:[[Player sharedPlayer] luck] forKey:kDataLuck];
    
    [gamesave setInteger:[[Player sharedPlayer] currentGold] forKey:kDataGold];
    [gamesave setInteger:[[Player sharedPlayer] weapon] forKey:kDataWeapon];
    [gamesave setInteger:[[Player sharedPlayer] spellbook] forKey:kDataSpellbook];
    [gamesave setInteger:[[Player sharedPlayer] armor] forKey:kDataArmor];
    [gamesave setInteger:[[Player sharedPlayer] ring] forKey:kDataRing];
    [gamesave setInteger:[[Player sharedPlayer] amulet] forKey:kDataAmulet];
    [gamesave setInteger:[[Player sharedPlayer] shield] forKey:kDataShield];
    [gamesave setInteger:[[Player sharedPlayer] potion] forKey:kDataPotion];
    [gamesave setInteger:[[Player sharedPlayer] bomb] forKey:kDataBomb];
    [gamesave setInteger:[[Player sharedPlayer] ale] forKey:kDataAle];
    [gamesave setInteger:[[Player sharedPlayer] rune] forKey:kDataRune];
    [gamesave setInteger:[[Player sharedPlayer] mirror] forKey:kDataMirror];
    [gamesave setInteger:[[Player sharedPlayer] flute] forKey:kDataFlute];
    
    [gamesave setInteger:[[Player sharedPlayer] classRank1] forKey:kDataClass01];
    [gamesave setInteger:[[Player sharedPlayer] classRank2] forKey:kDataClass02];
    [gamesave setInteger:[[Player sharedPlayer] classRank3] forKey:kDataClass03];
    [gamesave setInteger:[[Player sharedPlayer] classRank4] forKey:kDataClass04];
    [gamesave setInteger:[[Player sharedPlayer] classRank5] forKey:kDataClass05];
    [gamesave setInteger:[[Player sharedPlayer] classRank6] forKey:kDataClass06];
    [gamesave setInteger:[[Player sharedPlayer] classRank7] forKey:kDataClass07];
    [gamesave setInteger:[[Player sharedPlayer] classRank8] forKey:kDataClass08];
    [gamesave setInteger:[[Player sharedPlayer] classRank9] forKey:kDataClass09];
    
    [gamesave setInteger:[[Player sharedPlayer] ability1] forKey:kDataAbility01];
    [gamesave setInteger:[[Player sharedPlayer] ability2] forKey:kDataAbility02];
    [gamesave setInteger:[[Player sharedPlayer] ability3] forKey:kDataAbility03];
    [gamesave setInteger:[[Player sharedPlayer] ability4] forKey:kDataAbility04];
    [gamesave setInteger:[[Player sharedPlayer] ability5] forKey:kDataAbility05];
    [gamesave setInteger:[[Player sharedPlayer] ability6] forKey:kDataAbility06];
    [gamesave setInteger:[[Player sharedPlayer] ability7] forKey:kDataAbility07];
    [gamesave setInteger:[[Player sharedPlayer] ability8] forKey:kDataAbility08];
    [gamesave setInteger:[[Player sharedPlayer] ability9] forKey:kDataAbility09];
    
    [gamesave setInteger:[[Player sharedPlayer] combatSkill1] forKey:kDataSkill01];
    [gamesave setInteger:[[Player sharedPlayer] combatSkill2] forKey:kDataSkill02];
    [gamesave setInteger:[[Player sharedPlayer] combatSkill3] forKey:kDataSkill03];
    [gamesave setInteger:[[Player sharedPlayer] survivalSkill1] forKey:kDataSkill04];
    [gamesave setInteger:[[Player sharedPlayer] survivalSkill2] forKey:kDataSkill05];
    [gamesave setInteger:[[Player sharedPlayer] survivalSkill3] forKey:kDataSkill06];
    [gamesave setInteger:[[Player sharedPlayer] practicalSkill1] forKey:kDataSkill07];
    [gamesave setInteger:[[Player sharedPlayer] practicalSkill2] forKey:kDataSkill08];
    [gamesave setInteger:[[Player sharedPlayer] practicalSkill3] forKey:kDataSkill09];
    
    [gamesave setInteger:[[Player sharedPlayer] emblems] forKey:kDataEmblems];
    [gamesave setInteger:[[Player sharedPlayer] reputation] forKey:kDataReputation];
    
    [gamesave setInteger:itemSlot1 forKey:kDataItemSlot01];
    [gamesave setInteger:itemSlot2 forKey:kDataItemSlot02];
    [gamesave setInteger:itemSlot3 forKey:kDataItemSlot03];
    [gamesave setInteger:itemSlot4 forKey:kDataItemSlot04];
    [gamesave setInteger:itemSlot5 forKey:kDataItemSlot05];
    [gamesave setInteger:itemSlot6 forKey:kDataItemSlot06];
    [gamesave setInteger:itemSlot7 forKey:kDataItemSlot07];
    
    [gamesave setBool:battleHelp forKey:kDataBattleHelp];
    [gamesave setBool:playHelp forKey:kDataPlayHelp];
    [gamesave setBool:statsHelp forKey:kDataStatsHelp];
    [gamesave setBool:inventoryHelp forKey:kDataInventoryHelp];
    [gamesave setBool:tavernHelp forKey:kDataTavernHelp];
    [gamesave setBool:shopHelp forKey:kDataShopHelp];
    [gamesave setBool:skillsHelp forKey:kDataSkillsHelp];
    
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalRuns] forKey:kDataTotalRuns];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalQuests] forKey:kDataTotalQuests];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] highestRounds] forKey:kDataHighestRounds];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] monstersKilled] forKey:kDataMonstersKilled];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] arenaVictories] forKey:kDataArenaVictories];
    
    [gamesave setBool:[[SoundManager sharedSoundManager] isMusicON] forKey:kDataMusic];
    [gamesave setBool:[[SoundManager sharedSoundManager] isSoundON] forKey:kDataSound];
    
    [gamesave setBool:[[GameCenterManager sharedGameCenterManager] shouldFightSimilarLevel] forKey:kDataOnlineSimilarLevel];
        
    [gamesave setBool:isEarlyAdopter forKey:kDataEarlyAdopter];
    [gamesave setBool:isDoubleCoin forKey:kDataDoubleCoin];
    [gamesave setBool:hasPurchasedHardMode forKey:kDataPurchasedHardMode];
}

// loads the game save data
-(void)loadGameData
{
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];

    [[Player sharedPlayer] setName:[gamesave stringForKey:kDataName]];
    [[Player sharedPlayer] setClassVal:[gamesave integerForKey:kDataClass]];
    
    [[Player sharedPlayer] setLevel:[gamesave integerForKey:kDataLevel]];
    [[Player sharedPlayer] setRequiredExperience:[gamesave integerForKey:kDataExperience]];
    
    [[Player sharedPlayer] setMaxHP:[gamesave integerForKey:kDataHp]];
    [[Player sharedPlayer] setAttack:[gamesave integerForKey:kDataAttack]];
    [[Player sharedPlayer] setDefence:[gamesave integerForKey:kDataDefence]];
    [[Player sharedPlayer] setMagic:[gamesave integerForKey:kDataMagic]];
    [[Player sharedPlayer] setLuck:[gamesave integerForKey:kDataLuck]];
    
    [[Player sharedPlayer] setCurrentGold:[gamesave integerForKey:kDataGold]];
    [[Player sharedPlayer] setWeapon:[gamesave integerForKey:kDataWeapon]];
    [[Player sharedPlayer] setSpellbook:[gamesave integerForKey:kDataSpellbook]];
    [[Player sharedPlayer] setArmor:[gamesave integerForKey:kDataArmor]];
    [[Player sharedPlayer] setRing:[gamesave integerForKey:kDataRing]];
    [[Player sharedPlayer] setAmulet:[gamesave integerForKey:kDataAmulet]];
    [[Player sharedPlayer] setShield:[gamesave integerForKey:kDataShield]];
    [[Player sharedPlayer] setPotion:[gamesave integerForKey:kDataPotion]];
    [[Player sharedPlayer] setBomb:[gamesave integerForKey:kDataBomb]];
    [[Player sharedPlayer] setAle:[gamesave integerForKey:kDataAle]];
    [[Player sharedPlayer] setRune:[gamesave integerForKey:kDataRune]];
    [[Player sharedPlayer] setMirror:[gamesave integerForKey:kDataMirror]];
    [[Player sharedPlayer] setFlute:[gamesave integerForKey:kDataFlute]];
    
    [[Player sharedPlayer] setClassRank1:[gamesave integerForKey:kDataClass01]];
    [[Player sharedPlayer] setClassRank2:[gamesave integerForKey:kDataClass02]];
    [[Player sharedPlayer] setClassRank3:[gamesave integerForKey:kDataClass03]];
    [[Player sharedPlayer] setClassRank4:[gamesave integerForKey:kDataClass04]];
    [[Player sharedPlayer] setClassRank5:[gamesave integerForKey:kDataClass05]];
    [[Player sharedPlayer] setClassRank6:[gamesave integerForKey:kDataClass06]];
    [[Player sharedPlayer] setClassRank7:[gamesave integerForKey:kDataClass07]];
    [[Player sharedPlayer] setClassRank8:[gamesave integerForKey:kDataClass08]];
    [[Player sharedPlayer] setClassRank9:[gamesave integerForKey:kDataClass09]];
    
    [[Player sharedPlayer] setAbility1:[gamesave integerForKey:kDataAbility01]];
    [[Player sharedPlayer] setAbility2:[gamesave integerForKey:kDataAbility02]];
    [[Player sharedPlayer] setAbility3:[gamesave integerForKey:kDataAbility03]];
    [[Player sharedPlayer] setAbility4:[gamesave integerForKey:kDataAbility04]];
    [[Player sharedPlayer] setAbility5:[gamesave integerForKey:kDataAbility05]];
    [[Player sharedPlayer] setAbility6:[gamesave integerForKey:kDataAbility06]];
    [[Player sharedPlayer] setAbility7:[gamesave integerForKey:kDataAbility07]];
    [[Player sharedPlayer] setAbility8:[gamesave integerForKey:kDataAbility08]];
    [[Player sharedPlayer] setAbility9:[gamesave integerForKey:kDataAbility09]];
    
    [[Player sharedPlayer] setCombatSkill1:[gamesave integerForKey:kDataSkill01]];
    [[Player sharedPlayer] setCombatSkill2:[gamesave integerForKey:kDataSkill02]];
    [[Player sharedPlayer] setCombatSkill3:[gamesave integerForKey:kDataSkill03]];
    [[Player sharedPlayer] setSurvivalSkill1:[gamesave integerForKey:kDataSkill04]];
    [[Player sharedPlayer] setSurvivalSkill2:[gamesave integerForKey:kDataSkill05]];
    [[Player sharedPlayer] setSurvivalSkill3:[gamesave integerForKey:kDataSkill06]];
    [[Player sharedPlayer] setPracticalSkill1:[gamesave integerForKey:kDataSkill07]];
    [[Player sharedPlayer] setPracticalSkill2:[gamesave integerForKey:kDataSkill08]];
    [[Player sharedPlayer] setPracticalSkill3:[gamesave integerForKey:kDataSkill09]];
    
    [[Player sharedPlayer] setEmblems:[gamesave integerForKey:kDataEmblems]];
    [[Player sharedPlayer] setReputation:[gamesave integerForKey:kDataReputation]];
    
    itemSlot1 = [gamesave integerForKey:kDataItemSlot01];
    itemSlot2 = [gamesave integerForKey:kDataItemSlot02];
    itemSlot3 = [gamesave integerForKey:kDataItemSlot03];
    itemSlot4 = [gamesave integerForKey:kDataItemSlot04];
    itemSlot5 = [gamesave integerForKey:kDataItemSlot05];
    itemSlot6 = [gamesave integerForKey:kDataItemSlot06];
    itemSlot7 = [gamesave integerForKey:kDataItemSlot07];
    
    battleHelp = [gamesave boolForKey:kDataBattleHelp];
    playHelp = [gamesave boolForKey:kDataPlayHelp];
    statsHelp = [gamesave boolForKey:kDataStatsHelp];
    inventoryHelp = [gamesave boolForKey:kDataInventoryHelp];
    tavernHelp = [gamesave boolForKey:kDataTavernHelp];
    shopHelp = [gamesave boolForKey:kDataShopHelp];
    skillsHelp = [gamesave boolForKey:kDataSkillsHelp];
    
    [[GameCenterManager sharedGameCenterManager] setTotalScore:[gamesave integerForKey:kDataTotalScore]];
    [[GameCenterManager sharedGameCenterManager] setTotalRuns:[gamesave integerForKey:kDataTotalRuns]];
    [[GameCenterManager sharedGameCenterManager] setTotalQuests:[gamesave integerForKey:kDataTotalQuests]];
    [[GameCenterManager sharedGameCenterManager] setHighestRounds:[gamesave integerForKey:kDataHighestRounds]];
    [[GameCenterManager sharedGameCenterManager] setMonstersKilled:[gamesave integerForKey:kDataMonstersKilled]];
    [[GameCenterManager sharedGameCenterManager] setArenaVictories:[gamesave integerForKey:kDataArenaVictories]];
    
    [[SoundManager sharedSoundManager] setIsMusicON:[gamesave boolForKey:kDataMusic]];
    [[SoundManager sharedSoundManager] setIsSoundON:[gamesave boolForKey:kDataSound]];
    
    [[GameCenterManager sharedGameCenterManager] setShouldFightSimilarLevel:[gamesave boolForKey:kDataOnlineSimilarLevel]];
        
    isEarlyAdopter = [gamesave boolForKey:kDataEarlyAdopter];
    isDoubleCoin = [gamesave boolForKey:kDataDoubleCoin];
    hasPurchasedHardMode = [gamesave boolForKey:kDataPurchasedHardMode];
}

// delete game data
-(void)deleteGameData
{
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setObject:NULL forKey:kDataName];
    [gamesave setInteger:1 forKey:kDataClass];
    
    [gamesave setInteger:1 forKey:kDataLevel];
    [gamesave setInteger:10 forKey:kDataExperience];
    
    [gamesave setInteger:12 forKey:kDataHp];
    [gamesave setInteger:4 forKey:kDataAttack];
    [gamesave setInteger:2 forKey:kDataDefence];
    [gamesave setInteger:4 forKey:kDataMagic];
    [gamesave setInteger:2 forKey:kDataLuck];
    
    [gamesave setInteger:0 forKey:kDataGold];
    [gamesave setInteger:1 forKey:kDataWeapon];
    [gamesave setInteger:1 forKey:kDataSpellbook];
    [gamesave setInteger:0 forKey:kDataArmor];
    [gamesave setInteger:0 forKey:kDataRing];
    [gamesave setInteger:0 forKey:kDataAmulet];
    [gamesave setInteger:1 forKey:kDataShield];
    [gamesave setInteger:0 forKey:kDataPotion];
    [gamesave setInteger:0 forKey:kDataBomb];
    [gamesave setInteger:0 forKey:kDataAle];
    [gamesave setInteger:0 forKey:kDataRune];
    [gamesave setInteger:0 forKey:kDataMirror];
    [gamesave setInteger:0 forKey:kDataFlute];
    
    [gamesave setInteger:1 forKey:kDataClass01];
    [gamesave setInteger:0 forKey:kDataClass02];
    [gamesave setInteger:0 forKey:kDataClass03];
    [gamesave setInteger:0 forKey:kDataClass04];
    [gamesave setInteger:0 forKey:kDataClass05];
    [gamesave setInteger:0 forKey:kDataClass06];
    [gamesave setInteger:0 forKey:kDataClass07];
    [gamesave setInteger:0 forKey:kDataClass08];
    [gamesave setInteger:0 forKey:kDataClass09];
    
    [gamesave setInteger:1 forKey:kDataAbility01];
    [gamesave setInteger:1 forKey:kDataAbility02];
    [gamesave setInteger:1 forKey:kDataAbility03];
    [gamesave setInteger:1 forKey:kDataAbility04];
    [gamesave setInteger:1 forKey:kDataAbility05];
    [gamesave setInteger:1 forKey:kDataAbility06];
    [gamesave setInteger:1 forKey:kDataAbility07];
    [gamesave setInteger:1 forKey:kDataAbility08];
    [gamesave setInteger:1 forKey:kDataAbility09];
    
    [gamesave setInteger:0 forKey:kDataSkill01];
    [gamesave setInteger:0 forKey:kDataSkill02];
    [gamesave setInteger:0 forKey:kDataSkill03];
    [gamesave setInteger:0 forKey:kDataSkill04];
    [gamesave setInteger:0 forKey:kDataSkill05];
    [gamesave setInteger:0 forKey:kDataSkill06];
    [gamesave setInteger:0 forKey:kDataSkill07];
    [gamesave setInteger:0 forKey:kDataSkill08];
    [gamesave setInteger:0 forKey:kDataSkill09];
    
    [gamesave setInteger:0 forKey:kDataEmblems];
    [gamesave setInteger:0 forKey:kDataReputation];
    
    [gamesave setInteger:1 forKey:kDataItemSlot01];
    [gamesave setInteger:2 forKey:kDataItemSlot02];
    [gamesave setInteger:3 forKey:kDataItemSlot03];
    [gamesave setInteger:4 forKey:kDataItemSlot04];
    [gamesave setInteger:5 forKey:kDataItemSlot05];
    [gamesave setInteger:6 forKey:kDataItemSlot06];
    [gamesave setInteger:7 forKey:kDataItemSlot07];
    
    [gamesave setBool:YES forKey:kDataBattleHelp];
    [gamesave setBool:YES forKey:kDataPlayHelp];
    [gamesave setBool:YES forKey:kDataStatsHelp];
    [gamesave setBool:YES forKey:kDataInventoryHelp];
    [gamesave setBool:YES forKey:kDataTavernHelp];
    [gamesave setBool:YES forKey:kDataShopHelp];
    [gamesave setBool:YES forKey:kDataSkillsHelp];
    
    [gamesave setInteger:0 forKey:kDataTotalScore];
    [gamesave setInteger:0 forKey:kDataTotalRuns];
    [gamesave setInteger:0 forKey:kDataTotalQuests];
    [gamesave setInteger:0 forKey:kDataHighestRounds];
    [gamesave setInteger:0 forKey:kDataMonstersKilled];
    [gamesave setInteger:0 forKey:kDataArenaVictories];
    
    [gamesave setBool:YES forKey:kDataMusic];
    [gamesave setBool:YES forKey:kDataSound];

    [gamesave setBool:NO forKey:kDataOnlineSimilarLevel];
}

#pragma mark - game data actions

// reads game data
-(void)readGameData
{
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    if ([gamesave integerForKey:kDataLevel] == 0) {
        [self deleteGameData];
        [self loadGameData];
    }
    else {
        [self loadGameData];
    }
    
    [[Player sharedPlayer] updatePlayer];
}

// writes players data
-(void)writePlayerName:(NSString*)string
{
    [[Player sharedPlayer] setName:string];
    
    [[GameCenterManager sharedGameCenterManager] checkAchievementsHeroName];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setObject:string forKey:kDataName];
}

// writes players class
-(void)writePlayerClass:(int)value
{
    [[Player sharedPlayer] setClassVal:value];
    [[Player sharedPlayer] updatePlayer];

    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:value forKey:kDataClass];
}

// writes exp progress
-(void)writeExp:(int)exp
{
    [[Player sharedPlayer] rankUp];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateMonstersKilled];
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:exp];
    
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMonsterKillsInRow];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMonsterKills];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    if ([[Player sharedPlayer] level] < 999) {
        int requiredExp = [[Player sharedPlayer] requiredExperience] - (exp + (int)(exp * [[Player sharedPlayer] extra_exp_percentage] / 100));
        
        if (requiredExp <= 0) {
            [[Player sharedPlayer] levelUp:requiredExp * -1];
            
            [gamesave setInteger:[[Player sharedPlayer] level] forKey:kDataLevel];
            [gamesave setInteger:[[Player sharedPlayer] maxHP] forKey:kDataHp];
            [gamesave setInteger:[[Player sharedPlayer] attack] forKey:kDataAttack];
            [gamesave setInteger:[[Player sharedPlayer] defence] forKey:kDataDefence];
            [gamesave setInteger:[[Player sharedPlayer] magic] forKey:kDataMagic];
            [gamesave setInteger:[[Player sharedPlayer] luck] forKey:kDataLuck];
            
            [[GameCenterManager sharedGameCenterManager] checkAchievementsLevelUp];
            [[GameCenterManager sharedGameCenterManager] updateHighestLevel];
        }
        else {
            [[Player sharedPlayer] setRequiredExperience:requiredExp];
        }
        
        if ([[Player sharedPlayer] level] == 999) {
            [[Player sharedPlayer] setRequiredExperience:0];
        }
        
        [gamesave setInteger:[[Player sharedPlayer] requiredExperience] forKey:kDataExperience];
        
        if ([[Player sharedPlayer] level] == 100) {
            [[Player sharedPlayer] setClassRank7:1];
            [[Player sharedPlayer] setClassRank8:1];
            [[Player sharedPlayer] setClassRank9:1];
            
            [[GameCenterManager sharedGameCenterManager] checkAchievementsClassUnlocks];
        }
        else if ([[Player sharedPlayer] level] == 40) {
            [[Player sharedPlayer] setClassRank4:1];
            [[Player sharedPlayer] setClassRank5:1];
            [[Player sharedPlayer] setClassRank6:1];
            
            [[GameCenterManager sharedGameCenterManager] checkAchievementsClassUnlocks];
        }
        else if ([[Player sharedPlayer] level] == 12) {
            [[Player sharedPlayer] setClassRank2:1];
            [[Player sharedPlayer] setClassRank3:1];
            
            [[GameCenterManager sharedGameCenterManager] checkAchievementsClassUnlocks];
        }
    }
    
    [gamesave setInteger:[[Player sharedPlayer] classRank1] forKey:kDataClass01];
    [gamesave setInteger:[[Player sharedPlayer] classRank2] forKey:kDataClass02];
    [gamesave setInteger:[[Player sharedPlayer] classRank3] forKey:kDataClass03];
    [gamesave setInteger:[[Player sharedPlayer] classRank4] forKey:kDataClass04];
    [gamesave setInteger:[[Player sharedPlayer] classRank5] forKey:kDataClass05];
    [gamesave setInteger:[[Player sharedPlayer] classRank6] forKey:kDataClass06];
    [gamesave setInteger:[[Player sharedPlayer] classRank7] forKey:kDataClass07];
    [gamesave setInteger:[[Player sharedPlayer] classRank8] forKey:kDataClass08];
    [gamesave setInteger:[[Player sharedPlayer] classRank9] forKey:kDataClass09];
    
    [[GameCenterManager sharedGameCenterManager] checkAchievementsClassRanks];
    
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] monstersKilled] forKey:kDataMonstersKilled];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes total runs
-(void)writeTotalRuns
{
    [[GameCenterManager sharedGameCenterManager] updateTotalRuns];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalRuns] forKey:kDataTotalRuns];
}

// writes highest rounds
-(void)writeHighestRounds:(int)battleRounds
{
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:(battleRounds * 10)];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
        
    if ([[GameCenterManager sharedGameCenterManager] highestRounds] < battleRounds) {
        [[GameCenterManager sharedGameCenterManager] setHighestRounds:battleRounds];
        [gamesave setInteger:battleRounds forKey:kDataHighestRounds];
    }
    
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes quest progress
-(void)writeQuestProgress:(int)rep
{
    [[Player sharedPlayer] setReputation:[[Player sharedPlayer] reputation] + rep];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalQuests];
    
    if ([[Player sharedPlayer] reputation] > 100000) [[Player sharedPlayer] setReputation:100000];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] reputation] forKey:kDataReputation];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalQuests] forKey:kDataTotalQuests];
}

// writes arena victory
-(void)writeArenaVictory
{
    [[GameCenterManager sharedGameCenterManager] updateArenaVictories];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsArena];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] arenaVictories] forKey:kDataArenaVictories];
}

// writes gathered gold
-(void)writeGatheredGold:(int)gold
{
    int battle_gold = gold;
        
    [[Player sharedPlayer] setCurrentGold:[[Player sharedPlayer] currentGold] + battle_gold];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:battle_gold];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] currentGold] forKey:kDataGold];
    
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes emblems progress
-(void)writeEmblemProgress
{
    [[Player sharedPlayer] setEmblems:[[Player sharedPlayer] emblems] + 1];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:10000];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsDungeonProgress];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] emblems] forKey:kDataEmblems];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes weapon upgrade data
-(void)writeWeaponUpgradeData
{
    [[Player sharedPlayer] setWeapon:[[Player sharedPlayer] weapon] + 1];
    [[Player sharedPlayer] setAttack:[[Player sharedPlayer] attack] + 4 * [[Player sharedPlayer] weapon]];
    
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] attack] forKey:kDataAttack];
    [gamesave setInteger:[[Player sharedPlayer] weapon] forKey:kDataWeapon];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes spellbook upgrade data
-(void)writeSpellbookUpgradeData
{
    [[Player sharedPlayer] setSpellbook:[[Player sharedPlayer] spellbook] + 1];
    [[Player sharedPlayer] setMagic:[[Player sharedPlayer] magic] + 4 * [[Player sharedPlayer] spellbook]];
    
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] magic] forKey:kDataMagic];
    [gamesave setInteger:[[Player sharedPlayer] spellbook] forKey:kDataSpellbook];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes armor upgrade data
-(void)writeArmorUpgradeData
{
    [[Player sharedPlayer] setArmor:[[Player sharedPlayer] armor] + 1];
    [[Player sharedPlayer] setDefence:[[Player sharedPlayer] defence] + 4 * [[Player sharedPlayer] armor]];
    
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] defence] forKey:kDataDefence];
    [gamesave setInteger:[[Player sharedPlayer] armor] forKey:kDataArmor];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes ring upgrade data
-(void)writeRingUpgradeData
{
    [[Player sharedPlayer] setRing:[[Player sharedPlayer] ring] + 1];
    [[Player sharedPlayer] setLuck:[[Player sharedPlayer] luck] + 4 * [[Player sharedPlayer] ring]];
    
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] luck] forKey:kDataLuck];
    [gamesave setInteger:[[Player sharedPlayer] ring] forKey:kDataRing];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes amulet upgrade data
-(void)writeAmuletUpgradeData
{
    [[Player sharedPlayer] setAmulet:[[Player sharedPlayer] amulet] + 1];
    [[Player sharedPlayer] setMaxHP:[[Player sharedPlayer] maxHP] + 10 * [[Player sharedPlayer] amulet]];
    
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] maxHP] forKey:kDataHp];
    [gamesave setInteger:[[Player sharedPlayer] amulet] forKey:kDataAmulet];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes shield upgrade data
-(void)writeShieldUpgradeData
{
    [[Player sharedPlayer] setShield:2];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:20000];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsHeroShield];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] shield] forKey:kDataShield];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes potion upgrade data
-(void)writePotionUpgradeData
{
    [[Player sharedPlayer] setPotion:[[Player sharedPlayer] potion] + 1];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:1000];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsPotion];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] potion] forKey:kDataPotion];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes bomb upgrade data
-(void)writeBombUpgradeData
{
    [[Player sharedPlayer] setBomb:[[Player sharedPlayer] bomb] + 1];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:1000];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsBomb];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] bomb] forKey:kDataBomb];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes ale upgrade data
-(void)writeAleUpgradeData
{
    [[Player sharedPlayer] setAle:[[Player sharedPlayer] ale] + 1];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:1000];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ale] forKey:kDataAle];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes rune upgrade data
-(void)writeRuneUpgradeData
{
    [[Player sharedPlayer] setRune:[[Player sharedPlayer] rune] + 1];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:1000];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] rune] forKey:kDataRune];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes mirror upgrade data
-(void)writeMirrorUpgradeData
{
    [[Player sharedPlayer] setMirror:[[Player sharedPlayer] mirror] + 1];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:1000];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] mirror] forKey:kDataMirror];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes flute upgrade data
-(void)writeFluteUpgradeData
{
    [[Player sharedPlayer] setFlute:[[Player sharedPlayer] flute] + 1];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:1000];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsItems];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] flute] forKey:kDataFlute];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes ability 1 upgrade data
-(void)writeAbility1UpgradeData
{
    [[Player sharedPlayer] setAbility1:[[Player sharedPlayer] ability1] + 1];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ability1] forKey:kDataAbility01];
}

// writes ability 2 upgrade data
-(void)writeAbility2UpgradeData
{
    [[Player sharedPlayer] setAbility2:[[Player sharedPlayer] ability2] + 1];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ability2] forKey:kDataAbility02];
}

// writes ability 3 upgrade data
-(void)writeAbility3UpgradeData
{
    [[Player sharedPlayer] setAbility3:[[Player sharedPlayer] ability3] + 1];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ability3] forKey:kDataAbility03];
}

// writes ability 4 upgrade data
-(void)writeAbility4UpgradeData
{
    [[Player sharedPlayer] setAbility4:[[Player sharedPlayer] ability4] + 1];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ability4] forKey:kDataAbility04];
}

// writes ability 5 upgrade data
-(void)writeAbility5UpgradeData
{
    [[Player sharedPlayer] setAbility5:[[Player sharedPlayer] ability5] + 1];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ability5] forKey:kDataAbility05];
}

// writes ability 6 upgrade data
-(void)writeAbility6UpgradeData
{
    [[Player sharedPlayer] setAbility6:[[Player sharedPlayer] ability6] + 1];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ability6] forKey:kDataAbility06];
}

// writes ability 7 upgrade data
-(void)writeAbility7UpgradeData
{
    [[Player sharedPlayer] setAbility7:[[Player sharedPlayer] ability7] + 1];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ability7] forKey:kDataAbility07];
}

// writes ability 8 upgrade data
-(void)writeAbility8UpgradeData
{
    [[Player sharedPlayer] setAbility8:[[Player sharedPlayer] ability8] + 1];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ability8] forKey:kDataAbility08];
}

// writes ability 9 upgrade data
-(void)writeAbility9UpgradeData
{
    [[Player sharedPlayer] setAbility9:[[Player sharedPlayer] ability9] + 1];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] ability9] forKey:kDataAbility09];
}

// writes combat skill 1 upgrade data
-(void)writeCombatSkill1UpgradeData
{
    [[Player sharedPlayer] setCombatSkill1:[[Player sharedPlayer] combatSkill1] + 1];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsSkills];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] combatSkill1] forKey:kDataSkill01];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes combat skill 2 upgrade data
-(void)writeCombatSkill2UpgradeData
{
    [[Player sharedPlayer] setCombatSkill2:[[Player sharedPlayer] combatSkill2] + 1];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsSkills];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];

    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] combatSkill2] forKey:kDataSkill02];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes combat skill 3 upgrade data
-(void)writeCombatSkill3UpgradeData
{
    [[Player sharedPlayer] setCombatSkill3:[[Player sharedPlayer] combatSkill3] + 1];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsSkills];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];

    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] combatSkill3] forKey:kDataSkill03];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes survival skill 1 upgrade data
-(void)writeSurvivalSkill1UpgradeData
{
    [[Player sharedPlayer] setSurvivalSkill1:[[Player sharedPlayer] survivalSkill1] + 1];
    [[Player sharedPlayer] setMaxHP:[[Player sharedPlayer] maxHP] + 10 * [[Player sharedPlayer] survivalSkill1]];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsSkills];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];

    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] maxHP] forKey:kDataHp];
    [gamesave setInteger:[[Player sharedPlayer] survivalSkill1] forKey:kDataSkill04];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes survival skill 2 upgrade data
-(void)writeSurvivalSkill2UpgradeData
{
    [[Player sharedPlayer] setSurvivalSkill2:[[Player sharedPlayer] survivalSkill2] + 1];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsSkills];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];

    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] survivalSkill2] forKey:kDataSkill05];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes survival skill 3 upgrade data
-(void)writeSurvivalSkill3UpgradeData
{
    [[Player sharedPlayer] setSurvivalSkill3:[[Player sharedPlayer] survivalSkill3] + 1];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsSkills];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];

    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] survivalSkill3] forKey:kDataSkill06];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes practical skill 1 upgrade data
-(void)writePracticalSkill1UpgradeData
{
    [[Player sharedPlayer] setPracticalSkill1:[[Player sharedPlayer] practicalSkill1] + 1];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsSkills];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] practicalSkill1] forKey:kDataSkill07];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes practical skill 2 upgrade data
-(void)writePracticalSkill2UpgradeData
{
    [[Player sharedPlayer] setPracticalSkill2:[[Player sharedPlayer] practicalSkill2] + 1];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsSkills];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];

    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] practicalSkill2] forKey:kDataSkill08];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes practical skill 3 upgrade data
-(void)writePracticalSkill3UpgradeData
{
    [[Player sharedPlayer] setPracticalSkill3:[[Player sharedPlayer] practicalSkill3] + 1];
    [[Player sharedPlayer] setAttack:[[Player sharedPlayer] attack] + 4 * [[Player sharedPlayer] practicalSkill3]];
    [[Player sharedPlayer] setDefence:[[Player sharedPlayer] defence] + 4 * [[Player sharedPlayer] practicalSkill3]];
    [[Player sharedPlayer] setMagic:[[Player sharedPlayer] magic] + 4 * [[Player sharedPlayer] practicalSkill3]];
    [[Player sharedPlayer] setLuck:[[Player sharedPlayer] luck] + 4 * [[Player sharedPlayer] practicalSkill3]];
    [[Player sharedPlayer] updatePlayer];
    
    [[GameCenterManager sharedGameCenterManager] updateTotalScore:100];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsSkills];
    [[GameCenterManager sharedGameCenterManager] checkAchievementsMaster];

    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:[[Player sharedPlayer] attack] forKey:kDataAttack];
    [gamesave setInteger:[[Player sharedPlayer] defence] forKey:kDataDefence];
    [gamesave setInteger:[[Player sharedPlayer] magic] forKey:kDataMagic];
    [gamesave setInteger:[[Player sharedPlayer] luck] forKey:kDataLuck];
    [gamesave setInteger:[[Player sharedPlayer] practicalSkill3] forKey:kDataSkill09];
    [gamesave setInteger:[[GameCenterManager sharedGameCenterManager] totalScore] forKey:kDataTotalScore];
}

// writes gold spendings
-(void)writeSpendingGold:(int)gold
{
    int remainingGold = [[Player sharedPlayer] currentGold] - gold;
    
    if (remainingGold < 0) {
        remainingGold = 0;
    }
    
    [[Player sharedPlayer] setCurrentGold:remainingGold];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setInteger:remainingGold forKey:kDataGold];
}

// writes menu help
-(void)writeMenuHelp
{    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
        
    [gamesave setBool:battleHelp forKey:kDataBattleHelp];
    [gamesave setBool:playHelp forKey:kDataPlayHelp];
    [gamesave setBool:statsHelp forKey:kDataStatsHelp];
    [gamesave setBool:inventoryHelp forKey:kDataInventoryHelp];
    [gamesave setBool:tavernHelp forKey:kDataTavernHelp];
    [gamesave setBool:shopHelp forKey:kDataShopHelp];
    [gamesave setBool:skillsHelp forKey:kDataSkillsHelp];
}

// swaps the items in the new slots
-(void)writeSwapItemsData
{    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
        
    [gamesave setInteger:itemSlot1 forKey:kDataItemSlot01];
    [gamesave setInteger:itemSlot2 forKey:kDataItemSlot02];
    [gamesave setInteger:itemSlot3 forKey:kDataItemSlot03];
    [gamesave setInteger:itemSlot4 forKey:kDataItemSlot04];
    [gamesave setInteger:itemSlot5 forKey:kDataItemSlot05];
    [gamesave setInteger:itemSlot6 forKey:kDataItemSlot06];
    [gamesave setInteger:itemSlot7 forKey:kDataItemSlot07];    
}

// writes music configuration
-(void)writeConfigurationMusic:(BOOL)musicOn
{
    [[SoundManager sharedSoundManager] setIsMusicON:musicOn];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setBool:[[SoundManager sharedSoundManager] isMusicON] forKey:kDataMusic];
}

// writes sound configuration
-(void)writeConfigurationSound:(BOOL)soundOn
{
    [[SoundManager sharedSoundManager] setIsSoundON:soundOn];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setBool:[[SoundManager sharedSoundManager] isSoundON] forKey:kDataSound];
}

// writes online player level configuration
-(void)writeConfigurationOnlineSimilarLevel:(BOOL)similarLevel
{
    [[GameCenterManager sharedGameCenterManager] setShouldFightSimilarLevel:similarLevel];
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setBool:[[GameCenterManager sharedGameCenterManager] shouldFightSimilarLevel] forKey:kDataOnlineSimilarLevel];
}

// writes double coin
-(void)writeDoubleCoinData
{
    isDoubleCoin = YES;
        
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setBool:isDoubleCoin forKey:kDataDoubleCoin];
}

// writes purchased hard mode
-(void)writePurchasedHardModeData
{
    hasPurchasedHardMode = YES;
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setBool:hasPurchasedHardMode forKey:kDataPurchasedHardMode];
}

// writes early adopter
-(void)writeEarlyAdopterData
{
    isEarlyAdopter = YES;
    
    NSUserDefaults *gamesave = [NSUserDefaults standardUserDefaults];
    
    [gamesave setBool:isEarlyAdopter forKey:kDataEarlyAdopter];
}

#pragma mark - change current scene

// runs the scene that corresponds to the given id
-(void)runSceneWithID:(SceneType)sceneID
       withTransition:(BOOL)transition
{
    SceneType previousScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    
    switch (sceneID) {
        case kSceneMenu:
            sceneToRun = [MenuLayer node];
            break;
            
        case kScenePlay:
            sceneToRun = [PlayLayer node];
            break;
            
        case kSceneOptions:
            sceneToRun = [OptionsLayer node];
            break;
            
        case kSceneStats:
            sceneToRun = [StatsLayer node];
            break;
            
        case kSceneInventory:
            sceneToRun = [InventoryLayer node];
            break;
            
        case kSceneStory:
            sceneToRun = [StoryLayer node];
            break;
            
        case kSceneTavern:
            sceneToRun = [TavernLayer node];
            break;
            
        case kSceneShop:
            sceneToRun = [ShopLayer node];
            break;
            
        case kSceneTrainer:
            sceneToRun = [TrainerLayer node];
            break;
            
        case kSceneBattle:
            sceneToRun = [BattleLayer node];
            break;
            
        case kSceneQuest:
            sceneToRun = [BattleQuestLayer node];
            break;
            
        case kSceneVictory:
            sceneToRun = [VictoryLayer node];
            break;
            
        case kSceneCredits:
            sceneToRun = [CreditsLayer node];
            break;
            
        case kSceneMultiplayer:
            sceneToRun = [MultiplayLayer node];
            break;
            
        case kSceneArena:
            sceneToRun = [ArenaLayer node];
            break;
            
        case kSceneStore:
            sceneToRun = [StoreLayer node];
            break;
            
        case kSceneDonate:
            sceneToRun = [PurchaseLayer node];
            break;
            
        default:
            currentScene = previousScene;
            return;
            break;
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil) {
        if (transition) {
            [[CCDirector sharedDirector] pushScene:
             [CCTransitionFade transitionWithDuration:1.0f
                                                scene:sceneToRun
                                            withColor:ccBLACK]];
        }
        else {
            [[CCDirector sharedDirector] pushScene:sceneToRun];
        }
    }
    else {
        if (transition) {
            [[CCDirector sharedDirector] replaceScene:
             [CCTransitionFade transitionWithDuration:1.0f
                                                scene:sceneToRun
                                            withColor:ccBLACK]];
        }
        else {
            [[CCDirector sharedDirector] replaceScene:sceneToRun];
        }
    }
}

#pragma mark - follow a hyperlink

-(void)openHyperlinkType:(Hyperlink)hyperlinkType {
    NSURL *urlToOpen = nil;
    
    if (hyperlinkType == kHyperlinkTwitter) {
        urlToOpen = [NSURL URLWithString:@"https://twitter.com/intent/user?screen_name=DungeonStory"];
    }
    else if (hyperlinkType == kHyperlinkFacebook) {
        urlToOpen = [NSURL URLWithString:@"https://www.facebook.com/DungeonStoryRPG"];
    }
    
    if (![[UIApplication sharedApplication] openURL:urlToOpen]) {
        [self runSceneWithID:kSceneMenu withTransition:NO];
    }
}

#pragma mark - swap item slot

// swaps the items in the slots
-(void)writeSwapSlot:(int)slot1
            withSlot:(int)slot2
{
    int temp = 0;
    
    if (slot1 == 1 && slot2 == 1) {
        temp = itemSlot1;
        itemSlot1 = itemSlot4;
        itemSlot4 = temp;
    }
    
    if (slot1 == 1 && slot2 == 2) {
        temp = itemSlot1;
        itemSlot1 = itemSlot5;
        itemSlot5 = temp;
    }
    
    if (slot1 == 1 && slot2 == 3) {
        temp = itemSlot1;
        itemSlot1 = itemSlot6;
        itemSlot6 = temp;
    }
    
    if (slot1 == 1 && slot2 == 4) {
        temp = itemSlot1;
        itemSlot1 = itemSlot7;
        itemSlot7 = temp;
    }
    
    if (slot1 == 2 && slot2 == 1) {
        temp = itemSlot2;
        itemSlot2 = itemSlot4;
        itemSlot4 = temp;
    }
    
    if (slot1 == 2 && slot2 == 2) {
        temp = itemSlot2;
        itemSlot2 = itemSlot5;
        itemSlot5 = temp;
    }
    
    if (slot1 == 2 && slot2 == 3) {
        temp = itemSlot2;
        itemSlot2 = itemSlot6;
        itemSlot6 = temp;
    }
    
    if (slot1 == 2 && slot2 == 4) {
        temp = itemSlot2;
        itemSlot2 = itemSlot7;
        itemSlot7 = temp;
    }
    
    if (slot1 == 3 && slot2 == 1) {
        temp = itemSlot3;
        itemSlot3 = itemSlot4;
        itemSlot4 = temp;
    }
    
    if (slot1 == 3 && slot2 == 2) {
        temp = itemSlot3;
        itemSlot3 = itemSlot5;
        itemSlot5 = temp;
    }
    
    if (slot1 == 3 && slot2 == 3) {
        temp = itemSlot3;
        itemSlot3 = itemSlot6;
        itemSlot6 = temp;
    }
    
    if (slot1 == 3 && slot2 == 4) {
        temp = itemSlot3;
        itemSlot3 = itemSlot7;
        itemSlot7 = temp;
    }
    
    [self writeSwapItemsData];
}

#pragma mark - various

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSUserDefaultsDidChangeNotification
                                                  object:nil];
}

@end
