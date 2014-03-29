//
//  ZoriBluetoothMainViewController.m
//  Zorios
//
//  Created by iGitScor on 26/03/2014.
//  Copyright (c) 2014 FlipFlopCrew. All rights reserved.
//

#import "ZoriBluetoothMainViewController.h"
#import "zlib.h"

@interface ZoriBluetoothMainViewController ()

@property (nonatomic, retain) NSString *currentDevice;

@end

@implementation ZoriBluetoothMainViewController
@synthesize picker;

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
    
    [self toggleButtons:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:false];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - GKPeerPickerController delegate

- (void)peerPickerController:(GKPeerPickerController *)localPicker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    self.currentSession             = session;
    self.currentSession.delegate    = self;
    [self.currentSession setDataReceiveHandler:self withContext:nil];
    localPicker.delegate            = nil;
    [localPicker dismiss];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)localPicker
{
    localPicker.delegate = nil;
    [self toggleButtons:NO];
}

#pragma mark - GKSession delegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    if (state == GKPeerStateDisconnected) {
        self.currentSession = nil;
        [self toggleButtons:NO];
    }
}

- (void)mySendDataToPeers:(NSData *)data
{
    if (self.currentSession) {
        [self.currentSession sendDataToAllPeers:data
                                   withDataMode:GKSendDataReliable
                                          error:nil];
    }
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    NSDictionary *dict  = (NSDictionary*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *str;
    
    if (_currentDevice == nil) {
        str = [dict objectForKey:@"device"];
    } else {
        str = [dict objectForKey:@"data"];
    }
    
    UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"Data received"
                                                     message:str
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}

#pragma mark - IBAction

- (IBAction)synchronizeDevice:(id)sender
{
    UIDevice *device    = [UIDevice currentDevice];
    NSString *uuid      = [[device identifierForVendor] UUIDString];
    NSString *str       = [NSString stringWithString:uuid];
    NSDictionary *dict  = [NSDictionary dictionaryWithObjectsAndKeys:str, @"device", nil];
    NSData *data        = [NSKeyedArchiver archivedDataWithRootObject:dict];
    
    [self mySendDataToPeers:data];
}

- (IBAction)sendDatabase:(id)sender
{
    NSError *error;
    
    NSString *docs      = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filepath  = [docs stringByAppendingPathComponent:@"Zorios.sqlite"];
    NSString *coredata  = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUnicodeStringEncoding error:&error];
    
    if (!coredata) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to get the database." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    NSDictionary *dict  = [NSDictionary dictionaryWithObjectsAndKeys:coredata, @"data", nil];
    NSData *data        = [NSKeyedArchiver archivedDataWithRootObject:dict];
    
    [self mySendDataToPeers:data];
}


- (IBAction)disconnect:(id)sender
{
    [self.currentSession disconnectFromAllPeers];
    self.currentSession = nil;
    
    [self toggleButtons:NO];
}

- (IBAction)connect:(id)sender
{
    picker                      = [[GKPeerPickerController alloc] init];
    picker.delegate             = self;
    picker.connectionTypesMask  = GKPeerPickerConnectionTypeNearby;
    
    [self toggleButtons:YES];
    [picker show];
}

- (void)toggleButtons:(bool)connectWillBeHidden
{
    [_connect setHidden:connectWillBeHidden];
    [_disconnect setHidden:!connectWillBeHidden];

    if (_currentDevice != nil) {
        [_send setHidden:!connectWillBeHidden];
        [_synchronize setHidden:true];
    } else {
        [_send setHidden:true];
        [_synchronize setHidden:!connectWillBeHidden];
    }
}

@end
