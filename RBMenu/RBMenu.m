//
//  RBMenu.m
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 3/28/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import "RBMenu.h"
#import <QuartzCore/QuartzCore.h>

#define CELLIDENTIFIER          @"menubutton"
#define MENU_BOUNCE_OFFSET      10
#define VELOCITY_TRESHOLD       1000
#define AUTOCLOSE_VELOCITY      1200

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
    self.isMenuClose = YES;
    return self;
    
}

-(RBMenuItem *)initMenuItemWithTitle:(NSString *)title withCompletionHandler:(void (^)(BOOL))completion withIsCloseMenu:(BOOL)isCloseMenu{
    self.title = title;
    self.completion = completion;
    self.isMenuClose = isCloseMenu;
    return self;
}

@end

@interface RBMenu ()


@property(nonatomic, strong)NSArray *menuItems;
@property(nonatomic, strong)UITableView *menuContentTable;
@property(nonatomic, weak)UIViewController *contentController;

@end

@implementation RBMenu

NSString *const MENU_ITEM_DEFAULT_FONTNAME    = @"HelveticaNeue-Light";
NSInteger const MENU_ITEM_DEFAULT_FONTSIZE    = 25;
NSInteger const STARTINDEX                    = 1;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.highLighedIndex = STARTINDEX;
        self.currentMenuState = RBMenuClosedState;
        self.titleFont = [UIFont fontWithName:MENU_ITEM_DEFAULT_FONTNAME size:MENU_ITEM_DEFAULT_FONTSIZE];
        self.height = 260;
    }
    return self;
}

#pragma mark initializers

-(RBMenu *)initWithItems:(NSArray *)menuItems
       andTextAllignment:(RBMenuAllignment)titleAllignment
       forViewController:(UIViewController *)viewController
{
    
    return [self initWithItems:menuItems
                     textColor:[UIColor grayColor]
           hightLightTextColor:[UIColor blackColor]
               backgroundColor:[UIColor whiteColor]
             andTextAllignment:titleAllignment
             forViewController:viewController];
}

-(RBMenu *)initWithItems:(NSArray *)menuItems
               textColor:(UIColor *)textColor
     hightLightTextColor:(UIColor *)hightLightTextColor
         backgroundColor:(UIColor *)backGroundColor
       andTextAllignment:(RBMenuAllignment)titleAllignment
       forViewController:(UIViewController *)viewController
{
    
    self = [[RBMenu alloc] init];
    self.isPangeStureenabel = YES;
    self.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), self.height);
    self.menuContentTable = [[UITableView alloc] initWithFrame:self.frame];
    self.menuItems = menuItems;
    self.titleAllignment = titleAllignment;
    self.textColor = textColor;
    self.highLightTextColor = hightLightTextColor;
    self.backgroundColor = backGroundColor;
    self.contentController = viewController;
    
    return self;
    
}

#pragma mark setter


-(void)setBackgroundColor:(UIColor *)backgroundColor{
    
    if(self.backgroundColor != backgroundColor){
        
        [self.menuContentTable setBackgroundColor:backgroundColor];
        
    }
    
}

-(void)setHeight:(CGFloat)height{
    
    if(_height != height){
        
        CGRect menuFrame = self.frame;
        menuFrame.size.height = height;
        _menuContentTable.frame = menuFrame;
        _height = height;
    }
    
    
}

-(void)setContentController:(UIViewController *)contentController{
    
    if(_contentController != contentController){
        
        if(contentController.navigationController)
            _contentController = contentController.navigationController;
        else
            _contentController = contentController;
        
        
        if(self.isPangeStureenabel)
            [_contentController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc]
                                                           initWithTarget:self action:@selector(didPan:)]];
        
        [self setShadowProperties];
        [_contentController.view setAutoresizingMask:UIViewAutoresizingNone];
        [[[[UIApplication sharedApplication] delegate] window] insertSubview:self atIndex:0];
        
    }
    
    
}

-(void)setMenuContentTable:(UITableView *)menuContentTable
{
    
    if(_menuContentTable != menuContentTable){
        
        [menuContentTable setDelegate:self];
        [menuContentTable setDataSource:self];
        [menuContentTable setShowsVerticalScrollIndicator:NO];
        [menuContentTable setSeparatorColor:[UIColor clearColor]];
        [menuContentTable setBackgroundColor:[UIColor whiteColor]];
        [menuContentTable setAllowsMultipleSelection:NO];
        _menuContentTable = menuContentTable;
        [self addSubview:_menuContentTable];
        
    }
    
}

