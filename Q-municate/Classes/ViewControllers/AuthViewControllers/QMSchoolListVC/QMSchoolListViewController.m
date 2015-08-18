//
//  QMSchoolListViewController.m
//  Q-municate
//
//  Created by bruno on 7/29/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import "QMSchoolListViewController.h"
#import "QMSignUp2ViewController.h"

#import "SBJSON.h"
#import "SBJsonWriter.h"
#import "SVProgressHUD.h"

#define REFRESH_HEADER_HEIGHT 100.0f

#define CONNECTION_STATE_WATCHLIST  1000
#define CONNECTION_STATE_START      1001
#define CONNECTION_STATE_UPDATE     1002
#define CONNECTION_STATE_NEXTLOAD   1003

@interface QMSchoolListViewController ()

@end

@implementation schoolListItem

@end

@implementation QMSchoolListViewController

@synthesize schoolNameText, addSchoolNameText;
@synthesize tbl_SchoolListView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self searchListWithFiterItem];
    listArray = [[NSMutableArray alloc] init];
    listTempArray = [[NSMutableArray alloc] init];
    
    [self.myScrollView setScrollEnabled:NO];
    [self.myScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 50)];
    
    //placeholder color
    UIColor *color = [UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:216.0/255.0 alpha:1.0];
    
    self.schoolNameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"School name" attributes:@{NSForegroundColorAttributeName: color}];
    self.addSchoolNameText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter school name" attributes:@{NSForegroundColorAttributeName: color}];
    
    CALayer *layer = tbl_SchoolListView.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:216.0/255.0 alpha:1.0] CGColor]];
    
    listID = -1;

    layer.hidden = YES;
}

- (IBAction)GoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Done:(id)sender {
    
    if ([selectedId  isEqual: @"-1"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please input school name!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:selectedId      forKey:SSchoolListID];
        [[NSUserDefaults standardUserDefaults] setObject:selectedName      forKey:SSchoolListName];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


// Getting schoolist


- (void) searchListWithFiterItem {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    NSString* url = nil;
    url = [NSString stringWithFormat:API_SCHOOLLIST, @"all"];
    
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
    
    
    [SVProgressHUD dismiss];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    NSLog(@"%@", responseString);
    
    [listArray  removeAllObjects];
    [listTempArray  removeAllObjects];
    
    NSDictionary *data_array = [[SBJsonParser new] objectWithString:responseString];

    NSString *ResponseCode = [data_array objectForKey:@"ResponseCode"];
    NSString *Result = [data_array objectForKey:@"Result"];

    NSLog(@"ResponseCode %@ - %@", ResponseCode, Result);
    
    NSMutableArray *schoolListArray = [data_array objectForKey:@"data"];
    
    for (int i=0; i< (int) [schoolListArray count]; i++) {
        
        NSDictionary *item = [schoolListArray objectAtIndex:i];
        if (item == nil)
            continue;
        
        schoolListItem *listItem        = [[schoolListItem alloc] init];
        
        listItem.schoolID               = [item objectForKey:@"school_id"];
        listItem.schoolName             = [item objectForKey:@"school_name"];
        
        [listArray addObject:listItem];
        [listTempArray addObject:listItem];
        
    }

    
    [tbl_SchoolListView reloadData];
    
}


// School List Select Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)schoolNameText.text.length);
    
    if (schoolNameText.text.length > 0) {
        return [listTempArray count];
    } else {
        return [listArray count];
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
    
    if (schoolNameText.text.length > 0) {
        schoolListItem *Item = [listTempArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = Item.schoolName;
    } else {
        
        schoolListItem *Item = [listArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = Item.schoolName;
    }
    
    


    
//    cell.textLabel.text = @"1123";
    [cell.textLabel setFont:[UIFont fontWithName:@"Open Sans" size:16.0]];
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    listID = (int) indexPath.row;
    
    schoolListItem *listItem = [listArray objectAtIndex:listID];
    
    self.schoolNameText.text = listItem.schoolName;
    
    selectedName = listItem.schoolName;
    selectedId   = listItem.schoolID;
    
    [tableView reloadData];
    
    tbl_SchoolListView.hidden   =   YES;
    [schoolNameText resignFirstResponder];
}

//

- (void)viewDidAppear:(BOOL)animated {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
     tbl_SchoolListView.hidden   =   YES;
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;

    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField == self.schoolNameText) {
        
//        [self searchListWithFiterItem];
//        self.addSchoolNameText.text = @"";
    } else {
        
        if (![self.addSchoolNameText.text  isEqual: @""]) {
            
            self.schoolNameText.text    =   @"";
            listID = -1;
            
            [self.tbl_SchoolListView reloadData];
            
            selectedId = @"0";
        } else {
            
            selectedId = @"-1";
        }
        
        selectedName = self.addSchoolNameText.text;
        
    }
    
    return YES;
}

- (IBAction)onTextChanged:(id)sender {
    [listTempArray removeAllObjects];
    
//    NSLog(@"%@", schoolNameText.text);
    
    if (schoolNameText.text.length > 0) {
        
        tbl_SchoolListView.hidden   =   NO;
    }
        
    for (int i = 0; i < (int) listArray.count; i++) {
        schoolListItem *item = [listArray objectAtIndex:i];
        NSRange foundRange = [item.schoolName.lowercaseString rangeOfString:schoolNameText.text.lowercaseString];
        
        if (foundRange.length > 0) {
            [listTempArray addObject:item];
        }
    }
    
    [tbl_SchoolListView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
