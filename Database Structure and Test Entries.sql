--
-- PostgreSQL database dump
--

\restrict e4qbopdJmRtNq0zd1NdjAlwPEYp335mnasccZd5KnltkQ4QSHujP18I73h0gGEV

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-05-12 20:11:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5152 (class 1262 OID 16758)
-- Name: Household Task Manager; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Household Task Manager" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Denmark.1252';


ALTER DATABASE "Household Task Manager" OWNER TO postgres;

\unrestrict e4qbopdJmRtNq0zd1NdjAlwPEYp335mnasccZd5KnltkQ4QSHujP18I73h0gGEV
\encoding SQL_ASCII
\connect -reuse-previous=on "dbname='Household Task Manager'"
\restrict e4qbopdJmRtNq0zd1NdjAlwPEYp335mnasccZd5KnltkQ4QSHujP18I73h0gGEV

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 17954)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 17786)
-- Name: difficulty_levels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.difficulty_levels (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.difficulty_levels OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17785)
-- Name: difficulty_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.difficulty_levels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.difficulty_levels_id_seq OWNER TO postgres;

--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 228
-- Name: difficulty_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.difficulty_levels_id_seq OWNED BY public.difficulty_levels.id;


--
-- TOC entry 227 (class 1259 OID 17775)
-- Name: duration_levels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.duration_levels (
    id integer NOT NULL,
    minutes integer NOT NULL
);


ALTER TABLE public.duration_levels OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17774)
-- Name: duration_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.duration_levels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.duration_levels_id_seq OWNER TO postgres;

--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 226
-- Name: duration_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.duration_levels_id_seq OWNED BY public.duration_levels.id;


--
-- TOC entry 221 (class 1259 OID 17725)
-- Name: households; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.households (
    id integer NOT NULL,
    password_hash character varying(255),
    house_code character varying(255)
);


ALTER TABLE public.households OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17724)
-- Name: households_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.households_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.households_id_seq OWNER TO postgres;

--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 220
-- Name: households_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.households_id_seq OWNED BY public.households.id;


--
-- TOC entry 225 (class 1259 OID 17749)
-- Name: housemates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.housemates (
    id integer NOT NULL,
    household_id integer NOT NULL,
    name character varying(100) NOT NULL,
    is_active boolean DEFAULT true,
    avatar_id integer
);


ALTER TABLE public.housemates OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17748)
-- Name: housemates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.housemates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.housemates_id_seq OWNER TO postgres;

--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 224
-- Name: housemates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.housemates_id_seq OWNED BY public.housemates.id;


--
-- TOC entry 231 (class 1259 OID 17797)
-- Name: priority_levels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.priority_levels (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.priority_levels OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17796)
-- Name: priority_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.priority_levels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.priority_levels_id_seq OWNER TO postgres;

--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 230
-- Name: priority_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.priority_levels_id_seq OWNED BY public.priority_levels.id;


--
-- TOC entry 223 (class 1259 OID 17734)
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    id integer NOT NULL,
    household_id integer NOT NULL,
    room_name character varying(100) NOT NULL,
    room_image_id integer,
    image_url character varying(255)
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17733)
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rooms_id_seq OWNER TO postgres;

--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 222
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- TOC entry 235 (class 1259 OID 17854)
-- Name: task_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_assignments (
    id integer NOT NULL,
    task_id integer NOT NULL,
    housemate_id integer NOT NULL
);


ALTER TABLE public.task_assignments OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17853)
-- Name: task_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_assignments_id_seq OWNER TO postgres;

--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 234
-- Name: task_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_assignments_id_seq OWNED BY public.task_assignments.id;


--
-- TOC entry 237 (class 1259 OID 17881)
-- Name: task_completions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_completions (
    id integer NOT NULL,
    assignment_id integer NOT NULL,
    completed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.task_completions OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17880)
-- Name: task_completions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_completions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_completions_id_seq OWNER TO postgres;

--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 236
-- Name: task_completions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_completions_id_seq OWNED BY public.task_completions.id;


--
-- TOC entry 233 (class 1259 OID 17808)
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    household_id integer NOT NULL,
    room_id integer,
    title character varying(150) NOT NULL,
    difficulty_level_id integer,
    priority_level_id integer,
    duration_level_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17807)
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_id_seq OWNER TO postgres;

--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 232
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- TOC entry 4939 (class 2604 OID 17789)
-- Name: difficulty_levels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difficulty_levels ALTER COLUMN id SET DEFAULT nextval('public.difficulty_levels_id_seq'::regclass);


--
-- TOC entry 4938 (class 2604 OID 17778)
-- Name: duration_levels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duration_levels ALTER COLUMN id SET DEFAULT nextval('public.duration_levels_id_seq'::regclass);


--
-- TOC entry 4934 (class 2604 OID 17728)
-- Name: households id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.households ALTER COLUMN id SET DEFAULT nextval('public.households_id_seq'::regclass);


