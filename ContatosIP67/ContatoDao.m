//
//  ContatoDao.m
//  ContatosIP67
//
//  Created by ios5065 on 11/04/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatoDao.h"

@implementation ContatoDao

static ContatoDao *defaultDao = nil;

+ (id) contatoDaoInstance {
    if(!defaultDao) {
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}

- (id) init {
    self = [super init];
    if(self) {
        _contatos = [NSMutableArray new];
    }
    return self;
}

- (void) adicionaContato:(Contato *)contato {
    [self.contatos addObject:contato];
}

- (Contato *)buscaContatoDaPosicao:(NSInteger)posicao {
    return self.contatos[posicao];
}

- (void)removeContatoDaPosicao:(NSInteger)posicao {
    [self.contatos removeObjectAtIndex:posicao];
}

- (NSInteger)buscaPosicaoDoContato:(Contato *)contato {
    return [self.contatos indexOfObject:contato];
}

@end
