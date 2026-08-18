create database Goiaba_Restaurante;

use  Goiaba_Restaurante;                            -- criacao do banco e das tabelas

create table Pedidos(
idPedido int not null auto_increment,
dataPedido date not null,
condicao enum('F','NF'),   -- f = feito , nf = nao feito
valorTotal decimal(5,2),
id_Cliente int,
id_Atentende int, 
id_Cardapio int,
primary key (idPedido)
);

create table Cardapio(
idCardapio int not null auto_increment,
nomePrato varchar(45) not null,
valorPrato decimal(5,2) not null,
primary key (idCardapio)
);

create table Cliente(
idCliente int not null auto_increment,
nomeCliente varchar(45) not null,
numeroCelular varchar(45) not null,
endereco varchar (45) not null,
email varchar(45),
primary key (idCliente)
);

create table Atendentes(
idAtendente int not null auto_increment,
nomeAtendente varchar (45) not null,
login varchar (45) not null,
senha varchar(100) not null,
primary key (idAtendente)	
);

create table Dono(
idDono int not null auto_increment,
nomeDono varchar(45) not null,
login varchar (45) not null,
senha varchar(100) not null,
primary key (idDono)
);

create table Pagamentos(
idPagamentos int not null auto_increment,
metodoPagamento varchar (45) not null,
valor decimal (5,2) not null, 
statusPagamento enum ('PG','NPG'), -- Pg = pago, npg = nao pago
dataPagamento date,
id_Pedido int,
primary key (idPagamentos)
);

create table Caixa(
idCaixa int not null auto_increment,
dataMovimento date not null,
tipoMovimento varchar (45) not null, 
valor decimal (5,2) not null,
decricao text (100),
id_Pagamentos int, 
id_Dono int,
id_fornecedor int,
id_Produto int,
primary key (idcaixa)
);

create table Produto(
idProduto int not null auto_increment,
nomeProduto varchar (45) not null,
descricaoProduto varchar (45),
preco decimal(5,2) not null,
quantidadeEstoque int not null,
validade date not null,
id_Fornecedor int,
primary key (idProduto)
);

create table Delivery(
idDelivery int not null auto_increment,
statusEntrega enum ('F', 'NF') not null,
localizacaoGPS varchar (45),
id_Pedido int,
id_Pagamento int,
primary key (idDelivery)
);

create table Fornecedor(
idfornecedor int not null auto_increment,
nomefornecedor varchar (45) not null,
numeroCelular varchar (45) not null,
produto varchar (45) not null,
primary key (idfornecedor)
);

create table itemPedido(
id_Pedido int,
id_Produto int 
);

show tables;
                                            -- criacao das Fks
alter table Pedidos
add constraint fk_Cliente
foreign key (id_Cliente) references Cliente (idCliente);            

alter table Pedidos
add constraint fk_Atendente
foreign key (id_Atentende) references Atendentes (idAtendente);  

alter table Pedidos
add constraint fk_Cardapio
foreign key (id_Cardapio) references Cardapio (idCardapio);

alter table caixa 
add constraint fk_Pagamentos
foreign key (id_Pagamentos) references Pagamentos (idPagamentos);

alter table caixa
add constraint fk_Dono
foreign key (id_Dono) references Dono (idDono);

alter table caixa
add constraint fk_Fornecedor
foreign key (id_Fornecedor) references Fornecedor (idFornecedor);

alter table caixa 
add constraint fk_Produto
foreign key (id_Produto) references Produto (idProduto);

alter table Pagamentos
add constraint fk_Pedido
foreign key (id_Pedido) references Pedidos (idPedido);

alter table Delivery
add constraint fk_Pedidos
foreign key (id_Pedido) references Pedidos (idPedido);

alter table Delivery 
add constraint fk_Pagamento
foreign key (id_Pagamento) references Pagamentos (idPagamentos);   

alter table Produto 
add constraint fk_Fornecedo
foreign key (id_Fornecedor) references Fornecedor (idfornecedor);

alter table itemPedido
add constraint fk_Pedidos02
foreign key (id_Pedido) references Pedidos (idPedido);

