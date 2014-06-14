//
//  RBMenu.h
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 3/28/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@interface RBMenuItem : NSObject


//The title of the menu item
@property(nonatomic, strong)NSString *title;
//completion handler
@property(nonatomic, strong)void (^completion)(BOOL);

//initialization methods
-(RBMenuItem *)initMenuItemWithTitle:(NSString *)title withCompletionHandler:(void (^)(BOOL))completion;

@end

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
