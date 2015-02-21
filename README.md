RBMenu
======

A menu for iOS that was inspired by [Medium iOS App](https://itunes.apple.com/us/app/medium/id828256236)

![Output gif](https://raw.githubusercontent.com/RoshanNindrai/RBMenu/master/Screen%20Shot/RBMenuDemo.gif)
![Output gif2](https://raw.githubusercontent.com/RoshanNindrai/RBMenu/master/Screen%20Shot/RBMenuDemo_custom_black.gif)


Installation
======

The preferred method of installation is with CocoaPods. Add this line to the podfile

    pod 'RBMenu',  '~>0.2.4'
    
If you want to install manually, copy the RBMenu .h and .m file to the project director.

Usage
======

THe RBMenu consict of menu items that is denoted by RBMenuItems. Each item for now holds a title and a completion handler. To create a Menu item 

    #import "RBMenu.h"
        
create each menu item by creating an object of RBMenuItems class For this demo project the menu items were created by the following snippet. Each element have a completionHandler that gets executed when the user clicks the option.

    RBMenuItem *item = [[RBMenuItem alloc]initMenuItemWithTitle:@"First" withCompletionHandler:^(BOOL finished){
        
       NSLog(@"First selected");
        
    }];
    RBMenuItem *item2 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Second" withCompletionHandler:^(BOOL finished){
        
        NSLog(@"Second selected");
        
    }];

    
Once the item are created it is neccesary to add the items to the RBMenu. The delegate needs to be a subclass of UIViewController

     _menu = [[RBMenu alloc] initWithItems:@[item, item2] andTextAlignment:RBMenuTextAlignmentLeft forViewController:self];
In the above code, the RBMenuItems are added to the menu and the allignment of the title along the menu is also mentioned while menu creation. Custom menu with user defined properties to the Menu can be performed by using the following method.

    -(RBMenu *)initWithItems:(NSArray *)menuItems
               textColor:(UIColor *)textColor
     hightLightTextColor:(UIColor *)hightLightTextColor
         backgroundColor:(UIColor *)backGroundColor
       andTextAlignment:(RBMenuAlignment)titleAlignment
       forViewController:(UIViewController *)viewController

At present RBMenu supports three menu title alignments 

    RBMenuTextAlignmentLeft
    RBMenuTextAlignmentRight
    RBMenuTextAlignmentCenter

The added demo project would give you additional information. 

Customization
======

These properties of the menu can be customized

    @property(nonatomic)CGFloat          height;
    @property(nonatomic, strong)UIColor *textColor;
    @property(nonatomic, strong)UIFont  *titleFont;
    @property(nonatomic, strong)UIColor *highLightTextColor;
    @property(nonatomic)RBMenuAlignment titleAlignment;

    

Screenshot
======

![screenshot](https://raw.githubusercontent.com/RoshanNindrai/RBMenu/master/Screen%20Shot/Screen_Shot.png)



TODO
======

1. Add Images to Menu
2. Comment the code :(
3. ~~Add landscape support~~

LICENSE:
============
  RBMenu is available under The MIT License (MIT)

Copyright (c) 2014 Roshan Balaji

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


