//
//  SWSoftKeyboardKey.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import "SWSoftKeyboardKeyCell.h"

@interface SWSoftKeyboardKeyCell ()
@property (nonatomic, assign) NSRect frame;
@end

@implementation SWSoftKeyboardKeyCell

- (id)initWithFrame:(NSRect)frame
        stateLabels:(NSDictionary *)stateLabels
        stateValues:(NSDictionary *)stateValues
            keyType:(SKKeyType)keyType
        controlType:(SKControlType)controlType
        keyDelegate:(id<SWKeyDelegate>)keyDelegate
{
    if (self = [super init]) {
        self.frame = frame;
        self.stateLabels = stateLabels;
        self.stateValues = stateValues;
        self.keyType = keyType;
        self.controlType = controlType;
        self.keyDelegate = keyDelegate;
        
        if ([self isSticky]) {
            [self setButtonType:NSPushOnPushOffButton];
        } else {
            [self setButtonType:NSMomentaryPushInButton];
        }
        
        [self setTarget:self];
        [self setAction:@selector(hit)];
    }
    return self;
}

#pragma mark - Private helpers

- (BOOL)isSticky
{
    return self.keyType == SKKeyTypeControl;
}

- (void)hit
{
    if (self.keyDelegate) {
        if ([self isSticky]) {
            self.isSelected = !self.isSelected;
            [self.keyDelegate softKeyboardKeyToggled:self];
        } else {
            [self.keyDelegate softKeyboardKeyPressed:self];
        }
    }
}

#pragma mark - Public methods

- (NSView *)labelForKeyboardState:(int)keyboardState
{
    NSDictionary *stickyStateLabels = [self.stateLabels objectForKey:[NSNumber numberWithBool:self.isSelected]];
    if (stickyStateLabels) {
        return [stickyStateLabels objectForKey:[NSNumber numberWithInt:keyboardState]];
    }
    return nil;
}
- (NSString *)valueForKeyboardState:(int)keyboardState
{
    NSDictionary *stickyStateValues = [self.stateValues objectForKey:[NSNumber numberWithBool:self.isSelected]];
    if (stickyStateValues) {
        return [stickyStateValues objectForKey:[NSNumber numberWithInt:keyboardState]];
    }
    return @"";
}

- (void)updateForKeyboardState:(int)keyboardState
{
    // TODO: update the cell's view according to the given keyboard state and the key's sitcky state
    
    
}
@end
