//
//  SWSoftKeyboard.m
//  SWSoftKeyboard
//
//  Created by Spencer Williams on 9/4/14.
//  This is free and unencumbered software released into the public domain.
//

#import "SWSoftKeyboard.h"
#import "SWSoftKeyboardLayout.h"
#import "SWSoftKeyboardKeyCell.h"

@implementation SWSoftKeyboard

- (id)initWithFrame:(NSRect)frameRect
{
    if (self = [super initWithFrame:frameRect]) {
        [self commonInit];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self commonInit];
    }
    return self;
}
- (id)initWithFrame:(NSRect)frameRect mode:(NSMatrixMode)aMode cellClass:(Class)factoryId numberOfRows:(NSInteger)rowsHigh numberOfColumns:(NSInteger)colsWide
{
    if (self = [super initWithFrame:frameRect mode:aMode cellClass:factoryId numberOfRows:rowsHigh numberOfColumns:colsWide]) {
        [self commonInit];
    }
    return self;
}
- (id)initWithFrame:(NSRect)frameRect mode:(NSMatrixMode)aMode prototype:(NSCell *)aCell numberOfRows:(NSInteger)rowsHigh numberOfColumns:(NSInteger)colsWide
{
    if (self = [super initWithFrame:frameRect mode:aMode prototype:aCell numberOfRows:rowsHigh numberOfColumns:colsWide]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithLayout:(SWSoftKeyboardLayout *)keyboardLayout
{
    if (self = [super init]) {
        self.keyboardLayout = keyboardLayout;
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    // TODO: custom nsmatrix overriding
//    [self setPrototype:<#(id)#>
}

- (void)setKeyboardLayout:(SWSoftKeyboardLayout *)keyboardLayout
{
    _keyboardLayout = keyboardLayout;
    [self.keyboardLayout setKeyDelegate:self];
    self.layoutState = 0; // triggers needsDisplay, so we don't need to do that here explicitly
}

- (void)setLayoutState:(int)layoutState
{
    _layoutState = layoutState;
    [self setKeys:[self.keyboardLayout keysForState:layoutState]];
    self.needsDisplay = YES;
}

- (void)setKeys:(NSArray *)keys
{
    _keys = keys;
    for (SWSoftKeyboardKeyCell *key in self.keys) {
        [key updateForKeyboardState:self.layoutState];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
