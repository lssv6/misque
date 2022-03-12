TRUNCATE TABLE
    QUESTIONARIO_SOCIOECONOMICO,
    DADOS_DA_REDACAO,
    DADOS_DA_PROVA_OBJETIVA,
    APLICACOES_DE_PROVAS,
    ATENDIMENTO_ESPECIALIZADO_E_ESPECIFICOS,
    ATENDIMENTO_ESPECIFICOS,
    ATENDIMENTO_ESPECIALIZADOS,
    PARTICIPANTES,
    ESCOLAS,
    MUNICIPIOS,
    ESTADOS CASCADE;

-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA ESTADOS 44 --
INSERT INTO ESTADOS
	SELECT CO_UF_NASCIMENTO, SG_UF_NASCIMENTO FROM INSCRITOS
        WHERE
            CO_UF_NASCIMENTO <> 0 AND
            SG_UF_NASCIMENTO <> ''
    ON CONFLICT DO NOTHING;

-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS ESPECIFICAMENTE SOBRE MUNICIPIOS DE ESCOLAS NA TABELA MUNICIPIOS  --
INSERT INTO MUNICIPIOS
	SELECT CO_MUNICIPIO_ESC, CO_UF_ESC, NO_MUNICIPIO_ESC FROM INSCRITOS
    	WHERE CO_MUNICIPIO_ESC <> 0 AND
              CO_UF_ESC <> 0 AND
              NO_MUNICIPIO_ESC <> ''
    ON CONFLICT DO NOTHING;

-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA MUNICIPIOS 49 --
INSERT INTO MUNICIPIOS
	SELECT CO_MUNICIPIO_NASCIMENTO, CO_UF_NASCIMENTO, NO_MUNICIPIO_NASCIMENTO FROM INSCRITOS
    	WHERE CO_MUNICIPIO_NASCIMENTO <> 0 AND
              CO_UF_NASCIMENTO <> 0 AND
              NO_MUNICIPIO_NASCIMENTO <> ''
    ON CONFLICT DO NOTHING;

-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA MUNICIPIOS 49 --
INSERT INTO MUNICIPIOS
	SELECT CO_MUNICIPIO_PROVA, CO_UF_PROVA, NO_MUNICIPIO_PROVA FROM INSCRITOS
    	WHERE CO_MUNICIPIO_PROVA <> 0 AND
              CO_UF_PROVA <> 0 AND
              NO_MUNICIPIO_PROVA <> ''
    ON CONFLICT DO NOTHING;


-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA ESCOLA  --
INSERT INTO ESCOLAS
    SELECT
        CO_ESCOLA,
        CO_MUNICIPIO_ESC,
        TP_ESCOLA,
        TP_DEPENDENCIA_ADM_ESC,
        TP_LOCALIZACAO_ESC,
        TP_SIT_FUNC_ESC
    FROM INSCRITOS WHERE
    	CO_ESCOLA<>0 AND
        CO_MUNICIPIO_ESC<>0 AND
        CO_UF_ESC<>0
    ON CONFLICT DO NOTHING;


-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA PARTICIPANTES  --
INSERT INTO PARTICIPANTES
    SELECT
        NU_INSCRICAO,
        NU_ANO,
        NU_IDADE,
        TP_SEXO,
        TP_ESTADO_CIVIL,
        TP_COR_RACA,
        TP_NACIONALIDADE,
        TP_ST_CONCLUSAO,
        TP_ANO_CONCLUIU,
        TP_ENSINO,
        IN_TREINEIRO
    FROM INSCRITOS ON CONFLICT DO NOTHING;

INSERT INTO ESCOLAS_DOS_PARTICIPANTES(NU_INSCRICAO,CO_ESCOLA_ESTUDA)           SELECT NU_INSCRICAO,CO_ESCOLA               FROM INSCRITOS WHERE CO_ESCOLA<>0 ON CONFLICT DO NOTHING;
INSERT INTO NASCIMENTOS_DE_PARTICIPANTES(NU_INSCRICAO,CO_MUNICIPIO_NASCIMENTO) SELECT NU_INSCRICAO,CO_MUNICIPIO_NASCIMENTO FROM INSCRITOS WHERE CO_MUNICIPIO_NASCIMENTO<>0 ON CONFLICT DO NOTHING;
INSERT INTO RESIDENCIA_DE_PARTICIPANTES(NU_INSCRICAO,CO_MUNICIPIO_RESIDENCIA)  SELECT NU_INSCRICAO,CO_MUNICIPIO_RESIDENCIA FROM INSCRITOS WHERE CO_MUNICIPIO_RESIDENCIA<>0 ON CONFLICT DO NOTHING;
INSERT INTO APLICACOES_DE_PROVAS(NU_INSCRICAO,CO_MUNICIPIO_PROVA)              SELECT NU_INSCRICAO,CO_MUNICIPIO_PROVA      FROM INSCRITOS WHERE CO_MUNICIPIO_PROVA<>0 ON CONFLICT DO NOTHING;

