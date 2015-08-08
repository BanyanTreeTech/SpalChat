//
//  QMLoginVerificationViewController.h
//  Q-municate
//
//  Created by bruno on 8/8/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMLoginVerificationViewController : UIViewController <UITextFieldDelegate> {
    
}

@property (nonatomic, weak) IBOutlet UIButton *nextButton;
@property (nonatomic, weak) IBOutlet UITextField *verificationText;

@end
