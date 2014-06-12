//
//  ULViewController.m
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 3/14/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import "ULRootViewController.h"



@interface ULRootViewController ()



@end

@implementation ULRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(showMenu)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
