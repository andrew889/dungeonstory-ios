//
//  SoundManager.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 10/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CDSoundSource;

@interface SoundManager : NSObject
{
    BOOL isMusicON;
    BOOL isSoundON;
    
    BOOL soundEffectStarted;
    
    int soundEffectID;
}

+(SoundManager*)sharedSoundManager;

@property (readwrite) BOOL isMusicON;
@property (readwrite) BOOL isSoundON;
@property (readwrite) BOOL soundEffectStarted;

-(void)playMainTheme;
-(void)stopBackgroundMusic;
-(void)fadeOutBackgroundMusic;

-(void)playButtonPressedEffect;

-(void)playSwordHitEffect;
-(void)playSwordTouchedEffect;

-(void)playMagicHitEffect;
-(void)playMagicTouchedEffect;

-(void)playCoinPickedUpEffect;
-(void)playCoinTouchedEffect;

-(void)playHeartEffect;

-(void)playShieldEffect;
-(void)playPotionEffect;
-(void)playBombEffect;

-(void)playUnlockEffect;
-(void)playVictoryEffect;
-(void)playDefeatEffect;

-(void)playMonster1Effect;
-(void)playMonster2Effect;
-(void)playMonster3Effect;

-(void)stopSoundEffect;

@end
