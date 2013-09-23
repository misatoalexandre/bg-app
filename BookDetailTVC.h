//
//  BookDetailTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BookGenreTVC.h"
#import "Genre.h"
#import "BookCollectionTVC.h"
#import "Favorite.h"
#import "BookStatusTVC.h"
#import "Status.h"


@protocol BookDetailTVCDelegate;

@interface BookDetailTVC : UIViewController <BookGenreTVCDelegate,BookCollectionTVCDelegate, BookStatusTVCDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextView *notesField;
@property (weak, nonatomic) IBOutlet UITextField *dateAddedField;
@property (weak, nonatomic) IBOutlet UITextField *statusField;

@property (strong, nonatomic) Book *currentBook;
@property (strong, nonatomic) Genre *selectedGenre;
@property (strong, nonatomic) Favorite *selectedCollection;
@property (strong, nonatomic) Status *selectedStatus;
@property (weak, nonatomic) id<BookDetailTVCDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleAlert;
@property (weak, nonatomic) IBOutlet UILabel *statusMissingAlert;





- (IBAction)doneEditingNotes:(id)sender;

- (IBAction)saveNav:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

- (IBAction)textResignFirstResponder:(id)sender;

@end

@protocol BookDetailTVCDelegate
//-(void)bookDetailTVCDelegateSave:(BookDetailTVC *)controller;
-(void)bookDetailTVCDelegateSave;
-(void)bookDetailTVCDelegateCancel:(Book *)bookToDelete;
-(void)bookDetailTVCDelegateSavePush:(BookDetailTVC *)controller;


@end
