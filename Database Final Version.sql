--
-- PostgreSQL database dump
--

\restrict aG8GkiG6KurPRsZIzOaUvHrTVZa2Prqa7fRwMPQBI4w2xZYdxy3Ra6xgtTJlWE6

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-05-11 18:03:48

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
-- TOC entry 5152 (class 0 OID 0)
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
-- TOC entry 5153 (class 0 OID 0)
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
-- TOC entry 5154 (class 0 OID 0)
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
-- TOC entry 5155 (class 0 OID 0)
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
-- TOC entry 5156 (class 0 OID 0)
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
-- TOC entry 5157 (class 0 OID 0)
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
    room_image_id integer
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
-- TOC entry 5158 (class 0 OID 0)
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
-- TOC entry 5159 (class 0 OID 0)
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
-- TOC entry 5160 (class 0 OID 0)
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
-- TOC entry 5161 (class 0 OID 0)
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
1	\N	\N
2	\N	\N
3	\N	\N
4	$2a$06$gMNRJKIy3Fa7sMHoqRT0n.jiKHRohTR0B9GhrpE/1ojzO4wWZUQoW	test2
5	$2a$06$OelRmn1qCzy7J5TcnFnCT.xsSM6VqTEeOfCKehfOY2wkGDuFpG8qq	test3
6	$2a$06$VWmPquNesrzlBxOSZY5Jj.Puc.f9QKmcQqMB7pLhzgFA9FFaQlzSe	test4
7	$2a$06$T77HQLqqADdr8or.RPiAYeWewSXcsS.R7.ugNMed0s3AFpAQYh7yG	test5
8	$2a$06$Euj5nPTAQ00lCD6h1fmEJequicYPDYSIFAhathwRS92tiCJoSaNae	test5
9	$2a$06$Amt0qTTlDSPkfRFeNXZakuRNZpGAYe/Q20..3XwuHVVCRbDcrtMQq	test7
10	12345678	Test7
11	$2a$06$StIdtqjX0BvIW5XUojJ0muMJZpy.k.FKzK30L8ks/Rsdr5K9aA4qe	test9
12	$2a$06$mN1ztr487tq8EsaOQVgjW.YLKhsjfrDYJ6pxWhiCg/sfA22CckJ0.	test10
13	$2a$06$PnWRbbgRKNhq6FFDIsMe.OuJFpcMh14bEUqHl00ncXC9sByPdNBbC	Testing10
\.


--
-- TOC entry 5134 (class 0 OID 17749)
-- Dependencies: 225
-- Data for Name: housemates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.housemates (id, household_id, name, is_active, avatar_id) FROM stdin;
1	1	Alex	t	\N
2	1	Siri	t	\N
3	2	Ivana	t	\N
4	2	Sara	f	\N
5	3	Sofie	t	\N
\.


--
-- TOC entry 5140 (class 0 OID 17797)
-- Dependencies: 231
-- Data for Name: priority_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.priority_levels (id, name) FROM stdin;
2	Medium
1	Low
3	High
\.


--
-- TOC entry 5132 (class 0 OID 17734)
-- Dependencies: 223
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooms (id, household_id, room_name, room_image_id) FROM stdin;
1	1	bathroom	\N
2	1	kitchen	\N
3	2	bathroom	\N
4	2	bathroom	\N
5	2	kitchen	\N
6	3	bathroom	\N
7	1	Bedroom	\N
8	4	kitchen	\N
9	8	Bedroom	\N
11	12	Garden	\N
12	13	Garden	\N
\.


--
-- TOC entry 5144 (class 0 OID 17854)
-- Dependencies: 235
-- Data for Name: task_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_assignments (id, task_id, housemate_id) FROM stdin;
1	1	1
2	13	4
3	14	1
4	15	2
5	16	1
6	17	1
7	18	1
8	19	4
\.


--
-- TOC entry 5146 (class 0 OID 17881)
-- Dependencies: 237
-- Data for Name: task_completions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_completions (id, assignment_id, completed_at) FROM stdin;
1	2	2026-05-03 16:16:38.083
2	3	2026-05-03 16:16:56.934
3	4	2026-05-03 16:17:01.975
4	5	2026-05-03 16:17:16.915
\.


--
-- TOC entry 5142 (class 0 OID 17808)
-- Dependencies: 233
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, household_id, room_id, title, difficulty_level_id, priority_level_id, duration_level_id, created_at) FROM stdin;
1	1	1	Clean Bathroom	2	1	3	2004-03-12 00:00:00
13	4	8	Wash Dishes	3	3	3	2026-05-03 16:14:50.50075
14	4	8	Wipe floor	2	2	1	2026-05-03 16:16:11.314186
15	4	8	Clean fridge	2	2	2	2026-05-03 16:16:34.67563
16	4	8	Wash floor	2	2	2	2026-05-03 16:17:15.770959
17	4	8	Dust	1	1	1	2026-05-03 16:22:40.548293
18	8	9	Change Bedsheets	1	3	1	2026-05-03 16:41:40.056198
19	13	12	clean weeds	1	1	1	2026-05-10 17:11:01.053289
\.


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 228
-- Name: difficulty_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.difficulty_levels_id_seq', 1, false);


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 226
-- Name: duration_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.duration_levels_id_seq', 1, false);


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 220
-- Name: households_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.households_id_seq', 13, true);


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 224
-- Name: housemates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.housemates_id_seq', 1, false);


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 230
-- Name: priority_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.priority_levels_id_seq', 1, false);


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 222
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_id_seq', 12, true);


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 234
-- Name: task_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_assignments_id_seq', 8, true);


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 236
-- Name: task_completions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_completions_id_seq', 5, true);


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 232
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 19, true);


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


-- Completed on 2026-05-11 18:03:48

--
-- PostgreSQL database dump complete
--

\unrestrict aG8GkiG6KurPRsZIzOaUvHrTVZa2Prqa7fRwMPQBI4w2xZYdxy3Ra6xgtTJlWE6

