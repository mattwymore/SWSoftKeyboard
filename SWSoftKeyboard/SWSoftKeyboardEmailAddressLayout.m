//
//  SWSoftKeyboardEmailAddressLayout.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import "SWSoftKeyboardEmailAddressLayout.h"
#import "SWSoftKeyboardLayoutHelper.h"
#import "SWSoftKeyboardKeyCell.h"

@interface SWSoftKeyboardEmailAddressLayout ()
@property (nonatomic, strong) NSArray *lowerCaseValues;
@property (nonatomic, strong) NSArray *upperCaseValues;
@end

@implementation SWSoftKeyboardEmailAddressLayout

- (NSArray *)keysForState:(int)layoutState
{
    NSArray *keys = [self.keysForStates objectForKey:[NSNumber numberWithInt:layoutState]];
    if (keys != nil) {
        return keys;
    }
    
    NSMutableArray *keysArray = [NSMutableArray new];
    
    //need to switch these based on state:
    switch (layoutState) {
        case 0:{
            self.upperCaseValues = [SWSoftKeyboardLayoutHelper qwertyUpperRows];
            self.lowerCaseValues = [SWSoftKeyboardLayoutHelper qwertyLowerRows];
            self.keyCodeValues = [SWSoftKeyboardLayoutHelper qwertyKeyCodes];
            
            for (NSInteger row = 0; row < self.numberOfRows; row++) {
                for (NSInteger position = 0; position < self.maxKeysInRow; position++) {
                    SWSoftKeyboardKeyCell* key = [self keyInRow:row atPosition:position];
                    if (key) {
                        [keysArray addObject:key];
                    }
                }
            }
            
            //now add task/modifier keys
            //flip to numeric keyboard
            NSDictionary *stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"123",[NSNumber numberWithBool:NO],
                           @"123",[NSNumber numberWithBool:YES],nil];
            //lame, but for now this is hard coded.
            NSInteger xPos = self.padding;
            NSInteger yPos = self.padding;
            NSInteger width = self.defaultKeyWidth;
            NSInteger height = self.defaultKeyHeight;
            SWSoftKeyboardKeyCell *key = [[SWSoftKeyboardKeyCell alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)
                                                   stateLabels:stateLabels
                                                   stateValues:nil
                                                       keyCode:nil
                                                       keyType:SKKeyTypeLayout
                                                   controlType:SKControlTypeNumeric
                                                   keyDelegate:nil];
            
            [keysArray addObject:key];
            
            //shift key:
            stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"shift",[NSNumber numberWithBool:NO],
                           @"shift",[NSNumber numberWithBool:YES],nil];
            //lame, but for now this is hard coded.
            xPos = self.padding;
            yPos = self.padding + (1 * self.defaultKeyHeight) + (1*self.gutter);
            width = self.defaultKeyWidth * 1.5;
            height = self.defaultKeyHeight;
            //xPos += ((3 * self.defaultKeyWidth) + (2*self.gutter)) / 2;
            key = [[SWSoftKeyboardKeyCell alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)
                                                   stateLabels:stateLabels
                                                   stateValues:nil
                                                       keyCode:@56
                                                       keyType:SKKeyTypeControl
                                                   controlType:SKControlTypeShift
                                                   keyDelegate:nil];
            [keysArray addObject:key];
            
            
            
            break;
        }
        case 1:{
            self.upperCaseValues = [SWSoftKeyboardLayoutHelper numericUpperRows];
            self.lowerCaseValues = [SWSoftKeyboardLayoutHelper numericLowerRows];
            self.keyCodeValues = [SWSoftKeyboardLayoutHelper numericKeyCodes];
            
            for (NSInteger row = 0; row < self.numberOfRows; row++) {
                for (NSInteger position = 0; position < self.maxKeysInRow; position++) {
                    SWSoftKeyboardKeyCell* key = [self keyInRow:row atPosition:position];
                    if (key) {
                        [keysArray addObject:key];
                    }
                }
            }
            
            //now ad task/modifier keys
            //flip to numeric keyboard
            NSDictionary *stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                                         @"ABC",[NSNumber numberWithBool:NO],
                                         @"ABC",[NSNumber numberWithBool:YES],nil];
            //lame, but for now this is hard coded.
            NSInteger xPos = self.padding;
            NSInteger yPos = self.padding;
            NSInteger width = self.defaultKeyWidth;
            NSInteger height = self.defaultKeyHeight;
            SWSoftKeyboardKeyCell *key = [[SWSoftKeyboardKeyCell alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)
                                                                          stateLabels:stateLabels
                                                                          stateValues:nil
                                                                              keyCode:nil
                                                                              keyType:SKKeyTypeLayout
                                                                          controlType:SKControlTypeAlpha
                                                                          keyDelegate:nil];
            [keysArray addObject:key];
            
            //shift key:
            stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"#+=",[NSNumber numberWithBool:NO],
                           @"123",[NSNumber numberWithBool:YES],nil];
            //lame, but for now this is hard coded.
            xPos = self.padding;
            yPos = self.padding + (1 * self.defaultKeyHeight) + (1*self.gutter);
            width = self.defaultKeyWidth * 1.5;
            height = self.defaultKeyHeight;
            //xPos += ((3 * self.defaultKeyWidth) + (2*self.gutter)) / 2;
            key = [[SWSoftKeyboardKeyCell alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)
                                                   stateLabels:stateLabels
                                                   stateValues:nil
                                                       keyCode:@56
                                                       keyType:SKKeyTypeControl
                                                   controlType:SKControlTypeShift
                                                   keyDelegate:nil];
            [keysArray addObject:key];
            
            
            break;
        }
        default:
            break;
    }
    
    //add common keys
    //delete key:
    NSString *str = [NSString stringWithFormat: @"%C", 127];
    NSDictionary *stateValues = [NSDictionary dictionaryWithObjectsAndKeys:
                                 str,[NSNumber numberWithBool:NO],
                                 str,[NSNumber numberWithBool:YES],nil];
    NSDictionary *stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"Delete",[NSNumber numberWithBool:NO],
                                 @"Delete",[NSNumber numberWithBool:YES],nil];
    //lame, but for now this is hard coded.
    NSInteger xPos = self.padding + (7 * self.defaultKeyWidth) + (7*self.gutter);
    NSInteger yPos = self.padding + (1 * self.defaultKeyHeight) + (1*self.gutter);
    NSInteger width = self.defaultKeyWidth * 1.5;
    NSInteger height = self.defaultKeyHeight;
    xPos += ((3 * self.defaultKeyWidth) + (2*self.gutter)) / 2;
    SWSoftKeyboardKeyCell *key = [[SWSoftKeyboardKeyCell alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)
                                                                  stateLabels:stateLabels
                                                                  stateValues:stateValues
                                                                      keyCode:@51
                                                                      keyType:SKKeyTypeContent
                                                                  controlType:SKControlTypeBackspace
                                                                  keyDelegate:nil];
    [keysArray addObject:key];
    
    
    
    //DONE key:
    stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                   @"DONE!",[NSNumber numberWithBool:NO],
                   @"DONE!",[NSNumber numberWithBool:YES],nil];
    //lame, but for now this is hard coded.
    xPos = self.padding + (7 * self.defaultKeyWidth) + (7*self.gutter);
    yPos = self.padding;
    width = self.defaultKeyWidth * 1.5;
    height = self.defaultKeyHeight;
    xPos += ((3 * self.defaultKeyWidth) + (2*self.gutter)) / 2;
    CGFloat donePos = xPos;

    key = [[SWSoftKeyboardKeyCell alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)
                                           stateLabels:stateLabels
                                           stateValues:nil
                                               keyCode:@56
                                               keyType:SKKeyTypeControl
                                           controlType:SKControlTypeDone
                                           keyDelegate:nil];
    [keysArray addObject:key];
    
    
    // add @ and .com buttons
    stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                   @"@", [NSNumber numberWithBool:NO],
                   @"@", [NSNumber numberWithBool:YES], nil];
    stateValues = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"@", [NSNumber numberWithBool:NO],
                                 @"@", [NSNumber numberWithBool:YES], nil];
    xPos = self.padding + self.defaultKeyWidth + self.gutter;
    yPos = self.padding;
    width = self.defaultKeyWidth;
    height = self.defaultKeyHeight;
    key = [[SWSoftKeyboardKeyCell alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)
                                           stateLabels:stateLabels
                                           stateValues:stateValues
                                               keyCode:nil keyType:SKKeyTypeContent controlType:SKControlTypeNone keyDelegate:nil];
    [keysArray addObject:key];
    stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                   @".com", [NSNumber numberWithBool:NO],
                   @".com", [NSNumber numberWithBool:YES], nil];
    stateValues = [NSDictionary dictionaryWithObjectsAndKeys:
                   @".com", [NSNumber numberWithBool:NO],
                   @".com", [NSNumber numberWithBool:YES], nil];
    xPos = donePos - self.defaultKeyWidth - self.gutter;
    key = [[SWSoftKeyboardKeyCell alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)
                                           stateLabels:stateLabels
                                           stateValues:stateValues
                                               keyCode:nil keyType:SKKeyTypeContent controlType:SKControlTypeNone keyDelegate:nil];
    [keysArray addObject:key];
    
    [self.keysForStates setObject:keysArray forKey:[NSNumber numberWithInt:layoutState]];
    
    return keysArray;
}

