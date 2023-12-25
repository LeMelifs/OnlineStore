--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: usertypes; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.usertypes AS ENUM (
    'admin',
    'regular_user'
);


ALTER TYPE public.usertypes OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: change_pass_code_storage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.change_pass_code_storage (
    id integer NOT NULL,
    email text,
    code text,
    exp_date timestamp without time zone
);


ALTER TABLE public.change_pass_code_storage OWNER TO postgres;

--
-- Name: change_pass_code_storage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.change_pass_code_storage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.change_pass_code_storage_id_seq OWNER TO postgres;

--
-- Name: change_pass_code_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.change_pass_code_storage_id_seq OWNED BY public.change_pass_code_storage.id;


--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer NOT NULL,
    username text,
    first_name text,
    second_name text,
    email text,
    phone_number text,
    password text,
    type public.usertypes,
    gender character varying(1),
    register_date timestamp without time zone,
    active boolean
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_id_seq OWNER TO postgres;

--
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- Name: contract_storage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contract_storage (
    id integer NOT NULL,
    paid boolean
);


ALTER TABLE public.contract_storage OWNER TO postgres;

--
-- Name: contract_storage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contract_storage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contract_storage_id_seq OWNER TO postgres;

--
-- Name: contract_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contract_storage_id_seq OWNED BY public.contract_storage.id;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    obj text,
    obj_id integer,
    path text,
    "time" timestamp without time zone
);


ALTER TABLE public.photo OWNER TO postgres;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_id_seq OWNER TO postgres;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


--
-- Name: refresh_token_storage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh_token_storage (
    id integer NOT NULL,
    refresh_token text,
    expired timestamp without time zone
);


ALTER TABLE public.refresh_token_storage OWNER TO postgres;

--
-- Name: refresh_token_storage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_token_storage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refresh_token_storage_id_seq OWNER TO postgres;

--
-- Name: refresh_token_storage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refresh_token_storage_id_seq OWNED BY public.refresh_token_storage.id;


--
-- Name: change_pass_code_storage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_pass_code_storage ALTER COLUMN id SET DEFAULT nextval('public.change_pass_code_storage_id_seq'::regclass);


--
-- Name: client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- Name: contract_storage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_storage ALTER COLUMN id SET DEFAULT nextval('public.contract_storage_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: refresh_token_storage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_token_storage ALTER COLUMN id SET DEFAULT nextval('public.refresh_token_storage_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
c3ea7e348c4e
\.


--
-- Data for Name: change_pass_code_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.change_pass_code_storage (id, email, code, exp_date) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, username, first_name, second_name, email, phone_number, password, type, gender, register_date, active) FROM stdin;
\.


--
-- Data for Name: contract_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract_storage (id, paid) FROM stdin;
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photo (id, obj, obj_id, path, "time") FROM stdin;
\.


--
-- Data for Name: refresh_token_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_token_storage (id, refresh_token, expired) FROM stdin;
\.


--
-- Name: change_pass_code_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.change_pass_code_storage_id_seq', 1, false);


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_seq', 1, false);


--
-- Name: contract_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contract_storage_id_seq', 1, false);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photo_id_seq', 1, false);


--
-- Name: refresh_token_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_token_storage_id_seq', 1, false);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: change_pass_code_storage change_pass_code_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_pass_code_storage
    ADD CONSTRAINT change_pass_code_storage_pkey PRIMARY KEY (id);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: contract_storage contract_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_storage
    ADD CONSTRAINT contract_storage_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: refresh_token_storage refresh_token_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_token_storage
    ADD CONSTRAINT refresh_token_storage_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

