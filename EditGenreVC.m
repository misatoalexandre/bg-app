//
//  EditGenreVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "EditGenreVC.h"
#import "AppDelegate.h"

@interface EditGenreVC ()

@end

@implementation EditGenreVC


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
    self.saveBtn.hidden=YES;
    [self.genreField setUserInteractionEnabled:NO];
    
    self.genreField.text=self.selectedGenre.genre;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)edit:(id)sender {
    self.saveBtn.hidden=NO;
    self.editBtn.hidden=YES;
    [self.genreField setClearButtonMode:UITextFieldViewModeAlways];
    [self.genreField setUserInteractionEnabled:YES];
}

- (IBAction)save:(id)sender {
    self.saveBtn.hidden=YES;
    self.editBtn.hidden=NO;
    [self.genreField setClearButtonMode:UITextFieldViewModeNever];
    [self.genreField setUserInteractionEnabled:NO];
    
    [self.selectedGenre setGenre:self.genreField.text];
    
    AppDelegate *myApp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [myApp saveContext];
    NSString *newGenre=[NSString stringWithFormat:@"Category name was successfully updated to %@", self.selectedGenre.genre];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Categoy name updated!" message:newGenre delegate:self  cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}
@end
