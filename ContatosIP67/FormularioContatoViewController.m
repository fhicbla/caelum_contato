//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"
#import "Contato.h"
#import "ContatoDao.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _contatoDao = [ContatoDao contatoDaoInstance];
        self.navigationItem.title = @"Cadastro";
        UIBarButtonItem *adiciona = [[UIBarButtonItem alloc] initWithTitle:@"Adiciona" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = adiciona;
    }
    return self;
}

- (void)viewDidLoad {
    //[super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.contato) {
        self.navigationItem.title = @"Alterar";
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Confirmar" style:UIBarButtonItemStylePlain
                                      target:self action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pegaDadosDoFormulario {
    if (!self.contato) {
        self.contato = [Contato new];
    }
    self.contato.nome = [self.nome text];
    self.contato.telefone = [self.telefone text];
    self.contato.endereco = [self.endereco text];
    self.contato.email = [self.email text];
    self.contato.site = [self.site text];
}

- (void)criaContato {
    [self pegaDadosDoFormulario];
    [self.contatoDao adicionaContato:self.contato];
    
    if (self.delegate) {
        [self.delegate contatoAdicionado:self.contato];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)atualizaContato {
    [self pegaDadosDoFormulario];
    
    if (self.delegate) {
        [self.delegate contatoAtualizado:self.contato];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
