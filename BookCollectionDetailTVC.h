//
//  BookCollectionDetailTVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 9/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorite.h"
@protocol BookCollectionDetailTVCDelegate;
@interface BookCollectionDetailTVC : UITableViewController





@property (weak, nonatomic) IBOutlet UITextField *collectionField;

@property (strong, nonatomic) Favorite *currentFavorite;
@property (weak, nonatomic) id<BookCollectionDetailTVCDelegate> delegate;
- (IBAction)removeKeyboard:(id)sender;
- (IBAction)save:(id)sender;
@end

@protocol BookCollectionDetailTVCDelegate
-(void)bookCollectionDetailTVCDelegateSave:(BookCollectionDetailTVC *)controller;
@end