--
-- TOC entry 4936 (class 2604 OID 17752)
-- Name: housemates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.housemates ALTER COLUMN id SET DEFAULT nextval('public.housemates_id_seq'::regclass);


--
-- TOC entry 4940 (class 2604 OID 17800)
-- Name: priority_levels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priority_levels ALTER COLUMN id SET DEFAULT nextval('public.priority_levels_id_seq'::regclass);


--
-- TOC entry 4935 (class 2604 OID 17737)
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- TOC entry 4943 (class 2604 OID 17857)
-- Name: task_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_assignments ALTER COLUMN id SET DEFAULT nextval('public.task_assignments_id_seq'::regclass);


--
-- TOC entry 4944 (class 2604 OID 17884)
-- Name: task_completions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_completions ALTER COLUMN id SET DEFAULT nextval('public.task_completions_id_seq'::regclass);


--
-- TOC entry 4941 (class 2604 OID 17811)
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- TOC entry 5138 (class 0 OID 17786)
-- Dependencies: 229
-- Data for Name: difficulty_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.difficulty_levels (id, name) FROM stdin;
1	Easy
2	Moderate
3	Hard
\.


--
-- TOC entry 5136 (class 0 OID 17775)
-- Dependencies: 227
-- Data for Name: duration_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.duration_levels (id, minutes) FROM stdin;
1	15
2	30
3	60
\.


--
-- TOC entry 5130 (class 0 OID 17725)
-- Dependencies: 221
-- Data for Name: households; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.households (id, password_hash, house_code) FROM stdin;
1	$2a$06$D9UIBvx1685/jLgL.V80Muu/p6XvoYITZeLe3GVLcUvoR/TcsWDi.	Test1
2	$2a$06$H14vKTPJIVzJSmDgY9MNbOzAvjJaM4u0J5/08v7i0pvAhvHwKDJ3G	Test2
\.


--
-- TOC entry 5134 (class 0 OID 17749)
-- Dependencies: 225
-- Data for Name: housemates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.housemates (id, household_id, name, is_active, avatar_id) FROM stdin;
1	2	Rabbi	t	2
2	2	Goofy	t	1
3	2	Rocky	t	3
\.


--
-- TOC entry 5140 (class 0 OID 17797)
-- Dependencies: 231
-- Data for Name: priority_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.priority_levels (id, name) FROM stdin;
1	Low
2	Medium
3	High
\.


--
-- TOC entry 5132 (class 0 OID 17734)
-- Dependencies: 223
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooms (id, household_id, room_name, room_image_id, image_url) FROM stdin;
34	2	Kitchen	\N	/assets/rooms/room3.png
35	2	Bathroom	\N	/assets/rooms/room4.png
\.


--
-- TOC entry 5144 (class 0 OID 17854)
-- Dependencies: 235
-- Data for Name: task_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_assignments (id, task_id, housemate_id) FROM stdin;
1	1	1
2	2	2
3	3	1
4	4	1
5	5	1
6	6	1
7	7	2
8	8	2
9	9	1
10	10	2
\.


--
-- TOC entry 5146 (class 0 OID 17881)
-- Dependencies: 237
-- Data for Name: task_completions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_completions (id, assignment_id, completed_at) FROM stdin;
1	5	2026-05-12 20:03:08.009907
2	3	2026-05-12 20:03:09.741236
3	1	2026-05-12 20:03:10.694757
4	2	2026-05-12 20:03:20.665105
\.


--
-- TOC entry 5142 (class 0 OID 17808)
-- Dependencies: 233
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, household_id, room_id, title, difficulty_level_id, priority_level_id, duration_level_id, created_at) FROM stdin;
1	2	34	Clean Dishes	2	2	2	2026-05-12 19:42:46.124703
2	2	34	Swipe Floors	1	1	1	2026-05-12 19:42:59.276043
3	2	34	Clean Fridge	1	3	1	2026-05-12 19:43:18.226959
4	2	34	Buy towels	1	1	1	2026-05-12 19:44:00.421436
5	2	34	Cook Dinner	3	3	3	2026-05-12 19:45:13.197069
6	2	34	Swipe Dust	1	1	1	2026-05-12 20:03:39.873175
7	2	34	Fix lightbulb	2	3	2	2026-05-12 20:06:25.169154
8	2	35	Clean Drains	2	2	2	2026-05-12 20:07:10.360307
9	2	35	Buy toilet paper	1	1	1	2026-05-12 20:07:19.933159
10	2	35	Wash sink	2	2	2	2026-05-12 20:07:33.17383
\.


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 228
-- Name: difficulty_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.difficulty_levels_id_seq', 1, false);


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 226
-- Name: duration_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.duration_levels_id_seq', 1, false);


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 220
-- Name: households_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.households_id_seq', 2, true);


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 224
-- Name: housemates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.housemates_id_seq', 3, true);


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 230
-- Name: priority_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.priority_levels_id_seq', 1, false);


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 222
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_id_seq', 35, true);


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 234
-- Name: task_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_assignments_id_seq', 10, true);


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 236
-- Name: task_completions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_completions_id_seq', 4, true);


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 232
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 10, true);


