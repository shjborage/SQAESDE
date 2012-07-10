//
//  TestViewController.m
//  test_SQCommon
//
//  Created by Shi Eric on 7/9/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "TestViewController.h"
#import "SQLibs.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // SQStringUtils
    UILabel *t_lbInfo = [[UILabel alloc] init];
    t_lbInfo.frame = CGRectMake(50.0f, 50.0f, self.view.frame.size.width - 100.0f, 150.0f);
    t_lbInfo.numberOfLines = 0;
    
    // getCurrentDateTime's parameter can be nil. The default is "yyyy-MM-dd HH:mm:ss";
    NSString *t_strTime = [NSString getCurrentDateTime:@"MM-dd-yyyy HH:mm:ss"];
    NSString *t_strUUID = @"";//[NSString getUUID];
    NSString *t_strChinease     = @"我是中国人";
    NSString *t_strEnglish      = @"English";
    NSString *t_strMix          = @"English人";
    NSString *t_strCharNum = [NSString stringWithFormat:@"%@ charNum:%d\n%@ charNum:%d\n%@ charNum:%d\n", t_strChinease, [t_strChinease charNumber], t_strEnglish, [t_strEnglish charNumber], t_strMix, [t_strMix charNumber]];
    
    t_lbInfo.text = [t_strTime stringByAppendingFormat:@"\n%@\n%@", t_strUUID, t_strCharNum];
    [self.view addSubview:t_lbInfo];
    [t_lbInfo release];
    
    UIImageView *t_ivColor = [[UIImageView alloc] init];
    t_ivColor.frame = CGRectMake(50.0f, 220.0f, self.view.frame.size.width - 100.0f, 100.0f);
    t_ivColor.image = [RGB(125, 2, 111) createImage];
    [self.view addSubview:t_ivColor];
    [t_ivColor release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    SQLOG(@"file:%@ line:%d fun:%@ callstack:%@ UIInterfaceOrientation:%d", __FILE_NAME__, __LINE__, __FUNC_NAME__, __CALL_STACK__, interfaceOrientation);
    
    if (SQ_ISPAD)
        return YES;
    else 
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