-(void)setShadowProperties{
    
    [_contentController.view.layer setShadowOffset:CGSizeMake(0, 1)];
    [_contentController.view.layer setShadowRadius:4.0];
    [_contentController.view.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_contentController.view.layer setShadowOpacity:0.4];
    [_contentController.view.layer setShadowPath:[UIBezierPath
                                                  bezierPathWithRect:_contentController.view.bounds].CGPath];
    
}

#pragma mark menu interactions

-(void)showMenu{
    
    if(self.currentMenuState == RBMenuShownState || self.currentMenuState == RBMenuDisplayingState){
        if(self.currentMenuState == RBMenuShownState || self.currentMenuState == RBMenuDisplayingState)
            [self animateMenuClosingWithCompletion:nil];
        
    }
    else{
        
        self.currentMenuState = RBMenuDisplayingState;
        [self animateMenuOpening];
        
    }
    
}

-(void)dismissMenu{
    
    if(self.currentMenuState == RBMenuShownState || self.currentMenuState == RBMenuDisplayingState){
        
        _contentController.view.frame = CGRectOffset(_contentController.view.frame, 0,
                                                     - _height + MENU_BOUNCE_OFFSET);
        self.currentMenuState = RBMenuClosedState;
        
    }
    
}



-(void)didPan:(UIPanGestureRecognizer *)panRecognizer{
    
    __block CGPoint viewCenter = panRecognizer.view.center;
    
    if(panRecognizer.state == UIGestureRecognizerStateBegan || panRecognizer.state ==
       UIGestureRecognizerStateChanged){
        CGPoint translation = [panRecognizer translationInView:panRecognizer.view.superview];
        
        if(viewCenter.y >= [[UIScreen mainScreen] bounds].size.height / 2 &&
           viewCenter.y <= (([[UIScreen mainScreen] bounds].size.height / 2 + _height) - MENU_BOUNCE_OFFSET)){
            
            self.currentMenuState = RBMenuDisplayingState;
            viewCenter.y = ABS(viewCenter.y + translation.y);
            
            if(viewCenter.y >= [[UIScreen mainScreen] bounds].size.height / 2 &&
               viewCenter.y < [UIScreen mainScreen].bounds.size.height / 2 + _height - MENU_BOUNCE_OFFSET)
                _contentController.view.center = viewCenter;
            
            [panRecognizer setTranslation:CGPointZero inView:_contentController.view];
            
        }
        
    }
    else if(panRecognizer.state == UIGestureRecognizerStateEnded) {
        
        
        CGPoint velocity = [panRecognizer velocityInView:panRecognizer.view.superview];
        if(velocity.y > VELOCITY_TRESHOLD)
            [self openMenuFromCenterWithVelocity:velocity.y];
        else if(velocity.y < -VELOCITY_TRESHOLD)
            [self closeMenuFromCenterWithVelocity:ABS(velocity.y)];
        else if( viewCenter.y <  ([[UIScreen mainScreen] bounds].size.height / 2 + (_height / 2)))
            [self closeMenuFromCenterWithVelocity:AUTOCLOSE_VELOCITY];
        else if(viewCenter.y <= ([[UIScreen mainScreen] bounds].size.height / 2 + _height - MENU_BOUNCE_OFFSET))
            [self openMenuFromCenterWithVelocity:AUTOCLOSE_VELOCITY];
        
    }
    
}

#pragma mark animation and menu operations

-(void)animateMenuOpening{
    
    if(self.currentMenuState != RBMenuShownState){
        
        [UIView animateWithDuration:.2 animations:^{
            
            //pushing the content controller down
            _contentController.view.center = CGPointMake(_contentController.view.center.x,
                                                         [[UIScreen mainScreen] bounds].size.height / 2 + _height);
        }completion:^(BOOL finished){
            
            [UIView animateWithDuration:.2 animations:^{
                
                _contentController.view.center = CGPointMake(_contentController.view.center.x,
                                                             [[UIScreen mainScreen] bounds].size.height / 2 + _height - MENU_BOUNCE_OFFSET);
                
            }completion:^(BOOL finished){
                
                self.currentMenuState = RBMenuShownState;
                
            }];
            
        }];
        
    }
    
    
}

-(void)animateMenuClosingWithCompletion:(void (^)(BOOL))completion{
    [self animateMenuClosingWithCompletion:completion WithIsCloseMenu:YES];
}


