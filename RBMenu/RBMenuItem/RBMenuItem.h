//
//  RBMenuItem.h
//  RBMenuBarDemo
//
//  Created by Roshan Balaji on 3/28/14.
//  Copyright (c) 2014 Uniq Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBMenuItem : UICollectionViewCell

//The image of the menu button
@property(nonatomic, strong)UIImage* itemImage;
//The border color of the menu button
@property(nonatomic, strong)UIColor *borderColor;
//The title of the menu item
@property(nonatomic, strong)NSString *title;


//initialization methods

//initialize a menuitem with border clear

-(RBMenuItem *)initMenuItemWithTitle:(NSString *)title;

@end
