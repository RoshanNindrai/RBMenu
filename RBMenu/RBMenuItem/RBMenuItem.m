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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



-(RBMenuItem *)initMenuItemWithTitle:(NSString *)title
{

    self.title = title;
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



@end
