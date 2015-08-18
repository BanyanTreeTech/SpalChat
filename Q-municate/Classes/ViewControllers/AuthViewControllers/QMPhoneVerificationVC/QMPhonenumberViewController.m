//
//  QMPhonenumberViewController.m
//  Q-municate
//
//  Created by bruno on 8/2/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import "QMPhonenumberViewController.h"

#import "UIViewController+MJPopupViewController.h"
#import "MJDetailViewController.h"

@interface QMPhonenumberViewController ()

@end

@implementation QMPhonenumberViewController

@synthesize nextButton, phonenumberText;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    nextButton.layer.cornerRadius   =   5;
    
    // add tap gesture to help in dismissing keyboard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapScreen:)];// outside textfields
    
    [self.view addGestureRecognizer:tapGesture];
    
    //placeholder color
    UIColor *color = [UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:216.0/255.0 alpha:1.0];
    
    self.phonenumberText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone number" attributes:@{NSForegroundColorAttributeName: color}];
    
    static NSString *letters = @"0123456789";
    
    postCode = [NSMutableString stringWithCapacity: 6];
    for (int i=0; i<6; i++) {
        [postCode appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    NSLog(@"postCode - %@", postCode);
}

- (IBAction)GoHelp:(id)sender {
    
    MJDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MJDetailViewController"];
    
    [detailViewController.view setFrame:CGRectMake(0, -100, self.line.frame.size.width, 121)];
    [self presentPopupViewController:detailViewController animationType:0];
}

- (IBAction)GoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)GoVerification:(id)sender {
    
    if (self.phonenumberText.text.length < 10) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Invalid Phone number!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    } else {
        
        NSString *msg = [[NSString alloc] initWithFormat:@"+1 %@ \n We will send the verification code to this number via SMS.", self.phonenumberText.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Check Phone Number!" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    [phonenumberText resignFirstResponder];
    
}

- (IBAction)changeText:(id)sender {
    
    if (self.phonenumberText.text.length == 10) {
        
        [phonenumberText resignFirstResponder];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) { // Set buttonIndex == 0 to handel "Ok"/"Yes" button response
        // Cancel button response
        
        NSString *kTwilioSID = @"ACed7382b831d5a11258dc20bc0c77007d";
        NSString *kTwilioSecret = @"e0a8afec452689e1ddba04e9bc13fd50";
        NSString *kFromNumber = @"+14155992671";
        NSString *kToNumber = [NSString stringWithFormat:@"+1%@", self.phonenumberText.text];
        NSString *kMessage = [NSString stringWithString:postCode];

        // Build request
        NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@api.twilio.com/2010-04-01/Accounts/%@/SMS/Messages", kTwilioSID, kTwilioSecret, kTwilioSID];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        // Set up the body
        NSString *bodyString = [NSString stringWithFormat:@"From=%@&To=%@&Body=%@", kFromNumber, kToNumber, kMessage];
        NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSError *error;
        NSURLResponse *response;
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        // Handle the received data
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Error!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            NSString *receivedString = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
            NSLog(@"Request sent. %@", receivedString);
            
            [[NSUserDefaults standardUserDefaults] setObject:self.phonenumberText.text      forKey:SignYourname];
            [[NSUserDefaults standardUserDefaults] setObject:postCode      forKey:VerCode];

            [self performSegueWithIdentifier:kPhoneVeriSegue sender:nil];
        }
    }
    
//    [[NSUserDefaults standardUserDefaults] setObject:postCode      forKey:VerCode];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:self.phonenumberText.text      forKey:SignYourname];
//    
//    [self performSegueWithIdentifier:kPhoneVeriSegue sender:nil];
}

// Generates alpha-numeric-random string
- (NSString *)genRandStringLength:(int)len {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
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
