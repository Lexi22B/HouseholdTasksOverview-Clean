--
-- PostgreSQL database dump
--

\restrict zbErPOkjWm7lzsY3ctmslNYZJ6mRYegQzk2Blh2aLbfryWD1Mi5DouCJxFfFI4t

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-03-13 12:16:42

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 238 (class 1259 OID 17904)
-- Name: date; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.date (
    full_date date NOT NULL
);


ALTER TABLE public.date OWNER TO postgres;

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
-- TOC entry 5137 (class 0 OID 0)
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
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 226
-- Name: duration_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.duration_levels_id_seq OWNED BY public.duration_levels.id;


--
-- TOC entry 220 (class 1259 OID 17725)
-- Name: households; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.households (
    id integer NOT NULL,
    address character varying(255) NOT NULL
);


ALTER TABLE public.households OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17724)
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
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 219
-- Name: households_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.households_id_seq OWNED BY public.households.id;


--
-- TOC entry 224 (class 1259 OID 17749)
-- Name: housemates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.housemates (
    id integer NOT NULL,
    household_id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(150),
    is_active boolean DEFAULT true
);


ALTER TABLE public.housemates OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17748)
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
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 223
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
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 230
-- Name: priority_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.priority_levels_id_seq OWNED BY public.priority_levels.id;


--
-- TOC entry 222 (class 1259 OID 17734)
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    id integer NOT NULL,
    household_id integer NOT NULL,
    room_name character varying(100) NOT NULL
);


ALTER TABLE public.rooms OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17733)
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
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 221
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
    housemate_id integer NOT NULL,
    assigned_date date NOT NULL,
    due_date date NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    CONSTRAINT task_assignments_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'overdue'::character varying])::text[])))
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
-- TOC entry 5143 (class 0 OID 0)
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
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 236
-- Name: task_completions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_completions_id_seq OWNED BY public.task_completions.id;


--
-- TOC entry 225 (class 1259 OID 17766)
-- Name: task_frequency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_frequency (
    id integer NOT NULL,
    description text
);


