-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS OficinaMecanica;
USE OficinaMecanica;

-- Criação das tabelas
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    modelo_ano VARCHAR(100),
    placa VARCHAR(10) UNIQUE,
    idCliente INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Orçamento (
    idOrçamento INT AUTO_INCREMENT PRIMARY KEY,
    valorTotalEstimado DECIMAL(10, 2),
    status VARCHAR(20),
    dataCriacao DATE,
    dataValidade DATE,
    descricaoServico TEXT,
    idCliente INT,
    idVeiculo INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo)
);

CREATE TABLE Equipe (
    idEquipe INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Peças (
    idPeça INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255),
    valorPeça DECIMAL(10, 2)
);

CREATE TABLE Ordem_de_Serviço (
    idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
    dataEmissao DATE,
    valor DECIMAL(10, 2),
    status VARCHAR(20),
    dataConclusao DATE,
    idVeiculo INT,
    idEquipe INT,
    idOrçamento INT,
    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),
    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe),
    FOREIGN KEY (idOrçamento) REFERENCES Orçamento(idOrçamento)
);

CREATE TABLE Mecânico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(255),
    especialidade VARCHAR(100),
    idEquipe INT,
    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)
);

CREATE TABLE orçamento_has_peças (
    idOrçamento INT,
    idPeça INT,
    quantidade INT,
    valor_estimado DECIMAL(10, 2),
    PRIMARY KEY (idOrçamento, idPeça),
    FOREIGN KEY (idOrçamento) REFERENCES Orçamento(idOrçamento),
    FOREIGN KEY (idPeça) REFERENCES Peças(idPeça)
);

CREATE TABLE ordem_serviço_has_peças (
    idOrdemServico INT,
    idPeça INT,
    quantidade INT,
    valor DECIMAL(10, 2),
    PRIMARY KEY (idOrdemServico, idPeça),
    FOREIGN KEY (idOrdemServico) REFERENCES Ordem_de_Serviço(idOrdemServico),
    FOREIGN KEY (idPeça) REFERENCES Peças(idPeça)
);

-- Inserção de dados fictícios
INSERT INTO Cliente (nome, endereco, telefone, email) VALUES
('João Silva', 'Rua das Flores, 123', '1234-5678', 'joao.silva@email.com'),
('Maria Oliveira', 'Rua dos Limoeiros, 456', '8765-4321', 'maria.oliveira@email.com'),
('Carlos Pereira', 'Avenida Brasil, 789', '1122-3344', 'carlos.pereira@email.com');

INSERT INTO Veiculo (modelo_ano, placa, idCliente) VALUES
('Fusca 1975', 'ABC-1234', 1),
('Civic 2020', 'XYZ-5678', 2),
('Ka 2018', 'DEF-9012', 3);

INSERT INTO Orçamento (valorTotalEstimado, status, dataCriacao, dataValidade, descricaoServico, idCliente, idVeiculo) VALUES
(1000.00, 'Aprovado', '2025-04-01', '2025-05-01', 'Troca de óleo e filtro de ar', 1, 1),
(2000.00, 'Em andamento', '2025-04-03', '2025-06-01', 'Revisão completa do motor', 2, 2),
(1500.00, 'Aprovado', '2025-04-04', '2025-05-04', 'Troca de pastilhas de freio e amortecedor', 3, 3);

INSERT INTO Equipe (nome) VALUES
('Equipe A'),
('Equipe B');

INSERT INTO Peças (descricao, valorPeça) VALUES
('Óleo 5W30', 50.00),
('Amortecedor', 200.00),
('Pastilha de freio', 100.00),
('Filtro de ar', 30.00);

INSERT INTO Ordem_de_Serviço (dataEmissao, valor, status, dataConclusao, idVeiculo, idEquipe, idOrçamento) VALUES
('2025-04-04', 550.00, 'Em andamento', '2025-04-06', 1, 1, 1),
('2025-04-05', 300.00, 'Concluída', '2025-04-07', 2, 2, 2),
('2025-04-06', 700.00, 'Em andamento', '2025-04-08', 3, 1, 3);

INSERT INTO Mecânico (nome, endereco, especialidade, idEquipe) VALUES
('Ricardo Souza', 'Rua X, 123', 'Mecânica geral', 1),
('Lucas Almeida', 'Rua Y, 456', 'Suspensão e freios', 2),
('Amanda Silva', 'Rua Z, 789', 'Motor e câmbio', 1);

INSERT INTO orçamento_has_peças (idOrçamento, idPeça, quantidade, valor_estimado) VALUES
(1, 1, 2, 100.00),
(2, 2, 4, 800.00),
(3, 3, 1, 100.00);

INSERT INTO ordem_serviço_has_peças (idOrdemServico, idPeça, quantidade, valor) VALUES
(1, 1, 2, 100.00),
(2, 2, 4, 800.00),
(3, 3, 1, 100.00);

-- Finalizando o processo
SET FOREIGN_KEY_CHECKS = 1;


-- 1. Consulta de informações de clientes e seus veículos
SELECT c.idCliente, c.nome, v.idVeiculo, v.modelo_ano, v.placa
FROM Cliente c
JOIN Veiculo v ON c.idCliente = v.idCliente;

-- 2. Consultar orçamentos de um cliente específico
SELECT o.idOrçamento, o.valorTotalEstimado, o.status, o.dataCriacao, o.dataValidade
FROM Orçamento o
JOIN Cliente c ON o.idCliente = c.idCliente
WHERE c.nome = 'Ricardo Souza';  -- Substitua pelo nome do cliente que deseja consultar

-- 3. Consultar as ordens de serviço de um veículo específico
SELECT os.idOrdemServico, os.dataEmissao, os.valor, os.status, os.dataConclusao
FROM Ordem_de_Serviço os
JOIN Veiculo v ON os.idVeiculo = v.idVeiculo
WHERE v.placa = 'ABC1234';  -- Substitua pela placa do veículo

