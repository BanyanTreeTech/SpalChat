//
//  QMLoginPhoneNumberViewController.h
//  Q-municate
//
//  Created by bruno on 8/8/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMLoginPhoneNumberViewController : UIViewController <UITextFieldDelegate> {
    
    NSMutableString *postCode;
}

@property (nonatomic, weak) IBOutlet UIButton *nextButton;
@property (nonatomic, weak) IBOutlet UITextField *phonenumberText;

@property (nonatomic, weak) IBOutlet UIView *line;

@end
