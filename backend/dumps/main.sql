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
    product_id integer,
    size_id integer,
    color_id integer
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
    user_id integer,
    sum integer,
    pickpoint_id integer,
    status public.orderstatuses,
    create_time timestamp without time zone,
    close_time timestamp without time zone,
    num text
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
-- Name: order_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_product (
    id integer NOT NULL,
    num text,
    product_id integer,
    size_id integer,
    color_id integer
);


ALTER TABLE public.order_product OWNER TO postgres;

--
-- Name: order_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_product_id_seq OWNER TO postgres;

--
-- Name: order_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_product_id_seq OWNED BY public.order_product.id;


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
    active boolean,
    short_description character varying(70)
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
-- Name: order_product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product ALTER COLUMN id SET DEFAULT nextval('public.order_product_id_seq'::regclass);


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
71021c94af5b
\.


--
-- Data for Name: bin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bin (id, user_id, product_id, size_id, color_id) FROM stdin;
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
2	Белый	#FFFFFF
3	Черный	#000000
4	Темно-синий	#151B54
5	Слоновая кость	#FFFFF0
6	Розовый	#FFC0CB
7	Желтый	#FFFF00
8	Голубой	#0000FF
9	Лиловый	#822680
10	Серый	#808080
11	Коричневый	#804030
\.


--
-- Data for Name: contract_storage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contract_storage (id, paid) FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (id, user_id, sum, pickpoint_id, status, create_time, close_time, num) FROM stdin;
\.


--
-- Data for Name: order_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_product (id, num, product_id, size_id, color_id) FROM stdin;
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photo (id, obj, obj_id, path, "time") FROM stdin;
48	product	6	product/6/6_0.jpg	2024-01-18 02:37:25.906451
49	product	6	product/6/6_0_small.jpg	2024-01-18 02:37:25.908038
50	product	7	product/7/7_0.jpg	2024-01-18 02:41:13.860943
51	product	7	product/7/7_0_small.jpg	2024-01-18 02:41:13.861453
52	product	8	product/8/8_0.jpg	2024-01-18 02:41:20.965747
53	product	8	product/8/8_0_small.jpg	2024-01-18 02:41:20.966289
54	product	9	product/9/9_0.jpg	2024-01-18 02:41:30.956212
55	product	9	product/9/9_0_small.jpg	2024-01-18 02:41:30.956752
56	product	10	product/10/10_0.jpg	2024-01-18 02:41:38.222969
57	product	10	product/10/10_0_small.jpg	2024-01-18 02:41:38.223477
58	product	11	product/11/11_0.jpg	2024-01-18 02:41:46.944391
59	product	11	product/11/11_0_small.jpg	2024-01-18 02:41:46.945065
60	product	12	product/12/12_0.jpg	2024-01-18 02:41:55.031209
61	product	12	product/12/12_0_small.jpg	2024-01-18 02:41:55.031775
62	product	13	product/13/13_0.jpg	2024-01-18 02:42:03.907728
63	product	13	product/13/13_0_small.jpg	2024-01-18 02:42:03.908209
64	product	14	product/14/14_0.jpg	2024-01-18 02:42:10.237374
65	product	14	product/14/14_0_small.jpg	2024-01-18 02:42:10.237897
66	product	15	product/15/15_0.jpg	2024-01-18 02:42:16.120813
67	product	15	product/15/15_0_small.jpg	2024-01-18 02:42:16.121265
68	product	16	product/16/16_0.jpg	2024-01-18 02:42:23.113247
69	product	16	product/16/16_0_small.jpg	2024-01-18 02:42:23.113833
70	product	17	product/17/17_0.jpg	2024-01-18 02:42:30.760668
71	product	17	product/17/17_0_small.jpg	2024-01-18 02:42:30.761123
72	product	18	product/18/18_0.jpg	2024-01-18 02:42:38.969654
73	product	18	product/18/18_0_small.jpg	2024-01-18 02:42:38.970143
74	product	19	product/19/19_0.jpg	2024-01-18 02:43:09.842138
75	product	19	product/19/19_0_small.jpg	2024-01-18 02:43:09.84266
76	product	20	product/20/20_0.jpg	2024-01-18 02:43:16.495043
77	product	20	product/20/20_0_small.jpg	2024-01-18 02:43:16.495526
78	product	21	product/21/21_0.jpg	2024-01-18 02:43:23.364343
79	product	21	product/21/21_0_small.jpg	2024-01-18 02:43:23.365012
80	product	22	product/22/22_0.jpg	2024-01-18 02:43:30.712949
81	product	22	product/22/22_0_small.jpg	2024-01-18 02:43:30.713489
82	product	23	product/23/23_0.jpg	2024-01-18 02:43:39.319997
83	product	23	product/23/23_0_small.jpg	2024-01-18 02:43:39.320458
84	product	24	product/24/24_0.jpg	2024-01-18 02:43:47.219354
85	product	24	product/24/24_0_small.jpg	2024-01-18 02:43:47.219991
86	product	25	product/25/25_0.jpg	2024-01-18 02:43:53.17637
87	product	25	product/25/25_0_small.jpg	2024-01-18 02:43:53.176891
88	product	26	product/26/26_0.jpg	2024-01-18 02:43:59.739493
89	product	26	product/26/26_0_small.jpg	2024-01-18 02:43:59.740012
90	product	27	product/27/27_0.jpg	2024-01-18 02:44:06.284346
91	product	27	product/27/27_0_small.jpg	2024-01-18 02:44:06.284798
92	product	28	product/28/28_0.jpg	2024-01-18 02:44:12.671256
93	product	28	product/28/28_0_small.jpg	2024-01-18 02:44:12.671765
94	product	29	product/29/29_0.jpg	2024-01-18 02:44:21.802784
95	product	29	product/29/29_0_small.jpg	2024-01-18 02:44:21.803279
\.