alter table itemPedido
add constraint fk_Produtos02
foreign key (id_Produto) references Produto (idProduto);          

                                                                    -- incerindo dados 
insert into
Cliente (nomeCliente, numeroCelular, endereco, email)
VALUES
('João Silva', '71999990001', 'Rua das Flores, 100', 'joao@email.com'),
('Maria Oliveira', '71999990002', 'Av. Central, 250', 'maria@email.com'),
('Carlos Souza', '71999990003', 'Rua Bahia, 80', 'carlos@email.com'),
('Ana Santos', '71999990004', 'Rua do Sol, 150', 'ana@email.com'),
('Pedro Lima', '71999990005', 'Av. Brasil, 300', 'pedro@email.com'); 

INSERT INTO Atendentes (nomeAtendente, login, senha)
VALUES
('Fernanda Costa', 'fernanda', '123456'),
('Lucas Pereira', 'lucas', '123456'),
('Juliana Rocha', 'juliana', '123456'),
('Bruno Almeida', 'bruno', '123456'),
('Patrícia Gomes', 'patricia', '123456');

INSERT INTO Dono (nomeDono, login, senha) -- Restaurante é uma sociedade por isso tem varios donos 
VALUES
('Ricardo Menezes', 'ricardo', '123456'),
('Marcos Silva', 'marcos', '123456'),
('Paulo Souza', 'paulo', '123456'),
('Eduardo Lima', 'eduardo', '123456'),
('Roberto Costa', 'roberto', '123456');  

INSERT INTO Cardapio (nomePrato, valorPrato)
VALUES
('Hamburguer Artesanal', 32.90),
('Pizza Calabresa', 49.90),
('Lasanha Bolonhesa', 38.50),
('Frango Grelhado', 29.90),
('Camarao Empanado ', 69.90); 

INSERT INTO Fornecedor (nomeFornecedor, numeroCelular, produto)
VALUES
('Distribuidora Bahia', '7133331111', 'Carnes'),
('Hortifruti Salvador', '7133332222', 'Verduras'),
('Camarao Brasil', '7133333333', 'Frutos do Mar'),
('Padaria Central', '7133334444', 'Pães'),
('Laticínios Boa Vista', '7133335555', 'Queijos');

INSERT INTO Produto
(nomeProduto, descricaoProduto, preco, quantidadeEstoque, validade, id_Fornecedor)
VALUES
('Camarao', 'Camarao Pistola', 80.90, 30, '2026-08-10', 1),
('Alface', 'Alface Crespa', 4.50, 50, '2026-07-25', 2),
('Frango', 'Frango Congelado', 16.50, 40, '2027-01-15', 3),
('Pão de Hambúrguer', 'Pão Brioche', 2.50, 100, '2026-07-20', 4),
('Queijo Mussarela', 'Queijo Fatiado', 35.00, 20, '2026-08-05', 5);

insert into Pedidos
(dataPedido, condicao, valorTotal, id_Cliente, id_Atentende, id_Cardapio)
VALUES
('2026-07-15', 'F', 32.90, 1, 1, 1),
('2026-07-15', 'F', 49.90, 2, 2, 2),
('2026-07-15', 'NF', 38.50, 3, 3, 3),
('2026-07-16', 'F', 29.90, 4, 4, 4),
('2026-07-16', 'NF', 12.00, 5, 5, 5);

INSERT INTO Pagamentos
(metodoPagamento, valor, statusPagamento, dataPagamento, id_Pedido)
VALUES
('PIX', 32.90, 'PG', '2026-07-15', 1),
('Cartão de Crédito', 49.90, 'PG', '2026-07-15', 2),
('Dinheiro', 38.50, 'NPG', NULL, 3),
('PIX', 29.90, 'PG', '2026-07-16', 4),
('Cartão de Débito', 12.00, 'NPG', NULL, 5);

INSERT INTO Delivery
(statusEntrega, localizacaoGPS, id_Pedido, id_Pagamento)
VALUES
('F', 'Salvador - Pituba', 1, 1),
('F', 'Salvador - Itaigara', 2, 2),
('NF', 'Salvador - Barra', 3, 3),
('F', 'Salvador - Brotas', 4, 4),
('NF', 'Salvador - Imbuí', 5, 5);

