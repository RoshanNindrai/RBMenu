//
//  RBMenu.h
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 3/28/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBMenuItem.h"

typedef enum {
    
    RBMenuShownState,
    RBMenuClosedState,
    RBMenuDisplayingState
    
}RBMenuState;

typedef enum {
    
    RBMenuTextAllignmentLeft,
    RBMenuTextAlignmentRight,
    RBMenuTextAlignmentCenter
    
}RBMenuAllignment;

@class RBMenu;

@interface RBMenu : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic)RBMenuState currentMenuState;
@property(nonatomic, weak)UIViewController *delegate;
@property(nonatomic)NSUInteger highLighedIndex;
@property(nonatomic)CGFloat height;
@property(nonatomic, strong)UIColor *textColor;
@property(nonatomic, strong)UIColor *highLightTextColor;
@property(nonatomic)RBMenuAllignment titleAllignment;

//create Menu with white background
-(RBMenu *)initMenuWithItems:(NSArray *)menuItems WithTextAllignment:(RBMenuAllignment)titleAllignment;

-(RBMenu *)initMenuWithItems:(NSArray *)menuItems
               withTextColor:(UIColor *)textColor
         hightLightTextColor:(UIColor *)hightLightTextColor
             backGroundColor:(UIColor *)backGroundColor
           andTextAllignment:(RBMenuAllignment)titleAllignment;

-(void)showMenu;


@end