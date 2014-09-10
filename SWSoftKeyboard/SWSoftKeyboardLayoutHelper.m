//
//  SWSoftKeyboardLayoutHelper.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/10/14.
//  Copyright (c) 2014 Spencer Williams. All rights reserved.
//

#import "SWSoftKeyboardLayoutHelper.h"
#import "SWSoftKeyboardKeyCell.h"

@implementation SWSoftKeyboardLayoutHelper
+ (NSArray *)simpleKeysFromKeyboardShiftUpCharacters:(NSArray *)keyboardShiftUpCharacters
                         keyboardShiftDownCharacters:(NSArray *)keyboardShiftDownCharacters
{
    NSMutableArray *keys = [NSMutableArray new];
    for (int i=0; i<keyboardShiftUpCharacters.count; i++) {
        NSString *lowerLetter = [keyboardShiftUpCharacters objectAtIndex:i];
        NSString *upperLetter = [keyboardShiftDownCharacters objectAtIndex:i];
        // assumes keyboard layout states of
        // 0 = shift key is unpressed (unstuck)
        // 1 = shift key is pressed (stuck)
        NSDictionary *stuckLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                                     lowerLetter,[NSNumber numberWithInt:0],
                                     upperLetter,[NSNumber numberWithInt:1],nil];
        // stuck and notstuck labels and values are identical: these keys aren't sticky
        NSDictionary *stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [stuckLabels copy],[NSNumber numberWithBool:NO],
                                     [stuckLabels copy],[NSNumber numberWithBool:YES],nil];
        
        SWSoftKeyboardKeyCell *key = [[SWSoftKeyboardKeyCell alloc] initWithStateLabels:stateLabels
                                                                      stateValues:[stateLabels copy]
                                                                          keyType:SKKeyTypeContent
                                                                      controlType:SKControlTypeNone];
        [keys addObject:key];
    }
    return keys;
    
}
+ (NSArray *)commonAlphabetKeys
{
    NSArray *lowercase = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"];
    NSArray *uppercase = @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
    return [self simpleKeysFromKeyboardShiftUpCharacters:lowercase keyboardShiftDownCharacters:uppercase];
}
@end
