//
//  SCLoginViewController.m
//  Contacts
//
//  Created by Stephen Cao on 17/2/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

#import "SCLoginViewController.h"
#import "MBProgressHUD/MBProgressHUD+Ex.h"

@interface SCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UISwitch *rememberMeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *keepSignedSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)login:(id)sender;
- (IBAction)usernameTexttUpdate:(id)sender;
- (IBAction)passwordTextUpdate:(id)sender;
- (IBAction)rememberMeSwitchValue:(id)sender;
- (IBAction)keepSignedSwitchValue:(id)sender;
@end

@implementation SCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.rememberMeSwitch.on = [defaults boolForKey:@"rememberMe"];
    self.keepSignedSwitch.on = [defaults boolForKey:@"keepSigned"];
    if(self.rememberMeSwitch.on){
        self.usernameTxt.text = [defaults objectForKey:@"username"];
        self.passwordTxt.text = [defaults objectForKey:@"password"];
    }
    [self updateLoginButtonStatus];
    if(self.keepSignedSwitch.on){
        [self login:nil];
    }
}

- (IBAction)login:(id)sender {
    [MBProgressHUD showMessage:@"Logining..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if([self.usernameTxt.text isEqualToString:@"dabao"] && [self.passwordTxt.text isEqualToString:@"123"]){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:self.rememberMeSwitch.isOn forKey:@"rememberMe"];
            [defaults setBool:self.keepSignedSwitch.isOn forKey:@"keepSigned"];
            if(self.rememberMeSwitch.on){
                [defaults setObject:self.usernameTxt.text forKey:@"username"];
                [defaults setObject:self.passwordTxt.text forKey:@"password"];
            }
        
            [self performSegueWithIdentifier:@"login2Contacts" sender:nil];
        }
        else{
            [MBProgressHUD showError:@"Incorrect username or password."];
        }
    });
}

#pragma mark - listen login button status methods
- (IBAction)usernameTexttUpdate:(id)sender {
    [self updateLoginButtonStatus];
}

- (IBAction)passwordTextUpdate:(id)sender {
    [self updateLoginButtonStatus];
}

-(void)updateLoginButtonStatus{
    self.loginBtn.enabled = ![self.usernameTxt.text isEqualToString:@""] && ![self.passwordTxt.text isEqualToString:@""];
}

#pragma mark - two swithes listener
- (IBAction)rememberMeSwitchValue:(id)sender {
    if(!self.rememberMeSwitch.on && self.keepSignedSwitch.on){
        [self.keepSignedSwitch setOn:NO animated:YES];
    }
}

- (IBAction)keepSignedSwitchValue:(id)sender {
    if(self.keepSignedSwitch.on && !self.rememberMeSwitch.on){
        [self.rememberMeSwitch setOn:YES animated:YES];
    }
}
#pragma mark - prepare segue method
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    segue.destinationViewController.navigationItem.title = [NSString stringWithFormat:@"%@'s Contact List",self.usernameTxt.text];
}
@end
