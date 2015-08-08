//
//  QMChatsViewController.h
//  Q-municate
//
//  Created by bruno on 8/2/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMChatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    
    int     chatroomID;
}

@property (nonatomic, weak) IBOutlet UIView *searchView;

@property (nonatomic, weak) IBOutlet UITextField*   searchKeyText;

@end
