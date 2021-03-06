//
//  ViewController.m
//  Split Pay
//
//  Created by Mac Liu on 7/19/14.
//  Copyright (c) 2014 Mac Liu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imageView.image = [UIImage imageNamed:@"logo.png"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
}

- (IBAction)facebookButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"toFTGsignup" sender:self];
}

- (IBAction)signUpButtonPressed:(UIButton *)sender {
}

- (IBAction)loginButtonPressed:(UIButton *)sender {
    NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login Failed" message:@"Please enter an username and password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    } else {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"]delegate:nil cancelButtonTitle:@"Try again" otherButtonTitles: nil];
                [alert show];
            } else {
                [self performSegueWithIdentifier:@"toProfile" sender:self];
            }
        }];
    }

}

#pragma mark - UITextfielddelegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Helper Methods

-(void)dismissKeyboard {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
@end
