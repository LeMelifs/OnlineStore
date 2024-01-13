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
-- Name: orderstatuses; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.orderstatuses AS ENUM (
    'cancelled',
    'pending',
    'delivery',
    'done'
);


ALTER TYPE public.orderstatuses OWNER TO postgres;

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
-- Name: bin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bin (
    id integer NOT NULL,
    user_id integer,
    product_id integer
);


ALTER TABLE public.bin OWNER TO postgres;

--
-- Name: bin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bin_id_seq OWNER TO postgres;

--
-- Name: bin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bin_id_seq OWNED BY public.bin.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_id_seq OWNER TO postgres;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


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
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.city OWNER TO postgres;

--
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.city_id_seq OWNER TO postgres;

--
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer NOT NULL,
    username text,
    first_name text,
    email text,
    phone_number text,
    password text,
    type public.usertypes,
    gender character varying(1),
    register_date timestamp without time zone,
    active boolean,
    city integer
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
-- Name: color; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.color (
    id integer NOT NULL,
    name text,
    hex_code text
);


ALTER TABLE public.color OWNER TO postgres;

--
-- Name: color_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.color_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.color_id_seq OWNER TO postgres;

--
-- Name: color_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.color_id_seq OWNED BY public.color.id;


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
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    product_id integer,
    user_id integer,
    sum integer,
    pickpoint_id integer,
    status public.orderstatuses,
    create_time timestamp without time zone,
    close_time timestamp without time zone
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_id_seq OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;


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
-- Name: pickpoint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickpoint (
    id integer NOT NULL,
    name text,
    city_id integer
);


ALTER TABLE public.pickpoint OWNER TO postgres;

--
-- Name: pickpoint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickpoint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickpoint_id_seq OWNER TO postgres;

--
-- Name: pickpoint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickpoint_id_seq OWNED BY public.pickpoint.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name text,
    description text,
    rating double precision,
    price integer,
    sale integer,
    category_id integer,
    active boolean
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_color; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_color (
    id integer NOT NULL,
    product_id integer,
    color_id integer
);


ALTER TABLE public.product_color OWNER TO postgres;

--
-- Name: product_color_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_color_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_color_id_seq OWNER TO postgres;

--
-- Name: product_color_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_color_id_seq OWNED BY public.product_color.id;


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_id_seq OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: product_size; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_size (
    id integer NOT NULL,
    product_id integer,
    size_id integer
);


ALTER TABLE public.product_size OWNER TO postgres;

--
-- Name: product_size_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_size_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_size_id_seq OWNER TO postgres;

