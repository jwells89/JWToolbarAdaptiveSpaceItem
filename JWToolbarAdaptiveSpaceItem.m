//
//  JWToolbarAdaptiveSpaceItem.m
//
//  Created by John Wells on 7/14/13.
//  Copyright (c) 2013 John Wells. All rights reserved.
//

#import "JWToolbarAdaptiveSpaceItem.h"

@implementation JWToolbarAdaptiveSpaceItem

-(void)dealloc
{
    // Clean up our key-value observer
    [self.linkedView removeObserver:self forKeyPath:@"frame"];
}

-(void)setLinkedView:(NSView *)linkedView
{
    /*
     Start observing the linked view's frame as soon its
     IBOutlet is assigned
    */
    _linkedView = linkedView;
    
    [self.linkedView addObserver:self forKeyPath:@"frame" options:0 context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    /*
     Update the toolbar item's width whenever a change to the
     linked view's frame is observed
    */
    if ([keyPath isEqualToString:@"frame"] && object == self.linkedView)
    {
        [self updateWidth];
    }
}

- (void)updateWidth
{
    if (self.linkedView)
    {
        /*
         Resizes the adaptive toolbar item and makes sure that we don't
         make the toolbar do funky things when the linked view collapses
         */
        if (self.linkedView.frame.size.width-16 > -8)
        {
            [self setMinSize:NSMakeSize(self.linkedView.frame.size.width-16, 0)];
            [self setMaxSize:NSMakeSize(self.linkedView.frame.size.width-16, 0)];
        } else {
            [self setMinSize:NSMakeSize(-8, 0)];
            [self setMaxSize:NSMakeSize(-8, 0)];
        }
    }
}

#pragma mark - NSToolbarItem Methods

-(NSView *)view
{
    /*
     Set the toolbar item's content to a view that ignores
     clicks so the user can drag the window by the portion
     of the toolbar covered by the adaptive toolbar item
     */
    return [[JWClickThroughView alloc] init];;
}

-(NSString *)label
{
    return @"";
}

-(NSString *)paletteLabel
{
    return @"Adaptive Space Item";
}

-(NSSize)minSize
{
    if (self.linkedView)
    {
        if (self.linkedView.frame.size.width-16 > -8)
        {
            return NSMakeSize(self.linkedView.frame.size.width-16, 0);
        } else {
            return NSMakeSize(-8, 0);
        }
    }
    
    return [super minSize];
}

-(NSSize)maxSize
{
    if (self.linkedView)
    {
        if (self.linkedView.frame.size.width-16 > -8)
        {
            return NSMakeSize(self.linkedView.frame.size.width-16, 0);
        } else {
            return NSMakeSize(-8, 0);
        }
    }
    
    return [super maxSize];
}

@end

@implementation JWClickThroughView

// A super-simple NSView that ignores clicks

-(BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
    return NO;
}

@end