-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA ATENDIMENTO_ESPECIFICO  --
INSERT INTO ATENDIMENTO_ESPECIFICOS
    SELECT 
        NU_INSCRICAO,
        IN_GESTANTE,
        IN_LACTANTE,
        IN_IDOSO,
        IN_ESTUDA_CLASSE_HOSPITALAR
    FROM INSCRITOS
    WHERE
        IN_GESTANTE=TRUE OR
        IN_LACTANTE=TRUE OR
        IN_IDOSO=TRUE OR
        IN_ESTUDA_CLASSE_HOSPITALAR=TRUE
    ON CONFLICT DO NOTHING;

-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA PARTICIPANTES  --
INSERT INTO ATENDIMENTO_ESPECIALIZADO_E_ESPECIFICOS
    SELECT 
        NU_INSCRICAO,
        IN_SEM_RECURSO,
        IN_BRAILLE,
        IN_AMPLIADA_24,
        IN_AMPLIADA_18,
        IN_LEDOR,
        IN_ACESSO,
        IN_TRANSCRICAO,
        IN_LIBRAS,
        IN_TEMPO_ADICIONAL,
        IN_LEITURA_LABIAL,
        IN_MESA_CADEIRA_RODAS,
        IN_MESA_CADEIRA_SEPARADA,
        IN_APOIO_PERNA,
        IN_GUIA_INTERPRETE,
        IN_COMPUTADOR,
        IN_CADEIRA_ESPECIAL,
        IN_CADEIRA_CANHOTO,
        IN_CADEIRA_ACOLCHOADA,
        IN_PROVA_DEITADO,
        IN_MOBILIARIO_OBESO,
        IN_LAMINA_OVERLAY,
        IN_PROTETOR_AURICULAR,
        IN_MEDIDOR_GLICOSE,
        IN_MAQUINA_BRAILE,
        IN_SOROBAN,
        IN_MARCA_PASSO,
        IN_SONDA,
        IN_MEDICAMENTOS,
        IN_SALA_INDIVIDUAL,
        IN_SALA_ESPECIAL,
        IN_SALA_ACOMPANHANTE,
        IN_MOBILIARIO_ESPECIFICO,
        IN_MATERIAL_ESPECIFICO,
        IN_NOME_SOCIAL
    FROM INSCRITOS WHERE
        IN_SEM_RECURSO=TRUE OR
        IN_BRAILLE=TRUE OR
        IN_AMPLIADA_24=TRUE OR
        IN_AMPLIADA_18=TRUE OR
        IN_LEDOR=TRUE OR
        IN_ACESSO=TRUE OR
        IN_TRANSCRICAO=TRUE OR
        IN_LIBRAS=TRUE OR
        IN_TEMPO_ADICIONAL=TRUE OR
        IN_LEITURA_LABIAL=TRUE OR
        IN_MESA_CADEIRA_RODAS=TRUE OR
        IN_MESA_CADEIRA_SEPARADA=TRUE OR
        IN_APOIO_PERNA=TRUE OR
        IN_GUIA_INTERPRETE=TRUE OR
        IN_COMPUTADOR=TRUE OR
        IN_CADEIRA_ESPECIAL=TRUE OR
        IN_CADEIRA_CANHOTO=TRUE OR
        IN_CADEIRA_ACOLCHOADA=TRUE OR
        IN_PROVA_DEITADO=TRUE OR
        IN_MOBILIARIO_OBESO=TRUE OR
        IN_LAMINA_OVERLAY=TRUE OR
        IN_PROTETOR_AURICULAR=TRUE OR
        IN_MEDIDOR_GLICOSE=TRUE OR
        IN_MAQUINA_BRAILE=TRUE OR
        IN_SOROBAN=TRUE OR
        IN_MARCA_PASSO=TRUE OR
        IN_SONDA=TRUE OR
        IN_MEDICAMENTOS=TRUE OR
        IN_SALA_INDIVIDUAL=TRUE OR
        IN_SALA_ESPECIAL=TRUE OR
        IN_SALA_ACOMPANHANTE=TRUE OR
        IN_MOBILIARIO_ESPECIFICO=TRUE OR
        IN_MATERIAL_ESPECIFICO=TRUE OR
        IN_NOME_SOCIAL=TRUE
    ON CONFLICT DO NOTHING;

