//
//  ViewController.m
//  Demo
//
//  Created by shihaijie on 4/24/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import "ViewController.h"

#import "SQAESDE.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UITextField *originTF;
@property (nonatomic, strong) IBOutlet UITextField *enkeyTF;
@property (nonatomic, strong) IBOutlet UITextField *encryptTF;
@property (nonatomic, strong) IBOutlet UITextField *dekeyTF;
@property (nonatomic, strong) IBOutlet UITextField *resultTF;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (IBAction)keyDidChanged:(UITextField *)sender
{
  self.dekeyTF.text = sender.text;
}

- (IBAction)encryptDidPressed:(id)sender
{
  self.encryptTF.text = [SQAESDE enCryptBase64:self.originTF.text key:self.enkeyTF.text];
}

- (IBAction)decryptDidPressed:(id)sender
{
  self.resultTF.text = [SQAESDE deCryptBase64:self.encryptTF.text key:self.dekeyTF.text];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesBegan:touches withEvent:event];
  
  [self.originTF resignFirstResponder];
  [self.enkeyTF resignFirstResponder];
  [self.encryptTF resignFirstResponder];
  [self.dekeyTF resignFirstResponder];
  [self.resultTF resignFirstResponder];
}

@end
