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

@protocol RBMenuDelegate <NSObject>

@required
-(void)topBar:(RBMenu *)menuBar selectedIndex:(NSUInteger)index;

@end


@interface RBMenu : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic)RBMenuState currentMenuState;
@property(nonatomic, weak)UIViewController<RBMenuDelegate> *delegate;
@property(nonatomic)NSUInteger highLighedIndexPath;

//create Menu with white background
-(RBMenu *)initMenuWithItems:(NSArray *)menuItems WithTextAllignment:(RBMenuAllignment)titleAllignment;

-(RBMenu *)initMenuWithItems:(NSArray *)menuItems
               withTextColor:(UIColor *)textColor
          hightLightTextColor:(UIColor *)hightLightTextColor
          andBackGroundColor:(UIColor *)backGroundColor
          WithTextAllignment:(RBMenuAllignment)titleAllignment;

-(void)showMenu;

-(void)dismissMenuAnimated:(BOOL)animated WithCompletionHandler:(void(^)(BOOL))completion;

@end
