PGDMP         5                }            loja_confeccao    13.20    13.20 m    >           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            @           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            A           1262    16542    loja_confeccao    DATABASE     ]   CREATE DATABASE loja_confeccao WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'pt-BR';
    DROP DATABASE loja_confeccao;
                postgres    false            �            1255    16704 8   autenticar_usuario(character varying, character varying)    FUNCTION     d  CREATE FUNCTION public.autenticar_usuario(p_username character varying, p_senha character varying) RETURNS TABLE(id integer, username character varying, nome_completo character varying, email character varying, permissoes jsonb, id_colaborador integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        u.id,
        u.username,
        u.nome_completo,
        u.email,
        u.permissoes,
        u.id_colaborador
    FROM 
        usuario u
    WHERE 
        u.username = p_username 
        AND u.senha_hash = md5(p_senha)  -- Usando MD5 aqui
        AND u.ativo = TRUE;
END;
$$;
 b   DROP FUNCTION public.autenticar_usuario(p_username character varying, p_senha character varying);
       public          postgres    false            �            1255    16705    registrar_login(integer)    FUNCTION     �   CREATE FUNCTION public.registrar_login(p_user_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE usuario 
    SET ultimo_login = CURRENT_TIMESTAMP
    WHERE id = p_user_id;
END;
$$;
 9   DROP FUNCTION public.registrar_login(p_user_id integer);
       public          postgres    false            �            1255    16651 N   sp_abrir_rnc(date, text, integer, integer, integer, integer, integer, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.sp_abrir_rnc(p_data_abertura date, p_descricao text, p_id_produto integer, p_id_setor integer, p_id_colaborador integer, p_id_tipo_nc integer, p_id_status integer, p_id_cliente integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO rnc (data_abertura, descricao, id_produto, id_setor, id_colaborador, id_tipo_nc, id_status, id_cliente)
    VALUES (p_data_abertura, p_descricao, p_id_produto, p_id_setor, p_id_colaborador, p_id_tipo_nc, p_id_status, p_id_cliente);
END;
$$;
 �   DROP PROCEDURE public.sp_abrir_rnc(p_data_abertura date, p_descricao text, p_id_produto integer, p_id_setor integer, p_id_colaborador integer, p_id_tipo_nc integer, p_id_status integer, p_id_cliente integer);
       public          postgres    false            �            1259    16637    acao_corretiva    TABLE     �   CREATE TABLE public.acao_corretiva (
    id integer NOT NULL,
    id_rnc integer,
    descricao text,
    data_execucao date,
    id_responsavel integer
);
 "   DROP TABLE public.acao_corretiva;
       public         heap    postgres    false            �            1259    16635    acao_corretiva_id_seq    SEQUENCE     �   CREATE SEQUENCE public.acao_corretiva_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.acao_corretiva_id_seq;
       public          postgres    false    215            B           0    0    acao_corretiva_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.acao_corretiva_id_seq OWNED BY public.acao_corretiva.id;
          public          postgres    false    214            �            1259    16545    cliente    TABLE     �   CREATE TABLE public.cliente (
    id integer NOT NULL,
    nome character varying(100),
    cnpj character varying(20),
    email character varying(100),
    telefone character varying(20)
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            �            1259    16543    cliente_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cliente_id_seq;
       public          postgres    false    201            C           0    0    cliente_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;
          public          postgres    false    200            �            1259    16577    colaborador    TABLE     �   CREATE TABLE public.colaborador (
    id integer NOT NULL,
    nome character varying(100),
    matricula character varying(20),
    cargo character varying(50)
);
    DROP TABLE public.colaborador;
       public         heap    postgres    false            �            1259    16575    colaborador_id_seq    SEQUENCE     �   CREATE SEQUENCE public.colaborador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.colaborador_id_seq;
       public          postgres    false    209            D           0    0    colaborador_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.colaborador_id_seq OWNED BY public.colaborador.id;
          public          postgres    false    208            �            1259    16585    produto    TABLE     �   CREATE TABLE public.produto (
    id integer NOT NULL,
    nome character varying(100),
    codigo_referencia character varying(50),
    descricao text
);
    DROP TABLE public.produto;
       public         heap    postgres    false            �            1259    16583    produto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.produto_id_seq;
       public          postgres    false    211            E           0    0    produto_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.id;
          public          postgres    false    210            �            1259    16596    rnc    TABLE     �   CREATE TABLE public.rnc (
    id integer NOT NULL,
    data_abertura date,
    descricao text,
    id_produto integer,
    id_setor integer,
    id_colaborador integer,
    id_tipo_nc integer,
    id_status integer,
    id_cliente integer
);
    DROP TABLE public.rnc;
       public         heap    postgres    false            �            1259    16594 
   rnc_id_seq    SEQUENCE     �   CREATE SEQUENCE public.rnc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.rnc_id_seq;
       public          postgres    false    213            F           0    0 
   rnc_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE public.rnc_id_seq OWNED BY public.rnc.id;
          public          postgres    false    212            �            1259    16569    setor    TABLE     �   CREATE TABLE public.setor (
    id integer NOT NULL,
    nome character varying(100),
    responsavel character varying(100)
);
    DROP TABLE public.setor;
       public         heap    postgres    false            �            1259    16567    setor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.setor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.setor_id_seq;
       public          postgres    false    207            G           0    0    setor_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.setor_id_seq OWNED BY public.setor.id;
          public          postgres    false    206            �            1259    16553 
   status_rnc    TABLE     a   CREATE TABLE public.status_rnc (
    id integer NOT NULL,
    descricao character varying(50)
);
    DROP TABLE public.status_rnc;
       public         heap    postgres    false            �            1259    16551    status_rnc_id_seq    SEQUENCE     �   CREATE SEQUENCE public.status_rnc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.status_rnc_id_seq;
       public          postgres    false    203            H           0    0    status_rnc_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.status_rnc_id_seq OWNED BY public.status_rnc.id;
          public          postgres    false    202            �            1259    16561    tipo_nao_conformidade    TABLE     m   CREATE TABLE public.tipo_nao_conformidade (
    id integer NOT NULL,
    descricao character varying(100)
);
 )   DROP TABLE public.tipo_nao_conformidade;
       public         heap    postgres    false            �            1259    16559    tipo_nao_conformidade_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_nao_conformidade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.tipo_nao_conformidade_id_seq;
       public          postgres    false    205            I           0    0    tipo_nao_conformidade_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.tipo_nao_conformidade_id_seq OWNED BY public.tipo_nao_conformidade.id;
          public          postgres    false    204            �            1259    16678    usuario    TABLE     ~  CREATE TABLE public.usuario (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    nome_completo character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    senha_hash character varying(255) NOT NULL,
    id_colaborador integer,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ultimo_login timestamp without time zone,
    ativo boolean DEFAULT true,
    reset_token character varying(255),
    reset_token_expira timestamp without time zone,
    permissoes jsonb DEFAULT '{"rnc": {"escrita": false, "leitura": true, "aprovacao": false}, "relatorios": true}'::jsonb
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �            1259    16676    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public          postgres    false    217            J           0    0    usuario_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;
          public          postgres    false    216            �            1259    16724    vw_acoes_corretivas_recentes    VIEW     �  CREATE VIEW public.vw_acoes_corretivas_recentes AS
 SELECT ac.id,
    ac.descricao,
    ac.data_execucao,
    ac.id_rnc,
    ac.id_responsavel,
    c.nome AS colaborador_nome,
    r.data_abertura
   FROM ((public.acao_corretiva ac
     JOIN public.rnc r ON ((ac.id_rnc = r.id)))
     JOIN public.colaborador c ON ((ac.id_responsavel = c.id)))
  WHERE (ac.data_execucao >= (CURRENT_DATE - '30 days'::interval));
 /   DROP VIEW public.vw_acoes_corretivas_recentes;
       public          postgres    false    215    209    215    209    213    213    215    215    215            �            1259    16710    vw_rncs_completas    VIEW     �  CREATE VIEW public.vw_rncs_completas AS
 SELECT r.id AS rnc_id,
    r.data_abertura,
    r.descricao,
    r.id_produto AS produto_id,
    p.nome AS produto_nome,
    p.codigo_referencia AS produto_codigo,
    p.descricao AS produto_descricao,
    r.id_setor AS setor_id,
    s.nome AS setor_nome,
    s.responsavel AS setor_responsavel,
    r.id_colaborador AS colaborador_id,
    c.nome AS colaborador_nome,
    c.matricula AS colaborador_matricula,
    c.cargo AS colaborador_cargo,
    r.id_tipo_nc AS tipo_nc_id,
    tn.descricao AS tipo_nc_descricao,
    r.id_status AS status_id,
    st.descricao AS status_descricao,
    r.id_cliente AS cliente_id,
    cli.nome AS cliente_nome,
    cli.cnpj AS cliente_cnpj,
    cli.email AS cliente_email,
    cli.telefone AS cliente_telefone,
    (CURRENT_DATE - r.data_abertura) AS dias_aberto,
        CASE
            WHEN (r.id_status = ( SELECT status_rnc.id
               FROM public.status_rnc
              WHERE ((status_rnc.descricao)::text = 'Concluído'::text))) THEN 'Concluído'::text
            WHEN (r.id_status = ( SELECT status_rnc.id
               FROM public.status_rnc
              WHERE ((status_rnc.descricao)::text = 'Cancelado'::text))) THEN 'Cancelado'::text
            ELSE 'Em Aberto'::text
        END AS status_simplificado
   FROM ((((((public.rnc r
     LEFT JOIN public.produto p ON ((r.id_produto = p.id)))
     LEFT JOIN public.setor s ON ((r.id_setor = s.id)))
     LEFT JOIN public.colaborador c ON ((r.id_colaborador = c.id)))
     LEFT JOIN public.tipo_nao_conformidade tn ON ((r.id_tipo_nc = tn.id)))
     LEFT JOIN public.status_rnc st ON ((r.id_status = st.id)))
     LEFT JOIN public.cliente cli ON ((r.id_cliente = cli.id)));
 $   DROP VIEW public.vw_rncs_completas;
       public          postgres    false    213    213    213    213    213    213    203    203    205    207    207    207    201    209    209    209    209    205    211    211    201    201    201    211    213    213    213    211    201            h           2604    16640    acao_corretiva id    DEFAULT     v   ALTER TABLE ONLY public.acao_corretiva ALTER COLUMN id SET DEFAULT nextval('public.acao_corretiva_id_seq'::regclass);
 @   ALTER TABLE public.acao_corretiva ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            a           2604    16548 
   cliente id    DEFAULT     h   ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);
 9   ALTER TABLE public.cliente ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200    201            e           2604    16580    colaborador id    DEFAULT     p   ALTER TABLE ONLY public.colaborador ALTER COLUMN id SET DEFAULT nextval('public.colaborador_id_seq'::regclass);
 =   ALTER TABLE public.colaborador ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209            f           2604    16588 
   produto id    DEFAULT     h   ALTER TABLE ONLY public.produto ALTER COLUMN id SET DEFAULT nextval('public.produto_id_seq'::regclass);
 9   ALTER TABLE public.produto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            g           2604    16599    rnc id    DEFAULT     `   ALTER TABLE ONLY public.rnc ALTER COLUMN id SET DEFAULT nextval('public.rnc_id_seq'::regclass);
 5   ALTER TABLE public.rnc ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    213    213            d           2604    16572    setor id    DEFAULT     d   ALTER TABLE ONLY public.setor ALTER COLUMN id SET DEFAULT nextval('public.setor_id_seq'::regclass);
 7   ALTER TABLE public.setor ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    206    207            b           2604    16556    status_rnc id    DEFAULT     n   ALTER TABLE ONLY public.status_rnc ALTER COLUMN id SET DEFAULT nextval('public.status_rnc_id_seq'::regclass);
 <   ALTER TABLE public.status_rnc ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203            c           2604    16564    tipo_nao_conformidade id    DEFAULT     �   ALTER TABLE ONLY public.tipo_nao_conformidade ALTER COLUMN id SET DEFAULT nextval('public.tipo_nao_conformidade_id_seq'::regclass);
 G   ALTER TABLE public.tipo_nao_conformidade ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            i           2604    16681 
   usuario id    DEFAULT     h   ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);
 9   ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            9          0    16637    acao_corretiva 
   TABLE DATA           ^   COPY public.acao_corretiva (id, id_rnc, descricao, data_execucao, id_responsavel) FROM stdin;
    public          postgres    false    215   ��       +          0    16545    cliente 
   TABLE DATA           B   COPY public.cliente (id, nome, cnpj, email, telefone) FROM stdin;
    public          postgres    false    201   {�       3          0    16577    colaborador 
   TABLE DATA           A   COPY public.colaborador (id, nome, matricula, cargo) FROM stdin;
    public          postgres    false    209   d�       5          0    16585    produto 
   TABLE DATA           I   COPY public.produto (id, nome, codigo_referencia, descricao) FROM stdin;
    public          postgres    false    211   ێ       7          0    16596    rnc 
   TABLE DATA           �   COPY public.rnc (id, data_abertura, descricao, id_produto, id_setor, id_colaborador, id_tipo_nc, id_status, id_cliente) FROM stdin;
    public          postgres    false    213   p�       1          0    16569    setor 
   TABLE DATA           6   COPY public.setor (id, nome, responsavel) FROM stdin;
    public          postgres    false    207   @�       -          0    16553 
   status_rnc 
   TABLE DATA           3   COPY public.status_rnc (id, descricao) FROM stdin;
    public          postgres    false    203   ��       /          0    16561    tipo_nao_conformidade 
   TABLE DATA           >   COPY public.tipo_nao_conformidade (id, descricao) FROM stdin;
    public          postgres    false    205   �       ;          0    16678    usuario 
   TABLE DATA           �   COPY public.usuario (id, username, nome_completo, email, senha_hash, id_colaborador, data_criacao, ultimo_login, ativo, reset_token, reset_token_expira, permissoes) FROM stdin;
    public          postgres    false    217   V�       K           0    0    acao_corretiva_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.acao_corretiva_id_seq', 10, true);
          public          postgres    false    214            L           0    0    cliente_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.cliente_id_seq', 14, true);
          public          postgres    false    200            M           0    0    colaborador_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.colaborador_id_seq', 12, true);
          public          postgres    false    208            N           0    0    produto_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.produto_id_seq', 15, true);
          public          postgres    false    210            O           0    0 
   rnc_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.rnc_id_seq', 39, true);
          public          postgres    false    212            P           0    0    setor_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.setor_id_seq', 12, true);
          public          postgres    false    206            Q           0    0    status_rnc_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.status_rnc_id_seq', 16, true);
          public          postgres    false    202            R           0    0    tipo_nao_conformidade_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.tipo_nao_conformidade_id_seq', 16, true);
          public          postgres    false    204            S           0    0    usuario_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.usuario_id_seq', 6, true);
          public          postgres    false    216            �           2606    16645 "   acao_corretiva acao_corretiva_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.acao_corretiva
    ADD CONSTRAINT acao_corretiva_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.acao_corretiva DROP CONSTRAINT acao_corretiva_pkey;
       public            postgres    false    215            n           2606    16550    cliente cliente_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    201                       2606    16582    colaborador colaborador_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.colaborador
    ADD CONSTRAINT colaborador_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.colaborador DROP CONSTRAINT colaborador_pkey;
       public            postgres    false    209            �           2606    16593    produto produto_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public            postgres    false    211            �           2606    16604    rnc rnc_pkey 
   CONSTRAINT     J   ALTER TABLE ONLY public.rnc
    ADD CONSTRAINT rnc_pkey PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.rnc DROP CONSTRAINT rnc_pkey;
       public            postgres    false    213            }           2606    16574    setor setor_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.setor
    ADD CONSTRAINT setor_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.setor DROP CONSTRAINT setor_pkey;
       public            postgres    false    207            u           2606    16558    status_rnc status_rnc_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.status_rnc
    ADD CONSTRAINT status_rnc_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.status_rnc DROP CONSTRAINT status_rnc_pkey;
       public            postgres    false    203            y           2606    16566 0   tipo_nao_conformidade tipo_nao_conformidade_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.tipo_nao_conformidade
    ADD CONSTRAINT tipo_nao_conformidade_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.tipo_nao_conformidade DROP CONSTRAINT tipo_nao_conformidade_pkey;
       public            postgres    false    205            �           2606    16693    usuario usuario_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key;
       public            postgres    false    217            �           2606    16689    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    217            �           2606    16691    usuario usuario_username_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_username_key UNIQUE (username);
 F   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_username_key;
       public            postgres    false    217            �           1259    16674    idx_acao_corretiva_rnc_data    INDEX     �   CREATE INDEX idx_acao_corretiva_rnc_data ON public.acao_corretiva USING btree (id_rnc, data_execucao) WHERE (id_rnc IS NOT NULL);
 /   DROP INDEX public.idx_acao_corretiva_rnc_data;
       public            postgres    false    215    215    215            o           1259    16655    idx_cliente_cnpj    INDEX     d   CREATE UNIQUE INDEX idx_cliente_cnpj ON public.cliente USING btree (cnpj) WHERE (cnpj IS NOT NULL);
 $   DROP INDEX public.idx_cliente_cnpj;
       public            postgres    false    201    201            p           1259    16656    idx_cliente_nome_email    INDEX     j   CREATE INDEX idx_cliente_nome_email ON public.cliente USING btree (nome, email) WHERE (nome IS NOT NULL);
 *   DROP INDEX public.idx_cliente_nome_email;
       public            postgres    false    201    201    201            �           1259    16662    idx_colaborador_matricula    INDEX     {   CREATE UNIQUE INDEX idx_colaborador_matricula ON public.colaborador USING btree (matricula) WHERE (matricula IS NOT NULL);
 -   DROP INDEX public.idx_colaborador_matricula;
       public            postgres    false    209    209            �           1259    16663    idx_colaborador_nome_cargo    INDEX     r   CREATE INDEX idx_colaborador_nome_cargo ON public.colaborador USING btree (nome, cargo) WHERE (nome IS NOT NULL);
 .   DROP INDEX public.idx_colaborador_nome_cargo;
       public            postgres    false    209    209    209            �           1259    16665    idx_produto_codigo_referencia    INDEX     �   CREATE UNIQUE INDEX idx_produto_codigo_referencia ON public.produto USING btree (codigo_referencia) WHERE (codigo_referencia IS NOT NULL);
 1   DROP INDEX public.idx_produto_codigo_referencia;
       public            postgres    false    211    211            �           1259    16666    idx_produto_nome_descricao    INDEX     r   CREATE INDEX idx_produto_nome_descricao ON public.produto USING btree (nome, descricao) WHERE (nome IS NOT NULL);
 .   DROP INDEX public.idx_produto_nome_descricao;
       public            postgres    false    211    211    211            �           1259    16670    idx_rnc_cliente_data    INDEX     x   CREATE INDEX idx_rnc_cliente_data ON public.rnc USING btree (id_cliente, data_abertura) WHERE (id_cliente IS NOT NULL);
 (   DROP INDEX public.idx_rnc_cliente_data;
       public            postgres    false    213    213    213            �           1259    16672    idx_rnc_colaborador_data    INDEX     �   CREATE INDEX idx_rnc_colaborador_data ON public.rnc USING btree (id_colaborador, data_abertura) WHERE (id_colaborador IS NOT NULL);
 ,   DROP INDEX public.idx_rnc_colaborador_data;
       public            postgres    false    213    213    213            �           1259    16668    idx_rnc_data_status    INDEX     y   CREATE INDEX idx_rnc_data_status ON public.rnc USING btree (data_abertura, id_status) WHERE (data_abertura IS NOT NULL);
 '   DROP INDEX public.idx_rnc_data_status;
       public            postgres    false    213    213    213            �           1259    16669    idx_rnc_produto_status    INDEX     W   CREATE INDEX idx_rnc_produto_status ON public.rnc USING btree (id_produto, id_status);
 *   DROP INDEX public.idx_rnc_produto_status;
       public            postgres    false    213    213            �           1259    16671    idx_rnc_setor_tipo    INDEX     o   CREATE INDEX idx_rnc_setor_tipo ON public.rnc USING btree (id_setor, id_tipo_nc) WHERE (id_setor IS NOT NULL);
 &   DROP INDEX public.idx_rnc_setor_tipo;
       public            postgres    false    213    213    213            z           1259    16653    idx_setor_nome_responsavel    INDEX     r   CREATE INDEX idx_setor_nome_responsavel ON public.setor USING btree (nome, responsavel) WHERE (nome IS NOT NULL);
 .   DROP INDEX public.idx_setor_nome_responsavel;
       public            postgres    false    207    207    207            r           1259    16658    idx_status_rnc_descricao    INDEX     r   CREATE INDEX idx_status_rnc_descricao ON public.status_rnc USING btree (descricao) WHERE (descricao IS NOT NULL);
 ,   DROP INDEX public.idx_status_rnc_descricao;
       public            postgres    false    203    203            v           1259    16660    idx_tipo_nc_descricao    INDEX     z   CREATE INDEX idx_tipo_nc_descricao ON public.tipo_nao_conformidade USING btree (descricao) WHERE (descricao IS NOT NULL);
 )   DROP INDEX public.idx_tipo_nc_descricao;
       public            postgres    false    205    205            �           1259    16701    idx_usuario_ativo    INDEX     [   CREATE INDEX idx_usuario_ativo ON public.usuario USING btree (ativo) WHERE (ativo = true);
 %   DROP INDEX public.idx_usuario_ativo;
       public            postgres    false    217    217            �           1259    16700    idx_usuario_email    INDEX     F   CREATE INDEX idx_usuario_email ON public.usuario USING btree (email);
 %   DROP INDEX public.idx_usuario_email;
       public            postgres    false    217            �           1259    16699    idx_usuario_username    INDEX     L   CREATE INDEX idx_usuario_username ON public.usuario USING btree (username);
 (   DROP INDEX public.idx_usuario_username;
       public            postgres    false    217            �           1259    16673    pk_acao_corretiva    INDEX     t   CREATE UNIQUE INDEX pk_acao_corretiva ON public.acao_corretiva USING btree (id) INCLUDE (descricao, data_execucao);
 %   DROP INDEX public.pk_acao_corretiva;
       public            postgres    false    215    215    215            q           1259    16654 
   pk_cliente    INDEX     _   CREATE UNIQUE INDEX pk_cliente ON public.cliente USING btree (id) INCLUDE (nome, cnpj, email);
    DROP INDEX public.pk_cliente;
       public            postgres    false    201    201    201    201            �           1259    16661    pk_colaborador    INDEX     l   CREATE UNIQUE INDEX pk_colaborador ON public.colaborador USING btree (id) INCLUDE (nome, matricula, cargo);
 "   DROP INDEX public.pk_colaborador;
       public            postgres    false    209    209    209    209            �           1259    16664 
   pk_produto    INDEX     e   CREATE UNIQUE INDEX pk_produto ON public.produto USING btree (id) INCLUDE (nome, codigo_referencia);
    DROP INDEX public.pk_produto;
       public            postgres    false    211    211    211            �           1259    16667    pk_rnc    INDEX     ^   CREATE UNIQUE INDEX pk_rnc ON public.rnc USING btree (id) INCLUDE (data_abertura, descricao);
    DROP INDEX public.pk_rnc;
       public            postgres    false    213    213    213            {           1259    16652    pk_setor    INDEX     [   CREATE UNIQUE INDEX pk_setor ON public.setor USING btree (id) INCLUDE (nome, responsavel);
    DROP INDEX public.pk_setor;
       public            postgres    false    207    207    207            s           1259    16657    pk_status_rnc    INDEX     ]   CREATE UNIQUE INDEX pk_status_rnc ON public.status_rnc USING btree (id) INCLUDE (descricao);
 !   DROP INDEX public.pk_status_rnc;
       public            postgres    false    203    203            w           1259    16659    pk_tipo_nao_conformidade    INDEX     s   CREATE UNIQUE INDEX pk_tipo_nao_conformidade ON public.tipo_nao_conformidade USING btree (id) INCLUDE (descricao);
 ,   DROP INDEX public.pk_tipo_nao_conformidade;
       public            postgres    false    205    205            �           2606    16719 1   acao_corretiva acao_corretiva_id_responsavel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.acao_corretiva
    ADD CONSTRAINT acao_corretiva_id_responsavel_fkey FOREIGN KEY (id_responsavel) REFERENCES public.colaborador(id);
 [   ALTER TABLE ONLY public.acao_corretiva DROP CONSTRAINT acao_corretiva_id_responsavel_fkey;
       public          postgres    false    209    2943    215            �           2606    16646 )   acao_corretiva acao_corretiva_id_rnc_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.acao_corretiva
    ADD CONSTRAINT acao_corretiva_id_rnc_fkey FOREIGN KEY (id_rnc) REFERENCES public.rnc(id);
 S   ALTER TABLE ONLY public.acao_corretiva DROP CONSTRAINT acao_corretiva_id_rnc_fkey;
       public          postgres    false    213    215    2959            �           2606    16630    rnc rnc_id_cliente_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.rnc
    ADD CONSTRAINT rnc_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id);
 A   ALTER TABLE ONLY public.rnc DROP CONSTRAINT rnc_id_cliente_fkey;
       public          postgres    false    2926    213    201            �           2606    16615    rnc rnc_id_colaborador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rnc
    ADD CONSTRAINT rnc_id_colaborador_fkey FOREIGN KEY (id_colaborador) REFERENCES public.colaborador(id);
 E   ALTER TABLE ONLY public.rnc DROP CONSTRAINT rnc_id_colaborador_fkey;
       public          postgres    false    209    2943    213            �           2606    16605    rnc rnc_id_produto_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.rnc
    ADD CONSTRAINT rnc_id_produto_fkey FOREIGN KEY (id_produto) REFERENCES public.produto(id);
 A   ALTER TABLE ONLY public.rnc DROP CONSTRAINT rnc_id_produto_fkey;
       public          postgres    false    211    2951    213            �           2606    16610    rnc rnc_id_setor_fkey    FK CONSTRAINT     u   ALTER TABLE ONLY public.rnc
    ADD CONSTRAINT rnc_id_setor_fkey FOREIGN KEY (id_setor) REFERENCES public.setor(id);
 ?   ALTER TABLE ONLY public.rnc DROP CONSTRAINT rnc_id_setor_fkey;
       public          postgres    false    207    213    2941            �           2606    16625    rnc rnc_id_status_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.rnc
    ADD CONSTRAINT rnc_id_status_fkey FOREIGN KEY (id_status) REFERENCES public.status_rnc(id);
 @   ALTER TABLE ONLY public.rnc DROP CONSTRAINT rnc_id_status_fkey;
       public          postgres    false    213    2933    203            �           2606    16620    rnc rnc_id_tipo_nc_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rnc
    ADD CONSTRAINT rnc_id_tipo_nc_fkey FOREIGN KEY (id_tipo_nc) REFERENCES public.tipo_nao_conformidade(id);
 A   ALTER TABLE ONLY public.rnc DROP CONSTRAINT rnc_id_tipo_nc_fkey;
       public          postgres    false    205    2937    213            �           2606    16694 #   usuario usuario_id_colaborador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_colaborador_fkey FOREIGN KEY (id_colaborador) REFERENCES public.colaborador(id);
 M   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_id_colaborador_fkey;
       public          postgres    false    217    2943    209            9   �   x����N1E��W���`Z����LL5��E�0��� Ұc��|�I���_yQAA��V.vɄ�4� �8���'�<�{H���nT��βb�OA�yɲG�#2AJ@���*�.���V�f�"���]0~���*{uL�sՙo�|�k�}!x�0�ʤT�}E�mMp�޶�폊��ΐΆ��h%��o�9���:���9�C�]�      +   �   x����N!���SPj1C7��Obmòw���d����sq���+�-�9'G�MN;���W�����C�:��J���W�s1X>��Z^�w���2�W����ЅHx�[W��=ؙ�I35�S��P�_��/林<���Ѕ�p�X��;�)�%��'����G�
�2e�t�����gS��mu�qZX��(�RD(hXR�� ��߮WF���[�      3   g   x�34�tN,��/V��)K��542���+.H-�/�24�tK-�K�KITp�/.˛p���e�%rqz�^�������ZR`��XZ����X����� *��      5   �   x�34�tN��,NT����t�500�	 �RRs��S/�W�M,N.���K�24*�9�<Q�+51������&�SHK���+6�K-.�L�Wp��/J��s*7����܂��me�E@��b���� o94�      7   �   x�U�1n�0Eg��@K�]t.r��]X[A�bB�'�Ѓ�b���F�?����Q�ԥ���.�%��$�p��Ka��ZƫJ1��x��x�!�;�E���h��XeyS�\�k�I �n��b�����m��j\|W����
��7�h����l��ri{=4�v9��ͮ�^S�Q�������t=U���46���z!|$|I{      1   P   x�34�t�/.)-J��M,�LTpK-*J�,J�24���rz�^���_Z4�t�MJ�ILO��t�KT���M����� ��)      -   >   x�34�tLJ-*I�24�t�UH�;�0'�8��Д3(�8?�,3(g�霘�������qqq �~�      /   X   x��;
�0 �99EO ?��7pt�iĀm�����b���*��q�MX��L�/J�q���i����*�`f:(K�?��uýC��W      ;   M  x���OO�@���� �������"FC�e��bM�ⶀ������WM&3��f�<��X�x����E�ؙ�b�%-�\��Xf���E�fS�Aw�F��ϝa�-���q�<���F�M�#L^����1�1e�J�j�����MӕI3nl�X%.�a�gPTx�h���Wj��0wv		���v'�9:H�;{tX@m]n�����k��yw߳� ��P��v�(�:�#%�&\m@j0e�D���,�8^�(r�~X\�D�).��P�~��B����,�PGiBu*"��QY�rC����Q�u $�4��$H������$�}���k     