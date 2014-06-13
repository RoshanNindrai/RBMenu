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
#define MENU_HEIGHT             260
#define MENU_BOUNCE_OFFSET      10
#define PANGESTUREENABLE        1
#define VELOCITY_TRESHOLD       1000
#define AUTOCLOSE_VELOCITY      1200

@interface RBMenu ()


@property(nonatomic, strong)NSArray *menuItems;
@property(nonatomic, strong)UITableView *menuContentTable;


@end

@implementation RBMenu

NSString *const MENUITEM_FONT_NAME   = @"HelveticaNeue-Light";
NSInteger const MENU_ITEM_FONTSIZE    = 25;
NSInteger const STARTINDEX            = 1;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.highLighedIndex = STARTINDEX;
    }
    return self;
}

-(RBMenu *)initMenuWithItems:(NSArray *)menuItems WithTextAllignment:(RBMenuAllignment)titleAllignment
{
    
    return [self initMenuWithItems:menuItems
                     withTextColor:[UIColor grayColor]
               hightLightTextColor:[UIColor blackColor]
                   backGroundColor:[UIColor whiteColor]
                 andTextAllignment:titleAllignment];
}

-(RBMenu *)initMenuWithItems:(NSArray *)menuItems
               withTextColor:(UIColor *)textColor
         hightLightTextColor:(UIColor *)hightLightTextColor
             backGroundColor:(UIColor *)backGroundColor
           andTextAllignment:(RBMenuAllignment)titleAllignment
{
    
    self = [[RBMenu alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), MENU_HEIGHT)];
    self.menuItems = menuItems;
    self.menuTitleAllignment = titleAllignment;
    self.menuContentTable = [[UITableView alloc] initWithFrame:self.frame];
    self.textColor = textColor;
    self.highLightTextColor = hightLightTextColor;
    self.backgroundColor = backGroundColor;
    self.currentMenuState = RBMenuClosedState;
    return self;
    
}

#pragma mark setter


-(void)setBackgroundColor:(UIColor *)backgroundColor{
    
    if(self.backgroundColor != backgroundColor){
        
        [self.menuContentTable setBackgroundColor:backgroundColor];
        
    }
    
}

-(void)setDelegate:(UIViewController *)delegate{
    
    if(_delegate != delegate){
        
        if(delegate.navigationController)
            _delegate = delegate.navigationController;
        else
            _delegate = delegate;
        
        
        if(PANGESTUREENABLE)
            [_delegate.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)]];
        
        [self setShadowProperties];
        [_delegate.view setAutoresizingMask:UIViewAutoresizingNone];
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
    
    [_delegate.view.layer setShadowOffset:CGSizeMake(0, 1)];
    [_delegate.view.layer setShadowRadius:4.0];
    [_delegate.view.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [_delegate.view.layer setShadowOpacity:0.4];
    [_delegate.view.layer setShadowPath:[UIBezierPath bezierPathWithRect:_delegate.view.bounds].CGPath];
    
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
        
        self.delegate.view.frame = CGRectOffset(self.delegate.view.frame, 0, - MENU_HEIGHT + MENU_BOUNCE_OFFSET);
        self.currentMenuState = RBMenuClosedState;
        
    }
    
}



-(void)didPan:(UIPanGestureRecognizer *)panRecognizer{
    
    __block CGPoint viewCenter = panRecognizer.view.center;
    
    if(panRecognizer.state == UIGestureRecognizerStateBegan || panRecognizer.state ==
       UIGestureRecognizerStateChanged){
        CGPoint translation = [panRecognizer translationInView:panRecognizer.view.superview];
        
        if(viewCenter.y >= [[UIScreen mainScreen] bounds].size.height / 2 && viewCenter.y <= (([[UIScreen mainScreen] bounds].size.height / 2 + MENU_HEIGHT) - MENU_BOUNCE_OFFSET)){
            
            self.currentMenuState = RBMenuDisplayingState;
            viewCenter.y = ABS(viewCenter.y + translation.y);
            if(viewCenter.y >= [[UIScreen mainScreen] bounds].size.height / 2 && viewCenter.y < [UIScreen mainScreen].bounds.size.height / 2 + MENU_HEIGHT - MENU_BOUNCE_OFFSET )
                self.delegate.view.center = viewCenter;
            
            [panRecognizer setTranslation:CGPointZero inView:self.delegate.view];
            
        }
        
    }
    else if(panRecognizer.state == UIGestureRecognizerStateEnded) {
        
        
        CGPoint velocity = [panRecognizer velocityInView:panRecognizer.view.superview];
        if(velocity.y > VELOCITY_TRESHOLD)
            [self openMenuFromCenterWithVelocity:velocity.y];
        else if(velocity.y < -VELOCITY_TRESHOLD)
            [self closeMenuFromCenterWithVelocity:ABS(velocity.y)];
        else if( viewCenter.y <  ([[UIScreen mainScreen] bounds].size.height / 2 + (MENU_HEIGHT / 2)))
            [self closeMenuFromCenterWithVelocity:AUTOCLOSE_VELOCITY];
        else if(viewCenter.y <= ([[UIScreen mainScreen] bounds].size.height / 2 + MENU_HEIGHT - MENU_BOUNCE_OFFSET))
            [self openMenuFromCenterWithVelocity:AUTOCLOSE_VELOCITY];
        
    }
    
}