--
-- Name: product_size_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_size_id_seq OWNED BY public.product_size.id;


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
-- Name: size; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.size (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.size OWNER TO postgres;

--
-- Name: size_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.size_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.size_id_seq OWNER TO postgres;

--
-- Name: size_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.size_id_seq OWNED BY public.size.id;


--
-- Name: bin id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bin ALTER COLUMN id SET DEFAULT nextval('public.bin_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: change_pass_code_storage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_pass_code_storage ALTER COLUMN id SET DEFAULT nextval('public.change_pass_code_storage_id_seq'::regclass);


--
-- Name: city id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- Name: client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- Name: color id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.color ALTER COLUMN id SET DEFAULT nextval('public.color_id_seq'::regclass);


--
-- Name: contract_storage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_storage ALTER COLUMN id SET DEFAULT nextval('public.contract_storage_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: pickpoint id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickpoint ALTER COLUMN id SET DEFAULT nextval('public.pickpoint_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: product_color id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_color ALTER COLUMN id SET DEFAULT nextval('public.product_color_id_seq'::regclass);


--
-- Name: product_size id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_size ALTER COLUMN id SET DEFAULT nextval('public.product_size_id_seq'::regclass);


--
-- Name: refresh_token_storage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_token_storage ALTER COLUMN id SET DEFAULT nextval('public.refresh_token_storage_id_seq'::regclass);


--
-- Name: size id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.size ALTER COLUMN id SET DEFAULT nextval('public.size_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
0e9944d82080
\.


--
-- Data for Name: bin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bin (id, user_id, product_id) FROM stdin;
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name) FROM stdin;
2	ФУТБОЛКИ
5	НОСКИ
6	СУМКИ
7	АКСЕССУАРЫ
8	ТОЛСТОВКИ
9	ШТАНЫ
\.


--
-- Data for Name: change_pass_code_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.change_pass_code_storage (id, email, code, exp_date) FROM stdin;
2	vera_mij_xxx@mail.ru	588040	2024-01-10 01:22:20.210742
\.


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (id, name) FROM stdin;
1	Владивосток
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, username, first_name, email, phone_number, password, type, gender, register_date, active, city) FROM stdin;
1	poslam	Денис	kirden04@gmail.com	+79245227172	scrypt:32768:8:1$XzHaqQwVipegHsIk$0d23a8abbe70653ef2a94ca1005a2a78fa270ce788104486012374bdac5ed0c7c8b5622adc7539968321c2fc45f7fcc1f27035cf32de85e221548cd8e568fb83	admin	m	2023-12-25 17:02:57.357503	t	\N
2	Veronika	Вероника	vera_mij_xxx@mail.ru	+79146581599	scrypt:32768:8:1$uFyWmx0QMWhh7Z2M$e25d359a17cd3f24eb2aa96a1678c8ce1a23eadee8a7093942b87fa86f0fb8a276497b6d7871f6ccb46971d1e5de0cfde0eabef556ac2f3d0b1ac0298b585d0c	admin	ж	2023-12-28 22:43:43.559173	t	\N
7	ее	rar	rar@rar.com	+79143355555	scrypt:32768:8:1$sAOvhvftCmqlGpxx$1883faff7889bd25c575c777854e06b7e42fcb793f2d028ab6ae45c80b88d8039881512dfd46c21e0cd9e83e9b245fd132490396d1090d9fcd15758ea5733c07	regular_user	f	2024-01-13 00:46:34.457066	t	\N
\.


--
-- Data for Name: color; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.color (id, name, hex_code) FROM stdin;
\.


--
-- Data for Name: contract_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract_storage (id, paid) FROM stdin;
\.



--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (id, product_id, user_id, sum, pickpoint_id, status, create_time, close_time) FROM stdin;
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photo (id, obj, obj_id, path, "time") FROM stdin;
3	category	1	category/1/1_0.jpg	2024-01-09 00:26:39.799625
4	category	1	category/1/1_1.jpg	2024-01-10 01:29:13.178246
5	client	1	client/1/1_0.jpg	2024-01-13 00:53:28.751092
10	client	2	client/2/2_0.jpg	2024-01-13 18:18:43.783757
11	client	2	client/2/2_1.jpg	2024-01-13 18:25:46.909765
12	client	2	client/2/2_2.jpg	2024-01-13 18:26:38.970432
13	client	2	client/2/2_3.jpg	2024-01-13 18:26:39.056825
14	client	2	client/2/2_4.jpg	2024-01-13 18:26:43.287158
15	client	2	client/2/2_5.jpg	2024-01-13 18:26:43.296028
16	client	2	client/2/2_6.jpg	2024-01-13 18:26:49.664126
17	client	2	client/2/2_7.jpg	2024-01-13 18:27:06.330933
18	client	2	client/2/2_8.jpg	2024-01-13 18:27:11.28133
19	client	2	client/2/2_9.jpg	2024-01-13 18:27:11.284586
20	client	2	client/2/2_10.jpg	2024-01-13 18:27:18.214358
21	client	2	client/2/2_11.jpg	2024-01-13 18:27:18.220155
22	client	2	client/2/2_12.jpg	2024-01-13 18:27:21.803308
23	client	2	client/2/2_13.jpg	2024-01-13 18:29:11.543724
24	client	2	client/2/2_14.jpg	2024-01-13 18:29:11.563095
25	client	2	client/2/2_15.jpg	2024-01-13 18:29:16.266553
26	client	2	client/2/2_16.jpg	2024-01-13 18:30:09.932777
27	client	2	client/2/2_17.jpg	2024-01-13 18:30:09.974485
28	client	2	client/2/2_18.jpg	2024-01-13 18:30:12.348814
29	client	2	client/2/2_19.jpg	2024-01-13 18:42:45.826948
30	client	2	client/2/2_20.jpg	2024-01-13 18:43:00.006158
31	client	2	client/2/2_21.jpg	2024-01-13 18:43:10.118739
32	client	2	client/2/2_22.jpg	2024-01-13 18:43:10.182859
33	client	2	client/2/2_23.jpg	2024-01-13 18:50:28.375315
34	client	2	client/2/2_24.jpg	2024-01-13 18:51:24.254796
35	client	2	client/2/2_25.jpg	2024-01-13 18:51:35.318123
36	client	2	client/2/2_26.jpg	2024-01-13 18:51:37.368411
37	client	2	client/2/2_27.jpg	2024-01-13 18:51:37.417299
38	client	2	client/2/2_28.jpg	2024-01-13 18:51:41.152521
39	client	2	client/2/2_29.jpg	2024-01-13 18:52:39.981591
40	client	2	client/2/2_30.jpg	2024-01-13 18:53:16.944402
41	client	2	client/2/2_31.jpg	2024-01-13 18:53:38.552749
42	client	2	client/2/2_32.jpg	2024-01-13 18:54:19.891681
45	client	2	client/2/2_33.jpg	2024-01-13 23:09:34.269342
46	client	2	client/2/2_34.jpg	2024-01-13 23:09:35.016481
\.


--
-- Data for Name: pickpoint; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickpoint (id, name, city_id) FROM stdin;
1	Точка выдачи на Семеновской	1
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, name, rating, price, sale, category_id, active) FROM stdin;
\.


--
-- Data for Name: product_color; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_color (id, product_id, color_id) FROM stdin;
\.


--
-- Data for Name: product_size; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_size (id, product_id, size_id) FROM stdin;
\.


--
-- Data for Name: refresh_token_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_token_storage (id, refresh_token, expired) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZXhwaXJlZCI6IjIwMjQtMDEtMjQgMTA6MjQ6NTAuNzQ5NzcwIn0.X-vEf3RTaG1LGonzbfJ1auZCLKx-L_BzCa6DBXKZVNw	2024-01-24 10:24:50.74977
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTAgMjI6MjY6MzkuMTU2Nzg2In0.MkrVJLhCbimVgpmLSnGa6dmrgRXcNwVH-_nbfeTiSnc	2024-02-10 22:26:39.156786
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTAgMjI6MzA6NTQuNjQ1Njc4In0.9ImDwxFJPKEiBKcxxPi5QFHgghiQxiknrhHVCVTiPTc	2024-02-10 22:30:54.645678
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTAgMjM6NTc6MTIuODA3ODU1In0.a9QgFhIuQPCfLTn9YRJSyd5ppYrEKF5RFV3h_QFSIw0	2024-02-10 23:57:12.807855
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTEgMDA6NTk6MTUuNjI1MTQ5In0.SBXT6TzVuf6cCP0sVlgAZ94OuIkaA5rPZwyrTuj3s2s	2024-02-11 00:59:15.625149
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMDA6NDA6NDMuMjM0ODA1In0.D1WQjovSynClzxqHewev7Y_nQhgP5MdmW-QMlE9Tuyw	2024-02-12 00:40:43.234805
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZXhwaXJlZCI6IjIwMjQtMDItMTIgMDA6NDY6NDMuODcyNzc1In0.m7Zpg4dXEULYXKo07U2ZMlzUJBMwA13TFPzE6ye1aXE	2024-02-12 00:46:43.872775
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMDE6MDU6MTguMjAzNTE5In0.2zfeEGkGbMx1rMp0vDkyge-KBAtjgWNbKIZjeXWm0zE	2024-02-12 01:05:18.203519
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMDE6MDc6MDIuNzk2MDMzIn0.JyyaUq_zFeH4gvLukpqeAOQbFwPLctqFGE1ZDC1dTok	2024-02-12 01:07:02.796033
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMDE6MTQ6MTYuMDM4MjE1In0.N7X3x1VLT8EMBWTGB3VhV8FMTkDpntFqxLN8sp9qM68	2024-02-12 01:14:16.038215
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMDE6MTk6MzEuMTY1NTk5In0.bsoMuiEN4sBXJWLiDPeHt19gVC_UkXrr_UneXdZd4F4	2024-02-12 01:19:31.165599
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTQ6NDM6NDcuNzAzOTczIn0.fooomIe6ALvnoneWwSpXj88sS7XXprm52P_OwGEW2SU	2024-02-12 14:43:47.703973
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTU6Mzc6MTkuMjQzNzgzIn0.U8XURpzgTJqVVGalv9-tkdmE0lH_9sMm2SwB3zpAsJo	2024-02-12 15:37:19.243783
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTU6NDE6NDMuOTY0MTk5In0.o94gcG5T7IIeu5k_OURVnKUpN7tHi4KRsg_1FOVj2js	2024-02-12 15:41:43.964199
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTY6MDY6NTQuNTQzODk1In0.6T7ZsFKZrCtPQIK9xJakEF627u3TRFR9E5n5oq5fc7Q	2024-02-12 16:06:54.543895
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTY6MTI6MjEuMzUyNjE3In0.o7ysNx2CEz7HD59A5lFvVfQIkOXWql1JME2rzZcPcVY	2024-02-12 16:12:21.352617
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTY6MjQ6MTYuNDgyOTk5In0.UdZyftGlbm1jSvZRN79kayrMMcs2wF001zCw84pzYKc	2024-02-12 16:24:16.482999
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTc6MzI6MjQuMjg1OTA5In0.7gGN2nYJoz8V_qw5rIfECgxNbqFrqvGr6pTDAeXx--M	2024-02-12 17:32:24.285909
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6MjU6MDkuMzU2Nzk2In0.liYEwgC53aN_Qu95sswqi2knejpEv1Wu95wRxOYbMw0	2024-02-12 18:25:09.356796
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6MjY6MTQuNzYzNDkxIn0.PhK_UqgBs4NoHUQbCYoqVzboK1_PviDFBzQCyo6UcXk	2024-02-12 18:26:14.763491
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6Mjc6NTIuNTE1MzQxIn0.hbQLIHGeqr9b34Tz91BMhlfYFweDtXxNLQU6iC9wU7g	2024-02-12 18:27:52.515341
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6Mjk6NTEuMzA5MzE1In0.H6_OTxzZlL1D4Jertnu-kqW3Tv8oIoPxhAOKMJaJ4lM	2024-02-12 18:29:51.309315
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6NDM6MjguNzE0NTc4In0.wMQG_BZCGOLaGkEn-zqu2SzNdABnWfN5kX6acCS9yfs	2024-02-12 18:43:28.714578
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6NDc6MjEuNDA1MzI0In0.W0Wqqy0o0OorjNHFcsnOl9D4WmGqOfE7dlPoFQ-cPrQ	2024-02-12 18:47:21.405324
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6NDg6MjMuODg0NjIyIn0.AqoETDikzX-QPGPBYd2D6BSVCQ4d_1QwRWOIv4GtkO8	2024-02-12 18:48:23.884622
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6NTA6NTYuMTQ3MjY3In0.tc75_1q-zMNi51Z4lREkodi6tat-URD0W7d6LYaUb6w	2024-02-12 18:50:56.147267
27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6NTM6MDguMzQwOTM2In0.QG4U-kVyZ_Kxh3wQisF122i6keyru_CwSto6UCXbIrc	2024-02-12 18:53:08.340936
28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMTg6NTQ6MTEuMDAyNTc3In0.Hl0g4-epKfsRJ1YF24G3QkE1sMg7BmSRqPLkOcT4OZg	2024-02-12 18:54:11.002577
29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMjE6MTg6MDYuMDgxMTc0In0.BoZxUe4U4lBlhEblMMb606M8VC1mn7XzCyrf8gbcx0Q	2024-02-12 21:18:06.081174
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZXhwaXJlZCI6IjIwMjQtMDItMTIgMjI6Mzk6NDYuNjI3MTc0In0.0lLrIGvIfHcYVjXuIwIQtPAXlCIuyWOCsGGvRFjpjds	2024-02-12 22:39:46.627174
\.


--
-- Data for Name: size; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.size (id, name) FROM stdin;
\.


--
-- Name: bin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bin_id_seq', 1, false);


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 9, true);


