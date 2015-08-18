//
//  QMVerificationViewController.h
//  Q-municate
//
//  Created by bruno on 8/2/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface childInfo2 : NSObject

@property (nonatomic, copy) NSString*   child_name;
@property (nonatomic, copy) NSString*   school_id;

@property (nonatomic, copy) NSString*   grade_name;
@property (nonatomic, copy) NSString*   classroom_name;

@end

@interface QMVerificationViewController : UIViewController <UITextFieldDelegate> {
    
    NSString *yourName;
    NSString *childName;
    
    NSString *schoolID;
    NSString *schoolName;
    
    NSString *gradeID;
    NSString *gradeName;
    
    NSString *classroomName;
    NSString *selFlag;
    
    NSString *phoneNumber;
    NSString *verificationCode;
    
    NSMutableData*     responseData;
    
    NSMutableArray* childArray;
}

@property (nonatomic, weak) IBOutlet UIButton *nextButton;
@property (nonatomic, weak) IBOutlet UITextField *verificationText;

@property (nonatomic, weak) IBOutlet UIView *line;

@end
