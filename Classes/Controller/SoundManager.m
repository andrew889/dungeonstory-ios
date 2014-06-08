//
//  SoundManager.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 10/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "SoundManager.h"
#import "SimpleAudioEngine.h"

@implementation SoundManager

static SoundManager *_sharedSoundManager = nil;

@synthesize isMusicON;
@synthesize isSoundON;
@synthesize soundEffectStarted;

+(SoundManager*)sharedSoundManager
{
    static dispatch_once_t pred = 0;
    
    __strong static id _sharedSoundManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedSoundManager = [[self alloc] init];
    });
    
    return _sharedSoundManager;
}

+(id)alloc
{
    @synchronized ([SoundManager class])
    {
        NSAssert(_sharedSoundManager == nil,
                 @"Attempted to allocate a second instance of the Sound Manager singleton");
        _sharedSoundManager = [super alloc];
        
        return _sharedSoundManager;
    }
    
    return nil;
}

-(id)init
{
    if ((self = [super init])) {
        [[CDAudioManager sharedManager] preloadBackgroundMusic:@"main_theme.caf"];
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"click.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sword_hit.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"sword.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"magic_hit.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"magic.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"coin_pickup.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"coin.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"heart.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"shield.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"potion.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"bomb.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"unlock.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"victory.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"defeat.caf"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"monster1.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"monster2.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"monster3.wav"];
        
        soundEffectStarted = NO;
        soundEffectID = 0;
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    }
    
    return self;
}

#pragma mark - game background music

// plays the main theme
-(void)playMainTheme
{    
    if (![self isNonGameMusicPlaying] && isMusicON &&
        ![[CDAudioManager sharedManager] isBackgroundMusicPlaying]) {
        
        [[CDAudioManager sharedManager] playBackgroundMusic:@"main_theme.caf" loop:YES];
        [[[CDAudioManager sharedManager] backgroundMusic] setVolume:0.5f];
    }
    else if ([self isNonGameMusicPlaying]) {
        [self stopBackgroundMusic];
    }
}

// stop the background music
-(void)stopBackgroundMusic
{
    if ([[CDAudioManager sharedManager] isBackgroundMusicPlaying]) {
        [[CDAudioManager sharedManager] stopBackgroundMusic];
    }
}

// fade out the background music
-(void)fadeOutBackgroundMusic
{
    if (isMusicON && [[CDAudioManager sharedManager] isBackgroundMusicPlaying]) {
        float volume = [[[CDAudioManager sharedManager] backgroundMusic] volume];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (float vol = volume; vol > 0.0f; vol -= 0.00005f) {
                [[[CDAudioManager sharedManager] backgroundMusic] setVolume:vol];
            }
            
            [[CDAudioManager sharedManager] stopBackgroundMusic];
        });
    }
}

#pragma mark - sound effects

// plays button pressed sound effect
-(void)playButtonPressedEffect
{
    if (isSoundON && !soundEffectStarted) {
        soundEffectStarted = YES;
                
        int gen = arc4random_uniform(4);
        
        if (gen == 3) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav" pitch:0.7f pan:0.0f gain:0.35f];
        }
        else if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav" pitch:0.8f pan:0.0f gain:0.35f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav" pitch:0.9f pan:0.0f gain:0.35f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"click.wav" pitch:1.0f pan:0.0f gain:0.35f];
        }
    }
}

// plays sword hit sound effect
-(void)playSwordHitEffect
{
    if (isSoundON) {        
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"sword_hit.wav" pitch:0.85f pan:0.0f gain:0.2f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"sword_hit.wav" pitch:1.0f pan:0.0f gain:0.2f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"sword_hit.wav" pitch:0.7f pan:0.0f gain:0.2f];
        }
    }
}

// plays sword touched sound effect
-(void)playSwordTouchedEffect
{
    if (isSoundON) {
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"sword.wav" pitch:0.85f pan:0.0f gain:0.2f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"sword.wav" pitch:1.0f pan:0.0f gain:0.2f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"sword.wav" pitch:0.7f pan:0.0f gain:0.2f];
        }
    }
}

// plays magic hit sound effect
-(void)playMagicHitEffect
{
    if (isSoundON) {
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"magic_hit.wav" pitch:0.85f pan:0.0f gain:0.8f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"magic_hit.wav" pitch:1.0f pan:0.0f gain:0.8f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"magic_hit.wav" pitch:1.15f pan:0.0f gain:0.8f];
        }
    }
}

// plays magic touched sound effect
-(void)playMagicTouchedEffect
{
    if (isSoundON) {
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"magic.wav" pitch:0.85f pan:0.0f gain:0.6f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"magic.wav" pitch:1.0f pan:0.0f gain:0.6f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"magic.wav" pitch:0.7f pan:0.0f gain:0.6f];
        }
    }
}

