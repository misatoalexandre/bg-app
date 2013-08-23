//
//  EditGenreVC.h
//  Books
//
//  Created by Misato Tina Alexandre on 8/22/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Genre.h"


@interface EditGenreVC : UIViewController
{
    unsigned int count;
}
@property (strong, nonatomic) Genre *selectedGenre;
@property (weak, nonatomic) IBOutlet UITextField *genreField;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;




- (IBAction)edit:(id)sender;
- (IBAction)save:(id)sender;

@end
