//
//  QMVerificationViewController.m
//  Q-municate
//
//  Created by bruno on 8/2/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import "QMVerificationViewController.h"

@interface QMVerificationViewController ()

@end

@implementation QMVerificationViewController

@synthesize nextButton, verificationText;

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
    
    self.verificationText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Verification code" attributes:@{NSForegroundColorAttributeName: color}];
}

- (IBAction)GoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    [verificationText resignFirstResponder];
    
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