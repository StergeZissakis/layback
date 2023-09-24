--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-24 23:19:55 BST

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

DROP DATABASE IF EXISTS postgres;
--
-- TOC entry 3045 (class 1262 OID 13465)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_GB.UTF-8' LC_CTYPE = 'en_GB.UTF-8';


\connect postgres

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
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 3045
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3047 (class 0 OID 0)
-- Name: postgres; Type: DATABASE PROPERTIES; Schema: -; Owner: -
--

ALTER DATABASE postgres SET "TimeZone" TO 'GMT+1';


\connect postgres

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
-- TOC entry 2539 (class 3456 OID 17065)
-- Name: match_team_names_collation; Type: COLLATION; Schema: public; Owner: -
--

CREATE COLLATION public.match_team_names_collation (provider = icu, deterministic = false, locale = 'und');


--
-- TOC entry 1 (class 3079 OID 16584)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 549 (class 1247 OID 16385)
-- Name: ActionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ActionType" AS ENUM (
    'Lay',
    'Back'
);


--
-- TOC entry 552 (class 1247 OID 16390)
-- Name: BetResult; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BetResult" AS ENUM (
    'Won',
    'Lost',
    'Lapsed'
);


--
-- TOC entry 643 (class 1247 OID 16404)
-- Name: OverUnderType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OverUnderType" AS ENUM (
    'Over',
    'Under'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 208 (class 1259 OID 17015)
-- Name: over2p5footballsupertips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5footballsupertips (
    id bigint NOT NULL,
    home character varying NOT NULL COLLATE pg_catalog."en_US",
    away character varying NOT NULL COLLATE pg_catalog."en_US",
    date_time timestamp without time zone NOT NULL,
    url character varying,
    league_id smallint
);


--
-- TOC entry 214 (class 1259 OID 25377)
-- Name: footballsupertips_today; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.footballsupertips_today AS
 SELECT over2p5footballsupertips.id,
    over2p5footballsupertips.home,
    over2p5footballsupertips.away,
    over2p5footballsupertips.date_time,
    over2p5footballsupertips.league_id,
    over2p5footballsupertips.url
   FROM public.over2p5footballsupertips
  WHERE ((over2p5footballsupertips.date_time)::date >= CURRENT_DATE)
  ORDER BY over2p5footballsupertips.date_time, over2p5footballsupertips.id;


--
-- TOC entry 206 (class 1259 OID 17004)
-- Name: over2p5goalsnow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5goalsnow (
    id bigint NOT NULL,
    home character varying NOT NULL COLLATE pg_catalog."en_US",
    away character varying NOT NULL COLLATE pg_catalog."en_US",
    date_time timestamp without time zone NOT NULL,
    url character varying,
    league_id smallint
);


--
-- TOC entry 213 (class 1259 OID 25373)
-- Name: goalsnow_today; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.goalsnow_today AS
 SELECT over2p5goalsnow.id,
    over2p5goalsnow.home,
    over2p5goalsnow.away,
    over2p5goalsnow.date_time,
    over2p5goalsnow.league_id,
    over2p5goalsnow.url
   FROM public.over2p5goalsnow
  WHERE ((over2p5goalsnow.date_time)::date >= CURRENT_DATE)
  ORDER BY over2p5goalsnow.date_time, over2p5goalsnow.id;


--
-- TOC entry 210 (class 1259 OID 17026)
-- Name: over2p5orbitxch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5orbitxch (
    id bigint NOT NULL,
    home character varying NOT NULL COLLATE pg_catalog."en_US",
    away character varying NOT NULL COLLATE pg_catalog."en_US",
    date_time timestamp without time zone NOT NULL,
    url character varying,
    plaied boolean DEFAULT false NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 17086)
-- Name: orbitxch_today; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.orbitxch_today AS
 SELECT over2p5orbitxch.id,
    over2p5orbitxch.home,
    over2p5orbitxch.away,
    over2p5orbitxch.date_time,
    over2p5orbitxch.url,
    over2p5orbitxch.plaied
   FROM public.over2p5orbitxch
  WHERE ((over2p5orbitxch.date_time)::date >= CURRENT_DATE)
  ORDER BY over2p5orbitxch.date_time, over2p5orbitxch.id;


--
-- TOC entry 215 (class 1259 OID 25381)
-- Name: TodayMatches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."TodayMatches" AS
 SELECT c.id,
    c.home,
    c.away,
    c.date_time,
    c.url,
    c.plaied,
    b.league_id
   FROM ((public.goalsnow_today a
     JOIN public.footballsupertips_today b ON ((((a.league_id = b.league_id) AND (a.date_time = b.date_time) AND (lower((a.home)::text) ~~ lower((b.home)::text))) OR (lower((a.away)::text) ~~ lower((b.away)::text)))))
     JOIN public.orbitxch_today c ON ((((b.date_time = c.date_time) AND (lower((b.home)::text) ~~ lower((c.home)::text))) OR (lower((b.away)::text) ~~ lower((c.away)::text)))))
  ORDER BY c.date_time, c.id, c.url;


--
-- TOC entry 203 (class 1259 OID 16493)
-- Name: over2p5bets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5bets (
    id bigint NOT NULL,
    "MatchDateTime" timestamp without time zone,
    "Home" character varying NOT NULL,
    "Away" character varying NOT NULL,
    "BetDateTime" timestamp without time zone NOT NULL,
    "LayBack" public."ActionType" NOT NULL,
    "OverUnder" public."OverUnderType" NOT NULL,
    "Goals" numeric(3,2) NOT NULL,
    "Odds" numeric(3,2) NOT NULL,
    "OddsRecorded" numeric(3,2) NOT NULL,
    "Amount" numeric NOT NULL,
    "BetResult" public."BetResult",
    "BetResultTime" timestamp without time zone,
    "BetId" bigint
);


--
-- TOC entry 212 (class 1259 OID 17110)
-- Name: TodaysBets; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."TodaysBets" AS
 SELECT a.id,
    a."MatchDateTime",
    a."Home",
    a."Away",
    a."BetDateTime",
    a."LayBack",
    a."OverUnder",
    a."Goals",
    a."Odds",
    a."OddsRecorded",
    a."Amount",
    a."BetResultTime" AS "BetMatchTime",
    a."BetResult"
   FROM public.over2p5bets a
  WHERE ((a."BetDateTime")::date >= CURRENT_DATE)
  ORDER BY a."BetDateTime", a.id;


--
-- TOC entry 204 (class 1259 OID 16500)
-- Name: over2p5bets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5bets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 204
-- Name: over2p5bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5bets_id_seq OWNED BY public.over2p5bets.id;


--
-- TOC entry 207 (class 1259 OID 17013)
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5footballsupertips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 207
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5footballsupertips_id_seq OWNED BY public.over2p5footballsupertips.id;


--
-- TOC entry 205 (class 1259 OID 17002)
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5goalsnow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 205
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5goalsnow_id_seq OWNED BY public.over2p5goalsnow.id;


--
-- TOC entry 209 (class 1259 OID 17024)
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5orbitxch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 209
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5orbitxch_id_seq OWNED BY public.over2p5orbitxch.id;


--
-- TOC entry 2888 (class 2604 OID 16906)
-- Name: over2p5bets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets ALTER COLUMN id SET DEFAULT nextval('public.over2p5bets_id_seq'::regclass);


--
-- TOC entry 2890 (class 2604 OID 17018)
-- Name: over2p5footballsupertips id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips ALTER COLUMN id SET DEFAULT nextval('public.over2p5footballsupertips_id_seq'::regclass);


--
-- TOC entry 2889 (class 2604 OID 17007)
-- Name: over2p5goalsnow id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow ALTER COLUMN id SET DEFAULT nextval('public.over2p5goalsnow_id_seq'::regclass);


--
-- TOC entry 2892 (class 2604 OID 17029)
-- Name: over2p5orbitxch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch ALTER COLUMN id SET DEFAULT nextval('public.over2p5orbitxch_id_seq'::regclass);


--
-- TOC entry 3032 (class 0 OID 16493)
-- Dependencies: 203
-- Data for Name: over2p5bets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetResultTime", "BetId") FROM stdin;
18	2023-09-06 19:00:00	SonderjyskE	Vejle	2023-09-06 20:15:04.824315	Lay	Under	2.50	1.50	1.64	1	\N	\N	\N
19	2023-09-06 19:00:00	SonderjyskE	Vejle	2023-09-06 20:38:40.392177	Back	Under	2.50	1.00	1.12	1	\N	\N	\N
20	2023-09-08 19:45:00	Turkey	Armenia	2023-09-08 21:12:52.123619	Lay	Under	2.50	1.50	1.44	1	\N	\N	\N
21	2023-09-08 19:45:00	Turkey	Armenia	2023-09-08 21:27:16.909669	Back	Under	2.50	1.00	1.13	1	\N	\N	\N
22	2023-09-09 19:45:00	Romania	Israel	2023-09-09 20:00:01.58423	Lay	Under	2.50	1.50	1.71	1	\N	\N	\N
23	2023-09-09 19:45:00	Romania	Israel	2023-09-09 21:27:19.539354	Back	Under	2.50	1.00	1.52	1	\N	\N	\N
24	2023-09-16 23:00:00	Atlanta Utd	Inter Miami CF	2023-09-16 23:36:29.549506	Lay	Under	2.50	1.50	1.10	5	\N	\N	\N
25	2023-09-17 11:15:00	PEC Zwolle	Go Ahead Eagles	2023-09-17 12:34:56.107165	Lay	Under	2.50	1.50	1.56	5	\N	\N	\N
26	2023-09-17 13:00:00	Fredericia	FC Helsingor	2023-09-17 13:15:07.071973	Lay	Under	1.50	1.50	2.28	5	\N	\N	\N
27	2023-09-17 13:00:00	Vejle	Randers	2023-09-17 13:15:02.031318	Lay	Under	2.50	1.50	1.68	5	\N	\N	\N
28	2023-09-17 13:30:00	Excelsior	Almere City	2023-09-17 13:45:06.999307	Lay	Under	1.50	1.50	1.86	5	\N	\N	\N
29	2023-09-17 13:00:00	Fredericia	FC Helsingor	2023-09-17 14:37:45.097641	Back	Under	1.50	1.14	1.14	5	\N	\N	\N
30	2023-09-17 13:00:00	Vejle	Randers	2023-09-17 14:41:10.263215	Back	Under	2.50	1.50	1.50	5	\N	\N	\N
31	2023-09-17 13:30:00	Excelsior	Almere City	2023-09-17 15:03:15.003938	Back	Under	1.50	1.14	1.14	5	\N	\N	\N
32	2023-09-17 15:45:00	Cambuur Leeuwarden	Willem II	2023-09-17 16:00:02.382652	Lay	Under	1.50	1.50	1.78	5	\N	\N	\N
33	2023-09-17 15:45:00	Cambuur Leeuwarden	Willem II	2023-09-17 17:22:10.183766	Back	Under	1.50	1.14	1.14	5	\N	\N	\N
34	2023-09-17 19:45:00	Lyon	Le Havre	2023-09-17 20:00:02.511832	Lay	Under	1.50	1.50	1.88	5	\N	\N	\N
35	2023-09-17 19:45:00	Lyon	Le Havre	2023-09-17 21:19:40.661111	Back	Under	1.50	1.14	1.14	5	\N	\N	\N
36	2023-09-18 19:00:00	De Graafschap	Helmond Sport	2023-09-18 19:15:17.13321	Lay	Under	2.50	1.50	2.00	5	\N	\N	\N
37	2023-09-18 19:00:00	FC Oss	FC Dordrecht	2023-09-18 19:15:07.098199	Lay	Under	2.50	1.50	1.99	5	\N	\N	\N
38	2023-09-18 19:00:00	FC Oss	FC Dordrecht	2023-09-18 20:38:47.400989	Back	Under	2.50	1.13	1.13	5	\N	\N	\N
39	2023-09-18 19:00:00	De Graafschap	Helmond Sport	2023-09-18 20:43:56.624064	Back	Under	2.50	1.50	1.50	5	\N	\N	\N
40	2023-09-21 00:30:00	Charlotte FC	Philadelphia	2023-09-21 00:45:17.177764	Lay	Under	1.50	1.50	1.74	5	\N	\N	\N
41	2023-09-21 00:30:00	CF Montreal	FC Cincinnati	2023-09-21 00:45:07.178901	Lay	Under	1.50	1.50	1.66	5	\N	\N	\N
42	2023-09-21 00:30:00	Inter Miami CF	Toronto FC	2023-09-21 00:45:12.149575	Lay	Under	2.50	1.50	2.16	5	\N	\N	\N
43	2023-09-21 00:30:00	CF Montreal	FC Cincinnati	2023-09-21 02:17:57.864237	Back	Under	1.50	1.50	1.52	5	\N	\N	\N
44	2023-09-21 01:30:00	Kansas City	Nashville SC	2023-09-21 01:45:07.842214	Lay	Under	2.50	1.50	1.87	5	\N	\N	\N
45	2023-09-21 01:30:00	St Louis City SC	Los Angeles FC	2023-09-21 01:45:12.80983	Lay	Under	1.50	1.50	1.96	5	\N	\N	\N
46	2023-09-21 01:30:00	St Louis City SC	Los Angeles FC	2023-09-21 03:18:22.488218	Back	Under	1.50	1.13	1.13	5	\N	\N	\N
47	2023-09-21 03:30:00	Portland Timbers	San Jose Earthquakes	2023-09-21 03:45:03.908277	Lay	Under	2.50	1.50	1.97	5	\N	\N	\N
48	2023-09-22 18:00:00	Kolding IF	Fredericia	2023-09-22 18:53:43.235772	Lay	Under	2.50	1.50	2.20	5	\N	\N	\N
49	2023-09-22 18:00:00	AaB	HB Koge	2023-09-22 18:53:53.23891	Lay	Under	2.50	1.50	2.10	5	\N	\N	\N
50	2023-09-22 18:00:00	Lyngby	Vejle	2023-09-22 19:17:29.821308	Lay	Under	1.50	1.50	1.47	5	\N	\N	\N
51	2023-09-22 18:00:00	Lyngby	Vejle	2023-09-22 19:24:46.152212	Back	Under	1.50	1.50	1.10	5	\N	\N	\N
52	2023-09-22 18:00:00	AaB	HB Koge	2023-09-22 19:41:07.183869	Back	Under	2.50	1.13	1.13	5	\N	\N	\N
53	2023-09-22 19:00:00	Go Ahead Eagles	Fortuna Sittard	2023-09-22 19:54:01.766341	Lay	Under	2.50	1.50	1.90	5	\N	\N	\N
54	2023-09-22 19:00:00	FC Dordrecht	Jong AZ Alkmaar	2023-09-22 19:54:06.788161	Lay	Under	1.50	1.50	2.08	5	\N	\N	\N
55	2023-09-22 19:00:00	ADO Den Haag	SC Telstar	2023-09-22 19:53:56.767956	Lay	Under	2.50	1.50	2.28	5	\N	\N	\N
56	2023-09-22 19:00:00	FC Dordrecht	Jong AZ Alkmaar	2023-09-22 20:36:10.930015	Back	Under	1.50	1.13	1.13	5	\N	\N	\N
57	2023-09-22 19:00:00	Go Ahead Eagles	Fortuna Sittard	2023-09-22 20:42:05.936741	Back	Under	2.50	1.52	1.52	5	\N	\N	\N
58	2023-09-22 19:00:00	ADO Den Haag	SC Telstar	2023-09-22 20:46:00.820346	Back	Under	2.50	1.51	1.51	5	\N	\N	\N
59	2023-09-22 19:45:00	Standard	Westerlo	2023-09-22 20:00:08.344166	Lay	Under	1.50	1.50	1.93	5	\N	\N	\N
60	2023-09-22 20:00:00	Monaco	Nice	2023-09-22 20:15:47.745171	Lay	Under	1.50	1.50	1.91	5	\N	\N	\N
61	2023-09-22 19:45:00	Standard	Westerlo	2023-09-22 21:18:59.228056	Back	Under	1.50	1.12	1.12	5	\N	\N	\N
63	2023-09-23 14:00:00	Degerfors	Malmo FF	2023-09-23 15:05:51.438238	Lay	Under	2.50	1.50	2.08	5	\N	\N	\N
64	2023-09-23 14:00:00	Ranheim IL	Fredrikstad	2023-09-23 15:07:22.313319	Lay	Under	1.50	1.50	1.77	5	\N	\N	\N
65	2023-09-23 15:00:00	Leicester	Bristol City	2023-09-23 16:06:32.658819	Lay	Under	1.50	1.50	1.87	5	\N	\N	\N
66	2023-09-23 15:00:00	Charleroi	Kortrijk	2023-09-23 16:06:32.986303	Lay	Under	2.50	1.50	2.14	5	\N	\N	\N
67	2023-09-23 14:00:00	Jonkopings Sodra	Orgryte	2023-09-23 16:07:45.56413	Lay	Under	2.50	1.50	1.84	5	\N	\N	\N
68	2023-09-23 15:00:00	Crystal Palace	Fulham	2023-09-23 16:10:19.404682	Lay	Under	1.50	1.50	1.51	5	\N	\N	\N
69	2023-09-23 16:00:00	Red Bull Salzburg	FC Blau Weiss Linz	2023-09-23 17:06:38.044984	Lay	Under	1.50	1.50	2.12	5	\N	\N	\N
70	2023-09-23 16:00:00	Red Bull Salzburg	FC Blau Weiss Linz	2023-09-23 17:44:58.417991	Back	Under	1.50	1.50	1.46	5	\N	\N	\N
71	2023-09-23 17:00:00	Lausanne	FC Zurich	2023-09-23 18:08:52.730164	Lay	Under	1.50	1.50	1.80	5	\N	\N	\N
72	2023-09-23 17:00:00	Lausanne	FC Zurich	2023-09-23 18:33:30.992741	Back	Under	1.50	1.13	1.13	5	\N	\N	\N
73	2023-09-23 17:30:00	Barcelona	Celta Vigo	2023-09-23 18:40:27.410129	Lay	Under	2.50	1.50	2.34	5	\N	\N	\N
74	2023-09-23 19:30:00	Grasshoppers Zurich	St Gallen	2023-09-23 20:36:05.423746	Lay	Under	2.50	1.50	2.32	5	\N	\N	\N
75	2023-09-23 19:45:00	Antwerp	Molenbeek	2023-09-23 20:48:47.231746	Lay	Under	1.50	1.50	1.98	5	\N	\N	\N
76	2023-09-23 20:00:00	Brest	Lyon	2023-09-23 21:02:16.715748	Lay	Under	1.50	1.50	1.85	5	\N	\N	\N
77	2023-09-23 20:00:00	Burnley	Man Utd	2023-09-23 21:07:21.160819	Lay	Under	2.50	1.50	1.91	5	\N	\N	\N
78	2023-09-23 20:00:00	Almeria	Valencia	2023-09-23 21:07:22.318188	Lay	Under	2.50	1.50	1.73	5	\N	\N	\N
79	2023-09-23 19:30:00	Grasshoppers Zurich	St Gallen	2023-09-23 21:14:45.940707	Back	Under	2.50	1.49	1.49	5	\N	\N	\N
80	2023-09-23 19:45:00	Antwerp	Molenbeek	2023-09-23 21:22:29.51058	Back	Under	1.50	1.12	1.12	5	\N	\N	\N
81	2023-09-23 20:00:00	Brest	Lyon	2023-09-23 21:30:46.899187	Back	Under	1.50	1.14	1.14	5	\N	\N	\N
82	2023-09-23 20:00:00	Burnley	Man Utd	2023-09-23 21:36:56.528216	Back	Under	2.50	1.14	1.14	5	\N	\N	\N
83	2023-09-24 00:30:00	FC Cincinnati	Charlotte FC	2023-09-24 01:43:10.603331	Lay	Under	2.50	1.50	1.85	5	\N	\N	\N
84	2023-09-24 00:30:00	Philadelphia	Los Angeles FC	2023-09-24 01:46:07.911155	Lay	Under	1.50	1.50	1.75	5	\N	\N	\N
85	2023-09-24 11:15:00	Sparta Rotterdam	Vitesse Arnhem	2023-09-24 12:26:01.642845	Lay	Under	2.50	1.50	1.82	5	\N	\N	\N
86	2023-09-24 11:30:00	Empoli	Inter	2023-09-24 12:31:50.060174	Lay	Under	1.50	1.50	2.16	5	\N	\N	\N
87	2023-09-24 11:15:00	Sparta Rotterdam	Vitesse Arnhem	2023-09-24 12:47:24.887836	Back	Under	2.50	1.25	1.25	5	\N	\N	\N
88	2023-09-24 11:30:00	Empoli	Inter	2023-09-24 13:11:30.964684	Back	Under	1.50	1.50	1.49	5	\N	\N	\N
89	2023-09-24 12:30:00	Lommel	Francs Borains	2023-09-24 13:33:53.392619	Lay	Under	2.50	1.50	2.06	5	\N	\N	\N
90	2023-09-24 12:30:00	Fortuna Dusseldorf	Hannover	2023-09-24 13:35:57.229267	Lay	Under	2.50	1.50	2.30	5	\N	\N	\N
91	2023-09-24 12:30:00	Lommel	Francs Borains	2023-09-24 14:01:21.797074	Back	Under	2.50	1.29	1.29	5	\N	\N	\N
92	2023-09-24 13:00:00	Silkeborg	Viborg	2023-09-24 14:06:00.75962	Lay	Under	2.50	1.50	1.66	5	\N	\N	\N
93	2023-09-24 13:00:00	Brondby	FC Copenhagen	2023-09-24 14:08:58.261391	Lay	Under	2.50	1.50	1.87	5	\N	\N	\N
94	2023-09-24 12:30:00	Fortuna Dusseldorf	Hannover	2023-09-24 14:13:36.825404	Back	Under	2.50	1.52	1.52	5	\N	\N	\N
95	2023-09-24 13:30:00	LASK Linz	Hartberg	2023-09-24 14:34:05.186713	Lay	Under	1.50	1.50	1.97	5	\N	\N	\N
96	2023-09-24 13:00:00	Silkeborg	Viborg	2023-09-24 14:41:40.597055	Back	Under	2.50	1.52	1.52	5	\N	\N	\N
97	2023-09-24 14:00:00	Chelsea	Aston Villa	2023-09-24 15:03:48.959083	Lay	Under	1.50	1.50	1.97	5	\N	\N	\N
98	2023-09-24 14:00:00	Bryne	Kristiansund	2023-09-24 15:03:49.293575	Lay	Under	1.50	1.50	1.91	5	\N	\N	\N
99	2023-09-24 13:30:00	LASK Linz	Hartberg	2023-09-24 15:04:48.130271	Back	Under	1.50	1.14	1.14	5	\N	\N	\N
100	2023-09-24 14:00:00	Start	Moss	2023-09-24 15:06:11.060085	Lay	Under	1.50	1.50	1.80	5	\N	\N	\N
101	2023-09-24 14:00:00	Atalanta	Cagliari	2023-09-24 15:06:11.407514	Lay	Under	2.50	1.50	1.87	5	\N	\N	\N
102	2023-09-24 14:00:00	Udinese	Fiorentina	2023-09-24 15:07:53.783557	Lay	Under	2.50	1.50	1.73	5	\N	\N	\N
103	2023-09-24 14:00:00	Start	Moss	2023-09-24 15:35:55.933625	Back	Under	1.50	1.13	1.13	5	\N	\N	\N
104	2023-09-24 14:00:00	Udinese	Fiorentina	2023-09-24 15:36:33.818363	Back	Under	2.50	1.14	1.14	5	\N	\N	\N
105	2023-09-24 14:00:00	Atalanta	Cagliari	2023-09-24 15:45:05.398451	Back	Under	2.50	1.47	1.47	5	\N	\N	\N
106	2023-09-24 14:00:00	Chelsea	Aston Villa	2023-09-24 15:47:49.387326	Back	Under	1.50	1.50	1.47	5	\N	\N	\N
107	2023-09-24 15:00:00	Sunderland	Cardiff	2023-09-24 16:17:17.924685	Lay	Under	1.50	1.50	1.74	5	\N	\N	\N
108	2023-09-24 15:00:00	Sunderland	Cardiff	2023-09-24 16:40:47.651344	Back	Under	1.50	1.14	1.14	5	\N	\N	\N
109	2023-09-24 15:45:00	RKC Waalwijk	FC Twente	2023-09-24 16:57:29.51015	Lay	Under	1.50	1.50	1.90	5	\N	\N	\N
110	2023-09-24 16:00:00	Odds BK	Haugesund	2023-09-24 17:13:22.022082	Lay	Under	1.50	1.50	3.25	5	\N	\N	\N
111	2023-09-24 16:00:00	Lillestrom	Rosenborg	2023-09-24 17:16:23.174412	Lay	Under	2.50	1.50	1.69	5	\N	\N	\N
112	2023-09-24 16:05:00	Montpellier	Rennes	2023-09-24 17:18:22.272423	Lay	Under	1.50	1.50	1.53	5	\N	\N	\N
113	2023-09-24 15:45:00	RKC Waalwijk	FC Twente	2023-09-24 17:21:16.780317	Back	Under	1.50	1.13	1.13	5	\N	\N	\N
114	2023-09-24 16:05:00	Montpellier	Rennes	2023-09-24 17:39:59.941992	Back	Under	1.50	1.13	1.13	5	\N	\N	\N
115	2023-09-24 16:30:00	Varbergs BoIS	Hammarby	2023-09-24 17:42:26.175161	Lay	Under	1.50	1.50	1.79	5	\N	\N	\N
116	2023-09-24 16:30:00	Eintracht Frankfurt	Freiburg	2023-09-24 17:46:41.229081	Lay	Under	1.50	1.50	1.45	5	\N	\N	\N
117	2023-09-24 16:30:00	Kalmar FF	Hacken	2023-09-24 17:46:41.471614	Lay	Under	2.50	1.50	1.75	5	\N	\N	\N
118	2023-09-24 16:30:00	Eintracht Frankfurt	Freiburg	2023-09-24 18:04:26.544605	Back	Under	1.50	1.14	1.14	5	\N	\N	\N
119	2023-09-24 16:30:00	Kalmar FF	Hacken	2023-09-24 18:10:43.293814	Back	Under	2.50	1.12	1.12	5	\N	\N	\N
120	2023-09-24 16:30:00	Varbergs BoIS	Hammarby	2023-09-24 18:14:08.001955	Back	Under	1.50	1.50	1.52	5	\N	\N	\N
121	2023-09-24 17:00:00	Bologna	Napoli	2023-09-24 18:16:51.11982	Lay	Under	1.50	1.50	1.52	5	\N	\N	\N
122	2023-09-24 17:00:00	Bologna	Napoli	2023-09-24 18:38:18.697161	Back	Under	1.50	1.14	1.14	5	\N	\N	\N
\.