- (SWSoftKeyboardKeyCell*)keyInRow:(NSInteger)row atPosition:(NSInteger)position{
    NSInteger numberOfKeysInRow = [self.lowerCaseValues[row] count];
    NSInteger xPos = self.padding + (position * self.defaultKeyWidth) + (position*self.gutter);
    NSInteger yPos = self.padding + (row * self.defaultKeyHeight) + (row*self.gutter);
    NSInteger width = self.defaultKeyWidth;
    NSInteger height = self.defaultKeyHeight;
    
    //test bounds
    if (row > self.lowerCaseValues.count - 1) {
        return nil;
    }
    if (position > [self.lowerCaseValues[row] count] - 1) {
        return nil;
    }
    NSDictionary *stateValues = nil;
    NSDictionary *stateLabels = nil;
    if([self.lowerCaseValues[row][position] isEqualToString:@" "]){
        stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"space",[NSNumber numberWithBool:NO],
                                     @"space",[NSNumber numberWithBool:YES],nil];
        stateValues = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @" ",[NSNumber numberWithBool:NO],
                                     @" ",[NSNumber numberWithBool:YES],nil];
        width = (self.defaultKeyWidth * 5.5) + (self.gutter * 4);
        //hard coded xPos
        xPos+= (2*self.defaultKeyWidth) + (2*self.gutter);
    }else{
        stateLabels = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.lowerCaseValues[row][position],[NSNumber numberWithBool:NO],
                                 self.upperCaseValues[row][position],[NSNumber numberWithBool:YES],nil];
        stateValues = stateLabels;
        NSInteger missingKeys = self.maxKeysInRow - numberOfKeysInRow;
        if (missingKeys > 0) {
            xPos += ((missingKeys * self.defaultKeyWidth) + ((missingKeys - 1)*self.gutter)) / 2;
        }
    }
    NSNumber *keyCode = self.keyCodeValues[row][position];
    SWSoftKeyboardKeyCell *key = [[SWSoftKeyboardKeyCell alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)
                                                                  stateLabels:stateLabels
                                                                  stateValues:stateValues
                                                                      keyCode:keyCode
                                                                      keyType:SKKeyTypeContent
                                                                  controlType:SKControlTypeNone
                                                                  keyDelegate:nil];
    return key;
}

- (int)layoutStates {
    return 2; // shift up, shift down
}
@end
