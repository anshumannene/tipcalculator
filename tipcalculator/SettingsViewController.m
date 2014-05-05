//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Anshuman Nene on 5/1/14.
//  Copyright (c) 2014 anene. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constants.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *roundUpTotalAmountSwitch;
@property (weak, nonatomic) IBOutlet UITextField *numberOfPeopleTextField;

- (IBAction)onRoundUpTotalAmountSwitchChanged:(id)sender;
- (IBAction)onNumberOfPeopleChanged:(id)sender;

@end

@implementation SettingsViewController

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
    // Do any additional setup after loading the view from its nib.
    
    //Update the round-up switch for total amount with user settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.roundUpTotalAmountSwitch.on = [defaults boolForKey:PREF_ROUND_UP];
    self.numberOfPeopleTextField.text = [NSString stringWithFormat:@"%d", [defaults integerForKey:PREF_NUM_OF_PEOPLE]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRoundUpTotalAmountSwitchChanged:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.roundUpTotalAmountSwitch.on forKey:PREF_ROUND_UP];
    [defaults synchronize];
}

- (IBAction)onNumberOfPeopleChanged:(id)sender {
    NSString *numOfPeople = self.numberOfPeopleTextField.text;
    if ([numOfPeople length] != 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:[numOfPeople integerValue] forKey:PREF_NUM_OF_PEOPLE];
    }
}

@end