--
-- TOC entry 4957 (class 2606 OID 17795)
-- Name: difficulty_levels difficulty_levels_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difficulty_levels
    ADD CONSTRAINT difficulty_levels_name_key UNIQUE (name);


--
-- TOC entry 4959 (class 2606 OID 17793)
-- Name: difficulty_levels difficulty_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difficulty_levels
    ADD CONSTRAINT difficulty_levels_pkey PRIMARY KEY (id);


--
-- TOC entry 4953 (class 2606 OID 17784)
-- Name: duration_levels duration_levels_minutes_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duration_levels
    ADD CONSTRAINT duration_levels_minutes_key UNIQUE (minutes);


--
-- TOC entry 4955 (class 2606 OID 17782)
-- Name: duration_levels duration_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duration_levels
    ADD CONSTRAINT duration_levels_pkey PRIMARY KEY (id);


--
-- TOC entry 4947 (class 2606 OID 17732)
-- Name: households households_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.households
    ADD CONSTRAINT households_pkey PRIMARY KEY (id);


--
-- TOC entry 4951 (class 2606 OID 17758)
-- Name: housemates housemates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.housemates
    ADD CONSTRAINT housemates_pkey PRIMARY KEY (id);


--
-- TOC entry 4961 (class 2606 OID 17806)
-- Name: priority_levels priority_levels_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priority_levels
    ADD CONSTRAINT priority_levels_name_key UNIQUE (name);


--
-- TOC entry 4963 (class 2606 OID 17804)
-- Name: priority_levels priority_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priority_levels
    ADD CONSTRAINT priority_levels_pkey PRIMARY KEY (id);


--
-- TOC entry 4949 (class 2606 OID 17742)
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 4967 (class 2606 OID 17867)
-- Name: task_assignments task_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_assignments
    ADD CONSTRAINT task_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 4969 (class 2606 OID 17891)
-- Name: task_completions task_completions_assignment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_completions
    ADD CONSTRAINT task_completions_assignment_id_key UNIQUE (assignment_id);


--
-- TOC entry 4971 (class 2606 OID 17889)
-- Name: task_completions task_completions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_completions
    ADD CONSTRAINT task_completions_pkey PRIMARY KEY (id);


--
-- TOC entry 4965 (class 2606 OID 17822)
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- TOC entry 4973 (class 2606 OID 17761)
-- Name: housemates housemates_household_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.housemates
    ADD CONSTRAINT housemates_household_id_fkey FOREIGN KEY (household_id) REFERENCES public.households(id) ON DELETE CASCADE;


--
-- TOC entry 4972 (class 2606 OID 17743)
-- Name: rooms rooms_household_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_household_id_fkey FOREIGN KEY (household_id) REFERENCES public.households(id) ON DELETE CASCADE;


--
-- TOC entry 4979 (class 2606 OID 17875)
-- Name: task_assignments task_assignments_housemate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_assignments
    ADD CONSTRAINT task_assignments_housemate_id_fkey FOREIGN KEY (housemate_id) REFERENCES public.housemates(id) ON DELETE CASCADE;


--
-- TOC entry 4980 (class 2606 OID 17870)
-- Name: task_assignments task_assignments_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_assignments
    ADD CONSTRAINT task_assignments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- TOC entry 4981 (class 2606 OID 17892)
-- Name: task_completions task_completions_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_completions
    ADD CONSTRAINT task_completions_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.task_assignments(id) ON DELETE CASCADE;


--
-- TOC entry 4974 (class 2606 OID 17838)
-- Name: tasks tasks_difficulty_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_difficulty_level_id_fkey FOREIGN KEY (difficulty_level_id) REFERENCES public.difficulty_levels(id);


--
-- TOC entry 4975 (class 2606 OID 17848)
-- Name: tasks tasks_duration_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_duration_level_id_fkey FOREIGN KEY (duration_level_id) REFERENCES public.duration_levels(id);


--
-- TOC entry 4976 (class 2606 OID 17823)
-- Name: tasks tasks_household_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_household_id_fkey FOREIGN KEY (household_id) REFERENCES public.households(id) ON DELETE CASCADE;


--
-- TOC entry 4977 (class 2606 OID 17843)
-- Name: tasks tasks_priority_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_priority_level_id_fkey FOREIGN KEY (priority_level_id) REFERENCES public.priority_levels(id);


--
-- TOC entry 4978 (class 2606 OID 17828)
-- Name: tasks tasks_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(id) ON DELETE SET NULL;


-- Completed on 2026-05-12 20:11:45

--
-- PostgreSQL database dump complete
--

\unrestrict e4qbopdJmRtNq0zd1NdjAlwPEYp335mnasccZd5KnltkQ4QSHujP18I73h0gGEV

