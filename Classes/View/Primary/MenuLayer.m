//
//  MenuLayer.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "MenuLayer.h"
#import "AppDelegate.h"
#import "GameManager.h"
#import "SoundManager.h"
#import "Player.h"
#import "Utility.h"

#pragma mark - MenuLayer

@implementation MenuLayer

+(CCScene*)scene
{
	CCScene *scene = [CCScene node];
	MenuLayer *layer = [MenuLayer node];
	
	[scene addChild:layer];
	
	return scene;
}

-(id)init
{
	if((self=[super init])) {        
		screenSize = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"MainMenu.png"];
        mainLogo = [CCSprite spriteWithFile:@"MainLogo.png"];
        mainMenuSword = [CCSprite spriteWithFile:@"MainMenuSwords.png"];
        mainMenuGlow = [CCSprite spriteWithFile:@"MainMenuGlow.png"];
        
        labelBtn04 = [Utility labelWithString:NSLocalizedString(@"StoreLabel", nil)
                                     fontName:@"Shark Crash"
                                     fontSize:[Utility getFontSize:40]
                                        color:ccWHITE
                                   strokeSize:[Utility getFontSize:2]
                                   stokeColor:ccBLACK];
        
        itemPlay = [CCMenuItemImage itemWithNormalImage:@"newgame_btn.png"
                                          selectedImage:@"newgame_btn_pressed.png"
                                          disabledImage:nil
                                                 target:self selector:@selector(showPlay)];
        
        itemOnline = [CCMenuItemImage itemWithNormalImage:@"online_btn.png"
                                            selectedImage:@"online_btn_pressed.png"
                                            disabledImage:nil
                                                   target:self selector:@selector(showMultiplayer)];
        
        itemOptions = [CCMenuItemImage itemWithNormalImage:@"options_btn.png"
                                             selectedImage:@"options_btn_pressed.png"
                                             disabledImage:nil
                                                    target:self selector:@selector(showOptions)];

        itemAchievements = [CCMenuItemImage itemWithNormalImage:@"achievements_btn.png"
                                                  selectedImage:@"achievements_btn_pressed.png"
                                                  disabledImage:nil
                                                          block:^(id sender) {
                                                              [self setupAchievementsView];
                                                          }];
        itemLeaderboards = [CCMenuItemImage itemWithNormalImage:@"leaderboards_btn.png"
                                                  selectedImage:@"leaderboards_btn_pressed.png"
                                                  disabledImage:nil
                                                          block:^(id sender) {
                                                              [self setupLeaderboardsView];
                                                          }];

        itemTw = [CCMenuItemImage itemWithNormalImage:@"twitter_btn.png"
                                        selectedImage:@"twitter_btn_pressed.png"
                                        disabledImage:nil
                                               target:self
                                             selector:@selector(followTwitter)];
        itemFb = [CCMenuItemImage itemWithNormalImage:@"facebook_btn.png"
                                        selectedImage:@"facebook_btn_pressed.png"
                                        disabledImage:nil
                                               target:self
                                             selector:@selector(followFacebook)];

        itemStore = [CCMenuItemImage itemWithNormalImage:@"store_btn.png"
                                           selectedImage:@"store_btn_pressed.png"
                                           disabledImage:nil
                                                  target:self
                                                selector:@selector(showStore)];
        
		menuChoices = [CCMenu menuWithItems:itemPlay, itemOnline, itemOptions, nil];
        menuGameCenter = [CCMenu menuWithItems:itemLeaderboards, itemAchievements, nil];
        menuStore = [CCMenu menuWithItems:itemStore, nil];

        menuSocial = [CCMenu menuWithItems:itemTw, itemFb, nil];
        
        [menuChoices setAnchorPoint:ccp(1, 0.5)];
        
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height == 568.00) {
                [mainLogo setPosition:ccp(screenSize.width/2, screenSize.height/2 + 44)];
                [mainMenuSword setPosition:ccp(screenSize.width/2, screenSize.height/2 - 22)];
                [mainMenuGlow setPosition:ccp(screenSize.width/2, screenSize.height/2 - 22)];
                
                [menuChoices alignItemsVerticallyWithPadding:1];
                [menuChoices setPosition:ccp(screenSize.width/2 - 110, screenSize.height/2 - 57)];
                [menuSocial alignItemsHorizontallyWithPadding:5];
                [menuSocial setPosition:ccp(screenSize.width/2 + 95, screenSize.height/2 - 244)];
                [menuStore setPosition:ccp(screenSize.width/2 + 95, screenSize.height/2 - 169)];
                [menuGameCenter alignItemsHorizontallyWithPadding:5];
                [menuGameCenter setPosition:ccp(screenSize.width/2 - 95, screenSize.height/2 - 244)];
            }
            else {
                [mainLogo setPosition:ccp(screenSize.width/2, screenSize.height/2)];
                [mainMenuSword setPosition:ccp(screenSize.width/2, screenSize.height/2)];
                [mainMenuGlow setPosition:ccp(screenSize.width/2, screenSize.height/2)];
                
                [menuChoices alignItemsVerticallyWithPadding:1];
                [menuChoices setPosition:ccp(screenSize.width/2 - 110, screenSize.height/2 - 35)];
                [menuSocial alignItemsHorizontallyWithPadding:5];
                [menuSocial setPosition:ccp(screenSize.width/2 + 95, screenSize.height/2 - 200)];
                [menuStore setPosition:ccp(screenSize.width/2 + 95, screenSize.height/2 - 125)];
                [menuGameCenter alignItemsHorizontallyWithPadding:5];
                [menuGameCenter setPosition:ccp(screenSize.width/2 - 95, screenSize.height/2 - 200)];
            }
            
            [labelBtn04 setPosition:ccp(itemStore.contentSize.width/2, itemStore.contentSize.height/2 - 10)];
        }
        else {
            [mainLogo setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [mainMenuSword setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            [mainMenuGlow setPosition:ccp(screenSize.width/2, screenSize.height/2)];
            
            [menuChoices alignItemsVerticallyWithPadding:(1 * 2.133f)];
            [menuChoices setPosition:ccp(screenSize.width/2 - (119 * 2.4f), screenSize.height/2 - (35 * 2.133f))];
            [menuSocial alignItemsHorizontallyWithPadding:(5 * 2.4f)];
            [menuSocial setPosition:ccp(screenSize.width/2 + (98 * 2.4f), screenSize.height/2 - (200 * 2.133f))];
            [menuStore setPosition:ccp(screenSize.width/2 + (98 * 2.4f), screenSize.height/2 - (125 * 2.133f))];
            [menuGameCenter alignItemsHorizontallyWithPadding:(5 * 2.4f)];
            [menuGameCenter setPosition:ccp(screenSize.width/2 - (98 * 2.4f), screenSize.height/2 - (200 * 2.133f))];
            
            [labelBtn04 setPosition:ccp(itemStore.contentSize.width/2, itemStore.contentSize.height/2 - (10 * 2.133f))];
        }
		
        [self addChild:background z:-1 tag:0];
        [self addChild:mainLogo z:3 tag:1];
        [self addChild:mainMenuGlow z:1 tag:2];
        [self addChild:mainMenuSword z:2 tag:3];
		[self addChild:menuChoices z:3 tag:4];
        [self addChild:menuSocial z:3 tag:6];
        [self addChild:menuStore z:3 tag:7];
        [self addChild:menuGameCenter z:3 tag:5];
        
        [itemStore addChild:labelBtn04];
        
        mainMenuGlow.opacity = 0.0f;
        shouldGlow = YES;
        isPlayButtonMoving = NO;
        isOnlineButtonMoving = NO;
        isOptionsButtonMoving = NO;

        [self scheduleUpdate];
        
        if (![[GameManager sharedGameManager] isEarlyAdopter]) {
            [self showReward];
        }
    }
    
	return self;
}

