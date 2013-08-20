//
//  BookDetailTVC.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "BookDetailTVC.h"
#import "AppDelegate.h"


@interface BookDetailTVC ()

@end

@implementation BookDetailTVC

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
    self.titleField.text=self.currentBook.title;
    self.authorField.text=self.currentBook.author;
    self.notesField.text=self.currentBook.notes;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateAddedField.text=[formatter stringFromDate:self.currentBook.dateAdded];
    

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



#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if ([segue.identifier isEqualToString:@"addGenre"]) {
            
            BookGenreTVC *bgtvc=(BookGenreTVC *)[segue destinationViewController];
            bgtvc.delegate=self;
            
            AppDelegate *myApp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            bgtvc.managedObjectContext=myApp.managedObjectContext;
        }
}
-(void)genreWasSelectedOnBookGenreTVC:(BookGenreTVC *)controller  {
    //Passing the selectedGenre's value to the BookDetailTVC and displaying it in genreTableViewCell.
    self.genreTableViewCell.textLabel.text=controller.selectedGenre.genre;
    
    self.selectedGenre=controller.selectedGenre;
    [controller.navigationController popViewControllerAnimated:YES];
    
    
}



- (IBAction)save:(id)sender {
    //Saving Book Entity's attributes
    [self.currentBook setTitle:self.titleField.text];
    [self.currentBook setAuthor:self.authorField.text];
    [self.currentBook setNotes:self.notesField.text];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [self.currentBook setDateAdded:[formatter dateFromString:self.dateAddedField.text]];
    
    //Saving Genre entity's attribute
    [self.currentBook setGenre:self.selectedGenre];
    
    [self.delegate bookDetailTVCDelegateSave:self];
     
}
@end
