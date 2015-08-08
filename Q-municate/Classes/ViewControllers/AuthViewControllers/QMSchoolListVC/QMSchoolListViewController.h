//
//  QMSchoolListViewController.h
//  Q-municate
//
//  Created by bruno on 7/29/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface schoolListItem : NSObject

@property (nonatomic, copy) NSString*   schoolID;
@property (nonatomic, copy) NSString*   schoolName;

@end

@interface QMSchoolListViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate> {

    NSArray *DetailsData;
    int     listID;

    NSMutableData*     responseData;
    NSMutableArray*     listArray;
    NSMutableArray*     listTempArray;
    
    int curConnectionState;
}



@property (nonatomic, weak) IBOutlet UITextField *schoolNameText;
@property (nonatomic, weak) IBOutlet UITextField *addSchoolNameText;

@property (strong, nonatomic) IBOutlet  UITableView* tbl_SchoolListView;

@property (nonatomic, weak) IBOutlet UIScrollView *myScrollView;

@end