--
-- Name: change_pass_code_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.change_pass_code_storage_id_seq', 7, true);


--
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_id_seq', 1, true);


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_seq', 8, true);


--
-- Name: color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.color_id_seq', 1, false);


--
-- Name: contract_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contract_storage_id_seq', 1, false);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_id_seq', 1, false);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photo_id_seq', 46, true);


--
-- Name: pickpoint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickpoint_id_seq', 1, true);


--
-- Name: product_color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_color_id_seq', 1, false);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 1, false);


--
-- Name: product_size_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_size_id_seq', 1, false);


--
-- Name: refresh_token_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_token_storage_id_seq', 30, true);


--
-- Name: size_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.size_id_seq', 1, false);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: bin bin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bin
    ADD CONSTRAINT bin_pkey PRIMARY KEY (id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: change_pass_code_storage change_pass_code_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.change_pass_code_storage
    ADD CONSTRAINT change_pass_code_storage_pkey PRIMARY KEY (id);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: color color_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.color
    ADD CONSTRAINT color_pkey PRIMARY KEY (id);


--
-- Name: contract_storage contract_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contract_storage
    ADD CONSTRAINT contract_storage_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: pickpoint pickpoint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickpoint
    ADD CONSTRAINT pickpoint_pkey PRIMARY KEY (id);


--
-- Name: product_color product_color_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_color
    ADD CONSTRAINT product_color_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product_size product_size_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_size
    ADD CONSTRAINT product_size_pkey PRIMARY KEY (id);


--
-- Name: refresh_token_storage refresh_token_storage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_token_storage
    ADD CONSTRAINT refresh_token_storage_pkey PRIMARY KEY (id);


--
-- Name: size size_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.size
    ADD CONSTRAINT size_pkey PRIMARY KEY (id);


--
-- Name: bin bin_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bin
    ADD CONSTRAINT bin_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: bin bin_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bin
    ADD CONSTRAINT bin_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.client(id);


--
-- Name: client client_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_city_fkey FOREIGN KEY (city) REFERENCES public.city(id);


--
-- Name: order order_pickpoint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pickpoint_id_fkey FOREIGN KEY (pickpoint_id) REFERENCES public.pickpoint(id);


--
-- Name: order order_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: order order_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.client(id);


--
-- Name: pickpoint pickpoint_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickpoint
    ADD CONSTRAINT pickpoint_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(id);


--
-- Name: product product_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: product_color product_color_color_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_color
    ADD CONSTRAINT product_color_color_id_fkey FOREIGN KEY (color_id) REFERENCES public.color(id);


--
-- Name: product_color product_color_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_color
    ADD CONSTRAINT product_color_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: product_size product_size_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_size
    ADD CONSTRAINT product_size_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: product_size product_size_size_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_size
    ADD CONSTRAINT product_size_size_id_fkey FOREIGN KEY (size_id) REFERENCES public.size(id);


--
-- PostgreSQL database dump complete
--

