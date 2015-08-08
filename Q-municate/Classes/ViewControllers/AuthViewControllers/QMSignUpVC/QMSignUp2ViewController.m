//
//  QMSignUp2ViewController.m
//  Q-municate
//
//  Created by bruno on 7/28/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import "QMSignUp2ViewController.h"

@interface QMSignUp2ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *teacherButton;
@property (nonatomic, weak) IBOutlet UIButton *parentButton;

@property (nonatomic, weak) IBOutlet UITextField *nameText;
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

@implementation QMSignUp2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self selectParent:nil];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectTeacher:(id)sender {
    
    self.teacherButton.selected     =   YES;
    self.parentButton.selected      =   NO;
    
    self.childText.enabled  =   NO;
    
    UIColor *color = [UIColor grayColor];
    self.childText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Your child name" attributes:@{NSForegroundColorAttributeName: color}];
    
    selectBtnFlag   =   1;
}

- (IBAction)selectParent:(id)sender {
    
    self.teacherButton.selected     =   NO;
    self.parentButton.selected      =   YES;
    
    self.childText.enabled  =   YES;
    
    UIColor *color = [UIColor colorWithRed:30.0/255.0 green:174.0/255.0 blue:216.0/255.0 alpha:1.0];
    self.childText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Your child name" attributes:@{NSForegroundColorAttributeName: color}];
    
    selectBtnFlag   =   2;
}

- (IBAction)selectSchool:(id)sender
{
    [self performSegueWithIdentifier:kSchoolListSegueIdentifier sender:nil];
}

- (IBAction)additinalChild:(id)sender
{
    [self performSegueWithIdentifier:kAddChildSegueIdentifier sender:nil];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.myscrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [textField resignFirstResponder];

    return YES;
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
