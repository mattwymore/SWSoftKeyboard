//
//  SWSoftKeyboardEmailAddressLayout.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import "SWSoftKeyboardEmailAddressLayout.h"

@implementation SWSoftKeyboardEmailAddressLayout
- (NSArray *)keysForState:(int)layoutState
{
    // this layout actually doesn't care about layout state
    
    NSMutableArray *keysArray = [NSMutableArray new];
    
    NSArray *alphabetKeys = [self commonAlphabetKeys];
    NSArray *numberKeys = [self simpleKeysFromKeyboardShiftUpCharacters:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]
                                            keyboardShiftDownCharacters:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]];
    NSArray *punctuationLetters = @[@"@",@"-",@"_",@".",@"+"];
    NSArray *punctuationKeys = [self simpleKeysFromKeyboardShiftUpCharacters:punctuationLetters
                                                 keyboardShiftDownCharacters:punctuationLetters];
    NSArray *controlKeys = [self controlKeysWithFn:NO control:NO alt:NO shift:YES command:NO done:YES backspace:NO];
    // TODO: update frame data for all keys
    return keysArray;
}
- (int)layoutStates
{
    return 2; // shift up, shift down
}
@end