ALTER TABLE public.task_frequency OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17808)
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    household_id integer NOT NULL,
    room_id integer,
    task_frequency_id integer NOT NULL,
    recurrence_pattern character varying(20),
    title character varying(150) NOT NULL,
    description text,
    difficulty_level_id integer,
    priority_level_id integer,
    duration_level_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT tasks_recurrence_pattern_check CHECK ((((recurrence_pattern)::text = ANY ((ARRAY['daily'::character varying, 'weekly'::character varying, 'monthly'::character varying])::text[])) OR (recurrence_pattern IS NULL)))
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
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 232
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- TOC entry 4909 (class 2604 OID 17789)
-- Name: difficulty_levels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difficulty_levels ALTER COLUMN id SET DEFAULT nextval('public.difficulty_levels_id_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 17778)
-- Name: duration_levels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duration_levels ALTER COLUMN id SET DEFAULT nextval('public.duration_levels_id_seq'::regclass);


--
-- TOC entry 4904 (class 2604 OID 17728)
-- Name: households id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.households ALTER COLUMN id SET DEFAULT nextval('public.households_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 17752)
-- Name: housemates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.housemates ALTER COLUMN id SET DEFAULT nextval('public.housemates_id_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 17800)
-- Name: priority_levels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priority_levels ALTER COLUMN id SET DEFAULT nextval('public.priority_levels_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 17737)
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- TOC entry 4914 (class 2604 OID 17857)
-- Name: task_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_assignments ALTER COLUMN id SET DEFAULT nextval('public.task_assignments_id_seq'::regclass);


--
-- TOC entry 4916 (class 2604 OID 17884)
-- Name: task_completions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_completions ALTER COLUMN id SET DEFAULT nextval('public.task_completions_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 17811)
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- TOC entry 5131 (class 0 OID 17904)
-- Dependencies: 238
-- Data for Name: date; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.date (full_date) FROM stdin;
2025-01-01
2025-01-02
2025-01-03
2025-01-04
2025-01-05
2025-01-06
2025-01-07
2025-01-08
2025-01-09
2025-01-10
2025-01-11
2025-01-12
2025-01-13
2025-01-14
2025-01-15
2025-01-16
2025-01-17
2025-01-18
2025-01-19
2025-01-20
2025-01-21
2025-01-22
2025-01-23
2025-01-24
2025-01-25
2025-01-26
2025-01-27
2025-01-28
2025-01-29
2025-01-30
2025-01-31
2025-02-01
2025-02-02
2025-02-03
2025-02-04
2025-02-05
2025-02-06
2025-02-07
2025-02-08
2025-02-09
2025-02-10
2025-02-11
2025-02-12
2025-02-13
2025-02-14
2025-02-15
2025-02-16
2025-02-17
2025-02-18
2025-02-19
2025-02-20
2025-02-21
2025-02-22
2025-02-23
2025-02-24
2025-02-25
2025-02-26
2025-02-27
2025-02-28
2025-03-01
2025-03-02
2025-03-03
2025-03-04
2025-03-05
2025-03-06
2025-03-07
2025-03-08
2025-03-09
2025-03-10
2025-03-11
2025-03-12
2025-03-13
2025-03-14
2025-03-15
2025-03-16
2025-03-17
2025-03-18
2025-03-19
2025-03-20
2025-03-21
2025-03-22
2025-03-23
2025-03-24
2025-03-25
2025-03-26
2025-03-27
2025-03-28
2025-03-29
2025-03-30
2025-03-31
2025-04-01
2025-04-02
2025-04-03
2025-04-04
2025-04-05
2025-04-06
2025-04-07
2025-04-08
2025-04-09
2025-04-10
2025-04-11
2025-04-12
2025-04-13
2025-04-14
2025-04-15
2025-04-16
2025-04-17
2025-04-18
2025-04-19
2025-04-20
2025-04-21
2025-04-22
2025-04-23
2025-04-24
2025-04-25
2025-04-26
2025-04-27
2025-04-28
2025-04-29
2025-04-30
2025-05-01
2025-05-02
2025-05-03
2025-05-04
2025-05-05
2025-05-06
2025-05-07
2025-05-08
2025-05-09
2025-05-10
2025-05-11
2025-05-12
2025-05-13
2025-05-14
2025-05-15
2025-05-16
2025-05-17
2025-05-18
2025-05-19
2025-05-20
2025-05-21
2025-05-22
2025-05-23
2025-05-24
2025-05-25
2025-05-26
2025-05-27
2025-05-28
2025-05-29
2025-05-30
2025-05-31
2025-06-01
2025-06-02
2025-06-03
2025-06-04
2025-06-05
2025-06-06
2025-06-07
2025-06-08
2025-06-09
2025-06-10
2025-06-11
2025-06-12
2025-06-13
2025-06-14
2025-06-15
2025-06-16
2025-06-17
2025-06-18
2025-06-19
2025-06-20
2025-06-21
2025-06-22
2025-06-23
2025-06-24
2025-06-25
2025-06-26
2025-06-27
2025-06-28
2025-06-29
2025-06-30
2025-07-01
2025-07-02
2025-07-03
2025-07-04
2025-07-05
2025-07-06
2025-07-07
2025-07-08
2025-07-09
2025-07-10
2025-07-11
2025-07-12
2025-07-13
2025-07-14
2025-07-15
2025-07-16
2025-07-17
2025-07-18
2025-07-19
2025-07-20
2025-07-21
2025-07-22
2025-07-23
2025-07-24
2025-07-25
2025-07-26
2025-07-27
2025-07-28
2025-07-29
2025-07-30
2025-07-31
2025-08-01
2025-08-02
2025-08-03
2025-08-04
2025-08-05
2025-08-06
2025-08-07
2025-08-08
2025-08-09
2025-08-10
2025-08-11
2025-08-12
2025-08-13
2025-08-14
2025-08-15
2025-08-16
2025-08-17
2025-08-18
2025-08-19
2025-08-20
2025-08-21
2025-08-22
2025-08-23
2025-08-24
2025-08-25
2025-08-26
2025-08-27
2025-08-28
2025-08-29
2025-08-30
2025-08-31
2025-09-01
2025-09-02
2025-09-03
2025-09-04
2025-09-05
2025-09-06
2025-09-07
2025-09-08
2025-09-09
2025-09-10
2025-09-11
2025-09-12
2025-09-13
2025-09-14
2025-09-15
2025-09-16
2025-09-17
2025-09-18
2025-09-19
2025-09-20
2025-09-21
2025-09-22
2025-09-23
2025-09-24
2025-09-25
2025-09-26
2025-09-27
2025-09-28
2025-09-29
2025-09-30
2025-10-01
2025-10-02
2025-10-03
2025-10-04
2025-10-05
2025-10-06
2025-10-07
2025-10-08
2025-10-09
2025-10-10
2025-10-11
2025-10-12
2025-10-13
2025-10-14
2025-10-15
2025-10-16
2025-10-17
2025-10-18
2025-10-19
2025-10-20
2025-10-21
2025-10-22
2025-10-23
2025-10-24
2025-10-25
2025-10-26
2025-10-27
2025-10-28
2025-10-29
2025-10-30
2025-10-31
2025-11-01
2025-11-02
2025-11-03
2025-11-04
2025-11-05
2025-11-06
2025-11-07
2025-11-08
2025-11-09
2025-11-10
2025-11-11
2025-11-12
2025-11-13
2025-11-14
2025-11-15
2025-11-16
2025-11-17
2025-11-18
2025-11-19
2025-11-20
2025-11-21
2025-11-22
2025-11-23
2025-11-24
2025-11-25
2025-11-26
2025-11-27
2025-11-28
2025-11-29
2025-11-30
2025-12-01
2025-12-02
2025-12-03
2025-12-04
2025-12-05
2025-12-06
2025-12-07
2025-12-08
2025-12-09
2025-12-10
2025-12-11
2025-12-12
2025-12-13
2025-12-14
2025-12-15
2025-12-16
2025-12-17
2025-12-18
2025-12-19
2025-12-20
2025-12-21
2025-12-22
2025-12-23
2025-12-24
2025-12-25
2025-12-26
2025-12-27
2025-12-28
2025-12-29
2025-12-30
2025-12-31
2026-01-01
2026-01-02
2026-01-03
2026-01-04
2026-01-05
2026-01-06
2026-01-07
2026-01-08
2026-01-09
2026-01-10
2026-01-11
2026-01-12
2026-01-13
2026-01-14
2026-01-15
2026-01-16
2026-01-17
2026-01-18
2026-01-19
2026-01-20
2026-01-21
2026-01-22
2026-01-23
2026-01-24
2026-01-25
2026-01-26
2026-01-27
2026-01-28
2026-01-29
2026-01-30
2026-01-31
2026-02-01
2026-02-02
2026-02-03
2026-02-04
2026-02-05
2026-02-06
2026-02-07
2026-02-08
2026-02-09
2026-02-10
2026-02-11
2026-02-12
2026-02-13
2026-02-14
2026-02-15
2026-02-16
2026-02-17
2026-02-18
2026-02-19
2026-02-20
2026-02-21
2026-02-22
2026-02-23
2026-02-24
2026-02-25
2026-02-26
2026-02-27
2026-02-28
2026-03-01
2026-03-02
2026-03-03
2026-03-04
2026-03-05
2026-03-06
2026-03-07
2026-03-08
2026-03-09
2026-03-10
2026-03-11
2026-03-12
2026-03-13
2026-03-14
2026-03-15
2026-03-16
2026-03-17
2026-03-18
2026-03-19
2026-03-20
2026-03-21
2026-03-22
2026-03-23
2026-03-24
2026-03-25
2026-03-26
2026-03-27
2026-03-28
2026-03-29
2026-03-30
2026-03-31
2026-04-01
2026-04-02
2026-04-03
2026-04-04
2026-04-05
2026-04-06
2026-04-07
2026-04-08
2026-04-09
2026-04-10
2026-04-11
2026-04-12
2026-04-13
2026-04-14
2026-04-15
2026-04-16
2026-04-17
2026-04-18
2026-04-19
2026-04-20
2026-04-21
2026-04-22
2026-04-23
2026-04-24
2026-04-25
2026-04-26
2026-04-27
2026-04-28
2026-04-29
2026-04-30
2026-05-01
2026-05-02
2026-05-03
2026-05-04
2026-05-05
2026-05-06
2026-05-07
2026-05-08
2026-05-09
2026-05-10
2026-05-11
2026-05-12
2026-05-13
2026-05-14
2026-05-15
2026-05-16
2026-05-17
2026-05-18
2026-05-19
2026-05-20
2026-05-21
2026-05-22
2026-05-23
2026-05-24
2026-05-25
2026-05-26
2026-05-27
2026-05-28
2026-05-29
2026-05-30
2026-05-31
2026-06-01
2026-06-02
2026-06-03
2026-06-04
2026-06-05
2026-06-06
2026-06-07
2026-06-08
2026-06-09
2026-06-10
2026-06-11
2026-06-12
2026-06-13
2026-06-14
2026-06-15
2026-06-16
2026-06-17
2026-06-18
2026-06-19
2026-06-20
2026-06-21
2026-06-22
2026-06-23
2026-06-24
2026-06-25
2026-06-26
2026-06-27
2026-06-28
2026-06-29
2026-06-30
2026-07-01
2026-07-02
2026-07-03
2026-07-04
2026-07-05
2026-07-06
2026-07-07
2026-07-08
2026-07-09
2026-07-10
2026-07-11
2026-07-12
2026-07-13
2026-07-14
2026-07-15
2026-07-16
2026-07-17
2026-07-18
2026-07-19
2026-07-20
2026-07-21
2026-07-22
2026-07-23
2026-07-24
2026-07-25
2026-07-26
2026-07-27
2026-07-28
2026-07-29
2026-07-30
2026-07-31
2026-08-01
2026-08-02
2026-08-03
2026-08-04
2026-08-05
2026-08-06
2026-08-07
2026-08-08
2026-08-09
2026-08-10
2026-08-11
2026-08-12
2026-08-13
2026-08-14
2026-08-15
2026-08-16
2026-08-17
2026-08-18
2026-08-19
2026-08-20
2026-08-21
2026-08-22
2026-08-23
2026-08-24
2026-08-25
2026-08-26
2026-08-27
2026-08-28
2026-08-29
2026-08-30
2026-08-31
2026-09-01
2026-09-02
2026-09-03
2026-09-04
2026-09-05
2026-09-06
2026-09-07
2026-09-08
2026-09-09
2026-09-10
2026-09-11
2026-09-12
2026-09-13
2026-09-14
2026-09-15
2026-09-16
2026-09-17
2026-09-18
2026-09-19
2026-09-20
2026-09-21
2026-09-22
2026-09-23
2026-09-24
2026-09-25
2026-09-26
2026-09-27
2026-09-28
2026-09-29
2026-09-30
2026-10-01
2026-10-02
2026-10-03
2026-10-04
2026-10-05
2026-10-06
2026-10-07
2026-10-08
2026-10-09
2026-10-10
2026-10-11
2026-10-12
2026-10-13
2026-10-14
2026-10-15
2026-10-16
2026-10-17
2026-10-18
2026-10-19
2026-10-20
2026-10-21
2026-10-22
2026-10-23
2026-10-24
2026-10-25
2026-10-26
2026-10-27
2026-10-28
2026-10-29
2026-10-30
2026-10-31
2026-11-01
2026-11-02
2026-11-03
2026-11-04
2026-11-05
2026-11-06
2026-11-07
2026-11-08
2026-11-09
2026-11-10
2026-11-11
2026-11-12
2026-11-13
2026-11-14
2026-11-15
2026-11-16
2026-11-17
2026-11-18
2026-11-19
2026-11-20
2026-11-21
2026-11-22
2026-11-23
2026-11-24
2026-11-25
2026-11-26
2026-11-27
2026-11-28
2026-11-29
2026-11-30
2026-12-01
2026-12-02
2026-12-03
2026-12-04
2026-12-05
2026-12-06
2026-12-07
2026-12-08
2026-12-09
2026-12-10
2026-12-11
2026-12-12
2026-12-13
2026-12-14
2026-12-15
2026-12-16
2026-12-17
2026-12-18
2026-12-19
2026-12-20
2026-12-21
2026-12-22
2026-12-23
2026-12-24
2026-12-25
2026-12-26
2026-12-27
2026-12-28
2026-12-29
2026-12-30
2026-12-31
2027-01-01
2027-01-02
2027-01-03
2027-01-04
2027-01-05
2027-01-06
2027-01-07
2027-01-08
2027-01-09
2027-01-10
2027-01-11
2027-01-12
2027-01-13
2027-01-14
2027-01-15
2027-01-16
2027-01-17
2027-01-18
2027-01-19
2027-01-20
2027-01-21
2027-01-22
2027-01-23
2027-01-24
2027-01-25
2027-01-26
2027-01-27
2027-01-28
2027-01-29
2027-01-30
2027-01-31
2027-02-01
2027-02-02
2027-02-03
2027-02-04
2027-02-05
2027-02-06
2027-02-07
2027-02-08
2027-02-09
2027-02-10
2027-02-11
2027-02-12
2027-02-13
2027-02-14
2027-02-15
2027-02-16
2027-02-17
2027-02-18
2027-02-19
2027-02-20
2027-02-21
2027-02-22
2027-02-23
2027-02-24
2027-02-25
2027-02-26
2027-02-27
2027-02-28
2027-03-01
2027-03-02
2027-03-03
2027-03-04
2027-03-05
2027-03-06
2027-03-07
2027-03-08
2027-03-09
2027-03-10
2027-03-11
2027-03-12
2027-03-13
2027-03-14
2027-03-15
2027-03-16
2027-03-17
2027-03-18
2027-03-19
2027-03-20
2027-03-21
2027-03-22
2027-03-23
2027-03-24
2027-03-25
2027-03-26
2027-03-27
2027-03-28
2027-03-29
2027-03-30
2027-03-31
2027-04-01
2027-04-02
2027-04-03
2027-04-04
2027-04-05
2027-04-06
2027-04-07
2027-04-08
2027-04-09
2027-04-10
2027-04-11
2027-04-12
2027-04-13
2027-04-14
2027-04-15
2027-04-16
2027-04-17
2027-04-18
2027-04-19
2027-04-20
2027-04-21
2027-04-22
2027-04-23
2027-04-24
2027-04-25
2027-04-26
2027-04-27
2027-04-28
2027-04-29
2027-04-30
2027-05-01
2027-05-02
2027-05-03
2027-05-04
2027-05-05
2027-05-06
2027-05-07
2027-05-08
2027-05-09
2027-05-10
2027-05-11
2027-05-12
2027-05-13
2027-05-14
2027-05-15
2027-05-16
2027-05-17
2027-05-18
2027-05-19
2027-05-20
2027-05-21
2027-05-22
2027-05-23
2027-05-24
2027-05-25
2027-05-26
2027-05-27
2027-05-28
2027-05-29
2027-05-30
2027-05-31
2027-06-01
2027-06-02
2027-06-03
2027-06-04
2027-06-05
2027-06-06
2027-06-07
2027-06-08
2027-06-09
2027-06-10
2027-06-11
2027-06-12
2027-06-13
2027-06-14
2027-06-15
2027-06-16
2027-06-17
2027-06-18
2027-06-19
2027-06-20
2027-06-21
2027-06-22
2027-06-23
2027-06-24
2027-06-25
2027-06-26
2027-06-27
2027-06-28
2027-06-29
2027-06-30
2027-07-01
2027-07-02
2027-07-03
2027-07-04
2027-07-05
2027-07-06
2027-07-07
2027-07-08
2027-07-09
2027-07-10
2027-07-11
2027-07-12
2027-07-13
2027-07-14
2027-07-15
2027-07-16
2027-07-17
2027-07-18
2027-07-19
2027-07-20
2027-07-21
2027-07-22
2027-07-23
2027-07-24
2027-07-25
2027-07-26
2027-07-27
2027-07-28
2027-07-29
2027-07-30
2027-07-31
2027-08-01
2027-08-02
2027-08-03
2027-08-04
2027-08-05
2027-08-06
2027-08-07
2027-08-08
2027-08-09
2027-08-10
2027-08-11
2027-08-12
2027-08-13
2027-08-14
2027-08-15
2027-08-16
2027-08-17
2027-08-18
2027-08-19
2027-08-20
2027-08-21
2027-08-22
2027-08-23
2027-08-24
2027-08-25
2027-08-26
2027-08-27
2027-08-28
2027-08-29
2027-08-30
2027-08-31
2027-09-01
2027-09-02
2027-09-03
2027-09-04
2027-09-05
2027-09-06
2027-09-07
2027-09-08
2027-09-09
2027-09-10
2027-09-11
2027-09-12
2027-09-13
2027-09-14
2027-09-15
2027-09-16
2027-09-17
2027-09-18
2027-09-19
2027-09-20
2027-09-21
2027-09-22
2027-09-23
2027-09-24
2027-09-25
2027-09-26
2027-09-27
2027-09-28
2027-09-29
2027-09-30
2027-10-01
2027-10-02
2027-10-03
2027-10-04
2027-10-05
2027-10-06
2027-10-07
2027-10-08
2027-10-09
2027-10-10
2027-10-11
2027-10-12
2027-10-13
2027-10-14
2027-10-15
2027-10-16
2027-10-17
2027-10-18
2027-10-19
2027-10-20
2027-10-21
2027-10-22
2027-10-23
2027-10-24
2027-10-25
2027-10-26
2027-10-27
2027-10-28
2027-10-29
2027-10-30
2027-10-31
2027-11-01
2027-11-02
2027-11-03
2027-11-04
2027-11-05
2027-11-06
2027-11-07
2027-11-08
2027-11-09
2027-11-10
2027-11-11
2027-11-12
2027-11-13
2027-11-14
2027-11-15
2027-11-16
2027-11-17
2027-11-18
2027-11-19
2027-11-20
2027-11-21
2027-11-22
2027-11-23
2027-11-24
2027-11-25
2027-11-26
2027-11-27
2027-11-28
2027-11-29
2027-11-30
2027-12-01
2027-12-02
2027-12-03
2027-12-04
2027-12-05
2027-12-06
2027-12-07
2027-12-08
2027-12-09
2027-12-10
2027-12-11
2027-12-12
2027-12-13
2027-12-14
2027-12-15
2027-12-16
2027-12-17
2027-12-18
2027-12-19
2027-12-20
2027-12-21
2027-12-22
2027-12-23
2027-12-24
2027-12-25
2027-12-26
2027-12-27
2027-12-28
2027-12-29
2027-12-30
2027-12-31
\.


--
-- TOC entry 5122 (class 0 OID 17786)
-- Dependencies: 229
-- Data for Name: difficulty_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.difficulty_levels (id, name) FROM stdin;
1	Easy
2	Moderate
3	Hard
\.


--
-- TOC entry 5120 (class 0 OID 17775)
-- Dependencies: 227
-- Data for Name: duration_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.duration_levels (id, minutes) FROM stdin;
1	15
2	30
3	60
\.


--
-- TOC entry 5113 (class 0 OID 17725)
-- Dependencies: 220
-- Data for Name: households; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.households (id, address) FROM stdin;
1	Dalgas Have
2	Solbjerg Plads
3	Finsensvej
\.


--
-- TOC entry 5117 (class 0 OID 17749)
-- Dependencies: 224
-- Data for Name: housemates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.housemates (id, household_id, name, email, is_active) FROM stdin;
1	1	Alex	alex@gmail.com	t
2	1	Siri	siri@gmail.com	t
3	2	Ivana	ivana@gmail.com	t
4	2	Sara	sara@gmail.com	f
5	3	Sofie	sofie@gmail.com	t
\.


--
-- TOC entry 5124 (class 0 OID 17797)
-- Dependencies: 231
-- Data for Name: priority_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.priority_levels (id, name) FROM stdin;
1	High
2	Medium
3	Low
\.


--
-- TOC entry 5115 (class 0 OID 17734)
-- Dependencies: 222
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooms (id, household_id, room_name) FROM stdin;
1	1	bathroom
2	1	kitchen
3	2	bathroom
4	2	bathroom
5	2	kitchen
6	3	bathroom
\.


--
-- TOC entry 5128 (class 0 OID 17854)
-- Dependencies: 235
-- Data for Name: task_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_assignments (id, task_id, housemate_id, assigned_date, due_date, status) FROM stdin;
1	1	1	2004-03-13	2004-03-15	pending
\.


--
-- TOC entry 5130 (class 0 OID 17881)
-- Dependencies: 237
-- Data for Name: task_completions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_completions (id, assignment_id, completed_at) FROM stdin;
\.


--
-- TOC entry 5118 (class 0 OID 17766)
-- Dependencies: 225
-- Data for Name: task_frequency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.task_frequency (id, description) FROM stdin;
1	OneTime
2	Recurrent
\.


--
-- TOC entry 5126 (class 0 OID 17808)
-- Dependencies: 233
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, household_id, room_id, task_frequency_id, recurrence_pattern, title, description, difficulty_level_id, priority_level_id, duration_level_id, is_active, created_at) FROM stdin;
1	1	1	1	daily	Clean Bathroom	Deep-clean	2	1	3	t	2004-03-12 00:00:00
\.


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 228
-- Name: difficulty_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.difficulty_levels_id_seq', 1, false);


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 226
-- Name: duration_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.duration_levels_id_seq', 1, false);


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 219
-- Name: households_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.households_id_seq', 1, false);


--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 223
-- Name: housemates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.housemates_id_seq', 1, false);


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 230
-- Name: priority_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.priority_levels_id_seq', 1, false);


--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 221
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_id_seq', 1, false);


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 234
-- Name: task_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_assignments_id_seq', 1, false);


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 236
-- Name: task_completions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_completions_id_seq', 1, false);


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 232
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 1, false);


--
-- TOC entry 4953 (class 2606 OID 17909)
-- Name: date date_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.date
    ADD CONSTRAINT date_pkey PRIMARY KEY (full_date);


--
-- TOC entry 4935 (class 2606 OID 17795)
-- Name: difficulty_levels difficulty_levels_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difficulty_levels
    ADD CONSTRAINT difficulty_levels_name_key UNIQUE (name);


--
-- TOC entry 4937 (class 2606 OID 17793)
-- Name: difficulty_levels difficulty_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.difficulty_levels
    ADD CONSTRAINT difficulty_levels_pkey PRIMARY KEY (id);


--
-- TOC entry 4931 (class 2606 OID 17784)
-- Name: duration_levels duration_levels_minutes_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duration_levels
    ADD CONSTRAINT duration_levels_minutes_key UNIQUE (minutes);


--
-- TOC entry 4933 (class 2606 OID 17782)
-- Name: duration_levels duration_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.duration_levels
    ADD CONSTRAINT duration_levels_pkey PRIMARY KEY (id);


--
-- TOC entry 4921 (class 2606 OID 17732)
-- Name: households households_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.households
    ADD CONSTRAINT households_pkey PRIMARY KEY (id);


--
-- TOC entry 4925 (class 2606 OID 17760)
-- Name: housemates housemates_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.housemates
    ADD CONSTRAINT housemates_email_key UNIQUE (email);


--
-- TOC entry 4927 (class 2606 OID 17758)
-- Name: housemates housemates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.housemates
    ADD CONSTRAINT housemates_pkey PRIMARY KEY (id);


--
-- TOC entry 4939 (class 2606 OID 17806)
-- Name: priority_levels priority_levels_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priority_levels
    ADD CONSTRAINT priority_levels_name_key UNIQUE (name);


--
-- TOC entry 4941 (class 2606 OID 17804)
-- Name: priority_levels priority_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.priority_levels
    ADD CONSTRAINT priority_levels_pkey PRIMARY KEY (id);


--
-- TOC entry 4923 (class 2606 OID 17742)
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 4945 (class 2606 OID 17867)
-- Name: task_assignments task_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_assignments
    ADD CONSTRAINT task_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 4947 (class 2606 OID 17869)
-- Name: task_assignments task_assignments_task_id_housemate_id_due_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_assignments
    ADD CONSTRAINT task_assignments_task_id_housemate_id_due_date_key UNIQUE (task_id, housemate_id, due_date);


--
-- TOC entry 4949 (class 2606 OID 17891)
-- Name: task_completions task_completions_assignment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_completions
    ADD CONSTRAINT task_completions_assignment_id_key UNIQUE (assignment_id);


--
-- TOC entry 4951 (class 2606 OID 17889)
-- Name: task_completions task_completions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_completions
    ADD CONSTRAINT task_completions_pkey PRIMARY KEY (id);


--
-- TOC entry 4929 (class 2606 OID 17773)
-- Name: task_frequency task_frequency_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_frequency
    ADD CONSTRAINT task_frequency_pkey PRIMARY KEY (id);


--
-- TOC entry 4943 (class 2606 OID 17822)
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- TOC entry 4955 (class 2606 OID 17761)
-- Name: housemates housemates_household_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.housemates
    ADD CONSTRAINT housemates_household_id_fkey FOREIGN KEY (household_id) REFERENCES public.households(id) ON DELETE CASCADE;


--
-- TOC entry 4954 (class 2606 OID 17743)
-- Name: rooms rooms_household_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_household_id_fkey FOREIGN KEY (household_id) REFERENCES public.households(id) ON DELETE CASCADE;


--
-- TOC entry 4962 (class 2606 OID 17875)
-- Name: task_assignments task_assignments_housemate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_assignments
    ADD CONSTRAINT task_assignments_housemate_id_fkey FOREIGN KEY (housemate_id) REFERENCES public.housemates(id) ON DELETE CASCADE;


--
-- TOC entry 4963 (class 2606 OID 17870)
-- Name: task_assignments task_assignments_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_assignments
    ADD CONSTRAINT task_assignments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- TOC entry 4964 (class 2606 OID 17892)
-- Name: task_completions task_completions_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_completions
    ADD CONSTRAINT task_completions_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.task_assignments(id) ON DELETE CASCADE;


--
-- TOC entry 4956 (class 2606 OID 17838)
-- Name: tasks tasks_difficulty_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_difficulty_level_id_fkey FOREIGN KEY (difficulty_level_id) REFERENCES public.difficulty_levels(id);


--
-- TOC entry 4957 (class 2606 OID 17848)
-- Name: tasks tasks_duration_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_duration_level_id_fkey FOREIGN KEY (duration_level_id) REFERENCES public.duration_levels(id);


--
-- TOC entry 4958 (class 2606 OID 17823)
-- Name: tasks tasks_household_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_household_id_fkey FOREIGN KEY (household_id) REFERENCES public.households(id) ON DELETE CASCADE;


--
-- TOC entry 4959 (class 2606 OID 17843)
-- Name: tasks tasks_priority_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_priority_level_id_fkey FOREIGN KEY (priority_level_id) REFERENCES public.priority_levels(id);


--
-- TOC entry 4960 (class 2606 OID 17828)
-- Name: tasks tasks_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(id) ON DELETE SET NULL;


--
-- TOC entry 4961 (class 2606 OID 17833)
-- Name: tasks tasks_task_frequency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_task_frequency_id_fkey FOREIGN KEY (task_frequency_id) REFERENCES public.task_frequency(id);


-- Completed on 2026-03-13 12:16:42

--
-- PostgreSQL database dump complete
--

\unrestrict zbErPOkjWm7lzsY3ctmslNYZJ6mRYegQzk2Blh2aLbfryWD1Mi5DouCJxFfFI4t

