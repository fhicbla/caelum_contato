//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios5065 on 18/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ContatoDao.h"

@interface ListaContatosViewController : UITableViewController

@property ContatoDao *dao;

@end
