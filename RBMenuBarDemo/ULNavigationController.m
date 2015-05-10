//
//  ULNavigationController.m
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 6/12/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import "ULNavigationController.h"
#import "RBMenu.h"
#import "ULFirstViewController.h"
#import "ULSecondViewController.h"

@interface ULNavigationController ()

@property(nonatomic, strong)RBMenu *menu;

@end

@implementation ULNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //creating the menu items
    ULFirstViewController *firstViewController = [storyboard instantiateViewControllerWithIdentifier:@"firstView"];
    [self setViewControllers:@[firstViewController] animated:NO];
   
    RBMenuItem *item = [[RBMenuItem alloc]initMenuItemWithTitle:@"First" withCompletionHandler:^(BOOL finished){
        
        ULFirstViewController *firstViewController = [storyboard instantiateViewControllerWithIdentifier:@"firstView"];
        [self setViewControllers:@[firstViewController] animated:NO];
        
    }];
    RBMenuItem *item2 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Second" withCompletionHandler:^(BOOL finished){
        
        ULSecondViewController *secondViewController = [storyboard instantiateViewControllerWithIdentifier:@"secondView"];
        [self setViewControllers:@[secondViewController] animated:NO];

        
        
    }];
    

	// Do any additional setup after loading the view, typically from a nib.
    _menu = [[RBMenu alloc] initWithItems:@[item, item2] textColor:[UIColor whiteColor] hightLightTextColor:[UIColor blackColor] backgroundColor:[UIColor redColor] andTextAlignment:RBMenuTextAlignmentLeft forViewController:self];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMenu{
    
    [_menu showMenu];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