--
-- TOC entry 3037 (class 0 OID 17015)
-- Dependencies: 208
-- Data for Name: over2p5footballsupertips; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5footballsupertips (id, home, away, date_time, url, league_id) FROM stdin;
721	Union Saint Gilloise	Toulouse	2023-09-21 17:45:00	\N	245
722	LASK Linz	Liverpool	2023-09-21 17:45:00	\N	245
723	Panathinaikos	Villarreal	2023-09-21 17:45:00	\N	245
724	Rennes	Maccabi Haifa	2023-09-21 17:45:00	\N	245
725	Servette	Slavia Prague	2023-09-21 17:45:00	\N	245
726	Bayer Leverkusen	BK Hacken	2023-09-21 17:45:00	\N	245
727	Charlotte FC	Philadelphia Union	2023-09-21 00:30:00	\N	76
728	Columbus Crew	Chicago Fire	2023-09-21 00:30:00	\N	76
729	DC United	Atlanta United	2023-09-21 00:30:00	\N	76
730	Inter Miami CF	Toronto FC	2023-09-21 00:30:00	\N	76
731	CF Montreal	FC Cincinnati	2023-09-21 00:30:00	\N	76
732	New York Red Bulls	Austin FC	2023-09-21 00:30:00	\N	76
733	New York City FC	Orlando City SC	2023-09-21 00:30:00	\N	76
747	Standard Liege	Westerlo	2023-09-22 19:45:00	\N	68
748	Lyngby	Vejle	2023-09-22 18:00:00	\N	40
749	AaB	HB Køge	2023-09-22 18:00:00	\N	147
750	B93 Copenhagen	Hobro IK	2023-09-22 18:00:00	\N	147
751	Kolding IF	FC Fredericia	2023-09-22 18:00:00	\N	147
752	Monaco	Nice	2023-09-22 20:00:00	\N	5
753	VfB Stuttgart	Darmstadt	2023-09-22 19:30:00	\N	1
754	Go Ahead Eagles	Fortuna Sittard	2023-09-22 19:00:00	\N	196
755	ADO Den Haag	Telstar	2023-09-22 19:00:00	\N	199
756	PSV Reserves	VVV	2023-09-22 19:00:00	\N	199
757	Roda JC	FC Den Bosch	2023-09-22 19:00:00	\N	199
758	NAC	FC Emmen	2023-09-22 19:00:00	\N	199
759	Helmond Sport	FC Groningen	2023-09-22 19:00:00	\N	199
760	FC Dordrecht	AZ Reserves	2023-09-22 19:00:00	\N	199
761	Willem II	Top Oss	2023-09-22 19:00:00	\N	199
792	Nantes	Lorient	2023-09-23 16:00:00	\N	5
793	Brest	Lyon	2023-09-23 20:00:00	\N	5
777	FC Salzburg	FC Blau Weiss Linz	2023-09-23 16:00:00	\N	43
778	Austria Klagenfurt	Austria Lustenau	2023-09-23 16:00:00	\N	43
779	WSG Swarovski Tirol	Wolfsberger AC	2023-09-23 16:00:00	\N	43
780	Charleroi	KV Kortrijk	2023-09-23 15:00:00	\N	68
781	KV Mechelen	OH Leuven	2023-09-23 17:15:00	\N	68
794	Bayern Munich	Bochum	2023-09-23 14:30:00	\N	1
795	Borussia Dortmund	Wolfsburg	2023-09-23 14:30:00	\N	1
796	Union Berlin	TSG Hoffenheim	2023-09-23 14:30:00	\N	1
797	Borussia Mgladbach	RB Leipzig	2023-09-23 14:30:00	\N	1
798	Augsburg	Mainz	2023-09-23 14:30:00	\N	1
799	Werder Bremen	Cologne	2023-09-23 17:30:00	\N	1
895	Greuther Furth	Karlsruher SC	2023-09-23 12:00:00	\N	93
896	Eintracht Braunschweig	Nurnberg	2023-09-23 12:00:00	\N	93
800	FC Volendam	Heracles	2023-09-23 15:30:00	\N	196
801	NEC	FC Utrecht	2023-09-23 17:45:00	\N	196
802	Almere City FC	PSV	2023-09-23 19:00:00	\N	196
803	Heerenveen	Excelsior	2023-09-23 20:00:00	\N	196
910	Aalesund	Stabaek	2023-09-23 17:00:00	\N	13
804	Hodd	FK Jerv	2023-09-23 14:00:00	\N	204
805	Ranheim	Fredrikstad	2023-09-23 14:00:00	\N	204
806	Skeid	Kongsvinger	2023-09-23 14:00:00	\N	204
807	Sogndal	Asane	2023-09-23 14:00:00	\N	204
915	Moreirense	SC Farense	2023-09-23 15:30:00	\N	8
916	FC Porto	Gil Vicente	2023-09-23 20:30:00	\N	8
917	Daejeon Hana Citizen	Suwon Bluewings	2023-09-23 06:00:00	\N	66
808	Barcelona	Celta Vigo	2023-09-23 17:30:00	\N	3
809	Almeria	Valencia	2023-09-23 20:00:00	\N	3
921	Degerfors	Malmo FF	2023-09-23 14:00:00	\N	14
922	Brommapojkarna	IFK Norrkoping	2023-09-23 16:30:00	\N	14
923	Landskrona	Osters IF	2023-09-23 12:00:00	\N	336
811	FC Cincinnati	Charlotte FC	2023-09-24 00:30:00	\N	76
812	DC United	New York Red Bulls	2023-09-24 00:30:00	\N	76
813	New York City FC	Toronto FC	2023-09-24 00:30:00	\N	76
814	Philadelphia Union	Los Angeles FC	2023-09-24 00:30:00	\N	76
815	Chicago Fire	New England Revolution	2023-09-24 01:30:00	\N	76
816	FC Dallas	Columbus Crew	2023-09-24 01:30:00	\N	76
810	Atlanta United	CF Montreal	2023-09-24 00:30:00	\N	76
897	Wehen SV	Elversberg	2023-09-23 12:00:00	\N	93
898	St Pauli	Schalke	2023-09-23 19:30:00	\N	93
899	Sassuolo	Juventus	2023-09-23 17:00:00	\N	4
900	Lazio	Monza	2023-09-23 19:45:00	\N	4
901	Albirex Niigata	Yokohama FC	2023-09-23 06:00:00	\N	28
902	FC Tokyo	Sagan Tosu	2023-09-23 07:00:00	\N	28
903	Nagoya Grampus	Consadole Sapporo	2023-09-23 08:00:00	\N	28
782	Antwerp	RWD Molenbeek	2023-09-23 19:45:00	\N	68
783	RFC Seraing	Anderlecht II	2023-09-23 15:00:00	\N	136
784	Club Brugge II	Standard Liege II	2023-09-23 19:00:00	\N	136
785	KV Oostende	Genk II	2023-09-23 19:00:00	\N	136
786	AC Horsens	Vendsyssel FF	2023-09-23 12:00:00	\N	147
787	Crystal Palace	Fulham	2023-09-23 15:00:00	\N	2
788	Luton	Wolverhampton	2023-09-23 15:00:00	\N	2
789	Man City	Nottm Forest	2023-09-23 15:00:00	\N	2
790	Brentford	Everton	2023-09-23 17:30:00	\N	2
791	Burnley	Man Utd	2023-09-23 20:00:00	\N	2
881	Ipswich	Blackburn	2023-09-23 15:00:00	\N	77
882	Leeds	Watford	2023-09-23 15:00:00	\N	77
883	Leicester	Bristol City	2023-09-23 15:00:00	\N	77
884	Middlesbrough	Southampton	2023-09-23 15:00:00	\N	77
885	Plymouth	Norwich	2023-09-23 15:00:00	\N	77
886	Swansea	Sheff Wed	2023-09-23 15:00:00	\N	77
904	Kyoto Sanga FC	Sanfrecce Hiroshima	2023-09-23 11:00:00	\N	28
905	Vissel Kobe	Cerezo Osaka	2023-09-23 11:00:00	\N	28
918	Jeju United	FC Seoul	2023-09-23 08:30:00	\N	66
924	Västerås SK FK	GIF Sundsvall	2023-09-23 14:00:00	\N	336
925	Jonkopings Sodra	Orgryte IS	2023-09-23 14:00:00	\N	336
926	Gefle IF	GAIS	2023-09-23 14:00:00	\N	336
927	Skövde AIK	Ostersunds FK	2023-09-23 14:00:00	\N	336
928	Lausanne Sports	FC Zurich	2023-09-23 17:00:00	\N	15
929	Winterthur	Stade Lausanne-Ouchy	2023-09-23 17:00:00	\N	15
930	Grasshoppers	St Gallen	2023-09-23 19:30:00	\N	15
949	LASK Linz	Hartberg	2023-09-24 13:30:00	\N	43
950	SCR Altach	FK Austria Vienna	2023-09-24 13:30:00	\N	43
951	Rapid Vienna	SK Sturm Graz	2023-09-24 16:00:00	\N	43
952	Genk	Sint-Truidense	2023-09-24 12:30:00	\N	68
953	Cercle Brugge	Union Saint Gilloise	2023-09-24 15:00:00	\N	68
954	Anderlecht	Club Brugge	2023-09-24 17:30:00	\N	68
955	Gent	Eupen	2023-09-24 18:15:00	\N	68
956	Lommel	Francs Borains	2023-09-24 12:30:00	\N	136
957	SK Beveren	RFC Liege	2023-09-24 15:00:00	\N	136
958	Lierse Kempenzonen	KFCO Beerschot Wilrijk	2023-09-24 18:15:00	\N	136
959	Brondby	FC Copenhagen	2023-09-24 13:00:00	\N	40
960	Silkeborg IF	Viborg	2023-09-24 13:00:00	\N	40
961	Midtjylland	Odense BK	2023-09-24 17:00:00	\N	40
962	Naestved IF	Hillerød	2023-09-24 12:00:00	\N	147
963	FC Helsingor	Sonderjyske	2023-09-24 13:00:00	\N	147
964	Chelsea	Aston Villa	2023-09-24 14:00:00	\N	2
965	Arsenal	Tottenham	2023-09-24 14:00:00	\N	2
966	Brighton	Bournemouth	2023-09-24 14:00:00	\N	2
967	Liverpool	West Ham	2023-09-24 14:00:00	\N	2
968	Sheff Utd	Newcastle	2023-09-24 16:30:00	\N	2
969	Stoke	Hull	2023-09-24 12:00:00	\N	77
970	Sunderland	Cardiff	2023-09-24 15:00:00	\N	77
971	Lens	Toulouse	2023-09-24 14:00:00	\N	5
972	Montpellier	Rennes	2023-09-24 16:05:00	\N	5
973	PSG	Marseille	2023-09-24 19:45:00	\N	5
974	Bayer Leverkusen	Heidenheim	2023-09-24 14:30:00	\N	1
975	Eintracht Frankfurt	SC Freiburg	2023-09-24 16:30:00	\N	1
976	Fortuna Dusseldorf	Hannover 96	2023-09-24 12:30:00	\N	93
977	Holstein Kiel	Hertha Berlin	2023-09-24 12:30:00	\N	93
978	Kaiserslautern	Hansa Rostock	2023-09-24 12:30:00	\N	93
979	Empoli	Inter Milan	2023-09-24 11:30:00	\N	4
980	Atalanta	Cagliari	2023-09-24 14:00:00	\N	4
981	Udinese	Fiorentina	2023-09-24 14:00:00	\N	4
982	Bologna	Napoli	2023-09-24 17:00:00	\N	4
983	Kashima Antlers	Yokohama F-Marinos	2023-09-24 07:00:00	\N	28
984	Shonan Bellmare	Kawasaki Frontale	2023-09-24 08:00:00	\N	28
985	Gamba Osaka	Urawa Red Diamonds	2023-09-24 09:00:00	\N	28
986	Sparta Rotterdam	Vitesse	2023-09-24 11:15:00	\N	196
987	Ajax	Feyenoord	2023-09-24 13:30:00	\N	196
988	RKC	FC Twente	2023-09-24 15:45:00	\N	196
989	PEC Zwolle	AZ	2023-09-24 15:45:00	\N	196
990	Maastricht	De Graafschap	2023-09-24 13:30:00	\N	199
991	Bodo/Glimt	Valerenga	2023-09-24 16:00:00	\N	13
992	HamKam	Sarpsborg	2023-09-24 16:00:00	\N	13
993	Lillestrom	Rosenborg	2023-09-24 16:00:00	\N	13
994	Odd BK	Haugesund	2023-09-24 16:00:00	\N	13
995	Stromsgodset	Molde	2023-09-24 16:00:00	\N	13
996	Viking FK	Sandefjord	2023-09-24 16:00:00	\N	13
997	SK Brann	Tromso	2023-09-24 18:15:00	\N	13
998	Bryne	Kristiansund BK	2023-09-24 14:00:00	\N	204
999	KFUM	Mjondalen	2023-09-24 14:00:00	\N	204
1000	Raufoss	Sandnes Ulf	2023-09-24 14:00:00	\N	204
1001	IK Start	Moss	2023-09-24 14:00:00	\N	204
1002	Chaves	Estrela Amadora	2023-09-24 15:30:00	\N	8
1003	Portimonense	Benfica	2023-09-24 18:00:00	\N	8
1004	Braga	Boavista	2023-09-24 20:30:00	\N	8
1005	Suwon FC	Ulsan Hyundai	2023-09-24 06:00:00	\N	66
1006	Daegu FC	Pohang Steelers	2023-09-24 11:00:00	\N	66
1007	Rayo Vallecano	Villarreal	2023-09-24 15:15:00	\N	3
1008	Las Palmas	Granada	2023-09-24 17:30:00	\N	3
1009	Atletico Madrid	Real Madrid	2023-09-24 20:00:00	\N	3
1010	Kalmar FF	BK Hacken	2023-09-24 16:30:00	\N	14
1011	Varbergs BoIS FC	Hammarby	2023-09-24 16:30:00	\N	14
1012	Utsiktens BK	Trelleborgs FF	2023-09-24 12:00:00	\N	336
1013	Yverdon Sport FC	Basel	2023-09-24 13:15:00	\N	15
1014	Lucerne	Servette	2023-09-24 15:30:00	\N	15
1015	Young Boys	Lugano	2023-09-24 15:30:00	\N	15
1023	Orlando City SC	Inter Miami CF	2023-09-25 00:30:00	\N	76
1024	Austin FC	LA Galaxy	2023-09-25 02:30:00	\N	76
\.


--
-- TOC entry 3035 (class 0 OID 17004)
-- Dependencies: 206
-- Data for Name: over2p5goalsnow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5goalsnow (id, home, away, date_time, url, league_id) FROM stdin;
1013	VfB Stuttgart	Darmstadt	2023-09-22 19:30:00	\N	1
1014	Monaco	Nice	2023-09-22 20:00:00	\N	5
1015	Standard Liege	Westerlo	2023-09-22 19:45:00	\N	68
1016	Zulte-Waregem	Deinze	2023-09-22 19:00:00	\N	136
1017	Patro Eisden Maasmechelen	FCV Dender EH	2023-09-22 19:00:00	\N	136
1018	Lyngby	Vejle	2023-09-22 18:00:00	\N	40
1019	AaB	HB Køge	2023-09-22 18:00:00	\N	147
1020	B93 Copenhagen	Hobro IK	2023-09-22 18:00:00	\N	147
1021	Kolding IF	FC Fredericia	2023-09-22 18:00:00	\N	147
1022	Go Ahead Eagles	Fortuna Sittard	2023-09-22 19:00:00	\N	196
1023	ADO Den Haag	Telstar	2023-09-22 19:00:00	\N	199
929	LASK Linz	Liverpool	2023-09-21 17:45:00	\N	245
930	Panathinaikos	Villarreal	2023-09-21 17:45:00	\N	245
931	Rennes	Maccabi Haifa	2023-09-21 17:45:00	\N	245
932	Servette	Slavia Prague	2023-09-21 17:45:00	\N	245
933	Sheriff Tiraspol	Roma	2023-09-21 17:45:00	\N	245
934	Bayer Leverkusen	BK Hacken	2023-09-21 17:45:00	\N	245
935	FK Qarabag	Molde	2023-09-21 17:45:00	\N	245
936	West Ham	FK Backa Topola	2023-09-21 20:00:00	\N	245
937	Olympiakos	SC Freiburg	2023-09-21 20:00:00	\N	245
938	Ajax	Marseille	2023-09-21 20:00:00	\N	245
939	Brighton	AEK Athens	2023-09-21 20:00:00	\N	245
940	Sparta Prague	Aris Limassol	2023-09-21 20:00:00	\N	245
941	Rangers	Real Betis	2023-09-21 20:00:00	\N	245
942	Atalanta	Rakow Czestochowa	2023-09-21 20:00:00	\N	245
943	SK Sturm Graz	Sporting	2023-09-21 20:00:00	\N	245
944	Charlotte FC	Philadelphia Union	2023-09-21 00:30:00	\N	76
945	Columbus Crew	Chicago Fire	2023-09-21 00:30:00	\N	76
946	DC United	Atlanta United	2023-09-21 00:30:00	\N	76
947	Inter Miami CF	Toronto FC	2023-09-21 00:30:00	\N	76
948	CF Montreal	FC Cincinnati	2023-09-21 00:30:00	\N	76
949	New York Red Bulls	Austin FC	2023-09-21 00:30:00	\N	76
950	New York City FC	Orlando City SC	2023-09-21 00:30:00	\N	76
951	Houston Dynamo	Vancouver Whitecaps	2023-09-21 01:30:00	\N	76
952	Sporting Kansas City	Nashville SC	2023-09-21 01:30:00	\N	76
953	St. Louis City SC	Los Angeles FC	2023-09-21 01:30:00	\N	76
954	Real Salt Lake	FC Dallas	2023-09-21 02:30:00	\N	76
955	LA Galaxy	Minnesota United	2023-09-21 03:30:00	\N	76
956	Portland Timbers	San Jose Earthquakes	2023-09-21 03:30:00	\N	76
1024	PSV Reserves	VVV	2023-09-22 19:00:00	\N	199
1025	Roda JC	FC Den Bosch	2023-09-22 19:00:00	\N	199
1026	NAC	FC Emmen	2023-09-22 19:00:00	\N	199
1027	FC Dordrecht	AZ Reserves	2023-09-22 19:00:00	\N	199
1028	Willem II	Top Oss	2023-09-22 19:00:00	\N	199
1029	FC Utrecht Reserves	Cambuur Leeuwarden	2023-09-22 19:00:00	\N	199
1051	Borussia Dortmund	Wolfsburg	2023-09-23 14:30:00	\N	1
1052	Union Berlin	TSG Hoffenheim	2023-09-23 14:30:00	\N	1
1053	Borussia Mgladbach	RB Leipzig	2023-09-23 14:30:00	\N	1
1056	Girona	Mallorca	2023-09-23 13:00:00	\N	3
1057	Osasuna	Sevilla	2023-09-23 15:15:00	\N	3
1058	Barcelona	Celta Vigo	2023-09-23 17:30:00	\N	3
1059	Almeria	Valencia	2023-09-23 20:00:00	\N	3
1060	Nantes	Lorient	2023-09-23 16:00:00	\N	5
1061	Brest	Lyon	2023-09-23 20:00:00	\N	5
1062	FC Salzburg	FC Blau Weiss Linz	2023-09-23 16:00:00	\N	43
1063	Austria Klagenfurt	Austria Lustenau	2023-09-23 16:00:00	\N	43
1064	WSG Swarovski Tirol	Wolfsberger AC	2023-09-23 16:00:00	\N	43
1065	Charleroi	KV Kortrijk	2023-09-23 15:00:00	\N	68
1066	KV Mechelen	OH Leuven	2023-09-23 17:15:00	\N	68
1067	Antwerp	RWD Molenbeek	2023-09-23 19:45:00	\N	68
1068	RFC Seraing	Anderlecht II	2023-09-23 15:00:00	\N	136
1069	KV Oostende	Genk II	2023-09-23 19:00:00	\N	136
1070	AC Horsens	Vendsyssel FF	2023-09-23 12:00:00	\N	147
1071	FC Volendam	Heracles	2023-09-23 15:30:00	\N	196
1072	NEC	FC Utrecht	2023-09-23 17:45:00	\N	196
1073	Almere City FC	PSV	2023-09-23 19:00:00	\N	196
1074	Heerenveen	Excelsior	2023-09-23 20:00:00	\N	196
1075	Hodd	FK Jerv	2023-09-23 14:00:00	\N	204
1076	Ranheim	Fredrikstad	2023-09-23 14:00:00	\N	204
1077	Skeid	Kongsvinger	2023-09-23 14:00:00	\N	204
1078	Sogndal	Asane	2023-09-23 14:00:00	\N	204
1080	FC Cincinnati	Charlotte FC	2023-09-24 00:30:00	\N	76
1047	Crystal Palace	Fulham	2023-09-23 15:00:00	\N	2
1048	Luton	Wolverhampton	2023-09-23 15:00:00	\N	2
1049	Burnley	Man Utd	2023-09-23 20:00:00	\N	2
1160	Ipswich	Blackburn	2023-09-23 15:00:00	\N	77
1161	Leicester	Bristol City	2023-09-23 15:00:00	\N	77
1083	Philadelphia Union	Los Angeles FC	2023-09-24 00:30:00	\N	76
1081	DC United	New York Red Bulls	2023-09-24 00:30:00	\N	76
1082	New York City FC	Toronto FC	2023-09-24 00:30:00	\N	76
1084	Chicago Fire	New England Revolution	2023-09-24 01:30:00	\N	76
1085	FC Dallas	Columbus Crew	2023-09-24 01:30:00	\N	76
1079	Atlanta United	CF Montreal	2023-09-24 00:30:00	\N	76
1162	Middlesbrough	Southampton	2023-09-23 15:00:00	\N	77
1050	Bayern Munich	Bochum	2023-09-23 14:30:00	\N	1
1054	Augsburg	Mainz	2023-09-23 14:30:00	\N	1
1055	Werder Bremen	Cologne	2023-09-23 17:30:00	\N	1
1172	Greuther Furth	Karlsruher SC	2023-09-23 12:00:00	\N	93
1163	Plymouth	Norwich	2023-09-23 15:00:00	\N	77
1164	Rotherham	Preston	2023-09-23 15:00:00	\N	77
1165	West Brom	Millwall	2023-09-23 15:00:00	\N	77
1173	Eintracht Braunschweig	Nurnberg	2023-09-23 12:00:00	\N	93
1174	Wehen SV	Elversberg	2023-09-23 12:00:00	\N	93
1175	St Pauli	Schalke	2023-09-23 19:30:00	\N	93
1180	AC Milan	Verona	2023-09-23 14:00:00	\N	4
1181	Sassuolo	Juventus	2023-09-23 17:00:00	\N	4
1182	Lazio	Monza	2023-09-23 19:45:00	\N	4
1194	Vissel Kobe	Cerezo Osaka	2023-09-23 11:00:00	\N	28
1199	Aalesund	Stabaek	2023-09-23 17:00:00	\N	13
1204	Moreirense	SC Farense	2023-09-23 15:30:00	\N	8
1205	Estoril	Vizela	2023-09-23 15:30:00	\N	8
1206	Degerfors	Malmo FF	2023-09-23 14:00:00	\N	14
1207	Brommapojkarna	IFK Norrkoping	2023-09-23 16:30:00	\N	14
1208	Landskrona	Osters IF	2023-09-23 12:00:00	\N	336
1209	Västerås SK FK	GIF Sundsvall	2023-09-23 14:00:00	\N	336
1210	Jonkopings Sodra	Orgryte IS	2023-09-23 14:00:00	\N	336
1211	Gefle IF	GAIS	2023-09-23 14:00:00	\N	336
1212	Skövde AIK	Ostersunds FK	2023-09-23 14:00:00	\N	336
1213	Lausanne Sports	FC Zurich	2023-09-23 17:00:00	\N	15
1214	Winterthur	Stade Lausanne-Ouchy	2023-09-23 17:00:00	\N	15
1215	Grasshoppers	St Gallen	2023-09-23 19:30:00	\N	15
1251	Chelsea	Aston Villa	2023-09-24 14:00:00	\N	2
1252	Arsenal	Tottenham	2023-09-24 14:00:00	\N	2
1253	Brighton	Bournemouth	2023-09-24 14:00:00	\N	2
1254	Liverpool	West Ham	2023-09-24 14:00:00	\N	2
1255	Sheff Utd	Newcastle	2023-09-24 16:30:00	\N	2
1256	Sunderland	Cardiff	2023-09-24 15:00:00	\N	77
1257	Bayer Leverkusen	Heidenheim	2023-09-24 14:30:00	\N	1
1258	Eintracht Frankfurt	SC Freiburg	2023-09-24 16:30:00	\N	1
1259	Fortuna Dusseldorf	Hannover 96	2023-09-24 12:30:00	\N	93
1260	Holstein Kiel	Hertha Berlin	2023-09-24 12:30:00	\N	93
1261	Kaiserslautern	Hansa Rostock	2023-09-24 12:30:00	\N	93
1262	Rayo Vallecano	Villarreal	2023-09-24 15:15:00	\N	3
1263	Atletico Madrid	Real Madrid	2023-09-24 20:00:00	\N	3
1264	Empoli	Inter Milan	2023-09-24 11:30:00	\N	4
1265	Atalanta	Cagliari	2023-09-24 14:00:00	\N	4
1266	Udinese	Fiorentina	2023-09-24 14:00:00	\N	4
1267	Bologna	Napoli	2023-09-24 17:00:00	\N	4
1268	Torino	Roma	2023-09-24 19:45:00	\N	4
1269	Metz	Strasbourg	2023-09-24 12:00:00	\N	5
1270	Lens	Toulouse	2023-09-24 14:00:00	\N	5
1271	Montpellier	Rennes	2023-09-24 16:05:00	\N	5
1272	PSG	Marseille	2023-09-24 19:45:00	\N	5
1273	LASK Linz	Hartberg	2023-09-24 13:30:00	\N	43
1274	SCR Altach	FK Austria Vienna	2023-09-24 13:30:00	\N	43
1275	Rapid Vienna	SK Sturm Graz	2023-09-24 16:00:00	\N	43
1276	Anderlecht	Club Brugge	2023-09-24 17:30:00	\N	68
1277	Gent	Eupen	2023-09-24 18:15:00	\N	68
1278	Lommel	Francs Borains	2023-09-24 12:30:00	\N	136
1279	SK Beveren	RFC Liege	2023-09-24 15:00:00	\N	136
1280	Lierse Kempenzonen	KFCO Beerschot Wilrijk	2023-09-24 18:15:00	\N	136
1281	Brondby	FC Copenhagen	2023-09-24 13:00:00	\N	40
1282	Silkeborg IF	Viborg	2023-09-24 13:00:00	\N	40
1283	Randers FC	AGF Aarhus	2023-09-24 15:00:00	\N	40
1284	Midtjylland	Odense BK	2023-09-24 17:00:00	\N	40
1285	Naestved IF	Hillerød	2023-09-24 12:00:00	\N	147
1286	FC Helsingor	Sonderjyske	2023-09-24 13:00:00	\N	147
1287	Kashima Antlers	Yokohama F-Marinos	2023-09-24 07:00:00	\N	28
1288	Shonan Bellmare	Kawasaki Frontale	2023-09-24 08:00:00	\N	28
1289	Sparta Rotterdam	Vitesse	2023-09-24 11:15:00	\N	196
1290	Ajax	Feyenoord	2023-09-24 13:30:00	\N	196
1291	RKC	FC Twente	2023-09-24 15:45:00	\N	196
1292	PEC Zwolle	AZ	2023-09-24 15:45:00	\N	196
1293	Maastricht	De Graafschap	2023-09-24 13:30:00	\N	199
1294	Bodo/Glimt	Valerenga	2023-09-24 16:00:00	\N	13
1295	HamKam	Sarpsborg	2023-09-24 16:00:00	\N	13
1296	Lillestrom	Rosenborg	2023-09-24 16:00:00	\N	13
1297	Odd BK	Haugesund	2023-09-24 16:00:00	\N	13
1298	Stromsgodset	Molde	2023-09-24 16:00:00	\N	13
1299	Viking FK	Sandefjord	2023-09-24 16:00:00	\N	13
1300	SK Brann	Tromso	2023-09-24 18:15:00	\N	13
1301	Bryne	Kristiansund BK	2023-09-24 14:00:00	\N	204
1302	KFUM	Mjondalen	2023-09-24 14:00:00	\N	204
1303	Raufoss	Sandnes Ulf	2023-09-24 14:00:00	\N	204
1304	IK Start	Moss	2023-09-24 14:00:00	\N	204
1305	Chaves	Estrela Amadora	2023-09-24 15:30:00	\N	8
1306	Portimonense	Benfica	2023-09-24 18:00:00	\N	8
1307	Braga	Boavista	2023-09-24 20:30:00	\N	8
1308	Suwon FC	Ulsan Hyundai	2023-09-24 06:00:00	\N	66
1309	AIK	Djurgarden	2023-09-24 14:00:00	\N	14
1310	Kalmar FF	BK Hacken	2023-09-24 16:30:00	\N	14
1311	Varbergs BoIS FC	Hammarby	2023-09-24 16:30:00	\N	14
1312	Utsiktens BK	Trelleborgs FF	2023-09-24 12:00:00	\N	336
1313	Yverdon Sport FC	Basel	2023-09-24 13:15:00	\N	15
1314	Lucerne	Servette	2023-09-24 15:30:00	\N	15
1315	Young Boys	Lugano	2023-09-24 15:30:00	\N	15
1321	Sporting Kansas City	Houston Dynamo	2023-09-24 01:30:00	\N	76
1322	Minnesota United	St. Louis City SC	2023-09-24 01:30:00	\N	76
1323	Real Salt Lake	Vancouver Whitecaps	2023-09-24 02:30:00	\N	76
1324	Portland Timbers	Colorado Rapids	2023-09-24 03:30:00	\N	76
1325	Orlando City SC	Inter Miami CF	2023-09-25 00:30:00	\N	76
1326	Austin FC	LA Galaxy	2023-09-25 02:30:00	\N	76
\.


