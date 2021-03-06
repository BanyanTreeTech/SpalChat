//
//  QMSignUp2ViewController.m
//  Q-municate
//
//  Created by bruno on 7/28/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import "QMSignUp2ViewController.h"

#import "SBJSON.h"
#import "SBJsonWriter.h"
#import "SVProgressHUD.h"

#import "UIViewController+MJPopupViewController.h"
#import "MJDetailViewController.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"

#define REFRESH_HEADER_HEIGHT 100.0f

#define CONNECTION_STATE_WATCHLIST  1000
#define CONNECTION_STATE_START      1001
#define CONNECTION_STATE_UPDATE     1002
#define CONNECTION_STATE_NEXTLOAD   1003

@interface QMSignUp2ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *teacherButton;
@property (nonatomic, weak) IBOutlet UIButton *parentButton;

@property (nonatomic, weak) IBOutlet UITextField *nameText;
@property (nonatomic, weak) IBOutlet UIView *nameLine;

@property (nonatomic, weak) IBOutlet UIView *childView;
@property (nonatomic, weak) IBOutlet UITextField *childText;

@property (nonatomic, weak) IBOutlet UITextField *schoolText;
@property (nonatomic, weak) IBOutlet UIButton *schoolButton;

@property (nonatomic, weak) IBOutlet UITextField *gradeText;
@property (nonatomic, weak) IBOutlet UIButton *gradeButton;
@property (nonatomic, weak) IBOutlet UIView *gradeLine;

@property (nonatomic, weak) IBOutlet UITextField *ClassroomText;
@property (nonatomic, weak) IBOutlet UIView *classroomLine;

@property (nonatomic, weak) IBOutlet UIButton *AddChildButton;
@property (nonatomic, weak) IBOutlet UIButton *NextButton;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *line1WidthConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *text1WidthConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *button1WidthConstraint;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *line2WidthConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *text2WidthConstraint;

@property (nonatomic, weak) IBOutlet UIScrollView   *myscrollView;



@end


@implementation allListItem

@end

@implementation QMSignUp2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self selectParent:nil];
    
    self.myscrollView.scrollEnabled = NO;
  
    // Empty School Id and name
    [[NSUserDefaults standardUserDefaults] setObject:@""      forKey:SSchoolListID];
    [[NSUserDefaults standardUserDefaults] setObject:@""      forKey:SSchoolListName];
    
    //Format list array
    
    schoolListArray = [[NSMutableArray alloc] init];
    schoolListTempArray = [[NSMutableArray alloc] init];
    gradeListArray  =   [[NSMutableArray alloc] init];
    gradeListTempArray  =   [[NSMutableArray alloc] init];
    
    //Resize grade & classroom textfeild width
    
    
    //placeholder color
    UIColor *color = [UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:216.0/255.0 alpha:1.0];
    
    self.nameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Your name" attributes:@{NSForegroundColorAttributeName: color}];
    self.childText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Your child name" attributes:@{NSForegroundColorAttributeName: color}];
    self.schoolText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"School name" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.gradeText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Grade" attributes:@{NSForegroundColorAttributeName: color}];
    self.ClassroomText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Classroom" attributes:@{NSForegroundColorAttributeName: color}];
    
    self.NextButton.layer.cornerRadius  =   5;
   
    self.line1WidthConstraint.constant = (self.view.frame.size.width - 60) * 0.4;
    self.text1WidthConstraint.constant = (self.view.frame.size.width - 60) * 0.4;
    self.button1WidthConstraint.constant = (self.view.frame.size.width - 60) * 0.4;
    
    self.line2WidthConstraint.constant = (self.view.frame.size.width - 60) * 0.6;
    self.text2WidthConstraint.constant = (self.view.frame.size.width - 60) * 0.6;
    
    listID = -1;
    
    addView = [[UIView alloc] initWithFrame:CGRectMake(20, 1110, self.nameLine.frame.size.width, 200)];
    [UIView animateWithDuration:0.5 animations:^{addView.frame = CGRectMake(20, 110, self.nameLine.frame.size.width, 200);}];
    
    [self.view addSubview:addView];
    addView.hidden = YES;
    
    tbl_addListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, addView.frame.size.width, 200) style:UITableViewStylePlain];
    
    
    [tbl_addListView setDataSource:self];
    [tbl_addListView setDelegate:self];
    
    CALayer *layer = tbl_addListView.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:216.0/255.0 alpha:1.0] CGColor]];
    
    [addView addSubview:tbl_addListView];
    
