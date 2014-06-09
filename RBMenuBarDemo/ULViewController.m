//
//  ULViewController.m
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 3/14/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import "ULViewController.h"



@interface ULViewController ()

@property(nonatomic, strong)RBMenu *menu;

@end

@implementation ULViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.table.center = self.view.center;
    //creating the menu items
    RBMenuItem *item = [[RBMenuItem alloc]initMenuItemWithTitle:@"Read"];
    RBMenuItem *item2 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Help"];
    RBMenuItem *item3 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Settings"];
      RBMenuItem *item4 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Sign out"];
	// Do any additional setup after loading the view, typically from a nib.
    _menu = [[RBMenu alloc] initMenuWithItems:@[item, item2, item3, item4] WithTextAllignment:RBMenuTextAllignmentLeft];
    _menu.delegate = self;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    
    [_menu showMenu];

}

-(void)topBar:(RBMenu *)menuBar selectedIndex:(NSUInteger)index{
    
    
    [self.menu dismissMenuAnimated:YES WithCompletionHandler:^(BOOL completed){
        
        NSLog(@"%d index pressed", index);
    }];
    
    
    
    
    
}
@end
