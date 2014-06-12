//
//  RBMenuItem.m
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 3/28/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import "RBMenuItem.h"
#define CELLIDENTIFIER @"menubutton"
@interface RBMenuItem ()

//the menuButton
@property(strong, nonatomic)UIButton *menuButton;


@end

@implementation RBMenuItem


-(RBMenuItem *)initMenuItemWithTitle:(NSString *)title
               withCompletionHandler:(void (^)(BOOL))completion;
{
    
    self.title = title;
    self.completion = completion;
    return self;
    
}

@end
