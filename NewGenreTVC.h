//
//  NewGenreTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Genre.h"

@protocol NewGenreTVCDelegate;

@interface NewGenreTVC : UITableViewController


@property (weak, nonatomic) IBOutlet UITextField *genreField;
@property (strong, nonatomic) Genre *currentGenre;
@property (weak, nonatomic) id<NewGenreTVCDelegate> delegate;

- (IBAction)save:(id)sender;

@end

@protocol NewGenreTVCDelegate
-(void) newGenreTVCSave:(NewGenreTVC *)controller;
@end
