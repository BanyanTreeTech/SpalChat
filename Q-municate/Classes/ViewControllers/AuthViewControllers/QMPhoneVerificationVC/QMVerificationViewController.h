//
//  QMVerificationViewController.h
//  Q-municate
//
//  Created by bruno on 8/2/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMVerificationViewController : UIViewController <UITextFieldDelegate> {
    
    NSString *yourName;
    NSString *childName;
    
    NSString *schoolID;
    NSString *schoolName;
    
    NSString *gradeID;
    NSString *gradeName;
    
    NSString *classroomName;
    NSString *selFlag;
}

@property (nonatomic, weak) IBOutlet UIButton *nextButton;
@property (nonatomic, weak) IBOutlet UITextField *verificationText;

@end
