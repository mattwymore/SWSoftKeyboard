//
//  SWSoftKeyboardLayout.m
//  CurrentScience
//
//  Created by Spencer Williams on 12/8/14.
//  Copyright (c) 2014 Uncorked Studios. All rights reserved.
//

#import "SWSoftKeyboardLayout.h"

#define LOG YES

@implementation SWSoftKeyboardLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.keysForStates = [NSMutableDictionary new];
        self.maxKeysInRow = 10;
        self.gutter = 7; //pixel spacing between keys
        self.padding = 16; // pixel spacing between end key and keyboard border
        self.numberOfRows = 4;
        self.defaultKeyWidth = 50;
        self.keyHeightMultiplier = 0.618; // golden!
        self.defaultKeyHeight = self.defaultKeyWidth * self.keyHeightMultiplier;
        
        
    }
    return self;
}

- (void)emptyExistingKeys {
    self.keysForStates = [NSMutableDictionary new];
}

- (NSArray *)keysForState:(int)layoutState {
    return @[];
}

- (int)layoutStates {
    return 0;
}

- (NSRect)keyboardFrameForState:(int)layoutState
{
    if (LOG) NSLog(@"[SKL] keyboardFrameForState:%i", layoutState);
    
    // NOTE: this currently is based on a NSWindow based application not an NSDocument one.
    //find a window!
    NSWindow *activeWindow = nil;
    if ([NSApp keyWindow]) {
        activeWindow = [NSApp keyWindow];
    }else if ([NSApp mainWindow]){
        activeWindow = [NSApp mainWindow];
    }else{
        activeWindow = [NSApp windows][0];
    }
    NSRect keyboardFrame = activeWindow.frame;
    
    if (self.layoutDelegate && [self.layoutDelegate respondsToSelector:@selector(maxSizeForLayout:)]) {
        CGSize maxSize = [self.layoutDelegate maxSizeForLayout:self];
        keyboardFrame.size = CGSizeMake(MIN(keyboardFrame.size.width, maxSize.width),
                                        MIN(keyboardFrame.size.height, maxSize.height));
    }
    
    self.defaultKeyWidth = (keyboardFrame.size.width - (self.padding*2) - (self.gutter*(self.maxKeysInRow-1))) / self.maxKeysInRow;
    
    self.defaultKeyHeight = self.defaultKeyWidth * self.keyHeightMultiplier;
    
    NSInteger height = (self.defaultKeyHeight*self.numberOfRows) + (self.padding*2) + (self.gutter*(self.numberOfRows-1));
    
    NSRect finalFrame = NSMakeRect((activeWindow.frame.size.width - keyboardFrame.size.width) / 2.0,
                                   0,
                                   keyboardFrame.size.width,
                                   height);
    return finalFrame;
    
}
@end
