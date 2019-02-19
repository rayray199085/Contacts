//
//  SCAddNewContactViewController.m
//  Contacts
//
//  Created by Stephen Cao on 18/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import "SCAddNewContactViewController.h"

@interface SCAddNewContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *contactNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *telNumberTxt;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)sumbitInfo:(id)sender;
- (IBAction)contactNameTextUpdate:(id)sender;
- (IBAction)telNumberTextUpdate:(id)sender;
-(void) updateSumbitButtonStatus;
-(void) back2ContactList;
@end

@implementation SCAddNewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back2ContactList)];
    [self.contactNameTxt becomeFirstResponder];
}
-(void) back2ContactList{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sumbitInfo:(id)sender {
    SCNewContactPerson *person = [[SCNewContactPerson alloc]init];
    person.name = self.contactNameTxt.text;
    person.tel = self.telNumberTxt.text;
    if([self.delegate respondsToSelector:@selector(addNewContactWithController:andWithNewContactPerson:)]){
        [self.delegate addNewContactWithController:self andWithNewContactPerson:person];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - name and telephone number textFields listener
- (IBAction)contactNameTextUpdate:(id)sender {
    [self updateSumbitButtonStatus];
}

- (IBAction)telNumberTextUpdate:(id)sender {
    [self updateSumbitButtonStatus];
}
-(void) updateSumbitButtonStatus{
    self.submitBtn.enabled = ![self.contactNameTxt.text isEqualToString:@""] && ![self.telNumberTxt.text isEqualToString:@""];
}
@end