--
-- TOC entry 3039 (class 0 OID 17026)
-- Dependencies: 210
-- Data for Name: over2p5orbitxch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5orbitxch (id, home, away, date_time, url, plaied) FROM stdin;
5871	Roda JC	Den Bosch	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504975	t
6122	Mito	Oita	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343026	f
6123	Grulla Morioka	Tegevajaro Miyazaki	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522654	f
6124	Blaublitz Akita	Yamagata	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342936	f
6125	Albirex Niigata	Yokohama FC	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159486	f
6126	Daejeon Citizen	Suwon Bluewings	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365147	f
6127	FC Tiamo Hirakata	Suzuka Unlimited	2023-09-23 06:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218529597	f
6128	Honda Lock	Honda FC	2023-09-23 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528785	f
6129	FC Tokyo	Tosu	2023-09-23 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159846	f
6130	Nara Club	FC Ryukyu	2023-09-23 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522294	f
6131	Yangpyeong FC	Paju Citizen	2023-09-23 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550083	f
6132	Nagoya	Sapporo	2023-09-23 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159396	f
6133	Gimcheon Sangmu	FC Anyang	2023-09-23 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218540126	f
6134	Jeju Utd	FC Seoul	2023-09-23 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218372615	f
6135	NK Dugopolje U19	HNK Cibalia Vinkovci U19	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650362	f
6136	Rudes U19	Dinamo Zagreb U19	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650182	f
6137	Hajduk Split U19	Lokomotiva Zagreb U19	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649244	f
6138	Kalteng Putra FC	Persewar Waropen	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648519	f
6139	Veertien Kuwana	Tokyo Musashino City	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529417	f
6140	ACS Viitorul Tg Jiu	FC Hunedoara	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526113	f
6141	CS Mioveni	Progresul 1944 Spartac	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526022	f
6142	CSM Scolar Resita	Concordia Chiajna	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526292	f
6143	CS Tunari	Csikszereda	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515020	f
6144	FCM Alexandria	Argeș Pitești	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218525932	f
6145	PS TIRA	Persik Kediri	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218623644	f
6146	Chindia Targoviste	Acs Dumbravita	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526603	f
6147	FC Metaloglobus Bucuresti	Ceahlaul	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526421	f
6148	Persebaya Surabaya	Arema Cronus	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218623734	f
6149	Nagasaki	FC Machida	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343116	f
6150	MFK Chrudim	Zizkov	2023-09-23 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218370114	f
6151	Prostejov	Varnsdorf	2023-09-23 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218368567	f
6152	Angkor Tiger FC	Prey Veng	2023-09-23 09:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218649926	f
6153	HNK Sibenik U19	Mladost Zdralovi U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649154	f
6154	NK Kustošija U19	NK Varazdin U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650272	f
6155	Jef Utd Chiba	Sendai	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343206	f
6156	Iwaki SC	Kanazawa	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365057	f
6157	Ehime	Kagoshima Utd	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522564	f
6158	Nagano Parceiro	Toyama	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521619	f
6159	FC St. Pauli U19	SG Dynamo Dresden U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625991	f
6160	SC Paderborn 07 U19	Leverkusen U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626081	f
6161	FK Kyzyl-Zhar	FK Aktobe	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626807	f
6162	Fortuna Dusseldorf U19	Alemannia Aachen U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631545	f
6163	Dalian Yifang	Shandong Taishan	2023-09-23 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218415789	f
6164	Jeonnam Dragons	Cheonan City	2023-09-23 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218540306	f
6165	Gimhae City	Gyeongju KHNP	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550621	f
6166	Kashiwa	Fukuoka	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159306	f
6167	Wolfsburg U19	Hannover 96 (U19)	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625901	f
6168	Ulsan Citizen FC	Busan Transportation Corp	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550533	f
6169	Nottingham Forest U21	Crystal Palace U21	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218642625	f
6170	Kobe	C-Osaka	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159216	f
6171	FC Imabari	Vanraure Hachinohe	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522474	f
2945	SonderjyskE	AaB	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961564	f
6172	Kyoto	Hiroshima	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159576	f
6173	Lee Man Warriors	HK U23	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218638891	f
6174	Renofa Yamaguchi	Thespakusatsu Gunma	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343296	f
6175	Fabril Barreiro	Maritimo	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631455	f
6181	Chainat Hornbill	Ayutthaya United	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627559	f
6217	PIF	HJS Akatemia	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627952	f
6224	Fortuna Koln	FC Gutersloh	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565275	f
6176	Chanthaburi FC	Phrae United	2023-09-23 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218626897	f
6177	Radomiak Radom	Puszcza Niepolomice	2023-09-23 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218303027	f
6178	Boeung Ket	National Defense Ministry	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629477	f
2994	Jong PSV Eindhoven	De Graafschap	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218084970	f
6183	Hamburg II	Eimsbutteler	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218561023	f
6190	BK Olympic	Angelholms	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391452	f
6179	Kaiserslautern U19	Karlsruher SC U19	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628098	f
6189	Man Utd U21	Arsenal U21	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643498	f
6180	Muangthong Utd	Nakhon Pathom	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218571754	f
6187	FK Maqtaaral Jetisay	FK Aksu Pavlodar	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630517	f
6192	Torns	Tvaakers	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218403239	f
6193	Braunschweig	Nurnberg	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218014975	t
6195	Samut Prakan	Nakhon Ratchasima	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627469	f
6186	Carl Zeiss Jena	Viktoria Berlin	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560483	f
6182	Vard Haugesund	Orn Horten	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218644325	f
6184	CF Panaderia Pulido	CD Union Sur Yaiza	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658709	f
6191	Orebro Syrianska	IFK Stocksund	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406904	f
6185	NK Bravo	Olimpija	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375143	f
6196	FC Inter	KuPS	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218225557	f
6198	FC Eilenburg	Rot-Weiss Erfurt	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560573	f
6207	FC Voluntari	CSMS Iasi	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218257264	f
6208	Samtredia	Gagra	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218629025	f
6204	Livingston	Celtic	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217937447	f
6203	Krabi FC	Nakhon Si United F.C.	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218627379	f
6205	FC Shukura Kobuleti	Torpedo Kutaisi	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218628935	f
6201	Paide Linnameeskond	Parnu JK Vaprus	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218429185	f
6202	Trans Narva	Harju JK Laagri	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218429095	f
6206	Woking	York City	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218412577	f
6211	Meizhou Hakka	Henan Songshan Longmen	2023-09-23 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218374127	f
6210	Wuhan Three Towns	Tianjin Jinmen Tiger FC	2023-09-23 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218415987	f
6209	Chengdu Rongcheng	Shanghai Port FC	2023-09-23 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218408315	f
6212	Kohtla-Jarve	Tabasalu JK	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608575	f
6213	Esan Pattaya	SGBK FC	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648062	f
6222	Brescia	Venezia	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218132174	f
6220	Modena	Lecco	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218131958	f
6215	US Cremonese	Ascoli	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218132282	f
6227	FC Dziugas	FK Banga Gargzdu	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218525661	f
6225	FC Jazz	Atlantis	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627862	f
6214	Andorra CF	Sporting Gijon	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218278200	f
6219	Preussen Munster	Lubeck	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374509	f
6223	SV Werder Bremen U19	FC Hansa Rostock U19	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628188	f
6218	Ternana	Sudtirol	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218132390	f
6216	Schalke 04 II	FC Wegberg-Beeck	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564989	f
6226	SV Stuttgarter Kickers	Hoffenheim II	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564399	f
6221	Bidco United	FC Talanta	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649521	f
6188	AC Horsens	Vendsyssel FF	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218460738	t
6286	FC Floresti	Dacia Buiucani	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647883	f
6238	TuS Koblenz	FSV Frankfurt	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564489	f
6245	FC Duren	Velbert	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565375	f
6228	Viktoria Koln	Duisburg	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374417	f
6244	Dukla Prague	H Slavia Kromeriz	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374691	f
6233	Jahn Regensburg	SV Sandhausen	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374599	f
6237	Verl	Dortmund II	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374327	f
6243	Sotra SK	Strommen	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218644415	f
6239	Odisha	Chennaiyin FC	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375053	f
6236	Arda	Hebar	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032585	f
6231	Tusker FC	Muhoroni Youth FC	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650903	f
6242	Adiyamanspor	Ankaraspor	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660100	f
6232	FC Bocholt	SV Lippstadt	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564899	f
6229	Feralpisalo	Pisa	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387627	f
6241	Girona	Mallorca	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217927862	f
6234	Saarbrucken	Waldhof Mannheim	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374781	f
6230	Shabana	FC Kariobangi Sharks	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650813	f
6248	Lokomotiv Leipzig	BFC Dynamo	2023-09-23 13:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218560286	f
6249	Olympiacos B	Ilioupoli	2023-09-23 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218575863	f
6250	FC Tallinn	Flora Tallinn II	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218608665	f
6251	Ankara Demirspor	Halide Edip Adivarspor	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218659933	f
6258	FIRST VIENNA FC 1894	FC Dornbirn	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218341685	f
6255	Amasyaspor 1968 FK	ANADOLU UNIVERSITY	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218647172	f
6254	Grazer AK	FC Liefering	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218341775	f
6253	Serik Belediyespor	Karacabey Belediyespor AS	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218660460	f
6256	Puskas Akademia	Paks	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218181036	f
6252	Karaman Belediyespor	68 Aksaray Belediyespor	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218659566	f
6257	Etimesgut Belediyespor	Denizlispor	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218659750	f
6273	EPS	Ilves Kissat	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628559	f
6263	Slovan Liberec	Teplice	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217989131	f
6272	Ranheim IL	Fredrikstad	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198299	t
6265	NK Sesvete	Sibenik	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218570148	f
6289	Jaro	SalPA	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218435429	f
6271	Makedonikos	Iraklis	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628845	f
6274	Bul FC	Kampala City Council	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650452	f
6262	Slovacko	MFK Karvina	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988590	f
6269	Nkwazi	Kansanshi	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628286	f
6277	Zaglebie Lubin II	Skra Czestochowa	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599967	f
6275	PK-35 RY	TiPS	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628469	f
6280	Mikkeli	EIF	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218435609	f
6278	Johor Darul Takzim	Negeri Sembilan	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647975	f
6267	Kusadasispor	Silivrispor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218646947	f
6281	Vasteras SK	Sundsvall	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315048	f
6264	Mamelodi Sundowns	Kaizer Chiefs	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218670352	f
6284	ESTAC Troyes	Auxerre	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158068	f
6261	Ceske Budejovice	Mlada Boleslav	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217989401	f
6268	Bursaspor	Altinordu	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660280	f
6288	Kairat Almaty	Shakhter Karagandy	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629657	f
6279	JJK	JaPS	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387012	f
6260	Banik Ostrava	Zlin	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217989311	f
6270	Kieler SV Holstein II	Bremer SV	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218561113	f
6276	Thisted	Nykobing FC	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628376	f
6266	Arnavutkoy Belediyesi GVS	Sariyer G.K.	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658838	f
6285	JIPPO	NJS	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628649	f
6296	Levanger	Stjordals-Blink	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643787	f
3160	Kagoshima Utd	Kamatamare Sanuki	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138165	f
6316	Dortmund	Wolfsburg	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217880140	t
6300	Keciorengucu	Giresunspor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520354	f
6310	SK Super Nova	BFC Daugavpils	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528333	f
6292	KPV	KaPa	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218435519	f
6293	Catalcaspor	Bursa Yildirim Spor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218646767	f
6295	Turgutluspor	Elazigspor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647037	f
6303	Arendal	Fram Larvik	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218644235	f
6308	Degerfors	Malmo FF	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218160367	t
6299	Inegolspor	76 Igdir Belediyespor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659406	f
6290	Resovia Rzeszow	Polonia Warszawa	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218401360	f
6301	AC Milan	Verona	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217966124	f
6298	Belediye Derincespor	Usakspor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659019	f
6309	Wakiso Giants	Bright Stars	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649064	f
6307	Lamphun Warrior	Chiangrai Utd	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218571664	f
6302	Kallithea	Panachaiki	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628755	f
6297	RoPS	VIFK	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627772	f
6317	Bayern Munich	Bochum	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217880260	t
6312	NK Rogaska	Mura	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218385603	f
6304	Slask Wroclaw	Piast Gliwice	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303387	f
6313	Ahali Tamra	Bnei Hagolan VeHaGalil	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218652162	f
6319	Mgladbach	RB Leipzig	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217880020	t
6322	Barry Town Utd	Bala Town	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218535667	f
6315	MFk Dolny Kubin	FC Petrzalka	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218608362	f
6314	KFC Komarno	Spartak Myjava	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218608452	f
6318	Colwyn Bay	Newtown	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218535217	f
6323	NK Zagora	Kamen Ivanbegovina	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218654325	f
6320	Augsburg	Mainz	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217881536	t
6321	Union Berlin	Hoffenheim	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217881296	t
6328	Plymouth	Norwich	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381894	t
6342	Crystal Palace	Fulham	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217901976	t
6335	Dunfermline	Morton	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367253	f
6336	Swansea	Sheff Wed	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381678	f
6333	Edinburgh City	Cove Rangers	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378981	f
6331	Dartford	Tonbridge Angels	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337414	f
6341	Eastleigh	Kidderminster	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218411767	f
6340	Peterborough Sports FC	South Shields	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489708	f
6343	FC Inter Manacor	CD Binissalem FC	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658875	f
6339	Tuzla City	Borac Banja Luka	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664422	f
6345	Oxford Utd	Exeter	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380002	f
6348	Rizespor	Sivasspor	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190990	f
6334	Montrose	Stirling	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378567	f
6332	Harrogate Town	Salford City	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219678	f
6347	Pendikspor	Fatih Karagumruk Istanbul	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497615	f
6325	Partick	Arbroath	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367163	f
6338	Sandviks IK	Team TG FF	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218536588	f
6326	Ariana FC	Falkenbergs	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218394928	f
6346	Portsmouth	Lincoln	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378839	f
6327	Burton Albion	Fleetwood Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381043	f
6330	Chelmsford	St Albans	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218491228	f
6344	Doncaster	Gillingham	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209362	f
6324	Man City	Nottm Forest	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217902259	f
6294	Express	Mbarara City FC	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648973	f
6377	FK Sumqayit	PFK Turan Tovuz	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664152	f
6359	Leicester	Bristol City	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381786	t
6367	Ipswich	Blackburn	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383268	t
3222	Aegir	Leiknir R	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315663	f
6364	FK Kaisar	FK Kaspyi Aktau	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630337	f
6350	Cambridge Utd	Port Vale	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218379228	f
6390	Loughgall	Linfield	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429455	f
6397	Sestao River	Leonesa	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539315	f
6407	Altrincham	Ebbsfleet Utd	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413357	f
6383	Boston Utd	Chester	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489888	f
6357	Tranmere	Accrington	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218208822	f
6372	Southport	Tamworth FC	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489618	f
6395	Boreham Wood	Aldershot	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412667	f
6354	Farnborough FC	Slough Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336964	f
6366	Granada B	Intercity Sant Joan C.F	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539495	f
6405	Solihull Moors	Bromley	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412967	f
6363	Luton	Wolves	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217902117	t
6379	IF Karlstad	Sollentuna FF	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218646276	f
6352	Carlisle	Derby	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380509	f
6385	Atletico Madrid II	Ibiza Eivissa	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539675	f
6374	Newport County	Bradford	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218208912	f
6402	Inverness CT	Dundee Utd	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367343	f
6356	Maidstone Utd	Worthing	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337234	f
6361	Barnet	FC Halifax Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412877	f
6375	Taunton Town	Havant and W	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337324	f
6404	Stockport	Wrexham	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209182	f
6392	Brackley Town	Curzon Ashton	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218490068	f
6388	Blyth Spartans	Alfreton Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489528	f
6400	Gateshead	Maidenhead	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218411977	f
6398	Grimsby	Crawley Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209272	f
6389	Clyde	Elgin City FC	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380107	f
6355	Leyton Orient	Shrewsbury	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381362	f
6376	Truro City	Weston-super-Mare	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218490338	f
6380	Dag and Red	Hartlepool	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413177	f
6391	Hibernian	St Johnstone	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217937559	f
6401	Airdrieonians	Raith	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367073	f
6384	Chesterfield	Wealdstone	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412067	f
6387	Ballymena	Cliftonville	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429635	f
6403	Charlton	Wycombe	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381139	f
6362	Sutton Utd	MK Dons	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229720	f
6399	Panevezys	FK Suduva	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527654	f
6371	Crewe	Colchester	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209092	f
6360	Middlesbrough	Southampton	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218382698	t
6382	Southend	AFC Fylde	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412367	f
6369	Leeds	Watford	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383633	f
6368	Buxton	Spennymoor Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489438	f
6381	Oldham	Oxford City	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413267	f
6365	Bonnyrigg	Stenhousemuir	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218379784	f
6358	Farsley Celtic	Banbury Utd	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489348	f
6393	St Mirren	Hearts	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217937667	f
6406	Walsall	AFC Wimbledon	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209632	f
6353	Morecambe	Swindon	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209452	f
6373	Warrington Town	Kings Lynn	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489978	f
6386	Charleroi	Kortrijk	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218223600	t
6349	Cibalia Vinkovci	Zrinski Jurjevac	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218570056	f
6370	Hereford FC	Bishops Stortford	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218490248	f
6396	Seraing Utd	Anderlecht B	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612222	f
6418	Chorley	Scunthorpe	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489798	f
6414	Spartans	East Fife	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380365	f
6417	Hemel Hempstead	Torquay	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336874	f
6415	Hampton and Richmond	Yeovil	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336784	f
6411	Dorking Wanderers	Rochdale	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412277	f
6409	Aveley	Braintree	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337504	f
6408	CD Diocesanos	SD Atletico Tordesillas	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660136	f
6416	Annan	Alloa	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378657	f
6413	Dumbarton	Peterhead	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380623	f
6419	Blackpool	Reading	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380249	f
6410	Bath City	Dover	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337054	f
6412	Eastbourne	Welling Utd	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218491138	f
6420	Darlington	Gloucester	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218490158	f
6437	Eskilsminne	Oskarshamns AIK	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218403469	f
2910	Lahti	KTP	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218075271	f
6421	Bolton	Peterborough	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218379633	f
6433	Ponferradina II	CF Palencia	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659920	f
6430	Crusaders	Glenavon	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429545	f
6436	Aatvidabergs FF	FC Trollhattan	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218403329	f
6429	Notts Co	Forest Green	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209542	f
6434	West Brom	Millwall	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383741	f
6432	Patacona CF	Elche II	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660550	f
6428	Cheltenham	Stevenage	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380910	f
6422	Dundee	Kilmarnock	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217937883	f
6435	IBV	Fram	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497525	f
6424	Queen of South	Hamilton	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378747	f
6337	Hammarby TFF	Motala	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218395018	f
6439	Spezia	Reggiana	2023-09-23 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218132066	f
6431	Northampton	Barnsley	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381229	f
6425	RC Villalbes	Marino Luanco	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592899	f
6441	Levante	Eldense	2023-09-23 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218278290	f
6442	Vuteks Sloga	Oriolik	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218654235	f
6440	Osasuna	Sevilla	2023-09-23 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217927742	f
6446	OFI	Atromitos	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993398	f
6453	Moreirense	Farense	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218432338	t
6448	EGS Gafsa	AS Solimane	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218648793	f
6451	Rapitenca	CF Peralada	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218660730	f
6461	Red Bull Salzburg	FC Blau Weiss Linz	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944803	t
6452	Estoril Praia	Vizela	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218432771	f
6450	Hallescher FC	1860 Munich	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385333	f
6447	FC Sellier & Bellot Vlasim	SFC Opava	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218387192	f
6443	Ben Guerdane	Olympique De Beja	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218648883	f
6454	NK Lukavec	NK Bistra	2023-09-23 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218654145	f
6445	Lokomotiv Plovdiv	Slavia Sofia	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218031937	f
6444	Lions Gibraltar	St. Joseph's FC	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218647735	f
6455	CD Laguna	Villaralbo	2023-09-23 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218659739	f
6467	Tampereen Ilves II	Honka Akatemia	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631113	f
6460	CD Santa Ursula	CD Herbania	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658559	f
6471	Hapoel Petach Tikva	Hapoel Beer Sheva	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218524383	f
6466	Diosgyori	DEBRECENI VSC	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218180766	f
6464	Urduliz FT	Lagun Onak	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660889	f
6463	Austria Klagenfurt	SC AUSTRIA LUSTENAU	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944695	t
6472	Talleres (RE)	CA Ituzaingo	2023-09-23 16:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218630697	f
6468	Belouizdad	NC Magra	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626351	f
6456	NK Istra	HNK Gorica	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218385423	f
6462	WSG Wattens	Wolfsberger AC	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945019	t
6457	Brighton U21	Newcastle U21	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218642716	f
6477	Brommapojkarna	Norrkoping	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218159036	t
6469	Juventud Torremolinos	UD Torre del Mar	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659287	f
6470	FC Zbrojovka Brno	Vyskov	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387282	f
6465	Nantes	Lorient	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965381	t
6458	FC Jove Espanol	Ontinyent CF	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660370	f
6475	Kuopion Elo	GBK	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218631023	f
6479	Deportes Recoleta	CSD Barnechea	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218647554	f
6478	Palestino	Union Espanola	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218010672	f
6473	LKP Motor Lublin	Wisla Krakow	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218401137	f
6449	FC Volendam	Heracles	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217939180	t
6474	NK Celje	NK Radomlje	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218391664	f
6476	CD Ebro	CD Binefar	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218657963	f
6423	Bristol Rovers	Wigan	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380777	f
6484	Botosani	UTA Arad	2023-09-23 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218257716	f
2968	ETSV Hamburg	Dassendorf	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218290536	f
6483	Cadiz B	Manchego Ciudad Real	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636457	f
6480	Casalarreina CF	CD Berceo	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218658053	f
6522	Merida AD	Real Madrid Castilla	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552176	f
6501	Bucaspor	Nazilli Belediyespor	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660640	f
6514	Lausanne	FC Zurich	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217958811	t
6499	Huracanes Izcalli FC	Atlético Pachuca	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661182	f
6510	Corum Belediyespor	Sakaryaspor	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520264	f
6489	CSF Balti	CS Petrocub	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631845	f
6512	Espanyol B	UD Alzira	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218632175	f
6520	Sassuolo	Juventus	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965501	t
6488	Al Hala	Busaiteen Club	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643679	f
6521	UP Langreo	Real Oviedo II	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592626	f
6516	UD Ourense	CD Covadonga	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592808	f
6492	Paola Hibernians FC	Santa Lucia FC	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218530071	f
6515	Guijuelo	Coruxo	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592446	f
6502	Fethiyespor	Somaspor Spor Kulubu	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659199	f
6500	Muleno	CD Cieza	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658159	f
6511	FC Baden	Stade Nyonnais	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218142749	f
6503	CD Trofense	Pevidem SC	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218632025	f
6505	Floriana	Birkirkara	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529236	f
6528	Barcelona	Celta Vigo	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217927983	t
6508	Palencia Cristo Atletico	Atletico Astorga CF	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659379	f
6491	Manisa FK	Goztepe	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436228	f
6494	Stomil Olsztyn	Sandecja Nowy Sacz	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218600057	f
6507	Aalesunds	Stabaek	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064575	t
6495	FK Jedinstvo Bijelo Polje	FK Mladost Donja Goric	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631935	f
6518	SCD Durango	CD Vitoria	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661001	f
6513	F91 Dudelange	Fc Differdange 03	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631755	f
6498	CD Bezana	SD Torina	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661091	f
6490	Sociedad B	Lugo	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539585	f
6519	V de Santa Brigida	UD Gran Tarajal	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658366	f
6487	DUKLA BANSKA BYSTRICA	Zlate Moravce	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218144342	f
6504	Ispartaspor	Duzcespor	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658658	f
6517	Zemplin	Podbrezova	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218142569	f
6497	Al Riffa	Al Najma (BRN)	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643589	f
6485	Viven Bornova FK	Osmaniyespor 2011	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218646857	f
6486	Bohemians 1905	Sigma Olomouc	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988950	f
6524	Caernarfon Town	Pontypridd Town	2023-09-23 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218535487	f
6506	CE Andratx	CE Europa	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635917	f
6523	Yellow-Red Mechelen	Oud-Heverlee Leuven	2023-09-23 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218224614	f
6529	Arenas Club de Getxo	Tudelano	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218632670	f
6533	Entella	Arezzo	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218620564	f
6526	Kelty Hearts	Falkirk	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385693	f
6536	Progres Niedercorn	Una Strassen	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218632760	f
6531	Brentford	Everton	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217895405	f
6537	Gosk Gabela	FK Igman Konjic	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218643922	f
6534	Burgos	Elche	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218278965	f
6535	AD San Juan	Naxara CD	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218632994	f
6525	Zira	Neftchi Baku	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218648338	f
6527	Pontedera	Recanatese	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218620744	f
6532	Spal	Lucchese	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218620654	f
6530	Werder Bremen	FC Koln	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217881416	t
6496	Winterthur	Stade Lausanne-Ouchy	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217959351	t
6482	CD Mirandes II	SD Almazan	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218659559	f
6540	FC Ashdod	Maccabi Petach Tikva	2023-09-23 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218519245	f
6582	KV Oostende	Racing Genk B	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612312	t
6541	Hapoel Jerusalem	Maccabi Netanya	2023-09-23 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218436760	f
6559	Dunkerque	Rodez	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157420	f
6545	Casa Pia	Guimaraes	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218439307	f
6548	Basaksehir	Galatasaray	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218192392	f
6551	Amiens	Valenciennes	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157744	f
6560	Pau	Annecy	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218385783	f
6552	Angers	Bastia	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157636	f
6546	Laval	Guingamp	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157852	f
6562	Vojvodina	FK Javor Ivanjica	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575757	f
6558	Concarneau	St Etienne	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157528	f
6554	Panserraikos	Lamia	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217993200	f
6556	York9	Cavalry	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218469923	f
6547	Grenoble	Quevilly Rouen	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218385873	f
6557	Maccabi Bnei Raina	Beitar Jerusalem	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218493130	f
6544	AC Ajaccio	Paris FC	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157960	f
6553	FK Buducnost Podgorica	OFK Petrovac	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218651966	f
6563	Hajduk Split	Lokomotiva	2023-09-23 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218387372	f
6555	Leones Negros Udg	Correcaminos (Premier)	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218638350	f
6543	Antalyaspor	Samsunspor	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218192700	f
6561	Mladost Lucani	Fk Novi Pazar	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575667	f
6550	PFC Levski Sofia	Etar	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032027	f
6564	Ma'an	Al Salt	2023-09-23 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218638710	f
6565	Ujpest	MTK Budapest	2023-09-23 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218181653	f
6567	Swift Hesperange	Union Luxembourg	2023-09-23 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218638801	f
6566	Manchester 62 FC	Glacis Utd	2023-09-23 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218647644	f
6568	Hapoel Kfar Kasem Shua	Hapoel Mahane Yehuda	2023-09-23 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218652268	f
6586	Balzan FC	Gzira United FC	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529778	f
6588	Desp Brasil P LTDA U20	Sao Paulo U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637359	f
6579	Club San Juan de Aragon	Racing FC Porto Palmeira	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661722	f
6585	Deportivo	Cornella	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539225	f
6578	Sint Truidense (Res)	Francs Borains U21	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595078	f
6573	Gremio Novorizontino U20	Botafogo SP U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637089	f
6570	Recreativo Huelva	CD Castellon	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539405	f
6589	Ibrachina FC U20	Mirassol U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637449	f
6575	Oeste U20	Inter Limeira U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637179	f
6584	US Biskra	US Souf	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647373	f
6581	Bregenz	SV Ried	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218341865	f
6569	Univ Catolica (Ecu)	Gualaceo SC	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218416020	f
6591	Agropecuario	Flandria	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218485307	f
6580	Lech Poznan	Stal Mielec	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218302755	f
6583	MC Oran	JS Saoura	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626171	f
6576	Club Brugge B	SL 16 FC	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437593	f
6592	IRT Tanger	Yous Berrechid	2023-09-23 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218649336	f
6590	Almere City	PSV	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217939289	t
6577	ES Setif	MC El Bayadh	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626261	f
6571	Chrobry Glogow	Arka Gdynia	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400643	f
6572	La Serena	Deportes Iquique	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647463	f
6574	Curico Unido	Nublense	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218005614	f
6593	Naxxar Lions	Hamrun Spartans FC	2023-09-23 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218529146	f
6594	CSD San Antonio Unido	CDSC Iberia	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218656367	f
6596	Acassuso	Deportivo Merlo	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218637900	f
6595	Argentino de Merlo	Deportivo Armenio	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218637810	f
6542	NEC Nijmegen	FC Utrecht	2023-09-23 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217938002	t
6538	Hapoel Eran Hadera	Hapoel Haifa	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218493040	f
6601	Universitatea Cluj	Universitatea Craiova	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218257444	f
6602	San Telmo	Gimnasia Mendoza	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218484994	f
6600	Central Cordoba	Victoriano Arenas	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218637990	f
6605	CA Temperley	Patronato	2023-09-23 19:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218484891	f
6598	Agudat Sport Ashdod	Ironi Modiin	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218589700	f
6603	St Pauli	Schalke 04	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218014759	t
6604	Real Pilar FC	CA Atlas	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218668708	f
6607	Ancona	Juventus B	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218620834	f
3087	Tecos FC	Colima FC	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3088	San Martin de San Juan	Agropecuario	2023-09-16 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3089	SE Palmeiras	Goias	2023-09-16 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
6608	Antwerp	Molenbeek	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218295827	t
6610	Rimini	Perugia	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218620924	f
6609	FK Velez Mostar	Sloga Doboj	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218639971	f
6615	Heerenveen	Excelsior	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217939397	t
6611	Deportes Rengo Unido	Fernandez Vial	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218669818	f
6612	Deportes Limache	Deportes Valdivia	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218656655	f
6624	Chacarita	Quilmes	2023-09-23 20:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218492770	f
6618	Gimnasia La Plata	Rosario Central	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465043	f
6613	EC Sao Jose Porto Alegre	Sao Bernardo	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218578995	f
6620	Racing Santander	Albacete	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279055	f
6614	Rayo Zuliano	Angostura FC	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218624153	f
6619	Alcorcon	Huesca	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218278380	f
6621	Burnley	Man Utd	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217895546	t
6617	Uruguay de Coronado	Limon Black Star	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218640061	f
6623	Botafogo PB	Paysandu	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218578905	f
6616	Brest	Lyon	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965261	t
6622	Almeria	Valencia	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217928224	t
6625	Provincial Osorno	Deportes Melipilla	2023-09-23 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218656277	f
6626	FUS Rabat	USM Alger	2023-09-23 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218648610	f
6627	Porto	Gil Vicente	2023-09-23 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218432446	f
6629	Chapecoense	Ceara SC Fortaleza	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391845	f
6632	Binacional	AD Cantolao	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626595	f
6633	Emelec	Mushuc Runa	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218397024	f
6631	Sportivo Italiano	FC Midland	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218642225	f
6630	CRB	Guarani	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218345950	f
6628	Vancouver FC	HFX Wanderers	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218571884	f
6635	Chaco For Ever	Estudiantes de Caseros	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218492680	f
6634	Colo Colo	Cobresal	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218018834	f
6637	Tigres FC Zipaquira	Atletico FC Cali	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218582872	f
6643	CD Trasandino	Real San Joaquin	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218656548	f
6636	SCCM Chabab Mohamedia	Moghreb Tetouan	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218649427	f
6642	AD Guanacasteca	CS Cartagines	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218604891	f
6645	Municipal Santa Ana	AD Aserri	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218644145	f
6639	San Martin de Tucuman	CA Guemes	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218484788	f
6640	Boyaca Chico	Rionegro	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218613629	f
6644	Santa Tecla	Once Municipal	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625811	f
6646	Boca Juniors	Lanus	2023-09-23 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218465151	f
6641	Tombense MG	Botafogo SP	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218222768	f
6647	Tacuary	Olimpia	2023-09-23 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218643197	f
6648	Universidad de Venezuela	Puerto Cabello	2023-09-23 22:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218624243	f
6650	Yalmakan FC	Aguacateros de Peribán F.C	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661542	f
6649	UNIVERSIDAD O&M	Cibao FC	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650633	f
6597	Grasshoppers Zurich	St Gallen	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959243	t
6651	Nacional (Par)	Libertad	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643106	f
6606	Lazio	AC Monza	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217965881	t
6656	Operario PR	Brusque FC	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218579085	f
6655	Club CDM	Caja Oblatos C.FD	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661362	f
6660	Llaneros FC	Real Santander	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218582782	f
6657	Volta Redonda	Amazonas FC	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218579185	f
6663	Halcones de Zapopan	Inter de Queretaro FC	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661812	f
6659	Atlantico FC	Vega Real	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650542	f
3419	NK Aluminij	NK Rogaska	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001568	f
6654	Santamarina	Club Cipolletti	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648156	f
6658	Chile (W)	New Zealand (W)	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218566722	f
6664	Tuzos de la UAZ	Colima FC	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218653025	f
6666	Club Sporting Canamy	Deportiva Venados	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649654	f
6667	Real Cartagena	Quindio	2023-09-24 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218583005	f
6662	Everton De Vina	Huachipato	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218022702	f
6665	CA Liniers	Sol De Mayo	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649744	f
6661	Tecnico Universitario	Independiente (Ecu)	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218416110	f
6668	San Francisco FC	Arabe Unido	2023-09-24 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218579909	f
6669	San Antonio FC	Orange County Blues	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218621027	f
6673	CS Herediano	AD Municipal Liberia	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218604982	f
6686	Chicago Fire	New England	2023-09-24 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424142	t
6675	New York City	Toronto FC	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218422786	t
6674	FC Cincinnati	Charlotte FC	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218422894	t
6671	DC Utd	New York Red Bulls	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423388	t
6676	Sport Recife	Londrina	2023-09-24 00:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218223146	f
6672	Philadelphia	Los Angeles FC	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423182	t
6677	Mexicali FC	Chihuahua FC	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661272	f
6680	Central Cordoba (SdE)	Defensa y Justicia	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465259	f
6682	Atletico MG	Cuiaba	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218081092	f
6678	Alianza FC (SLV)	AD Isidro Metapan	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625541	f
6679	Lobos ULMX	Cafetaleros de Chiapas II	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218651876	f
6683	Portuguesa FC	Mineros Guayana	2023-09-24 01:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218624335	f
6681	Huracan	Velez Sarsfield	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218464933	f
6684	Minnesota Utd	St Louis City SC	2023-09-24 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423628	f
6685	Kansas City	Houston Dynamo	2023-09-24 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423788	f
6690	Reboceros de La Piedad	Montaneses FC	2023-09-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661992	f
6687	FC Dallas	Columbus	2023-09-24 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423936	t
6689	Leon	Tijuana	2023-09-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217987684	f
6691	Guadalajara	Pachuca	2023-09-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988046	f
6692	America de Cali S.A	Atletico Nacional Medellin	2023-09-24 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218620248	f
6688	Cd Fas	CD Aguila	2023-09-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625631	f
6694	Real Salt Lake	Vancouver Whitecaps	2023-09-24 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424250	f
6693	UMECIT	Tauro FC	2023-09-24 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218580359	f
6697	LD Alajuelense	Santos de Guapiles	2023-09-24 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218604194	f
6698	Portland Timbers	Colorado	2023-09-24 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424466	f
6695	Guastatoya	Achuapa FC	2023-09-24 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625361	f
6696	Tampico Madero	Escorpiones FC	2023-09-24 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661902	f
6699	San Jose Earthquakes	Nashville SC	2023-09-24 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424358	f
6700	Los Cabos United	CF Orgullo de Reynosa	2023-09-24 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661632	f
6701	Tigres	Monterrey	2023-09-24 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217987775	f
6703	ReinMeer Aomori	MIO Biwako Shiga	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528966	f
6706	Okayama	Iwata	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343386	f
6702	Sony Sendai FC	Kochi Univ	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528875	f
6704	Shimizu	Kofu	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343476	f
6670	Atlanta Utd	CF Montreal	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423520	t
6705	Fukushima Utd	Sagamihara	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522114	f
6653	Deportivo Mixco	CSD Municipal	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625271	f
6707	Gimpo Citizen	Chungnam Asan	2023-09-24 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218540216	f
3499	HFX Wanderers	Atletico Ottawa	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218199019	f
3480	Arenteiro	Real Union	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218233630	f
6727	FS METTA/LU	FK Tukums 2000	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528604	f
6235	Kenya Police FC	AFC Leopards SC (Kenya)	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218652072	f
6750	Hessen Kassel	Bahlinger SC	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564809	f
6240	1461 Trabzon	Afjet Afyonspor	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660821	f
6761	Bhayangkara FC	Persib Bandung	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629567	f
6259	Sapanca Genclikspor	Efeler 09	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647263	f
6311	Sao Joao Ver	Leixoes	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631365	f
6394	CD Portosantense	CD Nacional Funchal	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218668938	f
6426	Mansfield	Barrow	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209002	f
6351	Stranraer	Forfar	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218379384	f
6378	Dalkurd FF	United IK Nordic	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391558	f
6329	Rotherham	Preston	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383849	f
6427	Rushall Olympic	Scarborough Athletic	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489256	f
6909	Louletano	AVS Futebol SAD	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218682091	f
6928	Weymouth	Chippenham	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337144	f
6459	Al Wehdat	Shabab Al Ordon	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631243	f
6989	CD Illescas	CD Badajoz	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635467	f
6481	Cracovia Krakow	Pogon Szczecin	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218302935	f
6493	MFK Skalica	Dunajska Streda	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218142659	f
7041	AD Union Adarve	CDE Ursaria	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635022	f
6539	CA San Miguel	CA Colegiales	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218632852	f
6549	Coria CF	Puente Genil FC	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659029	f
6587	AA Portuguesa U20	Agua Santa U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637269	f
6599	UAI Urquiza	Canuelas	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218638080	f
6638	Alianza FC (Pan)	CD Universitario	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218580269	f
6652	Aguacateros C.D.U. Uruapan	Club Deportivo Ayense	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661452	f
6282	Skeid	Kongsvinger	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198389	t
6283	Sogndal	Asane	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198479	t
6287	Gefle	GAIS	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218421058	t
6291	Skovde AIK	Ostersunds FK	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218386832	t
6305	Jonkopings Sodra	Orgryte	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218386922	t
6306	Hodd	Jerv	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198569	t
3566	Real Sociedad III	Real Zaragoza II	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252970	f
7295	Haverfordwest County	Connahs Quay	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218694609	f
6509	CAP Ciudad de Murcia	Alcantarilla FC	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658266	f
7698	Matsumoto	FC Gifu	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522204	f
7699	Azul Claro Numazu	Tottori	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522384	f
7700	FC Osaka	Kitakyushu	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521529	f
7701	Kamatamare Sanuki	Yokohama SCC	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522744	f
7703	Melbourne City	Sydney FC	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218557435	f
7704	Gwangju FC	Jeonbuk Motors	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406581	f
7705	Kashima	Yokohama FM	2023-09-24 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159756	f
7706	Kitchee SC	Hong Kong Rangers FC	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218669728	f
7707	Tokushima	Omiya	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343566	f
7708	Seoul E-Land FC	Ansan Greeners FC	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218514367	f
7709	Shonan	Kawasaki	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159936	f
7710	Tokyo-V	Fujieda MYFC	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343656	f
7711	Gangwon	Incheon Utd	2023-09-24 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218408060	f
7712	Perserang Serang	Psim Yogyakarta	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694522	f
7713	Putra Safin Group	Persikab Kabupateng Bandung	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694432	f
7714	Persipa Pati	PSCS Cilacap	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698997	f
7715	Deltras Sidoarjo	Gresik United	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698906	f
7716	Levante UD II (W)	CD Juan Grande (W)	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709293	f
7717	Kyrgyzstan U23	Chinese Taipei U23	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218613269	f
7718	Real Murcia II	UCAM Murcia CF B	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218704759	f
7719	PSS Sleman	Madura Utd	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673294	f
7720	Chuncheon	Yangju Citizen	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550173	f
7721	Melbourne Knights	Brisbane Roar	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218558219	f
7722	G-Osaka	Urawa	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159666	f
7723	Sigma Olomouc B	Lisen	2023-09-24 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218413508	f
7724	PSMS Medan	Persiraja Banda Aceh	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218699087	f
7725	FC Unirea Dej	Unirea Slobozia	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218526511	f
7726	SV Horn	SK Sturm Graz II	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218341955	f
7727	Malzenice	Pohronie	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218612812	f
7728	Sparta Prague B	Vysocina Jihlava	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218413860	f
7729	MSK Zilina II	Slovan Bratislava II	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218612722	f
7730	Albacete (W)	CF Union Viera (W)	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709383	f
7731	Dortmund U19	Mgladbach U19	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218672934	f
7732	MSV Duisburg U19	FC Schalke U19	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673024	f
7733	Okzhetpes	FK Atyrau	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673654	f
7734	FC Augsburg U19	1. FSV Mainz 05 U19	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673204	f
7735	VfL Bochum U19	Wuppertaler SV U19	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218672844	f
7736	Villarreal CF III	CD Acero	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218693838	f
7737	Rayo Vallecano B	Leganes B	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695500	f
7738	Sevilla B	FC La Union Atletico	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636367	f
7739	Real Oviedo (W)	Real Sociedad II (W)	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218709023	f
7740	AC Torrellano	Levante UD II	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218693928	f
7741	Getafe B	Gimnastica Segoviana CF	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218634833	f
7742	FC Elva	Levadia Tallinn II	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613089	f
7743	Trival Valderas Alcorcon	AD Alcorcon II	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218704957	f
7744	Bucheon FC 1995	Gyeongnam	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218540036	f
7745	Collado Villalba	Alcala RSD	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695603	f
7746	Real Zaragoza II	SD Gernika Club	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218633084	f
7747	CD Fermarguin (W)	Elche CF (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709655	f
7748	Balears FC (W)	CD Pradejon (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709203	f
7749	Zaragoza CFF (W)	CA Osasuna II (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709473	f
3192	Wolves	Liverpool	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217635221	f
3328	FSV Frankfurt	Kickers Offenbach	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274430	f
6197	Landskrona	Osters	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315138	t
6194	Wehen Wiesbaden	Elversberg	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217942692	t
6199	Greuther Furth	Karlsruhe	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015083	t
7750	FF La Solana (W)	Fundacion CD Tenerife (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709563	f
7751	Racing Santander (W)	Bizkerre (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709113	f
7752	Melilla UD	Algeciras	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552868	f
7753	Atletico Baleares	AD Ceuta FC	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552271	f
7754	Mar Menor CF	Yeclano Deportivo	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636547	f
7755	SCF Plaza Argel (W)	Real Betis II (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218710064	f
7756	Real Union	CD Teruel	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551195	f
7757	Santa Eulalia	Valencia-Mestalla	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673744	f
7758	Ayamonte	Pozoblanco	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705894	f
7759	Huetor Vega CD	Motril CF	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695705	f
7760	UCAM Murcia	FC Cartagena II	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636097	f
3481	Intercity Sant Joan C.F	San Fernando CD	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238496	f
3543	New York City	New York Red Bulls	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938227	f
3595	Orlando City	Columbus	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938747	f
3606	AD Isidro Metapan	Fuerte San Francisco	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306953	f
7761	SE Penya Independent	Cerdanyola del Valles	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635377	f
7762	Castellon B	CD Roda	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695893	f
7763	L' Hospitalet	Badalona	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705146	f
7764	Lorca Deportiva CF	CD Algar	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218706217	f
7765	Kumamoto	Tochigi SC	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343746	f
7766	Daegu FC	Pohang Steelers	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417237	f
7767	Giouchtas	Diagoras	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575953	f
7768	SS Reyes	Talavera CF	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218634927	f
7769	CD Alaves B	CD Brea	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218633282	f
7770	UE Sant Andreu	Hercules	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635737	f
7771	CD Diocesano	Moralo CP	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705245	f
7772	CD Gerena	Conil FC	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705731	f
7773	Las Rozas CF	AD Torrejon	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695803	f
7774	CE Seagull (W)	Rayo Vallecano II (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218710154	f
7775	SD Logrones	CF Rayo Majadahonda	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551285	f
7776	Deportivo La Coruna II	Arandina CF	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592266	f
7777	Velez CF	CA Antoniano	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636187	f
7778	CD Estepona	Marbella	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636277	f
7779	El Palo	Orihuela CF	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636639	f
7780	Guadalajara	UD San Fernando	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218640473	f
7781	FC Carl Zeiss Jena U19	RB Leipzig U19	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218684017	f
7782	CD Tenerife II	Club Atletico Victoria	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705551	f
7783	CD Varea	CD Alfaro	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218706019	f
7784	Cordoba CF II	CD Cabecense	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705641	f
7786	Zaglebie Lubin	Warta Poznan	2023-09-24 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218302845	f
7787	Kasetsart FC	JL Chiangmai United	2023-09-24 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218673834	f
7789	Wisla Plock	GKS Tychy	2023-09-24 11:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218399244	f
7790	Air Force Central	Ratchaburi	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569005	f
7791	Greifswalder SV 04	Hertha Berlin II	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560393	f
7792	Stoke	Hull	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383957	f
7793	CD Marino	CD Buzanada	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695983	f
7794	Valladolid B	Real Aviles	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592718	f
7795	Rayong FC	Chiang Mai	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218682321	f
7796	Utsiktens	Trelleborgs	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314778	f
7797	FC Koln U19	Arminia Bielefeld U19	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218683927	f
7798	Valmieras FK	FK Auda	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528423	f
7799	Nurnberg U19	TSG Hoffenheim U19	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679971	f
7800	Bayern Munich U19	TSV 1860 Munchen U19	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218680241	f
7788	Empoli	Inter	2023-09-24 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217966003	t
7801	Altglienicke	Cottbus	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565587	f
7802	UD Las Palmas II	UD Teror Balompie	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695375	f
7803	Naestved	Hillerod Fodbold	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218440509	f
7804	Metz	Strasbourg	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217972848	f
7805	South Korea U23	Bahrain U23	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613359	f
7806	Iran U23	Mongolia U23	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613539	f
7807	China U23	Bangladesh U23	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613449	f
7812	SSV Ulm	Rot-Weiss Essen	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218416474	f
7813	Genk	Sint Truiden	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218304560	f
7814	Meuselwitz	Hansa Rostock II	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218565699	f
7815	Qingdao Jonoon	Nantong Zhiyun F.C	2023-09-24 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218421495	f
7816	Shenzhen FC	Zhejiang Greentown	2023-09-24 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218421383	f
7817	Atyra FC	Rubio Nu	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218682001	f
7818	Coimbra EC U20	America MG U20	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218729655	f
7819	Norderstedt	SSV Jeddeloh	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560843	f
7820	TSV Havelse	FC Phonix Lubeck	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560753	f
7821	Liverpool U21	Wolves U21	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698345	f
7822	Nairobi City Stars	Nzoia United FC	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681235	f
7823	Blackburn U21	Aston Villa U21	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698435	f
7824	Khonkaen United	Prachuap	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569095	f
7825	Lampang FC	Customs United	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218682231	f
7826	Ulinzi Stars	Sofapaka	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218703126	f
7827	Aurora Pro Patria 1919	Triestina	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218605831	f
7828	Teutonia 05 Ottensen	Hannover II	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560933	f
7829	Novara	Giana Erminio	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218605921	f
7830	SV Sandhausen U19	1. FC Heidenheim U19	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218680151	f
7831	Hamburger SV U19	VfL Osnabruck U19	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218680061	f
7832	Fortuna Dusseldorf II	Alemannia Aachen	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565480	f
7833	Hegelmann Litauen	FK Siauliai	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218525481	f
7834	Tobol Kostanay	FC Zhetysu	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681145	f
7835	Alessandria	Lumezzane	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218606011	f
7836	Kakamega Homeboyz	Gor Mahia FC	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218703216	f
7838	KCB	Bandari FC (Kenya)	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218703035	f
7840	Sandvikens	Bodens	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437321	f
7841	TransINVEST Vilnius	FK Panevezys II	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681385	f
7843	Real Sociedad	Getafe	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217927262	f
7844	Zorya	Dnipro-1	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218621348	f
7845	Villarreal B	Amorebieta	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218304807	f
7846	Yverdon Sport	FC Basel	2023-09-24 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217958919	f
7848	Kirsehir Belediyespor	Mersin Idman Yurdu	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218658462	f
7849	Pitea	Taby FK	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218495219	f
7809	Fortuna Dusseldorf	Hannover	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217943016	t
7810	Kaiserslautern	Hansa Rostock	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218014651	t
7811	Holstein Kiel	Hertha Berlin	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218014867	t
7837	Brondby	FC Copenhagen	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158697	t
7839	Silkeborg	Viborg	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158589	t
7842	FC Helsingor	SonderjyskE	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218423977	t
7847	MVV Maastricht	De Graafschap	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218524617	t
3265	RB Leipzig	Augsburg	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217628028	f
3267	Mainz	Stuttgart	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217627788	f
4226	Verspah Oita	Honda FC	2023-09-17 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342447	f
4227	Sydney FC	Western United	2023-09-17 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217957756	f
4228	Toyama	FC Osaka	2023-09-17 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218144252	f
4229	FC Seoul	Gwangju FC	2023-09-17 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218392212	f
4230	FC Tiamo Hirakata	Okinawa SV	2023-09-17 06:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218395361	f
4231	Tokyo Musashino City	Kochi Univ	2023-09-17 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373773	f
4232	Gangneung City	Yangju Citizen	2023-09-17 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218243153	f
7853	Ruch Chorzow	Rakow Czestochowa	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303297	f
7854	El Seka Elhadeed	La Viena FC	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711382	f
7856	FK Jelgava	Rigas Futbola Skola	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528115	f
7857	Athlitiki Enosi Larissa	Kampaniakos	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665864	f
7858	Norrby IF	Lunds BK	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437230	f
7859	MOL Vidi	Zalaegerszeg	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218181126	f
7860	Vardar Skopje	FK Gostivar	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681565	f
7861	Znicz Pruszkow	Stal Rzeszow	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406814	f
7862	Panathinaikos B	Kalamata	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665546	f
7863	FC Voska Sport	KF Shkupi	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707236	f
7864	Kozani FC	Aiolikos Mytilene AFC	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665366	f
7865	URSL Vise	K Sint-Eloois-Winkel	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678841	f
7866	Hradec Kralove	FK Jablonec	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988770	f
7867	AIK	Djurgardens	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218302481	f
7868	Stal Stalowa Wola	Polonia Bytom	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218600147	f
7869	FC Ordabasy	FC Astana	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681055	f
7870	Plzen	Pardubice	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988410	f
7872	Anagennisi Karditsas	AEK Athens B	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218576043	f
7873	Orlando Pirates (SA)	Stellenbosch FC	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711568	f
7874	Akademija Pandev	FK Sileks	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681475	f
7875	Royal Knokke FC	Heist	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678751	f
7877	Itrottarfelag Fuglafjaroar	AB Argir	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679524	f
7878	Fremad Amager	Skive	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679111	f
7879	CSF Spartanii	FC Milsami-Ursidos	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218701009	f
7882	Bandirmaspor	Genclerbirligi	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436408	f
7885	Shkendija	FK Makedonija	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681811	f
7886	Mjallby	IFK Goteborg	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218168174	f
7888	FC Sabah	Kapaz Ganja	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664242	f
7889	SC Spelle Venhaus	FC Kilia Kiel 1902	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560663	f
7891	Le Havre	Clermont	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218000865	f
7894	Tilikratis Lefkadas	Egaleo	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665726	f
7895	Selangor FA	Terengganu	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218701102	f
7896	Shabab Sahel	Al-Ahed	2023-09-24 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218644891	f
7897	Leverkusen	FC Heidenheim	2023-09-24 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217890590	f
7898	Fjolnir	IF Vestri	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599876	f
7899	Afturelding	Leiknir R	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599786	f
7900	San Fernando CD	Real Murcia	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552687	f
7901	NK Croatia Zmijavci	Vukovar	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569185	f
7903	Cercle Brugge	Union St Gilloise	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218304452	f
7904	Umea FC	Vasalunds IF	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437503	f
7905	Lusitano	Covilha	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718379	f
7906	Ribeirao	Santa Clara	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718199	f
7907	Besiktas	Kayserispor	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218199744	f
7908	Budafoki	Tiszakecske VSE	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461278	f
7852	Ajax	Feyenoord	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940505	t
4275	Ulsan Citizen FC	Siheung Citizen	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218243513	f
7855	Raufoss	Sandnes Ulf	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198839	t
7871	Start	Moss	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198929	t
7876	Atalanta	Cagliari	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218019305	t
7880	Lens	Toulouse	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217964661	t
7881	KFUM Oslo	Mjondalen	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198749	t
7883	Brighton	Bournemouth	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217895828	t
7884	Liverpool	West Ham	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217896327	t
7887	Bryne	Kristiansund	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198659	t
7890	Udinese	Fiorentina	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965621	t
7892	Chelsea	Aston Villa	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217901835	t
7893	Arsenal	Tottenham	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217895687	t
7902	Sunderland	Cardiff	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384065	t
7909	Keflavik	HK Kopavogur	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521439	f
7910	KR Reykjavik	Valur	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521259	f
7911	MTE 1904	Kozarmisleny	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461369	f
7912	Dumiense CJP II Futebol	Santarem	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218731023	f
7913	Aberdeen	Ross Co	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217937775	f
7914	GD Peniche	Cultural Montalegre	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718649	f
7915	GD Vitoria de Sernache	SC Vianense	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718289	f
7916	Juventude	Su Sintrense	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718739	f
7917	Mortagua FC	Amora FC	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718559	f
7918	Valadares Gaia	Penafiel	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218717929	f
7919	Waasland-Beveren	FC Liege	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612999	f
7920	B68 Toftir	EB/Streymur	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679337	f
7921	IF Sylvia	FC Stockholm Internazionale	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437412	f
7922	Hafnarfjordur	Stjarnan	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218440419	f
7923	Olympiakos	Kifisias FC	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217992912	f
7924	Randers	AGF	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339652	f
7925	Sertanense	Amarante	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718109	f
7926	Vikingur Gota	07 Vestur	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679434	f
7927	Zvijezda 09 Bijeljina	Nk Posusje	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664512	f
7928	Rangers	Motherwell	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217939072	f
7929	Atletico Mitre	Brown de Adrogue	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218492500	f
7930	1 Dezembro	Pacos Ferreira	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718019	f
7931	Atletico Clube de Portugal	Alverca	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718829	f
7932	FC Barreirense	Mirandela	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718469	f
7933	CA Osasuna II	Union de Salamanca	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551807	f
7934	Recreativa de Lamelas	FC Tirsense	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718919	f
7935	Ankaragucu	Konyaspor	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218189712	f
7936	LR Vicenza Virtus	Pergolettese	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218605651	f
7937	SSD Bari	Catanzaro	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218402883	f
7938	Parma	Sampdoria	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218403063	f
7939	Oviedo	Valladolid	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218278875	f
7940	Cittadella	Como	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218402973	f
7942	Northeast United	Mumbai City FC	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218435915	f
7943	CD Galapagar	AD Parla	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218707008	f
7945	Club Sportif Sfaxien	Sportive de Tunis	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218703401	f
7946	CDA Navalcarnero	AD Llerenense	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218635287	f
7947	CD Huetor Tajar	CD Torreperogil	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218706918	f
7948	Monastir	ES Metlaoui	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218703310	f
7950	Aris	Panaitolikos	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993094	f
7951	SJK	HJK Helsinki	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218431104	f
7952	Freiburg II	Ingolstadt	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218417327	f
7953	CA Bizertin	US Tataouine	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218703491	f
7957	VMFD Zalgiris	FK Kauno Zalgiris	2023-09-24 15:55:00	https://www.orbitxch.com/customer/sport/1/market/1.218525571	f
7958	Deportes Concepcion	Linares	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679021	f
7959	Numancia	CD Atletico Paso	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635647	f
7960	Haras El Hodood	Abo Qair Semads	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711476	f
7963	Vasas	Gyirmot	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461188	f
7964	Lleida	Club Atletico Saguntino	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635557	f
7967	FC Ajka	Siofok	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461459	f
4333	St Pauli	Holstein Kiel	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217704656	f
7944	Luzern	Servette	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959135	t
7949	Young Boys	Lugano	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959027	t
7954	Chaves	Club Football Estrela	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218471150	t
7955	RKC Waalwijk	FC Twente	2023-09-24 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217940613	t
7956	PEC Zwolle	Az Alkmaar	2023-09-24 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217939674	t
7961	Bodo Glimt	Valerenga	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064683	t
7962	Odds BK	Haugesund	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064143	t
7965	Lillestrom	Rosenborg	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064251	t
7966	Stromsgodset	Molde	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218063943	t
7968	Dila Gori	Samgurali Tskaltubo	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679881	f
7969	Kazincbarcika	BVSC Zuglo	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461098	f
7971	Szeged 2011	Nyiregyhaza	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461008	f
7973	Sevilla FC III	Xerez Deportivo FC	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708015	f
7975	CD Soneja	UD Rayo Ibense	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696399	f
7976	Lyn	Floy Flekkeroy	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698815	f
7977	CD Calahorra B	SD Oyonesa	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707925	f
7978	CD Llosetense	UD Poblense	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708105	f
7979	CD Quintanar del Rey	CD Puertollano	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708467	f
7980	Slaven Belupo	Rijeka	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218432230	f
7981	Pirin Blagoevgrad	Levski Krumovgrad	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032207	f
7982	Pecs MFC	Csakvar	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218460918	f
7983	CD Toledo	UB Conquense	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707745	f
7984	CD Fuentes	CD Illueca	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707835	f
7986	ACS Petrolul 52	Hermannstadt	2023-09-24 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218257806	f
7987	Legia Warsaw	Gornik Zabrze	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218303207	f
7988	CD Cayon	Pontevedra CF	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218592536	f
7989	Ferencvaros	Kisvarda	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218180946	f
7990	CD Belchite 97	CF Calamocha	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218694703	f
7991	Slovan Bratislava	Zilina	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218201068	f
7992	CD Minera	Montecasillas FC	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695285	f
7993	CD Don Alvaro	CF Trujillo	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695195	f
7996	AD Almudevar	CD Carinena	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218694886	f
7997	CDFC La Calzada	Club Haro Deportivo	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695015	f
7999	Sabail	Araz Nakhchivan PFK	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218664332	f
8000	RCP Valverdeno	CF Jaraiz	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695105	f
8002	LKS Lodz II	Olimpia Elblag	2023-09-24 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218600238	f
8003	Linares Deportivo	Malaga	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552545	f
8004	Barakaldo	CD Calahorra	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218633372	f
8005	East Riffa	Al Ahli (BRN)	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678661	f
8006	FC Saburtalo Tbilisi	FC Telavi	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679791	f
8007	Spartak Trnava	Ruzomberok	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218201158	f
8008	Leioa	Pasaia Kirol Elkartea	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694110	f
8009	UE Vilassar de Mar	UE Castelldefels	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694020	f
8010	Sitra	Al Khalidiyah	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678571	f
8012	Zaglebie Sosnowiec	Nieciecza	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218399639	f
8013	Sliema Wanderers FC	Valletta	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529507	f
8014	Viimsi JK	Tallinna JK Legion	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218613179	f
8016	Adanaspor	Erzurum BB	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436318	f
8017	Becerril	Salamanca UDS	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696516	f
8018	CD Llanera	CD Llanes	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694200	f
8019	Pena Balsamaiso	CCD Alberite	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708557	f
8020	UD Castellonense	CD Utiel	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696620	f
8021	Raja Beni Mellal	Olympique Khouribga	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218702939	f
8022	Villanovense	UD Montijo	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636007	f
8023	Slavia Prague	Sparta Prague	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217985914	f
8024	CD Izarra	Athletic Bilbao B	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218633174	f
8025	Ponferradina	Fuenlabrada	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551897	f
7972	Ham-Kam	Sarpsborg	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218063835	t
7974	Viking	Sandefjord	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064467	t
7985	Montpellier	Rennes	2023-09-24 16:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217965021	t
4390	Birmingham (W)	Charlton (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373322	f
7994	Sheff Utd	Newcastle	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217896468	t
7995	Varbergs BoIS	Hammarby	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218160277	t
7998	Kalmar FF	Hacken	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218158946	t
8001	Eintracht Frankfurt	Freiburg	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217890840	t
8011	Bologna	Napoli	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965743	t
8015	Midtjylland	OB	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158805	t
8026	Zimbru Chisinau	Sheriff Tiraspol	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681911	f
8027	CF Platges de Calvia	CE Constancia de Inca	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708647	f
8028	Sanliurfaspor	Kocaelispor	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520534	f
8029	Linense	Aguilas	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635827	f
8030	CD Estradense	Silva SD	2023-09-24 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218694290	f
8031	Mantova	Albinoleffe	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218605346	f
8032	Padova	SS Virtus Verona 1921	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218605561	f
8033	Club Africain	Stade Tunisien	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218682638	f
8034	CF Badalona Futur	Centre d'Esports Manresa	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218635019	f
8035	FC Legnago	Renate	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218605741	f
8036	SSD Pro Sesto	Arzignanochiampo	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218605253	f
8037	USD Sestri Levante 1919	Sassari Torres	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218622024	f
8038	Mirandes	Leganes	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218278785	f
8039	RS Gimnastica	SD Rayo Cantabria	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218592356	f
8040	Betis	Cadiz	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217928103	f
8041	Las Palmas	Granada	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217927142	f
8043	CA Atlanta	Ferro Carril Oeste	2023-09-24 17:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218485397	f
8044	Saint George FC	Al Ahly Cairo	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707146	f
8046	Ionikos	PAE Chania	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218680331	f
8047	Dinamo Batumi	Dinamo Tbilisi	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679616	f
8048	Celta Vigo B	Arenteiro	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551987	f
8049	Arenas Armilla	Real Jaen	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711198	f
8050	Fylkir	KA Akureyri	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521349	f
8051	Kasimpasa	Adana Demirspor	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218203579	f
8053	Torrent CF	La Nucia	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635197	f
8054	Comunicaciones	Deportivo Coatepeque	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625451	f
8055	Municipal Turrialba	Futbol Consultants Moravia	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218684108	f
8056	General Lamadrid	Excursionistas	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218684198	f
8045	NFC Volos	Asteras Tripolis	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217993488	f
8062	Rudes	Dinamo Zagreb	2023-09-24 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218439199	f
8063	Dynamo Dresden	Erzgebirge	2023-09-24 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218416294	f
8064	PAS Giannina	PAOK	2023-09-24 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993813	f
8065	Lokomotiv Sofia	Ludogorets	2023-09-24 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218032387	f
8066	Gimnastic	Sabadell	2023-09-24 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218551451	f
8067	Zrinjski	Zeljeznicar	2023-09-24 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218586235	f
8068	Gyori	Haladas	2023-09-24 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218460828	f
8069	Atletico Sanluqueno CF	Antequera CF	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552777	f
8070	Alcoyano	Cordoba	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552432	f
8071	Santos U20	Ferroviaria DE U20	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678931	f
8072	Cruzeiro U20	Atletico MG U20	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218729565	f
8073	Club Gimnasia y Tiro	9 de Julio Rafaela	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218686121	f
8074	CA Tarazona	Barcelona B	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551541	f
8075	CA Independiente	Instituto	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218464711	f
8076	Sportivo AC Las Parejas	Club Defensores de P	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218686031	f
8077	Atletico Ottawa	Valour	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569275	f
8078	Toluca	CF America	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217987866	f
8079	Gudja United	Marsaxlokk FC	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529326	f
8080	Tristan Suarez	Gimnasia Jujuy	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218485097	f
8081	Asociacion Deportiva Tarma	Alianza Atletico	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218634721	f
8082	ACS Sepsi OSK	FCSB	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218257354	f
8083	Deportes Copiapo	Universidad de Chile	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218005524	f
8042	Anderlecht	Club Brugge	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218225307	t
8052	New York City	Toronto FC	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218422786	t
8057	Portimonense	Benfica	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218466082	t
4450	Como	Ternana	2023-09-17 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217943487	f
8059	Gent	Eupen	2023-09-24 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218225199	t
8060	Lierse	Kfco Beerschot Wilrijk	2023-09-24 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218437683	t
8061	Brann	Tromso	2023-09-24 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218064359	t
8084	NK Maribor	Koper	2023-09-24 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218429725	f
8085	Raja Casablanca	Union de Touarga	2023-09-24 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218697037	f
8086	Justo Jose de Urquiza	Deportivo Laferrere	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218687509	f
8087	CSD Liniers de Ciudad Evita	Leandro N Alem	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218687599	f
8088	Sansinena	Olimpo	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218686301	f
8089	G, Brown	San Martin Juan	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218485700	f
8090	Almagro BA	Alvarado	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218492410	f
8091	Sacachispas	Argentino de Quilmes	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218686825	f
8092	Villa Mitre	CA Germinal	2023-09-24 19:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218686211	f
8093	Avellino	Monopoli	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218656949	f
8094	Crotone	Sorrento	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218657039	f
8095	Potenza	Casertana	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218656859	f
8097	USFrancavilla Calcio	ACR Messina	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218657218	f
8098	Atalanta B	Pro Vercelli	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218656765	f
8099	Torino	Roma	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217966244	f
8100	Nueva Chicago	Deportivo Moron	2023-09-24 19:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218492230	f
8101	Sao Paulo	Flamengo	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218460705	f
8102	Gimnasia Conc del Uruguay	Sportivo Belgrano	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218687133	f
8103	Cumbaya FC	Aucas	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218440599	f
8104	Municipal Garabito	ADR Jicaral	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696848	f
8107	CA Douglas Haig	CA Union de Sunchales	2023-09-24 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218693657	f
8108	Racing Cordoba	Deportivo Riestr	2023-09-24 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218485790	f
8109	Sport Boys (Per)	Universidad Cesar Vallejo	2023-09-24 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218634274	f
8110	C J Antoniana	Boca Unidos	2023-09-24 21:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218693747	f
8111	Melgar	Union Comercio	2023-09-24 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218634184	f
8112	Univ Catolica (Chile)	Magallanes	2023-09-24 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218005254	f
8113	Metropolitanos	Deportivo La Guaira	2023-09-24 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218624515	f
8114	RSB Berkane	Wydad Casablanca	2023-09-24 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218697691	f
8115	Newells	Estudiantes	2023-09-24 21:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218466479	f
8116	San Diego Loyal SC	Las Vegas Lights FC	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218621117	f
8117	Fuerte San Francisco	Jocoro	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629207	f
8118	Envigado	Millonarios	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629747	f
8119	CD Dragon	Platense Zacatecoluca	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625721	f
8120	Estudiantes Rio Cuarto	Defensores de Belgrano	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218492320	f
8121	Atletico Chiriqui	Costa del Este	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218579999	f
8122	CD Marathon	Olancho	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218730375	f
8123	Puntarenas F.C.	Municipal Perez Zeledon	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450446	f
8124	CD Luis Angel Firpo	CD Municipal Limeno	2023-09-24 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218629387	f
8125	Guarani (Par)	Sportivo Luqueno	2023-09-24 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218643016	f
8126	Delfin	Guayaquil City	2023-09-24 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218394837	f
8127	Club Sportivo Ameliano	Club Sportivo Trinidense	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218642828	f
8128	Cruz Azul	Queretaro	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217987594	f
8129	Aldosivi	Villa Dalmine	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218485217	f
8130	Escorpiones FC	AD Cariari Pococi	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696939	f
8131	Tigre	San Lorenzo	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465758	f
8132	Carlos Mannucci	Alianza Lima	2023-09-24 23:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218634364	f
8133	Huehueteco Xinabajul	Malacateco	2023-09-25 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625001	f
8134	CD Olimpia	CD Real Sociedad	2023-09-25 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218715944	f
8135	Audax Italiano	Union La Calera	2023-09-25 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218013077	f
8136	Monagas	Deportivo Tachira	2023-09-25 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218624425	f
8137	Santa Fe	Deportivo Pereira	2023-09-25 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218626685	f
8138	Herrera FC	Sporting San Miguelito	2023-09-25 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218580179	f
8139	Orlando City	Inter Miami CF	2023-09-25 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218422599	f
8105	Atletico Madrid	Real Madrid	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217927502	t
8106	Braga	Boavista	2023-09-24 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218465866	t
4510	Genclerbirligi	Eyupspor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218078954	f
8140	Deportivo Cuenca	Barcelona (Ecu)	2023-09-25 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450266	f
8141	Banfield	River Plate	2023-09-25 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465650	f
8142	Sporting San Jose FC	Deportivo Saprissa	2023-09-25 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218605073	f
8143	Tapatio	CD Tepatitlan de Morelos	2023-09-25 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461549	f
8144	Deportivo Garcilaso	Cienciano	2023-09-25 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218634544	f
8145	Genesis Huracan	Vida	2023-09-25 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218715764	f
8146	Junior FC Barranquilla	Tolima	2023-09-25 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218641433	f
8147	Austin FC	LA Galaxy	2023-09-25 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424672	f
8148	Xelaju	Coban Imperial	2023-09-25 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625091	f
8149	Santos Laguna	Necaxa	2023-09-25 03:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217987956	f
4617	JS Saoura	US Biskra	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218370803	f
7702	Suwon FC	Ulsan Hyundai Horang-i	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406491	t
4461	Cambuur Leeuwarden	Willem II	2023-09-17 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218138697	f
7785	Sparta Rotterdam	Vitesse Arnhem	2023-09-24 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217939506	t
4629	Flamengo	Sao Paulo	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217730501	f
4646	Coban Imperial	Comunicaciones	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299233	f
7808	Lommel	Francs Borains	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218612908	t
4899	CF Orgullo de Reynosa	Mexicali FC	2023-09-19 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218416654	f
7850	LASK Linz	Hartberg	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217944587	t
7851	SCR Altach	Austria Vienna	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217944479	t
7941	Rayo Vallecano	Villarreal	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217927382	t
5067	Leyton Orient	Fulham U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342627	f
5068	Morecambe	Liverpool U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258176	f
5069	Derby	Lincoln	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258626	f
7970	Rapid Vienna	Sturm Graz	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944911	t
8096	Paris St-G	Marseille	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217965141	t
5244	Rionegro	America de Cali S.A	2023-09-21 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218494425	f
5245	Cienciano	Asociacion Deportiva Tarma	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218480624	f
5250	DC Utd	Atlanta Utd	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218280577	f
5252	New York City	Orlando City	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285569	f
5253	Instituto	Colon	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218211440	f
5254	Birmingham Legion FC	Memphis 901 FC	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294217	f
5255	Sporting San Jose FC	CS Herediano	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502348	f
5256	Racing Club	Newells	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031271	f
5257	CD Victoria	CD Motagua	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218538732	f
5258	Independiente Juniors	Guayaquil SC	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521799	f
5325	Atalanta	Rakow Czestochowa	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217882995	f
5913	Ponte Preta	Mirassol	2023-09-22 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218221319	f
5299	Hapoel Bikat Hayarden	Maccabi Yavne	2023-09-21 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218551014	f
5392	Brighton	AEK Athens	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217884911	f
5519	Deportivo Recoleta	Atyra FC	2023-09-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608811	f
5522	Cobreloa	Club Deportes Santa Cruz	2023-09-21 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218607620	f
5340	Venezuela (W)	Uruguay (W)	2023-09-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218566438	f
5529	Club Martin Ledesma	Rubio Nu	2023-09-22 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218610219	f
5665	Salus FC	Juanico	2023-09-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218619697	f
5351	Municipal Grecia	Puntarenas F.C.	2023-09-22 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218536896	f
5350	CD Olimpia	Genesis Huracan	2023-09-22 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218563660	f
5352	Atlante	Venados FC	2023-09-22 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218402194	f
5672	PSBS Biak Numfor	Aceh United FC	2023-09-22 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218607715	f
5673	Gangneung City	Mokpo City	2023-09-22 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550353	f
5674	Maccabi Kiryat Gat	Beitar Yavne	2023-09-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614082	f
5675	Beitar Nahariya	Shefa-amr FC	2023-09-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613992	f
5676	RANS Nusantara FC	Persis Solo	2023-09-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218584846	f
5677	Hong Kong (W)	Philippines (W)	2023-09-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515558	f
5678	Maccabi Ironi Amishav PT	Beitar Tel Aviv Bat Yam	2023-09-22 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218614172	f
5736	NK Sesvete U19	Slaven Belupo U19	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218607807	f
5797	Berliner AK	Chemnitzer	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559877	f
5805	Unterhaching	Arminia Bielefeld	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342846	f
5802	Lyngby	Vejle	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158913	t
5858	ADO Den Haag	SC Telstar	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504186	t
5930	FC Juarez	Atlas	2023-09-23 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.217988318	f
5776	FK Spartak	Vozdovac	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575471	f
5962	SC Bruck an der Mur	UFC Fehring	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636819	f
5807	Tennis Borussia Berlin	FC Hertha 03 Zehlendorf	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590030	f
5793	Macva Sabac	FK Sloboda Point	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218594548	f
5823	Bad Sauerbrunn	Deutschkreutz	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218609518	f
5866	Everton U21	Norwich U21	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218598884	f
6043	RFC de Liege U21	Waasland-Beveren (Res)	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648429	f
3337	FC Nordsjaelland	FC Copenhagen	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217900814	f
3345	York City	Southend	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218121261	f
3353	Barnsley	Burton Albion	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889960	f
3304	Fjolnir	Njardvik	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319692	f
3329	FC Pyunik	BKMA Yerevan	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268176	f
3359	Celtic	Dundee	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637359	f
5744	USM Alger U21	USM Khenchela U21	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629837	f
5679	Beitar Ramat Gan	Beitar Petah Tikva	2023-09-22 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218614262	f
3317	SJK	Honka	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122644	f
3319	MK Dons	Stockport	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951539	f
3358	Cove Rangers	Kelty Hearts	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217919918	f
3313	Bradford	Harrogate Town	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951176	f
3314	Crawley Town	Tranmere	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217950996	f
3316	Forest Green	Doncaster	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951266	f
3335	Wrexham	Grimsby	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951447	f
3354	Coleraine	Newry	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218123023	f
3305	Selfoss	IF Vestri	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319962	f
3322	KFG	Throttur Vogar	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320248	f
3321	Rochdale	Barnet	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120541	f
3355	Port Vale	Northampton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889322	f
3357	Annan	Stirling	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217920404	f
3325	Hamilton	Alloa	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217920717	f
3330	Oxford City	Dag and Red	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120721	f
3347	NK Fuzinar	Krka	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270328	f
5210	Hull	Leeds	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884197	f
3356	Wycombe	Blackpool	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217888994	f
3352	Torns	FC Trollhattan	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137715	f
3326	Ebbsfleet Utd	Chesterfield	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120361	f
3301	Vasalunds IF	Orebro Syrianska	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137985	f
3339	Hartlepool	Woking	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120631	f
3350	Tabor Sezana	NK Jadran Dekani	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270148	f
3341	FK Puchov	FK Humenne	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228468	f
3318	Keflavik (W)	Selfoss (W)	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320664	f
3311	Molenbeek	Cercle Brugge	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217902501	f
3348	Eskilsminne	Vanersborgs IF	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138075	f
3323	Peterborough	Leyton Orient	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889852	f
3342	Colchester	Mansfield	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951719	f
3327	AFC Wimbledon	Crewe	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217950816	f
3344	Kayserispor	Gaziantep FK	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218113807	f
3312	AFC Fylde	Eastleigh	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120451	f
3303	Exeter	Cheltenham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889210	f
3324	Falkirk	Queen of South	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217920008	f
3306	Throttur	Afturelding	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319872	f
3302	Watford	Birmingham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646009	f
3338	Aldershot	Gateshead	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218121171	f
3333	FK Igman Konjic	FK Velez Mostar	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319096	f
5912	Chilangos FC	FC Santiago	2023-09-22 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218623464	f
6047	Austria Wien (A)	SPG Oberwart/R	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595576	f
6050	FK Lyn U19	Baerum SK U19	2023-09-22 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218649836	f
5339	Tolima	Envigado	2023-09-21 23:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218512032	f
3346	Swindon	Walsall	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951629	f
3343	Fulham	Luton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634798	f
3332	Hearts	Aberdeen	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637467	f
3320	Bristol City	West Brom	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645253	f
3349	Falkenbergs	Norrby IF	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138517	f
5922	Ituano	EC Vitoria Salvador	2023-09-23 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218316585	f
5925	Cimarrones de Sonora II	Real Apodaca FC	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218604616	f
3309	Hottur	IR Reykjavik	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320158	f
3308	Gillingham	Morecambe	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217950906	f
3336	Anderlecht B	Patro Eisden Maasmechelen	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218230114	f
3340	HJK Helsinki	FC Inter	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122464	f
3300	Preston	Plymouth	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645901	f
3331	Lincoln	Carlisle	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217888882	f
3315	Kilmarnock	Hibernian	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217638037	f
3307	West Ham	Man City	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634939	f
3334	Tindastoll (W)	IBV (W)	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320574	f
3351	Tottenham	Sheff Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217635503	f
3361	Sheff Wed	Ipswich	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645793	f
3298	Huddersfield	Rotherham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645577	f
3373	Reading	Bolton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217888660	f
3376	Wigan	Cambridge Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889102	f
5909	Club General Caballero JLM	Resistencia SC	2023-09-22 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218616210	f
5910	CD Hermanos Colmenarez	Caracas	2023-09-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599245	f
5911	Jaguares de Cordoba	Alianza Petrolera	2023-09-22 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218515112	f
3365	Ljungskile	BK Olympic	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138607	f
3369	Thor	Grindavik	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319782	f
3368	Fleetwood Town	Oxford Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217890068	f
3372	Montrose	Edinburgh City	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217920098	f
3360	Blackburn	Middlesbrough	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646442	f
3363	Arbroath	Airdrieonians	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217864120	f
3374	Shrewsbury	Bristol Rovers	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217890176	f
3367	Ross Co	Livingston	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637929	f
3364	Ahlafors IF	Ariana FC	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137445	f
3375	Stevenage	Charlton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889432	f
3366	Elgin City FC	Dumbarton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865305	f
3391	Feyenoord	Heerenveen	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217639118	f
3378	Valencia	Atletico Madrid	2023-09-16 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217673302	f
3380	Huesca	Villarreal B	2023-09-16 15:16:00	https://www.orbitxch.com/customer/sport/1/market/1.218322539	f
3382	Lamia	OFI	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217680327	f
3394	Slavia Sofia	Lokomotiv Sofia	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217707246	f
3387	Touring KE	SD Deusto	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218328371	f
3385	BSK Bijelo Brdo	NK Dubrava Zagreb	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218254387	f
3388	Rio Ave	Famalicao	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912989	f
3383	Europa Point FC	Manchester 62 FC	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218334109	f
3381	Ingolstadt	1860 Munich	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218117684	f
3389	NK Solin	NK Sesvete	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218254207	f
3406	Austria Klagenfurt	LASK Linz	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217674584	f
3392	Lisen	FC Sellier & Bellot Vlasim	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217974991	f
3390	H Slavia Kromeriz	Sigma Olomouc B	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217975081	f
3384	Santa Clara	Penafiel	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218126231	f
3393	Stade Tunisien	EGS Gafsa	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218333962	f
3386	Elche B	FC Jove Espanol	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218328281	f
3409	Al Salt	Al Ramtha	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320428	f
3395	Dinamo Zagreb	Slaven Belupo	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217973056	f
3397	MC Alger	ES Ben Aknoun	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328733	f
3400	BFA Vilnius	Be1 NFA	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320338	f
3399	Etoile Sportive Sahel	FAR Rabat	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329039	f
3401	FK Banga Gargzdu	FK Dainava Alytus	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218230204	f
3396	NC Magra	Kabylie	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328643	f
3404	FK Aktobe	FC Ordabasy	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218179434	f
3407	FC Blau Weiss Linz	SCR Altach	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217674465	f
3405	Rennes	Lille	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217678244	f
3410	Betis (W)	Villarreal (W)	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327699	f
3398	Hoffenheim II	SV Steinbach	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274610	f
3403	Al-Raed (KSA)	Al Nassr	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040278	f
3412	Djurgardens	Varnamo	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217786342	f
3402	FC Ajka	Mezokovesd-Zsory	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263735	f
3408	Al-Hazm (KSA)	Al Taee	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040576	f
3411	Mura	NK Bravo	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218001752	f
3416	Barcelona B	Fuenlabrada	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218233736	f
3415	Kaizer Chiefs	Bloemfontein Celtic	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218142029	f
3414	Rakow Czestochowa	LKS Lodz	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217793293	f
3418	Koper	NK Celje	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001387	f
3362	Man Utd	Brighton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217635080	f
3417	NK Radomlje	Domzale	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001477	f
3379	Reggiana	US Cremonese	2023-09-16 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217959655	f
3102	Sagamihara	FC Gifu	2023-09-16 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218101808	f
3103	Blaublitz Akita	Nagasaki	2023-09-16 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015713	f
3104	Incheon Utd	Jeju Utd	2023-09-16 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217880359	f
3105	Jeonbuk Motors	Gangwon	2023-09-16 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217880569	f
3106	Honda Lock	Sony Sendai FC	2023-09-16 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312696	f
3107	Maruyasu Okazaki	MIO Biwako Shiga	2023-09-16 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312876	f
3108	Ansan Greeners FC	Cheongju FC	2023-09-16 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217929112	f
3109	Lee Man Warriors	Kitchee SC	2023-09-16 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218309632	f
3110	Seoul E-Land FC	Cheonan City	2023-09-16 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217928834	f
3111	Pohang Steelers	Suwon FC	2023-09-16 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218344201	f
3112	Brisbane Roar	Western Sydney Wanderers	2023-09-16 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217952534	f
3113	Pocheon FC	Busan Transportation Corp	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218256011	f
3114	Arema Cronus	Persita Tangerang	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310543	f
3115	Csikszereda	CS Mioveni	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945232	f
3116	Gloria Buzau	FCM Alexandria	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945592	f
3117	Hwaseong FC	Yangpyeong FC	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218242973	f
3118	Persib Bandung	PS TIRA	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310453	f
3119	Jiangxi Dark Horse Junior	Dalian Zhixing	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310272	f
3120	Csm Slatina	CSC 1599 Selimbar	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217991481	f
3121	Unirea Slobozia	FC Metaloglobus Bucuresti	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945322	f
3122	Acs Dumbravita	CS Tunari	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945412	f
3123	FC Hunedoara	CSM Scolar Resita	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945052	f
3124	Haimen Codion	Quanzhou Yaxin	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310362	f
3125	Progresul 1944 Spartac	ACS Viitorul Tg Jiu	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945502	f
3126	Vyskov	Prostejov	2023-09-16 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217974901	f
3127	Taian Tiankuang	Hainan Star	2023-09-16 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218311638	f
3128	Slovan Bratislava II	KFC Komarno	2023-09-16 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218228738	f
3129	Prey Veng	National Defense Ministry	2023-09-16 09:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218335305	f
3130	Sendai	Mito	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218058034	f
3131	Viktoria Koln U19	Fortuna Dusseldorf U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311548	f
3132	Istanbul Basaksehir FK U19	Antalyaspor U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312302	f
3133	Omiya	Kumamoto	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218057943	f
3134	Tensung FC	RTC FC	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218332224	f
3135	Kitakyushu	Azul Claro Numazu	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218114072	f
3136	Yamagata	Okayama	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218057853	f
3137	Kashima	C-Osaka	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879265	f
3138	Arminia Bielefeld U19	Dortmund U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329337	f
3139	Leverkusen U19	FC Koln U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311368	f
3140	Eyupspor U19	Sivasspor U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312392	f
3141	Konyaspor U19	Istanbulspor AS U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312212	f
3142	RB Leipzig U19	Hamburger SV U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311458	f
3143	Henan Songshan Longmen	Shanghai Shenhua	2023-09-16 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218110693	f
3144	Busan IPark	Seongnam FC	2023-09-16 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217928927	f
3145	FC Schalke U19	SC Paderborn 07 U19	2023-09-16 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218330244	f
3146	Iwata	Renofa Yamaguchi	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015803	f
3147	CD Berceo	CA Rivers Ebro	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328100	f
3148	Tochigi SC	Jef Utd Chiba	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015983	f
3149	Vanraure Hachinohe	Nara Club	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218114252	f
3150	CD Atletico Melilla	Polideportivo Ejido	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328010	f
3151	Oita	Tokushima	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015622	f
3152	FC Imabari	Nagano Parceiro	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218115362	f
3153	SD Eibar (W)	Levante Las Planas (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327391	f
3154	Fukuoka	Nagoya	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879355	f
3155	Hiroshima	Kobe	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217878995	f
3156	FC Tatran Prešov (W)	FC Petrzalka (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329607	f
3157	MFK Ruzomberok (W)	Spartak Myjava (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329517	f
3158	Stomilanki Olsztyn (W)	Gornik Leczna (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334622	f
3159	Atletico Madrid (W)	Athletic Bilbao (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218110330	f
3161	Sapporo	Shonan	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879085	f
3162	1. FSV Mainz 05 U19	SV Sandhausen U19	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314595	f
3163	AVS Futebol SAD	Vilaverdense	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218118062	f
3164	Ulsan Hyundai Horang-i	Daejeon Citizen	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218344309	f
3165	Garliava Kaunas	TransINVEST Vilnius	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316114	f
3166	Slask Wroclaw (W)	Pogon Tczew (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316945	f
3167	Benfica U23	Farense U23	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316204	f
3168	Tottori	Fukushima Utd	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218114162	f
3169	Sporting Braga U23	SC Uniao Torreense U23	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218338223	f
3170	Porto B	Maritimo	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218142119	f
3171	Czarni Sosnowiec (W)	Pogon Szczecin (W)	2023-09-16 11:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218316855	f
3172	Hansa Rostock	Fortuna Dusseldorf	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217689179	f
3173	IF Karlstad	Umea FC	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137805	f
3174	Wuppertaler SV U19	SC Verl U19	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329427	f
3175	Mikkeli	SJK 2	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218289962	f
3176	FC Stockholm Internazionale	Hammarby TFF	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137535	f
3177	Sollentuna FF	IF Sylvia	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137895	f
3178	BG Pathumthani United	Muangthong Utd	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218180336	f
3179	AFC Eskilstuna	Orgryte	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217874964	f
3180	Elversberg	Hamburger SV	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217688981	f
3181	Ayutthaya United	Kasetsart FC	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316492	f
3182	FK Jelgava	BFC Daugavpils	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263371	f
3183	Rot-Weiss Erfurt	Meuselwitz	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274070	f
3184	Karlsruhe	Kaiserslautern	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217730844	f
3185	Hannover II	Norderstedt	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273890	f
3186	Nanjing Fengfan	Hebei KungFu	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314502	f
3187	AZS UJ Krakow (W)	UKS SMS Lodz (W)	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316765	f
3188	Hertha Berlin II	Carl Zeiss Jena	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274160	f
3189	Svay Rieng FC	Angkor Tiger FC	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314232	f
3190	St Johnstone	Rangers	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217637578	f
3191	Guangzhou FC	Dongguan Guanlian	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218314322	f
3193	Yunnan Yukun	Qingdao Red Lions	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218314412	f
3194	Phrae United	Rayong FC	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218316402	f
3195	Meizhou Hakka	Shenzhen FC	2023-09-16 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218115452	f
3196	SC Telstar (W)	Twente (W)	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218351349	f
3197	SV Sandhausen	Preussen Munster	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122735	f
3198	Lubeck	Dynamo Dresden	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218117594	f
3199	Arminia Bielefeld	Freiburg II	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122825	f
3200	Dortmund II	Viktoria Koln	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218117774	f
3201	Ratchaburi	Police Tero	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218155337	f
3202	Sundsvall (W)	Mallbackens IF (W)	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334297	f
3203	Rot-Weiss Essen	Jahn Regensburg	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218117864	f
3204	FC Koln II	Schalke 04 II	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218291133	f
3205	Athletic Bilbao	Cadiz	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217662409	f
3206	VfL Osnabruck U19	Wolfsburg U19	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218331448	f
3207	AFC Leopards SC (Kenya)	Muhoroni Youth FC	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032992	f
3208	Shabana	Kenya Police FC	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033180	f
3209	Persis Solo	Psis Semarang	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315754	f
3210	MFD Zalgiris Vilnius (Res)	FC Neptunas Klaipeda	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316024	f
3211	Cosenza	Sudtirol	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217943595	f
3212	Lecco	Brescia	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960696	f
3213	Pisa	SSD Bari	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217946822	f
3214	Ankaraspor	Bucaspor	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218333593	f
3215	FK Panevezio Ekranas	FK Nevezis	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315844	f
3216	Alemannia Aachen	SV Rodinghausen	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275127	f
3006	ASO Chlef	MC Oran	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272136	f
3217	Customs United	Samut Prakan	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316312	f
3218	Bandari FC (Kenya)	Ulinzi Stars	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033086	f
3219	Kakamega Homeboyz	Tusker FC	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033452	f
3220	FK Siauliai II	FK Riteriai II	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315934	f
3221	Kapaz Ganja	Sabail	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262936	f
3223	Abha	Al-Ettifaq	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040684	f
3224	Stuttgart II	Homburg	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274520	f
3225	VfB Oldenburg	Teutonia 05 Ottensen	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273800	f
3226	Ascoli	Palermo	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944155	f
3227	FK Atyrau	FK Kyzyl-Zhar	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190016	f
3228	Feralpisalo	Modena	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217959475	f
3229	FK Suduva	Panevezys	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218230024	f
3230	SalPA	JJK	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218118152	f
3231	Grorud IL	Lyn	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276707	f
3232	Montpellier (W)	Dijon (W)	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319422	f
3233	Floy Flekkeroy	Egersund	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276441	f
3234	Chiangrai Utd	Khonkaen United	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218180426	f
3235	Rigas Futbola Skola	FK Riga	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263191	f
3236	Lille (W)	Paris FC (W)	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218321765	f
3237	Mlada Boleslav	Hradec Kralove	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727920	f
3238	Ostersunds FK	Gefle	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960110	f
3239	Polonia Warszawa	Znicz Pruszkow	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798135	f
3240	MFK Karvina	Teplice	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217740020	f
3241	NK Jarun	NK Croatia Zmijavci	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218254027	f
3242	Sigma Olomouc	Ceske Budejovice	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727560	f
3243	FC Astana	Tobol Kostanay	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218179344	f
3244	Keciorengucu	Sanliurfaspor	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218077783	f
3245	IFK Goteborg	Brommapojkarna	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217786666	f
3246	JaPS	KaPa	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122915	f
3247	Egri FC	DEBRECENI VSC	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263553	f
3248	Golden Arrows	Stellenbosch FC	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218141939	f
3249	Juventus	Lazio	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672548	f
3250	Caen	St Etienne	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218008133	f
3251	Sirius	Varbergs BoIS	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217786558	f
3252	Bohemians 1905	Banik Ostrava	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217730677	f
3253	CD Nacional Funchal	Feirense	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218123490	f
2831	Rionegro	Union Magdalena	2023-09-14 23:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2832	Coritiba	Bahia	2023-09-15 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2833	Deportivo Cali	Atletico Huila	2023-09-15 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2834	Ferroviaria (W)	Palmeiras (W)	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2835	Guayaquil SC	Manta FC	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2836	EC Realidade Jovem (W)	Sao Paulo (W)	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2837	EC Sao Jose (W)	EC Taubate (W)	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2838	Santos FC (W)	Pinda SC (W)	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2839	CA Independiente	Huracan	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2840	Bragantino SP	Gremio	2023-09-15 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2841	Village Superstars	Conaree United	2023-09-15 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2842	Universidad Guadalajara	Dorados	2023-09-15 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2843	CD Victoria	Vida	2023-09-15 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2844	Alianza Petrolera	Junior FC Barranquilla	2023-09-15 02:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2845	FC Juarez (W)	Puebla FC (W)	2023-09-15 04:06:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f
2846	PSM Makassar	PS Barito Putera	2023-09-15 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276171	f
2847	FC Spartak Trnava U19	Dukla Banska Bystrica U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294690	f
2848	Slovan Bratislava U19	FK AS Trencin U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294780	f
2849	Ispe FC	Rakhine Utd	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276261	f
2850	FK Aksu Pavlodar	Okzhetpes	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218179614	f
2909	FK Auda	FS METTA/LU	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218255923	f
3254	IK Brage	Trelleborgs	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960020	f
2851	Sport Academy Kairat	FC Astana U21	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218318403	f
2852	FC Kosice U19	Dunajska Streda U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294510	f
2853	FC Vion Zlate Moravce U19	Z Michalovce U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294403	f
2854	Ruzomberok U19	MSK Zilina U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294600	f
2855	Ayeyawady United	Yadanarbon	2023-09-15 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218276351	f
2856	Changwon City	Gimhae City	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218243063	f
2857	Daejeon Korail FC	Paju Citizen	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218243243	f
2858	Yokohama FM	Tosu	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879716	f
2859	Kofu	Tokyo-V	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015532	f
2860	Kawasaki	FC Tokyo	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879536	f
2861	Urawa	Kyoto	2023-09-15 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217879175	f
2862	FK Kaspyi Aktau	FK Maqtaaral Jetisay	2023-09-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218189926	f
2863	KMC	JKT Tanzania	2023-09-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299139	f
2864	Shandong Taishan	Qingdao Jonoon	2023-09-15 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218065287	f
2865	Shanghai Port FC	Changchun Yatai	2023-09-15 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218065503	f
2866	Beijing Guoan	Zhejiang Greentown	2023-09-15 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218065395	f
2927	CD Tropezon	UD Samano	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296206	f
2867	Wuhan Three Towns	Cangzhou Mighty Lions	2023-09-15 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218065611	f
2868	Balestier Khalsa	Tampines Rovers	2023-09-15 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218276977	f
2869	Tanjong Pagar United	Brunei DPMM FC	2023-09-15 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217991390	f
2870	Bali Utd Pusam	RANS Nusantara FC	2023-09-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275991	f
2871	Dewa United FC	Bhayangkara FC	2023-09-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276081	f
2872	Buriram Utd	Trat	2023-09-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218103929	f
2873	Sabah FA	Perak	2023-09-15 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218288405	f
2874	Bangkok Utd	Sukhothai	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218103839	f
2875	Bright Stars	Bul FC	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295735	f
2876	Zira	FK Sumqayit	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218255742	f
2877	Bumamuru	Mamelodi Sundowns	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218300206	f
2878	Club El Porvenir (W)	Social Atletico Television	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218289401	f
2879	Birmingham U21	Wigan Athletic U21	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279415	f
2880	Maritzburg Utd	Casric FC	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299659	f
2881	SC Villa	Airtel Kitara FC	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295645	f
2882	Platense (W)	Club Ferro Carril Oeste (W)	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310814	f
2883	Unia Skierniewice	Olimpia Zambrow	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295917	f
2884	Zrinski Jurjevac	HNK Orijent 1919	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218254297	f
2885	CS Dinamo Bucuresti	CSO Plopeni	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294127	f
2886	CS Uni Craiova II	CSM Deva	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218293946	f
2887	Gorica	NK Slovenska Bistrica	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218267906	f
2888	Muscelul Camp	Cetate Rasnov	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294308	f
2889	Sloga Doboj	Tuzla City	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279325	f
2890	ACS Vedita Colonesti MS	CS Viitorul Daesti	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294037	f
2891	Slavoj Trebisov	MFk Dolny Kubin	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228378	f
2892	Vukovar	NK Dugopolje	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218254117	f
2893	Minija Kretinga	FK Kauno Zalgiris 2	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218280993	f
2894	Arda	Botev Vratsa	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217707063	f
2895	Beltinci	Nafta Lendava	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218267996	f
2896	Siarka Tarnobrzeg	GP TS Avia Swidnik	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218296007	f
2897	FK Babrungas	Marijampole City	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218280903	f
2898	Greuther Furth II	Nurnberg II	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218290913	f
2899	Al-Jalil	Sahab SC	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279595	f
2900	USM Khenchela	ES Setif	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272046	f
2901	MC El Bayadh	CS Constantine	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272226	f
2902	TSG Hoffenheim U19	Bayern Munich U19	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273529	f
2903	Notec Czarnków	Unia Solec Kujawski	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296097	f
2904	Atlantis	GrIFK	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218280757	f
2905	Al-Feiha	Al-Shabab (KSA)	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040900	f
2906	Vysocina Jihlava	FC Zbrojovka Brno	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217974631	f
2907	Haka	Ilves	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218075577	f
2908	Arsenal Ceska Lipa	Usti Nad Labem	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218280667	f
2911	Metalist 1925	Zorya	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217921528	f
2912	UTA Arad	Universitatea Cluj	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217713634	f
2913	Podbrezova	MFK Skalica	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217761827	f
2914	SV Fortuna Regensburg	Ingolstadt II	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218290056	f
2915	SFC Opava	Dukla Prague	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217974721	f
2916	TWL Elektra	SV Leobendorf	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218289707	f
2917	Puszcza Niepolomice	Slask Wroclaw	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217793394	f
2918	Correcaminos (Premier)	Tritones Vallarta MFC	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218281928	f
2919	Triglav	Ilirija Extra-Lux	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268086	f
2920	Rosengard (W)	Brommapojkarna (W)	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218277249	f
2921	Ilves Kissat	FC Jazz	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218281478	f
2922	Stal Rzeszow	Wisla Plock	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798694	f
2923	Lokomotiva	Rudes	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217978984	f
2924	Pohronie	MSK Zilina II	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228288	f
2925	Pribram	Sparta Prague B	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217974811	f
2926	FC Kiffen	PK-35 RY	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218281568	f
2928	St Polten	FIRST VIENNA FC 1894	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217936142	f
2929	Floridsdorfer Ac	Admira Wacker	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217935961	f
2930	FC Dornbirn	SKU Amstetten	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217936775	f
2931	FC Liefering	SV Stripfing/Weiden	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217936866	f
2932	SV Lafnitz	SV Horn	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217936052	f
2933	FC Bastia-Borgo	Stade Briochin	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218273120	f
2934	Nurnberg	Greuther Furth	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217876626	f
2935	Hannover 96 (U19)	SV Werder Bremen U19	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218277564	f
2936	Paderborn	Wehen Wiesbaden	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217688693	f
2937	Zeljeznicar	Gosk Gabela	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218282153	f
2938	Le Puy	Jura Sud	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273226	f
2939	Ranheim IL	Raufoss	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885444	f
2940	Lunds BK	Angelholms	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218101361	f
2941	Cherno More	Beroe Stara Za	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217706702	f
2942	Eimsbutteler	Weiche Flensburg	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273710	f
2943	Viborg	Midtjylland	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217903844	f
2944	Hobro	AC Horsens	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961654	f
2946	FC Nottingen	Atsv Mutschelbach	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218290150	f
2948	SC Weiz	Union Gurten	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272316	f
2949	SK Vorwarts Steyr	ASK Klagenfurt	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272406	f
2950	Viktoria Aschaffenburg	Schalding-Heining	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273620	f
2951	Eint Frankfurt II	SV Stuttgarter Kickers	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274880	f
2952	Spartak Myjava	Tatran Presov	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228197	f
2953	HB Torshavn	Klaksvikar Itrottarfelag	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279505	f
2954	Chemnitzer	Lokomotiv Leipzig	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274340	f
2955	IFK Hassleholm	Nosaby IF	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218264005	f
2956	TUS Bad Gleichenberg	Union Volksbank Vocklamarkt	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272496	f
2957	Duisburg	Verl	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218080321	f
2958	Skra Czestochowa	Radunia Stezyca	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251872	f
2959	Sao Paulo U20	Mirassol U20	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307647	f
2960	SAK Klagenfurt	SV Donau Klagenfurt	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276887	f
2961	SC Eltersdorf	Jahn Regensburg II	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218290294	f
2962	SV Lippstadt	Rot-Weiss Ahlen	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275413	f
2963	Skive	Middelfart	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218288673	f
2964	BFC Dynamo	Babelsberg	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274250	f
2965	FSV 63 Luckenwalde	Greifswalder SV 04	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273980	f
2966	Rouen	GO Lyon	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218200793	f
2967	Moroka Swallows	Richards Bay FC	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218141849	f
2947	Hillerod Fodbold	B93 Copenhagen	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961384	f
2969	Niort	Epinal	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093476	f
2970	Martigues	Sochaux	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218200704	f
2971	Lommel SK U21	Sint Truidense (Res)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218288281	f
2972	Favoritner AC	Austria Wien (A)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218274970	f
2973	FC Zwolle (W)	FC Utrecht (W)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218272996	f
2974	FC Wegberg-Beeck	Mgladbach II	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218275316	f
2975	Excelsior (W)	Ajax (W)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218298316	f
2976	Heerenveen (W)	AZ Alkmaar Women	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218272906	f
2977	SC Victoria Hamburg	FC Turkiye	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218290726	f
2978	ADO Den Haag (W)	PSV Eindhoven (W)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218272816	f
2979	Cholet SO	Marignane-Gignac	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093566	f
2980	Wiener SK	Wiener Victoria	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218298117	f
2981	FC Wil	Stade Lausanne-Ouchy	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218264095	f
2982	Le Mans	Red Star	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093296	f
2983	Avranches	Orleans	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093386	f
2984	Chateauroux	Versailles 78 FC	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218141759	f
2985	Villefranche Beaujolais	Nimes	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093206	f
2986	Neuchatel Xamax	Young Boys	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218264185	f
2987	Bourgoin Jallieu	Toulouse B	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273335	f
2988	America MG U20	Coimbra EC U20	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310182	f
2989	Helmond Sport	FC Oss	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218080681	f
2990	Jong AZ Alkmaar	FC Eindhoven	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218080591	f
2991	Brentford U21	Fulham U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292909	f
2992	Olimpia Elblag	Wisla Pulawy	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218240588	f
2993	Jong Ajax Amsterdam	Emmen	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218082967	f
2995	Leicester U21	Burnley U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292638	f
2996	Al-Khaleej Saihat	Al-Fateh (KSA)	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040792	f
2998	VVV Venlo	NAC Breda	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218083237	f
3000	Royal Charleroi SC (W)	Femina WS (W)	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279235	f
3001	Kari	IF Magni	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307803	f
3002	CA Huracan (W)	San Lorenzo Al (W)	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218288110	f
3003	Atletico Grau	UTC Cajamarca	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218191763	f
3004	Brighton U21	Aston Villa U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218293089	f
3005	Leeds United U21	Colchester United U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292999	f
3007	Fleetwood Town U21	Nottingham Forest U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292819	f
3008	Al-Hilal	Al Riyadh SC	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040158	f
3009	Den Bosch	MVV Maastricht	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218082787	f
3012	Soroksar	Kecskemeti	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218255833	f
3013	Middlesbrough U21	Crystal Palace U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292728	f
3014	FC Liege	Club Brugge B	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229177	f
3015	Racing (W)	CA Independiente (W)	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218287933	f
3016	River Plate (W)	Boca Juniors (W)	2023-09-15 19:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218288023	f
3017	Deportivo Riestra	CA Atlanta	2023-09-15 19:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218210444	f
3018	Club Football Estrela	Porto	2023-09-15 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217913097	f
3019	Ammanford AFC	Taffs Well	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218295553	f
3020	Venezia	Spezia	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959385	f
3021	Newport City	Abergavenny Town	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218295373	f
3022	Gornik Zabrze	Ruch Chorzow	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217793563	f
3024	DSV Leoben	Grazer AK	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217937029	f
3025	Dinamo Bucharest	FC U Craiova 1948	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217713184	f
3026	GKS Katowice	Zaglebie Sosnowiec	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217868286	f
3027	CD Cambaceres	Club El Porvenir (BA)	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218310724	f
2997	Roda JC	SC Telstar	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218082877	f
2999	Racing Genk B	Zulte-Waregem	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229465	f
3010	FC Dordrecht	Jong FC Utrecht	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218083057	f
3011	FC Groningen	ADO Den Haag	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218083147	f
3028	Genk (W)	Oud-Heverlee Leuven (W)	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218279145	f
3029	Bayern Munich	Leverkusen	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217627908	f
3023	Braga B	Sanjoanense	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218240710	f
3031	Holyhead Hotspur	Bangor 1876	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218295463	f
3032	Rimini	Juventus B	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218236244	f
3033	Galway Utd	Dundalk	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218198013	f
3034	Athlone Town	Kerry FC	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218083883	f
3035	Hull	Coventry	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217646334	f
3036	Salford City	Notts Co	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217951356	f
3037	Derry City	Shamrock Rovers	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217934382	f
3038	Atalanta B	Giana Erminio	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218239562	f
3039	Waterford	Cobh Ramblers	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218083973	f
3040	Spal	Perugia	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218236138	f
3041	Drogheda	Bohemians	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218198103	f
3042	Bray Wanderers	Treaty United	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218082037	f
3043	Ancona	ASD Pineto Calcio	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235934	f
3044	Ayr	Partick	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217864014	f
3045	Pontedera	Cesena	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235624	f
3046	Cork City	Wexford F.C	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218197923	f
3047	Colwyn Bay	Aberystwyth	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218256817	f
3048	Westerlo	Antwerp	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217902393	f
3049	Larne	Linfield	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218082127	f
3050	Southampton	Leicester	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646550	f
3051	Valencia (W)	Real Madrid FC (W)	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296656	f
3052	Paris St-G	Nice	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217677469	f
3053	Rayo Vallecano	Alaves	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217662542	f
3054	Finn Harps	St Patricks	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198193	f
3055	Le Havre AC (W)	Lyon (W)	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218288763	f
3056	Pacos Ferreira	Leixoes	2023-09-15 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218101898	f
3057	CD Buzanada	CD Santa Ursula	2023-09-15 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218296296	f
3058	Zaragoza	Racing Santander	2023-09-15 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217991879	f
3059	Tigre	Estudiantes	2023-09-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217822541	f
3060	Carlos Mannucci	AD Cantolao	2023-09-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190377	f
3061	UD Tamaraceite	CF Panaderia Pulido	2023-09-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296386	f
3062	Melgar	Alianza Atletico	2023-09-15 21:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218190558	f
3063	Real Soacha Cundinamarca FC	Boyaca Patriotas	2023-09-15 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218270720	f
3064	Atletico FC Cali	Quindio	2023-09-15 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218202859	f
3065	Platense Zacatecoluca	CD Aguila	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218277474	f
3066	Angostura FC	Monagas	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307107	f
3067	Guairena	Club Sportivo Trinidense	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218305636	f
3068	Fortaleza FC	Cortulua	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204977	f
3069	Limon Black Star	AD Aserri	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299049	f
3070	Defensa y Justicia	Boca Juniors	2023-09-15 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217819453	f
3071	Vila Nova	Ponte Preta	2023-09-15 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217980361	f
3072	Llaneros FC	Barranquilla	2023-09-15 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3073	St. Pauls United	Cayon FC	2023-09-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3074	Club Necaxa (W)	Santos Laguna (W)	2023-09-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3075	CD Poza Rica	Deportivo Gladiadores	2023-09-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3076	Cuiaba	America MG	2023-09-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3077	Queretaro (W)	Tigres (W)	2023-09-16 00:06:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3078	Once Caldas	Envigado	2023-09-16 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3079	Nacional (Par)	Sportivo Luqueno	2023-09-16 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3080	Deportivo La Guaira	CD Hermanos Colmenarez	2023-09-16 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3081	Banfield	Argentinos Juniors	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3082	Alianza FC (SLV)	CD Municipal Limeno	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3083	Orense Sporting Club	Univ Catolica (Ecu)	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3084	Binacional	Cienciano	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3085	Colon	Rosario Central	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3086	Deportivo Saprissa	Municipal Grecia	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3090	ABC RN	Sport Recife	2023-09-16 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3091	Mazatlan FC	Cruz Azul	2023-09-16 01:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3092	Petroleros de Salamanca	Yalmakan FC	2023-09-16 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3093	San Francisco FC	Tauro FC	2023-09-16 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3094	Atletico Saltillo	Tuzos de la UAZ	2023-09-16 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3095	Millonarios	Atletico Bucaramanga	2023-09-16 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3096	Futbol Consultants Moravia	Uruguay de Coronado	2023-09-16 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3097	AD Municipal Liberia	AD Guanacasteca	2023-09-16 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3098	Chihuahua FC	Mineros de Fresnillo FC	2023-09-16 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3099	Monterrey (W)	Pachuca (W)	2023-09-16 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3100	Tijuana	Toluca	2023-09-16 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3101	Suzuka Unlimited	Criacao Shinjuku	2023-09-16 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3255	Fram Larvik	Kjelsas	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276797	f
3256	Pogon Szczecin	Korona Kielce	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217794730	f
3257	Stade Reims (W)	Saint-Etienne (W)	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319512	f
3258	Sandnes Ulf	KFUM Oslo	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885254	f
3259	Sturm Graz (W)	USC Landhaus (W)	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218314102	f
3260	CD Victoria	Lagun Onak	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218328191	f
3261	Newtown	Barry Town Utd	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269564	f
3262	Connahs Quay	Cardiff Metropolitan	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269204	f
3264	FC Koln	Hoffenheim	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217641651	f
3266	Penybont FC	Caernarfon Town	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269384	f
3268	Freiburg	Dortmund	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217628780	f
3269	Pontypridd Town	Bala Town	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269474	f
3270	The New Saints	Haverfordwest County	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269294	f
3286	Forfar	Spartans	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865109	f
3291	Bromley	Oldham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120991	f
3299	Peterhead	Bonnyrigg	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865215	f
3281	East Fife	Clyde	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865395	f
3272	Norwich	Stoke	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646226	f
3283	Newport County	Barrow	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951086	f
3285	Accrington	Sutton Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960606	f
3277	Tolmin	Rudar	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218269966	f
3292	FC Halifax Town	Dorking Wanderers	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218121351	f
3297	Queens Park	Dunfermline	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217864210	f
3290	Aston Villa	Crystal Palace	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634516	f
3296	Dundee Utd	Morton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217864390	f
3278	Derby	Portsmouth	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889654	f
3288	IA Akranes	Grotta	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319602	f
3295	Maidenhead	Boreham Wood	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218121081	f
3284	QPR	Sunderland	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646117	f
3275	NK Primorje	Dravinja Kostroj	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270238	f
3271	Bohemians (W)	Sligo Rovers (W)	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303861	f
3294	Ballymena	Loughgall	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218181306	f
3276	Konyaspor	Rizespor	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218114023	f
3273	Taby FK	Sandvikens	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137625	f
3274	Stenhousemuir	Stranraer	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865019	f
3279	AC Oulu	IFK Mariehamn	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122554	f
3289	Glentoran	Dungannon	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218123113	f
3282	Raith	Inverness CT	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217864300	f
3287	Motherwell	St Mirren	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637821	f
3280	Wealdstone	Altrincham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120901	f
3263	Wolfsburg	Union Berlin	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217641951	f
3438	Umraniyespor	Corum Belediyespor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218077913	f
3443	Cukaricki	Crvena Zvezda	2023-09-16 17:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218220574	f
3423	Arandina CF	UD Ourense	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250603	f
3439	AD Llerenense	Numancia	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252513	f
3431	Ruzomberok	FC Kosice	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217761933	f
3424	Real Aviles	RS Gimnastica	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251233	f
3427	Zemplin	Spartak Trnava	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217762039	f
3435	SSD Fiorentina WFC (W)	Sassuolo (W)	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218321945	f
3430	Karacabey Belediyespor AS	Adiyamanspor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218333683	f
3437	Kocaelispor	Boluspor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218077693	f
3433	Oleksandria	FC Minaj	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217921618	f
3434	Gagra	Dila Gori	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218321855	f
3422	CS Petrocub	Zimbru Chisinau	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218322035	f
3421	Zilina	DUKLA BANSKA BYSTRICA	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217761401	f
3425	Menemen Belediyespor	Etimesgut Belediyespor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218333868	f
3432	Inter	AC Milan	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672668	f
3442	Erokspor A.S	1461 Trabzon	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218333773	f
3440	Pardubice	Slavia Prague	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727470	f
3436	CD Covadonga	SD Compostela	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250783	f
3441	Haugesund	Viking	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668817	f
3426	Sandefjord	Stromsgodset	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668907	f
3444	Union St Gilloise	Genk	2023-09-16 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217902609	f
3453	Alcorcon	Levante	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217994392	f
3446	Celta Vigo	Mallorca	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217662123	f
3454	Vitesse Arnhem	RKC Waalwijk	2023-09-16 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217639226	f
3448	Carrarese	Pesaro	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218235833	f
3450	Club Atletico Saguntino	CF Badalona Futur	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218252239	f
3449	Kidderminster	Solihull Moors	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218120811	f
3451	Bochum	Eintracht Frankfurt	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217627668	f
3447	Recanatese	Lucchese	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218235081	f
3452	Valladolid	FC Cartagena	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217994284	f
3456	CD Ardoi	SD Lagunak	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327920	f
3474	Annecy	ESTAC Troyes	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007952	f
3467	Quevilly Rouen	Concarneau	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007505	f
3458	Dunkerque	Grenoble	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007772	f
3455	Auxerre	Pau	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007624	f
3468	Farense	Braga	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217912881	f
3478	Rijeka	Osijek	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217982859	f
3472	Madrid (W)	Barcelona (W)	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327609	f
3459	Galatasaray	Samsunspor	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218118029	f
3466	Tondela	Mafra	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218126141	f
3463	Valenciennes	Bordeaux	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007325	f
3465	Vozdovac	Mladost Lucani	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218220934	f
3471	Rodez	Angers	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007862	f
3460	Alcantarilla FC	Union Molinense CF	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329697	f
3457	Ludogorets	Botev Plovdiv	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217706792	f
3470	Bastia	Laval	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007415	f
3462	Paris FC	Amiens	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218008043	f
3469	Adana Demirspor	Pendikspor	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218113915	f
3464	FK Backa Topola	Zeleznicar Pancevo	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218227105	f
3473	Deportiva Venados	Inter Playa Del Carmen	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218324156	f
3475	St. Joseph's FC	Europa FC	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218334199	f
3477	OFK Petrovac	FK Jedinstvo Bijelo Polje	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218323886	f
3445	Newcastle	Brentford	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217633662	f
3476	Manchego Ciudad Real	CD Estepona	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218252698	f
3429	Molde	Odds BK	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668724	f
3485	Union Kleinmunchen (W)	FFC Vorderland (W)	2023-09-16 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218313935	f
3483	Real Madrid Castilla	Atletico Madrid II	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238586	f
3484	FK Mladost Donja Gorica	FK Arsenal Tivat	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218323976	f
3497	Fortuna Sittard	FC Volendam	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217639334	f
3502	FK Spartak	Vojvodina	2023-09-16 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218220844	f
3491	Odra Opole	Lechia Gdansk	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798333	f
3489	PSV	NEC Nijmegen	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217639442	f
3495	Piast Gliwice	Legia Warsaw	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217793923	f
3498	Newells	Union Santa Fe	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217818026	f
3500	Calor de San Pedro	Cimarrones de Sonora II	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218326889	f
3492	Deportivo Municipal	Universidad Cesar Vallejo	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190287	f
3531	Club Brugge	Charleroi	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217902717	f
3488	UD Torre del Mar	UD Ciudad de Torredonjimeno	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328461	f
3486	Athlone Town (W)	Peamount United (W)	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303771	f
3501	Al Ahli	Al-Taawoun Buraidah	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040034	f
3496	Mushuc Runa	Delfin	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030911	f
3490	Kfco Beerschot Wilrijk	Waasland-Beveren	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218125959	f
3493	Desp Brasil P LTDA U20	Ibrachina FC U20	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218326799	f
3494	Gremio Novorizontino U20	Oeste U20	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329960	f
3503	Olympic Safi	FUS Rabat	2023-09-16 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218327122	f
3518	Deportivo Merlo	Argentino de Merlo	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326075	f
3505	Jerv	Start	2023-09-16 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217885764	f
3516	CA Claypole	Sportivo Italiano	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326387	f
3508	Comunicaciones B Aires	Talleres (RE)	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218325985	f
3512	Deportivo Madryn	Villa Dalmine	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218210354	f
3507	Criciuma	Mirassol	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218082004	f
3520	CSD Yupanqui	Real Pilar FC	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218336244	f
3522	Defensores Unidos	Guillermo Brown	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218210711	f
3513	Flandria	Almagro BA	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218209994	f
3514	Canuelas	CS Dock Sud	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326165	f
3510	Deportivo Armenio	CA Fenix	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218325797	f
3519	Gimnasia de La Plata (W)	Estudiantes de la plata	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326709	f
3515	Los Andes	Sacachispas	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218325887	f
3521	CA Guemes	Nueva Chicago	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218209724	f
3511	Excursionistas	San Martin de Burzaco	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326477	f
3509	Universitatea Craiova	ACS Sepsi OSK	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217713274	f
3526	Entella	USD Sestri Levante 1919	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235534	f
3517	FK Mornar	FK Buducnost Podgorica	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326979	f
3506	Schalke 04	FC Magdeburg	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217695743	f
3530	Olbia	Sassari Torres	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235730	f
3529	Pescara	Arezzo	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218236035	f
3533	Sao Bernardo	EC Sao Jose Porto Alegre	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262395	f
3525	Sligo Rovers	UCD	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217934292	f
3523	Cardiff	Swansea	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217645685	f
3528	Sarajevo	Zrinjski	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218324066	f
3524	Gubbio	Fermana	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235444	f
3527	Genoa	Napoli	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217672788	f
3532	Mineros Guayana	Rayo Zuliano	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218308834	f
3535	Barcelona	Betis	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217661961	f
3534	Ferroviario	Ferroviaria	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328949	f
3536	Lens	Metz	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217913475	f
3487	FCV Dender	Lommel	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218126049	f
3482	Sturm Graz	Red Bull Salzburg	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217656156	f
3567	UD Logrones	CD Izarra	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253377	f
3568	Utebo CF	Barakaldo	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253060	f
3570	Naxara CD	UD Mutilvera	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253287	f
3571	Athletic Bilbao B	UD Barbastro	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253647	f
3574	CD Calahorra	Arenas Club de Getxo	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253557	f
3575	SD Gernika Club	CD Alaves B	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252103	f
3537	Vasco Da Gama	Fluminense	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217718603	f
3545	Vizela	Benfica	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912773	f
3539	Albacete	Burgos	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217994176	f
3550	AD Cariari Pococi	Municipal Turrialba	2023-09-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327301	f
3544	Union de Salamanca	Deportivo	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218233431	f
3541	Cordoba	Linares Deportivo	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238316	f
3542	Sabadell	SD Logrones	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218233538	f
3546	Malaga	Granada B	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238406	f
3549	San Lorenzo	Racing Club	2023-09-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217817936	f
3552	Tigres FC Zipaquira	Boca Juniors de Cali	2023-09-16 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218202769	f
3548	Botafogo SP	Atletico Go	2023-09-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217957963	f
3547	Sampaio Correa FC	Chapecoense	2023-09-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217957873	f
3553	Yous Berrechid	SCCM Chabab Mohamedia	2023-09-16 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218336514	f
3554	Tacuary	Libertad	2023-09-16 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218305456	f
3555	Almirante Brown	Estudiantes Rio Cuarto	2023-09-16 21:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218242156	f
3551	Guayaquil City	Deportivo Cuenca	2023-09-16 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218031001	f
3564	Deportivo Garcilaso	Cusco FC	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190107	f
3561	Santa Tecla	CD Dragon	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306773	f
3557	Amazonas FC	Volta Redonda	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262485	f
3562	Cavalry	Vancouver FC	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218199109	f
3556	Cibao FC	UNIVERSIDAD O&M	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336694	f
3565	Zamora FC	Metropolitanos	2023-09-16 22:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218308744	f
3560	Cucuta Deportivo	Real Cartagena	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218155517	f
3558	Arabe Unido	Atletico Chiriqui	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218309194	f
3559	Juventude	CRB	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218115272	f
3569	Aguacateros de Peribán F.C	Halcones de Zapopan	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339314	f
3577	Atl Tucuman	Barracas Central	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217822975	f
3572	Olancho	Lobos UPNFM	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295087	f
3573	Deportivo Mixco	Guastatoya	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275541	f
3576	Artesanos Metepec F.C.	Chilangos FC	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218338926	f
3578	Gavilanes Matamoros	Leones Negros Udg	2023-09-16 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218334894	f
3583	Miami FC	Pittsburgh Riverhounds	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218134489	f
3580	Necaxa	FC Juarez	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217717020	f
3582	Olimpia	Club General Caballero JLM	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218305366	f
3581	Escorpiones FC	Montaneses FC	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339132	f
3579	Deportivo Irapuato FC	CD Pioneros de Cancun	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339224	f
3584	El Nacional	Emelec	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030821	f
3589	Leones FC	Bogota	2023-09-17 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218155427	f
3587	Club Sporting Canamy	Reboceros de La Piedad	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336604	f
3586	Cafetaleros de Chiapas II	Tampico Madero	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334984	f
3585	Municipal Perez Zeledon	AD San Carlos	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306503	f
3590	Atletico Independiente	Alianza FC (Pan)	2023-09-17 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218309014	f
3594	Charlotte FC	DC Utd	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938855	f
3592	Philadelphia	FC Cincinnati	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938498	f
3593	Toronto FC	Vancouver Whitecaps	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938356	f
3540	Gimnasia Mendoza	CA Temperley	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209814	f
3563	Atlanta Utd	Inter Miami CF	2023-09-16 23:55:00	https://www.orbitxch.com/customer/sport/1/market/1.218305366	f
3591	CF Montreal	Chicago Fire	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938638	f
3371	Araz Nakhchivan PFK	Neftchi Baku	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262756	f
3635	FC Telavi	Dinamo Batumi	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218317356	f
3293	Corinthians U20	AA Portuguesa U20	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319318	f
3310	MSK Povazska Bystrica	FK Spisska Nova Ves	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228558	f
3370	Dacia Buiucani	FC Milsami-Ursidos	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320052	f
3683	Chippenham	Hungerford Town	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368477	f
3597	Atletico MG	Botafogo	2023-09-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217717491	f
3600	Santos de Guapiles	CS Herediano	2023-09-17 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218306413	f
3598	Talleres	Instituto	2023-09-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217822866	f
3596	Antigua GFC	CSD Municipal	2023-09-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275628	f
3601	Caracas	Universidad de Venezuela	2023-09-17 01:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218308654	f
3604	Houston Dynamo	St Louis City SC	2023-09-17 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940030	f
3607	Cd Fas	Once Municipal	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307557	f
3602	Minnesota Utd	Kansas City	2023-09-17 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217939922	f
3615	San Jose Earthquakes	Real Salt Lake	2023-09-17 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940246	f
3605	Monterrey	Leon	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217716750	f
3608	CD Motagua	CD Real Sociedad	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295267	f
3609	Venados FC	Celaya	2023-09-17 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218135413	f
3610	America de Cali S.A	Boyaca Chico	2023-09-17 02:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218347594	f
3612	Herrera FC	Plaza Amador	2023-09-17 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218308924	f
3614	LD Alajuelense	Puntarenas F.C.	2023-09-17 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306593	f
3611	Sporting Cristal	Universitario de Deportes	2023-09-17 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218190823	f
3613	Colorado	New England	2023-09-17 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940138	f
3616	Los Angeles FC	LA Galaxy	2023-09-17 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940355	f
3617	Tlaxcala F.C	Alebrijes de Oaxaca	2023-09-17 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218135503	f
3618	CF America	Guadalajara	2023-09-17 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217716930	f
3619	Gyeongnam	Jeonnam Dragons	2023-09-17 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217929019	f
3742	CF Epila	CD Belchite 97	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218362151	f
3740	Casalarreina CF	CDFC La Calzada	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218362061	f
3735	CE Constancia de Inca	CD Llosetense	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218361971	f
3750	AB	Fremad Amager	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218359102	f
3761	APLG Gdansk (W)	Rekord Bielsko-Biala (W)	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218361787	f
3752	FC Vilafranca	Reus	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362241	f
3756	Strommen	Alta	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218361877	f
3767	CD Padura	Leioa	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362421	f
3768	CD Roda	CD Acero	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362331	f
3413	Wisla Krakow	Chrobry Glogow	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217875054	f
3776	CD Union Sur Yaiza	UD Las Palmas II	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218362511	f
3777	HUSA Agadir	Moghreb Tetouan	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362601	f
3420	Olimpija	NK Maribor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001658	f
3428	Hamrun Spartans FC	Balzan FC	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218269114	f
3791	Vikingur Reykjavik	KA Akureyri	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362691	f
3461	Dinamo Tbilisi	Torpedo Kutaisi	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218317266	f
3825	Athletic Bilbao B	UD Barbastro	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253647	f
3479	Panaitolikos	Panathinaikos	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217680056	f
3856	Santos U20	EC Sao Bernardo U20	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362797	f
3864	Pumas UNAM (W)	Toluca (W)	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362887	f
3504	Gzira United FC	Paola Hibernians FC	2023-09-16 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218269024	f
3603	FC Dallas	Seattle Sounders	2023-09-17 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217939814	f
3901	Utebo CF	Barakaldo	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253060	f
3588	Inter de Queretaro FC	Club San Juan de Aragon	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339016	f
3599	Estudiantes de Caseros	Independiente Rivadavia	2023-09-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218210264	f
3538	Heracles	FC Utrecht	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217639550	f
4233	Shenyang Urban FC	Qingdao Youth Island	2023-09-17 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218344760	f
4234	Chungnam Asan	FC Anyang	2023-09-17 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217928743	f
4235	Sham Shui Po	Hong Kong FC	2023-09-17 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218344850	f
4236	Suwon Bluewings FC	Daegu FC	2023-09-17 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218392302	f
4237	Guangxi Lanhang	Beijing Tech FC	2023-09-17 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218345665	f
4238	Heilongjiang Lava Spring	Guangxi Baoyun	2023-09-17 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218364155	f
4239	Nantong Zhiyun F.C	Chengdu Rongcheng	2023-09-17 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218181471	f
4240	Madura Utd	Persebaya Surabaya	2023-09-17 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218345575	f
4241	Zizkov	MAS Taborsko	2023-09-17 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217975171	f
4242	FC Petrzalka	Malzenice	2023-09-17 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218229009	f
4243	SV Ried	Ksv 1919	2023-09-17 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217937120	f
4244	SK Sturm Graz II	Bregenz	2023-09-17 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217937211	f
4245	Samorin	Tatran Lip Mikulas	2023-09-17 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218228918	f
4246	Veertien Kuwana	ReinMeer Aomori	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352620	f
4247	Mgladbach U19	VfL Bochum U19	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348823	f
4248	Tegevajaro Miyazaki	Matsumoto	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218153050	f
4249	Fujieda MYFC	FC Machida	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218041699	f
4250	Kanazawa	Shimizu	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218041609	f
4251	FC La Union Atletico	San Roque Lepe	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284315	f
4252	CD Plus Ultra	Lorca Deportiva CF	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218392392	f
4253	AD Torrejon	Collado Villalba	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218392482	f
4254	Yokohama FC	Kashiwa	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217878661	f
4255	Bucheon FC 1995	Gimpo Citizen	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217928653	f
4256	Hunan Billows FC	Wuhan Jiangcheng	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218346737	f
4257	Tianjin Jinmen Tiger FC	Dalian Yifang	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218144179	f
4258	FC Ryukyu	Ehime	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218153141	f
4259	AD Parla	CD Leganes II	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218392572	f
4260	FE Grama	CFJ Mollerusa	2023-09-17 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218392662	f
4261	CD Siete Villas	CD Bezana	2023-09-17 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218392752	f
4262	UD Logrones	CD Izarra	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253377	f
4263	Real Madrid C	Trival Valderas Alcorcon	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393717	f
4264	FC Zhetysu	Kairat Almaty	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218179794	f
4265	CD Utrera	Ayamonte	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393266	f
4266	CF Montanesa	Rapitenca	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393086	f
4267	Huetor Vega CD	Atletico Malagueno	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393446	f
4268	RCD Mallorca II	CF Soller	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393537	f
4269	Aviles Stadium CF	UC Ceares	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218392842	f
4270	Posta Rangers	Sofapaka	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033542	f
4271	Cornella	CA Tarazona	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218234347	f
4272	Leonesa	CA Osasuna II	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218233249	f
4273	UD Montijo	CDA Navalcarnero	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218283861	f
4274	CF Pozuelo de Alarcon	FC Villanueva del Pardillo	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393807	f
4276	UDG Tenerife Sur (W)	Sporting de Huelva (W)	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218145532	f
4277	Pobla de Mafumet CF	Olot	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393897	f
4278	G-Osaka	Albirex Niigata	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217878815	f
4279	Oliveirense	Academico de Viseu	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218145717	f
4280	CDE Ursaria	SS Reyes	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218283951	f
4281	Albacete Balompie II	CD Azuqueca	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218392943	f
4282	CD Llanes	CD Praviano	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393356	f
4283	Levadia Tallinn II	Paide Linnameeskond II	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218347009	f
4284	Atletico Sanluqueno CF	Atletico Baleares	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218239106	f
4285	Ibiza Eivissa	Real Murcia	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218239472	f
4286	Melilla UD	Recreativo Huelva	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218239196	f
4287	CP San Cristobal	LHospitalet	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218394077	f
4288	Girona B	UE Vilassar de Mar	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393987	f
4289	Real Oviedo II	Valladolid B	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251143	f
4290	CD Teruel	Gimnastic	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218233069	f
4291	CDF Tres Cantos	Rayo Vallecano B	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393176	f
4292	Thespakusatsu Gunma	Iwaki SC	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015893	f
4293	Cacereno	Getafe B	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284041	f
4294	Olivenza	Don Benito	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393627	f
4295	Valencia-Mestalla	SE Penya Independent	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252834	f
4296	Feyenoord (W)	Fortuna Sittard (W)	2023-09-17 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218348646	f
4298	Silva SD	Polvorin FC	2023-09-17 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218394167	f
4299	Cagliari	Udinese	2023-09-17 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217672908	f
4300	Jagiellonia Bialystock	Radomiak Radom	2023-09-17 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217793833	f
4301	Nakhon Si United F.C.	Lampang FC	2023-09-17 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218361518	f
4302	Como FC (W)	Napoli Calcio (W)	2023-09-17 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218350588	f
4303	GKS Tychy	LKP Motor Lublin	2023-09-17 11:40:00	https://www.orbitxch.com/customer/sport/1/market/1.217798423	f
4304	SG E Frankfurt U19	Kaiserslautern U19	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384613	f
4305	CD Marino	CD Union Puerto	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218394387	f
4306	UD San Fernando	AD Union Adarve	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284131	f
4307	Durham (W)	London City Lionesses	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373593	f
4308	GAIS	Helsingborgs	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960471	f
4309	Reading (W)	Southampton (W)	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373503	f
4310	IK Uppsala (W)	Vittsjo (W)	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218350984	f
4311	Oddevold	Tvaakers	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218162725	f
4312	Viktoria Berlin	FC Eilenburg	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311908	f
4313	ISI Dangkor Senchey FC	Nagaworld FC	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372344	f
4314	Notodden	Brattvag	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334714	f
4315	Boeung Ket	Kirivong Sok Sen Chey	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218347414	f
4316	Visakha FC	Phnom Penh	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218347504	f
4317	Liepajas Metalurgs	Valmieras FK	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263461	f
4318	Chemie Leipzig	Berliner AK	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311818	f
4319	Sheffield United (W)	Lewes (W)	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373413	f
4320	Chonburi	Lamphun Warrior	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218152565	f
4321	Hansa Rostock II	Altglienicke	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312032	f
4322	Suphanburi	Chanthaburi FC	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218360725	f
4323	Alemannia Aachen U19	MSV Duisburg U19	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364245	f
4324	Millwall	Leeds	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645145	f
4325	TSV 1860 Munchen U19	FC Ingolstadt 04 U19	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374873	f
4326	Lorient	Monaco	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217677884	f
4327	Sotra SK	Baerum	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390575	f
4329	Jinan Xingzhou	Shanghai Jiading	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347993	f
4330	Hannover	VFL Osnabruck	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217688585	f
4331	Jiangxi Liansheng	Wuxi Wugou	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347813	f
4328	Deinze	Seraing Utd	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218229555	f
4334	Erzgebirge	Hallescher FC	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218145626	f
4335	Hertha Berlin	Braunschweig	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217688440	f
4336	Kieler SV Holstein II	SC Spelle Venhaus	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218311183	f
4337	SGB Kanchanaburi	Chainat Horn	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218361695	f
4338	Suzhou Dongwu	Dantong Hantong	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347903	f
4339	Chongqing Tonglianglong	Hubei Chufeng Heli	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218348083	f
4340	Sichuan Jiuniu FC	Yanbian Longding	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347723	f
4341	Spartans WFC (W)	Hamilton WFC (W)	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371413	f
4342	Sarmiento de Junin	Central Cordoba (SdE)	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217876183	f
4343	Gimnasia La Plata	Velez Sarsfield	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217817846	f
4344	Persik Kediri	Persija Jakarta	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348916	f
4345	Dnipro-1	Kolos Kovalyovka	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217924563	f
4346	Hegelmann Litauen	FC Dziugas	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229844	f
4348	Shakhter Karagandy	FK Kaisar	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218291317	f
4349	Nakhon Ratchasima	Krabi FC	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218361212	f
4350	TSV Schott Mainz	Hessen Kassel	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218395127	f
4351	Updf FC	Uganda Revenue Authority	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369063	f
4353	Amorebieta	Mirandes	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217994068	f
4354	FC Talanta	Muranga Seal	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033654	f
4355	Gor Mahia FC	Nairobi City Stars	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033744	f
4356	Druk Lhayul FC	Thimphu City	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373015	f
4357	Pusamania Borneo FC	PSS Sleman	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218349632	f
4358	Asteras Tripolis	PAS Giannina	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217680146	f
4359	Karlsruher SC U19	Nurnberg U19	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348736	f
4360	Samgurali Tskaltubo	FC Saburtalo Tbilisi	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348556	f
4361	Port FC	Prachuap	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218152753	f
4362	Samtredia	FC Shukura Kobuleti	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348466	f
4363	Getafe	Osasuna	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217661841	f
4364	Bodens	Motala	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218200887	f
4365	Wakiso Giants	Maroons FC	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368970	f
4366	FC Kariobangi Sharks	KCB	2023-09-17 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218033834	f
4367	Kuala Lumpur	Pahang	2023-09-17 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218384793	f
4368	Stjordals-Blink	Tromsdalen	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390485	f
4369	SC AUSTRIA LUSTENAU	WSG Wattens	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217656336	f
4370	Karbel Karakopru	Viven Bornova FK	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385963	f
4372	Bahir Dar FC	Club Africain	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218370024	f
4373	PFK Turan Tovuz	FK Qabala	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218262846	f
4376	Palmeiras U20	Agua Santa U20	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218389457	f
4377	Pontypridd Town (W)	The New Saints (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391073	f
4378	Aberystwyth Town (W)	Barry Town United (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372525	f
4379	United IK Nordic	Pitea	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218390893	f
4380	Clermont	Nantes	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217678124	f
4381	Bregalnica Stip	FK Struga Trim-Lum	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371130	f
4382	Watford (W)	Blackburn Rovers (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373142	f
4383	Widzew Lodz	Cracovia Krakow	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217794821	f
4384	Gadafi FC	Vipers SC	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372705	f
4385	NK Radomlje	Domzale	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001477	f
4386	Strasbourg	Montpellier	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217677621	f
4387	68 Aksaray Belediyespor	Amed Sportif Faaliyetler	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367465	f
4388	Frosinone	Sassuolo	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217673438	f
4389	Etincelles	Police FC	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218351256	f
4347	Vejle	Randers	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217896973	f
4352	Fredericia	FC Helsingor	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961474	f
4371	Hartberg	Austria Vienna	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217656246	f
4374	Excelsior	Almere City	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217639874	f
4375	FC Twente	Ajax	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217639766	f
4391	Kozani FC	Iraklis	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334804	f
4392	Mjondalen	Bryne	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885660	f
4393	Linkopings FC (W)	KIF Orebro Dff (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352180	f
4394	Moss	Skeid	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885858	f
4395	Keruleti	Diosgyori	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218388141	f
4396	FK Makedonija	FK Gostivar	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218390395	f
4397	AC Milan (W)	AS Roma (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218350498	f
4398	Cf Os Belenenses	Leiria	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218152459	f
4399	Tuzlaspor	Adanaspor	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218077602	f
4400	APR FC	Pyramids	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369932	f
4401	Arua Hill SC	Busoga United	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368879	f
4402	Giresunspor	Manisa FK	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218234991	f
4403	PAE Chania	Apollon Kalamaria FC	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374963	f
4404	Hammarby	Malmo FF	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217787525	f
4406	Djurgardens IF Dff (W)	BK Hacken (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218350894	f
4407	Asane	Hodd	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885557	f
4408	Fredrikstad	Sogndal	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885948	f
4410	FK Jablonec	Slovan Liberec	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727740	f
4411	Reims	Brest	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217678004	f
4412	Kvik Halden	Levanger	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276617	f
4413	Sunderland (W)	Crystal Palace (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373232	f
4414	Sundsvall	Utsiktens	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960381	f
4415	AC Monza	Lecce	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217673028	f
4416	PTE PEAC	Kaposvar	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218388051	f
4417	KuPS	VPS	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218150851	f
4418	MUZA FC	Diables Noirs	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218396067	f
4419	Singida Big Stars	Future FC	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369842	f
4420	Bremer SV	Drochtersen-Assel	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311093	f
4421	Duzcespor	Karaman Belediyespor	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352953	f
4422	Kongsvinger	Kristiansund	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885344	f
4423	FK Tukums 2000	SK Super Nova	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263281	f
4424	Zlin	Plzen	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727650	f
4425	SC Bruhl St Gallen	Lausanne	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375323	f
4426	Aurora Pro Patria 1919	Arzignanochiampo	2023-09-17 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218390305	f
4428	Iskenderunspor	Belediye Derincespor	2023-09-17 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218353044	f
4429	Hearts (W)	Partick Thistle (W)	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371322	f
4430	Real Sociedad III	Real Zaragoza II	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252970	f
4431	NK Brinje Grosuplje	NK Bilje	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270056	f
4432	Valur Reykjavik (W)	Hafnarfjordur (W)	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352000	f
4433	Sol De Mayo	Sansinena	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352440	f
4434	Nieciecza	Podbeskidzie B-B	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879406	f
4435	Oskarshamns AIK	Aatvidabergs FF	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218162635	f
4436	KF Erzeni	Dinamo Tirana	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375413	f
4437	Fola Esch	Swift Hesperange	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352726	f
4438	Fenerbahce	Antalyaspor	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944047	f
4439	Istanbulspor	Basaksehir	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217943939	f
4440	Bellinzona	Schaffhausen	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218376434	f
4441	Breidablik (W)	Stjarnan (W)	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352090	f
4442	Hvidovre	Lyngby	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217900922	f
4443	Hermannstadt	FC Voluntari	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217713814	f
4444	Cottbus	FSV Zwickau	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311728	f
4445	Gnistan	TPS	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218150381	f
4446	FK Radnicki 1923	FK Javor Ivanjica	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218220754	f
4449	Catanzaro	Parma	2023-09-17 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217959565	f
4409	Bournemouth	Chelsea	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634657	f
4427	FC Heidenheim	Werder Bremen	2023-09-17 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217642214	f
4447	Kortrijk	Anderlecht	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217902825	f
4448	Francs Borains	Lierse	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229267	f
4451	Villarreal	Almeria	2023-09-17 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217661720	f
4452	Eibar	Racing de Ferrol	2023-09-17 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217993365	f
4453	Arouca	Casa Pia	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912665	f
4454	Avenir S Marsa	CA Bizertin	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385243	f
4455	US Tataouine	Monastir	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385153	f
4456	Lynx FC	Lions Gibraltar	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218376299	f
4457	Varnsdorf	MFK Chrudim	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217975261	f
4458	ES Metlaoui	Club Sportif Sfaxien	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218352530	f
4459	Gil Vicente	Estoril Praia	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912557	f
4460	Waldhof Mannheim	SSV Ulm	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218152663	f
4463	Etar	Lokomotiv Plovdiv	2023-09-17 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217706973	f
4464	Riteriai	VMFD Zalgiris	2023-09-17 15:55:00	https://www.orbitxch.com/customer/sport/1/market/1.218229934	f
4465	IFK Stocksund	Dalkurd FF	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218390983	f
4466	Motherwell (W)	Hibernian (W)	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371503	f
4467	Naxara CD	UD Mutilvera	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253287	f
4468	Fk Novi Pazar	FK Napredak	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218220664	f
4469	Rosenborg	Bodo Glimt	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668371	f
4470	Pontevedra CF	UP Langreo	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250873	f
4471	Marbella	El Palo	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284406	f
4472	SD Rayo Cantabria	RC Villalbes	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251053	f
4474	Shabab Al Ordon	Ma'an	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218395458	f
4475	HNK Gorica	Hajduk Split	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217973231	f
4476	CD Badajoz	Guadalajara	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218289045	f
4477	Medeama SC	Horoya AC	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367735	f
4478	Tromso	Ham-Kam	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668551	f
4479	Marino Luanco	Deportivo La Coruna II	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251323	f
4480	Orebro	Skovde AIK	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960291	f
4481	EIF	HIFK	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218150471	f
4482	Jaro	KPV	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218150561	f
4483	Kifisias FC	Panserraikos	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217679785	f
4484	TuS BW Lohne	TSV Havelse	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311002	f
4485	Cerdanyola del Valles	CE Andratx	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218282737	f
4486	Al Arabi (Jor)	Al Sarhan	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364335	f
4487	Sarpsborg	Lillestrom	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668461	f
4488	Stabaek	Brann	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668281	f
4489	Marseille	Toulouse	2023-09-17 16:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217677764	f
4490	Aberdeen (W)	Celtic (W)	2023-09-17 16:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218371231	f
4491	Fiorenzuola	Albinoleffe	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390035	f
4492	Alessandria	Padova	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218389945	f
4493	LR Vicenza Virtus	Lumezzane	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390215	f
4494	CD Calahorra	Arenas Club de Getxo	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218253557	f
4496	SV Darmstadt	Mgladbach	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217643091	f
4497	Elfsborg	Kalmar FF	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217786775	f
4498	Hacken	Halmstads	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217786991	f
4499	Sestao River	Sociedad B	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218234257	f
4500	Qarabag Fk	FC Sabah	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218263026	f
4501	UD Alzira	Lleida	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218282375	f
4502	FC Legnago	SS Virtus Verona 1921	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390125	f
4503	Warta Poznan	Lech Poznan	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217794013	f
4504	AmaZulu	Cape Town CIty F.C.	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218203309	f
4505	Dunajska Streda	Slovan Bratislava	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217756085	f
4506	Deportivo Coatepeque	Malacateco	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275718	f
4507	Tudelano	AD San Juan	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253196	f
4508	SD Gernika Club	CD Alaves B	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252103	f
4509	Sampdoria (W)	Inter Milan (W)	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218350408	f
4462	Az Alkmaar	Sparta Rotterdam	2023-09-17 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217639982	f
4473	Rapid Vienna	Wolfsberger AC	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217656426	f
4495	Everton	Arsenal	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217635362	f
4511	Tabasalu JK	FC Tallinn	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218355964	f
4512	Balikesirspor	Catalcaspor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367555	f
4514	FC Cartagena II	Velez CF	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284768	f
4515	Sparta Prague	Slovacko	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727830	f
4516	Aguilas	Cadiz B	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284859	f
4517	CE Europa	UE Sant Andreu	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218288887	f
4518	Birkirkara	Sliema Wanderers FC	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268844	f
4519	Afjet Afyonspor	Zonguldakspor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387657	f
4520	Akhisar Belediye	Agri 1970 Spor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391163	f
4521	Arka Gdynia	Miedz Legnica	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798513	f
4522	Goztepe	Bandirmaspor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218079068	f
4523	CF Rayo Majadahonda	Celta Vigo B	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218234167	f
4524	Santa Lucia FC	Floriana	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268664	f
4525	Mersin Idman Yurdu	Serik Belediyespor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352862	f
4526	CSF Balti	CSF Spartanii	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218370710	f
4527	Karsiyaka	Amasyaspor 1968 FK	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218386406	f
4528	Fiorentina	Atalanta	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217673150	f
4529	Denizlispor	Arnavutkoy Belediyesi GVS	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387459	f
4530	Zlate Moravce	Trencin	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217789322	f
4531	Yeni Orduspor	Tarsus Idman Yurdu	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391269	f
4532	Otelul Galati	Rapid Bucharest	2023-09-17 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217713544	f
4533	Bnei Sakhnin	Hapoel Jerusalem	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218153648	f
4534	Una Strassen	Fc Differdange 03	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218364426	f
4535	Espanyol	Eldense	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993077	f
4537	Novara	A.C. Trento S.C.S.D.	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218231256	f
4538	Stade Malien de Bamako	Aigle Noir	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218369752	f
4539	Elche	Leganes	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993780	f
4540	Sevilla	Las Palmas	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217661600	f
4541	Maccabi Tel Aviv	Maccabi Bnei Raina	2023-09-17 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218153954	f
4542	Hapoel Haifa	FC Ashdod	2023-09-17 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218154044	f
4545	S Lucia Cotzumalguapa	Solola FC	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218396693	f
4544	OFK Mladost	FK Kom	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372434	f
4543	Aurora FC	Universidad San Carlos	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375503	f
4560	Betis B	Mar Menor CF	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284225	f
4559	Coruxo	CD Cayon	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250693	f
4550	Fylkir	IBV	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218155030	f
4546	Hercules	Torrent CF	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218282647	f
4548	Benfica B	Torreense	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218155697	f
4558	Maccabi Petach Tikva	Maccabi Haifa	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228098	f
4556	Terrassa	Espanyol B	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218282556	f
4554	Alanyaspor	Kasimpasa	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944371	f
4553	Granada (W)	Real Sociedad (W)	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218351165	f
4547	Guimaraes	Portimonense	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217912449	f
4552	CS Cartagines	Sporting San Jose FC	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306683	f
4551	Caja Oblatos C.FD	Zitacuaro CF	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218392122	f
4557	Zamora	Guijuelo	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250963	f
4549	Maccabi Netanya	Hapoel Petach Tikva	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228008	f
4555	Trabzonspor	Besiktas	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217943831	f
4564	Varazdin	NK Istra	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217995886	f
4562	Sint Truiden	Yellow-Red Mechelen	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217902966	f
4561	Valerenga	Aalesunds	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217668191	f
4568	Antequera CF	CD Castellon	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218240032	f
4567	Algeciras	Merida AD	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218240800	f
4566	Unterhaching	Saarbrucken	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218155607	f
4536	Oud-Heverlee Leuven	Gent	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217903728	f
4565	SL 16 FC	KV Oostende	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218230294	f
4618	Bordeaux (W)	Paris St-G (W)	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218349902	f
4574	PAOK	Aris	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217679875	f
4569	Lugo	Ponferradina	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218234077	f
4572	Aucas	Tecnico Universitario	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218030731	f
4571	Orihuela CF	UCAM Murcia	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218284496	f
4575	Radnicki Nis	FK IMT Novi Beograd	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218226925	f
4573	Glacis Utd	Mons Calpe SC	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218376208	f
4576	Partizan Belgrade	Radnik Surdulica	2023-09-17 18:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218220484	f
4578	Bonsucesso	Sao Cristovao	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218388933	f
4581	Belford Roxo Futebol Clube	AA Carapebus	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218389200	f
4580	Angra dos Reis EC	Acao RJ	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218389023	f
4579	EC Rio Sao Paulo	Barra Mansa	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218389547	f
4577	SE Buzios	Mageense FC	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218389110	f
4582	Siroki Brijeg	Zvijezda 09 Bijeljina	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218364516	f
4583	Borac Banja Luka	Nk Posusje	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218364606	f
4584	Achuapa FC	CSD Tellioz	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275808	f
4585	Atletico MG U20	Cruzeiro U20	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218389367	f
4588	Puebla FC (W)	Cruz Azul (W)	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364877	f
4590	CA Germinal	CA Liniers	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365507	f
4594	Ferro Carril Oeste GP	Huracan Las Heras	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365687	f
4586	Pumas UNAM	Atletico San Luis	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217717200	f
4593	Breidablik	Hafnarfjordur	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218123310	f
4589	Botafogo SP U20	Inter Limeira U20	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364787	f
4595	Brown de Adrogue	Chaco For Ever	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218210534	f
4591	Ciudad de Bolivar	Sportivo Penarol	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365327	f
4592	Valletta	Sirens FC	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268754	f
4587	CA Antoniano	Sevilla B	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284678	f
4598	Gimnasia Jujuy	Chacarita	2023-09-17 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218210174	f
4597	Mosta	Gudja United	2023-09-17 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218268934	f
4601	CA Atlas	CSD Liniers de Ciudad Evita	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365417	f
4604	Victoriano Arenas	Justo Jose de Urquiza	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218336334	f
4600	Olimpo	Circulo Deportivo Otamendi	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365777	f
4606	Deportivo Laferrere	General Lamadrid	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218336424	f
4599	CA Colegiales	Villa San Carlos	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365237	f
4603	CA Puerto Nuevo	Club Lujan	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365597	f
4602	Def Belgrano VR	Sportivo AC Las Parejas	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365867	f
4605	AEK Athens	Olympiakos	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217679966	f
4615	Avellino	Foggia	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218243754	f
4613	US Virtus Calcio	Crotone	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244872	f
4607	Catania	AZ Picerno ASD	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218243664	f
4616	Casertana	Benevento	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218270894	f
4612	Potenza	Monopoli	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244384	f
4610	Guarani	Tombense MG	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218029243	f
4608	Farul Constanta	FCSB	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217712854	f
4614	AP Turris Calcio	Sorrento	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244294	f
4624	Real Madrid	Real Sociedad	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217662288	f
4611	Roma	Empoli	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217673558	f
4623	Club Cipolletti	Villa Mitre	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368005	f
4620	Paysandu	Botafogo PB	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262575	f
5013	ZED FC	Ismaily	2023-09-19 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218481182	f
4622	Argentino Monte Maiz	Juventud Unida Universitari	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368095	f
4625	Boca Unidos	Crucero del Norte	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368362	f
4619	Alvarado	San Telmo	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218242426	f
4621	Levante UD (W)	Sevilla FC (W)	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218351075	f
4626	Sporting Gijon	Tenerife	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217992879	f
4609	Lyon	Le Havre	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217879827	f
4513	AGF	Brondby	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217904043	f
4684	Deportivo Coatepeque	Malacateco	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275718	f
4297	PEC Zwolle	Go Ahead Eagles	2023-09-17 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217639658	f
4332	Eupen	Standard	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217903620	f
4405	Vendsyssel FF	Naestved	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961294	f
4563	CSKA Sofia	CSKA 1948 Sofia	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217707337	f
4570	FK Decic	FK Sutjeska	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218364697	f
4596	Mas Maghrib A Fes	Raja Casablanca	2023-09-17 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218367645	f
4734	Koper	NK Celje	2023-09-17 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218001387	f
4753	Club Defensores de P	Club Atletico el Linqueno	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218389704	f
4763	CS Estudiantes San Luis	San Martin de Mendoza	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368185	f
4630	Valur	Stjarnan	2023-09-17 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218155787	f
4631	Sporting Lisbon	Moreirense	2023-09-17 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912233	f
4632	Patronato	San Martin de Tucuman	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218242246	f
4636	FC Midland	AD Berazategui	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367915	f
4634	Sol de America	Club Gimnasia y Tiro	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368275	f
4635	Independiente (Ecu)	Libertad FC	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030551	f
4637	Asociacion Deportiva Tarma	Sport Huancayo	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190648	f
4633	Godoy Cruz	Belgrano	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217957012	f
4638	Deportivo Moron	All Boys	2023-09-17 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218242336	f
4836	El Geish	National Bank	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384343	f
4639	IRT Tanger	Mouloudia dOujda	2023-09-17 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218369567	f
4640	CA Central Norte	Sarmiento de Resistencia	2023-09-17 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218369658	f
4641	Club Sportivo Ameliano	Resistencia FC	2023-09-17 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218305276	f
4643	Deportivo San Pedro	Juventud Copalera	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218390700	f
4642	Quilmes	Atletico Mitre	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218210084	f
4649	Costa del Este	UMECIT	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218309104	f
4650	CD Marathon	CD Olimpia	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294997	f
4647	EC Vitoria Salvador	Avai	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218126500	f
4648	Deportivo Tachira	Carabobo FC	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218308564	f
4645	CA Racing de Cordoba	Aldosivi	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218210621	f
4644	Santa Fe	Alianza Petrolera	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218349366	f
4651	CD Luis Angel Firpo	Platense Zacatecoluca	2023-09-17 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218308472	f
4652	Juventud Pinulteca FC	Barberena FC	2023-09-17 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218375593	f
4654	Jocoro	CD Aguila	2023-09-17 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218342537	f
4653	Atletico Rafaela	CD MAIPU	2023-09-17 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218209904	f
4656	9 de Julio Rafaela	CSg San Martin F	2023-09-17 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372921	f
4655	Brusque FC	Operario PR	2023-09-17 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262665	f
4657	River Plate	Arsenal De Sarandi	2023-09-17 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217822650	f
4658	Huehueteco Xinabajul	Xelaju	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299323	f
4659	Queretaro	Puebla	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217716840	f
4661	CF America (W)	Guadalajara (W)	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371960	f
4660	Vida	Real Espana	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295177	f
4663	Real Apodaca FC	Alacranes de Durango	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373683	f
4662	Barcelona (Ecu)	LDU	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030641	f
4664	Club Atletico Morelia	Tapatio	2023-09-18 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218162421	f
4665	Junior FC Barranquilla	Atletico Nacional Medelli	2023-09-18 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218348270	f
4666	Alianza Lima	Union Comercio	2023-09-18 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218190468	f
4667	Atletico Huila	Rionegro	2023-09-18 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348376	f
4670	Atlas	Tigres	2023-09-18 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217717380	f
4669	Genesis Huracan	CD Victoria	2023-09-18 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294906	f
4671	Club Leon FC (W)	Atletico San Luis (W)	2023-09-18 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.218372050	f
4672	Club Tijuana (W)	FC Atlas (W)	2023-09-18 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.218372140	f
4673	Deportivo Pasto	Tolima	2023-09-18 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218349276	f
4674	Mazatlan FC(W)	FC Juarez (W)	2023-09-18 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218372230	f
4668	Austin FC	Portland Timbers	2023-09-18 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217943124	f
4803	Puerto Cabello	Portuguesa FC	2023-09-18 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218406721	f
4812	Yokohama SCC	Grulla Morioka	2023-09-18 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218255366	f
4815	Transport United FC	Paro FC	2023-09-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218423669	f
4814	Crewe U21	Hull City U21	2023-09-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400380	f
4816	KL Rovers	PDRM	2023-09-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436958	f
4817	Gorilla FC	AS Kigali	2023-09-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406992	f
4818	Argeș Pitești	FC Unirea Dej	2023-09-18 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218307287	f
4822	Etihad Al Ramtha	Kaforsum	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218402793	f
4823	Mumbai City FC	Nassaji Mazandaran F.C.	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417708	f
4821	FK Jedinstvo Ub	FK Smederevo	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218407173	f
4820	Dynamo Kiev	Vorskla	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218407082	f
4819	Stromsgodset II	Ullensaker Kisa	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218420040	f
4825	Brann II	Ullern	2023-09-18 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218419950	f
4824	Hebar	Pirin Blagoevgrad	2023-09-18 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217706883	f
4826	KPV/Akatemia	SIF	2023-09-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429365	f
4829	Atromitos	NFC Volos	2023-09-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217680236	f
4827	Al-Jazeera	Samma	2023-09-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375233	f
4828	Al Buqaa	Alhashemyya	2023-09-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218403619	f
4830	CSMS Iasi	Botosani	2023-09-18 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217712955	f
4839	Al-Ittihad	Olmaliq	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218434141	f
4834	Al Faisaly SC	Nasaf	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417816	f
4832	Gornik Leczna	Resovia Rzeszow	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798603	f
4837	Sibenik	Cibalia Vinkovci	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218254477	f
4838	Al Quwa Al Jawiya	Sepahan	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218434231	f
4833	Hapoel Nof Hagalil	Hapoel K Saba	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218304593	f
4831	Jabal Al Mukaber	Al-Futowa	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218414040	f
4840	Nancy	Dijon	2023-09-18 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218224944	f
4841	Salernitana	Torino	2023-09-18 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217673678	f
4842	Beitar Nahariya	Hapoel Ironi Karmiel	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436138	f
4846	Sakaryaspor	Bodrumspor	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218079155	f
4850	Norrkoping	Mjallby	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217786883	f
4849	Jonkopings Sodra	Landskrona	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960201	f
4852	Klaksvikar Itrottarfelag	B68 Toftir	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406401	f
4847	Beitar Jerusalem	Hapoel Eran Hadera	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218203129	f
4853	Stal Mielec	Zaglebie Lubin	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217793383	f
4843	Traeff	Valerenga II	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218420130	f
4851	Sivasspor	Ankaragucu	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944263	f
4854	Fatih Karagumruk Istanbul	Hatayspor	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218113699	f
4848	OB	Silkeborg	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217901030	f
4844	Levski Krumovgrad	PFC Levski Sofia	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707153	f
4845	Osters	Vasteras SK	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217959930	f
4855	AIK	Degerfors	2023-09-18 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217786450	f
4856	Hapoel Beer Sheva	Hapoel Tel Aviv	2023-09-18 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218203039	f
4864	Ipswich Town U21	Birmingham U21	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429005	f
4859	Jong AZ Alkmaar	Jong Ajax Amsterdam	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204475	f
4863	Al-Sadd	Al Sharjah	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417492	f
4858	Emmen	Jong FC Utrecht	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204565	f
4867	Uni San Martin	Deportivo Coopsol	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218394477	f
4865	FC Groningen	Jong PSV Eindhoven	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204745	f
4862	Nejmeh	Al Riffa	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413950	f
4866	De Graafschap	Helmond Sport	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204835	f
4861	FC Oss	FC Dordrecht	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204385	f
4860	FC Eindhoven	ADO Den Haag	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204655	f
4813	Nakhon Pathom	Air Force Central	2023-09-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218413679	f
4902	Persijap Jepara	Persipa Pati	2023-09-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218457006	f
4919	Pachuca U23	Santos Laguna U23	2023-09-18 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218457555	f
4835	Maccabi Kabilio Jaffa	Ihud Bnei Shfaram	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218304683	f
4868	Al-Hilal	FK Navbahor Namangan	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417600	f
4869	K Lierse U21	KV Oostende (Res)	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218407527	f
4857	Ferroviaria DE U20	Red Bull Bragantino U20	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218407617	f
4872	Argentino de Quilmes	CA San Miguel	2023-09-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218407437	f
4870	Leandro N Alem	Central Cordoba	2023-09-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218407347	f
4871	CFR Cluj	ACS Petrolul 52	2023-09-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217713724	f
4873	Sampdoria	Cittadella	2023-09-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959745	f
4880	Taranto Sport	ACR Messina	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244114	f
4878	Audace Cerignola	Brindisi	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218243934	f
4879	Nuova Monterosi	US Latina Calcio	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244024	f
4875	Guingamp	AC Ajaccio	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218010763	f
4877	Crusaders	Cliftonville	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218270984	f
4874	Nottm Forest	Burnley	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217634374	f
4881	Verona	Bologna	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217673798	f
4876	FC Giugliano	Juve Stabia	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218243844	f
4882	Andorra CF	Oviedo	2023-09-18 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218029710	f
4884	Puerto Golfito F.C	A.D. Cofutpa	2023-09-18 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413770	f
4883	Granada	Girona	2023-09-18 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217661478	f
4885	Boavista	Chaves	2023-09-18 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217912341	f
4886	HK Kopavogur	Fram	2023-09-18 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218203219	f
4887	Envigado	Jaguares de Cordoba	2023-09-18 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218349096	f
4888	Union Magdalena	Once Caldas	2023-09-18 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218349542	f
4889	HFX Wanderers	Atletico Ottawa	2023-09-18 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218199019	f
4891	Lanus	Sarmiento de Junin	2023-09-19 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031631	f
4890	Bahia	Santos	2023-09-19 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218081692	f
4892	Sportivo Belgrano	Independiente Chivilcoy	2023-09-19 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218416564	f
4893	Atletico Bucaramanga	Deportivo Pereira	2023-09-19 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218349006	f
4895	Corinthians	Gremio	2023-09-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218084111	f
4896	Gualaceo SC	Cumbaya FC	2023-09-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031847	f
4894	Novorizontino	Ceara SC Fortaleza	2023-09-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218160532	f
4897	Ferro Carril Oeste	Tristan Suarez	2023-09-19 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218455937	f
4898	Ind Medellin	Millonarios	2023-09-19 02:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218349186	f
4900	Pachuca	Santos Laguna	2023-09-19 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217716660	f
4990	Bahrain U23	Thailand U23	2023-09-19 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218487393	f
4991	Bangladesh U23	Myanmar U23	2023-09-19 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218487483	f
4992	Shaoxing Shangyu Pterosaur	Weifang Juexiaoya	2023-09-19 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218441037	f
4993	Vietnam U23	Mongolia U23	2023-09-19 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218370615	f
4994	Yokohama FM	Incheon Utd	2023-09-19 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218467609	f
4995	Busan IPark	Ansan Greeners FC	2023-09-19 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218271074	f
4996	Ulsan Hyundai Horang-i	BG Pathumthani United	2023-09-19 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218472193	f
4997	Leixoes U23	Famalicao U23	2023-09-19 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450314	f
4998	Seongnam FC	Gimcheon Sangmu	2023-09-19 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218457097	f
4999	Cheongju FC	Seoul E-Land FC	2023-09-19 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218277159	f
5000	Hamburg II	Hannover II	2023-09-19 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369477	f
5001	Burnley U21	Sheff Wed U21	2023-09-19 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218452350	f
5002	Shakhtar U19	Porto U19	2023-09-19 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218479120	f
5003	Saudi Arabia U23	Iran U23	2023-09-19 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218487703	f
5004	Indonesia U23	Kyrgyzstan U23	2023-09-19 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218338400	f
5005	Kaya	Shandong Taishan	2023-09-19 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218471344	f
5006	Johor Darul Takzim	Kawasaki	2023-09-19 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218471469	f
5007	SS Lazio U19	Atletico Madrid U19	2023-09-19 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483186	f
5008	AC Milan U19	Newcastle United U19	2023-09-19 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218496939	f
5009	Kuching FA	Kedah	2023-09-19 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218497119	f
5010	Young Boys U19	RB Leipzig U19	2023-09-19 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218483891	f
5011	Pulau Pinang	Harini FC	2023-09-19 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497209	f
5012	Feyenoord Youth	Celtic U19	2023-09-19 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483796	f
5014	Sheff Utd U21	Fleetwood Town U21	2023-09-19 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218484377	f
5015	Paris St-G U19	Dortmund U19	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483284	f
5016	Gil Vicente U23	Vizela U23	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450070	f
5017	Barcelona U19	Royal Antwerp U19	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497029	f
5018	Pakhtakor	Al Ain	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218471559	f
5019	Academico de Viseu U23	Rio Ave FC U23	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218494823	f
5020	Man City U19	FK Crvena Zvezda U19	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218481270	f
5021	Portimonense SC U23	Santa Clara U23	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218494733	f
5022	FCM Avantul Reghin	ACS Industria Galda	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218495325	f
5023	Al Sareeh	Yarmouk	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483504	f
5024	Ceahlaul	Chindia Targoviste	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945142	f
5025	Sporting Lisbon U23	Mafra U23	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450176	f
5026	Estrela U23	GD Estoril Praia U23	2023-09-19 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218449575	f
5027	RZ Pellets WAC (Am)	SK Vorwarts Steyr	2023-09-19 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218475272	f
5028	Um El Quttein	Al Tora	2023-09-19 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483594	f
5029	Miedz II Legnica	Stal Rzeszow	2023-09-19 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218495415	f
5030	Istiqlol	Al-Duhail SC	2023-09-19 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461639	f
5031	Al Ahly Cairo	Al-Masry	2023-09-19 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384433	f
5032	Ahal FC	Al-Feiha	2023-09-19 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461819	f
5033	Fermana	Recanatese	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438673	f
5034	Pesaro	Entella	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438403	f
5035	Pergolettese	Triestina	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218436867	f
5036	Arezzo	Olbia	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438583	f
5037	Lucchese	Gubbio	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438313	f
5038	ASD Pineto Calcio	Rimini	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438493	f
5039	Young Boys	RB Leipzig	2023-09-19 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217866491	f
5040	AC Milan	Newcastle	2023-09-19 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217867901	f
5107	Man City	Crvena Zvezda	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867478	f
5041	Austria Wien (A)	SC Neusiedl am See	2023-09-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218472284	f
5042	Mainz II	Hoffenheim II	2023-09-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218467518	f
5043	HB Torshavn	Vikingur Gota	2023-09-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218457191	f
5044	Augsburg II	Bayreuth	2023-09-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218466512	f
5045	Ajax Cape Town	Golden Arrows	2023-09-19 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218391362	f
5046	Richards Bay FC	Chippa Utd	2023-09-19 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218384883	f
5047	Agovv Apeldoorn	OJC Rosmalen	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218484183	f
5048	RKAV Volendam	Westlandia	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488699	f
5049	GVVV	BVV Barendrecht	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488796	f
5050	RKVV DEM	Sportlust 46	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488609	f
5051	SV DVS 33 Ermelo	Ijsselmeervogels	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488420	f
5052	VV Eemdijk	Harkemase Boys	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218484091	f
5053	Spakenburg	V.V. Scherpenzeel	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488330	f
5054	Sparta Nijkerk	Unitas Gorinchem	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488518	f
5055	Norwich U21	Wolves U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218501068	f
5056	Olde Veste 54	Noordwijk	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497435	f
5057	Scheveningen	Hoek	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488238	f
5058	Shrewsbury	Brighton U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258446	f
5059	Al Wehdat	Al Ittihad Aleppo	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480534	f
5060	Alianza Atletico	Binacional	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218476015	f
5061	Charlton U21	Bournemouth U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218466115	f
5062	Persepolis	Al Nassr	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461729	f
5063	Wycombe	Crystal Palace U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258266	f
5064	Exeter	Reading	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296476	f
5065	Oxford Utd	MK Dons	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258356	f
5066	FC Cosmos Koblenz	FV Dudenhofen	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218457449	f
5070	Doncaster	Everton U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258536	f
5071	Wigan	Leicester U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258716	f
5072	Colchester	Tottenham U21	2023-09-19 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218258807	f
5073	Corinthian Casuals	Westfield	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218493254	f
5074	Sittingbourne	Hythe Town	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218493344	f
5075	Felixstowe & Walton Utd	Bowers & Pitsea	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218484469	f
5076	Sutton Utd	Aston Villa U21	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218259417	f
5077	Dag and Red	Bromley	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218268266	f
5079	Chesterfield	FC Halifax Town	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218266941	f
5080	Solihull Moors	AFC Fylde	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218266670	f
5081	Dorking Wanderers	Wealdstone	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267122	f
5082	Southampton	Ipswich	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884305	f
5085	Altrincham	Hartlepool	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267031	f
5086	Gateshead	Kidderminster	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267392	f
5087	Cesena	Ancona	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218438896	f
5088	Preston	Birmingham	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884629	f
5089	Woking	Ebbsfleet Utd	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218266580	f
5090	Juventus B	Spal	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218438986	f
5091	Cardiff	Coventry	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217883977	f
5092	Bristol Rovers	West Ham U21	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218296566	f
5093	Boreham Wood	Rochdale	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267483	f
5094	Port Vale	Burton Albion	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218258143	f
5095	QPR	Swansea	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884089	f
5096	Eastleigh	Oxford City	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267212	f
5097	Perugia	Pontedera	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218438806	f
5098	USD Sestri Levante 1919	Pescara	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218474614	f
5083	Barnsley	Portsmouth	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218303681	f
5084	Peterborough	Cheltenham	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218303591	f
5078	Barnet	Aldershot	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218266851	f
5102	Lazio	Atletico Madrid	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867055	f
5103	Shakhtar	Porto	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866068	f
5104	Feyenoord	Celtic	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867619	f
5105	Sheff Wed	Middlesbrough	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217884737	f
5106	Boyaca Patriotas	Orsomarso	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270614	f
5108	Paris St-G	Dortmund	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217868042	f
5109	Barcelona	Antwerp	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866773	f
5110	AD Cantolao	Melgar	2023-09-19 21:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218476105	f
5111	Nacional (Par)	Sportivo Luqueno	2023-09-19 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218493678	f
5112	AD Guanacasteca	LD Alajuelense	2023-09-19 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218455682	f
5113	Quindio	Llaneros FC	2023-09-19 22:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218346827	f
5114	Central Cordoba (SdE)	Boca Juniors	2023-09-19 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218029439	f
5115	Corinthians U20	Fluminense U20	2023-09-19 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218475925	f
5116	Celaya	Mineros de Zacatecas	2023-09-20 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218402088	f
5117	Barranquilla	Atletico FC Cali	2023-09-20 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218346917	f
5118	Tacuary	Sportivo Trinidense	2023-09-20 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218493588	f
5119	CD America de Quito	Manta FC	2023-09-20 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480894	f
5120	Rosario Central	CA Independiente	2023-09-20 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031451	f
5121	Huracan	Gimnasia La Plata	2023-09-20 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218029890	f
5122	America MG	Bragantino SP	2023-09-20 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218080222	f
5123	Sampaio Correa FC	Vila Nova	2023-09-20 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218218853	f
5124	Cancun FC	Cimarrones de Sonora	2023-09-20 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218491480	f
5125	La Equidad	Deportivo Cali	2023-09-20 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218370500	f
5126	Deportivo Saprissa	Santos de Guapiles	2023-09-20 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400470	f
5127	Alebrijes de Oaxaca	Club Atletico La Paz	2023-09-20 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218403709	f
5128	Stallion Penson FC	Bali Utd Pusam	2023-09-20 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505684	f
5129	Selangor II	Terengganu FC 2	2023-09-20 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218509102	f
5130	Galatasaray U19	FC Copenhagen U19	2023-09-20 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218514548	f
5131	Melbourne City	Kofu	2023-09-20 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504505	f
5132	Buriram Utd	Zhejiang Greentown	2023-09-20 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504006	f
5133	Jeonbuk Motors	Kitchee SC	2023-09-20 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503826	f
5134	FC Anyang	Gyeongnam	2023-09-20 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218277069	f
5135	Chungnam Asan	Jeonnam Dragons	2023-09-20 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218408150	f
5136	Cheonan City	Bucheon FC 1995	2023-09-20 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218415822	f
5137	Japan U23	Qatar U23	2023-09-20 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218487827	f
5138	Home Utd	Bangkok Utd	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504096	f
5139	Real Madrid U19	1. FC Union Berlin U19	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218524113	f
5140	Arsenal U19	PSV Eindhoven U19	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527342	f
5141	Wuhan Three Towns	Urawa	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504398	f
5142	Ha Noi T and T	Pohang Steelers	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503916	f
5143	Terengganu	Central Coast Mariners	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505774	f
5144	Sevilla U19	RC Lens U19	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218524293	f
5145	SL Benfica Lisbon U19	Red Bull Salzburg U19	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218513950	f
5146	Sloga Doboj	Zeljeznicar	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218517821	f
5147	Sporting de Braga U19	Napoli U19	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218524203	f
5148	El Daklyeh	ENPPI	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384523	f
5149	Nkana	MUZA FC	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218501158	f
5150	Zaglebie Lubin II	Kotwica Kolobrzeg	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500978	f
5151	Moslavina Kutina	Slaven Belupo	2023-09-20 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218523285	f
5152	TJ Sokol Medzibrod	Rimavska Sobota	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218525752	f
5153	Dravinja Kostroj	Tabor Sezana	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502568	f
5154	TJ Slovan Velvary	FC Sellier & Bellot Vlasim	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520174	f
5155	Ilirija Extra-Lux	Gorica	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502838	f
5156	NK Slovenska Bistrica	NK Fuzinar	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502748	f
5157	Bayern Munich U19	Man Utd U19	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218514458	f
5158	Lille	Olimpija	2023-09-20 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217930996	f
5159	TSV Schwaben Augsburg	TSV Landsberg	2023-09-20 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500598	f
5160	Isa Town FC	Malkiya	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503338	f
5161	Etihad Al Reef	Qalali	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503248	f
5162	Tallinna JK Legion	Tammeka Tartu	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218518001	f
5163	Young Africans	Namungo FC	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503671	f
5164	Smouha	El Gounah	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218518091	f
5165	Olimpia Elblag	Pogon Siedlce	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503581	f
5166	Dila Gori	Dinamo Batumi	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503158	f
5167	Krka	NK Primorje	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502968	f
5168	Union de Touarga	RSB Berkane	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503429	f
5169	Al Mokawloon	Baladeyet Al-Mahalla	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218518181	f
5170	KA Akureyri	Keflavik	2023-09-20 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218268356	f
5171	Lumezzane	Fiorenzuola	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438043	f
5172	Arzignanochiampo	Alessandria	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438133	f
5173	Guadalajara	SS Reyes	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218532054	f
5174	Leiknir R	Afturelding	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218505504	f
5175	Pro Vercelli	SSD Pro Sesto	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218437773	f
5176	Albinoleffe	Aurora Pro Patria 1919	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218474802	f
5177	Sassari Torres	Carrarese	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218480984	f
5178	A.C. Trento S.C.S.D.	FC Legnago	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438223	f
5179	IF Vestri	Fjolnir	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218505594	f
5180	Galatasaray	FC Copenhagen	2023-09-20 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217865927	f
5181	Real Madrid	Union Berlin	2023-09-20 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217867337	f
5182	Union Gurten	SPG Lask Amateure	2023-09-20 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515423	f
5183	Reutlingen	FV Ravensburg	2023-09-20 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505875	f
5184	SV Donaustrauf	DJK Ammerthal	2023-09-20 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500688	f
5185	TS Galaxy FC	Cape Town CIty F.C.	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218437049	f
5186	Supersport Utd	Kaizer Chiefs	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385063	f
5187	Orlando Pirates (SA)	Mamelodi Sundowns	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218437139	f
5188	SW Rehden	Atlas Delmenhorst	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218500058	f
5189	Waldalgesheim	SV Auersmacher	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218500508	f
5190	TuS Mechtersheim	Arminia Ludwigshafen	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218500148	f
5191	FC Kaiserslautern II	Eintracht Trier	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218500418	f
5192	Hoogeveen	Staphorst	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515918	f
5193	RKSV Nuenen	Excelsior Maassluis	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520444	f
5194	Ado '20	Quick Boys	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515828	f
5195	Kloetinge	Koninklijke HFC	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515738	f
5196	FC Lisse	Blauw Geel 38	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218516009	f
5197	SV TEC Tiel	SV Meerssen	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218516099	f
5198	ACV Assen	USV Hercules	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515648	f
5199	Groene Ster	Kozakken Boys	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218516279	f
5200	IA/Kari U19	Fylkir/Ellidi U19	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218509346	f
5201	VVSB	UNA Veldhoven	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218516189	f
5202	Spvgg Quierschied	FC Karbach	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500328	f
5203	SV Morlautern	FC Bitburg	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500238	f
5204	Achuapa FC	Antigua GFC	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218507287	f
5205	FC Luzern II	Rapperswil-Jona	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218507197	f
5206	Union Comercio	Carlos Mannucci	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480354	f
5207	FAR Rabat	Club R Zemamra	2023-09-20 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218509193	f
5208	Almagro BA	San Martin de San Juan	2023-09-20 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218049453	f
5209	New Salamis FC UK	Waltham Forest	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218517911	f
5211	SS Virtus Verona 1921	LR Vicenza Virtus	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218474708	f
5212	Padova	Novara	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218437953	f
5213	Blackburn	Sunderland	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884413	f
5214	Giana Erminio	Mantova	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218437863	f
5215	Huddersfield	Stoke	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217883745	f
5216	Renate	Atalanta B	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218493498	f
5217	Watford	West Brom	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884521	f
5218	Millwall	Rotherham	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217883637	f
5219	Norwich	Leicester	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217883529	f
5220	Barracas Central	Banfield	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218029349	f
5221	Arsenal	PSV	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866209	f
5222	Real Sociedad	Inter	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866632	f
5223	Benfica	Red Bull Salzburg	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866914	f
5224	Braga	Napoli	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866350	f
5225	Defensa y Justicia	Tigre	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031541	f
5226	Bayern Munich	Man Utd	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867196	f
5227	Sevilla	Lens	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867760	f
5228	Vikingur Reykjavik	KR Reykjavik	2023-09-20 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218275901	f
5229	Club Nueve de Octubre	Cuniburo FC	2023-09-20 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218509005	f
5230	Chacaritas SC	Imbabura Sporting Club	2023-09-20 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218508915	f
5231	Boca Juniors de Cali	Cucuta Deportivo	2023-09-20 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218394657	f
5232	UTC Cajamarca	Deportivo Municipal	2023-09-20 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218480714	f
5233	Fortaleza FC	Real Cartagena	2023-09-20 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218394567	f
5234	Real Santander	Tigres FC Zipaquira	2023-09-20 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218394747	f
5235	Cortulua	Leones FC	2023-09-20 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218396844	f
5236	Boyaca Chico	Junior FC Barranquilla	2023-09-20 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218494643	f
5237	Velez Sarsfield	Arsenal De Sarandi	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218031181	f
5238	Fuerte San Francisco	CD Dragon	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218510601	f
5239	Platense Zacatecoluca	Santa Tecla	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218510511	f
5240	Estudiantes	San Lorenzo	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218031361	f
5241	Once Municipal	CD Luis Angel Firpo	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218510421	f
5242	Goias	Flamengo	2023-09-20 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218081212	f
5243	Tlaxcala F.C	Club Atletico Morelia	2023-09-21 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218451380	f
5260	Fluminense	Cruzeiro MG	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218081572	f
5261	Guastatoya	CSD Municipal	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218524023	f
5264	Sao Paulo	Fortaleza EC	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218081332	f
5265	CD Municipal Limeno	Cd Fas	2023-09-21 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539766	f
5266	Correcaminos Uat	Universidad Guadalajara	2023-09-21 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218318493	f
5267	Atletico Nacional Medellin	Santa Fe	2023-09-21 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218506595	f
5268	Universitario de Deportes	Sport Boys (Per)	2023-09-21 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218480236	f
5269	Colorado	Seattle Sounders	2023-09-21 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293691	f
5271	AD Isidro Metapan	Jocoro	2023-09-21 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218525842	f
5272	CD Aguila	Alianza FC (SLV)	2023-09-21 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527563	f
5273	Real Espana	Olancho	2023-09-21 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218538822	f
5326	Rangers	Betis	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217881954	f
5274	CS Cartagines	Municipal Perez Zeledon	2023-09-21 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502168	f
5275	Queretaro	CF America	2023-09-21 03:06:00	https://www.orbitxch.com/customer/sport/1/market/1.217987504	f
5276	AD San Carlos	AD Municipal Liberia	2023-09-21 03:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218536986	f
5278	Comunicaciones	Xelaju	2023-09-21 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218527473	f
5246	Columbus	Chicago Fire	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285299	f
5247	CF Montreal	FC Cincinnati	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285389	f
5248	Inter Miami CF	Toronto FC	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285200	f
5249	Charlotte FC	Philadelphia	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285479	f
5251	New York Red Bulls	Austin FC	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293258	f
5259	Houston Dynamo	Vancouver Whitecaps	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293474	f
5262	Kansas City	Nashville SC	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293366	f
5263	St Louis City SC	Los Angeles FC	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218279850	f
5270	Real Salt Lake	FC Dallas	2023-09-21 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293583	f
5277	Portland Timbers	San Jose Earthquakes	2023-09-21 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293908	f
5279	LA Galaxy	Minnesota Utd	2023-09-21 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293800	f
5287	Union St Gilloise	Toulouse	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217882440	f
5286	Fenerbahce	FC Nordsjaelland	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930451	f
5283	HJK Helsinki	PAOK	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930559	f
5285	Sheriff Tiraspol	Roma	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217881056	f
5288	Legia Warsaw	Aston Villa	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930125	f
5284	Genk	Fiorentina	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217950103	f
5280	Ferencvaros	Cukaricki	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930777	f
5289	Zrinjski	Az Alkmaar	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217933067	f
5281	Qarabag Fk	Molde	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217883355	f
5290	Rennes	Maccabi Haifa	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217882200	f
5282	Panathinaikos	Villarreal	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884791	f
5304	Throttur Reykjavik/SR U19	HK/YMIR U19	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218553417	f
5293	Hapoel Herzliya	Maccabi Ashdod B.C.	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218553147	f
5294	Ludogorets	Spartak Trnava	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217891698	f
5295	Leverkusen	Hacken	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217880936	f
5296	Servette	Slavia Prague	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217881176	f
5291	Eintracht Frankfurt	Aberdeen	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930887	f
5302	Sport Huancayo	Deportivo Garcilaso	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480146	f
5303	Al-Ittihad	Al-Fateh (KSA)	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218317602	f
5300	Bahia EC U20	CSA U20	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218566258	f
5308	Rudar	NK Brinje Grosuplje	2023-09-21 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218555843	f
5310	Juve Stabia	Potenza	2023-09-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218501988	f
5307	Shimshon Tel Aviv	Hapoel Tzafririm Holon	2023-09-21 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218576259	f
5301	Al-Shabab (KSA)	Al-Hazm (KSA)	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218317692	f
5312	Monopoli	Catania	2023-09-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218502078	f
5306	KFUM U19	Nordstrand U19	2023-09-21 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218566709	f
5317	Lugano	Bodo Glimt	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217930342	f
5309	Crotone	Audace Cerignola	2023-09-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218474898	f
5311	AZ Picerno ASD	FC Giugliano	2023-09-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218475091	f
5319	Sturm Graz	Sporting Lisbon	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217883115	f
5313	Bogota	Real Soacha Cundinamarca FC	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218396934	f
5324	Maccabi Tel Aviv	Breidablik	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217930668	f
5321	West Ham	FK Backa Topola	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217882560	f
5315	Club Brugge	Besiktas	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217969602	f
5318	Wydad Casablanca	CC Riadi Salmi	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218553327	f
5331	Comerciantes FC	Alianza Universidad	2023-09-21 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218546505	f
5330	Cruzeiro U20	Sampaio Correa U20	2023-09-21 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218566348	f
5316	Slovan Bratislava	Klaksvikar Itrottarfelag	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217891590	f
5320	Zorya	Gent	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217949995	f
5333	Cusco FC	Atletico Grau	2023-09-21 21:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218480804	f
5323	Ajax	Marseille	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217883235	f
5314	Plzen	KF Ballkani	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217891482	f
5332	Belgrano	CA Platense	2023-09-21 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138787	f
5327	Olympiakos	Freiburg	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217882680	f
5322	Dinamo Zagreb	FC Astana	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217930234	f
5329	Sparta Prague	Aris FC Limassol	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217882862	f
5336	Vasco Da Gama	Coritiba	2023-09-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218086654	f
5337	Argentinos Juniors	Talleres	2023-09-21 23:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218208471	f
5335	Union Santa Fe	Godoy Cruz	2023-09-21 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218208561	f
5338	Athletico-PR	Internacional	2023-09-21 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218080972	f
5341	Atletico Bucaramanga	Deportivo Pasto	2023-09-22 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218512122	f
5342	USA (W)	South Africa (W)	2023-09-22 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218596022	f
5343	Lobos UPNFM	CD Marathon	2023-09-22 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218563750	f
5346	Gremio	SE Palmeiras	2023-09-22 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218081812	f
5345	River Plate	Atl Tucuman	2023-09-22 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218211629	f
5344	CD Vargas Torres	Macara	2023-09-22 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564261	f
5348	Universidad Cesar Vallejo	Sporting Cristal	2023-09-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480444	f
5347	CD Real Sociedad	Vida	2023-09-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218563570	f
5349	Millonarios	Atletico Huila	2023-09-22 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218515328	f
5334	Deportivo Pereira	Union Magdalena	2023-09-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218512212	f
5292	LASK Linz	Liverpool	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217882320	f
5305	Fredrikstad U19	Kongsvinger U19	2023-09-21 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218566619	f
5297	Hermannstadt	FCSB	2023-09-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218439415	f
5298	Al Aqaba	Al Hussein	2023-09-21 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218553237	f
5680	Shimshon Kfar Qasem	Maccabi Shaaraim	2023-09-22 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585356	f
5681	Project Veng FC	Venghnuai	2023-09-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218602943	f
5682	Hapoel Kiryat Ono	Sporting Tel Aviv	2023-09-22 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218614352	f
5683	Farense U23	Santa Clara U23	2023-09-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218605163	f
5684	Changwon City	Siheung Citizen	2023-09-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550443	f
5685	Elimai FC	Khan Tengry	2023-09-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630427	f
5686	Hapoel Tirat HaCarmel	Hapoel Qalansawe	2023-09-22 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218614442	f
5687	Ironi Beit Dagan	Tzeirey Tira FC	2023-09-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614622	f
5688	Sderot FC	FC Shikhun HaMizrah	2023-09-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614532	f
5689	FC Astana U21	FK Akzhajik	2023-09-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630247	f
5690	MS Bnei Jaffa Ortodoxim	HaMakhtesh Givatayim	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614712	f
5691	Ahi Acre	Hapoel Ironi Karmiel	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614802	f
5692	Qatar U23	Palestine U23	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218556747	f
5693	Japan (W)	Bangladesh (W)	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218630607	f
5694	Hong Kong U23	Uzbekistan U23	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218546325	f
5695	MSK Kiryat Yam	Ironi Nesher	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218589520	f
5696	Hapoel Bueine	Hapoel Bnei Zalafa	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218585176	f
5697	Hapoel Kaukab	Hapoel Migdal HaEmek	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218585266	f
5698	Ironi Baka El Garbiya	Maccabi Nujeidat Ahmad	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218589430	f
5699	Maccabi Kiryat Malakhi	Hapoel Kfar Shelem	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218607965	f
5700	Changchun Yatai	Beijing Guoan	2023-09-22 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218337688	f
5701	Shanghai Shenhua	Cangzhou Mighty Lions	2023-09-22 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218370466	f
5702	Hapoel Raanana	MS Tira	2023-09-22 12:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218589610	f
5703	Ironi Bnei Kabul	Maccabi Bnei Abu Snan	2023-09-22 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218614892	f
5704	Hapoel Marmorek	AS Nordia Jerusalem	2023-09-22 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218589880	f
5705	Tzeirey Umm al-Fahm	Maccabi Tzur Shalom	2023-09-22 12:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218589752	f
5706	Maccabi Neve Shaanan Eldad	Ihud Bnei Baqa	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218614982	f
5707	Thimphu City	Ugyen Academy	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595258	f
5708	Maccabi Ahi Iksal	Hapoel Bnei Fureidis FC	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218615072	f
5709	Botev Vratsa	Beroe Stara Za	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032117	f
5710	Trat	Port FC	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569596	f
5711	Psis Semarang	PS Barito Putera	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218584666	f
5712	Persita Tangerang	Dewa United FC	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218584756	f
5713	Hapoel Azor	Hapoel Hod HaSharon	2023-09-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218615162	f
5714	KF Tirana	KF Erzeni	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585639	f
5715	Uganda Revenue Authority	Gadafi FC	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218603937	f
5716	Peterborough United U21	Birmingham U21	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590930	f
5717	CSC 1599 Selimbar	Gloria Buzau	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539946	f
5718	Airtel Kitara FC	Updf FC	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218604494	f
5719	NEC FC	Busoga United	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630824	f
5720	ACS Viitorul Cluj	CF Metalurgistul Cugir	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218619033	f
5721	KP Legia Warsaw II	Unia Skierniewice	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218616970	f
5722	CSM Deva	ACS Viitorul Simian	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618550	f
5723	ACS Tg. Mures 1898	FCM Avantul Reghin	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618640	f
5724	Ghiroda si Giarmata Vii	CS Uni Craiova II	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618460	f
5725	ACS Inainte Modelu	Agricola Borcea	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618280	f
5726	Garbarnia	Karpaty Krosno	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218616880	f
5727	NK Dugopolje	NK Solin	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569686	f
5728	Gilortul Targu Carbunesti	Jiul Petrosani	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618940	f
5729	FK Nevezis	BFA Vilnius	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590210	f
5730	CS Avantul Periam	Politehnica Timisoara	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618370	f
5731	Indija	OFK Beograd	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591020	f
5732	Csm Focsani	ACS Unirea Branistea	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618730	f
5733	Dunarea Calarasi	CS Axiopolis Cernavoda	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618820	f
5734	Radnik Surdulica	Radnicki Nis	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575381	f
5821	KAC 1909	Kottmannsdorf	2023-09-22 18:09:00	https://www.orbitxch.com/customer/sport/1/market/1.218590300	f
5735	Paide Linnameeskond II	Nomme Utd	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590750	f
5737	SK Kvítkovice	Unicov	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218595168	f
5738	CSKA 1948 Sofia	Cherno More	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218032495	f
5739	MAS Taborsko	Pribram	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218340549	f
5740	Hyderabad FC	FC Goa	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218340458	f
5741	Tzeirey Tamra	Maccabi Ahva Shaab	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218615469	f
5742	Honka	VPS	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218431194	f
5743	Unia Swarzedz	Gedania Gdansk	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218617302	f
5745	KTP	Ilves	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342717	f
5746	CS Constantine	MC Alger	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585729	f
5747	ES Ben Aknoun	ASO Chlef	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585925	f
5748	Al Riyadh SC	Al-Feiha	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520821	f
5749	Al-Akhdoud	Al-Khaleej Saihat	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218388228	f
5750	Lahti	AC Oulu	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218226725	f
5751	FC U Craiova 1948	Otelul Galati	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218257624	f
5752	FK Kolin	FK Prepere	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590660	f
5753	Wisla Pulawy	KKS Lech Poznan II	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591110	f
5754	FK Dainava Alytus	Riteriai	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527744	f
5755	ES Setif U21	MC El Bayadh U21	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218545442	f
5756	MC Oran U21	JS Saoura U21	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590570	f
5757	Domzale	NK Aluminij	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218344390	f
5758	SJK 2	TPS	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218429905	f
5759	HIFK	Gnistan	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218435699	f
5760	Moghayer Al Sarhan	Al-Jalil	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218591200	f
5761	FC Kosice	Trencin	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218142209	f
5762	IFK Mariehamn	Haka	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218226834	f
5763	SV Gerasdorf Stammersdorf	Red Star Penzing	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608935	f
5771	Al Hidd	Al-Muharraq	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591800	f
5764	Kraig	St Jakob Ros	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590390	f
5773	Al-Shabbab (BRN)	Manama Club	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591890	f
5769	Dinamo Tirana	Partizani Tirana	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585549	f
5775	Oleksandria	Chernomorets Odesa	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218386562	f
5768	Korona Kielce	Widzew Lodz	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303117	f
5770	Podbeskidzie B-B	Gornik Leczna	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400753	f
5772	PPJ	PKK-U	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591670	f
5767	Usti Nad Labem	FK Teplice B	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592175	f
5765	Osijek	Varazdin	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343935	f
5774	Miedz Legnica	Odra Opole	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400903	f
5766	SK Hranice	Csk Uhersky Brod	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592085	f
5777	SKU Amstetten	SV Lafnitz	2023-09-22 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218341505	f
5778	SV Stripfing/Weiden	Ksv 1919	2023-09-22 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218341454	f
5779	DSV Leoben	Floridsdorfer Ac	2023-09-22 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218341364	f
5784	Wurzburger Kickers	Burghausen	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218555026	f
5782	FC Magdeburg	Paderborn	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217942908	f
5780	SV Schwechat	Slovan Hutteldorfer AC	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218609025	f
5781	VFL Osnabruck	Hamburger SV	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217942800	f
5783	Salernitana	Frosinone	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218025035	f
5785	Tallinna FC Flora	Tallinna Kalev	2023-09-22 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218429275	f
5786	SC Kalsdorf	FSC Eggendorf Hartberg II	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218609317	f
5790	Salzburger AK 1914	SK Adnet	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218609411	f
5789	Stade Briochin	Beauvais	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595667	f
5788	Kematen	SV Worgl	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218609116	f
5794	IK Brage	Orebro	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314868	f
5787	SC Furstenfeld	SV Wildon	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218609214	f
5791	Helsingborgs	AFC Eskilstuna	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314958	f
5811	Bayern Munich II	Illertissen	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218555663	f
5810	ASV Drassburg	Kremser SC	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595438	f
5800	Babelsberg	FSV 63 Luckenwalde	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559681	f
5817	Homburg	FC Astoria Walldorf	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564713	f
5812	Sirens FC	Mosta	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529687	f
5801	SV Meppen	TuS BW Lohne	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559967	f
5816	Gaziantep FK	Istanbulspor	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218189424	f
5806	1. CfR Pforzheim	FSV 08 Bissingen	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585446	f
5813	Roskilde	HIK Hellerup	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218596547	f
5798	Boluspor	Tuzlaspor	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429815	f
5814	Kolubara Lazarevac	RFK Novi Sad	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218594458	f
5808	Botev Plovdiv	CSKA Sofia	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032297	f
5818	SV Steinbach	TSV Lehnerz	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565790	f
5819	TSG Balingen	SGV Freiberg	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565880	f
5795	IFK Hassleholm	IFK Malmo	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218596762	f
5815	Oddevold	Ljungskile	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364967	f
5809	Atlantis FC/Akatemia	FC Kiffen	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591490	f
5796	CD Avance Ezcabarte	UCD Burlades	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218619123	f
5820	Kickers Offenbach	Stuttgart II	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564579	f
5803	Eyupspor	Umraniyespor	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218494913	f
5822	Parndorf	SC Ritzing	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218609624	f
5841	TUS Bovinghausen 04	SpVgg Erkenschwick	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218586832	f
5846	Al Ahli Amman	Al Faisaly SC	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218603159	f
5840	TuRa Harksheide	SC Victoria Hamburg	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218590120	f
5824	Mgladbach II	SC Paderborn 07 II	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218565169	f
5829	FC Wil	Neuchatel Xamax	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218200978	f
5842	AS Eupen (Res)	RWD Molenbeek U21	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218594988	f
5825	Dijon	Cholet SO	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347234	f
5831	Marignane-Gignac	Niort	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347144	f
5833	Pena Sport	SD Lagunak	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218619213	f
5845	Orleans	Chateauroux	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218349722	f
5843	GOAL FC	Le Mans	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218561922	f
5830	Karlskrona	Kristianstads	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218524707	f
5847	Ratingen 04/19	TSV Meerbusch	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218586919	f
5844	Wuppertaler	SC Wiedenbruck	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218565079	f
5838	FSV Zwickau	Chemie Leipzig	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218559779	f
5832	Schaffhausen	Sion	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218142389	f
5848	Vatanspor	Blumenthaler	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218586742	f
5828	Bellinzona	FC Vaduz	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218142299	f
5836	Vanersborgs IF	Ahlafors IF	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218367825	f
5827	Red Star	Avranches	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347324	f
5835	KMSK Deinze U21	Lommel SK U21	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218594805	f
5839	KV Oostende (Res)	FCV Dender EH U21	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218594898	f
5837	Epinal	Martigues	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218466205	f
5826	Nimes	Nancy	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218349812	f
5834	Versailles 78 FC	Villefranche Beaujolais	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218344496	f
5850	NAC Breda	Emmen	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504278	f
5851	Zulte-Waregem	Deinze	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612042	f
5852	EC Sao Bernardo U20	Red Bull Bragantino U20	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612471	f
5849	Reading U21	Leeds United U21	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218598794	f
5862	Kecskemeti	Mezokovesd-Zsory	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218181216	f
5870	Jong FC Utrecht	Cambuur Leeuwarden	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504704	f
5855	Helmond Sport	FC Groningen	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504794	f
5860	Al Nassr	Al Ahli	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218345776	f
5869	Patro Eisden Maasmechelen	FCV Dender	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612132	f
5865	Dinamo Bucharest	Farul Constanta	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218257928	f
5868	Man City U21	Chelsea U21	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599064	f
5856	West Ham U21	Southampton U21	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218598974	f
5861	Al-Wahda (KSA)	Abha	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218428209	f
5864	Zeleznicar Pancevo	Partizan Belgrade	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575561	f
5867	FC Dordrecht	Jong AZ Alkmaar	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504885	t
5857	Siroki Brijeg	Sarajevo	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595348	f
5872	Kabylie	Paradou	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585819	f
5894	Standard	Westerlo	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218224506	t
5859	Jong PSV Eindhoven	VVV Venlo	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505065	f
5854	Marisca Mersch	UN Kaerjeng 97	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218602853	f
5873	Westerlo (Res)	Kortrijk (Res)	2023-09-22 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218594368	f
5874	Thun	Aarau	2023-09-22 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218142479	f
5878	Deportivo Espanol	CA Claypole	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218595901	f
5875	LKS Lodz	Jagiellonia Bialystock	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218303477	f
5877	Palermo	Cosenza	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218132552	f
5876	Lechia Gdansk	GKS Katowice	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218401227	f
5879	Stuttgart	SV Darmstadt	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217880470	f
5893	Treaty United	Athlone Town	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218345030	f
5882	Kerry FC	Galway Utd	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218345210	f
5896	Newry	Dungannon	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218386652	f
5880	Longford	Waterford	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218345120	f
5886	St Patricks	Dundalk	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218184913	f
5888	Sligo Rovers	Derry City	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218185003	f
5883	Wexford F.C	Bray Wanderers	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218345300	f
5887	Drogheda	Bohemians	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218152911	f
5890	Glentoran	Coleraine	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218386742	f
5891	Queens Park	Ayr	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218349992	f
5895	Cardiff Metropolitan	The New Saints	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218534857	f
5884	Larne	Carrick Rangers	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218387102	f
5881	Cobh Ramblers	Finn Harps	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218344940	f
5889	UCD	Shamrock Rovers	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218184823	f
5892	Lecce	Genoa	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218024914	f
5899	Admira Wacker	St Polten	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218341595	f
5903	Huracan Las Heras	CS Estudiantes San Luis	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218610972	f
5898	FC Cartagena	Eibar	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218278692	f
5900	Corinthians U20	Palmeiras U20	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218597503	f
5897	Aberystwyth	Penybont FC	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218535037	f
5904	Birmingham	QPR	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381570	f
5901	Alaves	Athletic Bilbao	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217927622	f
5905	Famalicao	Arouca	2023-09-22 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218391953	f
5908	AD Carmelita	Marineros de Puntarenas FC	2023-09-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599154	f
5907	Arucas CF	UD Tamaraceite	2023-09-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218619303	f
5906	PFA Antioquia FC	AD Barrio Mexico	2023-09-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608177	f
6052	FC La Chaux-De-Fonds	FC Vevey	2023-09-22 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218638981	f
6056	Itaberai U20	Vila Nova U20	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636909	f
6057	ASC Korneuburg	USC Rohrbach	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636729	f
6059	Cerrado U20	Vianopolis U20	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636999	f
6061	Csd Rangers	Santiago Morning	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218637720	f
5885	Shelbourne	Cork City	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218185093	f
6093	Universidad de Concepcion	Deportes Temuco	2023-09-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637630	f
5915	CD Poza Rica	Chilpancingo	2023-09-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218623554	f
5914	Inter Playa Del Carmen	Deportivo Irapuato FC	2023-09-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218622425	f
5916	Corinthians	Botafogo	2023-09-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218081452	f
5917	Coquimbo Unido	OHiggins	2023-09-23 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218010578	f
5919	Estudiantes de Merida	Zamora FC	2023-09-23 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218600346	f
5918	Once Caldas	La Equidad	2023-09-23 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218515202	f
6104	Guairena	Cerro Porteno	2023-09-23 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643287	f
5920	LDU	Orense Sporting Club	2023-09-23 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218440947	f
5921	Independiente Rivadavia	Atletico Rafaela	2023-09-23 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218492140	f
5924	San Martin de Mendoza	Argentino Monte Maiz	2023-09-23 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218611717	f
5923	Atletico Go	Criciuma	2023-09-23 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218316675	f
5928	Plaza Amador	Atletico Independiente	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218580089	f
5902	Monaco	Nice	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217964781	t
5927	Atletico San Luis	Mazatlan FC	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988227	f
5926	Atletico Saltillo	Calor de San Pedro	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608267	f
5929	Petroleros de Salamanca	CD Pioneros de Cancun	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218622515	f
6115	FC Juarez	Atlas	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988318	f
5931	Deportivo Cali	Ind Medellin	2023-09-23 02:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218521709	f
5932	Alacranes de Durango	Coras de Nayarit FC	2023-09-23 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218620158	f
5933	Japan (W)	Argentina (W)	2023-09-23 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502658	f
5934	Puebla	Pumas UNAM	2023-09-23 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217988137	f
5935	Briobecca Urayasu SC	Criacao Shinjuku	2023-09-23 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529056	f
5936	Seongnam FC	Cheongju FC	2023-09-23 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218514277	f
5792	B93 Copenhagen	Hobro	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369296	t
5799	Kolding IF	Fredericia	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369386	t
5804	AaB	HB Koge	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369206	t
5853	Willem II	FC Oss	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504614	t
5863	Go Ahead Eagles	Fortuna Sittard	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217938963	t
\.


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 204
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 122, true);


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 207
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 1024, true);


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 205
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 1326, true);


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 209
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 8149, true);


--
-- TOC entry 2894 (class 2606 OID 16547)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 2898 (class 2606 OID 17073)
-- Name: over2p5footballsupertips over2p5footballsupertips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips
    ADD CONSTRAINT over2p5footballsupertips_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 2896 (class 2606 OID 17069)
-- Name: over2p5goalsnow over2p5goalsnow_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow
    ADD CONSTRAINT over2p5goalsnow_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 2900 (class 2606 OID 17077)
-- Name: over2p5orbitxch over2p5orbitxch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch
    ADD CONSTRAINT over2p5orbitxch_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE over2p5footballsupertips; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5footballsupertips FROM postgres;
GRANT ALL ON TABLE public.over2p5footballsupertips TO postgres WITH GRANT OPTION;


--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE footballsupertips_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.footballsupertips_today FROM postgres;
GRANT ALL ON TABLE public.footballsupertips_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE over2p5goalsnow; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5goalsnow FROM postgres;
GRANT ALL ON TABLE public.over2p5goalsnow TO postgres WITH GRANT OPTION;


--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE goalsnow_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.goalsnow_today FROM postgres;
GRANT ALL ON TABLE public.goalsnow_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE over2p5orbitxch; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5orbitxch FROM postgres;
GRANT ALL ON TABLE public.over2p5orbitxch TO postgres WITH GRANT OPTION;


--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE orbitxch_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.orbitxch_today FROM postgres;
GRANT ALL ON TABLE public.orbitxch_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE "TodayMatches"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodayMatches" FROM postgres;
GRANT ALL ON TABLE public."TodayMatches" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodaysBets" FROM postgres;
GRANT ALL ON TABLE public."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 1741 (class 826 OID 16567)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


-- Completed on 2023-09-24 23:19:55 BST

--
-- PostgreSQL database dump complete
--