--
-- Data for Name: pickpoint; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickpoint (id, name, city_id) FROM stdin;
2	Острякова, 26	1
3	Светланская, 13	1
1	Кирова, 28	1
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, name, description, rating, price, sale, category_id, active, short_description) FROM stdin;
6	Футболка 'Котик с газетой'	Футболка с этим принтом - отличная вещь для людей, знающих толк в моде. Базовая модель с рисунком и свободный крой oversizeделает ее универсальной. Длинная унисекс футболка с качественным принтом отлично сядет на разные силуэты. Состав: хлопок 100% Размерная сетка: S(40-42), M(44-46), L(48-50), XL(50-52)	5	2000	0	2	t	Футболка с этим принтом - отличная вещь для людей
7	Футболка 'Котикс'	Трендовая футболка унисекс с свободным кроем отлично подойдет как для создания повседневных образов, так и для образов в деловом и спортивном стиле. Она производится из высококачественного хлопка с небольшим количеством искусственных волокон, благодаря этому кожа дышит. Состав: хлопок 92%, лайкра 8%. Размерная сетка: S(44-46), M(46-48), L(48-50), XL(50-52)	5	2200	0	2	t	Трендовая футболка унисекс
8	Футболка 'Путикот'	Отличная футболка с ярким принтом представлена в базовых цветах. Она отлично подойдет как для девушек, так и для парней. Принт напечатан очень качественно, что позволяет ему оставаться таким же ярким даже спустя многократных стирок.  Состав: хлопок 92%, лайкра 8%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50)	5	2000	0	2	t	Отличная футболка с ярким принтом
9	Футболка 'Котятки'	Отличная oversize футболка с интересным принтом хорошо поможет выделиться вам из толпы. Разнообразная палитра цветов поможет выбрать футболку, которая подходит именно вам. В состав входит 100% хлопок, что делает футболку очень приятной к телу Состав: хлопок 100%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50)	5	2000	0	2	t	Отличная oversize футболка с интересным принтом
10	Футболка 'Котик с мандаринами'	Футболку унисекс с качественным принтом отлично садится по фигуре и не сковывает движения. Она выполнена из качественного хлопка, что делает ее очень приятной к телу. Добавление искусственных волокон помогает футболке сохранять форму даже после многократных стирок. Состав: хлопок 92%, лайкра 8%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50))	5	1700	0	2	t	Футболку унисекс с качественным принтом
11	Футболка 'Котогалерея'	Базовая прямая футболка выполнена из мягкого хлопкового полотна средней плотности. Свободная посадка хорошо смотрится на любых типах фигур и не сковывает движения. Состав: хлопок 92%, лайкра 8%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50)	5	1700	0	2	t	Базовая прямая футболка с качественным принтом
12	Футболка 'Nuggetscat'	Предоставляем идеальную футболку унисекс с качественным принтом. Прямая футболка сделана из мягкого и приятного к телу хлопка, что делает ее актуальной в любое время года. За счет добавления лайкры вещь хорошо держит форму, не мнется и сохраняет первозданный вид. Она отлично садится по фигуре и не сковывает движения. Состав: хлопок 92%, лайкра 8%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50)	5	2500	0	2	t	Идеальная футболка унисекс с качественным принтом
13	Футболка 'Angelcat'	Отличная oversize футболка поможет вам чувствовать себя уверенно и комфортно, ведь она выполнена из плотного, но мягкого хлопка. Универсальные цвета подойдут под любой гардероб.  Состав: хлопок 92%, лайкра 8%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50)	5	2500	0	2	t	Отличная oversize футболка для уверенности
14	Толстовка 'Cats'	Крутой oversize, свободный силуэт, спущенная плечевая линия и объемный карман дарят стопроцентный комфорт, а подклад из начеса не даст замерзнуть. Толстовка подходит как для девушек, так и для парней. Состав: хлопок 80%, полиэстер 20%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50), XXL(50-52)	5	3000	0	8	t	Котики не упадут!
15	Толстовка 'Pew Pew'	Толстовка унисекс oversize утепленная с капюшоном сделана из мягкого материала, не колется и не вызывает раздражений. Ткань прочная, не скатывается и сохраняет форму даже при частном ношении.  Состав: хлопок 80%, полиэстер 20%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50), XXL(50-52)	5	3000	0	8	t	Толстовка унисекс oversize утепленная
16	Толстовка 'Hate morning'	Толстовка с принтом станет отличным дополнением к базовому гардеробу. Выполнена из качественного материала, который не меняет свой цвет даже после многочисленных стирок. Принт не трескается и не выцветает. Состав: хлопок 80%, полиэстер 20%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50), XXL(50-52)	5	2800	0	8	t	Толстовка унисекс
17	Толстовка 'Popcat'	Модная толстовка с принтом подойдет на каждый день. Толстовка выполнена из надежной ткани, которая не требует сложного ухода. Oversize крой хорошо садится на любую фигуру, подходит как для парней, так и для девушек.Состав: хлопок 80%, полиэстер 20%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50), XXL(50-52)	5	3000	0	8	t	Модная толстовка с принтом
18	Толстовка 'Killcat'	Толстовка хорошо подойдет для ежедневной носки. Она сохраняет яркость и стойкость цвета даже после многочисленных стирок. Ткань легкая и дышащая, хорошо удерживает тепло и держит форму.Состав: хлопок 80%, полиэстер 20%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50), XXL(50-52)	5	2700	0	8	t	Толстовка для настоящих котиков
19	Толстовка 'Кот с арбузами'	Уютная толстовка свободного кроя не сковывает движения, изделие хорошо держит форму. Толстовка с мягким начесом теплая и приятная к телу. Она отлично будет смотреться на разных типах фигур. Состав: хлопок 80%, полиэстер 20%. Размерная сетка: S(42-44), M(44-46), L(46-48), XL(48-50), XXL(50-52)	5	3200	0	8	t	Уютная толстовка свободного кроя
20	Сумка 'Шахматы'	Эта вместительная сумка-шоппер будет всегда в центре внимания. Невероятно удобная и функциональная, она без лишних деталей, но при этом современная и трендовая. С этой сумкой вы всегда будете чувствовать себя стильно и комфортно. Ширина: 35см. Высота: 40 см	5	3700	0	6	t	Вместительная сумка-шоппер
21	Сумка 'Все вместе'	Эта стильная сумка станет отличным дополнением вашему образу. Вязанный шоппер очень удобный и вместительный, он идеально подходит для повседневной носки. Ширина: 26см. Высота: 20 см	5	4000	0	6	t	Стильная сумка для котят
22	Носки 'Anglecat'	Удобные и мягкие носки с четким рисунком. Их комфортно носить в любое время года. Удобная резинка отчина держится на ноге и не перетягивает. Состав: хлопок 85%, полиамид 15%	5	350	0	5	t	Удобные и мягкие носки с четким рисунком
23	Носки 'Котик с клубочком'	Мягкие, приятные на ощупь носочки подойдут как для девушек, так и для парней. Они выполнены из качественных материалов и дают дышать ноге, идеальны для повседневной носки. Состав: хлопок 85%, полиамид 15%	5	450	0	5	t	Мягкие, приятные на ощупь носочки
24	Носки 'Много котиков'	Эти носочки имеют усиленные мысок и пятку, что делает их очень износостойкими. Хорошего качества, совершенно не парят и хорошо впитывают влагу. Состав: хлопок 85%, полиамид 15%	5	300	0	5	t	Носочки для ультра-котяток
25	Штаны 'Hello kitty'	Мягкие и уютные штаны в стиле hello kitty. Широкий силуэт, высокая талия на резинке. Изготовлены из невероятно мягкой и нежной ткани, покрытой плюшем с узором. Штаны превосходно сядут на вашу фигуру благодаря удобной резинке и обеспечат максимальный комфорт. Состав: полиэстер 100%	5	3500	0	9	t	Мягкие и уютные штаны в стиле hello kitty
26	Штаны 'Домашние котики'	Наши штаны - идеальное сочетание комфорта и стиля. Они изготовлены из хлопка, ваша кожа будет дышать. Штаны имеют свободный прямой крой, который подходит для любой фигуры. Состав: хлопок 92%, эластан 8%	5	3000	0	9	t	Лучшие штанишки лучшим котятам
27	Подвеска 'Котик спит'	Кулон и цепочка серебристого цвета, форма подвески в виде котика, замок - карабин. Длина цепи - 52 см. Оригинальный дизайн подвески дополнит любой образ. Состав: бижутерный сплав	5	1500	0	7	t	Котик, дарящий спокойствие
28	Кольцо 'Ушки и лапки'	Необычное и оригинальное женское кольцо дополнит Ваш образ. Благодаря своей необычной форме колечко в цвете серебро смотрится на руке стильно и оригинально. Кольцо регулируемое, так что подойдет всем. Состав: бижутерный сплав	5	1200	0	7	t	Необычное и оригинальное женское кольцо
29	Сережки 'Лежака'	Сережки изготовлены из легкого и гипоаллергенного акрила с ярким и насыщенным принтом. Это идеальный аксессуар для тех, кто хочет выделиться и подчеркнуть свою индивидуальность. Наша бижутерия с милыми котиками станет отличным подарком для вас и ваших близких и будет радовать вас каждый день Состав: акрил, бижутерный сплав	5	1800	0	7	t	Сережки для немножечко ленивых котиков
\.