INSERT INTO Caixa
(dataMovimento, tipoMovimento, valor, decricao, id_Pagamentos, id_Dono, id_Fornecedor, id_Produto)
VALUES
('2026-07-15', 'Entrada', 32.90, 'Venda do Pedido 1', 1, 1, 1, 1),
('2026-07-15', 'Entrada', 49.90, 'Venda do Pedido 2', 2, 2, 2, 2),
('2026-07-15', 'Saída', 45.90, 'Compra de Carne', 3, 3, 1, 1),
('2026-07-16', 'Entrada', 29.90, 'Venda do Pedido 4', 4, 4, 3, 3),
('2026-07-16', 'Saída', 35.00, 'Compra de Queijo', 5, 5, 5, 5);

INSERT INTO itemPedido (id_Pedido, id_Produto)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);
                                                     -- selects 
select * from caixa;                                                             
select * from Atendentes;
select * from Cardapio;
select * from Cliente;
select * from Delivery;
select * from Dono;
select * from itemPedido;
select * from Fornecedor;
select * from Pagamentos;
select * from Pedidos;
select * from produto;
select nomePrato , valorPrato from Cardapio
where valorPrato >= '40.00';
select metodoPagamento , valor , id_Pedido from Pagamentos
where dataPagamento = '2026-07-15';
                                                                     -- updates
UPDATE Cliente
SET
nomeCliente = 'João Pedro Silva',
numeroCelular = '71988887777',
endereco = 'Rua das Palmeiras, 250',
email = 'joaopedro@email.com'
WHERE idCliente = 1;

UPDATE Atendentes
SET
nomeAtendente = 'Fernanda Almeida',
login = 'fernanda.almeida',
senha = 'novaSenha123'
WHERE idAtendente = 1;

UPDATE Dono
SET
nomeDono = 'Ricardo Oliveira',
login = 'ricardo.oliveira',
senha = 'admin123'
WHERE idDono = 1;

UPDATE Cardapio
SET
nomePrato = 'Pizza Portuguesa',
valorPrato = 54.90
WHERE idCardapio = 2;

UPDATE Fornecedor
SET
nomeFornecedor = 'Distribuidora Nordeste',
numeroCelular = '71977776666',
produto = 'Alimentos'
WHERE idFornecedor = 1;

UPDATE Produto
SET
nomeProduto = 'Queijo Cheddar',
descricaoProduto = 'Queijo Cheddar Fatiado',
preco = 39.90,
quantidadeEstoque = 35,
validade = '2026-09-10'
WHERE idProduto = 5;

UPDATE Pedidos
SET
dataPedido = '2026-07-18',
condicao = 'F',
valorTotal = 59.90
WHERE idPedido = 3;

UPDATE Pagamentos
SET
metodoPagamento = 'PIX',
valor = 59.90,
statusPagamento = 'PG',
dataPagamento = '2026-07-18'
WHERE idPagamentos = 3;

UPDATE Delivery
SET
statusEntrega = 'F',
localizacaoGPS = 'Salvador - Caminho das Árvores'
WHERE idDelivery = 3;

UPDATE Caixa
SET
dataMovimento = '2026-07-18',
tipoMovimento = 'Entrada',
valor = 59.90,
decricao = 'Pagamento atualizado do Pedido 3'
WHERE idCaixa = 3;
                                                            -- Delets 
DELETE FROM itemPedido
WHERE id_Pedido = 5;

DELETE FROM Delivery
WHERE idDelivery = 5;

DELETE FROM Caixa
WHERE idCaixa = 5;

DELETE FROM Pagamentos
WHERE idPagamentos = 5;

DELETE FROM Pedidos
WHERE idPedido = 5;

DELETE FROM Produto
WHERE idProduto = 5;

DELETE FROM Fornecedor
WHERE idFornecedor = 5;

DELETE FROM Cardapio
WHERE idCardapio = 5;

DELETE FROM Cliente
WHERE idCliente = 5;

DELETE FROM Atendentes
WHERE idAtendente = 5;

DELETE FROM Dono
WHERE idDono = 5;