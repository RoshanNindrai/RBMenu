//
//  ULViewController.h
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 3/14/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBMenu.h"

@interface ULViewController : UIViewController<RBMenuDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;

- (IBAction)show:(id)sender;

@end