--
-- Data for Name: product_color; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_color (id, product_id, color_id) FROM stdin;
7	6	2
8	6	5
9	6	6
10	7	2
11	7	6
12	7	7
13	7	8
14	8	2
15	8	3
16	9	2
17	9	3
18	9	6
19	9	8
20	10	2
21	10	6
22	11	2
23	11	7
24	11	3
25	11	8
26	12	2
27	12	9
28	12	6
29	12	8
30	13	2
31	13	3
32	13	6
33	13	10
34	14	2
35	14	3
36	14	10
37	15	2
38	15	3
39	15	10
40	15	6
41	16	2
42	16	3
43	16	10
44	16	6
45	17	2
46	17	3
47	17	10
48	18	2
49	18	3
50	18	10
51	19	2
52	19	10
53	19	9
54	19	4
55	20	3
56	20	11
57	21	3
58	21	11
59	21	6
60	22	4
61	23	2
62	23	3
63	23	4
64	24	11
65	24	3
66	24	2
67	25	3
68	25	6
69	26	2
70	26	3
71	27	2
72	27	3
73	28	10
74	29	7
\.


--
-- Data for Name: product_size; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_size (id, product_id, size_id) FROM stdin;
14	6	2
15	6	3
16	6	5
17	6	6
18	7	2
19	7	3
20	7	5
21	7	6
22	8	2
23	8	3
24	8	5
25	8	6
26	9	2
27	9	3
28	9	5
29	9	6
30	10	2
31	10	3
32	10	5
33	10	6
34	11	2
35	11	3
36	11	5
37	11	6
38	12	2
39	12	3
40	12	5
41	12	6
42	13	2
43	13	3
44	13	5
45	13	6
46	14	2
47	14	3
48	14	5
49	14	6
50	14	7
51	15	2
52	15	3
53	15	5
54	15	6
55	15	7
56	16	2
57	16	3
58	16	5
59	16	6
60	16	7
61	17	2
62	17	3
63	17	5
64	17	6
65	17	7
66	18	2
67	18	3
68	18	5
69	18	6
70	18	7
71	19	2
72	19	3
73	19	5
74	19	6
75	19	7
76	20	7
77	21	7
78	22	2
79	22	3
80	22	6
81	23	2
82	23	3
83	23	6
84	24	2
85	24	3
86	25	2
87	25	3
88	25	5
89	25	6
90	26	2
91	26	3
92	26	5
93	26	6
94	27	7
95	28	7
96	29	7
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
2	M
3	S
4	XS
5	L
6	XL
7	XXL
\.