#pragma mark - update schedulers

// updates menu
-(void)update:(ccTime)dt
{
    if ([[GameCenterManager sharedGameCenterManager] pendingInvite]) {
        [self setupArenaView];
    }
    
    [self movePlayButton];
    [self moveOnlineButton];
    [self moveOptionsButton];
    
    if (shouldGlow) {
        mainMenuGlow.opacity += 1.5f;
        
        if (mainMenuGlow.opacity >= 185.0f) shouldGlow = NO;
    }
    else {
        mainMenuGlow.opacity -= 1.5f;
        
        if (mainMenuGlow.opacity <= 35.0f) shouldGlow = YES;
    }
    
    if (itemPlay.isSelected || itemOnline.isSelected || itemOptions.isSelected ||
        itemAchievements.isSelected || itemLeaderboards.isSelected ||
        itemTw.isSelected || itemFb.isSelected) {
        
        [[SoundManager sharedSoundManager] playButtonPressedEffect];
    }
    else if (!itemPlay.isSelected && !itemOnline.isSelected && !itemOptions.isSelected &&
             !itemAchievements.isSelected && !itemLeaderboards.isSelected &&
             !itemTw.isSelected && !itemFb.isSelected) {
        
        [[SoundManager sharedSoundManager] setSoundEffectStarted:NO];
    }
}

#pragma mark - button actions