#pragma mark animation

-(void)animateMenuOpening{
    
    if(self.currentMenuState != RBMenuShownState){
        
        [UIView animateWithDuration:.2 animations:^{
            
            //pushing the content controller down
            self.delegate.view.center = CGPointMake(self.delegate.view.center.x, [[UIScreen mainScreen] bounds].size.height / 2 + MENU_HEIGHT);
        }completion:^(BOOL finished){
            
            [UIView animateWithDuration:.2 animations:^{
                
                self.delegate.view.center = CGPointMake(self.delegate.view.center.x, [[UIScreen mainScreen] bounds].size.height / 2 + MENU_HEIGHT - MENU_BOUNCE_OFFSET);
                
            }completion:^(BOOL finished){
                
                self.currentMenuState = RBMenuShownState;
                
            }];
            
        }];
        
    }
    
    
}



-(void)animateMenuClosingWithCompletion:(void (^)(BOOL))completion{
    
    [UIView animateWithDuration:.2 animations:^{
        
        //pulling the contentController up
        self.delegate.view.center = CGPointMake(self.delegate.view.center.x, self.delegate.view.center.y + MENU_BOUNCE_OFFSET);
        
        
    }completion:^(BOOL finished){
        
        [UIView animateWithDuration:.2 animations:^{
            
            //pushing the menu controller down
            self.delegate.view.center = CGPointMake(self.delegate.view.center.x, [[UIScreen mainScreen] bounds].size.height / 2);
            
        }completion:^(BOOL finished){
            
            if(finished){
                self.currentMenuState = RBMenuClosedState;
                if(completion)
                    completion(finished);
            }
            
        }];
        
    }];
    
    
}

-(void)closeMenuFromCenterWithVelocity:(CGFloat)velocity{
    
    CGFloat viewCenterY = [[UIScreen mainScreen] bounds].size.height / 2;
    self.currentMenuState = RBMenuDisplayingState;
    [UIView animateWithDuration:((self.delegate.view.center.y - viewCenterY) / velocity)  animations:^{
        
        self.delegate.view.center = CGPointMake(self.delegate.view.center.x, [[UIScreen mainScreen] bounds].size.height / 2);
        
    }completion:^(BOOL completed){
        
        self.currentMenuState = RBMenuClosedState;
        
    }];
    
}

-(void)openMenuFromCenterWithVelocity:(CGFloat)velocity{
    
    
    CGFloat viewCenterY = [[UIScreen mainScreen] bounds].size.height / 2 + MENU_HEIGHT - MENU_BOUNCE_OFFSET;
    self.currentMenuState = RBMenuDisplayingState;
    [UIView animateWithDuration:((viewCenterY - self.delegate.view.center.y) / velocity)  animations:^{
        
        self.delegate.view.center = CGPointMake(self.delegate.view.center.x, viewCenterY);
        
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
        menuCell.textLabel.font = [UIFont fontWithName:MENUITEM_FONT_NAME size:MENU_ITEM_FONTSIZE];
        
    }
    if(self.highLighedIndex == indexPath.row){
        
        menuCell.textLabel.textColor = _highLightTextColor;
        menuCell.textLabel.font = [UIFont fontWithName:MENUITEM_FONT_NAME size:MENU_ITEM_FONTSIZE + 5];
        
    }
    else{
        
        menuCell.textLabel.textColor = self.textColor;
        menuCell.textLabel.font = [UIFont fontWithName:MENUITEM_FONT_NAME size:MENU_ITEM_FONTSIZE];
        
    }
    
    if(indexPath.row >= STARTINDEX && indexPath.row <= ([self.menuItems count] - 1 + STARTINDEX))
        menuItem = (RBMenuItem *)[self.menuItems objectAtIndex:indexPath.row - STARTINDEX];
    menuCell.textLabel.text =  menuItem.title;
    return menuCell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.row < STARTINDEX || indexPath.row > [self.menuItems count] - 1 + STARTINDEX)
        return;
    
    
    self.highLighedIndex = indexPath.row;
    
    [self.menuContentTable reloadData];
    
    RBMenuItem *selectedItem = [self.menuItems objectAtIndex:indexPath.row - STARTINDEX];
    
    [self animateMenuClosingWithCompletion:selectedItem.completion];
    
}

#pragma mark display modifications

-(void)setMenuTitleAlligmentForCell:(UITableViewCell *)cell{
    
    if (self.menuTitleAllignment) {
        
        switch (self.menuTitleAllignment) {
                
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
