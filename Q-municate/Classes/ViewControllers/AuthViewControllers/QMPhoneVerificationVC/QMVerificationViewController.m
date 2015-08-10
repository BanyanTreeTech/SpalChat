//
//  QMVerificationViewController.m
//  Q-municate
//
//  Created by bruno on 8/2/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import "QMVerificationViewController.h"

#import "SBJSON.h"
#import "SBJsonWriter.h"
#import "SVProgressHUD.h"

#define REFRESH_HEADER_HEIGHT 100.0f

#define CONNECTION_STATE_WATCHLIST  1000
#define CONNECTION_STATE_START      1001
#define CONNECTION_STATE_UPDATE     1002
#define CONNECTION_STATE_NEXTLOAD   1003

@interface QMVerificationViewController ()

@end

@implementation childInfo2

@end

@implementation QMVerificationViewController

@synthesize nextButton, verificationText;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    nextButton.layer.cornerRadius   =   5;
    
    childArray = [[NSMutableArray alloc] init];
    
    // add tap gesture to help in dismissing keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];

    
    //placeholder color
    UIColor *color = [UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:216.0/255.0 alpha:1.0];
    
    self.verificationText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Verification code" attributes:@{NSForegroundColorAttributeName: color}];
}

- (IBAction)GoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GoTabMain:(id)sender {
    
    yourName = [[NSUserDefaults standardUserDefaults]objectForKey:SignYourname];
    childName = [[NSUserDefaults standardUserDefaults]objectForKey:SignYourname];
    schoolID = [[NSUserDefaults standardUserDefaults]objectForKey:SignYourname];
    schoolName = [[NSUserDefaults standardUserDefaults]objectForKey:SignYourname];
    
    gradeID = [[NSUserDefaults standardUserDefaults]objectForKey:SignYourname];
    gradeName = [[NSUserDefaults standardUserDefaults]objectForKey:SignYourname];
    
    classroomName = [[NSUserDefaults standardUserDefaults]objectForKey:SignYourname];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:SignYourname]  isEqual: @"1"]) {
        selFlag = @"n";
    } else {
        selFlag = @"y";
    }
    
    
    if ([verificationText.text  isEqual: @"123456"]) {
        
        [self doRegistered];
        
//        [self performSegueWithIdentifier:KGoTabMainSegue sender:nil];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Invalid Verification code!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    [verificationText resignFirstResponder];
    
}

- (void) doRegistered {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    NSString* url = nil;
    
    childInfo2 *listItem        = [[childInfo2 alloc] init];
    
    listItem.child_name =   childName;
    listItem.school_id  =   schoolID;
    listItem.grade_name =   gradeName;
    listItem.classroom_name =   classroomName;
    
    [childArray addObject:listItem];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *childLink = [writer stringWithObject:childArray];
    
    url = [NSString stringWithFormat:API_SIGNUP, yourName, phoneNumber, selFlag, @"Device56489", @"iOS", schoolID, childLink];
    
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
    
    
    NSDictionary *data_array = [[SBJsonParser new] objectWithString:responseString];
    
    NSString *ResponseCode = [data_array objectForKey:@"ResponseCode"];
    NSString *Result = [data_array objectForKey:@"Result"];
    
    NSLog(@"ResponseCode %@ - %@", ResponseCode, Result);
    
    if ([Result  isEqual: @"true"]) {
        [self performSegueWithIdentifier:KGoTabMainSegue sender:nil];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Can't register!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