--
-- Name: bin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bin_id_seq', 10, true);


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

SELECT pg_catalog.setval('public.color_id_seq', 11, true);


--
-- Name: contract_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contract_storage_id_seq', 1, false);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_id_seq', 12, true);


--
-- Name: order_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_product_id_seq', 3, true);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photo_id_seq', 95, true);


--
-- Name: pickpoint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickpoint_id_seq', 3, true);


--
-- Name: product_color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_color_id_seq', 74, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 29, true);


--
-- Name: product_size_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_size_id_seq', 96, true);


--
-- Name: refresh_token_storage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_token_storage_id_seq', 30, true);


--
-- Name: size_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.size_id_seq', 7, true);


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
-- Name: order_product order_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_pkey PRIMARY KEY (id);


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
-- Name: bin bin_color_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bin
    ADD CONSTRAINT bin_color_id_fkey FOREIGN KEY (color_id) REFERENCES public.color(id);


--
-- Name: bin bin_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bin
    ADD CONSTRAINT bin_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: bin bin_size_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bin
    ADD CONSTRAINT bin_size_id_fkey FOREIGN KEY (size_id) REFERENCES public.size(id);


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
-- Name: order_product order_product_color_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_color_id_fkey FOREIGN KEY (color_id) REFERENCES public.color(id);


--
-- Name: order_product order_product_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: order_product order_product_size_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_product_size_id_fkey FOREIGN KEY (size_id) REFERENCES public.size(id);


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

