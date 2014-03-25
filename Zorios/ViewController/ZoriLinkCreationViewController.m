//
//  ZoriLinkCreationViewController.m
//  Zorios
//
//  Created by iGitScor on 24/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriLinkCreationViewController.h"
#import <Firebase/Firebase.h>

@interface ZoriLinkCreationViewController ()

@property (strong, nonatomic) IBOutlet UITextField *inputLink;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneItem;

@end

@implementation ZoriLinkCreationViewController

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
    UIMenuController *theMenu = [UIMenuController sharedMenuController];
    CGRect selectionRect = CGRectMake(0, 0, 0, 0);
    [theMenu setTargetRect:selectionRect inView:self.view];
    [theMenu setMenuVisible:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return true;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"createLink"]) {
        [self createLink];
    }
}

#pragma mark - IBAction
- (IBAction)copyFromClipboard:(id)sender
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    self.inputLink.text = [pb string];
    
    [self.doneItem setEnabled:true];
}

- (void)createLink
{
    Firebase* f = [[Firebase alloc] initWithUrl:@"https://shining-fire-3337.firebaseio.com/links"];
    [[f childByAutoId] setValue:@{
                  @"submitTime": [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]],
                  @"url": self.inputLink.text,
                  @"nbClick": [NSNumber numberWithInt:0]}];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // If the return button is a "Done" one, dismiss the keyboard.
    if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
        
        [self.doneItem setEnabled:true];
    }
    
    return true;
}


@end
