//
//  Utility.h
//  DungeonStory
//
//  Created by Pantazis Deligiannis on 30/09/2012.
//  Copyright Pantazis Deligiannis 2012-2014. All rights reserved.
//

#import "cocos2d.h"

@interface Utility : NSObject

+(CCRenderTexture*)createStroke:(CCLabelTTF*)label
                       withSize:(float)size
                      withColor:(ccColor3B)color;

+(CCSprite*)labelWithString:(NSString *)string
                   fontName:(NSString *)fontName
                   fontSize:(CGFloat)fontSize
                      color:(ccColor3B)color
                 strokeSize:(CGFloat)strokeSize
                 stokeColor:(ccColor3B)strokeColor;

+(NSString*)setupRandomMsg;

+(double)getFontSize:(double)size;

@end
