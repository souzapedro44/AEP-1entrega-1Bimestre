-- Marido de Aluguel
-- Script de criação do banco de dados (PostgreSQL)
-- Coerente com o Diagrama Entidade-Relacionamento (DER) apresentado em docs/AEP_1Bimestre_Marido_de_Aluguel.pdf

-- Tabela usuarios
-- Centraliza credenciais e dados pessoais. A coluna tipo_usuario distingue clientes de prestadores.
CREATE TABLE usuarios (
    id            SERIAL PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    telefone      VARCHAR(20)  NOT NULL,
    senha_hash    VARCHAR(255) NOT NULL,
    endereco      VARCHAR(150),
    tipo_usuario  VARCHAR(20)  NOT NULL CHECK (tipo_usuario IN ('CLIENTE', 'PRESTADOR')),
    nota_media    NUMERIC(3,2) DEFAULT 0
);

-- Tabela servicos
-- Materialização relacional da classe OfertaServico do diagrama de classes.
-- A chave estrangeira prestador_id é configurada com ON DELETE CASCADE: ao excluir um prestador,
-- todas as suas ofertas são removidas junto, reproduzindo no banco a composição 1:N entre
-- Prestador e OfertaServico do modelo de classes.
CREATE TABLE servicos (
    id             SERIAL PRIMARY KEY,
    prestador_id   INTEGER NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    nome_servico   VARCHAR(100) NOT NULL,
    categoria      VARCHAR(50)  NOT NULL,
    descricao      TEXT,
    raio_atendimento_km INTEGER NOT NULL,
    tipo_cobranca  VARCHAR(20)  NOT NULL CHECK (tipo_cobranca IN ('POR_HORA', 'POR_EMPREITADA')),
    valor_base     NUMERIC(10,2) NOT NULL
);

-- Tabela ordens_servico
-- Materializa a contratação, ligando um cliente a uma oferta de serviço.
CREATE TABLE ordens_servico (
    id             SERIAL PRIMARY KEY,
    cliente_id     INTEGER NOT NULL REFERENCES usuarios(id),
    servico_id     INTEGER NOT NULL REFERENCES servicos(id),
    data_abertura  DATE NOT NULL DEFAULT CURRENT_DATE,
    status         VARCHAR(20) NOT NULL DEFAULT 'ABERTA'
                   CHECK (status IN ('ABERTA', 'ACEITA', 'EM_EXECUCAO', 'CONCLUIDA', 'CANCELADA')),
    valor_final    NUMERIC(10,2)
);

-- Tabela avaliacoes
-- Guarda a reputação verificável do prestador. A restrição UNIQUE em ordem_id garante que
-- cada ordem de serviço concluída produza no máximo uma avaliação.
CREATE TABLE avaliacoes (
    id          SERIAL PRIMARY KEY,
    ordem_id    INTEGER NOT NULL UNIQUE REFERENCES ordens_servico(id),
    nota        INTEGER NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario  TEXT,
    data_registro DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Índices de apoio às buscas mais frequentes (RF03: categoria, preço, nota e distância)
CREATE INDEX idx_servicos_categoria ON servicos(categoria);
CREATE INDEX idx_servicos_prestador ON servicos(prestador_id);
CREATE INDEX idx_ordens_cliente ON ordens_servico(cliente_id);
CREATE INDEX idx_ordens_servico ON ordens_servico(servico_id);
