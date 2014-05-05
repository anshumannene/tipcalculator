//
//  TipViewController.m
//  tipcalculator
//
//  Created by Anshuman Nene on 5/1/14.
//  Copyright (c) 2014 anene. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"
#import "Constants.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *totalPerPersonTextField;

- (IBAction)onTap:(UITapGestureRecognizer *)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)initUserDefaults;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
        [self initUserDefaults];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *tipValues = @[@(0.15), @(0.18), @(0.2)];
    
    double billAmount = [self.billAmountTextField.text doubleValue];
    
    double tipAmount = [tipValues[self.tipControl.selectedSegmentIndex] doubleValue] * billAmount;
    self.tipAmountTextField.text = [NSString stringWithFormat:FMT_DISPLAY_MONETARY, tipAmount];
    
    bool roundUpTotal = [defaults boolForKey:PREF_ROUND_UP];
    double totalAmount = billAmount + tipAmount;
    if (roundUpTotal) {
        totalAmount = ceil(totalAmount);
    }
    self.totalAmountTextField.text = [NSString stringWithFormat:FMT_DISPLAY_MONETARY, totalAmount];
    
    double totalPerPerson = totalAmount;
    NSInteger numOfPeople = [defaults integerForKey:PREF_NUM_OF_PEOPLE];
    if (numOfPeople > 1) {
        totalPerPerson /= numOfPeople;
    }
    self.totalPerPersonTextField.text = [NSString stringWithFormat:FMT_DISPLAY_MONETARY, totalPerPerson];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc]init] animated:YES];
}

- (void)initUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:NO forKey:PREF_ROUND_UP];
    [defaults setInteger:1 forKey:PREF_NUM_OF_PEOPLE];
    [defaults synchronize];
}

@end
