//
//  AKOEasyNavigationController.h
//  EasyTableView
//
//  Created by Adrian on 11/22/09.
//  Copyright 2009 akosma software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKOEasyTableViewControllerDelegate.h"

@interface AKOEasyNavigationController : UINavigationController <AKOEasyTableViewControllerDelegate>
{
@private
    NSArray *_dataSequence;
    NSString *_dataSequenceFileName;
}

@property (nonatomic, retain) NSArray *dataSequence;
@property (nonatomic, copy) NSString *dataSequenceFileName;

- (void)loadNextScreen;

@end
