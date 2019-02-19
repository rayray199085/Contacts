//
//  SCUpdateContactViewController.m
//  Contacts
//
//  Created by Stephen Cao on 18/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import "SCUpdateContactViewController.h"

@interface SCUpdateContactViewController ()
- (IBAction)editContactInfo:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *telTxt;
- (IBAction)saveInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end

@implementation SCUpdateContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTxt.text = self.person.name;
    self.telTxt.text = self.person.tel;
}

- (IBAction)editContactInfo:(UIBarButtonItem *)sender {
    if(self.saveBtn.hidden){
        sender.title = @"Cancel";
    }else{
        sender.title = @"Edit";
        self.nameTxt.text = self.person.name;
        self.telTxt.text = self.person.tel;
    }
    self.nameTxt.enabled = ! self.nameTxt.enabled;
    self.telTxt.enabled = !self.telTxt.enabled;
    self.saveBtn.hidden = !self.saveBtn.hidden;
    [self.telTxt becomeFirstResponder];
}
- (IBAction)saveInfo:(id)sender {
    self.person.name = self.nameTxt.text;
    self.person.tel = self.telTxt.text;
    if([self.delegate respondsToSelector:@selector(updateConcactWithController:andWithContact:)]){
        [self.delegate updateConcactWithController:self andWithContact:self.person];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
