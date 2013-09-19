//
//  NewGenreTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "NewGenreTVC.h"

@interface NewGenreTVC ()

@end

@implementation NewGenreTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.genreField.text=self.currentGenre.genre;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textResignFirstResponder:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)save:(id)sender {
    if (![self.genreField.text isEqualToString:@""]) {
        [self.currentGenre setGenre:self.genreField.text];
        [self.delegate newGenreTVCSave];
        self.genreField.text=@"";
    }else{
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Category name missing" message:@"Please type a new category name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [view show];
    }
}

- (IBAction)cancel:(id)sender {
    [self.delegate newGenreTVCCancel:self.currentGenre];
}
@end
