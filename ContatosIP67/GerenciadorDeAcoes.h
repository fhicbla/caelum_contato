//
//  GerenciadorDeAcoes.h
//  ContatosIP67
//
//  Created by ios5065 on 25/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Contato.h"

@interface GerenciadorDeAcoes : NSObject<UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property Contato *contato;
@property UIViewController *controller;

- (id)initWithContato:(Contato *)contato;
- (void)acoesDoController:(UIViewController *)controller;
- (void)abrirAplicativoComURL: (NSString *)url;
- (void)ligar;
- (void)abrirSite;
- (void)mostrarMapa;
- (void)enviarEmail;

@end
