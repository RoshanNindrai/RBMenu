RBMenu
======

A menu for iOS that was inspired by Medium iOS APP

Installation
======

The following controller can be added to yout project by copying the RBMenu folder along with RBMenuItems folder. Cocoapods support will be added in the future.

Usage
======

THe RBMenu consict of menu items that is denoted by RBMenuItems. Each item for now holds just a title. TO create a Menu item 

    #import "RBMenu.h"
        
create each menu item by creating an object of RBMenuItems class For this demo porject the menu items were created by the follwing snippet

    RBMenuItem *item = [[RBMenuItem alloc]initMenuItemWithTitle:@"Read"];
    RBMenuItem *item2 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Help"];
    RBMenuItem *item3 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Settings"];
    RBMenuItem *item4 = [[RBMenuItem alloc]initMenuItemWithTitle:@"Sign out"];
    
Once the item are created it is neccesary to add to items to the RBMenu. The RBMenu class uses the delegation design pattern where in it informs the delegate UIViewController with selection operations.
to support this delegation the UIViewController must confirm to RBMenuDelegate. Once the protocol is added the RBMenu can be created by the following line.

     _menu = [[RBMenu alloc] initMenuWithItems:@[item, item2, item3, item4] WithTextAllignment:RBMenuTextAllignmentLeft];
    _menu.delegate = self;
    
In the above code, the RBMenuItems are added to the menu and the allignment of the title along the menu is also mentioned while menu creation. Custom menu with user defined properties to the Menu can be performed by using the following method.

            -(RBMenu *)initMenuWithItems:(NSArray *)menuItems
               withTextColor:(UIColor *)textColor
          hightLightTextColor:(UIColor *)hightLightTextColor
          BackGroundColor:(UIColor *)backGroundColor
          WithTextAllignment:(RBMenuAllignment)titleAllignment
          

At present RBMenu supports three menu title allignments 

    RBMenuTextAllignmentLeft
    RBMenuTextAlignmentRight
    RBMenuTextAlignmentCenter

The added demo project would give you additional information. 
    


TODO
======

1. Add Images to Menu
2. Comment the code :(
3. Add landscape support
