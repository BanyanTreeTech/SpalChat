//
//  QMSignUp2ViewController.h
//  Q-municate
//
//  Created by bruno on 7/28/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface allListItem : NSObject

@property (nonatomic, copy) NSString*   schoolID2;
@property (nonatomic, copy) NSString*   schoolName2;

@end

@interface QMSignUp2ViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    int selectBtnFlag;
    int fieldID;
    
    UIView *addView;
    UITableView *tbl_addListView;    
    
    int     listID;
    
    NSString *selectedSchoolId;
    NSString *selectedSchoolName;
    
    NSString *selectedGradeId;
    NSString *selectedGradeName;
    
    NSMutableData*     responseData;
    NSMutableArray*     listArray;
    NSMutableArray*     listTempArray;
    
    int curConnectionState;
}

//@property (nonatomic, retain) UITableView *tbl_addListView;

@end
