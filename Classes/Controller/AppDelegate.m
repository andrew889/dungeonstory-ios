//
//  AppDelegate.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 08/08/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "cocos2d.h"
#import "AppDelegate.h"
#import "GameManager.h"
#import "IAPManager.h"
#import "GameCenterManager.h"
#import "SoundManager.h"

@implementation AppController

@synthesize window = window_;
@synthesize navController = navController_;
@synthesize director = director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenBestEmulatedMode];
    
    // Set the application preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSDictionary *iCloudDefaults = [NSDictionary dictionaryWithObject:@"NO"
                                                               forKey:@"icloud_preference"];
    [preferences registerDefaults:iCloudDefaults];
    [preferences synchronize];

    // authenticates user for game center
    [[GameCenterManager sharedGameCenterManager] authenticateUser];
    
    // Setting up game manager.
    [GameManager sharedGameManager];
    
    // Setting up IAP.
    [IAPManager sharedIAPManager];
    
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
    
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
    
	director_.wantsFullScreenLayout = YES;
    
	//[director_ setDisplayStats:YES];
	[director_ setAnimationInterval:1.0/60];
	[director_ setView:glView];
	[director_ setDelegate:self];
    
	[director_ setProjection:kCCDirectorProjection2D];
    
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
    
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
    
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    
	// Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
    
    // setups game manager
    [[GameManager sharedGameManager] readGameData];
    
    // setups sound and music
    [[SoundManager sharedSoundManager] playMainTheme];
    
    [[GameManager sharedGameManager] runSceneWithID:kSceneMenu withTransition:YES];
	
	return YES;
}

// Supported orientations: Portrait
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


// getting a call, pause the game
-(void)applicationWillResignActive:(UIApplication*)application
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void)applicationDidBecomeActive:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void)applicationDidEnterBackground:(UIApplication*)application
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void)applicationWillEnterForeground:(UIApplication*)application
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
    
    if ([[GameManager sharedGameManager] currentDungeon] == kDungeonNone) {
        [[SoundManager sharedSoundManager] playMainTheme];
    }
}

// application will be killed
-(void)applicationWillTerminate:(UIApplication*)application
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    
	CC_DIRECTOR_END();
}

// purge memory
-(void)applicationDidReceiveMemoryWarning:(UIApplication*)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void)applicationSignificantTimeChange:(UIApplication*)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

@end