-(void)animateMenuClosingWithCompletion:(void (^)(BOOL))completion WithIsCloseMenu:(BOOL)isCloseMenu{
    
    [UIView animateWithDuration:.2 animations:^{
        
        if (isCloseMenu) {
            //pulling the contentController up
            _contentController.view.center = CGPointMake(_contentController.view.center.x,
                                                         _contentController.view.center.y + MENU_BOUNCE_OFFSET);
        }
        
    }completion:^(BOOL finished){
        
        [UIView animateWithDuration:.2 animations:^{
            
            if (isCloseMenu) {
                //pushing the menu controller down
                _contentController.view.center = CGPointMake(_contentController.view.center.x,
                                                             [[UIScreen mainScreen] bounds].size.height / 2);
            }
            
        }completion:^(BOOL finished){
            
            if(finished){
                if (isCloseMenu) {
                    self.currentMenuState = RBMenuClosedState;
                }
                if(completion)
                    completion(finished);
                
            }
            
        }];
        
    }];
    
    
}

-(void)closeMenuFromCenterWithVelocity:(CGFloat)velocity{
    
    CGFloat viewCenterY = [[UIScreen mainScreen] bounds].size.height / 2;
    self.currentMenuState = RBMenuDisplayingState;
    [UIView animateWithDuration:((_contentController.view.center.y - viewCenterY) / velocity)  animations:^{
        
        _contentController.view.center = CGPointMake(_contentController.view.center.x,
                                                     [[UIScreen mainScreen] bounds].size.height / 2);
        
    }completion:^(BOOL completed){
        
        self.currentMenuState = RBMenuClosedState;
        
    }];
    
}

-(void)openMenuFromCenterWithVelocity:(CGFloat)velocity{
    
    
    CGFloat viewCenterY = [[UIScreen mainScreen] bounds].size.height / 2 + _height - MENU_BOUNCE_OFFSET;
    self.currentMenuState = RBMenuDisplayingState;
    [UIView animateWithDuration:((viewCenterY - _contentController.view.center.y) / velocity)  animations:^{
        
        _contentController.view.center = CGPointMake(_contentController.view.center.x, viewCenterY);
        
    }completion:^(BOOL completed){
        
        self.currentMenuState = RBMenuShownState;
        
    }];
    
}

#pragma mark UITableViewDelegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.menuItems count] + 2 * STARTINDEX;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *menuCell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER];
    RBMenuItem *menuItem;
    
    if(menuCell == nil)
    {
        menuCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLIDENTIFIER];
        [self setMenuTitleAlligmentForCell:menuCell];
        menuCell.backgroundColor = [UIColor clearColor];
        menuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        menuCell.textLabel.textColor = self.textColor;
        [menuCell.textLabel setFont:self.titleFont];
        
    }
  
    if(indexPath.row >= STARTINDEX && indexPath.row <= ([self.menuItems count] - 1 + STARTINDEX))
        menuItem = (RBMenuItem *)[self.menuItems objectAtIndex:indexPath.row - STARTINDEX];
            menuCell.textLabel.text =  menuItem.title;
    
    
    return menuCell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.highLighedIndex == indexPath.row){
        
        cell.textLabel.textColor = _highLightTextColor;
        [cell.textLabel setFont:[self.titleFont fontWithSize:self.titleFont.pointSize + 5]];
    }
    else{
        
        cell.textLabel.textColor = self.textColor;
        [cell.textLabel setFont:self.titleFont];
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.row < STARTINDEX || indexPath.row > [self.menuItems count] - 1 + STARTINDEX)
        return;
    
    self.highLighedIndex = indexPath.row;
    [self.menuContentTable reloadData];
    RBMenuItem *selectedItem = [self.menuItems objectAtIndex:indexPath.row - STARTINDEX];
    [self animateMenuClosingWithCompletion:selectedItem.completion WithIsCloseMenu:selectedItem.isMenuClose];
    
}

#pragma mark display modifications

-(void)setMenuTitleAlligmentForCell:(UITableViewCell *)cell{
    
    if (self.titleAllignment) {
        
        switch (self.titleAllignment) {
                
            case RBMenuTextAllignmentLeft:
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
            case RBMenuTextAlignmentCenter:
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
                break;
            case RBMenuTextAlignmentRight:
                cell.textLabel.textAlignment = NSTextAlignmentRight;
                break;
            default:
                break;
                
        }
        
    }
    
}

@end