//    // add tap gesture to help in dismissing keyboard
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
//                                           initWithTarget:self
//                                           action:@selector(tapScreen:)];// outside textfields
//    
//    [self.view addGestureRecognizer:tapGesture];
}

- (void) onKeyboardWillHide {
    [UIView animateWithDuration:0.3 animations:^{
        addView.alpha = 0;
    } completion:^(BOOL finished) {
        addView.hidden = YES;
        addView.alpha = 1;
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    self.schoolText.text = [[NSUserDefaults standardUserDefaults]objectForKey:SSchoolListName];

}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GoHelp:(id)sender {
    
    MJDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MJDetailViewController"];
    
    NSLog(@"%f", self.nameLine.frame.size.width);
    [detailViewController.view setFrame:CGRectMake(0, -100, self.nameLine.frame.size.width, 121)];
    [self presentPopupViewController:detailViewController animationType:0];
}

- (IBAction)selectTeacher:(id)sender {
    
    self.teacherButton.selected     =   YES;
    self.parentButton.selected      =   NO;
    
    self.childView.hidden  =   YES;
    
    UIColor *color = [UIColor grayColor];
    self.childText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Your child name" attributes:@{NSForegroundColorAttributeName: color}];
    
    selectBtnFlag   =   1;
}

- (IBAction)selectParent:(id)sender {
    
    self.teacherButton.selected     =   NO;
    self.parentButton.selected      =   YES;
    
    self.childView.hidden  =   NO;
    
    UIColor *color = [UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:216.0/255.0 alpha:1.0];
    self.childText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Your child name" attributes:@{NSForegroundColorAttributeName: color}];
    
    selectBtnFlag   =   2;
}

- (IBAction)selectSchool:(id)sender
{
    [self.schoolText resignFirstResponder];
//    [addView removeFromSuperview];
    addView.hidden  =   YES;
    
    [self performSegueWithIdentifier:kSchoolListSegueIdentifier sender:nil];
}

- (IBAction)additinalChild:(id)sender
{
    [self performSegueWithIdentifier:kAddChildSegueIdentifier sender:nil];
}

- (IBAction)GoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)InputPhone:(id)sender {
    
    if (self.nameText.text.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please input Your name!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    if (selectBtnFlag == 2) {
        
        if (self.childText.text.length == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please input Child name!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
    }
    
    if (self.schoolText.text.length == 0 || selectedSchoolId <= 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please input School name!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    if (self.gradeText.text.length == 0  || selectedGradeId <= 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please input Grade name!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    if (self.ClassroomText.text.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please input Classroom name!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:self.nameText.text      forKey:SignYourname];
    [[NSUserDefaults standardUserDefaults] setObject:self.childText.text      forKey:SignChildname];
    [[NSUserDefaults standardUserDefaults] setObject:self.ClassroomText.text      forKey:SignClassroomname];
    
    [[NSUserDefaults standardUserDefaults] setObject:selectedSchoolId      forKey:SSchoolListID];
    [[NSUserDefaults standardUserDefaults] setObject:selectedSchoolName      forKey:SSchoolListName];
    
    [[NSUserDefaults standardUserDefaults] setObject:selectedGradeId      forKey:SGradeListID];
    [[NSUserDefaults standardUserDefaults] setObject:selectedGradeName      forKey:SGradeListName];
    
    
    NSString *selFlag= [NSString stringWithFormat:@"%d", selectBtnFlag];
    [[NSUserDefaults standardUserDefaults] setObject:selFlag      forKey:SignFlag];
    
    [self performSegueWithIdentifier:kPhoneSegue sender:nil];
}

// Getting schoolist


- (void) searchListWithFiterItem {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    NSString* url = nil;
    
    if (fieldID == 1) {
        url = [NSString stringWithFormat:API_SCHOOLLIST, @"all"];
    } else {
        url = [NSString stringWithFormat:API_GRADELIST];
    }
    
    // downloading data from Web Service API...
    responseData = [[NSMutableData alloc] init];
    
    NSLog(@"%@", url);
    NSURL *apiurl = [NSURL URLWithString:url];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:apiurl] delegate:self];
}

#pragma mark Connection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [SVProgressHUD dismiss];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Cannot connect to server!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    NSLog(@"%@", responseString);
    
    if (fieldID == 1) {
        [schoolListArray        removeAllObjects];
        [schoolListTempArray    removeAllObjects];
    } else {
        
        [gradeListArray         removeAllObjects];
        [gradeListTempArray     removeAllObjects];
    }
    
    NSDictionary *data_array = [[SBJsonParser new] objectWithString:responseString];
    
    NSString *ResponseCode = [data_array objectForKey:@"ResponseCode"];
    NSString *Result = [data_array objectForKey:@"Result"];
    
    NSLog(@"ResponseCode %@ - %@", ResponseCode, Result);
    
    NSMutableArray *dataListArray = [data_array objectForKey:@"data"];
    
    for (int i=0; i< (int) [dataListArray count]; i++) {
        
        NSDictionary *item = [dataListArray objectAtIndex:i];
        if (item == nil)
            continue;
        
        allListItem *listItem        = [[allListItem alloc] init];
        
        
        if (fieldID == 1) {
            
            listItem.ItemID               = [item objectForKey:@"school_id"];
            listItem.ItemName             = [item objectForKey:@"school_name"];
            
            [schoolListArray addObject:listItem];
            [schoolListTempArray addObject:listItem];
            
        } else {
            
            listItem.ItemID               = [item objectForKey:@"id"];
            listItem.ItemName             = [item objectForKey:@"grade_name"];
            
            [gradeListArray addObject:listItem];
            [gradeListTempArray addObject:listItem];
        }
    }
    
    [SVProgressHUD dismiss];
//    [tbl_addListView reloadData];
    
}

// School List Select Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)self
          .schoolText.text.length);
    
    if (fieldID == 1) {
        if (self.schoolText.text.length > 0) {
            return [schoolListTempArray count];
        } else {
            return [schoolListArray count];
        }
    } else {
        
        if (self.gradeText.text.length > 0) {
            return [gradeListTempArray count];
        } else {
            return [gradeListArray count];
        }
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SchoolListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
//    if (listID == indexPath.row)
//    {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    if (fieldID == 1) {
        
        if (self.schoolText.text.length > 0) {
            allListItem *Item = [schoolListTempArray objectAtIndex:indexPath.row];
            
            cell.textLabel.text = Item.ItemName;
        } else {
            
            allListItem *Item = [schoolListArray objectAtIndex:indexPath.row];
            
            cell.textLabel.text = Item.ItemName;
        }

    } else {
        
        if (self.gradeText.text.length > 0) {
            allListItem *Item = [gradeListTempArray objectAtIndex:indexPath.row];
            
            cell.textLabel.text = Item.ItemName;
        } else {
            
            allListItem *Item = [gradeListArray objectAtIndex:indexPath.row];
            
            cell.textLabel.text = Item.ItemName;
        }

    }
    
    
    
    tableView.separatorColor = [UIColor colorWithRed:30/255.0 green:174/255.0 blue:215/255.0 alpha:1.0];
    
    
    //    cell.textLabel.text = @"1123";
    [cell.textLabel setFont:[UIFont fontWithName:@"Open Sans" size:16.0]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    listID = (int) indexPath.row;
    
    if (fieldID == 1) {
        
        allListItem *listItem = [schoolListArray objectAtIndex:listID];
        
        self.schoolText.text = listItem.ItemName;
        
        selectedSchoolName = listItem.ItemName;
        selectedSchoolId   = listItem.ItemID;
    } else {
        
        allListItem *listItem = [gradeListArray objectAtIndex:listID];
        self.gradeText.text = listItem.ItemName;
        
        selectedGradeName = listItem.ItemName;
        selectedGradeId   = listItem.ItemID;
    }
    
    [tableView reloadData];
    
    addView.hidden  = YES;
    [self.schoolText resignFirstResponder];
    [self.gradeText resignFirstResponder];
}


// UI Text Field

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if (textField == self.schoolText) {
        fieldID = 1;
        
        if (schoolListArray.count <= 0) {
            [self searchListWithFiterItem];
        }
    } else if (textField == self.gradeText) {
        fieldID = 2;
        
        if (gradeListArray.count <= 0) {
            [self searchListWithFiterItem];
        }
    } else {
        
    }
//    NSLog(@" %f", self.nameText.frame.);
    
//    if (textField == self.schoolText || textField == self.gradeText) {
//        
//        addView = [[UIView alloc] initWithFrame:CGRectMake(20, 1110, self.nameLine.frame.size.width, 200)];
//        [UIView animateWithDuration:0.5 animations:^{addView.frame = CGRectMake(20, 110, self.nameLine.frame.size.width, 200);}];
//        
//        [self.view addSubview:addView];
//        
//        if (textField == self.schoolText) {
//            fieldID = 1;
//        } else {
//            fieldID = 2;
//        }
//        
//        tbl_addListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, addView.frame.size.width, 200) style:UITableViewStylePlain];
//        
//        
//        [tbl_addListView setDataSource:self];
//        [tbl_addListView setDelegate:self];
//        
//        CALayer *layer = tbl_addListView.layer;
//        [layer setMasksToBounds:YES];
//        [layer setCornerRadius:5.0];
//        [layer setBorderWidth:1.0];
//        [layer setBorderColor:[[UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:216.0/255.0 alpha:1.0] CGColor]];
//        
//        [addView addSubview:tbl_addListView];
//        
//        [self searchListWithFiterItem];
//    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.myscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
//    [addView removeFromSuperview];
    addView.hidden  =   YES;
    
    listID = -1;
    [textField resignFirstResponder];

    return YES;
}

