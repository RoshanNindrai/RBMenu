//
//  RBMenuItem.h
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 3/28/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBMenuItem : NSObject


//The title of the menu item
@property(nonatomic, strong)NSString *title;
//completion handler
@property(nonatomic, strong)void (^completion)(BOOL);

//initialization methods
-(RBMenuItem *)initMenuItemWithTitle:(NSString *)title withCompletionHandler:(void (^)(BOOL))completion;

@end
