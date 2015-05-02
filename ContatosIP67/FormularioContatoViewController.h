//
//  ViewController.h
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ContatoDao.h"
#import "FormularioContatoViewController.h"
#import <CoreLocation/CoreLocation.h>

@protocol FormularioContatoViewControllerDelegate <NSObject>

- (void)contatoAtualizado:(Contato *)contato;
- (void)contatoAdicionado:(Contato *)contato;

@end

@interface FormularioContatoViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property IBOutlet UITextField *nome;
@property IBOutlet UITextField *telefone;
@property IBOutlet UITextField *email;
@property IBOutlet UITextField *endereco;
@property IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UIButton *botaoFoto;
@property (weak, nonatomic) IBOutlet UITextField *latitude;
@property (weak, nonatomic) IBOutlet UITextField *longitude;

@property (strong) ContatoDao *contatoDao;
@property (strong) Contato *contato;

@property (weak) id<FormularioContatoViewControllerDelegate> delegate;

- (void)pegaDadosDoFormulario;
- (void)criaContato;
- (IBAction)selecionaFoto:(id)sender;

@end

