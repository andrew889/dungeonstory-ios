//
//  GameManager.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralValues.h"
#import "BattleValues.h"
#import "PlayerValues.h"

@interface GameManager : NSObject
{
    SceneType currentScene;
    Dungeon currentDungeon;
    
    QuestType questType;
    
    int itemSlot1;
    int itemSlot2;
    int itemSlot3;
    int itemSlot4;
    int itemSlot5;
    int itemSlot6;
    int itemSlot7;

    BOOL isEarlyAdopter;
    BOOL isDoubleCoin;
    BOOL hasPurchasedHardMode;
    BOOL isHardModeOn;
    BOOL battleHelp;
    BOOL playHelp;
    BOOL statsHelp;
    BOOL inventoryHelp;
    BOOL tavernHelp;
    BOOL shopHelp;
    BOOL skillsHelp;
}

@property (readonly) SceneType currentScene;
@property (readwrite) Dungeon currentDungeon;
@property (readwrite) QuestType questType;
@property (readwrite) int itemSlot1;
@property (readwrite) int itemSlot2;
@property (readwrite) int itemSlot3;
@property (readwrite) int itemSlot4;
@property (readwrite) int itemSlot5;
@property (readwrite) int itemSlot6;
@property (readwrite) int itemSlot7;
@property (readwrite) BOOL isEarlyAdopter;
@property (readwrite) BOOL isDoubleCoin;
@property (readwrite) BOOL hasPurchasedHardMode;
@property (readwrite) BOOL isHardModeOn;
@property (readwrite) BOOL battleHelp;
@property (readwrite) BOOL playHelp;
@property (readwrite) BOOL statsHelp;
@property (readwrite) BOOL inventoryHelp;
@property (readwrite) BOOL tavernHelp;
@property (readwrite) BOOL shopHelp;
@property (readwrite) BOOL skillsHelp;

+(GameManager*)sharedGameManager;

-(void)readGameData;
-(void)deleteGameData;

-(void)writePlayerName:(NSString*)string;
-(void)writePlayerClass:(int)value;

-(void)writeExp:(int)exp;
-(void)writeTotalRuns;
-(void)writeHighestRounds:(int)battleRounds;
-(void)writeQuestProgress:(int)rep;
-(void)writeGatheredGold:(int)gold;
-(void)writeEmblemProgress;
-(void)writeArenaVictory;

-(void)writeWeaponUpgradeData;
-(void)writeSpellbookUpgradeData;
-(void)writeArmorUpgradeData;
-(void)writeRingUpgradeData;
-(void)writeAmuletUpgradeData;
-(void)writeShieldUpgradeData;
-(void)writePotionUpgradeData;
-(void)writeBombUpgradeData;
-(void)writeAleUpgradeData;
-(void)writeRuneUpgradeData;
-(void)writeMirrorUpgradeData;
-(void)writeFluteUpgradeData;

-(void)writeAbility1UpgradeData;
-(void)writeAbility2UpgradeData;
-(void)writeAbility3UpgradeData;
-(void)writeAbility4UpgradeData;
-(void)writeAbility5UpgradeData;
-(void)writeAbility6UpgradeData;
-(void)writeAbility7UpgradeData;
-(void)writeAbility8UpgradeData;
-(void)writeAbility9UpgradeData;

-(void)writeCombatSkill1UpgradeData;
-(void)writeCombatSkill2UpgradeData;
-(void)writeCombatSkill3UpgradeData;
-(void)writeSurvivalSkill1UpgradeData;
-(void)writeSurvivalSkill2UpgradeData;
-(void)writeSurvivalSkill3UpgradeData;
-(void)writePracticalSkill1UpgradeData;
-(void)writePracticalSkill2UpgradeData;
-(void)writePracticalSkill3UpgradeData;

-(void)writeSpendingGold:(int)gold;

-(void)writeMenuHelp;

-(void)writeConfigurationMusic:(BOOL)musicOn;
-(void)writeConfigurationSound:(BOOL)soundOn;

-(void)writeConfigurationOnlineSimilarLevel:(BOOL)similarLevel;

-(void)writeDoubleCoinData;
-(void)writePurchasedHardModeData;
-(void)writeEarlyAdopterData;

-(void)runSceneWithID:(SceneType)sceneID
       withTransition:(BOOL)transition;
-(void)openHyperlinkType:(Hyperlink)hyperlinkType;

-(void)writeSwapSlot:(int)slot1
            withSlot:(int)slot2;

@end
