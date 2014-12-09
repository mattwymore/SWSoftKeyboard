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
//        NSDictionary *stuckLabels = [NSDictionary dictionaryWithObjectsAndKeys:
//                                     lowerLetter,[NSNumber numberWithInt:0],
//                                     upperLetter,[NSNumber numberWithInt:1],nil];
        // stuck and notstuck labels and values are identical: these keys aren't sticky
        NSDictionary *stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                                     lowerLetter,[NSNumber numberWithBool:NO],
                                     upperLetter,[NSNumber numberWithBool:YES],nil];
        
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

+ (NSArray *)qwertyLowerRows
{
    NSArray *lowercase = @[@[@" "],
                           @[@"z",@"x",@"c",@"v",@"b",@"n",@"m"],
                           @[@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l"],
                           @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p"]];
    return lowercase;
}

+ (NSArray *)qwertyUpperRows
{
    NSArray *uppercase = @[@[@" "],
                           @[@"Z",@"X",@"C",@"V",@"B",@"N",@"M"],
                           @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                           @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"]];
    return uppercase;
}

+ (NSArray *)qwertyKeyCodes
{
    NSArray *keycodes = @[@[@49],
                           @[@6, @7, @8, @9, @11, @45, @46],
                           @[@0, @1, @2, @3, @5, @4, @38, @40, @37],
                           @[@12, @13, @14, @15, @17, @16, @32, @34, @31, @35]];
    return keycodes;
}

+ (NSArray *)numericLowerRows{
    NSArray *lowercase = @[@[@" "],
                           @[@".",@",",@"?",@"!",@"'"],
                           @[@"-",@"/",@":",@";",@"(",@")",@"$",@"&",@"@",@"\""],
                           @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]];
    return lowercase;
}
+ (NSArray *)numericUpperRows{
    NSArray *uppercase = @[@[@" "],
                           @[@".",@",",@"?",@"!",@"'"],
                           @[@"_",@"\\",@"|",@"~",@"<",@">",@"€",@"£",@"¥",@"•"],
                           @[@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"="]];
    return uppercase;
    
}
+ (NSArray *)numericKeyCodes{
    NSArray *keycodes = @[@[@49],
                          @[@6, @7, @8, @9, @11],
                          @[@0, @1, @2, @3, @5, @4, @38, @40, @37, @37],
                          @[@12, @13, @14, @15, @17, @16, @32, @34, @31, @35]];
    return keycodes;
}
@end
