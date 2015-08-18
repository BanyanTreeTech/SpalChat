//
//  QMLoginPhoneNumberViewController.m
//  Q-municate
//
//  Created by bruno on 8/8/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import "QMLoginPhoneNumberViewController.h"

#import "UIViewController+MJPopupViewController.h"
#import "MJDetailViewController.h"

@interface QMLoginPhoneNumberViewController ()

@end

@implementation QMLoginPhoneNumberViewController

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
    
}

- (IBAction)GoHelp:(id)sender {
    
    MJDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MJDetailViewController"];
    
    [detailViewController.view setFrame:CGRectMake(0, -100, self.line.frame.size.width, 121)];
    [self presentPopupViewController:detailViewController animationType:0];
}

- (IBAction)GoBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// dismiss keyboard when tap outside text fields
- (IBAction)tapScreen:(UITapGestureRecognizer *)sender {
    
    [phonenumberText resignFirstResponder];
    
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