// moves play button
-(void)movePlayButton
{
    if (itemPlay.isSelected && !isPlayButtonMoving) {
        isPlayButtonMoving = YES;
                
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [itemPlay runAction:
             [CCMoveTo actionWithDuration:0.3f
                                 position:ccp(25, itemPlay.position.y)]];
        }
        else {
            [itemPlay runAction:
             [CCMoveTo actionWithDuration:0.3f
                                 position:ccp(16 * 2.4f, itemPlay.position.y)]];
        }
    }
    else if (!itemPlay.isSelected && isPlayButtonMoving) {
        isPlayButtonMoving = NO;
        
        [itemPlay runAction:
         [CCMoveTo actionWithDuration:0.3f
                             position:ccp(0.0f, itemPlay.position.y)]];
    }
}

// moves online button
-(void)moveOnlineButton
{
    if (itemOnline.isSelected && !isOnlineButtonMoving) {
        isOnlineButtonMoving = YES;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [itemOnline runAction:
             [CCMoveTo actionWithDuration:0.3f
                                 position:ccp(23, itemOnline.position.y)]];
        }
        else {
            [itemOnline runAction:
             [CCMoveTo actionWithDuration:0.3f
                                 position:ccp(14 * 2.4f, itemOnline.position.y)]];
        }
    }
    else if (!itemOnline.isSelected && isOnlineButtonMoving) {
        isOnlineButtonMoving = NO;
        
        [itemOnline runAction:
         [CCMoveTo actionWithDuration:0.3f
                             position:ccp(0.0f, itemOnline.position.y)]];
    }
}

// moves options button
-(void)moveOptionsButton
{
    if (itemOptions.isSelected && !isOptionsButtonMoving) {
        isOptionsButtonMoving = YES;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [itemOptions runAction:
             [CCMoveTo actionWithDuration:0.3f
                                 position:ccp(23, itemOptions.position.y)]];
        }
        else {
            [itemOptions runAction:
             [CCMoveTo actionWithDuration:0.3f
                                 position:ccp(14 * 2.4f, itemOptions.position.y)]];
        }
    }
    else if (!itemOptions.isSelected && isOptionsButtonMoving) {
        isOptionsButtonMoving = NO;
        
        [itemOptions runAction:
         [CCMoveTo actionWithDuration:0.3f
                             position:ccp(0.0f, itemOptions.position.y)]];
    }
}

#pragma mark - menu choices

// shows the play scene
-(void)showPlay
{
    [[GameManager sharedGameManager] runSceneWithID:kScenePlay withTransition:YES];
}

// shows the multiplayer scene
-(void)showMultiplayer
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneMultiplayer withTransition:YES];
}

// shows the options scene
-(void)showOptions
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneOptions withTransition:YES];
}

// follows on twitter
-(void)followTwitter
{
    [[GameManager sharedGameManager] openHyperlinkType:kHyperlinkTwitter];
}

// follows on facebook
-(void)followFacebook
{
    [[GameManager sharedGameManager] openHyperlinkType:kHyperlinkFacebook];
}

// shows the store scene
-(void)showStore
{
    [[GameManager sharedGameManager] runSceneWithID:kSceneStore withTransition:NO];
}

// shows the reward for early adopters
-(void)showReward
{
    int gift;
    
    if ([[Player sharedPlayer] level] <= 10) gift = 100;
    else if ([[Player sharedPlayer] level] <= 50) gift = 250;
    else if ([[Player sharedPlayer] level] <= 100) gift = 500;
    else gift = 1000;
    
    UIAlertView* dialog = [[UIAlertView alloc] init];
    
    [dialog setDelegate:self];
        
    [dialog setTitle:@"Supporter's Gift"];
    [dialog setMessage:[NSString stringWithFormat:@"Thank you for playing Dungeon Story! As a reward for your awesome support, you gained %d gold to spend on any items you want in game! More updates coming soon! Stay tuned :)", gift]];
	
	[dialog addButtonWithTitle:NSLocalizedString(@"Confirm", nil)];
    
    [dialog show];
    
    [[GameManager sharedGameManager] writeGatheredGold:gift];
    [[GameManager sharedGameManager] writeEarlyAdopterData];
}

#pragma mark Game Center achievements

// setups achievements view
-(void)setupAchievementsView
{
    GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
    achivementViewController.achievementDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] presentModalViewController:achivementViewController animated:YES];
}

-(void)achievementViewControllerDidFinish:(GKAchievementViewController*)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

#pragma mark Game Center leaderboards

// setups leaderboards view
-(void)setupLeaderboardsView
{
    GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
    leaderboardViewController.leaderboardDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] presentModalViewController:leaderboardViewController animated:YES];
}

-(void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController*)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

#pragma mark Game Center multiplayer

// setups multiplayer view
-(void)setupArenaView
{
    [[GameCenterManager sharedGameCenterManager] findMatchWithMinPlayers:2
                                                              maxPlayers:2
                                                          viewController:[CCDirector sharedDirector]
                                                                delegate:self];
}

@end