- (IBAction)onTextChanged:(id)sender {
    
    addView.hidden = NO;
    
    [schoolListTempArray removeAllObjects];
        
    for (int i = 0; i < (int) schoolListArray.count; i++) {
        
        allListItem *item = [schoolListArray objectAtIndex:i];
        NSRange foundRange = [item.ItemName.lowercaseString rangeOfString:self
                              .schoolText.text.lowercaseString];
        
        if (foundRange.length > 0) {
            [schoolListTempArray addObject:item];
        }
    }

    
    //    NSLog(@"%@", schoolNameText.text);
    
//    for (int i = 0; i < (int) listArray.count; i++) {
//        allListItem *item = [listArray objectAtIndex:i];
//        NSRange foundRange = [item.schoolName2.lowercaseString rangeOfString:self
//                              .schoolText.text.lowercaseString];
//        
//        if (foundRange.length > 0) {
//            [listTempArray addObject:item];
//        }
//    }
    
    [tbl_addListView reloadData];
}


- (IBAction)changeGradeList:(id)sender {
    
    addView.hidden = NO;
    
    [gradeListTempArray removeAllObjects];
    
    for (int i = 0; i < (int) gradeListArray.count; i++) {
        
        allListItem *item = [gradeListArray objectAtIndex:i];
        NSRange foundRange = [item.ItemName.lowercaseString rangeOfString:self.gradeText.text.lowercaseString];
        
        if (foundRange.length > 0) {
            [gradeListTempArray addObject:item];
        }
    }
    
    [tbl_addListView reloadData];
}
@end
