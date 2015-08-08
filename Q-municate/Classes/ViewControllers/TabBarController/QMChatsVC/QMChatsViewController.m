//
//  QMChatsViewController.m
//  Q-municate
//
//  Created by bruno on 8/2/15.
//  Copyright (c) 2015 Quickblox. All rights reserved.
//

#import "QMChatsViewController.h"

#import "QMHomeTabController.h"

@interface QMChatsViewController ()


@end

@implementation QMChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBarController.tabBar setHidden:YES];
    
    self.searchView.hidden  =   YES;
}

- (IBAction)GoParents:(id)sender {
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

- (IBAction)GoMore:(id)sender {
    
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
}

- (IBAction)ShowearchView:(id)sender {
    
    self.searchView.hidden  =   NO;
}

- (IBAction)hiddenSearchView:(id)sender {
    
    [self.searchKeyText resignFirstResponder];
    self.searchView.hidden  =   YES;
}

//Hidden keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


// Chats

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 8;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"RoomCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    UIColor *borderColor = [UIColor colorWithRed:30/255.0 green:174/255.0 blue:215/255.0 alpha:1];
    
    UILabel*        roomTitle = (UILabel*) [cell viewWithTag:11];
    UILabel*        content = (UILabel*) [cell viewWithTag:12];
    UIImageView*    roomImg =   (UIImageView*) [ cell viewWithTag:13];
    
    roomImg.layer.cornerRadius   =   roomImg.frame.size.width / 2;
    if (indexPath.row > 3)
        roomImg.layer.borderWidth   =   0;
    else
        roomImg.layer.borderWidth   =   2;
    [roomImg.layer setBorderColor:borderColor.CGColor];
    roomImg.clipsToBounds   =   YES;
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.contentView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
            
            UIImage* image = [UIImage imageNamed:@""];
            [roomImg setImage:image];
        } else {
            
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            UIImage* image = [UIImage imageNamed:@"room1.png"];
            [roomImg setImage:image];
        }
    } else {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImage* image = [UIImage imageNamed:@"room1.png"];
        [roomImg setImage:image];
    }
    
    
    
//    cell.textLabel.text = [DetailsData objectAtIndex:indexPath.row];
//    [cell.textLabel setFont:[UIFont fontWithName:@"Open Sans" size:16.0]];
    //    UIButton*       cellCheckBtn = (UIButton*) [cell viewWithTag:321];
    //
    
    //
    //
    //    if (GenderType == indexPath.row) {
    //        cellCheckBtn.selected = YES;
    //    } else {
    //        cellCheckBtn.selected = NO;
    //    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    chatroomID = (int) indexPath.row;
//    
//    [tableView reloadData];
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
