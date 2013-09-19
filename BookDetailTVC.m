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
    self.titleField.text=self.currentBook.title;
    self.authorField.text=self.currentBook.author;
    self.notesField.text=self.currentBook.notes;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateAddedField.text=[formatter stringFromDate:self.currentBook.dateAdded];
    self.categoryLabel.text=self.currentBook.genre.genre;
    self.collectionLabel.text=self.currentBook.favorite.favorite;
    self.statusField.text=self.currentBook.status.readingStatus;
    
    self.statusMissingAlert.hidden=YES;
    self.bookTitleAlert.hidden=YES;
   
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
    AppDelegate *myApp=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([segue.identifier isEqualToString:@"addGenre"]) {
        
        BookGenreTVC *bgtvc=(BookGenreTVC *)[segue destinationViewController];
        bgtvc.delegate=self;
        
        bgtvc.managedObjectContext=myApp.managedObjectContext;
    }
    
    if ([segue.identifier isEqualToString:@"addCollection"]) {
        
        BookCollectionTVC *bctvc=(BookCollectionTVC *)[segue destinationViewController];
        bctvc.delegate=self;
        
        bctvc.managedObjectContext=myApp.managedObjectContext;
    }
    if ([segue.identifier isEqualToString:@"addStatus"]) {
        BookStatusTVC *bstvc=(BookStatusTVC *)[segue destinationViewController];
        bstvc.delegate=self;
        bstvc.managedObjectContext=myApp.managedObjectContext;
    }
    
}
-(void)genreWasSelectedOnBookGenreTVC:(BookGenreTVC *)controller  {
    //Passing the selectedGenre's value to the BookDetailTVC and displaying it in genreTableViewCell.
    self.categoryLabel.text=controller.selectedGenre.genre;
    self.selectedGenre=controller.selectedGenre;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)collectionWasSelectedOnBookCollectionTVC:(BookCollectionTVC *)controller{
    //Passing the selectedCollection's value to the BookDetailTVC and displaying it in collectionlTableViewCell.
    self.collectionLabel.text=controller.selectedCollection.favorite;
    self.selectedCollection=controller.selectedCollection;
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)statusWasSelectedOnBookStatusnTVC:(BookStatusTVC *)controller{
    //Passing the selectedStatus's value to the BookDetailTVC and displyaing it in the readingStatusTableView(Cell).
    
    
    if ([controller.selectedStatus.readingStatus isEqualToString:@"Read it"]) {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        NSString *readItDate=[formatter stringFromDate:controller.selectedStatus.updateDate];
        NSString *readStatusWithDate=[NSString stringWithFormat:@"%@ on %@",controller.selectedStatus.readingStatus, readItDate];
        self.statusField.text=readStatusWithDate ;
    }
    else{
        self.statusField.text=controller.selectedStatus.readingStatus;
    }
    self.selectedStatus=controller.selectedStatus;
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)saveCurrentBook{
  
    [self.currentBook setTitle:self.titleField.text];
    [self.currentBook setAuthor:self.authorField.text];
    [self.currentBook setNotes:self.notesField.text];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [self.currentBook setDateAdded:[formatter dateFromString:self.dateAddedField.text]];
    //Saving Genre entity's attribute
    [self.currentBook setGenre:self.selectedGenre];
    [self.currentBook setFavorite:self.selectedCollection];
    [self.currentBook setStatus:self.selectedStatus];
    
}
- (IBAction)save:(id)sender {
    //Saving Book Entity's attributes
    if ([self.titleField.text isEqualToString:@""]) {
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Title Missing" message:@"Please add a book title to save." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [view show];
        self.bookTitleAlert.hidden=NO;
    } else if (self.selectedStatus.readingStatus==nil) {
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Status Missing" message:@"Please select your reading status." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [view show];
        self.statusMissingAlert.hidden=NO;
       
        
        
    }else{
        [self saveCurrentBook];
        [self.delegate bookDetailTVCDelegateSave];
        self.statusMissingAlert.hidden=YES;
        self.bookTitleAlert.hidden=YES;
       
        
        
    }
    
    
}

- (IBAction)saveNav:(id)sender {
   
    if ([self.titleField.text isEqualToString:@""]) {
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Title Missing" message:@"Please add a book title to save." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [view show];
        self.bookTitleAlert.hidden=NO;
    } else if (self.selectedStatus.readingStatus==nil) {
        UIAlertView *view=[[UIAlertView alloc]initWithTitle:@"Status Missing" message:@"Please select your reading status." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [view show];
        self.statusMissingAlert.hidden=NO;
        
        
    }else{
        [self saveCurrentBook];
        [self.delegate bookDetailTVCDelegateSavePush:self];
        self.statusMissingAlert.hidden=YES;
        self.bookTitleAlert.hidden=YES;
        
    
    }

}

-(void)cancel:(id)sender{
    [self.delegate bookDetailTVCDelegateCancel:self.currentBook];
}

- (IBAction)textResignFirstResponder:(UITextField *)sender {
    [self.titleField resignFirstResponder];
    [self.authorField resignFirstResponder];
    [self.dateAddedField resignFirstResponder];
    [self.notesField resignFirstResponder];
}
@end