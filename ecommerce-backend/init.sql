--
-- PostgreSQL database dump
--

-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
-- SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    is_default boolean,
    created_at timestamp(6) without time zone,
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    address_line character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    country character varying(255) NOT NULL,
    full_name character varying(255) NOT NULL,
    phone character varying(255),
    postal_code character varying(255),
    state character varying(255)
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addresses_id_seq OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    created_at timestamp(6) without time zone,
    id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_id_seq OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    quantity integer NOT NULL,
    cart_id bigint NOT NULL,
    id bigint NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    parent_id bigint,
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: complaints; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.complaints (
    created_at timestamp(6) without time zone,
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    user_id bigint NOT NULL,
    description text NOT NULL,
    issue_type character varying(255) NOT NULL,
    status character varying(255),
    CONSTRAINT complaints_issue_type_check CHECK (((issue_type)::text = ANY ((ARRAY['PAYMENT'::character varying, 'DELIVERY'::character varying, 'PRODUCT'::character varying, 'OTHER'::character varying])::text[]))),
    CONSTRAINT complaints_status_check CHECK (((status)::text = ANY ((ARRAY['OPEN'::character varying, 'RESOLVED'::character varying])::text[])))
);


ALTER TABLE public.complaints OWNER TO postgres;

--
-- Name: complaints_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.complaints_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.complaints_id_seq OWNER TO postgres;

--
-- Name: complaints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.complaints_id_seq OWNED BY public.complaints.id;


--
-- Name: customer_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_profiles (
    age integer,
    satisfaction_level integer,
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    city character varying(255),
    membership_type character varying(255)
);


ALTER TABLE public.customer_profiles OWNER TO postgres;

--
-- Name: customer_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_profiles_id_seq OWNER TO postgres;

--
-- Name: customer_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_profiles_id_seq OWNED BY public.customer_profiles.id;


--
-- Name: logistics_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logistics_provider (
    id bigint NOT NULL,
    contact_info character varying(255),
    name character varying(255)
);


ALTER TABLE public.logistics_provider OWNER TO postgres;

--
-- Name: logistics_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logistics_provider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logistics_provider_id_seq OWNER TO postgres;

--
-- Name: logistics_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logistics_provider_id_seq OWNED BY public.logistics_provider.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    quantity integer NOT NULL,
    unit_price numeric(38,2) NOT NULL,
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    grand_total numeric(38,2) NOT NULL,
    created_at timestamp(6) without time zone,
    id bigint NOT NULL,
    logistic_id bigint,
    shipping_address_id bigint,
    store_id bigint,
    user_id bigint NOT NULL,
    status character varying(255),
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'PROCESSING'::character varying, 'SHIPPED'::character varying, 'DELIVERED'::character varying, 'CANCELLED'::character varying, 'RETURN_REQUESTED'::character varying, 'RETURNED'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    amount numeric(38,2),
    created_at timestamp(6) without time zone,
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    payment_method character varying(255),
    payment_status character varying(255),
    CONSTRAINT payments_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['STRIPE'::character varying, 'PAYPAL'::character varying])::text[]))),
    CONSTRAINT payments_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['PENDING'::character varying, 'COMPLETED'::character varying, 'FAILED'::character varying])::text[])))
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: product_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_attribute (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE public.product_attribute OWNER TO postgres;

--
-- Name: product_attribute_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_attribute_id_seq OWNER TO postgres;

--
-- Name: product_attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_attribute_id_seq OWNED BY public.product_attribute.id;


--
-- Name: product_attribute_value; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_attribute_value (
    attribute_id bigint,
    id bigint NOT NULL,
    value character varying(255)
);


ALTER TABLE public.product_attribute_value OWNER TO postgres;

--
-- Name: product_attribute_value_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_attribute_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_attribute_value_id_seq OWNER TO postgres;

--
-- Name: product_attribute_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_attribute_value_id_seq OWNED BY public.product_attribute_value.id;


--
-- Name: product_product_attribute_values; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_product_attribute_values (
    attribute_value_id bigint NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.product_product_attribute_values OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    stock_quantity integer,
    unit_price numeric(38,2) NOT NULL,
    category_id bigint,
    created_at timestamp(6) without time zone,
    id bigint NOT NULL,
    store_id bigint NOT NULL,
    description character varying(255),
    image_url character varying(255),
    name character varying(255) NOT NULL,
    sku character varying(255)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    star_rating integer NOT NULL,
    created_at timestamp(6) without time zone,
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    user_id bigint NOT NULL,
    sentiment character varying(20),
    comment text
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: shipments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipments (
    customer_care_calls integer,
    estimated_arrival timestamp(6) without time zone,
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    mode character varying(255),
    product_importance character varying(255),
    status character varying(255),
    warehouse character varying(255)
);


ALTER TABLE public.shipments OWNER TO postgres;

--
-- Name: shipments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shipments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shipments_id_seq OWNER TO postgres;

--
-- Name: shipments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shipments_id_seq OWNED BY public.shipments.id;


--
-- Name: stores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stores (
    id bigint NOT NULL,
    owner_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    status character varying(255)
);


ALTER TABLE public.stores OWNER TO postgres;

--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stores_id_seq OWNER TO postgres;

--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stores_id_seq OWNED BY public.stores.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    created_at timestamp(6) without time zone,
    id bigint NOT NULL,
    updated_at timestamp(6) without time zone,
    gender character varying(20),
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(255),
    status character varying(255),
    username character varying(255) NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['CUSTOMER'::character varying, 'ADMIN'::character varying, 'SELLER'::character varying])::text[]))),
    CONSTRAINT users_status_check CHECK (((status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'BANNED'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: complaints id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complaints ALTER COLUMN id SET DEFAULT nextval('public.complaints_id_seq'::regclass);


--
-- Name: customer_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_profiles ALTER COLUMN id SET DEFAULT nextval('public.customer_profiles_id_seq'::regclass);


--
-- Name: logistics_provider id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logistics_provider ALTER COLUMN id SET DEFAULT nextval('public.logistics_provider_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: product_attribute id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute ALTER COLUMN id SET DEFAULT nextval('public.product_attribute_id_seq'::regclass);


--
-- Name: product_attribute_value id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_value ALTER COLUMN id SET DEFAULT nextval('public.product_attribute_value_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: shipments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments ALTER COLUMN id SET DEFAULT nextval('public.shipments_id_seq'::regclass);


--
-- Name: stores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores ALTER COLUMN id SET DEFAULT nextval('public.stores_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cart VALUES ('2026-04-02 21:48:51.51886', 1, 105);
INSERT INTO public.cart VALUES ('2026-04-02 22:42:12.621562', 2, 106);
INSERT INTO public.cart VALUES ('2026-04-02 22:48:56.057875', 3, 107);
INSERT INTO public.cart VALUES ('2026-04-02 22:49:24.042177', 4, 108);
INSERT INTO public.cart VALUES ('2026-04-02 23:22:21.302163', 5, 114);


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cart_items VALUES (1, 2, 1, 4);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES (12, NULL, 'Home Lighting');
INSERT INTO public.categories VALUES (13, NULL, 'Bags & Accessories');
INSERT INTO public.categories VALUES (14, NULL, 'Kitchen & Dining');
INSERT INTO public.categories VALUES (15, NULL, 'Home Decor');
INSERT INTO public.categories VALUES (16, NULL, 'Storage');
INSERT INTO public.categories VALUES (17, NULL, 'Seasonal');
INSERT INTO public.categories VALUES (18, NULL, 'Clocks & Watches');
INSERT INTO public.categories VALUES (19, NULL, 'Cards & Wrapping');
INSERT INTO public.categories VALUES (20, NULL, 'Toys & Games');
INSERT INTO public.categories VALUES (21, NULL, 'Signs & Letters');
INSERT INTO public.categories VALUES (22, NULL, 'General');


--
-- Data for Name: complaints; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: customer_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.customer_profiles VALUES (25, NULL, 1, 3, 'City D', NULL);
INSERT INTO public.customer_profiles VALUES (34, NULL, 2, 7, 'City E', NULL);
INSERT INTO public.customer_profiles VALUES (56, NULL, 3, 8, 'City F', NULL);
INSERT INTO public.customer_profiles VALUES (29, NULL, 4, 9, 'City G', NULL);
INSERT INTO public.customer_profiles VALUES (42, NULL, 5, 10, 'City H', NULL);
INSERT INTO public.customer_profiles VALUES (51, NULL, 6, 11, 'City I', NULL);
INSERT INTO public.customer_profiles VALUES (36, NULL, 7, 12, 'City J', NULL);
INSERT INTO public.customer_profiles VALUES (48, NULL, 8, 13, 'City K', NULL);
INSERT INTO public.customer_profiles VALUES (25, NULL, 9, 14, 'City L', NULL);
INSERT INTO public.customer_profiles VALUES (48, NULL, 10, 24, 'City J', NULL);
INSERT INTO public.customer_profiles VALUES (30, NULL, 11, 25, 'City K', NULL);
INSERT INTO public.customer_profiles VALUES (65, NULL, 12, 26, 'City L', NULL);
INSERT INTO public.customer_profiles VALUES (50, NULL, 13, 40, 'City P', NULL);


--
-- Data for Name: logistics_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_items VALUES (1, 1.09, 1, 502, 1);
INSERT INTO public.order_items VALUES (1, 0.39, 2, 502, 2);
INSERT INTO public.order_items VALUES (1, 1.09, 3, 503, 1);
INSERT INTO public.order_items VALUES (4, 0.39, 4, 503, 2);
INSERT INTO public.order_items VALUES (1, 0.21, 5, 503, 3);
INSERT INTO public.order_items VALUES (1, 6.42, 6, 503, 19);
INSERT INTO public.order_items VALUES (1, 1.09, 7, 504, 1);
INSERT INTO public.order_items VALUES (2, 1.09, 8, 505, 1);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders VALUES (2382.00, '2025-04-20 21:33:55.335434', 2, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (2521.00, '2026-03-21 21:33:55.335444', 3, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (2611.00, '2025-06-29 21:33:55.335446', 4, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (310.00, '2025-11-09 21:33:55.335448', 5, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1284.00, '2026-01-24 21:33:55.335449', 6, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1496.00, '2026-03-23 21:33:55.335451', 7, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (4828.00, '2026-01-18 21:33:55.335452', 8, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (2681.00, '2025-08-15 21:33:55.335454', 9, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (518.00, '2026-02-05 21:33:55.335455', 10, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1931.00, '2026-01-27 21:33:55.335457', 11, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (1791.00, '2026-02-06 21:33:55.335459', 12, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (4178.00, '2025-09-27 21:33:55.33546', 13, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (3397.00, '2025-05-31 21:33:55.335461', 14, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (4270.00, '2025-09-22 21:33:55.335463', 15, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (1884.00, '2025-09-16 21:33:55.335464', 16, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (669.00, '2026-03-26 21:33:55.335466', 17, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (4470.00, '2025-11-27 21:33:55.335467', 18, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (3177.00, '2025-11-17 21:33:55.335469', 19, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (1802.00, '2025-07-30 21:33:55.33547', 20, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1829.00, '2025-08-01 21:33:55.335472', 21, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (4881.00, '2025-11-11 21:33:55.335473', 22, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (207.00, '2025-06-18 21:33:55.335475', 23, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (1704.00, '2025-10-13 21:33:55.335476', 24, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (1603.00, '2025-04-06 21:33:55.335477', 25, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (1750.00, '2025-08-20 21:33:55.335479', 26, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (766.00, '2025-04-26 21:33:55.33548', 27, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3320.00, '2025-09-24 21:33:55.335482', 28, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (2784.00, '2025-09-30 21:33:55.335483', 29, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (4366.00, '2025-07-06 21:33:55.335485', 30, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (2497.00, '2026-02-07 21:33:55.335486', 31, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (172.00, '2025-12-01 21:33:55.335488', 32, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2239.00, '2025-12-09 21:33:55.335489', 33, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (619.00, '2025-11-22 21:33:55.33549', 34, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (4562.00, '2026-03-05 21:33:55.335492', 35, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (182.00, '2026-02-15 21:33:55.335494', 36, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (724.00, '2026-02-05 21:33:55.335495', 37, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (4783.00, '2025-11-23 21:33:55.335496', 38, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (1844.00, '2025-12-21 21:33:55.335498', 39, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (1802.00, '2026-03-08 21:33:55.335499', 40, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (3973.00, '2025-10-27 21:33:55.335501', 41, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (819.00, '2026-03-18 21:33:55.335502', 42, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3326.00, '2025-05-16 21:33:55.335504', 43, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (1071.00, '2025-07-04 21:33:55.335505', 44, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (2100.00, '2026-03-29 21:33:55.335507', 45, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (2106.00, '2026-04-02 21:33:55.335508', 46, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (911.00, '2025-12-29 21:33:55.33551', 47, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (3109.00, '2025-11-22 21:33:55.335511', 48, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (384.00, '2025-07-12 21:33:55.335513', 49, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2059.00, '2025-04-30 21:33:55.335514', 50, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (1483.00, '2025-08-08 21:33:55.335516', 51, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (267.00, '2025-12-11 21:33:55.335517', 52, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (2028.00, '2026-03-26 21:33:55.335518', 53, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4995.00, '2026-03-23 21:33:55.33552', 54, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (1475.00, '2025-08-06 21:33:55.335522', 55, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (2027.00, '2025-07-31 21:33:55.335523', 56, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (293.00, '2025-07-14 21:33:55.335524', 57, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2044.00, '2025-10-21 21:33:55.335526', 58, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (1963.00, '2026-01-06 21:33:55.335527', 59, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3358.00, '2026-03-09 21:33:55.335528', 60, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (4713.00, '2025-09-08 21:33:55.33553', 61, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (172.00, '2026-03-03 21:33:55.335531', 62, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (4286.00, '2026-01-05 21:33:55.335533', 63, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (192.00, '2026-03-21 21:33:55.335534', 64, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (4978.00, '2025-07-07 21:33:55.335536', 65, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (2296.00, '2026-02-24 21:33:55.335537', 66, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (1287.00, '2026-03-07 21:33:55.335539', 67, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (3582.00, '2026-03-11 21:33:55.335541', 68, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (1434.00, '2025-10-03 21:33:55.335542', 69, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4640.00, '2025-05-15 21:33:55.335543', 70, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (758.00, '2025-05-18 21:33:55.335545', 71, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (3752.00, '2025-11-17 21:33:55.335546', 72, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (2459.00, '2025-04-22 21:33:55.335548', 73, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (2909.00, '2025-09-24 21:33:55.335549', 74, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3679.00, '2025-07-15 21:33:55.335551', 75, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (3385.00, '2025-07-09 21:33:55.335552', 76, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (381.00, '2026-03-27 21:33:55.335554', 77, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (2250.00, '2025-08-04 21:33:55.335555', 78, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (3991.00, '2026-02-08 21:33:55.335557', 79, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (896.00, '2025-09-15 21:33:55.335558', 80, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (3208.00, '2025-08-09 21:33:55.33556', 81, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (4282.00, '2026-02-06 21:33:55.335561', 82, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1258.00, '2025-09-05 21:33:55.335562', 83, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (1436.00, '2025-10-31 21:33:55.335564', 84, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (57.00, '2025-12-02 21:33:55.335565', 85, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (1934.00, '2026-03-08 21:33:55.335566', 86, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (4106.00, '2025-11-18 21:33:55.335568', 87, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (4620.00, '2025-04-12 21:33:55.335569', 88, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (4949.00, '2025-09-12 21:33:55.335571', 89, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (1814.00, '2025-04-09 21:33:55.335572', 90, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (4183.00, '2025-11-26 21:33:55.335574', 91, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (3328.00, '2025-10-02 21:33:55.335575', 92, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (4237.00, '2025-10-15 21:33:55.335577', 93, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (2970.00, '2025-10-11 21:33:55.335578', 94, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (4341.00, '2025-12-11 21:33:55.33558', 95, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (689.00, '2026-02-25 21:33:55.335582', 96, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2165.00, '2026-03-13 21:33:55.335583', 97, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (769.00, '2025-05-27 21:33:55.335584', 98, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (1227.00, '2025-05-24 21:33:55.335586', 99, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (4512.00, '2025-05-03 21:33:55.335587', 100, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (466.00, '2025-11-17 21:33:55.335589', 101, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (383.00, '2025-07-09 21:33:55.33559', 102, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (1444.00, '2025-07-14 21:33:55.335592', 103, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (2162.00, '2026-02-19 21:33:55.335593', 104, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (4396.00, '2025-08-25 21:33:55.335594', 105, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1096.00, '2025-10-18 21:33:55.335596', 106, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (1356.00, '2025-05-08 21:33:55.335597', 107, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (4076.00, '2025-10-08 21:33:55.335599', 108, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2193.00, '2025-05-02 21:33:55.3356', 109, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (4781.00, '2025-07-11 21:33:55.335602', 110, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (2745.00, '2026-03-12 21:33:55.335603', 111, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (2900.00, '2025-10-26 21:33:55.335605', 112, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3783.00, '2025-06-07 21:33:55.335606', 113, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (3873.00, '2025-12-12 21:33:55.335608', 114, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (2043.00, '2025-04-27 21:33:55.335609', 115, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (1753.00, '2025-05-16 21:33:55.335611', 116, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (1570.00, '2025-10-11 21:33:55.335612', 117, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3066.00, '2025-10-01 21:33:55.335613', 118, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (2356.00, '2025-10-26 21:33:55.335615', 119, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (496.00, '2025-04-25 21:33:55.335616', 120, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (1161.00, '2025-08-02 21:33:55.335618', 121, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (4863.00, '2025-10-20 21:33:55.335619', 122, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3366.00, '2025-06-18 21:33:55.335621', 123, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (4847.00, '2025-09-01 21:33:55.335622', 124, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (318.00, '2025-04-18 21:33:55.335624', 125, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (1307.00, '2026-03-14 21:33:55.335625', 126, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (3272.00, '2025-12-22 21:33:55.335627', 127, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (2073.00, '2025-09-19 21:33:55.335628', 128, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (4215.00, '2025-10-10 21:33:55.335629', 129, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3363.00, '2026-01-25 21:33:55.335631', 130, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (302.00, '2025-09-13 21:33:55.335633', 131, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (2177.00, '2025-12-10 21:33:55.335634', 132, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (3870.00, '2025-10-10 21:33:55.335635', 133, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (4304.00, '2025-08-28 21:33:55.335637', 134, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (996.00, '2025-10-13 21:33:55.335638', 135, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (2599.00, '2025-04-28 21:33:55.33564', 136, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (4922.00, '2026-03-04 21:33:55.335641', 137, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (3476.00, '2025-06-04 21:33:55.335642', 138, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (136.00, '2026-03-21 21:33:55.335644', 139, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (1815.00, '2025-12-02 21:33:55.335646', 140, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (277.00, '2025-06-09 21:33:55.335647', 141, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (1247.00, '2025-11-03 21:33:55.335648', 142, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (750.00, '2026-02-24 21:33:55.33565', 143, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (340.00, '2025-08-27 21:33:55.335651', 144, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (4470.00, '2026-01-10 21:33:55.335653', 145, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (3998.00, '2025-08-30 21:33:55.335654', 146, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (1954.00, '2025-04-29 21:33:55.335656', 147, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (1529.00, '2025-06-28 21:33:55.335657', 148, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (4585.00, '2025-12-01 21:33:55.335659', 149, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (173.00, '2025-09-19 21:33:55.33566', 150, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (927.00, '2025-07-18 21:33:55.335662', 151, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (2658.00, '2025-11-07 21:33:55.335663', 152, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (1769.00, '2025-12-26 21:33:55.335665', 153, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (1640.00, '2025-06-08 21:33:55.335666', 154, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (1025.00, '2025-09-30 21:33:55.335668', 155, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (2012.00, '2026-02-15 21:33:55.335669', 156, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (4184.00, '2025-09-17 21:33:55.33567', 157, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (4929.00, '2025-05-05 21:33:55.335672', 158, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (1210.00, '2025-09-18 21:33:55.335673', 159, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (1114.00, '2025-06-11 21:33:55.335675', 160, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (3157.00, '2025-10-13 21:33:55.335676', 161, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3001.00, '2025-06-02 21:33:55.335678', 162, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3143.00, '2026-02-19 21:33:55.335679', 163, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (843.00, '2025-04-19 21:33:55.33568', 164, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4006.00, '2025-10-03 21:33:55.335682', 165, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4848.00, '2025-11-21 21:33:55.335683', 166, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (382.00, '2026-01-29 21:33:55.335685', 167, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (827.00, '2025-12-12 21:33:55.335686', 168, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (4822.00, '2025-10-25 21:33:55.335687', 169, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (1829.00, '2025-11-14 21:33:55.335689', 170, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (3953.00, '2025-04-16 21:33:55.33572', 171, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (1947.00, '2025-05-24 21:33:55.335722', 172, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (1201.00, '2025-09-24 21:33:55.335723', 173, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (3411.00, '2025-09-19 21:33:55.335724', 174, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (1784.00, '2026-02-27 21:33:55.335726', 175, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (2625.00, '2026-02-07 21:33:55.335728', 176, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (2219.00, '2026-01-13 21:33:55.335729', 177, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (4872.00, '2025-04-13 21:33:55.33573', 178, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (1219.00, '2025-05-02 21:33:55.335732', 179, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (2321.00, '2026-03-22 21:33:55.335733', 180, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (3635.00, '2025-10-01 21:33:55.335734', 181, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (4294.00, '2025-08-05 21:33:55.335736', 182, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (902.00, '2025-10-23 21:33:55.335737', 183, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4899.00, '2026-03-12 21:33:55.335739', 184, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (2967.00, '2025-07-05 21:33:55.33574', 185, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (2732.00, '2026-02-08 21:33:55.335742', 186, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3896.00, '2025-08-01 21:33:55.335743', 187, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4629.00, '2025-10-11 21:33:55.335744', 188, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4008.00, '2025-04-02 21:33:55.335746', 189, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (1536.00, '2026-02-04 21:33:55.335747', 190, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (3995.00, '2026-03-10 21:33:55.335749', 191, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (450.00, '2025-12-25 21:33:55.33575', 192, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4113.00, '2026-03-11 21:33:55.335751', 193, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (549.00, '2025-06-13 21:33:55.335753', 194, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3570.00, '2025-12-08 21:33:55.335754', 195, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (2702.00, '2025-05-30 21:33:55.335756', 196, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (2133.00, '2025-10-03 21:33:55.335757', 197, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (990.00, '2026-01-13 21:33:55.335759', 198, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (4199.00, '2025-10-06 21:33:55.33576', 199, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (1953.00, '2025-09-19 21:33:55.335762', 200, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (382.00, '2025-11-25 21:33:55.335763', 201, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (379.00, '2026-01-30 21:33:55.335764', 202, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (980.00, '2026-01-03 21:33:55.335766', 203, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2845.00, '2025-10-25 21:33:55.335767', 204, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (4561.00, '2026-01-26 21:33:55.335769', 205, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (2026.00, '2025-08-08 21:33:55.33577', 206, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (1046.00, '2025-09-09 21:33:55.335772', 207, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2494.00, '2026-03-09 21:33:55.335773', 208, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (4804.00, '2025-11-04 21:33:55.335774', 209, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3436.00, '2026-02-25 21:33:55.335776', 210, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (4751.00, '2025-12-08 21:33:55.335777', 211, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (2414.00, '2025-10-24 21:33:55.335778', 212, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (3312.00, '2026-01-07 21:33:55.33578', 213, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (159.00, '2025-05-29 21:33:55.335781', 214, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3325.00, '2025-05-14 21:33:55.335783', 215, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (3295.00, '2025-04-26 21:33:55.335784', 216, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3514.00, '2025-11-25 21:33:55.335786', 217, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (3108.00, '2025-06-23 21:33:55.335787', 218, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (2136.00, '2026-01-25 21:33:55.33579', 219, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (4564.00, '2025-05-28 21:33:55.335792', 220, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (3506.00, '2025-12-02 21:33:55.335793', 221, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (4269.00, '2025-09-23 21:33:55.335794', 222, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4180.00, '2025-10-09 21:33:55.335796', 223, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (995.00, '2025-11-23 21:33:55.335797', 224, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (744.00, '2026-03-06 21:33:55.335799', 225, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (2462.00, '2025-05-05 21:33:55.3358', 226, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (1736.00, '2025-07-13 21:33:55.335801', 227, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (3856.00, '2025-06-18 21:33:55.335803', 228, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3437.00, '2025-08-23 21:33:55.335804', 229, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (4847.00, '2025-08-15 21:33:55.335805', 230, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (298.00, '2025-11-27 21:33:55.335807', 231, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (927.00, '2025-12-01 21:33:55.335808', 232, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (4167.00, '2025-11-14 21:33:55.335809', 233, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (262.00, '2025-08-08 21:33:55.335811', 234, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (1847.00, '2025-12-03 21:33:55.335812', 235, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (2134.00, '2025-08-25 21:33:55.335814', 236, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1452.00, '2025-05-02 21:33:55.335815', 237, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3534.00, '2025-05-25 21:33:55.335816', 238, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (4091.00, '2025-12-11 21:33:55.335818', 239, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3952.00, '2025-04-22 21:33:55.335819', 240, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (1391.00, '2025-09-23 21:33:55.33582', 241, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (2766.00, '2025-04-08 21:33:55.335821', 242, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (1751.00, '2025-06-18 21:33:55.335822', 243, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3943.00, '2025-08-24 21:33:55.335824', 244, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (4410.00, '2025-10-28 21:33:55.335825', 245, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2933.00, '2025-09-05 21:33:55.335826', 246, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2567.00, '2026-01-04 21:33:55.335827', 247, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (1585.00, '2026-02-03 21:33:55.335829', 248, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (4030.00, '2025-12-28 21:33:55.33583', 249, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (98.00, '2026-03-19 21:33:55.335831', 250, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (3979.00, '2026-03-30 21:33:55.335832', 251, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (4012.00, '2025-12-21 21:33:55.335833', 252, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (3971.00, '2025-12-15 21:33:55.335835', 253, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (351.00, '2026-03-10 21:33:55.335836', 254, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1270.00, '2025-10-08 21:33:55.335837', 255, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3038.00, '2026-03-12 21:33:55.335838', 256, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (4212.00, '2025-05-26 21:33:55.33584', 257, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3646.00, '2026-03-23 21:33:55.335841', 258, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (3272.00, '2025-04-22 21:33:55.335842', 259, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (1888.00, '2025-12-30 21:33:55.335844', 260, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (4322.00, '2026-02-23 21:33:55.335845', 261, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (1649.00, '2026-02-01 21:33:55.335846', 262, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (1612.00, '2026-03-24 21:33:55.335848', 263, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (1321.00, '2025-10-18 21:33:55.335849', 264, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (4272.00, '2025-08-05 21:33:55.33585', 265, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (3478.00, '2026-02-01 21:33:55.335851', 266, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4375.00, '2025-05-09 21:33:55.335853', 267, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (2436.00, '2026-03-23 21:33:55.335854', 268, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (1418.00, '2025-11-23 21:33:55.335855', 269, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (979.00, '2026-03-19 21:33:55.335857', 270, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (3335.00, '2025-04-12 21:33:55.335858', 271, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3086.00, '2026-01-29 21:33:55.335859', 272, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (1222.00, '2025-11-29 21:33:55.33586', 273, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (4582.00, '2026-01-27 21:33:55.335862', 274, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (3636.00, '2025-05-28 21:33:55.335863', 275, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3926.00, '2026-03-24 21:33:55.335864', 276, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (758.00, '2025-10-26 21:33:55.335865', 277, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (2012.00, '2025-11-22 21:33:55.335867', 278, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (838.00, '2025-05-08 21:33:55.335868', 279, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (315.00, '2025-11-17 21:33:55.335869', 280, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2718.00, '2026-03-15 21:33:55.33587', 281, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (4384.00, '2026-02-23 21:33:55.335872', 282, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (3191.00, '2025-09-20 21:33:55.335873', 283, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (4266.00, '2025-11-11 21:33:55.335874', 284, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (1695.00, '2025-10-23 21:33:55.335875', 285, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2261.00, '2026-02-24 21:33:55.335877', 286, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (3090.00, '2026-01-13 21:33:55.335878', 287, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (615.00, '2025-06-20 21:33:55.335879', 288, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (3839.00, '2025-04-26 21:33:55.33588', 289, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (3326.00, '2025-05-12 21:33:55.335882', 290, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (899.00, '2026-03-01 21:33:55.335883', 291, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2165.00, '2026-02-04 21:33:55.335884', 292, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (2690.00, '2026-02-20 21:33:55.335886', 293, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2388.00, '2026-02-23 21:33:55.335887', 294, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (2762.00, '2026-02-21 21:33:55.335888', 295, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4552.00, '2026-02-07 21:33:55.335889', 296, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4189.00, '2025-12-16 21:33:55.335891', 297, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (4758.00, '2025-10-02 21:33:55.335892', 298, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (2285.00, '2025-05-09 21:33:55.335893', 299, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4038.00, '2025-06-10 21:33:55.335894', 300, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3933.00, '2026-02-16 21:33:55.335896', 301, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (4947.00, '2026-03-01 21:33:55.335897', 302, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2703.00, '2026-01-03 21:33:55.335898', 303, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (4657.00, '2025-04-20 21:33:55.3359', 304, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (3800.00, '2025-05-08 21:33:55.335901', 305, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2572.00, '2025-05-07 21:33:55.335902', 306, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (4369.00, '2025-12-07 21:33:55.335903', 307, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (4346.00, '2025-05-29 21:33:55.335905', 308, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (4906.00, '2026-03-21 21:33:55.335906', 309, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (2379.00, '2026-03-22 21:33:55.335907', 310, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (2540.00, '2025-04-07 21:33:55.335909', 311, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (2962.00, '2026-03-08 21:33:55.33591', 312, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (960.00, '2026-01-17 21:33:55.335911', 313, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (1837.00, '2026-01-26 21:33:55.335913', 314, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (1958.00, '2025-05-03 21:33:55.335914', 315, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (2287.00, '2025-08-09 21:33:55.335915', 316, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (3545.00, '2025-11-10 21:33:55.335916', 317, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (4291.00, '2025-08-12 21:33:55.335918', 318, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (1124.00, '2025-12-02 21:33:55.335919', 319, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (262.00, '2026-01-07 21:33:55.33592', 320, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3818.00, '2025-09-12 21:33:55.335922', 321, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4996.00, '2025-07-30 21:33:55.335923', 322, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (2365.00, '2025-09-07 21:33:55.335924', 323, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (3159.00, '2025-12-06 21:33:55.335925', 324, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (2776.00, '2025-11-13 21:33:55.335927', 325, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4260.00, '2025-06-03 21:33:55.335928', 326, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (1430.00, '2026-02-08 21:33:55.335929', 327, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (1639.00, '2025-09-06 21:33:55.33593', 328, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (895.00, '2025-08-26 21:33:55.335932', 329, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (4059.00, '2025-08-14 21:33:55.335933', 330, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2910.00, '2025-10-14 21:33:55.335934', 331, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (2181.00, '2025-07-30 21:33:55.335935', 332, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (523.00, '2026-02-08 21:33:55.335936', 333, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (325.00, '2025-12-30 21:33:55.335938', 334, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (3078.00, '2026-03-12 21:33:55.335939', 335, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (889.00, '2025-11-21 21:33:55.33594', 336, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (1036.00, '2026-02-17 21:33:55.335942', 337, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (4886.00, '2025-07-27 21:33:55.335943', 338, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (1564.00, '2025-07-17 21:33:55.335944', 339, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (4088.00, '2025-04-26 21:33:55.335945', 340, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4271.00, '2025-07-03 21:33:55.335947', 341, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (795.00, '2025-06-18 21:33:55.335948', 342, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (1486.00, '2025-09-13 21:33:55.33595', 343, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (3308.00, '2025-10-02 21:33:55.335951', 344, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (293.00, '2025-08-23 21:33:55.335952', 345, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (448.00, '2025-07-06 21:33:55.335954', 346, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4944.00, '2026-03-06 21:33:55.335955', 347, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (1834.00, '2025-09-07 21:33:55.335956', 348, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3234.00, '2025-11-02 21:33:55.335958', 349, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (1290.00, '2025-05-17 21:33:55.335959', 350, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (1611.00, '2025-07-14 21:33:55.33596', 351, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1915.00, '2026-03-09 21:33:55.335962', 352, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2732.00, '2026-03-02 21:33:55.335963', 353, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (2003.00, '2025-07-15 21:33:55.335964', 354, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (70.00, '2025-08-02 21:33:55.335966', 355, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (2610.00, '2025-08-05 21:33:55.335967', 356, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (212.00, '2025-09-05 21:33:55.335969', 357, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4077.00, '2025-07-19 21:33:55.33597', 358, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (2276.00, '2025-09-25 21:33:55.335971', 359, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (1582.00, '2025-04-11 21:33:55.335973', 360, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (945.00, '2025-05-09 21:33:55.335974', 361, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (1261.00, '2025-07-03 21:33:55.335975', 362, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (1544.00, '2025-05-12 21:33:55.335977', 363, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (3190.00, '2026-01-02 21:33:55.335978', 364, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3067.00, '2025-11-05 21:33:55.335979', 365, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (4614.00, '2025-05-14 21:33:55.33598', 366, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (3267.00, '2025-05-09 21:33:55.335982', 367, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (4255.00, '2025-07-27 21:33:55.335983', 368, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (1040.00, '2025-05-02 21:33:55.335984', 369, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (3073.00, '2025-05-08 21:33:55.335986', 370, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3043.00, '2025-05-02 21:33:55.335987', 371, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (106.00, '2025-08-12 21:33:55.335988', 372, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (3747.00, '2026-01-20 21:33:55.335989', 373, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (1496.00, '2025-04-10 21:33:55.335991', 374, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (324.00, '2025-06-09 21:33:55.335992', 375, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4544.00, '2026-03-15 21:33:55.335993', 376, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (3156.00, '2025-12-01 21:33:55.335995', 377, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (3277.00, '2025-11-30 21:33:55.335996', 378, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (1772.00, '2025-07-27 21:33:55.335997', 379, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (3241.00, '2025-09-12 21:33:55.335998', 380, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (2963.00, '2025-11-09 21:33:55.336', 381, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (4915.00, '2025-11-13 21:33:55.336001', 382, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (4108.00, '2026-02-15 21:33:55.336002', 383, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (995.00, '2025-08-22 21:33:55.336004', 384, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3038.00, '2026-01-21 21:33:55.336005', 385, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (2680.00, '2025-09-24 21:33:55.336006', 386, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (660.00, '2026-03-02 21:33:55.336007', 387, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (135.00, '2025-09-09 21:33:55.336009', 388, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2304.00, '2026-03-11 21:33:55.33601', 389, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (2452.00, '2025-10-28 21:33:55.336011', 390, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (2171.00, '2025-10-23 21:33:55.336012', 391, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4954.00, '2025-07-03 21:33:55.336014', 392, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (4427.00, '2026-03-23 21:33:55.336015', 393, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3596.00, '2025-04-21 21:33:55.336016', 394, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (909.00, '2025-09-21 21:33:55.336018', 395, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (2089.00, '2026-02-13 21:33:55.336019', 396, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (3805.00, '2026-02-08 21:33:55.33602', 397, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (4307.00, '2026-02-17 21:33:55.336021', 398, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (2259.00, '2026-03-12 21:33:55.336024', 399, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (4724.00, '2025-05-31 21:33:55.336025', 400, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (2484.00, '2026-02-26 21:33:55.336026', 401, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (760.00, '2025-08-07 21:33:55.336028', 402, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (2488.00, '2025-09-08 21:33:55.33603', 403, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (1467.00, '2026-03-12 21:33:55.336031', 404, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3087.00, '2026-01-23 21:33:55.336032', 405, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4802.00, '2025-09-24 21:33:55.336034', 406, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3439.00, '2025-10-23 21:33:55.336035', 407, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (4786.00, '2025-06-05 21:33:55.336036', 408, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (2657.00, '2025-04-20 21:33:55.336037', 409, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (2853.00, '2025-11-25 21:33:55.336039', 410, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (3680.00, '2025-12-14 21:33:55.33604', 411, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3057.00, '2025-07-01 21:33:55.336041', 412, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (2547.00, '2025-11-23 21:33:55.336042', 413, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3089.00, '2025-09-29 21:33:55.336044', 414, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (3024.00, '2026-01-06 21:33:55.336045', 415, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (2651.00, '2025-09-09 21:33:55.336046', 416, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (565.00, '2025-07-21 21:33:55.336047', 417, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (2600.00, '2025-09-27 21:33:55.336048', 418, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (842.00, '2025-12-30 21:33:55.33605', 419, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3933.00, '2025-10-06 21:33:55.336051', 420, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (2113.00, '2025-08-10 21:33:55.336052', 421, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (2844.00, '2025-08-03 21:33:55.336054', 422, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3085.00, '2025-04-10 21:33:55.336055', 423, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (2107.00, '2025-10-26 21:33:55.336056', 424, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (616.00, '2025-05-26 21:33:55.336058', 425, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (1181.00, '2026-03-22 21:33:55.336059', 426, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (4926.00, '2026-02-10 21:33:55.33606', 427, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (1761.00, '2025-09-22 21:33:55.336061', 428, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (3176.00, '2025-12-15 21:33:55.336063', 429, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (2049.00, '2026-03-15 21:33:55.336064', 430, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (1463.00, '2025-05-09 21:33:55.336065', 431, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3796.00, '2025-06-28 21:33:55.336067', 432, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2646.00, '2026-02-13 21:33:55.336068', 433, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (280.00, '2025-09-28 21:33:55.336069', 434, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (2932.00, '2025-10-30 21:33:55.33607', 435, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (1497.00, '2025-12-15 21:33:55.336072', 436, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (1665.00, '2026-03-29 21:33:55.336073', 437, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (3632.00, '2025-04-09 21:33:55.336074', 438, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (3068.00, '2025-12-15 21:33:55.336076', 439, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (1434.00, '2025-12-31 21:33:55.336077', 440, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3647.00, '2026-01-11 21:33:55.336078', 441, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4754.00, '2025-06-26 21:33:55.33608', 442, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (1711.00, '2025-04-03 21:33:55.336081', 443, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (766.00, '2025-07-23 21:33:55.336082', 444, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (3189.00, '2025-12-10 21:33:55.336084', 445, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (1074.00, '2025-07-04 21:33:55.336085', 446, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (4131.00, '2025-11-22 21:33:55.336086', 447, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2600.00, '2025-11-05 21:33:55.336087', 448, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (4473.00, '2025-08-01 21:33:55.336089', 449, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (881.00, '2025-12-20 21:33:55.33609', 450, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (3816.00, '2025-06-20 21:33:55.336091', 451, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3946.00, '2025-10-22 21:33:55.336092', 452, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (330.00, '2025-10-26 21:33:55.336094', 453, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (4292.00, '2025-09-27 21:33:55.336095', 454, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (1135.00, '2025-12-21 21:33:55.336096', 455, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (108.00, '2025-11-19 21:33:55.336098', 456, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (3054.00, '2025-09-11 21:33:55.336099', 457, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (2805.00, '2025-11-18 21:33:55.3361', 458, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (232.00, '2025-11-14 21:33:55.336102', 459, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2144.00, '2025-11-23 21:33:55.336103', 460, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (2062.00, '2025-05-05 21:33:55.336104', 461, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3704.00, '2025-06-21 21:33:55.336106', 462, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (4248.00, '2025-05-28 21:33:55.336107', 463, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1627.00, '2025-09-04 21:33:55.336108', 464, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (244.00, '2026-03-31 21:33:55.336109', 465, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (3773.00, '2025-09-13 21:33:55.336111', 466, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (4024.00, '2025-10-17 21:33:55.336112', 467, NULL, NULL, 2, 24, 'DELIVERED');
INSERT INTO public.orders VALUES (3051.00, '2026-01-04 21:33:55.336113', 468, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3411.00, '2025-08-20 21:33:55.336114', 469, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (3207.00, '2025-06-29 21:33:55.336115', 470, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (2219.00, '2025-06-14 21:33:55.336116', 471, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (742.00, '2026-03-19 21:33:55.336118', 472, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (2508.00, '2025-10-05 21:33:55.336119', 473, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (2197.00, '2026-01-15 21:33:55.33612', 474, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (2943.00, '2026-01-31 21:33:55.336122', 475, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (2834.00, '2025-08-13 21:33:55.336123', 476, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (3519.00, '2026-01-16 21:33:55.336124', 477, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (4344.00, '2025-09-11 21:33:55.336126', 478, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (4154.00, '2025-12-07 21:33:55.336127', 479, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (3136.00, '2025-05-04 21:33:55.336128', 480, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (2522.00, '2025-06-21 21:33:55.33613', 481, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (4274.00, '2025-04-22 21:33:55.336131', 482, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (2288.00, '2025-07-26 21:33:55.336132', 483, NULL, NULL, 2, 9, 'DELIVERED');
INSERT INTO public.orders VALUES (940.00, '2025-05-01 21:33:55.336133', 484, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (2746.00, '2025-07-29 21:33:55.336135', 485, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (4032.00, '2025-07-31 21:33:55.336136', 486, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (2419.00, '2026-03-09 21:33:55.336137', 487, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (4240.00, '2025-09-24 21:33:55.336138', 488, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (3572.00, '2026-02-05 21:33:55.33614', 489, NULL, NULL, 2, 26, 'DELIVERED');
INSERT INTO public.orders VALUES (2123.00, '2025-05-07 21:33:55.336141', 490, NULL, NULL, 2, 40, 'DELIVERED');
INSERT INTO public.orders VALUES (1091.00, '2026-01-24 21:33:55.336142', 491, NULL, NULL, 2, 13, 'DELIVERED');
INSERT INTO public.orders VALUES (4931.00, '2025-10-08 21:33:55.336144', 492, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (1942.00, '2025-09-10 21:33:55.336145', 493, NULL, NULL, 2, 7, 'DELIVERED');
INSERT INTO public.orders VALUES (812.00, '2026-01-14 21:33:55.336146', 494, NULL, NULL, 2, 14, 'DELIVERED');
INSERT INTO public.orders VALUES (2704.00, '2025-08-26 21:33:55.336148', 495, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (3978.00, '2025-04-14 21:33:55.336149', 496, NULL, NULL, 2, 8, 'DELIVERED');
INSERT INTO public.orders VALUES (805.00, '2025-11-11 21:33:55.33615', 497, NULL, NULL, 2, 12, 'DELIVERED');
INSERT INTO public.orders VALUES (2264.00, '2025-09-09 21:33:55.336151', 498, NULL, NULL, 2, 10, 'DELIVERED');
INSERT INTO public.orders VALUES (1265.00, '2025-12-12 21:33:55.336153', 499, NULL, NULL, 2, 3, 'DELIVERED');
INSERT INTO public.orders VALUES (1456.00, '2025-09-29 21:33:55.336154', 500, NULL, NULL, 2, 11, 'DELIVERED');
INSERT INTO public.orders VALUES (1015.00, '2025-07-14 21:33:55.336155', 501, NULL, NULL, 2, 25, 'DELIVERED');
INSERT INTO public.orders VALUES (1.48, '2026-04-02 23:40:27.322954', 502, NULL, NULL, NULL, 114, 'PENDING');
INSERT INTO public.orders VALUES (9.28, '2026-04-06 01:05:04.535488', 503, NULL, NULL, NULL, 114, 'PENDING');
INSERT INTO public.orders VALUES (1.09, '2026-04-06 01:08:25.199442', 504, NULL, NULL, NULL, 114, 'PENDING');
INSERT INTO public.orders VALUES (2.18, '2026-04-06 01:08:54.617211', 505, NULL, NULL, NULL, 114, 'PENDING');


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: product_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: product_attribute_value; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: product_product_attribute_values; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products VALUES (10, 0.65, 19, NULL, 4, 2, NULL, NULL, 'HEARTS WRAPPING TAPE ', '10123C');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 5, 2, NULL, NULL, 'SPOTS ON RED BOOKCOVER TAPE', '10124A');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 6, 2, NULL, NULL, 'ARMY CAMO BOOKCOVER TAPE', '10124G');
INSERT INTO public.products VALUES (129, 0.86, 21, NULL, 7, 2, NULL, NULL, 'MINI FUNKY DESIGN TAPES', '10125');
INSERT INTO public.products VALUES (277, 0.65, 22, NULL, 8, 2, NULL, NULL, 'COLOURING PENCILS BROWN TUBE', '10133');
INSERT INTO public.products VALUES (223, 1.41, 22, NULL, 9, 2, NULL, NULL, 'COLOURING PENCILS BROWN TUBE', '10135');
INSERT INTO public.products VALUES (143, 1.88, 21, NULL, 10, 2, NULL, NULL, 'ASSTD DESIGN RACING CAR PEN', '11001');
INSERT INTO public.products VALUES (14, 0.29, 15, NULL, 11, 2, NULL, NULL, 'FAN BLACK FRAME ', '15030');
INSERT INTO public.products VALUES (520, 0.37, 22, NULL, 12, 2, NULL, NULL, 'PAPER POCKET TRAVELING FAN ', '15034');
INSERT INTO public.products VALUES (2308, 1.07, 22, NULL, 13, 2, NULL, NULL, 'ASSORTED COLOURS SILK FAN', '15036');
INSERT INTO public.products VALUES (206, 1.23, 22, NULL, 14, 2, NULL, NULL, 'SANDALWOOD FAN', '15039');
INSERT INTO public.products VALUES (46, 3.66, 22, NULL, 15, 2, NULL, NULL, 'PINK PAPER PARASOL ', '15044A');
INSERT INTO public.products VALUES (32, 3.50, 22, NULL, 16, 2, NULL, NULL, 'BLUE PAPER PARASOL ', '15044B');
INSERT INTO public.products VALUES (31, 3.82, 22, NULL, 17, 2, NULL, NULL, 'PURPLE PAPER PARASOL', '15044C');
INSERT INTO public.products VALUES (64, 3.32, 22, NULL, 18, 2, NULL, NULL, 'RED PAPER PARASOL', '15044D');
INSERT INTO public.products VALUES (389, 6.93, 22, NULL, 20, 2, NULL, NULL, 'EDWARDIAN PARASOL NATURAL', '15056N');
INSERT INTO public.products VALUES (76, 6.33, 22, NULL, 21, 2, NULL, NULL, 'EDWARDIAN PARASOL PINK', '15056P');
INSERT INTO public.products VALUES (10, 12.49, 22, NULL, 22, 2, NULL, NULL, 'EDWARDIAN PARASOL BLACK', '15056bl');
INSERT INTO public.products VALUES (12, 12.48, 22, NULL, 23, 2, NULL, NULL, 'EDWARDIAN PARASOL NATURAL', '15056n');
INSERT INTO public.products VALUES (10, 12.50, 22, NULL, 24, 2, NULL, NULL, 'EDWARDIAN PARASOL PINK', '15056p');
INSERT INTO public.products VALUES (16, 9.03, 22, NULL, 25, 2, NULL, NULL, 'BLUE POLKADOT GARDEN PARASOL', '15058A');
INSERT INTO public.products VALUES (22, 9.84, 22, NULL, 26, 2, NULL, NULL, 'PINK POLKADOT GARDEN PARASOL', '15058B');
INSERT INTO public.products VALUES (21, 9.21, 21, NULL, 27, 2, NULL, NULL, 'ICE CREAM DESIGN GARDEN PARASOL', '15058C');
INSERT INTO public.products VALUES (45, 4.98, 21, NULL, 28, 2, NULL, NULL, 'FAIRY CAKE DESIGN UMBRELLA', '15060B');
INSERT INTO public.products VALUES (10, 8.29, 21, NULL, 29, 2, NULL, NULL, 'FAIRY CAKE DESIGN UMBRELLA', '15060b');
INSERT INTO public.products VALUES (138, 0.13, 22, NULL, 30, 2, NULL, NULL, 'SMALL FOLDING SCISSOR(POINTED EDGE)', '16008');
INSERT INTO public.products VALUES (10, 0.12, 22, NULL, 31, 2, NULL, NULL, 'FOLDING CAMPING SCISSOR W/KNIF & S', '16010');
INSERT INTO public.products VALUES (177, 0.21, 22, NULL, 32, 2, NULL, NULL, 'ANIMAL STICKERS', '16011');
INSERT INTO public.products VALUES (124, 0.21, 22, NULL, 33, 2, NULL, NULL, 'FOOD/DRINK SPONGE STICKERS', '16012');
INSERT INTO public.products VALUES (1332, 0.40, 22, NULL, 34, 2, NULL, NULL, 'SMALL CHINESE STYLE SCISSOR', '16014');
INSERT INTO public.products VALUES (66, 0.49, 22, NULL, 35, 2, NULL, NULL, 'MEDIUM CHINESE STYLE SCISSOR', '16015');
INSERT INTO public.products VALUES (127, 0.85, 22, NULL, 36, 2, NULL, NULL, 'LARGE CHINESE STYLE SCISSOR', '16016');
INSERT INTO public.products VALUES (10, 0.83, 16, NULL, 37, 2, NULL, NULL, 'CLEAR STATIONERY BOX SET ', '16020C');
INSERT INTO public.products VALUES (84, 0.12, 12, NULL, 38, 2, NULL, NULL, 'MINI HIGHLIGHTER PENS', '16033');
INSERT INTO public.products VALUES (10, 0.12, 22, NULL, 39, 2, NULL, NULL, 'POP ART PUSH DOWN RUBBER ', '16043');
INSERT INTO public.products VALUES (800, 0.04, 22, NULL, 40, 2, NULL, NULL, 'POPART WOODEN PENCILS ASST', '16045');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 41, 2, NULL, NULL, 'TEATIME PEN CASE & PENS', '16046');
INSERT INTO public.products VALUES (146, 0.33, 22, NULL, 42, 2, NULL, NULL, 'TEATIME ROUND PENCIL SHARPENER ', '16048');
INSERT INTO public.products VALUES (50, 0.24, 22, NULL, 43, 2, NULL, NULL, 'TEATIME GEL PENS ASST', '16049');
INSERT INTO public.products VALUES (47, 0.59, 22, NULL, 44, 2, NULL, NULL, 'TEATIME PUSH DOWN RUBBER', '16052');
INSERT INTO public.products VALUES (105, 0.13, 22, NULL, 45, 2, NULL, NULL, 'POPART RECT PENCIL SHARPENER ASST', '16054');
INSERT INTO public.products VALUES (10, 1.25, 13, NULL, 46, 2, NULL, NULL, 'FLOWERS HANDBAG blue and orange', '16151A');
INSERT INTO public.products VALUES (47, 0.42, 19, NULL, 47, 2, NULL, NULL, 'WRAP, CAROUSEL', '16156L');
INSERT INTO public.products VALUES (580, 0.42, 19, NULL, 48, 2, NULL, NULL, 'WRAP PINK FAIRY CAKES ', '16156S');
INSERT INTO public.products VALUES (70, 0.10, 19, NULL, 49, 2, NULL, NULL, 'WRAP BAD HAIR DAY', '16161G');
INSERT INTO public.products VALUES (10, 0.42, 19, NULL, 50, 2, NULL, NULL, 'WRAP  PINK FLOCK', '16161M');
INSERT INTO public.products VALUES (720, 0.42, 19, NULL, 51, 2, NULL, NULL, 'WRAP ENGLISH ROSE ', '16161P');
INSERT INTO public.products VALUES (405, 0.42, 19, NULL, 52, 2, NULL, NULL, 'WRAP SUKI AND FRIENDS', '16161U');
INSERT INTO public.products VALUES (10, 0.65, 13, NULL, 53, 2, NULL, NULL, 'THE KING GIFT BAG', '16162L');
INSERT INTO public.products VALUES (10, 0.37, 22, NULL, 54, 2, NULL, NULL, 'alan hodge cant mamage this section', '16162M');
INSERT INTO public.products VALUES (41, 0.62, 13, NULL, 55, 2, NULL, NULL, 'FUNKY MONKEY GIFT BAG MEDIUM', '16168M');
INSERT INTO public.products VALUES (412, 0.42, 17, NULL, 56, 2, NULL, NULL, 'WRAP 50''S  CHRISTMAS', '16169E');
INSERT INTO public.products VALUES (20, 0.42, 19, NULL, 57, 2, NULL, NULL, 'WRAP FOLK ART', '16169K');
INSERT INTO public.products VALUES (66, 0.42, 19, NULL, 58, 2, NULL, NULL, 'WRAP DAISY CARPET ', '16169M');
INSERT INTO public.products VALUES (10, 0.42, 19, NULL, 59, 2, NULL, NULL, 'WRAP BLUE RUSSIAN FOLKART', '16169N');
INSERT INTO public.products VALUES (10, 0.42, 19, NULL, 60, 2, NULL, NULL, 'WRAP GREEN RUSSIAN FOLKART ', '16169P');
INSERT INTO public.products VALUES (10, 0.50, 15, NULL, 61, 2, NULL, NULL, 'PASTEL PINK PHOTO ALBUM ', '16202A');
INSERT INTO public.products VALUES (10, 0.50, 15, NULL, 62, 2, NULL, NULL, 'PASTEL BLUE PHOTO ALBUM ', '16202B');
INSERT INTO public.products VALUES (10, 1.76, 15, NULL, 63, 2, NULL, NULL, 'BLACK PHOTO ALBUM ', '16202E');
INSERT INTO public.products VALUES (10, 1.25, 13, NULL, 64, 2, NULL, NULL, 'RED PURSE WITH PINK HEART', '16206B');
INSERT INTO public.products VALUES (10, 2.67, 13, NULL, 65, 2, NULL, NULL, 'PINK STRAWBERRY HANDBAG ', '16207A');
INSERT INTO public.products VALUES (10, 2.70, 13, NULL, 66, 2, NULL, NULL, 'PINK HEART RED HANDBAG', '16207B');
INSERT INTO public.products VALUES (333, 0.15, 21, NULL, 67, 2, NULL, NULL, 'LETTER SHAPE PENCIL SHARPENER', '16216');
INSERT INTO public.products VALUES (382, 0.27, 22, NULL, 68, 2, NULL, NULL, 'CARTOON  PENCIL SHARPENERS', '16218');
INSERT INTO public.products VALUES (300, 0.51, 22, NULL, 69, 2, NULL, NULL, 'HOUSE SHAPE PENCIL SHARPENER', '16219');
INSERT INTO public.products VALUES (81, 1.46, 22, NULL, 70, 2, NULL, NULL, 'RATTLE SNAKE EGGS', '16225');
INSERT INTO public.products VALUES (310, 0.32, 22, NULL, 71, 2, NULL, NULL, 'RECYCLED PENCIL WITH RABBIT ERASER', '16235');
INSERT INTO public.products VALUES (143, 0.30, 22, NULL, 72, 2, NULL, NULL, 'KITTY PENCIL ERASERS', '16236');
INSERT INTO public.products VALUES (493, 0.30, 22, NULL, 73, 2, NULL, NULL, 'SLEEPING CAT ERASERS', '16237');
INSERT INTO public.products VALUES (139, 0.31, 22, NULL, 74, 2, NULL, NULL, 'PARTY TIME PENCIL ERASERS', '16238');
INSERT INTO public.products VALUES (10, 1.23, 15, NULL, 75, 2, NULL, NULL, 'MAXWELL 2 TONE BLUE 60 PAGE PHOTO A', '16244B');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 76, 2, NULL, NULL, 'BLUE HOLE PUNCH', '16248B');
INSERT INTO public.products VALUES (10, 1.31, 22, NULL, 77, 2, NULL, NULL, 'TRANSPARENT ACRYLIC TAPE DISPENSER', '16254');
INSERT INTO public.products VALUES (47, 0.59, 13, NULL, 78, 2, NULL, NULL, 'SWIRLY CIRCULAR RUBBERS IN BAG', '16258A');
INSERT INTO public.products VALUES (327, 0.10, 22, NULL, 79, 2, NULL, NULL, 'PIECE OF CAMO STATIONERY SET', '16259');
INSERT INTO public.products VALUES (10, 0.29, 22, NULL, 80, 2, NULL, NULL, 'HEAVENS SCENT FRAGRANCE OILS ASSTD', '17001');
INSERT INTO public.products VALUES (2305, 1.06, 13, NULL, 81, 2, NULL, NULL, 'BROCADE RING PURSE ', '17003');
INSERT INTO public.products VALUES (10, 2.10, 22, NULL, 82, 2, NULL, NULL, 'S/3 POT POURI CUSHIONS BLUE COLOURS', '17007B');
INSERT INTO public.products VALUES (10, 1.57, 22, NULL, 83, 2, NULL, NULL, 'ORIGAMI SANDLEWOOD INCENSE+FLOWER', '17011F');
INSERT INTO public.products VALUES (32, 1.95, 12, NULL, 84, 2, NULL, NULL, 'ORIGAMI VANILLA INCENSE/CANDLE SET ', '17012A');
INSERT INTO public.products VALUES (45, 1.86, 12, NULL, 85, 2, NULL, NULL, 'ORIGAMI JASMINE INCENSE/CANDLE SET', '17012B');
INSERT INTO public.products VALUES (39, 1.76, 22, NULL, 86, 2, NULL, NULL, 'ORIGAMI LAVENDER INCENSE/CANDL SET ', '17012C');
INSERT INTO public.products VALUES (46, 1.82, 12, NULL, 87, 2, NULL, NULL, 'ORIGAMI ROSE INCENSE/CANDLE SET ', '17012D');
INSERT INTO public.products VALUES (10, 2.15, 12, NULL, 88, 2, NULL, NULL, 'ORIGAMI OPIUM INCENSE/CANDLE SET ', '17012E');
INSERT INTO public.products VALUES (46, 1.78, 22, NULL, 89, 2, NULL, NULL, 'ORIGAMI SANDLEWOOD INCENSE/CAND SET', '17012F');
INSERT INTO public.products VALUES (53, 1.25, 22, NULL, 90, 2, NULL, NULL, 'ORIGAMI ROSE INCENSE IN TUBE', '17013D');
INSERT INTO public.products VALUES (15, 0.95, 22, NULL, 91, 2, NULL, NULL, 'ORIGAMI VANILLA INCENSE CONES', '17014A');
INSERT INTO public.products VALUES (242, 0.29, 22, NULL, 92, 2, NULL, NULL, 'NAMASTE SWAGAT INCENSE', '17021');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 93, 2, NULL, NULL, 'INCENSE BAZAAR PEACH', '17028J');
INSERT INTO public.products VALUES (152, 0.42, 22, NULL, 94, 2, NULL, NULL, 'PORCELAIN BUDAH INCENSE HOLDER', '17038');
INSERT INTO public.products VALUES (20, 0.21, 22, NULL, 95, 2, NULL, NULL, 'TRANQUILITY MASALA INCENSE', '17084A');
INSERT INTO public.products VALUES (22, 0.21, 22, NULL, 96, 2, NULL, NULL, 'LOVE POTION MASALA INCENSE', '17084J');
INSERT INTO public.products VALUES (126, 0.35, 22, NULL, 97, 2, NULL, NULL, 'FAIRY DREAMS INCENSE ', '17084N');
INSERT INTO public.products VALUES (42, 0.35, 22, NULL, 98, 2, NULL, NULL, 'DRAGONS BLOOD INCENSE', '17084P');
INSERT INTO public.products VALUES (403, 0.20, 22, NULL, 99, 2, NULL, NULL, 'ASSORTED INCENSE PACK', '17084R');
INSERT INTO public.products VALUES (10, 1.17, 16, NULL, 100, 2, NULL, NULL, 'LAVENDER INCENSE 40 CONES IN TIN', '17090A');
INSERT INTO public.products VALUES (10, 1.25, 16, NULL, 101, 2, NULL, NULL, 'VANILLA INCENSE 40 CONES IN TIN', '17090D');
INSERT INTO public.products VALUES (25, 0.75, 16, NULL, 102, 2, NULL, NULL, 'LAVENDER INCENSE IN TIN', '17091A');
INSERT INTO public.products VALUES (208, 0.70, 16, NULL, 103, 2, NULL, NULL, 'VANILLA INCENSE IN TIN', '17091J');
INSERT INTO public.products VALUES (254, 0.30, 22, NULL, 104, 2, NULL, NULL, 'ASSORTED LAQUERED INCENSE HOLDERS', '17096');
INSERT INTO public.products VALUES (17, 2.55, 22, NULL, 105, 2, NULL, NULL, 'FLOWER FAIRY,5 SUMMER B''DRAW LINERS', '17107D');
INSERT INTO public.products VALUES (10, 0.75, 22, NULL, 106, 2, NULL, NULL, 'FLOWER FAIRY INCENSE BOUQUET', '17109D');
INSERT INTO public.products VALUES (58, 1.36, 13, NULL, 107, 2, NULL, NULL, 'BLUE GLASS GEMS IN BAG', '17129F');
INSERT INTO public.products VALUES (40, 0.09, 12, NULL, 108, 2, NULL, NULL, 'BLUE STONES ON WIRE FOR CANDLE', '17136A');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 109, 2, NULL, NULL, 'ASS COL SMALL SAND GECKO P''WEIGHT', '17164B');
INSERT INTO public.products VALUES (10, 1.05, 22, NULL, 110, 2, NULL, NULL, 'ASS COL LARGE SAND FROG P''WEIGHT', '17165D');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 111, 2, NULL, NULL, 'ASSTD RASTA KEY-CHAINS', '17174');
INSERT INTO public.products VALUES (10, 3.75, 12, NULL, 112, 2, NULL, NULL, 'ROSE FLOWER CANDLE+INCENSE 16X16CM', '17191A');
INSERT INTO public.products VALUES (588, 0.27, 16, NULL, 113, 2, NULL, NULL, 'ESSENTIAL BALM 3.5g TIN IN ENVELOPE', '18007');
INSERT INTO public.products VALUES (19, 1.96, 22, NULL, 114, 2, NULL, NULL, 'WHITE AND BLUE CERAMIC OIL BURNER', '18094C');
INSERT INTO public.products VALUES (10, 2.55, 12, NULL, 115, 2, NULL, NULL, 'PINK TALL PORCELAIN T-LIGHT HOLDER ', '18097A');
INSERT INTO public.products VALUES (40, 3.06, 12, NULL, 116, 2, NULL, NULL, 'WHITE TALL PORCELAIN T-LIGHT HOLDER', '18097C');
INSERT INTO public.products VALUES (22, 3.54, 22, NULL, 117, 2, NULL, NULL, 'PORCELAIN BUTTERFLY OIL BURNER', '18098C');
INSERT INTO public.products VALUES (10, 5.06, 22, NULL, 118, 2, NULL, NULL, 'PORCELAIN BUTTERFLY OIL BURNER', '18098c');
INSERT INTO public.products VALUES (31, 2.51, 22, NULL, 119, 2, NULL, NULL, 'BLUE POLKADOT PASSPORT COVER', '20615');
INSERT INTO public.products VALUES (19, 1.81, 22, NULL, 120, 2, NULL, NULL, 'CHERRY BLOSSOM PASSPORT COVER', '20616');
INSERT INTO public.products VALUES (10, 2.25, 22, NULL, 121, 2, NULL, NULL, 'FIRST CLASS PASSPORT COVER ', '20617');
INSERT INTO public.products VALUES (14, 2.03, 22, NULL, 122, 2, NULL, NULL, 'QUEEN OF THE SKIES PASSPORT COVER ', '20618');
INSERT INTO public.products VALUES (26, 2.14, 22, NULL, 123, 2, NULL, NULL, 'TROPICAL PASSPORT COVER ', '20619');
INSERT INTO public.products VALUES (18, 2.40, 22, NULL, 124, 2, NULL, NULL, 'VIPPASSPORT COVER ', '20622');
INSERT INTO public.products VALUES (23, 1.51, 22, NULL, 125, 2, NULL, NULL, 'BLUE POLKADOT LUGGAGE TAG ', '20652');
INSERT INTO public.products VALUES (10, 1.48, 22, NULL, 126, 2, NULL, NULL, 'CHERRY BLOSSOM LUGGAGE TAG', '20653');
INSERT INTO public.products VALUES (15, 1.39, 22, NULL, 127, 2, NULL, NULL, 'FIRST CLASS LUGGAGE TAG ', '20654');
INSERT INTO public.products VALUES (19, 1.72, 22, NULL, 128, 2, NULL, NULL, 'QUEEN OF SKIES LUGGAGE TAG', '20655');
INSERT INTO public.products VALUES (10, 1.72, 22, NULL, 129, 2, NULL, NULL, 'TROPICAL LUGGAGE TAG', '20657');
INSERT INTO public.products VALUES (42, 1.74, 22, NULL, 130, 2, NULL, NULL, 'RED RETROSPOT LUGGAGE TAG', '20658');
INSERT INTO public.products VALUES (15, 1.63, 22, NULL, 131, 2, NULL, NULL, 'ECONOMY LUGGAGE TAG', '20659');
INSERT INTO public.products VALUES (10, 3.40, 13, NULL, 132, 2, NULL, NULL, 'BLUE POLKADOT PURSE ', '20661');
INSERT INTO public.products VALUES (10, 2.88, 13, NULL, 133, 2, NULL, NULL, 'FIRST CLASS HOLIDAY PURSE ', '20662');
INSERT INTO public.products VALUES (10, 2.69, 13, NULL, 134, 2, NULL, NULL, 'QUEEN OF THE SKIES HOLIDAY PURSE ', '20663');
INSERT INTO public.products VALUES (10, 2.54, 13, NULL, 135, 2, NULL, NULL, 'TROPICAL HOLIDAY PURSE ', '20664');
INSERT INTO public.products VALUES (46, 4.02, 13, NULL, 136, 2, NULL, NULL, 'RED RETROSPOT PURSE ', '20665');
INSERT INTO public.products VALUES (10, 1.71, 13, NULL, 137, 2, NULL, NULL, 'ECONOMY HOLIDAY PURSE', '20666');
INSERT INTO public.products VALUES (10, 2.49, 13, NULL, 138, 2, NULL, NULL, 'CHERRY BLOSSOM PURSE', '20667');
INSERT INTO public.products VALUES (1297, 0.16, 17, NULL, 139, 2, NULL, NULL, 'DISCO BALL CHRISTMAS DECORATION', '20668');
INSERT INTO public.products VALUES (30, 1.69, 22, NULL, 140, 2, NULL, NULL, 'RED HEART LUGGAGE TAG', '20669');
INSERT INTO public.products VALUES (10, 3.24, 13, NULL, 141, 2, NULL, NULL, 'VIP HOLIDAY PURSE', '20670');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 142, 2, NULL, NULL, 'BLUE TEATIME PRINT BOWL ', '20671');
INSERT INTO public.products VALUES (157, 1.56, 22, NULL, 143, 2, NULL, NULL, 'GREEN POLKADOT BOWL', '20674');
INSERT INTO public.products VALUES (310, 1.58, 22, NULL, 144, 2, NULL, NULL, 'BLUE POLKADOT BOWL', '20675');
INSERT INTO public.products VALUES (505, 1.63, 22, NULL, 145, 2, NULL, NULL, 'RED RETROSPOT BOWL', '20676');
INSERT INTO public.products VALUES (367, 1.65, 22, NULL, 146, 2, NULL, NULL, 'PINK POLKADOT BOWL', '20677');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 147, 2, NULL, NULL, 'LARGE BLACK DIAMANTE HAIRSLIDE', '20678');
INSERT INTO public.products VALUES (170, 6.99, 22, NULL, 148, 2, NULL, NULL, 'EDWARDIAN PARASOL RED', '20679');
INSERT INTO public.products VALUES (10, 4.08, 22, NULL, 149, 2, NULL, NULL, 'PINK POLKADOT CHILDRENS UMBRELLA', '20681');
INSERT INTO public.products VALUES (122, 3.95, 22, NULL, 150, 2, NULL, NULL, 'RED RETROSPOT CHILDRENS UMBRELLA', '20682');
INSERT INTO public.products VALUES (10, 3.54, 22, NULL, 151, 2, NULL, NULL, 'STRAWBERRY DREAM CHILDS UMBRELLA', '20684');
INSERT INTO public.products VALUES (402, 8.92, 22, NULL, 152, 2, NULL, NULL, 'DOORMAT RED RETROSPOT', '20685');
INSERT INTO public.products VALUES (27, 3.86, 20, NULL, 153, 2, NULL, NULL, 'DOLLY MIXTURE CHILDREN''S UMBRELLA', '20686');
INSERT INTO public.products VALUES (10, 4.80, 22, NULL, 154, 2, NULL, NULL, 'FLORAL PINK MONSTER', '20694');
INSERT INTO public.products VALUES (10, 4.25, 22, NULL, 155, 2, NULL, NULL, 'FLORAL BLUE MONSTER', '20695');
INSERT INTO public.products VALUES (10, 4.72, 20, NULL, 156, 2, NULL, NULL, 'FLORAL SOFT CAR TOY', '20696');
INSERT INTO public.products VALUES (10, 2.55, 20, NULL, 157, 2, NULL, NULL, 'LITTLE GREEN MONSTER SOFT TOY', '20697');
INSERT INTO public.products VALUES (10, 2.55, 20, NULL, 158, 2, NULL, NULL, 'LITTLE PINK MONSTER SOFT TOY', '20698');
INSERT INTO public.products VALUES (10, 3.00, 20, NULL, 159, 2, NULL, NULL, 'MOUSEY LONG LEGS SOFT TOY', '20699');
INSERT INTO public.products VALUES (10, 4.89, 22, NULL, 160, 2, NULL, NULL, 'GREEN CAT FLORAL CUSHION COVER ', '20700');
INSERT INTO public.products VALUES (10, 4.07, 22, NULL, 161, 2, NULL, NULL, 'PINK CAT FLORAL CUSHION COVER ', '20701');
INSERT INTO public.products VALUES (13, 4.34, 22, NULL, 162, 2, NULL, NULL, 'PINK PADDED MOBILE', '20702');
INSERT INTO public.products VALUES (10, 4.25, 22, NULL, 163, 2, NULL, NULL, 'BLUE PADDED SOFT MOBILE', '20703');
INSERT INTO public.products VALUES (21, 5.87, 20, NULL, 164, 2, NULL, NULL, 'MR ROBOT SOFT TOY', '20704');
INSERT INTO public.products VALUES (14, 4.71, 20, NULL, 165, 2, NULL, NULL, 'MRS ROBOT SOFT TOY', '20705');
INSERT INTO public.products VALUES (46, 1.09, 22, NULL, 166, 2, NULL, NULL, 'CRAZY DAISY HEART DECORATION', '20707');
INSERT INTO public.products VALUES (466, 3.09, 13, NULL, 167, 2, NULL, NULL, 'JUMBO BAG TOYS ', '20711');
INSERT INTO public.products VALUES (953, 2.92, 13, NULL, 168, 2, NULL, NULL, 'JUMBO BAG WOODLAND ANIMALS', '20712');
INSERT INTO public.products VALUES (910, 2.74, 13, NULL, 169, 2, NULL, NULL, 'JUMBO BAG OWLS', '20713');
INSERT INTO public.products VALUES (40, 1.32, 13, NULL, 170, 2, NULL, NULL, 'PARTY FOOD SHOPPER BAG', '20716');
INSERT INTO public.products VALUES (283, 1.67, 13, NULL, 171, 2, NULL, NULL, 'STRAWBERRY SHOPPER BAG', '20717');
INSERT INTO public.products VALUES (474, 1.77, 13, NULL, 172, 2, NULL, NULL, 'RED RETROSPOT SHOPPER BAG', '20718');
INSERT INTO public.products VALUES (1319, 1.20, 13, NULL, 173, 2, NULL, NULL, 'WOODLAND CHARLOTTE BAG', '20719');
INSERT INTO public.products VALUES (972, 1.19, 13, NULL, 174, 2, NULL, NULL, 'STRAWBERRY CHARLOTTE BAG', '20723');
INSERT INTO public.products VALUES (1754, 1.13, 13, NULL, 175, 2, NULL, NULL, 'RED RETROSPOT CHARLOTTE BAG', '20724');
INSERT INTO public.products VALUES (1897, 2.11, 13, NULL, 176, 2, NULL, NULL, 'LUNCH BAG RED RETROSPOT', '20725');
INSERT INTO public.products VALUES (985, 2.16, 13, NULL, 177, 2, NULL, NULL, 'LUNCH BAG WOODLAND', '20726');
INSERT INTO public.products VALUES (1211, 2.09, 13, NULL, 178, 2, NULL, NULL, 'LUNCH BAG  BLACK SKULL.', '20727');
INSERT INTO public.products VALUES (1160, 2.05, 13, NULL, 179, 2, NULL, NULL, 'LUNCH BAG CARS BLUE', '20728');
INSERT INTO public.products VALUES (10, 1.09, 13, NULL, 180, 2, NULL, NULL, 'POSY CANDY BAG', '20731');
INSERT INTO public.products VALUES (93, 0.85, 22, NULL, 181, 2, NULL, NULL, 'GOLD MINI TAPE MEASURE ', '20733');
INSERT INTO public.products VALUES (15, 1.80, 22, NULL, 182, 2, NULL, NULL, 'SILVER MINI TAPE MEASURE ', '20734');
INSERT INTO public.products VALUES (62, 1.11, 22, NULL, 183, 2, NULL, NULL, 'BLACK MINI TAPE MEASURE ', '20735');
INSERT INTO public.products VALUES (10, 13.08, 22, NULL, 184, 2, NULL, NULL, 'KENSINGTON COFFEE SET', '20748');
INSERT INTO public.products VALUES (176, 8.06, 22, NULL, 185, 2, NULL, NULL, 'ASSORTED COLOUR MINI CASES', '20749');
INSERT INTO public.products VALUES (174, 8.12, 22, NULL, 186, 2, NULL, NULL, 'RED RETROSPOT MINI CASES', '20750');
INSERT INTO public.products VALUES (96, 2.33, 22, NULL, 187, 2, NULL, NULL, 'FUNKY WASHING UP GLOVES ASSORTED', '20751');
INSERT INTO public.products VALUES (40, 2.39, 22, NULL, 188, 2, NULL, NULL, 'BLUE POLKADOT WASHING UP GLOVES', '20752');
INSERT INTO public.products VALUES (151, 2.50, 22, NULL, 189, 2, NULL, NULL, 'RETROSPOT RED WASHING UP GLOVES', '20754');
INSERT INTO public.products VALUES (30, 0.99, 22, NULL, 190, 2, NULL, NULL, 'BLUE PAISLEY POCKET BOOK', '20755');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 191, 2, NULL, NULL, 'GREEN FERN POCKET BOOK', '20756');
INSERT INTO public.products VALUES (16, 0.91, 22, NULL, 192, 2, NULL, NULL, 'RED DAISY POCKET BOOK ', '20757');
INSERT INTO public.products VALUES (16, 0.85, 22, NULL, 193, 2, NULL, NULL, 'ABSTRACT CIRCLES POCKET BOOK', '20758');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 194, 2, NULL, NULL, 'CHRYSANTHEMUM POCKET BOOK ', '20759');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 195, 2, NULL, NULL, 'GARDEN PATH POCKET BOOK', '20760');
INSERT INTO public.products VALUES (12, 4.43, 22, NULL, 196, 2, NULL, NULL, 'BLUE PAISLEY SKETCHBOOK', '20761');
INSERT INTO public.products VALUES (10, 4.15, 22, NULL, 197, 2, NULL, NULL, 'GREEN FERN SKETCHBOOK ', '20762');
INSERT INTO public.products VALUES (10, 3.98, 22, NULL, 198, 2, NULL, NULL, 'DAISY SKETCHBOOK ', '20763');
INSERT INTO public.products VALUES (14, 4.66, 22, NULL, 199, 2, NULL, NULL, 'ABSTRACT CIRCLES SKETCHBOOK ', '20764');
INSERT INTO public.products VALUES (10, 4.24, 22, NULL, 200, 2, NULL, NULL, 'CHRYSANTHEMUM SKETCHBOOK ', '20765');
INSERT INTO public.products VALUES (12, 4.43, 22, NULL, 201, 2, NULL, NULL, 'GARDEN PATH SKETCHBOOK', '20766');
INSERT INTO public.products VALUES (25, 2.86, 22, NULL, 202, 2, NULL, NULL, 'BLUE PAISLEY JOURNAL ', '20767');
INSERT INTO public.products VALUES (17, 2.65, 22, NULL, 203, 2, NULL, NULL, 'GREEN FERN JOURNAL ', '20768');
INSERT INTO public.products VALUES (10, 2.75, 22, NULL, 204, 2, NULL, NULL, 'DAISY JOURNAL ', '20769');
INSERT INTO public.products VALUES (18, 2.50, 22, NULL, 205, 2, NULL, NULL, 'ABSTRACT CIRCLE JOURNAL ', '20770');
INSERT INTO public.products VALUES (10, 2.76, 22, NULL, 206, 2, NULL, NULL, 'CHRYSANTHEMUM  JOURNAL', '20771');
INSERT INTO public.products VALUES (24, 2.75, 22, NULL, 207, 2, NULL, NULL, 'GARDEN PATH JOURNAL', '20772');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 208, 2, NULL, NULL, 'BLUE PAISLEY NOTEBOOK', '20773');
INSERT INTO public.products VALUES (10, 1.60, 22, NULL, 209, 2, NULL, NULL, 'GREEN FERN NOTEBOOK', '20774');
INSERT INTO public.products VALUES (13, 1.72, 22, NULL, 210, 2, NULL, NULL, 'DAISY NOTEBOOK ', '20775');
INSERT INTO public.products VALUES (16, 1.70, 22, NULL, 211, 2, NULL, NULL, 'CHRYSANTHEMUM NOTEBOOK', '20777');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 212, 2, NULL, NULL, 'GARDEN PATH NOTEBOOK ', '20778');
INSERT INTO public.products VALUES (10, 7.62, 22, NULL, 213, 2, NULL, NULL, 'BLACK EAR MUFF HEADPHONES', '20780');
INSERT INTO public.products VALUES (10, 5.75, 22, NULL, 214, 2, NULL, NULL, 'GOLD EAR MUFF HEADPHONES', '20781');
INSERT INTO public.products VALUES (10, 7.46, 22, NULL, 215, 2, NULL, NULL, 'CAMOUFLAGE EAR MUFF HEADPHONES', '20782');
INSERT INTO public.products VALUES (10, 39.15, 22, NULL, 216, 2, NULL, NULL, 'FUSCHIA RETRO BAR STOOL', '20785');
INSERT INTO public.products VALUES (10, 6.75, 22, NULL, 217, 2, NULL, NULL, 'BLUE TILED TRAY', '20793');
INSERT INTO public.products VALUES (10, 3.51, 22, NULL, 218, 2, NULL, NULL, 'BLUE  TILE HOOK', '20794');
INSERT INTO public.products VALUES (10, 2.57, 22, NULL, 219, 2, NULL, NULL, 'LARGE BLUE PROVENCAL CERAMIC BALL', '20795');
INSERT INTO public.products VALUES (10, 1.83, 22, NULL, 220, 2, NULL, NULL, 'SMALL BLUE PROVENCAL CERAMIC BALL', '20796');
INSERT INTO public.products VALUES (10, 2.02, 14, NULL, 221, 2, NULL, NULL, 'CLEAR MILKSHAKE GLASS', '20798');
INSERT INTO public.products VALUES (98, 1.59, 14, NULL, 222, 2, NULL, NULL, 'LARGE PINK GLASS SUNDAE DISH', '20801');
INSERT INTO public.products VALUES (70, 1.91, 14, NULL, 223, 2, NULL, NULL, 'SMALL GLASS SUNDAE DISH CLEAR', '20802');
INSERT INTO public.products VALUES (83, 1.07, 14, NULL, 224, 2, NULL, NULL, 'SMALL PINK GLASS SUNDAE DISH', '20803');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 225, 2, NULL, NULL, 'GOLD FLOWER CUSHION COVER ', '20816');
INSERT INTO public.products VALUES (10, 5.54, 22, NULL, 226, 2, NULL, NULL, 'GOLD TEDDY BEAR', '20818');
INSERT INTO public.products VALUES (10, 4.02, 22, NULL, 227, 2, NULL, NULL, 'SILVER TEDDY BEAR', '20819');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 228, 2, NULL, NULL, 'SILVER LOOKING MIRROR', '20820');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 229, 2, NULL, NULL, 'GOLDIE LOOKING MIRROR', '20821');
INSERT INTO public.products VALUES (16, 0.79, 22, NULL, 230, 2, NULL, NULL, 'GOLD WINE GOBLET', '20823');
INSERT INTO public.products VALUES (27, 0.82, 14, NULL, 231, 2, NULL, NULL, 'SILVER APERITIF GLASS', '20826');
INSERT INTO public.products VALUES (10, 0.26, 14, NULL, 232, 2, NULL, NULL, 'GOLD APERITIF GLASS', '20827');
INSERT INTO public.products VALUES (113, 3.16, 22, NULL, 233, 2, NULL, NULL, 'GLITTER BUTTERFLY CLIPS', '20828');
INSERT INTO public.products VALUES (119, 2.44, 22, NULL, 234, 2, NULL, NULL, 'GLITTER HANGING BUTTERFLY STRING', '20829');
INSERT INTO public.products VALUES (13, 3.02, 15, NULL, 235, 2, NULL, NULL, 'SILVER PHOTO FRAME', '20830');
INSERT INTO public.products VALUES (21, 2.74, 15, NULL, 236, 2, NULL, NULL, 'GOLD PHOTO FRAME', '20831');
INSERT INTO public.products VALUES (120, 0.73, 15, NULL, 237, 2, NULL, NULL, 'RED FLOCK LOVE HEART PHOTO FRAME', '20832');
INSERT INTO public.products VALUES (10, 2.10, 22, NULL, 238, 2, NULL, NULL, 'FRENCH LATTICE CUSHION COVER ', '20835');
INSERT INTO public.products VALUES (15, 0.83, 22, NULL, 239, 2, NULL, NULL, 'FRENCH PAISLEY CUSHION COVER', '20836');
INSERT INTO public.products VALUES (14, 0.97, 22, NULL, 240, 2, NULL, NULL, 'FRENCH FLORAL CUSHION COVER ', '20837');
INSERT INTO public.products VALUES (37, 1.86, 22, NULL, 241, 2, NULL, NULL, 'FRENCH LATTICE CUSHION COVER ', '20838');
INSERT INTO public.products VALUES (49, 2.36, 22, NULL, 242, 2, NULL, NULL, 'FRENCH PAISLEY CUSHION COVER ', '20839');
INSERT INTO public.products VALUES (49, 1.96, 22, NULL, 243, 2, NULL, NULL, 'FRENCH FLORAL CUSHION COVER ', '20840');
INSERT INTO public.products VALUES (10, 6.35, 22, NULL, 244, 2, NULL, NULL, 'ZINC HEART LATTICE 2 WALL PLANTER', '20845');
INSERT INTO public.products VALUES (71, 1.61, 12, NULL, 245, 2, NULL, NULL, 'ZINC HEART LATTICE T-LIGHT HOLDER', '20846');
INSERT INTO public.products VALUES (10, 4.59, 22, NULL, 246, 2, NULL, NULL, 'ZINC HEART LATTICE CHARGER LARGE', '20847');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 247, 2, NULL, NULL, 'ZINC HEART LATTICE CHARGER SMALL', '20848');
INSERT INTO public.products VALUES (10, 5.95, 22, NULL, 248, 2, NULL, NULL, 'ZINC HEART LATTICE TRAY OVAL ', '20851');
INSERT INTO public.products VALUES (23, 1.68, 13, NULL, 249, 2, NULL, NULL, 'BLUE PATCH PURSE PINK HEART', '20854');
INSERT INTO public.products VALUES (10, 1.64, 13, NULL, 250, 2, NULL, NULL, 'DENIM PATCH PURSE PINK BUTTERFLY', '20856');
INSERT INTO public.products VALUES (10, 1.65, 13, NULL, 251, 2, NULL, NULL, 'BLUE ROSE PATCH PURSE PINK BUTTERFL', '20857');
INSERT INTO public.products VALUES (10, 2.10, 13, NULL, 252, 2, NULL, NULL, 'GOLD COSMETICS BAG WITH BUTTERFLY', '20860');
INSERT INTO public.products VALUES (10, 2.10, 13, NULL, 253, 2, NULL, NULL, 'GOLD COSMETIC BAG PINK STAR', '20861');
INSERT INTO public.products VALUES (24, 1.47, 22, NULL, 254, 2, NULL, NULL, 'BLUE ROSE FABRIC MIRROR', '20866');
INSERT INTO public.products VALUES (10, 1.33, 22, NULL, 255, 2, NULL, NULL, 'PINK ROSE FABRIC MIRROR', '20867');
INSERT INTO public.products VALUES (45, 0.71, 22, NULL, 256, 2, NULL, NULL, 'SILVER FABRIC MIRROR', '20868');
INSERT INTO public.products VALUES (18, 0.72, 22, NULL, 257, 2, NULL, NULL, 'GOLD FABRIC MIRROR', '20869');
INSERT INTO public.products VALUES (10, 4.21, 12, NULL, 258, 2, NULL, NULL, 'OPULENT VELVET SET/3 CANDLES', '20871');
INSERT INTO public.products VALUES (10, 1.25, 12, NULL, 259, 2, NULL, NULL, 'SET/9 CHRISTMAS T-LIGHTS SCENTED ', '20878');
INSERT INTO public.products VALUES (48, 2.47, 12, NULL, 260, 2, NULL, NULL, 'BOX OF 9 PEBBLE CANDLES', '20886');
INSERT INTO public.products VALUES (10, 21.24, 12, NULL, 261, 2, NULL, NULL, 'SET/3 TALL GLASS CANDLE HOLDER PINK', '20892');
INSERT INTO public.products VALUES (10, 2.81, 12, NULL, 262, 2, NULL, NULL, 'HANGING BAUBLE T-LIGHT HOLDER SMALL', '20893');
INSERT INTO public.products VALUES (10, 3.71, 12, NULL, 263, 2, NULL, NULL, 'HANGING BAUBLE T-LIGHT HOLDER LARGE', '20894');
INSERT INTO public.products VALUES (10, 3.16, 22, NULL, 264, 2, NULL, NULL, 'VINTAGE NOTEBOOK PARIS DAYS', '20897');
INSERT INTO public.products VALUES (10, 2.49, 22, NULL, 265, 2, NULL, NULL, 'VINTAGE NOTEBOOK TRAVELOGUE', '20898');
INSERT INTO public.products VALUES (10, 4.65, 16, NULL, 266, 2, NULL, NULL, 'VINTAGE KEEPSAKE BOX PINK FLOWER', '20901');
INSERT INTO public.products VALUES (10, 6.82, 16, NULL, 267, 2, NULL, NULL, 'VINTAGE KEEPSAKE BOX PARIS DAYS', '20902');
INSERT INTO public.products VALUES (10, 5.58, 16, NULL, 268, 2, NULL, NULL, 'VINTAGE KEEPSAKE BOX TRAVELOGUE', '20903');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 269, 2, NULL, NULL, 'VINTAGE NOTEBOOK BEAUTY GIRL', '20906');
INSERT INTO public.products VALUES (10, 6.35, 15, NULL, 270, 2, NULL, NULL, 'VINTAGE PHOTO ALBUM PARIS DAYS', '20910');
INSERT INTO public.products VALUES (626, 3.27, 14, NULL, 271, 2, NULL, NULL, 'SET/5 RED RETROSPOT LID GLASS BOWLS', '20914');
INSERT INTO public.products VALUES (28, 4.98, 12, NULL, 272, 2, NULL, NULL, 'BLUE POT PLANT CANDLE ', '20931');
INSERT INTO public.products VALUES (19, 4.58, 12, NULL, 273, 2, NULL, NULL, 'PINK POT PLANT CANDLE', '20932');
INSERT INTO public.products VALUES (10, 3.13, 12, NULL, 274, 2, NULL, NULL, 'YELLOW POT PLANT CANDLE', '20933');
INSERT INTO public.products VALUES (10, 6.93, 12, NULL, 275, 2, NULL, NULL, 'SET/3 POT PLANT CANDLES', '20934');
INSERT INTO public.products VALUES (10, 2.95, 12, NULL, 276, 2, NULL, NULL, 'ROUND CACTUS CANDLE', '20935');
INSERT INTO public.products VALUES (10, 3.71, 12, NULL, 277, 2, NULL, NULL, 'FORKED CACTUS CANDLE', '20936');
INSERT INTO public.products VALUES (10, 1.37, 12, NULL, 278, 2, NULL, NULL, 'FROG CANDLE', '20941');
INSERT INTO public.products VALUES (10, 8.47, 22, NULL, 279, 2, NULL, NULL, '*USB Office Mirror Ball', '20954');
INSERT INTO public.products VALUES (10, 1.73, 12, NULL, 280, 2, NULL, NULL, 'PORCELAIN T-LIGHT HOLDERS ASSORTED', '20956');
INSERT INTO public.products VALUES (10, 1.45, 22, NULL, 281, 2, NULL, NULL, 'PORCELAIN HANGING BELL SMALL', '20957');
INSERT INTO public.products VALUES (10, 2.49, 22, NULL, 282, 2, NULL, NULL, 'WATERMELON BATH SPONGE', '20960');
INSERT INTO public.products VALUES (118, 1.79, 22, NULL, 283, 2, NULL, NULL, 'STRAWBERRY BATH SPONGE ', '20961');
INSERT INTO public.products VALUES (133, 1.82, 22, NULL, 284, 2, NULL, NULL, 'APPLE BATH SPONGE', '20963');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 285, 2, NULL, NULL, 'POLYESTER FILLER PAD 60x40cm', '20964');
INSERT INTO public.products VALUES (71, 1.96, 22, NULL, 286, 2, NULL, NULL, 'SANDWICH BATH SPONGE', '20966');
INSERT INTO public.products VALUES (26, 4.06, 13, NULL, 287, 2, NULL, NULL, 'GREY FLORAL FELTCRAFT SHOULDER BAG', '20967');
INSERT INTO public.products VALUES (167, 4.26, 13, NULL, 288, 2, NULL, NULL, 'RED FLORAL FELTCRAFT SHOULDER BAG', '20969');
INSERT INTO public.products VALUES (111, 4.19, 13, NULL, 289, 2, NULL, NULL, 'PINK FLORAL FELTCRAFT SHOULDER BAG', '20970');
INSERT INTO public.products VALUES (838, 1.42, 16, NULL, 290, 2, NULL, NULL, 'PINK BLUE FELT CRAFT TRINKET BOX', '20971');
INSERT INTO public.products VALUES (733, 1.42, 16, NULL, 291, 2, NULL, NULL, 'PINK CREAM FELT CRAFT TRINKET BOX ', '20972');
INSERT INTO public.products VALUES (450, 0.79, 22, NULL, 292, 2, NULL, NULL, '12 PENCIL SMALL TUBE WOODLAND', '20973');
INSERT INTO public.products VALUES (641, 0.75, 22, NULL, 293, 2, NULL, NULL, '12 PENCILS SMALL TUBE SKULL', '20974');
INSERT INTO public.products VALUES (652, 0.74, 22, NULL, 294, 2, NULL, NULL, '12 PENCILS SMALL TUBE RED RETROSPOT', '20975');
INSERT INTO public.products VALUES (166, 1.50, 22, NULL, 295, 2, NULL, NULL, '36 PENCILS TUBE WOODLAND', '20977');
INSERT INTO public.products VALUES (178, 1.61, 22, NULL, 296, 2, NULL, NULL, '36 PENCILS TUBE SKULLS', '20978');
INSERT INTO public.products VALUES (357, 1.57, 22, NULL, 297, 2, NULL, NULL, '36 PENCILS TUBE RED RETROSPOT', '20979');
INSERT INTO public.products VALUES (10, 1.07, 22, NULL, 298, 2, NULL, NULL, '36 PENCILS TUBE POSY', '20980');
INSERT INTO public.products VALUES (195, 0.96, 22, NULL, 299, 2, NULL, NULL, '12 PENCILS TALL TUBE WOODLAND', '20981');
INSERT INTO public.products VALUES (215, 0.95, 22, NULL, 300, 2, NULL, NULL, '12 PENCILS TALL TUBE SKULLS', '20982');
INSERT INTO public.products VALUES (273, 0.93, 22, NULL, 301, 2, NULL, NULL, '12 PENCILS TALL TUBE RED RETROSPOT', '20983');
INSERT INTO public.products VALUES (386, 0.38, 22, NULL, 302, 2, NULL, NULL, '12 PENCILS TALL TUBE POSY', '20984');
INSERT INTO public.products VALUES (116, 1.63, 22, NULL, 303, 2, NULL, NULL, 'HEART CALCULATOR', '20985');
INSERT INTO public.products VALUES (65, 1.59, 22, NULL, 304, 2, NULL, NULL, 'BLUE CALCULATOR RULER', '20986');
INSERT INTO public.products VALUES (445, 0.55, 13, NULL, 305, 2, NULL, NULL, 'JAZZ HEARTS PURSE NOTEBOOK', '20992');
INSERT INTO public.products VALUES (319, 0.32, 22, NULL, 306, 2, NULL, NULL, 'JAZZ HEARTS ADDRESS BOOK', '20996');
INSERT INTO public.products VALUES (10, 4.27, 22, NULL, 307, 2, NULL, NULL, 'ROSE DU SUD CUSHION COVER ', '20997');
INSERT INTO public.products VALUES (18, 2.66, 22, NULL, 308, 2, NULL, NULL, 'ROSE DU SUD OVEN GLOVE', '20998');
INSERT INTO public.products VALUES (10, 3.63, 13, NULL, 309, 2, NULL, NULL, 'ROSE DU SUD COSMETICS BAG', '21000');
INSERT INTO public.products VALUES (10, 4.65, 13, NULL, 310, 2, NULL, NULL, 'ROSE DU SUD WASHBAG ', '21001');
INSERT INTO public.products VALUES (12, 3.40, 13, NULL, 311, 2, NULL, NULL, 'ROSE DU SUD DRAWSTRING BAG', '21002');
INSERT INTO public.products VALUES (10, 5.89, 22, NULL, 312, 2, NULL, NULL, 'ROSE DU SUD CUSHION COVER', '21003');
INSERT INTO public.products VALUES (10, 1.25, 14, NULL, 313, 2, NULL, NULL, 'ETCHED GLASS STAR TREE DECORATION', '21009');
INSERT INTO public.products VALUES (10, 1.45, 22, NULL, 314, 2, NULL, NULL, 'GLITTER SNOW PEAR TREE DECORATION', '21011');
INSERT INTO public.products VALUES (116, 2.31, 12, NULL, 315, 2, NULL, NULL, 'ANTIQUE ALL GLASS CANDLESTICK', '21012');
INSERT INTO public.products VALUES (129, 0.67, 22, NULL, 316, 2, NULL, NULL, 'SWISS CHALET TREE DECORATION ', '21014');
INSERT INTO public.products VALUES (148, 0.66, 22, NULL, 317, 2, NULL, NULL, 'DARK BIRD HOUSE TREE DECORATION', '21015');
INSERT INTO public.products VALUES (10, 0.95, 16, NULL, 318, 2, NULL, NULL, 'BIRD BOX CHRISTMAS TREE DECORATION', '21018');
INSERT INTO public.products VALUES (17, 1.55, 22, NULL, 319, 2, NULL, NULL, 'SPACE FROG', '21025');
INSERT INTO public.products VALUES (25, 1.54, 22, NULL, 320, 2, NULL, NULL, 'SPACE OWL', '21026');
INSERT INTO public.products VALUES (16, 1.12, 22, NULL, 321, 2, NULL, NULL, 'NINJA RABBIT PINK', '21027');
INSERT INTO public.products VALUES (18, 1.54, 22, NULL, 322, 2, NULL, NULL, 'NINJA RABBIT BLACK', '21028');
INSERT INTO public.products VALUES (14, 1.19, 22, NULL, 323, 2, NULL, NULL, 'SPACE CADET RED', '21030');
INSERT INTO public.products VALUES (10, 1.29, 22, NULL, 324, 2, NULL, NULL, 'SPACE CADET BLACK', '21031');
INSERT INTO public.products VALUES (10, 1.38, 22, NULL, 325, 2, NULL, NULL, 'SPACE CADET WHITE', '21032');
INSERT INTO public.products VALUES (190, 3.18, 13, NULL, 326, 2, NULL, NULL, 'JUMBO BAG CHARLIE AND LOLA TOYS', '21033');
INSERT INTO public.products VALUES (191, 0.95, 22, NULL, 327, 2, NULL, NULL, 'REX CASH+CARRY JUMBO SHOPPER', '21034');
INSERT INTO public.products VALUES (240, 4.53, 22, NULL, 328, 2, NULL, NULL, 'SET/2 RED RETROSPOT TEA TOWELS ', '21035');
INSERT INTO public.products VALUES (10, 1.24, 22, NULL, 329, 2, NULL, NULL, 'SET/4 MODERN VINTAGE COTTON NAPKINS', '21038');
INSERT INTO public.products VALUES (51, 3.08, 13, NULL, 330, 2, NULL, NULL, 'RED RETROSPOT SHOPPING BAG', '21039');
INSERT INTO public.products VALUES (10, 1.67, 13, NULL, 331, 2, NULL, NULL, 'MODERN VINTAGE COTTON SHOPPING BAG', '21040');
INSERT INTO public.products VALUES (91, 4.36, 22, NULL, 332, 2, NULL, NULL, 'RED RETROSPOT OVEN GLOVE DOUBLE', '21041');
INSERT INTO public.products VALUES (32, 7.17, 22, NULL, 333, 2, NULL, NULL, 'RED RETROSPOT APRON ', '21042');
INSERT INTO public.products VALUES (49, 2.97, 22, NULL, 334, 2, NULL, NULL, 'APRON MODERN VINTAGE COTTON', '21043');
INSERT INTO public.products VALUES (43, 2.01, 13, NULL, 335, 2, NULL, NULL, 'RIBBONS PURSE ', '21051');
INSERT INTO public.products VALUES (10, 9.23, 13, NULL, 336, 2, NULL, NULL, 'NURSE''S BAG SOFT TOY', '21054');
INSERT INTO public.products VALUES (17, 10.41, 16, NULL, 337, 2, NULL, NULL, 'TOOL BOX SOFT TOY ', '21055');
INSERT INTO public.products VALUES (18, 10.09, 13, NULL, 338, 2, NULL, NULL, 'DOCTOR''S BAG SOFT TOY', '21056');
INSERT INTO public.products VALUES (114, 0.97, 22, NULL, 339, 2, NULL, NULL, 'PARTY INVITES WOODLAND', '21058');
INSERT INTO public.products VALUES (59, 0.92, 22, NULL, 340, 2, NULL, NULL, 'PARTY INVITES DINOSAURS', '21059');
INSERT INTO public.products VALUES (40, 0.95, 22, NULL, 341, 2, NULL, NULL, 'PARTY INVITES BALLOON GIRL', '21060');
INSERT INTO public.products VALUES (48, 1.05, 22, NULL, 342, 2, NULL, NULL, 'PARTY INVITES FOOTBALL', '21061');
INSERT INTO public.products VALUES (53, 0.86, 22, NULL, 343, 2, NULL, NULL, 'PARTY INVITES SPACEMAN', '21062');
INSERT INTO public.products VALUES (52, 0.93, 22, NULL, 344, 2, NULL, NULL, 'PARTY INVITES JAZZ HEARTS', '21063');
INSERT INTO public.products VALUES (30, 4.86, 16, NULL, 345, 2, NULL, NULL, 'BOOM BOX SPEAKER BOYS', '21064');
INSERT INTO public.products VALUES (56, 4.40, 16, NULL, 346, 2, NULL, NULL, 'BOOM BOX SPEAKER GIRLS', '21065');
INSERT INTO public.products VALUES (69, 1.52, 14, NULL, 347, 2, NULL, NULL, 'VINTAGE RED MUG', '21066');
INSERT INTO public.products VALUES (29, 1.75, 14, NULL, 348, 2, NULL, NULL, 'VINTAGE RED TEATIME MUG', '21067');
INSERT INTO public.products VALUES (159, 1.66, 14, NULL, 349, 2, NULL, NULL, 'VINTAGE BILLBOARD LOVE/HATE MUG', '21068');
INSERT INTO public.products VALUES (124, 1.73, 14, NULL, 350, 2, NULL, NULL, 'VINTAGE BILLBOARD TEA MUG', '21069');
INSERT INTO public.products VALUES (110, 1.63, 14, NULL, 351, 2, NULL, NULL, 'VINTAGE BILLBOARD MUG ', '21070');
INSERT INTO public.products VALUES (90, 1.70, 14, NULL, 352, 2, NULL, NULL, 'VINTAGE BILLBOARD DRINK ME MUG', '21071');
INSERT INTO public.products VALUES (278, 1.25, 22, NULL, 353, 2, NULL, NULL, 'SET/20 STRAWBERRY PAPER NAPKINS ', '21078');
INSERT INTO public.products VALUES (1319, 1.09, 22, NULL, 354, 2, NULL, NULL, 'SET/20 RED RETROSPOT PAPER NAPKINS ', '21080');
INSERT INTO public.products VALUES (10, 1.57, 22, NULL, 355, 2, NULL, NULL, 'SET/20 FRUIT SALAD PAPER NAPKINS ', '21082');
INSERT INTO public.products VALUES (258, 0.50, 14, NULL, 356, 2, NULL, NULL, 'SET/6 COLLAGE PAPER CUPS', '21084');
INSERT INTO public.products VALUES (713, 0.96, 14, NULL, 357, 2, NULL, NULL, 'SET/6 RED SPOTTY PAPER CUPS', '21086');
INSERT INTO public.products VALUES (14, 0.60, 14, NULL, 358, 2, NULL, NULL, 'SET/6 POSIES PAPER CUPS', '21087');
INSERT INTO public.products VALUES (166, 0.41, 14, NULL, 359, 2, NULL, NULL, 'SET/6 FRUIT SALAD PAPER CUPS', '21088');
INSERT INTO public.products VALUES (22, 0.27, 14, NULL, 360, 2, NULL, NULL, 'SET/6 GREEN SPRING PAPER CUPS', '21089');
INSERT INTO public.products VALUES (219, 0.63, 22, NULL, 361, 2, NULL, NULL, 'SET/6 COLLAGE PAPER PLATES', '21090');
INSERT INTO public.products VALUES (875, 0.99, 22, NULL, 362, 2, NULL, NULL, 'SET/6 RED SPOTTY PAPER PLATES', '21094');
INSERT INTO public.products VALUES (12, 0.96, 22, NULL, 363, 2, NULL, NULL, 'SET/6 POSIES PAPER PLATES', '21095');
INSERT INTO public.products VALUES (125, 0.57, 22, NULL, 364, 2, NULL, NULL, 'SET/6 FRUIT SALAD  PAPER PLATES', '21096');
INSERT INTO public.products VALUES (356, 1.66, 17, NULL, 365, 2, NULL, NULL, 'CHRISTMAS TOILET ROLL', '21098');
INSERT INTO public.products VALUES (10, 3.29, 13, NULL, 366, 2, NULL, NULL, 'CHARLIE AND LOLA CHARLOTTE BAG', '21100');
INSERT INTO public.products VALUES (23, 3.81, 22, NULL, 367, 2, NULL, NULL, 'CREAM SLICE FLANNEL CHOCOLATE SPOT ', '21106');
INSERT INTO public.products VALUES (90, 3.81, 22, NULL, 368, 2, NULL, NULL, 'CREAM SLICE FLANNEL PINK SPOT ', '21107');
INSERT INTO public.products VALUES (710, 2.30, 22, NULL, 369, 2, NULL, NULL, 'FAIRY CAKE FLANNEL ASSORTED COLOUR', '21108');
INSERT INTO public.products VALUES (88, 5.62, 22, NULL, 370, 2, NULL, NULL, 'LARGE CAKE TOWEL, CHOCOLATE SPOTS', '21109');
INSERT INTO public.products VALUES (110, 6.27, 22, NULL, 371, 2, NULL, NULL, 'LARGE CAKE TOWEL PINK SPOTS', '21110');
INSERT INTO public.products VALUES (90, 2.92, 22, NULL, 372, 2, NULL, NULL, 'SWISS ROLL TOWEL, CHOCOLATE  SPOTS', '21111');
INSERT INTO public.products VALUES (135, 3.04, 22, NULL, 373, 2, NULL, NULL, 'SWISS ROLL TOWEL, PINK  SPOTS', '21112');
INSERT INTO public.products VALUES (135, 1.92, 22, NULL, 374, 2, NULL, NULL, 'LAVENDER SCENTED FABRIC HEART', '21114');
INSERT INTO public.products VALUES (56, 7.44, 22, NULL, 375, 2, NULL, NULL, 'ROSE CARAVAN DOORSTOP', '21115');
INSERT INTO public.products VALUES (70, 6.56, 22, NULL, 376, 2, NULL, NULL, 'OWL DOORSTOP', '21116');
INSERT INTO public.products VALUES (11, 1.57, 20, NULL, 377, 2, NULL, NULL, 'BLOND DOLL DOORSTOP', '21117');
INSERT INTO public.products VALUES (10, 16.98, 16, NULL, 378, 2, NULL, NULL, '*Boombox Ipod Classic', '21120');
INSERT INTO public.products VALUES (653, 1.37, 12, NULL, 379, 2, NULL, NULL, 'SET/10 RED POLKADOT PARTY CANDLES', '21121');
INSERT INTO public.products VALUES (528, 1.37, 12, NULL, 380, 2, NULL, NULL, 'SET/10 PINK POLKADOT PARTY CANDLES', '21122');
INSERT INTO public.products VALUES (112, 1.19, 12, NULL, 381, 2, NULL, NULL, 'SET/10 IVORY POLKADOT PARTY CANDLES', '21123');
INSERT INTO public.products VALUES (396, 1.30, 12, NULL, 382, 2, NULL, NULL, 'SET/10 BLUE POLKADOT PARTY CANDLES', '21124');
INSERT INTO public.products VALUES (65, 1.32, 12, NULL, 383, 2, NULL, NULL, 'SET 6 FOOTBALL CELEBRATION CANDLES', '21125');
INSERT INTO public.products VALUES (59, 1.33, 12, NULL, 384, 2, NULL, NULL, 'SET OF 6 GIRLS CELEBRATION CANDLES', '21126');
INSERT INTO public.products VALUES (10, 10.02, 22, NULL, 385, 2, NULL, NULL, 'GOLD FISHING GNOME', '21128');
INSERT INTO public.products VALUES (10, 9.28, 22, NULL, 386, 2, NULL, NULL, 'SILVER FISHING GNOME ', '21129');
INSERT INTO public.products VALUES (10, 5.60, 22, NULL, 387, 2, NULL, NULL, 'GOLD STANDING GNOME', '21131');
INSERT INTO public.products VALUES (10, 5.08, 22, NULL, 388, 2, NULL, NULL, 'SILVER STANDING GNOME   ', '21132');
INSERT INTO public.products VALUES (111, 1.85, 19, NULL, 389, 2, NULL, NULL, 'VICTORIAN  METAL POSTCARD SPRING', '21135');
INSERT INTO public.products VALUES (442, 1.80, 22, NULL, 390, 2, NULL, NULL, 'PAINTED METAL PEARS ASSORTED', '21136');
INSERT INTO public.products VALUES (1164, 4.20, 15, NULL, 391, 2, NULL, NULL, 'BLACK RECORD COVER FRAME', '21137');
INSERT INTO public.products VALUES (32, 2.44, 14, NULL, 392, 2, NULL, NULL, 'ANTIQUE GLASS HEART DECORATION ', '21143');
INSERT INTO public.products VALUES (10, 2.37, 22, NULL, 393, 2, NULL, NULL, 'PINK POODLE HANGING DECORATION ', '21144');
INSERT INTO public.products VALUES (12, 1.25, 14, NULL, 394, 2, NULL, NULL, 'ANTIQUE GLASS PLACE SETTING', '21145');
INSERT INTO public.products VALUES (18, 1.99, 22, NULL, 395, 2, NULL, NULL, 'JINGLE BELLS TREE DECORATION', '21147');
INSERT INTO public.products VALUES (382, 1.94, 22, NULL, 396, 2, NULL, NULL, 'RED RETROSPOT OVEN GLOVE ', '21154');
INSERT INTO public.products VALUES (291, 3.11, 13, NULL, 397, 2, NULL, NULL, 'RED RETROSPOT PEG BAG', '21155');
INSERT INTO public.products VALUES (313, 2.36, 22, NULL, 398, 2, NULL, NULL, 'RETROSPOT CHILDRENS APRON', '21156');
INSERT INTO public.products VALUES (10, 3.27, 13, NULL, 399, 2, NULL, NULL, 'RED RETROSPOT WASHBAG', '21157');
INSERT INTO public.products VALUES (145, 0.96, 22, NULL, 400, 2, NULL, NULL, 'MOODY GIRL DOOR HANGER ', '21158');
INSERT INTO public.products VALUES (108, 1.02, 22, NULL, 401, 2, NULL, NULL, 'MOODY BOY  DOOR HANGER ', '21159');
INSERT INTO public.products VALUES (10, 3.36, 22, NULL, 402, 2, NULL, NULL, 'KEEP OUT GIRLS DOOR HANGER ', '21160');
INSERT INTO public.products VALUES (14, 1.78, 22, NULL, 403, 2, NULL, NULL, 'KEEP OUT BOYS DOOR HANGER ', '21161');
INSERT INTO public.products VALUES (146, 0.98, 22, NULL, 404, 2, NULL, NULL, 'TOXIC AREA  DOOR HANGER ', '21162');
INSERT INTO public.products VALUES (120, 1.02, 22, NULL, 405, 2, NULL, NULL, 'DO NOT TOUCH MY STUFF DOOR HANGER ', '21163');
INSERT INTO public.products VALUES (176, 3.29, 21, NULL, 406, 2, NULL, NULL, 'HOME SWEET HOME METAL SIGN ', '21164');
INSERT INTO public.products VALUES (411, 2.15, 21, NULL, 407, 2, NULL, NULL, 'BEWARE OF THE CAT METAL SIGN ', '21165');
INSERT INTO public.products VALUES (1015, 2.38, 21, NULL, 408, 2, NULL, NULL, 'COOK WITH WINE METAL SIGN ', '21166');
INSERT INTO public.products VALUES (138, 0.34, 22, NULL, 409, 2, NULL, NULL, 'WHITE SAGE INCENSE', '21167');
INSERT INTO public.products VALUES (440, 2.23, 21, NULL, 410, 2, NULL, NULL, 'YOU''RE CONFUSING ME METAL SIGN ', '21169');
INSERT INTO public.products VALUES (43, 1.77, 21, NULL, 411, 2, NULL, NULL, 'BATHROOM METAL SIGN ', '21171');
INSERT INTO public.products VALUES (347, 2.01, 21, NULL, 412, 2, NULL, NULL, 'PARTY METAL SIGN ', '21172');
INSERT INTO public.products VALUES (425, 2.69, 21, NULL, 413, 2, NULL, NULL, 'POTTERING IN THE SHED METAL SIGN', '21174');
INSERT INTO public.products VALUES (1019, 2.76, 21, NULL, 414, 2, NULL, NULL, 'GIN + TONIC DIET METAL SIGN', '21175');
INSERT INTO public.products VALUES (191, 1.19, 21, NULL, 415, 2, NULL, NULL, 'NO JUNK MAIL METAL SIGN', '21179');
INSERT INTO public.products VALUES (1256, 2.40, 21, NULL, 416, 2, NULL, NULL, 'PLEASE ONE PERSON METAL SIGN', '21181');
INSERT INTO public.products VALUES (10, 3.36, 22, NULL, 417, 2, NULL, NULL, 'WHITE DOVE HONEYCOMB PAPER GARLAND', '21186');
INSERT INTO public.products VALUES (37, 2.11, 22, NULL, 418, 2, NULL, NULL, 'WHITE BELL HONEYCOMB PAPER GARLAND ', '21187');
INSERT INTO public.products VALUES (32, 3.83, 22, NULL, 419, 2, NULL, NULL, '3D HEARTS  HONEYCOMB PAPER GARLAND', '21188');
INSERT INTO public.products VALUES (35, 2.58, 22, NULL, 420, 2, NULL, NULL, 'WHITE HONEYCOMB PAPER GARLAND ', '21189');
INSERT INTO public.products VALUES (11, 1.57, 22, NULL, 421, 2, NULL, NULL, 'PINK HEARTS PAPER GARLAND', '21190');
INSERT INTO public.products VALUES (56, 3.07, 22, NULL, 422, 2, NULL, NULL, 'LARGE WHITE HONEYCOMB PAPER BELL  ', '21191');
INSERT INTO public.products VALUES (97, 2.39, 22, NULL, 423, 2, NULL, NULL, 'WHITE BELL HONEYCOMB PAPER ', '21192');
INSERT INTO public.products VALUES (48, 1.64, 22, NULL, 424, 2, NULL, NULL, 'PINK  HONEYCOMB PAPER FAN', '21194');
INSERT INTO public.products VALUES (69, 2.83, 22, NULL, 425, 2, NULL, NULL, 'PINK  HONEYCOMB PAPER BALL ', '21195');
INSERT INTO public.products VALUES (10, 2.00, 22, NULL, 426, 2, NULL, NULL, 'ROUND WHITE CONFETTI IN TUBE', '21196');
INSERT INTO public.products VALUES (26, 1.62, 22, NULL, 427, 2, NULL, NULL, 'MULTICOLOUR  CONFETTI IN TUBE', '21197');
INSERT INTO public.products VALUES (95, 1.44, 22, NULL, 428, 2, NULL, NULL, 'WHITE HEART CONFETTI IN TUBE', '21198');
INSERT INTO public.products VALUES (91, 1.57, 22, NULL, 429, 2, NULL, NULL, 'PINK  HEART CONFETTI IN TUBE', '21199');
INSERT INTO public.products VALUES (111, 1.97, 22, NULL, 430, 2, NULL, NULL, 'MULTICOLOUR HONEYCOMB PAPER GARLAND', '21200');
INSERT INTO public.products VALUES (84, 3.13, 22, NULL, 431, 2, NULL, NULL, 'TROPICAL  HONEYCOMB PAPER GARLAND ', '21201');
INSERT INTO public.products VALUES (47, 1.75, 20, NULL, 432, 2, NULL, NULL, 'DOLLY HONEYCOMB GARLAND', '21202');
INSERT INTO public.products VALUES (49, 1.96, 22, NULL, 433, 2, NULL, NULL, 'DAISIES  HONEYCOMB GARLAND ', '21204');
INSERT INTO public.products VALUES (23, 2.80, 22, NULL, 434, 2, NULL, NULL, 'MULTICOLOUR 3D BALLS GARLAND', '21205');
INSERT INTO public.products VALUES (128, 1.92, 22, NULL, 435, 2, NULL, NULL, 'STRAWBERRY HONEYCOMB  GARLAND ', '21206');
INSERT INTO public.products VALUES (106, 1.67, 22, NULL, 436, 2, NULL, NULL, 'SKULL AND CROSSBONES  GARLAND ', '21207');
INSERT INTO public.products VALUES (90, 1.21, 22, NULL, 437, 2, NULL, NULL, 'PASTEL COLOUR HONEYCOMB FAN', '21208');
INSERT INTO public.products VALUES (120, 1.35, 22, NULL, 438, 2, NULL, NULL, 'MULTICOLOUR HONEYCOMB FAN', '21209');
INSERT INTO public.products VALUES (567, 1.78, 22, NULL, 439, 2, NULL, NULL, 'SET OF 72 RETROSPOT PAPER  DOILIES', '21210');
INSERT INTO public.products VALUES (88, 1.73, 22, NULL, 440, 2, NULL, NULL, 'SET OF 72 SKULL PAPER  DOILIES', '21211');
INSERT INTO public.products VALUES (3603, 0.76, 22, NULL, 441, 2, NULL, NULL, 'PACK OF 72 RETROSPOT CAKE CASES', '21212');
INSERT INTO public.products VALUES (1512, 0.79, 22, NULL, 442, 2, NULL, NULL, 'PACK OF 72 SKULL CAKE CASES', '21213');
INSERT INTO public.products VALUES (108, 0.92, 14, NULL, 443, 2, NULL, NULL, 'IVORY PAPER CUP CAKE CASES ', '21215');
INSERT INTO public.products VALUES (211, 7.33, 22, NULL, 444, 2, NULL, NULL, 'SET 3 RETROSPOT TEA,COFFEE,SUGAR', '21216');
INSERT INTO public.products VALUES (108, 12.52, 16, NULL, 445, 2, NULL, NULL, 'RED RETROSPOT ROUND CAKE TINS', '21217');
INSERT INTO public.products VALUES (238, 5.85, 16, NULL, 446, 2, NULL, NULL, 'RED SPOTTY BISCUIT TIN', '21218');
INSERT INTO public.products VALUES (44, 1.50, 22, NULL, 447, 2, NULL, NULL, 'SET/4 BADGES BALLOON GIRL', '21219');
INSERT INTO public.products VALUES (34, 1.55, 22, NULL, 448, 2, NULL, NULL, 'SET/4 BADGES DOGS', '21220');
INSERT INTO public.products VALUES (26, 1.36, 22, NULL, 449, 2, NULL, NULL, 'SET/4 BADGES CUTE CREATURES', '21221');
INSERT INTO public.products VALUES (26, 1.57, 22, NULL, 450, 2, NULL, NULL, 'SET/4 BADGES BEETLES', '21222');
INSERT INTO public.products VALUES (90, 1.10, 22, NULL, 451, 2, NULL, NULL, 'SET/4 SKULL BADGES', '21224');
INSERT INTO public.products VALUES (10, 0.93, 22, NULL, 452, 2, NULL, NULL, 'POCKET MIRROR WOODLAND', '21226');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 453, 2, NULL, NULL, 'POCKET MIRROR "GLAMOROUS"', '21228');
INSERT INTO public.products VALUES (590, 1.55, 16, NULL, 454, 2, NULL, NULL, 'SWEETHEART CERAMIC TRINKET BOX', '21231');
INSERT INTO public.products VALUES (1147, 1.64, 16, NULL, 455, 2, NULL, NULL, 'STRAWBERRY CERAMIC TRINKET BOX', '21232');
INSERT INTO public.products VALUES (391, 1.06, 14, NULL, 456, 2, NULL, NULL, 'RED RETROSPOT CUP', '21238');
INSERT INTO public.products VALUES (299, 1.12, 14, NULL, 457, 2, NULL, NULL, 'PINK  POLKADOT CUP', '21239');
INSERT INTO public.products VALUES (353, 1.11, 14, NULL, 458, 2, NULL, NULL, 'BLUE POLKADOT CUP', '21240');
INSERT INTO public.products VALUES (334, 2.08, 22, NULL, 459, 2, NULL, NULL, 'RED RETROSPOT PLATE ', '21242');
INSERT INTO public.products VALUES (227, 2.13, 22, NULL, 460, 2, NULL, NULL, 'PINK  POLKADOT PLATE ', '21243');
INSERT INTO public.products VALUES (226, 2.05, 22, NULL, 461, 2, NULL, NULL, 'BLUE POLKADOT PLATE ', '21244');
INSERT INTO public.products VALUES (107, 2.00, 22, NULL, 462, 2, NULL, NULL, 'GREEN POLKADOT PLATE ', '21245');
INSERT INTO public.products VALUES (28, 4.51, 22, NULL, 463, 2, NULL, NULL, 'RED RETROSPOT BIG BOWL', '21246');
INSERT INTO public.products VALUES (20, 1.84, 22, NULL, 464, 2, NULL, NULL, 'DOOR HANGER  MUM + DADS ROOM', '21248');
INSERT INTO public.products VALUES (72, 3.87, 22, NULL, 465, 2, NULL, NULL, 'WOODLAND  HEIGHT CHART STICKERS ', '21249');
INSERT INTO public.products VALUES (10, 3.36, 22, NULL, 466, 2, NULL, NULL, 'SET OF SKULL WALL STICKERS', '21250');
INSERT INTO public.products VALUES (18, 3.58, 22, NULL, 467, 2, NULL, NULL, 'DINOSAUR HEIGHT CHART STICKER SET', '21251');
INSERT INTO public.products VALUES (13, 5.00, 15, NULL, 468, 2, NULL, NULL, 'SET OF PICTURE FRAME  STICKERS', '21253');
INSERT INTO public.products VALUES (58, 11.14, 16, NULL, 469, 2, NULL, NULL, 'VICTORIAN SEWING BOX MEDIUM', '21257');
INSERT INTO public.products VALUES (44, 16.40, 16, NULL, 470, 2, NULL, NULL, 'VICTORIAN SEWING BOX LARGE', '21258');
INSERT INTO public.products VALUES (116, 6.97, 16, NULL, 471, 2, NULL, NULL, 'VICTORIAN SEWING BOX SMALL ', '21259');
INSERT INTO public.products VALUES (111, 3.58, 16, NULL, 472, 2, NULL, NULL, 'FIRST AID TIN', '21260');
INSERT INTO public.products VALUES (18, 5.11, 17, NULL, 473, 2, NULL, NULL, 'GREEN GOOSE FEATHER CHRISTMAS TREE ', '21261');
INSERT INTO public.products VALUES (33, 4.79, 17, NULL, 474, 2, NULL, NULL, 'WHITE GOOSE FEATHER CHRISTMAS TREE ', '21262');
INSERT INTO public.products VALUES (16, 2.46, 22, NULL, 475, 2, NULL, NULL, 'GREEN GOOSE FEATHER TREE 60CM', '21263');
INSERT INTO public.products VALUES (27, 2.34, 22, NULL, 476, 2, NULL, NULL, 'WHITE GOOSE FEATHER TREE 60CM ', '21264');
INSERT INTO public.products VALUES (13, 2.57, 22, NULL, 477, 2, NULL, NULL, 'PINK GOOSE FEATHER TREE 60CM', '21265');
INSERT INTO public.products VALUES (10, 0.42, 16, NULL, 478, 2, NULL, NULL, 'VINTAGE BLUE TINSEL REEL', '21268');
INSERT INTO public.products VALUES (10, 8.95, 22, NULL, 479, 2, NULL, NULL, 'ANTIQUE CREAM CUTLERY SHELF ', '21269');
INSERT INTO public.products VALUES (10, 11.34, 14, NULL, 480, 2, NULL, NULL, 'ANTIQUE CREAM CUTLERY CUPBOARD', '21270');
INSERT INTO public.products VALUES (33, 1.71, 22, NULL, 481, 2, NULL, NULL, 'SALLE DE BAIN HOOK', '21272');
INSERT INTO public.products VALUES (10, 19.00, 22, NULL, 482, 2, NULL, NULL, '?', '21275');
INSERT INTO public.products VALUES (10, 22.23, 22, NULL, 483, 2, NULL, NULL, 'FRENCH STYLE EMBOSSED HEART CABINET', '21277');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 484, 2, NULL, NULL, 'VINTAGE KITCHEN PRINT PUDDINGS', '21278');
INSERT INTO public.products VALUES (10, 3.95, 22, NULL, 485, 2, NULL, NULL, 'VINTAGE KITCHEN PRINT FRUITS', '21279');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 486, 2, NULL, NULL, 'VINTAGE KITCHEN PRINT VEGETABLES', '21280');
INSERT INTO public.products VALUES (10, 3.98, 22, NULL, 487, 2, NULL, NULL, 'VINTAGE KITCHEN PRINT SEAFOOD', '21281');
INSERT INTO public.products VALUES (36, 1.99, 12, NULL, 488, 2, NULL, NULL, 'RETROSPOT CANDLE  SMALL', '21284');
INSERT INTO public.products VALUES (34, 2.14, 12, NULL, 489, 2, NULL, NULL, 'RETROSPOT CANDLE  MEDIUM', '21285');
INSERT INTO public.products VALUES (27, 2.67, 12, NULL, 490, 2, NULL, NULL, 'RETROSPOT CANDLE  LARGE', '21286');
INSERT INTO public.products VALUES (179, 0.55, 12, NULL, 491, 2, NULL, NULL, 'SCENTED VELVET LOUNGE CANDLE ', '21287');
INSERT INTO public.products VALUES (33, 3.30, 16, NULL, 492, 2, NULL, NULL, 'STRIPEY CHOCOLATE NESTING BOXES', '21288');
INSERT INTO public.products VALUES (54, 1.25, 13, NULL, 493, 2, NULL, NULL, 'LARGE STRIPES CHOCOLATE GIFT BAG', '21289');
INSERT INTO public.products VALUES (94, 1.03, 13, NULL, 494, 2, NULL, NULL, 'SMALL POLKADOT CHOCOLATE GIFT BAG ', '21291');
INSERT INTO public.products VALUES (86, 0.87, 13, NULL, 495, 2, NULL, NULL, 'SMALL STRIPES CHOCOLATE GIFT BAG ', '21292');
INSERT INTO public.products VALUES (11, 2.67, 22, NULL, 496, 2, NULL, NULL, 'MIRRORED DOVE WALL DECORATION', '21293');
INSERT INTO public.products VALUES (139, 0.83, 14, NULL, 497, 2, NULL, NULL, 'ETCHED GLASS COASTER', '21294');
INSERT INTO public.products VALUES (47, 1.03, 22, NULL, 498, 2, NULL, NULL, 'SET/4 DAISY MIRROR MAGNETS', '21306');
INSERT INTO public.products VALUES (10, 1.26, 22, NULL, 499, 2, NULL, NULL, 'SET/4 BUTTERFLY MIRROR MAGNETS', '21307');
INSERT INTO public.products VALUES (10, 29.95, 22, NULL, 500, 2, NULL, NULL, 'CAPIZ CHANDELIER', '21310');
INSERT INTO public.products VALUES (45, 0.85, 22, NULL, 501, 2, NULL, NULL, 'SET/4 BIRD MIRROR MAGNETS ', '21311');
INSERT INTO public.products VALUES (330, 1.13, 12, NULL, 502, 2, NULL, NULL, 'GLASS HEART T-LIGHT HOLDER ', '21313');
INSERT INTO public.products VALUES (411, 2.78, 14, NULL, 503, 2, NULL, NULL, 'SMALL GLASS HEART TRINKET POT', '21314');
INSERT INTO public.products VALUES (15, 3.04, 14, NULL, 504, 2, NULL, NULL, 'SMALL CHUNKY GLASS ROMAN  BOWL', '21316');
INSERT INTO public.products VALUES (11, 6.58, 12, NULL, 505, 2, NULL, NULL, 'GLASS SPHERE CANDLE STAND MEDIUM', '21317');
INSERT INTO public.products VALUES (67, 1.29, 14, NULL, 506, 2, NULL, NULL, 'GLASS CHALICE BLUE SMALL ', '21318');
INSERT INTO public.products VALUES (16, 1.88, 14, NULL, 507, 2, NULL, NULL, 'GLASS CHALICE GREEN  SMALL ', '21319');
INSERT INTO public.products VALUES (12, 2.77, 14, NULL, 508, 2, NULL, NULL, 'GLASS CHALICE GREEN  LARGE ', '21320');
INSERT INTO public.products VALUES (10, 3.48, 12, NULL, 509, 2, NULL, NULL, 'HANGING MEDINA LANTERN SMALL', '21324');
INSERT INTO public.products VALUES (1056, 0.82, 12, NULL, 510, 2, NULL, NULL, 'AGED GLASS SILVER T-LIGHT HOLDER', '21326');
INSERT INTO public.products VALUES (86, 1.98, 16, NULL, 511, 2, NULL, NULL, 'SKULLS WRITING SET ', '21327');
INSERT INTO public.products VALUES (134, 2.24, 16, NULL, 512, 2, NULL, NULL, 'BALLOONS  WRITING SET ', '21328');
INSERT INTO public.products VALUES (94, 2.15, 16, NULL, 513, 2, NULL, NULL, 'DINOSAURS  WRITING SET ', '21329');
INSERT INTO public.products VALUES (10, 14.34, 22, NULL, 514, 2, NULL, NULL, 'MOROCCAN BEATEN METAL DISH LARGE', '21331');
INSERT INTO public.products VALUES (10, 16.09, 22, NULL, 515, 2, NULL, NULL, 'MOROCCAN BEATEN METAL MIRROR', '21332');
INSERT INTO public.products VALUES (10, 3.14, 15, NULL, 516, 2, NULL, NULL, 'CLASSIC WHITE FRAME', '21333');
INSERT INTO public.products VALUES (10, 2.03, 13, NULL, 517, 2, NULL, NULL, 'GOLD WASHBAG', '21336');
INSERT INTO public.products VALUES (95, 13.33, 22, NULL, 518, 2, NULL, NULL, 'CLASSIC METAL BIRDCAGE PLANT HOLDER', '21340');
INSERT INTO public.products VALUES (10, 11.50, 22, NULL, 519, 2, NULL, NULL, 'MOROCCAN BEATEN METAL DISH', '21344');
INSERT INTO public.products VALUES (14, 3.31, 16, NULL, 520, 2, NULL, NULL, 'PINK SPOTS CHOCOLATE NESTING BOXES ', '21348');
INSERT INTO public.products VALUES (10, 7.80, 22, NULL, 521, 2, NULL, NULL, 'IVY HEART WREATH', '21349');
INSERT INTO public.products VALUES (10, 6.49, 22, NULL, 522, 2, NULL, NULL, 'CINAMMON & ORANGE WREATH', '21351');
INSERT INTO public.products VALUES (34, 5.11, 22, NULL, 523, 2, NULL, NULL, 'EUCALYPTUS & PINECONE  WREATH', '21352');
INSERT INTO public.products VALUES (80, 1.58, 22, NULL, 524, 2, NULL, NULL, 'TOAST ITS - BEST MUM', '21354');
INSERT INTO public.products VALUES (79, 1.36, 22, NULL, 525, 2, NULL, NULL, 'TOAST ITS - I LOVE YOU ', '21355');
INSERT INTO public.products VALUES (64, 1.22, 22, NULL, 526, 2, NULL, NULL, 'TOAST ITS - FAIRY FLOWER', '21356');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 527, 2, NULL, NULL, 'TOAST ITS - DINOSAUR', '21357');
INSERT INTO public.products VALUES (41, 1.18, 22, NULL, 528, 2, NULL, NULL, 'TOAST ITS - HAPPY BIRTHDAY', '21358');
INSERT INTO public.products VALUES (12, 10.38, 21, NULL, 529, 2, NULL, NULL, 'RELAX LARGE WOOD LETTERS', '21359');
INSERT INTO public.products VALUES (10, 8.55, 21, NULL, 530, 2, NULL, NULL, 'JOY LARGE WOOD LETTERS', '21360');
INSERT INTO public.products VALUES (10, 15.36, 21, NULL, 531, 2, NULL, NULL, 'LOVE LARGE WOOD LETTERS ', '21361');
INSERT INTO public.products VALUES (23, 6.43, 21, NULL, 532, 2, NULL, NULL, 'HOME SMALL WOOD LETTERS', '21363');
INSERT INTO public.products VALUES (10, 7.30, 21, NULL, 533, 2, NULL, NULL, 'PEACE SMALL WOOD LETTERS', '21364');
INSERT INTO public.products VALUES (36, 1.97, 22, NULL, 534, 2, NULL, NULL, 'MIRRORED WALL ART STARS', '21365');
INSERT INTO public.products VALUES (10, 5.89, 15, NULL, 535, 2, NULL, NULL, 'MIRRORED WALL ART PHOTO FRAMES', '21366');
INSERT INTO public.products VALUES (17, 2.20, 22, NULL, 536, 2, NULL, NULL, 'MIRRORED WALL ART GENTS', '21367');
INSERT INTO public.products VALUES (16, 1.23, 22, NULL, 537, 2, NULL, NULL, 'MIRRORED WALL ART LADIES', '21368');
INSERT INTO public.products VALUES (10, 2.52, 22, NULL, 538, 2, NULL, NULL, 'MIRRORED WALL ART SPLODGES', '21369');
INSERT INTO public.products VALUES (10, 5.78, 22, NULL, 539, 2, NULL, NULL, 'MIRRORED WALL ART FOXY', '21370');
INSERT INTO public.products VALUES (28, 1.64, 22, NULL, 540, 2, NULL, NULL, 'MIRRORED WALL ART POPPIES', '21371');
INSERT INTO public.products VALUES (10, 1.98, 22, NULL, 541, 2, NULL, NULL, 'MIRRORED WALL ART TABLE LAMP', '21372');
INSERT INTO public.products VALUES (50, 0.85, 22, NULL, 542, 2, NULL, NULL, 'MIRRORED WALL ART SNOWFLAKES', '21373');
INSERT INTO public.products VALUES (30, 2.37, 22, NULL, 543, 2, NULL, NULL, 'MIRRORED WALL ART SKULLS', '21374');
INSERT INTO public.products VALUES (10, 8.15, 22, NULL, 544, 2, NULL, NULL, 'LARGE CAMPHOR WOOD FIELD MUSHROOM ', '21375');
INSERT INTO public.products VALUES (10, 5.91, 22, NULL, 545, 2, NULL, NULL, 'LARGE  TALL CAMPHOR WOOD TOADSTOOL ', '21376');
INSERT INTO public.products VALUES (12, 2.44, 22, NULL, 546, 2, NULL, NULL, 'SMALL CAMPHOR WOOD FIELD  MUSHROOM', '21377');
INSERT INTO public.products VALUES (14, 2.12, 22, NULL, 547, 2, NULL, NULL, 'SMALL TALL CAMPHOR WOOD TOADSTOOL', '21378');
INSERT INTO public.products VALUES (18, 1.84, 22, NULL, 548, 2, NULL, NULL, 'CAMPHOR WOOD PORTOBELLO MUSHROOM', '21379');
INSERT INTO public.products VALUES (216, 3.48, 22, NULL, 549, 2, NULL, NULL, 'WOODEN HAPPY BIRTHDAY GARLAND', '21380');
INSERT INTO public.products VALUES (179, 2.36, 22, NULL, 550, 2, NULL, NULL, 'MINI WOODEN HAPPY BIRTHDAY GARLAND', '21381');
INSERT INTO public.products VALUES (114, 2.01, 22, NULL, 551, 2, NULL, NULL, 'SET/4 SPRING FLOWER DECORATION', '21382');
INSERT INTO public.products VALUES (99, 1.01, 22, NULL, 552, 2, NULL, NULL, 'PACK OF 12 STICKY BUNNIES', '21383');
INSERT INTO public.products VALUES (388, 1.10, 22, NULL, 553, 2, NULL, NULL, 'IVORY HANGING DECORATION  HEART', '21385');
INSERT INTO public.products VALUES (73, 0.55, 22, NULL, 554, 2, NULL, NULL, 'IVORY HANGING DECORATION  EGG', '21386');
INSERT INTO public.products VALUES (111, 0.95, 22, NULL, 555, 2, NULL, NULL, 'IVORY HANGING DECORATION  BIRD', '21389');
INSERT INTO public.products VALUES (390, 1.47, 22, NULL, 556, 2, NULL, NULL, 'FILIGRIS HEART WITH BUTTERFLY', '21390');
INSERT INTO public.products VALUES (73, 1.49, 22, NULL, 557, 2, NULL, NULL, 'FRENCH LAVENDER SCENT HEART', '21391');
INSERT INTO public.products VALUES (10, 1.71, 22, NULL, 558, 2, NULL, NULL, 'RED POLKADOT PUDDING BOWL', '21392');
INSERT INTO public.products VALUES (10, 1.46, 22, NULL, 559, 2, NULL, NULL, 'BLUE POLKADOT PUDDING BOWL', '21393');
INSERT INTO public.products VALUES (380, 0.59, 22, NULL, 560, 2, NULL, NULL, 'RED POLKADOT BEAKER ', '21394');
INSERT INTO public.products VALUES (283, 0.54, 22, NULL, 561, 2, NULL, NULL, 'BLUE POLKADOT BEAKER ', '21395');
INSERT INTO public.products VALUES (101, 1.04, 14, NULL, 562, 2, NULL, NULL, 'BLUE POLKADOT EGG CUP ', '21397');
INSERT INTO public.products VALUES (152, 1.23, 14, NULL, 563, 2, NULL, NULL, 'RED POLKADOT COFFEE  MUG', '21398');
INSERT INTO public.products VALUES (195, 0.77, 14, NULL, 564, 2, NULL, NULL, 'BLUE POLKADOT COFFEE MUG', '21399');
INSERT INTO public.products VALUES (88, 0.25, 22, NULL, 565, 2, NULL, NULL, 'RED PUDDING SPOON', '21400');
INSERT INTO public.products VALUES (105, 0.24, 22, NULL, 566, 2, NULL, NULL, 'BLUE PUDDING SPOON', '21401');
INSERT INTO public.products VALUES (136, 0.26, 22, NULL, 567, 2, NULL, NULL, 'RED  EGG  SPOON', '21402');
INSERT INTO public.products VALUES (185, 0.25, 22, NULL, 568, 2, NULL, NULL, 'BLUE EGG  SPOON', '21403');
INSERT INTO public.products VALUES (28, 5.44, 22, NULL, 569, 2, NULL, NULL, 'BROWN CHECK CAT DOORSTOP ', '21407');
INSERT INTO public.products VALUES (28, 5.86, 22, NULL, 570, 2, NULL, NULL, 'SPOTTY PINK DUCK DOORSTOP', '21408');
INSERT INTO public.products VALUES (10, 8.47, 22, NULL, 571, 2, NULL, NULL, 'COUNTRY COTTAGE  DOORSTOP GREEN', '21410');
INSERT INTO public.products VALUES (78, 4.89, 22, NULL, 572, 2, NULL, NULL, 'GINGHAM HEART  DOORSTOP RED', '21411');
INSERT INTO public.products VALUES (10, 0.42, 16, NULL, 573, 2, NULL, NULL, 'VINTAGE GOLD TINSEL REEL', '21412');
INSERT INTO public.products VALUES (10, 1.77, 12, NULL, 574, 2, NULL, NULL, 'PERIWINKLE T-LIGHT HOLDER', '21413');
INSERT INTO public.products VALUES (10, 2.10, 22, NULL, 575, 2, NULL, NULL, 'SCALLOP SHELL SOAP DISH', '21414');
INSERT INTO public.products VALUES (22, 2.70, 22, NULL, 576, 2, NULL, NULL, 'CLAM SHELL SMALL ', '21415');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 577, 2, NULL, NULL, 'CLAM SHELL LARGE', '21416');
INSERT INTO public.products VALUES (33, 2.98, 22, NULL, 578, 2, NULL, NULL, 'COCKLE SHELL DISH', '21417');
INSERT INTO public.products VALUES (10, 3.49, 22, NULL, 579, 2, NULL, NULL, 'STARFISH SOAP DISH', '21418');
INSERT INTO public.products VALUES (10, 3.83, 16, NULL, 580, 2, NULL, NULL, 'OYSTER TRINKET BOX', '21420');
INSERT INTO public.products VALUES (29, 1.29, 22, NULL, 581, 2, NULL, NULL, 'PORCELAIN ROSE LARGE ', '21421');
INSERT INTO public.products VALUES (160, 1.10, 22, NULL, 582, 2, NULL, NULL, 'PORCELAIN ROSE SMALL', '21422');
INSERT INTO public.products VALUES (30, 5.21, 16, NULL, 583, 2, NULL, NULL, 'WOODLAND STORAGE BOX LARGE ', '21424');
INSERT INTO public.products VALUES (10, 4.64, 16, NULL, 584, 2, NULL, NULL, 'SKULLS STORAGE BOX LARGE', '21425');
INSERT INTO public.products VALUES (25, 3.74, 16, NULL, 585, 2, NULL, NULL, 'WOODLAND STORAGE BOX SMALL', '21426');
INSERT INTO public.products VALUES (10, 3.15, 16, NULL, 586, 2, NULL, NULL, 'SKULLS STORAGE BOX SMALL', '21427');
INSERT INTO public.products VALUES (117, 5.41, 16, NULL, 587, 2, NULL, NULL, 'SET3 BOOK BOX GREEN GINGHAM FLOWER ', '21428');
INSERT INTO public.products VALUES (170, 2.31, 16, NULL, 588, 2, NULL, NULL, 'RED GINGHAM ROSE JEWELLERY BOX', '21429');
INSERT INTO public.products VALUES (299, 4.89, 16, NULL, 589, 2, NULL, NULL, 'SET/3 RED GINGHAM ROSE STORAGE BOX', '21430');
INSERT INTO public.products VALUES (102, 1.57, 16, NULL, 590, 2, NULL, NULL, 'BASKET OF TOADSTOOLS', '21439');
INSERT INTO public.products VALUES (42, 1.07, 22, NULL, 591, 2, NULL, NULL, 'BLUE BIRDHOUSE DECORATION', '21441');
INSERT INTO public.products VALUES (44, 1.04, 22, NULL, 592, 2, NULL, NULL, 'GREEN BIRDHOUSE DECORATION', '21442');
INSERT INTO public.products VALUES (21, 1.25, 16, NULL, 593, 2, NULL, NULL, '12 PINK ROSE PEG PLACE SETTINGS', '21445');
INSERT INTO public.products VALUES (45, 1.57, 16, NULL, 594, 2, NULL, NULL, '12 RED ROSE PEG PLACE SETTINGS', '21446');
INSERT INTO public.products VALUES (96, 1.71, 16, NULL, 595, 2, NULL, NULL, '12 IVORY ROSE PEG PLACE SETTINGS', '21447');
INSERT INTO public.products VALUES (34, 1.91, 16, NULL, 596, 2, NULL, NULL, '12 DAISY PEGS IN WOOD BOX', '21448');
INSERT INTO public.products VALUES (78, 3.59, 16, NULL, 597, 2, NULL, NULL, 'TOADSTOOL MONEY BOX', '21452');
INSERT INTO public.products VALUES (57, 0.86, 22, NULL, 598, 2, NULL, NULL, 'PAINTED PINK RABBIT ', '21454');
INSERT INTO public.products VALUES (59, 0.86, 22, NULL, 599, 2, NULL, NULL, 'PAINTED YELLOW WOODEN DAISY', '21455');
INSERT INTO public.products VALUES (17, 1.48, 15, NULL, 600, 2, NULL, NULL, '2 PICTURE BOOK EGGS EASTER CHICKS', '21456');
INSERT INTO public.products VALUES (12, 1.69, 15, NULL, 601, 2, NULL, NULL, '2 PICTURE BOOK EGGS EASTER DUCKS', '21457');
INSERT INTO public.products VALUES (18, 1.82, 15, NULL, 602, 2, NULL, NULL, '2 PICTURE BOOK EGGS EASTER BUNNY', '21458');
INSERT INTO public.products VALUES (10, 2.05, 22, NULL, 603, 2, NULL, NULL, 'YELLOW EASTER EGG HUNT START POST', '21459');
INSERT INTO public.products VALUES (10, 2.15, 22, NULL, 604, 2, NULL, NULL, 'GREEN EASTER EGG HUNT START POST', '21460');
INSERT INTO public.products VALUES (10, 2.43, 22, NULL, 605, 2, NULL, NULL, 'BLUE EASTER EGG HUNT START POST', '21461');
INSERT INTO public.products VALUES (19, 6.41, 21, NULL, 606, 2, NULL, NULL, 'NURSERY A,B,C PAINTED LETTERS', '21462');
INSERT INTO public.products VALUES (60, 5.79, 22, NULL, 607, 2, NULL, NULL, 'MIRRORED DISCO BALL ', '21463');
INSERT INTO public.products VALUES (24, 4.25, 22, NULL, 608, 2, NULL, NULL, 'DISCO BALL ROTATOR BATTERY OPERATED', '21464');
INSERT INTO public.products VALUES (23, 3.93, 22, NULL, 609, 2, NULL, NULL, 'PINK FLOWER CROCHET FOOD COVER', '21465');
INSERT INTO public.products VALUES (30, 3.90, 22, NULL, 610, 2, NULL, NULL, 'RED FLOWER CROCHET FOOD COVER', '21466');
INSERT INTO public.products VALUES (26, 3.99, 22, NULL, 611, 2, NULL, NULL, 'CHERRY CROCHET FOOD COVER', '21467');
INSERT INTO public.products VALUES (14, 4.01, 22, NULL, 612, 2, NULL, NULL, 'BUTTERFLY CROCHET FOOD COVER', '21468');
INSERT INTO public.products VALUES (28, 3.84, 22, NULL, 613, 2, NULL, NULL, 'POLKA DOT RAFFIA FOOD COVER', '21469');
INSERT INTO public.products VALUES (37, 4.10, 22, NULL, 614, 2, NULL, NULL, 'FLOWER VINE RAFFIA FOOD COVER', '21470');
INSERT INTO public.products VALUES (63, 3.67, 22, NULL, 615, 2, NULL, NULL, 'STRAWBERRY RAFFIA FOOD COVER', '21471');
INSERT INTO public.products VALUES (12, 4.16, 22, NULL, 616, 2, NULL, NULL, 'LADYBIRD + BEE RAFFIA FOOD COVER', '21472');
INSERT INTO public.products VALUES (10, 23.76, 22, NULL, 617, 2, NULL, NULL, 'SWEETHEART CREAM STEEL TABLE RECT', '21473');
INSERT INTO public.products VALUES (10, 18.56, 22, NULL, 618, 2, NULL, NULL, 'STEEL SWEETHEART ROUND TABLE CREAM', '21476');
INSERT INTO public.products VALUES (448, 4.95, 14, NULL, 619, 2, NULL, NULL, 'WHITE SKULL HOT WATER BOTTLE ', '21479');
INSERT INTO public.products VALUES (322, 4.08, 14, NULL, 620, 2, NULL, NULL, 'FAWN BLUE HOT WATER BOTTLE', '21481');
INSERT INTO public.products VALUES (183, 5.14, 14, NULL, 621, 2, NULL, NULL, 'CHICK GREY HOT WATER BOTTLE', '21484');
INSERT INTO public.products VALUES (351, 5.62, 14, NULL, 622, 2, NULL, NULL, 'RETROSPOT HEART HOT WATER BOTTLE', '21485');
INSERT INTO public.products VALUES (10, 4.04, 14, NULL, 623, 2, NULL, NULL, 'PINK HEART DOTS HOT WATER BOTTLE', '21486');
INSERT INTO public.products VALUES (10, 7.61, 14, NULL, 624, 2, NULL, NULL, 'RED WHITE SCARF  HOT WATER BOTTLE', '21488');
INSERT INTO public.products VALUES (10, 1.95, 19, NULL, 625, 2, NULL, NULL, 'SET OF THREE VINTAGE GIFT WRAPS', '21491');
INSERT INTO public.products VALUES (193, 2.58, 12, NULL, 626, 2, NULL, NULL, 'ROTATING LEAVES T-LIGHT HOLDER', '21494');
INSERT INTO public.products VALUES (577, 0.42, 19, NULL, 627, 2, NULL, NULL, 'SKULLS AND CROSSBONES WRAP', '21495');
INSERT INTO public.products VALUES (860, 0.42, 19, NULL, 628, 2, NULL, NULL, 'FANCY FONTS BIRTHDAY WRAP', '21497');
INSERT INTO public.products VALUES (1050, 0.42, 19, NULL, 629, 2, NULL, NULL, 'RED RETROSPOT WRAP ', '21498');
INSERT INTO public.products VALUES (672, 0.42, 19, NULL, 630, 2, NULL, NULL, 'BLUE POLKADOT WRAP', '21499');
INSERT INTO public.products VALUES (635, 0.42, 19, NULL, 631, 2, NULL, NULL, 'PINK POLKADOT WRAP ', '21500');
INSERT INTO public.products VALUES (72, 0.42, 16, NULL, 632, 2, NULL, NULL, 'TOYBOX  WRAP ', '21503');
INSERT INTO public.products VALUES (191, 0.48, 16, NULL, 633, 2, NULL, NULL, 'SKULLS GREETING CARD', '21504');
INSERT INTO public.products VALUES (494, 0.51, 19, NULL, 634, 2, NULL, NULL, 'FANCY FONT BIRTHDAY CARD, ', '21506');
INSERT INTO public.products VALUES (330, 0.53, 19, NULL, 635, 2, NULL, NULL, 'ELEPHANT, BIRTHDAY CARD, ', '21507');
INSERT INTO public.products VALUES (247, 0.55, 19, NULL, 636, 2, NULL, NULL, 'VINTAGE KID DOLLY CARD ', '21508');
INSERT INTO public.products VALUES (374, 0.53, 19, NULL, 637, 2, NULL, NULL, 'COWBOYS AND INDIANS BIRTHDAY CARD ', '21509');
INSERT INTO public.products VALUES (31, 0.48, 16, NULL, 638, 2, NULL, NULL, 'BANK ACCOUNT  GREETING  CARD ', '21518');
INSERT INTO public.products VALUES (318, 0.51, 16, NULL, 639, 2, NULL, NULL, 'GIN & TONIC DIET GREETING CARD ', '21519');
INSERT INTO public.products VALUES (50, 0.51, 16, NULL, 640, 2, NULL, NULL, 'BOOZE & WOMEN GREETING CARD ', '21520');
INSERT INTO public.products VALUES (324, 9.50, 22, NULL, 641, 2, NULL, NULL, 'DOORMAT FANCY FONT HOME SWEET HOME', '21523');
INSERT INTO public.products VALUES (175, 9.19, 22, NULL, 642, 2, NULL, NULL, 'DOORMAT SPOTTY HOME SWEET HOME', '21524');
INSERT INTO public.products VALUES (41, 8.36, 22, NULL, 643, 2, NULL, NULL, 'RED RETROSPOT TRADITIONAL TEAPOT ', '21527');
INSERT INTO public.products VALUES (20, 7.61, 22, NULL, 644, 2, NULL, NULL, 'DAIRY MAID TRADITIONAL TEAPOT ', '21528');
INSERT INTO public.products VALUES (71, 1.56, 22, NULL, 645, 2, NULL, NULL, 'DAIRY MAID TOASTRACK', '21530');
INSERT INTO public.products VALUES (150, 2.87, 22, NULL, 646, 2, NULL, NULL, 'RED RETROSPOT SUGAR JAM BOWL', '21531');
INSERT INTO public.products VALUES (132, 5.27, 22, NULL, 647, 2, NULL, NULL, 'RETROSPOT LARGE MILK JUG', '21533');
INSERT INTO public.products VALUES (36, 5.42, 22, NULL, 648, 2, NULL, NULL, 'DAIRY MAID LARGE MILK JUG', '21534');
INSERT INTO public.products VALUES (246, 2.74, 22, NULL, 649, 2, NULL, NULL, 'RED RETROSPOT SMALL MILK JUG', '21535');
INSERT INTO public.products VALUES (19, 4.39, 22, NULL, 650, 2, NULL, NULL, 'RED RETROSPOT PUDDING BOWL', '21537');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 651, 2, NULL, NULL, 'DAIRY MAID  PUDDING BOWL', '21538');
INSERT INTO public.products VALUES (84, 5.37, 22, NULL, 652, 2, NULL, NULL, 'RED RETROSPOT BUTTER DISH', '21539');
INSERT INTO public.products VALUES (197, 1.11, 22, NULL, 653, 2, NULL, NULL, 'SKULLS  WATER TRANSFER TATTOOS ', '21544');
INSERT INTO public.products VALUES (10, 3.71, 22, NULL, 654, 2, NULL, NULL, 'CERAMIC BIRDHOUSE CRESTED TIT SMALL', '21547');
INSERT INTO public.products VALUES (13, 2.59, 22, NULL, 655, 2, NULL, NULL, 'CERAMIC STRAWBERRY TRINKET TRAY', '21555');
INSERT INTO public.products VALUES (98, 3.25, 16, NULL, 656, 2, NULL, NULL, 'CERAMIC STRAWBERRY MONEY BOX', '21556');
INSERT INTO public.products VALUES (55, 4.16, 22, NULL, 657, 2, NULL, NULL, 'SET OF 6 FUNKY BEAKERS', '21557');
INSERT INTO public.products VALUES (213, 3.36, 16, NULL, 658, 2, NULL, NULL, 'SKULL LUNCH BOX WITH CUTLERY ', '21558');
INSERT INTO public.products VALUES (392, 3.10, 16, NULL, 659, 2, NULL, NULL, 'STRAWBERRY LUNCH BOX WITH CUTLERY', '21559');
INSERT INTO public.products VALUES (128, 3.02, 16, NULL, 660, 2, NULL, NULL, 'DINOSAUR LUNCH BOX WITH CUTLERY', '21561');
INSERT INTO public.products VALUES (32, 1.44, 22, NULL, 661, 2, NULL, NULL, 'HAWAIIAN GRASS SKIRT ', '21562');
INSERT INTO public.products VALUES (139, 3.20, 22, NULL, 662, 2, NULL, NULL, 'RED HEART SHAPE LOVE BUCKET ', '21563');
INSERT INTO public.products VALUES (103, 3.20, 22, NULL, 663, 2, NULL, NULL, 'PINK  HEART SHAPE LOVE BUCKET ', '21564');
INSERT INTO public.products VALUES (25, 2.59, 13, NULL, 664, 2, NULL, NULL, 'LETS GO SHOPPING COTTON TOTE BAG', '21576');
INSERT INTO public.products VALUES (71, 2.71, 13, NULL, 665, 2, NULL, NULL, 'SAVE THE PLANET COTTON TOTE BAG', '21577');
INSERT INTO public.products VALUES (51, 2.54, 13, NULL, 666, 2, NULL, NULL, 'WOODLAND DESIGN  COTTON TOTE BAG', '21578');
INSERT INTO public.products VALUES (16, 2.54, 13, NULL, 667, 2, NULL, NULL, 'LOLITA  DESIGN  COTTON TOTE BAG', '21579');
INSERT INTO public.products VALUES (18, 2.89, 13, NULL, 668, 2, NULL, NULL, 'RABBIT  DESIGN  COTTON TOTE BAG', '21580');
INSERT INTO public.products VALUES (24, 2.88, 13, NULL, 669, 2, NULL, NULL, 'SKULLS  DESIGN  COTTON TOTE BAG', '21581');
INSERT INTO public.products VALUES (106, 1.65, 22, NULL, 670, 2, NULL, NULL, 'RETROSPOT SMALL TUBE MATCHES', '21584');
INSERT INTO public.products VALUES (73, 2.50, 22, NULL, 671, 2, NULL, NULL, 'KINGS CHOICE GIANT TUBE MATCHES', '21586');
INSERT INTO public.products VALUES (19, 2.53, 22, NULL, 672, 2, NULL, NULL, 'COSY HOUR GIANT TUBE MATCHES', '21587');
INSERT INTO public.products VALUES (149, 2.53, 22, NULL, 673, 2, NULL, NULL, 'RETROSPOT GIANT TUBE MATCHES', '21588');
INSERT INTO public.products VALUES (105, 1.25, 16, NULL, 674, 2, NULL, NULL, 'COSY HOUR CIGAR BOX MATCHES ', '21591');
INSERT INTO public.products VALUES (216, 1.13, 16, NULL, 675, 2, NULL, NULL, 'RETROSPOT CIGAR BOX MATCHES ', '21592');
INSERT INTO public.products VALUES (10, 4.17, 22, NULL, 676, 2, NULL, NULL, 'Dr. Jam''s Arouzer Stress Ball', '21594');
INSERT INTO public.products VALUES (10, 8.47, 22, NULL, 677, 2, NULL, NULL, 'Dad''s Cab Electronic Meter', '21595');
INSERT INTO public.products VALUES (76, 3.04, 12, NULL, 678, 2, NULL, NULL, 'SET 12 LAVENDER  BOTANICAL T-LIGHTS', '21609');
INSERT INTO public.products VALUES (22, 3.15, 12, NULL, 679, 2, NULL, NULL, 'S/12 VANILLA  BOTANICAL T-LIGHTS', '21613');
INSERT INTO public.products VALUES (10, 3.27, 12, NULL, 680, 2, NULL, NULL, 'SET OF 12 ROSE BOTANICAL T-LIGHTS', '21614');
INSERT INTO public.products VALUES (86, 2.00, 12, NULL, 681, 2, NULL, NULL, '4 LAVENDER BOTANICAL DINNER CANDLES', '21615');
INSERT INTO public.products VALUES (82, 1.96, 12, NULL, 682, 2, NULL, NULL, '4 PEAR BOTANICAL DINNER CANDLES', '21616');
INSERT INTO public.products VALUES (52, 2.42, 12, NULL, 683, 2, NULL, NULL, '4 LILY  BOTANICAL DINNER CANDLES', '21617');
INSERT INTO public.products VALUES (35, 2.43, 12, NULL, 684, 2, NULL, NULL, '4 WILDFLOWER BOTANICAL CANDLES', '21618');
INSERT INTO public.products VALUES (88, 1.96, 12, NULL, 685, 2, NULL, NULL, '4 VANILLA BOTANICAL CANDLES', '21619');
INSERT INTO public.products VALUES (10, 2.02, 12, NULL, 686, 2, NULL, NULL, 'SET OF 4 ROSE BOTANICAL CANDLES', '21620');
INSERT INTO public.products VALUES (236, 9.38, 16, NULL, 687, 2, NULL, NULL, 'VINTAGE UNION JACK BUNTING', '21621');
INSERT INTO public.products VALUES (10, 5.67, 22, NULL, 688, 2, NULL, NULL, 'VINTAGE UNION JACK CUSHION COVER', '21622');
INSERT INTO public.products VALUES (326, 10.36, 22, NULL, 689, 2, NULL, NULL, 'VINTAGE UNION JACK MEMOBOARD', '21623');
INSERT INTO public.products VALUES (21, 6.62, 22, NULL, 690, 2, NULL, NULL, 'VINTAGE UNION JACK DOORSTOP', '21624');
INSERT INTO public.products VALUES (41, 8.04, 22, NULL, 691, 2, NULL, NULL, 'VINTAGE UNION JACK APRON', '21625');
INSERT INTO public.products VALUES (77, 2.26, 22, NULL, 692, 2, NULL, NULL, 'VINTAGE UNION JACK PENNANT', '21626');
INSERT INTO public.products VALUES (10, 21.50, 22, NULL, 693, 2, NULL, NULL, 'ELEPHANT CARNIVAL POUFFE', '21627');
INSERT INTO public.products VALUES (10, 21.36, 22, NULL, 694, 2, NULL, NULL, 'TRIANGULAR POUFFE VINTAGE ', '21628');
INSERT INTO public.products VALUES (10, 10.40, 22, NULL, 695, 2, NULL, NULL, 'SQUARE FLOOR CUSHION VINTAGE RED', '21629');
INSERT INTO public.products VALUES (10, 12.01, 22, NULL, 696, 2, NULL, NULL, 'FLOOR CUSHION ELEPHANT CARNIVAL', '21630');
INSERT INTO public.products VALUES (16, 8.34, 22, NULL, 697, 2, NULL, NULL, 'HIPPY CHIC DECORATIVE PARASOL', '21631');
INSERT INTO public.products VALUES (10, 8.20, 22, NULL, 698, 2, NULL, NULL, 'VINTAGE PINK DECORATIVE PARASOL', '21632');
INSERT INTO public.products VALUES (12, 10.22, 22, NULL, 699, 2, NULL, NULL, 'SUNFLOWER DECORATIVE PARASOL', '21633');
INSERT INTO public.products VALUES (97, 0.84, 22, NULL, 700, 2, NULL, NULL, 'ASSORTED MINI MADRAS NOTEBOOK', '21634');
INSERT INTO public.products VALUES (27, 2.26, 22, NULL, 701, 2, NULL, NULL, 'MADRAS NOTEBOOK LARGE ', '21635');
INSERT INTO public.products VALUES (89, 0.84, 22, NULL, 702, 2, NULL, NULL, 'MADRAS NOTEBOOK MEDIUM', '21636');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 703, 2, NULL, NULL, 'ASSORTED SANSKRIT MINI NOTEBOOK', '21637');
INSERT INTO public.products VALUES (24, 2.56, 22, NULL, 704, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI NOTEBOOK', '21638');
INSERT INTO public.products VALUES (66, 1.14, 22, NULL, 705, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI  FOB NOTEBOOK', '21640');
INSERT INTO public.products VALUES (115, 1.10, 22, NULL, 706, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI KEYRING BALL', '21641');
INSERT INTO public.products VALUES (221, 0.49, 22, NULL, 707, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI PEN', '21642');
INSERT INTO public.products VALUES (52, 1.80, 22, NULL, 708, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI MIRROR', '21643');
INSERT INTO public.products VALUES (36, 1.18, 16, NULL, 709, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI HEART BOX', '21644');
INSERT INTO public.products VALUES (10, 1.65, 16, NULL, 710, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI ROUND BOX', '21645');
INSERT INTO public.products VALUES (11, 2.10, 13, NULL, 711, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI LARGE PURSE', '21647');
INSERT INTO public.products VALUES (73, 1.85, 13, NULL, 712, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI SMALL PURSE', '21648');
INSERT INTO public.products VALUES (252, 0.50, 22, NULL, 713, 2, NULL, NULL, 'ASSORTED TUTTI FRUTTI BRACELET', '21650');
INSERT INTO public.products VALUES (13, 1.76, 12, NULL, 714, 2, NULL, NULL, 'HANGING GLASS ETCHED TEALIGHT', '21651');
INSERT INTO public.products VALUES (98, 0.93, 14, NULL, 715, 2, NULL, NULL, 'RIDGED GLASS FINGER BOWL', '21654');
INSERT INTO public.products VALUES (10, 1.69, 12, NULL, 716, 2, NULL, NULL, 'HANGING RIDGE GLASS T-LIGHT HOLDER', '21655');
INSERT INTO public.products VALUES (20, 2.16, 14, NULL, 717, 2, NULL, NULL, 'RIDGED GLASS POSY VASE ', '21656');
INSERT INTO public.products VALUES (10, 7.83, 14, NULL, 718, 2, NULL, NULL, 'MILK BOTTLE WITH GLASS STOPPER ', '21657');
INSERT INTO public.products VALUES (84, 5.44, 14, NULL, 719, 2, NULL, NULL, 'GLASS  BEURRE DISH', '21658');
INSERT INTO public.products VALUES (10, 5.95, 14, NULL, 720, 2, NULL, NULL, 'VINTAGE GLASS TEA CADDY', '21661');
INSERT INTO public.products VALUES (522, 0.42, 19, NULL, 1581, 2, NULL, NULL, 'WRAP RED APPLES ', '22704');
INSERT INTO public.products VALUES (10, 8.16, 14, NULL, 721, 2, NULL, NULL, 'VINTAGE GLASS COFFEE CADDY', '21662');
INSERT INTO public.products VALUES (10, 3.73, 14, NULL, 722, 2, NULL, NULL, 'RIDGED GLASS STORAGE JAR CREAM LID', '21664');
INSERT INTO public.products VALUES (41, 0.86, 12, NULL, 723, 2, NULL, NULL, 'RIDGED GLASS T-LIGHT HOLDER', '21666');
INSERT INTO public.products VALUES (10, 14.95, 14, NULL, 724, 2, NULL, NULL, 'GLASS CAKE COVER AND PLATE', '21667');
INSERT INTO public.products VALUES (544, 1.66, 22, NULL, 725, 2, NULL, NULL, 'RED STRIPE CERAMIC DRAWER KNOB', '21668');
INSERT INTO public.products VALUES (520, 1.59, 22, NULL, 726, 2, NULL, NULL, 'BLUE STRIPE CERAMIC DRAWER KNOB', '21669');
INSERT INTO public.products VALUES (430, 1.69, 22, NULL, 727, 2, NULL, NULL, 'BLUE SPOT CERAMIC DRAWER KNOB', '21670');
INSERT INTO public.products VALUES (426, 1.71, 22, NULL, 728, 2, NULL, NULL, 'RED SPOT CERAMIC DRAWER KNOB', '21671');
INSERT INTO public.products VALUES (496, 1.68, 22, NULL, 729, 2, NULL, NULL, 'WHITE SPOT RED CERAMIC DRAWER KNOB', '21672');
INSERT INTO public.products VALUES (429, 1.67, 22, NULL, 730, 2, NULL, NULL, 'WHITE SPOT BLUE CERAMIC DRAWER KNOB', '21673');
INSERT INTO public.products VALUES (62, 1.13, 22, NULL, 731, 2, NULL, NULL, 'BUTTERFLIES STICKERS', '21675');
INSERT INTO public.products VALUES (25, 1.16, 22, NULL, 732, 2, NULL, NULL, 'FLOWERS  STICKERS', '21676');
INSERT INTO public.products VALUES (82, 1.03, 22, NULL, 733, 2, NULL, NULL, 'HEARTS  STICKERS', '21677');
INSERT INTO public.products VALUES (12, 1.01, 22, NULL, 734, 2, NULL, NULL, 'PAISLEY PATTERN  STICKERS', '21678');
INSERT INTO public.products VALUES (114, 1.13, 22, NULL, 735, 2, NULL, NULL, 'SKULLS  STICKERS', '21679');
INSERT INTO public.products VALUES (86, 1.21, 22, NULL, 736, 2, NULL, NULL, 'WOODLAND  STICKERS', '21680');
INSERT INTO public.products VALUES (10, 9.95, 22, NULL, 737, 2, NULL, NULL, 'GIANT MEDINA STAMPED METAL BOWL ', '21681');
INSERT INTO public.products VALUES (10, 5.39, 22, NULL, 738, 2, NULL, NULL, 'LARGE MEDINA STAMPED METAL BOWL ', '21682');
INSERT INTO public.products VALUES (31, 3.39, 22, NULL, 739, 2, NULL, NULL, 'MEDIUM MEDINA STAMPED METAL BOWL ', '21683');
INSERT INTO public.products VALUES (78, 1.25, 22, NULL, 740, 2, NULL, NULL, 'SMALL MEDINA STAMPED METAL BOWL ', '21684');
INSERT INTO public.products VALUES (10, 39.87, 22, NULL, 741, 2, NULL, NULL, 'MEDINA STAMPED METAL STOOL', '21686');
INSERT INTO public.products VALUES (10, 3.74, 12, NULL, 742, 2, NULL, NULL, 'SILVER PLATE CANDLE BOWL SMALL', '21688');
INSERT INTO public.products VALUES (10, 4.12, 12, NULL, 743, 2, NULL, NULL, 'SILVER VANILLA  FLOWER CANDLE POT', '21689');
INSERT INTO public.products VALUES (10, 3.75, 12, NULL, 744, 2, NULL, NULL, 'SILVER  CANDLEPOT JARDIN ', '21690');
INSERT INTO public.products VALUES (10, 3.75, 12, NULL, 745, 2, NULL, NULL, 'SILVER LATTICE VANILLA CANDLE POT', '21692');
INSERT INTO public.products VALUES (28, 3.27, 12, NULL, 746, 2, NULL, NULL, 'SMALL HAMMERED SILVER CANDLEPOT ', '21693');
INSERT INTO public.products VALUES (30, 3.40, 12, NULL, 747, 2, NULL, NULL, 'SMALL REGAL  SILVER CANDLEPOT ', '21694');
INSERT INTO public.products VALUES (29, 3.36, 12, NULL, 748, 2, NULL, NULL, 'SMALL SILVER FLOWER CANDLE POT', '21695');
INSERT INTO public.products VALUES (21, 3.28, 12, NULL, 749, 2, NULL, NULL, 'SMALL SILVER TRELLIS CANDLEPOT', '21696');
INSERT INTO public.products VALUES (29, 1.06, 22, NULL, 750, 2, NULL, NULL, 'MOCK LOBSTER FRIDGE MAGNET', '21698');
INSERT INTO public.products VALUES (51, 3.90, 22, NULL, 751, 2, NULL, NULL, 'BIG DOUGHNUT FRIDGE MAGNETS', '21700');
INSERT INTO public.products VALUES (930, 0.49, 13, NULL, 752, 2, NULL, NULL, 'BAG 125g SWIRLY MARBLES', '21703');
INSERT INTO public.products VALUES (513, 1.00, 13, NULL, 753, 2, NULL, NULL, 'BAG 250g SWIRLY MARBLES', '21704');
INSERT INTO public.products VALUES (143, 1.83, 13, NULL, 754, 2, NULL, NULL, 'BAG 500g SWIRLY MARBLES', '21705');
INSERT INTO public.products VALUES (34, 5.00, 22, NULL, 755, 2, NULL, NULL, 'FOLDING UMBRELLA RED/WHITE POLKADOT', '21706');
INSERT INTO public.products VALUES (16, 4.88, 22, NULL, 756, 2, NULL, NULL, 'FOLDING UMBRELLA BLACKBLUE POLKADOT', '21707');
INSERT INTO public.products VALUES (19, 4.34, 22, NULL, 757, 2, NULL, NULL, 'FOLDING UMBRELLA CREAM POLKADOT', '21708');
INSERT INTO public.products VALUES (13, 4.67, 22, NULL, 758, 2, NULL, NULL, 'FOLDING UMBRELLA CHOCOLATE POLKADOT', '21709');
INSERT INTO public.products VALUES (10, 4.82, 22, NULL, 759, 2, NULL, NULL, 'FOLDING UMBRELLA PINKWHITE POLKADOT', '21710');
INSERT INTO public.products VALUES (10, 5.25, 22, NULL, 760, 2, NULL, NULL, 'FOLDING UMBRELLA WHITE/RED POLKADOT', '21711');
INSERT INTO public.products VALUES (77, 2.49, 12, NULL, 761, 2, NULL, NULL, 'CITRONELLA CANDLE FLOWERPOT', '21713');
INSERT INTO public.products VALUES (163, 1.88, 12, NULL, 762, 2, NULL, NULL, 'CITRONELLA CANDLE GARDEN POT', '21714');
INSERT INTO public.products VALUES (133, 3.26, 16, NULL, 763, 2, NULL, NULL, 'GIRLS VINTAGE TIN SEASIDE BUCKET', '21715');
INSERT INTO public.products VALUES (143, 3.38, 16, NULL, 764, 2, NULL, NULL, 'BOYS VINTAGE TIN SEASIDE BUCKET', '21716');
INSERT INTO public.products VALUES (40, 2.68, 16, NULL, 765, 2, NULL, NULL, 'EASTER TIN BUCKET', '21717');
INSERT INTO public.products VALUES (149, 1.70, 22, NULL, 766, 2, NULL, NULL, 'RED METAL BEACH SPADE ', '21718');
INSERT INTO public.products VALUES (34, 1.06, 22, NULL, 767, 2, NULL, NULL, 'LOVELY BONBON STICKER SHEET', '21719');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 768, 2, NULL, NULL, 'CAKE SHOP  STICKER SHEET', '21720');
INSERT INTO public.products VALUES (19, 1.10, 22, NULL, 769, 2, NULL, NULL, 'CANDY SHOP  STICKER SHEET', '21721');
INSERT INTO public.products VALUES (10, 1.12, 22, NULL, 770, 2, NULL, NULL, 'SWEET PUDDING STICKER SHEET', '21722');
INSERT INTO public.products VALUES (40, 1.02, 22, NULL, 771, 2, NULL, NULL, 'ALPHABET HEARTS STICKER SHEET', '21723');
INSERT INTO public.products VALUES (40, 0.97, 22, NULL, 772, 2, NULL, NULL, 'PANDA AND BUNNIES STICKER SHEET', '21724');
INSERT INTO public.products VALUES (30, 1.13, 22, NULL, 773, 2, NULL, NULL, 'SWEETIES  STICKERS', '21725');
INSERT INTO public.products VALUES (23, 0.93, 22, NULL, 774, 2, NULL, NULL, 'MULTI HEARTS  STICKERS', '21726');
INSERT INTO public.products VALUES (50, 5.32, 12, NULL, 775, 2, NULL, NULL, 'GLASS STAR FROSTED T-LIGHT HOLDER', '21730');
INSERT INTO public.products VALUES (1382, 2.37, 12, NULL, 776, 2, NULL, NULL, 'RED TOADSTOOL LED NIGHT LIGHT', '21731');
INSERT INTO public.products VALUES (782, 3.15, 12, NULL, 777, 2, NULL, NULL, 'RED HANGING HEART T-LIGHT HOLDER', '21733');
INSERT INTO public.products VALUES (12, 12.38, 22, NULL, 778, 2, NULL, NULL, 'TWO DOOR CURIO CABINET', '21735');
INSERT INTO public.products VALUES (11, 1.41, 12, NULL, 779, 2, NULL, NULL, 'GOLD SCROLL GLASS T-LIGHT HOLDER', '21736');
INSERT INTO public.products VALUES (10, 3.31, 22, NULL, 780, 2, NULL, NULL, 'COSY SLIPPER SHOES SMALL  RED ', '21738');
INSERT INTO public.products VALUES (25, 2.77, 22, NULL, 781, 2, NULL, NULL, 'COSY SLIPPER SHOES SMALL GREEN', '21739');
INSERT INTO public.products VALUES (14, 3.82, 22, NULL, 782, 2, NULL, NULL, 'COSY SLIPPER SHOES LARGE GREEN', '21741');
INSERT INTO public.products VALUES (19, 6.09, 22, NULL, 783, 2, NULL, NULL, 'LARGE ROUND WICKER PLATTER ', '21742');
INSERT INTO public.products VALUES (29, 3.82, 12, NULL, 784, 2, NULL, NULL, 'STAR PORTABLE TABLE LIGHT ', '21743');
INSERT INTO public.products VALUES (51, 3.02, 12, NULL, 785, 2, NULL, NULL, 'SNOWFLAKE PORTABLE TABLE LIGHT ', '21744');
INSERT INTO public.products VALUES (93, 3.96, 22, NULL, 786, 2, NULL, NULL, 'GAOLERS KEYS DECORATIVE GARDEN ', '21745');
INSERT INTO public.products VALUES (306, 1.47, 22, NULL, 787, 2, NULL, NULL, 'SMALL RED RETROSPOT WINDMILL', '21746');
INSERT INTO public.products VALUES (47, 1.51, 22, NULL, 788, 2, NULL, NULL, 'SMALL SKULL WINDMILL', '21747');
INSERT INTO public.products VALUES (195, 2.52, 22, NULL, 789, 2, NULL, NULL, 'LARGE RED RETROSPOT WINDMILL', '21749');
INSERT INTO public.products VALUES (10, 2.67, 22, NULL, 790, 2, NULL, NULL, 'LARGE SKULL WINDMILL', '21750');
INSERT INTO public.products VALUES (276, 6.61, 22, NULL, 791, 2, NULL, NULL, 'HOME BUILDING BLOCK WORD', '21754');
INSERT INTO public.products VALUES (203, 6.67, 22, NULL, 792, 2, NULL, NULL, 'LOVE BUILDING BLOCK WORD', '21755');
INSERT INTO public.products VALUES (82, 6.59, 22, NULL, 793, 2, NULL, NULL, 'BATH BUILDING BLOCK WORD', '21756');
INSERT INTO public.products VALUES (10, 4.95, 12, NULL, 794, 2, NULL, NULL, 'LIGHTHOUSE PRINTED METAL SIGN', '21757');
INSERT INTO public.products VALUES (10, 9.84, 22, NULL, 795, 2, NULL, NULL, 'VINTAGE SHELLS PRINT', '21758');
INSERT INTO public.products VALUES (10, 27.23, 14, NULL, 796, 2, NULL, NULL, 'WOOD AND GLASS MEDICINE CABINET', '21761');
INSERT INTO public.products VALUES (10, 27.46, 22, NULL, 797, 2, NULL, NULL, 'VINTAGE WOODEN BAR STOOL', '21763');
INSERT INTO public.products VALUES (10, 44.24, 22, NULL, 798, 2, NULL, NULL, 'VINTAGE POST OFFICE CABINET', '21769');
INSERT INTO public.products VALUES (163, 5.52, 21, NULL, 799, 2, NULL, NULL, 'OPEN CLOSED METAL SIGN', '21770');
INSERT INTO public.products VALUES (117, 1.77, 14, NULL, 800, 2, NULL, NULL, 'DECORATIVE ROSE BATHROOM BOTTLE', '21773');
INSERT INTO public.products VALUES (109, 1.92, 14, NULL, 801, 2, NULL, NULL, 'DECORATIVE CATS BATHROOM BOTTLE', '21774');
INSERT INTO public.products VALUES (51, 1.87, 14, NULL, 802, 2, NULL, NULL, 'DECORATIVE FLORE BATHROOM BOTTLE', '21775');
INSERT INTO public.products VALUES (10, 7.95, 16, NULL, 803, 2, NULL, NULL, 'RECIPE BOX WITH METAL HEART', '21777');
INSERT INTO public.products VALUES (10, 16.47, 16, NULL, 804, 2, NULL, NULL, 'MA CAMPAGNE CUTLERY BOX', '21781');
INSERT INTO public.products VALUES (10, 11.41, 16, NULL, 805, 2, NULL, NULL, 'SHOE SHINE BOX ', '21784');
INSERT INTO public.products VALUES (41, 0.95, 22, NULL, 806, 2, NULL, NULL, 'RAIN PONCHO ', '21785');
INSERT INTO public.products VALUES (185, 0.66, 22, NULL, 807, 2, NULL, NULL, 'POLKADOT RAIN HAT ', '21786');
INSERT INTO public.products VALUES (835, 1.05, 22, NULL, 808, 2, NULL, NULL, 'RAIN PONCHO RETROSPOT', '21787');
INSERT INTO public.products VALUES (127, 0.90, 22, NULL, 809, 2, NULL, NULL, 'KIDS RAIN MAC BLUE', '21788');
INSERT INTO public.products VALUES (90, 0.94, 22, NULL, 810, 2, NULL, NULL, 'KIDS RAIN MAC PINK', '21789');
INSERT INTO public.products VALUES (1444, 1.01, 19, NULL, 811, 2, NULL, NULL, 'VINTAGE SNAP CARDS', '21790');
INSERT INTO public.products VALUES (785, 1.50, 19, NULL, 812, 2, NULL, NULL, 'VINTAGE HEADS AND TAILS CARD GAME ', '21791');
INSERT INTO public.products VALUES (33, 5.05, 16, NULL, 813, 2, NULL, NULL, 'CLASSIC FRENCH STYLE BASKET GREEN ', '21792');
INSERT INTO public.products VALUES (26, 4.52, 16, NULL, 814, 2, NULL, NULL, 'CLASSIC FRENCH STYLE BASKET BROWN', '21793');
INSERT INTO public.products VALUES (52, 4.87, 16, NULL, 815, 2, NULL, NULL, 'CLASSIC FRENCH STYLE BASKET NATURAL', '21794');
INSERT INTO public.products VALUES (121, 0.42, 17, NULL, 816, 2, NULL, NULL, 'CHRISTMAS TREE DECORATION WITH BELL', '21801');
INSERT INTO public.products VALUES (212, 0.45, 17, NULL, 817, 2, NULL, NULL, 'CHRISTMAS TREE HEART DECORATION', '21802');
INSERT INTO public.products VALUES (235, 0.45, 17, NULL, 818, 2, NULL, NULL, 'CHRISTMAS TREE STAR DECORATION', '21803');
INSERT INTO public.products VALUES (30, 3.61, 17, NULL, 819, 2, NULL, NULL, 'WHITE CHRISTMAS GARLAND STARS TREES', '21804');
INSERT INTO public.products VALUES (43, 0.47, 17, NULL, 820, 2, NULL, NULL, 'WHITE CHRISTMAS STAR DECORATION', '21807');
INSERT INTO public.products VALUES (18, 3.54, 17, NULL, 821, 2, NULL, NULL, 'CHRISTMAS GARLAND STARS,TREES', '21808');
INSERT INTO public.products VALUES (196, 0.95, 17, NULL, 822, 2, NULL, NULL, 'CHRISTMAS HANGING TREE WITH BELL', '21809');
INSERT INTO public.products VALUES (575, 0.74, 17, NULL, 823, 2, NULL, NULL, 'CHRISTMAS HANGING STAR WITH BELL', '21810');
INSERT INTO public.products VALUES (459, 0.99, 17, NULL, 824, 2, NULL, NULL, 'CHRISTMAS HANGING HEART WITH BELL', '21811');
INSERT INTO public.products VALUES (38, 5.17, 22, NULL, 825, 2, NULL, NULL, 'GARLAND WITH HEARTS AND BELLS', '21812');
INSERT INTO public.products VALUES (54, 4.67, 22, NULL, 826, 2, NULL, NULL, 'GARLAND WITH STARS AND BELLS', '21813');
INSERT INTO public.products VALUES (10, 1.70, 12, NULL, 827, 2, NULL, NULL, 'HEART T-LIGHT HOLDER ', '21814');
INSERT INTO public.products VALUES (10, 1.93, 12, NULL, 828, 2, NULL, NULL, 'STAR  T-LIGHT HOLDER ', '21815');
INSERT INTO public.products VALUES (10, 1.45, 12, NULL, 829, 2, NULL, NULL, 'CHRISTMAS TREE T-LIGHT HOLDER', '21816');
INSERT INTO public.products VALUES (90, 0.55, 17, NULL, 830, 2, NULL, NULL, 'GLITTER CHRISTMAS TREE', '21817');
INSERT INTO public.products VALUES (261, 0.60, 17, NULL, 831, 2, NULL, NULL, 'GLITTER CHRISTMAS HEART ', '21818');
INSERT INTO public.products VALUES (245, 0.54, 17, NULL, 832, 2, NULL, NULL, 'GLITTER CHRISTMAS STAR ', '21819');
INSERT INTO public.products VALUES (30, 4.96, 22, NULL, 833, 2, NULL, NULL, 'GLITTER HEART GARLAND WITH BELLS ', '21820');
INSERT INTO public.products VALUES (23, 5.05, 22, NULL, 834, 2, NULL, NULL, 'GLITTER STAR GARLAND WITH BELLS ', '21821');
INSERT INTO public.products VALUES (73, 1.31, 17, NULL, 835, 2, NULL, NULL, 'GLITTER CHRISTMAS TREE WITH BELLS', '21822');
INSERT INTO public.products VALUES (128, 0.91, 22, NULL, 836, 2, NULL, NULL, 'PAINTED METAL HEART WITH HOLLY BELL', '21823');
INSERT INTO public.products VALUES (179, 0.77, 22, NULL, 837, 2, NULL, NULL, 'PAINTED METAL STAR WITH HOLLY BELLS', '21824');
INSERT INTO public.products VALUES (12, 1.67, 22, NULL, 838, 2, NULL, NULL, 'EIGHT PIECE DINOSAUR SET', '21826');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 839, 2, NULL, NULL, 'EIGHT PIECE CREEPY CRAWLIE SET', '21827');
INSERT INTO public.products VALUES (33, 1.47, 22, NULL, 840, 2, NULL, NULL, 'EIGHT PIECE SNAKE  SET', '21828');
INSERT INTO public.products VALUES (444, 0.26, 22, NULL, 841, 2, NULL, NULL, 'DINOSAUR KEYRINGS ASSORTED', '21829');
INSERT INTO public.products VALUES (115, 0.45, 22, NULL, 842, 2, NULL, NULL, 'ASSORTED CREEPY CRAWLIES', '21830');
INSERT INTO public.products VALUES (93, 2.33, 22, NULL, 843, 2, NULL, NULL, 'CHOCOLATE CALCULATOR', '21832');
INSERT INTO public.products VALUES (258, 2.09, 22, NULL, 844, 2, NULL, NULL, 'CAMOUFLAGE LED TORCH', '21833');
INSERT INTO public.products VALUES (10, 5.04, 22, NULL, 845, 2, NULL, NULL, 'GINGHAM OVEN GLOVE RED HEART ', '21836');
INSERT INTO public.products VALUES (10, 5.45, 19, NULL, 846, 2, NULL, NULL, 'MUMMY MOUSE RED GINGHAM RIBBON', '21839');
INSERT INTO public.products VALUES (10, 4.25, 22, NULL, 847, 2, NULL, NULL, 'BABY MOUSE RED GINGHAM DRESS', '21841');
INSERT INTO public.products VALUES (162, 12.44, 22, NULL, 848, 2, NULL, NULL, 'RED RETROSPOT CAKE STAND', '21843');
INSERT INTO public.products VALUES (182, 3.28, 14, NULL, 849, 2, NULL, NULL, 'RED RETROSPOT MUG', '21844');
INSERT INTO public.products VALUES (185, 1.12, 14, NULL, 850, 2, NULL, NULL, 'DAIRY MAID STRIPE MUG', '21845');
INSERT INTO public.products VALUES (41, 4.10, 16, NULL, 851, 2, NULL, NULL, 'PINK DIAMANTE PEN IN GIFT BOX', '21846');
INSERT INTO public.products VALUES (10, 2.75, 16, NULL, 852, 2, NULL, NULL, 'GREEN  DIAMANTE PEN IN GIFT BOX', '21847');
INSERT INTO public.products VALUES (17, 3.82, 16, NULL, 853, 2, NULL, NULL, 'SILVER DIAMANTE PEN IN GIFT BOX', '21849');
INSERT INTO public.products VALUES (10, 4.31, 16, NULL, 854, 2, NULL, NULL, 'BLUE  DIAMANTE PEN IN GIFT BOX', '21850');
INSERT INTO public.products VALUES (14, 4.15, 16, NULL, 855, 2, NULL, NULL, 'LILAC DIAMANTE PEN IN GIFT BOX', '21851');
INSERT INTO public.products VALUES (80, 2.86, 22, NULL, 856, 2, NULL, NULL, 'UNION JACK FLAG PASSPORT COVER ', '21864');
INSERT INTO public.products VALUES (27, 2.56, 22, NULL, 857, 2, NULL, NULL, 'PINK UNION JACK  PASSPORT COVER ', '21865');
INSERT INTO public.products VALUES (75, 1.95, 22, NULL, 858, 2, NULL, NULL, 'UNION JACK FLAG LUGGAGE TAG', '21866');
INSERT INTO public.products VALUES (35, 1.56, 22, NULL, 859, 2, NULL, NULL, 'PINK UNION JACK  LUGGAGE TAG', '21867');
INSERT INTO public.products VALUES (236, 1.72, 14, NULL, 860, 2, NULL, NULL, 'POTTING SHED TEA MUG', '21868');
INSERT INTO public.products VALUES (138, 1.57, 14, NULL, 861, 2, NULL, NULL, 'I CAN ONLY PLEASE ONE PERSON MUG', '21870');
INSERT INTO public.products VALUES (476, 1.80, 14, NULL, 862, 2, NULL, NULL, 'SAVE THE PLANET MUG', '21871');
INSERT INTO public.products VALUES (128, 1.65, 14, NULL, 863, 2, NULL, NULL, 'GLAMOROUS  MUG', '21872');
INSERT INTO public.products VALUES (153, 1.59, 14, NULL, 864, 2, NULL, NULL, 'IF YOU CAN''T STAND THE HEAT MUG', '21873');
INSERT INTO public.products VALUES (295, 1.99, 14, NULL, 865, 2, NULL, NULL, 'GIN AND TONIC MUG', '21874');
INSERT INTO public.products VALUES (202, 1.82, 14, NULL, 866, 2, NULL, NULL, 'KINGS CHOICE MUG', '21875');
INSERT INTO public.products VALUES (375, 2.07, 14, NULL, 867, 2, NULL, NULL, 'POTTERING MUG', '21876');
INSERT INTO public.products VALUES (436, 1.70, 14, NULL, 868, 2, NULL, NULL, 'HOME SWEET HOME MUG', '21877');
INSERT INTO public.products VALUES (251, 1.09, 22, NULL, 869, 2, NULL, NULL, 'PACK OF 6 SANDCASTLE FLAGS ASSORTED', '21878');
INSERT INTO public.products VALUES (117, 0.59, 22, NULL, 870, 2, NULL, NULL, 'HEARTS GIFT TAPE', '21879');
INSERT INTO public.products VALUES (189, 0.48, 22, NULL, 871, 2, NULL, NULL, 'RED RETROSPOT TAPE', '21880');
INSERT INTO public.products VALUES (110, 0.68, 22, NULL, 872, 2, NULL, NULL, 'CUTE CATS TAPE', '21881');
INSERT INTO public.products VALUES (70, 0.64, 22, NULL, 873, 2, NULL, NULL, 'SKULLS TAPE', '21882');
INSERT INTO public.products VALUES (165, 0.64, 22, NULL, 874, 2, NULL, NULL, 'STARS GIFT TAPE ', '21883');
INSERT INTO public.products VALUES (116, 0.76, 22, NULL, 875, 2, NULL, NULL, 'CAKES AND BOWS GIFT  TAPE', '21884');
INSERT INTO public.products VALUES (162, 4.66, 22, NULL, 876, 2, NULL, NULL, 'BINGO SET', '21888');
INSERT INTO public.products VALUES (637, 1.57, 16, NULL, 877, 2, NULL, NULL, 'WOODEN BOX OF DOMINOES', '21889');
INSERT INTO public.products VALUES (100, 3.81, 13, NULL, 878, 2, NULL, NULL, 'S/6 WOODEN SKITTLES IN COTTON BAG', '21890');
INSERT INTO public.products VALUES (810, 1.58, 22, NULL, 879, 2, NULL, NULL, 'TRADITIONAL WOODEN SKIPPING ROPE', '21891');
INSERT INTO public.products VALUES (318, 1.60, 14, NULL, 880, 2, NULL, NULL, 'TRADITIONAL WOODEN CATCH CUP GAME ', '21892');
INSERT INTO public.products VALUES (59, 1.82, 16, NULL, 881, 2, NULL, NULL, 'POTTING SHED SEED ENVELOPES', '21894');
INSERT INTO public.products VALUES (10, 6.36, 16, NULL, 882, 2, NULL, NULL, 'POTTING SHED SOW ''N'' GROW SET', '21895');
INSERT INTO public.products VALUES (97, 2.40, 16, NULL, 883, 2, NULL, NULL, 'POTTING SHED TWINE', '21896');
INSERT INTO public.products VALUES (40, 3.85, 12, NULL, 884, 2, NULL, NULL, 'POTTING SHED CANDLE CITRONELLA', '21897');
INSERT INTO public.products VALUES (49, 2.62, 12, NULL, 885, 2, NULL, NULL, 'POTTING SHED ROSE CANDLE', '21898');
INSERT INTO public.products VALUES (264, 0.87, 21, NULL, 886, 2, NULL, NULL, 'KEY FOB , GARAGE DESIGN', '21899');
INSERT INTO public.products VALUES (323, 0.94, 22, NULL, 887, 2, NULL, NULL, 'KEY FOB , SHED', '21900');
INSERT INTO public.products VALUES (182, 0.89, 22, NULL, 888, 2, NULL, NULL, 'KEY FOB , BACK DOOR ', '21901');
INSERT INTO public.products VALUES (196, 0.88, 22, NULL, 889, 2, NULL, NULL, 'KEY FOB , FRONT  DOOR ', '21902');
INSERT INTO public.products VALUES (114, 2.50, 21, NULL, 890, 2, NULL, NULL, 'MAN FLU METAL SIGN', '21903');
INSERT INTO public.products VALUES (10, 2.10, 21, NULL, 891, 2, NULL, NULL, 'HOUSE WRECKING METAL SIGN ', '21904');
INSERT INTO public.products VALUES (76, 1.41, 21, NULL, 892, 2, NULL, NULL, 'MORE BUTTER METAL SIGN ', '21905');
INSERT INTO public.products VALUES (56, 9.56, 16, NULL, 893, 2, NULL, NULL, 'PHARMACIE FIRST AID TIN', '21906');
INSERT INTO public.products VALUES (236, 2.30, 21, NULL, 894, 2, NULL, NULL, 'I''M ON HOLIDAY METAL SIGN', '21907');
INSERT INTO public.products VALUES (374, 2.53, 21, NULL, 895, 2, NULL, NULL, 'CHOCOLATE THIS WAY METAL SIGN', '21908');
INSERT INTO public.products VALUES (10, 1.65, 21, NULL, 896, 2, NULL, NULL, 'WAY OUT METAL SIGN ', '21910');
INSERT INTO public.products VALUES (10, 2.15, 21, NULL, 897, 2, NULL, NULL, 'GARDEN METAL SIGN ', '21911');
INSERT INTO public.products VALUES (179, 4.91, 22, NULL, 898, 2, NULL, NULL, 'VINTAGE SNAKES & LADDERS', '21912');
INSERT INTO public.products VALUES (39, 4.36, 22, NULL, 899, 2, NULL, NULL, 'VINTAGE SEASIDE JIGSAW PUZZLES', '21913');
INSERT INTO public.products VALUES (784, 1.43, 16, NULL, 900, 2, NULL, NULL, 'BLUE HARMONICA IN BOX ', '21914');
INSERT INTO public.products VALUES (2206, 1.42, 16, NULL, 901, 2, NULL, NULL, 'RED  HARMONICA IN BOX ', '21915');
INSERT INTO public.products VALUES (457, 0.55, 22, NULL, 902, 2, NULL, NULL, 'SET 12 RETRO WHITE CHALK STICKS', '21916');
INSERT INTO public.products VALUES (414, 0.50, 22, NULL, 903, 2, NULL, NULL, 'SET 12 KIDS  WHITE CHALK STICKS', '21917');
INSERT INTO public.products VALUES (718, 0.52, 22, NULL, 904, 2, NULL, NULL, 'SET 12 KIDS COLOUR  CHALK STICKS', '21918');
INSERT INTO public.products VALUES (90, 9.14, 22, NULL, 905, 2, NULL, NULL, 'UNION STRIPE WITH FRINGE  HAMMOCK', '21922');
INSERT INTO public.products VALUES (39, 1.25, 22, NULL, 906, 2, NULL, NULL, 'UNION STRIPE CUSHION COVER ', '21925');
INSERT INTO public.products VALUES (40, 1.25, 22, NULL, 907, 2, NULL, NULL, 'RED/CREAM STRIPE CUSHION COVER ', '21926');
INSERT INTO public.products VALUES (58, 1.25, 22, NULL, 908, 2, NULL, NULL, 'BLUE/CREAM STRIPE CUSHION COVER ', '21927');
INSERT INTO public.products VALUES (1020, 2.68, 13, NULL, 909, 2, NULL, NULL, 'JUMBO BAG SCANDINAVIAN PAISLEY', '21928');
INSERT INTO public.products VALUES (1078, 2.67, 13, NULL, 910, 2, NULL, NULL, 'JUMBO BAG PINK VINTAGE PAISLEY', '21929');
INSERT INTO public.products VALUES (644, 2.78, 13, NULL, 911, 2, NULL, NULL, 'JUMBO STORAGE BAG SKULLS', '21930');
INSERT INTO public.products VALUES (1332, 2.73, 13, NULL, 912, 2, NULL, NULL, 'JUMBO STORAGE BAG SUKI', '21931');
INSERT INTO public.products VALUES (269, 2.07, 13, NULL, 913, 2, NULL, NULL, 'SCANDINAVIAN PAISLEY PICNIC BAG', '21932');
INSERT INTO public.products VALUES (266, 2.06, 13, NULL, 914, 2, NULL, NULL, 'PINK VINTAGE PAISLEY PICNIC BAG', '21933');
INSERT INTO public.products VALUES (241, 2.14, 13, NULL, 915, 2, NULL, NULL, 'SKULL SHOULDER BAG', '21934');
INSERT INTO public.products VALUES (339, 2.34, 13, NULL, 916, 2, NULL, NULL, 'SUKI  SHOULDER BAG', '21935');
INSERT INTO public.products VALUES (393, 3.69, 13, NULL, 917, 2, NULL, NULL, 'RED RETROSPOT PICNIC BAG', '21936');
INSERT INTO public.products VALUES (158, 3.37, 13, NULL, 918, 2, NULL, NULL, 'STRAWBERRY   PICNIC BAG', '21937');
INSERT INTO public.products VALUES (27, 1.33, 21, NULL, 919, 2, NULL, NULL, 'SKULLS DESIGN FLANNEL', '21942');
INSERT INTO public.products VALUES (11, 1.29, 21, NULL, 920, 2, NULL, NULL, 'CAKES AND RABBITS DESIGN FLANNEL ', '21943');
INSERT INTO public.products VALUES (33, 1.19, 21, NULL, 921, 2, NULL, NULL, 'KITTENS DESIGN FLANNEL', '21944');
INSERT INTO public.products VALUES (35, 1.31, 21, NULL, 922, 2, NULL, NULL, 'STRAWBERRIES  DESIGN FLANNEL ', '21945');
INSERT INTO public.products VALUES (10, 1.01, 21, NULL, 923, 2, NULL, NULL, 'PARTY TIME DESIGN FLANNEL', '21946');
INSERT INTO public.products VALUES (81, 1.69, 22, NULL, 924, 2, NULL, NULL, 'SET OF 6 HEART CHOPSTICKS', '21947');
INSERT INTO public.products VALUES (64, 1.90, 22, NULL, 925, 2, NULL, NULL, 'SET OF 6 CAKE CHOPSTICKS', '21948');
INSERT INTO public.products VALUES (80, 1.81, 22, NULL, 926, 2, NULL, NULL, 'SET OF 6 STRAWBERRY CHOPSTICKS', '21949');
INSERT INTO public.products VALUES (123, 9.16, 22, NULL, 927, 2, NULL, NULL, 'DOORMAT UNION JACK GUNS AND ROSES', '21955');
INSERT INTO public.products VALUES (527, 0.44, 22, NULL, 928, 2, NULL, NULL, 'PACK OF 12 SKULL TISSUES', '21967');
INSERT INTO public.products VALUES (33, 1.68, 22, NULL, 929, 2, NULL, NULL, 'SET OF 36 DINOSAUR PAPER DOILIES', '21972');
INSERT INTO public.products VALUES (15, 1.45, 22, NULL, 930, 2, NULL, NULL, 'SET OF 36 MUSHROOM PAPER DOILIES', '21973');
INSERT INTO public.products VALUES (215, 2.13, 22, NULL, 931, 2, NULL, NULL, 'SET OF 36 PAISLEY FLOWER DOILIES', '21974');
INSERT INTO public.products VALUES (1226, 0.62, 22, NULL, 932, 2, NULL, NULL, 'PACK OF 60 DINOSAUR CAKE CASES', '21975');
INSERT INTO public.products VALUES (520, 0.83, 22, NULL, 933, 2, NULL, NULL, 'PACK OF 60 MUSHROOM CAKE CASES', '21976');
INSERT INTO public.products VALUES (2475, 0.74, 22, NULL, 934, 2, NULL, NULL, 'PACK OF 60 PINK PAISLEY CAKE CASES', '21977');
INSERT INTO public.products VALUES (655, 0.40, 22, NULL, 935, 2, NULL, NULL, 'PACK OF 12 RED RETROSPOT TISSUES ', '21980');
INSERT INTO public.products VALUES (547, 0.48, 22, NULL, 936, 2, NULL, NULL, 'PACK OF 12 WOODLAND TISSUES ', '21981');
INSERT INTO public.products VALUES (761, 0.47, 22, NULL, 937, 2, NULL, NULL, 'PACK OF 12 SUKI TISSUES ', '21982');
INSERT INTO public.products VALUES (227, 0.45, 22, NULL, 938, 2, NULL, NULL, 'PACK OF 12 BLUE PAISLEY TISSUES ', '21983');
INSERT INTO public.products VALUES (341, 0.47, 22, NULL, 939, 2, NULL, NULL, 'PACK OF 12 PINK PAISLEY TISSUES ', '21984');
INSERT INTO public.products VALUES (880, 0.42, 21, NULL, 940, 2, NULL, NULL, 'PACK OF 12 HEARTS DESIGN TISSUES ', '21985');
INSERT INTO public.products VALUES (406, 0.43, 22, NULL, 941, 2, NULL, NULL, 'PACK OF 12 PINK POLKADOT TISSUES', '21986');
INSERT INTO public.products VALUES (210, 0.77, 14, NULL, 942, 2, NULL, NULL, 'PACK OF 6 SKULL PAPER CUPS', '21987');
INSERT INTO public.products VALUES (232, 1.02, 22, NULL, 943, 2, NULL, NULL, 'PACK OF 6 SKULL PAPER PLATES', '21988');
INSERT INTO public.products VALUES (241, 1.15, 22, NULL, 944, 2, NULL, NULL, 'PACK OF 20 SKULL PAPER NAPKINS', '21989');
INSERT INTO public.products VALUES (166, 1.99, 22, NULL, 945, 2, NULL, NULL, 'MODERN FLORAL STATIONERY SET', '21990');
INSERT INTO public.products VALUES (62, 2.00, 22, NULL, 946, 2, NULL, NULL, 'BOHEMIAN COLLAGE STATIONERY SET', '21991');
INSERT INTO public.products VALUES (192, 2.05, 22, NULL, 947, 2, NULL, NULL, 'VINTAGE PAISLEY STATIONERY SET', '21992');
INSERT INTO public.products VALUES (193, 2.01, 22, NULL, 948, 2, NULL, NULL, 'FLORAL FOLK STATIONERY SET', '21993');
INSERT INTO public.products VALUES (10, 83.33, 22, NULL, 949, 2, NULL, NULL, 'Dotcomgiftshop Gift Voucher £100.00', '22016');
INSERT INTO public.products VALUES (36, 1.74, 16, NULL, 950, 2, NULL, NULL, 'BLUE FELT EASTER EGG BASKET', '22021');
INSERT INTO public.products VALUES (120, 0.60, 19, NULL, 951, 2, NULL, NULL, 'EMPIRE BIRTHDAY CARD', '22023');
INSERT INTO public.products VALUES (241, 0.59, 19, NULL, 952, 2, NULL, NULL, 'RAINY LADIES BIRTHDAY CARD', '22024');
INSERT INTO public.products VALUES (180, 0.55, 19, NULL, 953, 2, NULL, NULL, 'RING OF ROSES BIRTHDAY CARD', '22025');
INSERT INTO public.products VALUES (164, 0.57, 19, NULL, 954, 2, NULL, NULL, 'BANQUET BIRTHDAY  CARD  ', '22026');
INSERT INTO public.products VALUES (422, 0.53, 19, NULL, 955, 2, NULL, NULL, 'TEA PARTY BIRTHDAY CARD', '22027');
INSERT INTO public.products VALUES (304, 0.54, 19, NULL, 956, 2, NULL, NULL, 'PENNY FARTHING BIRTHDAY CARD', '22028');
INSERT INTO public.products VALUES (817, 0.52, 19, NULL, 957, 2, NULL, NULL, 'SPACEBOY BIRTHDAY CARD', '22029');
INSERT INTO public.products VALUES (491, 0.46, 16, NULL, 958, 2, NULL, NULL, 'SWALLOWS GREETING CARD', '22030');
INSERT INTO public.products VALUES (49, 0.52, 19, NULL, 959, 2, NULL, NULL, 'BOTANICAL LAVENDER BIRTHDAY CARD', '22031');
INSERT INTO public.products VALUES (42, 0.45, 16, NULL, 960, 2, NULL, NULL, 'BOTANICAL LILY GREETING CARD', '22032');
INSERT INTO public.products VALUES (33, 0.44, 16, NULL, 961, 2, NULL, NULL, 'BOTANICAL ROSE GREETING CARD', '22033');
INSERT INTO public.products VALUES (10, 0.58, 17, NULL, 962, 2, NULL, NULL, 'ROBIN CHRISTMAS CARD', '22034');
INSERT INTO public.products VALUES (150, 0.57, 16, NULL, 963, 2, NULL, NULL, 'VINTAGE CARAVAN GREETING CARD ', '22035');
INSERT INTO public.products VALUES (397, 0.53, 19, NULL, 964, 2, NULL, NULL, 'ROBOT BIRTHDAY CARD', '22037');
INSERT INTO public.products VALUES (47, 0.42, 19, NULL, 965, 2, NULL, NULL, 'BOTANICAL LAVENDER GIFT WRAP ', '22038');
INSERT INTO public.products VALUES (22, 0.42, 19, NULL, 966, 2, NULL, NULL, 'BOTANICAL LILY GIFT WRAP', '22039');
INSERT INTO public.products VALUES (72, 0.42, 19, NULL, 967, 2, NULL, NULL, 'BOTANICAL ROSE GIFT WRAP', '22040');
INSERT INTO public.products VALUES (433, 3.66, 15, NULL, 968, 2, NULL, NULL, 'RECORD FRAME 7" SINGLE SIZE ', '22041');
INSERT INTO public.products VALUES (39, 0.43, 17, NULL, 969, 2, NULL, NULL, 'CHRISTMAS CARD SINGING ANGEL', '22042');
INSERT INTO public.products VALUES (118, 0.29, 17, NULL, 970, 2, NULL, NULL, 'CHRISTMAS CARD SCREEN PRINT ', '22043');
INSERT INTO public.products VALUES (81, 0.26, 17, NULL, 971, 2, NULL, NULL, 'CHRISTMAS CARD STACK OF PRESENTS', '22044');
INSERT INTO public.products VALUES (647, 0.42, 19, NULL, 972, 2, NULL, NULL, 'SPACEBOY GIFT WRAP', '22045');
INSERT INTO public.products VALUES (221, 0.42, 19, NULL, 973, 2, NULL, NULL, 'TEA PARTY  WRAPPING PAPER ', '22046');
INSERT INTO public.products VALUES (340, 0.42, 19, NULL, 974, 2, NULL, NULL, 'EMPIRE GIFT WRAP', '22047');
INSERT INTO public.products VALUES (95, 0.42, 19, NULL, 975, 2, NULL, NULL, 'BIRTHDAY BANQUET GIFT WRAP', '22048');
INSERT INTO public.products VALUES (95, 0.27, 17, NULL, 976, 2, NULL, NULL, 'WRAP CHRISTMAS SCREEN PRINT', '22049');
INSERT INTO public.products VALUES (120, 0.42, 19, NULL, 977, 2, NULL, NULL, 'PINK PAISLEY ROSE GIFT WRAP', '22050');
INSERT INTO public.products VALUES (70, 0.41, 19, NULL, 978, 2, NULL, NULL, 'BLUE SCANDINAVIAN PAISLEY WRAP', '22051');
INSERT INTO public.products VALUES (60, 0.42, 19, NULL, 979, 2, NULL, NULL, 'VINTAGE CARAVAN GIFT WRAP', '22052');
INSERT INTO public.products VALUES (424, 1.23, 21, NULL, 980, 2, NULL, NULL, 'EMPIRE DESIGN ROSETTE', '22053');
INSERT INTO public.products VALUES (135, 2.06, 22, NULL, 981, 2, NULL, NULL, 'MINI CAKE STAND  HANGING STRAWBERY', '22055');
INSERT INTO public.products VALUES (53, 1.42, 21, NULL, 982, 2, NULL, NULL, 'CERAMIC PLATE STRAWBERRY DESIGN', '22057');
INSERT INTO public.products VALUES (176, 1.60, 14, NULL, 983, 2, NULL, NULL, 'CERAMIC STRAWBERRY DESIGN MUG', '22059');
INSERT INTO public.products VALUES (21, 5.33, 22, NULL, 984, 2, NULL, NULL, 'LARGE CAKE STAND HANGING HEARTS', '22060');
INSERT INTO public.products VALUES (56, 10.20, 22, NULL, 985, 2, NULL, NULL, 'LARGE CAKE STAND  HANGING STRAWBERY', '22061');
INSERT INTO public.products VALUES (61, 1.54, 21, NULL, 986, 2, NULL, NULL, 'CERAMIC BOWL WITH LOVE HEART DESIGN', '22062');
INSERT INTO public.products VALUES (58, 3.61, 21, NULL, 987, 2, NULL, NULL, 'CERAMIC BOWL WITH STRAWBERRY DESIGN', '22063');
INSERT INTO public.products VALUES (169, 2.10, 22, NULL, 988, 2, NULL, NULL, 'PINK DOUGHNUT TRINKET POT ', '22064');
INSERT INTO public.products VALUES (674, 1.05, 17, NULL, 989, 2, NULL, NULL, 'CHRISTMAS PUDDING TRINKET POT ', '22065');
INSERT INTO public.products VALUES (225, 0.67, 22, NULL, 990, 2, NULL, NULL, 'LOVE HEART TRINKET POT', '22066');
INSERT INTO public.products VALUES (40, 2.04, 22, NULL, 991, 2, NULL, NULL, 'CHOC TRUFFLE GOLD TRINKET POT ', '22067');
INSERT INTO public.products VALUES (51, 2.35, 22, NULL, 992, 2, NULL, NULL, 'BLACK PIRATE TREASURE CHEST', '22068');
INSERT INTO public.products VALUES (41, 3.19, 22, NULL, 993, 2, NULL, NULL, 'BROWN  PIRATE TREASURE CHEST ', '22069');
INSERT INTO public.products VALUES (65, 4.16, 14, NULL, 994, 2, NULL, NULL, 'SMALL RED RETROSPOT MUG IN BOX ', '22070');
INSERT INTO public.products VALUES (44, 3.80, 14, NULL, 995, 2, NULL, NULL, 'SMALL WHITE RETROSPOT MUG IN BOX ', '22071');
INSERT INTO public.products VALUES (83, 3.94, 14, NULL, 996, 2, NULL, NULL, 'RED RETROSPOT TEA CUP AND SAUCER ', '22072');
INSERT INTO public.products VALUES (32, 4.91, 16, NULL, 997, 2, NULL, NULL, 'RED RETROSPOT STORAGE JAR', '22073');
INSERT INTO public.products VALUES (139, 1.40, 19, NULL, 998, 2, NULL, NULL, '6 RIBBONS SHIMMERING PINKS ', '22074');
INSERT INTO public.products VALUES (178, 1.77, 17, NULL, 999, 2, NULL, NULL, '6 RIBBONS ELEGANT CHRISTMAS ', '22075');
INSERT INTO public.products VALUES (126, 1.61, 19, NULL, 1000, 2, NULL, NULL, '6 RIBBONS EMPIRE  ', '22076');
INSERT INTO public.products VALUES (914, 2.20, 19, NULL, 1001, 2, NULL, NULL, '6 RIBBONS RUSTIC CHARM', '22077');
INSERT INTO public.products VALUES (138, 2.62, 19, NULL, 1002, 2, NULL, NULL, 'RIBBON REEL LACE DESIGN ', '22078');
INSERT INTO public.products VALUES (188, 2.03, 19, NULL, 1003, 2, NULL, NULL, 'RIBBON REEL HEARTS DESIGN ', '22079');
INSERT INTO public.products VALUES (121, 1.97, 19, NULL, 1004, 2, NULL, NULL, 'RIBBON REEL POLKADOTS ', '22080');
INSERT INTO public.products VALUES (64, 2.30, 19, NULL, 1005, 2, NULL, NULL, 'RIBBON REEL FLORA + FAUNA ', '22081');
INSERT INTO public.products VALUES (269, 1.97, 19, NULL, 1006, 2, NULL, NULL, 'RIBBON REEL STRIPES DESIGN ', '22082');
INSERT INTO public.products VALUES (460, 3.75, 22, NULL, 1007, 2, NULL, NULL, 'PAPER CHAIN KIT RETROSPOT', '22083');
INSERT INTO public.products VALUES (514, 3.27, 22, NULL, 1008, 2, NULL, NULL, 'PAPER CHAIN KIT EMPIRE', '22084');
INSERT INTO public.products VALUES (54, 3.18, 22, NULL, 1009, 2, NULL, NULL, 'PAPER CHAIN KIT SKULLS ', '22085');
INSERT INTO public.products VALUES (1890, 3.35, 17, NULL, 1010, 2, NULL, NULL, 'PAPER CHAIN KIT 50''S CHRISTMAS ', '22086');
INSERT INTO public.products VALUES (401, 3.37, 16, NULL, 1011, 2, NULL, NULL, 'PAPER BUNTING WHITE LACE', '22087');
INSERT INTO public.products VALUES (183, 3.58, 16, NULL, 1012, 2, NULL, NULL, 'PAPER BUNTING COLOURED LACE', '22088');
INSERT INTO public.products VALUES (144, 3.49, 16, NULL, 1013, 2, NULL, NULL, 'PAPER BUNTING VINTAGE PAISLEY', '22089');
INSERT INTO public.products VALUES (751, 3.77, 16, NULL, 1014, 2, NULL, NULL, 'PAPER BUNTING RETROSPOT', '22090');
INSERT INTO public.products VALUES (198, 0.94, 16, NULL, 1015, 2, NULL, NULL, 'EMPIRE TISSUE BOX', '22091');
INSERT INTO public.products VALUES (67, 0.57, 16, NULL, 1016, 2, NULL, NULL, 'BLUE PAISLEY TISSUE BOX', '22092');
INSERT INTO public.products VALUES (182, 0.60, 16, NULL, 1017, 2, NULL, NULL, 'MOTORING TISSUE BOX', '22093');
INSERT INTO public.products VALUES (210, 1.04, 16, NULL, 1018, 2, NULL, NULL, 'RED RETROSPOT TISSUE BOX', '22094');
INSERT INTO public.products VALUES (164, 1.14, 16, NULL, 1019, 2, NULL, NULL, 'LADS ONLY TISSUE BOX', '22095');
INSERT INTO public.products VALUES (136, 0.64, 16, NULL, 1020, 2, NULL, NULL, 'PINK PAISLEY SQUARE TISSUE BOX ', '22096');
INSERT INTO public.products VALUES (160, 0.68, 16, NULL, 1021, 2, NULL, NULL, 'SWALLOW SQUARE TISSUE BOX', '22097');
INSERT INTO public.products VALUES (191, 0.95, 16, NULL, 1022, 2, NULL, NULL, 'BOUDOIR SQUARE TISSUE BOX', '22098');
INSERT INTO public.products VALUES (143, 0.95, 16, NULL, 1023, 2, NULL, NULL, 'CARAVAN SQUARE TISSUE BOX', '22099');
INSERT INTO public.products VALUES (75, 1.18, 16, NULL, 1024, 2, NULL, NULL, 'SKULLS SQUARE TISSUE BOX', '22100');
INSERT INTO public.products VALUES (111, 2.24, 22, NULL, 1025, 2, NULL, NULL, 'MIRROR MOSAIC VOTIVE HOLDER', '22101');
INSERT INTO public.products VALUES (90, 2.00, 12, NULL, 1026, 2, NULL, NULL, 'MIRROR MOSAIC T-LIGHT HOLDER ', '22102');
INSERT INTO public.products VALUES (77, 1.99, 12, NULL, 1027, 2, NULL, NULL, 'MIRROR MOSAIC T-LIGHT HOLDER ROUND', '22103');
INSERT INTO public.products VALUES (28, 1.58, 12, NULL, 1028, 2, NULL, NULL, 'MIRROR MOSAIC CANDLE PLATE', '22104');
INSERT INTO public.products VALUES (33, 3.89, 12, NULL, 1029, 2, NULL, NULL, 'MIRROR MOSAIC GOBLET CANDLE HOLDER', '22105');
INSERT INTO public.products VALUES (22, 5.09, 22, NULL, 1030, 2, NULL, NULL, 'MIRROR MOSAIC HURRICANE LAMP ', '22106');
INSERT INTO public.products VALUES (57, 4.20, 16, NULL, 1031, 2, NULL, NULL, 'PIZZA PLATE IN BOX', '22107');
INSERT INTO public.products VALUES (15, 3.11, 22, NULL, 1032, 2, NULL, NULL, 'PING! MICROWAVE PLATE', '22108');
INSERT INTO public.products VALUES (161, 5.44, 22, NULL, 1033, 2, NULL, NULL, 'FULL ENGLISH BREAKFAST PLATE', '22109');
INSERT INTO public.products VALUES (117, 4.04, 14, NULL, 1034, 2, NULL, NULL, 'BIRD HOUSE HOT WATER BOTTLE', '22110');
INSERT INTO public.products VALUES (453, 5.78, 14, NULL, 1035, 2, NULL, NULL, 'SCOTTIE DOG HOT WATER BOTTLE', '22111');
INSERT INTO public.products VALUES (589, 6.04, 14, NULL, 1036, 2, NULL, NULL, 'CHOCOLATE HOT WATER BOTTLE', '22112');
INSERT INTO public.products VALUES (320, 4.39, 14, NULL, 1037, 2, NULL, NULL, 'GREY HEART HOT WATER BOTTLE', '22113');
INSERT INTO public.products VALUES (566, 5.00, 14, NULL, 1038, 2, NULL, NULL, 'HOT WATER BOTTLE TEA AND SYMPATHY', '22114');
INSERT INTO public.products VALUES (154, 2.35, 21, NULL, 1039, 2, NULL, NULL, 'METAL SIGN EMPIRE TEA', '22115');
INSERT INTO public.products VALUES (56, 1.47, 21, NULL, 1040, 2, NULL, NULL, 'METAL SIGN HIS DINNER IS SERVED', '22116');
INSERT INTO public.products VALUES (150, 2.89, 21, NULL, 1041, 2, NULL, NULL, 'METAL SIGN HER DINNER IS SERVED ', '22117');
INSERT INTO public.products VALUES (23, 5.14, 21, NULL, 1042, 2, NULL, NULL, 'JOY WOODEN BLOCK LETTERS', '22118');
INSERT INTO public.products VALUES (35, 6.31, 21, NULL, 1043, 2, NULL, NULL, 'PEACE WOODEN BLOCK LETTERS', '22119');
INSERT INTO public.products VALUES (51, 10.97, 21, NULL, 1044, 2, NULL, NULL, 'WELCOME  WOODEN BLOCK LETTERS', '22120');
INSERT INTO public.products VALUES (28, 6.71, 21, NULL, 1045, 2, NULL, NULL, 'NOEL WOODEN BLOCK LETTERS ', '22121');
INSERT INTO public.products VALUES (50, 3.00, 22, NULL, 1046, 2, NULL, NULL, 'PING MICROWAVE APRON', '22123');
INSERT INTO public.products VALUES (15, 2.46, 22, NULL, 1047, 2, NULL, NULL, 'SET OF 2 TEA TOWELS PING MICROWAVE', '22124');
INSERT INTO public.products VALUES (10, 10.45, 14, NULL, 1048, 2, NULL, NULL, 'UNION JACK HOT WATER BOTTLE ', '22125');
INSERT INTO public.products VALUES (10, 2.05, 22, NULL, 1049, 2, NULL, NULL, 'PARTY CONES CARNIVAL ASSORTED', '22127');
INSERT INTO public.products VALUES (168, 1.37, 22, NULL, 1050, 2, NULL, NULL, 'PARTY CONES CANDY ASSORTED', '22128');
INSERT INTO public.products VALUES (119, 1.98, 22, NULL, 1051, 2, NULL, NULL, 'PARTY CONES CANDY TREE DECORATION', '22129');
INSERT INTO public.products VALUES (174, 1.74, 17, NULL, 1052, 2, NULL, NULL, 'PARTY CONE CHRISTMAS DECORATION ', '22130');
INSERT INTO public.products VALUES (203, 2.79, 22, NULL, 1053, 2, NULL, NULL, 'FOOD CONTAINER SET 3 LOVE HEART ', '22131');
INSERT INTO public.products VALUES (102, 1.20, 14, NULL, 1054, 2, NULL, NULL, 'RED LOVE HEART SHAPE CUP', '22132');
INSERT INTO public.products VALUES (81, 1.29, 14, NULL, 1055, 2, NULL, NULL, 'PINK LOVE HEART SHAPE CUP', '22133');
INSERT INTO public.products VALUES (89, 0.65, 22, NULL, 1056, 2, NULL, NULL, 'LADLE LOVE HEART RED ', '22134');
INSERT INTO public.products VALUES (56, 0.67, 22, NULL, 1057, 2, NULL, NULL, 'LADLE LOVE HEART PINK', '22135');
INSERT INTO public.products VALUES (37, 2.29, 22, NULL, 1058, 2, NULL, NULL, 'LOVE HEART SOCK HANGER', '22136');
INSERT INTO public.products VALUES (10, 3.12, 21, NULL, 1059, 2, NULL, NULL, 'BATHROOM SET LOVE HEART DESIGN', '22137');
INSERT INTO public.products VALUES (488, 5.33, 22, NULL, 1060, 2, NULL, NULL, 'BAKING SET 9 PIECE RETROSPOT ', '22138');
INSERT INTO public.products VALUES (450, 5.70, 22, NULL, 1061, 2, NULL, NULL, 'RETROSPOT TEA SET CERAMIC 11 PC ', '22139');
INSERT INTO public.products VALUES (278, 2.59, 17, NULL, 1062, 2, NULL, NULL, 'CHRISTMAS CRAFT TREE TOP ANGEL', '22141');
INSERT INTO public.products VALUES (318, 1.74, 17, NULL, 1063, 2, NULL, NULL, 'CHRISTMAS CRAFT WHITE FAIRY ', '22142');
INSERT INTO public.products VALUES (403, 2.57, 17, NULL, 1064, 2, NULL, NULL, 'CHRISTMAS CRAFT LITTLE FRIENDS', '22144');
INSERT INTO public.products VALUES (10, 2.10, 17, NULL, 1065, 2, NULL, NULL, 'CHRISTMAS CRAFT HEART STOCKING ', '22145');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 1066, 2, NULL, NULL, 'EASTER CRAFT IVY WREATH WITH CHICK', '22146');
INSERT INTO public.products VALUES (527, 1.63, 22, NULL, 1067, 2, NULL, NULL, 'FELTCRAFT BUTTERFLY HEARTS', '22147');
INSERT INTO public.products VALUES (192, 2.25, 22, NULL, 1068, 2, NULL, NULL, 'EASTER CRAFT 4 CHICKS ', '22148');
INSERT INTO public.products VALUES (540, 2.43, 22, NULL, 1069, 2, NULL, NULL, 'FELTCRAFT 6 FLOWER FRIENDS', '22149');
INSERT INTO public.products VALUES (301, 2.27, 22, NULL, 1070, 2, NULL, NULL, '3 STRIPEY MICE FELTCRAFT', '22150');
INSERT INTO public.products VALUES (1426, 0.57, 16, NULL, 1071, 2, NULL, NULL, 'PLACE SETTING WHITE HEART', '22151');
INSERT INTO public.products VALUES (222, 0.55, 16, NULL, 1072, 2, NULL, NULL, 'PLACE SETTING WHITE STAR', '22152');
INSERT INTO public.products VALUES (258, 0.54, 22, NULL, 1073, 2, NULL, NULL, 'ANGEL DECORATION STARS ON DRESS', '22153');
INSERT INTO public.products VALUES (374, 0.54, 22, NULL, 1074, 2, NULL, NULL, 'ANGEL DECORATION 3 BUTTONS ', '22154');
INSERT INTO public.products VALUES (240, 0.58, 22, NULL, 1075, 2, NULL, NULL, 'STAR DECORATION RUSTIC', '22155');
INSERT INTO public.products VALUES (209, 1.15, 22, NULL, 1076, 2, NULL, NULL, 'HEART DECORATION WITH PEARLS ', '22156');
INSERT INTO public.products VALUES (21, 0.85, 22, NULL, 1077, 2, NULL, NULL, 'ANGEL DECORATION WITH LACE PADDED', '22157');
INSERT INTO public.products VALUES (343, 3.33, 22, NULL, 1078, 2, NULL, NULL, '3 HEARTS HANGING DECORATION RUSTIC', '22158');
INSERT INTO public.products VALUES (506, 0.59, 22, NULL, 1079, 2, NULL, NULL, 'HEART DECORATION RUSTIC HANGING ', '22161');
INSERT INTO public.products VALUES (25, 3.19, 22, NULL, 1080, 2, NULL, NULL, 'HEART GARLAND RUSTIC PADDED', '22162');
INSERT INTO public.products VALUES (85, 1.77, 22, NULL, 1081, 2, NULL, NULL, 'HEART STRING MEMO HOLDER HANGING', '22163');
INSERT INTO public.products VALUES (10, 3.53, 19, NULL, 1082, 2, NULL, NULL, 'STRING OF STARS CARD HOLDER', '22164');
INSERT INTO public.products VALUES (41, 11.88, 22, NULL, 1083, 2, NULL, NULL, 'DIAMANTE HEART SHAPED WALL MIRROR, ', '22165');
INSERT INTO public.products VALUES (20, 11.96, 22, NULL, 1084, 2, NULL, NULL, 'WALL MIRROR RECTANGLE DIAMANTE PINK', '22166');
INSERT INTO public.products VALUES (23, 10.68, 22, NULL, 1085, 2, NULL, NULL, ' OVAL WALL MIRROR DIAMANTE ', '22167');
INSERT INTO public.products VALUES (13, 8.39, 22, NULL, 1086, 2, NULL, NULL, 'ORGANISER WOOD ANTIQUE WHITE ', '22168');
INSERT INTO public.products VALUES (116, 10.06, 15, NULL, 1087, 2, NULL, NULL, 'FAMILY ALBUM WHITE PICTURE FRAME', '22169');
INSERT INTO public.products VALUES (104, 7.72, 15, NULL, 1088, 2, NULL, NULL, 'PICTURE FRAME WOOD TRIPLE PORTRAIT', '22170');
INSERT INTO public.products VALUES (184, 9.91, 15, NULL, 1089, 2, NULL, NULL, '3 HOOK PHOTO SHELF ANTIQUE WHITE', '22171');
INSERT INTO public.products VALUES (234, 3.82, 22, NULL, 1090, 2, NULL, NULL, 'METAL 4 HOOK HANGER FRENCH CHATEAU', '22173');
INSERT INTO public.products VALUES (323, 2.58, 15, NULL, 1091, 2, NULL, NULL, 'PHOTO CUBE', '22174');
INSERT INTO public.products VALUES (87, 3.45, 20, NULL, 1092, 2, NULL, NULL, 'PINK OWL SOFT TOY', '22175');
INSERT INTO public.products VALUES (48, 3.25, 20, NULL, 1093, 2, NULL, NULL, 'BLUE OWL SOFT TOY', '22176');
INSERT INTO public.products VALUES (2385, 1.65, 12, NULL, 1094, 2, NULL, NULL, 'VICTORIAN GLASS HANGING T-LIGHT', '22178');
INSERT INTO public.products VALUES (93, 8.93, 12, NULL, 1095, 2, NULL, NULL, 'SET 10 LIGHTS NIGHT OWL', '22179');
INSERT INTO public.products VALUES (31, 11.38, 22, NULL, 1096, 2, NULL, NULL, 'RETROSPOT LAMP', '22180');
INSERT INTO public.products VALUES (47, 0.98, 15, NULL, 1097, 2, NULL, NULL, 'SNOWSTORM PHOTO FRAME FRIDGE MAGNET', '22181');
INSERT INTO public.products VALUES (37, 4.34, 22, NULL, 1098, 2, NULL, NULL, 'CAKE STAND VICTORIAN FILIGREE SMALL', '22182');
INSERT INTO public.products VALUES (32, 5.93, 22, NULL, 1099, 2, NULL, NULL, 'CAKE STAND VICTORIAN FILIGREE MED', '22183');
INSERT INTO public.products VALUES (10, 8.43, 22, NULL, 1100, 2, NULL, NULL, 'CAKE STAND VICTORIAN FILIGREE LARGE', '22184');
INSERT INTO public.products VALUES (151, 1.94, 22, NULL, 1101, 2, NULL, NULL, 'SLATE TILE NATURAL HANGING', '22185');
INSERT INTO public.products VALUES (79, 3.02, 19, NULL, 1102, 2, NULL, NULL, 'RED STAR CARD HOLDER', '22186');
INSERT INTO public.products VALUES (126, 3.93, 17, NULL, 1103, 2, NULL, NULL, 'GREEN CHRISTMAS TREE CARD HOLDER', '22187');
INSERT INTO public.products VALUES (487, 4.35, 19, NULL, 1104, 2, NULL, NULL, 'BLACK HEART CARD HOLDER', '22188');
INSERT INTO public.products VALUES (828, 4.44, 19, NULL, 1105, 2, NULL, NULL, 'CREAM HEART CARD HOLDER', '22189');
INSERT INTO public.products VALUES (67, 2.18, 14, NULL, 1106, 2, NULL, NULL, 'LOCAL CAFE MUG', '22190');
INSERT INTO public.products VALUES (110, 8.83, 18, NULL, 1107, 2, NULL, NULL, 'IVORY DINER WALL CLOCK', '22191');
INSERT INTO public.products VALUES (93, 9.03, 18, NULL, 1108, 2, NULL, NULL, 'BLUE DINER WALL CLOCK', '22192');
INSERT INTO public.products VALUES (137, 9.22, 18, NULL, 1109, 2, NULL, NULL, 'RED DINER WALL CLOCK', '22193');
INSERT INTO public.products VALUES (10, 9.76, 18, NULL, 1110, 2, NULL, NULL, 'BLACK DINER WALL CLOCK', '22194');
INSERT INTO public.products VALUES (197, 2.35, 22, NULL, 1111, 2, NULL, NULL, 'LARGE HEART MEASURING SPOONS', '22195');
INSERT INTO public.products VALUES (282, 1.22, 22, NULL, 1112, 2, NULL, NULL, 'SMALL HEART MEASURING SPOONS', '22196');
INSERT INTO public.products VALUES (5645, 1.03, 22, NULL, 1113, 2, NULL, NULL, 'SMALL POPCORN HOLDER', '22197');
INSERT INTO public.products VALUES (98, 2.14, 22, NULL, 1114, 2, NULL, NULL, 'LARGE POPCORN HOLDER ', '22198');
INSERT INTO public.products VALUES (46, 5.26, 22, NULL, 1115, 2, NULL, NULL, 'FRYING PAN RED RETROSPOT', '22199');
INSERT INTO public.products VALUES (39, 5.89, 22, NULL, 1116, 2, NULL, NULL, 'FRYING PAN PINK POLKADOT', '22200');
INSERT INTO public.products VALUES (19, 4.25, 22, NULL, 1117, 2, NULL, NULL, 'FRYING PAN BLUE POLKADOT', '22201');
INSERT INTO public.products VALUES (10, 5.49, 22, NULL, 1118, 2, NULL, NULL, 'MILK PAN PINK POLKADOT', '22202');
INSERT INTO public.products VALUES (40, 4.44, 22, NULL, 1119, 2, NULL, NULL, 'MILK PAN RED RETROSPOT', '22203');
INSERT INTO public.products VALUES (19, 3.71, 22, NULL, 1120, 2, NULL, NULL, 'MILK PAN BLUE POLKADOT', '22204');
INSERT INTO public.products VALUES (10, 0.83, 14, NULL, 1121, 2, NULL, NULL, 'MUG , DOTCOMGIFTSHOP.COM ', '22206');
INSERT INTO public.products VALUES (125, 6.13, 22, NULL, 1122, 2, NULL, NULL, 'FRYING PAN UNION FLAG', '22207');
INSERT INTO public.products VALUES (150, 1.27, 22, NULL, 1123, 2, NULL, NULL, 'WOOD STAMP SET THANK YOU', '22208');
INSERT INTO public.products VALUES (93, 1.19, 22, NULL, 1124, 2, NULL, NULL, 'WOOD STAMP SET HAPPY BIRTHDAY', '22209');
INSERT INTO public.products VALUES (101, 1.13, 22, NULL, 1125, 2, NULL, NULL, 'WOOD STAMP SET BEST WISHES', '22210');
INSERT INTO public.products VALUES (96, 1.29, 22, NULL, 1126, 2, NULL, NULL, 'WOOD STAMP SET FLOWERS', '22211');
INSERT INTO public.products VALUES (159, 2.81, 22, NULL, 1127, 2, NULL, NULL, 'FOUR HOOK  WHITE LOVEBIRDS', '22212');
INSERT INTO public.products VALUES (19, 2.63, 12, NULL, 1128, 2, NULL, NULL, 'CANDLE PLATE LACE WHITE', '22214');
INSERT INTO public.products VALUES (34, 8.51, 22, NULL, 1129, 2, NULL, NULL, 'CAKE STAND WHITE TWO TIER LACE', '22215');
INSERT INTO public.products VALUES (58, 1.12, 12, NULL, 1130, 2, NULL, NULL, 'T-LIGHT HOLDER WHITE LACE', '22216');
INSERT INTO public.products VALUES (64, 1.30, 12, NULL, 1131, 2, NULL, NULL, 'T-LIGHT HOLDER HANGING LACE', '22217');
INSERT INTO public.products VALUES (10, 4.25, 22, NULL, 1132, 2, NULL, NULL, 'CAKE STAND LACE WHITE', '22218');
INSERT INTO public.products VALUES (356, 1.18, 22, NULL, 1133, 2, NULL, NULL, 'LOVEBIRD HANGING DECORATION WHITE ', '22219');
INSERT INTO public.products VALUES (21, 9.99, 22, NULL, 1134, 2, NULL, NULL, 'CAKE STAND LOVEBIRD 2 TIER WHITE', '22220');
INSERT INTO public.products VALUES (12, 10.59, 22, NULL, 1135, 2, NULL, NULL, 'CAKE STAND LOVEBIRD 2 TIER PINK', '22221');
INSERT INTO public.products VALUES (105, 5.44, 22, NULL, 1136, 2, NULL, NULL, 'CAKE PLATE LOVEBIRD WHITE', '22222');
INSERT INTO public.products VALUES (44, 5.30, 22, NULL, 1137, 2, NULL, NULL, 'CAKE PLATE LOVEBIRD PINK', '22223');
INSERT INTO public.products VALUES (83, 3.72, 12, NULL, 1138, 2, NULL, NULL, 'WHITE LOVEBIRD LANTERN', '22224');
INSERT INTO public.products VALUES (233, 0.89, 22, NULL, 1139, 2, NULL, NULL, 'HANGING HEART MIRROR DECORATION ', '22227');
INSERT INTO public.products VALUES (99, 0.93, 22, NULL, 1140, 2, NULL, NULL, 'BUNNY WOODEN PAINTED WITH BIRD ', '22228');
INSERT INTO public.products VALUES (56, 0.93, 22, NULL, 1141, 2, NULL, NULL, 'BUNNY WOODEN PAINTED WITH FLOWER ', '22229');
INSERT INTO public.products VALUES (103, 0.79, 22, NULL, 1142, 2, NULL, NULL, 'JIGSAW TREE WITH WATERING CAN', '22230');
INSERT INTO public.products VALUES (93, 1.22, 22, NULL, 1143, 2, NULL, NULL, 'JIGSAW TREE WITH BIRDHOUSE', '22231');
INSERT INTO public.products VALUES (62, 1.07, 22, NULL, 1144, 2, NULL, NULL, 'JIGSAW TOADSTOOLS 3 PIECE', '22232');
INSERT INTO public.products VALUES (57, 1.29, 22, NULL, 1145, 2, NULL, NULL, 'JIGSAW RABBIT AND BIRDHOUSE', '22233');
INSERT INTO public.products VALUES (26, 12.51, 22, NULL, 1146, 2, NULL, NULL, 'CAKE STAND 3 TIER MAGIC GARDEN', '22236');
INSERT INTO public.products VALUES (197, 1.60, 22, NULL, 1147, 2, NULL, NULL, 'GARLAND WOODEN HAPPY EASTER', '22241');
INSERT INTO public.products VALUES (60, 1.95, 22, NULL, 1148, 2, NULL, NULL, '5 HOOK HANGER MAGIC TOADSTOOL', '22242');
INSERT INTO public.products VALUES (308, 1.92, 22, NULL, 1149, 2, NULL, NULL, '5 HOOK HANGER RED MAGIC TOADSTOOL', '22243');
INSERT INTO public.products VALUES (168, 2.78, 22, NULL, 1150, 2, NULL, NULL, '3 HOOK HANGER MAGIC GARDEN', '22244');
INSERT INTO public.products VALUES (125, 1.17, 22, NULL, 1151, 2, NULL, NULL, 'HOOK, 1 HANGER ,MAGIC GARDEN', '22245');
INSERT INTO public.products VALUES (41, 2.81, 22, NULL, 1152, 2, NULL, NULL, 'MAGIC GARDEN FELT GARLAND ', '22246');
INSERT INTO public.products VALUES (67, 1.02, 22, NULL, 1153, 2, NULL, NULL, 'BUNNY DECORATION MAGIC GARDEN', '22247');
INSERT INTO public.products VALUES (57, 1.04, 22, NULL, 1154, 2, NULL, NULL, 'DECORATION  PINK CHICK MAGIC GARDEN', '22248');
INSERT INTO public.products VALUES (94, 1.00, 22, NULL, 1155, 2, NULL, NULL, 'DECORATION WHITE CHICK MAGIC GARDEN', '22249');
INSERT INTO public.products VALUES (81, 1.05, 22, NULL, 1156, 2, NULL, NULL, 'DECORATION  BUTTERFLY  MAGIC GARDEN', '22250');
INSERT INTO public.products VALUES (69, 1.52, 22, NULL, 1157, 2, NULL, NULL, 'BIRDHOUSE DECORATION MAGIC GARDEN', '22251');
INSERT INTO public.products VALUES (64, 1.24, 12, NULL, 1158, 2, NULL, NULL, 'BIRDCAGE DECORATION TEALIGHT HOLDER', '22252');
INSERT INTO public.products VALUES (65, 1.62, 22, NULL, 1159, 2, NULL, NULL, 'FELT TOADSTOOL LARGE', '22254');
INSERT INTO public.products VALUES (62, 1.19, 22, NULL, 1160, 2, NULL, NULL, 'FELT TOADSTOOL  SMALL', '22255');
INSERT INTO public.products VALUES (29, 1.58, 22, NULL, 1161, 2, NULL, NULL, 'FELT FARM ANIMAL CHICKEN', '22256');
INSERT INTO public.products VALUES (37, 1.10, 22, NULL, 1162, 2, NULL, NULL, 'FELT FARM ANIMAL SHEEP', '22257');
INSERT INTO public.products VALUES (90, 1.32, 22, NULL, 1163, 2, NULL, NULL, 'FELT FARM ANIMAL RABBIT', '22258');
INSERT INTO public.products VALUES (48, 1.05, 22, NULL, 1164, 2, NULL, NULL, 'FELT FARM ANIMAL HEN', '22259');
INSERT INTO public.products VALUES (54, 1.27, 22, NULL, 1165, 2, NULL, NULL, 'FELT EGG COSY BLUE RABBIT ', '22260');
INSERT INTO public.products VALUES (58, 1.12, 22, NULL, 1166, 2, NULL, NULL, 'FELT EGG COSY WHITE RABBIT ', '22261');
INSERT INTO public.products VALUES (102, 1.10, 22, NULL, 1167, 2, NULL, NULL, 'FELT EGG COSY CHICKEN', '22262');
INSERT INTO public.products VALUES (27, 1.04, 22, NULL, 1168, 2, NULL, NULL, 'FELT EGG COSY LADYBIRD ', '22263');
INSERT INTO public.products VALUES (156, 1.03, 22, NULL, 1169, 2, NULL, NULL, 'FELT FARM ANIMAL WHITE BUNNY ', '22264');
INSERT INTO public.products VALUES (54, 0.78, 22, NULL, 1170, 2, NULL, NULL, 'EASTER DECORATION NATURAL CHICK', '22265');
INSERT INTO public.products VALUES (188, 0.57, 22, NULL, 1171, 2, NULL, NULL, 'EASTER DECORATION HANGING BUNNY', '22266');
INSERT INTO public.products VALUES (83, 1.09, 22, NULL, 1172, 2, NULL, NULL, 'EASTER DECORATION EGG BUNNY ', '22267');
INSERT INTO public.products VALUES (196, 0.72, 16, NULL, 1173, 2, NULL, NULL, 'EASTER DECORATION SITTING BUNNY', '22268');
INSERT INTO public.products VALUES (93, 1.04, 14, NULL, 1174, 2, NULL, NULL, 'EGG CUP NATURAL CHICKEN', '22269');
INSERT INTO public.products VALUES (23, 4.37, 22, NULL, 1175, 2, NULL, NULL, 'HAPPY EASTER HANGING DECORATION', '22270');
INSERT INTO public.products VALUES (165, 3.36, 20, NULL, 1176, 2, NULL, NULL, 'FELTCRAFT DOLL ROSIE', '22271');
INSERT INTO public.products VALUES (18, 3.00, 20, NULL, 1177, 2, NULL, NULL, 'FELTCRAFT DOLL MARIA', '22272');
INSERT INTO public.products VALUES (306, 3.25, 20, NULL, 1178, 2, NULL, NULL, 'FELTCRAFT DOLL MOLLY', '22273');
INSERT INTO public.products VALUES (134, 3.32, 20, NULL, 1179, 2, NULL, NULL, 'FELTCRAFT DOLL EMILY', '22274');
INSERT INTO public.products VALUES (10, 7.65, 13, NULL, 1180, 2, NULL, NULL, 'WEEKEND BAG VINTAGE ROSE PAISLEY', '22275');
INSERT INTO public.products VALUES (28, 3.31, 13, NULL, 1181, 2, NULL, NULL, 'WASH BAG VINTAGE ROSE PAISLEY', '22276');
INSERT INTO public.products VALUES (41, 2.61, 13, NULL, 1182, 2, NULL, NULL, 'COSMETIC BAG VINTAGE ROSE PAISLEY', '22277');
INSERT INTO public.products VALUES (40, 7.31, 13, NULL, 1183, 2, NULL, NULL, 'OVERNIGHT BAG VINTAGE ROSE PAISLEY', '22278');
INSERT INTO public.products VALUES (83, 1.41, 13, NULL, 1184, 2, NULL, NULL, 'POCKET BAG BLUE PAISLEY RED SPOT', '22279');
INSERT INTO public.products VALUES (46, 1.29, 13, NULL, 1185, 2, NULL, NULL, 'POCKET BAG PINK PAISELY BROWN SPOT', '22280');
INSERT INTO public.products VALUES (13, 7.99, 22, NULL, 1186, 2, NULL, NULL, 'EASTER TREE YELLOW BIRDS', '22281');
INSERT INTO public.products VALUES (14, 17.17, 22, NULL, 1187, 2, NULL, NULL, '12 EGG HOUSE PAINTED WOOD', '22282');
INSERT INTO public.products VALUES (29, 9.91, 22, NULL, 1188, 2, NULL, NULL, '6 EGG HOUSE PAINTED WOOD', '22283');
INSERT INTO public.products VALUES (94, 2.02, 22, NULL, 1189, 2, NULL, NULL, 'HEN HOUSE DECORATION', '22284');
INSERT INTO public.products VALUES (87, 2.04, 22, NULL, 1190, 2, NULL, NULL, 'DECORATION HEN ON NEST, HANGING', '22285');
INSERT INTO public.products VALUES (110, 1.59, 22, NULL, 1191, 2, NULL, NULL, 'DECORATION , WOBBLY RABBIT , METAL ', '22286');
INSERT INTO public.products VALUES (78, 1.52, 22, NULL, 1192, 2, NULL, NULL, 'DECORATION , WOBBLY CHICKEN, METAL ', '22287');
INSERT INTO public.products VALUES (47, 1.60, 22, NULL, 1193, 2, NULL, NULL, 'HANGING METAL RABBIT DECORATION', '22288');
INSERT INTO public.products VALUES (15, 1.48, 22, NULL, 1194, 2, NULL, NULL, 'HANGING METAL CHICKEN DECORATION', '22289');
INSERT INTO public.products VALUES (129, 1.62, 22, NULL, 1195, 2, NULL, NULL, 'HANGING CHICK CREAM DECORATION', '22291');
INSERT INTO public.products VALUES (113, 1.59, 22, NULL, 1196, 2, NULL, NULL, 'HANGING CHICK  YELLOW DECORATION', '22292');
INSERT INTO public.products VALUES (90, 1.71, 22, NULL, 1197, 2, NULL, NULL, 'HANGING CHICK GREEN DECORATION', '22293');
INSERT INTO public.products VALUES (550, 1.45, 22, NULL, 1198, 2, NULL, NULL, 'HEART FILIGREE DOVE  SMALL', '22294');
INSERT INTO public.products VALUES (279, 1.90, 22, NULL, 1199, 2, NULL, NULL, 'HEART FILIGREE DOVE LARGE', '22295');
INSERT INTO public.products VALUES (315, 1.88, 22, NULL, 1200, 2, NULL, NULL, 'HEART IVORY TRELLIS LARGE', '22296');
INSERT INTO public.products VALUES (417, 1.74, 22, NULL, 1201, 2, NULL, NULL, 'HEART IVORY TRELLIS SMALL', '22297');
INSERT INTO public.products VALUES (132, 1.71, 12, NULL, 1202, 2, NULL, NULL, 'PIG KEYRING WITH LIGHT & SOUND ', '22299');
INSERT INTO public.products VALUES (153, 3.08, 14, NULL, 1203, 2, NULL, NULL, 'COFFEE MUG DOG + BALL DESIGN', '22300');
INSERT INTO public.products VALUES (220, 3.11, 14, NULL, 1204, 2, NULL, NULL, 'COFFEE MUG CAT + BIRD DESIGN', '22301');
INSERT INTO public.products VALUES (231, 2.72, 14, NULL, 1205, 2, NULL, NULL, 'COFFEE MUG PEARS  DESIGN', '22302');
INSERT INTO public.products VALUES (274, 2.75, 14, NULL, 1206, 2, NULL, NULL, 'COFFEE MUG APPLES DESIGN', '22303');
INSERT INTO public.products VALUES (76, 3.11, 14, NULL, 1207, 2, NULL, NULL, 'COFFEE MUG BLUE PAISLEY DESIGN', '22304');
INSERT INTO public.products VALUES (69, 3.00, 14, NULL, 1208, 2, NULL, NULL, 'COFFEE MUG PINK PAISLEY DESIGN', '22305');
INSERT INTO public.products VALUES (115, 1.81, 14, NULL, 1209, 2, NULL, NULL, 'SILVER MUG BONE CHINA TREE OF LIFE', '22306');
INSERT INTO public.products VALUES (73, 2.15, 14, NULL, 1210, 2, NULL, NULL, 'GOLD MUG BONE CHINA TREE OF LIFE', '22307');
INSERT INTO public.products VALUES (25, 4.21, 22, NULL, 1211, 2, NULL, NULL, 'TEA COSY BLUE STRIPE', '22308');
INSERT INTO public.products VALUES (37, 3.73, 22, NULL, 1212, 2, NULL, NULL, 'TEA COSY RED  STRIPE', '22309');
INSERT INTO public.products VALUES (66, 2.58, 14, NULL, 1213, 2, NULL, NULL, 'IVORY KNITTED MUG COSY ', '22310');
INSERT INTO public.products VALUES (113, 4.03, 14, NULL, 1214, 2, NULL, NULL, 'OFFICE MUG WARMER BLACK+SILVER ', '22311');
INSERT INTO public.products VALUES (62, 3.59, 14, NULL, 1215, 2, NULL, NULL, 'OFFICE MUG WARMER POLKADOT', '22312');
INSERT INTO public.products VALUES (31, 3.50, 14, NULL, 1216, 2, NULL, NULL, 'OFFICE MUG WARMER PINK', '22313');
INSERT INTO public.products VALUES (56, 3.95, 14, NULL, 1217, 2, NULL, NULL, 'OFFICE MUG WARMER CHOC+BLUE', '22314');
INSERT INTO public.products VALUES (91, 1.46, 22, NULL, 1218, 2, NULL, NULL, '200 RED + WHITE BENDY STRAWS', '22315');
INSERT INTO public.products VALUES (66, 1.37, 22, NULL, 1219, 2, NULL, NULL, '200 BENDY SKULL STRAWS', '22316');
INSERT INTO public.products VALUES (28, 3.65, 22, NULL, 1220, 2, NULL, NULL, 'FIVE CATS HANGING DECORATION', '22317');
INSERT INTO public.products VALUES (45, 3.97, 22, NULL, 1221, 2, NULL, NULL, 'FIVE HEART HANGING DECORATION', '22318');
INSERT INTO public.products VALUES (134, 0.57, 22, NULL, 1222, 2, NULL, NULL, 'HAIRCLIPS FORTIES FABRIC ASSORTED', '22319');
INSERT INTO public.products VALUES (18, 6.25, 21, NULL, 1223, 2, NULL, NULL, 'BIRDS MOBILE VINTAGE DESIGN', '22320');
INSERT INTO public.products VALUES (91, 1.28, 22, NULL, 1224, 2, NULL, NULL, 'BIRD DECORATION RED RETROSPOT', '22321');
INSERT INTO public.products VALUES (80, 1.13, 22, NULL, 1225, 2, NULL, NULL, 'BIRD DECORATION GREEN POLKADOT', '22322');
INSERT INTO public.products VALUES (10, 1.95, 13, NULL, 1226, 2, NULL, NULL, 'PINK POLKADOT KIDS BAG', '22323');
INSERT INTO public.products VALUES (28, 3.44, 13, NULL, 1227, 2, NULL, NULL, 'BLUE POLKADOT KIDS BAG', '22324');
INSERT INTO public.products VALUES (23, 5.08, 22, NULL, 1228, 2, NULL, NULL, 'MOBILE VINTAGE HEARTS ', '22325');
INSERT INTO public.products VALUES (851, 3.45, 16, NULL, 1229, 2, NULL, NULL, 'ROUND SNACK BOXES SET OF4 WOODLAND ', '22326');
INSERT INTO public.products VALUES (116, 4.24, 16, NULL, 1230, 2, NULL, NULL, 'ROUND SNACK BOXES SET OF 4 SKULLS', '22327');
INSERT INTO public.products VALUES (618, 3.26, 16, NULL, 1231, 2, NULL, NULL, 'ROUND SNACK BOXES SET OF 4 FRUITS ', '22328');
INSERT INTO public.products VALUES (158, 2.06, 22, NULL, 1232, 2, NULL, NULL, 'ROUND CONTAINER SET OF 5 RETROSPOT', '22329');
INSERT INTO public.products VALUES (183, 2.00, 13, NULL, 1233, 2, NULL, NULL, 'WOODLAND PARTY BAG + STICKER SET', '22331');
INSERT INTO public.products VALUES (100, 1.79, 13, NULL, 1234, 2, NULL, NULL, 'SKULLS PARTY BAG + STICKER SET', '22332');
INSERT INTO public.products VALUES (441, 1.87, 13, NULL, 1235, 2, NULL, NULL, 'RETROSPOT PARTY BAG + STICKER SET', '22333');
INSERT INTO public.products VALUES (70, 1.79, 13, NULL, 1236, 2, NULL, NULL, 'DINOSAUR PARTY BAG + STICKER SET', '22334');
INSERT INTO public.products VALUES (238, 0.91, 22, NULL, 1237, 2, NULL, NULL, 'HEART DECORATION PAINTED ZINC ', '22335');
INSERT INTO public.products VALUES (228, 0.62, 22, NULL, 1238, 2, NULL, NULL, 'DOVE DECORATION PAINTED ZINC ', '22336');
INSERT INTO public.products VALUES (91, 0.71, 22, NULL, 1239, 2, NULL, NULL, 'ANGEL DECORATION PAINTED ZINC ', '22337');
INSERT INTO public.products VALUES (466, 0.44, 22, NULL, 1240, 2, NULL, NULL, 'STAR DECORATION PAINTED ZINC ', '22338');
INSERT INTO public.products VALUES (237, 0.43, 17, NULL, 1241, 2, NULL, NULL, 'CHRISTMAS TREE PAINTED ZINC ', '22339');
INSERT INTO public.products VALUES (139, 0.77, 22, NULL, 1242, 2, NULL, NULL, 'NOEL GARLAND PAINTED ZINC ', '22340');
INSERT INTO public.products VALUES (45, 2.47, 22, NULL, 1243, 2, NULL, NULL, 'LOVE GARLAND PAINTED ZINC ', '22341');
INSERT INTO public.products VALUES (96, 1.83, 22, NULL, 1244, 2, NULL, NULL, 'HOME GARLAND PAINTED ZINC ', '22342');
INSERT INTO public.products VALUES (195, 0.60, 22, NULL, 1245, 2, NULL, NULL, 'PARTY PIZZA DISH RED RETROSPOT', '22343');
INSERT INTO public.products VALUES (122, 0.63, 22, NULL, 1246, 2, NULL, NULL, 'PARTY PIZZA DISH PINK POLKADOT', '22344');
INSERT INTO public.products VALUES (110, 0.60, 22, NULL, 1247, 2, NULL, NULL, 'PARTY PIZZA DISH BLUE POLKADOT', '22345');
INSERT INTO public.products VALUES (103, 0.59, 22, NULL, 1248, 2, NULL, NULL, 'PARTY PIZZA DISH GREEN POLKADOT', '22346');
INSERT INTO public.products VALUES (407, 1.08, 13, NULL, 1249, 2, NULL, NULL, 'TEA BAG PLATE RED RETROSPOT', '22348');
INSERT INTO public.products VALUES (135, 4.12, 21, NULL, 1250, 2, NULL, NULL, 'DOG BOWL CHASING BALL DESIGN', '22349');
INSERT INTO public.products VALUES (141, 3.06, 22, NULL, 1251, 2, NULL, NULL, 'ILLUSTRATED CAT BOWL ', '22350');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 1252, 2, NULL, NULL, 'Given away', '22351');
INSERT INTO public.products VALUES (307, 3.30, 16, NULL, 1253, 2, NULL, NULL, 'LUNCH BOX WITH CUTLERY RETROSPOT ', '22352');
INSERT INTO public.products VALUES (10, 2.45, 16, NULL, 1254, 2, NULL, NULL, 'LUNCH BOX WITH CUTLERY FAIRY CAKES ', '22353');
INSERT INTO public.products VALUES (74, 4.54, 22, NULL, 1255, 2, NULL, NULL, 'RETROSPOT PADDED SEAT CUSHION', '22354');
INSERT INTO public.products VALUES (1800, 1.21, 13, NULL, 1256, 2, NULL, NULL, 'CHARLOTTE BAG SUKI DESIGN', '22355');
INSERT INTO public.products VALUES (945, 1.24, 13, NULL, 1257, 2, NULL, NULL, 'CHARLOTTE BAG PINK POLKADOT', '22356');
INSERT INTO public.products VALUES (46, 5.18, 16, NULL, 1258, 2, NULL, NULL, 'KINGS CHOICE BISCUIT TIN', '22357');
INSERT INTO public.products VALUES (69, 4.30, 22, NULL, 1259, 2, NULL, NULL, 'KINGS CHOICE TEA CADDY ', '22358');
INSERT INTO public.products VALUES (18, 3.47, 14, NULL, 1260, 2, NULL, NULL, 'GLASS JAR KINGS CHOICE', '22359');
INSERT INTO public.products VALUES (91, 3.78, 14, NULL, 1261, 2, NULL, NULL, 'GLASS JAR ENGLISH CONFECTIONERY', '22360');
INSERT INTO public.products VALUES (72, 4.39, 14, NULL, 1262, 2, NULL, NULL, 'GLASS JAR DAISY FRESH COTTON WOOL', '22361');
INSERT INTO public.products VALUES (38, 3.93, 14, NULL, 1263, 2, NULL, NULL, 'GLASS JAR PEACOCK BATH SALTS', '22362');
INSERT INTO public.products VALUES (35, 3.62, 14, NULL, 1264, 2, NULL, NULL, 'GLASS JAR MARMALADE ', '22363');
INSERT INTO public.products VALUES (55, 3.96, 14, NULL, 1265, 2, NULL, NULL, 'GLASS JAR DIGESTIVE BISCUITS', '22364');
INSERT INTO public.products VALUES (79, 9.74, 22, NULL, 1266, 2, NULL, NULL, 'DOORMAT RESPECTABLE HOUSE', '22365');
INSERT INTO public.products VALUES (77, 9.65, 22, NULL, 1267, 2, NULL, NULL, 'DOORMAT AIRMAIL ', '22366');
INSERT INTO public.products VALUES (372, 2.40, 21, NULL, 1268, 2, NULL, NULL, 'CHILDRENS APRON SPACEBOY DESIGN', '22367');
INSERT INTO public.products VALUES (108, 5.13, 13, NULL, 1269, 2, NULL, NULL, 'AIRLINE BAG VINTAGE TOKYO 78', '22371');
INSERT INTO public.products VALUES (28, 4.90, 13, NULL, 1270, 2, NULL, NULL, 'AIRLINE BAG VINTAGE WORLD CHAMPION ', '22372');
INSERT INTO public.products VALUES (55, 4.70, 13, NULL, 1271, 2, NULL, NULL, 'AIRLINE BAG VINTAGE JET SET RED', '22374');
INSERT INTO public.products VALUES (35, 5.12, 13, NULL, 1272, 2, NULL, NULL, 'AIRLINE BAG VINTAGE JET SET BROWN', '22375');
INSERT INTO public.products VALUES (25, 4.68, 13, NULL, 1273, 2, NULL, NULL, 'AIRLINE BAG VINTAGE JET SET WHITE', '22376');
INSERT INTO public.products VALUES (132, 2.42, 13, NULL, 1274, 2, NULL, NULL, 'BOTTLE BAG RETROSPOT ', '22377');
INSERT INTO public.products VALUES (228, 3.02, 22, NULL, 1275, 2, NULL, NULL, 'WALL TIDY RETROSPOT ', '22378');
INSERT INTO public.products VALUES (684, 3.17, 13, NULL, 1276, 2, NULL, NULL, 'RECYCLING BAG RETROSPOT ', '22379');
INSERT INTO public.products VALUES (128, 2.66, 20, NULL, 1277, 2, NULL, NULL, 'TOY TIDY SPACEBOY  ', '22380');
INSERT INTO public.products VALUES (341, 3.00, 20, NULL, 1278, 2, NULL, NULL, 'TOY TIDY PINK POLKADOT', '22381');
INSERT INTO public.products VALUES (1030, 2.00, 13, NULL, 1279, 2, NULL, NULL, 'LUNCH BAG SPACEBOY DESIGN ', '22382');
INSERT INTO public.products VALUES (1240, 2.15, 13, NULL, 1280, 2, NULL, NULL, 'LUNCH BAG SUKI  DESIGN ', '22383');
INSERT INTO public.products VALUES (1036, 2.02, 13, NULL, 1281, 2, NULL, NULL, 'LUNCH BAG PINK POLKADOT', '22384');
INSERT INTO public.products VALUES (856, 2.64, 13, NULL, 1282, 2, NULL, NULL, 'JUMBO BAG SPACEBOY DESIGN', '22385');
INSERT INTO public.products VALUES (2100, 2.59, 13, NULL, 1283, 2, NULL, NULL, 'JUMBO BAG PINK POLKADOT', '22386');
INSERT INTO public.products VALUES (23, 2.57, 22, NULL, 1284, 2, NULL, NULL, 'PAPERWEIGHT SAVE THE PLANET', '22389');
INSERT INTO public.products VALUES (26, 2.78, 22, NULL, 1285, 2, NULL, NULL, 'PAPERWEIGHT CHILDHOOD MEMORIES', '22390');
INSERT INTO public.products VALUES (15, 2.87, 22, NULL, 1286, 2, NULL, NULL, 'PAPERWEIGHT HOME SWEET HOME', '22391');
INSERT INTO public.products VALUES (50, 2.89, 22, NULL, 1287, 2, NULL, NULL, 'PAPERWEIGHT VINTAGE COLLAGE', '22393');
INSERT INTO public.products VALUES (16, 2.64, 22, NULL, 1288, 2, NULL, NULL, 'PAPERWEIGHT KINGS CHOICE ', '22394');
INSERT INTO public.products VALUES (15, 3.32, 22, NULL, 1289, 2, NULL, NULL, 'PAPERWEIGHT VINTAGE PAISLEY', '22395');
INSERT INTO public.products VALUES (122, 0.76, 15, NULL, 1290, 2, NULL, NULL, 'MAGNETS PACK OF 4 RETRO PHOTO', '22396');
INSERT INTO public.products VALUES (249, 0.78, 22, NULL, 1291, 2, NULL, NULL, 'MAGNETS PACK OF 4 SWALLOWS', '22398');
INSERT INTO public.products VALUES (112, 1.32, 22, NULL, 1292, 2, NULL, NULL, 'MAGNETS PACK OF 4 CHILDHOOD MEMORY', '22399');
INSERT INTO public.products VALUES (139, 0.66, 22, NULL, 1293, 2, NULL, NULL, 'MAGNETS PACK OF 4 HOME SWEET HOME', '22400');
INSERT INTO public.products VALUES (171, 0.69, 22, NULL, 1294, 2, NULL, NULL, 'MAGNETS PACK OF 4 VINTAGE COLLAGE', '22402');
INSERT INTO public.products VALUES (131, 0.90, 22, NULL, 1295, 2, NULL, NULL, 'MAGNETS PACK OF 4 VINTAGE LABELS ', '22403');
INSERT INTO public.products VALUES (37, 1.42, 16, NULL, 1296, 2, NULL, NULL, 'MONEY BOX POCKET MONEY DESIGN', '22405');
INSERT INTO public.products VALUES (34, 1.51, 16, NULL, 1297, 2, NULL, NULL, 'MONEY BOX KINGS CHOICE DESIGN', '22406');
INSERT INTO public.products VALUES (10, 1.28, 16, NULL, 1298, 2, NULL, NULL, 'MONEY BOX FIRST ADE DESIGN', '22407');
INSERT INTO public.products VALUES (14, 1.49, 16, NULL, 1299, 2, NULL, NULL, 'MONEY BOX CONFECTIONERY DESIGN', '22408');
INSERT INTO public.products VALUES (22, 1.50, 16, NULL, 1300, 2, NULL, NULL, 'MONEY BOX BISCUITS DESIGN', '22409');
INSERT INTO public.products VALUES (23, 1.42, 16, NULL, 1301, 2, NULL, NULL, 'MONEY BOX HOUSEKEEPING DESIGN', '22410');
INSERT INTO public.products VALUES (1224, 2.68, 22, NULL, 1302, 2, NULL, NULL, 'JUMBO SHOPPER VINTAGE RED PAISLEY', '22411');
INSERT INTO public.products VALUES (91, 2.55, 21, NULL, 1303, 2, NULL, NULL, 'METAL SIGN NEIGHBOURHOOD WITCH ', '22412');
INSERT INTO public.products VALUES (375, 3.34, 21, NULL, 1304, 2, NULL, NULL, 'METAL SIGN TAKE IT OR LEAVE IT ', '22413');
INSERT INTO public.products VALUES (28, 9.75, 22, NULL, 1305, 2, NULL, NULL, 'DOORMAT NEIGHBOURHOOD WITCH ', '22414');
INSERT INTO public.products VALUES (10, 7.95, 22, NULL, 1306, 2, NULL, NULL, 'WHITE TISSUE REAM', '22415');
INSERT INTO public.products VALUES (86, 1.59, 21, NULL, 1307, 2, NULL, NULL, 'SET OF 36 DOILIES SPACEBOY DESIGN ', '22416');
INSERT INTO public.products VALUES (838, 0.76, 22, NULL, 1308, 2, NULL, NULL, 'PACK OF 60 SPACEBOY CAKE CASES', '22417');
INSERT INTO public.products VALUES (639, 1.05, 22, NULL, 1309, 2, NULL, NULL, '10 COLOUR SPACEBOY PEN', '22418');
INSERT INTO public.products VALUES (334, 0.60, 22, NULL, 1310, 2, NULL, NULL, 'LIPSTICK PEN RED', '22419');
INSERT INTO public.products VALUES (133, 0.59, 22, NULL, 1311, 2, NULL, NULL, 'LIPSTICK PEN BABY PINK', '22420');
INSERT INTO public.products VALUES (259, 0.61, 22, NULL, 1312, 2, NULL, NULL, 'LIPSTICK PEN FUSCHIA', '22421');
INSERT INTO public.products VALUES (127, 1.03, 22, NULL, 1313, 2, NULL, NULL, 'TOOTHPASTE TUBE PEN', '22422');
INSERT INTO public.products VALUES (1298, 13.78, 22, NULL, 1314, 2, NULL, NULL, 'REGENCY CAKESTAND 3 TIER', '22423');
INSERT INTO public.products VALUES (84, 15.76, 22, NULL, 1315, 2, NULL, NULL, 'ENAMEL BREAD BIN CREAM', '22424');
INSERT INTO public.products VALUES (45, 5.67, 22, NULL, 1316, 2, NULL, NULL, 'ENAMEL COLANDER CREAM', '22425');
INSERT INTO public.products VALUES (71, 4.81, 22, NULL, 1317, 2, NULL, NULL, 'ENAMEL WASH BOWL CREAM', '22426');
INSERT INTO public.products VALUES (204, 6.50, 22, NULL, 1318, 2, NULL, NULL, 'ENAMEL FLOWER JUG CREAM', '22427');
INSERT INTO public.products VALUES (25, 8.05, 22, NULL, 1319, 2, NULL, NULL, 'ENAMEL FIRE BUCKET CREAM', '22428');
INSERT INTO public.products VALUES (123, 4.81, 22, NULL, 1320, 2, NULL, NULL, 'ENAMEL MEASURING JUG CREAM', '22429');
INSERT INTO public.products VALUES (61, 5.59, 22, NULL, 1321, 2, NULL, NULL, 'ENAMEL WATERING CAN CREAM', '22430');
INSERT INTO public.products VALUES (205, 2.30, 22, NULL, 1322, 2, NULL, NULL, 'WATERING CAN BLUE ELEPHANT', '22431');
INSERT INTO public.products VALUES (170, 2.23, 22, NULL, 1323, 2, NULL, NULL, 'WATERING CAN PINK BUNNY', '22432');
INSERT INTO public.products VALUES (139, 2.27, 22, NULL, 1324, 2, NULL, NULL, 'WATERING CAN GREEN DINOSAUR', '22433');
INSERT INTO public.products VALUES (78, 2.12, 22, NULL, 1325, 2, NULL, NULL, 'BALLOON PUMP WITH 10 BALLOONS', '22434');
INSERT INTO public.products VALUES (232, 1.45, 22, NULL, 1326, 2, NULL, NULL, 'SET OF 9 HEART SHAPED BALLOONS', '22435');
INSERT INTO public.products VALUES (213, 0.70, 22, NULL, 1327, 2, NULL, NULL, '12 COLOURED PARTY BALLOONS', '22436');
INSERT INTO public.products VALUES (284, 1.01, 22, NULL, 1328, 2, NULL, NULL, 'SET OF 9 BLACK SKULL BALLOONS', '22437');
INSERT INTO public.products VALUES (102, 1.74, 22, NULL, 1329, 2, NULL, NULL, 'BALLOON ART MAKE YOUR OWN FLOWERS', '22438');
INSERT INTO public.products VALUES (183, 0.77, 22, NULL, 1330, 2, NULL, NULL, '6 ROCKET BALLOONS ', '22439');
INSERT INTO public.products VALUES (602, 0.45, 22, NULL, 1331, 2, NULL, NULL, 'BALLOON WATER BOMB PACK OF 35', '22440');
INSERT INTO public.products VALUES (104, 2.55, 14, NULL, 1332, 2, NULL, NULL, 'GROW YOUR OWN BASIL IN ENAMEL MUG', '22441');
INSERT INTO public.products VALUES (28, 6.88, 22, NULL, 1333, 2, NULL, NULL, 'GROW YOUR OWN FLOWERS SET OF 3', '22442');
INSERT INTO public.products VALUES (16, 8.72, 22, NULL, 1334, 2, NULL, NULL, 'GROW YOUR OWN HERBS SET OF 3', '22443');
INSERT INTO public.products VALUES (80, 1.73, 22, NULL, 1335, 2, NULL, NULL, 'GROW YOUR OWN PLANT IN A CAN ', '22444');
INSERT INTO public.products VALUES (53, 3.51, 22, NULL, 1336, 2, NULL, NULL, 'PENCIL CASE LIFE IS BEAUTIFUL', '22445');
INSERT INTO public.products VALUES (43, 2.81, 22, NULL, 1337, 2, NULL, NULL, 'PIN CUSHION BABUSHKA PINK', '22446');
INSERT INTO public.products VALUES (13, 3.29, 22, NULL, 1338, 2, NULL, NULL, 'PIN CUSHION BABUSHKA BLUE', '22447');
INSERT INTO public.products VALUES (20, 3.90, 22, NULL, 1339, 2, NULL, NULL, 'PIN CUSHION BABUSHKA RED', '22448');
INSERT INTO public.products VALUES (36, 3.23, 13, NULL, 1340, 2, NULL, NULL, 'SILK PURSE BABUSHKA PINK', '22449');
INSERT INTO public.products VALUES (19, 3.51, 13, NULL, 1341, 2, NULL, NULL, 'SILK PURSE BABUSHKA BLUE', '22450');
INSERT INTO public.products VALUES (22, 4.13, 13, NULL, 1342, 2, NULL, NULL, 'SILK PURSE BABUSHKA RED', '22451');
INSERT INTO public.products VALUES (74, 2.33, 22, NULL, 1343, 2, NULL, NULL, 'MEASURING TAPE BABUSHKA PINK', '22452');
INSERT INTO public.products VALUES (44, 2.76, 22, NULL, 1344, 2, NULL, NULL, 'MEASURING TAPE BABUSHKA BLUE', '22453');
INSERT INTO public.products VALUES (28, 3.06, 22, NULL, 1345, 2, NULL, NULL, 'MEASURING TAPE BABUSHKA RED', '22454');
INSERT INTO public.products VALUES (166, 6.55, 22, NULL, 1346, 2, NULL, NULL, 'NATURAL SLATE CHALKBOARD LARGE ', '22456');
INSERT INTO public.products VALUES (912, 3.58, 22, NULL, 1347, 2, NULL, NULL, 'NATURAL SLATE HEART CHALKBOARD ', '22457');
INSERT INTO public.products VALUES (45, 3.39, 22, NULL, 1348, 2, NULL, NULL, 'CAST IRON HOOK GARDEN FORK', '22458');
INSERT INTO public.products VALUES (15, 3.40, 22, NULL, 1349, 2, NULL, NULL, 'CAST IRON HOOK GARDEN TROWEL', '22459');
INSERT INTO public.products VALUES (254, 1.54, 12, NULL, 1350, 2, NULL, NULL, 'EMBOSSED GLASS TEALIGHT HOLDER', '22460');
INSERT INTO public.products VALUES (21, 10.16, 18, NULL, 1351, 2, NULL, NULL, 'SAVOY ART DECO CLOCK', '22461');
INSERT INTO public.products VALUES (330, 1.92, 12, NULL, 1352, 2, NULL, NULL, 'HANGING METAL HEART LANTERN', '22464');
INSERT INTO public.products VALUES (203, 1.87, 12, NULL, 1353, 2, NULL, NULL, 'HANGING METAL STAR LANTERN', '22465');
INSERT INTO public.products VALUES (304, 2.47, 12, NULL, 1354, 2, NULL, NULL, 'FAIRY TALE COTTAGE NIGHTLIGHT', '22466');
INSERT INTO public.products VALUES (788, 2.85, 22, NULL, 1355, 2, NULL, NULL, 'GUMBALL COAT RACK', '22467');
INSERT INTO public.products VALUES (51, 8.28, 12, NULL, 1356, 2, NULL, NULL, 'BABUSHKA LIGHTS STRING OF 10', '22468');
INSERT INTO public.products VALUES (1783, 1.95, 22, NULL, 1357, 2, NULL, NULL, 'HEART OF WICKER SMALL', '22469');
INSERT INTO public.products VALUES (983, 3.27, 22, NULL, 1358, 2, NULL, NULL, 'HEART OF WICKER LARGE', '22470');
INSERT INTO public.products VALUES (41, 5.69, 22, NULL, 1359, 2, NULL, NULL, 'TV DINNER TRAY AIR HOSTESS ', '22471');
INSERT INTO public.products VALUES (32, 6.08, 20, NULL, 1360, 2, NULL, NULL, 'TV DINNER TRAY DOLLY GIRL', '22472');
INSERT INTO public.products VALUES (50, 4.97, 22, NULL, 1361, 2, NULL, NULL, 'TV DINNER TRAY VINTAGE PAISLEY', '22473');
INSERT INTO public.products VALUES (27, 6.75, 22, NULL, 1362, 2, NULL, NULL, 'SPACEBOY TV DINNER TRAY', '22474');
INSERT INTO public.products VALUES (32, 5.84, 21, NULL, 1363, 2, NULL, NULL, 'SKULL DESIGN TV DINNER TRAY', '22475');
INSERT INTO public.products VALUES (87, 6.83, 22, NULL, 1364, 2, NULL, NULL, 'EMPIRE UNION JACK TV DINNER TRAY', '22476');
INSERT INTO public.products VALUES (137, 1.77, 22, NULL, 1365, 2, NULL, NULL, 'WATERING CAN GARDEN MARKER', '22477');
INSERT INTO public.products VALUES (154, 1.78, 22, NULL, 1366, 2, NULL, NULL, 'BIRDHOUSE GARDEN MARKER ', '22478');
INSERT INTO public.products VALUES (113, 1.78, 22, NULL, 1367, 2, NULL, NULL, 'DAISY GARDEN MARKER', '22479');
INSERT INTO public.products VALUES (63, 1.29, 21, NULL, 1368, 2, NULL, NULL, 'RED TEA TOWEL CLASSIC DESIGN', '22480');
INSERT INTO public.products VALUES (53, 1.06, 21, NULL, 1369, 2, NULL, NULL, 'BLACK TEA TOWEL CLASSIC DESIGN', '22481');
INSERT INTO public.products VALUES (47, 1.27, 21, NULL, 1370, 2, NULL, NULL, 'BLUE TEA TOWEL CLASSIC DESIGN', '22482');
INSERT INTO public.products VALUES (77, 3.58, 22, NULL, 1371, 2, NULL, NULL, 'RED GINGHAM TEDDY BEAR ', '22483');
INSERT INTO public.products VALUES (52, 14.97, 22, NULL, 1372, 2, NULL, NULL, 'SET OF 2 WOODEN MARKET CRATES', '22485');
INSERT INTO public.products VALUES (10, 8.63, 22, NULL, 1373, 2, NULL, NULL, 'PLASMATRONIC LAMP', '22486');
INSERT INTO public.products VALUES (76, 10.82, 22, NULL, 1374, 2, NULL, NULL, 'WHITE WOOD GARDEN PLANT LADDER', '22487');
INSERT INTO public.products VALUES (316, 2.06, 22, NULL, 1375, 2, NULL, NULL, 'NATURAL SLATE RECTANGLE CHALKBOARD', '22488');
INSERT INTO public.products VALUES (971, 0.54, 22, NULL, 1376, 2, NULL, NULL, 'PACK OF 12 TRADITIONAL CRAYONS', '22489');
INSERT INTO public.products VALUES (394, 0.91, 22, NULL, 1377, 2, NULL, NULL, 'PACK OF 12 COLOURED PENCILS', '22491');
INSERT INTO public.products VALUES (2643, 0.78, 22, NULL, 1378, 2, NULL, NULL, 'MINI PAINT SET VINTAGE ', '22492');
INSERT INTO public.products VALUES (219, 1.91, 22, NULL, 1379, 2, NULL, NULL, 'PAINT YOUR OWN CANVAS SET', '22493');
INSERT INTO public.products VALUES (104, 1.89, 16, NULL, 1380, 2, NULL, NULL, 'EMERGENCY FIRST AID TIN ', '22494');
INSERT INTO public.products VALUES (27, 3.63, 16, NULL, 1381, 2, NULL, NULL, 'SET OF 2 ROUND TINS CAMEMBERT ', '22495');
INSERT INTO public.products VALUES (25, 3.03, 16, NULL, 1382, 2, NULL, NULL, 'SET OF 2 ROUND TINS DUTCH CHEESE', '22496');
INSERT INTO public.products VALUES (22, 5.87, 16, NULL, 1383, 2, NULL, NULL, 'SET OF 2 TINS VINTAGE BATHROOM ', '22497');
INSERT INTO public.products VALUES (33, 6.84, 16, NULL, 1384, 2, NULL, NULL, 'WOODEN REGATTA BUNTING', '22498');
INSERT INTO public.products VALUES (208, 6.79, 16, NULL, 1385, 2, NULL, NULL, 'WOODEN UNION JACK BUNTING', '22499');
INSERT INTO public.products VALUES (25, 4.78, 16, NULL, 1386, 2, NULL, NULL, 'SET OF 2 TINS JARDIN DE PROVENCE', '22500');
INSERT INTO public.products VALUES (132, 14.04, 16, NULL, 1387, 2, NULL, NULL, 'PICNIC BASKET WICKER LARGE', '22501');
INSERT INTO public.products VALUES (179, 10.15, 16, NULL, 1388, 2, NULL, NULL, 'PICNIC BASKET WICKER SMALL', '22502');
INSERT INTO public.products VALUES (10, 22.38, 13, NULL, 1389, 2, NULL, NULL, 'CABIN BAG VINTAGE PAISLEY', '22503');
INSERT INTO public.products VALUES (24, 22.66, 13, NULL, 1390, 2, NULL, NULL, 'CABIN BAG VINTAGE RETROSPOT', '22504');
INSERT INTO public.products VALUES (145, 5.65, 21, NULL, 1391, 2, NULL, NULL, 'MEMO BOARD COTTAGE DESIGN', '22505');
INSERT INTO public.products VALUES (295, 6.28, 21, NULL, 1392, 2, NULL, NULL, 'MEMO BOARD RETROSPOT  DESIGN', '22507');
INSERT INTO public.products VALUES (157, 4.54, 22, NULL, 1393, 2, NULL, NULL, 'DOORSTOP RETROSPOT HEART', '22508');
INSERT INTO public.products VALUES (19, 13.11, 16, NULL, 1394, 2, NULL, NULL, 'SEWING BOX RETROSPOT DESIGN ', '22509');
INSERT INTO public.products VALUES (21, 2.43, 22, NULL, 1395, 2, NULL, NULL, 'GINGHAM BABUSHKA DOORSTOP', '22510');
INSERT INTO public.products VALUES (25, 2.82, 22, NULL, 1396, 2, NULL, NULL, 'RETROSPOT BABUSHKA DOORSTOP', '22511');
INSERT INTO public.products VALUES (12, 3.23, 21, NULL, 1397, 2, NULL, NULL, 'DOORSTOP RACING CAR DESIGN', '22512');
INSERT INTO public.products VALUES (15, 4.65, 21, NULL, 1398, 2, NULL, NULL, 'DOORSTOP FOOTBALL DESIGN', '22513');
INSERT INTO public.products VALUES (30, 2.40, 22, NULL, 1399, 2, NULL, NULL, 'CHILDS GARDEN SPADE BLUE', '22514');
INSERT INTO public.products VALUES (27, 2.51, 22, NULL, 1400, 2, NULL, NULL, 'CHILDS GARDEN SPADE PINK', '22515');
INSERT INTO public.products VALUES (20, 2.68, 22, NULL, 1401, 2, NULL, NULL, 'CHILDS GARDEN RAKE BLUE', '22516');
INSERT INTO public.products VALUES (20, 2.49, 22, NULL, 1402, 2, NULL, NULL, 'CHILDS GARDEN RAKE PINK', '22517');
INSERT INTO public.products VALUES (36, 2.57, 22, NULL, 1403, 2, NULL, NULL, 'CHILDS GARDEN BRUSH BLUE', '22518');
INSERT INTO public.products VALUES (41, 2.54, 22, NULL, 1404, 2, NULL, NULL, 'CHILDS GARDEN BRUSH PINK', '22519');
INSERT INTO public.products VALUES (72, 0.87, 22, NULL, 1405, 2, NULL, NULL, 'CHILDS GARDEN TROWEL BLUE ', '22520');
INSERT INTO public.products VALUES (61, 0.91, 22, NULL, 1406, 2, NULL, NULL, 'CHILDS GARDEN TROWEL PINK', '22521');
INSERT INTO public.products VALUES (79, 0.88, 22, NULL, 1407, 2, NULL, NULL, 'CHILDS GARDEN FORK BLUE ', '22522');
INSERT INTO public.products VALUES (76, 0.93, 22, NULL, 1408, 2, NULL, NULL, 'CHILDS GARDEN FORK PINK', '22523');
INSERT INTO public.products VALUES (64, 1.54, 22, NULL, 1409, 2, NULL, NULL, 'CHILDRENS GARDEN GLOVES BLUE', '22524');
INSERT INTO public.products VALUES (49, 1.75, 22, NULL, 1410, 2, NULL, NULL, 'CHILDRENS GARDEN GLOVES PINK', '22525');
INSERT INTO public.products VALUES (12, 14.03, 22, NULL, 1411, 2, NULL, NULL, 'WHEELBARROW FOR CHILDREN ', '22526');
INSERT INTO public.products VALUES (10, 3.36, 22, NULL, 1412, 2, NULL, NULL, 'GARDENERS KNEELING PAD', '22528');
INSERT INTO public.products VALUES (85, 0.46, 22, NULL, 1413, 2, NULL, NULL, 'MAGIC DRAWING SLATE GO TO THE FAIR ', '22529');
INSERT INTO public.products VALUES (360, 0.50, 20, NULL, 1414, 2, NULL, NULL, 'MAGIC DRAWING SLATE DOLLY GIRL ', '22530');
INSERT INTO public.products VALUES (338, 0.49, 22, NULL, 1415, 2, NULL, NULL, 'MAGIC DRAWING SLATE CIRCUS PARADE  ', '22531');
INSERT INTO public.products VALUES (107, 0.45, 22, NULL, 1416, 2, NULL, NULL, 'MAGIC DRAWING SLATE LEAP FROG ', '22532');
INSERT INTO public.products VALUES (182, 0.45, 22, NULL, 1417, 2, NULL, NULL, 'MAGIC DRAWING SLATE BAKE A CAKE ', '22533');
INSERT INTO public.products VALUES (449, 0.51, 22, NULL, 1418, 2, NULL, NULL, 'MAGIC DRAWING SLATE SPACEBOY ', '22534');
INSERT INTO public.products VALUES (171, 0.48, 22, NULL, 1419, 2, NULL, NULL, 'MAGIC DRAWING SLATE BUNNIES ', '22535');
INSERT INTO public.products VALUES (462, 0.44, 22, NULL, 1420, 2, NULL, NULL, 'MAGIC DRAWING SLATE PURDEY', '22536');
INSERT INTO public.products VALUES (188, 0.49, 22, NULL, 1421, 2, NULL, NULL, 'MAGIC DRAWING SLATE DINOSAUR', '22537');
INSERT INTO public.products VALUES (40, 0.56, 22, NULL, 1422, 2, NULL, NULL, 'MINI JIGSAW GO TO THE FAIR', '22538');
INSERT INTO public.products VALUES (292, 0.56, 20, NULL, 1423, 2, NULL, NULL, 'MINI JIGSAW DOLLY GIRL', '22539');
INSERT INTO public.products VALUES (251, 0.52, 22, NULL, 1424, 2, NULL, NULL, 'MINI JIGSAW CIRCUS PARADE ', '22540');
INSERT INTO public.products VALUES (50, 0.56, 22, NULL, 1425, 2, NULL, NULL, 'MINI JIGSAW LEAP FROG', '22541');
INSERT INTO public.products VALUES (145, 0.50, 22, NULL, 1426, 2, NULL, NULL, 'MINI JIGSAW BAKE A CAKE ', '22543');
INSERT INTO public.products VALUES (447, 0.53, 22, NULL, 1427, 2, NULL, NULL, 'MINI JIGSAW SPACEBOY', '22544');
INSERT INTO public.products VALUES (114, 0.56, 22, NULL, 1428, 2, NULL, NULL, 'MINI JIGSAW BUNNIES', '22545');
INSERT INTO public.products VALUES (210, 0.53, 22, NULL, 1429, 2, NULL, NULL, 'MINI JIGSAW PURDEY', '22546');
INSERT INTO public.products VALUES (80, 0.63, 22, NULL, 1430, 2, NULL, NULL, 'MINI JIGSAW DINOSAUR ', '22547');
INSERT INTO public.products VALUES (198, 1.40, 16, NULL, 1431, 2, NULL, NULL, 'HEADS AND TAILS SPORTING FUN', '22548');
INSERT INTO public.products VALUES (318, 1.98, 15, NULL, 1432, 2, NULL, NULL, 'PICTURE DOMINOES', '22549');
INSERT INTO public.products VALUES (115, 4.38, 22, NULL, 1433, 2, NULL, NULL, 'HOLIDAY FUN LUDO', '22550');
INSERT INTO public.products VALUES (805, 1.86, 16, NULL, 1434, 2, NULL, NULL, 'PLASTERS IN TIN SPACEBOY', '22551');
INSERT INTO public.products VALUES (420, 1.96, 16, NULL, 1435, 2, NULL, NULL, 'PLASTERS IN TIN SKULLS', '22553');
INSERT INTO public.products VALUES (778, 1.91, 16, NULL, 1436, 2, NULL, NULL, 'PLASTERS IN TIN WOODLAND ANIMALS', '22554');
INSERT INTO public.products VALUES (600, 1.85, 16, NULL, 1437, 2, NULL, NULL, 'PLASTERS IN TIN STRONGMAN', '22555');
INSERT INTO public.products VALUES (188, 0.42, 19, NULL, 1582, 2, NULL, NULL, 'WRAP GREEN PEARS ', '22705');
INSERT INTO public.products VALUES (605, 1.78, 16, NULL, 1438, 2, NULL, NULL, 'PLASTERS IN TIN CIRCUS PARADE ', '22556');
INSERT INTO public.products VALUES (469, 1.89, 16, NULL, 1439, 2, NULL, NULL, 'PLASTERS IN TIN VINTAGE PAISLEY ', '22557');
INSERT INTO public.products VALUES (864, 1.83, 22, NULL, 1440, 2, NULL, NULL, 'CLOTHES PEGS RETROSPOT PACK 24 ', '22558');
INSERT INTO public.products VALUES (50, 1.56, 22, NULL, 1441, 2, NULL, NULL, 'SEASIDE FLYING DISC', '22559');
INSERT INTO public.products VALUES (816, 1.42, 22, NULL, 1442, 2, NULL, NULL, 'TRADITIONAL MODELLING CLAY', '22560');
INSERT INTO public.products VALUES (561, 1.78, 22, NULL, 1443, 2, NULL, NULL, 'WOODEN SCHOOL COLOURING SET', '22561');
INSERT INTO public.products VALUES (142, 1.36, 22, NULL, 1444, 2, NULL, NULL, 'MONSTERS STENCIL CRAFT', '22562');
INSERT INTO public.products VALUES (283, 1.35, 22, NULL, 1445, 2, NULL, NULL, 'HAPPY STENCIL CRAFT', '22563');
INSERT INTO public.products VALUES (226, 1.35, 22, NULL, 1446, 2, NULL, NULL, 'ALPHABET STENCIL CRAFT', '22564');
INSERT INTO public.products VALUES (93, 1.11, 22, NULL, 1447, 2, NULL, NULL, 'FELTCRAFT HAIRBANDS PINK AND WHITE ', '22565');
INSERT INTO public.products VALUES (87, 1.05, 22, NULL, 1448, 2, NULL, NULL, 'FELTCRAFT HAIRBAND PINK AND PURPLE', '22566');
INSERT INTO public.products VALUES (244, 1.56, 20, NULL, 1449, 2, NULL, NULL, '20 DOLLY PEGS RETROSPOT', '22567');
INSERT INTO public.products VALUES (290, 4.14, 22, NULL, 1450, 2, NULL, NULL, 'FELTCRAFT CUSHION OWL', '22568');
INSERT INTO public.products VALUES (248, 4.25, 22, NULL, 1451, 2, NULL, NULL, 'FELTCRAFT CUSHION BUTTERFLY', '22569');
INSERT INTO public.products VALUES (277, 4.27, 22, NULL, 1452, 2, NULL, NULL, 'FELTCRAFT CUSHION RABBIT', '22570');
INSERT INTO public.products VALUES (233, 1.07, 17, NULL, 1453, 2, NULL, NULL, 'ROCKING HORSE RED CHRISTMAS ', '22571');
INSERT INTO public.products VALUES (105, 1.05, 17, NULL, 1454, 2, NULL, NULL, 'ROCKING HORSE GREEN CHRISTMAS ', '22572');
INSERT INTO public.products VALUES (268, 1.12, 17, NULL, 1455, 2, NULL, NULL, 'STAR WOODEN CHRISTMAS DECORATION', '22573');
INSERT INTO public.products VALUES (214, 1.11, 17, NULL, 1456, 2, NULL, NULL, 'HEART WOODEN CHRISTMAS DECORATION', '22574');
INSERT INTO public.products VALUES (50, 2.18, 17, NULL, 1457, 2, NULL, NULL, 'METAL MERRY CHRISTMAS WREATH', '22575');
INSERT INTO public.products VALUES (150, 1.08, 17, NULL, 1458, 2, NULL, NULL, 'SWALLOW WOODEN CHRISTMAS DECORATION', '22576');
INSERT INTO public.products VALUES (1020, 0.50, 17, NULL, 1459, 2, NULL, NULL, 'WOODEN HEART CHRISTMAS SCANDINAVIAN', '22577');
INSERT INTO public.products VALUES (927, 0.47, 17, NULL, 1460, 2, NULL, NULL, 'WOODEN STAR CHRISTMAS SCANDINAVIAN', '22578');
INSERT INTO public.products VALUES (503, 0.52, 17, NULL, 1461, 2, NULL, NULL, 'WOODEN TREE CHRISTMAS SCANDINAVIAN', '22579');
INSERT INTO public.products VALUES (125, 5.71, 22, NULL, 1462, 2, NULL, NULL, 'ADVENT CALENDAR GINGHAM SACK', '22580');
INSERT INTO public.products VALUES (156, 0.88, 17, NULL, 1463, 2, NULL, NULL, 'WOOD STOCKING CHRISTMAS SCANDISPOT', '22581');
INSERT INTO public.products VALUES (104, 3.12, 16, NULL, 1464, 2, NULL, NULL, 'PACK OF 6 SWEETIE GIFT BOXES', '22582');
INSERT INTO public.products VALUES (57, 3.27, 13, NULL, 1465, 2, NULL, NULL, 'PACK OF 6 HANDBAG GIFT BOXES', '22583');
INSERT INTO public.products VALUES (231, 3.10, 16, NULL, 1466, 2, NULL, NULL, 'PACK OF 6 PANNETONE GIFT BOXES', '22584');
INSERT INTO public.products VALUES (618, 1.47, 22, NULL, 1467, 2, NULL, NULL, 'PACK OF 6 BIRDY GIFT TAGS', '22585');
INSERT INTO public.products VALUES (77, 1.05, 22, NULL, 1468, 2, NULL, NULL, 'FELTCRAFT HAIRBAND PINK AND BLUE', '22586');
INSERT INTO public.products VALUES (88, 1.03, 22, NULL, 1469, 2, NULL, NULL, 'FELTCRAFT HAIRBAND RED AND BLUE', '22587');
INSERT INTO public.products VALUES (49, 3.48, 19, NULL, 1470, 2, NULL, NULL, 'CARD HOLDER GINGHAM HEART', '22588');
INSERT INTO public.products VALUES (37, 3.65, 19, NULL, 1471, 2, NULL, NULL, 'CARDHOLDER GINGHAM STAR', '22589');
INSERT INTO public.products VALUES (35, 4.39, 17, NULL, 1472, 2, NULL, NULL, 'CARDHOLDER GINGHAM CHRISTMAS TREE', '22591');
INSERT INTO public.products VALUES (65, 5.07, 19, NULL, 1473, 2, NULL, NULL, 'CARDHOLDER HOLLY WREATH METAL', '22592');
INSERT INTO public.products VALUES (212, 1.12, 17, NULL, 1474, 2, NULL, NULL, 'CHRISTMAS GINGHAM STAR', '22593');
INSERT INTO public.products VALUES (200, 1.17, 17, NULL, 1475, 2, NULL, NULL, 'CHRISTMAS GINGHAM TREE', '22594');
INSERT INTO public.products VALUES (657, 1.02, 17, NULL, 1476, 2, NULL, NULL, 'CHRISTMAS GINGHAM HEART', '22595');
INSERT INTO public.products VALUES (347, 1.30, 17, NULL, 1477, 2, NULL, NULL, 'CHRISTMAS STAR WISH LIST CHALKBOARD', '22596');
INSERT INTO public.products VALUES (278, 0.69, 17, NULL, 1478, 2, NULL, NULL, 'CHRISTMAS MUSICAL ZINC HEART ', '22597');
INSERT INTO public.products VALUES (98, 0.66, 17, NULL, 1479, 2, NULL, NULL, 'CHRISTMAS MUSICAL ZINC TREE', '22598');
INSERT INTO public.products VALUES (192, 0.65, 17, NULL, 1480, 2, NULL, NULL, 'CHRISTMAS MUSICAL ZINC STAR', '22599');
INSERT INTO public.products VALUES (167, 1.07, 17, NULL, 1481, 2, NULL, NULL, 'CHRISTMAS RETROSPOT STAR WOOD', '22600');
INSERT INTO public.products VALUES (245, 1.06, 17, NULL, 1482, 2, NULL, NULL, 'CHRISTMAS RETROSPOT ANGEL WOOD', '22601');
INSERT INTO public.products VALUES (217, 1.12, 17, NULL, 1483, 2, NULL, NULL, 'CHRISTMAS RETROSPOT HEART WOOD', '22602');
INSERT INTO public.products VALUES (137, 1.07, 17, NULL, 1484, 2, NULL, NULL, 'CHRISTMAS RETROSPOT TREE WOOD', '22603');
INSERT INTO public.products VALUES (125, 2.85, 22, NULL, 1485, 2, NULL, NULL, 'SET OF 4 NAPKIN CHARMS CUTLERY', '22604');
INSERT INTO public.products VALUES (77, 16.14, 22, NULL, 1486, 2, NULL, NULL, 'WOODEN CROQUET GARDEN SET', '22605');
INSERT INTO public.products VALUES (31, 16.10, 22, NULL, 1487, 2, NULL, NULL, 'WOODEN SKITTLES GARDEN SET', '22606');
INSERT INTO public.products VALUES (132, 10.72, 22, NULL, 1488, 2, NULL, NULL, 'WOODEN ROUNDERS GARDEN SET ', '22607');
INSERT INTO public.products VALUES (524, 0.33, 22, NULL, 1489, 2, NULL, NULL, 'PENS ASSORTED FUNKY JEWELED ', '22608');
INSERT INTO public.products VALUES (591, 0.41, 22, NULL, 1490, 2, NULL, NULL, 'PENS ASSORTED SPACEBALL', '22609');
INSERT INTO public.products VALUES (960, 0.39, 22, NULL, 1491, 2, NULL, NULL, 'PENS ASSORTED FUNNY FACE', '22610');
INSERT INTO public.products VALUES (22, 5.55, 13, NULL, 1492, 2, NULL, NULL, 'VINTAGE UNION JACK SHOPPING BAG', '22611');
INSERT INTO public.products VALUES (152, 1.01, 22, NULL, 1493, 2, NULL, NULL, 'PACK OF 20 SPACEBOY NAPKINS', '22613');
INSERT INTO public.products VALUES (299, 0.45, 22, NULL, 1494, 2, NULL, NULL, 'PACK OF 12 SPACEBOY TISSUES', '22614');
INSERT INTO public.products VALUES (206, 0.49, 22, NULL, 1495, 2, NULL, NULL, 'PACK OF 12 CIRCUS PARADE TISSUES ', '22615');
INSERT INTO public.products VALUES (2631, 0.45, 22, NULL, 1496, 2, NULL, NULL, 'PACK OF 12 LONDON TISSUES ', '22616');
INSERT INTO public.products VALUES (10, 5.43, 21, NULL, 1497, 2, NULL, NULL, 'BAKING SET SPACEBOY DESIGN', '22617');
INSERT INTO public.products VALUES (10, 10.17, 22, NULL, 1498, 2, NULL, NULL, 'COOKING SET RETROSPOT', '22618');
INSERT INTO public.products VALUES (256, 4.61, 22, NULL, 1499, 2, NULL, NULL, 'SET OF 6 SOLDIER SKITTLES', '22619');
INSERT INTO public.products VALUES (488, 1.65, 22, NULL, 1500, 2, NULL, NULL, '4 TRADITIONAL SPINNING TOPS', '22620');
INSERT INTO public.products VALUES (609, 1.88, 16, NULL, 1501, 2, NULL, NULL, 'TRADITIONAL KNITTING NANCY', '22621');
INSERT INTO public.products VALUES (132, 12.37, 16, NULL, 1502, 2, NULL, NULL, 'BOX OF VINTAGE ALPHABET BLOCKS', '22622');
INSERT INTO public.products VALUES (92, 6.16, 16, NULL, 1503, 2, NULL, NULL, 'BOX OF VINTAGE JIGSAW BLOCKS ', '22623');
INSERT INTO public.products VALUES (190, 9.36, 22, NULL, 1504, 2, NULL, NULL, 'IVORY KITCHEN SCALES', '22624');
INSERT INTO public.products VALUES (162, 9.63, 22, NULL, 1505, 2, NULL, NULL, 'RED KITCHEN SCALES', '22625');
INSERT INTO public.products VALUES (51, 8.97, 22, NULL, 1506, 2, NULL, NULL, 'BLACK KITCHEN SCALES', '22626');
INSERT INTO public.products VALUES (84, 9.31, 22, NULL, 1507, 2, NULL, NULL, 'MINT KITCHEN SCALES', '22627');
INSERT INTO public.products VALUES (94, 5.62, 16, NULL, 1508, 2, NULL, NULL, 'PICNIC BOXES SET OF 3 RETROSPOT ', '22628');
INSERT INTO public.products VALUES (1420, 2.19, 16, NULL, 1509, 2, NULL, NULL, 'SPACEBOY LUNCH BOX ', '22629');
INSERT INTO public.products VALUES (1151, 2.32, 16, NULL, 1510, 2, NULL, NULL, 'DOLLY GIRL LUNCH BOX', '22630');
INSERT INTO public.products VALUES (365, 2.60, 16, NULL, 1511, 2, NULL, NULL, 'CIRCUS PARADE LUNCH BOX ', '22631');
INSERT INTO public.products VALUES (444, 2.21, 22, NULL, 1512, 2, NULL, NULL, 'HAND WARMER RED POLKA DOT', '22632');
INSERT INTO public.products VALUES (484, 2.19, 22, NULL, 1513, 2, NULL, NULL, 'HAND WARMER UNION JACK', '22633');
INSERT INTO public.products VALUES (72, 10.24, 22, NULL, 1514, 2, NULL, NULL, 'CHILDS BREAKFAST SET SPACEBOY ', '22634');
INSERT INTO public.products VALUES (59, 10.34, 20, NULL, 1515, 2, NULL, NULL, 'CHILDS BREAKFAST SET DOLLY GIRL ', '22635');
INSERT INTO public.products VALUES (56, 8.85, 22, NULL, 1516, 2, NULL, NULL, 'CHILDS BREAKFAST SET CIRCUS PARADE', '22636');
INSERT INTO public.products VALUES (264, 3.05, 22, NULL, 1517, 2, NULL, NULL, 'PIGGY BANK RETROSPOT ', '22637');
INSERT INTO public.products VALUES (29, 2.28, 22, NULL, 1518, 2, NULL, NULL, 'SET OF 4 NAPKIN CHARMS CROWNS ', '22638');
INSERT INTO public.products VALUES (80, 2.79, 22, NULL, 1519, 2, NULL, NULL, 'SET OF 4 NAPKIN CHARMS HEARTS', '22639');
INSERT INTO public.products VALUES (23, 2.52, 22, NULL, 1520, 2, NULL, NULL, 'SET OF 4 NAPKIN CHARMS 3 KEYS ', '22640');
INSERT INTO public.products VALUES (13, 2.59, 22, NULL, 1521, 2, NULL, NULL, 'SET OF 4 NAPKIN CHARMS INSTRUMENT', '22641');
INSERT INTO public.products VALUES (26, 2.65, 22, NULL, 1522, 2, NULL, NULL, 'SET OF 4 NAPKIN CHARMS STARS   ', '22642');
INSERT INTO public.products VALUES (24, 2.18, 22, NULL, 1523, 2, NULL, NULL, 'SET OF 4 NAPKIN CHARMS LEAVES   ', '22643');
INSERT INTO public.products VALUES (221, 2.11, 22, NULL, 1524, 2, NULL, NULL, 'CERAMIC CHERRY CAKE MONEY BANK', '22644');
INSERT INTO public.products VALUES (234, 2.25, 22, NULL, 1525, 2, NULL, NULL, 'CERAMIC HEART FAIRY CAKE MONEY BANK', '22645');
INSERT INTO public.products VALUES (413, 2.03, 22, NULL, 1526, 2, NULL, NULL, 'CERAMIC STRAWBERRY CAKE MONEY BANK', '22646');
INSERT INTO public.products VALUES (72, 1.38, 22, NULL, 1527, 2, NULL, NULL, 'CERAMIC LOVE HEART MONEY BANK', '22647');
INSERT INTO public.products VALUES (76, 5.85, 22, NULL, 1528, 2, NULL, NULL, 'STRAWBERRY FAIRY CAKE TEAPOT', '22649');
INSERT INTO public.products VALUES (85, 1.90, 22, NULL, 1529, 2, NULL, NULL, 'CERAMIC PIRATE CHEST MONEY BANK', '22650');
INSERT INTO public.products VALUES (216, 1.14, 22, NULL, 1530, 2, NULL, NULL, 'GENTLEMAN SHIRT REPAIR KIT ', '22651');
INSERT INTO public.products VALUES (497, 1.96, 22, NULL, 1531, 2, NULL, NULL, 'TRAVEL SEWING KIT', '22652');
INSERT INTO public.products VALUES (184, 1.95, 16, NULL, 1532, 2, NULL, NULL, 'BUTTON BOX ', '22653');
INSERT INTO public.products VALUES (137, 7.67, 22, NULL, 1533, 2, NULL, NULL, 'DELUXE SEWING KIT ', '22654');
INSERT INTO public.products VALUES (10, 147.46, 22, NULL, 1534, 2, NULL, NULL, 'VINTAGE RED KITCHEN CABINET', '22655');
INSERT INTO public.products VALUES (10, 143.65, 22, NULL, 1535, 2, NULL, NULL, 'VINTAGE BLUE KITCHEN CABINET', '22656');
INSERT INTO public.products VALUES (1120, 2.30, 16, NULL, 1536, 2, NULL, NULL, 'LUNCH BOX I LOVE LONDON', '22659');
INSERT INTO public.products VALUES (36, 9.90, 22, NULL, 1537, 2, NULL, NULL, 'DOORMAT I LOVE LONDON', '22660');
INSERT INTO public.products VALUES (520, 0.97, 13, NULL, 1538, 2, NULL, NULL, 'CHARLOTTE BAG DOLLY GIRL DESIGN', '22661');
INSERT INTO public.products VALUES (670, 1.93, 13, NULL, 1539, 2, NULL, NULL, 'LUNCH BAG DOLLY GIRL DESIGN', '22662');
INSERT INTO public.products VALUES (340, 2.57, 13, NULL, 1540, 2, NULL, NULL, 'JUMBO BAG DOLLY GIRL DESIGN', '22663');
INSERT INTO public.products VALUES (70, 2.86, 20, NULL, 1541, 2, NULL, NULL, 'TOY TIDY DOLLY GIRL DESIGN', '22664');
INSERT INTO public.products VALUES (150, 3.97, 16, NULL, 1542, 2, NULL, NULL, 'RECIPE BOX BLUE SKETCHBOOK DESIGN', '22665');
INSERT INTO public.products VALUES (814, 3.65, 16, NULL, 1543, 2, NULL, NULL, 'RECIPE BOX PANTRY YELLOW DESIGN', '22666');
INSERT INTO public.products VALUES (277, 3.02, 16, NULL, 1544, 2, NULL, NULL, 'RECIPE BOX RETROSPOT ', '22667');
INSERT INTO public.products VALUES (213, 4.10, 16, NULL, 1545, 2, NULL, NULL, 'PINK BABY BUNTING', '22668');
INSERT INTO public.products VALUES (107, 3.76, 16, NULL, 1546, 2, NULL, NULL, 'RED BABY BUNTING ', '22669');
INSERT INTO public.products VALUES (187, 1.63, 21, NULL, 1547, 2, NULL, NULL, 'FRENCH WC SIGN BLUE METAL', '22670');
INSERT INTO public.products VALUES (96, 2.15, 21, NULL, 1548, 2, NULL, NULL, 'FRENCH LAUNDRY SIGN BLUE METAL', '22671');
INSERT INTO public.products VALUES (146, 2.08, 21, NULL, 1549, 2, NULL, NULL, 'FRENCH BATHROOM SIGN BLUE METAL', '22672');
INSERT INTO public.products VALUES (78, 1.49, 21, NULL, 1550, 2, NULL, NULL, 'FRENCH GARDEN SIGN BLUE METAL', '22673');
INSERT INTO public.products VALUES (133, 1.51, 21, NULL, 1551, 2, NULL, NULL, 'FRENCH TOILET SIGN BLUE METAL', '22674');
INSERT INTO public.products VALUES (121, 1.54, 21, NULL, 1552, 2, NULL, NULL, 'FRENCH KITCHEN SIGN BLUE METAL', '22675');
INSERT INTO public.products VALUES (117, 1.56, 21, NULL, 1553, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 1', '22676');
INSERT INTO public.products VALUES (100, 1.68, 21, NULL, 1554, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 2', '22677');
INSERT INTO public.products VALUES (85, 1.59, 21, NULL, 1555, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 3', '22678');
INSERT INTO public.products VALUES (75, 1.64, 21, NULL, 1556, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 4', '22679');
INSERT INTO public.products VALUES (82, 1.58, 21, NULL, 1557, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 5', '22680');
INSERT INTO public.products VALUES (71, 1.60, 21, NULL, 1558, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 6', '22681');
INSERT INTO public.products VALUES (67, 1.51, 21, NULL, 1559, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 7', '22682');
INSERT INTO public.products VALUES (65, 1.54, 21, NULL, 1560, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 8', '22683');
INSERT INTO public.products VALUES (53, 1.59, 21, NULL, 1561, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 9', '22684');
INSERT INTO public.products VALUES (59, 1.47, 21, NULL, 1562, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN 0', '22685');
INSERT INTO public.products VALUES (99, 1.81, 21, NULL, 1563, 2, NULL, NULL, 'FRENCH BLUE METAL DOOR SIGN No', '22686');
INSERT INTO public.products VALUES (61, 10.90, 17, NULL, 1564, 2, NULL, NULL, 'DOORMAT CHRISTMAS VILLAGE', '22687');
INSERT INTO public.products VALUES (70, 9.14, 22, NULL, 1565, 2, NULL, NULL, 'DOORMAT PEACE ON EARTH BLUE', '22688');
INSERT INTO public.products VALUES (66, 10.03, 17, NULL, 1566, 2, NULL, NULL, 'DOORMAT MERRY CHRISTMAS RED ', '22689');
INSERT INTO public.products VALUES (161, 8.31, 22, NULL, 1567, 2, NULL, NULL, 'DOORMAT HOME SWEET HOME BLUE ', '22690');
INSERT INTO public.products VALUES (36, 9.33, 22, NULL, 1568, 2, NULL, NULL, 'DOORMAT WELCOME SUNRISE', '22691');
INSERT INTO public.products VALUES (152, 9.48, 22, NULL, 1569, 2, NULL, NULL, 'DOORMAT WELCOME TO OUR HOME', '22692');
INSERT INTO public.products VALUES (1617, 1.48, 16, NULL, 1570, 2, NULL, NULL, 'GROW A FLYTRAP OR SUNFLOWER IN TIN', '22693');
INSERT INTO public.products VALUES (179, 2.54, 22, NULL, 1571, 2, NULL, NULL, 'WICKER STAR ', '22694');
INSERT INTO public.products VALUES (74, 1.75, 22, NULL, 1572, 2, NULL, NULL, 'WICKER WREATH SMALL', '22695');
INSERT INTO public.products VALUES (73, 2.34, 22, NULL, 1573, 2, NULL, NULL, 'WICKER WREATH LARGE', '22696');
INSERT INTO public.products VALUES (716, 3.78, 14, NULL, 1574, 2, NULL, NULL, 'GREEN REGENCY TEACUP AND SAUCER', '22697');
INSERT INTO public.products VALUES (568, 3.65, 14, NULL, 1575, 2, NULL, NULL, 'PINK REGENCY TEACUP AND SAUCER', '22698');
INSERT INTO public.products VALUES (944, 3.62, 14, NULL, 1576, 2, NULL, NULL, 'ROSES REGENCY TEACUP AND SAUCER ', '22699');
INSERT INTO public.products VALUES (112, 2.54, 22, NULL, 1577, 2, NULL, NULL, 'BLACK AND WHITE DOG BOWL', '22700');
INSERT INTO public.products VALUES (53, 2.60, 22, NULL, 1578, 2, NULL, NULL, 'PINK DOG BOWL', '22701');
INSERT INTO public.products VALUES (136, 2.04, 22, NULL, 1579, 2, NULL, NULL, 'BLACK AND WHITE CAT BOWL', '22702');
INSERT INTO public.products VALUES (36, 1.75, 22, NULL, 1580, 2, NULL, NULL, 'PINK CAT BOWL', '22703');
INSERT INTO public.products VALUES (203, 0.42, 19, NULL, 1583, 2, NULL, NULL, 'WRAP COWBOYS  ', '22706');
INSERT INTO public.products VALUES (125, 0.42, 19, NULL, 1584, 2, NULL, NULL, 'WRAP MONSTER FUN ', '22707');
INSERT INTO public.products VALUES (277, 0.42, 19, NULL, 1585, 2, NULL, NULL, 'WRAP DOLLY GIRL', '22708');
INSERT INTO public.products VALUES (132, 0.42, 19, NULL, 1586, 2, NULL, NULL, 'WRAP WEDDING DAY', '22709');
INSERT INTO public.products VALUES (445, 0.42, 19, NULL, 1587, 2, NULL, NULL, 'WRAP I LOVE LONDON ', '22710');
INSERT INTO public.products VALUES (287, 0.42, 19, NULL, 1588, 2, NULL, NULL, 'WRAP CIRCUS PARADE', '22711');
INSERT INTO public.products VALUES (445, 0.55, 19, NULL, 1589, 2, NULL, NULL, 'CARD DOLLY GIRL ', '22712');
INSERT INTO public.products VALUES (349, 0.54, 19, NULL, 1590, 2, NULL, NULL, 'CARD I LOVE LONDON ', '22713');
INSERT INTO public.products VALUES (347, 0.54, 19, NULL, 1591, 2, NULL, NULL, 'CARD BIRTHDAY COWBOY', '22714');
INSERT INTO public.products VALUES (154, 0.52, 19, NULL, 1592, 2, NULL, NULL, 'CARD WEDDING DAY', '22715');
INSERT INTO public.products VALUES (321, 0.52, 19, NULL, 1593, 2, NULL, NULL, 'CARD CIRCUS PARADE', '22716');
INSERT INTO public.products VALUES (122, 0.56, 19, NULL, 1594, 2, NULL, NULL, 'CARD DOG AND BALL ', '22717');
INSERT INTO public.products VALUES (163, 0.57, 19, NULL, 1595, 2, NULL, NULL, 'CARD CAT AND TREE ', '22718');
INSERT INTO public.products VALUES (29, 1.99, 22, NULL, 1596, 2, NULL, NULL, 'GUMBALL MONOCHROME COAT RACK', '22719');
INSERT INTO public.products VALUES (733, 5.78, 16, NULL, 1597, 2, NULL, NULL, 'SET OF 3 CAKE TINS PANTRY DESIGN ', '22720');
INSERT INTO public.products VALUES (102, 5.38, 16, NULL, 1598, 2, NULL, NULL, 'SET OF 3 CAKE TINS SKETCHBOOK', '22721');
INSERT INTO public.products VALUES (594, 4.66, 16, NULL, 1599, 2, NULL, NULL, 'SET OF 6 SPICE TINS PANTRY DESIGN', '22722');
INSERT INTO public.products VALUES (116, 4.29, 16, NULL, 1600, 2, NULL, NULL, 'SET OF 6 HERB TINS SKETCHBOOK', '22723');
INSERT INTO public.products VALUES (193, 4.74, 18, NULL, 1601, 2, NULL, NULL, 'ALARM CLOCK BAKELIKE CHOCOLATE', '22725');
INSERT INTO public.products VALUES (638, 4.51, 18, NULL, 1602, 2, NULL, NULL, 'ALARM CLOCK BAKELIKE GREEN', '22726');
INSERT INTO public.products VALUES (774, 4.37, 18, NULL, 1603, 2, NULL, NULL, 'ALARM CLOCK BAKELIKE RED ', '22727');
INSERT INTO public.products VALUES (532, 4.56, 18, NULL, 1604, 2, NULL, NULL, 'ALARM CLOCK BAKELIKE PINK', '22728');
INSERT INTO public.products VALUES (229, 4.48, 18, NULL, 1605, 2, NULL, NULL, 'ALARM CLOCK BAKELIKE ORANGE', '22729');
INSERT INTO public.products VALUES (284, 4.39, 18, NULL, 1606, 2, NULL, NULL, 'ALARM CLOCK BAKELIKE IVORY', '22730');
INSERT INTO public.products VALUES (115, 1.51, 17, NULL, 1607, 2, NULL, NULL, '3D CHRISTMAS STAMPS STICKERS ', '22731');
INSERT INTO public.products VALUES (164, 1.57, 17, NULL, 1608, 2, NULL, NULL, '3D VINTAGE CHRISTMAS STICKERS ', '22732');
INSERT INTO public.products VALUES (158, 1.52, 17, NULL, 1609, 2, NULL, NULL, '3D TRADITIONAL CHRISTMAS STICKERS', '22733');
INSERT INTO public.products VALUES (334, 3.46, 17, NULL, 1610, 2, NULL, NULL, 'SET OF 6 RIBBONS VINTAGE CHRISTMAS', '22734');
INSERT INTO public.products VALUES (74, 2.53, 19, NULL, 1611, 2, NULL, NULL, 'RIBBON REEL SOCKS AND MITTENS', '22735');
INSERT INTO public.products VALUES (122, 2.37, 19, NULL, 1612, 2, NULL, NULL, 'RIBBON REEL MAKING SNOWMEN ', '22736');
INSERT INTO public.products VALUES (134, 2.33, 17, NULL, 1613, 2, NULL, NULL, 'RIBBON REEL CHRISTMAS PRESENT ', '22737');
INSERT INTO public.products VALUES (205, 2.32, 19, NULL, 1614, 2, NULL, NULL, 'RIBBON REEL SNOWY VILLAGE', '22738');
INSERT INTO public.products VALUES (182, 2.35, 17, NULL, 1615, 2, NULL, NULL, 'RIBBON REEL CHRISTMAS SOCK BAUBLE', '22739');
INSERT INTO public.products VALUES (587, 1.12, 22, NULL, 1616, 2, NULL, NULL, 'POLKADOT PEN', '22740');
INSERT INTO public.products VALUES (849, 1.10, 22, NULL, 1617, 2, NULL, NULL, 'FUNKY DIVA PEN', '22741');
INSERT INTO public.products VALUES (64, 3.01, 19, NULL, 1618, 2, NULL, NULL, 'MAKE YOUR OWN PLAYTIME CARD KIT', '22742');
INSERT INTO public.products VALUES (92, 3.64, 19, NULL, 1619, 2, NULL, NULL, 'MAKE YOUR OWN FLOWERPOWER CARD KIT', '22743');
INSERT INTO public.products VALUES (86, 3.11, 19, NULL, 1620, 2, NULL, NULL, 'MAKE YOUR OWN MONSOON CARD KIT', '22744');
INSERT INTO public.products VALUES (201, 2.54, 20, NULL, 1621, 2, NULL, NULL, 'POPPY''S PLAYHOUSE BEDROOM ', '22745');
INSERT INTO public.products VALUES (143, 2.51, 20, NULL, 1622, 2, NULL, NULL, 'POPPY''S PLAYHOUSE LIVINGROOM ', '22746');
INSERT INTO public.products VALUES (95, 2.49, 20, NULL, 1623, 2, NULL, NULL, 'POPPY''S PLAYHOUSE BATHROOM', '22747');
INSERT INTO public.products VALUES (210, 2.47, 20, NULL, 1624, 2, NULL, NULL, 'POPPY''S PLAYHOUSE KITCHEN', '22748');
INSERT INTO public.products VALUES (237, 4.11, 20, NULL, 1625, 2, NULL, NULL, 'FELTCRAFT PRINCESS CHARLOTTE DOLL', '22749');
INSERT INTO public.products VALUES (201, 4.05, 20, NULL, 1626, 2, NULL, NULL, 'FELTCRAFT PRINCESS LOLA DOLL', '22750');
INSERT INTO public.products VALUES (156, 4.23, 20, NULL, 1627, 2, NULL, NULL, 'FELTCRAFT PRINCESS OLIVIA DOLL', '22751');
INSERT INTO public.products VALUES (166, 9.77, 16, NULL, 1628, 2, NULL, NULL, 'SET 7 BABUSHKA NESTING BOXES', '22752');
INSERT INTO public.products VALUES (101, 0.97, 22, NULL, 1629, 2, NULL, NULL, 'SMALL YELLOW BABUSHKA NOTEBOOK ', '22753');
INSERT INTO public.products VALUES (195, 1.00, 22, NULL, 1630, 2, NULL, NULL, 'SMALL RED BABUSHKA NOTEBOOK ', '22754');
INSERT INTO public.products VALUES (169, 0.98, 22, NULL, 1631, 2, NULL, NULL, 'SMALL PURPLE BABUSHKA NOTEBOOK ', '22755');
INSERT INTO public.products VALUES (59, 1.43, 22, NULL, 1632, 2, NULL, NULL, 'LARGE YELLOW BABUSHKA NOTEBOOK ', '22756');
INSERT INTO public.products VALUES (109, 1.53, 22, NULL, 1633, 2, NULL, NULL, 'LARGE RED BABUSHKA NOTEBOOK ', '22757');
INSERT INTO public.products VALUES (119, 1.49, 22, NULL, 1634, 2, NULL, NULL, 'LARGE PURPLE BABUSHKA NOTEBOOK  ', '22758');
INSERT INTO public.products VALUES (520, 2.03, 22, NULL, 1635, 2, NULL, NULL, 'SET OF 3 NOTEBOOKS IN PARCEL', '22759');
INSERT INTO public.products VALUES (26, 14.55, 22, NULL, 1636, 2, NULL, NULL, 'TRAY, BREAKFAST IN BED', '22760');
INSERT INTO public.products VALUES (10, 25.40, 22, NULL, 1637, 2, NULL, NULL, 'CHEST 7 DRAWER MA CAMPAGNE', '22761');
INSERT INTO public.products VALUES (15, 17.48, 14, NULL, 1638, 2, NULL, NULL, 'CUPBOARD 3 DRAWER MA CAMPAGNE', '22762');
INSERT INTO public.products VALUES (20, 11.26, 22, NULL, 1639, 2, NULL, NULL, 'KEY CABINET MA CAMPAGNE', '22763');
INSERT INTO public.products VALUES (10, 31.20, 14, NULL, 1640, 2, NULL, NULL, 'RUSTIC WOODEN CABINET, GLASS DOORS', '22764');
INSERT INTO public.products VALUES (10, 19.87, 22, NULL, 1641, 2, NULL, NULL, 'NEWSPAPER STAND', '22765');
INSERT INTO public.products VALUES (324, 3.20, 15, NULL, 1642, 2, NULL, NULL, 'PHOTO FRAME CORNICE', '22766');
INSERT INTO public.products VALUES (73, 10.25, 15, NULL, 1643, 2, NULL, NULL, 'TRIPLE PHOTO FRAME CORNICE ', '22767');
INSERT INTO public.products VALUES (83, 10.86, 15, NULL, 1644, 2, NULL, NULL, 'FAMILY PHOTO FRAME CORNICE', '22768');
INSERT INTO public.products VALUES (10, 34.78, 22, NULL, 1645, 2, NULL, NULL, 'CHALKBOARD KITCHEN ORGANISER', '22769');
INSERT INTO public.products VALUES (10, 16.21, 22, NULL, 1646, 2, NULL, NULL, 'MIRROR CORNICE', '22770');
INSERT INTO public.products VALUES (660, 1.56, 22, NULL, 1647, 2, NULL, NULL, 'CLEAR DRAWER KNOB ACRYLIC EDWARDIAN', '22771');
INSERT INTO public.products VALUES (386, 1.66, 22, NULL, 1648, 2, NULL, NULL, 'PINK DRAWER KNOB ACRYLIC EDWARDIAN', '22772');
INSERT INTO public.products VALUES (208, 1.52, 22, NULL, 1649, 2, NULL, NULL, 'GREEN DRAWER KNOB ACRYLIC EDWARDIAN', '22773');
INSERT INTO public.products VALUES (226, 1.58, 22, NULL, 1650, 2, NULL, NULL, 'RED DRAWER KNOB ACRYLIC EDWARDIAN', '22774');
INSERT INTO public.products VALUES (319, 1.72, 22, NULL, 1651, 2, NULL, NULL, 'PURPLE DRAWERKNOB ACRYLIC EDWARDIAN', '22775');
INSERT INTO public.products VALUES (115, 11.32, 22, NULL, 1652, 2, NULL, NULL, 'SWEETHEART CAKESTAND 3 TIER', '22776');
INSERT INTO public.products VALUES (34, 10.52, 14, NULL, 1653, 2, NULL, NULL, 'GLASS BELL JAR LARGE', '22777');
INSERT INTO public.products VALUES (73, 4.71, 14, NULL, 1654, 2, NULL, NULL, 'GLASS CLOCHE SMALL', '22778');
INSERT INTO public.products VALUES (151, 4.19, 12, NULL, 1655, 2, NULL, NULL, 'WOODEN OWLS LIGHT GARLAND ', '22779');
INSERT INTO public.products VALUES (132, 4.19, 12, NULL, 1656, 2, NULL, NULL, 'LIGHT GARLAND BUTTERFILES PINK', '22780');
INSERT INTO public.products VALUES (57, 9.70, 22, NULL, 1657, 2, NULL, NULL, 'GUMBALL MAGAZINE RACK', '22781');
INSERT INTO public.products VALUES (24, 19.36, 16, NULL, 1658, 2, NULL, NULL, 'SET 3 WICKER STORAGE BASKETS ', '22782');
INSERT INTO public.products VALUES (46, 14.62, 16, NULL, 1659, 2, NULL, NULL, 'SET 3 WICKER OVAL BASKETS W LIDS', '22783');
INSERT INTO public.products VALUES (121, 5.58, 12, NULL, 1660, 2, NULL, NULL, 'LANTERN CREAM GAZEBO ', '22784');
INSERT INTO public.products VALUES (24, 7.30, 22, NULL, 1661, 2, NULL, NULL, 'SQUARECUSHION COVER PINK UNION FLAG', '22785');
INSERT INTO public.products VALUES (12, 7.62, 22, NULL, 1662, 2, NULL, NULL, 'CUSHION COVER PINK UNION JACK', '22786');
INSERT INTO public.products VALUES (21, 11.91, 22, NULL, 1663, 2, NULL, NULL, 'BROCANTE COAT RACK', '22788');
INSERT INTO public.products VALUES (85, 2.15, 12, NULL, 1664, 2, NULL, NULL, 'T-LIGHT HOLDER SWEETHEART HANGING', '22789');
INSERT INTO public.products VALUES (785, 1.50, 12, NULL, 1665, 2, NULL, NULL, 'T-LIGHT GLASS FLUTED ANTIQUE', '22791');
INSERT INTO public.products VALUES (272, 1.14, 12, NULL, 1666, 2, NULL, NULL, 'FLUTED ANTIQUE CANDLE HOLDER', '22792');
INSERT INTO public.products VALUES (32, 9.00, 22, NULL, 1667, 2, NULL, NULL, 'SWEETHEART WIRE MAGAZINE RACK', '22794');
INSERT INTO public.products VALUES (119, 8.08, 22, NULL, 1668, 2, NULL, NULL, 'SWEETHEART RECIPE BOOK STAND', '22795');
INSERT INTO public.products VALUES (16, 10.36, 15, NULL, 1669, 2, NULL, NULL, 'PHOTO FRAME 3 CLASSIC HANGING', '22796');
INSERT INTO public.products VALUES (12, 18.36, 22, NULL, 1670, 2, NULL, NULL, 'CHEST OF DRAWERS GINGHAM HEART ', '22797');
INSERT INTO public.products VALUES (175, 3.73, 14, NULL, 1671, 2, NULL, NULL, 'ANTIQUE GLASS DRESSING TABLE POT', '22798');
INSERT INTO public.products VALUES (20, 8.71, 22, NULL, 1672, 2, NULL, NULL, 'SWEETHEART WIRE FRUIT BOWL', '22799');
INSERT INTO public.products VALUES (86, 4.92, 14, NULL, 1673, 2, NULL, NULL, 'ANTIQUE TALL SWIRLGLASS TRINKET POT', '22800');
INSERT INTO public.products VALUES (101, 4.67, 14, NULL, 1674, 2, NULL, NULL, 'ANTIQUE GLASS PEDESTAL BOWL', '22801');
INSERT INTO public.products VALUES (10, 18.76, 22, NULL, 1675, 2, NULL, NULL, 'FAUX FUR CHOCOLATE THROW', '22802');
INSERT INTO public.products VALUES (10, 38.97, 22, NULL, 1676, 2, NULL, NULL, 'IVORY EMBROIDERED QUILT ', '22803');
INSERT INTO public.products VALUES (271, 3.17, 12, NULL, 1677, 2, NULL, NULL, 'CANDLEHOLDER PINK HANGING HEART', '22804');
INSERT INTO public.products VALUES (189, 1.67, 22, NULL, 1678, 2, NULL, NULL, 'BLUE DRAWER KNOB ACRYLIC EDWARDIAN', '22805');
INSERT INTO public.products VALUES (26, 3.39, 12, NULL, 1679, 2, NULL, NULL, 'SET OF 6 T-LIGHTS WEDDING CAKE ', '22806');
INSERT INTO public.products VALUES (82, 3.75, 12, NULL, 1680, 2, NULL, NULL, 'SET OF 6 T-LIGHTS TOADSTOOLS', '22807');
INSERT INTO public.products VALUES (32, 3.59, 12, NULL, 1681, 2, NULL, NULL, 'SET OF 6 T-LIGHTS EASTER CHICKS', '22808');
INSERT INTO public.products VALUES (122, 3.48, 12, NULL, 1682, 2, NULL, NULL, 'SET OF 6 T-LIGHTS SANTA', '22809');
INSERT INTO public.products VALUES (87, 3.56, 12, NULL, 1683, 2, NULL, NULL, 'SET OF 6 T-LIGHTS SNOWMEN', '22810');
INSERT INTO public.products VALUES (88, 3.83, 12, NULL, 1684, 2, NULL, NULL, 'SET OF 6 T-LIGHTS CACTI ', '22811');
INSERT INTO public.products VALUES (148, 2.77, 16, NULL, 1685, 2, NULL, NULL, 'PACK 3 BOXES CHRISTMAS PANNETONE', '22812');
INSERT INTO public.products VALUES (237, 2.65, 16, NULL, 1686, 2, NULL, NULL, 'PACK 3 BOXES BIRD PANNETONE ', '22813');
INSERT INTO public.products VALUES (214, 0.49, 19, NULL, 1687, 2, NULL, NULL, 'CARD PARTY GAMES ', '22814');
INSERT INTO public.products VALUES (264, 0.49, 19, NULL, 1688, 2, NULL, NULL, 'CARD PSYCHEDELIC APPLES', '22815');
INSERT INTO public.products VALUES (402, 0.46, 17, NULL, 1689, 2, NULL, NULL, 'CARD MOTORBIKE SANTA', '22816');
INSERT INTO public.products VALUES (263, 0.48, 19, NULL, 1690, 2, NULL, NULL, 'CARD SUKI BIRTHDAY', '22817');
INSERT INTO public.products VALUES (356, 0.46, 17, NULL, 1691, 2, NULL, NULL, 'CARD CHRISTMAS VILLAGE', '22818');
INSERT INTO public.products VALUES (260, 0.47, 19, NULL, 1692, 2, NULL, NULL, 'BIRTHDAY CARD, RETRO SPOT', '22819');
INSERT INTO public.products VALUES (93, 0.61, 13, NULL, 1693, 2, NULL, NULL, 'GIFT BAG BIRTHDAY', '22820');
INSERT INTO public.products VALUES (117, 0.70, 13, NULL, 1694, 2, NULL, NULL, 'GIFT BAG PSYCHEDELIC APPLES', '22821');
INSERT INTO public.products VALUES (43, 6.43, 22, NULL, 1695, 2, NULL, NULL, 'CREAM WALL PLANTER HEART SHAPED', '22822');
INSERT INTO public.products VALUES (10, 102.33, 22, NULL, 1696, 2, NULL, NULL, 'CHEST NATURAL WOOD 20 DRAWERS', '22823');
INSERT INTO public.products VALUES (10, 35.68, 22, NULL, 1697, 2, NULL, NULL, '3 TIER SWEETHEART GARDEN SHELF', '22824');
INSERT INTO public.products VALUES (10, 8.42, 22, NULL, 1698, 2, NULL, NULL, 'DECORATIVE PLANT POT WITH FRIEZE', '22825');
INSERT INTO public.products VALUES (10, 115.39, 22, NULL, 1699, 2, NULL, NULL, 'LOVE SEAT ANTIQUE WHITE METAL', '22826');
INSERT INTO public.products VALUES (10, 156.03, 22, NULL, 1700, 2, NULL, NULL, 'RUSTIC  SEVENTEEN DRAWER SIDEBOARD', '22827');
INSERT INTO public.products VALUES (10, 156.43, 22, NULL, 1701, 2, NULL, NULL, 'REGENCY MIRROR WITH SHUTTERS', '22828');
INSERT INTO public.products VALUES (21, 10.83, 22, NULL, 1702, 2, NULL, NULL, 'SWEETHEART WIRE WALL TIDY', '22829');
INSERT INTO public.products VALUES (13, 21.77, 22, NULL, 1703, 2, NULL, NULL, 'UTILTY CABINET WITH HOOKS', '22830');
INSERT INTO public.products VALUES (70, 3.32, 22, NULL, 1704, 2, NULL, NULL, 'WHITE BROCANTE SOAP DISH', '22831');
INSERT INTO public.products VALUES (15, 11.48, 22, NULL, 1705, 2, NULL, NULL, 'BROCANTE SHELF WITH HOOKS', '22832');
INSERT INTO public.products VALUES (10, 56.51, 22, NULL, 1706, 2, NULL, NULL, 'HALL CABINET WITH 3 DRAWERS', '22833');
INSERT INTO public.products VALUES (476, 2.21, 21, NULL, 1707, 2, NULL, NULL, 'HAND WARMER BABUSHKA DESIGN', '22834');
INSERT INTO public.products VALUES (308, 5.86, 14, NULL, 1708, 2, NULL, NULL, 'HOT WATER BOTTLE I AM SO POORLY', '22835');
INSERT INTO public.products VALUES (105, 5.49, 14, NULL, 1709, 2, NULL, NULL, 'HOT WATER BOTTLE BABUSHKA ', '22837');
INSERT INTO public.products VALUES (56, 17.06, 16, NULL, 1710, 2, NULL, NULL, '3 TIER CAKE TIN RED AND CREAM', '22838');
INSERT INTO public.products VALUES (43, 18.39, 16, NULL, 1711, 2, NULL, NULL, '3 TIER CAKE TIN GREEN AND CREAM', '22839');
INSERT INTO public.products VALUES (89, 8.34, 16, NULL, 1712, 2, NULL, NULL, 'ROUND CAKE TIN VINTAGE RED', '22840');
INSERT INTO public.products VALUES (51, 8.38, 16, NULL, 1713, 2, NULL, NULL, 'ROUND CAKE TIN VINTAGE GREEN', '22841');
INSERT INTO public.products VALUES (57, 7.14, 16, NULL, 1714, 2, NULL, NULL, 'BISCUIT TIN VINTAGE RED', '22842');
INSERT INTO public.products VALUES (44, 7.13, 16, NULL, 1715, 2, NULL, NULL, 'BISCUIT TIN VINTAGE GREEN', '22843');
INSERT INTO public.products VALUES (97, 10.77, 22, NULL, 1716, 2, NULL, NULL, 'VINTAGE CREAM DOG FOOD CONTAINER', '22844');
INSERT INTO public.products VALUES (78, 7.80, 22, NULL, 1717, 2, NULL, NULL, 'VINTAGE CREAM CAT FOOD CONTAINER', '22845');
INSERT INTO public.products VALUES (63, 17.62, 22, NULL, 1718, 2, NULL, NULL, 'BREAD BIN DINER STYLE RED ', '22846');
INSERT INTO public.products VALUES (86, 17.33, 22, NULL, 1719, 2, NULL, NULL, 'BREAD BIN DINER STYLE IVORY', '22847');
INSERT INTO public.products VALUES (31, 17.84, 22, NULL, 1720, 2, NULL, NULL, 'BREAD BIN DINER STYLE PINK', '22848');
INSERT INTO public.products VALUES (31, 16.86, 22, NULL, 1721, 2, NULL, NULL, 'BREAD BIN DINER STYLE MINT', '22849');
INSERT INTO public.products VALUES (273, 1.00, 21, NULL, 1722, 2, NULL, NULL, 'SET 20 NAPKINS FAIRY CAKES DESIGN ', '22851');
INSERT INTO public.products VALUES (38, 4.63, 22, NULL, 1723, 2, NULL, NULL, 'DOG BOWL VINTAGE CREAM', '22852');
INSERT INTO public.products VALUES (46, 3.63, 22, NULL, 1724, 2, NULL, NULL, 'CAT BOWL VINTAGE CREAM', '22853');
INSERT INTO public.products VALUES (76, 5.38, 22, NULL, 1725, 2, NULL, NULL, 'CREAM SWEETHEART EGG HOLDER', '22854');
INSERT INTO public.products VALUES (263, 1.52, 22, NULL, 1726, 2, NULL, NULL, 'FINE WICKER HEART ', '22855');
INSERT INTO public.products VALUES (51, 3.64, 22, NULL, 1727, 2, NULL, NULL, 'ASSORTED EASTER DECORATIONS  BELLS', '22856');
INSERT INTO public.products VALUES (111, 1.30, 22, NULL, 1728, 2, NULL, NULL, 'ASSORTED EASTER GIFT TAGS', '22857');
INSERT INTO public.products VALUES (111, 1.93, 16, NULL, 1729, 2, NULL, NULL, 'EASTER TIN KEEPSAKE', '22858');
INSERT INTO public.products VALUES (117, 1.91, 16, NULL, 1730, 2, NULL, NULL, 'EASTER TIN BUNNY BOUQUET', '22859');
INSERT INTO public.products VALUES (58, 1.95, 16, NULL, 1731, 2, NULL, NULL, 'EASTER TIN CHICKS PINK DAISY', '22860');
INSERT INTO public.products VALUES (30, 2.01, 16, NULL, 1732, 2, NULL, NULL, 'EASTER TIN CHICKS IN GARDEN', '22861');
INSERT INTO public.products VALUES (17, 5.40, 16, NULL, 1733, 2, NULL, NULL, 'LOVE HEART NAPKIN BOX ', '22862');
INSERT INTO public.products VALUES (70, 3.28, 22, NULL, 1734, 2, NULL, NULL, 'SOAP DISH BROCANTE', '22863');
INSERT INTO public.products VALUES (837, 2.35, 21, NULL, 1735, 2, NULL, NULL, 'HAND WARMER OWL DESIGN', '22865');
INSERT INTO public.products VALUES (652, 2.33, 21, NULL, 1736, 2, NULL, NULL, 'HAND WARMER SCOTTY DOG DESIGN', '22866');
INSERT INTO public.products VALUES (638, 2.39, 21, NULL, 1737, 2, NULL, NULL, 'HAND WARMER BIRD DESIGN', '22867');
INSERT INTO public.products VALUES (10, 2.99, 22, NULL, 1738, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 0 ', '22868');
INSERT INTO public.products VALUES (10, 3.16, 22, NULL, 1739, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 1', '22869');
INSERT INTO public.products VALUES (10, 3.23, 22, NULL, 1740, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 2', '22870');
INSERT INTO public.products VALUES (10, 3.26, 22, NULL, 1741, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 3 ', '22871');
INSERT INTO public.products VALUES (10, 3.19, 22, NULL, 1742, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 4', '22872');
INSERT INTO public.products VALUES (10, 3.05, 22, NULL, 1743, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 5', '22873');
INSERT INTO public.products VALUES (10, 2.94, 22, NULL, 1744, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 6', '22874');
INSERT INTO public.products VALUES (10, 2.91, 22, NULL, 1745, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 7', '22875');
INSERT INTO public.products VALUES (10, 2.94, 22, NULL, 1746, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 8', '22876');
INSERT INTO public.products VALUES (10, 2.60, 22, NULL, 1747, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN 9', '22877');
INSERT INTO public.products VALUES (10, 3.41, 22, NULL, 1748, 2, NULL, NULL, 'NUMBER TILE COTTAGE GARDEN No', '22878');
INSERT INTO public.products VALUES (10, 2.87, 22, NULL, 1749, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 0', '22879');
INSERT INTO public.products VALUES (10, 3.26, 22, NULL, 1750, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 1', '22880');
INSERT INTO public.products VALUES (10, 3.22, 22, NULL, 1751, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 2', '22881');
INSERT INTO public.products VALUES (10, 3.00, 22, NULL, 1752, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 3', '22882');
INSERT INTO public.products VALUES (10, 3.25, 22, NULL, 1753, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 4', '22883');
INSERT INTO public.products VALUES (10, 3.09, 22, NULL, 1754, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 5', '22884');
INSERT INTO public.products VALUES (10, 3.06, 22, NULL, 1755, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 6 ', '22885');
INSERT INTO public.products VALUES (10, 2.88, 22, NULL, 1756, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 7', '22886');
INSERT INTO public.products VALUES (10, 2.97, 22, NULL, 1757, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 8', '22887');
INSERT INTO public.products VALUES (10, 3.16, 22, NULL, 1758, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT 9 ', '22888');
INSERT INTO public.products VALUES (17, 3.54, 22, NULL, 1759, 2, NULL, NULL, 'NUMBER TILE VINTAGE FONT No ', '22889');
INSERT INTO public.products VALUES (36, 11.14, 22, NULL, 1760, 2, NULL, NULL, 'NOVELTY BISCUITS CAKE STAND 3 TIER', '22890');
INSERT INTO public.products VALUES (39, 5.64, 22, NULL, 1761, 2, NULL, NULL, 'TEA FOR ONE POLKADOT', '22891');
INSERT INTO public.products VALUES (232, 1.24, 22, NULL, 1762, 2, NULL, NULL, 'SET OF SALT AND PEPPER TOADSTOOLS', '22892');
INSERT INTO public.products VALUES (185, 0.63, 12, NULL, 1763, 2, NULL, NULL, 'MINI CAKE STAND T-LIGHT HOLDER', '22893');
INSERT INTO public.products VALUES (30, 10.17, 21, NULL, 1764, 2, NULL, NULL, 'TABLECLOTH RED APPLES DESIGN ', '22894');
INSERT INTO public.products VALUES (205, 3.59, 22, NULL, 1765, 2, NULL, NULL, 'SET OF 2 TEA TOWELS APPLE AND PEARS', '22895');
INSERT INTO public.products VALUES (157, 3.19, 13, NULL, 1766, 2, NULL, NULL, 'PEG BAG APPLES DESIGN', '22896');
INSERT INTO public.products VALUES (131, 1.80, 21, NULL, 1767, 2, NULL, NULL, 'OVEN MITT APPLES DESIGN', '22897');
INSERT INTO public.products VALUES (242, 2.55, 21, NULL, 1768, 2, NULL, NULL, 'CHILDRENS APRON APPLES DESIGN', '22898');
INSERT INTO public.products VALUES (206, 2.43, 20, NULL, 1769, 2, NULL, NULL, 'CHILDREN''S APRON DOLLY GIRL ', '22899');
INSERT INTO public.products VALUES (470, 3.71, 22, NULL, 1770, 2, NULL, NULL, ' SET 2 TEA TOWELS I LOVE LONDON ', '22900');
INSERT INTO public.products VALUES (127, 2.65, 13, NULL, 1771, 2, NULL, NULL, 'TOTE BAG I LOVE LONDON', '22902');
INSERT INTO public.products VALUES (19, 3.03, 22, NULL, 1772, 2, NULL, NULL, 'CALENDAR FAMILY FAVOURITES', '22903');
INSERT INTO public.products VALUES (183, 3.35, 21, NULL, 1773, 2, NULL, NULL, 'CALENDAR PAPER CUT DESIGN', '22904');
INSERT INTO public.products VALUES (58, 2.79, 21, NULL, 1774, 2, NULL, NULL, 'CALENDAR IN SEASON DESIGN', '22905');
INSERT INTO public.products VALUES (173, 2.04, 19, NULL, 1775, 2, NULL, NULL, '12 MESSAGE CARDS WITH ENVELOPES', '22906');
INSERT INTO public.products VALUES (653, 0.99, 21, NULL, 1776, 2, NULL, NULL, 'PACK OF 20 NAPKINS PANTRY DESIGN', '22907');
INSERT INTO public.products VALUES (438, 0.97, 22, NULL, 1777, 2, NULL, NULL, 'PACK OF 20 NAPKINS RED APPLES', '22908');
INSERT INTO public.products VALUES (872, 0.99, 17, NULL, 1778, 2, NULL, NULL, 'SET OF 20 VINTAGE CHRISTMAS NAPKINS', '22909');
INSERT INTO public.products VALUES (1025, 3.36, 17, NULL, 1779, 2, NULL, NULL, 'PAPER CHAIN KIT VINTAGE CHRISTMAS', '22910');
INSERT INTO public.products VALUES (45, 3.23, 22, NULL, 1780, 2, NULL, NULL, 'PAPER CHAIN KIT LONDON', '22911');
INSERT INTO public.products VALUES (28, 5.28, 22, NULL, 1781, 2, NULL, NULL, 'YELLOW COAT RACK PARIS FASHION', '22912');
INSERT INTO public.products VALUES (34, 5.54, 22, NULL, 1782, 2, NULL, NULL, 'RED COAT RACK PARIS FASHION', '22913');
INSERT INTO public.products VALUES (46, 5.49, 22, NULL, 1783, 2, NULL, NULL, 'BLUE COAT RACK PARIS FASHION', '22914');
INSERT INTO public.products VALUES (285, 1.15, 14, NULL, 1784, 2, NULL, NULL, 'ASSORTED BOTTLE TOP  MAGNETS ', '22915');
INSERT INTO public.products VALUES (189, 0.85, 22, NULL, 1785, 2, NULL, NULL, 'HERB MARKER THYME', '22916');
INSERT INTO public.products VALUES (193, 0.84, 22, NULL, 1786, 2, NULL, NULL, 'HERB MARKER ROSEMARY', '22917');
INSERT INTO public.products VALUES (186, 0.85, 22, NULL, 1787, 2, NULL, NULL, 'HERB MARKER PARSLEY', '22918');
INSERT INTO public.products VALUES (174, 0.84, 22, NULL, 1788, 2, NULL, NULL, 'HERB MARKER MINT', '22919');
INSERT INTO public.products VALUES (190, 0.85, 22, NULL, 1789, 2, NULL, NULL, 'HERB MARKER BASIL', '22920');
INSERT INTO public.products VALUES (170, 0.84, 22, NULL, 1790, 2, NULL, NULL, 'HERB MARKER CHIVES ', '22921');
INSERT INTO public.products VALUES (131, 1.71, 22, NULL, 1791, 2, NULL, NULL, 'FRIDGE MAGNETS US DINER ASSORTED', '22922');
INSERT INTO public.products VALUES (119, 0.96, 22, NULL, 1792, 2, NULL, NULL, 'FRIDGE MAGNETS LES ENFANTS ASSORTED', '22923');
INSERT INTO public.products VALUES (98, 1.32, 22, NULL, 1793, 2, NULL, NULL, 'FRIDGE MAGNETS LA VIE EN ROSE', '22924');
INSERT INTO public.products VALUES (44, 6.42, 22, NULL, 1794, 2, NULL, NULL, 'BLUE GIANT GARDEN THERMOMETER', '22925');
INSERT INTO public.products VALUES (58, 6.27, 22, NULL, 1795, 2, NULL, NULL, 'IVORY GIANT GARDEN THERMOMETER', '22926');
INSERT INTO public.products VALUES (37, 6.53, 22, NULL, 1796, 2, NULL, NULL, 'GREEN GIANT GARDEN THERMOMETER', '22927');
INSERT INTO public.products VALUES (28, 7.72, 22, NULL, 1797, 2, NULL, NULL, 'YELLOW GIANT GARDEN THERMOMETER', '22928');
INSERT INTO public.products VALUES (10, 64.06, 22, NULL, 1798, 2, NULL, NULL, 'SCHOOL DESK AND CHAIR ', '22929');
INSERT INTO public.products VALUES (101, 3.07, 22, NULL, 1799, 2, NULL, NULL, 'BAKING MOULD HEART MILK CHOCOLATE', '22930');
INSERT INTO public.products VALUES (81, 2.83, 22, NULL, 1800, 2, NULL, NULL, 'BAKING MOULD HEART WHITE CHOCOLATE', '22931');
INSERT INTO public.products VALUES (76, 2.70, 14, NULL, 1801, 2, NULL, NULL, 'BAKING MOULD TOFFEE CUP CHOCOLATE', '22932');
INSERT INTO public.products VALUES (78, 3.47, 22, NULL, 1802, 2, NULL, NULL, 'BAKING MOULD EASTER EGG MILK CHOC', '22933');
INSERT INTO public.products VALUES (58, 3.22, 22, NULL, 1803, 2, NULL, NULL, 'BAKING MOULD EASTER EGG WHITE CHOC', '22934');
INSERT INTO public.products VALUES (61, 3.79, 22, NULL, 1804, 2, NULL, NULL, 'BAKING MOULD ROSE MILK CHOCOLATE', '22935');
INSERT INTO public.products VALUES (20, 4.30, 22, NULL, 1805, 2, NULL, NULL, 'BAKING MOULD ROSE WHITE CHOCOLATE', '22936');
INSERT INTO public.products VALUES (96, 2.91, 14, NULL, 1806, 2, NULL, NULL, 'BAKING MOULD CHOCOLATE CUPCAKES', '22937');
INSERT INTO public.products VALUES (230, 2.09, 14, NULL, 1807, 2, NULL, NULL, 'CUPCAKE LACE PAPER SET 6', '22938');
INSERT INTO public.products VALUES (45, 5.98, 12, NULL, 1808, 2, NULL, NULL, 'APRON APPLE DELIGHT', '22939');
INSERT INTO public.products VALUES (189, 4.53, 17, NULL, 1809, 2, NULL, NULL, 'FELTCRAFT CHRISTMAS FAIRY', '22940');
INSERT INTO public.products VALUES (162, 9.86, 12, NULL, 1810, 2, NULL, NULL, 'CHRISTMAS LIGHTS 10 REINDEER', '22941');
INSERT INTO public.products VALUES (53, 8.34, 12, NULL, 1811, 2, NULL, NULL, 'CHRISTMAS LIGHTS 10 SANTAS ', '22942');
INSERT INTO public.products VALUES (129, 6.12, 12, NULL, 1812, 2, NULL, NULL, 'CHRISTMAS LIGHTS 10 VINTAGE BAUBLES', '22943');
INSERT INTO public.products VALUES (332, 1.30, 17, NULL, 1813, 2, NULL, NULL, 'CHRISTMAS METAL POSTCARD WITH BELLS', '22944');
INSERT INTO public.products VALUES (212, 2.14, 17, NULL, 1814, 2, NULL, NULL, 'CHRISTMAS METAL TAGS ASSORTED ', '22945');
INSERT INTO public.products VALUES (41, 17.91, 22, NULL, 1815, 2, NULL, NULL, 'WOODEN ADVENT CALENDAR CREAM', '22946');
INSERT INTO public.products VALUES (74, 13.14, 22, NULL, 1816, 2, NULL, NULL, 'WOODEN ADVENT CALENDAR RED', '22947');
INSERT INTO public.products VALUES (148, 1.64, 22, NULL, 1817, 2, NULL, NULL, 'METAL DECORATION NAUGHTY CHILDREN ', '22948');
INSERT INTO public.products VALUES (95, 1.71, 20, NULL, 1818, 2, NULL, NULL, '36 DOILIES DOLLY GIRL', '22949');
INSERT INTO public.products VALUES (488, 1.58, 17, NULL, 1819, 2, NULL, NULL, '36 DOILIES VINTAGE CHRISTMAS', '22950');
INSERT INTO public.products VALUES (739, 0.67, 20, NULL, 1820, 2, NULL, NULL, '60 CAKE CASES DOLLY GIRL DESIGN', '22951');
INSERT INTO public.products VALUES (1576, 0.76, 17, NULL, 1821, 2, NULL, NULL, '60 CAKE CASES VINTAGE CHRISTMAS', '22952');
INSERT INTO public.products VALUES (50, 1.36, 22, NULL, 1822, 2, NULL, NULL, 'BIRTHDAY PARTY CORDON BARRIER TAPE', '22953');
INSERT INTO public.products VALUES (20, 1.38, 22, NULL, 1823, 2, NULL, NULL, 'HEN PARTY CORDON BARRIER TAPE', '22954');
INSERT INTO public.products VALUES (119, 2.29, 22, NULL, 1824, 2, NULL, NULL, '36 FOIL STAR CAKE CASES ', '22955');
INSERT INTO public.products VALUES (190, 2.21, 22, NULL, 1825, 2, NULL, NULL, '36 FOIL HEART CAKE CASES', '22956');
INSERT INTO public.products VALUES (175, 3.11, 22, NULL, 1826, 2, NULL, NULL, 'SET 3 PAPER VINTAGE CHICK PAPER EGG', '22957');
INSERT INTO public.products VALUES (442, 0.42, 17, NULL, 1827, 2, NULL, NULL, 'WRAP CHRISTMAS VILLAGE', '22959');
INSERT INTO public.products VALUES (847, 5.01, 16, NULL, 1828, 2, NULL, NULL, 'JAM MAKING SET WITH JARS', '22960');
INSERT INTO public.products VALUES (1608, 1.90, 22, NULL, 1829, 2, NULL, NULL, 'JAM MAKING SET PRINTED', '22961');
INSERT INTO public.products VALUES (381, 1.04, 16, NULL, 1830, 2, NULL, NULL, 'JAM JAR WITH PINK LID', '22962');
INSERT INTO public.products VALUES (317, 1.07, 16, NULL, 1831, 2, NULL, NULL, 'JAM JAR WITH GREEN LID', '22963');
INSERT INTO public.products VALUES (261, 2.52, 22, NULL, 1832, 2, NULL, NULL, '3 PIECE SPACEBOY COOKIE CUTTER SET', '22964');
INSERT INTO public.products VALUES (133, 2.34, 22, NULL, 1833, 2, NULL, NULL, '3 TRADITIONAL COOKIE CUTTERS  SET', '22965');
INSERT INTO public.products VALUES (744, 1.45, 22, NULL, 1834, 2, NULL, NULL, 'GINGERBREAD MAN COOKIE CUTTER', '22966');
INSERT INTO public.products VALUES (115, 3.01, 22, NULL, 1835, 2, NULL, NULL, 'SET 3 SONG BIRD PAPER EGGS ASSORTED', '22967');
INSERT INTO public.products VALUES (72, 11.79, 16, NULL, 1836, 2, NULL, NULL, 'ROSE COTTAGE KEEPSAKE BOX ', '22968');
INSERT INTO public.products VALUES (1239, 1.79, 12, NULL, 1837, 2, NULL, NULL, 'HOMEMADE JAM SCENTED CANDLES', '22969');
INSERT INTO public.products VALUES (435, 2.72, 14, NULL, 1838, 2, NULL, NULL, 'LONDON BUS COFFEE MUG', '22970');
INSERT INTO public.products VALUES (241, 2.77, 14, NULL, 1839, 2, NULL, NULL, 'QUEENS GUARD COFFEE MUG', '22971');
INSERT INTO public.products VALUES (176, 1.97, 14, NULL, 1840, 2, NULL, NULL, 'CHILDREN''S SPACEBOY MUG', '22972');
INSERT INTO public.products VALUES (123, 2.02, 14, NULL, 1841, 2, NULL, NULL, 'CHILDREN''S CIRCUS PARADE MUG', '22973');
INSERT INTO public.products VALUES (158, 2.02, 14, NULL, 1842, 2, NULL, NULL, 'CHILDRENS DOLLY GIRL MUG', '22974');
INSERT INTO public.products VALUES (120, 1.54, 14, NULL, 1843, 2, NULL, NULL, 'SPACEBOY CHILDRENS EGG CUP', '22975');
INSERT INTO public.products VALUES (105, 1.50, 14, NULL, 1844, 2, NULL, NULL, 'CIRCUS PARADE CHILDRENS EGG CUP ', '22976');
INSERT INTO public.products VALUES (95, 1.48, 14, NULL, 1845, 2, NULL, NULL, 'DOLLY GIRL CHILDRENS EGG CUP', '22977');
INSERT INTO public.products VALUES (239, 4.31, 22, NULL, 1846, 2, NULL, NULL, 'PANTRY ROLLING PIN', '22978');
INSERT INTO public.products VALUES (400, 1.81, 22, NULL, 1847, 2, NULL, NULL, 'PANTRY WASHING UP BRUSH', '22979');
INSERT INTO public.products VALUES (228, 1.91, 22, NULL, 1848, 2, NULL, NULL, 'PANTRY SCRUBBING BRUSH', '22980');
INSERT INTO public.products VALUES (46, 1.86, 22, NULL, 1849, 2, NULL, NULL, 'PANTRY APPLE CORER', '22981');
INSERT INTO public.products VALUES (113, 1.63, 22, NULL, 1850, 2, NULL, NULL, 'PANTRY PASTRY BRUSH', '22982');
INSERT INTO public.products VALUES (512, 0.52, 19, NULL, 1851, 2, NULL, NULL, 'CARD BILLBOARD FONT', '22983');
INSERT INTO public.products VALUES (271, 0.48, 19, NULL, 1852, 2, NULL, NULL, 'CARD GINGHAM ROSE ', '22984');
INSERT INTO public.products VALUES (378, 0.42, 19, NULL, 1853, 2, NULL, NULL, 'WRAP, BILLBOARD FONTS DESIGN', '22985');
INSERT INTO public.products VALUES (408, 0.42, 19, NULL, 1854, 2, NULL, NULL, 'GINGHAM ROSE WRAP', '22986');
INSERT INTO public.products VALUES (10, 0.42, 19, NULL, 1855, 2, NULL, NULL, 'WRAP SUMMER ROSE DESIGN', '22987');
INSERT INTO public.products VALUES (902, 1.49, 14, NULL, 1856, 2, NULL, NULL, 'SOLDIERS EGG CUP ', '22988');
INSERT INTO public.products VALUES (279, 3.68, 21, NULL, 1857, 2, NULL, NULL, 'SET 2 PANTRY DESIGN TEA TOWELS', '22989');
INSERT INTO public.products VALUES (51, 5.28, 21, NULL, 1858, 2, NULL, NULL, 'COTTON APRON PANTRY DESIGN', '22990');
INSERT INTO public.products VALUES (317, 2.26, 22, NULL, 1859, 2, NULL, NULL, 'GIRAFFE WOODEN RULER', '22991');
INSERT INTO public.products VALUES (452, 2.26, 22, NULL, 1860, 2, NULL, NULL, 'REVOLVER WOODEN RULER ', '22992');
INSERT INTO public.products VALUES (1260, 1.49, 22, NULL, 1861, 2, NULL, NULL, 'SET OF 4 PANTRY JELLY MOULDS', '22993');
INSERT INTO public.products VALUES (216, 0.52, 13, NULL, 1862, 2, NULL, NULL, 'TRAVEL CARD WALLET RETROSPOT', '22994');
INSERT INTO public.products VALUES (234, 0.54, 13, NULL, 1863, 2, NULL, NULL, 'TRAVEL CARD WALLET SUKI', '22995');
INSERT INTO public.products VALUES (478, 0.53, 13, NULL, 1864, 2, NULL, NULL, 'TRAVEL CARD WALLET VINTAGE TICKET', '22996');
INSERT INTO public.products VALUES (251, 0.49, 13, NULL, 1865, 2, NULL, NULL, 'TRAVEL CARD WALLET UNION JACK', '22997');
INSERT INTO public.products VALUES (1231, 0.49, 13, NULL, 1866, 2, NULL, NULL, 'TRAVEL CARD WALLET KEEP CALM', '22998');
INSERT INTO public.products VALUES (295, 0.48, 13, NULL, 1867, 2, NULL, NULL, 'TRAVEL CARD WALLET RETRO PETALS', '22999');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2867, 2, NULL, NULL, 'Unsaleable, destroyed.', '79323S');
INSERT INTO public.products VALUES (313, 0.52, 13, NULL, 1868, 2, NULL, NULL, 'TRAVEL CARD WALLET TRANSPORT', '23000');
INSERT INTO public.products VALUES (20, 0.00, 13, NULL, 1869, 2, NULL, NULL, 'TRAVEL CARD WALLET DOTCOMGIFTSHOP', '23001');
INSERT INTO public.products VALUES (201, 0.52, 13, NULL, 1870, 2, NULL, NULL, 'TRAVEL CARD WALLET SKULLS', '23002');
INSERT INTO public.products VALUES (10, 0.41, 13, NULL, 1871, 2, NULL, NULL, 'TRAVEL CARD WALLET VINTAGE ROSE ', '23003');
INSERT INTO public.products VALUES (182, 0.60, 13, NULL, 1872, 2, NULL, NULL, 'TRAVEL CARD WALLET PANTRY', '23004');
INSERT INTO public.products VALUES (10, 0.52, 13, NULL, 1873, 2, NULL, NULL, 'TRAVEL CARD WALLET I LOVE LONDON', '23005');
INSERT INTO public.products VALUES (168, 0.52, 13, NULL, 1874, 2, NULL, NULL, 'TRAVEL CARD WALLET FLOWER MEADOW', '23006');
INSERT INTO public.products VALUES (49, 15.94, 22, NULL, 1875, 2, NULL, NULL, ' SPACEBOY BABY GIFT SET', '23007');
INSERT INTO public.products VALUES (42, 16.16, 20, NULL, 1876, 2, NULL, NULL, 'DOLLY GIRL BABY GIFT SET', '23008');
INSERT INTO public.products VALUES (26, 15.99, 22, NULL, 1877, 2, NULL, NULL, 'I LOVE LONDON BABY GIFT SET', '23009');
INSERT INTO public.products VALUES (31, 16.31, 22, NULL, 1878, 2, NULL, NULL, 'CIRCUS PARADE BABY GIFT SET', '23010');
INSERT INTO public.products VALUES (106, 4.61, 14, NULL, 1879, 2, NULL, NULL, 'GLASS APOTHECARY BOTTLE PERFUME', '23012');
INSERT INTO public.products VALUES (91, 4.66, 14, NULL, 1880, 2, NULL, NULL, 'GLASS APOTHECARY BOTTLE TONIC', '23013');
INSERT INTO public.products VALUES (84, 4.84, 14, NULL, 1881, 2, NULL, NULL, 'GLASS APOTHECARY BOTTLE ELIXIR', '23014');
INSERT INTO public.products VALUES (10, 8.61, 14, NULL, 1882, 2, NULL, NULL, 'CORDIAL GLASS JUG', '23015');
INSERT INTO public.products VALUES (10, 8.63, 14, NULL, 1883, 2, NULL, NULL, 'GLASS TWIST BON BON JAR', '23016');
INSERT INTO public.products VALUES (10, 12.75, 16, NULL, 1884, 2, NULL, NULL, 'APOTHECARY MEASURING JAR', '23017');
INSERT INTO public.products VALUES (10, 12.90, 16, NULL, 1885, 2, NULL, NULL, 'LARGE APOTHECARY MEASURING JAR ', '23018');
INSERT INTO public.products VALUES (10, 8.08, 16, NULL, 1886, 2, NULL, NULL, 'SMALL APOTHECARY MEASURING JAR ', '23019');
INSERT INTO public.products VALUES (17, 12.79, 14, NULL, 1887, 2, NULL, NULL, 'GLASS  SONGBIRD STORAGE JAR', '23020');
INSERT INTO public.products VALUES (12, 4.43, 14, NULL, 1888, 2, NULL, NULL, 'GLASS BONNE JAM JAR', '23021');
INSERT INTO public.products VALUES (39, 2.04, 12, NULL, 1889, 2, NULL, NULL, 'SMALL BONNE JAM JAR  T-LIGHT HOLDER', '23022');
INSERT INTO public.products VALUES (28, 1.75, 12, NULL, 1890, 2, NULL, NULL, 'RIDGED BONNE JAM JAR T-LIGHT HOLDER', '23023');
INSERT INTO public.products VALUES (25, 2.97, 12, NULL, 1891, 2, NULL, NULL, 'LARGE BONNE JAM JAR  T-LIGHT HOLDER', '23024');
INSERT INTO public.products VALUES (34, 2.27, 14, NULL, 1892, 2, NULL, NULL, 'DRAWER KNOB VINTAGE GLASS BALL', '23025');
INSERT INTO public.products VALUES (54, 2.32, 14, NULL, 1893, 2, NULL, NULL, 'DRAWER KNOB VINTAGE GLASS STAR', '23026');
INSERT INTO public.products VALUES (29, 2.22, 14, NULL, 1894, 2, NULL, NULL, 'DRAWER KNOB VINTAGE GLASS HEXAGON', '23027');
INSERT INTO public.products VALUES (136, 1.92, 22, NULL, 1895, 2, NULL, NULL, 'DRAWER KNOB CRACKLE GLAZE BLUE', '23028');
INSERT INTO public.products VALUES (130, 1.82, 22, NULL, 1896, 2, NULL, NULL, 'DRAWER KNOB CRACKLE GLAZE GREEN', '23029');
INSERT INTO public.products VALUES (127, 1.82, 22, NULL, 1897, 2, NULL, NULL, 'DRAWER KNOB CRACKLE GLAZE PINK', '23031');
INSERT INTO public.products VALUES (223, 1.76, 22, NULL, 1898, 2, NULL, NULL, 'DRAWER KNOB CRACKLE GLAZE IVORY', '23032');
INSERT INTO public.products VALUES (72, 1.81, 22, NULL, 1899, 2, NULL, NULL, 'DRAWER KNOB CERAMIC RED', '23033');
INSERT INTO public.products VALUES (98, 1.62, 22, NULL, 1900, 2, NULL, NULL, 'DRAWER KNOB CERAMIC BLACK', '23034');
INSERT INTO public.products VALUES (213, 1.63, 22, NULL, 1901, 2, NULL, NULL, 'DRAWER KNOB CERAMIC IVORY', '23035');
INSERT INTO public.products VALUES (18, 1.32, 12, NULL, 1902, 2, NULL, NULL, 'T-LIGHT HOLDER SILVER PETIT FOUR ', '23036');
INSERT INTO public.products VALUES (19, 1.89, 12, NULL, 1903, 2, NULL, NULL, 'CANDLE HOLDER SILVER MADELINE', '23037');
INSERT INTO public.products VALUES (10, 1.33, 12, NULL, 1904, 2, NULL, NULL, 'T-LIGHT HOLDER SILVER SAUCER', '23038');
INSERT INTO public.products VALUES (19, 2.38, 12, NULL, 1905, 2, NULL, NULL, 'T-LIGHT HOLDER SILVER HEART HANDLE', '23039');
INSERT INTO public.products VALUES (25, 6.28, 12, NULL, 1906, 2, NULL, NULL, 'PAPER LANTERN 9 POINT SNOW STAR ', '23040');
INSERT INTO public.products VALUES (24, 4.60, 12, NULL, 1907, 2, NULL, NULL, 'PAPER LANTERN 9 POINT SNOW STAR', '23041');
INSERT INTO public.products VALUES (10, 7.34, 12, NULL, 1908, 2, NULL, NULL, 'PAPER LANTERN 7 POINT SNOW STAR', '23042');
INSERT INTO public.products VALUES (10, 7.33, 12, NULL, 1909, 2, NULL, NULL, 'PAPER LANTERN 9 POINT HOLLY STAR 40', '23043');
INSERT INTO public.products VALUES (10, 4.30, 12, NULL, 1910, 2, NULL, NULL, 'PAPER LANTERN 9 POINT HOLLY STAR S', '23044');
INSERT INTO public.products VALUES (10, 4.47, 12, NULL, 1911, 2, NULL, NULL, 'PAPER LANTERN 5 POINT STAR MOON 30', '23045');
INSERT INTO public.products VALUES (34, 6.81, 12, NULL, 1912, 2, NULL, NULL, 'PAPER LANTERN 9 POINT DELUXE STAR', '23046');
INSERT INTO public.products VALUES (10, 5.75, 12, NULL, 1913, 2, NULL, NULL, 'PAPER LANTERN 5 POINT SEQUIN STAR', '23047');
INSERT INTO public.products VALUES (54, 4.63, 12, NULL, 1914, 2, NULL, NULL, 'SET OF 10 LANTERNS FAIRY LIGHT STAR', '23048');
INSERT INTO public.products VALUES (45, 8.91, 22, NULL, 1915, 2, NULL, NULL, 'RECYCLED ACAPULCO MAT RED', '23049');
INSERT INTO public.products VALUES (49, 9.22, 22, NULL, 1916, 2, NULL, NULL, 'RECYCLED ACAPULCO MAT GREEN', '23050');
INSERT INTO public.products VALUES (36, 9.62, 22, NULL, 1917, 2, NULL, NULL, 'RECYCLED ACAPULCO MAT BLUE', '23051');
INSERT INTO public.products VALUES (65, 9.78, 22, NULL, 1918, 2, NULL, NULL, 'RECYCLED ACAPULCO MAT TURQUOISE', '23052');
INSERT INTO public.products VALUES (36, 9.80, 22, NULL, 1919, 2, NULL, NULL, 'RECYCLED ACAPULCO MAT PINK', '23053');
INSERT INTO public.products VALUES (29, 9.51, 22, NULL, 1920, 2, NULL, NULL, 'RECYCLED ACAPULCO MAT LAVENDER', '23054');
INSERT INTO public.products VALUES (10, 5.13, 12, NULL, 1921, 2, NULL, NULL, 'IVORY CHANDELIER T-LIGHT HOLDER', '23055');
INSERT INTO public.products VALUES (17, 5.73, 12, NULL, 1922, 2, NULL, NULL, 'FLOWERS CHANDELIER T-LIGHT HOLDER', '23056');
INSERT INTO public.products VALUES (10, 4.43, 12, NULL, 1923, 2, NULL, NULL, 'GEMSTONE CHANDELIER T-LIGHT HOLDER', '23057');
INSERT INTO public.products VALUES (49, 1.23, 17, NULL, 1924, 2, NULL, NULL, 'CHRISTMAS HANGING SNOWFLAKE', '23058');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 1925, 2, NULL, NULL, 'Thrown away-rusty', '23059');
INSERT INTO public.products VALUES (24, 2.22, 22, NULL, 1926, 2, NULL, NULL, 'HEART BEADED TRELLIS DECORATION', '23060');
INSERT INTO public.products VALUES (103, 1.53, 22, NULL, 1927, 2, NULL, NULL, 'VINTAGE EMBOSSED HEART', '23061');
INSERT INTO public.products VALUES (14, 42.63, 22, NULL, 1928, 2, NULL, NULL, 'CINDERELLA CHANDELIER ', '23064');
INSERT INTO public.products VALUES (27, 12.97, 22, NULL, 1929, 2, NULL, NULL, 'LARGE DECO JEWELLERY STAND', '23065');
INSERT INTO public.products VALUES (25, 8.91, 22, NULL, 1930, 2, NULL, NULL, 'SMALL DECO JEWELLERY STAND', '23066');
INSERT INTO public.products VALUES (29, 4.34, 22, NULL, 1931, 2, NULL, NULL, 'HANGING ENGRAVED METAL HEART', '23067');
INSERT INTO public.products VALUES (81, 2.58, 22, NULL, 1932, 2, NULL, NULL, 'ALUMINIUM STAMPED HEART', '23068');
INSERT INTO public.products VALUES (10, 6.44, 15, NULL, 1933, 2, NULL, NULL, 'EDWARDIAN PHOTO FRAME', '23069');
INSERT INTO public.products VALUES (16, 5.09, 15, NULL, 1934, 2, NULL, NULL, 'EDWARDIAN HEART PHOTO FRAME', '23070');
INSERT INTO public.products VALUES (17, 10.18, 16, NULL, 1935, 2, NULL, NULL, 'MARIE ANTOIENETT TRINKET BOX GOLD', '23071');
INSERT INTO public.products VALUES (21, 12.77, 16, NULL, 1936, 2, NULL, NULL, 'MARIE ANTOINETTE TRINKET BOX SILVER', '23072');
INSERT INTO public.products VALUES (14, 12.41, 16, NULL, 1937, 2, NULL, NULL, 'GEORGIAN TRINKET BOX', '23073');
INSERT INTO public.products VALUES (24, 2.60, 16, NULL, 1938, 2, NULL, NULL, 'EMBOSSED HEART TRINKET BOX', '23074');
INSERT INTO public.products VALUES (44, 4.24, 22, NULL, 1939, 2, NULL, NULL, 'DOUBLE CERAMIC PARLOUR HOOK', '23075');
INSERT INTO public.products VALUES (807, 1.35, 22, NULL, 1940, 2, NULL, NULL, 'ICE CREAM SUNDAE LIP GLOSS', '23076');
INSERT INTO public.products VALUES (1035, 1.34, 22, NULL, 1941, 2, NULL, NULL, 'DOUGHNUT LIP GLOSS ', '23077');
INSERT INTO public.products VALUES (678, 1.43, 22, NULL, 1942, 2, NULL, NULL, 'ICE CREAM PEN LIP GLOSS ', '23078');
INSERT INTO public.products VALUES (23, 8.94, 12, NULL, 1943, 2, NULL, NULL, 'TOADSTOOL BEDSIDE LIGHT ', '23079');
INSERT INTO public.products VALUES (106, 9.30, 16, NULL, 1944, 2, NULL, NULL, 'RED METAL BOX TOP SECRET', '23080');
INSERT INTO public.products VALUES (47, 9.37, 16, NULL, 1945, 2, NULL, NULL, 'GREEN METAL BOX ARMY SUPPLIES', '23081');
INSERT INTO public.products VALUES (230, 4.08, 12, NULL, 1946, 2, NULL, NULL, 'SET 6 PAPER TABLE LANTERN HEARTS ', '23082');
INSERT INTO public.products VALUES (187, 4.23, 12, NULL, 1947, 2, NULL, NULL, 'SET 6 PAPER TABLE LANTERN STARS ', '23083');
INSERT INTO public.products VALUES (3031, 2.36, 12, NULL, 1948, 2, NULL, NULL, 'RABBIT NIGHT LIGHT', '23084');
INSERT INTO public.products VALUES (36, 10.75, 22, NULL, 1949, 2, NULL, NULL, 'ANTIQUE SILVER BAUBLE LAMP  ', '23085');
INSERT INTO public.products VALUES (121, 1.51, 12, NULL, 1950, 2, NULL, NULL, 'ZINC  STAR T-LIGHT HOLDER ', '23086');
INSERT INTO public.products VALUES (85, 1.59, 12, NULL, 1951, 2, NULL, NULL, 'ZINC  HEART T-LIGHT HOLDER', '23087');
INSERT INTO public.products VALUES (79, 1.63, 12, NULL, 1952, 2, NULL, NULL, 'ZINC HEART FLOWER T-LIGHT HOLDER', '23088');
INSERT INTO public.products VALUES (234, 2.36, 14, NULL, 1953, 2, NULL, NULL, 'GLASS BON BON JAR', '23089');
INSERT INTO public.products VALUES (189, 0.97, 12, NULL, 1954, 2, NULL, NULL, 'VINTAGE GLASS T-LIGHT HOLDER', '23090');
INSERT INTO public.products VALUES (58, 6.67, 22, NULL, 1955, 2, NULL, NULL, 'ZINC HERB GARDEN CONTAINER', '23091');
INSERT INTO public.products VALUES (51, 8.08, 15, NULL, 1956, 2, NULL, NULL, 'LARGE ANTIQUE WHITE PHOTO FRAME', '23092');
INSERT INTO public.products VALUES (93, 2.78, 15, NULL, 1957, 2, NULL, NULL, 'SMALL PARISIENNE HEART PHOTO FRAME ', '23093');
INSERT INTO public.products VALUES (15, 12.81, 22, NULL, 1958, 2, NULL, NULL, 'LE GRAND TRAY CHIC SET', '23094');
INSERT INTO public.products VALUES (104, 2.02, 22, NULL, 1959, 2, NULL, NULL, 'PETIT TRAY CHIC', '23096');
INSERT INTO public.products VALUES (12, 7.01, 12, NULL, 1960, 2, NULL, NULL, 'FRENCH CARRIAGE LANTERN', '23099');
INSERT INTO public.products VALUES (216, 1.42, 22, NULL, 1961, 2, NULL, NULL, 'SILVER BELLS TABLE DECORATION', '23100');
INSERT INTO public.products VALUES (203, 0.97, 22, NULL, 1962, 2, NULL, NULL, 'SILVER STARS TABLE DECORATION', '23101');
INSERT INTO public.products VALUES (128, 0.97, 22, NULL, 1963, 2, NULL, NULL, 'SILVER HEARTS TABLE DECORATION', '23102');
INSERT INTO public.products VALUES (405, 1.84, 22, NULL, 1964, 2, NULL, NULL, 'BELL HEART DECORATION', '23103');
INSERT INTO public.products VALUES (11, 12.86, 22, NULL, 1965, 2, NULL, NULL, 'IVORY PANTRY HANGING LAMP ', '23104');
INSERT INTO public.products VALUES (27, 2.94, 22, NULL, 1966, 2, NULL, NULL, 'ZINC HEARTS PLANT POT HOLDER', '23106');
INSERT INTO public.products VALUES (35, 3.20, 22, NULL, 1967, 2, NULL, NULL, 'WHITE WIRE PLANT POT HOLDER', '23107');
INSERT INTO public.products VALUES (215, 6.44, 12, NULL, 1968, 2, NULL, NULL, 'SET OF 10 LED DOLLY LIGHTS', '23108');
INSERT INTO public.products VALUES (230, 3.26, 12, NULL, 1969, 2, NULL, NULL, 'LED TEA LIGHTS', '23109');
INSERT INTO public.products VALUES (65, 6.57, 22, NULL, 1970, 2, NULL, NULL, 'PARISIENNE KEY CABINET ', '23110');
INSERT INTO public.products VALUES (28, 13.36, 16, NULL, 1971, 2, NULL, NULL, 'PARISIENNE SEWING BOX', '23111');
INSERT INTO public.products VALUES (51, 9.03, 22, NULL, 1972, 2, NULL, NULL, 'PARISIENNE CURIO CABINET', '23112');
INSERT INTO public.products VALUES (10, 6.13, 22, NULL, 1973, 2, NULL, NULL, 'Damaged', '23113');
INSERT INTO public.products VALUES (10, 5.32, 22, NULL, 1974, 2, NULL, NULL, 'Damaged', '23114');
INSERT INTO public.products VALUES (10, 5.68, 22, NULL, 1975, 2, NULL, NULL, 'Damaged', '23115');
INSERT INTO public.products VALUES (10, 5.93, 22, NULL, 1976, 2, NULL, NULL, 'Damaged', '23116');
INSERT INTO public.products VALUES (10, 5.47, 22, NULL, 1977, 2, NULL, NULL, 'Damaged', '23117');
INSERT INTO public.products VALUES (76, 8.25, 22, NULL, 1978, 2, NULL, NULL, 'PARISIENNE JEWELLERY DRAWER ', '23118');
INSERT INTO public.products VALUES (224, 0.78, 22, NULL, 1979, 2, NULL, NULL, 'PACK OF 6 LARGE FRUIT STRAWS ', '23119');
INSERT INTO public.products VALUES (164, 0.46, 22, NULL, 1980, 2, NULL, NULL, 'PACK OF 6 SMALL FRUIT STRAWS', '23120');
INSERT INTO public.products VALUES (250, 0.55, 22, NULL, 1981, 2, NULL, NULL, 'PACK OF 6 COCKTAIL PARASOL STRAWS', '23121');
INSERT INTO public.products VALUES (225, 1.03, 22, NULL, 1982, 2, NULL, NULL, 'PARTY CHARMS 50 PIECES', '23122');
INSERT INTO public.products VALUES (93, 1.01, 22, NULL, 1983, 2, NULL, NULL, 'COCKTAIL SWORDS 50 PIECES', '23123');
INSERT INTO public.products VALUES (56, 1.75, 22, NULL, 1984, 2, NULL, NULL, '18PC WOODEN CUTLERY SET DISPOSABLE', '23124');
INSERT INTO public.products VALUES (45, 1.91, 22, NULL, 1985, 2, NULL, NULL, '6PC WOOD PLATE SET DISPOSABLE', '23125');
INSERT INTO public.products VALUES (109, 5.36, 20, NULL, 1986, 2, NULL, NULL, 'DOLLCRAFT GIRL AMELIE KIT', '23126');
INSERT INTO public.products VALUES (72, 5.25, 20, NULL, 1987, 2, NULL, NULL, 'DOLLCRAFT GIRL NICOLE', '23127');
INSERT INTO public.products VALUES (44, 5.26, 22, NULL, 1988, 2, NULL, NULL, 'FELTCRAFT BOY JEAN-PAUL KIT', '23128');
INSERT INTO public.products VALUES (94, 4.57, 22, NULL, 1989, 2, NULL, NULL, 'HEART SHAPED HOLLY WREATH', '23129');
INSERT INTO public.products VALUES (95, 4.52, 22, NULL, 1990, 2, NULL, NULL, 'MISTLETOE HEART WREATH GREEN', '23130');
INSERT INTO public.products VALUES (93, 4.13, 22, NULL, 1991, 2, NULL, NULL, 'MISTLETOE HEART WREATH CREAM', '23131');
INSERT INTO public.products VALUES (103, 6.20, 22, NULL, 1992, 2, NULL, NULL, 'SMALL IVORY HEART WALL ORGANISER', '23132');
INSERT INTO public.products VALUES (78, 9.16, 22, NULL, 1993, 2, NULL, NULL, 'LARGE IVORY HEART WALL ORGANISER', '23133');
INSERT INTO public.products VALUES (106, 7.91, 22, NULL, 1994, 2, NULL, NULL, 'LARGE ZINC HEART WALL ORGANISER', '23134');
INSERT INTO public.products VALUES (164, 5.55, 22, NULL, 1995, 2, NULL, NULL, 'SMALL ZINC HEART WALL ORGANISER', '23135');
INSERT INTO public.products VALUES (13, 4.03, 21, NULL, 1996, 2, NULL, NULL, 'IVORY WIRE SWEETHEART LETTER TRAY', '23136');
INSERT INTO public.products VALUES (10, 3.98, 21, NULL, 1997, 2, NULL, NULL, 'ZINC WIRE SWEETHEART LETTER TRAY', '23137');
INSERT INTO public.products VALUES (87, 1.59, 22, NULL, 1998, 2, NULL, NULL, 'SINGLE WIRE HOOK IVORY HEART', '23138');
INSERT INTO public.products VALUES (40, 1.60, 22, NULL, 1999, 2, NULL, NULL, 'SINGLE WIRE HOOK PINK HEART', '23139');
INSERT INTO public.products VALUES (17, 4.53, 22, NULL, 2000, 2, NULL, NULL, 'TRIPLE WIRE HOOK IVORY HEART', '23140');
INSERT INTO public.products VALUES (10, 4.24, 22, NULL, 2001, 2, NULL, NULL, 'TRIPLE WIRE HOOK PINK HEART', '23141');
INSERT INTO public.products VALUES (11, 11.05, 22, NULL, 2002, 2, NULL, NULL, 'IVORY WIRE KITCHEN ORGANISER', '23142');
INSERT INTO public.products VALUES (10, 9.93, 22, NULL, 2003, 2, NULL, NULL, 'ZINC WIRE KITCHEN ORGANISER', '23143');
INSERT INTO public.products VALUES (504, 0.94, 12, NULL, 2004, 2, NULL, NULL, 'ZINC T-LIGHT HOLDER STARS SMALL', '23144');
INSERT INTO public.products VALUES (207, 1.08, 12, NULL, 2005, 2, NULL, NULL, 'ZINC T-LIGHT HOLDER STAR LARGE', '23145');
INSERT INTO public.products VALUES (75, 3.49, 22, NULL, 2006, 2, NULL, NULL, 'TRIPLE HOOK ANTIQUE IVORY ROSE', '23146');
INSERT INTO public.products VALUES (185, 1.52, 22, NULL, 2007, 2, NULL, NULL, 'SINGLE ANTIQUE ROSE HOOK IVORY', '23147');
INSERT INTO public.products VALUES (213, 0.91, 22, NULL, 2008, 2, NULL, NULL, 'MINIATURE ANTIQUE ROSE HOOK IVORY', '23148');
INSERT INTO public.products VALUES (10, 2.70, 22, NULL, 2009, 2, NULL, NULL, 'ANTIQUE IVORY WIRE BOWL SMALL', '23149');
INSERT INTO public.products VALUES (14, 2.93, 22, NULL, 2010, 2, NULL, NULL, 'IVORY SWEETHEART SOAP DISH', '23150');
INSERT INTO public.products VALUES (10, 2.25, 22, NULL, 2011, 2, NULL, NULL, 'ZINC SWEETHEART SOAP DISH', '23151');
INSERT INTO public.products VALUES (55, 3.95, 21, NULL, 2012, 2, NULL, NULL, 'IVORY SWEETHEART WIRE LETTER RACK ', '23152');
INSERT INTO public.products VALUES (25, 4.23, 21, NULL, 2013, 2, NULL, NULL, 'ZINC SWEETHEART WIRE LETTER RACK', '23153');
INSERT INTO public.products VALUES (267, 2.20, 16, NULL, 2014, 2, NULL, NULL, 'SET OF 4 JAM JAR MAGNETS', '23154');
INSERT INTO public.products VALUES (198, 1.39, 22, NULL, 2015, 2, NULL, NULL, 'KNICKERBOCKERGLORY MAGNET ASSORTED ', '23155');
INSERT INTO public.products VALUES (164, 2.26, 22, NULL, 2016, 2, NULL, NULL, 'SET OF 5 MINI GROCERY MAGNETS', '23156');
INSERT INTO public.products VALUES (278, 2.33, 22, NULL, 2017, 2, NULL, NULL, 'SET OF 6 NATIVITY MAGNETS ', '23157');
INSERT INTO public.products VALUES (257, 2.66, 22, NULL, 2018, 2, NULL, NULL, 'SET OF 5 LUCKY CAT MAGNETS ', '23158');
INSERT INTO public.products VALUES (229, 2.31, 22, NULL, 2019, 2, NULL, NULL, 'SET OF 5 PANCAKE DAY MAGNETS', '23159');
INSERT INTO public.products VALUES (145, 1.48, 22, NULL, 2020, 2, NULL, NULL, 'REGENCY TEA SPOON', '23160');
INSERT INTO public.products VALUES (170, 1.59, 22, NULL, 2021, 2, NULL, NULL, 'REGENCY CAKE FORK', '23161');
INSERT INTO public.products VALUES (141, 4.42, 22, NULL, 2022, 2, NULL, NULL, 'REGENCY TEA STRAINER', '23162');
INSERT INTO public.products VALUES (177, 3.32, 22, NULL, 2023, 2, NULL, NULL, 'REGENCY SUGAR TONGS', '23163');
INSERT INTO public.products VALUES (57, 5.57, 22, NULL, 2024, 2, NULL, NULL, 'REGENCY CAKE SLICE', '23164');
INSERT INTO public.products VALUES (301, 1.95, 16, NULL, 2025, 2, NULL, NULL, 'LARGE CERAMIC TOP STORAGE JAR', '23165');
INSERT INTO public.products VALUES (353, 1.46, 16, NULL, 2026, 2, NULL, NULL, 'MEDIUM CERAMIC TOP STORAGE JAR', '23166');
INSERT INTO public.products VALUES (532, 0.99, 16, NULL, 2027, 2, NULL, NULL, 'SMALL CERAMIC TOP STORAGE JAR ', '23167');
INSERT INTO public.products VALUES (323, 1.75, 22, NULL, 2028, 2, NULL, NULL, 'CLASSIC SUGAR DISPENSER', '23168');
INSERT INTO public.products VALUES (123, 4.63, 14, NULL, 2029, 2, NULL, NULL, 'CLASSIC GLASS SWEET JAR', '23169');
INSERT INTO public.products VALUES (615, 2.06, 22, NULL, 2030, 2, NULL, NULL, 'REGENCY TEA PLATE ROSES ', '23170');
INSERT INTO public.products VALUES (615, 2.12, 22, NULL, 2031, 2, NULL, NULL, 'REGENCY TEA PLATE GREEN ', '23171');
INSERT INTO public.products VALUES (376, 2.05, 22, NULL, 2032, 2, NULL, NULL, 'REGENCY TEA PLATE PINK', '23172');
INSERT INTO public.products VALUES (271, 11.05, 22, NULL, 2033, 2, NULL, NULL, 'REGENCY TEAPOT ROSES ', '23173');
INSERT INTO public.products VALUES (296, 4.76, 22, NULL, 2034, 2, NULL, NULL, 'REGENCY SUGAR BOWL GREEN', '23174');
INSERT INTO public.products VALUES (308, 3.85, 22, NULL, 2035, 2, NULL, NULL, 'REGENCY MILK JUG PINK ', '23175');
INSERT INTO public.products VALUES (212, 2.64, 16, NULL, 2036, 2, NULL, NULL, 'ABC TREASURE BOOK BOX ', '23176');
INSERT INTO public.products VALUES (251, 2.69, 16, NULL, 2037, 2, NULL, NULL, 'TREASURE ISLAND BOOK BOX', '23177');
INSERT INTO public.products VALUES (32, 3.31, 18, NULL, 2038, 2, NULL, NULL, 'JAM CLOCK MAGNET', '23178');
INSERT INTO public.products VALUES (32, 3.52, 18, NULL, 2039, 2, NULL, NULL, 'CLOCK MAGNET MUM''S KITCHEN', '23179');
INSERT INTO public.products VALUES (12, 5.92, 18, NULL, 2040, 2, NULL, NULL, 'MUM''S KITCHEN CLOCK', '23180');
INSERT INTO public.products VALUES (19, 9.37, 14, NULL, 2041, 2, NULL, NULL, 'BULL DOG BOTTLE TOP WALL CLOCK', '23181');
INSERT INTO public.products VALUES (376, 1.51, 14, NULL, 2042, 2, NULL, NULL, 'TOILET SIGN OCCUPIED OR VACANT', '23182');
INSERT INTO public.products VALUES (21, 4.84, 22, NULL, 2043, 2, NULL, NULL, 'MOTHER''S KITCHEN SPOON REST ', '23183');
INSERT INTO public.products VALUES (86, 6.43, 14, NULL, 2044, 2, NULL, NULL, 'BULL DOG BOTTLE OPENER', '23184');
INSERT INTO public.products VALUES (32, 0.35, 16, NULL, 2045, 2, NULL, NULL, 'FRENCH STYLE STORAGE JAR JAM', '23185');
INSERT INTO public.products VALUES (197, 0.35, 16, NULL, 2046, 2, NULL, NULL, 'FRENCH STYLE STORAGE JAR CAFE ', '23186');
INSERT INTO public.products VALUES (223, 0.32, 16, NULL, 2047, 2, NULL, NULL, 'FRENCH STYLE STORAGE JAR BONBONS', '23187');
INSERT INTO public.products VALUES (345, 1.93, 22, NULL, 2048, 2, NULL, NULL, 'VINTAGE  2 METER FOLDING RULER', '23188');
INSERT INTO public.products VALUES (124, 3.39, 12, NULL, 2049, 2, NULL, NULL, 'SET OF 12 FORK CANDLES', '23189');
INSERT INTO public.products VALUES (170, 1.80, 22, NULL, 2050, 2, NULL, NULL, 'BUNDLE OF 3 SCHOOL EXERCISE BOOKS  ', '23190');
INSERT INTO public.products VALUES (221, 1.87, 22, NULL, 2051, 2, NULL, NULL, 'BUNDLE OF 3 RETRO NOTE BOOKS', '23191');
INSERT INTO public.products VALUES (353, 1.77, 22, NULL, 2052, 2, NULL, NULL, 'BUNDLE OF 3 ALPHABET EXERCISE BOOKS', '23192');
INSERT INTO public.products VALUES (191, 2.70, 16, NULL, 2053, 2, NULL, NULL, 'BUFFALO BILL TREASURE BOOK BOX', '23193');
INSERT INTO public.products VALUES (180, 2.69, 16, NULL, 2054, 2, NULL, NULL, 'GYMKHANNA TREASURE BOOK BOX', '23194');
INSERT INTO public.products VALUES (187, 1.78, 22, NULL, 2055, 2, NULL, NULL, 'RETRO LEAVES MAGNETIC NOTEPAD', '23196');
INSERT INTO public.products VALUES (146, 1.93, 22, NULL, 2056, 2, NULL, NULL, 'SKETCHBOOK MAGNETIC SHOPPING LIST', '23197');
INSERT INTO public.products VALUES (328, 1.79, 22, NULL, 2057, 2, NULL, NULL, 'PANTRY MAGNETIC  SHOPPING LIST', '23198');
INSERT INTO public.products VALUES (1419, 2.56, 13, NULL, 2058, 2, NULL, NULL, 'JUMBO BAG APPLES', '23199');
INSERT INTO public.products VALUES (703, 2.42, 22, NULL, 2059, 2, NULL, NULL, 'mailout ', '23200');
INSERT INTO public.products VALUES (1278, 2.38, 13, NULL, 2060, 2, NULL, NULL, 'JUMBO BAG ALPHABET', '23201');
INSERT INTO public.products VALUES (1082, 2.29, 22, NULL, 2061, 2, NULL, NULL, 'mailout', '23202');
INSERT INTO public.products VALUES (2001, 2.27, 22, NULL, 2062, 2, NULL, NULL, 'mailout', '23203');
INSERT INTO public.products VALUES (779, 1.12, 13, NULL, 2063, 2, NULL, NULL, 'CHARLOTTE BAG APPLES DESIGN', '23204');
INSERT INTO public.products VALUES (566, 1.14, 13, NULL, 2064, 2, NULL, NULL, 'CHARLOTTE BAG VINTAGE ALPHABET ', '23205');
INSERT INTO public.products VALUES (1212, 2.05, 13, NULL, 2065, 2, NULL, NULL, 'LUNCH BAG APPLE DESIGN', '23206');
INSERT INTO public.products VALUES (740, 1.98, 13, NULL, 2066, 2, NULL, NULL, 'LUNCH BAG ALPHABET DESIGN', '23207');
INSERT INTO public.products VALUES (626, 1.93, 13, NULL, 2067, 2, NULL, NULL, 'LUNCH BAG VINTAGE LEAF DESIGN', '23208');
INSERT INTO public.products VALUES (1324, 1.82, 22, NULL, 2068, 2, NULL, NULL, 'mailout', '23209');
INSERT INTO public.products VALUES (270, 1.46, 22, NULL, 2069, 2, NULL, NULL, 'WHITE ROCKING HORSE HAND PAINTED', '23210');
INSERT INTO public.products VALUES (230, 1.56, 22, NULL, 2070, 2, NULL, NULL, 'RED ROCKING HORSE HAND PAINTED', '23211');
INSERT INTO public.products VALUES (224, 1.49, 22, NULL, 2071, 2, NULL, NULL, 'HEART WREATH DECORATION WITH BELL', '23212');
INSERT INTO public.products VALUES (167, 1.48, 22, NULL, 2072, 2, NULL, NULL, 'STAR WREATH DECORATION WITH BELL', '23213');
INSERT INTO public.products VALUES (79, 2.38, 22, NULL, 2073, 2, NULL, NULL, 'JINGLE BELL HEART ANTIQUE GOLD', '23214');
INSERT INTO public.products VALUES (344, 2.26, 22, NULL, 2074, 2, NULL, NULL, 'JINGLE BELL HEART ANTIQUE SILVER', '23215');
INSERT INTO public.products VALUES (52, 1.45, 22, NULL, 2075, 2, NULL, NULL, 'LAUREL HEART ANTIQUE GOLD', '23216');
INSERT INTO public.products VALUES (130, 1.54, 22, NULL, 2076, 2, NULL, NULL, 'LAUREL HEART ANTIQUE SILVER', '23217');
INSERT INTO public.products VALUES (37, 1.57, 22, NULL, 2077, 2, NULL, NULL, 'LAUREL STAR ANTIQUE GOLD', '23218');
INSERT INTO public.products VALUES (43, 1.53, 22, NULL, 2078, 2, NULL, NULL, 'LAUREL STAR ANTIQUE SILVER ', '23219');
INSERT INTO public.products VALUES (98, 1.08, 22, NULL, 2079, 2, NULL, NULL, 'REINDEER HEART DECORATION GOLD', '23220');
INSERT INTO public.products VALUES (147, 1.07, 22, NULL, 2080, 2, NULL, NULL, 'REINDEER HEART DECORATION SILVER', '23221');
INSERT INTO public.products VALUES (77, 1.04, 17, NULL, 2081, 2, NULL, NULL, 'CHRISTMAS TREE HANGING GOLD', '23222');
INSERT INTO public.products VALUES (79, 1.08, 17, NULL, 2082, 2, NULL, NULL, 'CHRISTMAS TREE HANGING SILVER ', '23223');
INSERT INTO public.products VALUES (72, 1.03, 22, NULL, 2083, 2, NULL, NULL, 'CHERUB HEART DECORATION GOLD', '23224');
INSERT INTO public.products VALUES (127, 1.08, 22, NULL, 2084, 2, NULL, NULL, 'CHERUB HEART DECORATION SILVER ', '23225');
INSERT INTO public.products VALUES (119, 1.57, 22, NULL, 2085, 2, NULL, NULL, 'FILIGREE HEART DAISY WHITE', '23226');
INSERT INTO public.products VALUES (163, 1.57, 22, NULL, 2086, 2, NULL, NULL, 'FILIGREE HEART BUTTERFLY WHITE ', '23227');
INSERT INTO public.products VALUES (134, 1.78, 22, NULL, 2087, 2, NULL, NULL, 'FILIGREE HEART BIRD WHITE ', '23228');
INSERT INTO public.products VALUES (185, 4.23, 20, NULL, 2088, 2, NULL, NULL, 'VINTAGE DONKEY TAIL GAME ', '23229');
INSERT INTO public.products VALUES (792, 0.42, 19, NULL, 2089, 2, NULL, NULL, 'WRAP ALPHABET DESIGN', '23230');
INSERT INTO public.products VALUES (727, 0.42, 19, NULL, 2090, 2, NULL, NULL, 'WRAP DOILEY DESIGN', '23231');
INSERT INTO public.products VALUES (857, 0.42, 19, NULL, 2091, 2, NULL, NULL, 'WRAP VINTAGE PETALS  DESIGN', '23232');
INSERT INTO public.products VALUES (515, 0.42, 19, NULL, 2092, 2, NULL, NULL, 'WRAP POPPIES  DESIGN', '23233');
INSERT INTO public.products VALUES (192, 3.36, 16, NULL, 2093, 2, NULL, NULL, 'BISCUIT TIN VINTAGE CHRISTMAS', '23234');
INSERT INTO public.products VALUES (72, 2.96, 16, NULL, 2094, 2, NULL, NULL, 'STORAGE TIN VINTAGE LEAF', '23235');
INSERT INTO public.products VALUES (247, 3.25, 16, NULL, 2095, 2, NULL, NULL, 'DOILEY STORAGE TIN', '23236');
INSERT INTO public.products VALUES (103, 4.24, 16, NULL, 2096, 2, NULL, NULL, 'SET OF 4 KNICK KNACK TINS LEAVES ', '23237');
INSERT INTO public.products VALUES (184, 4.72, 16, NULL, 2097, 2, NULL, NULL, 'SET OF 4 KNICK KNACK TINS LONDON ', '23238');
INSERT INTO public.products VALUES (82, 4.37, 16, NULL, 2098, 2, NULL, NULL, 'SET OF 4 KNICK KNACK TINS POPPIES', '23239');
INSERT INTO public.products VALUES (413, 4.43, 16, NULL, 2099, 2, NULL, NULL, 'SET OF 4 KNICK KNACK TINS DOILEY ', '23240');
INSERT INTO public.products VALUES (217, 2.47, 16, NULL, 2100, 2, NULL, NULL, 'TREASURE TIN GYMKHANA DESIGN', '23241');
INSERT INTO public.products VALUES (144, 2.27, 16, NULL, 2101, 2, NULL, NULL, 'TREASURE TIN BUFFALO BILL ', '23242');
INSERT INTO public.products VALUES (468, 5.79, 16, NULL, 2102, 2, NULL, NULL, 'SET OF TEA COFFEE SUGAR TINS PANTRY', '23243');
INSERT INTO public.products VALUES (92, 2.08, 16, NULL, 2103, 2, NULL, NULL, 'ROUND STORAGE TIN VINTAGE LEAF', '23244');
INSERT INTO public.products VALUES (626, 5.84, 16, NULL, 2104, 2, NULL, NULL, 'SET OF 3 REGENCY CAKE TINS', '23245');
INSERT INTO public.products VALUES (216, 3.27, 16, NULL, 2105, 2, NULL, NULL, 'BISCUIT TIN 50''S CHRISTMAS', '23247');
INSERT INTO public.products VALUES (79, 1.86, 22, NULL, 2106, 2, NULL, NULL, 'VINTAGE RED ENAMEL TRIM PLATE', '23249');
INSERT INTO public.products VALUES (105, 1.45, 22, NULL, 2107, 2, NULL, NULL, 'VINTAGE RED TRIM ENAMEL BOWL ', '23250');
INSERT INTO public.products VALUES (165, 1.40, 14, NULL, 2108, 2, NULL, NULL, 'VINTAGE RED ENAMEL TRIM MUG ', '23251');
INSERT INTO public.products VALUES (57, 4.02, 22, NULL, 2109, 2, NULL, NULL, 'VINTAGE RED ENAMEL TRIM JUG ', '23252');
INSERT INTO public.products VALUES (25, 17.12, 21, NULL, 2110, 2, NULL, NULL, '16 PIECE CUTLERY SET PANTRY DESIGN', '23253');
INSERT INTO public.products VALUES (169, 4.26, 20, NULL, 2111, 2, NULL, NULL, 'CHILDRENS CUTLERY DOLLY GIRL ', '23254');
INSERT INTO public.products VALUES (100, 4.34, 22, NULL, 2112, 2, NULL, NULL, 'CHILDRENS CUTLERY CIRCUS PARADE', '23255');
INSERT INTO public.products VALUES (202, 4.45, 22, NULL, 2113, 2, NULL, NULL, 'CHILDRENS CUTLERY SPACEBOY ', '23256');
INSERT INTO public.products VALUES (384, 1.44, 22, NULL, 2114, 2, NULL, NULL, 'SET OF 3 WOODEN HEART DECORATIONS', '23263');
INSERT INTO public.products VALUES (196, 1.49, 22, NULL, 2115, 2, NULL, NULL, 'SET OF 3 WOODEN SLEIGH DECORATIONS', '23264');
INSERT INTO public.products VALUES (176, 1.47, 22, NULL, 2116, 2, NULL, NULL, 'SET OF 3 WOODEN TREE DECORATIONS', '23265');
INSERT INTO public.products VALUES (205, 1.45, 22, NULL, 2117, 2, NULL, NULL, 'SET OF 3 WOODEN STOCKING DECORATION', '23266');
INSERT INTO public.products VALUES (115, 1.41, 16, NULL, 2118, 2, NULL, NULL, 'SET OF 4 SANTA PLACE SETTINGS', '23267');
INSERT INTO public.products VALUES (38, 1.63, 17, NULL, 2119, 2, NULL, NULL, 'SET OF 2 CERAMIC CHRISTMAS REINDEER', '23268');
INSERT INTO public.products VALUES (10, 1.69, 17, NULL, 2120, 2, NULL, NULL, 'SET OF 2 CERAMIC CHRISTMAS TREES', '23269');
INSERT INTO public.products VALUES (10, 1.48, 22, NULL, 2121, 2, NULL, NULL, 'SET OF 2 CERAMIC PAINTED HEARTS ', '23270');
INSERT INTO public.products VALUES (173, 1.05, 12, NULL, 2122, 2, NULL, NULL, 'CHRISTMAS TABLE CANDLE SILVER SPIKE', '23271');
INSERT INTO public.products VALUES (36, 1.92, 12, NULL, 2123, 2, NULL, NULL, 'TREE T-LIGHT HOLDER WILLIE WINKIE', '23272');
INSERT INTO public.products VALUES (96, 1.87, 12, NULL, 2124, 2, NULL, NULL, 'HEART T-LIGHT HOLDER WILLIE WINKIE', '23273');
INSERT INTO public.products VALUES (118, 2.00, 12, NULL, 2125, 2, NULL, NULL, 'STAR T-LIGHT HOLDER WILLIE WINKIE', '23274');
INSERT INTO public.products VALUES (367, 1.47, 22, NULL, 2126, 2, NULL, NULL, 'SET OF 3 HANGING OWLS OLLIE BEAK', '23275');
INSERT INTO public.products VALUES (202, 1.06, 22, NULL, 2127, 2, NULL, NULL, 'FOLDING BUTTERFLY MIRROR HOT PINK ', '23280');
INSERT INTO public.products VALUES (128, 0.98, 22, NULL, 2128, 2, NULL, NULL, 'FOLDING BUTTERFLY MIRROR RED  ', '23281');
INSERT INTO public.products VALUES (81, 1.26, 22, NULL, 2129, 2, NULL, NULL, 'FOLDING BUTTERFLY MIRROR IVORY ', '23282');
INSERT INTO public.products VALUES (98, 8.65, 21, NULL, 2130, 2, NULL, NULL, 'DOORMAT VINTAGE LEAVES DESIGN ', '23283');
INSERT INTO public.products VALUES (526, 8.76, 22, NULL, 2131, 2, NULL, NULL, 'DOORMAT KEEP CALM AND COME IN', '23284');
INSERT INTO public.products VALUES (480, 1.07, 22, NULL, 2132, 2, NULL, NULL, 'PINK VINTAGE SPOT BEAKER', '23285');
INSERT INTO public.products VALUES (499, 1.03, 22, NULL, 2133, 2, NULL, NULL, 'BLUE VINTAGE SPOT BEAKER', '23286');
INSERT INTO public.products VALUES (184, 1.03, 22, NULL, 2134, 2, NULL, NULL, 'RED VINTAGE SPOT BEAKER', '23287');
INSERT INTO public.products VALUES (454, 1.03, 22, NULL, 2135, 2, NULL, NULL, 'GREEN VINTAGE SPOT BEAKER', '23288');
INSERT INTO public.products VALUES (161, 1.53, 20, NULL, 2136, 2, NULL, NULL, 'DOLLY GIRL CHILDRENS BOWL', '23289');
INSERT INTO public.products VALUES (242, 1.43, 22, NULL, 2137, 2, NULL, NULL, 'SPACEBOY CHILDRENS BOWL', '23290');
INSERT INTO public.products VALUES (162, 1.52, 14, NULL, 2138, 2, NULL, NULL, 'DOLLY GIRL CHILDRENS CUP', '23291');
INSERT INTO public.products VALUES (216, 1.52, 14, NULL, 2139, 2, NULL, NULL, 'SPACE BOY CHILDRENS CUP', '23292');
INSERT INTO public.products VALUES (845, 1.06, 22, NULL, 2140, 2, NULL, NULL, 'SET OF 12 FAIRY CAKE BAKING CASES', '23293');
INSERT INTO public.products VALUES (440, 1.08, 22, NULL, 2141, 2, NULL, NULL, 'SET OF 6 SNACK LOAF BAKING CASES', '23294');
INSERT INTO public.products VALUES (612, 1.11, 22, NULL, 2142, 2, NULL, NULL, 'SET OF 12 MINI LOAF BAKING CASES', '23295');
INSERT INTO public.products VALUES (495, 1.52, 22, NULL, 2143, 2, NULL, NULL, 'SET OF 6 TEA TIME BAKING CASES', '23296');
INSERT INTO public.products VALUES (427, 1.83, 22, NULL, 2144, 2, NULL, NULL, 'SET 40 HEART SHAPE PETIT FOUR CASES', '23297');
INSERT INTO public.products VALUES (853, 5.50, 16, NULL, 2145, 2, NULL, NULL, 'SPOTTY BUNTING', '23298');
INSERT INTO public.products VALUES (100, 4.35, 22, NULL, 2146, 2, NULL, NULL, 'FOOD COVER WITH BEADS SET 2 ', '23299');
INSERT INTO public.products VALUES (667, 1.90, 14, NULL, 2147, 2, NULL, NULL, 'GARDENERS KNEELING PAD CUP OF TEA ', '23300');
INSERT INTO public.products VALUES (871, 1.94, 22, NULL, 2148, 2, NULL, NULL, 'GARDENERS KNEELING PAD KEEP CALM ', '23301');
INSERT INTO public.products VALUES (150, 1.88, 21, NULL, 2149, 2, NULL, NULL, 'KNEELING MAT HOUSEWORK  DESIGN', '23302');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 2150, 2, NULL, NULL, 'SET 4 PICNIC CUTLERY FONDANT', '23303');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 2151, 2, NULL, NULL, 'SET 4 PICNIC CUTLERY CHERRY ', '23304');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 2152, 2, NULL, NULL, 'SET 4 PICNIC CUTLERY BLUEBERRY', '23305');
INSERT INTO public.products VALUES (280, 1.80, 21, NULL, 2153, 2, NULL, NULL, 'SET OF 36 DOILIES PANTRY DESIGN', '23306');
INSERT INTO public.products VALUES (1197, 0.68, 21, NULL, 2154, 2, NULL, NULL, 'SET OF 60 PANTRY DESIGN CAKE CASES ', '23307');
INSERT INTO public.products VALUES (615, 0.69, 22, NULL, 2155, 2, NULL, NULL, 'SET OF 60 VINTAGE LEAF CAKE CASES ', '23308');
INSERT INTO public.products VALUES (824, 0.74, 22, NULL, 2156, 2, NULL, NULL, 'SET OF 60 I LOVE LONDON CAKE CASES ', '23309');
INSERT INTO public.products VALUES (1205, 0.48, 22, NULL, 2157, 2, NULL, NULL, 'BUBBLEGUM RING ASSORTED', '23310');
INSERT INTO public.products VALUES (237, 2.96, 17, NULL, 2158, 2, NULL, NULL, 'VINTAGE CHRISTMAS STOCKING ', '23311');
INSERT INTO public.products VALUES (142, 4.45, 17, NULL, 2159, 2, NULL, NULL, 'VINTAGE CHRISTMAS GIFT SACK', '23312');
INSERT INTO public.products VALUES (298, 5.54, 16, NULL, 2160, 2, NULL, NULL, 'VINTAGE CHRISTMAS BUNTING', '23313');
INSERT INTO public.products VALUES (40, 13.58, 17, NULL, 2161, 2, NULL, NULL, 'VINTAGE CHRISTMAS TABLECLOTH', '23314');
INSERT INTO public.products VALUES (20, 10.75, 18, NULL, 2162, 2, NULL, NULL, 'IVORY REFECTORY CLOCK', '23315');
INSERT INTO public.products VALUES (25, 11.09, 18, NULL, 2163, 2, NULL, NULL, 'RED REFECTORY CLOCK ', '23316');
INSERT INTO public.products VALUES (17, 11.21, 18, NULL, 2164, 2, NULL, NULL, 'BLUE REFECTORY CLOCK ', '23317');
INSERT INTO public.products VALUES (364, 2.73, 16, NULL, 2165, 2, NULL, NULL, 'BOX OF 6 MINI VINTAGE CRACKERS', '23318');
INSERT INTO public.products VALUES (362, 2.64, 16, NULL, 2166, 2, NULL, NULL, 'BOX OF 6 MINI 50''S CRACKERS', '23319');
INSERT INTO public.products VALUES (265, 2.80, 17, NULL, 2167, 2, NULL, NULL, 'GIANT 50''S CHRISTMAS CRACKER', '23320');
INSERT INTO public.products VALUES (469, 1.75, 22, NULL, 2168, 2, NULL, NULL, 'SMALL WHITE HEART OF WICKER', '23321');
INSERT INTO public.products VALUES (298, 3.12, 22, NULL, 2169, 2, NULL, NULL, 'LARGE WHITE HEART OF WICKER', '23322');
INSERT INTO public.products VALUES (147, 2.25, 22, NULL, 2170, 2, NULL, NULL, 'WHITE WICKER STAR ', '23323');
INSERT INTO public.products VALUES (36, 2.20, 22, NULL, 2171, 2, NULL, NULL, 'RUSTIC STRAWBERRY JAMPOT LARGE ', '23324');
INSERT INTO public.products VALUES (44, 1.80, 22, NULL, 2172, 2, NULL, NULL, 'RUSTIC STRAWBERRY JAMPOT SMALL', '23325');
INSERT INTO public.products VALUES (344, 2.61, 14, NULL, 2173, 2, NULL, NULL, 'HANGING MINI COLOURED BOTTLES', '23326');
INSERT INTO public.products VALUES (172, 0.78, 14, NULL, 2174, 2, NULL, NULL, 'HANGING CLEAR MINI BOTTLE', '23327');
INSERT INTO public.products VALUES (283, 4.82, 14, NULL, 2175, 2, NULL, NULL, 'SET 6 SCHOOL MILK BOTTLES IN CRATE', '23328');
INSERT INTO public.products VALUES (177, 1.76, 22, NULL, 2176, 2, NULL, NULL, 'DECORATIVE WICKER HEART LARGE', '23329');
INSERT INTO public.products VALUES (179, 1.36, 22, NULL, 2177, 2, NULL, NULL, 'DECORATIVE WICKER HEART MEDIUM', '23330');
INSERT INTO public.products VALUES (159, 0.78, 22, NULL, 2178, 2, NULL, NULL, 'DECORATIVE WICKER HEART SMALL', '23331');
INSERT INTO public.products VALUES (207, 1.76, 22, NULL, 2179, 2, NULL, NULL, 'IVORY WICKER HEART LARGE', '23332');
INSERT INTO public.products VALUES (209, 1.33, 22, NULL, 2180, 2, NULL, NULL, 'IVORY WICKER HEART MEDIUM', '23333');
INSERT INTO public.products VALUES (227, 0.79, 22, NULL, 2181, 2, NULL, NULL, 'IVORY WICKER HEART SMALL', '23334');
INSERT INTO public.products VALUES (36, 2.32, 22, NULL, 2182, 2, NULL, NULL, 'EGG FRYING PAN IVORY ', '23335');
INSERT INTO public.products VALUES (22, 2.60, 22, NULL, 2183, 2, NULL, NULL, 'EGG FRYING PAN PINK ', '23336');
INSERT INTO public.products VALUES (18, 2.29, 22, NULL, 2184, 2, NULL, NULL, 'EGG FRYING PAN MINT ', '23337');
INSERT INTO public.products VALUES (42, 2.34, 22, NULL, 2185, 2, NULL, NULL, 'EGG FRYING PAN RED ', '23338');
INSERT INTO public.products VALUES (17, 2.51, 22, NULL, 2186, 2, NULL, NULL, 'EGG FRYING PAN BLUE ', '23339');
INSERT INTO public.products VALUES (251, 1.96, 17, NULL, 2187, 2, NULL, NULL, 'VINTAGE CHRISTMAS CAKE FRILL', '23340');
INSERT INTO public.products VALUES (30, 9.93, 18, NULL, 2188, 2, NULL, NULL, 'PINK DINER WALL CLOCK', '23341');
INSERT INTO public.products VALUES (37, 8.83, 18, NULL, 2189, 2, NULL, NULL, 'MINT DINER WALL CLOCK', '23342');
INSERT INTO public.products VALUES (811, 2.39, 13, NULL, 2190, 2, NULL, NULL, 'JUMBO BAG VINTAGE CHRISTMAS ', '23343');
INSERT INTO public.products VALUES (1004, 2.41, 13, NULL, 2191, 2, NULL, NULL, 'JUMBO BAG 50''S CHRISTMAS ', '23344');
INSERT INTO public.products VALUES (244, 1.50, 20, NULL, 2192, 2, NULL, NULL, ' DOLLY GIRL BEAKER', '23345');
INSERT INTO public.products VALUES (262, 1.51, 22, NULL, 2193, 2, NULL, NULL, 'SPACEBOY BEAKER', '23346');
INSERT INTO public.products VALUES (82, 1.55, 22, NULL, 2194, 2, NULL, NULL, 'I LOVE LONDON BEAKER', '23347');
INSERT INTO public.products VALUES (67, 2.52, 20, NULL, 2195, 2, NULL, NULL, 'CHILDRENS TOY COOKING UTENSIL SET', '23348');
INSERT INTO public.products VALUES (320, 1.54, 17, NULL, 2196, 2, NULL, NULL, 'ROLL WRAP VINTAGE CHRISTMAS', '23349');
INSERT INTO public.products VALUES (269, 1.46, 19, NULL, 2197, 2, NULL, NULL, 'ROLL WRAP VINTAGE SPOT ', '23350');
INSERT INTO public.products VALUES (344, 1.51, 17, NULL, 2198, 2, NULL, NULL, 'ROLL WRAP 50''S CHRISTMAS', '23351');
INSERT INTO public.products VALUES (179, 1.51, 17, NULL, 2199, 2, NULL, NULL, 'ROLL WRAP 50''S RED CHRISTMAS ', '23352');
INSERT INTO public.products VALUES (399, 1.00, 17, NULL, 2200, 2, NULL, NULL, '6 GIFT TAGS VINTAGE CHRISTMAS ', '23353');
INSERT INTO public.products VALUES (368, 0.97, 17, NULL, 2201, 2, NULL, NULL, '6 GIFT TAGS 50''S CHRISTMAS ', '23354');
INSERT INTO public.products VALUES (574, 5.26, 14, NULL, 2202, 2, NULL, NULL, 'HOT WATER BOTTLE KEEP CALM', '23355');
INSERT INTO public.products VALUES (237, 6.20, 14, NULL, 2203, 2, NULL, NULL, 'LOVE HOT WATER BOTTLE', '23356');
INSERT INTO public.products VALUES (45, 4.97, 14, NULL, 2204, 2, NULL, NULL, 'HOT WATER BOTTLE SEX BOMB', '23357');
INSERT INTO public.products VALUES (55, 4.18, 14, NULL, 2205, 2, NULL, NULL, 'HOT STUFF HOT WATER BOTTLE', '23358');
INSERT INTO public.products VALUES (99, 1.99, 12, NULL, 2206, 2, NULL, NULL, 'SET OF 12 T-LIGHTS VINTAGE DOILEY', '23359');
INSERT INTO public.products VALUES (118, 2.06, 12, NULL, 2207, 2, NULL, NULL, 'SET 8 CANDLES VINTAGE DOILEY', '23360');
INSERT INTO public.products VALUES (185, 0.79, 22, NULL, 2208, 2, NULL, NULL, 'SET 12 COLOUR PENCILS LOVE LONDON', '23365');
INSERT INTO public.products VALUES (225, 0.81, 22, NULL, 2209, 2, NULL, NULL, 'SET 12 COLOURING PENCILS DOILY', '23366');
INSERT INTO public.products VALUES (326, 0.75, 22, NULL, 2210, 2, NULL, NULL, 'SET 12 COLOUR PENCILS SPACEBOY ', '23367');
INSERT INTO public.products VALUES (237, 0.78, 20, NULL, 2211, 2, NULL, NULL, 'SET 12 COLOUR PENCILS DOLLY GIRL ', '23368');
INSERT INTO public.products VALUES (110, 1.50, 22, NULL, 2212, 2, NULL, NULL, 'SET 36 COLOUR PENCILS LOVE LONDON', '23369');
INSERT INTO public.products VALUES (155, 1.53, 22, NULL, 2213, 2, NULL, NULL, 'SET 36 COLOUR PENCILS DOILEY', '23370');
INSERT INTO public.products VALUES (171, 1.51, 22, NULL, 2214, 2, NULL, NULL, 'SET 36 COLOUR PENCILS SPACEBOY ', '23371');
INSERT INTO public.products VALUES (137, 1.61, 20, NULL, 2215, 2, NULL, NULL, 'SET 36 COLOUR PENCILS DOLLY GIRL', '23372');
INSERT INTO public.products VALUES (160, 0.91, 13, NULL, 2216, 2, NULL, NULL, 'VINTAGE CHRISTMAS PAPER GIFT BAG', '23373');
INSERT INTO public.products VALUES (244, 0.87, 13, NULL, 2217, 2, NULL, NULL, 'RED SPOT PAPER GIFT BAG', '23374');
INSERT INTO public.products VALUES (135, 0.93, 13, NULL, 2218, 2, NULL, NULL, '50''S CHRISTMAS PAPER GIFT BAG', '23375');
INSERT INTO public.products VALUES (302, 0.51, 17, NULL, 2219, 2, NULL, NULL, 'PACK OF 12 VINTAGE CHRISTMAS TISSUE', '23376');
INSERT INTO public.products VALUES (134, 0.56, 20, NULL, 2220, 2, NULL, NULL, 'PACK OF 12 DOLLY GIRL TISSUES', '23377');
INSERT INTO public.products VALUES (400, 0.46, 17, NULL, 2221, 2, NULL, NULL, 'PACK OF 12 50''S CHRISTMAS TISSUES', '23378');
INSERT INTO public.products VALUES (122, 0.54, 22, NULL, 2222, 2, NULL, NULL, 'PACK OF 12 RED APPLE TISSUES', '23379');
INSERT INTO public.products VALUES (230, 0.48, 22, NULL, 2223, 2, NULL, NULL, 'PACK OF 12 VINTAGE DOILY TISSUES', '23380');
INSERT INTO public.products VALUES (150, 0.47, 22, NULL, 2224, 2, NULL, NULL, 'PACK OF 12 VINTAGE LEAF TISSUES ', '23381');
INSERT INTO public.products VALUES (185, 4.65, 16, NULL, 2225, 2, NULL, NULL, 'BOX OF 6 CHRISTMAS CAKE DECORATIONS', '23382');
INSERT INTO public.products VALUES (82, 4.63, 22, NULL, 2226, 2, NULL, NULL, 'WOODLAND MINI BACKPACK', '23388');
INSERT INTO public.products VALUES (112, 4.52, 22, NULL, 2227, 2, NULL, NULL, 'SPACEBOY MINI BACKPACK', '23389');
INSERT INTO public.products VALUES (75, 4.38, 20, NULL, 2228, 2, NULL, NULL, 'DOLLY GIRL MINI BACKPACK', '23390');
INSERT INTO public.products VALUES (39, 4.61, 22, NULL, 2229, 2, NULL, NULL, ' I LOVE LONDON MINI BACKPACK', '23391');
INSERT INTO public.products VALUES (64, 2.68, 22, NULL, 2230, 2, NULL, NULL, 'SPACEBOY ROCKET LOLLY MAKERS', '23392');
INSERT INTO public.products VALUES (78, 4.45, 22, NULL, 2231, 2, NULL, NULL, 'HOME SWEET HOME CUSHION COVER ', '23393');
INSERT INTO public.products VALUES (43, 4.93, 22, NULL, 2232, 2, NULL, NULL, 'POSTE FRANCE CUSHION COVER', '23394');
INSERT INTO public.products VALUES (72, 4.82, 16, NULL, 2233, 2, NULL, NULL, 'BELLE JARDINIERE CUSHION COVER', '23395');
INSERT INTO public.products VALUES (65, 4.76, 22, NULL, 2234, 2, NULL, NULL, 'BUTTERFLY CUSHION COVER', '23396');
INSERT INTO public.products VALUES (47, 11.49, 22, NULL, 2235, 2, NULL, NULL, 'FOOT STOOL HOME SWEET HOME ', '23397');
INSERT INTO public.products VALUES (60, 1.04, 22, NULL, 2236, 2, NULL, NULL, 'HANGING HEART BONHEUR', '23398');
INSERT INTO public.products VALUES (192, 1.10, 22, NULL, 2237, 2, NULL, NULL, 'HOME SWEET HOME HANGING HEART', '23399');
INSERT INTO public.products VALUES (44, 6.79, 22, NULL, 2238, 2, NULL, NULL, 'SHELF WITH 4 HOOKS HOME SWEET HOME', '23400');
INSERT INTO public.products VALUES (45, 7.06, 22, NULL, 2239, 2, NULL, NULL, 'RUSTIC MIRROR WITH LACE HEART', '23401');
INSERT INTO public.products VALUES (29, 4.44, 22, NULL, 2240, 2, NULL, NULL, 'HOME SWEEET HOME 3 PEG HANGER ', '23402');
INSERT INTO public.products VALUES (62, 4.36, 21, NULL, 2241, 2, NULL, NULL, 'LETTER HOLDER HOME SWEET HOME', '23403');
INSERT INTO public.products VALUES (102, 5.91, 22, NULL, 2242, 2, NULL, NULL, 'HOME SWEET HOME BLACKBOARD', '23404');
INSERT INTO public.products VALUES (25, 5.94, 22, NULL, 2243, 2, NULL, NULL, 'HOME SWEET HOME 2 DRAWER CABINET', '23405');
INSERT INTO public.products VALUES (43, 7.03, 22, NULL, 2244, 2, NULL, NULL, 'HOME SWEET HOME KEY HOLDER', '23406');
INSERT INTO public.products VALUES (26, 10.58, 22, NULL, 2245, 2, NULL, NULL, 'SET OF 2 TRAYS HOME SWEET HOME', '23407');
INSERT INTO public.products VALUES (29, 2.08, 15, NULL, 2246, 2, NULL, NULL, 'PHOTO FRAME LINEN AND LACE SMALL', '23408');
INSERT INTO public.products VALUES (20, 3.81, 15, NULL, 2247, 2, NULL, NULL, 'PHOTO FRAME LINEN AND LACE LARGE', '23409');
INSERT INTO public.products VALUES (10, 8.03, 22, NULL, 2248, 2, NULL, NULL, 'CURIO CABINET LINEN AND LACE ', '23410');
INSERT INTO public.products VALUES (22, 5.83, 22, NULL, 2249, 2, NULL, NULL, ' TRELLIS COAT RACK', '23411');
INSERT INTO public.products VALUES (32, 7.62, 22, NULL, 2250, 2, NULL, NULL, 'HEART MIRROR ANTIQUE WHITE', '23412');
INSERT INTO public.products VALUES (16, 6.24, 16, NULL, 2251, 2, NULL, NULL, 'VINTAGE COFFEE GRINDER BOX', '23413');
INSERT INTO public.products VALUES (13, 10.07, 16, NULL, 2252, 2, NULL, NULL, 'ZINC BOX SIGN HOME', '23414');
INSERT INTO public.products VALUES (32, 1.46, 22, NULL, 2253, 2, NULL, NULL, 'HOME SWEET HOME HOOK', '23415');
INSERT INTO public.products VALUES (13, 1.76, 22, NULL, 2254, 2, NULL, NULL, 'CHAMBRE HOOK', '23416');
INSERT INTO public.products VALUES (14, 1.60, 22, NULL, 2255, 2, NULL, NULL, 'BATHROOM HOOK', '23417');
INSERT INTO public.products VALUES (55, 2.56, 14, NULL, 2256, 2, NULL, NULL, 'LAVENDER TOILETTE BOTTLE', '23418');
INSERT INTO public.products VALUES (47, 2.66, 14, NULL, 2257, 2, NULL, NULL, 'HOME SWEET HOME BOTTLE ', '23419');
INSERT INTO public.products VALUES (16, 2.33, 22, NULL, 2258, 2, NULL, NULL, 'PANTRY HOOK TEA STRAINER ', '23420');
INSERT INTO public.products VALUES (16, 2.50, 22, NULL, 2259, 2, NULL, NULL, 'PANTRY HOOK SPATULA', '23421');
INSERT INTO public.products VALUES (21, 2.78, 22, NULL, 2260, 2, NULL, NULL, 'PANTRY HOOK BALLOON WHISK ', '23422');
INSERT INTO public.products VALUES (21, 4.50, 22, NULL, 2261, 2, NULL, NULL, 'PANTRY 3 HOOK ROLLING PIN HANGER', '23423');
INSERT INTO public.products VALUES (46, 6.17, 16, NULL, 2262, 2, NULL, NULL, 'GINGHAM RECIPE BOOK BOX', '23424');
INSERT INTO public.products VALUES (26, 3.07, 16, NULL, 2263, 2, NULL, NULL, 'STORAGE TIN HOME SWEET HOME', '23425');
INSERT INTO public.products VALUES (127, 3.33, 21, NULL, 2264, 2, NULL, NULL, 'METAL SIGN DROP YOUR PANTS', '23426');
INSERT INTO public.products VALUES (23, 12.83, 22, NULL, 2265, 2, NULL, NULL, 'STOOL HOME SWEET HOME ', '23427');
INSERT INTO public.products VALUES (10, 9.86, 18, NULL, 2266, 2, NULL, NULL, 'IVORY RETRO KITCHEN WALL CLOCK', '23428');
INSERT INTO public.products VALUES (10, 8.89, 18, NULL, 2267, 2, NULL, NULL, 'RED RETRO KITCHEN WALL CLOCK', '23429');
INSERT INTO public.products VALUES (10, 8.62, 18, NULL, 2268, 2, NULL, NULL, 'BLUE RETRO KITCHEN WALL CLOCK', '23430');
INSERT INTO public.products VALUES (143, 1.32, 22, NULL, 2269, 2, NULL, NULL, 'NATURAL HANGING QUILTED HEARTS ', '23431');
INSERT INTO public.products VALUES (127, 1.35, 22, NULL, 2270, 2, NULL, NULL, 'PRETTY HANGING QUILTED HEARTS', '23432');
INSERT INTO public.products VALUES (121, 1.48, 22, NULL, 2271, 2, NULL, NULL, 'HANGING QUILTED PATCHWORK APPLES', '23433');
INSERT INTO public.products VALUES (209, 0.88, 17, NULL, 2272, 2, NULL, NULL, '3 RAFFIA RIBBONS 50''S CHRISTMAS ', '23434');
INSERT INTO public.products VALUES (82, 0.90, 17, NULL, 2273, 2, NULL, NULL, '3 RAFFIA RIBBONS VINTAGE CHRISTMAS', '23435');
INSERT INTO public.products VALUES (196, 1.44, 13, NULL, 2274, 2, NULL, NULL, 'GIFT BAG LARGE VINTAGE CHRISTMAS', '23436');
INSERT INTO public.products VALUES (193, 1.42, 13, NULL, 2275, 2, NULL, NULL, ' 50''S CHRISTMAS GIFT BAG LARGE', '23437');
INSERT INTO public.products VALUES (182, 1.37, 13, NULL, 2276, 2, NULL, NULL, ' RED SPOT GIFT BAG LARGE', '23438');
INSERT INTO public.products VALUES (402, 2.22, 22, NULL, 2277, 2, NULL, NULL, 'HAND WARMER RED LOVE HEART', '23439');
INSERT INTO public.products VALUES (16, 2.02, 22, NULL, 2278, 2, NULL, NULL, 'PAINT YOUR OWN EGGS IN CRATE', '23440');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 2279, 2, NULL, NULL, 'HAND PAINTED HANGING EASTER EGG', '23441');
INSERT INTO public.products VALUES (10, 2.08, 22, NULL, 2280, 2, NULL, NULL, '12 HANGING EGGS HAND PAINTED', '23442');
INSERT INTO public.products VALUES (10, 15.19, 22, NULL, 2281, 2, NULL, NULL, 'Next Day Carriage', '23444');
INSERT INTO public.products VALUES (266, 0.87, 22, NULL, 2282, 2, NULL, NULL, 'ICE CREAM BUBBLES', '23445');
INSERT INTO public.products VALUES (15, 1.58, 16, NULL, 2283, 2, NULL, NULL, 'BLUE BUNNY EASTER EGG BASKET', '23446');
INSERT INTO public.products VALUES (15, 1.60, 16, NULL, 2284, 2, NULL, NULL, 'PINK BUNNY EASTER EGG BASKET', '23447');
INSERT INTO public.products VALUES (10, 1.65, 16, NULL, 2285, 2, NULL, NULL, 'CREAM BUNNY EASTER EGG BASKET', '23448');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 2286, 2, NULL, NULL, 'SET OF 6 EASTER RAINBOW CHICKS', '23449');
INSERT INTO public.products VALUES (27, 2.27, 15, NULL, 2287, 2, NULL, NULL, 'SQUARE MINI PORTRAIT FRAME', '23451');
INSERT INTO public.products VALUES (51, 2.07, 15, NULL, 2288, 2, NULL, NULL, 'HEART MINI PORTRAIT FRAME', '23452');
INSERT INTO public.products VALUES (32, 1.99, 15, NULL, 2289, 2, NULL, NULL, 'OVAL  MINI PORTRAIT FRAME', '23453');
INSERT INTO public.products VALUES (17, 4.49, 22, NULL, 2290, 2, NULL, NULL, 'SET OF 3 MINI HANGING PORTRAITS', '23454');
INSERT INTO public.products VALUES (20, 2.87, 15, NULL, 2291, 2, NULL, NULL, 'SMALL PARLOUR PICTURE FRAME', '23455');
INSERT INTO public.products VALUES (15, 4.12, 15, NULL, 2292, 2, NULL, NULL, 'MEDIUM PARLOUR PICTURE FRAME ', '23456');
INSERT INTO public.products VALUES (11, 5.10, 15, NULL, 2293, 2, NULL, NULL, 'LARGE PARLOUR PICTURE FRAME', '23457');
INSERT INTO public.products VALUES (10, 14.95, 20, NULL, 2294, 2, NULL, NULL, 'DOLLY CABINET 3 DRAWERS ', '23458');
INSERT INTO public.products VALUES (10, 12.50, 20, NULL, 2295, 2, NULL, NULL, 'DOLLY CABINET 2 DRAWERS ', '23459');
INSERT INTO public.products VALUES (10, 9.91, 22, NULL, 2296, 2, NULL, NULL, 'SWEETHEART WALL TIDY ', '23460');
INSERT INTO public.products VALUES (85, 4.52, 22, NULL, 2297, 2, NULL, NULL, 'SWEETHEART BIRD HOUSE', '23461');
INSERT INTO public.products VALUES (10, 20.14, 22, NULL, 2298, 2, NULL, NULL, 'ROCOCO WALL MIRROR WHITE', '23462');
INSERT INTO public.products VALUES (10, 11.21, 22, NULL, 2299, 2, NULL, NULL, 'VINTAGE ZINC WATERING CAN', '23463');
INSERT INTO public.products VALUES (10, 6.21, 22, NULL, 2300, 2, NULL, NULL, 'VINTAGE ZINC WATERING CAN SMALL', '23464');
INSERT INTO public.products VALUES (10, 8.77, 22, NULL, 2301, 2, NULL, NULL, 'TUSCAN VILLA FEEDING STATION', '23465');
INSERT INTO public.products VALUES (10, 10.02, 22, NULL, 2302, 2, NULL, NULL, 'TUSCAN VILLA DOVECOTE', '23466');
INSERT INTO public.products VALUES (10, 4.37, 22, NULL, 2303, 2, NULL, NULL, 'VINTAGE ZINC PLANTER  ', '23467');
INSERT INTO public.products VALUES (10, 8.25, 22, NULL, 2304, 2, NULL, NULL, 'TUSCAN VILLA BIRD TABLE ', '23468');
INSERT INTO public.products VALUES (32, 4.63, 19, NULL, 2305, 2, NULL, NULL, 'CARD HOLDER LOVE BIRD SMALL', '23469');
INSERT INTO public.products VALUES (22, 6.74, 19, NULL, 2306, 2, NULL, NULL, 'CARD HOLDER LOVE BIRD LARGE ', '23470');
INSERT INTO public.products VALUES (10, 10.15, 22, NULL, 2307, 2, NULL, NULL, 'SIX DRAWER OFFICE TIDY', '23471');
INSERT INTO public.products VALUES (10, 16.06, 22, NULL, 2308, 2, NULL, NULL, ' NINE DRAWER OFFICE TIDY', '23472');
INSERT INTO public.products VALUES (67, 0.95, 22, NULL, 2309, 2, NULL, NULL, 'WOODLAND SMALL RED FELT HEART', '23473');
INSERT INTO public.products VALUES (31, 1.04, 22, NULL, 2310, 2, NULL, NULL, 'WOODLAND SMALL BLUE FELT HEART', '23474');
INSERT INTO public.products VALUES (28, 0.96, 22, NULL, 2311, 2, NULL, NULL, 'WOODLAND SMALL PINK FELT HEART', '23475');
INSERT INTO public.products VALUES (20, 1.47, 22, NULL, 2312, 2, NULL, NULL, 'WOODLAND LARGE RED FELT HEART', '23476');
INSERT INTO public.products VALUES (10, 1.72, 22, NULL, 2313, 2, NULL, NULL, 'WOODLAND LARGE BLUE FELT HEART', '23477');
INSERT INTO public.products VALUES (28, 1.51, 22, NULL, 2314, 2, NULL, NULL, 'WOODLAND LARGE PINK FELT HEART', '23478');
INSERT INTO public.products VALUES (11, 8.26, 16, NULL, 2315, 2, NULL, NULL, 'WIRE EGG BASKET ', '23479');
INSERT INTO public.products VALUES (178, 4.39, 12, NULL, 2316, 2, NULL, NULL, 'MINI LIGHTS WOODLAND MUSHROOMS', '23480');
INSERT INTO public.products VALUES (22, 1.28, 22, NULL, 2317, 2, NULL, NULL, 'PEARLISED IVORY HEART SMALL ', '23481');
INSERT INTO public.products VALUES (41, 1.77, 22, NULL, 2318, 2, NULL, NULL, 'PEARLISED IVORY HEART LARGE ', '23482');
INSERT INTO public.products VALUES (131, 2.32, 12, NULL, 2319, 2, NULL, NULL, 'HANGING  BUTTERFLY T-LIGHT HOLDER', '23483');
INSERT INTO public.products VALUES (18, 3.67, 12, NULL, 2320, 2, NULL, NULL, 'HEART TRELLISTRIPLE T-LIGHT HOLDER', '23484');
INSERT INTO public.products VALUES (24, 24.55, 18, NULL, 2321, 2, NULL, NULL, 'BOTANICAL GARDENS WALL CLOCK ', '23485');
INSERT INTO public.products VALUES (26, 17.67, 22, NULL, 2322, 2, NULL, NULL, 'ANTIQUE HEART SHELF UNIT', '23486');
INSERT INTO public.products VALUES (10, 10.32, 22, NULL, 2323, 2, NULL, NULL, 'SWEET HEART CAKE CARRIER', '23487');
INSERT INTO public.products VALUES (91, 3.22, 22, NULL, 2324, 2, NULL, NULL, 'GARLAND, VINTAGE BELLS', '23489');
INSERT INTO public.products VALUES (54, 3.96, 12, NULL, 2325, 2, NULL, NULL, 'T-LIGHT HOLDER HANGING LOVE BIRD', '23490');
INSERT INTO public.products VALUES (22, 8.46, 22, NULL, 2326, 2, NULL, NULL, 'VINTAGE JINGLE BELLS HEART', '23491');
INSERT INTO public.products VALUES (10, 8.55, 22, NULL, 2327, 2, NULL, NULL, 'VINTAGE JINGLE BELLS WREATH', '23492');
INSERT INTO public.products VALUES (396, 2.15, 22, NULL, 2328, 2, NULL, NULL, 'VINTAGE DOILY TRAVEL SEWING KIT', '23493');
INSERT INTO public.products VALUES (74, 6.76, 22, NULL, 2329, 2, NULL, NULL, 'VINTAGE DOILY DELUXE SEWING KIT ', '23494');
INSERT INTO public.products VALUES (22, 1.72, 22, NULL, 2330, 2, NULL, NULL, 'SET OF 3 PANTRY WOODEN SPOONS', '23495');
INSERT INTO public.products VALUES (11, 1.56, 22, NULL, 2331, 2, NULL, NULL, 'PANTRY KITCHEN THERMOMETER ', '23496');
INSERT INTO public.products VALUES (254, 1.62, 22, NULL, 2332, 2, NULL, NULL, 'CLASSIC CHROME BICYCLE BELL ', '23497');
INSERT INTO public.products VALUES (164, 1.65, 22, NULL, 2333, 2, NULL, NULL, 'CLASSIC BICYCLE CLIPS ', '23498');
INSERT INTO public.products VALUES (131, 0.48, 22, NULL, 2334, 2, NULL, NULL, 'SET 12 VINTAGE DOILY CHALK ', '23499');
INSERT INTO public.products VALUES (163, 1.38, 22, NULL, 2335, 2, NULL, NULL, 'KEY RING BASEBALL BOOT ASSORTED ', '23500');
INSERT INTO public.products VALUES (182, 1.49, 22, NULL, 2336, 2, NULL, NULL, 'KEY RING BASEBALL BOOT UNION JACK', '23501');
INSERT INTO public.products VALUES (71, 1.30, 19, NULL, 2337, 2, NULL, NULL, 'PLAYING CARDS VINTAGE DOILEY ', '23502');
INSERT INTO public.products VALUES (364, 1.28, 19, NULL, 2338, 2, NULL, NULL, 'PLAYING CARDS KEEP CALM & CARRY ON', '23503');
INSERT INTO public.products VALUES (193, 1.35, 19, NULL, 2339, 2, NULL, NULL, 'PLAYING CARDS JUBILEE UNION JACK', '23504');
INSERT INTO public.products VALUES (120, 1.35, 19, NULL, 2340, 2, NULL, NULL, 'PLAYING CARDS I LOVE LONDON ', '23505');
INSERT INTO public.products VALUES (274, 0.46, 19, NULL, 2341, 2, NULL, NULL, 'MINI PLAYING CARDS SPACEBOY ', '23506');
INSERT INTO public.products VALUES (288, 0.47, 19, NULL, 2342, 2, NULL, NULL, 'MINI PLAYING CARDS BUFFALO BILL ', '23507');
INSERT INTO public.products VALUES (262, 0.46, 19, NULL, 2343, 2, NULL, NULL, 'MINI PLAYING CARDS DOLLY GIRL ', '23508');
INSERT INTO public.products VALUES (106, 0.48, 19, NULL, 2344, 2, NULL, NULL, 'MINI PLAYING CARDS FUN FAIR ', '23509');
INSERT INTO public.products VALUES (252, 0.50, 19, NULL, 2345, 2, NULL, NULL, 'MINI PLAYING CARDS GYMKHANA', '23510');
INSERT INTO public.products VALUES (56, 2.32, 19, NULL, 2346, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL EMILY ', '23511');
INSERT INTO public.products VALUES (50, 2.31, 19, NULL, 2347, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL ROSIE', '23512');
INSERT INTO public.products VALUES (56, 2.30, 19, NULL, 2348, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL SUSIE ', '23513');
INSERT INTO public.products VALUES (47, 2.35, 19, NULL, 2349, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL SALLY ', '23514');
INSERT INTO public.products VALUES (57, 2.39, 19, NULL, 2350, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL DAISY ', '23515');
INSERT INTO public.products VALUES (29, 3.85, 19, NULL, 2351, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL SOPHIE  ', '23516');
INSERT INTO public.products VALUES (33, 3.45, 19, NULL, 2352, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL REBECCA ', '23517');
INSERT INTO public.products VALUES (35, 3.09, 19, NULL, 2353, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL RACHEL ', '23518');
INSERT INTO public.products VALUES (22, 4.48, 19, NULL, 2354, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL CLAIRE', '23519');
INSERT INTO public.products VALUES (16, 3.96, 19, NULL, 2355, 2, NULL, NULL, 'EMBROIDERED RIBBON REEL RUBY ', '23520');
INSERT INTO public.products VALUES (41, 4.20, 22, NULL, 2356, 2, NULL, NULL, 'CAT AND BIRD WALL ART', '23521');
INSERT INTO public.products VALUES (35, 3.68, 22, NULL, 2357, 2, NULL, NULL, 'DOG AND BALL WALL ART', '23522');
INSERT INTO public.products VALUES (35, 3.93, 22, NULL, 2358, 2, NULL, NULL, 'TREASURE AHOY WALL ART', '23523');
INSERT INTO public.products VALUES (47, 4.32, 22, NULL, 2359, 2, NULL, NULL, 'HORSE & PONY WALL ART', '23524');
INSERT INTO public.products VALUES (57, 4.15, 22, NULL, 2360, 2, NULL, NULL, 'BUFFALO BILL WALL ART ', '23525');
INSERT INTO public.products VALUES (99, 8.22, 22, NULL, 2361, 2, NULL, NULL, 'DOG LICENCE WALL ART', '23526');
INSERT INTO public.products VALUES (41, 3.98, 22, NULL, 2362, 2, NULL, NULL, 'ANIMALS AND NATURE WALL ART', '23527');
INSERT INTO public.products VALUES (47, 4.78, 22, NULL, 2363, 2, NULL, NULL, 'SPACEBOY WALL ART', '23528');
INSERT INTO public.products VALUES (63, 4.34, 20, NULL, 2364, 2, NULL, NULL, 'DOLLY GIRL WALL ART', '23529');
INSERT INTO public.products VALUES (106, 5.57, 22, NULL, 2365, 2, NULL, NULL, 'WALL ART ONLY ONE PERSON ', '23530');
INSERT INTO public.products VALUES (97, 7.66, 22, NULL, 2366, 2, NULL, NULL, 'WALL ART BIG LOVE ', '23531');
INSERT INTO public.products VALUES (21, 5.30, 22, NULL, 2367, 2, NULL, NULL, 'WALL ART WORK REST AND PLAY  ', '23532');
INSERT INTO public.products VALUES (21, 6.17, 22, NULL, 2368, 2, NULL, NULL, 'WALL ART GARDEN HAVEN ', '23533');
INSERT INTO public.products VALUES (138, 7.52, 22, NULL, 2369, 2, NULL, NULL, 'STOP FOR TEA WALL ART', '23534');
INSERT INTO public.products VALUES (132, 7.41, 22, NULL, 2370, 2, NULL, NULL, 'BICYCLE SAFTEY WALL ART', '23535');
INSERT INTO public.products VALUES (62, 6.78, 22, NULL, 2371, 2, NULL, NULL, 'VILLAGE SHOW WALL ART', '23536');
INSERT INTO public.products VALUES (11, 6.94, 22, NULL, 2372, 2, NULL, NULL, 'I LOVE LONDON WALL ART', '23537');
INSERT INTO public.products VALUES (33, 5.75, 22, NULL, 2373, 2, NULL, NULL, 'WALL ART VINTAGE HEART', '23538');
INSERT INTO public.products VALUES (24, 6.59, 22, NULL, 2374, 2, NULL, NULL, 'WALL ART LOVES'' SECRET ', '23539');
INSERT INTO public.products VALUES (15, 8.42, 22, NULL, 2375, 2, NULL, NULL, 'WALL ART THE MAGIC FOREST ', '23540');
INSERT INTO public.products VALUES (87, 9.70, 22, NULL, 2376, 2, NULL, NULL, 'WALL ART CLASSIC PUDDINGS ', '23541');
INSERT INTO public.products VALUES (50, 9.73, 22, NULL, 2377, 2, NULL, NULL, '70''S ALPHABET WALL ART', '23542');
INSERT INTO public.products VALUES (123, 8.53, 22, NULL, 2378, 2, NULL, NULL, 'KEEP CALM WALL ART ', '23543');
INSERT INTO public.products VALUES (16, 7.56, 22, NULL, 2379, 2, NULL, NULL, 'WALL ART MID CENTURY MODERN ', '23544');
INSERT INTO public.products VALUES (248, 0.42, 19, NULL, 2380, 2, NULL, NULL, 'WRAP RED DOILEY', '23545');
INSERT INTO public.products VALUES (327, 0.42, 19, NULL, 2381, 2, NULL, NULL, 'WRAP PAISLEY PARK ', '23546');
INSERT INTO public.products VALUES (157, 0.42, 19, NULL, 2382, 2, NULL, NULL, 'WRAP FLOWER SHOP  ', '23547');
INSERT INTO public.products VALUES (107, 0.42, 19, NULL, 2383, 2, NULL, NULL, 'WRAP MAGIC FOREST ', '23548');
INSERT INTO public.products VALUES (130, 0.42, 19, NULL, 2384, 2, NULL, NULL, 'WRAP BIRD GARDEN ', '23549');
INSERT INTO public.products VALUES (185, 0.42, 19, NULL, 2385, 2, NULL, NULL, 'WRAP ALPHABET POSTER  ', '23550');
INSERT INTO public.products VALUES (184, 0.51, 22, NULL, 2386, 2, NULL, NULL, 'PACK OF 12 PAISLEY PARK TISSUES ', '23551');
INSERT INTO public.products VALUES (186, 2.26, 22, NULL, 2387, 2, NULL, NULL, 'BICYCLE PUNCTURE REPAIR KIT ', '23552');
INSERT INTO public.products VALUES (56, 13.29, 15, NULL, 2388, 2, NULL, NULL, 'LANDMARK FRAME CAMDEN TOWN ', '23553');
INSERT INTO public.products VALUES (42, 13.03, 15, NULL, 2389, 2, NULL, NULL, 'LANDMARK FRAME OXFORD STREET', '23554');
INSERT INTO public.products VALUES (42, 12.88, 15, NULL, 2390, 2, NULL, NULL, 'LANDMARK FRAME NOTTING HILL ', '23555');
INSERT INTO public.products VALUES (43, 12.61, 15, NULL, 2391, 2, NULL, NULL, 'LANDMARK FRAME COVENT GARDEN ', '23556');
INSERT INTO public.products VALUES (35, 13.18, 15, NULL, 2392, 2, NULL, NULL, 'LANDMARK FRAME BAKER STREET ', '23557');
INSERT INTO public.products VALUES (41, 13.09, 15, NULL, 2393, 2, NULL, NULL, 'LANDMARK FRAME LONDON BRIDGE ', '23558');
INSERT INTO public.products VALUES (65, 2.85, 22, NULL, 2394, 2, NULL, NULL, 'WOODLAND BUNNIES LOLLY MAKERS', '23559');
INSERT INTO public.products VALUES (17, 3.52, 19, NULL, 2395, 2, NULL, NULL, 'SET OF 6 RIBBONS COUNTRY STYLE', '23560');
INSERT INTO public.products VALUES (17, 3.41, 19, NULL, 2396, 2, NULL, NULL, 'SET OF 6 RIBBONS PARTY', '23561');
INSERT INTO public.products VALUES (25, 3.27, 19, NULL, 2397, 2, NULL, NULL, 'SET OF 6 RIBBONS PERFECTLY PRETTY  ', '23562');
INSERT INTO public.products VALUES (64, 1.76, 14, NULL, 2398, 2, NULL, NULL, 'EGG CUP MILKMAID INGRID', '23564');
INSERT INTO public.products VALUES (40, 1.83, 14, NULL, 2399, 2, NULL, NULL, 'EGG CUP MILKMAID HELGA ', '23565');
INSERT INTO public.products VALUES (87, 1.76, 14, NULL, 2400, 2, NULL, NULL, 'EGG CUP MILKMAID HEIDI', '23566');
INSERT INTO public.products VALUES (21, 1.81, 14, NULL, 2401, 2, NULL, NULL, 'EGG CUP HENRIETTA HEN PINK', '23567');
INSERT INTO public.products VALUES (62, 1.74, 14, NULL, 2402, 2, NULL, NULL, 'EGG CUP HENRIETTA HEN CREAM ', '23568');
INSERT INTO public.products VALUES (95, 5.29, 22, NULL, 2403, 2, NULL, NULL, 'TRADTIONAL ALPHABET STAMP SET', '23569');
INSERT INTO public.products VALUES (278, 1.43, 20, NULL, 2404, 2, NULL, NULL, 'TRADITIONAL PICK UP STICKS GAME ', '23570');
INSERT INTO public.products VALUES (285, 1.89, 22, NULL, 2405, 2, NULL, NULL, 'TRADITIONAL NAUGHTS & CROSSES', '23571');
INSERT INTO public.products VALUES (10, 7.50, 22, NULL, 2406, 2, NULL, NULL, 'PACKING CHARGE', '23574');
INSERT INTO public.products VALUES (17, 2.58, 22, NULL, 2407, 2, NULL, NULL, 'SNACK TRAY PAISLEY PARK', '23575');
INSERT INTO public.products VALUES (19, 2.40, 22, NULL, 2408, 2, NULL, NULL, 'SNACK TRAY RED VINTAGE DOILY', '23576');
INSERT INTO public.products VALUES (10, 2.42, 22, NULL, 2409, 2, NULL, NULL, 'SNACK TRAY RED GINGHAM', '23578');
INSERT INTO public.products VALUES (17, 2.52, 22, NULL, 2410, 2, NULL, NULL, 'SNACK TRAY I LOVE LONDON', '23579');
INSERT INTO public.products VALUES (11, 2.20, 22, NULL, 2411, 2, NULL, NULL, 'SNACK TRAY HAPPY FOREST  ', '23580');
INSERT INTO public.products VALUES (491, 2.25, 13, NULL, 2412, 2, NULL, NULL, 'JUMBO BAG PAISLEY PARK', '23581');
INSERT INTO public.products VALUES (469, 2.21, 13, NULL, 2413, 2, NULL, NULL, 'VINTAGE DOILY JUMBO BAG RED ', '23582');
INSERT INTO public.products VALUES (338, 1.80, 13, NULL, 2414, 2, NULL, NULL, 'LUNCH BAG PAISLEY PARK  ', '23583');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2415, 2, NULL, NULL, 'adjustment', '23595');
INSERT INTO public.products VALUES (24, 3.17, 16, NULL, 2416, 2, NULL, NULL, 'PAPER BUNTING PAISLEY PARK', '23597');
INSERT INTO public.products VALUES (42, 3.23, 16, NULL, 2417, 2, NULL, NULL, 'PAPER BUNTING VINTAGE PARTY', '23598');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2418, 2, NULL, NULL, 'SET 10 CARDS SNOWY SNOWDROPS  17100', '23601');
INSERT INTO public.products VALUES (10, 2.91, 19, NULL, 2419, 2, NULL, NULL, 'SET 10 CARDS 3 WISE MEN 17107', '23602');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2420, 2, NULL, NULL, 'SET 10 CARD KRAFT REINDEER 17084', '23603');
INSERT INTO public.products VALUES (10, 1.66, 17, NULL, 2421, 2, NULL, NULL, 'SET 10 MINI SANTA & SNOWMAN  17087', '23604');
INSERT INTO public.products VALUES (10, 2.91, 17, NULL, 2422, 2, NULL, NULL, 'SET 10 CARDS 12 DAYS OF XMAS 17059', '23605');
INSERT INTO public.products VALUES (10, 1.66, 19, NULL, 2423, 2, NULL, NULL, 'SET 10 CARDS HATS & STOCKINGS 17081', '23607');
INSERT INTO public.products VALUES (10, 2.91, 19, NULL, 2424, 2, NULL, NULL, 'SET 10 CARDS RUDOLPHS NOSE 17097', '23608');
INSERT INTO public.products VALUES (10, 2.91, 19, NULL, 2425, 2, NULL, NULL, 'SET 10 CARDS SNOWY ROBIN 17099', '23609');
INSERT INTO public.products VALUES (10, 2.08, 17, NULL, 2426, 2, NULL, NULL, 'SET 10 CARDS CHRISTMAS ROBIN 17095', '23610');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2427, 2, NULL, NULL, 'SET 10 CARDS RED RIDING HOOD 17214', '23611');
INSERT INTO public.products VALUES (10, 1.66, 19, NULL, 2428, 2, NULL, NULL, 'SET 10 MINICARDS CUTE SNOWMAN 17071', '23612');
INSERT INTO public.products VALUES (10, 2.49, 17, NULL, 2429, 2, NULL, NULL, 'SET 10 XMAS CARDS & BADGES 17070', '23613');
INSERT INTO public.products VALUES (10, 3.33, 19, NULL, 2430, 2, NULL, NULL, 'SET 10 CARDS 12 DAYS WRAP  17058', '23614');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2431, 2, NULL, NULL, 'SET 10 CARDS PRINTED GRAPHIC 17219', '23615');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2432, 2, NULL, NULL, 'SET 10 CARDS JINGLE BELLS 17217', '23616');
INSERT INTO public.products VALUES (10, 2.91, 17, NULL, 2433, 2, NULL, NULL, 'SET 10 CARDS SWIRLY XMAS TREE 17104', '23617');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2434, 2, NULL, NULL, 'SET 10 CARDS POINSETTIA 17093', '23619');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2435, 2, NULL, NULL, 'SET 10 CARDS PERFECT POST 17090', '23620');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2436, 2, NULL, NULL, 'SET 10 CARDS DAVID''S MADONNA 17074', '23621');
INSERT INTO public.products VALUES (10, 2.91, 17, NULL, 2437, 2, NULL, NULL, 'SET 10 CARD CHRISTMAS WELCOME 17112', '23623');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2438, 2, NULL, NULL, 'SET 10 CARD PERFECT NATIVITY 17089', '23624');
INSERT INTO public.products VALUES (10, 4.99, 19, NULL, 2439, 2, NULL, NULL, 'SET 6 CARDS SPARKLY REINDEER 17262', '23625');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2440, 2, NULL, NULL, 'SET 10 CARDS DINKY TREE 17076', '23626');
INSERT INTO public.products VALUES (10, 2.49, 17, NULL, 2441, 2, NULL, NULL, 'SET 10 CARDS XMAS GRAPHIC  17218', '23627');
INSERT INTO public.products VALUES (10, 2.91, 19, NULL, 2442, 2, NULL, NULL, 'SET 10 CARDS TRIANGLE ICONS  17220', '23628');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2443, 2, NULL, NULL, 'SET 10 CARDS DRESSING UP 17077', '23629');
INSERT INTO public.products VALUES (10, 2.82, 19, NULL, 2444, 2, NULL, NULL, 'SET 10 CARDS HANGING BAUBLES 17080', '23630');
INSERT INTO public.products VALUES (10, 2.08, 19, NULL, 2445, 2, NULL, NULL, 'SET 10 CARDS CHEERFUL ROBIN 17065', '23632');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2446, 2, NULL, NULL, 'SET 10 CARDS WORLD CHILDREN 17067', '23633');
INSERT INTO public.products VALUES (10, 2.91, 17, NULL, 2447, 2, NULL, NULL, 'SET 10 CARDS XMAS CHOIR 17068', '23634');
INSERT INTO public.products VALUES (10, 4.16, 17, NULL, 2448, 2, NULL, NULL, 'SET 10 CARDS CHRISTMAS HOLLY  17259', '23635');
INSERT INTO public.products VALUES (10, 2.91, 19, NULL, 2449, 2, NULL, NULL, 'SET 10 CARDS WISHING TREE 17116', '23636');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2450, 2, NULL, NULL, 'SET 10 CARDS OUT OF ORDER 17216', '23637');
INSERT INTO public.products VALUES (10, 2.91, 19, NULL, 2451, 2, NULL, NULL, 'SET 10 CARDS ROBIN WATERPUMP  17096', '23638');
INSERT INTO public.products VALUES (10, 3.33, 19, NULL, 2452, 2, NULL, NULL, 'SET 10 CARDS MAGICAL TREE 17086', '23639');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2453, 2, NULL, NULL, 'SET 10 CARDS SCOTTIE DOG 17211', '23640');
INSERT INTO public.products VALUES (10, 3.33, 17, NULL, 2454, 2, NULL, NULL, 'SET 10 CARDS CHRISTMAS BAUBLE 16954', '23643');
INSERT INTO public.products VALUES (10, 3.33, 17, NULL, 2455, 2, NULL, NULL, 'SET 10 CARDS CHRISTMAS TREE 16955', '23644');
INSERT INTO public.products VALUES (10, 2.49, 17, NULL, 2456, 2, NULL, NULL, 'SET 10 CHRISTMAS CARDS HOHOHO 16956', '23645');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2457, 2, NULL, NULL, 'SET 10 CARDS JINGLE BELLS 16957', '23646');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2458, 2, NULL, NULL, 'SET 10 CARDS DECK THE HALLS 16960', '23649');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2459, 2, NULL, NULL, 'SET 10 CARDS FILIGREE BAUBLE 16961', '23650');
INSERT INTO public.products VALUES (10, 2.91, 17, NULL, 2460, 2, NULL, NULL, 'SET 10 CARD CHRISTMAS STAMPS 16963', '23652');
INSERT INTO public.products VALUES (10, 2.49, 19, NULL, 2461, 2, NULL, NULL, 'SET 10 CARD SNOWMAN 16965', '23654');
INSERT INTO public.products VALUES (29, 2.19, 14, NULL, 2462, 2, NULL, NULL, 'HENRIETTA HEN MUG ', '23660');
INSERT INTO public.products VALUES (19, 2.17, 14, NULL, 2463, 2, NULL, NULL, 'MILK MAIDS MUG ', '23661');
INSERT INTO public.products VALUES (10, 1.65, 14, NULL, 2464, 2, NULL, NULL, 'FLOWER SHOP DESIGN MUG', '23664');
INSERT INTO public.products VALUES (157, 1.86, 13, NULL, 2465, 2, NULL, NULL, 'LUNCH BAG RED VINTAGE DOILY', '23681');
INSERT INTO public.products VALUES (117, 0.42, 19, NULL, 2466, 2, NULL, NULL, 'KEEP CALM BIRTHDAY WRAP', '23691');
INSERT INTO public.products VALUES (10, 0.42, 19, NULL, 2467, 2, NULL, NULL, 'WRAP A PRETTY THANK YOU', '23692');
INSERT INTO public.products VALUES (37, 0.59, 19, NULL, 2468, 2, NULL, NULL, 'PAISLEY PARK CARD', '23694');
INSERT INTO public.products VALUES (76, 0.50, 19, NULL, 2469, 2, NULL, NULL, 'DOILY THANK YOU CARD', '23695');
INSERT INTO public.products VALUES (45, 0.52, 19, NULL, 2470, 2, NULL, NULL, 'A PRETTY THANK YOU CARD', '23697');
INSERT INTO public.products VALUES (10, 8.50, 22, NULL, 2471, 2, NULL, NULL, 'High Resolution Image', '23702');
INSERT INTO public.products VALUES (10, 2.08, 22, NULL, 2472, 2, NULL, NULL, 'PAPER CRAFT , LITTLE BIRDIE', '23843');
INSERT INTO public.products VALUES (19, 3.71, 22, NULL, 2473, 2, NULL, NULL, 'HAND OPEN SHAPE GOLD', '35001G');
INSERT INTO public.products VALUES (10, 3.15, 22, NULL, 2474, 2, NULL, NULL, 'HAND OPEN SHAPE DECO.WHITE', '35001W');
INSERT INTO public.products VALUES (54, 6.13, 22, NULL, 2475, 2, NULL, NULL, 'SET OF 3 BLACK FLYING DUCKS', '35004B');
INSERT INTO public.products VALUES (35, 5.18, 22, NULL, 2476, 2, NULL, NULL, 'SET OF 3 COLOURED  FLYING DUCKS', '35004C');
INSERT INTO public.products VALUES (12, 5.20, 22, NULL, 2477, 2, NULL, NULL, 'SET OF 3 GOLD FLYING DUCKS', '35004G');
INSERT INTO public.products VALUES (10, 5.45, 22, NULL, 2478, 2, NULL, NULL, 'SET OF 3 PINK FLYING DUCKS', '35004P');
INSERT INTO public.products VALUES (92, 0.69, 16, NULL, 2479, 2, NULL, NULL, 'BLUE VICTORIAN FABRIC OVAL BOX', '35095A');
INSERT INTO public.products VALUES (86, 0.66, 16, NULL, 2480, 2, NULL, NULL, 'RED VICTORIAN FABRIC OVAL BOX', '35095B');
INSERT INTO public.products VALUES (10, 5.78, 22, NULL, 2481, 2, NULL, NULL, 'ENAMEL BLUE RIM BISCUIT BIN', '35241');
INSERT INTO public.products VALUES (10, 2.29, 22, NULL, 2482, 2, NULL, NULL, 'COLOURFUL FLOWER FRUIT BOWL', '35265');
INSERT INTO public.products VALUES (10, 0.19, 13, NULL, 2483, 2, NULL, NULL, 'GOLD PRINT PAPER BAG', '35271S');
INSERT INTO public.products VALUES (10, 8.80, 16, NULL, 2484, 2, NULL, NULL, 'WOODEN BOX ADVENT CALENDAR ', '35400');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 2485, 2, NULL, NULL, 'RASTA IN BATH W SPLIFF ASHTRAY', '35443');
INSERT INTO public.products VALUES (186, 0.91, 12, NULL, 2486, 2, NULL, NULL, 'SET OF 3 BIRD LIGHT PINK FEATHER ', '35471D');
INSERT INTO public.products VALUES (10, 1.25, 17, NULL, 2487, 2, NULL, NULL, 'TURQUOISE CHRISTMAS TREE ', '35591T');
INSERT INTO public.products VALUES (10, 1.25, 17, NULL, 2488, 2, NULL, NULL, 'DUSTY PINK CHRISTMAS TREE 30CM', '35597A');
INSERT INTO public.products VALUES (10, 1.25, 17, NULL, 2489, 2, NULL, NULL, 'BLACKCHRISTMAS TREE 30CM', '35597B');
INSERT INTO public.products VALUES (10, 0.38, 17, NULL, 2490, 2, NULL, NULL, 'PINK/WHITE CHRISTMAS TREE 30CM', '35597D');
INSERT INTO public.products VALUES (10, 2.95, 17, NULL, 2491, 2, NULL, NULL, 'DUSTY PINK CHRISTMAS TREE 60CM', '35598A');
INSERT INTO public.products VALUES (55, 1.93, 17, NULL, 2492, 2, NULL, NULL, 'BLACK CHRISTMAS TREE 60CM', '35598B');
INSERT INTO public.products VALUES (10, 1.97, 22, NULL, 2493, 2, NULL, NULL, 'found', '35598C');
INSERT INTO public.products VALUES (68, 1.48, 17, NULL, 2494, 2, NULL, NULL, 'PINK/WHITE CHRISTMAS TREE 60CM', '35598D');
INSERT INTO public.products VALUES (21, 3.46, 17, NULL, 2495, 2, NULL, NULL, 'BLACK CHRISTMAS TREE 120CM', '35599B');
INSERT INTO public.products VALUES (20, 4.02, 17, NULL, 2496, 2, NULL, NULL, 'PINK AND WHITE CHRISTMAS TREE 120CM', '35599D');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2497, 2, NULL, NULL, 'Found by jackie', '35600A');
INSERT INTO public.products VALUES (10, 0.91, 17, NULL, 2498, 2, NULL, NULL, 'PINK FLUFFY CHRISTMAS DECORATION', '35607A');
INSERT INTO public.products VALUES (10, 0.17, 17, NULL, 2499, 2, NULL, NULL, 'BLACK FEATHER CHRISTMAS DECORATION', '35607B');
INSERT INTO public.products VALUES (10, 2.51, 17, NULL, 2500, 2, NULL, NULL, 'PINK FEATHER CHRISTMAS DECORATION', '35609A');
INSERT INTO public.products VALUES (10, 1.57, 17, NULL, 2501, 2, NULL, NULL, 'PINK CHRISTMAS FLOCK DROPLET ', '35610A');
INSERT INTO public.products VALUES (10, 0.62, 17, NULL, 2502, 2, NULL, NULL, 'BLACK CHRISTMAS FLOCK DROPLET ', '35610B');
INSERT INTO public.products VALUES (10, 1.25, 17, NULL, 2503, 2, NULL, NULL, 'WHITE CHRISTMAS FLOCK DROPLET ', '35610C');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2504, 2, NULL, NULL, 'thrown away', '35611B');
INSERT INTO public.products VALUES (17, 4.99, 22, NULL, 2505, 2, NULL, NULL, 'IVORY STRING CURTAIN WITH POLE ', '35637A');
INSERT INTO public.products VALUES (10, 6.21, 22, NULL, 2506, 2, NULL, NULL, 'PINK STRING CURTAIN WITH POLE', '35637C');
INSERT INTO public.products VALUES (10, 3.55, 22, NULL, 2507, 2, NULL, NULL, 'PINK AND BLACK STRING CURTAIN', '35638A');
INSERT INTO public.products VALUES (10, 5.39, 22, NULL, 2508, 2, NULL, NULL, 'PINK/BLUE STRING CURTAIN ', '35638B');
INSERT INTO public.products VALUES (10, 4.25, 16, NULL, 2509, 2, NULL, NULL, 'VINTAGE BEAD PINK JEWEL BOX', '35645');
INSERT INTO public.products VALUES (61, 2.04, 13, NULL, 2510, 2, NULL, NULL, 'VINTAGE BEAD PINK EVENING BAG', '35646');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 2511, 2, NULL, NULL, 'VINTAGE BEAD PINK SHADE ', '35647');
INSERT INTO public.products VALUES (90, 1.43, 13, NULL, 2512, 2, NULL, NULL, 'VINTAGE BEAD PINK PURSE ', '35648');
INSERT INTO public.products VALUES (10, 2.70, 13, NULL, 2513, 2, NULL, NULL, 'VINTAGE BEAD COSMETIC BAG ', '35649');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 2514, 2, NULL, NULL, 'VINTAGE BEAD PINK JEWEL STAND', '35650');
INSERT INTO public.products VALUES (43, 2.88, 22, NULL, 2515, 2, NULL, NULL, 'VINTAGE BEAD PINK SCARF ', '35651');
INSERT INTO public.products VALUES (15, 3.35, 22, NULL, 2516, 2, NULL, NULL, 'VINTAGE BEAD NOTEBOOK', '35653');
INSERT INTO public.products VALUES (42, 1.91, 22, NULL, 2517, 2, NULL, NULL, 'ENAMEL PINK TEA CONTAINER', '35809A');
INSERT INTO public.products VALUES (10, 1.68, 22, NULL, 2518, 2, NULL, NULL, 'ENAMEL BLUE RIM TEA CONTAINER', '35809B');
INSERT INTO public.products VALUES (10, 4.15, 22, NULL, 2519, 2, NULL, NULL, 'ENAMEL PINK TEA CONTAINER', '35809a');
INSERT INTO public.products VALUES (55, 1.62, 22, NULL, 2520, 2, NULL, NULL, 'ENAMEL PINK COFFEE CONTAINER', '35810A');
INSERT INTO public.products VALUES (13, 1.63, 22, NULL, 2521, 2, NULL, NULL, 'ENAMEL BLUE RIM COFFEE CONTAINER', '35810B');
INSERT INTO public.products VALUES (16, 0.72, 22, NULL, 2522, 2, NULL, NULL, 'ACRYLIC JEWEL SNOWFLAKE, PINK', '35815P');
INSERT INTO public.products VALUES (10, 0.38, 22, NULL, 2523, 2, NULL, NULL, 'ACRYLIC JEWEL ANGEL,PINK', '35816P');
INSERT INTO public.products VALUES (10, 0.98, 22, NULL, 2524, 2, NULL, NULL, 'ACRYLIC JEWEL SNOWFLAKE,PINK', '35817P');
INSERT INTO public.products VALUES (10, 0.29, 22, NULL, 2525, 2, NULL, NULL, 'ACRYLIC JEWEL ICICLE, BLUE', '35818B');
INSERT INTO public.products VALUES (26, 0.67, 22, NULL, 2526, 2, NULL, NULL, 'ACRYLIC JEWEL ICICLE, PINK', '35818P');
INSERT INTO public.products VALUES (28, 0.51, 22, NULL, 2527, 2, NULL, NULL, 'ACRYLIC HANGING JEWEL,BLUE', '35819B');
INSERT INTO public.products VALUES (10, 0.50, 22, NULL, 2528, 2, NULL, NULL, 'ACRYLIC HANGING JEWEL,PINK', '35819P');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 2529, 2, NULL, NULL, 'WOOLLY HAT SOCK GLOVE ADVENT STRING', '35832');
INSERT INTO public.products VALUES (10, 1.68, 17, NULL, 2530, 2, NULL, NULL, '4 GOLD FLOCK CHRISTMAS BALLS', '35833G');
INSERT INTO public.products VALUES (10, 2.16, 17, NULL, 2531, 2, NULL, NULL, '4 PINK FLOCK CHRISTMAS BALLS', '35833P');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 2532, 2, NULL, NULL, 'RABBIT EASTER DECORATION', '35909A');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 2533, 2, NULL, NULL, 'PINK FLOWERS RABBIT EASTER', '35909B');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 2534, 2, NULL, NULL, 'MULTICOLOUR EASTER RABBIT ', '35910A');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 2535, 2, NULL, NULL, 'PINK FLOWERS RABBIT EASTER', '35910B');
INSERT INTO public.products VALUES (31, 0.97, 22, NULL, 2536, 2, NULL, NULL, 'MULTICOLOUR RABBIT EGG WARMER', '35911A');
INSERT INTO public.products VALUES (11, 1.14, 22, NULL, 2537, 2, NULL, NULL, 'PINK/FLOWER RABBIT EGG WARMER ', '35911B');
INSERT INTO public.products VALUES (25, 1.69, 22, NULL, 2538, 2, NULL, NULL, 'WHITE/PINK CHICK DECORATION', '35912B');
INSERT INTO public.products VALUES (10, 1.07, 22, NULL, 2539, 2, NULL, NULL, 'WHITE/PINK CHICK EASTER DECORATION', '35913B');
INSERT INTO public.products VALUES (19, 1.10, 14, NULL, 2540, 2, NULL, NULL, 'PINK CHICK EGG WARMER + EGG CUP', '35914');
INSERT INTO public.products VALUES (22, 1.06, 22, NULL, 2541, 2, NULL, NULL, 'BLUE KNITTED HEN ', '35915B');
INSERT INTO public.products VALUES (27, 1.03, 22, NULL, 2542, 2, NULL, NULL, 'PEACH KNITTED HEN ', '35915C');
INSERT INTO public.products VALUES (10, 0.79, 22, NULL, 2543, 2, NULL, NULL, 'YELLOW FELT HANGING HEART W FLOWER', '35916A');
INSERT INTO public.products VALUES (10, 0.76, 22, NULL, 2544, 2, NULL, NULL, 'BLUE FELT HANGING HEART W FLOWER', '35916B');
INSERT INTO public.products VALUES (10, 0.89, 22, NULL, 2545, 2, NULL, NULL, 'PINK FELT HANGING HEART W FLOWER', '35916C');
INSERT INTO public.products VALUES (10, 1.99, 22, NULL, 2546, 2, NULL, NULL, 'FOUR RABBIT EASTER DECORATIONS', '35920');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 2547, 2, NULL, NULL, 'EASTER BUNNY HANGING GARLAND', '35921');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 2548, 2, NULL, NULL, 'EASTER BUNNY WREATH', '35922');
INSERT INTO public.products VALUES (127, 0.76, 22, NULL, 2549, 2, NULL, NULL, 'CANDY HEART HANGING DECORATION', '35923');
INSERT INTO public.products VALUES (64, 2.49, 22, NULL, 2550, 2, NULL, NULL, 'HANGING FAIRY CAKE DECORATION', '35924');
INSERT INTO public.products VALUES (22, 0.65, 17, NULL, 2551, 2, NULL, NULL, 'PINK STOCKING CHRISTMAS DECORATION', '35933');
INSERT INTO public.products VALUES (355, 0.60, 17, NULL, 2552, 2, NULL, NULL, 'FOLKART STAR CHRISTMAS DECORATIONS', '35953');
INSERT INTO public.products VALUES (88, 0.82, 17, NULL, 2553, 2, NULL, NULL, 'SMALL FOLKART STAR CHRISTMAS DEC', '35954');
INSERT INTO public.products VALUES (59, 1.40, 17, NULL, 2554, 2, NULL, NULL, 'SMALLFOLKART BAUBLE CHRISTMAS DEC', '35957');
INSERT INTO public.products VALUES (10, 0.85, 17, NULL, 2555, 2, NULL, NULL, 'FOLKART ZINC STAR CHRISTMAS DEC', '35958');
INSERT INTO public.products VALUES (299, 1.13, 17, NULL, 2556, 2, NULL, NULL, 'FOLKART ZINC HEART CHRISTMAS DEC', '35961');
INSERT INTO public.products VALUES (78, 0.84, 22, NULL, 2557, 2, NULL, NULL, 'FOLKART CLIP ON STARS', '35964');
INSERT INTO public.products VALUES (36, 2.27, 22, NULL, 2558, 2, NULL, NULL, 'FOLKART HEART NAPKIN RINGS', '35965');
INSERT INTO public.products VALUES (10, 0.38, 12, NULL, 2559, 2, NULL, NULL, 'FOLKART CHRISTMAS TREE T-LIGHT HOLD', '35966');
INSERT INTO public.products VALUES (48, 0.73, 12, NULL, 2560, 2, NULL, NULL, 'FOLK ART METAL STAR T-LIGHT HOLDER', '35967');
INSERT INTO public.products VALUES (23, 0.39, 12, NULL, 2561, 2, NULL, NULL, 'FOLK ART METAL HEART T-LIGHT HOLDER', '35968');
INSERT INTO public.products VALUES (499, 2.40, 22, NULL, 2562, 2, NULL, NULL, 'ZINC FOLKART SLEIGH BELLS', '35970');
INSERT INTO public.products VALUES (44, 1.80, 22, NULL, 2563, 2, NULL, NULL, 'ROSE FOLKART HEART DECORATIONS', '35971');
INSERT INTO public.products VALUES (10, 1.18, 22, NULL, 2564, 2, NULL, NULL, 'DAISY FOLKART HEART DECORATION', '35972');
INSERT INTO public.products VALUES (135, 1.55, 14, NULL, 2565, 2, NULL, NULL, 'ASSTD MULTICOLOUR CIRCLES MUG', '37327');
INSERT INTO public.products VALUES (10, 0.39, 14, NULL, 2566, 2, NULL, NULL, 'BIG POLKADOT MUG', '37330');
INSERT INTO public.products VALUES (10, 5.02, 22, NULL, 2567, 2, NULL, NULL, 'RETRO "TEA FOR ONE" ', '37333');
INSERT INTO public.products VALUES (252, 2.61, 14, NULL, 2568, 2, NULL, NULL, 'MULTICOLOUR SPRING FLOWER MUG', '37340');
INSERT INTO public.products VALUES (151, 1.54, 14, NULL, 2569, 2, NULL, NULL, 'POLKADOT COFFEE CUP & SAUCER PINK', '37342');
INSERT INTO public.products VALUES (10, 2.05, 14, NULL, 2570, 2, NULL, NULL, 'POLKADOT MUG PINK ', '37343');
INSERT INTO public.products VALUES (10, 0.82, 14, NULL, 2571, 2, NULL, NULL, 'ORANGE FLOWER MUG ', '37351');
INSERT INTO public.products VALUES (117, 5.15, 14, NULL, 2572, 2, NULL, NULL, 'RETRO COFFEE MUGS ASSORTED', '37370');
INSERT INTO public.products VALUES (10, 1.25, 14, NULL, 2573, 2, NULL, NULL, 'PINK CHERRY BLOSSOM CUP & SAUCER', '37379A');
INSERT INTO public.products VALUES (70, 0.41, 14, NULL, 2574, 2, NULL, NULL, 'ICON MUG REVOLUTIONARY', '37413');
INSERT INTO public.products VALUES (10, 0.54, 22, NULL, 2575, 2, NULL, NULL, 'WHITE WITH BLACK CATS PLATE', '37423');
INSERT INTO public.products VALUES (10, 1.87, 14, NULL, 2576, 2, NULL, NULL, 'YELLOW BREAKFAST CUP AND SAUCER', '37444A');
INSERT INTO public.products VALUES (10, 2.95, 14, NULL, 2577, 2, NULL, NULL, 'BLUE BREAKFAST CUP AND SAUCER ', '37444B');
INSERT INTO public.products VALUES (10, 2.09, 14, NULL, 2578, 2, NULL, NULL, 'PINK BREAKFAST CUP AND SAUCER ', '37444C');
INSERT INTO public.products VALUES (129, 1.75, 22, NULL, 2579, 2, NULL, NULL, 'MINI CAKE STAND WITH HANGING CAKES', '37446');
INSERT INTO public.products VALUES (80, 2.07, 21, NULL, 2580, 2, NULL, NULL, 'CERAMIC CAKE DESIGN SPOTTED PLATE', '37447');
INSERT INTO public.products VALUES (141, 1.77, 14, NULL, 2581, 2, NULL, NULL, 'CERAMIC CAKE DESIGN SPOTTED MUG', '37448');
INSERT INTO public.products VALUES (51, 9.84, 22, NULL, 2582, 2, NULL, NULL, 'CERAMIC CAKE STAND + HANGING CAKES', '37449');
INSERT INTO public.products VALUES (68, 3.58, 22, NULL, 2583, 2, NULL, NULL, 'CERAMIC CAKE BOWL + HANGING CAKES', '37450');
INSERT INTO public.products VALUES (10, 1.25, 14, NULL, 2584, 2, NULL, NULL, 'FUNKY MONKEY MUG', '37461');
INSERT INTO public.products VALUES (10, 0.64, 14, NULL, 2585, 2, NULL, NULL, 'PET MUG, GOLDFISH', '37462E');
INSERT INTO public.products VALUES (10, 1.25, 14, NULL, 2586, 2, NULL, NULL, 'ROBOT MUG IN DISPLAY BOX', '37464');
INSERT INTO public.products VALUES (15, 1.44, 14, NULL, 2587, 2, NULL, NULL, 'PIG MUG IN TWO COLOUR DESIGNS', '37467');
INSERT INTO public.products VALUES (10, 0.89, 14, NULL, 2588, 2, NULL, NULL, 'HARDMAN MUG 3 ASSORTED', '37468');
INSERT INTO public.products VALUES (10, 2.08, 22, NULL, 2589, 2, NULL, NULL, 'MULTICOLOUR POLKADOT PLATE', '37471');
INSERT INTO public.products VALUES (10, 9.95, 22, NULL, 2590, 2, NULL, NULL, 'SET/4 2 TONE EGG SHAPE MIXING BOWLS', '37474');
INSERT INTO public.products VALUES (10, 9.83, 22, NULL, 2591, 2, NULL, NULL, 'SET/4 COLOURFUL MIXING BOWLS', '37475');
INSERT INTO public.products VALUES (10, 11.49, 22, NULL, 2592, 2, NULL, NULL, 'CONDIMENT TRAY 4 BOWLS AND 4 SPOONS', '37476');
INSERT INTO public.products VALUES (10, 1.50, 14, NULL, 2593, 2, NULL, NULL, 'CUBIC MUG FLOCK BLUE ON BROWN', '37479B');
INSERT INTO public.products VALUES (10, 2.01, 14, NULL, 2594, 2, NULL, NULL, 'CUBIC MUG FLOCK PINK ON BROWN', '37479P');
INSERT INTO public.products VALUES (41, 2.60, 14, NULL, 2595, 2, NULL, NULL, 'CUBIC MUG PINK POLKADOT', '37482P');
INSERT INTO public.products VALUES (10, 0.19, 21, NULL, 2596, 2, NULL, NULL, 'YELLOW/ORANGE FLOWER DESIGN PLATE', '37487B');
INSERT INTO public.products VALUES (10, 0.29, 21, NULL, 2597, 2, NULL, NULL, 'YELLOW PINK FLOWER DESIGN BIG BOWL', '37488A');
INSERT INTO public.products VALUES (10, 0.49, 14, NULL, 2598, 2, NULL, NULL, 'YELLOW/PINK FLOWER DESIGN BIG MUG', '37489A');
INSERT INTO public.products VALUES (10, 0.65, 14, NULL, 2599, 2, NULL, NULL, 'BLUE/YELLOW FLOWER DESIGN BIG MUG', '37489B');
INSERT INTO public.products VALUES (10, 0.78, 14, NULL, 2600, 2, NULL, NULL, 'GREEN/BLUE FLOWER DESIGN BIG MUG', '37489C');
INSERT INTO public.products VALUES (10, 0.48, 14, NULL, 2601, 2, NULL, NULL, 'PINK/GREEN FLOWER DESIGN BIG MUG', '37489D');
INSERT INTO public.products VALUES (10, 3.31, 12, NULL, 2602, 2, NULL, NULL, 'YELLOW/PINK CERAMIC CANDLE HOLDER', '37491A');
INSERT INTO public.products VALUES (10, 1.65, 12, NULL, 2603, 2, NULL, NULL, 'BLUE/YELLOW CERAMIC CANDLE HOLDER', '37491B');
INSERT INTO public.products VALUES (10, 1.65, 12, NULL, 2604, 2, NULL, NULL, 'GREEN/BLUE CERAMIC CANDLE HOLDER', '37491C');
INSERT INTO public.products VALUES (10, 2.47, 12, NULL, 2605, 2, NULL, NULL, 'PURPLE/BLUE CERAMIC CANDLE HOLDER', '37491D');
INSERT INTO public.products VALUES (39, 3.99, 12, NULL, 2606, 2, NULL, NULL, 'FAIRY CAKE BIRTHDAY CANDLE SET', '37495');
INSERT INTO public.products VALUES (37, 7.24, 16, NULL, 2607, 2, NULL, NULL, 'TEA TIME TEAPOT IN GIFT BOX', '37500');
INSERT INTO public.products VALUES (13, 6.68, 16, NULL, 2608, 2, NULL, NULL, 'TEA TIME TEA SET IN GIFT BOX', '37501');
INSERT INTO public.products VALUES (10, 10.75, 16, NULL, 2609, 2, NULL, NULL, 'TEA TIME CAKE STAND IN GIFT BOX', '37503');
INSERT INTO public.products VALUES (10, 2.55, 14, NULL, 2610, 2, NULL, NULL, 'NEW ENGLAND MUG W GIFT BOX', '37509');
INSERT INTO public.products VALUES (56, 1.03, 22, NULL, 2611, 2, NULL, NULL, 'WHITE BAMBOO RIBS LAMPSHADE', '40001');
INSERT INTO public.products VALUES (15, 1.64, 22, NULL, 2612, 2, NULL, NULL, 'WHITE BAMBOO RIBS LAMPSHADE', '40003');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 2613, 2, NULL, NULL, 'BLUE ORGANDY ROUND LAMPSHADE W BEA', '40005B');
INSERT INTO public.products VALUES (370, 2.23, 12, NULL, 2614, 2, NULL, NULL, 'CHINESE DRAGON PAPER LANTERNS', '40016');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 2615, 2, NULL, NULL, 'RED DAISY PAPER LAMPSHADE', '40046A');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 2616, 2, NULL, NULL, 'PINK GAUZE BUTTERFLY LAMPSHADE', '44089A');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 2617, 2, NULL, NULL, 'LILAC GAUZE BUTTERFLY LAMPSHADE', '44089C');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 2618, 2, NULL, NULL, 'BLUE CRUSOE CHECK LAMPSHADE', '44091A');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 2619, 2, NULL, NULL, 'BLUE WHITE PLASTIC RINGS LAMPSHADE', '44092B');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 2620, 2, NULL, NULL, 'PURPLE/COPPER HANGING LAMPSHADE', '44092C');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 2621, 2, NULL, NULL, 'CANNABIS LEAF BEAD CURTAIN', '44228');
INSERT INTO public.products VALUES (69, 0.41, 22, NULL, 2622, 2, NULL, NULL, 'ASSORTED CIRCULAR MOBILE', '44234');
INSERT INTO public.products VALUES (53, 0.42, 22, NULL, 2623, 2, NULL, NULL, 'ASS COL CIRCLE MOBILE ', '44235');
INSERT INTO public.products VALUES (10, 1.34, 22, NULL, 2624, 2, NULL, NULL, 'PINK/PURPLE CIRCLE CURTAIN', '44236');
INSERT INTO public.products VALUES (10, 0.79, 22, NULL, 2625, 2, NULL, NULL, 'LILAC FEATHERS CURTAIN', '44242A');
INSERT INTO public.products VALUES (10, 0.94, 22, NULL, 2626, 2, NULL, NULL, 'PINK FEATHERS CURTAIN', '44242B');
INSERT INTO public.products VALUES (10, 4.25, 22, NULL, 2627, 2, NULL, NULL, 'M/COLOUR POM-POM CURTAIN', '44265');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 2628, 2, NULL, NULL, 'FOLDING SHOE TIDY', '45013');
INSERT INTO public.products VALUES (160, 1.49, 22, NULL, 2629, 2, NULL, NULL, 'POLYESTER FILLER PAD 45x45cm', '46000M');
INSERT INTO public.products VALUES (10, 4.25, 22, NULL, 2630, 2, NULL, NULL, 'POLYESTER FILLER PAD 65CMx65CM', '46000P');
INSERT INTO public.products VALUES (10, 1.45, 22, NULL, 2631, 2, NULL, NULL, 'POLYESTER FILLER PAD 45x30cm', '46000R');
INSERT INTO public.products VALUES (209, 1.39, 22, NULL, 2632, 2, NULL, NULL, 'POLYESTER FILLER PAD 40x40cm', '46000S');
INSERT INTO public.products VALUES (11, 1.20, 22, NULL, 2633, 2, NULL, NULL, 'POLYESTER FILLER PAD 30CMx30CM', '46000U');
INSERT INTO public.products VALUES (10, 0.19, 22, NULL, 2634, 2, NULL, NULL, 'GREEN POP ART MAO CUSHION COVER ', '46115B');
INSERT INTO public.products VALUES (23, 2.81, 22, NULL, 2635, 2, NULL, NULL, 'FUNKY MONKEY CUSHION COVER', '46118');
INSERT INTO public.products VALUES (10, 1.55, 22, NULL, 2636, 2, NULL, NULL, 'ELVIS WALLHANGING / CURTAIN', '46126A');
INSERT INTO public.products VALUES (10, 1.01, 22, NULL, 2637, 2, NULL, NULL, 'BLUE CHENILLE SHAGGY CUSHION COVER ', '46138B');
INSERT INTO public.products VALUES (10, 11.51, 22, NULL, 2638, 2, NULL, NULL, 'SUNSET COLOUR CHUNKY KNITTED THROW', '46775D');
INSERT INTO public.products VALUES (15, 4.20, 22, NULL, 2639, 2, NULL, NULL, 'WOVEN BUBBLE GUM CUSHION COVER', '46776A');
INSERT INTO public.products VALUES (16, 4.21, 22, NULL, 2640, 2, NULL, NULL, 'WOVEN BERRIES CUSHION COVER ', '46776B');
INSERT INTO public.products VALUES (11, 4.22, 22, NULL, 2641, 2, NULL, NULL, 'WOVEN FROST CUSHION COVER', '46776C');
INSERT INTO public.products VALUES (10, 4.20, 22, NULL, 2642, 2, NULL, NULL, 'WOVEN SUNSET CUSHION COVER ', '46776D');
INSERT INTO public.products VALUES (10, 4.24, 22, NULL, 2643, 2, NULL, NULL, 'WOVEN CANDY CUSHION COVER ', '46776E');
INSERT INTO public.products VALUES (21, 4.21, 22, NULL, 2644, 2, NULL, NULL, 'WOVEN ROSE GARDEN CUSHION COVER ', '46776F');
INSERT INTO public.products VALUES (10, 4.13, 22, NULL, 2645, 2, NULL, NULL, 'WOVEN BUBBLE GUM CUSHION COVER', '46776a');
INSERT INTO public.products VALUES (10, 4.13, 22, NULL, 2646, 2, NULL, NULL, 'WOVEN BERRIES CUSHION COVER ', '46776b');
INSERT INTO public.products VALUES (10, 4.13, 22, NULL, 2647, 2, NULL, NULL, 'WOVEN CANDY CUSHION COVER ', '46776e');
INSERT INTO public.products VALUES (10, 4.13, 22, NULL, 2648, 2, NULL, NULL, 'WOVEN ROSE GARDEN CUSHION COVER ', '46776f');
INSERT INTO public.products VALUES (10, 0.16, 14, NULL, 2649, 2, NULL, NULL, 'WINE BOTTLE DRESSING LT.BLUE', '47013A');
INSERT INTO public.products VALUES (10, 0.41, 14, NULL, 2650, 2, NULL, NULL, 'WINE BOTTLE DRESSING DARK BLUE', '47013C');
INSERT INTO public.products VALUES (10, 2.10, 12, NULL, 2651, 2, NULL, NULL, 'LIGHT DECORATION BATTERY OPERATED', '47016');
INSERT INTO public.products VALUES (58, 1.90, 13, NULL, 2652, 2, NULL, NULL, 'SET/6 BEAD COASTERS GAUZE BAG GOLD', '47021G');
INSERT INTO public.products VALUES (41, 1.57, 16, NULL, 2653, 2, NULL, NULL, 'SMALL POP BOX,FUNKY MONKEY', '47310M');
INSERT INTO public.products VALUES (10, 1.75, 22, NULL, 2654, 2, NULL, NULL, 'FUSCHIA TABLE RUN FLOWER ', '47341A');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 2655, 2, NULL, NULL, 'BLUE TABLE RUN FLOWER', '47341B');
INSERT INTO public.products VALUES (15, 0.97, 13, NULL, 2656, 2, NULL, NULL, 'FUSCHIA FLOWER PURSE WITH BEADS', '47343A');
INSERT INTO public.products VALUES (10, 0.97, 13, NULL, 2657, 2, NULL, NULL, 'BLUE FLOWER DES PURSE', '47344B');
INSERT INTO public.products VALUES (10, 0.70, 22, NULL, 2658, 2, NULL, NULL, 'FUSCHIA VOILE POINTY SHOE DEC', '47348A');
INSERT INTO public.products VALUES (10, 2.87, 22, NULL, 2659, 2, NULL, NULL, 'BLUE  VOILE LAMPSHADE', '47351B');
INSERT INTO public.products VALUES (11, 3.40, 22, NULL, 2660, 2, NULL, NULL, 'PAIR PADDED HANGERS PINK CHECK', '47367B');
INSERT INTO public.products VALUES (10, 2.93, 13, NULL, 2661, 2, NULL, NULL, 'PINK GREEN EMBROIDERY COSMETIC BAG', '47369A');
INSERT INTO public.products VALUES (10, 3.26, 13, NULL, 2662, 2, NULL, NULL, 'BLUE GREEN EMBROIDERY COSMETIC BAG', '47369B');
INSERT INTO public.products VALUES (20, 0.19, 14, NULL, 2663, 2, NULL, NULL, 'ASSORTED COLOUR SUCTION CUP HOOK', '47420');
INSERT INTO public.products VALUES (99, 0.42, 22, NULL, 2664, 2, NULL, NULL, 'ASSORTED COLOUR LIZARD SUCTION HOOK', '47421');
INSERT INTO public.products VALUES (65, 0.42, 14, NULL, 2665, 2, NULL, NULL, 'ASSORTED MONKEY SUCTION CUP HOOK', '47422');
INSERT INTO public.products VALUES (44, 0.64, 15, NULL, 2666, 2, NULL, NULL, 'ASSORTED SHAPES PHOTO CLIP SILVER ', '47469');
INSERT INTO public.products VALUES (29, 0.98, 15, NULL, 2667, 2, NULL, NULL, 'RAINBOW PEGS PHOTO CLIP STRING', '47471');
INSERT INTO public.products VALUES (74, 2.41, 15, NULL, 2668, 2, NULL, NULL, 'HANGING PHOTO CLIP ROPE LADDER', '47480');
INSERT INTO public.products VALUES (22, 1.05, 22, NULL, 2669, 2, NULL, NULL, '50CM METAL STRING WITH  7 CLIPS', '47481');
INSERT INTO public.products VALUES (284, 0.50, 22, NULL, 2670, 2, NULL, NULL, 'ASS FLORAL PRINT MULTI SCREWDRIVER', '47503A');
INSERT INTO public.products VALUES (14, 1.44, 22, NULL, 2671, 2, NULL, NULL, 'ASS FLORAL PRINT SPIRIT LEVEL ', '47503H');
INSERT INTO public.products VALUES (10, 7.95, 13, NULL, 2672, 2, NULL, NULL, 'SET/3 FLORAL GARDEN TOOLS IN BAG', '47503J');
INSERT INTO public.products VALUES (97, 1.72, 22, NULL, 2673, 2, NULL, NULL, 'ENGLISH ROSE SPIRIT LEVEL ', '47504H');
INSERT INTO public.products VALUES (200, 1.55, 22, NULL, 2674, 2, NULL, NULL, 'ENGLISH ROSE GARDEN SECATEURS', '47504K');
INSERT INTO public.products VALUES (82, 0.14, 22, NULL, 2675, 2, NULL, NULL, 'ICON PLACEMAT POP ART ELVIS', '47518F');
INSERT INTO public.products VALUES (10, 4.15, 22, NULL, 2676, 2, NULL, NULL, 'ICON PLACEMAT POP ART ELVIS', '47518f');
INSERT INTO public.products VALUES (390, 1.55, 22, NULL, 2677, 2, NULL, NULL, 'TEA TIME TEA TOWELS ', '47556B');
INSERT INTO public.products VALUES (205, 1.45, 22, NULL, 2678, 2, NULL, NULL, 'TEA TIME OVEN GLOVE', '47559B');
INSERT INTO public.products VALUES (10, 3.31, 22, NULL, 2679, 2, NULL, NULL, 'TEA TIME OVEN GLOVE', '47559b');
INSERT INTO public.products VALUES (28, 2.56, 22, NULL, 2680, 2, NULL, NULL, 'RETRO LONGBOARD IRONING BOARD COVER', '47563A');
INSERT INTO public.products VALUES (1802, 5.78, 16, NULL, 2681, 2, NULL, NULL, 'PARTY BUNTING', '47566');
INSERT INTO public.products VALUES (10, 5.48, 16, NULL, 2682, 2, NULL, NULL, 'TEA TIME PARTY BUNTING', '47566B');
INSERT INTO public.products VALUES (19, 8.30, 16, NULL, 2683, 2, NULL, NULL, 'TEA TIME PARTY BUNTING', '47566b');
INSERT INTO public.products VALUES (60, 6.30, 22, NULL, 2684, 2, NULL, NULL, 'TEA TIME KITCHEN APRON', '47567B');
INSERT INTO public.products VALUES (18, 11.45, 22, NULL, 2685, 2, NULL, NULL, 'TEA TIME TABLE CLOTH', '47570B');
INSERT INTO public.products VALUES (10, 21.01, 22, NULL, 2686, 2, NULL, NULL, 'TEA TIME TABLE CLOTH', '47570b');
INSERT INTO public.products VALUES (48, 1.86, 22, NULL, 2687, 2, NULL, NULL, 'ENGLISH ROSE SCENTED HANGING FLOWER', '47574A');
INSERT INTO public.products VALUES (10, 4.25, 22, NULL, 2688, 2, NULL, NULL, 'ENGLISH ROSE SCENTED HANGING HEART', '47574B');
INSERT INTO public.products VALUES (21, 1.14, 22, NULL, 2689, 2, NULL, NULL, 'ENGLISH ROSE SMALL SCENTED FLOWER', '47578A');
INSERT INTO public.products VALUES (10, 2.10, 16, NULL, 2690, 2, NULL, NULL, 'TEA TIME BREAKFAST BASKET', '47579');
INSERT INTO public.products VALUES (37, 3.28, 22, NULL, 2691, 2, NULL, NULL, 'TEA TIME DES TEA COSY', '47580');
INSERT INTO public.products VALUES (26, 4.85, 22, NULL, 2692, 2, NULL, NULL, 'PINK FAIRY CAKE CUSHION COVER', '47585A');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 2693, 2, NULL, NULL, 'PINK FAIRY CAKE CUSHION COVER', '47586A');
INSERT INTO public.products VALUES (10, 5.45, 16, NULL, 2694, 2, NULL, NULL, 'CONGRATULATIONS BUNTING', '47589');
INSERT INTO public.products VALUES (196, 5.86, 16, NULL, 2695, 2, NULL, NULL, 'BLUE HAPPY BIRTHDAY BUNTING', '47590A');
INSERT INTO public.products VALUES (224, 5.80, 16, NULL, 2696, 2, NULL, NULL, 'PINK HAPPY BIRTHDAY BUNTING', '47590B');
INSERT INTO public.products VALUES (10, 10.79, 16, NULL, 2697, 2, NULL, NULL, 'PINK HAPPY BIRTHDAY BUNTING', '47590b');
INSERT INTO public.products VALUES (10, 1.62, 22, NULL, 2698, 2, NULL, NULL, 'SCOTTIES CHILDRENS APRON', '47591B');
INSERT INTO public.products VALUES (320, 2.16, 22, NULL, 2699, 2, NULL, NULL, 'PINK FAIRY CAKE CHILDRENS APRON', '47591D');
INSERT INTO public.products VALUES (10, 4.13, 22, NULL, 2700, 2, NULL, NULL, 'SCOTTIES CHILDRENS APRON', '47591b');
INSERT INTO public.products VALUES (13, 4.97, 22, NULL, 2701, 2, NULL, NULL, 'PINK FAIRY CAKE CHILDRENS APRON', '47591d');
INSERT INTO public.products VALUES (10, 0.54, 22, NULL, 2702, 2, NULL, NULL, 'CAROUSEL PONIES BABY BIB', '47593A');
INSERT INTO public.products VALUES (198, 0.70, 22, NULL, 2703, 2, NULL, NULL, 'SCOTTIE DOGS BABY BIB', '47593B');
INSERT INTO public.products VALUES (10, 0.83, 22, NULL, 2704, 2, NULL, NULL, 'SCOTTIE DOGS BABY BIB', '47593b');
INSERT INTO public.products VALUES (10, 1.92, 13, NULL, 2705, 2, NULL, NULL, 'CAROUSEL DESIGN WASHBAG', '47594A');
INSERT INTO public.products VALUES (16, 1.91, 13, NULL, 2706, 2, NULL, NULL, 'SCOTTIES DESIGN WASHBAG', '47594B');
INSERT INTO public.products VALUES (245, 2.28, 13, NULL, 2707, 2, NULL, NULL, 'PINK PARTY BAGS', '47599A');
INSERT INTO public.products VALUES (142, 2.18, 13, NULL, 2708, 2, NULL, NULL, 'BLUE PARTY BAGS ', '47599B');
INSERT INTO public.products VALUES (117, 9.55, 22, NULL, 2709, 2, NULL, NULL, 'DOORMAT 3 SMILEY CATS', '48111');
INSERT INTO public.products VALUES (148, 9.64, 22, NULL, 2710, 2, NULL, NULL, 'DOORMAT MULTICOLOUR STRIPE', '48116');
INSERT INTO public.products VALUES (88, 8.75, 22, NULL, 2711, 2, NULL, NULL, 'DOORMAT TOPIARY', '48129');
INSERT INTO public.products VALUES (375, 8.88, 22, NULL, 2712, 2, NULL, NULL, 'DOORMAT UNION FLAG', '48138');
INSERT INTO public.products VALUES (179, 8.20, 22, NULL, 2713, 2, NULL, NULL, 'DOORMAT BLACK FLOCK ', '48173C');
INSERT INTO public.products VALUES (10, 16.83, 22, NULL, 2714, 2, NULL, NULL, 'DOORMAT BLACK FLOCK ', '48173c');
INSERT INTO public.products VALUES (204, 8.55, 22, NULL, 2715, 2, NULL, NULL, 'DOORMAT ENGLISH ROSE ', '48184');
INSERT INTO public.products VALUES (288, 10.06, 22, NULL, 2716, 2, NULL, NULL, 'DOORMAT FAIRY CAKE', '48185');
INSERT INTO public.products VALUES (382, 8.46, 22, NULL, 2717, 2, NULL, NULL, 'DOORMAT NEW ENGLAND', '48187');
INSERT INTO public.products VALUES (206, 8.81, 22, NULL, 2718, 2, NULL, NULL, 'DOORMAT WELCOME PUPPIES', '48188');
INSERT INTO public.products VALUES (10, 14.95, 22, NULL, 2719, 2, NULL, NULL, 'DOORMAT FRIENDSHIP ', '48189');
INSERT INTO public.products VALUES (341, 9.22, 22, NULL, 2720, 2, NULL, NULL, 'DOORMAT HEARTS', '48194');
INSERT INTO public.products VALUES (51, 3.43, 22, NULL, 2721, 2, NULL, NULL, 'AFGHAN SLIPPER SOCK PAIR', '51008');
INSERT INTO public.products VALUES (381, 0.66, 22, NULL, 2722, 2, NULL, NULL, 'FEATHER PEN,HOT PINK', '51014A');
INSERT INTO public.products VALUES (250, 0.71, 22, NULL, 2723, 2, NULL, NULL, 'FEATHER PEN,COAL BLACK', '51014C');
INSERT INTO public.products VALUES (198, 0.65, 12, NULL, 2724, 2, NULL, NULL, 'FEATHER PEN,LIGHT PINK', '51014L');
INSERT INTO public.products VALUES (10, 0.83, 22, NULL, 2725, 2, NULL, NULL, 'FEATHER PEN,COAL BLACK', '51014c');
INSERT INTO public.products VALUES (36, 0.52, 21, NULL, 2726, 2, NULL, NULL, 'SUMMER FUN DESIGN SHOWER CAP', '51020A');
INSERT INTO public.products VALUES (14, 0.61, 21, NULL, 2727, 2, NULL, NULL, 'STRIPY DESIGN SHOWER CAP', '51020B');
INSERT INTO public.products VALUES (441, 1.81, 22, NULL, 2728, 2, NULL, NULL, 'SOMBRERO ', '62018');
INSERT INTO public.products VALUES (10, 0.83, 13, NULL, 2729, 2, NULL, NULL, 'BLUE CHECK BAG W HANDLE 34X20CM', '62043B');
INSERT INTO public.products VALUES (10, 0.42, 14, NULL, 2730, 2, NULL, NULL, 'ELEPHANT CLIP W SUCTION CUP', '62074B');
INSERT INTO public.products VALUES (10, 1.95, 13, NULL, 2731, 2, NULL, NULL, 'PINK RETRO BIG FLOWER BAG', '62086A');
INSERT INTO public.products VALUES (10, 4.08, 13, NULL, 2732, 2, NULL, NULL, 'TURQ ICE CREAM BUM BAG ', '62094B');
INSERT INTO public.products VALUES (10, 1.25, 13, NULL, 2733, 2, NULL, NULL, 'PINK/YELLOW FLOWERS HANDBAG', '62096A');
INSERT INTO public.products VALUES (10, 1.25, 13, NULL, 2734, 2, NULL, NULL, 'PURPLE/TURQ FLOWERS HANDBAG', '62096B');
INSERT INTO public.products VALUES (10, 0.83, 13, NULL, 2735, 2, NULL, NULL, 'BLUE STRIPES SHOULDER BAG', '62097B');
INSERT INTO public.products VALUES (270, 1.72, 22, NULL, 2736, 2, NULL, NULL, 'LOVE HEART POCKET WARMER', '70006');
INSERT INTO public.products VALUES (83, 2.10, 22, NULL, 2737, 2, NULL, NULL, 'HI TEC ALPINE HAND WARMER', '70007');
INSERT INTO public.products VALUES (21, 5.30, 12, NULL, 2738, 2, NULL, NULL, 'WHITE HANGING BEADS CANDLE HOLDER', '71038');
INSERT INTO public.products VALUES (10, 0.35, 12, NULL, 2739, 2, NULL, NULL, 'SMALL SINGLE FLAME CANDLE HOLDER', '71050');
INSERT INTO public.products VALUES (191, 4.78, 12, NULL, 2740, 2, NULL, NULL, 'WHITE METAL LANTERN', '71053');
INSERT INTO public.products VALUES (34, 0.83, 22, NULL, 2741, 2, NULL, NULL, 'STANDING FAIRY POLE SUPPORT ', '71101E');
INSERT INTO public.products VALUES (17, 1.64, 22, NULL, 2742, 2, NULL, NULL, 'SILVER BOOK MARK WITH BEADS', '71143');
INSERT INTO public.products VALUES (10, 0.42, 12, NULL, 2743, 2, NULL, NULL, 'METAL BASE FOR CANDLES', '71215');
INSERT INTO public.products VALUES (23, 1.68, 15, NULL, 2744, 2, NULL, NULL, 'PHOTO CLIP LINE', '71270');
INSERT INTO public.products VALUES (10, 3.51, 12, NULL, 2745, 2, NULL, NULL, 'PINK GLASS CANDLEHOLDER', '71279');
INSERT INTO public.products VALUES (10, 4.46, 22, NULL, 2746, 2, NULL, NULL, 'PINK/WHITE "KEEP CLEAN" BULLET BIN', '71403');
INSERT INTO public.products VALUES (13, 0.42, 22, NULL, 2747, 2, NULL, NULL, 'BLACK ORANGE SQUEEZER', '71406C');
INSERT INTO public.products VALUES (1347, 0.94, 12, NULL, 2748, 2, NULL, NULL, 'HANGING JAM JAR T-LIGHT HOLDER', '71459');
INSERT INTO public.products VALUES (552, 3.96, 12, NULL, 2749, 2, NULL, NULL, 'COLOUR GLASS. STAR T-LIGHT HOLDER', '71477');
INSERT INTO public.products VALUES (10, 0.71, 22, NULL, 2750, 2, NULL, NULL, 'CD WALL TIDY BLUE OFFICE', '71495A');
INSERT INTO public.products VALUES (16, 0.55, 22, NULL, 2751, 2, NULL, NULL, 'CD WALL TIDY RED FLOWERS', '71495B');
INSERT INTO public.products VALUES (12, 1.09, 22, NULL, 2752, 2, NULL, NULL, 'A4 WALL TIDY BLUE OFFICE', '71496A');
INSERT INTO public.products VALUES (10, 0.56, 22, NULL, 2753, 2, NULL, NULL, 'A4 WALL TIDY RED FLOWERS', '71496B');
INSERT INTO public.products VALUES (10, 0.81, 12, NULL, 2754, 2, NULL, NULL, 'SQUARE METAL CANDLEHOLDER BASE', '71510');
INSERT INTO public.products VALUES (10, 0.21, 12, NULL, 2755, 2, NULL, NULL, 'LILAC VOTIVE CANDLE', '72024U');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2756, 2, NULL, NULL, 'damages', '72038P');
INSERT INTO public.products VALUES (13, 0.66, 13, NULL, 2757, 2, NULL, NULL, 'BAG OF SILVER STONES', '72051S');
INSERT INTO public.products VALUES (32, 1.19, 12, NULL, 2758, 2, NULL, NULL, 'COFFEE SCENT PILLAR CANDLE', '72122');
INSERT INTO public.products VALUES (19, 1.24, 12, NULL, 2759, 2, NULL, NULL, 'COLUMBIAN CANDLE ROUND ', '72127');
INSERT INTO public.products VALUES (19, 0.90, 12, NULL, 2760, 2, NULL, NULL, 'COLUMBIAN CANDLE ROUND', '72128');
INSERT INTO public.products VALUES (21, 0.74, 12, NULL, 2761, 2, NULL, NULL, 'COLUMBIAN CANDLE ROUND', '72130');
INSERT INTO public.products VALUES (13, 1.90, 12, NULL, 2762, 2, NULL, NULL, 'COLUMBIAN CANDLE RECTANGLE', '72131');
INSERT INTO public.products VALUES (10, 1.95, 12, NULL, 2763, 2, NULL, NULL, 'COLUMBIAN CUBE CANDLE', '72132');
INSERT INTO public.products VALUES (10, 1.46, 12, NULL, 2764, 2, NULL, NULL, 'COLUMBIAN CANDLE RECTANGLE', '72133');
INSERT INTO public.products VALUES (10, 0.99, 12, NULL, 2765, 2, NULL, NULL, 'COLUMBIAN  CUBE CANDLE ', '72134');
INSERT INTO public.products VALUES (10, 0.85, 12, NULL, 2766, 2, NULL, NULL, 'BEST DAD CANDLE LETTERS', '72140E');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2767, 2, NULL, NULL, 'throw away', '72140F');
INSERT INTO public.products VALUES (62, 0.28, 12, NULL, 2768, 2, NULL, NULL, 'LAVENDER SCENT CAKE CANDLE', '72225C');
INSERT INTO public.products VALUES (331, 0.19, 12, NULL, 2769, 2, NULL, NULL, 'FENG SHUI PILLAR CANDLE', '72232');
INSERT INTO public.products VALUES (73, 2.47, 12, NULL, 2770, 2, NULL, NULL, 'SET/6 PURPLE BUTTERFLY T-LIGHTS', '72349B');
INSERT INTO public.products VALUES (15, 4.14, 12, NULL, 2771, 2, NULL, NULL, 'SET/6 PURPLE BUTTERFLY T-LIGHTS', '72349b');
INSERT INTO public.products VALUES (127, 2.29, 12, NULL, 2772, 2, NULL, NULL, 'SET/6 TURQUOISE BUTTERFLY T-LIGHTS', '72351A');
INSERT INTO public.products VALUES (209, 2.38, 12, NULL, 2773, 2, NULL, NULL, 'SET/6 PINK  BUTTERFLY T-LIGHTS', '72351B');
INSERT INTO public.products VALUES (10, 4.15, 12, NULL, 2774, 2, NULL, NULL, 'SET/6 TURQUOISE BUTTERFLY T-LIGHTS', '72351a');
INSERT INTO public.products VALUES (10, 1.65, 12, NULL, 2775, 2, NULL, NULL, 'PINK CLEAR GLASS CANDLE PLATE', '72369A');
INSERT INTO public.products VALUES (65, 0.64, 12, NULL, 2776, 2, NULL, NULL, 'SET OF 6 HALLOWEEN GHOST T-LIGHTS', '72586');
INSERT INTO public.products VALUES (60, 1.27, 12, NULL, 2777, 2, NULL, NULL, 'SET/12 TAPER CANDLES', '72598');
INSERT INTO public.products VALUES (10, 0.85, 12, NULL, 2778, 2, NULL, NULL, 'IVORY SCULPTED RND CANDLE ', '72709');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2779, 2, NULL, NULL, 'thrown away-can''t sell', '72732');
INSERT INTO public.products VALUES (595, 1.59, 12, NULL, 2780, 2, NULL, NULL, 'GRAND CHOCOLATECANDLE', '72741');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2781, 2, NULL, NULL, 'thrown away-can''t sell.', '72759');
INSERT INTO public.products VALUES (40, 11.05, 16, NULL, 2782, 2, NULL, NULL, 'VINTAGE CREAM 3 BASKET CAKE STAND', '72760B');
INSERT INTO public.products VALUES (13, 0.85, 12, NULL, 2783, 2, NULL, NULL, 'BLACK SILOUETTE CANDLE PLATE', '72780');
INSERT INTO public.products VALUES (10, 2.10, 12, NULL, 2784, 2, NULL, NULL, 'BLACK SIL''T SQU CANDLE PLATE ', '72783');
INSERT INTO public.products VALUES (10, 1.65, 12, NULL, 2785, 2, NULL, NULL, 'SET/4 GARDEN ROSE DINNER CANDLE', '72798C');
INSERT INTO public.products VALUES (10, 2.42, 12, NULL, 2786, 2, NULL, NULL, 'PINK PILLAR CANDLE SILVER FLOCK', '72799C');
INSERT INTO public.products VALUES (44, 2.83, 12, NULL, 2787, 2, NULL, NULL, 'IVORY PILLAR CANDLE SILVER FLOCK', '72799E');
INSERT INTO public.products VALUES (14, 3.03, 12, NULL, 2788, 2, NULL, NULL, 'IVORY PILLAR CANDLE GOLD FLOCK', '72799F');
INSERT INTO public.products VALUES (14, 2.46, 12, NULL, 2789, 2, NULL, NULL, ' 4 PURPLE FLOCK DINNER CANDLES', '72800B');
INSERT INTO public.products VALUES (13, 2.64, 12, NULL, 2790, 2, NULL, NULL, '4 PINK DINNER CANDLE SILVER FLOCK', '72800C');
INSERT INTO public.products VALUES (10, 2.70, 12, NULL, 2791, 2, NULL, NULL, '4 BLUE DINNER CANDLES SILVER FLOCK', '72800D');
INSERT INTO public.products VALUES (54, 2.60, 12, NULL, 2792, 2, NULL, NULL, '4 IVORY DINNER CANDLES SILVER FLOCK', '72800E');
INSERT INTO public.products VALUES (13, 1.48, 12, NULL, 2793, 2, NULL, NULL, '4 ROSE PINK DINNER CANDLES', '72801C');
INSERT INTO public.products VALUES (10, 1.59, 12, NULL, 2794, 2, NULL, NULL, '4 SKY BLUE DINNER CANDLES', '72801D');
INSERT INTO public.products VALUES (10, 1.34, 12, NULL, 2795, 2, NULL, NULL, '4 BURGUNDY WINE DINNER CANDLES', '72801G');
INSERT INTO public.products VALUES (10, 2.46, 12, NULL, 2796, 2, NULL, NULL, '4 ROSE PINK DINNER CANDLES', '72801c');
INSERT INTO public.products VALUES (10, 2.46, 12, NULL, 2797, 2, NULL, NULL, '4 SKY BLUE DINNER CANDLES', '72801d');
INSERT INTO public.products VALUES (10, 4.50, 12, NULL, 2798, 2, NULL, NULL, 'ROSE SCENT CANDLE IN JEWELLED BOX', '72802A');
INSERT INTO public.products VALUES (28, 3.93, 12, NULL, 2799, 2, NULL, NULL, 'OCEAN SCENT CANDLE IN JEWELLED BOX', '72802B');
INSERT INTO public.products VALUES (76, 4.28, 12, NULL, 2800, 2, NULL, NULL, 'VANILLA SCENT CANDLE JEWELLED BOX', '72802C');
INSERT INTO public.products VALUES (10, 8.29, 12, NULL, 2801, 2, NULL, NULL, 'ROSE SCENT CANDLE IN JEWELLED BOX', '72802a');
INSERT INTO public.products VALUES (10, 8.29, 12, NULL, 2802, 2, NULL, NULL, 'VANILLA SCENT CANDLE JEWELLED BOX', '72802c');
INSERT INTO public.products VALUES (48, 4.08, 12, NULL, 2803, 2, NULL, NULL, 'ROSE SCENT CANDLE JEWELLED DRAWER', '72803A');
INSERT INTO public.products VALUES (10, 8.47, 12, NULL, 2804, 2, NULL, NULL, 'OCEAN SCENT CANDLE JEWELLED DRAWER', '72803b');
INSERT INTO public.products VALUES (10, 5.45, 12, NULL, 2805, 2, NULL, NULL, 'SET/3 ROSE CANDLE IN JEWELLED BOX', '72807A');
INSERT INTO public.products VALUES (10, 5.20, 12, NULL, 2806, 2, NULL, NULL, 'SET/3 OCEAN SCENT CANDLE JEWEL BOX', '72807B');
INSERT INTO public.products VALUES (10, 5.14, 12, NULL, 2807, 2, NULL, NULL, 'SET/3 VANILLA SCENTED CANDLE IN BOX', '72807C');
INSERT INTO public.products VALUES (10, 8.29, 12, NULL, 2808, 2, NULL, NULL, 'SET/3 ROSE CANDLE IN JEWELLED BOX', '72807a');
INSERT INTO public.products VALUES (10, 8.29, 12, NULL, 2809, 2, NULL, NULL, 'SET/3 OCEAN SCENT CANDLE JEWEL BOX', '72807b');
INSERT INTO public.products VALUES (10, 8.29, 12, NULL, 2810, 2, NULL, NULL, 'SET/3 VANILLA SCENTED CANDLE IN BOX', '72807c');
INSERT INTO public.products VALUES (10, 1.82, 12, NULL, 2811, 2, NULL, NULL, 'SMALL ZINC/GLASS CANDLEHOLDER', '72811');
INSERT INTO public.products VALUES (10, 3.76, 12, NULL, 2812, 2, NULL, NULL, 'LARGE ZINC GLASS CANDLEHOLDER', '72812');
INSERT INTO public.products VALUES (10, 5.32, 12, NULL, 2813, 2, NULL, NULL, '3 WICK CHRISTMAS BRIAR CANDLE ', '72815');
INSERT INTO public.products VALUES (86, 1.91, 12, NULL, 2814, 2, NULL, NULL, 'SET/3 CHRISTMAS DECOUPAGE CANDLES', '72816');
INSERT INTO public.products VALUES (112, 1.22, 12, NULL, 2815, 2, NULL, NULL, 'SET OF 2 CHRISTMAS DECOUPAGE CANDLE', '72817');
INSERT INTO public.products VALUES (178, 0.76, 12, NULL, 2816, 2, NULL, NULL, 'CHRISTMAS DECOUPAGE CANDLE', '72818');
INSERT INTO public.products VALUES (22, 2.92, 12, NULL, 2817, 2, NULL, NULL, 'CUPID DESIGN SCENTED CANDLES', '72819');
INSERT INTO public.products VALUES (10, 1.65, 12, NULL, 2818, 2, NULL, NULL, 'CUPID SCENTED CANDLE IN GLASS', '72821');
INSERT INTO public.products VALUES (17, 0.80, 22, NULL, 2819, 2, NULL, NULL, 'BLUE DAISY MOBILE', '75011');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 2820, 2, NULL, NULL, 'STRING OF 8 BUTTERFLIES,PINK', '75013B');
INSERT INTO public.products VALUES (688, 1.61, 22, NULL, 2821, 2, NULL, NULL, 'LARGE CIRCULAR MIRROR MOBILE', '75049L');
INSERT INTO public.products VALUES (49, 1.80, 22, NULL, 2822, 2, NULL, NULL, 'METAL TUBE CHIME ON BAMBOO', '75131');
INSERT INTO public.products VALUES (10, 1.53, 22, NULL, 2823, 2, NULL, NULL, 'PAINTED SEA SHELL METAL WINDCHIME', '75172');
INSERT INTO public.products VALUES (45, 1.34, 22, NULL, 2824, 2, NULL, NULL, 'ASSTD COL BUTTERFLY/CRYSTAL W/CHIME', '75178');
INSERT INTO public.products VALUES (10, 2.12, 22, NULL, 2825, 2, NULL, NULL, 'DOLPHIN WINDMILL', '77079');
INSERT INTO public.products VALUES (38, 1.34, 22, NULL, 2826, 2, NULL, NULL, 'UNION FLAG WINDSOCK', '77101A');
INSERT INTO public.products VALUES (10, 5.61, 22, NULL, 2827, 2, NULL, NULL, 'FLAG OF ST GEORGE CHAIR', '78033');
INSERT INTO public.products VALUES (10, 1.95, 16, NULL, 2828, 2, NULL, NULL, 'BLUE NETTING STORAGE HANGER', '78034B');
INSERT INTO public.products VALUES (19, 1.33, 22, NULL, 2829, 2, NULL, NULL, 'MAGAZINE RACK GEBRA ASSORTED ', '78124');
INSERT INTO public.products VALUES (417, 1.00, 14, NULL, 2830, 2, NULL, NULL, 'MOROCCAN TEA GLASS', '79000');
INSERT INTO public.products VALUES (10, 0.49, 22, NULL, 2831, 2, NULL, NULL, 'S/4 ICON COASTER,ELVIS LIVES', '79026B');
INSERT INTO public.products VALUES (10, 1.40, 22, NULL, 2832, 2, NULL, NULL, 'TUMBLER, BAROQUE', '79030D');
INSERT INTO public.products VALUES (98, 1.80, 22, NULL, 2833, 2, NULL, NULL, 'TUMBLER, NEW ENGLAND', '79030G');
INSERT INTO public.products VALUES (82, 0.37, 14, NULL, 2834, 2, NULL, NULL, 'SMOKEY GREY COLOUR D.O.F. GLASS', '79051A');
INSERT INTO public.products VALUES (10, 0.38, 16, NULL, 2835, 2, NULL, NULL, 'RETRO TIN ASHTRAY,REVOLUTIONARY', '79062D');
INSERT INTO public.products VALUES (23, 0.19, 16, NULL, 2836, 2, NULL, NULL, 'RETRO PILL BOX KEY CHAIN,THE KING', '79063C');
INSERT INTO public.products VALUES (19, 0.21, 16, NULL, 2837, 2, NULL, NULL, 'RETRO PILL BOX , REVOLUTIONARY', '79063D');
INSERT INTO public.products VALUES (77, 1.07, 22, NULL, 2838, 2, NULL, NULL, 'RETRO MOD TRAY', '79066K');
INSERT INTO public.products VALUES (10, 1.64, 22, NULL, 2839, 2, NULL, NULL, 'RETRO MOD TRAY', '79066k');
INSERT INTO public.products VALUES (17, 5.87, 22, NULL, 2840, 2, NULL, NULL, 'CORONA MEXICAN TRAY', '79067');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 2841, 2, NULL, NULL, 'ENGLISH ROSE METAL WASTE BIN', '79071B');
INSERT INTO public.products VALUES (18, 0.71, 12, NULL, 2842, 2, NULL, NULL, 'PAINTED LIGHTBULB STAR+ MOON', '79144B');
INSERT INTO public.products VALUES (15, 0.77, 12, NULL, 2843, 2, NULL, NULL, 'PAINTED LIGHTBULB RAINBOW DESIGN', '79144C');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 2844, 2, NULL, NULL, 'SILICON STAR BULB  BLUE', '79149B');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 2845, 2, NULL, NULL, 'SILICON CUBE 25W, BLUE', '79151B');
INSERT INTO public.products VALUES (10, 0.85, 12, NULL, 2846, 2, NULL, NULL, 'UBO-LIGHT TRIOBASE BLUE', '79157B');
INSERT INTO public.products VALUES (10, 0.85, 12, NULL, 2847, 2, NULL, NULL, 'UBO-LIGHT TRIOBASE PURPLE', '79157V');
INSERT INTO public.products VALUES (43, 2.09, 22, NULL, 2848, 2, NULL, NULL, 'HEART SHAPE WIRELESS DOORBELL', '79160');
INSERT INTO public.products VALUES (10, 2.95, 12, NULL, 2849, 2, NULL, NULL, 'ST GEORGE SET OF 10 PARTY LIGHTS', '79161A');
INSERT INTO public.products VALUES (149, 0.50, 14, NULL, 2850, 2, NULL, NULL, 'BLACK CHAMPAGNE GLASS', '79163');
INSERT INTO public.products VALUES (15, 0.65, 14, NULL, 2851, 2, NULL, NULL, 'BLACK WINE GLASS', '79164');
INSERT INTO public.products VALUES (38, 0.61, 22, NULL, 2852, 2, NULL, NULL, 'RETRO PLASTIC 70''S TRAY', '79190A');
INSERT INTO public.products VALUES (69, 0.57, 22, NULL, 2853, 2, NULL, NULL, 'RETRO PLASTIC POLKA TRAY', '79190B');
INSERT INTO public.products VALUES (26, 0.61, 22, NULL, 2854, 2, NULL, NULL, 'RETRO PLASTIC DAISY TRAY', '79190D');
INSERT INTO public.products VALUES (14, 0.93, 22, NULL, 2855, 2, NULL, NULL, 'RETRO PLASTIC POLKA TRAY', '79191B');
INSERT INTO public.products VALUES (94, 0.84, 22, NULL, 2856, 2, NULL, NULL, 'RETRO PLASTIC ELEPHANT TRAY', '79191C');
INSERT INTO public.products VALUES (10, 1.27, 22, NULL, 2857, 2, NULL, NULL, 'RETRO PLASTIC DAISY TRAY', '79191D');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 2858, 2, NULL, NULL, 'RETRO PLASTIC 70''S TRAY', '79192A');
INSERT INTO public.products VALUES (37, 3.55, 12, NULL, 2859, 2, NULL, NULL, 'ART LIGHTS,FUNK MONKEY', '79302M');
INSERT INTO public.products VALUES (10, 4.95, 12, NULL, 2860, 2, NULL, NULL, 'FLAMINGO LIGHTS', '79320');
INSERT INTO public.products VALUES (1022, 6.74, 12, NULL, 2861, 2, NULL, NULL, 'CHILLI LIGHTS', '79321');
INSERT INTO public.products VALUES (10, 5.06, 12, NULL, 2862, 2, NULL, NULL, 'BLACK CHERRY LIGHTS', '79323B');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2863, 2, NULL, NULL, 'Unsaleable, destroyed.', '79323G');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2864, 2, NULL, NULL, 'Unsaleable, destroyed.', '79323GR');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2865, 2, NULL, NULL, 'Unsaleable, destroyed.', '79323LP');
INSERT INTO public.products VALUES (10, 5.06, 12, NULL, 2866, 2, NULL, NULL, 'PINK CHERRY LIGHTS', '79323P');
INSERT INTO public.products VALUES (10, 3.38, 12, NULL, 2868, 2, NULL, NULL, 'WHITE CHERRY LIGHTS', '79323W');
INSERT INTO public.products VALUES (10, 1.01, 12, NULL, 2869, 2, NULL, NULL, 'PINK FLOCK GLASS CANDLEHOLDER', '79329');
INSERT INTO public.products VALUES (10, 0.80, 12, NULL, 2870, 2, NULL, NULL, 'PINK FLOCK GLASS CANDLEHOLDER', '79331');
INSERT INTO public.products VALUES (10, 0.38, 12, NULL, 2871, 2, NULL, NULL, 'LIGHT PINK FLOCK GLASS CANDLEHOLDER', '79336');
INSERT INTO public.products VALUES (63, 0.61, 12, NULL, 2872, 2, NULL, NULL, 'BLUE FLOCK GLASS CANDLEHOLDER', '79337');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2873, 2, NULL, NULL, 'Unsaleable, destroyed.', '79341');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 2874, 2, NULL, NULL, 'Unsaleable, destroyed.', '79342B');
INSERT INTO public.products VALUES (10, 1.06, 22, NULL, 2875, 2, NULL, NULL, 'FROSTED WHITE BASE ', '79403');
INSERT INTO public.products VALUES (14, 0.37, 22, NULL, 2876, 2, NULL, NULL, 'FROSTED WHITE BASE ', '79406');
INSERT INTO public.products VALUES (11, 0.29, 18, NULL, 2877, 2, NULL, NULL, 'FLOWER BLUE CLOCK WITH SUCKER', '81950B');
INSERT INTO public.products VALUES (10, 0.53, 18, NULL, 2878, 2, NULL, NULL, 'FLOWER PURPLE CLOCK W/SUCKER', '81950V');
INSERT INTO public.products VALUES (20, 0.19, 18, NULL, 2879, 2, NULL, NULL, 'ROUND BLUE CLOCK WITH SUCKER', '81952B');
INSERT INTO public.products VALUES (36, 0.19, 18, NULL, 2880, 2, NULL, NULL, 'ROUND PURPLE CLOCK WITH SUCKER', '81952V');
INSERT INTO public.products VALUES (10, 0.19, 18, NULL, 2881, 2, NULL, NULL, 'ROUND BLUE CLOCK WITH SUCKER', '81953B');
INSERT INTO public.products VALUES (10, 0.19, 18, NULL, 2882, 2, NULL, NULL, 'ROUND ARTICULATED PINK CLOCK W/SUCK', '81953P');
INSERT INTO public.products VALUES (157, 4.40, 15, NULL, 2883, 2, NULL, NULL, 'VINYL RECORD FRAME SILVER', '82001S');
INSERT INTO public.products VALUES (12, 7.46, 15, NULL, 2884, 2, NULL, NULL, 'VINYL RECORD FRAME SILVER', '82001s');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 2885, 2, NULL, NULL, 'BATHROOM SCALES, TROPICAL BEACH', '82011A');
INSERT INTO public.products VALUES (10, 3.67, 22, NULL, 2886, 2, NULL, NULL, 'BATHROOM SCALES RUBBER DUCKS', '82011B');
INSERT INTO public.products VALUES (10, 3.67, 22, NULL, 2887, 2, NULL, NULL, 'BATHROOM SCALES FOOTPRINTS IN SAND', '82011C');
INSERT INTO public.products VALUES (10, 5.32, 16, NULL, 2888, 2, NULL, NULL, 'HEART BUTTONS JEWELLERY BOX', '82095');
INSERT INTO public.products VALUES (877, 3.09, 15, NULL, 2889, 2, NULL, NULL, 'WOODEN PICTURE FRAME WHITE FINISH', '82482');
INSERT INTO public.products VALUES (218, 6.89, 22, NULL, 2890, 2, NULL, NULL, 'WOOD 2 DRAWER CABINET WHITE FINISH', '82483');
INSERT INTO public.products VALUES (599, 8.42, 22, NULL, 2891, 2, NULL, NULL, 'WOOD BLACK BOARD ANT WHITE FINISH', '82484');
INSERT INTO public.products VALUES (208, 9.10, 22, NULL, 2892, 2, NULL, NULL, 'WOOD S/3 CABINET ANT WHITE FINISH', '82486');
INSERT INTO public.products VALUES (632, 3.25, 15, NULL, 2893, 2, NULL, NULL, 'WOODEN FRAME ANTIQUE WHITE ', '82494L');
INSERT INTO public.products VALUES (26, 8.31, 15, NULL, 2894, 2, NULL, NULL, 'WOODEN FRAME ANTIQUE WHITE ', '82494l');
INSERT INTO public.products VALUES (291, 1.76, 21, NULL, 2895, 2, NULL, NULL, 'LAUNDRY 15C METAL SIGN', '82551');
INSERT INTO public.products VALUES (301, 1.66, 21, NULL, 2896, 2, NULL, NULL, 'WASHROOM METAL SIGN', '82552');
INSERT INTO public.products VALUES (71, 2.01, 21, NULL, 2897, 2, NULL, NULL, 'AIRLINE LOUNGE,METAL SIGN', '82567');
INSERT INTO public.products VALUES (204, 0.75, 21, NULL, 2898, 2, NULL, NULL, 'KITCHEN METAL SIGN', '82578');
INSERT INTO public.products VALUES (559, 0.83, 21, NULL, 2899, 2, NULL, NULL, 'BATHROOM METAL SIGN', '82580');
INSERT INTO public.products VALUES (386, 0.73, 21, NULL, 2900, 2, NULL, NULL, 'TOILET METAL SIGN', '82581');
INSERT INTO public.products VALUES (421, 2.39, 21, NULL, 2901, 2, NULL, NULL, 'AREA PATROLLED METAL SIGN', '82582');
INSERT INTO public.products VALUES (723, 2.90, 21, NULL, 2902, 2, NULL, NULL, 'HOT BATHS METAL SIGN', '82583');
INSERT INTO public.products VALUES (21, 2.87, 21, NULL, 2903, 2, NULL, NULL, 'FANNY''S REST STOPMETAL SIGN', '82599');
INSERT INTO public.products VALUES (552, 2.54, 21, NULL, 2904, 2, NULL, NULL, 'NO SINGING METAL SIGN', '82600');
INSERT INTO public.products VALUES (10, 2.10, 21, NULL, 2905, 2, NULL, NULL, 'OLD DOC RUSSEL METAL SIGN', '82605');
INSERT INTO public.products VALUES (10, 1.37, 14, NULL, 2906, 2, NULL, NULL, 'METAL SIGN,CUPCAKE SINGLE HOOK', '82613A');
INSERT INTO public.products VALUES (56, 1.48, 14, NULL, 2907, 2, NULL, NULL, 'METAL SIGN,CUPCAKE SINGLE HOOK', '82613B');
INSERT INTO public.products VALUES (51, 1.43, 14, NULL, 2908, 2, NULL, NULL, 'METAL SIGN,CUPCAKE SINGLE HOOK', '82613C');
INSERT INTO public.products VALUES (67, 1.36, 14, NULL, 2909, 2, NULL, NULL, 'METAL SIGN CUPCAKE SINGLE HOOK', '82613D');
INSERT INTO public.products VALUES (10, 2.46, 14, NULL, 2910, 2, NULL, NULL, 'METAL SIGN,CUPCAKE SINGLE HOOK', '82613a');
INSERT INTO public.products VALUES (10, 2.48, 14, NULL, 2911, 2, NULL, NULL, 'METAL SIGN,CUPCAKE SINGLE HOOK', '82613b');
INSERT INTO public.products VALUES (10, 2.48, 14, NULL, 2912, 2, NULL, NULL, 'METAL SIGN,CUPCAKE SINGLE HOOK', '82613c');
INSERT INTO public.products VALUES (10, 2.55, 16, NULL, 2913, 2, NULL, NULL, 'PINK MARSHMALLOW SCARF KNITTING KIT', '82615');
INSERT INTO public.products VALUES (33, 1.95, 16, NULL, 2914, 2, NULL, NULL, 'FRAPPUCINO SCARF KNITTING KIT', '82616B');
INSERT INTO public.products VALUES (32, 1.91, 16, NULL, 2915, 2, NULL, NULL, 'MIDNIGHT GLAMOUR SCARF KNITTING KIT', '82616C');
INSERT INTO public.products VALUES (91, 1.05, 22, NULL, 2916, 2, NULL, NULL, 'MAGIC TREE -PAPER FLOWERS', '84006');
INSERT INTO public.products VALUES (114, 1.24, 22, NULL, 2917, 2, NULL, NULL, 'MAGIC SHEEP WOOL GROWING FROM PAPER', '84012');
INSERT INTO public.products VALUES (10, 0.62, 22, NULL, 2918, 2, NULL, NULL, 'FLAG OF ST GEORGE CAR FLAG', '84016');
INSERT INTO public.products VALUES (469, 5.10, 22, NULL, 2919, 2, NULL, NULL, 'RED WOOLLY HOTTIE WHITE HEART.', '84029E');
INSERT INTO public.products VALUES (330, 5.19, 14, NULL, 2920, 2, NULL, NULL, 'KNITTED UNION FLAG HOT WATER BOTTLE', '84029G');
INSERT INTO public.products VALUES (150, 4.93, 14, NULL, 2921, 2, NULL, NULL, 'ENGLISH ROSE HOT WATER BOTTLE', '84030E');
INSERT INTO public.products VALUES (10, 8.49, 14, NULL, 2922, 2, NULL, NULL, 'ENGLISH ROSE HOT WATER BOTTLE', '84030e');
INSERT INTO public.products VALUES (41, 4.49, 14, NULL, 2923, 2, NULL, NULL, 'CHARLIE+LOLA RED HOT WATER BOTTLE ', '84031A');
INSERT INTO public.products VALUES (28, 4.59, 14, NULL, 2924, 2, NULL, NULL, 'CHARLIE LOLA BLUE HOT WATER BOTTLE ', '84031B');
INSERT INTO public.products VALUES (10, 16.63, 14, NULL, 2925, 2, NULL, NULL, 'CHARLIE+LOLA RED HOT WATER BOTTLE ', '84031a');
INSERT INTO public.products VALUES (10, 16.63, 14, NULL, 2926, 2, NULL, NULL, 'CHARLIE LOLA BLUE HOT WATER BOTTLE ', '84031b');
INSERT INTO public.products VALUES (97, 3.49, 14, NULL, 2927, 2, NULL, NULL, 'CHARLIE+LOLA PINK HOT WATER BOTTLE', '84032A');
INSERT INTO public.products VALUES (87, 3.11, 14, NULL, 2928, 2, NULL, NULL, 'CHARLIE + LOLA RED HOT WATER BOTTLE', '84032B');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 2929, 2, NULL, NULL, 'FLAG OF ST GEORGE ', '84033');
INSERT INTO public.products VALUES (292, 2.14, 22, NULL, 2930, 2, NULL, NULL, 'PINK HEART SHAPE EGG FRYING PAN', '84050');
INSERT INTO public.products VALUES (28, 0.87, 22, NULL, 2931, 2, NULL, NULL, 'ASS COLOUR GLOWING TIARAS', '84051');
INSERT INTO public.products VALUES (5384, 0.32, 21, NULL, 2932, 2, NULL, NULL, 'WORLD WAR 2 GLIDERS ASSTD DESIGNS', '84077');
INSERT INTO public.products VALUES (38, 44.85, 22, NULL, 2933, 2, NULL, NULL, 'SET/4 WHITE RETRO STORAGE CUBES ', '84078A');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 2934, 2, NULL, NULL, 'YELLOW/BLUE RETRO RADIO', '84086B');
INSERT INTO public.products VALUES (22, 2.97, 22, NULL, 2935, 2, NULL, NULL, 'PINK/PURPLE RETRO RADIO', '84086C');
INSERT INTO public.products VALUES (11, 1.25, 22, NULL, 2936, 2, NULL, NULL, 'ASSORTED COLOUR METAL CAT ', '84192');
INSERT INTO public.products VALUES (13, 0.21, 22, NULL, 2937, 2, NULL, NULL, 'GLOW IN DARK DOLPHINS', '84199');
INSERT INTO public.products VALUES (10, 0.19, 19, NULL, 2938, 2, NULL, NULL, 'HAPPY BIRTHDAY CARD STRIPEY TEDDY', '84201B');
INSERT INTO public.products VALUES (10, 0.19, 19, NULL, 2939, 2, NULL, NULL, 'HAPPY BIRTHDAY CARD TEDDY/CAKE', '84201C');
INSERT INTO public.products VALUES (10, 0.19, 19, NULL, 2940, 2, NULL, NULL, '3 BLACK CATS W HEARTS BLANK CARD', '84206A');
INSERT INTO public.products VALUES (10, 0.19, 14, NULL, 2941, 2, NULL, NULL, 'CAT WITH SUNGLASSES BLANK CARD', '84206B');
INSERT INTO public.products VALUES (10, 0.19, 19, NULL, 2942, 2, NULL, NULL, 'CHAMPAGNE TRAY BLANK CARD', '84206C');
INSERT INTO public.products VALUES (1031, 0.89, 22, NULL, 2943, 2, NULL, NULL, 'ASSORTED FLOWER COLOUR "LEIS"', '84212');
INSERT INTO public.products VALUES (12, 1.92, 16, NULL, 2944, 2, NULL, NULL, 'BOX/12 CHICK & EGG IN BASKET', '84218');
INSERT INTO public.products VALUES (10, 0.83, 22, NULL, 2945, 2, NULL, NULL, 'HEN HOUSE W FAMILY IN BARN & NEST', '84226');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 2946, 2, NULL, NULL, 'HEN HOUSE W CHICK IN NEST', '84227');
INSERT INTO public.products VALUES (29, 0.52, 22, NULL, 2947, 2, NULL, NULL, 'HEN HOUSE W CHICK STANDING', '84228');
INSERT INTO public.products VALUES (10, 0.73, 16, NULL, 2948, 2, NULL, NULL, 'EASTER BUNNY WITH BASKET ON BACK', '84231');
INSERT INTO public.products VALUES (12, 2.73, 17, NULL, 2949, 2, NULL, NULL, 'PACK/12 XMAS FUN CARD', '84247E');
INSERT INTO public.products VALUES (35, 0.54, 16, NULL, 2950, 2, NULL, NULL, 'DECOUPAGE,GREETING CARD,', '84247G');
INSERT INTO public.products VALUES (10, 2.95, 16, NULL, 2951, 2, NULL, NULL, 'FOLK ART GREETING CARD,pack/12', '84247K');
INSERT INTO public.products VALUES (12, 0.66, 16, NULL, 2952, 2, NULL, NULL, 'FAWN AND MUSHROOM GREETING CARD', '84247L');
INSERT INTO public.products VALUES (10, 2.95, 19, NULL, 2953, 2, NULL, NULL, 'PACK/12 BLUE FOLKART CARDS', '84247N');
INSERT INTO public.products VALUES (10, 0.62, 16, NULL, 2954, 2, NULL, NULL, 'GREETING CARD,SQUARE, DOUGHNUTS', '84249A');
INSERT INTO public.products VALUES (23, 0.43, 16, NULL, 2955, 2, NULL, NULL, 'GREETING CARD, STICKY GORDON', '84251B');
INSERT INTO public.products VALUES (12, 0.52, 16, NULL, 2956, 2, NULL, NULL, 'GREETING CARD, TWO SISTERS.', '84251C');
INSERT INTO public.products VALUES (27, 0.40, 16, NULL, 2957, 2, NULL, NULL, 'GREETING CARD, OVERCROWDED POOL.', '84251G');
INSERT INTO public.products VALUES (10, 0.21, 21, NULL, 2958, 2, NULL, NULL, 'ASSTD DESIGN BUBBLE GUM RING', '84270');
INSERT INTO public.products VALUES (18, 4.47, 22, NULL, 2959, 2, NULL, NULL, 'CHERRY BLOSSOM DECORATIVE FLASK', '84279B');
INSERT INTO public.products VALUES (34, 4.71, 22, NULL, 2960, 2, NULL, NULL, 'CHERRY BLOSSOM  DECORATIVE FLASK', '84279P');
INSERT INTO public.products VALUES (10, 8.88, 22, NULL, 2961, 2, NULL, NULL, 'S/3 PINK SQUARE PLANTERS ROSES', '84306');
INSERT INTO public.products VALUES (10, 5.95, 22, NULL, 2962, 2, NULL, NULL, 'BLUE TV TRAY TABLE ', '84313B');
INSERT INTO public.products VALUES (50, 3.91, 22, NULL, 2963, 2, NULL, NULL, 'ORANGE TV TRAY TABLE ', '84313C');
INSERT INTO public.products VALUES (64, 0.68, 17, NULL, 2964, 2, NULL, NULL, 'SMALL PINK MAGIC CHRISTMAS TREE', '84341B');
INSERT INTO public.products VALUES (10, 3.39, 12, NULL, 2965, 2, NULL, NULL, 'ROTATING SILVER ANGELS T-LIGHT HLDR', '84347');
INSERT INTO public.products VALUES (10, 16.81, 17, NULL, 2966, 2, NULL, NULL, 'SILVER CHRISTMAS TREE BAUBLE STAND ', '84352');
INSERT INTO public.products VALUES (42, 6.08, 22, NULL, 2967, 2, NULL, NULL, 'POMPOM CURTAIN', '84356');
INSERT INTO public.products VALUES (10, 10.54, 22, NULL, 2968, 2, NULL, NULL, 'FLOOR LAMP SHADE WOOD BASE', '84358');
INSERT INTO public.products VALUES (10, 6.55, 22, NULL, 2969, 2, NULL, NULL, 'TABLE LAMP WHITE SHADE WOOD BASE', '84360');
INSERT INTO public.products VALUES (430, 2.51, 22, NULL, 2970, 2, NULL, NULL, 'SET OF 20 KIDS COOKIE CUTTERS', '84375');
INSERT INTO public.products VALUES (627, 1.62, 22, NULL, 2971, 2, NULL, NULL, 'SET OF 3 HEART COOKIE CUTTERS', '84378');
INSERT INTO public.products VALUES (573, 1.71, 22, NULL, 2972, 2, NULL, NULL, 'SET OF 3 BUTTERFLY COOKIE CUTTERS', '84380');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 2973, 2, NULL, NULL, 'BIRD ON BRANCH CANVAS SCREEN', '84387A');
INSERT INTO public.products VALUES (10, 1.02, 22, NULL, 2974, 2, NULL, NULL, 'WISE MAN STAR SHAPE EGG PAN', '84388');
INSERT INTO public.products VALUES (10, 0.79, 22, NULL, 2975, 2, NULL, NULL, 'PURPLE DRESS JEWELLERY STAND', '84402B');
INSERT INTO public.products VALUES (146, 4.27, 14, NULL, 2976, 2, NULL, NULL, 'CREAM CUPID HEARTS COAT HANGER', '84406B');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 2977, 2, NULL, NULL, 'PINK FLOCK SUEDE CUSHION COVER ', '84415A');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 2978, 2, NULL, NULL, 'BLUE FLOCK CUSHION COVER ', '84415B');
INSERT INTO public.products VALUES (48, 0.86, 22, NULL, 2979, 2, NULL, NULL, 'PINK/BLUE DISC/MIRROR STRING', '84422');
INSERT INTO public.products VALUES (10, 3.87, 22, NULL, 2980, 2, NULL, NULL, 'MEDIUM PINK BUDDHA HEAD ', '84429A');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 2981, 2, NULL, NULL, 'METAL RABBIT LADDER EASTER ', '84452');
INSERT INTO public.products VALUES (12, 0.99, 22, NULL, 2982, 2, NULL, NULL, 'SET/3 RABBITS FLOWER SKIPPPING ROPE', '84457');
INSERT INTO public.products VALUES (65, 2.19, 22, NULL, 2983, 2, NULL, NULL, 'PINK METAL CHICKEN HEART ', '84459A');
INSERT INTO public.products VALUES (72, 2.08, 22, NULL, 2984, 2, NULL, NULL, 'YELLOW METAL CHICKEN HEART ', '84459B');
INSERT INTO public.products VALUES (10, 2.55, 16, NULL, 2985, 2, NULL, NULL, '12 PINK HEN+CHICKS IN BASKET', '84461');
INSERT INTO public.products VALUES (10, 1.25, 16, NULL, 2986, 2, NULL, NULL, '3 PINK HEN+CHICKS IN BASKET', '84462');
INSERT INTO public.products VALUES (10, 2.95, 16, NULL, 2987, 2, NULL, NULL, '15 PINK FLUFFY CHICKS IN BOX', '84465');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 2988, 2, NULL, NULL, 'TOP SECRET PEN SET', '84466');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 2989, 2, NULL, NULL, 'BUTTONS AND STRIPES NOTEBOOK ', '84497');
INSERT INTO public.products VALUES (10, 0.85, 12, NULL, 2990, 2, NULL, NULL, 'BLACK FLOWER CANDLE PLATE', '84499');
INSERT INTO public.products VALUES (10, 3.43, 20, NULL, 2991, 2, NULL, NULL, 'STRIPES DESIGN MONKEY DOLL', '84507B');
INSERT INTO public.products VALUES (10, 2.70, 20, NULL, 2992, 2, NULL, NULL, 'BLUE CIRCLES DESIGN MONKEY DOLL', '84507C');
INSERT INTO public.products VALUES (159, 2.35, 21, NULL, 2993, 2, NULL, NULL, 'CAMOUFLAGE DESIGN TEDDY', '84508A');
INSERT INTO public.products VALUES (10, 2.55, 21, NULL, 2994, 2, NULL, NULL, 'STRIPES DESIGN TEDDY', '84508B');
INSERT INTO public.products VALUES (10, 2.91, 21, NULL, 2995, 2, NULL, NULL, 'BLUE CIRCLES DESIGN TEDDY', '84508C');
INSERT INTO public.products VALUES (88, 4.49, 22, NULL, 2996, 2, NULL, NULL, 'SET OF 4 ENGLISH ROSE PLACEMATS', '84509A');
INSERT INTO public.products VALUES (21, 3.80, 22, NULL, 2997, 2, NULL, NULL, 'SET OF 4 FAIRY CAKE PLACEMATS', '84509B');
INSERT INTO public.products VALUES (13, 4.14, 22, NULL, 2998, 2, NULL, NULL, 'SET OF 4 POLKADOT PLACEMATS ', '84509C');
INSERT INTO public.products VALUES (10, 3.54, 22, NULL, 2999, 2, NULL, NULL, 'SET OF 4 CAROUSEL PLACEMATS ', '84509E');
INSERT INTO public.products VALUES (51, 3.02, 22, NULL, 3000, 2, NULL, NULL, 'SET OF 4 FAIRY CAKE PLACEMATS ', '84509G');
INSERT INTO public.products VALUES (10, 7.46, 22, NULL, 3001, 2, NULL, NULL, 'SET OF 4 ENGLISH ROSE PLACEMATS', '84509a');
INSERT INTO public.products VALUES (10, 7.46, 22, NULL, 3002, 2, NULL, NULL, 'SET OF 4 FAIRY CAKE PLACEMATS', '84509b');
INSERT INTO public.products VALUES (10, 7.50, 22, NULL, 3003, 2, NULL, NULL, 'SET OF 4 POLKADOT PLACEMATS ', '84509c');
INSERT INTO public.products VALUES (10, 7.46, 22, NULL, 3004, 2, NULL, NULL, 'SET OF 4 FAIRY CAKE PLACEMATS ', '84509g');
INSERT INTO public.products VALUES (120, 1.73, 22, NULL, 3005, 2, NULL, NULL, 'SET OF 4 ENGLISH ROSE COASTERS', '84510A');
INSERT INTO public.products VALUES (13, 1.77, 22, NULL, 3006, 2, NULL, NULL, 'SET OF 4 POLKADOT COASTERS', '84510C');
INSERT INTO public.products VALUES (10, 1.66, 22, NULL, 3007, 2, NULL, NULL, 'SET OF 4 GREEN CAROUSEL COASTERS', '84510E');
INSERT INTO public.products VALUES (10, 2.46, 22, NULL, 3008, 2, NULL, NULL, 'SET OF 4 ENGLISH ROSE COASTERS', '84510a');
INSERT INTO public.products VALUES (10, 2.47, 22, NULL, 3009, 2, NULL, NULL, 'SET OF 4 POLKADOT COASTERS', '84510c');
INSERT INTO public.products VALUES (10, 2.46, 22, NULL, 3010, 2, NULL, NULL, 'SET OF 4 GREEN CAROUSEL COASTERS', '84510e');
INSERT INTO public.products VALUES (51, 2.51, 22, NULL, 3011, 2, NULL, NULL, 'TOMATO CHARLIE+LOLA COASTER SET', '84519A');
INSERT INTO public.products VALUES (47, 2.36, 22, NULL, 3012, 2, NULL, NULL, 'CARROT CHARLIE+LOLA COASTER SET', '84519B');
INSERT INTO public.products VALUES (55, 1.10, 22, NULL, 3013, 2, NULL, NULL, 'PACK 20 ENGLISH ROSE PAPER NAPKINS', '84520B');
INSERT INTO public.products VALUES (10, 1.82, 14, NULL, 3014, 2, NULL, NULL, 'PINK PARTY SUNGLASSES', '84522');
INSERT INTO public.products VALUES (10, 2.15, 14, NULL, 3015, 2, NULL, NULL, 'FLAMES SUNGLASSES PINK LENSES', '84527');
INSERT INTO public.products VALUES (14, 0.67, 22, NULL, 3016, 2, NULL, NULL, 'PINK KNITTED EGG COSY', '84531A');
INSERT INTO public.products VALUES (15, 0.72, 22, NULL, 3017, 2, NULL, NULL, 'BLUE KNITTED EGG COSY', '84531B');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 3018, 2, NULL, NULL, 'FAIRY CAKE NOTEBOOK A5 SIZE', '84534B');
INSERT INTO public.products VALUES (10, 1.66, 22, NULL, 3019, 2, NULL, NULL, 'FAIRY CAKE NOTEBOOK A5 SIZE', '84534b');
INSERT INTO public.products VALUES (39, 0.68, 22, NULL, 3020, 2, NULL, NULL, 'ENGLISH ROSE NOTEBOOK A6 SIZE', '84535A');
INSERT INTO public.products VALUES (125, 0.89, 22, NULL, 3021, 2, NULL, NULL, 'FAIRY CAKES NOTEBOOK A6 SIZE', '84535B');
INSERT INTO public.products VALUES (310, 0.54, 22, NULL, 3022, 2, NULL, NULL, 'ENGLISH ROSE NOTEBOOK A7 SIZE', '84536A');
INSERT INTO public.products VALUES (205, 0.55, 22, NULL, 3023, 2, NULL, NULL, 'FAIRY CAKES NOTEBOOK A7 SIZE', '84536B');
INSERT INTO public.products VALUES (10, 0.79, 22, NULL, 3024, 2, NULL, NULL, 'ENGLISH ROSE NOTEBOOK A7 SIZE', '84536a');
INSERT INTO public.products VALUES (10, 0.81, 22, NULL, 3025, 2, NULL, NULL, 'FAIRY CAKES NOTEBOOK A7 SIZE', '84536b');
INSERT INTO public.products VALUES (10, 1.65, 20, NULL, 3026, 2, NULL, NULL, 'KNITTED RABBIT DOLL ', '84539');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 3027, 2, NULL, NULL, 'CROCHET BEAR RED/BLUE  KEYRING', '84548');
INSERT INTO public.products VALUES (10, 2.56, 22, NULL, 3028, 2, NULL, NULL, 'CROCHET WHITE RABBIT KEYRING ', '84549');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 3029, 2, NULL, NULL, 'CROCHET LILAC/RED BEAR KEYRING', '84550');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 3030, 2, NULL, NULL, 'CROCHET DOG KEYRING', '84551');
INSERT INTO public.products VALUES (33, 3.11, 15, NULL, 3031, 2, NULL, NULL, '3D DOG PICTURE PLAYING CARDS', '84558A');
INSERT INTO public.products VALUES (10, 5.86, 15, NULL, 3032, 2, NULL, NULL, '3D DOG PICTURE PLAYING CARDS', '84558a');
INSERT INTO public.products VALUES (39, 1.15, 22, NULL, 3033, 2, NULL, NULL, '3D SHEET OF DOG STICKERS', '84559A');
INSERT INTO public.products VALUES (23, 1.01, 22, NULL, 3034, 2, NULL, NULL, '3D SHEET OF CAT STICKERS', '84559B');
INSERT INTO public.products VALUES (10, 1.67, 22, NULL, 3035, 2, NULL, NULL, '3D SHEET OF DOG STICKERS', '84559a');
INSERT INTO public.products VALUES (10, 1.67, 22, NULL, 3036, 2, NULL, NULL, '3D SHEET OF CAT STICKERS', '84559b');
INSERT INTO public.products VALUES (10, 7.95, 22, NULL, 3037, 2, NULL, NULL, 'PINK/WHITE RIBBED MELAMINE JUG', '84562A');
INSERT INTO public.products VALUES (10, 4.59, 22, NULL, 3038, 2, NULL, NULL, 'PINK & WHITE BREAKFAST TRAY', '84563A');
INSERT INTO public.products VALUES (10, 3.84, 22, NULL, 3039, 2, NULL, NULL, 'BLUE & WHITE BREAKFAST TRAY', '84563B');
INSERT INTO public.products VALUES (1388, 0.39, 22, NULL, 3040, 2, NULL, NULL, 'GIRLS ALPHABET IRON ON PATCHES ', '84568');
INSERT INTO public.products VALUES (29, 1.26, 22, NULL, 3041, 2, NULL, NULL, 'PACK 3 IRON ON DOG PATCHES', '84569A');
INSERT INTO public.products VALUES (10, 1.74, 22, NULL, 3042, 2, NULL, NULL, 'PACK 3 FIRE ENGINE/CAR PATCHES', '84569B');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 3043, 2, NULL, NULL, 'PACK 4 FLOWER/BUTTERFLY PATCHES', '84569C');
INSERT INTO public.products VALUES (46, 1.37, 22, NULL, 3044, 2, NULL, NULL, 'PACK 6 HEART/ICE-CREAM PATCHES', '84569D');
INSERT INTO public.products VALUES (10, 4.35, 22, NULL, 3045, 2, NULL, NULL, 'PINK DOG CANNISTER', '84575A');
INSERT INTO public.products VALUES (10, 2.81, 22, NULL, 3046, 2, NULL, NULL, 'BLUE CAT BISCUIT BARREL PINK HEART', '84576');
INSERT INTO public.products VALUES (39, 3.86, 20, NULL, 3047, 2, NULL, NULL, 'MOUSE TOY WITH PINK T-SHIRT', '84580');
INSERT INTO public.products VALUES (14, 3.80, 20, NULL, 3048, 2, NULL, NULL, 'DOG TOY WITH PINK CROCHET SKIRT', '84581');
INSERT INTO public.products VALUES (10, 2.22, 22, NULL, 3049, 2, NULL, NULL, 'PINK GINGHAM CAT WITH SCARF', '84584');
INSERT INTO public.products VALUES (10, 3.60, 13, NULL, 3050, 2, NULL, NULL, 'CROCHET ROSE PURSE WITH SUEDE BACK', '84592');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3051, 2, NULL, NULL, 'CROCHET ROSE DES CLOTHES HANGER', '84593');
INSERT INTO public.products VALUES (10, 2.78, 21, NULL, 3052, 2, NULL, NULL, 'LARGE TORTILLA DESIGN RED BOWL', '84595E');
INSERT INTO public.products VALUES (506, 0.61, 20, NULL, 3053, 2, NULL, NULL, 'SMALL DOLLY MIX DESIGN ORANGE BOWL', '84596B');
INSERT INTO public.products VALUES (56, 0.97, 22, NULL, 3054, 2, NULL, NULL, 'SMALL LICORICE DES PINK BOWL', '84596E');
INSERT INTO public.products VALUES (373, 0.63, 22, NULL, 3055, 2, NULL, NULL, 'SMALL MARSHMALLOWS PINK BOWL', '84596F');
INSERT INTO public.products VALUES (149, 0.62, 22, NULL, 3056, 2, NULL, NULL, 'SMALL CHOCOLATES PINK BOWL', '84596G');
INSERT INTO public.products VALUES (56, 0.83, 12, NULL, 3057, 2, NULL, NULL, 'MIXED NUTS LIGHT GREEN BOWL', '84596J');
INSERT INTO public.products VALUES (125, 0.70, 12, NULL, 3058, 2, NULL, NULL, 'BISCUITS SMALL BOWL LIGHT BLUE', '84596L');
INSERT INTO public.products VALUES (10, 2.51, 20, NULL, 3059, 2, NULL, NULL, 'SMALL DOLLY MIX DESIGN ORANGE BOWL', '84596b');
INSERT INTO public.products VALUES (10, 2.51, 22, NULL, 3060, 2, NULL, NULL, 'SMALL LICORICE DES PINK BOWL', '84596e');
INSERT INTO public.products VALUES (10, 2.46, 22, NULL, 3061, 2, NULL, NULL, 'SMALL MARSHMALLOWS PINK BOWL', '84596f');
INSERT INTO public.products VALUES (10, 2.46, 22, NULL, 3062, 2, NULL, NULL, 'SMALL CHOCOLATES PINK BOWL', '84596g');
INSERT INTO public.products VALUES (10, 2.46, 12, NULL, 3063, 2, NULL, NULL, 'BISCUITS SMALL BOWL LIGHT BLUE', '84596l');
INSERT INTO public.products VALUES (10, 1.04, 22, NULL, 3064, 2, NULL, NULL, 'RETRO BROWN BALL ASHTRAY ', '84597B');
INSERT INTO public.products VALUES (10, 1.25, 22, NULL, 3065, 2, NULL, NULL, 'RETRO PINK BALL ASHTRAY ', '84597C');
INSERT INTO public.products VALUES (10, 0.38, 22, NULL, 3066, 2, NULL, NULL, 'BOYS ALPHABET IRON ON PATCHES', '84598');
INSERT INTO public.products VALUES (10, 9.39, 16, NULL, 3067, 2, NULL, NULL, 'NEW BAROQUE JEWELLERY BOX ', '84600');
INSERT INTO public.products VALUES (10, 9.14, 12, NULL, 3068, 2, NULL, NULL, 'TALL ROCOCO CANDLE HOLDER', '84609');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 3069, 2, NULL, NULL, 'thrown away', '84611B');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 3070, 2, NULL, NULL, 'thrown away', '84612B');
INSERT INTO public.products VALUES (10, 3.49, 12, NULL, 3071, 2, NULL, NULL, 'PINK NEW BAROQUE FLOCK CANDLESTICK', '84613A');
INSERT INTO public.products VALUES (10, 4.65, 12, NULL, 3072, 2, NULL, NULL, 'BLUE NEW BAROQUE FLOCK CANDLESTICK', '84613C');
INSERT INTO public.products VALUES (10, 2.98, 12, NULL, 3073, 2, NULL, NULL, 'PINK BAROQUE FLOCK CANDLE HOLDER', '84614A');
INSERT INTO public.products VALUES (10, 37.68, 22, NULL, 3074, 2, NULL, NULL, 'SILVER ROCCOCO CHANDELIER', '84616');
INSERT INTO public.products VALUES (10, 12.75, 16, NULL, 3075, 2, NULL, NULL, 'NEW BAROQUE BLACK BOXES', '84617');
INSERT INTO public.products VALUES (10, 5.95, 22, NULL, 3076, 2, NULL, NULL, 'BLUE GINGHAM ROSE CUSHION COVER', '84620');
INSERT INTO public.products VALUES (45, 2.58, 12, NULL, 3077, 2, NULL, NULL, 'PINK NEW BAROQUECANDLESTICK CANDLE', '84625A');
INSERT INTO public.products VALUES (40, 2.19, 12, NULL, 3078, 2, NULL, NULL, 'BLUE NEW BAROQUE CANDLESTICK CANDLE', '84625C');
INSERT INTO public.products VALUES (10, 9.59, 15, NULL, 3079, 2, NULL, NULL, 'WHITE 3 FRAME BIRDS AND TREE ', '84629');
INSERT INTO public.products VALUES (10, 8.63, 21, NULL, 3080, 2, NULL, NULL, 'FRUIT TREE AND BIRDS WALL PLAQUE', '84631');
INSERT INTO public.products VALUES (10, 59.95, 22, NULL, 3081, 2, NULL, NULL, 'DECORATIVE HANGING SHELVING UNIT', '84632');
INSERT INTO public.products VALUES (11, 5.30, 21, NULL, 3082, 2, NULL, NULL, 'KITCHEN FLOWER POTS WALL PLAQUE', '84637');
INSERT INTO public.products VALUES (10, 6.67, 21, NULL, 3083, 2, NULL, NULL, 'SMALL KITCHEN FLOWER POTS PLAQUE', '84638');
INSERT INTO public.products VALUES (10, 7.29, 22, NULL, 3084, 2, NULL, NULL, 'WHITE STITCHED CUSHION COVER', '84658');
INSERT INTO public.products VALUES (29, 2.45, 18, NULL, 3085, 2, NULL, NULL, 'WHITE TRAVEL ALARM CLOCK', '84659A');
INSERT INTO public.products VALUES (82, 1.67, 18, NULL, 3086, 2, NULL, NULL, 'WHITE STITCHED WALL CLOCK', '84660A');
INSERT INTO public.products VALUES (70, 2.07, 18, NULL, 3087, 2, NULL, NULL, 'BLACK STITCHED WALL CLOCK', '84660B');
INSERT INTO public.products VALUES (66, 2.49, 18, NULL, 3088, 2, NULL, NULL, 'PINK STITCHED WALL CLOCK', '84660C');
INSERT INTO public.products VALUES (10, 7.46, 18, NULL, 3089, 2, NULL, NULL, 'WHITE STITCHED WALL CLOCK', '84660a');
INSERT INTO public.products VALUES (10, 7.54, 18, NULL, 3090, 2, NULL, NULL, 'BLACK STITCHED WALL CLOCK', '84660b');
INSERT INTO public.products VALUES (10, 7.50, 18, NULL, 3091, 2, NULL, NULL, 'PINK STITCHED WALL CLOCK', '84660c');
INSERT INTO public.products VALUES (10, 2.79, 18, NULL, 3092, 2, NULL, NULL, 'WHITE SQUARE TABLE CLOCK', '84661A');
INSERT INTO public.products VALUES (11, 3.38, 18, NULL, 3093, 2, NULL, NULL, 'BLACK SQUARE TABLE CLOCK', '84661B');
INSERT INTO public.products VALUES (10, 3.02, 18, NULL, 3094, 2, NULL, NULL, 'PINK SQUARE TABLE CLOCK', '84661C');
INSERT INTO public.products VALUES (10, 4.96, 18, NULL, 3095, 2, NULL, NULL, 'WHITE SQUARE TABLE CLOCK', '84661a');
INSERT INTO public.products VALUES (10, 4.96, 18, NULL, 3096, 2, NULL, NULL, 'BLACK SQUARE TABLE CLOCK', '84661b');
INSERT INTO public.products VALUES (26, 2.93, 18, NULL, 3097, 2, NULL, NULL, 'GRASS HOPPER WOODEN WALL CLOCK ', '84663A');
INSERT INTO public.products VALUES (10, 5.67, 22, NULL, 3098, 2, NULL, NULL, 'SQUARE CHERRY BLOSSOM CABINET', '84665');
INSERT INTO public.products VALUES (10, 3.95, 22, NULL, 3099, 2, NULL, NULL, 'SQUARE CHERRY BLOSSOM CABINET', '84666');
INSERT INTO public.products VALUES (10, 0.70, 22, NULL, 3100, 2, NULL, NULL, 'PINK FLY SWAT', '84673A');
INSERT INTO public.products VALUES (17, 0.93, 22, NULL, 3101, 2, NULL, NULL, 'BLUE FLY SWAT', '84673B');
INSERT INTO public.products VALUES (19, 3.25, 22, NULL, 3102, 2, NULL, NULL, 'FLYING PIG WATERING CAN', '84674');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3103, 2, NULL, NULL, 'FROG KING WATERING CAN', '84675');
INSERT INTO public.products VALUES (13, 2.69, 22, NULL, 3104, 2, NULL, NULL, 'CLASSICAL ROSE SMALL VASE', '84678');
INSERT INTO public.products VALUES (10, 11.95, 22, NULL, 3105, 2, NULL, NULL, 'CLASSICAL ROSE TABLE LAMP', '84679');
INSERT INTO public.products VALUES (19, 1.51, 12, NULL, 3106, 2, NULL, NULL, 'CLASSICAL ROSE CANDLESTAND', '84683');
INSERT INTO public.products VALUES (10, 5.84, 22, NULL, 3107, 2, NULL, NULL, 'BEACH HUT KEY CABINET', '84685');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3108, 2, NULL, NULL, 'BEACH HUT MIRROR', '84686');
INSERT INTO public.products VALUES (10, 7.64, 22, NULL, 3109, 2, NULL, NULL, 'BEACH HUT SHELF W 3 DRAWERS', '84687');
INSERT INTO public.products VALUES (10, 5.95, 21, NULL, 3110, 2, NULL, NULL, 'BEACH HUT DESIGN BLACKBOARD', '84688');
INSERT INTO public.products VALUES (10, 3.98, 22, NULL, 3111, 2, NULL, NULL, 'S/2 BEACH HUT TREASURE CHESTS', '84689');
INSERT INTO public.products VALUES (24, 0.75, 20, NULL, 3112, 2, NULL, NULL, 'PACK 20 DOLLY PEGS', '84691');
INSERT INTO public.products VALUES (788, 0.67, 16, NULL, 3113, 2, NULL, NULL, 'BOX OF 24 COCKTAIL PARASOLS', '84692');
INSERT INTO public.products VALUES (10, 1.25, 15, NULL, 3114, 2, NULL, NULL, 'PINK FLOCK PHOTO FRAME ', '84705C');
INSERT INTO public.products VALUES (10, 3.70, 18, NULL, 3115, 2, NULL, NULL, 'CHERRY BLOSSOM TABLE CLOCK ', '84706D');
INSERT INTO public.products VALUES (10, 2.95, 18, NULL, 3116, 2, NULL, NULL, 'RED PEONY TABLE CLOCK', '84706F');
INSERT INTO public.products VALUES (10, 9.79, 22, NULL, 3117, 2, NULL, NULL, 'SILVER JEWELLED MIRROR TRINKET TRAY', '84707A');
INSERT INTO public.products VALUES (10, 8.19, 22, NULL, 3118, 2, NULL, NULL, 'PINK JEWELLED MIRROR TRINKET TRAY', '84707B');
INSERT INTO public.products VALUES (10, 5.93, 15, NULL, 3119, 2, NULL, NULL, 'PINK JEWELLED PHOTO FRAME ', '84708B');
INSERT INTO public.products VALUES (10, 5.95, 22, NULL, 3120, 2, NULL, NULL, 'PINK OVAL JEWELLED MIRROR', '84709B');
INSERT INTO public.products VALUES (10, 8.61, 16, NULL, 3121, 2, NULL, NULL, 'SILVER OVAL SHAPE TRINKET BOX', '84711A');
INSERT INTO public.products VALUES (10, 9.00, 16, NULL, 3122, 2, NULL, NULL, 'PINK OVAL SHAPE TRINKET BOX', '84711B');
INSERT INTO public.products VALUES (10, 7.68, 15, NULL, 3123, 2, NULL, NULL, 'PINK JEWELLED PHOTO FRAME', '84712B');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3124, 2, NULL, NULL, 'SET OF 6 ICE CREAM SKITTLES', '84715');
INSERT INTO public.products VALUES (10, 3.95, 15, NULL, 3125, 2, NULL, NULL, 'CHERRY BLOSSOM CANVAS ART PICTURE', '84723');
INSERT INTO public.products VALUES (10, 1.24, 15, NULL, 3126, 2, NULL, NULL, 'FREESTYLE CANVAS ART PICTURE', '84725');
INSERT INTO public.products VALUES (10, 1.02, 22, NULL, 3127, 2, NULL, NULL, '3 BIRDS CANVAS SCREEN', '84731');
INSERT INTO public.products VALUES (10, 0.39, 22, NULL, 3128, 2, NULL, NULL, 'CUTE BIRD CEATURE SCREEN', '84732B');
INSERT INTO public.products VALUES (10, 0.39, 22, NULL, 3129, 2, NULL, NULL, 'CUTE RABBIT CEATURE SCREEN ', '84732D');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 3130, 2, NULL, NULL, 'CITRUS GARLAND FELT FLOWERS ', '84741C');
INSERT INTO public.products VALUES (10, 0.62, 22, NULL, 3131, 2, NULL, NULL, 'ORANGE FELT VASE + FLOWERS', '84743C');
INSERT INTO public.products VALUES (11, 1.38, 22, NULL, 3132, 2, NULL, NULL, 'S/6 SEW ON CROCHET FLOWERS', '84744');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 3133, 2, NULL, NULL, 'PINK HANGING GINGHAM EASTER HEN', '84745A');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 3134, 2, NULL, NULL, 'BLUE HANGING GINGHAM EASTER HEN', '84745B');
INSERT INTO public.products VALUES (10, 2.60, 22, NULL, 3135, 2, NULL, NULL, 'PINK EASTER HENS+FLOWER', '84746');
INSERT INTO public.products VALUES (20, 3.24, 22, NULL, 3136, 2, NULL, NULL, 'FOLK FELT HANGING MULTICOL GARLAND', '84748');
INSERT INTO public.products VALUES (10, 1.95, 14, NULL, 3137, 2, NULL, NULL, 'PINK SMALL GLASS CAKE STAND', '84750A');
INSERT INTO public.products VALUES (10, 1.11, 14, NULL, 3138, 2, NULL, NULL, 'BLACK SMALL GLASS CAKE STAND', '84750B');
INSERT INTO public.products VALUES (10, 1.68, 14, NULL, 3139, 2, NULL, NULL, 'BLACK MEDIUM GLASS CAKE STAND', '84751B');
INSERT INTO public.products VALUES (41, 1.74, 13, NULL, 3140, 2, NULL, NULL, 'S/15 SILVER GLASS BAUBLES IN BAG', '84754');
INSERT INTO public.products VALUES (1638, 0.73, 12, NULL, 3141, 2, NULL, NULL, 'COLOUR GLASS T-LIGHT HOLDER HANGING', '84755');
INSERT INTO public.products VALUES (10, 1.45, 12, NULL, 3142, 2, NULL, NULL, 'SMALL HANGING GLASS+ZINC LANTERN', '84760S');
INSERT INTO public.products VALUES (45, 1.39, 22, NULL, 3143, 2, NULL, NULL, 'ZINC FINISH 15CM PLANTER POTS', '84763');
INSERT INTO public.products VALUES (13, 3.36, 12, NULL, 3144, 2, NULL, NULL, 'SILVER ROCOCO CANDLE STICK', '84766');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3145, 2, NULL, NULL, 'RED ROSE AND LACE C/COVER', '84773');
INSERT INTO public.products VALUES (18, 4.03, 22, NULL, 3146, 2, NULL, NULL, 'ENCHANTED BIRD PLANT CAGE', '84789');
INSERT INTO public.products VALUES (80, 5.51, 22, NULL, 3147, 2, NULL, NULL, 'ENCHANTED BIRD COATHANGER 5 HOOK', '84792');
INSERT INTO public.products VALUES (17, 9.09, 22, NULL, 3148, 2, NULL, NULL, 'SUNSET CHECK HAMMOCK', '84795B');
INSERT INTO public.products VALUES (10, 7.95, 22, NULL, 3149, 2, NULL, NULL, 'OCEAN STRIPE HAMMOCK ', '84795C');
INSERT INTO public.products VALUES (10, 16.65, 22, NULL, 3150, 2, NULL, NULL, 'SUNSET CHECK HAMMOCK', '84795b');
INSERT INTO public.products VALUES (10, 9.33, 22, NULL, 3151, 2, NULL, NULL, 'PINK HAWAIIAN PICNIC HAMPER FOR 2', '84796A');
INSERT INTO public.products VALUES (25, 9.26, 22, NULL, 3152, 2, NULL, NULL, 'BLUE SAVANNAH PICNIC HAMPER FOR 2', '84796B');
INSERT INTO public.products VALUES (10, 8.30, 22, NULL, 3153, 2, NULL, NULL, 'PINK HAWAIIAN PICNIC HAMPER FOR 2', '84796a');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 3154, 2, NULL, NULL, 'PINK FOXGLOVE ARTIIFCIAL FLOWER', '84798A');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 3155, 2, NULL, NULL, 'PURPLE FOXGLOVE ARTIIFCIAL FLOWER', '84798B');
INSERT INTO public.products VALUES (16, 0.97, 22, NULL, 3156, 2, NULL, NULL, 'SPRIG LAVENDER ARTIFICIAL FLOWER', '84799');
INSERT INTO public.products VALUES (19, 1.83, 22, NULL, 3157, 2, NULL, NULL, 'LARGE WHITE/PINK ROSE ART FLOWER', '84800L');
INSERT INTO public.products VALUES (12, 1.55, 22, NULL, 3158, 2, NULL, NULL, 'MEDIUM WHITE/PINK ROSE ART FLOWER', '84800M');
INSERT INTO public.products VALUES (11, 1.22, 22, NULL, 3159, 2, NULL, NULL, 'SMALL WHITE/PINK ROSE ART FLOWER', '84800S');
INSERT INTO public.products VALUES (10, 1.50, 22, NULL, 3160, 2, NULL, NULL, 'PINK HYDRANGEA ART FLOWER', '84801A');
INSERT INTO public.products VALUES (10, 2.10, 22, NULL, 3161, 2, NULL, NULL, 'WHITE HYDRANGEA ART FLOWER', '84801B');
INSERT INTO public.products VALUES (10, 1.69, 22, NULL, 3162, 2, NULL, NULL, 'WHITE ANEMONE ARTIFICIAL FLOWER', '84802A');
INSERT INTO public.products VALUES (10, 1.69, 22, NULL, 3163, 2, NULL, NULL, 'PURPLE ANEMONE ARTIFICIAL FLOWER', '84802B');
INSERT INTO public.products VALUES (10, 1.69, 22, NULL, 3164, 2, NULL, NULL, 'PINK ALLIUM  ARTIFICIAL FLOWER', '84803A');
INSERT INTO public.products VALUES (10, 1.69, 22, NULL, 3165, 2, NULL, NULL, 'WHITE ALLIUM  ARTIFICIAL FLOWER', '84803B');
INSERT INTO public.products VALUES (10, 2.38, 22, NULL, 3166, 2, NULL, NULL, 'CREAM DELPHINIUM ARTIFICIAL FLOWER', '84804A');
INSERT INTO public.products VALUES (10, 2.23, 22, NULL, 3167, 2, NULL, NULL, 'BLUE DELPHINIUM ARTIFICIAL FLOWER', '84804B');
INSERT INTO public.products VALUES (10, 2.00, 22, NULL, 3168, 2, NULL, NULL, 'CREAM CLIMBING HYDRANGA ART FLOWER', '84805A');
INSERT INTO public.products VALUES (10, 1.56, 22, NULL, 3169, 2, NULL, NULL, 'wet damaged', '84805B');
INSERT INTO public.products VALUES (13, 1.06, 22, NULL, 3170, 2, NULL, NULL, 'PINK CANDYSTUFT ARTIFICIAL FLOWER', '84806A');
INSERT INTO public.products VALUES (30, 1.39, 22, NULL, 3171, 2, NULL, NULL, 'WHITE CANDYSTUFT ARTIFICIAL FLOWER', '84806B');
INSERT INTO public.products VALUES (10, 2.10, 22, NULL, 3172, 2, NULL, NULL, 'WHITE CHRYSANTHEMUMS ART FLOWER', '84809A');
INSERT INTO public.products VALUES (10, 1.05, 22, NULL, 3173, 2, NULL, NULL, 'PINK CHRYSANTHEMUMS ART FLOWER', '84809B');
INSERT INTO public.products VALUES (16, 10.36, 22, NULL, 3174, 2, NULL, NULL, 'SET OF 4 DIAMOND NAPKIN RINGS', '84813');
INSERT INTO public.products VALUES (10, 37.45, 22, NULL, 3175, 2, NULL, NULL, 'DANISH ROSE BEDSIDE CABINET', '84816');
INSERT INTO public.products VALUES (91, 1.50, 22, NULL, 3176, 2, NULL, NULL, 'DANISH ROSE DECORATIVE PLATE', '84817');
INSERT INTO public.products VALUES (125, 1.34, 15, NULL, 3177, 2, NULL, NULL, 'DANISH ROSE PHOTO FRAME', '84818');
INSERT INTO public.products VALUES (80, 2.28, 16, NULL, 3178, 2, NULL, NULL, 'DANISH ROSE ROUND SEWING BOX', '84819');
INSERT INTO public.products VALUES (25, 3.85, 22, NULL, 3179, 2, NULL, NULL, 'DANISH ROSE TRINKET TRAYS', '84820');
INSERT INTO public.products VALUES (93, 0.63, 22, NULL, 3180, 2, NULL, NULL, 'DANISH ROSE DELUXE COASTER', '84821');
INSERT INTO public.products VALUES (11, 7.95, 22, NULL, 3181, 2, NULL, NULL, 'DANISH ROSE FOLDING CHAIR', '84823');
INSERT INTO public.products VALUES (10, 15.95, 22, NULL, 3182, 2, NULL, NULL, 'DANISH ROSE UMBRELLA STAND', '84824');
INSERT INTO public.products VALUES (1364, 0.57, 21, NULL, 3183, 2, NULL, NULL, 'ASSTD DESIGN 3D PAPER STICKERS', '84826');
INSERT INTO public.products VALUES (51, 0.49, 22, NULL, 3184, 2, NULL, NULL, 'ASS DES PHONE SPONGE CRAFT STICKER', '84827');
INSERT INTO public.products VALUES (107, 1.63, 22, NULL, 3185, 2, NULL, NULL, 'JUNGLE POPSICLES ICE LOLLY HOLDERS', '84828');
INSERT INTO public.products VALUES (292, 1.09, 12, NULL, 3186, 2, NULL, NULL, 'ZINC WILLIE WINKIE  CANDLE STICK', '84832');
INSERT INTO public.products VALUES (590, 1.36, 22, NULL, 3187, 2, NULL, NULL, 'ZINC METAL HEART DECORATION', '84836');
INSERT INTO public.products VALUES (10, 5.55, 22, NULL, 3188, 2, NULL, NULL, 'SWEETHEART KEY CABINET', '84839');
INSERT INTO public.products VALUES (10, 12.13, 16, NULL, 3189, 2, NULL, NULL, 'SWEETHEART CARRY-ALL BASKET', '84840');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 3190, 2, NULL, NULL, 'HELLO SAILOR BATHROOM SET', '84842');
INSERT INTO public.products VALUES (17, 6.56, 14, NULL, 3191, 2, NULL, NULL, 'WHITE SOAP RACK WITH 2 BOTTLES', '84843');
INSERT INTO public.products VALUES (10, 2.55, 12, NULL, 3192, 2, NULL, NULL, 'SCENTED CANDLE IN DIGITALIS TIN', '84846A');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 3193, 2, NULL, NULL, 'FLORAL BATHROOM SET', '84847');
INSERT INTO public.products VALUES (16, 2.34, 22, NULL, 3194, 2, NULL, NULL, 'HELLO SAILOR BLUE SOAP HOLDER', '84849A');
INSERT INTO public.products VALUES (26, 2.05, 22, NULL, 3195, 2, NULL, NULL, 'FAIRY SOAP SOAP HOLDER', '84849B');
INSERT INTO public.products VALUES (47, 1.86, 22, NULL, 3196, 2, NULL, NULL, 'HOT BATHS SOAP HOLDER', '84849D');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 3197, 2, NULL, NULL, 'GIRLY PINK TOOL SET', '84854');
INSERT INTO public.products VALUES (10, 8.91, 13, NULL, 3198, 2, NULL, NULL, 'LARGE TAHITI BEACH BAG', '84856L');
INSERT INTO public.products VALUES (10, 4.23, 13, NULL, 3199, 2, NULL, NULL, 'SMALL TAHITI BEACH BAG', '84856S');
INSERT INTO public.products VALUES (10, 1.95, 13, NULL, 3200, 2, NULL, NULL, 'BLUE MONTE CARLO HANDBAG', '84857B');
INSERT INTO public.products VALUES (10, 4.51, 13, NULL, 3201, 2, NULL, NULL, 'PINK MONTE CARLO HANDBAG', '84857C');
INSERT INTO public.products VALUES (18, 5.33, 13, NULL, 3202, 2, NULL, NULL, 'PINK RIVIERA HANDBAG', '84858C');
INSERT INTO public.products VALUES (12, 2.48, 13, NULL, 3203, 2, NULL, NULL, 'SILVER DISCO HANDBAG', '84859A');
INSERT INTO public.products VALUES (10, 2.31, 13, NULL, 3204, 2, NULL, NULL, 'BLUE DISCO HANDBAG', '84859B');
INSERT INTO public.products VALUES (10, 2.32, 13, NULL, 3205, 2, NULL, NULL, 'PINK DISCO HANDBAG', '84859C');
INSERT INTO public.products VALUES (10, 6.58, 15, NULL, 3206, 2, NULL, NULL, 'NEW BAROQUE BLACK PHOTO ALBUM', '84865');
INSERT INTO public.products VALUES (10, 3.45, 22, NULL, 3207, 2, NULL, NULL, 'BLUE GEISHA GIRL ', '84870B');
INSERT INTO public.products VALUES (10, 3.16, 22, NULL, 3208, 2, NULL, NULL, 'GREEN GEISHA GIRL ', '84870C');
INSERT INTO public.products VALUES (10, 10.70, 22, NULL, 3209, 2, NULL, NULL, 'TEATIME FUNKY FLOWER BACKPACK FOR 2', '84872A');
INSERT INTO public.products VALUES (10, 10.86, 22, NULL, 3210, 2, NULL, NULL, 'TEATIME FUNKY FLOWER BACKPACK FOR 2', '84872a');
INSERT INTO public.products VALUES (10, 16.95, 13, NULL, 3211, 2, NULL, NULL, 'FUNKY FLOWER PICNIC BAG FOR 4', '84873A');
INSERT INTO public.products VALUES (10, 1.64, 22, NULL, 3212, 2, NULL, NULL, 'BLUE TRAVEL FIRST AID KIT', '84874B');
INSERT INTO public.products VALUES (13, 2.55, 22, NULL, 3213, 2, NULL, NULL, 'GREEN SQUARE COMPACT MIRROR', '84875B');
INSERT INTO public.products VALUES (10, 1.11, 22, NULL, 3214, 2, NULL, NULL, 'BLUE SQUARE COMPACT MIRROR', '84875D');
INSERT INTO public.products VALUES (28, 2.29, 22, NULL, 3215, 2, NULL, NULL, 'GREEN HEART COMPACT MIRROR', '84876B');
INSERT INTO public.products VALUES (12, 3.40, 22, NULL, 3216, 2, NULL, NULL, 'BLUE HEART COMPACT MIRROR', '84876D');
INSERT INTO public.products VALUES (10, 2.27, 22, NULL, 3217, 2, NULL, NULL, 'PINK ROUND COMPACT MIRROR', '84877A');
INSERT INTO public.products VALUES (14, 2.32, 22, NULL, 3218, 2, NULL, NULL, 'GREEN ROUND COMPACT MIRROR', '84877B');
INSERT INTO public.products VALUES (10, 2.05, 22, NULL, 3219, 2, NULL, NULL, 'BLUE ROUND COMPACT MIRROR', '84877D');
INSERT INTO public.products VALUES (3622, 1.72, 22, NULL, 3220, 2, NULL, NULL, 'ASSORTED COLOUR BIRD ORNAMENT', '84879');
INSERT INTO public.products VALUES (30, 7.72, 22, NULL, 3221, 2, NULL, NULL, 'WHITE WIRE EGG HOLDER', '84880');
INSERT INTO public.products VALUES (10, 7.26, 12, NULL, 3222, 2, NULL, NULL, 'BLUE WIRE SPIRAL CANDLE HOLDER', '84881');
INSERT INTO public.products VALUES (10, 4.37, 12, NULL, 3223, 2, NULL, NULL, 'GREEN WIRE STANDING CANDLE HOLDER', '84882');
INSERT INTO public.products VALUES (30, 4.79, 22, NULL, 3224, 2, NULL, NULL, 'ANT WHITE WIRE HEART SPIRAL', '84884A');
INSERT INTO public.products VALUES (10, 8.35, 22, NULL, 3225, 2, NULL, NULL, 'ANT WHITE WIRE HEART SPIRAL', '84884a');
INSERT INTO public.products VALUES (10, 2.21, 13, NULL, 3226, 2, NULL, NULL, 'YELLOW FLOWERS FELT HANDBAG KIT', '84898F');
INSERT INTO public.products VALUES (10, 4.96, 22, NULL, 3227, 2, NULL, NULL, 'PINK BUTTERFLY CUSHION COVER ', '84905');
INSERT INTO public.products VALUES (10, 4.62, 22, NULL, 3228, 2, NULL, NULL, 'PINK B''FLY C/COVER W BOBBLES', '84906');
INSERT INTO public.products VALUES (10, 6.11, 22, NULL, 3229, 2, NULL, NULL, 'PINK YELLOW PATCH CUSHION COVER', '84907');
INSERT INTO public.products VALUES (10, 7.46, 22, NULL, 3230, 2, NULL, NULL, 'PINK PAISLEY CUSHION COVER ', '84910A');
INSERT INTO public.products VALUES (15, 3.53, 13, NULL, 3231, 2, NULL, NULL, 'PINK ROSE WASHBAG', '84912A');
INSERT INTO public.products VALUES (31, 3.41, 13, NULL, 3232, 2, NULL, NULL, 'GREEN ROSE WASHBAG', '84912B');
INSERT INTO public.products VALUES (27, 3.41, 22, NULL, 3233, 2, NULL, NULL, 'SOFT PINK ROSE TOWEL ', '84913A');
INSERT INTO public.products VALUES (19, 3.64, 22, NULL, 3234, 2, NULL, NULL, 'MINT GREEN ROSE TOWEL', '84913B');
INSERT INTO public.products VALUES (21, 3.89, 22, NULL, 3235, 2, NULL, NULL, 'HAND TOWEL PINK FLOWER AND DAISY', '84915');
INSERT INTO public.products VALUES (22, 3.95, 22, NULL, 3236, 2, NULL, NULL, 'HAND TOWEL PALE BLUE W FLOWERS', '84916');
INSERT INTO public.products VALUES (18, 3.98, 22, NULL, 3237, 2, NULL, NULL, 'WHITE HAND TOWEL WITH BUTTERFLY', '84917');
INSERT INTO public.products VALUES (10, 6.53, 22, NULL, 3238, 2, NULL, NULL, 'BLUE CUSHION COVER WITH FLOWER', '84919');
INSERT INTO public.products VALUES (11, 4.16, 22, NULL, 3239, 2, NULL, NULL, 'PINK FLOWER FABRIC PONY', '84920');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 3240, 2, NULL, NULL, 'CREAM AND PINK FLOWERS PONY ', '84921');
INSERT INTO public.products VALUES (10, 4.92, 13, NULL, 3241, 2, NULL, NULL, 'PINK BUTTERFLY WASHBAG', '84922');
INSERT INTO public.products VALUES (16, 4.15, 13, NULL, 3242, 2, NULL, NULL, 'PINK BUTTERFLY HANDBAG W BOBBLES', '84923');
INSERT INTO public.products VALUES (10, 5.00, 21, NULL, 3243, 2, NULL, NULL, 'WAKE UP COCKEREL CALENDAR SIGN ', '84924A');
INSERT INTO public.products VALUES (10, 0.79, 21, NULL, 3244, 2, NULL, NULL, 'PSYCHEDELIC METAL SIGN CALENDAR', '84924F');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 3245, 2, NULL, NULL, 'LA PALMIERA WALL THERMOMETER', '84925D');
INSERT INTO public.products VALUES (10, 1.96, 22, NULL, 3246, 2, NULL, NULL, 'PSYCHEDELIC WALL THERMOMETER', '84925F');
INSERT INTO public.products VALUES (60, 0.67, 22, NULL, 3247, 2, NULL, NULL, 'WAKE UP COCKEREL TILE COASTER', '84926A');
INSERT INTO public.products VALUES (70, 0.81, 22, NULL, 3248, 2, NULL, NULL, 'LA PALMIERA TILE COASTER', '84926D');
INSERT INTO public.products VALUES (99, 0.54, 22, NULL, 3249, 2, NULL, NULL, 'FLOWERS TILE COASTER', '84926E');
INSERT INTO public.products VALUES (40, 1.16, 22, NULL, 3250, 2, NULL, NULL, 'PSYCHEDELIC TILE COASTER', '84926F');
INSERT INTO public.products VALUES (10, 1.99, 22, NULL, 3251, 2, NULL, NULL, 'WAKE UP COCKEREL TILE HOOK', '84927A');
INSERT INTO public.products VALUES (10, 1.52, 22, NULL, 3252, 2, NULL, NULL, 'LA PALMIERA TILE HOOK', '84927D');
INSERT INTO public.products VALUES (10, 1.92, 22, NULL, 3253, 2, NULL, NULL, 'FLOWERS TILE HOOK', '84927E');
INSERT INTO public.products VALUES (29, 1.07, 22, NULL, 3254, 2, NULL, NULL, 'PSYCHEDELIC TILE HOOK', '84927F');
INSERT INTO public.products VALUES (173, 0.29, 22, NULL, 3255, 2, NULL, NULL, 'ASSTD FRUIT+FLOWERS FRIDGE MAGNETS', '84929');
INSERT INTO public.products VALUES (13, 2.51, 22, NULL, 3256, 2, NULL, NULL, 'PINK SCOTTIE DOG W FLOWER PATTERN', '84931A');
INSERT INTO public.products VALUES (17, 2.41, 22, NULL, 3257, 2, NULL, NULL, 'BLUE SCOTTIE DOG W FLOWER PATTERN', '84931B');
INSERT INTO public.products VALUES (71, 2.00, 22, NULL, 3258, 2, NULL, NULL, 'SET OF 6 KASHMIR FOLKART BAUBLES', '84944');
INSERT INTO public.products VALUES (1045, 0.97, 12, NULL, 3259, 2, NULL, NULL, 'MULTI COLOUR SILVER T-LIGHT HOLDER', '84945');
INSERT INTO public.products VALUES (1891, 1.52, 14, NULL, 3260, 2, NULL, NULL, 'ANTIQUE SILVER TEA GLASS ETCHED', '84946');
INSERT INTO public.products VALUES (867, 1.46, 14, NULL, 3261, 2, NULL, NULL, 'ANTIQUE SILVER TEA GLASS ENGRAVED', '84947');
INSERT INTO public.products VALUES (453, 1.83, 12, NULL, 3262, 2, NULL, NULL, 'SILVER HANGING T-LIGHT HOLDER', '84949');
INSERT INTO public.products VALUES (362, 0.81, 12, NULL, 3263, 2, NULL, NULL, 'ASSORTED COLOUR T-LIGHT HOLDER', '84950');
INSERT INTO public.products VALUES (45, 1.80, 22, NULL, 3264, 2, NULL, NULL, 'SET OF 4 PISTACHIO LOVEBIRD COASTER', '84951A');
INSERT INTO public.products VALUES (45, 1.82, 22, NULL, 3265, 2, NULL, NULL, 'SET OF 4 BLACK LOVEBIRD COASTERS', '84951B');
INSERT INTO public.products VALUES (10, 3.18, 12, NULL, 3266, 2, NULL, NULL, 'CLEAR LOVE BIRD T-LIGHT HOLDER', '84952A');
INSERT INTO public.products VALUES (18, 3.00, 12, NULL, 3267, 2, NULL, NULL, 'BLACK LOVE BIRD T-LIGHT HOLDER', '84952B');
INSERT INTO public.products VALUES (14, 4.04, 12, NULL, 3268, 2, NULL, NULL, 'MIRROR LOVE BIRD T-LIGHT HOLDER', '84952C');
INSERT INTO public.products VALUES (10, 42.95, 22, NULL, 3269, 2, NULL, NULL, 'PINK PAINTED KASHMIRI CHAIR', '84963A');
INSERT INTO public.products VALUES (10, 49.95, 22, NULL, 3270, 2, NULL, NULL, 'BLUE PAINTED KASHMIRI CHAIR', '84963B');
INSERT INTO public.products VALUES (25, 13.81, 22, NULL, 3271, 2, NULL, NULL, 'SET OF 16 VINTAGE ROSE CUTLERY', '84968A');
INSERT INTO public.products VALUES (10, 12.75, 22, NULL, 3272, 2, NULL, NULL, 'SET OF 16 VINTAGE IVORY CUTLERY', '84968B');
INSERT INTO public.products VALUES (31, 14.89, 22, NULL, 3273, 2, NULL, NULL, 'SET OF 16 VINTAGE PISTACHIO CUTLERY', '84968C');
INSERT INTO public.products VALUES (15, 12.21, 22, NULL, 3274, 2, NULL, NULL, 'SET OF 16 VINTAGE RED CUTLERY', '84968D');
INSERT INTO public.products VALUES (10, 11.78, 22, NULL, 3275, 2, NULL, NULL, 'check', '84968E');
INSERT INTO public.products VALUES (15, 12.14, 22, NULL, 3276, 2, NULL, NULL, 'SET OF 16 VINTAGE SKY BLUE CUTLERY', '84968F');
INSERT INTO public.products VALUES (10, 25.14, 22, NULL, 3277, 2, NULL, NULL, 'SET OF 16 VINTAGE ROSE CUTLERY', '84968a');
INSERT INTO public.products VALUES (10, 24.96, 22, NULL, 3278, 2, NULL, NULL, 'SET OF 16 VINTAGE RED CUTLERY', '84968d');
INSERT INTO public.products VALUES (10, 25.05, 22, NULL, 3279, 2, NULL, NULL, 'SET OF 16 VINTAGE BLACK CUTLERY', '84968e');
INSERT INTO public.products VALUES (10, 25.49, 22, NULL, 3280, 2, NULL, NULL, 'SET OF 16 VINTAGE SKY BLUE CUTLERY', '84968f');
INSERT INTO public.products VALUES (50, 4.61, 16, NULL, 3281, 2, NULL, NULL, 'BOX OF 6 ASSORTED COLOUR TEASPOONS', '84969');
INSERT INTO public.products VALUES (605, 1.30, 12, NULL, 3282, 2, NULL, NULL, 'SINGLE HEART ZINC T-LIGHT HOLDER', '84970L');
INSERT INTO public.products VALUES (888, 1.14, 12, NULL, 3283, 2, NULL, NULL, 'HANGING HEART ZINC T-LIGHT HOLDER', '84970S');
INSERT INTO public.products VALUES (20, 2.09, 12, NULL, 3284, 2, NULL, NULL, 'SINGLE HEART ZINC T-LIGHT HOLDER', '84970l');
INSERT INTO public.products VALUES (23, 2.09, 12, NULL, 3285, 2, NULL, NULL, 'HANGING HEART ZINC T-LIGHT HOLDER', '84970s');
INSERT INTO public.products VALUES (178, 1.11, 22, NULL, 3286, 2, NULL, NULL, 'SMALL HEART FLOWERS HOOK ', '84971S');
INSERT INTO public.products VALUES (10, 2.46, 22, NULL, 3287, 2, NULL, NULL, 'LARGE HEART FLOWERS HOOK   ', '84971l');
INSERT INTO public.products VALUES (10, 9.95, 21, NULL, 3288, 2, NULL, NULL, 'S/2 ZINC HEART DESIGN PLANTERS', '84974');
INSERT INTO public.products VALUES (10, 1.69, 22, NULL, 3289, 2, NULL, NULL, 'HEART SHAPED MIRROR', '84975');
INSERT INTO public.products VALUES (49, 1.40, 22, NULL, 3290, 2, NULL, NULL, 'RECTANGULAR SHAPED MIRROR', '84976');
INSERT INTO public.products VALUES (10, 1.25, 12, NULL, 3291, 2, NULL, NULL, 'WIRE FLOWER T-LIGHT HOLDER', '84977');
INSERT INTO public.products VALUES (1233, 1.47, 12, NULL, 3292, 2, NULL, NULL, 'HANGING HEART JAR T-LIGHT HOLDER', '84978');
INSERT INTO public.products VALUES (10, 4.65, 22, NULL, 3293, 2, NULL, NULL, 'GREEN PEONY CUSHION COVER', '84984A');
INSERT INTO public.products VALUES (10, 4.65, 22, NULL, 3294, 2, NULL, NULL, 'RED PEONY CUSHION COVER ', '84984B');
INSERT INTO public.products VALUES (10, 4.65, 22, NULL, 3295, 2, NULL, NULL, 'ORIENTAL RED CUSHION COVER ', '84984D');
INSERT INTO public.products VALUES (10, 1.45, 22, NULL, 3296, 2, NULL, NULL, 'SET OF 72 GREEN PAPER DOILIES', '84985A');
INSERT INTO public.products VALUES (303, 1.98, 22, NULL, 3297, 2, NULL, NULL, 'SET OF 36 TEATIME PAPER DOILIES', '84987');
INSERT INTO public.products VALUES (729, 2.14, 22, NULL, 3298, 2, NULL, NULL, 'SET OF 72 PINK HEART PAPER DOILIES', '84988');
INSERT INTO public.products VALUES (10, 0.55, 22, NULL, 3299, 2, NULL, NULL, '75 GREEN FAIRY CAKE CASES', '84989A');
INSERT INTO public.products VALUES (10, 2.09, 22, NULL, 3300, 2, NULL, NULL, '75 GREEN FAIRY CAKE CASES', '84989a');
INSERT INTO public.products VALUES (10, 0.55, 22, NULL, 3301, 2, NULL, NULL, '60 GOLD AND SILVER FAIRY CAKE CASES', '84990');
INSERT INTO public.products VALUES (1804, 0.69, 22, NULL, 3302, 2, NULL, NULL, '60 TEATIME FAIRY CAKE CASES', '84991');
INSERT INTO public.products VALUES (1323, 0.68, 22, NULL, 3303, 2, NULL, NULL, '72 SWEETHEART FAIRY CAKE CASES', '84992');
INSERT INTO public.products VALUES (34, 0.58, 22, NULL, 3304, 2, NULL, NULL, '75 GREEN PETIT FOUR CASES', '84993A');
INSERT INTO public.products VALUES (10, 0.42, 22, NULL, 3305, 2, NULL, NULL, '75 BLACK PETIT FOUR CASES', '84993B');
INSERT INTO public.products VALUES (10, 0.83, 22, NULL, 3306, 2, NULL, NULL, '75 GREEN PETIT FOUR CASES', '84993a');
INSERT INTO public.products VALUES (256, 4.45, 22, NULL, 3307, 2, NULL, NULL, 'GREEN 3 PIECE POLKADOT CUTLERY SET', '84997A');
INSERT INTO public.products VALUES (418, 4.37, 22, NULL, 3308, 2, NULL, NULL, 'RED 3 PIECE RETROSPOT CUTLERY SET', '84997B');
INSERT INTO public.products VALUES (303, 4.24, 22, NULL, 3309, 2, NULL, NULL, 'BLUE 3 PIECE POLKADOT CUTLERY SET', '84997C');
INSERT INTO public.products VALUES (507, 4.40, 22, NULL, 3310, 2, NULL, NULL, 'PINK 3 PIECE POLKADOT CUTLERY SET', '84997D');
INSERT INTO public.products VALUES (10, 8.29, 22, NULL, 3311, 2, NULL, NULL, 'GREEN 3 PIECE POLKADOT CUTLERY SET', '84997a');
INSERT INTO public.products VALUES (36, 8.58, 22, NULL, 3312, 2, NULL, NULL, 'RED 3 PIECE RETROSPOT CUTLERY SET', '84997b');
INSERT INTO public.products VALUES (28, 8.59, 22, NULL, 3313, 2, NULL, NULL, 'BLUE 3 PIECE POLKADOT CUTLERY SET', '84997c');
INSERT INTO public.products VALUES (31, 8.43, 22, NULL, 3314, 2, NULL, NULL, 'PINK 3 PIECE POLKADOT CUTLERY SET', '84997d');
INSERT INTO public.products VALUES (10, 1.55, 16, NULL, 3315, 2, NULL, NULL, 'SET 4 NURSERY DES ROUND BOXES', '85006');
INSERT INTO public.products VALUES (10, 5.17, 16, NULL, 3316, 2, NULL, NULL, 'SET OF 3 CONEY ISLAND OVAL BOXES', '85008');
INSERT INTO public.products VALUES (115, 6.48, 22, NULL, 3317, 2, NULL, NULL, 'BLACK/BLUE POLKADOT UMBRELLA', '85014A');
INSERT INTO public.products VALUES (191, 6.82, 22, NULL, 3318, 2, NULL, NULL, 'RED RETROSPOT UMBRELLA', '85014B');
INSERT INTO public.products VALUES (10, 12.52, 22, NULL, 3319, 2, NULL, NULL, 'BLACK/BLUE POLKADOT UMBRELLA', '85014a');
INSERT INTO public.products VALUES (10, 12.51, 22, NULL, 3320, 2, NULL, NULL, 'RED RETROSPOT UMBRELLA', '85014b');
INSERT INTO public.products VALUES (218, 1.31, 19, NULL, 3321, 2, NULL, NULL, 'SET OF 12  VINTAGE POSTCARD SET', '85015');
INSERT INTO public.products VALUES (56, 2.02, 22, NULL, 3322, 2, NULL, NULL, 'SET OF 6 VINTAGE NOTELETS KIT', '85016');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 3323, 2, NULL, NULL, 'ENVELOPE 50 ROMANTIC IMAGES', '85017A');
INSERT INTO public.products VALUES (106, 0.68, 22, NULL, 3324, 2, NULL, NULL, 'ENVELOPE 50 BLOSSOM IMAGES', '85017B');
INSERT INTO public.products VALUES (10, 0.54, 22, NULL, 3325, 2, NULL, NULL, 'ENVELOPE 50 CURIOUS IMAGES', '85017C');
INSERT INTO public.products VALUES (10, 2.55, 16, NULL, 3326, 2, NULL, NULL, 'YULETIDE IMAGES S/6 PAPER BOXES', '85018D');
INSERT INTO public.products VALUES (41, 2.03, 22, NULL, 3327, 2, NULL, NULL, 'ROMANTIC IMAGES NOTEBOOK SET', '85019A');
INSERT INTO public.products VALUES (52, 1.91, 22, NULL, 3328, 2, NULL, NULL, 'BLOSSOM  IMAGES NOTEBOOK SET', '85019B');
INSERT INTO public.products VALUES (10, 2.86, 22, NULL, 3329, 2, NULL, NULL, 'CURIOUS  IMAGES NOTEBOOK SET', '85019C');
INSERT INTO public.products VALUES (10, 2.57, 22, NULL, 3330, 2, NULL, NULL, 'ROUND PINK HEART MIRROR', '85020');
INSERT INTO public.products VALUES (10, 2.49, 15, NULL, 3331, 2, NULL, NULL, 'EAU DE NILE JEWELLED PHOTOFRAME', '85023B');
INSERT INTO public.products VALUES (10, 2.55, 15, NULL, 3332, 2, NULL, NULL, 'PINK LARGE JEWELED PHOTOFRAME', '85023C');
INSERT INTO public.products VALUES (19, 1.63, 15, NULL, 3333, 2, NULL, NULL, 'EAU DE NILE JEWELLED PHOTOFRAME', '85024B');
INSERT INTO public.products VALUES (10, 1.65, 15, NULL, 3334, 2, NULL, NULL, 'PINK SMALL JEWELLED PHOTOFRAME', '85024C');
INSERT INTO public.products VALUES (33, 2.30, 15, NULL, 3335, 2, NULL, NULL, 'EAU DE NILE HEART SHAPE PHOTO FRAME', '85025B');
INSERT INTO public.products VALUES (10, 1.99, 15, NULL, 3336, 2, NULL, NULL, 'PINK HEART SHAPE PHOTO FRAME', '85025C');
INSERT INTO public.products VALUES (10, 0.99, 12, NULL, 3337, 2, NULL, NULL, 'EAU DE NILE JEWELLED T-LIGHT HOLDER', '85026B');
INSERT INTO public.products VALUES (10, 2.90, 22, NULL, 3338, 2, NULL, NULL, 'FRENCH CHATEAU LARGE PLATTER ', '85027L');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 3339, 2, NULL, NULL, 'FRENCH CHATEAU LARGE FRUIT BOWL ', '85028L');
INSERT INTO public.products VALUES (10, 2.02, 22, NULL, 3340, 2, NULL, NULL, 'FRENCH CHATEAU SMALL FRUITBOWL', '85028S');
INSERT INTO public.products VALUES (10, 1.95, 22, NULL, 3341, 2, NULL, NULL, 'FRENCH CHATEAU OVAL PLATTER', '85030');
INSERT INTO public.products VALUES (10, 3.89, 22, NULL, 3342, 2, NULL, NULL, 'ROMANTIC IMAGES SCRAP BOOK SET', '85031A');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 3343, 2, NULL, NULL, 'BLOSSOM IMAGES SCRAP BOOK SET', '85031B');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 3344, 2, NULL, NULL, 'CURIOUS IMAGES SCRAP BOOK SET', '85031C');
INSERT INTO public.products VALUES (79, 1.09, 19, NULL, 3345, 2, NULL, NULL, 'ROMANTIC IMAGES GIFT WRAP SET', '85032A');
INSERT INTO public.products VALUES (79, 1.07, 19, NULL, 3346, 2, NULL, NULL, 'BLOSSOM IMAGES GIFT WRAP SET', '85032B');
INSERT INTO public.products VALUES (67, 1.18, 19, NULL, 3347, 2, NULL, NULL, 'CURIOUS IMAGES GIFT WRAP SET', '85032C');
INSERT INTO public.products VALUES (67, 1.14, 19, NULL, 3348, 2, NULL, NULL, 'YULETIDE IMAGES GIFT WRAP SET', '85032D');
INSERT INTO public.products VALUES (43, 2.67, 12, NULL, 3349, 2, NULL, NULL, '3 GARDENIA MORRIS BOXED CANDLES', '85034A');
INSERT INTO public.products VALUES (94, 2.70, 12, NULL, 3350, 2, NULL, NULL, '3 WHITE CHOC MORRIS BOXED CANDLES', '85034B');
INSERT INTO public.products VALUES (111, 2.28, 12, NULL, 3351, 2, NULL, NULL, '3 ROSE MORRIS BOXED CANDLES', '85034C');
INSERT INTO public.products VALUES (10, 8.29, 12, NULL, 3352, 2, NULL, NULL, '3 GARDENIA MORRIS BOXED CANDLES', '85034a');
INSERT INTO public.products VALUES (10, 8.29, 12, NULL, 3353, 2, NULL, NULL, '3 WHITE CHOC MORRIS BOXED CANDLES', '85034b');
INSERT INTO public.products VALUES (21, 3.78, 12, NULL, 3354, 2, NULL, NULL, 'GARDENIA 3 WICK MORRIS BOXED CANDLE', '85035A');
INSERT INTO public.products VALUES (58, 3.27, 12, NULL, 3355, 2, NULL, NULL, 'CHOCOLATE 3 WICK MORRIS BOX CANDLE', '85035B');
INSERT INTO public.products VALUES (112, 2.47, 12, NULL, 3356, 2, NULL, NULL, 'ROSE 3 WICK MORRIS BOX CANDLE', '85035C');
INSERT INTO public.products VALUES (10, 8.47, 12, NULL, 3357, 2, NULL, NULL, 'GARDENIA 3 WICK MORRIS BOXED CANDLE', '85035a');
INSERT INTO public.products VALUES (10, 8.47, 12, NULL, 3358, 2, NULL, NULL, 'CHOCOLATE 3 WICK MORRIS BOX CANDLE', '85035b');
INSERT INTO public.products VALUES (10, 8.47, 12, NULL, 3359, 2, NULL, NULL, 'ROSE 3 WICK MORRIS BOX CANDLE', '85035c');
INSERT INTO public.products VALUES (22, 3.86, 12, NULL, 3360, 2, NULL, NULL, 'GARDENIA 1 WICK MORRIS BOXED CANDLE', '85036A');
INSERT INTO public.products VALUES (10, 2.17, 12, NULL, 3361, 2, NULL, NULL, 'CHOCOLATE 1 WICK MORRIS BOX CANDLE', '85036B');
INSERT INTO public.products VALUES (10, 2.34, 12, NULL, 3362, 2, NULL, NULL, 'ROSE 1 WICK MORRIS BOXED CANDLE', '85036C');
INSERT INTO public.products VALUES (10, 8.29, 12, NULL, 3363, 2, NULL, NULL, 'GARDENIA 1 WICK MORRIS BOXED CANDLE', '85036a');
INSERT INTO public.products VALUES (10, 8.47, 12, NULL, 3364, 2, NULL, NULL, 'CHOCOLATE 1 WICK MORRIS BOX CANDLE', '85036b');
INSERT INTO public.products VALUES (106, 2.53, 12, NULL, 3365, 2, NULL, NULL, '6 CHOCOLATE LOVE HEART T-LIGHTS', '85038');
INSERT INTO public.products VALUES (70, 1.63, 12, NULL, 3366, 2, NULL, NULL, 'SET/4 RED MINI ROSE CANDLE IN BOWL', '85039A');
INSERT INTO public.products VALUES (80, 1.62, 12, NULL, 3367, 2, NULL, NULL, 'S/4 IVORY MINI ROSE CANDLE IN BOWL', '85039B');
INSERT INTO public.products VALUES (30, 1.59, 12, NULL, 3368, 2, NULL, NULL, 'S/4 BLACK MINI ROSE CANDLE IN BOWL', '85039C');
INSERT INTO public.products VALUES (10, 3.30, 12, NULL, 3369, 2, NULL, NULL, 'SET/4 RED MINI ROSE CANDLE IN BOWL', '85039a');
INSERT INTO public.products VALUES (87, 2.02, 12, NULL, 3370, 2, NULL, NULL, 'S/4 PINK FLOWER CANDLES IN BOWL', '85040A');
INSERT INTO public.products VALUES (13, 1.69, 12, NULL, 3371, 2, NULL, NULL, 'SET/4 BLUE FLOWER CANDLES IN BOWL', '85040B');
INSERT INTO public.products VALUES (10, 3.29, 12, NULL, 3372, 2, NULL, NULL, 'S/4 PINK FLOWER CANDLES IN BOWL', '85040a');
INSERT INTO public.products VALUES (10, 4.95, 12, NULL, 3373, 2, NULL, NULL, 'ANTIQUE LILY FAIRY LIGHTS', '85042');
INSERT INTO public.products VALUES (10, 4.89, 12, NULL, 3374, 2, NULL, NULL, 'GREEN CHRISTMAS TREE STRING 20LIGHT', '85045');
INSERT INTO public.products VALUES (10, 6.15, 12, NULL, 3375, 2, NULL, NULL, 'WHITE BEADED GARLAND STRING 20LIGHT', '85047');
INSERT INTO public.products VALUES (131, 9.18, 12, NULL, 3376, 2, NULL, NULL, '15CM CHRISTMAS GLASS BALL 20 LIGHTS', '85048');
INSERT INTO public.products VALUES (299, 1.49, 17, NULL, 3377, 2, NULL, NULL, 'TRADITIONAL CHRISTMAS RIBBONS', '85049A');
INSERT INTO public.products VALUES (10, 1.16, 19, NULL, 3378, 2, NULL, NULL, 'LUSH GREENS RIBBONS', '85049B');
INSERT INTO public.products VALUES (121, 1.35, 19, NULL, 3379, 2, NULL, NULL, 'ROMANTIC PINKS RIBBONS ', '85049C');
INSERT INTO public.products VALUES (44, 1.28, 19, NULL, 3380, 2, NULL, NULL, 'BRIGHT BLUES RIBBONS ', '85049D');
INSERT INTO public.products VALUES (285, 1.49, 19, NULL, 3381, 2, NULL, NULL, 'SCANDINAVIAN REDS RIBBONS', '85049E');
INSERT INTO public.products VALUES (37, 1.29, 19, NULL, 3382, 2, NULL, NULL, 'BABY BOOM RIBBONS ', '85049F');
INSERT INTO public.products VALUES (160, 1.40, 16, NULL, 3383, 2, NULL, NULL, 'CHOCOLATE BOX RIBBONS ', '85049G');
INSERT INTO public.products VALUES (84, 1.06, 19, NULL, 3384, 2, NULL, NULL, 'URBAN BLACK RIBBONS ', '85049H');
INSERT INTO public.products VALUES (24, 3.30, 17, NULL, 3385, 2, NULL, NULL, 'TRADITIONAL CHRISTMAS RIBBONS', '85049a');
INSERT INTO public.products VALUES (10, 2.46, 19, NULL, 3386, 2, NULL, NULL, 'LUSH GREENS RIBBONS', '85049b');
INSERT INTO public.products VALUES (10, 2.46, 19, NULL, 3387, 2, NULL, NULL, 'ROMANTIC PINKS RIBBONS ', '85049c');
INSERT INTO public.products VALUES (10, 2.46, 19, NULL, 3388, 2, NULL, NULL, 'BRIGHT BLUES RIBBONS ', '85049d');
INSERT INTO public.products VALUES (10, 3.30, 19, NULL, 3389, 2, NULL, NULL, 'SCANDINAVIAN REDS RIBBONS', '85049e');
INSERT INTO public.products VALUES (11, 2.43, 16, NULL, 3390, 2, NULL, NULL, 'CHOCOLATE BOX RIBBONS ', '85049g');
INSERT INTO public.products VALUES (167, 2.58, 12, NULL, 3391, 2, NULL, NULL, 'FRENCH ENAMEL CANDLEHOLDER', '85053');
INSERT INTO public.products VALUES (57, 3.40, 22, NULL, 3392, 2, NULL, NULL, 'FRENCH ENAMEL POT W LID', '85054');
INSERT INTO public.products VALUES (10, 5.15, 22, NULL, 3393, 2, NULL, NULL, 'FRENCH ENAMEL UTENSIL HOLDER', '85055');
INSERT INTO public.products VALUES (40, 4.09, 22, NULL, 3394, 2, NULL, NULL, 'FRENCH ENAMEL WATER BASIN', '85059');
INSERT INTO public.products VALUES (215, 1.09, 22, NULL, 3395, 2, NULL, NULL, 'WHITE JEWELLED HEART DECORATION', '85061W');
INSERT INTO public.products VALUES (147, 1.79, 12, NULL, 3396, 2, NULL, NULL, 'PEARL CRYSTAL PUMPKIN T-LIGHT HLDR', '85062');
INSERT INTO public.products VALUES (10, 15.95, 22, NULL, 3397, 2, NULL, NULL, 'CREAM SWEETHEART MAGAZINE RACK', '85063');
INSERT INTO public.products VALUES (21, 6.37, 21, NULL, 3398, 2, NULL, NULL, 'CREAM SWEETHEART LETTER RACK', '85064');
INSERT INTO public.products VALUES (10, 12.75, 22, NULL, 3399, 2, NULL, NULL, 'CREAM SWEETHEART TRAYS', '85065');
INSERT INTO public.products VALUES (175, 14.19, 22, NULL, 3400, 2, NULL, NULL, 'CREAM SWEETHEART MINI CHEST', '85066');
INSERT INTO public.products VALUES (10, 18.55, 22, NULL, 3401, 2, NULL, NULL, 'CREAM SWEETHEART WALL CABINET', '85067');
INSERT INTO public.products VALUES (10, 7.95, 22, NULL, 3402, 2, NULL, NULL, 'CREAM SWEETHEART SHELF + HOOKS', '85068');
INSERT INTO public.products VALUES (88, 0.92, 21, NULL, 3403, 2, NULL, NULL, 'BLUE CHARLIE+LOLA PERSONAL DOORSIGN', '85071A');
INSERT INTO public.products VALUES (129, 0.89, 21, NULL, 3404, 2, NULL, NULL, 'RED CHARLIE+LOLA PERSONAL DOORSIGN', '85071B');
INSERT INTO public.products VALUES (68, 1.25, 21, NULL, 3405, 2, NULL, NULL, 'CHARLIE+LOLA"EXTREMELY BUSY" SIGN', '85071C');
INSERT INTO public.products VALUES (40, 0.83, 21, NULL, 3406, 2, NULL, NULL, 'CHARLIE+LOLA MY ROOM DOOR SIGN', '85071D');
INSERT INTO public.products VALUES (109, 0.99, 22, NULL, 3407, 2, NULL, NULL, 'SCANDINAVIAN 3 HEARTS NAPKIN RING', '85078');
INSERT INTO public.products VALUES (10, 0.85, 17, NULL, 3408, 2, NULL, NULL, 'HOLLY TOP CHRISTMAS STOCKING', '85084');
INSERT INTO public.products VALUES (14, 0.83, 22, NULL, 3409, 2, NULL, NULL, 'CANDY SPOT HEART DECORATION', '85086A');
INSERT INTO public.products VALUES (33, 3.48, 22, NULL, 3410, 2, NULL, NULL, 'CANDY SPOT CUSHION COVER', '85087');
INSERT INTO public.products VALUES (25, 2.38, 13, NULL, 3411, 2, NULL, NULL, 'CANDY SPOT HAND BAG', '85088');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3412, 2, NULL, NULL, 'CANDY SPOT BUNNY', '85089');
INSERT INTO public.products VALUES (10, 2.30, 22, NULL, 3413, 2, NULL, NULL, 'CANDY SPOT TEA COSY', '85092');
INSERT INTO public.products VALUES (70, 0.89, 22, NULL, 3414, 2, NULL, NULL, 'CANDY SPOT EGG WARMER HARE', '85093');
INSERT INTO public.products VALUES (64, 0.69, 22, NULL, 3415, 2, NULL, NULL, 'CANDY SPOT EGG WARMER RABBIT', '85094');
INSERT INTO public.products VALUES (15, 1.82, 22, NULL, 3416, 2, NULL, NULL, 'THREE CANVAS LUGGAGE TAGS', '85095');
INSERT INTO public.products VALUES (10, 4.40, 22, NULL, 3417, 2, NULL, NULL, 'HILDA CANDY SPOT RABBIT', '85096');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 3418, 2, NULL, NULL, 'BLUE FLYING SINGING CANARY', '85098B');
INSERT INTO public.products VALUES (4736, 2.47, 13, NULL, 3419, 2, NULL, NULL, 'JUMBO BAG RED RETROSPOT', '85099B');
INSERT INTO public.products VALUES (1364, 2.59, 13, NULL, 3420, 2, NULL, NULL, 'JUMBO  BAG BAROQUE BLACK WHITE', '85099C');
INSERT INTO public.products VALUES (1702, 2.36, 13, NULL, 3421, 2, NULL, NULL, 'JUMBO BAG STRAWBERRY', '85099F');
INSERT INTO public.products VALUES (10, 5.05, 13, NULL, 3422, 2, NULL, NULL, 'JUMBO BAG STRAWBERRY', '85099f');
INSERT INTO public.products VALUES (10, 7.00, 12, NULL, 3423, 2, NULL, NULL, 'SILVER T-LIGHT SETTING', '85103');
INSERT INTO public.products VALUES (10, 3.04, 12, NULL, 3424, 2, NULL, NULL, 'SILVER GLASS T-LIGHT SET', '85104');
INSERT INTO public.products VALUES (65, 2.27, 12, NULL, 3425, 2, NULL, NULL, 'CUT GLASS HEXAGON T-LIGHT HOLDER', '85106');
INSERT INTO public.products VALUES (62, 2.44, 12, NULL, 3426, 2, NULL, NULL, 'CUT GLASS T-LIGHT HOLDER OCTAGON', '85107');
INSERT INTO public.products VALUES (10, 0.85, 12, NULL, 3427, 2, NULL, NULL, 'PINK BOUDOIR T-LIGHT HOLDER', '85109');
INSERT INTO public.products VALUES (130, 0.48, 22, NULL, 3428, 2, NULL, NULL, 'SILVER GLITTER FLOWER VOTIVE HOLDER', '85111');
INSERT INTO public.products VALUES (64, 2.05, 22, NULL, 3429, 2, NULL, NULL, 'BLACK ENCHANTED FOREST PLACEMAT', '85114A');
INSERT INTO public.products VALUES (47, 2.19, 22, NULL, 3430, 2, NULL, NULL, 'IVORY ENCHANTED FOREST PLACEMAT', '85114B');
INSERT INTO public.products VALUES (51, 1.94, 22, NULL, 3431, 2, NULL, NULL, 'RED ENCHANTED FOREST PLACEMAT', '85114C');
INSERT INTO public.products VALUES (10, 3.30, 22, NULL, 3432, 2, NULL, NULL, 'BLACK ENCHANTED FOREST PLACEMAT', '85114a');
INSERT INTO public.products VALUES (10, 3.30, 22, NULL, 3433, 2, NULL, NULL, 'IVORY ENCHANTED FOREST PLACEMAT', '85114b');
INSERT INTO public.products VALUES (16, 3.30, 22, NULL, 3434, 2, NULL, NULL, 'RED ENCHANTED FOREST PLACEMAT', '85114c');
INSERT INTO public.products VALUES (10, 8.29, 22, NULL, 3435, 2, NULL, NULL, 'S/4 BLACK DISCO PARTITION PANEL', '85115B');
INSERT INTO public.products VALUES (91, 1.48, 12, NULL, 3436, 2, NULL, NULL, 'BLACK CANDELABRA T-LIGHT HOLDER', '85116');
INSERT INTO public.products VALUES (13, 1.49, 12, NULL, 3437, 2, NULL, NULL, 'HEART T-LIGHT HOLDER', '85118');
INSERT INTO public.products VALUES (10, 3.36, 22, NULL, 3438, 2, NULL, NULL, 'WATERING CAN SINGLE HOOK PISTACHIO', '85119');
INSERT INTO public.products VALUES (3883, 3.10, 12, NULL, 3439, 2, NULL, NULL, 'WHITE HANGING HEART T-LIGHT HOLDER', '85123A');
INSERT INTO public.products VALUES (29, 6.64, 12, NULL, 3440, 2, NULL, NULL, 'WHITE HANGING HEART T-LIGHT HOLDER', '85123a');
INSERT INTO public.products VALUES (10, 3.16, 15, NULL, 3441, 2, NULL, NULL, 'BLUE JUICY FRUIT PHOTO FRAME', '85124B');
INSERT INTO public.products VALUES (10, 2.99, 15, NULL, 3442, 2, NULL, NULL, 'GREEN JUICY FRUIT PHOTO FRAME', '85124C');
INSERT INTO public.products VALUES (10, 5.05, 12, NULL, 3443, 2, NULL, NULL, 'SMALL ROUND CUT GLASS CANDLESTICK', '85125');
INSERT INTO public.products VALUES (10, 10.16, 12, NULL, 3444, 2, NULL, NULL, 'LARGE ROUND CUTGLASS CANDLESTICK', '85126');
INSERT INTO public.products VALUES (18, 6.76, 12, NULL, 3445, 2, NULL, NULL, 'SMALL SQUARE CUT GLASS CANDLESTICK', '85127');
INSERT INTO public.products VALUES (11, 1.91, 22, NULL, 3446, 2, NULL, NULL, 'BEADED CRYSTAL HEART GREEN SMALL', '85129B');
INSERT INTO public.products VALUES (10, 1.74, 22, NULL, 3447, 2, NULL, NULL, 'BEADED CRYSTAL HEART BLUE SMALL', '85129C');
INSERT INTO public.products VALUES (20, 1.93, 22, NULL, 3448, 2, NULL, NULL, 'BEADED CRYSTAL HEART PINK SMALL', '85129D');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 3449, 2, NULL, NULL, 'BEADED PEARL HEART WHITE LARGE', '85130A');
INSERT INTO public.products VALUES (83, 1.38, 22, NULL, 3450, 2, NULL, NULL, 'BEADED CRYSTAL HEART GREEN LARGE', '85130B');
INSERT INTO public.products VALUES (48, 1.09, 22, NULL, 3451, 2, NULL, NULL, 'BEADED CRYSTAL HEART BLUE  LARGE', '85130C');
INSERT INTO public.products VALUES (56, 1.50, 22, NULL, 3452, 2, NULL, NULL, 'BEADED CRYSTAL HEART PINK LARGE', '85130D');
INSERT INTO public.products VALUES (98, 0.92, 22, NULL, 3453, 2, NULL, NULL, 'BEADED PEARL HEART WHITE ON STICK', '85131A');
INSERT INTO public.products VALUES (62, 0.84, 22, NULL, 3454, 2, NULL, NULL, 'BEADED CRYSTAL HEART GREEN ON STICK', '85131B');
INSERT INTO public.products VALUES (19, 0.87, 22, NULL, 3455, 2, NULL, NULL, 'BEADED CRYSTAL HEART BLUE ON STICK', '85131C');
INSERT INTO public.products VALUES (85, 0.84, 22, NULL, 3456, 2, NULL, NULL, 'BEADED CRYSTAL HEART PINK ON STICK', '85131D');
INSERT INTO public.products VALUES (44, 4.99, 16, NULL, 3457, 2, NULL, NULL, 'CHARLIE + LOLA BISCUITS TINS', '85132A');
INSERT INTO public.products VALUES (52, 3.53, 16, NULL, 3458, 2, NULL, NULL, 'CHARLIE AND LOLA TABLE TINS', '85132B');
INSERT INTO public.products VALUES (140, 3.93, 16, NULL, 3459, 2, NULL, NULL, 'CHARLIE AND LOLA FIGURES TINS', '85132C');
INSERT INTO public.products VALUES (10, 11.52, 16, NULL, 3460, 2, NULL, NULL, 'CHARLIE + LOLA BISCUITS TINS', '85132a');
INSERT INTO public.products VALUES (10, 8.29, 16, NULL, 3461, 2, NULL, NULL, 'CHARLIE AND LOLA TABLE TINS', '85132b');
INSERT INTO public.products VALUES (10, 8.29, 16, NULL, 3462, 2, NULL, NULL, 'CHARLIE AND LOLA FIGURES TINS', '85132c');
INSERT INTO public.products VALUES (10, 7.95, 22, NULL, 3463, 2, NULL, NULL, 'YELLOW DRAGONFLY HELICOPTER', '85135A');
INSERT INTO public.products VALUES (12, 7.72, 22, NULL, 3464, 2, NULL, NULL, 'BLUE DRAGONFLY HELICOPTER', '85135B');
INSERT INTO public.products VALUES (10, 7.85, 22, NULL, 3465, 2, NULL, NULL, 'RED DRAGONFLY HELICOPTER', '85135C');
INSERT INTO public.products VALUES (10, 7.90, 22, NULL, 3466, 2, NULL, NULL, 'YELLOW SHARK HELICOPTER', '85136A');
INSERT INTO public.products VALUES (10, 7.95, 22, NULL, 3467, 2, NULL, NULL, 'BLUE SHARK HELICOPTER', '85136B');
INSERT INTO public.products VALUES (10, 7.86, 22, NULL, 3468, 2, NULL, NULL, 'RED SHARK HELICOPTER', '85136C');
INSERT INTO public.products VALUES (11, 5.59, 14, NULL, 3469, 2, NULL, NULL, 'JARDIN ETCHED GLASS FRUITBOWL', '85141');
INSERT INTO public.products VALUES (22, 3.88, 14, NULL, 3470, 2, NULL, NULL, 'JARDIN ETCHED GLASS BUTTER DISH', '85144');
INSERT INTO public.products VALUES (10, 5.21, 14, NULL, 3471, 2, NULL, NULL, 'JARDIN ETCHED GLASS LARGE BELL JAR', '85145');
INSERT INTO public.products VALUES (10, 4.42, 14, NULL, 3472, 2, NULL, NULL, 'JARDIN ETCHED GLASS SMALL BELL JAR', '85146');
INSERT INTO public.products VALUES (403, 3.07, 21, NULL, 3473, 2, NULL, NULL, 'LADIES & GENTLEMEN METAL SIGN', '85150');
INSERT INTO public.products VALUES (819, 2.35, 21, NULL, 3474, 2, NULL, NULL, 'HAND OVER THE CHOCOLATE   SIGN ', '85152');
INSERT INTO public.products VALUES (41, 2.05, 16, NULL, 3475, 2, NULL, NULL, 'BLACK TEA,COFFEE,SUGAR JARS', '85159A');
INSERT INTO public.products VALUES (58, 2.15, 16, NULL, 3476, 2, NULL, NULL, 'WHITE TEA,COFFEE,SUGAR JARS', '85159B');
INSERT INTO public.products VALUES (10, 1.25, 14, NULL, 3477, 2, NULL, NULL, 'WHITE BIRD GARDEN DESIGN MUG', '85160A');
INSERT INTO public.products VALUES (10, 1.31, 14, NULL, 3478, 2, NULL, NULL, 'BLACK BIRD GARDEN DESIGN MUG', '85160B');
INSERT INTO public.products VALUES (10, 16.13, 14, NULL, 3479, 2, NULL, NULL, 'WHITE BIRD GARDEN DESIGN MUG', '85160a');
INSERT INTO public.products VALUES (10, 17.13, 22, NULL, 3480, 2, NULL, NULL, 'ACRYLIC GEOMETRIC LAMP', '85161');
INSERT INTO public.products VALUES (10, 11.21, 18, NULL, 3481, 2, NULL, NULL, 'WHITE BAROQUE WALL CLOCK ', '85163A');
INSERT INTO public.products VALUES (10, 12.72, 18, NULL, 3482, 2, NULL, NULL, 'BLACK BAROQUE WALL CLOCK ', '85163B');
INSERT INTO public.products VALUES (10, 3.58, 15, NULL, 3483, 2, NULL, NULL, 'BLACK GRAND BAROQUE PHOTO FRAME', '85167B');
INSERT INTO public.products VALUES (10, 8.48, 18, NULL, 3484, 2, NULL, NULL, 'BLACK BAROQUE CARRIAGE CLOCK', '85168B');
INSERT INTO public.products VALUES (80, 1.32, 12, NULL, 3485, 2, NULL, NULL, 'IVORY LOVE BIRD CANDLE', '85169A');
INSERT INTO public.products VALUES (32, 1.44, 12, NULL, 3486, 2, NULL, NULL, 'BLACK LOVE BIRD CANDLE', '85169B');
INSERT INTO public.products VALUES (41, 1.22, 12, NULL, 3487, 2, NULL, NULL, 'EAU DE NIL LOVE BIRD CANDLE', '85169C');
INSERT INTO public.products VALUES (35, 1.31, 12, NULL, 3488, 2, NULL, NULL, 'PINK LOVE BIRD CANDLE', '85169D');
INSERT INTO public.products VALUES (10, 2.10, 12, NULL, 3489, 2, NULL, NULL, 'SET/6 IVORY BIRD T-LIGHT CANDLES', '85170A');
INSERT INTO public.products VALUES (21, 2.39, 12, NULL, 3490, 2, NULL, NULL, 'SET/6 BLACK BIRD T-LIGHT CANDLES', '85170B');
INSERT INTO public.products VALUES (33, 2.69, 12, NULL, 3491, 2, NULL, NULL, 'SET/6 EAU DE NIL BIRD T-LIGHTS', '85170C');
INSERT INTO public.products VALUES (44, 2.71, 12, NULL, 3492, 2, NULL, NULL, 'SET/6 PINK BIRD T-LIGHT CANDLES', '85170D');
INSERT INTO public.products VALUES (10, 0.62, 12, NULL, 3493, 2, NULL, NULL, 'HYACINTH BULB T-LIGHT CANDLES', '85172');
INSERT INTO public.products VALUES (47, 2.90, 12, NULL, 3494, 2, NULL, NULL, 'SET/6 FROG PRINCE T-LIGHT CANDLES', '85173');
INSERT INTO public.products VALUES (61, 6.94, 12, NULL, 3495, 2, NULL, NULL, 'S/4 CACTI CANDLES', '85174');
INSERT INTO public.products VALUES (248, 0.93, 12, NULL, 3496, 2, NULL, NULL, 'CACTI T-LIGHT CANDLES', '85175');
INSERT INTO public.products VALUES (91, 1.20, 22, NULL, 3497, 2, NULL, NULL, 'SEWING SUSAN 21 NEEDLE SET', '85176');
INSERT INTO public.products VALUES (81, 1.03, 16, NULL, 3498, 2, NULL, NULL, 'BASKET OF FLOWERS SEWING KIT', '85177');
INSERT INTO public.products VALUES (223, 1.39, 22, NULL, 3499, 2, NULL, NULL, 'VICTORIAN SEWING KIT', '85178');
INSERT INTO public.products VALUES (19, 2.83, 12, NULL, 3500, 2, NULL, NULL, 'GREEN BITTY LIGHT CHAIN', '85179A');
INSERT INTO public.products VALUES (10, 2.89, 12, NULL, 3501, 2, NULL, NULL, 'PINK BITTY LIGHT CHAIN', '85179C');
INSERT INTO public.products VALUES (10, 2.46, 12, NULL, 3502, 2, NULL, NULL, 'GREEN BITTY LIGHT CHAIN', '85179a');
INSERT INTO public.products VALUES (49, 3.16, 12, NULL, 3503, 2, NULL, NULL, 'RED HEARTS LIGHT CHAIN ', '85180A');
INSERT INTO public.products VALUES (27, 3.28, 12, NULL, 3504, 2, NULL, NULL, 'PINK HEARTS LIGHT CHAIN ', '85180B');
INSERT INTO public.products VALUES (66, 1.56, 22, NULL, 3505, 2, NULL, NULL, 'CHARLIE & LOLA WASTEPAPER BIN BLUE', '85183A');
INSERT INTO public.products VALUES (99, 1.88, 22, NULL, 3506, 2, NULL, NULL, 'CHARLIE & LOLA WASTEPAPER BIN FLORA', '85183B');
INSERT INTO public.products VALUES (165, 3.17, 16, NULL, 3507, 2, NULL, NULL, 'S/4 VALENTINE DECOUPAGE HEART BOX', '85184C');
INSERT INTO public.products VALUES (10, 5.79, 16, NULL, 3508, 2, NULL, NULL, 'SET 4 VALENTINE DECOUPAGE HEART BOX', '85184c');
INSERT INTO public.products VALUES (10, 3.29, 22, NULL, 3509, 2, NULL, NULL, 'PINK HORSE SOCK PUPPET', '85185B');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3510, 2, NULL, NULL, 'FROG SOCK PUPPET', '85185D');
INSERT INTO public.products VALUES (61, 0.63, 22, NULL, 3511, 2, NULL, NULL, 'EASTER BUNNY GARLAND OF FLOWERS', '85186A');
INSERT INTO public.products VALUES (50, 0.65, 22, NULL, 3512, 2, NULL, NULL, 'BUNNY EGG GARLAND', '85186C');
INSERT INTO public.products VALUES (33, 1.88, 22, NULL, 3513, 2, NULL, NULL, 'S/12 MINI RABBIT EASTER', '85187');
INSERT INTO public.products VALUES (31, 0.98, 22, NULL, 3514, 2, NULL, NULL, 'GREEN METAL SWINGING BUNNY', '85188A');
INSERT INTO public.products VALUES (10, 1.01, 22, NULL, 3515, 2, NULL, NULL, 'PINK METAL SWINGING BUNNY', '85188B');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 3516, 2, NULL, NULL, 'HANGING BUTTERFLY  EGG', '85189');
INSERT INTO public.products VALUES (92, 1.02, 22, NULL, 3517, 2, NULL, NULL, 'HANGING SPRING FLOWER EGG LARGE', '85194L');
INSERT INTO public.products VALUES (116, 0.64, 22, NULL, 3518, 2, NULL, NULL, 'HANGING SPRING FLOWER EGG SMALL', '85194S');
INSERT INTO public.products VALUES (10, 2.10, 16, NULL, 3519, 2, NULL, NULL, 'HANGING HEART BASKET', '85195');
INSERT INTO public.products VALUES (10, 2.10, 22, NULL, 3520, 2, NULL, NULL, 'SET OF 12 MINI BUNNIES IN A BUCKET', '85197');
INSERT INTO public.products VALUES (10, 1.09, 22, NULL, 3521, 2, NULL, NULL, 'ASSORTED FARMYARD ANIMALS IN BUCKET', '85198');
INSERT INTO public.products VALUES (71, 0.83, 22, NULL, 3522, 2, NULL, NULL, 'LARGE HANGING IVORY & RED WOOD BIRD', '85199L');
INSERT INTO public.products VALUES (264, 0.59, 22, NULL, 3523, 2, NULL, NULL, 'SMALL HANGING IVORY/RED WOOD BIRD', '85199S');
INSERT INTO public.products VALUES (18, 1.25, 16, NULL, 3524, 2, NULL, NULL, 'BUNNY EGG BOX', '85200');
INSERT INTO public.products VALUES (67, 0.54, 22, NULL, 3525, 2, NULL, NULL, 'HANGING WOOD AND FELT HEART', '85202');
INSERT INTO public.products VALUES (89, 0.57, 22, NULL, 3526, 2, NULL, NULL, 'HANGING WOOD AND FELT BUTTERFLY ', '85203');
INSERT INTO public.products VALUES (92, 0.33, 22, NULL, 3527, 2, NULL, NULL, 'HANGING WOOD AND FELT FLOWER', '85204');
INSERT INTO public.products VALUES (12, 2.87, 22, NULL, 3528, 2, NULL, NULL, 'PINK FELT EASTER RABBIT GARLAND', '85205B');
INSERT INTO public.products VALUES (97, 1.76, 16, NULL, 3529, 2, NULL, NULL, 'CREAM FELT EASTER EGG BASKET', '85206A');
INSERT INTO public.products VALUES (10, 1.65, 16, NULL, 3530, 2, NULL, NULL, 'PINK FELT EASTER EGG BASKET', '85206B');
INSERT INTO public.products VALUES (20, 2.03, 13, NULL, 3531, 2, NULL, NULL, 'SET/12 FUNKY FELT FLOWER PEG IN BAG', '85208');
INSERT INTO public.products VALUES (14, 1.76, 22, NULL, 3532, 2, NULL, NULL, 'S/4 GROOVY CAT MAGNETS', '85211');
INSERT INTO public.products VALUES (247, 0.51, 22, NULL, 3533, 2, NULL, NULL, 'MINI PAINTED GARDEN DECORATION ', '85212');
INSERT INTO public.products VALUES (84, 0.81, 22, NULL, 3534, 2, NULL, NULL, 'MINI  ZINC GARDEN DECORATIONS ', '85213');
INSERT INTO public.products VALUES (16, 1.67, 22, NULL, 3535, 2, NULL, NULL, 'TUB 24 PINK FLOWER PEGS', '85214');
INSERT INTO public.products VALUES (19, 0.93, 22, NULL, 3536, 2, NULL, NULL, 'ASSORTED CHEESE FRIDGE MAGNETS', '85215');
INSERT INTO public.products VALUES (10, 0.65, 22, NULL, 3537, 2, NULL, NULL, 'ASSORTED CAKES FRIDGE MAGNETS', '85216');
INSERT INTO public.products VALUES (10, 2.10, 14, NULL, 3538, 2, NULL, NULL, 'ASSORTED COLOUR SILK GLASSES CASE', '85224');
INSERT INTO public.products VALUES (10, 1.08, 22, NULL, 3539, 2, NULL, NULL, 'BLING KEY RING STAND', '85225');
INSERT INTO public.products VALUES (148, 1.11, 19, NULL, 3540, 2, NULL, NULL, 'SET OF 6 3D KIT CARDS FOR KIDS', '85227');
INSERT INTO public.products VALUES (84, 0.26, 12, NULL, 3541, 2, NULL, NULL, 'OPIUM SCENTED VOTIVE CANDLE', '85230A');
INSERT INTO public.products VALUES (128, 0.28, 12, NULL, 3542, 2, NULL, NULL, 'CINNAMON SCENTED VOTIVE CANDLE', '85230B');
INSERT INTO public.products VALUES (105, 0.26, 12, NULL, 3543, 2, NULL, NULL, 'STRAWBRY SCENTED VOTIVE CANDLE', '85230E');
INSERT INTO public.products VALUES (33, 0.28, 12, NULL, 3544, 2, NULL, NULL, 'JASMINE VOTIVE CANDLE', '85230F');
INSERT INTO public.products VALUES (98, 0.27, 12, NULL, 3545, 2, NULL, NULL, 'ORANGE VOTIVE CANDLE', '85230G');
INSERT INTO public.products VALUES (85, 1.07, 12, NULL, 3546, 2, NULL, NULL, 'CINAMMON SET OF 9 T-LIGHTS', '85231B');
INSERT INTO public.products VALUES (47, 0.97, 12, NULL, 3547, 2, NULL, NULL, 'ORANGE SCENTED SET/9 T-LIGHTS', '85231G');
INSERT INTO public.products VALUES (10, 1.64, 12, NULL, 3548, 2, NULL, NULL, 'CINAMMON SET OF 9 T-LIGHTS', '85231b');
INSERT INTO public.products VALUES (10, 1.63, 12, NULL, 3549, 2, NULL, NULL, 'ORANGE SCENTED SET/9 T-LIGHTS', '85231g');
INSERT INTO public.products VALUES (10, 5.60, 16, NULL, 3550, 2, NULL, NULL, 'SET/3 POLKADOT STACKING TINS', '85232A');
INSERT INTO public.products VALUES (10, 4.88, 16, NULL, 3551, 2, NULL, NULL, 'SET OF 3 BABUSHKA STACKING TINS', '85232B');
INSERT INTO public.products VALUES (10, 5.84, 16, NULL, 3552, 2, NULL, NULL, 'SET/3 DECOUPAGE STACKING TINS', '85232D');
INSERT INTO public.products VALUES (10, 6.02, 22, NULL, 3553, 2, NULL, NULL, 'RASPBERRY ANT COPPER FLOWER NECKLAC', '90000A');
INSERT INTO public.products VALUES (10, 6.17, 22, NULL, 3554, 2, NULL, NULL, 'MIDNIGHT BLUE COPPER FLOWER NECKLAC', '90000B');
INSERT INTO public.products VALUES (10, 6.19, 22, NULL, 3555, 2, NULL, NULL, 'COPPER/OLIVE GREEN FLOWER NECKLACE', '90000D');
INSERT INTO public.products VALUES (10, 4.18, 22, NULL, 3556, 2, NULL, NULL, 'ANTIQUE RASPBERRY FLOWER EARRINGS', '90001A');
INSERT INTO public.products VALUES (10, 4.22, 22, NULL, 3557, 2, NULL, NULL, 'ANTIQUE MID BLUE FLOWER EARRINGS', '90001B');
INSERT INTO public.products VALUES (10, 4.23, 22, NULL, 3558, 2, NULL, NULL, 'ANTIQUE OPAL WHITE FLOWER EARRINGS', '90001C');
INSERT INTO public.products VALUES (10, 4.25, 22, NULL, 3559, 2, NULL, NULL, 'ANTIQUE OLIVE GREEN FLOWER EARRINGS', '90001D');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 3560, 2, NULL, NULL, 'FLOWER BURST SILVER RING CRYSTAL', '90002D');
INSERT INTO public.products VALUES (10, 3.76, 22, NULL, 3561, 2, NULL, NULL, 'ROSE COLOUR PAIR HEART HAIR SLIDES', '90003B');
INSERT INTO public.products VALUES (10, 3.74, 22, NULL, 3562, 2, NULL, NULL, 'MIDNIGHT BLUE PAIR HEART HAIR SLIDE', '90003C');
INSERT INTO public.products VALUES (10, 3.74, 22, NULL, 3563, 2, NULL, NULL, 'CRYSTAL PAIR HEART HAIR SLIDES', '90003D');
INSERT INTO public.products VALUES (10, 3.74, 22, NULL, 3564, 2, NULL, NULL, 'GREEN PAIR HEART HAIR SLIDES', '90003E');
INSERT INTO public.products VALUES (10, 2.02, 22, NULL, 3565, 2, NULL, NULL, 'JADE GREEN ENAMEL HAIR COMB', '90005A');
INSERT INTO public.products VALUES (10, 9.32, 14, NULL, 3566, 2, NULL, NULL, 'MIDNIGHT BLUE GLASS/SILVER BRACELET', '90010A');
INSERT INTO public.products VALUES (10, 9.18, 14, NULL, 3567, 2, NULL, NULL, 'BLACK/WHITE GLASS/SILVER BRACELET', '90010B');
INSERT INTO public.products VALUES (10, 9.10, 14, NULL, 3568, 2, NULL, NULL, 'AMBER GLASS/SILVER BRACELET', '90010E');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3569, 2, NULL, NULL, 'MIDNIGHT BLUE CRYSTAL DROP EARRINGS', '90011A');
INSERT INTO public.products VALUES (10, 2.93, 22, NULL, 3570, 2, NULL, NULL, 'BLACK CRYSTAL DROP EARRINGS', '90011B');
INSERT INTO public.products VALUES (10, 2.90, 22, NULL, 3571, 2, NULL, NULL, 'GREEN CRYSTAL DROP EARRINGS', '90011C');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3572, 2, NULL, NULL, 'PURPLE CRYSTAL DROP EARRINGS', '90011D');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3573, 2, NULL, NULL, 'AMBER CRYSTAL DROP EARRINGS', '90011E');
INSERT INTO public.products VALUES (10, 6.01, 22, NULL, 3574, 2, NULL, NULL, 'MIDNIGHT BLUE DROP CRYSTAL NECKLACE', '90012A');
INSERT INTO public.products VALUES (10, 3.96, 22, NULL, 3575, 2, NULL, NULL, 'BLACK DROP CRYSTAL NECKLACE', '90012B');
INSERT INTO public.products VALUES (10, 3.76, 22, NULL, 3576, 2, NULL, NULL, 'MIDNIGHT BLUE VINTAGE EARRINGS', '90013A');
INSERT INTO public.products VALUES (10, 4.16, 22, NULL, 3577, 2, NULL, NULL, 'BLACK VINTAGE EARRINGS', '90013B');
INSERT INTO public.products VALUES (10, 4.12, 22, NULL, 3578, 2, NULL, NULL, 'GREEN VINTAGE EARRINGS ', '90013C');
INSERT INTO public.products VALUES (10, 4.18, 22, NULL, 3579, 2, NULL, NULL, 'PURPLE VINTAGE EARRINGS', '90013D');
INSERT INTO public.products VALUES (10, 8.77, 22, NULL, 3580, 2, NULL, NULL, 'SILVER/MOP ORBIT NECKLACE', '90014A');
INSERT INTO public.products VALUES (10, 9.26, 22, NULL, 3581, 2, NULL, NULL, 'GOLD M PEARL  ORBIT NECKLACE', '90014B');
INSERT INTO public.products VALUES (10, 8.31, 22, NULL, 3582, 2, NULL, NULL, 'SILVER/BLACK ORBIT NECKLACE', '90014C');
INSERT INTO public.products VALUES (10, 7.82, 22, NULL, 3583, 2, NULL, NULL, 'SILVER/M.O.P PENDANT ORBIT NECKLACE', '90016A');
INSERT INTO public.products VALUES (10, 8.40, 22, NULL, 3584, 2, NULL, NULL, 'GOLD/M.O.P PENDANT ORBIT NECKLACE', '90016B');
INSERT INTO public.products VALUES (10, 8.32, 22, NULL, 3585, 2, NULL, NULL, 'SILVER/BLACK PENDANT ORBIT NECKLACE', '90016C');
INSERT INTO public.products VALUES (10, 4.20, 22, NULL, 3586, 2, NULL, NULL, 'SILVER M.O.P ORBIT DROP EARRINGS', '90018A');
INSERT INTO public.products VALUES (10, 4.19, 22, NULL, 3587, 2, NULL, NULL, 'GOLD M.O.P ORBIT DROP EARRINGS', '90018B');
INSERT INTO public.products VALUES (10, 4.19, 22, NULL, 3588, 2, NULL, NULL, 'SILVER BLACK ORBIT DROP EARRINGS', '90018C');
INSERT INTO public.products VALUES (10, 5.25, 22, NULL, 3589, 2, NULL, NULL, 'SILVER M.O.P ORBIT BRACELET', '90019A');
INSERT INTO public.products VALUES (10, 5.36, 22, NULL, 3590, 2, NULL, NULL, 'GOLD M.O.P ORBIT BRACELET', '90019B');
INSERT INTO public.products VALUES (10, 5.31, 22, NULL, 3591, 2, NULL, NULL, 'SILVER BLACK ORBIT BRACELET', '90019C');
INSERT INTO public.products VALUES (10, 12.48, 22, NULL, 3592, 2, NULL, NULL, 'FILIGREE DIAMANTE CHAIN', '90020');
INSERT INTO public.products VALUES (10, 11.95, 22, NULL, 3593, 2, NULL, NULL, 'LASER CUT MULTI STRAND NECKLACE', '90021');
INSERT INTO public.products VALUES (10, 3.76, 22, NULL, 3594, 2, NULL, NULL, 'EDWARDIAN DROP EARRINGS JET BLACK', '90022');
INSERT INTO public.products VALUES (10, 4.22, 22, NULL, 3595, 2, NULL, NULL, 'FILIGREE DIAMANTE EARRINGS', '90023');
INSERT INTO public.products VALUES (10, 8.40, 22, NULL, 3596, 2, NULL, NULL, 'NEW BAROQUE B''FLY NECKLACE RED', '90024B');
INSERT INTO public.products VALUES (10, 8.44, 22, NULL, 3597, 2, NULL, NULL, 'NEW BAROQUE B''FLY NECKLACE GREEN', '90024C');
INSERT INTO public.products VALUES (10, 8.41, 22, NULL, 3598, 2, NULL, NULL, 'NEW BAROQUE B''FLY NECKLACE PINK', '90024D');
INSERT INTO public.products VALUES (10, 8.41, 22, NULL, 3599, 2, NULL, NULL, 'NEW BAROQUE B''FLY NECKLACE MONTANA', '90024E');
INSERT INTO public.products VALUES (10, 8.41, 22, NULL, 3600, 2, NULL, NULL, 'NEW BAROQUE B''FLY NECKLACE CRYSTAL', '90024F');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 3601, 2, NULL, NULL, 'BAROQUE BUTTERFLY EARRINGS BLACK', '90025A');
INSERT INTO public.products VALUES (10, 3.73, 22, NULL, 3602, 2, NULL, NULL, 'BAROQUE BUTTERFLY EARRINGS RED', '90025B');
INSERT INTO public.products VALUES (10, 3.73, 22, NULL, 3603, 2, NULL, NULL, 'BAROQUE BUTTERFLY EARRINGS PINK', '90025D');
INSERT INTO public.products VALUES (10, 3.73, 22, NULL, 3604, 2, NULL, NULL, 'BAROQUE BUTTERFLY EARRINGS MONTANA', '90025E');
INSERT INTO public.products VALUES (10, 3.74, 22, NULL, 3605, 2, NULL, NULL, 'BAROQUE BUTTERFLY EARRINGS CRYSTAL', '90025F');
INSERT INTO public.products VALUES (10, 8.50, 14, NULL, 3606, 2, NULL, NULL, 'GLASS BEAD HOOP NECKLACE BLACK', '90026A');
INSERT INTO public.products VALUES (10, 8.44, 14, NULL, 3607, 2, NULL, NULL, 'GLASS BEAD HOOP NECKLACE MONTANA', '90026B');
INSERT INTO public.products VALUES (10, 8.44, 14, NULL, 3608, 2, NULL, NULL, 'GLASS BEAD HOOP NECKLACE GREEN', '90026C');
INSERT INTO public.products VALUES (10, 8.50, 14, NULL, 3609, 2, NULL, NULL, 'GLASS BEAD HOOP NECKLACE AMETHYST', '90026D');
INSERT INTO public.products VALUES (10, 2.94, 14, NULL, 3610, 2, NULL, NULL, 'GLASS BEAD HOOP EARRINGS BLACK', '90027A');
INSERT INTO public.products VALUES (10, 2.92, 14, NULL, 3611, 2, NULL, NULL, 'GLASS BEAD HOOP EARRINGS MONTANA', '90027B');
INSERT INTO public.products VALUES (10, 2.90, 14, NULL, 3612, 2, NULL, NULL, 'GLASS BEAD HOOP EARRINGS GREEN', '90027C');
INSERT INTO public.products VALUES (10, 3.26, 14, NULL, 3613, 2, NULL, NULL, 'GLASS BEAD HOOP EARRINGS AMETHYST', '90027D');
INSERT INTO public.products VALUES (10, 8.38, 22, NULL, 3614, 2, NULL, NULL, 'NEW BAROQUE LARGE NECKLACE BLK/WHIT', '90028');
INSERT INTO public.products VALUES (10, 8.41, 22, NULL, 3615, 2, NULL, NULL, 'NEW BAROQUE SMALL NECKLACE BLACK', '90029');
INSERT INTO public.products VALUES (10, 1.00, 22, NULL, 3616, 2, NULL, NULL, 'SPOTTED WHITE NATURAL SEED NECKLACE', '90030A');
INSERT INTO public.products VALUES (12, 3.16, 22, NULL, 3617, 2, NULL, NULL, 'RED KUKUI COCONUT SEED NECKLACE', '90030B');
INSERT INTO public.products VALUES (10, 2.34, 22, NULL, 3618, 2, NULL, NULL, 'BROWN KUKUI COCONUT SEED NECKLACE', '90030C');
INSERT INTO public.products VALUES (10, 2.41, 22, NULL, 3619, 2, NULL, NULL, 'BILI NUT AND WOOD NECKLACE', '90031');
INSERT INTO public.products VALUES (10, 5.86, 22, NULL, 3620, 2, NULL, NULL, 'IVORY SHELL HEART NECKLACE', '90032');
INSERT INTO public.products VALUES (10, 2.50, 22, NULL, 3621, 2, NULL, NULL, 'IVORY SHELL HEART EARRINGS', '90033');
INSERT INTO public.products VALUES (10, 10.09, 14, NULL, 3622, 2, NULL, NULL, 'WHITE SILVER NECKLACE SHELL GLASS', '90034');
INSERT INTO public.products VALUES (10, 10.71, 22, NULL, 3623, 2, NULL, NULL, 'PEARL & SHELL 42"NECKL. GREEN', '90035A');
INSERT INTO public.products VALUES (10, 10.75, 22, NULL, 3624, 2, NULL, NULL, 'PEARL & SHELL 42"NECKL. IVORY', '90035C');
INSERT INTO public.products VALUES (10, 7.95, 22, NULL, 3625, 2, NULL, NULL, 'FLOWER GARLAND NECKLACE RED', '90036A');
INSERT INTO public.products VALUES (10, 7.95, 14, NULL, 3626, 2, NULL, NULL, 'FLOWER GLASS GARLAND NECKL.36"GREEN', '90036B');
INSERT INTO public.products VALUES (10, 7.92, 14, NULL, 3627, 2, NULL, NULL, 'FLOWER GLASS GARLAND NECKL.36"BLUE', '90036C');
INSERT INTO public.products VALUES (10, 7.94, 14, NULL, 3628, 2, NULL, NULL, 'FLOWER GLASS GARLAND NECKL.36"BLACK', '90036D');
INSERT INTO public.products VALUES (10, 7.92, 14, NULL, 3629, 2, NULL, NULL, 'FLOWER GLASS GARLD NECKL36"AMETHYST', '90036E');
INSERT INTO public.products VALUES (10, 8.05, 14, NULL, 3630, 2, NULL, NULL, 'FLOWER GLASS GARLD NECKL36"TURQUOIS', '90036F');
INSERT INTO public.products VALUES (10, 2.48, 16, NULL, 3631, 2, NULL, NULL, 'TINY CRYSTAL BRACELET RED', '90037A');
INSERT INTO public.products VALUES (10, 2.51, 16, NULL, 3632, 2, NULL, NULL, 'TINY CRYSTAL BRACELET GREEN', '90037B');
INSERT INTO public.products VALUES (10, 2.50, 16, NULL, 3633, 2, NULL, NULL, 'TINY CRYSTAL BRACELET BLUE', '90037C');
INSERT INTO public.products VALUES (10, 3.74, 14, NULL, 3634, 2, NULL, NULL, 'GLASS AND PAINTED BEADS BRACELET TO', '90038A');
INSERT INTO public.products VALUES (10, 3.75, 14, NULL, 3635, 2, NULL, NULL, 'GLASS AND PAINTED BEADS BRACELET OL', '90038B');
INSERT INTO public.products VALUES (10, 3.73, 14, NULL, 3636, 2, NULL, NULL, 'GLASS AND BEADS BRACELET IVORY', '90038C');
INSERT INTO public.products VALUES (10, 3.74, 14, NULL, 3637, 2, NULL, NULL, 'FIRE POLISHED GLASS BRACELET RED', '90039A');
INSERT INTO public.products VALUES (10, 3.76, 14, NULL, 3638, 2, NULL, NULL, 'FIRE POLISHED GLASS BRACELET MONTAN', '90039B');
INSERT INTO public.products VALUES (10, 3.75, 14, NULL, 3639, 2, NULL, NULL, 'FIRE POLISHED GLASS BRACELET BLACK', '90039C');
INSERT INTO public.products VALUES (10, 3.74, 14, NULL, 3640, 2, NULL, NULL, 'FIRE POLISHED GLASS BRACELET GREEN', '90039D');
INSERT INTO public.products VALUES (10, 3.91, 14, NULL, 3641, 2, NULL, NULL, 'MURANO STYLE GLASS BRACELET RED', '90040A');
INSERT INTO public.products VALUES (10, 3.73, 14, NULL, 3642, 2, NULL, NULL, 'MURANO STYLE GLASS BRACELET BLACK', '90040B');
INSERT INTO public.products VALUES (10, 3.67, 14, NULL, 3643, 2, NULL, NULL, 'MURANO STYLE GLASS BRACELET GOLD', '90040C');
INSERT INTO public.products VALUES (10, 3.69, 22, NULL, 3644, 2, NULL, NULL, 'PEARL AND CHERRY QUARTZ BRACLET', '90041');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 3645, 2, NULL, NULL, 'FRESHWATER PEARL BRACELET GOLD', '90042A');
INSERT INTO public.products VALUES (10, 2.54, 22, NULL, 3646, 2, NULL, NULL, 'FRESHWATER PEARL BRACELET IVORY', '90042C');
INSERT INTO public.products VALUES (10, 7.46, 13, NULL, 3647, 2, NULL, NULL, 'COPPER AND BRASS BAG CHARM', '90043');
INSERT INTO public.products VALUES (10, 4.95, 13, NULL, 3648, 2, NULL, NULL, 'WHITE WITH METAL BAG CHARM', '90046');
INSERT INTO public.products VALUES (10, 4.95, 13, NULL, 3649, 2, NULL, NULL, 'GREEN WITH METAL BAG CHARM', '90048');
INSERT INTO public.products VALUES (10, 8.29, 13, NULL, 3650, 2, NULL, NULL, 'IVORY GOLD METAL BAG CHARM', '90049');
INSERT INTO public.products VALUES (10, 6.97, 22, NULL, 3651, 2, NULL, NULL, 'CRACKED GLAZE NECKLACE IVORY', '90050');
INSERT INTO public.products VALUES (10, 7.04, 22, NULL, 3652, 2, NULL, NULL, 'CRACKED GLAZE NECKLACE RED', '90051');
INSERT INTO public.products VALUES (10, 7.07, 22, NULL, 3653, 2, NULL, NULL, 'CRACKED GLAZE NECKLACE BROWN', '90052');
INSERT INTO public.products VALUES (10, 2.50, 22, NULL, 3654, 2, NULL, NULL, 'CRACKED GLAZE EARRINGS IVORY', '90053');
INSERT INTO public.products VALUES (10, 2.51, 22, NULL, 3655, 2, NULL, NULL, 'CRACKED GLAZE EARRINGS RED', '90054');
INSERT INTO public.products VALUES (10, 2.51, 22, NULL, 3656, 2, NULL, NULL, 'CRACKED GLAZE EARRINGS BROWN', '90055');
INSERT INTO public.products VALUES (10, 10.88, 22, NULL, 3657, 2, NULL, NULL, 'CHUNKY CRACKED GLAZE NECKLACE IVORY', '90056');
INSERT INTO public.products VALUES (62, 1.29, 16, NULL, 3658, 2, NULL, NULL, 'DIAMANTE RING ASSORTED IN BOX.', '90057');
INSERT INTO public.products VALUES (28, 0.38, 22, NULL, 3659, 2, NULL, NULL, 'CRYSTAL STUD EARRINGS CLEAR DISPLAY', '90058A');
INSERT INTO public.products VALUES (57, 0.38, 22, NULL, 3660, 2, NULL, NULL, 'CRYSTAL STUD EARRINGS ASSORTED COL ', '90058B');
INSERT INTO public.products VALUES (10, 1.66, 22, NULL, 3661, 2, NULL, NULL, 'DIAMANTE HAIR GRIP PACK/2 CRYSTAL', '90059A');
INSERT INTO public.products VALUES (10, 1.66, 22, NULL, 3662, 2, NULL, NULL, 'DIAMANTE HAIR GRIP PACK/2 BLACK DIA', '90059B');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 3663, 2, NULL, NULL, 'DIAMANTE HAIR GRIP PACK/2 MONTANA', '90059C');
INSERT INTO public.products VALUES (10, 1.66, 22, NULL, 3664, 2, NULL, NULL, 'DIAMANTE HAIR GRIP PACK/2 PERIDOT', '90059D');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 3665, 2, NULL, NULL, 'DIAMANTE HAIR GRIP PACK/2 RUBY', '90059E');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 3666, 2, NULL, NULL, 'DIAMANTE HAIR GRIP PACK/2 LT ROSE', '90059F');
INSERT INTO public.products VALUES (10, 5.95, 14, NULL, 3667, 2, NULL, NULL, 'FIRE POLISHED GLASS NECKL GOLD', '90060B');
INSERT INTO public.products VALUES (10, 5.95, 14, NULL, 3668, 2, NULL, NULL, 'FIRE POLISHED GLASS NECKL BRONZE', '90060D');
INSERT INTO public.products VALUES (10, 5.86, 14, NULL, 3669, 2, NULL, NULL, 'FIRE POLISHED GLASS NECKL GREEN', '90060F');
INSERT INTO public.products VALUES (10, 12.66, 22, NULL, 3670, 2, NULL, NULL, 'CARNIVAL BRACELET', '90062');
INSERT INTO public.products VALUES (10, 8.50, 22, NULL, 3671, 2, NULL, NULL, 'WHITE VINT ART DECO CRYSTAL NECKLAC', '90063A');
INSERT INTO public.products VALUES (10, 8.47, 22, NULL, 3672, 2, NULL, NULL, 'BLACK VINT ART DEC CRYSTAL NECKLACE', '90063B');
INSERT INTO public.products VALUES (10, 3.95, 22, NULL, 3673, 2, NULL, NULL, 'WHITE VINTAGE CRYSTAL EARRINGS', '90064A');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 3674, 2, NULL, NULL, 'BLACK VINTAGE  CRYSTAL EARRINGS', '90064B');
INSERT INTO public.products VALUES (10, 6.75, 22, NULL, 3675, 2, NULL, NULL, 'WHITE VINTAGE CRYSTAL BRACELET', '90065A');
INSERT INTO public.products VALUES (10, 6.75, 22, NULL, 3676, 2, NULL, NULL, 'BLACK VINT ART DEC CRYSTAL BRACELET', '90065B');
INSERT INTO public.products VALUES (10, 2.93, 22, NULL, 3677, 2, NULL, NULL, 'PINK VINTAGE VICTORIAN EARRINGS', '90067A');
INSERT INTO public.products VALUES (10, 2.90, 22, NULL, 3678, 2, NULL, NULL, 'BROWN VINTAGE VICTORIAN EARRINGS', '90067B');
INSERT INTO public.products VALUES (10, 7.50, 14, NULL, 3679, 2, NULL, NULL, 'RUBY GLASS NECKLACE 42"', '90068');
INSERT INTO public.products VALUES (10, 7.50, 14, NULL, 3680, 2, NULL, NULL, 'RUBY GLASS CLUSTER NECKLACE', '90069');
INSERT INTO public.products VALUES (10, 6.16, 14, NULL, 3681, 2, NULL, NULL, 'RUBY GLASS CLUSTER BRACELET', '90070');
INSERT INTO public.products VALUES (10, 1.24, 14, NULL, 3682, 2, NULL, NULL, 'RUBY GLASS CLUSTER EARRINGS', '90071');
INSERT INTO public.products VALUES (10, 4.08, 22, NULL, 3683, 2, NULL, NULL, 'RUBY DROP CHANDELIER EARRINGS', '90072');
INSERT INTO public.products VALUES (10, 5.01, 22, NULL, 3684, 2, NULL, NULL, 'VINTAGE ENAMEL & CRYSTAL EARRINGS', '90073');
INSERT INTO public.products VALUES (10, 9.43, 22, NULL, 3685, 2, NULL, NULL, 'BLACK DIAMOND CLUSTER NECKLACE', '90074');
INSERT INTO public.products VALUES (10, 9.36, 22, NULL, 3686, 2, NULL, NULL, 'MONTANA DIAMOND CLUSTER NECKLACE', '90075');
INSERT INTO public.products VALUES (10, 2.78, 22, NULL, 3687, 2, NULL, NULL, 'MONTANA DIAMOND CLUSTER EARRINGS', '90076');
INSERT INTO public.products VALUES (10, 2.94, 22, NULL, 3688, 2, NULL, NULL, 'BLACK DIAMOND CLUSTER EARRINGS', '90077');
INSERT INTO public.products VALUES (10, 7.50, 14, NULL, 3689, 2, NULL, NULL, 'PINK/WHITE GLASS DEMI CHOKER', '90078');
INSERT INTO public.products VALUES (10, 4.99, 22, NULL, 3690, 2, NULL, NULL, 'VINTAGE ENAMEL & CRYSTAL NECKLACE', '90079');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 3691, 2, NULL, NULL, 'LILY BROOCH AMETHYST COLOUR', '90081A');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 3692, 2, NULL, NULL, 'LILY BROOCH WHITE/SILVER COLOUR', '90081B');
INSERT INTO public.products VALUES (10, 4.99, 22, NULL, 3693, 2, NULL, NULL, 'LILY BROOCH OLIVE COLOUR', '90081C');
INSERT INTO public.products VALUES (10, 6.48, 22, NULL, 3694, 2, NULL, NULL, 'DIAMANTE BOW BROOCH GREEN COLOUR', '90082A');
INSERT INTO public.products VALUES (10, 6.35, 22, NULL, 3695, 2, NULL, NULL, 'DIAMANTE BOW BROOCH RED COLOUR', '90082B');
INSERT INTO public.products VALUES (10, 6.42, 22, NULL, 3696, 2, NULL, NULL, 'DIAMANTE BOW BROOCH BLACK COLOUR', '90082D');
INSERT INTO public.products VALUES (10, 1.47, 22, NULL, 3697, 2, NULL, NULL, 'CRYSTAL CZECH CROSS PHONE CHARM', '90083');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 3698, 2, NULL, NULL, 'PINK CRYSTAL GUITAR PHONE CHARM', '90084');
INSERT INTO public.products VALUES (10, 1.48, 22, NULL, 3699, 2, NULL, NULL, 'CRYSTAL STILETTO PHONE CHARM', '90085');
INSERT INTO public.products VALUES (10, 1.50, 22, NULL, 3700, 2, NULL, NULL, 'CRYSTAL FROG PHONE CHARM', '90086');
INSERT INTO public.products VALUES (10, 1.49, 22, NULL, 3701, 2, NULL, NULL, 'CRYSTAL SEA HORSE PHONE CHARM', '90087');
INSERT INTO public.products VALUES (10, 1.20, 22, NULL, 3702, 2, NULL, NULL, 'PINK CRYSTAL SKULL PHONE CHARM', '90089');
INSERT INTO public.products VALUES (10, 1.66, 22, NULL, 3703, 2, NULL, NULL, 'BLUE CRYSTAL BOOT PHONE CHARM', '90092');
INSERT INTO public.products VALUES (10, 1.19, 22, NULL, 3704, 2, NULL, NULL, 'CLEAR CRYSTAL STAR PHONE CHARM', '90093');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 3705, 2, NULL, NULL, 'NECKLACE+BRACELET SET FRUIT SALAD ', '90094');
INSERT INTO public.products VALUES (10, 2.48, 22, NULL, 3706, 2, NULL, NULL, 'NECKLACE+BRACELET SET BLUE BLOSSOM', '90096');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 3707, 2, NULL, NULL, 'NECKLACE+BRACELET PINK BUTTERFLY', '90098');
INSERT INTO public.products VALUES (10, 2.86, 22, NULL, 3708, 2, NULL, NULL, 'NECKLACE+BRACELET SET BLUE HIBISCUS', '90099');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 3709, 2, NULL, NULL, 'NECKLACE+BRACELET SET PINK DAISY', '90100');
INSERT INTO public.products VALUES (10, 2.51, 22, NULL, 3710, 2, NULL, NULL, 'WHITE FRANGIPANI NECKLACE', '90101');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 3711, 2, NULL, NULL, 'WHITE FRANGIPANI HAIR CLIP', '90102');
INSERT INTO public.products VALUES (10, 2.50, 22, NULL, 3712, 2, NULL, NULL, 'PURPLE FRANGIPANI NECKLACE', '90103');
INSERT INTO public.products VALUES (10, 0.83, 22, NULL, 3713, 2, NULL, NULL, 'PURPLE FRANGIPANI HAIRCLIP', '90104');
INSERT INTO public.products VALUES (10, 1.70, 22, NULL, 3714, 2, NULL, NULL, 'BLUE BLOSSOM HAIR CLIP', '90108');
INSERT INTO public.products VALUES (10, 1.05, 20, NULL, 3715, 2, NULL, NULL, 'PINK DOLLY HAIR CLIPS', '90112');
INSERT INTO public.products VALUES (16, 2.48, 13, NULL, 3716, 2, NULL, NULL, 'SUMMER DAISIES BAG CHARM', '90114');
INSERT INTO public.products VALUES (10, 2.49, 13, NULL, 3717, 2, NULL, NULL, 'SUMMER BUTTERFLIES BAG CHARM', '90115');
INSERT INTO public.products VALUES (10, 2.42, 13, NULL, 3718, 2, NULL, NULL, 'FRUIT SALAD BAG CHARM', '90116');
INSERT INTO public.products VALUES (10, 2.48, 13, NULL, 3719, 2, NULL, NULL, 'PINK DAISY BAG CHARM', '90118');
INSERT INTO public.products VALUES (10, 2.47, 13, NULL, 3720, 2, NULL, NULL, 'METALIC LEAVES BAG CHARMS', '90119');
INSERT INTO public.products VALUES (10, 4.24, 22, NULL, 3721, 2, NULL, NULL, 'PINK MURANO TWIST BRACELET', '90120A');
INSERT INTO public.products VALUES (10, 4.20, 22, NULL, 3722, 2, NULL, NULL, 'BLUE MURANO TWIST BRACELET', '90120B');
INSERT INTO public.products VALUES (10, 4.20, 22, NULL, 3723, 2, NULL, NULL, 'GREEN MURANO TWIST BRACELET', '90120C');
INSERT INTO public.products VALUES (10, 4.21, 22, NULL, 3724, 2, NULL, NULL, 'WHITE MURANO TWIST BRACELET', '90120D');
INSERT INTO public.products VALUES (10, 4.98, 14, NULL, 3725, 2, NULL, NULL, 'PINK CRYSTAL+GLASS BRACELET', '90122A');
INSERT INTO public.products VALUES (10, 4.99, 14, NULL, 3726, 2, NULL, NULL, 'JADE CRYSTAL+GLASS BRACELET', '90122B');
INSERT INTO public.products VALUES (10, 4.99, 14, NULL, 3727, 2, NULL, NULL, 'TURQUOISE CRYSTAL+GLASS BRACELET', '90122C');
INSERT INTO public.products VALUES (10, 5.94, 14, NULL, 3728, 2, NULL, NULL, 'PINK HEART OF GLASS BRACELET', '90123A');
INSERT INTO public.products VALUES (10, 5.92, 14, NULL, 3729, 2, NULL, NULL, 'TURQUOISE HEART OF GLASS BRACELET', '90123B');
INSERT INTO public.products VALUES (10, 5.95, 14, NULL, 3730, 2, NULL, NULL, 'GREEN HEART OF GLASS BRACELET', '90123C');
INSERT INTO public.products VALUES (10, 5.87, 14, NULL, 3731, 2, NULL, NULL, 'WHITE HEART OF GLASS BRACELET', '90123D');
INSERT INTO public.products VALUES (10, 9.96, 22, NULL, 3732, 2, NULL, NULL, 'PINK MURANO TWIST NECKLACE', '90124A');
INSERT INTO public.products VALUES (10, 9.99, 22, NULL, 3733, 2, NULL, NULL, 'BLUE MURANO TWIST NECKLACE', '90124B');
INSERT INTO public.products VALUES (10, 9.96, 22, NULL, 3734, 2, NULL, NULL, 'GREEN MURANO TWIST NECKLACE', '90124C');
INSERT INTO public.products VALUES (11, 1.54, 13, NULL, 3735, 2, NULL, NULL, 'PINK BERTIE GLASS BEAD BAG CHARM', '90125A');
INSERT INTO public.products VALUES (10, 2.07, 13, NULL, 3736, 2, NULL, NULL, 'AQUA BERTIE GLASS BEAD BAG CHARM', '90125B');
INSERT INTO public.products VALUES (10, 1.48, 14, NULL, 3737, 2, NULL, NULL, 'TURQUOISE BERTIE GLASS BEAD CHARM', '90125C');
INSERT INTO public.products VALUES (10, 2.10, 13, NULL, 3738, 2, NULL, NULL, 'PURPLE BERTIE GLASS BEAD BAG CHARM', '90125D');
INSERT INTO public.products VALUES (10, 1.94, 13, NULL, 3739, 2, NULL, NULL, 'AMBER BERTIE GLASS BEAD BAG CHARM', '90125E');
INSERT INTO public.products VALUES (10, 3.36, 22, NULL, 3740, 2, NULL, NULL, 'PINK BERTIE MOBILE PHONE CHARM', '90126A');
INSERT INTO public.products VALUES (10, 3.29, 22, NULL, 3741, 2, NULL, NULL, 'AMBER BERTIE MOBILE PHONE CHARM', '90126C');
INSERT INTO public.products VALUES (10, 2.46, 22, NULL, 3742, 2, NULL, NULL, 'PINK BEADS+HAND PHONE CHARM', '90127A');
INSERT INTO public.products VALUES (10, 2.48, 22, NULL, 3743, 2, NULL, NULL, 'PINK LEAVES AND BEADS PHONE CHARM', '90128A');
INSERT INTO public.products VALUES (10, 1.88, 22, NULL, 3744, 2, NULL, NULL, 'BLUE LEAVES AND BEADS PHONE CHARM', '90128B');
INSERT INTO public.products VALUES (10, 2.48, 22, NULL, 3745, 2, NULL, NULL, 'GREEN LEAVES AND BEADS PHONE CHARM', '90128C');
INSERT INTO public.products VALUES (10, 2.48, 22, NULL, 3746, 2, NULL, NULL, 'PURPLE LEAVES AND BEADS PHONE CHAR', '90128D');
INSERT INTO public.products VALUES (10, 1.84, 13, NULL, 3747, 2, NULL, NULL, 'PINK GLASS TASSLE BAG CHARM ', '90129A');
INSERT INTO public.products VALUES (10, 2.04, 13, NULL, 3748, 2, NULL, NULL, 'TURQUOISE GLASS TASSLE BAG CHARM ', '90129B');
INSERT INTO public.products VALUES (10, 2.13, 13, NULL, 3749, 2, NULL, NULL, 'GREEN GLASS TASSLE BAG CHARM', '90129C');
INSERT INTO public.products VALUES (10, 2.02, 13, NULL, 3750, 2, NULL, NULL, 'AMBER GLASS TASSLE BAG CHARM', '90129D');
INSERT INTO public.products VALUES (10, 1.73, 13, NULL, 3751, 2, NULL, NULL, 'PURPLE GLASS TASSLE BAG CHARM', '90129E');
INSERT INTO public.products VALUES (10, 2.13, 13, NULL, 3752, 2, NULL, NULL, 'RED GLASS TASSLE BAG CHARM', '90129F');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3753, 2, NULL, NULL, 'WHITE STONE/CRYSTAL EARRINGS', '90130A');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3754, 2, NULL, NULL, 'TURQ STONE/CRYSTAL EARRINGS', '90130B');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3755, 2, NULL, NULL, 'GREEN STONE/CRYSTAL EARRINGS', '90130C');
INSERT INTO public.products VALUES (10, 2.90, 22, NULL, 3756, 2, NULL, NULL, 'RED STONE/CRYSTAL EARRINGS', '90130D');
INSERT INTO public.products VALUES (10, 7.01, 22, NULL, 3757, 2, NULL, NULL, 'PINK/AMETHYST/GOLD NECKLACE', '90131');
INSERT INTO public.products VALUES (10, 5.05, 12, NULL, 3758, 2, NULL, NULL, 'LIGHT TOPAZ TEAL/AQUA COL NECKLACE', '90132');
INSERT INTO public.products VALUES (10, 4.98, 22, NULL, 3759, 2, NULL, NULL, 'TEAL/FUSCHIA COL BEAD NECKLACE', '90133');
INSERT INTO public.products VALUES (10, 2.91, 22, NULL, 3760, 2, NULL, NULL, 'OLD ROSE COMBO BEAD NECKLACE', '90134');
INSERT INTO public.products VALUES (10, 4.96, 22, NULL, 3761, 2, NULL, NULL, 'ORANGE/WHT/FUSCHIA STONES NECKLACE', '90135');
INSERT INTO public.products VALUES (10, 4.98, 22, NULL, 3762, 2, NULL, NULL, 'ORANGE/FUSCHIA STONES NECKLACE', '90135A');
INSERT INTO public.products VALUES (10, 9.95, 22, NULL, 3763, 2, NULL, NULL, 'PALE PINK/AMETHYST STONE NECKLACE', '90136');
INSERT INTO public.products VALUES (10, 5.44, 22, NULL, 3764, 2, NULL, NULL, 'PINK COMBO MINI CRYSTALS NECKLACE', '90137');
INSERT INTO public.products VALUES (10, 5.37, 22, NULL, 3765, 2, NULL, NULL, 'WHITE/PINK MINI CRYSTALS NECKLACE', '90138');
INSERT INTO public.products VALUES (10, 7.56, 22, NULL, 3766, 2, NULL, NULL, 'PINK SWEETIE NECKLACE', '90140');
INSERT INTO public.products VALUES (10, 5.32, 22, NULL, 3767, 2, NULL, NULL, 'GREEN PENDANT TRIPLE SHELL NECKLACE', '90141A');
INSERT INTO public.products VALUES (10, 5.01, 22, NULL, 3768, 2, NULL, NULL, 'IVORY PENDANT TRIPLE SHELL NECKLACE', '90141B');
INSERT INTO public.products VALUES (10, 5.30, 22, NULL, 3769, 2, NULL, NULL, 'TURQ PENDANT TRIPLE SHELL NECKLACE', '90141C');
INSERT INTO public.products VALUES (10, 5.23, 22, NULL, 3770, 2, NULL, NULL, 'ROSE PENDANT TRIPLE SHELL NECKLACE', '90141D');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 3771, 2, NULL, NULL, 'ORANGE PENDANT TRIPLE SHELL NECKLAC', '90141E');
INSERT INTO public.products VALUES (10, 5.09, 22, NULL, 3772, 2, NULL, NULL, 'GREEN PENDANT SHELL NECKLACE', '90142A');
INSERT INTO public.products VALUES (10, 4.99, 22, NULL, 3773, 2, NULL, NULL, 'MOP PENDANT SHELL NECKLACE', '90142D');
INSERT INTO public.products VALUES (10, 7.66, 22, NULL, 3774, 2, NULL, NULL, 'SILVER BRACELET W PASTEL FLOWER', '90143');
INSERT INTO public.products VALUES (10, 3.74, 22, NULL, 3775, 2, NULL, NULL, 'SILVER DROP EARRINGS WITH FLOWER', '90144');
INSERT INTO public.products VALUES (10, 6.03, 22, NULL, 3776, 2, NULL, NULL, 'SILVER HOOP EARRINGS WITH FLOWER', '90145');
INSERT INTO public.products VALUES (10, 7.19, 22, NULL, 3777, 2, NULL, NULL, 'FINE SILVER NECKLACE W PASTEL FLOWE', '90146');
INSERT INTO public.products VALUES (10, 10.18, 22, NULL, 3778, 2, NULL, NULL, 'CHUNKY SILVER NECKLACE PASTEL FLOWE', '90147');
INSERT INTO public.products VALUES (10, 12.72, 22, NULL, 3779, 2, NULL, NULL, 'LONG SILVER NECKLACE PASTEL FLOWER', '90148');
INSERT INTO public.products VALUES (10, 7.21, 22, NULL, 3780, 2, NULL, NULL, 'SILVER FLOWR PINK SHELL NECKLACE', '90149');
INSERT INTO public.products VALUES (10, 8.50, 22, NULL, 3781, 2, NULL, NULL, 'SILVER/NATURAL SHELL NECKLACE', '90151');
INSERT INTO public.products VALUES (10, 5.75, 22, NULL, 3782, 2, NULL, NULL, 'SILVER/NAT SHELL NECKLACE W PENDANT', '90152A');
INSERT INTO public.products VALUES (10, 5.73, 22, NULL, 3783, 2, NULL, NULL, 'BLUE/GREEN SHELL NECKLACE W PENDANT', '90152B');
INSERT INTO public.products VALUES (10, 5.95, 22, NULL, 3784, 2, NULL, NULL, 'BLUE/NAT SHELL NECKLACE W PENDANT', '90152C');
INSERT INTO public.products VALUES (10, 8.61, 22, NULL, 3785, 2, NULL, NULL, 'LAZER CUT NECKLACE W PASTEL BEADS', '90154');
INSERT INTO public.products VALUES (10, 7.52, 22, NULL, 3786, 2, NULL, NULL, 'RESIN NECKLACE W PASTEL BEADS', '90155');
INSERT INTO public.products VALUES (10, 4.95, 22, NULL, 3787, 2, NULL, NULL, 'RESIN BRACELET W PASTEL BEADS', '90156');
INSERT INTO public.products VALUES (10, 4.97, 22, NULL, 3788, 2, NULL, NULL, 'RIVIERA NECKLACE', '90157');
INSERT INTO public.products VALUES (10, 4.99, 22, NULL, 3789, 2, NULL, NULL, 'ST TROPEZ NECKLACE', '90158');
INSERT INTO public.products VALUES (10, 4.97, 22, NULL, 3790, 2, NULL, NULL, 'COTE D''AZURE NECKLACE', '90159');
INSERT INTO public.products VALUES (10, 6.98, 22, NULL, 3791, 2, NULL, NULL, 'PURPLE BOUDICCA LARGE BRACELET', '90160A');
INSERT INTO public.products VALUES (10, 7.00, 22, NULL, 3792, 2, NULL, NULL, 'RED BOUDICCA LARGE BRACELET', '90160B');
INSERT INTO public.products VALUES (10, 7.00, 22, NULL, 3793, 2, NULL, NULL, 'TURQ+RED BOUDICCA LARGE BRACELET', '90160C');
INSERT INTO public.products VALUES (10, 6.97, 22, NULL, 3794, 2, NULL, NULL, 'PINK BOUDICCA LARGE BRACELET', '90160D');
INSERT INTO public.products VALUES (10, 5.00, 22, NULL, 3795, 2, NULL, NULL, 'ANT COPPER RED BOUDICCA BRACELET', '90161A');
INSERT INTO public.products VALUES (10, 4.98, 22, NULL, 3796, 2, NULL, NULL, 'ANT COPPER TURQ BOUDICCA BRACELET', '90161B');
INSERT INTO public.products VALUES (10, 4.99, 22, NULL, 3797, 2, NULL, NULL, 'ANT COPPER LIME BOUDICCA BRACELET', '90161C');
INSERT INTO public.products VALUES (10, 5.00, 22, NULL, 3798, 2, NULL, NULL, 'ANT COPPER PINK BOUDICCA BRACELET', '90161D');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3799, 2, NULL, NULL, 'ANT SILVER TURQUOISE BOUDICCA RING', '90162A');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3800, 2, NULL, NULL, 'ANT SILVER LIME GREEN BOUDICCA RING', '90162B');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3801, 2, NULL, NULL, 'ANT SILVER FUSCHIA BOUDICCA RING', '90162C');
INSERT INTO public.products VALUES (10, 2.95, 22, NULL, 3802, 2, NULL, NULL, 'ANT SILVER PURPLE BOUDICCA RING', '90162D');
INSERT INTO public.products VALUES (10, 7.54, 22, NULL, 3803, 2, NULL, NULL, 'PINK ROSEBUD & PEARL NECKLACE', '90163A');
INSERT INTO public.products VALUES (10, 7.52, 22, NULL, 3804, 2, NULL, NULL, 'WHITE ROSEBUD & PEARL NECKLACE', '90163B');
INSERT INTO public.products VALUES (10, 6.33, 22, NULL, 3805, 2, NULL, NULL, 'PINK ROSEBUD PEARL BRACELET', '90164A');
INSERT INTO public.products VALUES (10, 5.29, 22, NULL, 3806, 2, NULL, NULL, 'WHITE  ROSEBUD PEARL BRACELET', '90164B');
INSERT INTO public.products VALUES (10, 2.50, 22, NULL, 3807, 2, NULL, NULL, 'PINK ROSEBUD PEARL EARRINGS', '90165A');
INSERT INTO public.products VALUES (10, 2.49, 22, NULL, 3808, 2, NULL, NULL, 'WHITE ROSEBUD  PEARL EARRINGS', '90165B');
INSERT INTO public.products VALUES (10, 4.18, 22, NULL, 3809, 2, NULL, NULL, 'PINK & WHITE ROSEBUD RING', '90166');
INSERT INTO public.products VALUES (10, 0.85, 22, NULL, 3810, 2, NULL, NULL, 'BEADED LOVE HEART JEWELLERY SET', '90167');
INSERT INTO public.products VALUES (10, 2.91, 22, NULL, 3811, 2, NULL, NULL, '2 DAISIES HAIR COMB', '90168');
INSERT INTO public.products VALUES (10, 2.51, 22, NULL, 3812, 2, NULL, NULL, 'DAISY HAIR COMB', '90169');
INSERT INTO public.products VALUES (10, 1.65, 22, NULL, 3813, 2, NULL, NULL, 'DAISY HAIR BAND', '90170');
INSERT INTO public.products VALUES (10, 3.77, 22, NULL, 3814, 2, NULL, NULL, 'PAIR BUTTERFLY HAIR CLIPS', '90173');
INSERT INTO public.products VALUES (10, 2.50, 22, NULL, 3815, 2, NULL, NULL, 'BUTTERFLY HAIR BAND', '90174');
INSERT INTO public.products VALUES (10, 9.10, 14, NULL, 3816, 2, NULL, NULL, 'WHITE GLASS CHUNKY CHARM BRACELET', '90175A');
INSERT INTO public.products VALUES (10, 9.17, 14, NULL, 3817, 2, NULL, NULL, 'PINK GLASS CHUNKY CHARM BRACELET', '90175B');
INSERT INTO public.products VALUES (10, 8.95, 14, NULL, 3818, 2, NULL, NULL, 'BLUE GLASS CHUNKY CHARM BRACELET', '90175C');
INSERT INTO public.products VALUES (10, 9.14, 22, NULL, 3819, 2, NULL, NULL, 'TIGRIS EYE CHUNKY CHARM BRACELET', '90175D');
INSERT INTO public.products VALUES (10, 7.49, 22, NULL, 3820, 2, NULL, NULL, 'CLASSIC DIAMANTE NECKLACE JET', '90176A');
INSERT INTO public.products VALUES (10, 7.54, 22, NULL, 3821, 2, NULL, NULL, 'DIAMANTE NECKLACE BLACK ', '90176B');
INSERT INTO public.products VALUES (10, 7.91, 22, NULL, 3822, 2, NULL, NULL, 'DIAMANTE NECKLACE', '90176C');
INSERT INTO public.products VALUES (10, 7.50, 22, NULL, 3823, 2, NULL, NULL, 'DIAMANTE NECKLACE PURPLE', '90176D');
INSERT INTO public.products VALUES (10, 7.49, 22, NULL, 3824, 2, NULL, NULL, 'DIAMANTE NECKLACE GREEN', '90176E');
INSERT INTO public.products VALUES (10, 2.91, 22, NULL, 3825, 2, NULL, NULL, 'CLASSIC DIAMANTE EARRINGS JET', '90177A');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3826, 2, NULL, NULL, 'DROP DIAMANTE EARRINGS BLACK DIAMON', '90177B');
INSERT INTO public.products VALUES (10, 2.93, 22, NULL, 3827, 2, NULL, NULL, 'DROP DIAMANTE EARRINGS CRYSTAL', '90177C');
INSERT INTO public.products VALUES (10, 2.94, 22, NULL, 3828, 2, NULL, NULL, 'DROP DIAMANTE EARRINGS PURPLE', '90177D');
INSERT INTO public.products VALUES (10, 2.93, 22, NULL, 3829, 2, NULL, NULL, 'DROP DIAMANTE EARRINGS GREEN', '90177E');
INSERT INTO public.products VALUES (10, 11.91, 14, NULL, 3830, 2, NULL, NULL, 'AMBER CHUNKY GLASS+BEAD NECKLACE', '90178A');
INSERT INTO public.products VALUES (10, 11.95, 14, NULL, 3831, 2, NULL, NULL, 'PURPLE CHUNKY GLASS+BEAD NECKLACE', '90178B');
INSERT INTO public.products VALUES (10, 5.87, 22, NULL, 3832, 2, NULL, NULL, 'AMBER FINE BEAD NECKLACE W TASSEL', '90179A');
INSERT INTO public.products VALUES (10, 5.86, 22, NULL, 3833, 2, NULL, NULL, 'PURPLE FINE BEAD NECKLACE W TASSEL', '90179B');
INSERT INTO public.products VALUES (10, 5.91, 22, NULL, 3834, 2, NULL, NULL, 'BLACK FINE BEAD NECKLACE W TASSEL', '90179C');
INSERT INTO public.products VALUES (10, 8.26, 22, NULL, 3835, 2, NULL, NULL, 'BLACK+WHITE NECKLACE W TASSEL', '90180A');
INSERT INTO public.products VALUES (10, 9.96, 22, NULL, 3836, 2, NULL, NULL, 'PURPLE AMETHYST NECKLACE W TASSEL', '90180B');
INSERT INTO public.products VALUES (10, 9.15, 14, NULL, 3837, 2, NULL, NULL, 'AMBER GLASS/SHELL/PEARL NECKLACE', '90181A');
INSERT INTO public.products VALUES (10, 9.18, 14, NULL, 3838, 2, NULL, NULL, 'AMETHYST GLASS/SHELL/PEARL NECKLACE', '90181B');
INSERT INTO public.products VALUES (10, 9.15, 14, NULL, 3839, 2, NULL, NULL, 'BLACK GLASS/SHELL/PEARL NECKLACE', '90181C');
INSERT INTO public.products VALUES (10, 2.90, 22, NULL, 3840, 2, NULL, NULL, 'AMBER 3 BEAD DROP EARRINGS', '90182A');
INSERT INTO public.products VALUES (10, 2.90, 22, NULL, 3841, 2, NULL, NULL, 'AMETHYST 3 BEAD DROP EARRINGS', '90182B');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3842, 2, NULL, NULL, 'BLACK 3 BEAD DROP EARRINGS', '90182C');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3843, 2, NULL, NULL, 'AMBER DROP EARRINGS W LONG BEADS', '90183A');
INSERT INTO public.products VALUES (10, 2.91, 22, NULL, 3844, 2, NULL, NULL, 'AMETHYST DROP EARRINGS W LONG BEADS', '90183B');
INSERT INTO public.products VALUES (10, 2.91, 22, NULL, 3845, 2, NULL, NULL, 'BLACK DROP EARRINGS W LONG BEADS', '90183C');
INSERT INTO public.products VALUES (10, 2.90, 22, NULL, 3846, 2, NULL, NULL, 'BLACK DROP EARRINGS W LONG BEADS', '90183c');
INSERT INTO public.products VALUES (10, 9.10, 22, NULL, 3847, 2, NULL, NULL, 'AMBER CHUNKY BEAD BRACELET W STRAP', '90184A');
INSERT INTO public.products VALUES (10, 9.05, 22, NULL, 3848, 2, NULL, NULL, 'AMETHYST CHUNKY BEAD BRACELET W STR', '90184B');
INSERT INTO public.products VALUES (10, 9.10, 22, NULL, 3849, 2, NULL, NULL, 'BLACK CHUNKY BEAD BRACELET W STRAP', '90184C');
INSERT INTO public.products VALUES (10, 9.15, 22, NULL, 3850, 2, NULL, NULL, 'BLACK CHUNKY BEAD BRACELET W STRAP', '90184c');
INSERT INTO public.products VALUES (10, 4.21, 22, NULL, 3851, 2, NULL, NULL, 'AMBER DIAMANTE EXPANDABLE RING', '90185A');
INSERT INTO public.products VALUES (10, 4.20, 22, NULL, 3852, 2, NULL, NULL, 'AMETHYST DIAMANTE EXPANDABLE RING', '90185B');
INSERT INTO public.products VALUES (10, 4.22, 22, NULL, 3853, 2, NULL, NULL, 'BLACK DIAMANTE EXPANDABLE RING', '90185C');
INSERT INTO public.products VALUES (10, 4.24, 22, NULL, 3854, 2, NULL, NULL, 'CRYSTAL DIAMANTE EXPANDABLE RING', '90185D');
INSERT INTO public.products VALUES (10, 2.93, 22, NULL, 3855, 2, NULL, NULL, 'AMETHYST HOOP EARRING FLORAL LEAF', '90186A');
INSERT INTO public.products VALUES (10, 2.93, 22, NULL, 3856, 2, NULL, NULL, 'CRYSTAL HOOP EARRING FLORAL LEAF', '90186B');
INSERT INTO public.products VALUES (10, 3.32, 22, NULL, 3857, 2, NULL, NULL, 'BLUE DROP EARRINGS W BEAD CLUSTER', '90187A');
INSERT INTO public.products VALUES (10, 3.33, 22, NULL, 3858, 2, NULL, NULL, 'GREEN DROP EARRINGS W BEAD CLUSTER', '90187B');
INSERT INTO public.products VALUES (10, 2.52, 22, NULL, 3859, 2, NULL, NULL, 'DROP EARRINGS W FLOWER & LEAF', '90188');
INSERT INTO public.products VALUES (10, 7.50, 22, NULL, 3860, 2, NULL, NULL, 'SILVER 2 STRAND NECKLACE-LEAF CHARM', '90189A');
INSERT INTO public.products VALUES (10, 2.91, 22, NULL, 3861, 2, NULL, NULL, 'SILVER/CRYSTAL DROP EARRINGS W LEAF', '90190A');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3862, 2, NULL, NULL, 'GOLD/AMBER DROP EARRINGS W LEAF', '90190B');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3863, 2, NULL, NULL, 'SILVER/AMETHYST DROP EARRINGS LEAF', '90190C');
INSERT INTO public.products VALUES (10, 8.84, 22, NULL, 3864, 2, NULL, NULL, 'SILVER LARIAT 40CM', '90191');
INSERT INTO public.products VALUES (10, 4.99, 22, NULL, 3865, 2, NULL, NULL, 'JADE DROP EARRINGS W FILIGREE', '90192');
INSERT INTO public.products VALUES (10, 4.24, 22, NULL, 3866, 2, NULL, NULL, 'SILVER LARIAT BLACK STONE EARRINGS', '90194');
INSERT INTO public.products VALUES (10, 6.57, 22, NULL, 3867, 2, NULL, NULL, 'PURPLE GEMSTONE BRACELET', '90195A');
INSERT INTO public.products VALUES (10, 7.50, 22, NULL, 3868, 2, NULL, NULL, 'BLACK GEMSTONE BRACELET', '90195B');
INSERT INTO public.products VALUES (10, 12.75, 22, NULL, 3869, 2, NULL, NULL, 'PURPLE GEMSTONE NECKLACE 45CM', '90196A');
INSERT INTO public.products VALUES (10, 12.70, 22, NULL, 3870, 2, NULL, NULL, 'BLACK GEMSTONE NECKLACE 45CM', '90196B');
INSERT INTO public.products VALUES (10, 4.99, 14, NULL, 3871, 2, NULL, NULL, 'BLACK GLASS BRACELET W HEART CHARMS', '90197B');
INSERT INTO public.products VALUES (10, 4.20, 22, NULL, 3872, 2, NULL, NULL, 'VINTAGE ROSE BEAD BRACELET RASPBERR', '90198A');
INSERT INTO public.products VALUES (10, 4.21, 22, NULL, 3873, 2, NULL, NULL, 'VINTAGE ROSE BEAD BRACELET BLACK', '90198B');
INSERT INTO public.products VALUES (10, 6.31, 14, NULL, 3874, 2, NULL, NULL, '5 STRAND GLASS NECKLACE BLACK', '90199A');
INSERT INTO public.products VALUES (10, 6.28, 14, NULL, 3875, 2, NULL, NULL, '5 STRAND GLASS NECKLACE AMETHYST', '90199B');
INSERT INTO public.products VALUES (10, 6.33, 14, NULL, 3876, 2, NULL, NULL, '5 STRAND GLASS NECKLACE CRYSTAL', '90199C');
INSERT INTO public.products VALUES (10, 6.27, 14, NULL, 3877, 2, NULL, NULL, '5 STRAND GLASS NECKLACE AMBER', '90199D');
INSERT INTO public.products VALUES (10, 4.19, 22, NULL, 3878, 2, NULL, NULL, 'PURPLE SWEETHEART BRACELET', '90200A');
INSERT INTO public.products VALUES (10, 4.21, 22, NULL, 3879, 2, NULL, NULL, 'BLACK SWEETHEART BRACELET', '90200B');
INSERT INTO public.products VALUES (10, 4.22, 22, NULL, 3880, 2, NULL, NULL, 'BLUE SWEETHEART BRACELET', '90200C');
INSERT INTO public.products VALUES (17, 4.19, 22, NULL, 3881, 2, NULL, NULL, 'PINK SWEETHEART BRACELET', '90200D');
INSERT INTO public.products VALUES (10, 4.19, 22, NULL, 3882, 2, NULL, NULL, 'GREEN SWEETHEART BRACELET', '90200E');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3883, 2, NULL, NULL, 'PURPLE ENAMEL FLOWER RING', '90201A');
INSERT INTO public.products VALUES (10, 2.94, 22, NULL, 3884, 2, NULL, NULL, 'BLACK ENAMEL FLOWER RING', '90201B');
INSERT INTO public.products VALUES (10, 2.94, 22, NULL, 3885, 2, NULL, NULL, 'RED ENAMEL FLOWER RING', '90201C');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3886, 2, NULL, NULL, 'GREEN ENAMEL FLOWER RING', '90201D');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3887, 2, NULL, NULL, 'PURPLE ENAMEL FLOWER HAIR TIE', '90202A');
INSERT INTO public.products VALUES (10, 2.91, 22, NULL, 3888, 2, NULL, NULL, 'WHITE ENAMEL FLOWER HAIR TIE', '90202B');
INSERT INTO public.products VALUES (10, 2.93, 22, NULL, 3889, 2, NULL, NULL, 'GREEN ENAMEL FLOWER HAIR TIE', '90202C');
INSERT INTO public.products VALUES (10, 2.92, 22, NULL, 3890, 2, NULL, NULL, 'PINK ENAMEL FLOWER HAIR TIE', '90202D');
INSERT INTO public.products VALUES (10, 3.34, 22, NULL, 3891, 2, NULL, NULL, 'PAIR OF ENAMEL BUTTERFLY HAIRCLIP', '90204');
INSERT INTO public.products VALUES (10, 1.66, 22, NULL, 3892, 2, NULL, NULL, 'LARGE MINT DIAMANTE HAIRSLIDE', '90205A');
INSERT INTO public.products VALUES (10, 1.66, 22, NULL, 3893, 2, NULL, NULL, 'LARGE CRYSTAL DIAMANTE HAIRSLIDE', '90205C');
INSERT INTO public.products VALUES (10, 4.99, 22, NULL, 3894, 2, NULL, NULL, 'GOLD DIAMANTE STAR BROOCH', '90206A');
INSERT INTO public.products VALUES (10, 4.99, 22, NULL, 3895, 2, NULL, NULL, 'CRYSTAL DIAMANTE STAR BROOCH', '90206C');
INSERT INTO public.products VALUES (10, 2.50, 22, NULL, 3896, 2, NULL, NULL, 'PAIR OF PINK FLOWER CLUSTER SLIDE', '90208');
INSERT INTO public.products VALUES (10, 2.03, 14, NULL, 3897, 2, NULL, NULL, 'PURPLE ENAMEL+GLASS HAIR COMB', '90209A');
INSERT INTO public.products VALUES (18, 2.07, 14, NULL, 3898, 2, NULL, NULL, 'GREEN ENAMEL+GLASS HAIR COMB', '90209B');
INSERT INTO public.products VALUES (26, 2.06, 14, NULL, 3899, 2, NULL, NULL, 'PINK ENAMEL+GLASS HAIR COMB', '90209C');
INSERT INTO public.products VALUES (10, 2.42, 22, NULL, 3900, 2, NULL, NULL, 'GREY ACRYLIC FACETED BANGLE', '90210A');
INSERT INTO public.products VALUES (10, 2.15, 22, NULL, 3901, 2, NULL, NULL, 'CLEAR ACRYLIC FACETED BANGLE', '90210B');
INSERT INTO public.products VALUES (10, 2.21, 22, NULL, 3902, 2, NULL, NULL, 'RED   ACRYLIC FACETED BANGLE', '90210C');
INSERT INTO public.products VALUES (10, 1.42, 22, NULL, 3903, 2, NULL, NULL, 'PURPLE ACRYLIC FACETED BANGLE', '90210D');
INSERT INTO public.products VALUES (10, 5.91, 22, NULL, 3904, 2, NULL, NULL, 'DIAMOND LAS VEGAS NECKLACE 45CM', '90211A');
INSERT INTO public.products VALUES (10, 5.91, 22, NULL, 3905, 2, NULL, NULL, 'JET BLACK LAS VEGAS NECKLACE 45CM', '90211B');
INSERT INTO public.products VALUES (10, 3.77, 22, NULL, 3906, 2, NULL, NULL, 'JET BLACK LAS VEGAS BRACELET ROUND', '90212B');
INSERT INTO public.products VALUES (10, 3.75, 22, NULL, 3907, 2, NULL, NULL, 'PURPLE LAS VEGAS BRACELET ROUND', '90212C');
INSERT INTO public.products VALUES (13, 0.90, 21, NULL, 3908, 2, NULL, NULL, 'LETTER "A" BLING KEY RING', '90214A');
INSERT INTO public.products VALUES (10, 0.83, 21, NULL, 3909, 2, NULL, NULL, 'LETTER "B" BLING KEY RING', '90214B');
INSERT INTO public.products VALUES (10, 0.83, 21, NULL, 3910, 2, NULL, NULL, 'LETTER "C" BLING KEY RING', '90214C');
INSERT INTO public.products VALUES (10, 0.87, 21, NULL, 3911, 2, NULL, NULL, 'LETTER "D" BLING KEY RING', '90214D');
INSERT INTO public.products VALUES (10, 0.85, 21, NULL, 3912, 2, NULL, NULL, 'LETTER "E" BLING KEY RING', '90214E');
INSERT INTO public.products VALUES (10, 0.76, 21, NULL, 3913, 2, NULL, NULL, 'LETTER "F" BLING KEY RING', '90214F');
INSERT INTO public.products VALUES (10, 0.84, 21, NULL, 3914, 2, NULL, NULL, 'LETTER "G" BLING KEY RING', '90214G');
INSERT INTO public.products VALUES (10, 0.85, 21, NULL, 3915, 2, NULL, NULL, 'LETTER "H" BLING KEY RING', '90214H');
INSERT INTO public.products VALUES (10, 0.78, 21, NULL, 3916, 2, NULL, NULL, 'LETTER "I" BLING KEY RING', '90214I');
INSERT INTO public.products VALUES (10, 0.86, 21, NULL, 3917, 2, NULL, NULL, 'LETTER "J" BLING KEY RING', '90214J');
INSERT INTO public.products VALUES (10, 0.89, 21, NULL, 3918, 2, NULL, NULL, 'LETTER "K" BLING KEY RING', '90214K');
INSERT INTO public.products VALUES (10, 0.84, 21, NULL, 3919, 2, NULL, NULL, 'LETTER "L" BLING KEY RING', '90214L');
INSERT INTO public.products VALUES (10, 0.87, 21, NULL, 3920, 2, NULL, NULL, 'LETTER "M" BLING KEY RING', '90214M');
INSERT INTO public.products VALUES (10, 0.84, 21, NULL, 3921, 2, NULL, NULL, 'LETTER "N" BLING KEY RING', '90214N');
INSERT INTO public.products VALUES (10, 0.73, 21, NULL, 3922, 2, NULL, NULL, 'LETTER "O" BLING KEY RING', '90214O');
INSERT INTO public.products VALUES (10, 0.81, 21, NULL, 3923, 2, NULL, NULL, 'LETTER "P" BLING KEY RING', '90214P');
INSERT INTO public.products VALUES (10, 0.83, 21, NULL, 3924, 2, NULL, NULL, 'LETTER "R" BLING KEY RING', '90214R');
INSERT INTO public.products VALUES (10, 0.83, 21, NULL, 3925, 2, NULL, NULL, 'LETTER "S" BLING KEY RING', '90214S');
INSERT INTO public.products VALUES (10, 0.78, 21, NULL, 3926, 2, NULL, NULL, 'LETTER "T" BLING KEY RING', '90214T');
INSERT INTO public.products VALUES (10, 0.29, 21, NULL, 3927, 2, NULL, NULL, 'LETTER "U" BLING KEY RING', '90214U');
INSERT INTO public.products VALUES (10, 0.85, 21, NULL, 3928, 2, NULL, NULL, 'LETTER "V" BLING KEY RING', '90214V');
INSERT INTO public.products VALUES (10, 0.73, 21, NULL, 3929, 2, NULL, NULL, 'LETTER "W" BLING KEY RING', '90214W');
INSERT INTO public.products VALUES (10, 0.75, 21, NULL, 3930, 2, NULL, NULL, 'LETTER "Y" BLING KEY RING', '90214Y');
INSERT INTO public.products VALUES (10, 0.78, 21, NULL, 3931, 2, NULL, NULL, 'LETTER "Z" BLING KEY RING', '90214Z');
INSERT INTO public.products VALUES (10, 7324.78, 22, NULL, 3932, 2, NULL, NULL, 'AMAZON FEE', 'AMAZONFEE');
INSERT INTO public.products VALUES (10, -3687.35, 22, NULL, 3933, 2, NULL, NULL, 'Adjust bad debt', 'B');
INSERT INTO public.products VALUES (10, 202.86, 22, NULL, 3934, 2, NULL, NULL, 'Bank Charges', 'BANK CHARGES');
INSERT INTO public.products VALUES (14, 49.64, 22, NULL, 3935, 2, NULL, NULL, 'CARRIAGE', 'C2');
INSERT INTO public.products VALUES (10, 495.84, 22, NULL, 3936, 2, NULL, NULL, 'CRUK Commission', 'CRUK');
INSERT INTO public.products VALUES (10, 72.48, 22, NULL, 3937, 2, NULL, NULL, 'Discount', 'D');
INSERT INTO public.products VALUES (10, 1.99, 14, NULL, 3938, 2, NULL, NULL, 'BOXED GLASS ASHTRAY', 'DCGS0003');
INSERT INTO public.products VALUES (10, 16.63, 13, NULL, 3939, 2, NULL, NULL, 'HAYNES CAMPER SHOULDER BAG', 'DCGS0004');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 3940, 2, NULL, NULL, 'ebay', 'DCGS0067');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 3941, 2, NULL, NULL, 'ebay', 'DCGS0068');
INSERT INTO public.products VALUES (10, 7.89, 22, NULL, 3942, 2, NULL, NULL, 'OOH LA LA DOGS COLLAR', 'DCGS0069');
INSERT INTO public.products VALUES (10, 12.72, 22, NULL, 3943, 2, NULL, NULL, 'CAMOUFLAGE DOG COLLAR', 'DCGS0070');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 3944, 2, NULL, NULL, 'ebay', 'DCGS0073');
INSERT INTO public.products VALUES (10, 16.13, 12, NULL, 3945, 2, NULL, NULL, 'SUNJAR LED NIGHT NIGHT LIGHT', 'DCGS0076');
INSERT INTO public.products VALUES (10, 3.10, 13, NULL, 3946, 2, NULL, NULL, 'BOYS PARTY BAG', 'DCGSSBOY');
INSERT INTO public.products VALUES (10, 3.13, 13, NULL, 3947, 2, NULL, NULL, 'GIRLS PARTY BAG', 'DCGSSGIRL');
INSERT INTO public.products VALUES (70, 290.91, 22, NULL, 3948, 2, NULL, NULL, 'DOTCOM POSTAGE', 'DOT');
INSERT INTO public.products VALUES (316, 375.57, 22, NULL, 3949, 2, NULL, NULL, 'Manual', 'M');
INSERT INTO public.products VALUES (10, 0.00, 22, NULL, 3950, 2, NULL, NULL, 'PADS TO MATCH ALL CUSHIONS', 'PADS');
INSERT INTO public.products VALUES (300, 37.05, 22, NULL, 3951, 2, NULL, NULL, 'POSTAGE', 'POST');
INSERT INTO public.products VALUES (10, 50.40, 22, NULL, 3952, 2, NULL, NULL, 'SAMPLES', 'S');
INSERT INTO public.products VALUES (10, 8.33, 22, NULL, 3953, 2, NULL, NULL, 'Dotcomgiftshop Gift Voucher £10.00', 'gift_0001_10');
INSERT INTO public.products VALUES (10, 15.04, 22, NULL, 3954, 2, NULL, NULL, 'Dotcomgiftshop Gift Voucher £20.00', 'gift_0001_20');
INSERT INTO public.products VALUES (10, 25.08, 22, NULL, 3955, 2, NULL, NULL, 'Dotcomgiftshop Gift Voucher £30.00', 'gift_0001_30');
INSERT INTO public.products VALUES (10, 33.57, 22, NULL, 3956, 2, NULL, NULL, 'Dotcomgiftshop Gift Voucher £40.00', 'gift_0001_40');
INSERT INTO public.products VALUES (10, 41.89, 22, NULL, 3957, 2, NULL, NULL, 'Dotcomgiftshop Gift Voucher £50.00', 'gift_0001_50');
INSERT INTO public.products VALUES (10, 2.55, 22, NULL, 3958, 2, NULL, NULL, 'Manual', 'm');
INSERT INTO public.products VALUES (28, 0.39, 22, NULL, 2, 2, NULL, NULL, 'GROOVY CACTUS INFLATABLE', '10080');
INSERT INTO public.products VALUES (18, 0.21, 22, NULL, 3, 2, NULL, NULL, 'DOGGY RUBBER', '10120');
INSERT INTO public.products VALUES (270, 6.42, 22, NULL, 19, 2, NULL, NULL, 'EDWARDIAN PARASOL BLACK', '15056BL');
INSERT INTO public.products VALUES (82, 1.09, 22, NULL, 1, 2, NULL, NULL, 'INFLATABLE POLITICAL GLOBE ', '10002');


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reviews VALUES (5, NULL, 1, 180, 7, NULL, 'This is my go to resource for great muffin recipes!  Many have become family, friends favorites:  Chocolate chip , multi berry, most of the recipes produce a delicious muffin!');
INSERT INTO public.reviews VALUES (5, NULL, 2, 155, 14, NULL, 'Gave as a gift.');
INSERT INTO public.reviews VALUES (5, NULL, 3, 66, 7, NULL, 'Noah Cordell is a self-made man with money, prestige and power.  Now he wants to marry a princess.  He''s chosen his princess sight unseen.  She is Princess Alice of Montedoro: feisty, intelligent, confident, and adventurous.  Noah meets his princess and all is not as it seems.  Soon he confesses his plan to the princess.  Can he tame her?  Can she unlock his heart?  Both are headstrong and used to getting their own way.  Passion ignites, but will lasting love result?');
INSERT INTO public.reviews VALUES (5, NULL, 4, 52, 9, NULL, 'Great artist! Very informative! Good condition!');
INSERT INTO public.reviews VALUES (5, NULL, 5, 191, 11, NULL, 'I''m a big fan of Glencoe within the last decade. Great book for teaching high school Biology I to prep my kids for their state test required for graduation. Love the Nat Geo inserts with real life connections & online resources.');
INSERT INTO public.reviews VALUES (5, NULL, 6, 86, 40, NULL, 'I''ve probably read 40 or more  of Kings books and this is 1 of my favorites. fast moving, suspenseful, nostalgic, and interesting subject. characters are well developed and story moves quickly. It''s right on the edge of being possible which I love when he writes something that''s almost plausible.');
INSERT INTO public.reviews VALUES (5, NULL, 7, 38, 25, NULL, 'As usual, this is a very well written, and timely book!  Mark Levin eloquently addresses very key subject matter.  All Patriots, that love America, support our Constitution, and plan to vote in the upcoming 2016 Presidential election, must read this book. His recent book Liberty and Tyranny, along with Plunder and Deceit, will prepare you to make an informed and educated decision with regard to the proper candidate in 2016!');
INSERT INTO public.reviews VALUES (5, NULL, 8, 63, 14, NULL, 'Written in a different manner, it had a lot of focus on what was important to them not their records. It is for someone that really wants to develop a balanced approach to history. For some reason it was a bit painful to see these men not just as soldiers but people.');
INSERT INTO public.reviews VALUES (5, NULL, 9, 105, 11, NULL, 'Love this book and the advice. It is inspirational and provides great info. I have already dropped 5 pounds of fat in one week!');
INSERT INTO public.reviews VALUES (5, NULL, 10, 15, 12, NULL, 'Penney Pierce is amazing!!  She soooooo gets it!!!');
INSERT INTO public.reviews VALUES (3, NULL, 11, 47, 13, NULL, 'My Rating: 3 out of 5 stars.<br /><br />Why did I decide to turn the pages? I had to see what happened to Jesse and Rowen.<br /><br />My Overall Thoughts/Impressions:  I enjoyed this one even though it frustrated me to no end. The characters in this novel were realistic, but they were all frustrating as all get out.<br /><br />They did so many things that bugged me so many times, but I was rooting for them the entire time.<br /><br />I don''t like books about one couple spread out over several novels typically. It drives me nuts, but I did enjoy this one.<br /><br />The writing was good and this one was better paced than the first one.<br /><br />The Characters: I liked them. The characters are normal, flawed beings. I enjoyed watching them grow.<br /><br />Major Strengths: The characters.<br /><br />Major Weaknesses: All the frustrations the characters put me through.<br /><br />So why 3 stars? It didn''t quite have enough to make it 4 stars, but I enjoyed it.<br /><br />Can I read the');
INSERT INTO public.reviews VALUES (5, NULL, 12, 66, 26, NULL, 'This is a classic. Every student of modern Islam should read it. The most thorough global history of Islam.');
INSERT INTO public.reviews VALUES (5, NULL, 13, 15, 8, NULL, 'Great read!');
INSERT INTO public.reviews VALUES (4, NULL, 14, 100, 25, NULL, 'A great intergalactic boot-camp style novel. There''s a lot of military jargon which to the uninitiated, is really confusing. The ending felt abrupt but it didn''t deter me from thoroughly enjoying this novel.');
INSERT INTO public.reviews VALUES (5, NULL, 15, 135, 12, NULL, 'Ghettoside is a behemoth of a book. At 366 pages, it''s longer than most other non-fiction books of its ilk and it packs punches on every single page. Tracing the homicide investigation of a 18-year-old boy murdered in a drive-by shooting, Leovy peels back the layers of complications which surround the lives and deaths of young black men in America.<br /><br />The narrative of this book takes place in Watts - a neighborhood of Southeast LA which is famous to most Americans for the riots there in the 1960s. It''s now a predominantly Latino neighborhood, but was historically where black families who migrated from the South - especially East Texas and Louisiana - settled. Leovy writes that it functioned a lot like a small Southern town - massive barbecues, town potlucks, everyone knowing everyone. This was both a benefit and a hindrance to the detectives working any case - everyone always saw a shooting, but no one would ever testify.<br /><br />What Leovy proves on every page is that the ');
INSERT INTO public.reviews VALUES (5, NULL, 16, 44, 26, NULL, 'The author clearly understands how markets work and explains the same<br />with a flourish. It''s a good book revealing how professionals really play the<br />market and, most importantly, how successful their &#34;strategies&#34; really are.');
INSERT INTO public.reviews VALUES (5, NULL, 17, 10, 40, NULL, 'Great book, very helpful information.  We buy a new edition every time we go because things change.');
INSERT INTO public.reviews VALUES (4, NULL, 18, 79, 24, NULL, 'The book arrived in time for my trip and I''m enjoying it.');
INSERT INTO public.reviews VALUES (5, NULL, 19, 13, 11, NULL, 'Great book. My baby smiles and laughs at the pages with faces!');
INSERT INTO public.reviews VALUES (5, NULL, 20, 102, 11, NULL, 'One of the best books I have read. Dave Stewart is an amazing man and his values are next to none in business. Just goes to show that good people with faith and being of service to others as your primary goal will always serve everyone.');
INSERT INTO public.reviews VALUES (5, NULL, 21, 30, 9, NULL, 'Deeply atmospheric and intensely captivating The Night Sisters by Jennifer McMahon held my interest from the get go and I was unwilling to set the book down until I had devoured it.  The story takes place in an extraordinarily creepy run down motel in rural Vermont where as children Amy, Piper, and Piper’s sister Margot enjoyed exploring and playing in the Tower Motel, that is until a secret was uncovered. As adults Piper and Margot have tried to put the past behind them until the night when Margot, in a panic, phones Piper that Amy is being accused of a heinous crime, drawing Margot and Piper back to their childhood and following the clues to what actually happened to Sylvie and Rose, the sisters who lived in the motel in the 50s.  The Night Sisters is brilliantly crafted, and is an exceedingly atmospheric, fast-paced suspense novel.  McMahon skillfully captures the reader’s attention with intertwining plotlines as well as including twisting the past with the present to create a deep');
INSERT INTO public.reviews VALUES (5, NULL, 22, 76, 7, NULL, 'Easy to read, very enjoyable. Nice stuff');
INSERT INTO public.reviews VALUES (5, NULL, 23, 21, 10, NULL, 'I love it, This has hit the/MY nail on the head more than not.<br />A great help in my life and a great way to start the day');
INSERT INTO public.reviews VALUES (5, NULL, 24, 71, 10, NULL, 'Like & Love');
INSERT INTO public.reviews VALUES (4, NULL, 25, 42, 9, NULL, 'Good collection of Conan Doyle''s stories, most of which I hadn''t read before. Would definitely recommend for any Sherlock fan.');
INSERT INTO public.reviews VALUES (5, NULL, 26, 86, 25, NULL, 'A great book. Provides a lot of information written so anyone can understand.');
INSERT INTO public.reviews VALUES (5, NULL, 27, 25, 3, NULL, 'I saw Deborah Feldman being interviewed on television about leaving the Orthodox community/faith.  Her book [[ASIN:1439187010 Unorthodox: The Scandalous Rejection of My Hasidic Roots]] is an excellent companion book to this one.  So is [[ASIN:159514675X Like No Other]], an excellent fiction book about a Lubavitcher girl meeting a boy in her Brooklyn neighborhood who comes from a vastly different background from the cloistered one she has known all her life.<br /><br />The author, born in 1963 which was a time when the world at large was undergoing major social upheavals.  The war in Vietnam; the riots throughout the United States; the riots protesting racism in America most notably in the deep south; the presidential assassination and the Beatles'' meteoric rise to fame were some of the landmarks in 1963.<br /><br />Chaya is a brilliant woman and an equally brilliant author.  She interviews various members of her family and studies her deep Jewish roots and the traditions that she has ');
INSERT INTO public.reviews VALUES (5, NULL, 28, 111, 26, NULL, 'Amazing book!  I love it so much.');
INSERT INTO public.reviews VALUES (4, NULL, 29, 129, 11, NULL, 'This is one of my favorite light novel series to have come out of Japan in recent years. This volume establishes Bell''s resolve and determination needed got the journey ahead. The actual release however left something to be desired. There were several grammatical errors and typos in this volume that stuck me as jarring and removed me from the story. This is the first time I''ve experienced such an issue with any of Yen Press'' LN translations. Over all it made this installment feel rushed, less polished than their other releases.');
INSERT INTO public.reviews VALUES (5, NULL, 30, 142, 26, NULL, 'I was pleased with the product.');
INSERT INTO public.reviews VALUES (5, NULL, 31, 13, 8, NULL, 'One of my son''s favorite book. I enjoy reading this so much more than Goodnight Moon.');
INSERT INTO public.reviews VALUES (4, NULL, 32, 125, 10, NULL, 'Came in great shape. After using it for a bit the pages started falling out.');
INSERT INTO public.reviews VALUES (5, NULL, 33, 64, 40, NULL, 'Very good.');
INSERT INTO public.reviews VALUES (5, NULL, 34, 56, 12, NULL, 'I really enjoyed this book! Historical fiction is my favorite and Angel Matthews did a great job!<br />You can really tell she put her heart and time into this book and I eagerly await her next.');
INSERT INTO public.reviews VALUES (5, NULL, 35, 174, 11, NULL, 'WONDERFUL... JIRO TANIGUCHI IS THE ZEN MASTER OF MANGA, AND HE DEPICTS THE EMOTIONS,NATURE AND LIFE IN SO SIMPLE BEAUTY. I LOVE TANUGUCHI''S DETAILED STYLE HERE...SUCH A DELIGHT AND ALTERNATIVE TONE IN MANGA.');
INSERT INTO public.reviews VALUES (5, NULL, 36, 50, 3, NULL, 'Handy gadget.');
INSERT INTO public.reviews VALUES (5, NULL, 37, 55, 24, NULL, 'This book ministered to me all summer; working at a secular summer camp. I kept rembering the &#34;Kingdom of God is 2 inches from the ground&#34; and &#34;My 8 feet of pool to walk can save a life&#34;.  Great word pictures for everyday life.');
INSERT INTO public.reviews VALUES (5, NULL, 38, 168, 13, NULL, 'The pictures are so clear and breathtaking.  I absolutely love this book.');
INSERT INTO public.reviews VALUES (5, NULL, 39, 172, 7, NULL, 'Didn''t realize it was loose leaf.  But hey, anything with Rob is 5 stars');
INSERT INTO public.reviews VALUES (4, NULL, 40, 198, 24, NULL, 'Great book very informative.');
INSERT INTO public.reviews VALUES (3, NULL, 41, 87, 9, NULL, 'Good ... a solid good ... I liked the telling of a good story ... although I found it a bit long and wordy ... very Italian in that sense.<br />There is a lot of history attached to the story which gives the reader a good background and understanding of Italy and the evolution of the social impetus for the migrations that took place. In perspective of today it gives us an understanding as to the present migration of people from war zones and economically deprived areas of the world - this is very much a history of all the people throughout the planet.');
INSERT INTO public.reviews VALUES (2, NULL, 42, 26, 13, NULL, 'Binding fell off during first week of class. Condition was misrepresented');
INSERT INTO public.reviews VALUES (5, NULL, 43, 125, 40, NULL, 'I have bought this book at least three or four times, when my kids were invited to birthday parties. This is such a great resource of actual information of all areas.');
INSERT INTO public.reviews VALUES (5, NULL, 44, 36, 3, NULL, 'One more for the collection! Can''t wait to start this one!');
INSERT INTO public.reviews VALUES (1, NULL, 45, 182, 40, NULL, 'Quite disappointed about this book ,I should not have order it.');
INSERT INTO public.reviews VALUES (4, NULL, 46, 152, 7, NULL, 'given as a gift');
INSERT INTO public.reviews VALUES (5, NULL, 47, 106, 13, NULL, 'I''ve read many books about North Korea.  This reads as quickly as a good novel; by a few pages in, I was weeping, later I was howling with laughter and then talking to the book.  Born in South Korea and raised in Southern California, Helie Lee bridges the cultural gap with understanding and humor.  Although this particular family escape occurred about 17 years ago, I would say reading this book is &#34;definitely recommended.&#34;');
INSERT INTO public.reviews VALUES (5, NULL, 48, 62, 25, NULL, 'Love love love this book! Not just the recipes, but the stories from New York natives and how they identify with food - a real treat to read, and use!');
INSERT INTO public.reviews VALUES (4, NULL, 49, 123, 3, NULL, 'Very informative especially for newly diagnosed patients who are feeling overwhelmed. This book left me feeling empowered and showed me steps I can take to manage my condition and work towards recovery, as opposed to being a victim of autoimmune disease.');
INSERT INTO public.reviews VALUES (4, NULL, 50, 96, 7, NULL, 'Still a better love story than Twilight.');
INSERT INTO public.reviews VALUES (5, NULL, 51, 145, 13, NULL, 'Love to read this series of Thunder Point. Keeps you up at night reading to the end of the book. Would suggest this series of books to others.');
INSERT INTO public.reviews VALUES (5, NULL, 52, 168, 7, NULL, 'I love J.D. Robb.  each year, her characters get better, deeper, and more real.  I have read almost all of this series and LOVE them.');
INSERT INTO public.reviews VALUES (3, NULL, 53, 152, 12, NULL, 'This book gets very long and doesn''t hold my children''s attention very well. I have yet to have them sit through the whole thing while reading it to them.');
INSERT INTO public.reviews VALUES (5, NULL, 54, 97, 9, NULL, 'Laura has done an outstanding job of guiding our organization to look at workplace wellness in a new light.  Her Ten Simple Steps helps us to take the traditional model of wellness to a whole new level.  I love her suggestion to go stealth to “sneak” wellness into our model so that it becomes so embedded we may not need a stand along wellness program.  Thank you Laura!  It was a great read with many takeaways that are already being implemented into our program.');
INSERT INTO public.reviews VALUES (5, NULL, 55, 170, 26, NULL, 'This study is a resource that I will refer to often as I seek rest in this fast-paced world.  Very practical applications!!!');
INSERT INTO public.reviews VALUES (4, NULL, 56, 145, 10, NULL, 'Good book');
INSERT INTO public.reviews VALUES (4, NULL, 57, 15, 3, NULL, 'A great book from a master teacher!');
INSERT INTO public.reviews VALUES (5, NULL, 58, 67, 3, NULL, 'Outstanding!!!!!!');
INSERT INTO public.reviews VALUES (5, NULL, 59, 32, 10, NULL, 'excellent');
INSERT INTO public.reviews VALUES (5, NULL, 91, 34, 25, NULL, 'Love every minute I spend reading this book. Characters are well-drawn and Mrs. Parker is Mrs. Parker in all her glory!  Two thumbs up. :)');
INSERT INTO public.reviews VALUES (5, NULL, 92, 145, 24, NULL, 'awesome book, great recipes');
INSERT INTO public.reviews VALUES (2, NULL, 60, 195, 7, NULL, 'Nothing new...at best you could say this is common sense.  This is only useful if you have plenty of money and just don''t want to waste it too easily; telling you that you can unplug your electronics, for instance, means you have them?<br />Nothing hard-core here, or inspirational either.<br />Get the Tightwad Gazette, or go visit Grandma.');
INSERT INTO public.reviews VALUES (5, NULL, 61, 26, 11, NULL, 'Must read--you really need to know HOW things in our cities got the way they are..');
INSERT INTO public.reviews VALUES (5, NULL, 62, 165, 3, NULL, 'exciting ideas to try. Never knew this existed. Feel like I have found a treasure.');
INSERT INTO public.reviews VALUES (5, NULL, 63, 79, 12, NULL, 'I love this book. I happen to be a runner, but that is certainly not a requirement of this book. The Oatmeal has a lot of hilarious comics, and many can be viewed on his website. I read most of these comics before purchasing the book, but the book was still delightfully enjoyable. I got it near the end of last year, read it the moment I got it and have not had it back since. It has been passed around from person to person to enjoy the hilarity in this easy and quick read.');
INSERT INTO public.reviews VALUES (5, NULL, 64, 48, 40, NULL, 'Great book about not only the history of The Flatiron building but Chicago architecture & the men behind the building of great iconic buildings.');
INSERT INTO public.reviews VALUES (5, NULL, 65, 75, 25, NULL, 'FUN !!!');
INSERT INTO public.reviews VALUES (4, NULL, 66, 18, 14, NULL, 'Handy book to have for wedding gigs. They are easy enough over all with  a few difficult shift changes. Overall I am happy with this product. I just got it today and still need to go thru entirely. I got it to supplement when I don''t have in my other wedding book.');
INSERT INTO public.reviews VALUES (2, NULL, 67, 124, 10, NULL, 'Very disappointing. With Gorey, it''s about the black ink crosshatch illustrations. I ordered five books. In all of them, the ink is grey. Not the stark black on white contrast that makes the whole thing work. Avoid this edition.');
INSERT INTO public.reviews VALUES (3, NULL, 68, 157, 24, NULL, 'Nora Roberts is my favorite author but this lacked her usual depth of characters.  Not her best!');
INSERT INTO public.reviews VALUES (5, NULL, 69, 98, 9, NULL, 'All of Sarah Water''s books are so special to me. This one is a little moodier than the rest. Slow paced but beautifully written.');
INSERT INTO public.reviews VALUES (5, NULL, 70, 27, 7, NULL, 'Excellent quality for the price, but the words inside are priceless!');
INSERT INTO public.reviews VALUES (5, NULL, 71, 137, 11, NULL, 'Whlie visiting Eddie''s Quilting Bee shop in CA, a customer was selecting fabric for a quilt made from a pattern in this book. Her husband was a geologist. The two of them had collected rocks from their trips. The pattern in this book is very pleasing to me. There were a couple other good patterns');
INSERT INTO public.reviews VALUES (4, NULL, 72, 69, 10, NULL, 'Great book! Very practical. I''m only a few days in, but the Lord is already doing a work!');
INSERT INTO public.reviews VALUES (1, NULL, 73, 36, 8, NULL, 'I do not believe he was a hero or do I believe in his views. It was a library add. Good looking book');
INSERT INTO public.reviews VALUES (3, NULL, 74, 167, 3, NULL, 'water marks.');
INSERT INTO public.reviews VALUES (1, NULL, 75, 88, 9, NULL, 'This book is a total waste of time. If you know anything at all about women this book will just refresh all that knowledge you already have. This book also has a christian bent which I frankly found annoying in the context of this subject.');
INSERT INTO public.reviews VALUES (5, NULL, 76, 179, 14, NULL, 'A very helpful and well-written commentary on Traherne''s poetry and vision.');
INSERT INTO public.reviews VALUES (5, NULL, 77, 118, 11, NULL, 'We have looked through this book with our kids several times now and each time the experience produces a fun discussion about the places they have visited - or want to visit someday. My kids are fascinated by the illustrations and make up creative stories each time we turn the page and unveil a new place in Chicago. I wouldn''t be surprised if my kids end up sharing this book with their children someday.');
INSERT INTO public.reviews VALUES (5, NULL, 78, 114, 3, NULL, 'Great read, wonderful rich Irish history!');
INSERT INTO public.reviews VALUES (5, NULL, 79, 155, 24, NULL, 'Nice product!');
INSERT INTO public.reviews VALUES (5, NULL, 80, 46, 11, NULL, 'The book looks great . I am satisfied with not only book but also the seller .');
INSERT INTO public.reviews VALUES (3, NULL, 81, 37, 25, NULL, 'I know - I know - something like a book is really hard to evaluate objectively. I might hate it whilst YOU might love it. So all I can offer is an opinion:<br /><br />I am disappointed.  I have tried valiantly to get into the book - I really have.  I''m about 65% of the way through, and I have had to put it down - probably forever.  It''s just too deep.  I''m not exactly sure what I was expecting, but what I got is a dry & complex examination/comparison of various investing strategies that are very difficult to grasp.  Sorry, Mr. Barak.');
INSERT INTO public.reviews VALUES (5, NULL, 82, 87, 14, NULL, 'I would highly recommend this book and all of Julie Miller''s Precinct books.  They are all excellent.');
INSERT INTO public.reviews VALUES (5, NULL, 83, 58, 3, NULL, 'Each card has three or four questions on it with answers and a rationale on the back. Some select all that apply questions. Using these to prep for my NCLEX. I have the Saunders text book so when I get a question wrong it tells me what topic I need to review so I go to my book and reference the topic. Very good purchase.');
INSERT INTO public.reviews VALUES (5, NULL, 84, 125, 24, NULL, 'I bought this for my daughter and she really liked it.  My son also read it and liked it too.');
INSERT INTO public.reviews VALUES (5, NULL, 85, 56, 13, NULL, 'Absolutely fantastic book!  In Hit by a Flying Wolf, Nicole takes you on a journey sharing her most personal experiences in working, training and loving the animals she had dedicated her life too.  She shares her personal joys, frustrations, tears and successes as an owner, trainer and educator of dogs and wolves.  No doubt we all have experienced many of these emotions with our own animals over the years. Nicole''s sense of humor will keep you laughing or crying throughout the entire book. Nicole demonstrates that patience, consistency and unconditional love are key in creating and maintaining a happy dog.....and happy home.');
INSERT INTO public.reviews VALUES (5, NULL, 86, 48, 11, NULL, 'Beautiful art and very famous part of Native American arts since the 1800s when Native artists started to<br />use the ledger papers to create images of their tribes and their tribal histories.  If the Ledger art had not<br />started it would have been years before Native artists became famous for painting and drawing...<br />Beyond just being art paintings some of these are historical documents of tribal histories.');
INSERT INTO public.reviews VALUES (5, NULL, 87, 172, 14, NULL, 'Brand new in the cellophane!!<br />Great deal for brand new books! Fast shipping ! 👌🏼👏🏼');
INSERT INTO public.reviews VALUES (5, NULL, 88, 151, 12, NULL, 'My mom enjoyed reading this book. Paid a great price for it also.');
INSERT INTO public.reviews VALUES (5, NULL, 89, 108, 8, NULL, 'Good condition');
INSERT INTO public.reviews VALUES (5, NULL, 90, 68, 3, NULL, 'Mary shares without holding back, bringing her readers into her home, painting a picture of an &#34;ordinary&#34; marriage which becomes extraordinary after a cancer diagnosis.  Her honesty is quite refreshing. Most wives will see themselves as they read about her marriage, and will gain a deeper understanding of what it means to take the marriage vows &#34;in sickness and in health&#34;. This is a very uplifting story, and it is told from a Christian viewpoint which is sadly lacking in much of nonfiction written today.');
INSERT INTO public.reviews VALUES (5, NULL, 93, 72, 12, NULL, 'My 4 year old and 3 year old girls love this book as well as my 1 year old niece. I like that it has several super heroines in it not just the well known ones. It has Wonder woman, Supergirl, Hawkgirl, Mera, Raven, Mary, and Batgirl. The page on Raven is kind of vague but other then that I love this one.');
INSERT INTO public.reviews VALUES (5, NULL, 94, 159, 11, NULL, 'Sequel to A Lantern in Her Hand.  Sequel not quite as good, but nice followup to ALIHH.  Thanks again!');
INSERT INTO public.reviews VALUES (4, NULL, 95, 110, 25, NULL, 'Is it Bizarro or is it just weird fiction? hard to say. One thing I will say is I have never read anything like this before. At first I wasn''t sure if this was for me. The diagrams and broken text made it feel a little disjointed, but I found myself keen to continue on this voyage of textual discovery into the strange. If you like fiction that is against the grain then give this a try. I suppose the way I would describe it is a journey through the movie bizarre. This is an engaging read for those looking for something a little different. 4 stars.');
INSERT INTO public.reviews VALUES (5, NULL, 96, 187, 11, NULL, 'Good read.');
INSERT INTO public.reviews VALUES (5, NULL, 97, 179, 25, NULL, 'Nice textbook<br />perfect condition<br />Thank You!');
INSERT INTO public.reviews VALUES (4, NULL, 98, 190, 25, NULL, 'Easy to understand information for the beginner.');
INSERT INTO public.reviews VALUES (1, NULL, 99, 78, 13, NULL, 'THE CASE IS MADE OF A CHEAP QUALITY. IT BROKE AFTER ONLY HAVING IT 2 DAYS. AND I STILL HAVENT RECEIVED THE OTHER CASES THAT IV ORDERED. THE CHEAP CASES DONT LAST LONG AT ALL. I HAD THE SAME PROBLEM WITH ANOTHER CASE THAT I PURCHASED ON YOUR WEBITE. NOT PLEASED WITH THE VENDORS AT ALL.');
INSERT INTO public.reviews VALUES (5, NULL, 100, 82, 40, NULL, 'This book introduces an important new voice in young men''s fiction. O''Connor writes with a crystalline rigor, as if his heart is pouring out on the page. He provides a deeply thoughtful, ethical perspective on masculinity and on our culture''s destructive impact on men, offering help to young adults struggling to define men''s truest callings for themselves.');
INSERT INTO public.reviews VALUES (5, NULL, 101, 106, 3, NULL, 'This is a superb memoir, because the author wrote her entire World War II story. She didn''t limit the story to her moments of combat. A war story that is only about combat becomes tedious. She included her dates with pilots, life in Africa, the liberation of Paris, getting to know Ernie Pyle, the Battle of the Bulge, and even the two pet dogs she picked up while overseas.');
INSERT INTO public.reviews VALUES (5, NULL, 102, 1, 24, NULL, 'great use it all the time');
INSERT INTO public.reviews VALUES (5, NULL, 103, 163, 25, NULL, 'Very faithful transcriptions for piano of pieces originally written for orchestra, opera, voice, or other instruments. They all sound wonderful in solo piano arrangements. Especially well transcribed are the Rachmaninoff Vocalise with all the complex orchestral harmonies intact, the Sleeping Beauty Waltz of Tchaikovsky is an interesting piano arrangement and the Faure Pavane also works very well for solo piano. A few are a bit difficult, such as the transcription of the18th Variation from the Rachmaninoff Rhapsody, which loses none of it''s power minus a symphony orchestra !!! Others are quite simple, such as the Air on a G String of Bach, or the Polovetsian Dance of Borodin, yet sound great in their simplicity. The Pachelbel Canon I feel runs on a little long and becomes a bit bombastic in the final pages, but generally Mr. Schultz knows how to make a piano sound rich and substantive in works that were otherwise written for different mediums. Excellent job of transcribing. I highly re');
INSERT INTO public.reviews VALUES (1, NULL, 104, 162, 11, NULL, 'Dreadful bore.');
INSERT INTO public.reviews VALUES (5, NULL, 105, 175, 7, NULL, 'The book was exactly what I expected. The delivery  was on time.');
INSERT INTO public.reviews VALUES (5, NULL, 106, 74, 8, NULL, 'Great Italian recipes.  Authentic recipes that are fantastic.  Good book.');
INSERT INTO public.reviews VALUES (5, NULL, 107, 95, 26, NULL, 'Wow, this book is shockingly good!  I try to pre-read the books my kids are scheduled to read, some I slog through, and some are treasures like Edward Bloor''s &#34;Tangerine&#34;.  The plot is strong, and the characters, unforgettable.  Not to mention I learned a lot about Florida and citrus growing; a win, win, win.  Thank you Edward Bloor!');
INSERT INTO public.reviews VALUES (5, NULL, 108, 9, 14, NULL, 'It really meets the needs of visually impaired seniors.');
INSERT INTO public.reviews VALUES (5, NULL, 109, 36, 40, NULL, 'I love the older books and I''m very interested in the WWll era.  This book is very informative and very helpful.  I would recommend it to everyone who loves to cook and also prepping for an emergency from weather or hazards.');
INSERT INTO public.reviews VALUES (5, NULL, 110, 191, 24, NULL, 'I like all her recipes,I use them alot');
INSERT INTO public.reviews VALUES (5, NULL, 111, 188, 12, NULL, 'crucified by christians is 1 of the most riveting books I have ever read. It truly to choose the heart every individual that has ever gone through a personal use the fiction at the hands of fellow christians and how it in tables want to become stronger in their faith, while being able to stand in the midst of adversity');
INSERT INTO public.reviews VALUES (5, NULL, 112, 151, 40, NULL, 'Book two in the series - does not disappoint, but proves (to me anyways) that it''s best to read the series in chronological order :)<br />Full of humour, twists and turns, you find yourself flying through the book, not wanting to put it to the side :)<br />Nothing is only black or white there, there are all sorts of grayish areas everywhere, the Kelly-clan once more saves and is being saved by their youngest, Jordan.<br />Lots of love in there, as I was reading, with wide smile I watched the couples form, leading to one wedding at the end.<br />There are really bad guys, not so bad guys and mostly good guys :)<br />I loved it. :)');
INSERT INTO public.reviews VALUES (3, NULL, 113, 5, 13, NULL, 'Book was only 150 pages, large print.  Was not a bargain.  More like a short story.');
INSERT INTO public.reviews VALUES (5, NULL, 114, 191, 14, NULL, 'Lyrical, beautiful prose, complex storyline that''s gripping and suspenseful. A unique masterful book, touching and thought-provoking.');
INSERT INTO public.reviews VALUES (5, NULL, 115, 181, 11, NULL, 'Not as good as the first one but still very cute and fun to read!');
INSERT INTO public.reviews VALUES (5, NULL, 116, 147, 12, NULL, 'Very good book The information is like none I have read before. It works! I have bought more than one copy of it since others borrow mine and don''t return it. I recommend it.');
INSERT INTO public.reviews VALUES (3, NULL, 117, 181, 12, NULL, 'So, you want to manage/run/work at a hedge fund right? well this book wont help you with that at all.<br />What this book will do is give you a basic understanding of a few hedge fund strategies including Long/Short, market neutral, leveraged.<br /><br />Another thing I liked is how the author explains how to measure performance, returns, and compensation structure - things that are still relevant today.<br />However, some of the stuff is kinda old and obsolete and is not relevant in today''s hedge fund world.<br /><br />This book is easy to follow but it does get a little complicated and confusing in the few technical sections.<br />I am not sure who the intended audience is for this book is but I believe the author is writing for possibly business school students who are not sure what they want to do when they graduate.<br /><br />I wish the author written another edition and maybe teamed up with another person to help explain and structure the more confusing sections better.<br />Al');
INSERT INTO public.reviews VALUES (5, NULL, 474, 18, 7, NULL, 'Loved it. Quality product.  In-time delivery.');
INSERT INTO public.reviews VALUES (5, NULL, 118, 10, 13, NULL, 'Wonderful! It is very well-written, clear in its propostitions and references. It is helping my research in ways I did not expect. I recommend it for anyone trying to understand the different concepts of visibility in the contemporary world.');
INSERT INTO public.reviews VALUES (5, NULL, 119, 17, 10, NULL, 'Love it!');
INSERT INTO public.reviews VALUES (3, NULL, 120, 99, 26, NULL, 'Couldn''t tell how big it was');
INSERT INTO public.reviews VALUES (5, NULL, 121, 195, 24, NULL, 'ITS TIME TO MAKE IT 100 PERCENT LEGAL<br />GOOD BOOK TO READ ABOUT HISTORY IN AREA.  I LIVE ON MARCO ISLAND . BUY THE BOOK .  JOE.');
INSERT INTO public.reviews VALUES (5, NULL, 122, 94, 12, NULL, 'Really enjoyed being taken back to the 1970''s when we lived in Cornwall');
INSERT INTO public.reviews VALUES (3, NULL, 123, 17, 10, NULL, 'haven''t tried it yet because i am colouring another book now but it looks like a fun colouring book');
INSERT INTO public.reviews VALUES (5, NULL, 124, 2, 40, NULL, 'Well-written and informative.');
INSERT INTO public.reviews VALUES (5, NULL, 125, 120, 14, NULL, 'Good book');
INSERT INTO public.reviews VALUES (5, NULL, 126, 154, 25, NULL, 'Just getting into it, but like it so far.');
INSERT INTO public.reviews VALUES (1, NULL, 127, 48, 40, NULL, 'Someone started the puzzles in my book forgot about it then sold it<br />I had to throw it out');
INSERT INTO public.reviews VALUES (5, NULL, 128, 163, 7, NULL, '&#34;That word! Connection. To be connected. To be bridged across any divides. To be plugged into a network. To be alive.&#34;<br /><br />I think this quote from ALL THIS LIFE summarizes the book quite well. It features a cast of diverse characters, created with such insight and empathy, they will stay with you long after the last page. ALL THIS LIFE is an entertaining read, but more than that, it is an unflinching portrait of American life in 2015--the technology, tragedy, humanity and triumph. The prose is beautifully written and the story is equal parts thought-provoking and emotionally complex. This may be Joshua Mohr''s best book yet and that is saying a lot. Highly recommend.');
INSERT INTO public.reviews VALUES (5, NULL, 129, 87, 26, NULL, 'Another Mini Aussie book I refer to frequently!');
INSERT INTO public.reviews VALUES (5, NULL, 130, 92, 13, NULL, 'Great product. Works perfect!! :)');
INSERT INTO public.reviews VALUES (5, NULL, 131, 170, 12, NULL, 'Erudite and lively..  Very helpful.  Ted');
INSERT INTO public.reviews VALUES (5, NULL, 132, 86, 10, NULL, 'I must read for professionals.');
INSERT INTO public.reviews VALUES (5, NULL, 133, 72, 13, NULL, 'A complete goldmine of Italian recipes!');
INSERT INTO public.reviews VALUES (5, NULL, 134, 47, 7, NULL, 'I am so hooked on Val Wood''s books ~ they are such feel-good stories we all need in these times of high drama everywhere. Her details about the UK in the period she chooses are excellent. THANKS, VAL~FOR WRITING SOOO MANY GREAT BOOKS! A very happy reader in Morgantown, WV.');
INSERT INTO public.reviews VALUES (5, NULL, 135, 41, 25, NULL, 'one of the best, most unique, and wonderfully amazing pieces of literature that exists');
INSERT INTO public.reviews VALUES (5, NULL, 136, 58, 14, NULL, 'The illustrations are adorable. So are the stories. I''m picky about books and really liked this one.');
INSERT INTO public.reviews VALUES (5, NULL, 137, 31, 13, NULL, 'Val Brelinski’s debut novel, The Girl Who Slept with God, drew my attention initially because of its cultural context, an evangelical Christian family in 1970’s rural Idaho. The story centers around fourteen-year-old Jory Quanbeck, who has been banished by her parents to an isolated house on the outskirts of town, along with her pregnant older sister, Grace. Although Jory’s understanding of what is normal has been hemmed in by a religion which bans “mixed bathing,” dancing, playing cards, makeup, movies, pierced ears, and miniskirts, among many other banal practices, she herself remains open to and curious about the world and the people around her. Her journey outside the strict confines of church and parental supervision leads her into the messy and mysterious life of high school, her first experience of romantic love, and a burgeoning understanding of the painful and sometimes tragic world of adults, including her own parents. The book is beautifully written, a delight to read for i');
INSERT INTO public.reviews VALUES (5, NULL, 138, 179, 8, NULL, 'this is the other book my grandsons college professor recommended and he found it to be quite useful, glad you had it available');
INSERT INTO public.reviews VALUES (5, NULL, 139, 147, 40, NULL, 'I''m one of the few that actually enjoys the Fantastic Four movies. I did not see the one from the 90s that was never released, only the Tim Story ones and the recent Josh Trank version that just came out. The latest one that just came out was a good story, even if there was only skit 20 minutes of action. The action was exciting though and the actors did a good job. However, after reading this comic, I think to myself, why isn''t more of this in the movies? Fantastic Four: Solve Everything was awesome! So much science fiction about different realms and the infinity gauntlet! The artwork was cool too, particularly the page with Galactus and Silver Surfer. I would love to read more of these and other Fantastic Four stories. I highly recommend this series');
INSERT INTO public.reviews VALUES (5, NULL, 140, 83, 7, NULL, '😃');
INSERT INTO public.reviews VALUES (4, NULL, 141, 182, 24, NULL, 'The ending kind of sucks but the journey leading up to it was so good that I''ll overlook it.');
INSERT INTO public.reviews VALUES (5, NULL, 142, 153, 40, NULL, 'Amazing. Very well written. A very comprehensive book for anyone thinking of owning and raising an iguana.');
INSERT INTO public.reviews VALUES (3, NULL, 143, 180, 7, NULL, 'This book is fairly comphinsive but lacked the information I was looking for on the fuel pump / oil injection pump.');
INSERT INTO public.reviews VALUES (5, NULL, 144, 194, 24, NULL, 'Full of pictures, really good for a general view of symbols');
INSERT INTO public.reviews VALUES (2, NULL, 145, 77, 24, NULL, 'I bought this book thinking that reading the daily entry aloud would be a fun way to begin an activities group in an Eldercare setting.  Nope.  While some of the articles are interesting, they are generally neither uplifting nor funny.');
INSERT INTO public.reviews VALUES (5, NULL, 146, 189, 12, NULL, 'This is the best way to spend time in the Bible when your unable to sit and read. I absolutely love it! Thank you Zondervan !');
INSERT INTO public.reviews VALUES (5, NULL, 147, 62, 40, NULL, 'A very interesting and helpful book. As a senior starting to write college applications, this book really gave me the tools and inspiration to write my essays.');
INSERT INTO public.reviews VALUES (5, NULL, 148, 187, 9, NULL, 'Always knew Texting while driving was bad… One to Go puts a whole new TWIST on this subject! Can you? Would you? WILL you become a killer in order to save your child? Tom Booker has to make that choice. When the angelic (yet totally demonic) Chad and Brit show up in the time paused reality… they will alter these events, but will require restitution… a soul for a soul! When time rewinds, Tom avoids the horrible event that would have taken the lives of his daughter and friends. He thinks ir was just imagination, but it soon become clear when he gets a text of the first death (the driver of the minivan). What ensues is a fast-paced thriller as Tom tries desperately to rise above the tasks he is required to do to save his daughter and her friends.  Mike Pace presents the reader with a superb tale of good vs evil. Which will triumph? This is a gut-wrenching story… and the ending…. Explosive.  I received this book to facilitate my review. All opinions are my own.');
INSERT INTO public.reviews VALUES (5, NULL, 219, 171, 7, NULL, 'For cat lovers, cat haters and people in love-hate relationships with their cats (like me).  What a hoot!');
INSERT INTO public.reviews VALUES (5, NULL, 475, 47, 10, NULL, 'Love the Cowboy Havamal');
INSERT INTO public.reviews VALUES (2, NULL, 149, 84, 25, NULL, 'I have also gone through a recent messy divorce myself. I was hoping to read something about financial infidelity which the book barely speaks about. Just a few sentences in the entire book that mention the author''s name was forged on documents. But I wanted to hear the story- what kind of documents, what legal battles pursued, what specifically became of your finances before and after this revelation? Or possibly tell the reader about the extremely flawed judges and family court system in St Tammany Parish which will make your head spin and be quite the page turner. Some of that is mentioned in this book but in far less detail then personal events are described.  I live in the greater New Orleans area (Northshore) and I was able to figure out all the people, churches, places, and such that the author was speaking about. The story does tell somewhat interesting biographical story of a journey in a divorced life. It was sort of like a newsstand gossip read for me that I enjoyed for tha');
INSERT INTO public.reviews VALUES (5, NULL, 150, 183, 24, NULL, 'Neat book. For the nerd in all of us. My boyfriend and I like to look up characters we don''t know yet.');
INSERT INTO public.reviews VALUES (1, NULL, 151, 10, 8, NULL, 'So sad and so disgusting.');
INSERT INTO public.reviews VALUES (5, NULL, 152, 153, 12, NULL, 'great book');
INSERT INTO public.reviews VALUES (4, NULL, 153, 155, 14, NULL, 'I was kind of surprised, this started out somewhat slow, but picked up good and turned out to be a great book.<br />Now I am wanting to get the previous book to this one, which was written before New 52.');
INSERT INTO public.reviews VALUES (5, NULL, 154, 28, 9, NULL, 'Very good journel excellent tracker for all things of concern when you are tweeking or beginning a health program until it becomes habit.');
INSERT INTO public.reviews VALUES (5, NULL, 155, 54, 10, NULL, 'Great book and very fast delivery very happy would recommended this book to anyone who grew up in Westchester ca In the 1960s - 1970s');
INSERT INTO public.reviews VALUES (3, NULL, 156, 28, 14, NULL, 'Over wordy needs to show moment diagrams.');
INSERT INTO public.reviews VALUES (4, NULL, 157, 192, 9, NULL, 'Good choice');
INSERT INTO public.reviews VALUES (5, NULL, 158, 114, 40, NULL, 'great');
INSERT INTO public.reviews VALUES (5, NULL, 159, 21, 26, NULL, 'Good');
INSERT INTO public.reviews VALUES (5, NULL, 160, 129, 8, NULL, 'As an intermediate cyclist who was new to Kentucky, I''ve gotten a lot of use and value out of this book. It''s got a wide variety of rides that have taken me to lots of places around the Bluegrass that I never would have found otherwise. Because rides vary from 4 to 100 miles, and from Easy to Moderate to Strenuous, it''s also been good to grow with. I''ve done about half of these rides, and have only found a couple mistakes, which were easy to spot if you looked at a map beforehand.');
INSERT INTO public.reviews VALUES (1, NULL, 161, 14, 40, NULL, 'I bought this book for my toddlers, because I thought they would like to learn about sharks. But it''s full of what I feel to be propaganda. I don''t want to explain an illustration of severed shark fins to them. And a poem encourages children to be rude if they are presented with shark fin soup. My kids will never even know what that is!');
INSERT INTO public.reviews VALUES (4, NULL, 162, 88, 13, NULL, 'A very brief guide to the museum.');
INSERT INTO public.reviews VALUES (5, NULL, 163, 72, 14, NULL, 'The Realism Challenge is an excellent addition to the studio library. The 152-page paperback is also dressed within a sturdy dust jacket. Mark Crilley divides the book into six sections covering a particular technique: simulating shadows, adding color, advanced surfaces, transparent objects, metallic surface and manufactured objects. There are five different pieces that the author walks you through in each topical chapter. All are beneficial to any level and genre of art.<br /><br />Crilley opens the book by expounding on the sudden popularity and growing fanbase from his YouTube demonstrations. He breaks down barriers and allows the artist feel more comfortable in their skin and capable of rendering amazing art. The author covers the main staples of his supplies necessary to complete a project in this genre. While stressing the importance of paper quality, he also provides his preferred watercolor palette along with brushes, colored pencils, and concluding with the subtle but integra');
INSERT INTO public.reviews VALUES (5, NULL, 164, 94, 3, NULL, 'Found this at a Goodwill and am *IN LOVE* with it. Homegirl should re-publish via a deck of oracle cards, as I use this book randomly by opening to a page and it is exactly what I need at that moment. I''m going to get her book on mothers as well. What a gift. These words uplift and they GET IT!');
INSERT INTO public.reviews VALUES (5, NULL, 165, 20, 40, NULL, 'The best and just what I was looking for thanks');
INSERT INTO public.reviews VALUES (5, NULL, 166, 113, 10, NULL, 'A beautiful story by a beautiful lady.  I''m proud to have been one of her friends.  What she didn''t say in the book is how courageously she handled the heartbreak she experienced in her life.  She lived a life filled with strength, compassion, honesty and integrity.  Her family and friends are blessed to have been a part of her life.');
INSERT INTO public.reviews VALUES (5, NULL, 167, 106, 25, NULL, 'This is not really about chess but a very complicated man with many faults to go with his incredible chess skills and also the people he was familiar with . The thing i found most incredible in this book is the way people will bend over backwards to accommodate someone who is mentally ill if they can gain from it, If he had never played chess i think he would have had much simpler and happy life. i really wont go into the details as there are many reviews that do . Having known very little of Bobby Fischers  background i found this a very informative read.');
INSERT INTO public.reviews VALUES (5, NULL, 168, 154, 10, NULL, 'Unbelievable that this is a first book. It made me think long and hard about what we convey to our children about our expectations. This book made me re-examine my own behavior and wonder about how many things I didn''t realize go on even in my own immediately sphere of influence. I was so moved, that I made my dad read it just for discussion. Although he is quite well read, he didn''t get it at all. Not even after I explained some of the nuances. Maybe it''s too deep to bridge the gender divide. I for one, am so happy that I read it.');
INSERT INTO public.reviews VALUES (5, NULL, 169, 182, 7, NULL, 'Good read for small dog owners so if you have a small dog, read it.');
INSERT INTO public.reviews VALUES (5, NULL, 170, 86, 9, NULL, 'Good overview of dolls of the 20th century');
INSERT INTO public.reviews VALUES (2, NULL, 171, 63, 7, NULL, 'Ok');
INSERT INTO public.reviews VALUES (5, NULL, 172, 164, 11, NULL, 'Lovely and comforting book for a child of any age! the artwork is also excellent.');
INSERT INTO public.reviews VALUES (5, NULL, 173, 2, 10, NULL, 'Terrific information re the many vortex areas in Sedona.');
INSERT INTO public.reviews VALUES (5, NULL, 174, 24, 40, NULL, 'I was looking for ways to improve the birth experience for my second child after my first has a lot of interventions.<br /><br />I liked this book a lot. It helped explain the position of nurses and doctors and why they recommend what they do. It helped me to prepare by hiring a doula, having a strong birth plan, and knowing wha too expect and what questions to ask.<br /><br />This isn''t the only book for birthing. This book should be a part of your suite of tools including a birthing class, a book on natural labor techniques, and finally finding a birth partner that will be able to support you with your choices.<br /><br />This book will also have you feeling more confident about how to work with your hospital team. This isn''t a fight between you and the hospital.  understanding both sides means that you can get everyone on your side in a more pleasant way.');
INSERT INTO public.reviews VALUES (5, NULL, 175, 200, 14, NULL, 'Definitely increased my score!  Only studied for 1 week with this book and raised my score 6 points.  If I had more time to fully study the whole book I''m sure it would of increased it by much more!  Definitely recommend');
INSERT INTO public.reviews VALUES (5, NULL, 176, 114, 11, NULL, 'As others have already mentioned, this book is a must for any serious programmer that wants to expand his toolbox. I find myself thinking about many of the themes in the book such as the &#34;broken window theory&#34;. The book is not academic at all and as the title suggest very practical to people who make a living writing code.');
INSERT INTO public.reviews VALUES (5, NULL, 177, 170, 13, NULL, 'Oh, how I loved this book!  What a powerful story of grace, reconciliation, hope, honor and courage.  I finished reading and had to just sit and stare at the pictures, awestruck at Minka''s legacy and the fact that God took a terrible tragedy and used it for good.  I loved seeing how Minka''s beautiful daughter''s family has not only survived, but thrived and how God took what could have been used for so much evil and used it for so much good.');
INSERT INTO public.reviews VALUES (5, NULL, 178, 98, 7, NULL, 'Great book for yoga practice and teaching!');
INSERT INTO public.reviews VALUES (5, NULL, 179, 41, 11, NULL, 'love it');
INSERT INTO public.reviews VALUES (4, NULL, 180, 149, 10, NULL, 'Tecnical, but accessible book.<br />I recomend');
INSERT INTO public.reviews VALUES (5, NULL, 181, 108, 7, NULL, 'This beautifully illustrated and tightly written classic should be on every child''s read-to-me list right next to &#34;The Napping House,&#34; also by Don and Audrey Wood.');
INSERT INTO public.reviews VALUES (5, NULL, 182, 14, 11, NULL, 'Unlike numerous other Viking/Norseman books, this tale is centered not around action and plunder (thought it does indeed contain that), but the ways of the Norse religion, and how it coexists and compares to Christianity and the Celtic/Druid way. Immensely thoughtful, and masterly portraying the average people of the time period, it tells the saga of Leif Erikkson''s young son in his quest to understand what his worth is to the world. From Iceland to Greenland, from Vinland to Ireland, take the journey with him--and learn about yourself in the process!');
INSERT INTO public.reviews VALUES (1, NULL, 183, 33, 3, NULL, 'I was looking forward to this book but was hugely disappointed. The guys are just above average and the photos are terrible. There isn''t any photographic skill, they look like amateur shots. You can find exponentially higher quality photos and guys just browsing tumblr. Had to return it because it was so bad.');
INSERT INTO public.reviews VALUES (5, NULL, 184, 141, 40, NULL, 'As a lover of mermaid mythology, I really wanted this book to be good and I was not disappointed. Monstrous Beauty was dark, tragic, hopeful, and romantic. Fama mixed mystery, curses, murder, and history to create a story of love gone awry that created consequences that lasted over a century.<br /><br />The book alternates between the events of the past and those of the present. The reader is given clues from the past and has to watch Hester try and catch up and piece them together in the present. While some may find this frustrating, I just found that it kept me reading, excited to see when Hester would finally solve the mystery.<br /><br />I also loved how Fama didn’t Disneyfy the mermaids or the myths surrounding them. Mermaid lore is disturbing and usually laced with death and Fama did not shy away from these elements in her book. There is a lot of mature content in this book, including murder, gore, rape, and sex. While none of it is too graphic (well, maybe some of the gore was ');
INSERT INTO public.reviews VALUES (5, NULL, 185, 179, 25, NULL, 'Like the other &#34;Dummies&#34; books I have, things are spelled out in plain English and easy to follow along.');
INSERT INTO public.reviews VALUES (5, NULL, 186, 189, 10, NULL, 'I originally purchased this book for a class. However I did truly enjoy reading it. It''s a great story and dies a good job documenting the lives of the characters.');
INSERT INTO public.reviews VALUES (5, NULL, 187, 153, 3, NULL, 'Aurora Rose Reynolds never fails to blow me away with her seemingly effortless storytelling style. She sucks you into every one of her stories from page one and leaves you wanting more with the last line. I buy her books without even reading the blurb, because no matter what new couple she decide to give their HEA, I know the story will never disappoint. One-Click this talented author''s fabulous work!');
INSERT INTO public.reviews VALUES (5, NULL, 188, 96, 40, NULL, 'love it');
INSERT INTO public.reviews VALUES (4, NULL, 189, 60, 11, NULL, 'I am really loving this story. I was very confused in the beginning because of the jumps back and forth in time, but once I figured out what was happening I would take the first paragraph or two in stride in order to settle where I was, and then delve in.<br /><br />The characters are interesting, and well built. The lead is neither all powerful, nor a weeping mess. Some of the adventures she gets away a touch easily, but there''s always a new issue coming around the corner. The comparison between the &#34;evil&#34; assassin, the golden haired boy, and the rough and tumble hunter are a good study in not judging a person too quickly. A good read.<br /><br />I haven''t read any of the prior stories, so there were a lot of unfamiliar terms. It took me a few chapters to settle who was who - the fact that there''s no clear cut good path/bad path makes that a little more difficult, but also makes for a better book so I call it a win. I''m looking forward to checking out the Graphic Novel of The');
INSERT INTO public.reviews VALUES (4, NULL, 190, 156, 11, NULL, 'Gardner Dozois is arguably the most famous science fiction writer you never heard of. He is science fiction''s most influential editor and anthologist, the ultimate insider who shaped two generations of speculative fiction writers and fans since first coming on the scene in 1970. Like many gifted editors, Dozois began as a writer of short fiction, developing unique story lines and an intellectually high level of prose that set him apart from the mainstream. The Visible Man, his first collection of short stories, was published in 1977 to high praise from peers and fans. Several others followed. But Dozois never moved far beyond short fiction, writing one solo novel and a couple collaborations before moving on to full-time editing. This despite emerging during the heady era of mass-market paperback madness when there was serious money to be made. Instead, Dozois took a decidedly less lucrative career turn as an editor of science fiction magazines -- Galaxy Science Fiction, If, Worlds of ');
INSERT INTO public.reviews VALUES (5, NULL, 191, 174, 13, NULL, 'One of the best books');
INSERT INTO public.reviews VALUES (5, NULL, 192, 199, 13, NULL, 'I was pleasantly pleased with the outworking of this  &#34;sneaker&#34; of a book by Don Everts.  It seems gimmicky with the use of the &#34;black verses&#34; motif, especially to those younger believes who have never read a &#34;red letter addition!&#34;  Though not agreeing with his clear statements of the unimportance of these black verses, he still makes his point quite clearly:  there is much to learn about Jesus Christ by how people responded to him in person.  The way he begins each chapter''s unique human reaction to Jesus with a score of scriptures from the Gospels is very effective.  There is an invitation to an existential understanding of who Christ was back then, and therefore a faith-strengthening opportunity for the reader today.  It puts one in a meditative perusal of just how being with Christ in Israel would have been like.  Not a bad exercise in our quasi-intellectual culture!  Reflecting on, amazement, worship,silence, prostration, being touched physically as well a');
INSERT INTO public.reviews VALUES (5, NULL, 193, 138, 24, NULL, 'Great book');
INSERT INTO public.reviews VALUES (2, NULL, 194, 196, 25, NULL, 'I know Madeline is a classic childhood story, and that years of children have enjoyed these books. But, I don''t like them. They seem trite and odd and nonsensical - but not in a whimsical childlike way but in a author-on-drugs sort of way. Even the bright and colorful illustration didn''t help! The first book was not too bad, but they went downhill fast. Boring, weird, and strange - not my cup of tea. I''m sure others will continue to enjoy these stories, but as for me - I don''t think I''ll introduce them to my future kids less I be forced into reading them repeatedly.');
INSERT INTO public.reviews VALUES (5, NULL, 195, 100, 12, NULL, 'I have read her other books and articles. She pretty much get''s it right.');
INSERT INTO public.reviews VALUES (5, NULL, 196, 44, 40, NULL, 'Great for a granddaughter on a car trip');
INSERT INTO public.reviews VALUES (5, NULL, 197, 81, 26, NULL, 'Came on time in perfect condition.Always loved Greyhawk  More so than Forgotten Realms.');
INSERT INTO public.reviews VALUES (5, NULL, 198, 197, 13, NULL, 'As Expected');
INSERT INTO public.reviews VALUES (5, NULL, 199, 1, 25, NULL, 'Loved it');
INSERT INTO public.reviews VALUES (5, NULL, 200, 141, 25, NULL, 'I love this book! When I came to the pages about WHY coffee is called a cup of Joe, I knew I had to give this &#34;a nod.&#34;<br /><br />Ryoko Iwata has included a picture of &#34;Joe,&#34; aka Josephus Daniels, a &#34;wicked handsome&#34; man and 41st Secretary of the U.S. Navy (page 79) and a brief write up on the following pages, explaining why we refer to coffee as &#34;A Cup of Joe.&#34;<br /><br />For those whose only drugs are alcohol and caffeine, did you know there''s an optimal way to use these to promote creativity and energy? I sure didn''t, but I do now! It has something to do with the cerebral cortex and brain receptors and adenosine (page 5).<br /><br />Come to find out, both elephants and honey bees like coffee (pages 17 & 29). I don''t know why I like facts of this nature, but I do.<br /><br />Every now and then, my local library gets an infusion of new cookbooks and I always check that section when I stop by. But, this is a book I''d buy in a nanosecond for the coffee l');
INSERT INTO public.reviews VALUES (5, NULL, 201, 197, 40, NULL, 'Mr. Mixon has written an excellent Book 2 in his Empire of Bones series.  The transition from Book 1 to Book 2 was seamless with just enough details to fill folks in on the details of the first book if you either missed it or it has been a while.  Still, you need to check back in with Book 1.<br /><br />I do not want to spoil the book.  It is an intriguing military sci-fi series in which a fleet commander seeks to reconnect the remains of the Empire with the long lost Earth homeworld.  He is joined by his half-sister, an Imperial princess. As the name implies, new alliances along the way are troubled by a conspiracy against the fleet and its young commander.');
INSERT INTO public.reviews VALUES (5, NULL, 202, 166, 9, NULL, 'This book does help.');
INSERT INTO public.reviews VALUES (5, NULL, 203, 116, 3, NULL, 'If you are an experienced programmer who is new ios 7 programming, buy this book.  This book appeals to the experienced programmer who has no trouble skipping past the subtleties of Objective C to focus on the subtleties of ios 7 using xcode 5.<br /><br />The book walks you through the build of a iphone application with the full code explained.  Each chapter takes on a new topic as you use the Interface Builder, iCloud Syncing, Core Data API, and divide up code into the Model-View-Controller design pattern.<br /><br />The book reads like an idealized coding exercise that results in a working prototype.  Richard calls out the bugs he encounters, the problems that need to be thought through, and the trade offs that need to be considered as folks move from the toy code of the book to production quality code.<br /><br />I wanted a guided tour in ios 7 that would leave you with working code.  This is well provided by this book.  I highly recommend it for those looking for this type of book');
INSERT INTO public.reviews VALUES (5, NULL, 204, 170, 40, NULL, 'Great book. great service');
INSERT INTO public.reviews VALUES (5, NULL, 205, 112, 7, NULL, 'Study guide is well laid out and easy to understand.  Particularly like the way Bible scripture is included in the study questions to help point the reader and study participants in the right direction and to understand how we, as Christians, need to be aware of the tricks and traps of &#34;Screwtape and Wormwood&#34; so that we are able to remain faithful through out our personal journeys.');
INSERT INTO public.reviews VALUES (4, NULL, 206, 188, 10, NULL, 'Harry Potter thought he had it bad.<br /><br />Tabitha Crum probably has the crummiest lot in life I''ve ever read, but she''s always looking to the bright side like a true optimist. When circumstances throw her into the very worst/best experience of her life, she finally has the chance to shine, and shine she does. With new friendships, feats of courage, and a mystery to solve, she faces the adventure of a lifetime.<br /><br />I love optimistic protagonists. LOVE. Tabitha left me wanting to be more positive and see the good in each moment and person. I thought I had the book all figured out half way through, but I have to hand it to Jessica Lawson. She took me by surprise.<br /><br />This is a lovely story following an admirable character, recommended to any young readers who love a good mystery.<br /><br />Content warning: Minor sequences of crime violence.');
INSERT INTO public.reviews VALUES (4, NULL, 207, 155, 25, NULL, 'its a text book.');
INSERT INTO public.reviews VALUES (5, NULL, 208, 151, 8, NULL, 'I didn''t even realize this was targeted towards younger readers.  Thoroughly enjoyable, especially for pet lovers!');
INSERT INTO public.reviews VALUES (5, NULL, 209, 31, 8, NULL, 'The secret study guide it''s  great to study  it has paragraph of the most important things and also have 50 questions with answer and explanation its very helpful I''m learning alot.');
INSERT INTO public.reviews VALUES (5, NULL, 210, 137, 7, NULL, 'I bought these for a young reader.');
INSERT INTO public.reviews VALUES (5, NULL, 211, 148, 9, NULL, 'Several good suggestions');
INSERT INTO public.reviews VALUES (5, NULL, 212, 125, 26, NULL, 'California Moderne and the Mid-Century Dream: The Architecture of Edward H. Fickett provides a fantastic look at some of the most extraordinary homes and commercial establishments in Southern California.  I highly recommend this book to students and fans of monumental architectural achievement.<br /><br />Sherry Lansing');
INSERT INTO public.reviews VALUES (5, NULL, 213, 183, 13, NULL, 'Mind Blown!  It''s like this book was written just for me.  This book has inspired many changes in my lifestyle.  I love reading books written by REAL people with REAL knowledge.  Well done Mr. Gorman!  I highly recommend this book to everyone.');
INSERT INTO public.reviews VALUES (5, NULL, 214, 139, 40, NULL, 'Excellent Service and good quality.');
INSERT INTO public.reviews VALUES (5, NULL, 215, 50, 24, NULL, 'This is a great government account book for all the people who want to sit in Government state accounts exam. Accounting is never be an easy exam for every one, but this book help a lot student to feel comfortable. This book helps me to understand the Keys to questions that &#34;give away&#34; the wrong (or right) answers- I get credit for some of the questions without really even knowing anything about them Details the EXACT STUDY PLAN for the CGFM test that I believe gives the most results in the least time- No matter if you''re studying for a week or a month, you won''t waste the precious study time you have on useless activities. Highly recommend to every one');
INSERT INTO public.reviews VALUES (5, NULL, 216, 152, 12, NULL, 'Hilarious!');
INSERT INTO public.reviews VALUES (5, NULL, 217, 152, 40, NULL, 'My son can''t put his Bible down!');
INSERT INTO public.reviews VALUES (5, NULL, 218, 42, 3, NULL, 'This book is great.');
INSERT INTO public.reviews VALUES (4, NULL, 220, 179, 9, NULL, 'I have mixed feelings about this book. I began reading it immediately after finishing French''s stellar debut novel, the award-winning In the Woods (which I raved about here), and while in The Likeness the initial premise is intriguing and a little out of left-field for the genre, it quickly devolved into something tedious and slow.<br /><br />While In the Woods did take its time and was a “slow-burn” story (for lack of a better term), it was still well told, interesting from start to finish, and read like a detective story with some literary flair. The Likeness reads more like a tense family drama or—sad, but true—something a step or two up from a soap opera. I don''t know if this says anything of the book''s quality, but I read In the Woods in a week; The Likeness took me nearly a month. I knew I wanted to finish it, but the prospect was not an exciting one. It was hard to want to pick it back up and keep going.<br /><br />It begins with Cassie Maddox (co-star of In the Woods and one o');
INSERT INTO public.reviews VALUES (5, NULL, 221, 23, 3, NULL, 'One of the most intense books I have read in a long time.  Constant action, plot twists and revelation. Sorry to see the series end.');
INSERT INTO public.reviews VALUES (5, NULL, 222, 88, 14, NULL, 'Great book to follow a theatre production...interesting to a 5 year old about to learn to read!');
INSERT INTO public.reviews VALUES (4, NULL, 223, 36, 40, NULL, 'Thank you');
INSERT INTO public.reviews VALUES (5, NULL, 224, 66, 25, NULL, 'This book is outstanding as one has come to expect from John Wukovits.  One can only marvel and wonder at the courage and tenacity of the men of the Laffee, while at the same time respecting the dedication of the Japanese pilots who acted in a way so contrary to our western beliefs.  It also gives us a vivid insight into the effect a true leader can have on those whom he leads.  It is an example to any young officer of the truth of the premise  that loyalty from the top down breeds loyalty from the bottom up. In my experience, every great leader manifested this trait.  I highly recommend this book.');
INSERT INTO public.reviews VALUES (5, NULL, 225, 73, 9, NULL, 'GOD BLESS YOU! PERFECT! MUCH THANKS!');
INSERT INTO public.reviews VALUES (5, NULL, 226, 18, 9, NULL, 'It''s exactly what I wanted');
INSERT INTO public.reviews VALUES (5, NULL, 227, 105, 11, NULL, 'This is my go-to cookbook right now. My mom gave it to me a few months ago and I''ve hardly used another cookbook since. The first time I cooked out of this book (using 3 different recipes for a whole dinner), my boyfriend said it was the best meal I''ve ever cooked. Everything is so simple, nutritious, inspiring, and delicious! This man is a genius.<br /><br />Marco Canora left an early impression on me when I went to his restaurant Hearth when I was in college, and he continues to be such a strong presence in my food life.');
INSERT INTO public.reviews VALUES (5, NULL, 228, 31, 24, NULL, 'Great book. If you want to know what it is really like being in the Jackson family, this book will give that to you. Also, it will explain how two of MJ''s brothers have children with the same woman. The author had a crazy relationship with Jermaine and she detailed that in the book. I recommend fans to read the book.');
INSERT INTO public.reviews VALUES (5, NULL, 229, 87, 8, NULL, 'If you’re a widow of a certain age, this book is for you.  The three widows in the book were different from the very beginning.  And so are Alyce’s newer friends.  And yet… there’s this thing in common - all the things you feel, but are afraid to admit.  A fast read – at times funny, at times poignant.  “What’s not to enjoy.”');
INSERT INTO public.reviews VALUES (3, NULL, 230, 13, 12, NULL, 'This small book is informative about this Shaker community, its outgrowth of the Shaker movement and its relationship to earlier colonies in New York and Massachusetts.  The Shakers were a curious people that present some mystery. Born out of the tragedy of its founder in England, the tenants of the religion are briefly covered.  It seemed the rules were somewhat loose, the theology was incomplete, and the practitioners were not highly educated.  Legal issues of the community were covered as well as some commentary of the overall religious fervor fomenting in the early nineteenth century.  The Shakers were industrious and had a good sense of design.  I gave the book a lesser grade because it went into more detail than I found useful.  Perhaps derived from a scholarly paper, the book has biographical data and information about other events extra to the basic details of the community.  It did, however, address the demise of the movement and the community with a brief overview of the pro');
INSERT INTO public.reviews VALUES (5, NULL, 231, 97, 7, NULL, 'Thoroughly researched and full of excellent images an foot notes to illustrate the text.');
INSERT INTO public.reviews VALUES (5, NULL, 232, 183, 13, NULL, 'loving them');
INSERT INTO public.reviews VALUES (5, NULL, 233, 127, 25, NULL, 'As I read Christmas Travelers I became curious about each character and how they all connected. I could picture their personal journeys, the joys and the sorrows. I would love to see this as a holiday story during Christmas and again for a Christmas in July reminder of what can happen when one believes.');
INSERT INTO public.reviews VALUES (4, NULL, 234, 138, 14, NULL, 'I cannot say I read this cover to cover but out of all the parenting books I have tried this one was by far the best and probably the only one worth anything at all.  Why?  The basic premise is easy to follow.  1.  State the problem 2.  Work with Child to solve the problem.  Yes, I think there are actually more steps which I cannot remember.  Still, these two seem to work sort of, especially the part about acknowledging the problem.  Kids really like when you show an honest effort to understand their issue.  Honestly, that is all I remember about this book but when my kid is throwing a fit I will often think to myself &#34;ok, state the problem&#34; and they will often become noticeably calmer. I got this when my difficult kid was pre-verbal.  My less difficult kid also responds well to these tactics except when tired in which case, all bets are off.  Fatigue does strange things to small children.<br /><br />Actually, just remember that last point:  &#34;fatigue can do strange things ');
INSERT INTO public.reviews VALUES (5, NULL, 235, 128, 12, NULL, 'Hands down the most important theoretical contribution to my dissertation.  I absolutely love this book.  There is so many data, but it''s packaged in an easy to read and even entertaining way.');
INSERT INTO public.reviews VALUES (5, NULL, 236, 172, 26, NULL, 'Been using it for the past couple years:)');
INSERT INTO public.reviews VALUES (1, NULL, 237, 32, 14, NULL, 'I''ve read thousands of books in my lifetime, and this has to be high in the list of the most boring. Also, I''ve come to the realization that a Stephen King blurb means absolutely nothing. Save your $, folks. This one''s a real stinker.');
INSERT INTO public.reviews VALUES (5, NULL, 238, 77, 3, NULL, 'Pretty artwork and cute way to teach seasons. Nothing scary.');
INSERT INTO public.reviews VALUES (5, NULL, 239, 18, 8, NULL, '9-year old loves these.');
INSERT INTO public.reviews VALUES (5, NULL, 264, 194, 14, NULL, 'One of my favorites of Cornwell''s books! Very interesting information.');
INSERT INTO public.reviews VALUES (5, NULL, 265, 40, 11, NULL, 'Impeccable condition. Absolutely the best condition of any book I''ve purchased on Amamzon. Very pleased.');
INSERT INTO public.reviews VALUES (5, NULL, 266, 145, 24, NULL, 'More informative than other crystal books I have bought. Love my stones and crystals.');
INSERT INTO public.reviews VALUES (5, NULL, 267, 97, 10, NULL, 'Especially loved White Flour story');
INSERT INTO public.reviews VALUES (5, NULL, 268, 98, 40, NULL, 'Really good book and very much on point.');
INSERT INTO public.reviews VALUES (4, NULL, 240, 22, 26, NULL, 'In Troubled Waters, flooding is causing problems in the small towns surrounding River Heights. Nancy and the gang team up with Helping Homes, where they will build apartments for flood victims. Of course, this ends up leading to another mystery for Nancy when someone starts spray painting messages on the apartment walls and causing other problems and set backs. It all seems to revolve around the famous basketball player, J.C. Valdez, who is helping out on this community project. However, there is more to it than just that, and the old building the apartments are being built in appears to have some possible money hidden inside.<br /><br />Overall, this was a fast, fun read. An adventurous plot and an interesting twist in the end.');
INSERT INTO public.reviews VALUES (4, NULL, 241, 57, 11, NULL, 'This is the first book in the Cedar Springs series and my first read of this author''s work. This was a good read about a dedicated fire chief and a beautiful widow who literally falls at his feet. Summer is afraid to start a relationship, it being less than 2 years since her husband was tragically killed. At first, Cameron is determined to get to know Summer better but becomes insecure when she reminds him of his ex-wife. Their relationship seemed to be a two steps-forward-one-step-back kind of dance. They both had issues from past relationships that affected their present. Cameron also had a tendency to stick his foot in his mouth.  I enjoyed the interactions between Summer and her three sisters (named after the seasons) and moments of humor from several secondary characters. I thought the characters and plot were well-developed even though a lot was packed into this story. I appreciated the spiritual content in this story and how both Summer and Cameron had grown by the end of this ');
INSERT INTO public.reviews VALUES (5, NULL, 242, 4, 7, NULL, 'I use these in group psychotherapy with women in recovery from alcohol and substance use. I have then reflect on the thought and the cards sometimes prompt some deep insights. I also share them with my coworkers.');
INSERT INTO public.reviews VALUES (5, NULL, 243, 143, 12, NULL, 'My new favorite Lisa Jackson. Twins, love them or fear them. I will be watching twins with a jaded eye from now on. So many story lines twining around which ones connect will keep you guessing until the very last chapter. This page turner held my attention from the very beginning.<br /><br />Rick Bentz and Reuben Montoya are still chasing Father John when evidence appears that the 21 Killer has returned. How can Bentz even consider retiring with these pieces of unfinished business hanging in limbo.<br /><br />Brianna Hayward is a psychiatrist who leads a support group for twin-less twins. She herself lost her sister Arianna years ago and feels their pain. When a member of the group fears for the lives of her twin daughters Brianna must make the authorities listen and take action.<br /><br />There is always an element of romance without changing genres. Jase is our lucky guy who blends well into several facets of the story.');
INSERT INTO public.reviews VALUES (3, NULL, 244, 175, 3, NULL, 'Interesting collection of case studies.');
INSERT INTO public.reviews VALUES (5, NULL, 245, 4, 12, NULL, 'Awesome book of gems just waiting to be read. There''s a lot of heart and feelings written in this book! It''s filled with funny stories, observations and some heartfelt writings.');
INSERT INTO public.reviews VALUES (4, NULL, 246, 42, 9, NULL, 'great book for kids to learn about trucks');
INSERT INTO public.reviews VALUES (5, NULL, 247, 73, 25, NULL, 'Informative');
INSERT INTO public.reviews VALUES (3, NULL, 248, 31, 25, NULL, 'Thoroughly enjoyed the first two books of the Expanse. For me it was a real eye opener with a fresh turn on space travel in our limited solar system. Most modern sci-fi has moved on to interstellar stories. For me this  feels like a stepping stone before mankind figured out how to travel to the stars. Life in low and no gravity, combat in space and life on board a space ship is explored and written about with marvelous creativity. The first two books were a delight in this respect. It is my feeling that the authors left some of that behind in Abadon''s Gate. It feels hurried and forced.  I am not sure if I will purchase the next book in the series. Perhaps the authors should have contained the series to only three books.');
INSERT INTO public.reviews VALUES (5, NULL, 249, 90, 12, NULL, 'This book is one that can be read over and over, buy it!');
INSERT INTO public.reviews VALUES (5, NULL, 250, 74, 10, NULL, 'Excellent recipes.');
INSERT INTO public.reviews VALUES (3, NULL, 251, 165, 26, NULL, 'I''m disappointed. This book seems disjointed and not really at all about the gospel of Thomas. Seems to be more about the gospel of John. The author seems to be on the verge of dismissing Christianity as an obvious myth. But, can''t quite bring herself too. As to Bishop Irenaeus'' extreme and aggressive defense of the Gospel of John. Am I the only one who thinks it was the good Bishop that wrote the Gospel of John.  That would account for his very aggressive defense.');
INSERT INTO public.reviews VALUES (5, NULL, 252, 105, 13, NULL, 'She is amazing you feel so much better about your self after you listen to the amazing brene brown');
INSERT INTO public.reviews VALUES (5, NULL, 253, 192, 13, NULL, 'Debbie is a great author - I wish  had started reading her books from the first to the present instead of out of sequence');
INSERT INTO public.reviews VALUES (4, NULL, 254, 195, 40, NULL, 'Zombies v. ninjas: origins by Barnes is a serious study if the undead rise up. The ninjas belong to an Irish karate club and are the only line of defence against the zombies. Even the police and the army support them. The main protagonist is a clinical psychiatrist who enjoys the martial arts. He is not overly successful in the forays and is faced with a sticky, watery end. One has to read the sequel to see if he survives. There is a community of both undead and alive, babies born already walking, their mothers conceiving without a male. Lots of ideas thrown into the mix though I wasn''t particularly horrified.');
INSERT INTO public.reviews VALUES (5, NULL, 255, 83, 25, NULL, 'Great!');
INSERT INTO public.reviews VALUES (5, NULL, 256, 41, 7, NULL, 'A clever idea for a bedtime story that''s well-executed and beautifully illustrated.  I gave one copy away to a family with a young child (it makes a great gift!), but I''m keeping another copy for the grandchildren I hope to have!');
INSERT INTO public.reviews VALUES (4, NULL, 257, 39, 26, NULL, 'This is the story of a kind hearted young man out to confirm that the old fashioned basic goodness of people still exists today. The author recounts a wealth of tales he exchanges with the people he meets as he spends several summer weeks hitch hiking from Colorado back home to Upstate New York, hoping to make it by Fathers Day. I thoroughly enjoyed learning the tricks and trials of this traveler with a positive attitude and the folks who encourage...or threaten...him along the way.');
INSERT INTO public.reviews VALUES (5, NULL, 258, 107, 13, NULL, 'Very funny');
INSERT INTO public.reviews VALUES (5, NULL, 259, 38, 14, NULL, 'Really good first book from these authors, really looking forward to the next! I enjoyed how the two sisters shared the narration. You got to get to know each one intimately. There are a few grammar/typo errors, but they don''t disrupt the storyline. This is the perfect read for teens or fantasy readers. And it is a quick read too!');
INSERT INTO public.reviews VALUES (5, NULL, 260, 22, 12, NULL, 'I don''t think there is any of J.D. Robb books I don''t like. I just wish I can have them all!');
INSERT INTO public.reviews VALUES (5, NULL, 261, 93, 40, NULL, 'I''m waiting for the next edition.');
INSERT INTO public.reviews VALUES (5, NULL, 262, 99, 25, NULL, 'Book was as described and quickly shipped. Thank you.');
INSERT INTO public.reviews VALUES (5, NULL, 263, 43, 13, NULL, 'I used it with her on-line workshops. A great self-help book.');
INSERT INTO public.reviews VALUES (5, NULL, 269, 83, 13, NULL, 'This is a beautiful book about trauma and healing that will touch your heart and perhaps speak to your inner child.');
INSERT INTO public.reviews VALUES (5, NULL, 270, 195, 26, NULL, 'Incredible book about a Incredible movie.....Nuff said');
INSERT INTO public.reviews VALUES (5, NULL, 271, 190, 12, NULL, 'Do dreams actually come true? Yeah,they sure do...for Kevin and Shelby! True...they did go through some very rough patches along the way but with an abundance of love, faith and courage they conquered the odds and made their dreams a reality.&#34;Feels like a dream&#34; had me in tears...otherwise sad ones,otherwise happy ones...over and over again! A story that touches your heart and soul...of two people who gave eachother the greatest gift...that of true love and sticking together through thick and thin,no matter what. 5 beautiful & soothing stars for this beautiful novel & you,Isabelle Peterson!');
INSERT INTO public.reviews VALUES (5, NULL, 272, 84, 40, NULL, 'This book is HILARIOUS!  Sloan''s view on the everyday issues of life are funny and spot-on.  Throughout the book, I chuckled, laughed out loud,  and even cried from laughing so hard.  The only bad part about the book was when I came to the end, because I could have read on and on.  I look forward to more books by this author!');
INSERT INTO public.reviews VALUES (5, NULL, 273, 183, 11, NULL, 'Within a 24-hour time span of owning this book, my almost two-year-old son wanted to read this book SIX TIMES! He was even asking for it by title! As a child reader, he seemed captivated by the colorful illustrations and the lovely use of bold beautiful blocks of color. As a parent reader, the themes of (literally) thinking outside of the box and creating for the sake of creating, above and beyond what any assignment calls for is a crucial lesson for children to learn as young as possible. This is one of many Reynolds books we own because the themes and morals the books present with colorful, joyful pictures are so special and vital to little ones growing up today. We are thrilled to have Going Places as our  most addition to our bookshelf; it has become a fast favorite!');
INSERT INTO public.reviews VALUES (5, NULL, 274, 190, 9, NULL, 'I love the way this book has been laid out… story, analysis of story by author, and then an exercise is given. I learned a lot from this book as far as the structure of a story and the analysis at the end of each story is so detailed it helped me see the structure of each story when I re-read them.  I would recommend this book to anyone who has a passion for writing.');
INSERT INTO public.reviews VALUES (5, NULL, 275, 101, 9, NULL, 'A very inspirational book about a genuine couple and their true life struggles before an extraordinary opportunity changed their lives.  They care so much about helping others succeed in life, encouraging them to never give up and follow their dreams.  Chris and Debbie Atkinson have made such a positive impact on so many lives including mine.  Don’t wait, buy this book today, it is a must read!  I promise you won’t be disappointed.  - Jeni Sherrard');
INSERT INTO public.reviews VALUES (5, NULL, 276, 91, 14, NULL, 'I purchased this book on Monday around noon and received it on a Wednesday. Saved me so much money compared to buying it at my college''s bookstore. I purchased it brand new, it had shelf wear on it but nothing to be upset about. I''m very happy with my purchase and the quickly delivery!');
INSERT INTO public.reviews VALUES (4, NULL, 277, 132, 10, NULL, 'This is a fun book for kids who play violin but it doesn''t focus on anyone one type of song and I think that hurts it. It has some christmas, classical, nursery rhymes even some music from other countries we had never heard before. I would have liked to seen more nursery rhymes and folk music.<br /><br />Since it didn''t list the songs, I will list them here:<br />Aloutte<br />Amazing Grace<br />America the Beautiful<br />Arroz Con Leche<br />Aserrin, Aserran<br />Aura Lee<br />Cielito Lindo<br />For He''s a Jolly Good Fellow<br />Frere Jacquees<br />Go Tell Aunty Rhody<br />Good Morning to All<br />Greensleeves<br />Jingle Bells<br />La Cucaracha<br />La Donna e Mobile<br />Las Manaitas<br />London Bridge is Falling Down<br />Mary Had a Little Lamb<br />Menuettt in G<br />My Bonnie Lies over the Ocean<br />Ode an die Freude<br />Oh Susanna<br />Old Macdonald Had a Farm<br />Row Row Your Boat<br />Scarborough Fair<br />Stile Nacht, heilige Nacht<br />Sur le Pont d''Avignon<br />The House');
INSERT INTO public.reviews VALUES (5, NULL, 278, 89, 9, NULL, 'Enchanting read! Marie Louise shares some of the high points of her life and shows how the experiences, both positive and negative, helps her to be the caring woman she is today. She shows both strength and compassion in her thoughts and memories. Charming book! Beautiful person!!');
INSERT INTO public.reviews VALUES (5, NULL, 279, 186, 12, NULL, 'Un libro extraordinario, leerlo es como transportarse a un mundo realmente vivido, aveses nos limitamos, aveses pensamos que solo uno vive una historia propia pero a travez de las historias de los demas podemos darnos cuenta que vivimos parecido...aveses no nos damos cuenta que vivimos y no nos detenemos a pensar si realmente es lo que desemaos vivir.,<br /><br />lo recomiendo fabuloso de leer');
INSERT INTO public.reviews VALUES (5, NULL, 280, 123, 3, NULL, 'This novel contains memorable characters and some wonderful insights into marriage and friendship!');
INSERT INTO public.reviews VALUES (4, NULL, 281, 120, 26, NULL, 'My grand daughter really enjoyed them. She is going to be in second grade and loves to read');
INSERT INTO public.reviews VALUES (5, NULL, 282, 27, 12, NULL, 'It was Great.');
INSERT INTO public.reviews VALUES (5, NULL, 283, 99, 40, NULL, 'Informative and accurate. Gives an accurate description of what it''s like to be a trans woman. Of course her''s is not the only experience, but it''s better than someone else''s imagined version.');
INSERT INTO public.reviews VALUES (5, NULL, 284, 78, 13, NULL, 'Just what I needed.');
INSERT INTO public.reviews VALUES (5, NULL, 285, 163, 26, NULL, 'very detailed view of all the &#34;landmarks&#34; through scripture of the coming Messiah, an eye-opener for people<br />newly exploring the Old Testament.  Rewarding the reader.');
INSERT INTO public.reviews VALUES (5, NULL, 286, 74, 12, NULL, 'I love this book.  Good lessons in life to help you survive life.  Other than historical lessons, I know most of the local people author is speaking about.  I haven''t quite finished it, but I have enjoyed this book so much. Janice McKeithan Evans');
INSERT INTO public.reviews VALUES (5, NULL, 287, 110, 12, NULL, 'A beautiful book supporting such an important cause with part of the proceeds going to the Genesis Project to help fight against sex trafficking. Denica''s poetry is smooth and fluent, and I loved how the book was divided up into different sections with different themes, such as social justice, relationship with God, and overcoming struggles. The poems range in length, tone, and subject matter, but Denica''s love for God and people shines through each of them. I will often times read these poems after a long day, and they always help me remember who I am in Christ. Highly recommended!');
INSERT INTO public.reviews VALUES (5, NULL, 288, 162, 13, NULL, 'Classic must have.');
INSERT INTO public.reviews VALUES (5, NULL, 289, 79, 25, NULL, 'Book arrived in brand new condition and quickly.Very happy with the seller.The book itself was filled with twists and turns I enjoyed it immensely');
INSERT INTO public.reviews VALUES (5, NULL, 290, 89, 25, NULL, 'Excellent book.');
INSERT INTO public.reviews VALUES (5, NULL, 291, 125, 7, NULL, 'Eye-opening! I learned so much and sincerely thank Dr. Jordan for taking the time to pen this valuable guide for parent''s of daughters.');
INSERT INTO public.reviews VALUES (5, NULL, 339, 77, 9, NULL, 'My granddaughter didn''t want this book to end!');
INSERT INTO public.reviews VALUES (5, NULL, 292, 26, 14, NULL, 'Great book!  This has been on my radar for a while, but for some reason copies are out of this world expensive.  I finally found a reasonable seller and picked this up.  It covers many people, each with a photo and about a 2-3 page blurb.  Great reading and reference material.  Easy to pick up and put down!');
INSERT INTO public.reviews VALUES (5, NULL, 293, 92, 11, NULL, 'Exactly what I needed for school');
INSERT INTO public.reviews VALUES (2, NULL, 294, 19, 12, NULL, 'I knew going into purchasing this book that it was used but what I didn''t expect was the water damage on the first 60 pages. The quality wasa much worse than what I thought I was purchasing.');
INSERT INTO public.reviews VALUES (4, NULL, 295, 161, 40, NULL, 'Overall the book is good, especially in drawing attention to how effective some attacks are. I also appreciate the statistics on most-likely attacks. But there are 2 weaknesses. First is that the book states that most people start training in martial arts to learn self-defense (which is true) but doesn''t recognize that that is not what keeps people training for many years. The other problem is that it downplays the need to become efficient in non-lethal defense. Putting people in the hospital is usually unnecessary for a well trained martial artist, and opens up the martial artist to law suits. Using only necessary force is an important concept ignored by this book. I think some of the bunkai examples are not well illustrated, though the photo and print quality are excellent.');
INSERT INTO public.reviews VALUES (5, NULL, 296, 24, 9, NULL, 'The classic in the field of why we failed to predict Pearl Harbor. Wohlsetter points out we had a vast number of signals that the war was about to start, all pointing away from Pearl Harbor. One point that should perhaps have been stressed more was that the Japanese armada headed toward the oil fields of Indonesia and tasked to take out Malaya on the Philippines along the way to guard the flanks was impossible to hide and generated a vast amount of absolutely correct information about the main thrust of the Japanese.');
INSERT INTO public.reviews VALUES (5, NULL, 297, 60, 12, NULL, 'I haven''t read it yet (glanced through and it looks very useful), but here''s why I love it - After getting it I took it to my daughter''s Sevens practice and offered it to the Coach to read over the weekend. He''s an experienced Rugby player and has been coaching the High School Sevens team for a couple years. When I picked my daughter up today he said he loves the book and wants to keep it a bit longer, and will order himself a copy. My daughter said he was carrying it around like a bible. I told him to keep it and I''m ordering another for myself.');
INSERT INTO public.reviews VALUES (5, NULL, 298, 72, 13, NULL, 'This is a precious piece of Air Force heritage for those wanting to broaden their knowledge base of Air Force history and culture.');
INSERT INTO public.reviews VALUES (4, NULL, 299, 72, 3, NULL, 'I''ve been fortunate to have lived over periods of time, and to have traveled extensively in Provence for over a quarter century. Thus, when this offering appeared in my Vine account, I had to say YES, since there is always so much more to learn, and this area in particular, can be \\"sliced and diced\\" so many different ways. And that is precisely the core feature of this guide: four different road trips through Provence. There is a seven day trip through \\"Roman\\" Provence, covering the most notable historical legacies of that once powerful empire. There are two that feature very different natural worlds, one covering the lavender fields of high Provence, for 4-5 days, and another one of similar duration covering the wetlands of coastal Camargue, with their French \\"cowboys\\" and white horses. The fourth is also of seven days, and is the longest journey, from Menton on the Italian border to St. Remy de Provence and covers the galleries and museums devoted to modern art. Since th');
INSERT INTO public.reviews VALUES (4, NULL, 300, 65, 14, NULL, 'Got what my wife ordered');
INSERT INTO public.reviews VALUES (5, NULL, 301, 77, 40, NULL, 'Lately I have been rediscovering the joys of coloring. This is one of the best advanced coloring books I have found. It has so many more images then other books so it''s a great value. I love the intricate designs. Some are quicker patterns and I expect others are definitely going to take some time. I like to use colored pencils and I think that is best on these pages. I''m excited to finish my first design and may add this to my holiday gift giving list!');
INSERT INTO public.reviews VALUES (3, NULL, 302, 77, 12, NULL, 'I was disappointed. This is a complex story and the author doesn''t make it any less complex. Europeans are the descendents of Russian goatherds. Really. Probably true. I still don''t know what a Celt was although lots of words were thrown at them. I guess I wasn''t willing to invest the time to really understand what the author was saying. The book does pretty much destroy any myth of racial purity.');
INSERT INTO public.reviews VALUES (5, NULL, 303, 15, 13, NULL, 'This has been great to pass the time in meetings. I''ve noticed a few colleagues were jealous that I had something tangible to show for my time at the end of the  meeting so I recommended they check it out too.  Some executives were intrigued as well, but they struggled to understand how to use it so they moved on to something else.');
INSERT INTO public.reviews VALUES (4, NULL, 304, 160, 26, NULL, 'great pircures and very informative; some of the information is &#34;scattered&#34; in different areas of the book and there seems to be some duplication of data, But well worth it to go natural.');
INSERT INTO public.reviews VALUES (5, NULL, 305, 132, 25, NULL, 'Fantastic read!! This book couldn''t have come at a better time. I''ve been experiencing a food baby as far as I can remember and now I finally know why. I found this to be educational and inspirational. I''m excited to start my body on a new and healthier path!!!');
INSERT INTO public.reviews VALUES (5, NULL, 306, 33, 14, NULL, 'Perfect!');
INSERT INTO public.reviews VALUES (3, NULL, 307, 138, 9, NULL, 'Ok book, great service.');
INSERT INTO public.reviews VALUES (4, NULL, 308, 1, 7, NULL, 'I do love the works of Anne Tyler. This is not her best effort in my opinion but was a nice read.');
INSERT INTO public.reviews VALUES (5, NULL, 309, 91, 9, NULL, 'This book delivers!!!');
INSERT INTO public.reviews VALUES (5, NULL, 310, 91, 12, NULL, 'Was just what I wanted and was in great condition');
INSERT INTO public.reviews VALUES (5, NULL, 311, 111, 14, NULL, 'Intriguing story about a man, conflicted with his past, seeking out answers he wonders if he will ever find. Stockman does and exceptional portrayal of unrequited love, and the passing of time. The pairing of Andy''s pain and anguish with the plight of cicadas was an unusual, but poignant touch. I saw both stories through the eyes of Andy and the cicadas. Well done! Well done!!');
INSERT INTO public.reviews VALUES (5, NULL, 312, 196, 40, NULL, 'Each and every time I get a new Harold Davis text, I am motivated to make better images.<br />This new text is a mentor in a book!  I can''t wait to work my way through it---<br />If you don''t have access to Photo classes, this book is a must read/use.');
INSERT INTO public.reviews VALUES (5, NULL, 313, 112, 9, NULL, 'Good book. Needed it.');
INSERT INTO public.reviews VALUES (5, NULL, 340, 158, 9, NULL, 'Love this book.  Great advice especially for young professionals or really anyone in the workplace.');
INSERT INTO public.reviews VALUES (4, NULL, 341, 70, 10, NULL, 'When the books arrived I was surprised that they were just 5 1/4&#34; X 7 1/4&#34;, a size that I think is a little small for a book for a young child. If the description had mentioned this I wouldn''t have gotten them. I won''t return them but I may wait until my granddaughter is a little older before I give them to her.');
INSERT INTO public.reviews VALUES (4, NULL, 314, 89, 12, NULL, 'Loved this story. Evan Currie has a very good imagination, and is able to put it on paper for the enjoyment of all.  I thought the science was very well explained, the pace of the book was spot on, and he kept the aliens, alien enough to keep the book interesting.<br /><br />I gave it four stars because he was clearly not military, or not any that I heard of.  This was suppose to be a military environment but all the officers acted like civies.  Junior officers always questing his order, deaths because there mouth was open surprise instead of doing there job.  With training comes reaction and none of the officers showed they had any.<br /><br />I''ve read two series from him and will continue to read. great job.');
INSERT INTO public.reviews VALUES (5, NULL, 315, 99, 3, NULL, 'Very helpful.');
INSERT INTO public.reviews VALUES (5, NULL, 316, 197, 24, NULL, 'Pelecanos can sure pick them!<br />These are stories by a number of DC writers about DC and therefore vary somewhat in quality.<br />However, some are real gems and almost all have thought provoking content.<br />Characters are gritty and compelling in most cases.<br />The neighborhoods are distinct and recognizable.<br />As in most Noir, it is easy to see the characters falling into trouble, but many of the stories have a surprising twist at the end.');
INSERT INTO public.reviews VALUES (5, NULL, 317, 135, 11, NULL, 'I was reluctant to  read a potentially depressing book.  But &#34;The Deadliest Pandemic&#34; is important for all of us.  It goes beyond the fascinating history of the 1918 virus, how it was created and how it spread worldwide to what is happening in real time.  Mr. Ritchey gives the inevitable odds of a new pandemic a hard look, one we need to face, and how we can prepare and hopefully prevent infection.  It is a concise and factual book with information that just may save your life.  It surprised me and I highly suggest not just reading it for yourself but to give to everyone you know.');
INSERT INTO public.reviews VALUES (5, NULL, 318, 143, 12, NULL, 'Both me and my 4 year old daughter love this book. Every time Louise''s heart beats fast in her feathered breast, my daughter pats her heart.  And when Louise finally makes it back to the henhouse and tucks her beak beneath her wing to go to sleep, my little one puts her nose in the crook of her arm.  We got this book out from the library and it''s a cute story that I''m not tired of reading nightly.');
INSERT INTO public.reviews VALUES (5, NULL, 319, 76, 3, NULL, 'I have several FMQ books but this one and the companion book, &#34;First Steps in FMQ&#34; are the ones I will reference again and again from now on. Christina has two Craftsy classes that compliment her books.');
INSERT INTO public.reviews VALUES (5, NULL, 320, 27, 13, NULL, 'Excellent book. Well thought out argument that explains why his should really matter to you now!');
INSERT INTO public.reviews VALUES (5, NULL, 321, 97, 25, NULL, 'i love the author. good book.');
INSERT INTO public.reviews VALUES (5, NULL, 322, 91, 26, NULL, 'This is one of the Grove Edition liturgical booklets- I vaguely recall that it is no more than 30 or 40 pages long (and that''s being generous). It is excellent, erudite, learned and holds that mellifluously distinct tone of Lord Williams'' voice, of course. However, to pay more than $200 for it is, quite simply, scandalous. I urge my theological contemporaries from Cambridge (1980''s) to check through their libraries, dig out their old copies and offer them ''on loan'' to anyone who dearly wants to read this essay.');
INSERT INTO public.reviews VALUES (5, NULL, 323, 10, 7, NULL, 'I am Loving this series. So many shocking moments you have to recover from; sending you in a direction you never considered. Seriously well scripted story-telling. The characters only become more interesting in the second book and the ending... what i love too is that the author gives us a sample of the next book at the end and wow... talk about a twist to start book three. I can''t wait to read the next installment. I almost feel like this story could go on and on and i''d be very pleased if it did. But I understand it is a trilogy and perhaps will stop at book three. I will miss this world when it is over. Like I missed the world of Hyperion by Dan Simmons. So well crafted. So entertaining.  So happy to have had these books recommended to me!');
INSERT INTO public.reviews VALUES (5, NULL, 324, 120, 11, NULL, 'Great!');
INSERT INTO public.reviews VALUES (5, NULL, 325, 56, 10, NULL, 'Daughter really likes this book because it features Elmo. At this point she is more into Elmo more than the potty or Elmo and friends interacting with the potty. Not a bad thing, it''s familiarizing her with it more and helping her to understand as we begin the training and transition. Beyond that, I can''t really comment whether or not it will be ''the answer'' or not, if anything, everything positive helps!');
INSERT INTO public.reviews VALUES (3, NULL, 326, 122, 8, NULL, 'Was looking for &#34;Hands on&#34; to treat Separation Anxiety, not much there on that.');
INSERT INTO public.reviews VALUES (5, NULL, 327, 187, 10, NULL, 'My son loved this book.');
INSERT INTO public.reviews VALUES (5, NULL, 328, 116, 8, NULL, 'This book is amazing, first poetry book purchase and one i will certainly recommend. the introduction to the book show raw emotions and and leaves you connected to the author, u will want to read her work.The poetry is mind gripping, entertaining and will leave you lyrically consumed.');
INSERT INTO public.reviews VALUES (4, NULL, 329, 111, 9, NULL, 'Easy to read and easy to use; good product;');
INSERT INTO public.reviews VALUES (4, NULL, 330, 99, 11, NULL, 'I liked this book. am learning some things new. getting ready to do some out of it.');
INSERT INTO public.reviews VALUES (5, NULL, 331, 30, 3, NULL, 'Eight miles below the surface may lie the secret to humanity''s survival. A terrifying new disease is sweeping across the planet. People are slowly forgetting...first, little things. Then more important things. Finally, how to breathe, how to live. But down on the ocean floor, Clayton Nelson is working on a cure. He''s the smartest man on Earth, for better or worse. If anyone can do it, it''s him. Until things start happening. And communication lines are cut. Clayton''s final transmission is a call for help to his brother Luke. But as Luke descends into the depths himself, he finds a world cut straight from his darkest nightmares, from snippets of horror from his troubled childhood. Waiting for him eight miles below the surface is nothing less than Hell itself.<br /><br />I picked up THE DEEP on a whim, thinking, &#34;Yeah, I haven''t read a fun little horror novel in a while.&#34; THE DEEP isn''t fun. Not in the sense I was expecting. Nick Cutter (an alias of author Craig Davidson; hell, e');
INSERT INTO public.reviews VALUES (5, NULL, 332, 37, 12, NULL, 'Top notch book, extremely clear communicator.');
INSERT INTO public.reviews VALUES (5, NULL, 333, 181, 3, NULL, 'Great little book, and pictures are fabulous.  Shipped quickly');
INSERT INTO public.reviews VALUES (5, NULL, 334, 112, 26, NULL, 'Very helpful');
INSERT INTO public.reviews VALUES (5, NULL, 335, 53, 9, NULL, 'As described. Would buy from again. Thanks!');
INSERT INTO public.reviews VALUES (3, NULL, 336, 138, 11, NULL, 'Nice resource. The CD is kind of boring for small kids.');
INSERT INTO public.reviews VALUES (5, NULL, 337, 64, 26, NULL, 'Item as described');
INSERT INTO public.reviews VALUES (5, NULL, 338, 95, 10, NULL, 'I reach for this book whenever I get the inclination to write a book myself. I love Anne Lamott''s style and her advice on writing is wonderful. This book gives me hope that I will someday actually sit down and write a book but in the meantime I will read this whenever I feel the urge to write, do some of the exercises (writing what you see in a one inch picture frame is a regular favorite of mine), and imagine my own memoir written in the style of Ms. Lamott. If only I could sit down and start with that first bird...');
INSERT INTO public.reviews VALUES (3, NULL, 342, 38, 7, NULL, 'I really wanted to love this book, but I didn''t.  I found it to be kind of boring.');
INSERT INTO public.reviews VALUES (4, NULL, 343, 131, 26, NULL, 'Very nice stories I wish there was some more illustration');
INSERT INTO public.reviews VALUES (1, NULL, 344, 13, 11, NULL, 'Do not expect any technical details in this book. After finish reading, i felt waste of my time. Biology of malt was just a copy of text book, no new information on malt analysis and malt handling storage milling sections for commercial brewers.');
INSERT INTO public.reviews VALUES (3, NULL, 345, 34, 14, NULL, 'This is odd for me.  There are some really fabulous parts of this book and then some really awful parts of the book.  It is probably the hardest book that I have had to review this year because I am getting stuck on whether I want to give it to another to read or not.  I really loved the flashbacks with the twins together.  Learning about the sisters and their connection was very interesting and made me feel more connected to the surviving twin.  Everything else in the present is not as interesting.  Most of this is because I feel like there is a lot of blah behind it.  There was not a lot of a driving force forward.  Giselle also doesn''t seem to really have a lot of emotion without her twin.  I didn''t feel like the anger and mixed feelings within grief really showed through in the present tense.  The premise is that she has to learn to live without her twin by traveling through the past to go to the future, but honestly the present/future is bland.  Why leave the past when those memo');
INSERT INTO public.reviews VALUES (4, NULL, 346, 178, 9, NULL, 'cute on my kit');
INSERT INTO public.reviews VALUES (1, NULL, 347, 120, 24, NULL, 'It was hard to follow and didn''t offer any sightseeing information for out of towners.');
INSERT INTO public.reviews VALUES (5, NULL, 348, 179, 26, NULL, 'Great Read');
INSERT INTO public.reviews VALUES (5, NULL, 349, 175, 14, NULL, 'Wonderfull brief of our money turbulance for the near history.');
INSERT INTO public.reviews VALUES (5, NULL, 350, 142, 13, NULL, 'Excellent novel. Combination of Stephen Jing and Dean Koontz. Greatest character development. Albuquerque in the fifties and sixties incredible!<br />Really enjoyed the Shaman/ Antasazi Indian development to the storyline!<br />The author is brilliant and has a knack for character development and suspense!<br />Hopefully, he will continue publishing novels! Very impressed with his first novel!<br />Former English teacher for thirty years and school administrator for ten. LA County Woman  in Education, 2010');
INSERT INTO public.reviews VALUES (5, NULL, 351, 75, 13, NULL, 'This is a brain tumor survival handbook. Would not hesitate to recommend to anyone and Dr. Williams provides free updates via pdf to keep the info current. This should not detract from your purchase, however, because he updates the medications and supplements section, not the whole book. This book will give you the information you need to have frank discussions with your medical providers to achieve the best outcome for you. There is also a free movie made about Dr. Williams'' (and others) survival. Search for surviving terminal cancer movie.');
INSERT INTO public.reviews VALUES (3, NULL, 352, 144, 11, NULL, 'Ruth Reichl (pronounced RYE-shil) is a former New York Times food critic as well as the last editor in chief of the now defunct Gourmet magazine. In this food memoir, Reichl revisits her unique relationship with her mother and how that came to inspire Ruth''s career in food. Ruth shares stories of her mother''s over-confidence in the kitchen, especially when it came to her tendency to look past expiration dates or experiment with odd flavor combinations in dinner party dishes. Ruth also recounts some of her mother''s quirky behaviors and &#34;antics&#34;, realizing what was laughable as a child, adult Ruth later realized were signs of her mother''s manic depression.<br /><br />One such telling incident was when Ruth, as a child, voiced a desire to speak French more fluently. Little did she know that shortly after and completely without warning, her mother would pick her up from school and drive her (from New York) to a French academy for girls in Montreal, basically telling Ruth she could');
INSERT INTO public.reviews VALUES (5, NULL, 353, 84, 8, NULL, 'I ordered this accidentally but kept it for the commentary - meant to just order the book!');
INSERT INTO public.reviews VALUES (5, NULL, 354, 83, 26, NULL, 'Review Title: Standing in the River of Life (review of River Dwellers by Dr. Rob Reimer)<br />Reviewer: Janice S. Garey<br />*****5 Stars<br /><br />Dr. Reimer pursued and found eternal treasure in becoming what he labels as a River Dweller. His book generously shares how to join in with those who go into the depths with God. I loved this book and its message. I want to go back through it and take notes so as to not forget any parts of what he related that will help me in spiritual growth. He gives names of other authors and book titles that helped him go deeper. He shares the credit with others for training people in the ways of living at the deeper level with God. You will desire to go deeper once you read about the rewards found, the peace available, and ways to help others with this information.<br /><br />I already know who I will  share this book with first in my friends circle. The one who is going through rough times and needs rest and peace that only comes through giving all ');
INSERT INTO public.reviews VALUES (5, NULL, 355, 181, 14, NULL, 'well written and lots of tips for writing.');
INSERT INTO public.reviews VALUES (5, NULL, 356, 29, 13, NULL, 'Make sure you have a box of tissue for this book.  Their journey had me in locked in by the end of the first page.  It is well written and gripping with each page I turned I didn''t want to put it down.  It is a true story of a father''s love, the journey of life, and the strength of hope.  I could feel the emotions the father was feeling.  I felt like I was standing by his side as a quiet observer.  His devotion to his son is unwavering and inspirational.<br /><br />Disclaimer:<br />I have received this product at a discount price in exchange for my honest review.');
INSERT INTO public.reviews VALUES (4, NULL, 357, 7, 40, NULL, 'Interesting plot, but shows much of the darker side of war that is uncomfortable..');
INSERT INTO public.reviews VALUES (1, NULL, 358, 102, 25, NULL, 'I bought this book on the 16th (August 2015) and have found the cooking times (arguably the most important part) to be either missing or utterly incorrect in all the recipes &#34;used&#34; so far. As we speak I''m taking random stabs at trying to cook the (raw) eggs in my &#34;Breakfast Hash&#34;... The book reads: &#34;bring the pot to high pressure and then allow it to slow release.&#34;. Yeah. No. I''m not going to eat raw eggs.');
INSERT INTO public.reviews VALUES (5, NULL, 359, 177, 40, NULL, 'Jordan Rosenfeld''s novel, WOMEN IN RED is a fantastic read!  My take: It''s about a former ballet dancer who finds herself in a dangerous underworld, navigating an eerie cast of characters, as she rediscovers her love of dance.  It''s a real page-turner; sensual prose that''s both lush, yet streamlined. And Ms. Rosenfeld plays, adeptly, with the reader''s expectations--there are many plot twists.  The story offers mystery, thrills (chills, too), and engages all the senses. At the same time, at the heart of the story are universal themes; at its core, WOMEN IN RED is a journey of a woman''s search for connection, for family.  A very fulfilling read!');
INSERT INTO public.reviews VALUES (5, NULL, 360, 65, 13, NULL, 'As described');
INSERT INTO public.reviews VALUES (5, NULL, 361, 183, 25, NULL, 'One of the best');
INSERT INTO public.reviews VALUES (5, NULL, 418, 166, 26, NULL, 'Just as described');
INSERT INTO public.reviews VALUES (1, NULL, 419, 193, 3, NULL, 'Horrid.  Juvenile writing.  Not your &#34;average&#34; Inspirational...and not even a good Inspirational.  All the best to author Lee, but I won''t be back to her canon.  No loss for either of us.');
INSERT INTO public.reviews VALUES (5, NULL, 362, 149, 25, NULL, 'I''ve been following her blog for about four years and I finally purchased the book. The book is awesome! I''m so happy that I got it! I''ve already made so many things, it''s very helpful.<br />I am very grateful for Lisa for sharing her recipes online and in this book.<br />I went raw vegan about four years ago to help me distinguish what food was giving me issues, overall it worked. Through many years of pain and stomach problems I found out on my own (something all my doctors missed) that I was lactose intolerant and had a dairy allergy.<br />Let me say that going raw vegan is very difficult, but it is totally worth it.<br />I lost 15lbs and I feel healthier and happier.<br />Currently I am not on a completely raw diet, but I like to incorporate many of the raw recipes found in this book into my regular meal plan.');
INSERT INTO public.reviews VALUES (5, NULL, 363, 123, 26, NULL, 'Easy to read, fantastic hands on writing exercises to jump start working with depression.');
INSERT INTO public.reviews VALUES (5, NULL, 364, 132, 24, NULL, 'As a former resident of Fort Worth I really enjoyed reading about things I hadn''t known. This book is well-organized, easy to read and full of historical details. Now I want to revisit FW and check out what some of these areas look like today.');
INSERT INTO public.reviews VALUES (5, NULL, 365, 161, 12, NULL, 'clever, fun, make-it-yourself recipes');
INSERT INTO public.reviews VALUES (5, NULL, 366, 75, 40, NULL, 'This is a wonderful. I highly recommend it for use in kindergarten and TK programs.');
INSERT INTO public.reviews VALUES (5, NULL, 367, 164, 10, NULL, 'Very Helpful I mostly use it for parts referencing and it''s great for just that');
INSERT INTO public.reviews VALUES (1, NULL, 368, 44, 25, NULL, 'In the first few pages he tells a tale about his father,  and draws conclusions as to his father''s internal motives and drives.  He says that his father lived through him, and that his father''s ego was so bound up in his taking sports.<br /><br />I see  that the sun rises, man walks to river, man fishes, man walks home,  sun sets.  I ask &#34;why?&#34;  &#34;Only don''t know.&#34;  Zen Master Seung Sahn');
INSERT INTO public.reviews VALUES (5, NULL, 369, 93, 7, NULL, 'great txt book. :)');
INSERT INTO public.reviews VALUES (5, NULL, 370, 14, 9, NULL, 'This book is jam packed with beautiful projects for people with embroidery machines. It will keep you busy all year and then some creating the well explained projects given here. We have made several things and can''t wait to continue with something else. Well worth the money!');
INSERT INTO public.reviews VALUES (5, NULL, 371, 192, 9, NULL, 'I live a fairly healthy lifestyle, I eat well, I exercise, but but I have few extra pounds. I also struggle with stress. I felt I needed a little help or guidance so I read this book. It''s a great book... very easy to read... it''s like Vanessa Chamberlin is talking to you. I think we all know what we are suppose to do to live a healthy life... yet we get distracted by marketing and advertising and subsequently develop bad habits... to our health''s detriment. The Fire Driven Life reminds us what we should be doing. Putting your self first is most important. Vanessa says that caring for yourself... what you put in your mouth... how you care for your body... is real self love. The book gives sound reason and offers numerous tips to help the reader to make better day to day choices. Vanessa shares her own personal story and inspires the reader to understand there own... to be real with themselves and encourages them to move forward... we are not our past... we are our future... and our fu');
INSERT INTO public.reviews VALUES (5, NULL, 372, 103, 26, NULL, 'thank you');
INSERT INTO public.reviews VALUES (3, NULL, 373, 53, 13, NULL, 'a great idea, not very well executed - a lot of rather pedestrian editing most likely left up to individual photographers - their better work is shown in &#34;In Our Time&#34;');
INSERT INTO public.reviews VALUES (5, NULL, 374, 144, 14, NULL, 'Love, love, love this book! I am very impressed by the quality of the art and the poetry. I will definitely use this book in my classes to introduce my students to the many different artists that are represented. Eric Gibbons has provided another great tool to art teachers, teachers and parents to expose their children to a wide range of art!');
INSERT INTO public.reviews VALUES (5, NULL, 375, 24, 9, NULL, 'Great product & service was quick!');
INSERT INTO public.reviews VALUES (5, NULL, 376, 158, 13, NULL, 'Lo que estaba buscando. Muy buen libro');
INSERT INTO public.reviews VALUES (5, NULL, 377, 32, 9, NULL, 'I Love Lakshmi. whatever I can learn about this Gret aGoddess is what I want. I chant to her daily and She comes through with Blessings.');
INSERT INTO public.reviews VALUES (5, NULL, 378, 182, 13, NULL, 'Great book!');
INSERT INTO public.reviews VALUES (4, NULL, 379, 44, 7, NULL, 'This is my second headfirst book... as allways, they ar fun and entertaining in ways in which few books are.<br /><br />This is an excellent book for a beginner programmer, specially if javascript is their first book: It is fun , easy to follow and has good coverage of the basic stuff.<br />That said, as a seasoned programmer I found less than I expected for a book this size. Now , don''t get me wrong, the book still has some very important topics regarding the idiosincrasy of javascript, it also contains a couple of interesting programs. The downside is that it will leave you just in the border between a beginner and an intermediate programmer. The DOM is only briefly touched and JQuery is just mentioned.');
INSERT INTO public.reviews VALUES (4, NULL, 380, 109, 9, NULL, 'I enjoyed reading this book, it was entertaining and informative, I learned things I didn''t know about being in the military. My only real issue with the book, was Mr. Scianna''s writing style took me a few chapters to get used to. I thought he was rushing through some parts and thinking that I had missed something, I found myself going back and re-reading those parts to make sure I hadn''t. I liked the story and sympathized with Dennis''s struggle to deal with military life, his personal demons, having a disappointing love experience and living through a devastating family tragedy. As for the Marcel character, I was not too fond of him, I found him pushy, manipulating, condescending and a little mean, I guess that''s what made him interesting. Hat''s off to the author...');
INSERT INTO public.reviews VALUES (5, NULL, 381, 54, 13, NULL, 'This was the first book I ever read on my own 50 years ago.  I was more than pleased just to have it in my hands.');
INSERT INTO public.reviews VALUES (5, NULL, 382, 82, 13, NULL, 'Very nice journal! The cover is beautiful and the pages are great for watercolor or colored pencil.');
INSERT INTO public.reviews VALUES (5, NULL, 383, 179, 8, NULL, 'Attachment theory is one of the most underrated aspects of dating, yet one of the most important. Amir Levine writes a fantastic book around the topic, and really brings clarity to the concept. Upon reading this book myself, I was able to reframe my entire life going back to my teenage life. While I still harbor anxieties in my own dating life, my understanding of dating through attachment style has helped me grow up just a little bit more. If you''re the self-discovery type, this book is definitely for you.');
INSERT INTO public.reviews VALUES (4, NULL, 384, 182, 10, NULL, 'Good resource for OD professionals.');
INSERT INTO public.reviews VALUES (2, NULL, 385, 43, 14, NULL, 'For those who enjoy counting angels dancing on the head of a pin.');
INSERT INTO public.reviews VALUES (5, NULL, 386, 108, 14, NULL, 'Easy interesting read');
INSERT INTO public.reviews VALUES (1, NULL, 387, 138, 7, NULL, 'The book purports to not be about &#34;a mindset&#34;, and then spends the next several chapters talking about mindsets.  Stupid book that says nothing in a lot of words.');
INSERT INTO public.reviews VALUES (5, NULL, 388, 185, 9, NULL, 'A gritty, hard hitting story centered on our border narcotics problem.');
INSERT INTO public.reviews VALUES (1, NULL, 389, 37, 14, NULL, 'I don''t see what''s funny.  It''s exagerated, but it''s not funny.  It attempts to be philosophical, but it''s not engaging or interesting at all.  It tells a simple but disjointed story about a two-dimensional middle-aged man that Bellow tries very hard to make interesting and three-diminsional, but he''s not.  He''s an obvious stereotype of the older Earnest Hemingway as &#34;American abroad&#34; while he was in his furious (as opposed to serious) decline.  The African characters are largely done in &#34;black face&#34;, and are insultingly patronized as vehicles for anything.  I like this author, but I hate this book.  It was a typical second effort that failed, and its self-conscious attempt to avoid bigotry played right into that same bigotry. This book is awful on just about every level imaginable.  Which is something it also lacks, although it tries so hard to avoid that obvious fact as it stumbles along to get past three hundred pages.  It completely lacks imagination.');
INSERT INTO public.reviews VALUES (5, NULL, 390, 173, 24, NULL, 'I enjoyed it better than the t.v. adaptation');
INSERT INTO public.reviews VALUES (5, NULL, 391, 56, 11, NULL, 'Very intense and good read to reflect on');
INSERT INTO public.reviews VALUES (5, NULL, 392, 193, 14, NULL, 'Great book fast!');
INSERT INTO public.reviews VALUES (3, NULL, 393, 181, 7, NULL, 'I read this book for my copyediting class. It''s a good, brief explanation of grammar problems and how to fix them. I also enjoyed Casagrande''s humor. If you''re looking for more detailed explanations on grammar issues or more instruction on writing, you may want something different.');
INSERT INTO public.reviews VALUES (5, NULL, 394, 195, 13, NULL, 'the grand kids loved this book');
INSERT INTO public.reviews VALUES (5, NULL, 395, 86, 26, NULL, 'grew up having this book read to me, was so excited to find it to read to my girls!  every girl needs a Mrs. Gigglebelly.');
INSERT INTO public.reviews VALUES (5, NULL, 396, 24, 10, NULL, 'good product good service');
INSERT INTO public.reviews VALUES (4, NULL, 397, 8, 14, NULL, 'I read the book more than one year ago and cannot remember if it was written by the first person. I enjoyed it very much because I had visited Tarumi many times when I lived in Japan.');
INSERT INTO public.reviews VALUES (4, NULL, 398, 155, 8, NULL, 'every helpful when I got hurt.');
INSERT INTO public.reviews VALUES (5, NULL, 399, 25, 10, NULL, 'Great coverage of an aircraft that did great service during WW II, but was forgotten afterwards.');
INSERT INTO public.reviews VALUES (4, NULL, 400, 132, 10, NULL, 'The key words I just selected for this review don''t reflect my feelings on this book.  It is flawed, but I loved it.  It''s the only book I''ve had dreams about while reading it.  I grant that it''s largely contrived to explore certain possibilities but the exploration is worth it.  It is an epic meditation on humanity, as the best science fiction often is.  For an apocalyptic book, it is very optimistic when contemplating what humans could do if we cared to, though it''s also pessimistic about our ability to ever stop warring.  It also deconstructs some of the tropes of science fiction itself, particularly the variety of big-headed, pointy-eared humanoid aliens encountered in television SF.  Stephenson is notorious for out-of-nowhere endings.  While the story ends leaving a world of questions, it wraps up in exactly the right place for the book''s subject.  This is hard science fiction, but accessible.  (incidentally, many science blogs have discussed the book''s science, in case you have ');
INSERT INTO public.reviews VALUES (5, NULL, 401, 44, 10, NULL, 'Nice reading.');
INSERT INTO public.reviews VALUES (5, NULL, 402, 2, 40, NULL, 'Anne Hillerman has picked up the torch from her dad.  Kudos Anne.');
INSERT INTO public.reviews VALUES (5, NULL, 403, 140, 12, NULL, 'Love it');
INSERT INTO public.reviews VALUES (3, NULL, 404, 32, 13, NULL, 'I happen to love the work of Jane Austen so I very much wanted to know more about the author. This book is OK, but it seems to go off on tangents talking about people other than Austen. This process can be very annoying. As a result I did not enjoy this book as much as I had thought I would...or had hoped I would. It was more academic and less personal than I would have personally liked. But as I say it is an OK read. I will leave to you the decision as to whether or not to buy this one.');
INSERT INTO public.reviews VALUES (4, NULL, 405, 80, 9, NULL, 'I enjoyed this book and will likely read the next few in the series, although I like where the novel ended and don''t think it needs any follow up. I feel like everything is wrapped up well enough and perhaps Moore shouldn''t drag out the plot anymore. This novel isn''t as funny as some of the others, but it''s still a great choice.');
INSERT INTO public.reviews VALUES (5, NULL, 406, 131, 25, NULL, 'I found the book to be very easy reading. Very touching.  Actually bringing tears at some parts.  Thinking back, wondering what if that had been me.  This is something I think of every time I assist on cases like this.  Being part of Denny''s surgical team from the start, I knew how bad things were and how bad of a condition Denny was in.  I was so happy to see the final out come for Denny.  Its not every day I get to see the out come of my work.  To also be able to read about it and the wonderful out come,  Thank You Jesus.  Great read,  easy, short.  Worth your time.');
INSERT INTO public.reviews VALUES (5, NULL, 407, 140, 26, NULL, 'Wonderful book');
INSERT INTO public.reviews VALUES (1, NULL, 408, 64, 24, NULL, 'Good seller.  Terrible book!');
INSERT INTO public.reviews VALUES (5, NULL, 409, 8, 14, NULL, 'This book is for men too! Understanding the dynamic interactions between our sophisticated counterparts can help us immensely! Erika''s book helps you get inside the heads of women and can teach you how to better function with them.');
INSERT INTO public.reviews VALUES (4, NULL, 410, 151, 8, NULL, 'This book is good enough to my little girl');
INSERT INTO public.reviews VALUES (5, NULL, 411, 113, 26, NULL, 'I wish I could have read this book 50 years ago but of course it was not in print now.  I am loaning it to all of my women friends &#34;of a certain age.&#34;');
INSERT INTO public.reviews VALUES (5, NULL, 412, 110, 12, NULL, 'Grow Young with HGH is a great book, everyone  should read it and amazon is the place to buy it..');
INSERT INTO public.reviews VALUES (5, NULL, 413, 46, 24, NULL, 'A rumor or more, and terrifying tales develop of unexplained matters. A lengthy list of episodes of vampires. There are even more books of its universal nature in many parts of the globe.');
INSERT INTO public.reviews VALUES (5, NULL, 414, 125, 24, NULL, 'The Martin Brothers are early studio potters active at the end of the 19th century and the beginning of the 20th century in England. Studio potting, in contrast to the giant pottery factories, was just getting started and would become the dominate form of potters in England and North America. While they made a large variety of pottery the Martin Brothers are no doubt most famous for the grotesques in the form of face pots and tobacco jars. The tobacco jars were usually the now famous and very valuable ''Wally'' birds named after their creator, the oldest brother, Wallace Martin.<br /><br />I have the original addition published in 1978 with 270 photos, mostly of their pots and the Martin Brothers Studio, of which 26 are in color. Many of the colored pictures are full page plates with often a dozen or more pots. Color is important as the Martin Brothers used a wide variety of colored glazes and the Wally Birds are very colorful.<br /><br />The book covers the life and art of the Martin B');
INSERT INTO public.reviews VALUES (5, NULL, 415, 52, 3, NULL, 'Good old material');
INSERT INTO public.reviews VALUES (5, NULL, 416, 7, 40, NULL, 'Love, love, love Nicole Tillman''s books!!!!!');
INSERT INTO public.reviews VALUES (1, NULL, 417, 139, 3, NULL, 'FAIRIES ARE EVIL LOOKING');
INSERT INTO public.reviews VALUES (5, NULL, 472, 196, 26, NULL, 'Superb');
INSERT INTO public.reviews VALUES (4, NULL, 420, 75, 7, NULL, 'Being someone who suffers with anxiety, I was happy to get a paperback copy of Thriving With Social Anxiety by Author Hattie C. Cooper.  I like the way this book breaks down different types of strategies, from therapeutic, daily scheduled social anxiety management, both sides of popular treatments like mindfulness and cognitive behavior therapy.  I really enjoyed learning about the natural remedies which include, aroma therapy, exercise, yoga, mediation and even remedies through diet.  I like that this book also covers way to be assertive and confidence building.  I really like that there is nothing complicated about these therapies/strategies and I was able to use them in my daily life. I have found ways to deal with anxiety by slowing down, being mindful and working on remaining calm.  I like that this author is not just a person who specializes in social anxiety, a doctor or someone who has studied the subject, but rather that she knows what it is like to have social anxiety and us');
INSERT INTO public.reviews VALUES (5, NULL, 421, 42, 10, NULL, 'Great Bible!');
INSERT INTO public.reviews VALUES (4, NULL, 422, 10, 13, NULL, 'I got a little tired of this 3/4 through, but I especially enjoyed the rush of a new culture (just as the author did) in the beginning.  As this is autobiographical, the latter parts deal with her career in fashion.  I really was interested in Paris instead.  Nevertheless, an entertaining read that brought back memories of my own time abroad after college.');
INSERT INTO public.reviews VALUES (5, NULL, 423, 38, 10, NULL, 'I was 10 years old in the summer of 1981 and I remember how disappointed I was with that summer''s baseball strike. At the time I didn''t understand all of the elements of the dispute between the players and the owners. I just knew that Major League Baseball had shut down and I couldn''t watch NBC''s Game of the Week...This Week in Baseball...and my hometown teams (the Orioles and Phillies). Plus, Fernando-mania was so exciting -- and then it all just stopped.<br /><br />I have to admit I was a little unsure that a book about a summer without baseball would hold up. But I was wrong about that.<br /><br />Jeff Katz found a way to tell the story of everything that happened in 1981 without making it seem like I was reading a series of legal briefs.  Instead, the story moved quickly -- with lots of great baseball content -- and the details behind the strike were explained in clear, simple terms.<br /><br />In hindsight -- after reading this book -- now I can''t understand why it took more than');
INSERT INTO public.reviews VALUES (5, NULL, 424, 113, 12, NULL, 'My Girl Read the whole book in like 3 weeks.!! She could of read it in one if we wernt so busy with the new born and all..');
INSERT INTO public.reviews VALUES (5, NULL, 425, 166, 11, NULL, 'At our library, Eastman''s books are in the section for kids learning to read, but they are also great for children learning to listen to stories read. Simple sentences and not too many words per page, easy concepts. Age two twins ask for this and &#34;Go Dog Go&#34; over and over.');
INSERT INTO public.reviews VALUES (3, NULL, 426, 167, 9, NULL, 'Pretty beat up and old.');
INSERT INTO public.reviews VALUES (5, NULL, 427, 45, 13, NULL, 'Good map and worth the money.');
INSERT INTO public.reviews VALUES (4, NULL, 428, 26, 9, NULL, 'Loved the peacefulness');
INSERT INTO public.reviews VALUES (4, NULL, 429, 138, 10, NULL, 'Set in the Middle East of the First World War, Maha Akhtar''s Footprints in the Sand is a well textured and riveting  novel about love, bravery, and commitment both in the larger context of the fight for Arab freedom from Ottoman domination and in the struggle of the main characters who face death and experience death in their lives and loves. With strong attention to detail such as the colorful and time period clothing worn by the characters, the descriptions of the labyrinth of Cairo''s Khan el-Khalili bazaar and the dry, arid, and deadly desert of the Arabian Peninsula, Akhtar pens a picture of turbulent life in the time of war where loyalties are tested and uncertain and love is risky.<br /><br />Focused around a young Egyptian named Salah who is a spy for the Arab Revolt and a young widowed mother and friend of Salah''s, named Noura, Footprints in the Sand is an intense novel whose shadows of plot are mirrored in the shadowy figures who seek Salah''s arrest for his work against the O');
INSERT INTO public.reviews VALUES (4, NULL, 430, 99, 26, NULL, 'Good book, thanks');
INSERT INTO public.reviews VALUES (5, NULL, 431, 200, 12, NULL, 'Then Colonel Michaelis was instrumental in preserving the Perimeter.  He later became my Boss as a Four Star commanding all Forces in Korea.');
INSERT INTO public.reviews VALUES (5, NULL, 432, 99, 24, NULL, 'Great');
INSERT INTO public.reviews VALUES (5, NULL, 433, 16, 13, NULL, 'Good book!');
INSERT INTO public.reviews VALUES (1, NULL, 434, 14, 40, NULL, 'You can find the content for free in the internet.  Just read any business model book.');
INSERT INTO public.reviews VALUES (1, NULL, 435, 107, 24, NULL, 'was recommended but i have not read it yet');
INSERT INTO public.reviews VALUES (5, NULL, 436, 25, 24, NULL, 'Great book. Inspiring to read the lives of the disciples, their struggles and solutions. Well translated. It is a handy reference for many occasions.');
INSERT INTO public.reviews VALUES (5, NULL, 437, 159, 26, NULL, 'This 7th edition book offers a nice update since the 6th edition (2004) that I used when I took the Nuclear Cardiology Boards the first time.<br />It''s subject matter is clearly presented and this edition is a bit more clinical in its tone.<br />The only reason to read it is to prepare for the CBNC Exam/Recert Exam.<br />It hits the mark. Just buy it.');
INSERT INTO public.reviews VALUES (5, NULL, 438, 177, 7, NULL, 'I am a pre natal yoga teacher. This book is very simple, gentle and clear. I find this book has nothing to do with not being experienced but being careful and nurture mothers and their babies. I agree with a comment that says it is a favourite book. For me too.');
INSERT INTO public.reviews VALUES (5, NULL, 439, 119, 25, NULL, 'I really, really enjoyed reading this book.  It did, in some ways, remind me of the writings of Edgar Allen Poe AND all of those Nancy Drew Mysteries I read as a teen.  In case you wonder, this is a big compliment.  I liked it so much I ordered a hard copy sent to my dear friend who has lived in Hawaii for 60 years and reads &#34;all the time&#34;.  She really liked it too.');
INSERT INTO public.reviews VALUES (5, NULL, 440, 182, 13, NULL, 'Need something for friends with small children....this is it!');
INSERT INTO public.reviews VALUES (5, NULL, 441, 145, 7, NULL, 'Walter was the greatest! Great book!');
INSERT INTO public.reviews VALUES (5, NULL, 442, 44, 40, NULL, 'I''m a huge fan. Not only did I get to be the cheerleader to get this book out to the public - but I personally LOVE IT.  Tracie has a wonderful way of sharing stories (they will make you laugh and cry) that weave wisdom and the need for wisdom all throughout it.  To join the Crowning Wisdom community - join up at www.crowningwisdom.com OR Text &#34;CrowingWisdom&#34; to #33444.  I hope you love this book as much as I do!!!');
INSERT INTO public.reviews VALUES (5, NULL, 443, 102, 10, NULL, 'Este libro definitivamente te llevara a  posicionarte en nuevos niveles de revelación');
INSERT INTO public.reviews VALUES (4, NULL, 444, 6, 26, NULL, 'I really liked this book. It was a good read and I enjoyed the difference in what the good guys did to set up camp vs. what the bad guys did. Definitely a worthwhile read. Will be keeping this in my collection.');
INSERT INTO public.reviews VALUES (5, NULL, 445, 97, 14, NULL, 'Best mechanical guide ever, I only wish that this book was available  to me ten years ago during some difficult engineering testing.');
INSERT INTO public.reviews VALUES (3, NULL, 473, 161, 26, NULL, 'Book was not very clean.  Plus I did not realize a CD comes with new books and I bought this used, so no CD!');
INSERT INTO public.reviews VALUES (5, NULL, 446, 106, 7, NULL, 'This is a solid introduction to the main components of a PC, their relationship to one another, and how to put them all together into a working machine.  The tech listed in this book is only a year or so past cutting edge, and the only additional info needed to put a rig together is spec data for each component the builder intends to use.  This really isn''t an oversight as Yarnold fully explains what types of parts are needed for different levels of builds and then shows you where to find the information on manufacturers'' websites to determine what will work with your plans.  It''s also a quick read with lots of well photographed illustrations to guide you through some of the intricacies involved in connecting things to a motherboard, installing adequate cooling, and finally bundling cables.  After only about 30 minutes skimming relevant passages, I was able to do an extensive upgrade on an existing system where I swapped power supplies, vid card, and hard drive on the first try.  Havi');
INSERT INTO public.reviews VALUES (5, NULL, 447, 21, 10, NULL, 'This is an excellent book, it will provide you with incredible insight into the portions of the New Testament written about or by Paul. I am a Christian who has spent 33 years studying the Bible, and because of my study, I am still searching out truths. Admittedly, this is the first book of Pauline studies I have ever read, but I have read quite a few commentaries by Christian authors and found them to offer no insight into the difficult passages of Paul. Mr. Segal, even though a Jew, provides a non-denigrating review of Paul based on his knowledge of early CE Jewish practices and philosophy and the New Testament record of Paul. He does not treat all aspects of Paul, but focuses on Paul''s Pharisaical background and it''s effects on Paul''s ministry. I don''t agree with all of his conclusions, but I do with most of them. I only wish it was available in Kindle edition. I also recommend &#34;Life after Death&#34;, another good work by Prof. Segal, although I think that &#34;Paul the Convert');
INSERT INTO public.reviews VALUES (5, NULL, 448, 158, 14, NULL, 'Fantastic 3 book set.');
INSERT INTO public.reviews VALUES (3, NULL, 449, 185, 9, NULL, 'This is the first time I have read any of Tricia O''Malley books. To me the whole Mystic Cove series wasn''t Irish enough! There wasn''t enough Irish brogue (terms and chatting) in the book!');
INSERT INTO public.reviews VALUES (5, NULL, 450, 43, 9, NULL, 'You can''t go wrong with the Empire of Man books. Weber and Ringo are masters of Military Sci-Fi.');
INSERT INTO public.reviews VALUES (5, NULL, 451, 62, 8, NULL, 'The grands love it!');
INSERT INTO public.reviews VALUES (5, NULL, 452, 191, 26, NULL, 'Funny and informative-great book for anyone who wants a laugh with understanding.  I have read this book several times and bought this one as a gift and she loved it and it helped her understand why when she asks her son what he is thinking he says nothing-because its true.');
INSERT INTO public.reviews VALUES (5, NULL, 453, 176, 3, NULL, 'thank you');
INSERT INTO public.reviews VALUES (5, NULL, 454, 171, 9, NULL, 'This book tells how to save money by canning your own beans. You also get health and/or taste benefits when you get to choose your own ingredients. And, it''s better for the environment than throwing cans in the trash. The book would be worth the price even the introduction was all you used.<br /><br />The rest of the book alternates between stories and recipes. The stories do make good reading and help to lengthen this rather short book. Many of the recipes contain meat, but you can easily adopt the canning methods to you own tastes if that''s what you prefer.<br /><br />Canning could be a very helpful tool for some people. An electric pressure cooker[[ASIN:B0040XHKR4 Deni 9770 Electric Pressure Cooker, 2 Quart]] is another way of adding dry beans to you diet. I use mine almost every day. Just add dry beans, water, and any other ingredients. Everything is done automatically without needing to to watch it the way you would if you were cooking on a stove. Unsoaked beans can be prepared t');
INSERT INTO public.reviews VALUES (4, NULL, 455, 181, 24, NULL, 'I received this book from the author for a free and honest review, so that is what you are going to get.<br /><br />This book was such an adventure. There is so much inside and going on that you can''t help but become extremely invested with something crazy is going down.<br /><br />The premise of the book is that a year long game set in virtual reality has been set up and commences at the beginning of the book. The whole world is watching and involved. For the most part, highly advanced artificial intelligence program control the game. There can be only one winner.<br /><br />The Game itself is this wonderful mash of mythology, classics, and pop culture. Most of the time you have to look for it and it can be so obscure, but I loved it so much. Specially the puzzle aspects of the game.<br /><br />Throughout the book you get the story of Nova Negrahnu, a young player of the game, Casey Brown, a down and out american trying to figure out his life, and Artica Kronkite, the CEO of Sprialwe');
INSERT INTO public.reviews VALUES (5, NULL, 456, 79, 26, NULL, 'Great book cause some life changing experience and adjustments in my life.');
INSERT INTO public.reviews VALUES (5, NULL, 457, 103, 10, NULL, 'Fast shipping!  Great product!  Thanks!');
INSERT INTO public.reviews VALUES (5, NULL, 458, 140, 26, NULL, 'Great detailed history of that period of time for th<br />ose heavily involved in Vietnam.');
INSERT INTO public.reviews VALUES (5, NULL, 459, 33, 9, NULL, 'good book');
INSERT INTO public.reviews VALUES (5, NULL, 460, 118, 40, NULL, 'A finely spun Web of a story that combines murder, mystery, intrigue and a killer who escalates with every passing minute. Whether this is your first read by Lisa Jackson, or you have read them all up to now, her books get more intriguing as the titles pile up. Prepare to be entranced and intrigued .');
INSERT INTO public.reviews VALUES (5, NULL, 461, 90, 11, NULL, 'Interesting and informative.');
INSERT INTO public.reviews VALUES (5, NULL, 462, 148, 25, NULL, 'What a great debut!  I couldn''t put it down and am recommending it to everyone!');
INSERT INTO public.reviews VALUES (5, NULL, 463, 176, 25, NULL, 'The book outlined history of the Huguenots that I was unaware of as well as show samples of silk work that I had never seen before. Although it was not long the writer has captured the essence of the Dupree''s relating them to Keith Richards in a most interesting way.');
INSERT INTO public.reviews VALUES (5, NULL, 464, 184, 24, NULL, 'This book brings together a wealth of information gathered over a life time of serious work in this area. It is exceptionally well written and very informative. The synthesis of concepts especially the life review is clear and easily understood. The individual personal histories are very clear. It is the best I have read. Compliments to Kenneth Ring.');
INSERT INTO public.reviews VALUES (4, NULL, 465, 102, 26, NULL, 'Good information but a little dated obviously. Worth what I paid for it. I got a couple of good points and techniques that I can use in the future.');
INSERT INTO public.reviews VALUES (1, NULL, 466, 157, 3, NULL, 'I agree with the other negative reviews. This textbook should be retired! The information is dated and not presented well. If your course requires the textbook, rent it and don''t waste your $ with a purchase.');
INSERT INTO public.reviews VALUES (2, NULL, 467, 82, 40, NULL, 'Just not that good.');
INSERT INTO public.reviews VALUES (5, NULL, 468, 150, 11, NULL, 'We need more writers like Brian Wiprud!');
INSERT INTO public.reviews VALUES (5, NULL, 469, 40, 40, NULL, 'Great book for preparing for the GRE. Very good example questions and helped me get my required test scores');
INSERT INTO public.reviews VALUES (5, NULL, 470, 175, 11, NULL, 'Great');
INSERT INTO public.reviews VALUES (5, NULL, 471, 135, 13, NULL, 'My daughter absolutely loves these books.');
INSERT INTO public.reviews VALUES (5, NULL, 476, 79, 7, NULL, 'A must read in today''s multitasking, stressed out world!');
INSERT INTO public.reviews VALUES (5, NULL, 477, 177, 7, NULL, 'This is the second most-important book I''ve ever read in my entire life. The author is a true expert on the New Testament, and in fact was someone who believed in every single word of it so strongly that he was convinced that nothing could ever change his mind on this. But through critical research of both history and the facts, he''s determined that the New Testament can no longer be relied upon, and he''s now an agnostic.<br /><br />There are so many people who believe that the New Testament, or at the minimum the Gospels, are the infallible word of God. But the author points out that there are so many inconsistencies in these books that this simply cannot be so. Approximately two thirds of the books in the New Testament weren''t written by the people whose names have been ascribed to them, including the four Gospels. The Gospels, the most detailed descriptions of the life of Jesus Christ, weren''t even written until 35-65 years after Jesus'' death, and they were written by people who ne');
INSERT INTO public.reviews VALUES (1, NULL, 478, 190, 3, NULL, 'Very distressing and depressing....things go from bad to worse to horrendous with nary a breather.');
INSERT INTO public.reviews VALUES (5, NULL, 479, 136, 8, NULL, 'Excellent translation for children. Accurate and understandable!');
INSERT INTO public.reviews VALUES (4, NULL, 480, 81, 10, NULL, 'good design book, a little dry as they all are.');
INSERT INTO public.reviews VALUES (5, NULL, 481, 43, 10, NULL, 'Purchased for my 7yr old grandson. He loved it! Has already gotten many hours of fun time with it. Would definitely recommend it.');
INSERT INTO public.reviews VALUES (4, NULL, 482, 134, 13, NULL, 'Good!');
INSERT INTO public.reviews VALUES (5, NULL, 483, 116, 25, NULL, 'Good price and fast delivery');
INSERT INTO public.reviews VALUES (5, NULL, 484, 101, 10, NULL, 'Gave as a gift');
INSERT INTO public.reviews VALUES (5, NULL, 485, 139, 26, NULL, 'Violence comes to the Colorado high country, but Alison Coil is on the case, hoping to restore order to the wilderness she so dearly loves.  Trapline, with its ensemble cast, is an engrossing, contemporary mystery that reminds you of the rugged beauty of the mountains and the dangers that lurk there.');
INSERT INTO public.reviews VALUES (5, NULL, 486, 1, 9, NULL, 'I was glad to get the first printing of this book.');
INSERT INTO public.reviews VALUES (5, NULL, 487, 131, 7, NULL, 'My 15mo old grandson LOVES his new book!  Lot''s of flaps to lift and see a variety of items on the page.');
INSERT INTO public.reviews VALUES (5, NULL, 488, 52, 13, NULL, 'Another book which really helped me to learn how to sew things.. Help a lot as beginner and rare to use sewing machine.');
INSERT INTO public.reviews VALUES (5, NULL, 489, 49, 40, NULL, 'The book was in excellent shape ,, thanks');
INSERT INTO public.reviews VALUES (5, NULL, 490, 138, 24, NULL, 'I love the geometric shapes in this book- very contemporary.');
INSERT INTO public.reviews VALUES (5, NULL, 491, 45, 14, NULL, 'I love this book! It makes me want to fall in love.');
INSERT INTO public.reviews VALUES (5, NULL, 492, 57, 3, NULL, 'I am happy I found this book. It is the most informative and easiest to understand of any I’ve read. I wanted to gain a little skill to make my travel photos better when I started reading this book. It reveals some of the tips and tricks used by professional photographers, without all of the technical language. If a picture is worth a thousand words then the amazing photos showing the techniques the author uses, say it all. The desert photos taken in Egypt really caught my eyes. In the pictures, the shadows, reflections, and drifting dunes come alive. If this book had been available when I toured Egypt a few years ago, maybe my photos would be livelier. I can’t wait to put what I’ve learned to use wherever my next trip takes me.');
INSERT INTO public.reviews VALUES (5, NULL, 493, 60, 25, NULL, 'Great product and in great condition! Thanks!');
INSERT INTO public.reviews VALUES (5, NULL, 494, 120, 9, NULL, 'Even if you never cook a single recipe he has listed in this book, it is awesome simply because of all the history and the historical pictures included in it.  I wanted it just to add to my recipe book collection as it has some very old, very good tips on cooking wild game, but found it so interesting I went cover to cover in a couple of days after I received it.  If you can snag a copy do so.');
INSERT INTO public.reviews VALUES (5, NULL, 495, 154, 25, NULL, 'Great book for parents');
INSERT INTO public.reviews VALUES (5, NULL, 496, 88, 9, NULL, 'Beautiful cards.Thank you.');
INSERT INTO public.reviews VALUES (5, NULL, 497, 71, 7, NULL, 'Couldn''t put it down!  David and Veronica are amazingly talented writers with an uncanny ability to put you smack in the middle of those &#34;you had to be there moments&#34;!  I was there!  And laughing my a__ off with tears running down my face! That they raised 3 happy, independent and successful children speaks volumes for their character, values and diligence!  And did I mention their sense of humor??  Their courage and independence??  Great book, can''t wait for the next one, and for those wanting a &#34;travel journal&#34; , go to their website!  Always a fun read!!');
INSERT INTO public.reviews VALUES (4, NULL, 498, 60, 25, NULL, 'Anyone who has ever attended summer camp--Girl Scouts, Boy Scouts, Campfire Girls, Civic or Religious organization camps, should enjoy a visit to this camp with three former campers. One of them, seventy year old Ethel, was the camp director of Camp Firelight and a great deal of her life revolves around this beautiful setting on a large lake. The problem is, the camp is about to be sold for lack of funds to re-build the water system. Also, though it is not emphasized,  four week long summer camp sessions have now given way to much shorter stays and the &#34;old fashioned&#34; camp now has competition from band, cheerleader, tennis, riding camps and a host of special-type camps lasting only one week.<br />  Back to our story, joining the returning camp director at Camp Firelight are two women who have been both campers and counselors and  a young teen age girl who has run away from a desperate home situation. Can these people solve the problem and save the camp? No spoilers here, but s');
INSERT INTO public.reviews VALUES (1, NULL, 499, 34, 9, NULL, 'I saw this book on a news story earlier in the year. I was curious to read about the haunting as it is an interest of mine. Don''t expect to hear about the spooky tales of the demon. This book is extremely &#34;Jesus saves and over comes all&#34; in its message. The author is pretty arrogant and the basis of the story is about his life and his family''s, not the spooky tale of a demon infestation. I also had an extremely hard time believing his side of the story. It''s a fast read for those skipping parts to find the spooky details. I wouldn''t recommend it to someone who isn''t religious and/or has an interest in the paranormal.');
INSERT INTO public.reviews VALUES (5, NULL, 500, 200, 26, NULL, 'Great book. Anything Os Guinness writes is worth reading and this is no exception. Well done.');


--
-- Data for Name: shipments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shipments VALUES (NULL, NULL, 1, 2, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 2, 3, 'Ship', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 3, 4, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 4, 5, 'Ship', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 5, 6, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 6, 7, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 7, 8, 'Ship', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 8, 9, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 9, 10, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 10, 11, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 11, 12, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 12, 13, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 13, 14, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 14, 15, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 15, 16, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 16, 17, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 17, 18, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 18, 19, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 19, 20, 'Ship', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 20, 21, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 21, 22, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 22, 23, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 23, 24, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 24, 25, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 25, 26, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 26, 27, 'Ship', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 27, 28, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 28, 29, 'Ship', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 29, 30, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 30, 31, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 31, 32, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 32, 33, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 33, 34, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 34, 35, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 35, 36, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 36, 37, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 37, 38, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 38, 39, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 39, 40, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 40, 41, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 41, 42, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 42, 43, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 43, 44, 'Ship', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 44, 45, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 45, 46, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 46, 47, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 47, 48, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 48, 49, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 49, 50, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 50, 51, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 51, 52, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 52, 53, 'Ship', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 53, 54, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 54, 55, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 55, 56, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 56, 57, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 57, 58, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 58, 59, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 59, 60, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 60, 61, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 61, 62, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 62, 63, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 63, 64, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 64, 65, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 65, 66, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 66, 67, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 67, 68, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 68, 69, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 69, 70, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 70, 71, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 71, 72, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 72, 73, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 73, 74, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 74, 75, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 75, 76, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 76, 77, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 77, 78, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 78, 79, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 79, 80, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 80, 81, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 81, 82, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 82, 83, 'Road', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 83, 84, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 84, 85, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 85, 86, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 86, 87, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 87, 88, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 88, 89, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 89, 90, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 90, 91, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 91, 92, 'Road', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 92, 93, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 93, 94, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 94, 95, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 95, 96, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 96, 97, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 97, 98, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 98, 99, 'Road', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 99, 100, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 100, 101, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 101, 102, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 102, 103, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 103, 104, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 104, 105, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 105, 106, 'Road', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 106, 107, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 107, 108, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 108, 109, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 109, 110, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 110, 111, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 111, 112, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 112, 113, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 113, 114, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 114, 115, 'Road', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 115, 116, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 116, 117, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 117, 118, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 118, 119, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 119, 120, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 120, 121, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 121, 122, 'Ship', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 122, 123, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 123, 124, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 124, 125, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 125, 126, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 126, 127, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 127, 128, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 128, 129, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 129, 130, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 130, 131, 'Ship', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 131, 132, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 132, 133, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 133, 134, 'Ship', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 134, 135, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 135, 136, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 136, 137, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 137, 138, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 138, 139, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 139, 140, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 140, 141, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 141, 142, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 142, 143, 'Ship', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 143, 144, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 144, 145, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 145, 146, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 146, 147, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 147, 148, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 148, 149, 'Ship', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 149, 150, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 150, 151, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 151, 152, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 152, 153, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 153, 154, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 154, 155, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 155, 156, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 156, 157, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 157, 158, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 158, 159, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 159, 160, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 160, 161, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 161, 162, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 162, 163, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 163, 164, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 164, 165, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 165, 166, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 166, 167, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 167, 168, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 168, 169, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 169, 170, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 170, 171, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 171, 172, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 172, 173, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 173, 174, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 174, 175, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 175, 176, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 176, 177, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 177, 178, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 178, 179, 'Ship', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 179, 180, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 180, 181, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 181, 182, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 182, 183, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 183, 184, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 184, 185, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 185, 186, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 186, 187, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 187, 188, 'Ship', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 188, 189, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 189, 190, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 190, 191, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 191, 192, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 192, 193, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 193, 194, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 194, 195, 'Ship', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 195, 196, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 196, 197, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 197, 198, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 198, 199, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 199, 200, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 200, 201, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 201, 202, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 202, 203, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 203, 204, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 204, 205, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 205, 206, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 206, 207, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 207, 208, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 208, 209, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 209, 210, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 210, 211, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 211, 212, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 212, 213, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 213, 214, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 214, 215, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 215, 216, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 216, 217, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 217, 218, 'Road', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 218, 219, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 219, 220, 'Road', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 220, 221, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 221, 222, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 222, 223, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 223, 224, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 224, 225, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 225, 226, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 226, 227, 'Road', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 227, 228, 'Road', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 228, 229, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 229, 230, 'Road', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 230, 231, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 231, 232, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 232, 233, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 233, 234, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 234, 235, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 235, 236, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 236, 237, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 237, 238, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 238, 239, 'Road', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 239, 240, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 240, 241, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 241, 242, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 242, 243, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 243, 244, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 244, 245, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 245, 246, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 246, 247, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 247, 248, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 248, 249, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 249, 250, 'Road', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 250, 251, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 251, 252, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 252, 253, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 253, 254, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 254, 255, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 255, 256, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 256, 257, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 257, 258, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 258, 259, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 259, 260, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 260, 261, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 261, 262, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 262, 263, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 263, 264, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 264, 265, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 265, 266, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 266, 267, 'Ship', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 267, 268, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 268, 269, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 269, 270, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 270, 271, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 271, 272, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 272, 273, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 273, 274, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 274, 275, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 275, 276, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 276, 277, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 277, 278, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 278, 279, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 279, 280, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 280, 281, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 281, 282, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 282, 283, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 283, 284, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 284, 285, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 285, 286, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 286, 287, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 287, 288, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 288, 289, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 289, 290, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 290, 291, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 291, 292, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 292, 293, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 293, 294, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 294, 295, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 295, 296, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 296, 297, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 297, 298, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 298, 299, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 299, 300, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 300, 301, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 301, 302, 'Ship', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 302, 303, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 303, 304, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 304, 305, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 305, 306, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 306, 307, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 307, 308, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 308, 309, 'Ship', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 309, 310, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 310, 311, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 311, 312, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 312, 313, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 313, 314, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 314, 315, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 315, 316, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 316, 317, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 317, 318, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 318, 319, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 319, 320, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 320, 321, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 321, 322, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 322, 323, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 323, 324, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 324, 325, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 325, 326, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 326, 327, 'Ship', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 327, 328, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 328, 329, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 329, 330, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 330, 331, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 331, 332, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 332, 333, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 333, 334, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 334, 335, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 335, 336, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 336, 337, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 337, 338, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 338, 339, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 339, 340, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 340, 341, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 341, 342, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 342, 343, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 343, 344, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 344, 345, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 345, 346, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 346, 347, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 347, 348, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 348, 349, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 349, 350, 'Road', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 350, 351, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 351, 352, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 352, 353, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 353, 354, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 354, 355, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 355, 356, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 356, 357, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 357, 358, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 358, 359, 'Road', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 359, 360, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 360, 361, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 361, 362, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 362, 363, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 363, 364, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 364, 365, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 365, 366, 'Road', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 366, 367, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 367, 368, 'Road', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 368, 369, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 369, 370, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 370, 371, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 371, 372, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 372, 373, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 373, 374, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 374, 375, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 375, 376, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 376, 377, 'Road', NULL, 'DELIVERED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 377, 378, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 378, 379, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 379, 380, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 380, 381, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 381, 382, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 382, 383, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 383, 384, 'Road', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 384, 385, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 385, 386, 'Road', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 386, 387, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 387, 388, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 388, 389, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 389, 390, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 390, 391, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 391, 392, 'Road', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 392, 393, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 393, 394, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 394, 395, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 395, 396, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 396, 397, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 397, 398, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 398, 399, 'Ship', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 399, 400, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 400, 401, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 401, 402, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 402, 403, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 403, 404, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 404, 405, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 405, 406, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 406, 407, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 407, 408, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 408, 409, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 409, 410, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 410, 411, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 411, 412, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 412, 413, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 413, 414, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 414, 415, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 415, 416, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 416, 417, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 417, 418, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 418, 419, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 419, 420, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 420, 421, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 421, 422, 'Ship', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 422, 423, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 423, 424, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 424, 425, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 425, 426, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 426, 427, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 427, 428, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 428, 429, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 429, 430, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 430, 431, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 431, 432, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 432, 433, 'Ship', NULL, 'DELIVERED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 433, 434, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 434, 435, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 435, 436, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 436, 437, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 437, 438, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 438, 439, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 439, 440, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 440, 441, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 441, 442, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 442, 443, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 443, 444, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 444, 445, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 445, 446, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 446, 447, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 447, 448, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 448, 449, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 449, 450, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 450, 451, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 451, 452, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 452, 453, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 453, 454, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 454, 455, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 455, 456, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 456, 457, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 457, 458, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 458, 459, 'Ship', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 459, 460, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 460, 461, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 461, 462, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 462, 463, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 463, 464, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 464, 465, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 465, 466, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 466, 467, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 467, 468, 'Ship', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 468, 469, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 469, 470, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 470, 471, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 471, 472, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 472, 473, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 473, 474, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 474, 475, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 475, 476, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 476, 477, 'Ship', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 477, 478, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 478, 479, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 479, 480, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 480, 481, 'Ship', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 481, 482, 'Ship', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 482, 483, 'Ship', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 483, 484, 'Ship', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 484, 485, 'Ship', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 485, 486, 'Road', NULL, 'DELIVERED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 486, 487, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 487, 488, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 488, 489, 'Road', NULL, 'SHIPPED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 489, 490, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 490, 491, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 491, 492, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 492, 493, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 493, 494, 'Road', NULL, 'SHIPPED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 494, 495, 'Road', NULL, 'DELIVERED', 'C');
INSERT INTO public.shipments VALUES (NULL, NULL, 495, 496, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 496, 497, 'Road', NULL, 'SHIPPED', 'D');
INSERT INTO public.shipments VALUES (NULL, NULL, 497, 498, 'Road', NULL, 'SHIPPED', 'F');
INSERT INTO public.shipments VALUES (NULL, NULL, 498, 499, 'Road', NULL, 'SHIPPED', 'A');
INSERT INTO public.shipments VALUES (NULL, NULL, 499, 500, 'Road', NULL, 'DELIVERED', 'B');
INSERT INTO public.shipments VALUES (NULL, NULL, 500, 501, 'Road', NULL, 'SHIPPED', 'C');


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stores VALUES (2, 2, 'Global Tech Store', 'ACTIVE');
INSERT INTO public.stores VALUES (5, 108, 'Test Seller Store', 'OPEN');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 2, NULL, NULL, 'admin@test.com', '$2a$10$8.UnVuG9HHgffUDAlk8qn.6nQH22LujUXRWf997E88aKSc4E8Y.n2', 'ADMIN', 'ACTIVE', 'admin');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 3, NULL, 'Female', 'user_1001@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1001');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 7, NULL, 'Male', 'user_1002@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1002');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 8, NULL, 'Other', 'user_1003@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1003');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 9, NULL, 'Female', 'user_1004@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1004');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 10, NULL, 'Male', 'user_1005@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1005');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 11, NULL, 'Other', 'user_1006@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1006');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 12, NULL, 'Female', 'user_1007@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1007');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 13, NULL, 'Male', 'user_1008@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1008');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 14, NULL, 'Other', 'user_1009@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1009');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 24, NULL, 'Female', 'user_1010@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1010');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 25, NULL, 'Male', 'user_1011@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1011');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 26, NULL, 'Female', 'user_1012@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1012');
INSERT INTO public.users VALUES ('2026-04-02 18:33:02.437683', 40, NULL, 'Female', 'user_1013@example.com', 'pass123', 'CUSTOMER', NULL, 'user_1013');
INSERT INTO public.users VALUES (NULL, 105, NULL, NULL, 'tester@test.com', '$2a$10$yJKl.8IfVXtBHJXYljcHcOncOzW6y2jnHsUcMgFrBb2CHzuQl3IEu', 'CUSTOMER', 'ACTIVE', 'tester');
INSERT INTO public.users VALUES (NULL, 106, NULL, NULL, 'user@test.com', '$2a$10$bXj2uJF0ylAqv9L72/j1n.gAAmzVrlkBGwXwU1bnO3aaID6LUaFoa', 'CUSTOMER', 'ACTIVE', 'user');
INSERT INTO public.users VALUES (NULL, 107, NULL, 'Male', 'testadmin.panel@example.com', '$2a$10$haXDZKFLM6WRmmr8lTDyGO1betmVoatoGP.HE1ObLnuZ.0ku3A.7u', 'ADMIN', 'ACTIVE', 'testadmin');
INSERT INTO public.users VALUES (NULL, 108, NULL, 'Male', 'testseller.panel@example.com', '$2a$10$X2aOJ.qrBF.PS4aSijeRgO4b2Mv.BXUjbQF1.EW1rDGQwnmPtjuNO', 'SELLER', 'ACTIVE', 'testseller');
INSERT INTO public.users VALUES (NULL, 113, NULL, 'Male', 'debuguser123@example.com', '$2a$10$WchSEF7jS1zYIWqE6GCi0e7JUqnPPWxHKVJUEf2D0wVG6Ity7CPIq', 'CUSTOMER', 'ACTIVE', 'debuguser123');
INSERT INTO public.users VALUES (NULL, 114, NULL, NULL, 'kocaborek.berkk@gmail.com', '$2a$10$AESx1x9OvArT5RSNkAQZ7Oth2uQVywmSuEtAzduozpwrp2/ICLA3W', 'CUSTOMER', 'ACTIVE', 'berk kocaborek');


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_id_seq', 1, false);


--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_id_seq', 5, true);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 9, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 44, true);


--
-- Name: complaints_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.complaints_id_seq', 1, false);


--
-- Name: customer_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_profiles_id_seq', 13, true);


--
-- Name: logistics_provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logistics_provider_id_seq', 1, false);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 8, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 505, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- Name: product_attribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_attribute_id_seq', 1, false);


--
-- Name: product_attribute_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_attribute_value_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 7916, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 500, true);


--
-- Name: shipments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipments_id_seq', 500, true);


--
-- Name: stores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stores_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 114, true);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: cart cart_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_user_id_key UNIQUE (user_id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: complaints complaints_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complaints
    ADD CONSTRAINT complaints_pkey PRIMARY KEY (id);


--
-- Name: customer_profiles customer_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_profiles
    ADD CONSTRAINT customer_profiles_pkey PRIMARY KEY (id);


--
-- Name: customer_profiles customer_profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_profiles
    ADD CONSTRAINT customer_profiles_user_id_key UNIQUE (user_id);


--
-- Name: logistics_provider logistics_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logistics_provider
    ADD CONSTRAINT logistics_provider_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payments payments_order_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_key UNIQUE (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: product_attribute product_attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute
    ADD CONSTRAINT product_attribute_pkey PRIMARY KEY (id);


--
-- Name: product_attribute_value product_attribute_value_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_value
    ADD CONSTRAINT product_attribute_value_pkey PRIMARY KEY (id);


--
-- Name: product_product_attribute_values product_product_attribute_values_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_attribute_values
    ADD CONSTRAINT product_product_attribute_values_pkey PRIMARY KEY (attribute_value_id, product_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_sku_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_sku_key UNIQUE (sku);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: shipments shipments_order_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_order_id_key UNIQUE (order_id);


--
-- Name: shipments shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_pkey PRIMARY KEY (id);


--
-- Name: stores stores_owner_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_owner_id_key UNIQUE (owner_id);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: addresses fk1fa36y2oqhao3wgg2rw1pi459; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk1fa36y2oqhao3wgg2rw1pi459 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: cart_items fk1re40cjegsfvw58xrkdp6bac6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk1re40cjegsfvw58xrkdp6bac6 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: product_attribute_value fk2hlm751b2lxswfyu8hh9kp1k7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_attribute_value
    ADD CONSTRAINT fk2hlm751b2lxswfyu8hh9kp1k7 FOREIGN KEY (attribute_id) REFERENCES public.product_attribute(id);


--
-- Name: orders fk32ql8ubntj5uh44ph9659tiih; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk32ql8ubntj5uh44ph9659tiih FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: product_product_attribute_values fk5pmgcqgwqx8m4cibh3l4liyi0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_attribute_values
    ADD CONSTRAINT fk5pmgcqgwqx8m4cibh3l4liyi0 FOREIGN KEY (attribute_value_id) REFERENCES public.product_attribute_value(id);


--
-- Name: stores fk62smc31fbgclsu56aa4y2hrxg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT fk62smc31fbgclsu56aa4y2hrxg FOREIGN KEY (owner_id) REFERENCES public.users(id);


--
-- Name: customer_profiles fk69orkdj1un5rh845ngvvmd1xs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_profiles
    ADD CONSTRAINT fk69orkdj1un5rh845ngvvmd1xs FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payments fk81gagumt0r8y3rmudcgpbk42l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk81gagumt0r8y3rmudcgpbk42l FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: complaints fk83j5gqkd7ku4vc908g4rtmglr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complaints
    ADD CONSTRAINT fk83j5gqkd7ku4vc908g4rtmglr FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: cart_items fk99e0am9jpriwxcm6is7xfedy3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk99e0am9jpriwxcm6is7xfedy3 FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: order_items fkbioxgbv59vetrxe0ejfubep1w; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fkbioxgbv59vetrxe0ejfubep1w FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: reviews fkcgy7qjc1r99dp117y9en6lxye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fkcgy7qjc1r99dp117y9en6lxye FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: cart fkg5uhi8vpsuy0lgloxk2h4w5o6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT fkg5uhi8vpsuy0lgloxk2h4w5o6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: products fkgcyffheofvmy2x5l78xam63mc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fkgcyffheofvmy2x5l78xam63mc FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: product_product_attribute_values fkjjlwhtsmfcen6pdwflsth8yu3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_product_attribute_values
    ADD CONSTRAINT fkjjlwhtsmfcen6pdwflsth8yu3 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders fkmk6q95x8ffidq82wlqjaq7sqc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fkmk6q95x8ffidq82wlqjaq7sqc FOREIGN KEY (shipping_address_id) REFERENCES public.addresses(id);


--
-- Name: orders fknqkwhwveegs6ne9ra90y1gq0e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fknqkwhwveegs6ne9ra90y1gq0e FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: orders fko5mqe94uno989lolexotqcn46; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fko5mqe94uno989lolexotqcn46 FOREIGN KEY (logistic_id) REFERENCES public.logistics_provider(id);


--
-- Name: order_items fkocimc7dtr037rh4ls4l95nlfi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fkocimc7dtr037rh4ls4l95nlfi FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: products fkog2rp4qthbtt2lfyhfo32lsw9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fkog2rp4qthbtt2lfyhfo32lsw9 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: reviews fkpl51cejpw4gy5swfar8br9ngi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fkpl51cejpw4gy5swfar8br9ngi FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: complaints fkr32fabkp363nyst1byc5txf9u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complaints
    ADD CONSTRAINT fkr32fabkp363nyst1byc5txf9u FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: shipments fkrnt4wht95lxxplspltrg9681s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT fkrnt4wht95lxxplspltrg9681s FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: categories fksaok720gsu4u2wrgbk10b5n8d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fksaok720gsu4u2wrgbk10b5n8d FOREIGN KEY (parent_id) REFERENCES public.categories(id);


--
-- PostgreSQL database dump complete
--