// plays coin picked up sound effect
-(void)playCoinPickedUpEffect
{
    if (isSoundON) {
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"coin_pickup.wav" pitch:0.85f pan:0.0f gain:0.4f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"coin_pickup.wav" pitch:1.0f pan:0.0f gain:0.4f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"coin_pickup.wav" pitch:0.7f pan:0.0f gain:0.4f];
        }
    }
}

// plays coin touched sound effect
-(void)playCoinTouchedEffect
{
    if (isSoundON) {
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"coin.wav" pitch:0.85f pan:0.0f gain:0.3f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"coin.wav" pitch:1.0f pan:0.0f gain:0.3f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"coin.wav" pitch:0.7f pan:0.0f gain:0.3f];
        }
    }
}

// plays heart sound effect
-(void)playHeartEffect
{
    if (isSoundON) {
        int gen = arc4random_uniform(4);
        
        if (gen == 3) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"heart.wav" pitch:0.77f pan:0.0f gain:0.8f];
        }
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"heart.wav" pitch:0.85f pan:0.0f gain:0.8f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"heart.wav" pitch:1.0f pan:0.0f gain:0.8f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"heart.wav" pitch:0.7f pan:0.0f gain:0.8f];
        }
    }
}

// plays shield sound effect
-(void)playShieldEffect
{
    if (isSoundON) {
        int gen = arc4random_uniform(2);
        
        if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"shield.wav" pitch:0.55f pan:0.0f gain:0.5f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"shield.wav" pitch:0.75f pan:0.0f gain:0.5f];
        }
    }
}

// plays potion sound effect
-(void)playPotionEffect
{
    if (isSoundON) {
        int gen = arc4random_uniform(2);
        
        if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"potion.wav" pitch:0.85f pan:0.0f gain:0.7f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"potion.wav" pitch:1.0f pan:0.0f gain:0.7f];
        }
    }
}

// plays bomb sound effect
-(void)playBombEffect
{
    if (isSoundON) {
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"bomb.wav" pitch:0.7f pan:0.0f gain:0.8f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"bomb.wav" pitch:1.0f pan:0.0f gain:0.8f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"bomb.wav" pitch:0.85f pan:0.0f gain:0.8f];
        }
    }
}

// plays unlock sound effect
-(void)playUnlockEffect
{
    if (isSoundON) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"unlock.caf" pitch:1.4f pan:0.0f gain:0.15f];
    }
}

// plays victory sound effect
-(void)playVictoryEffect
{
    if (isSoundON) {
        soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"victory.caf" pitch:1.0f pan:0.0f gain:0.8f];
    }
}

// plays defeat sound effect
-(void)playDefeatEffect
{
    if (isSoundON) {
        soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"defeat.caf" pitch:1.0f pan:0.0f gain:0.8f];
    }
}

// plays enemy 1 sound effect
-(void)playMonster1Effect
{
    if (isSoundON) {
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"monster1.wav" pitch:0.8f pan:0.0f gain:0.3f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"monster1.wav" pitch:1.2f pan:0.0f gain:0.3f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"monster1.wav" pitch:1.0f pan:0.0f gain:0.3f];
        }
    }
}

// plays enemy 2 sound effect
-(void)playMonster2Effect
{
    if (isSoundON) {
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"monster2.wav" pitch:0.8f pan:0.0f gain:0.3f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"monster2.wav" pitch:1.2f pan:0.0f gain:0.3f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"monster2.wav" pitch:1.0f pan:0.0f gain:0.3f];
        }
    }
}

// plays enemy 3 sound effect
-(void)playMonster3Effect
{
    if (isSoundON) {
        int gen = arc4random_uniform(3);
        
        if (gen == 2) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"monster3.wav" pitch:0.8f pan:0.0f gain:0.3f];
        }
        else if (gen == 1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"monster3.wav" pitch:1.2f pan:0.0f gain:0.3f];
        }
        else {
            [[SimpleAudioEngine sharedEngine] playEffect:@"monster3.wav" pitch:1.0f pan:0.0f gain:0.3f];
        }
    }
}

// stops sound effect
-(void)stopSoundEffect
{
    if (isSoundON) {
        [[SimpleAudioEngine sharedEngine] stopEffect:soundEffectID];
    }
}

#pragma mark - utilities

// checks if msusic is playing from an outside source (eg. ipod)
-(BOOL)isNonGameMusicPlaying
{
    BOOL value;
    
    UInt32 otherAudioIsPlaying;
    UInt32 propertySize = sizeof (otherAudioIsPlaying);
    
    AudioSessionGetProperty (kAudioSessionProperty_OtherAudioIsPlaying,
                             &propertySize, &otherAudioIsPlaying);
    
    if (otherAudioIsPlaying) value = YES;
    else value = NO;
    
    return value;
}

@end
