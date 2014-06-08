//
//  Utility.m
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 30/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "Utility.h"

@implementation Utility

// creates a custom stroke around label text
+(CCRenderTexture*)createStroke:(CCLabelTTF*)label
                       withSize:(float)size
                      withColor:(ccColor3B)color
{
    CCRenderTexture* rt = [CCRenderTexture renderTextureWithWidth:label.contentSize.width+size*2
                                                           height:label.contentSize.height+size*2];
    
	CGPoint originalPos = [label position];
	ccColor3B originalColor = [label color];
	BOOL originalVisibility = [label visible];
    
	[label setColor:color];
	[label setVisible:YES];
	
    ccBlendFunc originalBlend = [label blendFunc];
    
	[label setBlendFunc:(ccBlendFunc) { GL_SRC_ALPHA, GL_ONE }];
    
	CGPoint meio = ccp(label.texture.contentSize.width/2+size, label.texture.contentSize.height/2+size);
	
    [rt begin];
	
    for (int i=0; i<360; i+=30)
	{
		[label setPosition:ccp(meio.x + sin(CC_DEGREES_TO_RADIANS(i))*size, meio.y + cos(CC_DEGREES_TO_RADIANS(i))*size)];
		[label visit];
	}
	
    [rt end];
    
    [[[rt sprite] texture] setAntiAliasTexParameters];
	
    [label setPosition:originalPos];
	[label setColor:originalColor];
	[label setBlendFunc:originalBlend];
	[label setVisible:originalVisibility];
	[rt setPosition:originalPos];
	
    return rt;
}

+(CCSprite*)labelWithString:(NSString *)string
                   fontName:(NSString *)fontName
                   fontSize:(CGFloat)fontSize
                      color:(ccColor3B)color
                 strokeSize:(CGFloat)strokeSize
                 stokeColor:(ccColor3B)strokeColor
{    
	CCLabelTTF *label = [CCLabelTTF labelWithString:string fontName:fontName fontSize:fontSize];
    
	CCRenderTexture* rt = [CCRenderTexture renderTextureWithWidth:label.texture.contentSize.width + strokeSize*2  height:label.texture.contentSize.height+strokeSize*2];
    
	[label setFlipY:YES];
	[label setColor:strokeColor];
	ccBlendFunc originalBlendFunc = [label blendFunc];
	[label setBlendFunc:(ccBlendFunc) { GL_SRC_ALPHA, GL_ONE }];
    
	CGPoint bottomLeft = ccp(label.texture.contentSize.width * label.anchorPoint.x + strokeSize,
                             label.texture.contentSize.height * label.anchorPoint.y + strokeSize);
    
	CGPoint position = ccpSub([label position], ccp(-label.contentSize.width / 2.0f,
                                                    -label.contentSize.height / 2.0f));
    
	[rt begin];
    
	for (int i=0; i<360; i++)
	{
		[label setPosition:ccp(bottomLeft.x + sin(CC_DEGREES_TO_RADIANS(i))*strokeSize,
                               bottomLeft.y + cos(CC_DEGREES_TO_RADIANS(i))*strokeSize)];
		[label visit];
	}
    
	[label setPosition:bottomLeft];
	[label setBlendFunc:originalBlendFunc];
	[label setColor:color];
	[label visit];
    
	[rt end];
    
	[rt setPosition:position];
    
	return [CCSprite spriteWithTexture:rt.sprite.texture];
    
}

// returns a random message to display on upper bar
+(NSString*)setupRandomMsg
{
    int random = arc4random_uniform(9);
    NSString *msg;
    
    if (random == 8) {
        msg = NSLocalizedString(@"UpperBarMsg01", nil);
    }
    else if (random == 7) {
        msg = NSLocalizedString(@"UpperBarMsg02", nil);
    }
    else if (random == 5 || random == 6) {
        msg = NSLocalizedString(@"UpperBarMsg03", nil);
    }
    else if (random == 4) {
        msg = NSLocalizedString(@"UpperBarMsg04", nil);
    }
    else if (random == 3) {
        msg = NSLocalizedString(@"UpperBarMsg05", nil);
    }
    else if (random == 2) {
        msg = NSLocalizedString(@"UpperBarMsg06", nil);
    }
    else if (random == 1) {
        msg = NSLocalizedString(@"UpperBarMsg07", nil);
    }
    else {
        msg = NSLocalizedString(@"UpperBarMsg08", nil);
    }
    
    return msg;
}

// returns the font size
+(double)getFontSize:(double)size
{
    double fontSize = size;
    
    if ([NSLocalizedString(@"LANGUAGE", nil) isEqualToString:@"CHINESE"]) {
        fontSize = fontSize * 0.75;
    }
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) {
        fontSize = fontSize * 2.2f;
    }
    
    return fontSize;
}

@end
