//
//  NewCollectionTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"


@protocol NewCollectionTVCDelegate;

@interface NewCollectionTVC : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *collectionField;
@property (strong, nonatomic) Favorite *currentFavorite;
@property (weak, nonatomic) id<NewCollectionTVCDelegate> delegate;
- (IBAction)textResignFirstResponder:(id)sender;

- (IBAction)save:(id)sender;
@end

@protocol NewCollectionTVCDelegate
-(void)newCollectionTVCSave:(NewCollectionTVC *)controller;
@end
