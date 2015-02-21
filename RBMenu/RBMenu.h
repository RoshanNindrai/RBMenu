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
    
    RBMenuTextAlignmentLeft,
    RBMenuTextAlignmentRight,
    RBMenuTextAlignmentCenter
    
}RBMenuAlignment;

@interface RBMenuItem : NSObject


//The title of the menu item
@property(nonatomic, strong)NSString *title;
//completion handler
@property(nonatomic, strong)void (^completion)(BOOL);

//initialization methods
-(RBMenuItem *)initMenuItemWithTitle:(NSString *)title withCompletionHandler:(void (^)(BOOL))completion;

@end

@interface RBMenu : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic)RBMenuState      currentMenuState;
@property(nonatomic)NSUInteger       highLighedIndex;
@property(nonatomic)CGFloat          height;
@property(nonatomic, strong)UIColor *textColor;
@property(nonatomic, strong)UIFont  *titleFont;
@property(nonatomic, strong)UIColor *highLightTextColor;
@property(nonatomic)RBMenuAlignment titleAlignment;

//create Menu with white background
-(RBMenu *)initWithItems:(NSArray *)menuItems andTextAlignment:(RBMenuAlignment)titleAlignment forViewController:(UIViewController *)viewController;

-(RBMenu *)initWithItems:(NSArray *)menuItems
               textColor:(UIColor *)textColor
     hightLightTextColor:(UIColor *)hightLightTextColor
         backgroundColor:(UIColor *)backGroundColor
       andTextAlignment:(RBMenuAlignment)titleAlignment
       forViewController:(UIViewController *)viewController;

-(void)showMenu;


@end
