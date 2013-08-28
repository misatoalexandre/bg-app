//
//  Genre.m
//  Books
//
//  Created by Misato Tina Alexandre on 8/19/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "Genre.h"
#import "Book.h"


@implementation Genre

@dynamic genre;
@dynamic genreBooks;

-(void)awakeFromInsert{
    [super awakeFromInsert];
    self.genre=@"Category";
}
@end