-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA ATENDIMENTOS_ESPECIALIZADOS  --
INSERT INTO ATENDIMENTO_ESPECIALIZADOS
    SELECT 
        NU_INSCRICAO,
        IN_BAIXA_VISAO,
        IN_CEGUEIRA,
        IN_SURDEZ,
        IN_DEFICIENCIA_AUDITIVA,
        IN_SURDO_CEGUEIRA,
        IN_DEFICIENCIA_FISICA,
        IN_DEFICIENCIA_MENTAL,
        IN_DEFICIT_ATENCAO,
        IN_DISLEXIA,
        IN_DISCALCULIA,
        IN_AUTISMO,
        IN_VISAO_MONOCULAR,
        IN_OUTRA_DEF
    FROM INSCRITOS
    WHERE
        IN_BAIXA_VISAO=TRUE OR
        IN_CEGUEIRA=TRUE OR
        IN_SURDEZ=TRUE OR
        IN_DEFICIENCIA_AUDITIVA=TRUE OR
        IN_SURDO_CEGUEIRA=TRUE OR
        IN_DEFICIENCIA_FISICA=TRUE OR
        IN_DEFICIENCIA_MENTAL=TRUE OR
        IN_DEFICIT_ATENCAO=TRUE OR
        IN_DISLEXIA=TRUE OR
        IN_DISCALCULIA=TRUE OR
        IN_AUTISMO=TRUE OR
        IN_VISAO_MONOCULAR=TRUE OR
        IN_OUTRA_DEF=TRUE
    ON CONFLICT DO NOTHING;

-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA DADOS_DA_PROVA_OBJETIVA  --
INSERT INTO DADOS_DA_PROVA_OBJETIVA
    SELECT 
        NU_INSCRICAO,
        TP_PRESENCA_CN,
        TP_PRESENCA_CH,
        TP_PRESENCA_LC,
        TP_PRESENCA_MT,
        CO_PROVA_CN,
        CO_PROVA_CH,
        CO_PROVA_LC,
        CO_PROVA_MT,
        NU_NOTA_CN,
        NU_NOTA_CH,
        NU_NOTA_LC,
        NU_NOTA_MT,
        TX_RESPOSTAS_CN,
        TX_RESPOSTAS_CH,
        TX_RESPOSTAS_LC,
        TX_RESPOSTAS_MT,
        TP_LINGUA,
        TX_GABARITO_CN,
        TX_GABARITO_CH,
        TX_GABARITO_LC,
        TX_GABARITO_MT
    FROM INSCRITOS
    ON CONFLICT DO NOTHING;

-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA TABELA DADOS_DA_REDACAO  --
INSERT INTO DADOS_DA_REDACAO
    SELECT 
        NU_INSCRICAO,TP_STATUS_REDACAO,NU_NOTA_COMP1,NU_NOTA_COMP2,NU_NOTA_COMP3,NU_NOTA_COMP4,NU_NOTA_COMP5,NU_NOTA_REDACAO
    FROM INSCRITOS ON CONFLICT DO NOTHING;


-- INSERE DADOS PROVENIENTES DA TABELA INSCRITOS NA QUESTIONARIO_SOCIOECONOMICO  --
INSERT INTO QUESTIONARIO_SOCIOECONOMICO
    SELECT 
        NU_INSCRICAO,Q001,Q002,Q003,Q004,Q005,Q006,Q007,Q008,Q009,Q010,Q011,Q012,Q013,Q014,Q015,Q016,Q017,Q018,Q019,Q020,Q021,Q022,Q023,Q024,Q025
    FROM INSCRITOS ON CONFLICT DO NOTHING;
