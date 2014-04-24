//
//  ViewController.m
//  Demo
//
//  Created by shihaijie on 4/24/14.
//  Copyright (c) 2014 Saick. All rights reserved.
//

#import "ViewController.h"

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
  
}

- (IBAction)encryptDidPressed:(id)sender
{
  
}

- (IBAction)decryptDidPressed:(id)sender
{
  
}

@end
