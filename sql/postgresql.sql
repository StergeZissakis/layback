--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-29 21:54:00 BST

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
-- TOC entry 3055 (class 1262 OID 13465)
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
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 3055
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3057 (class 0 OID 0)
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
-- TOC entry 2547 (class 3456 OID 17065)
-- Name: match_team_names_collation; Type: COLLATION; Schema: public; Owner: -
--

CREATE COLLATION public.match_team_names_collation (provider = icu, deterministic = false, locale = 'und');


--
-- TOC entry 1 (class 3079 OID 16584)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 551 (class 1247 OID 16385)
-- Name: ActionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ActionType" AS ENUM (
    'Lay',
    'Back'
);


--
-- TOC entry 554 (class 1247 OID 16390)
-- Name: BetResult; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BetResult" AS ENUM (
    'Won',
    'Lost',
    'Lapsed'
);


--
-- TOC entry 645 (class 1247 OID 16404)
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
-- TOC entry 213 (class 1259 OID 25377)
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
-- TOC entry 212 (class 1259 OID 25373)
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
    plaied boolean DEFAULT false NOT NULL,
    ht_goals smallint,
    ft_goals smallint,
    league_id smallint
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
    over2p5orbitxch.plaied,
    over2p5orbitxch.ht_goals,
    over2p5orbitxch.ft_goals
   FROM public.over2p5orbitxch
  WHERE ((over2p5orbitxch.date_time)::date >= CURRENT_DATE)
  ORDER BY over2p5orbitxch.date_time, over2p5orbitxch.id;


--
-- TOC entry 214 (class 1259 OID 25381)
-- Name: TodayMatches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."TodayMatches" AS
 SELECT c.id,
    c.home,
    c.away,
    c.date_time,
    c.url,
    c.plaied,
    b.league_id,
    c.ht_goals,
    c.ft_goals
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
-- TOC entry 215 (class 1259 OID 25413)
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
    a."BetId",
    a."BetResult",
    a."BetResultTime" AS "BetMatchTime"
   FROM public.over2p5bets a
  WHERE ((a."BetDateTime")::date >= CURRENT_DATE)
  ORDER BY a."BetDateTime", a.id;


--
-- TOC entry 216 (class 1259 OID 25418)
-- Name: YesterdaysBets; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."YesterdaysBets" AS
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
    a."BetId",
    a."BetResult",
    a."BetResultTime" AS "BetMatchTime"
   FROM public.over2p5bets a
  WHERE (((a."BetDateTime")::date >= (CURRENT_DATE - '1 day'::interval)) AND ((a."BetDateTime")::date < CURRENT_DATE))
  ORDER BY a."BetDateTime", a.id;


--
-- TOC entry 217 (class 1259 OID 25423)
-- Name: YesterdaysMatches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."YesterdaysMatches" AS
 SELECT c.id,
    c.home,
    c.away,
    c.date_time,
    c.url,
    c.plaied,
    b.league_id,
    c.ht_goals,
    c.ft_goals
   FROM ((public.over2p5goalsnow a
     JOIN public.over2p5footballsupertips b ON ((((a.league_id = b.league_id) AND (a.date_time = b.date_time) AND (lower((a.home)::text) ~~ lower((b.home)::text))) OR (lower((a.away)::text) ~~ lower((b.away)::text)))))
     JOIN public.over2p5orbitxch c ON ((((b.date_time = c.date_time) AND (lower((b.home)::text) ~~ lower((c.home)::text))) OR (lower((b.away)::text) ~~ lower((c.away)::text)))))
  WHERE ((c.date_time >= (CURRENT_DATE - '1 day'::interval)) AND (c.date_time < CURRENT_DATE))
  ORDER BY c.date_time, c.id, c.url;


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
-- TOC entry 3070 (class 0 OID 0)
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
-- TOC entry 3071 (class 0 OID 0)
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
-- TOC entry 3072 (class 0 OID 0)
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
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 209
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5orbitxch_id_seq OWNED BY public.over2p5orbitxch.id;


--
-- TOC entry 2896 (class 2604 OID 16906)
-- Name: over2p5bets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets ALTER COLUMN id SET DEFAULT nextval('public.over2p5bets_id_seq'::regclass);


--
-- TOC entry 2898 (class 2604 OID 17018)
-- Name: over2p5footballsupertips id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips ALTER COLUMN id SET DEFAULT nextval('public.over2p5footballsupertips_id_seq'::regclass);


--
-- TOC entry 2897 (class 2604 OID 17007)
-- Name: over2p5goalsnow id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow ALTER COLUMN id SET DEFAULT nextval('public.over2p5goalsnow_id_seq'::regclass);


--
-- TOC entry 2900 (class 2604 OID 17029)
-- Name: over2p5orbitxch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch ALTER COLUMN id SET DEFAULT nextval('public.over2p5orbitxch_id_seq'::regclass);


--
-- TOC entry 3042 (class 0 OID 16493)
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
123	2023-09-25 00:30:00	Orlando City	Inter Miami CF	2023-09-25 01:57:02.406792	Lay	Under	2.50	1.50	1.72	5	\N	\N	\N
124	2023-09-25 18:00:00	Varnamo	Sirius	2023-09-25 19:12:01.570014	Lay	Under	1.50	1.50	1.62	5	\N	\N	\N
125	2023-09-25 18:00:00	FC Nordsjaelland	Hvidovre	2023-09-25 19:12:39.208005	Lay	Under	1.50	1.50	2.02	5	\N	\N	\N
126	2023-09-25 18:00:00	Halmstads	Elfsborg	2023-09-25 19:13:40.800437	Lay	Under	1.50	1.50	1.49	5	\N	\N	\N
127	2023-09-27 17:30:00	Verona	Atalanta	2023-09-27 18:52:54.579107	Lay	Under	2.50	1.50	1.26	5	\N	\N	\N
128	2023-09-27 18:00:00	Villarreal	Girona	2023-09-27 19:06:11.420903	Lay	Under	1.50	1.50	1.99	5	\N	\N	\N
129	2023-09-27 19:30:00	St Gallen	Young Boys	2023-09-27 20:34:23.829096	Lay	Under	1.50	1.50	2.22	5	\N	\N	\N
130	2023-09-27 19:30:00	Servette	Winterthur	2023-09-27 20:34:23.988291	Lay	Under	2.50	1.50	2.30	5	\N	\N	\N
131	2023-09-27 19:30:00	Lugano	Lausanne	2023-09-27 20:36:24.705886	Lay	Under	2.50	1.50	1.94	5	\N	\N	\N
132	2023-09-27 19:45:00	Antwerp	Gent	2023-09-27 20:51:12.180306	Lay	Under	1.50	1.50	1.68	5	\N	\N	\N
133	2023-09-27 19:45:00	Inter	Sassuolo	2023-09-27 20:53:51.772042	Lay	Under	2.50	1.50	2.38	5	\N	\N	\N
134	2023-09-27 19:45:00	Antwerp	Gent	2023-09-27 20:53:54.068535	Lay	Under	1.50	1.50	1.67	5	\N	\N	\N
135	2023-09-27 19:45:00	Inter	Sassuolo	2023-09-27 20:55:58.316829	Lay	Under	2.50	1.50	2.30	5	\N	\N	\N
136	2023-09-27 19:45:00	Antwerp	Gent	2023-09-27 20:55:59.079237	Lay	Under	1.50	1.50	1.63	5	\N	\N	\N
137	2023-09-27 19:45:00	Inter	Sassuolo	2023-09-27 20:57:31.931739	Lay	Under	2.50	1.50	2.28	5	\N	\N	\N
138	2023-09-27 19:45:00	Antwerp	Gent	2023-09-27 20:57:39.463119	Lay	Under	1.50	1.50	1.57	5	\N	\N	\N
139	2023-09-27 19:45:00	Inter	Sassuolo	2023-09-27 20:59:07.688609	Lay	Under	2.50	1.50	2.22	5	\N	\N	\N
140	2023-09-27 19:45:00	Antwerp	Gent	2023-09-27 20:59:11.058351	Lay	Under	1.50	1.50	1.53	5	\N	\N	\N
141	2023-09-28 17:30:00	Frosinone	Fiorentina	2023-09-28 18:35:55.722569	Lay	Under	2.50	1.50	2.02	5	\N	\N	\N
142	2023-09-28 17:30:00	Frosinone	Fiorentina	2023-09-28 19:12:21.835023	Back	Under	2.50	1.50	1.52	5	\N	\N	\N
143	2023-09-28 19:00:00	AZ Alkmaar	Heracles	2023-09-28 20:03:56.039721	Lay	Under	2.50	1.50	2.34	5	\N	\N	\N
144	2023-09-28 19:30:00	Stade Lausanne-Ouchy	Yverdon Sport	2023-09-28 20:39:07.906744	Lay	Under	2.50	1.50	1.97	5	\N	\N	\N
145	2023-09-28 19:45:00	Club Brugge	Genk	2023-09-28 20:53:21.551234	Lay	Under	2.50	1.50	2.52	5	\N	\N	\N
146	2023-09-28 19:30:00	Stade Lausanne-Ouchy	Yverdon Sport	2023-09-28 21:08:28.769018	Back	Under	2.50	1.14	1.14	5	\N	\N	\N
147	2023-09-28 20:30:00	Osasuna	Atletico Madrid	2023-09-28 21:35:27.24274	Lay	Under	2.50	1.50	1.53	6	\N	\N	\N
148	2023-09-28 20:30:00	Osasuna	Atletico Madrid	2023-09-28 22:01:51.530741	Back	Under	2.50	1.12	1.12	6	\N	\N	\N
149	2023-09-29 17:30:00	Hamburger SV	Fortuna Dusseldorf	2023-09-29 18:33:57.694009	Lay	Under	1.50	1.50	2.32	6	\N	\N	\N
150	2023-09-29 17:30:00	Paderborn	Schalke 04	2023-09-29 18:34:10.080595	Lay	Under	2.50	1.50	2.14	6	\N	\N	\N
151	2023-09-29 18:00:00	Hillerod Fodbold	AC Horsens	2023-09-29 19:03:03.996725	Lay	Under	1.50	1.50	1.79	6	\N	\N	\N
152	2023-09-29 19:00:00	Deinze	Waasland-Beveren	2023-09-29 20:03:05.735729	Lay	Under	1.50	1.50	2.22	6	\N	\N	\N
153	2023-09-29 19:00:00	FC Groningen	Den Bosch	2023-09-29 20:03:54.813335	Lay	Under	1.50	1.50	2.22	6	\N	\N	\N
154	2023-09-29 19:00:00	Jong AZ Alkmaar	Willem II	2023-09-29 20:09:15.576058	Lay	Under	2.50	1.50	1.78	6	\N	\N	\N
155	2023-09-29 19:45:00	Kortrijk	Cercle Brugge	2023-09-29 20:49:03.687489	Lay	Under	1.50	1.50	2.04	6	\N	\N	\N
156	2023-09-29 20:00:00	Barcelona	Sevilla	2023-09-29 21:04:41.023066	Lay	Under	1.50	1.50	2.22	6	\N	\N	\N
157	2023-09-29 20:00:00	Strasbourg	Lens	2023-09-29 21:07:22	Lay	Under	2.50	1.50	1.54	6	\N	2023-09-29 21:09:09.15752	123046300
158	2023-09-29 20:15:00	Benfica	Porto	2023-09-29 21:28:18	Lay	Under	1.50	1.50	1.99	6	\N	2023-09-29 21:43:18.028975	123048747
\.


--
-- TOC entry 3047 (class 0 OID 17015)
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
1059	AD Grecia	AD San Carlos	2023-09-25 22:00:00	\N	\N
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
1061	Deportivo Cuenca	Barcelona Guayaquil	2023-09-25 01:00:00	\N	\N
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
1025	FC Nordsjaelland	Hvidovre IF	2023-09-25 18:00:00	\N	40
1026	Coventry	Huddersfield	2023-09-25 20:00:00	\N	77
1027	Ajax Reserves	FC Eindhoven	2023-09-25 19:00:00	\N	199
1028	Sporting	Rio Ave	2023-09-25 20:15:00	\N	8
1029	Halmstad	Elfsborg	2023-09-25 18:00:00	\N	14
1030	IFK Varnamo	Sirius	2023-09-25 18:00:00	\N	14
1023	Orlando City SC	Inter Miami CF	2023-09-25 00:30:00	\N	76
1024	Austin FC	LA Galaxy	2023-09-25 02:30:00	\N	76
1049	Banfield	River Plate	2023-09-25 01:00:00	\N	\N
1050	Sarmiento	Belgrano	2023-09-25 20:00:00	\N	\N
1051	CA Platense	Union Santa Fe	2023-09-25 20:00:00	\N	\N
1052	Colon	Argentinos Jrs	2023-09-25 22:30:00	\N	\N
1053	Godoy Cruz	Racing Club	2023-09-25 22:30:00	\N	\N
1054	Audax Italiano	Union La Calera	2023-09-25 00:00:00	\N	\N
1055	Independiente Santa Fe	Deportivo Pereira	2023-09-25 00:10:00	\N	\N
1056	Junior	Deportes Tolima	2023-09-25 02:20:00	\N	\N
1057	La Equidad	Jaguares de Cordoba	2023-09-25 22:15:00	\N	\N
1058	Sporting San Jose	Deportivo Saprissa	2023-09-25 01:00:00	\N	\N
1063	Panathinaikos	AEK Athens	2023-09-25 19:00:00	\N	\N
1064	East Bengal Club	Jamshedpur FC	2023-09-25 15:30:00	\N	\N
1065	Santos Laguna	Necaxa	2023-09-25 03:05:00	\N	\N
1066	JS Soualem	OC Safi	2023-09-25 17:00:00	\N	\N
1067	Mouloudia Oujda	FAR Rabat	2023-09-25 19:15:00	\N	\N
1069	Sportivo Ameliano	Sportivo Trinidense	2023-09-25 01:00:00	\N	\N
1070	Deportivo Garcilaso	Cienciano	2023-09-25 01:30:00	\N	\N
1071	Deportivo Municipal	Cusco FC	2023-09-25 19:00:00	\N	\N
1072	Atletico Grau	Sport Huancayo	2023-09-25 21:00:00	\N	\N
1074	Bohemians Dublin	Shelbourne	2023-09-25 19:45:00	\N	\N
1075	Dundalk	Cork City	2023-09-25 19:45:00	\N	\N
1076	St Patricks Athletic	Drogheda United	2023-09-25 19:45:00	\N	\N
1077	Rapid Bucuresti	CFR Cluj	2023-09-25 19:00:00	\N	\N
1078	Racing Ferrol	Real Zaragoza	2023-09-25 20:00:00	\N	\N
1079	Tenerife	Espanyol	2023-09-25 20:00:00	\N	\N
1082	Hatayspor	Trabzonspor	2023-09-25 18:00:00	\N	\N
1083	Altay	Bodrumspor	2023-09-25 18:00:00	\N	\N
1086	Atlético Tucumán	Arsenal de Sarandi	2023-09-26 01:00:00	\N	\N
1087	CA Talleres de Córdoba	Barracas Central	2023-09-26 01:00:00	\N	\N
1088	America MG	Vasco da Gama	2023-09-26 00:00:00	\N	\N
1089	Alianza Petrolera	Once Caldas	2023-09-26 00:25:00	\N	\N
1090	Independiente Medellin	Atletico Bucaramanga	2023-09-26 02:35:00	\N	\N
1091	Libertad FC	El Nacional	2023-09-26 01:00:00	\N	\N
1092	Sporting Cristal	UTC Cajamarca	2023-09-26 02:00:00	\N	\N
1130	Real Madrid	Las Palmas	2023-09-27 18:00:00	\N	3
1131	AFC Eskilstuna	Västerås SK FK	2023-09-27 18:00:00	\N	336
1132	Skövde AIK	Landskrona	2023-09-27 18:00:00	\N	336
1133	Osters IF	Helsingborg	2023-09-27 18:00:00	\N	336
1134	Ostersunds FK	IK Brage	2023-09-27 18:00:00	\N	336
1135	Lugano	Lausanne Sports	2023-09-27 19:30:00	\N	15
1136	Servette	Winterthur	2023-09-27 19:30:00	\N	15
1137	St Gallen	Young Boys	2023-09-27 19:30:00	\N	15
1209	Deinze	SK Beveren	2023-09-29 19:00:00	\N	136
1093	Lille	Reims	2023-09-26 20:00:00	\N	5
1094	Sevilla	Almeria	2023-09-26 18:00:00	\N	3
1095	Mallorca	Barcelona	2023-09-26 20:30:00	\N	3
1096	FC Zurich	Grasshoppers	2023-09-26 19:30:00	\N	15
1178	RWD Molenbeek	Union Saint Gilloise	2023-09-28 17:30:00	\N	68
1179	Club Brugge	Genk	2023-09-28 19:45:00	\N	68
1180	Frosinone	Fiorentina	2023-09-28 17:30:00	\N	4
1181	AZ	Heracles	2023-09-28 19:00:00	\N	196
1121	Antwerp	Gent	2023-09-27 19:45:00	\N	68
1122	Empoli	Salernitana	2023-09-27 17:30:00	\N	4
1123	Verona	Atalanta	2023-09-27 17:30:00	\N	4
1124	Inter Milan	Sassuolo	2023-09-27 19:45:00	\N	4
1125	Napoli	Udinese	2023-09-27 19:45:00	\N	4
1126	PSV	Go Ahead Eagles	2023-09-27 17:45:00	\N	196
1127	FC Twente	Vitesse	2023-09-27 19:00:00	\N	196
1128	Hodd	Sandnes Ulf	2023-09-27 17:00:00	\N	204
1129	Villarreal	Girona	2023-09-27 18:00:00	\N	3
1182	Estrela Amadora	Braga	2023-09-28 20:15:00	\N	8
1183	Granada	Real Betis	2023-09-28 18:00:00	\N	3
1184	Osasuna	Atletico Madrid	2023-09-28 20:30:00	\N	3
1185	Orgryte IS	GAIS	2023-09-28 18:00:00	\N	336
1186	Orebro SK	Utsiktens BK	2023-09-28 18:00:00	\N	336
1187	Trelleborgs FF	Jonkopings Sodra	2023-09-28 18:00:00	\N	336
1188	GIF Sundsvall	Gefle IF	2023-09-28 18:00:00	\N	336
1189	Basel	Lucerne	2023-09-28 19:30:00	\N	15
1190	Stade Lausanne-Ouchy	Yverdon Sport FC	2023-09-28 19:30:00	\N	15
1138	Philadelphia Union	FC Dallas	2023-09-28 00:30:00	\N	76
1139	Colorado Rapids	Vancouver Whitecaps	2023-09-28 02:30:00	\N	76
1208	KV Kortrijk	Cercle Brugge	2023-09-29 19:45:00	\N	68
1210	Hillerød	AC Horsens	2023-09-29 18:00:00	\N	147
1211	Vendsyssel FF	AaB	2023-09-29 18:00:00	\N	147
1212	Sheff Wed	Sunderland	2023-09-29 20:00:00	\N	77
1213	Strasbourg	Lens	2023-09-29 20:00:00	\N	5
1214	TSG Hoffenheim	Borussia Dortmund	2023-09-29 19:30:00	\N	1
1215	Hamburg	Fortuna Dusseldorf	2023-09-29 17:30:00	\N	93
1216	Paderborn	Schalke	2023-09-29 17:30:00	\N	93
1217	Kawasaki Frontale	Albirex Niigata	2023-09-29 11:00:00	\N	28
1218	Yokohama F-Marinos	Vissel Kobe	2023-09-29 11:00:00	\N	28
1219	Cambuur Leeuwarden	PSV Reserves	2023-09-29 19:00:00	\N	199
1220	Maastricht	ADO Den Haag	2023-09-29 19:00:00	\N	199
1221	FC Groningen	FC Den Bosch	2023-09-29 19:00:00	\N	199
1222	FC Eindhoven	FC Dordrecht	2023-09-29 19:00:00	\N	199
1223	Top Oss	FC Emmen	2023-09-29 19:00:00	\N	199
1228	Consadole Sapporo	Kashiwa Reysol	2023-09-30 05:00:00	\N	28
1224	Telstar	Ajax Reserves	2023-09-29 19:00:00	\N	199
1225	AZ Reserves	Willem II	2023-09-29 19:00:00	\N	199
1226	Benfica	FC Porto	2023-09-29 20:15:00	\N	8
1227	Barcelona	Sevilla	2023-09-29 20:00:00	\N	3
\.


--
-- TOC entry 3045 (class 0 OID 17004)
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
1365	Junior	Deportes Tolima	2023-09-25 02:20:00	\N	\N
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
1328	FC Nordsjaelland	Hvidovre IF	2023-09-25 18:00:00	\N	40
1331	Halmstad	Elfsborg	2023-09-25 18:00:00	\N	14
1332	IFK Varnamo	Sirius	2023-09-25 18:00:00	\N	14
1325	Orlando City SC	Inter Miami CF	2023-09-25 00:30:00	\N	76
1326	Austin FC	LA Galaxy	2023-09-25 02:30:00	\N	76
1329	Ajax Reserves	FC Eindhoven	2023-09-25 19:00:00	\N	199
1330	Sporting	Rio Ave	2023-09-25 20:15:00	\N	8
1327	Coventry	Huddersfield	2023-09-25 20:00:00	\N	77
1354	Racing Ferrol	Real Zaragoza	2023-09-25 20:00:00	\N	\N
1355	Tenerife	Espanyol	2023-09-25 20:00:00	\N	\N
1356	Banfield	River Plate	2023-09-25 01:00:00	\N	\N
1357	Sarmiento	Belgrano	2023-09-25 20:00:00	\N	\N
1358	CA Platense	Union Santa Fe	2023-09-25 20:00:00	\N	\N
1359	Colon	Argentinos Jrs	2023-09-25 22:30:00	\N	\N
1360	Godoy Cruz	Racing Club	2023-09-25 22:30:00	\N	\N
1361	Deportivo Maipu	Deportivo Madryn	2023-09-25 19:30:00	\N	\N
1362	Palestine U23	Japan U23	2023-09-25 12:30:00	\N	\N
1363	Audax Italiano	Union La Calera	2023-09-25 00:00:00	\N	\N
1364	Independiente Santa Fe	Deportivo Pereira	2023-09-25 00:10:00	\N	\N
1366	La Equidad	Jaguares de Cordoba	2023-09-25 22:15:00	\N	\N
1367	Sporting San Jose	Deportivo Saprissa	2023-09-25 01:00:00	\N	\N
1368	AD Grecia	AD San Carlos	2023-09-25 22:00:00	\N	\N
1369	NK Dubrava Zagreb	NK Jarun	2023-09-25 15:00:00	\N	\N
1371	Deportivo Cuenca	Barcelona Guayaquil	2023-09-25 01:00:00	\N	\N
1372	Panathinaikos	AEK Athens	2023-09-25 19:00:00	\N	\N
1373	East Bengal Club	Jamshedpur FC	2023-09-25 15:30:00	\N	\N
1374	Santos Laguna	Necaxa	2023-09-25 03:05:00	\N	\N
1375	JS Soualem	OC Safi	2023-09-25 17:00:00	\N	\N
1376	Mouloudia Oujda	FAR Rabat	2023-09-25 19:15:00	\N	\N
1377	Renaissance Zemamra	MAS Fes	2023-09-25 21:30:00	\N	\N
1379	Sportivo Ameliano	Sportivo Trinidense	2023-09-25 01:00:00	\N	\N
1380	Deportivo Garcilaso	Cienciano	2023-09-25 01:30:00	\N	\N
1381	Deportivo Municipal	Cusco FC	2023-09-25 19:00:00	\N	\N
1382	Atletico Grau	Sport Huancayo	2023-09-25 21:00:00	\N	\N
1384	Bohemians Dublin	Shelbourne	2023-09-25 19:45:00	\N	\N
1385	Dundalk	Cork City	2023-09-25 19:45:00	\N	\N
1386	St Patricks Athletic	Drogheda United	2023-09-25 19:45:00	\N	\N
1387	Rapid Bucuresti	CFR Cluj	2023-09-25 19:00:00	\N	\N
1388	Stirling University	Albion	2023-09-25 19:05:00	\N	\N
1391	Hatayspor	Trabzonspor	2023-09-25 18:00:00	\N	\N
1392	Altay	Bodrumspor	2023-09-25 18:00:00	\N	\N
1395	Atlético Tucumán	Arsenal de Sarandi	2023-09-26 01:00:00	\N	\N
1396	CA Talleres de Córdoba	Barracas Central	2023-09-26 01:00:00	\N	\N
1397	America MG	Vasco da Gama	2023-09-26 00:00:00	\N	\N
1398	Alianza Petrolera	Once Caldas	2023-09-26 00:25:00	\N	\N
1399	Independiente Medellin	Atletico Bucaramanga	2023-09-26 02:35:00	\N	\N
1400	Libertad FC	El Nacional	2023-09-26 01:00:00	\N	\N
1401	Sporting Cristal	UTC Cajamarca	2023-09-26 02:00:00	\N	\N
1471	Osasuna	Atletico Madrid	2023-09-28 20:30:00	\N	3
1472	Frosinone	Fiorentina	2023-09-28 17:30:00	\N	4
1473	Genoa	Roma	2023-09-28 19:45:00	\N	4
1474	Club Brugge	Genk	2023-09-28 19:45:00	\N	68
1475	AZ	Heracles	2023-09-28 19:00:00	\N	196
1476	Estrela Amadora	Braga	2023-09-28 20:15:00	\N	8
1477	Orgryte IS	GAIS	2023-09-28 18:00:00	\N	336
1478	Orebro SK	Utsiktens BK	2023-09-28 18:00:00	\N	336
1479	Trelleborgs FF	Jonkopings Sodra	2023-09-28 18:00:00	\N	336
1480	Basel	Lucerne	2023-09-28 19:30:00	\N	15
1437	Philadelphia Union	FC Dallas	2023-09-28 00:30:00	\N	76
1438	Colorado Rapids	Vancouver Whitecaps	2023-09-28 02:30:00	\N	76
1402	Mallorca	Barcelona	2023-09-26 20:30:00	\N	3
1403	Lille	Reims	2023-09-26 20:00:00	\N	5
1404	FC Zurich	Grasshoppers	2023-09-26 19:30:00	\N	15
1423	Villarreal	Girona	2023-09-27 18:00:00	\N	3
1424	Valencia	Real Sociedad	2023-09-27 20:30:00	\N	3
1425	Verona	Atalanta	2023-09-27 17:30:00	\N	4
1426	Inter Milan	Sassuolo	2023-09-27 19:45:00	\N	4
1427	Lazio	Torino	2023-09-27 19:45:00	\N	4
1428	Antwerp	Gent	2023-09-27 19:45:00	\N	68
1429	PSV	Go Ahead Eagles	2023-09-27 17:45:00	\N	196
1430	Hodd	Sandnes Ulf	2023-09-27 17:00:00	\N	204
1431	Skövde AIK	Landskrona	2023-09-27 18:00:00	\N	336
1432	Osters IF	Helsingborg	2023-09-27 18:00:00	\N	336
1433	Ostersunds FK	IK Brage	2023-09-27 18:00:00	\N	336
1434	Lugano	Lausanne Sports	2023-09-27 19:30:00	\N	15
1435	Servette	Winterthur	2023-09-27 19:30:00	\N	15
1436	St Gallen	Young Boys	2023-09-27 19:30:00	\N	15
1481	Stade Lausanne-Ouchy	Yverdon Sport FC	2023-09-28 19:30:00	\N	15
1503	KV Kortrijk	Cercle Brugge	2023-09-29 19:45:00	\N	68
1504	Deinze	SK Beveren	2023-09-29 19:00:00	\N	136
1505	Standard Liege II	Patro Eisden Maasmechelen	2023-09-29 19:00:00	\N	136
1506	Hillerød	AC Horsens	2023-09-29 18:00:00	\N	147
1507	Vendsyssel FF	AaB	2023-09-29 18:00:00	\N	147
1508	Yokohama F-Marinos	Vissel Kobe	2023-09-29 11:00:00	\N	28
1509	De Graafschap	Roda JC	2023-09-29 19:00:00	\N	199
1510	Cambuur Leeuwarden	PSV Reserves	2023-09-29 19:00:00	\N	199
1511	Maastricht	ADO Den Haag	2023-09-29 19:00:00	\N	199
1512	FC Groningen	FC Den Bosch	2023-09-29 19:00:00	\N	199
1513	Top Oss	FC Emmen	2023-09-29 19:00:00	\N	199
1514	Telstar	Ajax Reserves	2023-09-29 19:00:00	\N	199
1515	AZ Reserves	Willem II	2023-09-29 19:00:00	\N	199
1516	Benfica	FC Porto	2023-09-29 20:15:00	\N	8
1517	Consadole Sapporo	Kashiwa Reysol	2023-09-30 05:00:00	\N	28
1497	Sheff Wed	Sunderland	2023-09-29 20:00:00	\N	77
1498	TSG Hoffenheim	Borussia Dortmund	2023-09-29 19:30:00	\N	1
1499	Hamburg	Fortuna Dusseldorf	2023-09-29 17:30:00	\N	93
1500	Paderborn	Schalke	2023-09-29 17:30:00	\N	93
1501	Barcelona	Sevilla	2023-09-29 20:00:00	\N	3
1502	Strasbourg	Lens	2023-09-29 20:00:00	\N	5
\.


--
-- TOC entry 3049 (class 0 OID 17026)
-- Dependencies: 210
-- Data for Name: over2p5orbitxch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5orbitxch (id, home, away, date_time, url, plaied, ht_goals, ft_goals, league_id) FROM stdin;
5871	Roda JC	Den Bosch	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504975	t	\N	\N	\N
6122	Mito	Oita	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343026	f	\N	\N	\N
6123	Grulla Morioka	Tegevajaro Miyazaki	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522654	f	\N	\N	\N
6124	Blaublitz Akita	Yamagata	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342936	f	\N	\N	\N
6125	Albirex Niigata	Yokohama FC	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159486	f	\N	\N	\N
6126	Daejeon Citizen	Suwon Bluewings	2023-09-23 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365147	f	\N	\N	\N
6127	FC Tiamo Hirakata	Suzuka Unlimited	2023-09-23 06:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218529597	f	\N	\N	\N
6128	Honda Lock	Honda FC	2023-09-23 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528785	f	\N	\N	\N
6129	FC Tokyo	Tosu	2023-09-23 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159846	f	\N	\N	\N
6130	Nara Club	FC Ryukyu	2023-09-23 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522294	f	\N	\N	\N
6131	Yangpyeong FC	Paju Citizen	2023-09-23 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550083	f	\N	\N	\N
6132	Nagoya	Sapporo	2023-09-23 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159396	f	\N	\N	\N
6133	Gimcheon Sangmu	FC Anyang	2023-09-23 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218540126	f	\N	\N	\N
6134	Jeju Utd	FC Seoul	2023-09-23 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218372615	f	\N	\N	\N
6135	NK Dugopolje U19	HNK Cibalia Vinkovci U19	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650362	f	\N	\N	\N
6136	Rudes U19	Dinamo Zagreb U19	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650182	f	\N	\N	\N
6137	Hajduk Split U19	Lokomotiva Zagreb U19	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649244	f	\N	\N	\N
6138	Kalteng Putra FC	Persewar Waropen	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648519	f	\N	\N	\N
6139	Veertien Kuwana	Tokyo Musashino City	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529417	f	\N	\N	\N
6140	ACS Viitorul Tg Jiu	FC Hunedoara	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526113	f	\N	\N	\N
6141	CS Mioveni	Progresul 1944 Spartac	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526022	f	\N	\N	\N
6142	CSM Scolar Resita	Concordia Chiajna	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526292	f	\N	\N	\N
6143	CS Tunari	Csikszereda	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515020	f	\N	\N	\N
6144	FCM Alexandria	Argeș Pitești	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218525932	f	\N	\N	\N
6145	PS TIRA	Persik Kediri	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218623644	f	\N	\N	\N
6146	Chindia Targoviste	Acs Dumbravita	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526603	f	\N	\N	\N
6147	FC Metaloglobus Bucuresti	Ceahlaul	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526421	f	\N	\N	\N
6148	Persebaya Surabaya	Arema Cronus	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218623734	f	\N	\N	\N
6149	Nagasaki	FC Machida	2023-09-23 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343116	f	\N	\N	\N
6150	MFK Chrudim	Zizkov	2023-09-23 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218370114	f	\N	\N	\N
6151	Prostejov	Varnsdorf	2023-09-23 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218368567	f	\N	\N	\N
6152	Angkor Tiger FC	Prey Veng	2023-09-23 09:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218649926	f	\N	\N	\N
6153	HNK Sibenik U19	Mladost Zdralovi U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649154	f	\N	\N	\N
6154	NK Kustošija U19	NK Varazdin U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650272	f	\N	\N	\N
6155	Jef Utd Chiba	Sendai	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343206	f	\N	\N	\N
6156	Iwaki SC	Kanazawa	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365057	f	\N	\N	\N
6157	Ehime	Kagoshima Utd	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522564	f	\N	\N	\N
6158	Nagano Parceiro	Toyama	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521619	f	\N	\N	\N
6159	FC St. Pauli U19	SG Dynamo Dresden U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625991	f	\N	\N	\N
6160	SC Paderborn 07 U19	Leverkusen U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626081	f	\N	\N	\N
6161	FK Kyzyl-Zhar	FK Aktobe	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626807	f	\N	\N	\N
6162	Fortuna Dusseldorf U19	Alemannia Aachen U19	2023-09-23 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631545	f	\N	\N	\N
6163	Dalian Yifang	Shandong Taishan	2023-09-23 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218415789	f	\N	\N	\N
6164	Jeonnam Dragons	Cheonan City	2023-09-23 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218540306	f	\N	\N	\N
6165	Gimhae City	Gyeongju KHNP	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550621	f	\N	\N	\N
6166	Kashiwa	Fukuoka	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159306	f	\N	\N	\N
6167	Wolfsburg U19	Hannover 96 (U19)	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625901	f	\N	\N	\N
6168	Ulsan Citizen FC	Busan Transportation Corp	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550533	f	\N	\N	\N
6169	Nottingham Forest U21	Crystal Palace U21	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218642625	f	\N	\N	\N
6170	Kobe	C-Osaka	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159216	f	\N	\N	\N
6171	FC Imabari	Vanraure Hachinohe	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522474	f	\N	\N	\N
2945	SonderjyskE	AaB	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961564	f	\N	\N	\N
6172	Kyoto	Hiroshima	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159576	f	\N	\N	\N
6173	Lee Man Warriors	HK U23	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218638891	f	\N	\N	\N
6174	Renofa Yamaguchi	Thespakusatsu Gunma	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343296	f	\N	\N	\N
6175	Fabril Barreiro	Maritimo	2023-09-23 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631455	f	\N	\N	\N
6181	Chainat Hornbill	Ayutthaya United	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627559	f	\N	\N	\N
6217	PIF	HJS Akatemia	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627952	f	\N	\N	\N
6224	Fortuna Koln	FC Gutersloh	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565275	f	\N	\N	\N
6176	Chanthaburi FC	Phrae United	2023-09-23 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218626897	f	\N	\N	\N
6177	Radomiak Radom	Puszcza Niepolomice	2023-09-23 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218303027	f	\N	\N	\N
6178	Boeung Ket	National Defense Ministry	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629477	f	\N	\N	\N
2994	Jong PSV Eindhoven	De Graafschap	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218084970	f	\N	\N	\N
6183	Hamburg II	Eimsbutteler	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218561023	f	\N	\N	\N
6190	BK Olympic	Angelholms	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391452	f	\N	\N	\N
6179	Kaiserslautern U19	Karlsruher SC U19	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628098	f	\N	\N	\N
6189	Man Utd U21	Arsenal U21	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643498	f	\N	\N	\N
6180	Muangthong Utd	Nakhon Pathom	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218571754	f	\N	\N	\N
6187	FK Maqtaaral Jetisay	FK Aksu Pavlodar	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630517	f	\N	\N	\N
6192	Torns	Tvaakers	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218403239	f	\N	\N	\N
6193	Braunschweig	Nurnberg	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218014975	t	\N	\N	\N
6195	Samut Prakan	Nakhon Ratchasima	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627469	f	\N	\N	\N
6186	Carl Zeiss Jena	Viktoria Berlin	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560483	f	\N	\N	\N
6182	Vard Haugesund	Orn Horten	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218644325	f	\N	\N	\N
6184	CF Panaderia Pulido	CD Union Sur Yaiza	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658709	f	\N	\N	\N
6191	Orebro Syrianska	IFK Stocksund	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406904	f	\N	\N	\N
6185	NK Bravo	Olimpija	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375143	f	\N	\N	\N
6196	FC Inter	KuPS	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218225557	f	\N	\N	\N
6198	FC Eilenburg	Rot-Weiss Erfurt	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560573	f	\N	\N	\N
6207	FC Voluntari	CSMS Iasi	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218257264	f	\N	\N	\N
6208	Samtredia	Gagra	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218629025	f	\N	\N	\N
6204	Livingston	Celtic	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217937447	f	\N	\N	\N
6203	Krabi FC	Nakhon Si United F.C.	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218627379	f	\N	\N	\N
6205	FC Shukura Kobuleti	Torpedo Kutaisi	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218628935	f	\N	\N	\N
6201	Paide Linnameeskond	Parnu JK Vaprus	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218429185	f	\N	\N	\N
6202	Trans Narva	Harju JK Laagri	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218429095	f	\N	\N	\N
6206	Woking	York City	2023-09-23 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218412577	f	\N	\N	\N
6211	Meizhou Hakka	Henan Songshan Longmen	2023-09-23 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218374127	f	\N	\N	\N
6210	Wuhan Three Towns	Tianjin Jinmen Tiger FC	2023-09-23 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218415987	f	\N	\N	\N
6209	Chengdu Rongcheng	Shanghai Port FC	2023-09-23 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218408315	f	\N	\N	\N
6212	Kohtla-Jarve	Tabasalu JK	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608575	f	\N	\N	\N
6213	Esan Pattaya	SGBK FC	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648062	f	\N	\N	\N
6222	Brescia	Venezia	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218132174	f	\N	\N	\N
6220	Modena	Lecco	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218131958	f	\N	\N	\N
6215	US Cremonese	Ascoli	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218132282	f	\N	\N	\N
6227	FC Dziugas	FK Banga Gargzdu	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218525661	f	\N	\N	\N
6225	FC Jazz	Atlantis	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627862	f	\N	\N	\N
6214	Andorra CF	Sporting Gijon	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218278200	f	\N	\N	\N
6219	Preussen Munster	Lubeck	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374509	f	\N	\N	\N
6223	SV Werder Bremen U19	FC Hansa Rostock U19	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628188	f	\N	\N	\N
6218	Ternana	Sudtirol	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218132390	f	\N	\N	\N
6216	Schalke 04 II	FC Wegberg-Beeck	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564989	f	\N	\N	\N
6226	SV Stuttgarter Kickers	Hoffenheim II	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564399	f	\N	\N	\N
6221	Bidco United	FC Talanta	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649521	f	\N	\N	\N
6188	AC Horsens	Vendsyssel FF	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218460738	t	\N	\N	\N
6286	FC Floresti	Dacia Buiucani	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647883	f	\N	\N	\N
6238	TuS Koblenz	FSV Frankfurt	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564489	f	\N	\N	\N
6245	FC Duren	Velbert	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565375	f	\N	\N	\N
6228	Viktoria Koln	Duisburg	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374417	f	\N	\N	\N
6244	Dukla Prague	H Slavia Kromeriz	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374691	f	\N	\N	\N
6233	Jahn Regensburg	SV Sandhausen	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374599	f	\N	\N	\N
6237	Verl	Dortmund II	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374327	f	\N	\N	\N
6243	Sotra SK	Strommen	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218644415	f	\N	\N	\N
6239	Odisha	Chennaiyin FC	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375053	f	\N	\N	\N
6236	Arda	Hebar	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032585	f	\N	\N	\N
6231	Tusker FC	Muhoroni Youth FC	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650903	f	\N	\N	\N
6242	Adiyamanspor	Ankaraspor	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660100	f	\N	\N	\N
6232	FC Bocholt	SV Lippstadt	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564899	f	\N	\N	\N
6229	Feralpisalo	Pisa	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387627	f	\N	\N	\N
6241	Girona	Mallorca	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217927862	f	\N	\N	\N
6234	Saarbrucken	Waldhof Mannheim	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374781	f	\N	\N	\N
6230	Shabana	FC Kariobangi Sharks	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650813	f	\N	\N	\N
6248	Lokomotiv Leipzig	BFC Dynamo	2023-09-23 13:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218560286	f	\N	\N	\N
6249	Olympiacos B	Ilioupoli	2023-09-23 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218575863	f	\N	\N	\N
6250	FC Tallinn	Flora Tallinn II	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218608665	f	\N	\N	\N
6251	Ankara Demirspor	Halide Edip Adivarspor	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218659933	f	\N	\N	\N
6258	FIRST VIENNA FC 1894	FC Dornbirn	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218341685	f	\N	\N	\N
6255	Amasyaspor 1968 FK	ANADOLU UNIVERSITY	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218647172	f	\N	\N	\N
6254	Grazer AK	FC Liefering	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218341775	f	\N	\N	\N
6253	Serik Belediyespor	Karacabey Belediyespor AS	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218660460	f	\N	\N	\N
6256	Puskas Akademia	Paks	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218181036	f	\N	\N	\N
6252	Karaman Belediyespor	68 Aksaray Belediyespor	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218659566	f	\N	\N	\N
6257	Etimesgut Belediyespor	Denizlispor	2023-09-23 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218659750	f	\N	\N	\N
6273	EPS	Ilves Kissat	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628559	f	\N	\N	\N
6263	Slovan Liberec	Teplice	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217989131	f	\N	\N	\N
6272	Ranheim IL	Fredrikstad	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198299	t	\N	\N	\N
6265	NK Sesvete	Sibenik	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218570148	f	\N	\N	\N
6289	Jaro	SalPA	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218435429	f	\N	\N	\N
6271	Makedonikos	Iraklis	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628845	f	\N	\N	\N
6274	Bul FC	Kampala City Council	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650452	f	\N	\N	\N
6262	Slovacko	MFK Karvina	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988590	f	\N	\N	\N
6269	Nkwazi	Kansanshi	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628286	f	\N	\N	\N
6277	Zaglebie Lubin II	Skra Czestochowa	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599967	f	\N	\N	\N
6275	PK-35 RY	TiPS	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628469	f	\N	\N	\N
6280	Mikkeli	EIF	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218435609	f	\N	\N	\N
6278	Johor Darul Takzim	Negeri Sembilan	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647975	f	\N	\N	\N
6267	Kusadasispor	Silivrispor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218646947	f	\N	\N	\N
6281	Vasteras SK	Sundsvall	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315048	f	\N	\N	\N
6264	Mamelodi Sundowns	Kaizer Chiefs	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218670352	f	\N	\N	\N
6284	ESTAC Troyes	Auxerre	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158068	f	\N	\N	\N
6261	Ceske Budejovice	Mlada Boleslav	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217989401	f	\N	\N	\N
6268	Bursaspor	Altinordu	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660280	f	\N	\N	\N
6288	Kairat Almaty	Shakhter Karagandy	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629657	f	\N	\N	\N
6279	JJK	JaPS	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387012	f	\N	\N	\N
6260	Banik Ostrava	Zlin	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217989311	f	\N	\N	\N
6270	Kieler SV Holstein II	Bremer SV	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218561113	f	\N	\N	\N
6276	Thisted	Nykobing FC	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628376	f	\N	\N	\N
6266	Arnavutkoy Belediyesi GVS	Sariyer G.K.	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658838	f	\N	\N	\N
6285	JIPPO	NJS	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628649	f	\N	\N	\N
6296	Levanger	Stjordals-Blink	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643787	f	\N	\N	\N
3160	Kagoshima Utd	Kamatamare Sanuki	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138165	f	\N	\N	\N
6316	Dortmund	Wolfsburg	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217880140	t	\N	\N	\N
6300	Keciorengucu	Giresunspor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520354	f	\N	\N	\N
6310	SK Super Nova	BFC Daugavpils	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528333	f	\N	\N	\N
6292	KPV	KaPa	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218435519	f	\N	\N	\N
6293	Catalcaspor	Bursa Yildirim Spor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218646767	f	\N	\N	\N
6295	Turgutluspor	Elazigspor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647037	f	\N	\N	\N
6303	Arendal	Fram Larvik	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218644235	f	\N	\N	\N
6308	Degerfors	Malmo FF	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218160367	t	\N	\N	\N
6299	Inegolspor	76 Igdir Belediyespor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659406	f	\N	\N	\N
6290	Resovia Rzeszow	Polonia Warszawa	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218401360	f	\N	\N	\N
6301	AC Milan	Verona	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217966124	f	\N	\N	\N
6298	Belediye Derincespor	Usakspor	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659019	f	\N	\N	\N
6309	Wakiso Giants	Bright Stars	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649064	f	\N	\N	\N
6307	Lamphun Warrior	Chiangrai Utd	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218571664	f	\N	\N	\N
6302	Kallithea	Panachaiki	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218628755	f	\N	\N	\N
6297	RoPS	VIFK	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218627772	f	\N	\N	\N
6317	Bayern Munich	Bochum	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217880260	t	\N	\N	\N
6312	NK Rogaska	Mura	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218385603	f	\N	\N	\N
6304	Slask Wroclaw	Piast Gliwice	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303387	f	\N	\N	\N
6313	Ahali Tamra	Bnei Hagolan VeHaGalil	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218652162	f	\N	\N	\N
6319	Mgladbach	RB Leipzig	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217880020	t	\N	\N	\N
6322	Barry Town Utd	Bala Town	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218535667	f	\N	\N	\N
6315	MFk Dolny Kubin	FC Petrzalka	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218608362	f	\N	\N	\N
6314	KFC Komarno	Spartak Myjava	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218608452	f	\N	\N	\N
6318	Colwyn Bay	Newtown	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218535217	f	\N	\N	\N
6323	NK Zagora	Kamen Ivanbegovina	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218654325	f	\N	\N	\N
6320	Augsburg	Mainz	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217881536	t	\N	\N	\N
6321	Union Berlin	Hoffenheim	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217881296	t	\N	\N	\N
6328	Plymouth	Norwich	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381894	t	\N	\N	\N
6342	Crystal Palace	Fulham	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217901976	t	\N	\N	\N
6335	Dunfermline	Morton	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367253	f	\N	\N	\N
6336	Swansea	Sheff Wed	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381678	f	\N	\N	\N
6333	Edinburgh City	Cove Rangers	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378981	f	\N	\N	\N
6331	Dartford	Tonbridge Angels	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337414	f	\N	\N	\N
6341	Eastleigh	Kidderminster	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218411767	f	\N	\N	\N
6340	Peterborough Sports FC	South Shields	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489708	f	\N	\N	\N
6343	FC Inter Manacor	CD Binissalem FC	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658875	f	\N	\N	\N
6339	Tuzla City	Borac Banja Luka	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664422	f	\N	\N	\N
6345	Oxford Utd	Exeter	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380002	f	\N	\N	\N
6348	Rizespor	Sivasspor	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190990	f	\N	\N	\N
6334	Montrose	Stirling	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378567	f	\N	\N	\N
6332	Harrogate Town	Salford City	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219678	f	\N	\N	\N
6347	Pendikspor	Fatih Karagumruk Istanbul	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497615	f	\N	\N	\N
6325	Partick	Arbroath	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367163	f	\N	\N	\N
6338	Sandviks IK	Team TG FF	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218536588	f	\N	\N	\N
6326	Ariana FC	Falkenbergs	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218394928	f	\N	\N	\N
6346	Portsmouth	Lincoln	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378839	f	\N	\N	\N
6327	Burton Albion	Fleetwood Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381043	f	\N	\N	\N
6330	Chelmsford	St Albans	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218491228	f	\N	\N	\N
6344	Doncaster	Gillingham	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209362	f	\N	\N	\N
6324	Man City	Nottm Forest	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217902259	f	\N	\N	\N
6294	Express	Mbarara City FC	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648973	f	\N	\N	\N
6377	FK Sumqayit	PFK Turan Tovuz	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664152	f	\N	\N	\N
6359	Leicester	Bristol City	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381786	t	\N	\N	\N
6367	Ipswich	Blackburn	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383268	t	\N	\N	\N
3222	Aegir	Leiknir R	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315663	f	\N	\N	\N
6364	FK Kaisar	FK Kaspyi Aktau	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630337	f	\N	\N	\N
6350	Cambridge Utd	Port Vale	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218379228	f	\N	\N	\N
6390	Loughgall	Linfield	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429455	f	\N	\N	\N
6397	Sestao River	Leonesa	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539315	f	\N	\N	\N
6407	Altrincham	Ebbsfleet Utd	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413357	f	\N	\N	\N
6383	Boston Utd	Chester	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489888	f	\N	\N	\N
6357	Tranmere	Accrington	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218208822	f	\N	\N	\N
6372	Southport	Tamworth FC	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489618	f	\N	\N	\N
6395	Boreham Wood	Aldershot	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412667	f	\N	\N	\N
6354	Farnborough FC	Slough Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336964	f	\N	\N	\N
6366	Granada B	Intercity Sant Joan C.F	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539495	f	\N	\N	\N
6405	Solihull Moors	Bromley	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412967	f	\N	\N	\N
6363	Luton	Wolves	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217902117	t	\N	\N	\N
6379	IF Karlstad	Sollentuna FF	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218646276	f	\N	\N	\N
6352	Carlisle	Derby	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380509	f	\N	\N	\N
6385	Atletico Madrid II	Ibiza Eivissa	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539675	f	\N	\N	\N
6374	Newport County	Bradford	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218208912	f	\N	\N	\N
6402	Inverness CT	Dundee Utd	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367343	f	\N	\N	\N
6356	Maidstone Utd	Worthing	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337234	f	\N	\N	\N
6361	Barnet	FC Halifax Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412877	f	\N	\N	\N
6375	Taunton Town	Havant and W	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337324	f	\N	\N	\N
6404	Stockport	Wrexham	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209182	f	\N	\N	\N
6392	Brackley Town	Curzon Ashton	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218490068	f	\N	\N	\N
6388	Blyth Spartans	Alfreton Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489528	f	\N	\N	\N
6400	Gateshead	Maidenhead	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218411977	f	\N	\N	\N
6398	Grimsby	Crawley Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209272	f	\N	\N	\N
6389	Clyde	Elgin City FC	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380107	f	\N	\N	\N
6355	Leyton Orient	Shrewsbury	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381362	f	\N	\N	\N
6376	Truro City	Weston-super-Mare	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218490338	f	\N	\N	\N
6380	Dag and Red	Hartlepool	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413177	f	\N	\N	\N
6391	Hibernian	St Johnstone	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217937559	f	\N	\N	\N
6401	Airdrieonians	Raith	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367073	f	\N	\N	\N
6384	Chesterfield	Wealdstone	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412067	f	\N	\N	\N
6387	Ballymena	Cliftonville	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429635	f	\N	\N	\N
6403	Charlton	Wycombe	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381139	f	\N	\N	\N
6362	Sutton Utd	MK Dons	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229720	f	\N	\N	\N
6399	Panevezys	FK Suduva	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527654	f	\N	\N	\N
6371	Crewe	Colchester	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209092	f	\N	\N	\N
6360	Middlesbrough	Southampton	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218382698	t	\N	\N	\N
6382	Southend	AFC Fylde	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412367	f	\N	\N	\N
6369	Leeds	Watford	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383633	f	\N	\N	\N
6368	Buxton	Spennymoor Town	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489438	f	\N	\N	\N
6381	Oldham	Oxford City	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413267	f	\N	\N	\N
6365	Bonnyrigg	Stenhousemuir	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218379784	f	\N	\N	\N
6358	Farsley Celtic	Banbury Utd	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489348	f	\N	\N	\N
6393	St Mirren	Hearts	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217937667	f	\N	\N	\N
6406	Walsall	AFC Wimbledon	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209632	f	\N	\N	\N
6353	Morecambe	Swindon	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209452	f	\N	\N	\N
6373	Warrington Town	Kings Lynn	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489978	f	\N	\N	\N
6386	Charleroi	Kortrijk	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218223600	t	\N	\N	\N
6349	Cibalia Vinkovci	Zrinski Jurjevac	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218570056	f	\N	\N	\N
6370	Hereford FC	Bishops Stortford	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218490248	f	\N	\N	\N
6396	Seraing Utd	Anderlecht B	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612222	f	\N	\N	\N
6418	Chorley	Scunthorpe	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489798	f	\N	\N	\N
6414	Spartans	East Fife	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380365	f	\N	\N	\N
6417	Hemel Hempstead	Torquay	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336874	f	\N	\N	\N
6415	Hampton and Richmond	Yeovil	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336784	f	\N	\N	\N
6411	Dorking Wanderers	Rochdale	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412277	f	\N	\N	\N
6409	Aveley	Braintree	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337504	f	\N	\N	\N
6408	CD Diocesanos	SD Atletico Tordesillas	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660136	f	\N	\N	\N
6416	Annan	Alloa	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378657	f	\N	\N	\N
6413	Dumbarton	Peterhead	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380623	f	\N	\N	\N
6419	Blackpool	Reading	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380249	f	\N	\N	\N
6410	Bath City	Dover	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337054	f	\N	\N	\N
6412	Eastbourne	Welling Utd	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218491138	f	\N	\N	\N
6420	Darlington	Gloucester	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218490158	f	\N	\N	\N
6437	Eskilsminne	Oskarshamns AIK	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218403469	f	\N	\N	\N
2910	Lahti	KTP	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218075271	f	\N	\N	\N
6421	Bolton	Peterborough	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218379633	f	\N	\N	\N
6433	Ponferradina II	CF Palencia	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659920	f	\N	\N	\N
6430	Crusaders	Glenavon	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429545	f	\N	\N	\N
6436	Aatvidabergs FF	FC Trollhattan	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218403329	f	\N	\N	\N
6429	Notts Co	Forest Green	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209542	f	\N	\N	\N
6434	West Brom	Millwall	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383741	f	\N	\N	\N
6432	Patacona CF	Elche II	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660550	f	\N	\N	\N
6428	Cheltenham	Stevenage	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380910	f	\N	\N	\N
6422	Dundee	Kilmarnock	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217937883	f	\N	\N	\N
6435	IBV	Fram	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497525	f	\N	\N	\N
6424	Queen of South	Hamilton	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218378747	f	\N	\N	\N
6337	Hammarby TFF	Motala	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218395018	f	\N	\N	\N
6439	Spezia	Reggiana	2023-09-23 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218132066	f	\N	\N	\N
6431	Northampton	Barnsley	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381229	f	\N	\N	\N
6425	RC Villalbes	Marino Luanco	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592899	f	\N	\N	\N
6441	Levante	Eldense	2023-09-23 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218278290	f	\N	\N	\N
6442	Vuteks Sloga	Oriolik	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218654235	f	\N	\N	\N
6440	Osasuna	Sevilla	2023-09-23 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217927742	f	\N	\N	\N
6446	OFI	Atromitos	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993398	f	\N	\N	\N
6453	Moreirense	Farense	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218432338	t	\N	\N	\N
6448	EGS Gafsa	AS Solimane	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218648793	f	\N	\N	\N
6451	Rapitenca	CF Peralada	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218660730	f	\N	\N	\N
6461	Red Bull Salzburg	FC Blau Weiss Linz	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944803	t	\N	\N	\N
6452	Estoril Praia	Vizela	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218432771	f	\N	\N	\N
6450	Hallescher FC	1860 Munich	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385333	f	\N	\N	\N
6447	FC Sellier & Bellot Vlasim	SFC Opava	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218387192	f	\N	\N	\N
6443	Ben Guerdane	Olympique De Beja	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218648883	f	\N	\N	\N
6454	NK Lukavec	NK Bistra	2023-09-23 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218654145	f	\N	\N	\N
6445	Lokomotiv Plovdiv	Slavia Sofia	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218031937	f	\N	\N	\N
6444	Lions Gibraltar	St. Joseph's FC	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218647735	f	\N	\N	\N
6455	CD Laguna	Villaralbo	2023-09-23 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218659739	f	\N	\N	\N
6467	Tampereen Ilves II	Honka Akatemia	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631113	f	\N	\N	\N
6460	CD Santa Ursula	CD Herbania	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658559	f	\N	\N	\N
6471	Hapoel Petach Tikva	Hapoel Beer Sheva	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218524383	f	\N	\N	\N
6466	Diosgyori	DEBRECENI VSC	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218180766	f	\N	\N	\N
6464	Urduliz FT	Lagun Onak	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660889	f	\N	\N	\N
6463	Austria Klagenfurt	SC AUSTRIA LUSTENAU	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944695	t	\N	\N	\N
6472	Talleres (RE)	CA Ituzaingo	2023-09-23 16:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218630697	f	\N	\N	\N
6468	Belouizdad	NC Magra	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626351	f	\N	\N	\N
6456	NK Istra	HNK Gorica	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218385423	f	\N	\N	\N
6462	WSG Wattens	Wolfsberger AC	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945019	t	\N	\N	\N
6457	Brighton U21	Newcastle U21	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218642716	f	\N	\N	\N
6477	Brommapojkarna	Norrkoping	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218159036	t	\N	\N	\N
6469	Juventud Torremolinos	UD Torre del Mar	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659287	f	\N	\N	\N
6470	FC Zbrojovka Brno	Vyskov	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387282	f	\N	\N	\N
6465	Nantes	Lorient	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965381	t	\N	\N	\N
6458	FC Jove Espanol	Ontinyent CF	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660370	f	\N	\N	\N
6475	Kuopion Elo	GBK	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218631023	f	\N	\N	\N
6479	Deportes Recoleta	CSD Barnechea	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218647554	f	\N	\N	\N
6478	Palestino	Union Espanola	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218010672	f	\N	\N	\N
6473	LKP Motor Lublin	Wisla Krakow	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218401137	f	\N	\N	\N
6449	FC Volendam	Heracles	2023-09-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217939180	t	\N	\N	\N
6474	NK Celje	NK Radomlje	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218391664	f	\N	\N	\N
6476	CD Ebro	CD Binefar	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218657963	f	\N	\N	\N
6423	Bristol Rovers	Wigan	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218380777	f	\N	\N	\N
6484	Botosani	UTA Arad	2023-09-23 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218257716	f	\N	\N	\N
2968	ETSV Hamburg	Dassendorf	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218290536	f	\N	\N	\N
6483	Cadiz B	Manchego Ciudad Real	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636457	f	\N	\N	\N
6480	Casalarreina CF	CD Berceo	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218658053	f	\N	\N	\N
6522	Merida AD	Real Madrid Castilla	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552176	f	\N	\N	\N
6501	Bucaspor	Nazilli Belediyespor	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660640	f	\N	\N	\N
6514	Lausanne	FC Zurich	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217958811	t	\N	\N	\N
6499	Huracanes Izcalli FC	Atlético Pachuca	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661182	f	\N	\N	\N
6510	Corum Belediyespor	Sakaryaspor	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520264	f	\N	\N	\N
6489	CSF Balti	CS Petrocub	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631845	f	\N	\N	\N
6512	Espanyol B	UD Alzira	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218632175	f	\N	\N	\N
6520	Sassuolo	Juventus	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965501	t	\N	\N	\N
6488	Al Hala	Busaiteen Club	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643679	f	\N	\N	\N
6521	UP Langreo	Real Oviedo II	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592626	f	\N	\N	\N
6516	UD Ourense	CD Covadonga	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592808	f	\N	\N	\N
6492	Paola Hibernians FC	Santa Lucia FC	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218530071	f	\N	\N	\N
6515	Guijuelo	Coruxo	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592446	f	\N	\N	\N
6502	Fethiyespor	Somaspor Spor Kulubu	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659199	f	\N	\N	\N
6500	Muleno	CD Cieza	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658159	f	\N	\N	\N
6511	FC Baden	Stade Nyonnais	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218142749	f	\N	\N	\N
6503	CD Trofense	Pevidem SC	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218632025	f	\N	\N	\N
6505	Floriana	Birkirkara	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529236	f	\N	\N	\N
6528	Barcelona	Celta Vigo	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217927983	t	\N	\N	\N
6508	Palencia Cristo Atletico	Atletico Astorga CF	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659379	f	\N	\N	\N
6491	Manisa FK	Goztepe	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436228	f	\N	\N	\N
6494	Stomil Olsztyn	Sandecja Nowy Sacz	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218600057	f	\N	\N	\N
6507	Aalesunds	Stabaek	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064575	t	\N	\N	\N
6495	FK Jedinstvo Bijelo Polje	FK Mladost Donja Goric	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631935	f	\N	\N	\N
6518	SCD Durango	CD Vitoria	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661001	f	\N	\N	\N
6513	F91 Dudelange	Fc Differdange 03	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631755	f	\N	\N	\N
6498	CD Bezana	SD Torina	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661091	f	\N	\N	\N
6490	Sociedad B	Lugo	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539585	f	\N	\N	\N
6519	V de Santa Brigida	UD Gran Tarajal	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658366	f	\N	\N	\N
6487	DUKLA BANSKA BYSTRICA	Zlate Moravce	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218144342	f	\N	\N	\N
6504	Ispartaspor	Duzcespor	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658658	f	\N	\N	\N
6517	Zemplin	Podbrezova	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218142569	f	\N	\N	\N
6497	Al Riffa	Al Najma (BRN)	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643589	f	\N	\N	\N
6485	Viven Bornova FK	Osmaniyespor 2011	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218646857	f	\N	\N	\N
6486	Bohemians 1905	Sigma Olomouc	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988950	f	\N	\N	\N
6524	Caernarfon Town	Pontypridd Town	2023-09-23 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218535487	f	\N	\N	\N
6506	CE Andratx	CE Europa	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635917	f	\N	\N	\N
6523	Yellow-Red Mechelen	Oud-Heverlee Leuven	2023-09-23 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218224614	f	\N	\N	\N
6529	Arenas Club de Getxo	Tudelano	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218632670	f	\N	\N	\N
6533	Entella	Arezzo	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218620564	f	\N	\N	\N
6526	Kelty Hearts	Falkirk	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385693	f	\N	\N	\N
6536	Progres Niedercorn	Una Strassen	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218632760	f	\N	\N	\N
6531	Brentford	Everton	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217895405	f	\N	\N	\N
6537	Gosk Gabela	FK Igman Konjic	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218643922	f	\N	\N	\N
6534	Burgos	Elche	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218278965	f	\N	\N	\N
6535	AD San Juan	Naxara CD	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218632994	f	\N	\N	\N
6525	Zira	Neftchi Baku	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218648338	f	\N	\N	\N
6527	Pontedera	Recanatese	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218620744	f	\N	\N	\N
6532	Spal	Lucchese	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218620654	f	\N	\N	\N
6530	Werder Bremen	FC Koln	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217881416	t	\N	\N	\N
6496	Winterthur	Stade Lausanne-Ouchy	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217959351	t	\N	\N	\N
6482	CD Mirandes II	SD Almazan	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218659559	f	\N	\N	\N
6540	FC Ashdod	Maccabi Petach Tikva	2023-09-23 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218519245	f	\N	\N	\N
6582	KV Oostende	Racing Genk B	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612312	t	\N	\N	\N
6541	Hapoel Jerusalem	Maccabi Netanya	2023-09-23 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218436760	f	\N	\N	\N
6559	Dunkerque	Rodez	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157420	f	\N	\N	\N
6545	Casa Pia	Guimaraes	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218439307	f	\N	\N	\N
6548	Basaksehir	Galatasaray	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218192392	f	\N	\N	\N
6551	Amiens	Valenciennes	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157744	f	\N	\N	\N
6560	Pau	Annecy	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218385783	f	\N	\N	\N
6552	Angers	Bastia	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157636	f	\N	\N	\N
6546	Laval	Guingamp	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157852	f	\N	\N	\N
6562	Vojvodina	FK Javor Ivanjica	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575757	f	\N	\N	\N
6558	Concarneau	St Etienne	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157528	f	\N	\N	\N
6554	Panserraikos	Lamia	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217993200	f	\N	\N	\N
6556	York9	Cavalry	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218469923	f	\N	\N	\N
6547	Grenoble	Quevilly Rouen	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218385873	f	\N	\N	\N
6557	Maccabi Bnei Raina	Beitar Jerusalem	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218493130	f	\N	\N	\N
6544	AC Ajaccio	Paris FC	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218157960	f	\N	\N	\N
6553	FK Buducnost Podgorica	OFK Petrovac	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218651966	f	\N	\N	\N
6563	Hajduk Split	Lokomotiva	2023-09-23 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218387372	f	\N	\N	\N
6555	Leones Negros Udg	Correcaminos (Premier)	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218638350	f	\N	\N	\N
6543	Antalyaspor	Samsunspor	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218192700	f	\N	\N	\N
6561	Mladost Lucani	Fk Novi Pazar	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575667	f	\N	\N	\N
6550	PFC Levski Sofia	Etar	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032027	f	\N	\N	\N
6564	Ma'an	Al Salt	2023-09-23 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218638710	f	\N	\N	\N
6565	Ujpest	MTK Budapest	2023-09-23 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218181653	f	\N	\N	\N
6567	Swift Hesperange	Union Luxembourg	2023-09-23 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218638801	f	\N	\N	\N
6566	Manchester 62 FC	Glacis Utd	2023-09-23 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218647644	f	\N	\N	\N
6568	Hapoel Kfar Kasem Shua	Hapoel Mahane Yehuda	2023-09-23 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218652268	f	\N	\N	\N
6586	Balzan FC	Gzira United FC	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529778	f	\N	\N	\N
6588	Desp Brasil P LTDA U20	Sao Paulo U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637359	f	\N	\N	\N
6579	Club San Juan de Aragon	Racing FC Porto Palmeira	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661722	f	\N	\N	\N
6585	Deportivo	Cornella	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539225	f	\N	\N	\N
6578	Sint Truidense (Res)	Francs Borains U21	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595078	f	\N	\N	\N
6573	Gremio Novorizontino U20	Botafogo SP U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637089	f	\N	\N	\N
6570	Recreativo Huelva	CD Castellon	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539405	f	\N	\N	\N
6589	Ibrachina FC U20	Mirassol U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637449	f	\N	\N	\N
6575	Oeste U20	Inter Limeira U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637179	f	\N	\N	\N
6584	US Biskra	US Souf	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647373	f	\N	\N	\N
6581	Bregenz	SV Ried	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218341865	f	\N	\N	\N
6569	Univ Catolica (Ecu)	Gualaceo SC	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218416020	f	\N	\N	\N
6591	Agropecuario	Flandria	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218485307	f	\N	\N	\N
6580	Lech Poznan	Stal Mielec	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218302755	f	\N	\N	\N
6583	MC Oran	JS Saoura	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626171	f	\N	\N	\N
6576	Club Brugge B	SL 16 FC	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437593	f	\N	\N	\N
6592	IRT Tanger	Yous Berrechid	2023-09-23 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218649336	f	\N	\N	\N
6590	Almere City	PSV	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217939289	t	\N	\N	\N
6577	ES Setif	MC El Bayadh	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626261	f	\N	\N	\N
6571	Chrobry Glogow	Arka Gdynia	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400643	f	\N	\N	\N
6572	La Serena	Deportes Iquique	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647463	f	\N	\N	\N
6574	Curico Unido	Nublense	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218005614	f	\N	\N	\N
6593	Naxxar Lions	Hamrun Spartans FC	2023-09-23 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218529146	f	\N	\N	\N
6594	CSD San Antonio Unido	CDSC Iberia	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218656367	f	\N	\N	\N
6596	Acassuso	Deportivo Merlo	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218637900	f	\N	\N	\N
6595	Argentino de Merlo	Deportivo Armenio	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218637810	f	\N	\N	\N
6542	NEC Nijmegen	FC Utrecht	2023-09-23 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217938002	t	\N	\N	\N
6538	Hapoel Eran Hadera	Hapoel Haifa	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218493040	f	\N	\N	\N
6601	Universitatea Cluj	Universitatea Craiova	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218257444	f	\N	\N	\N
6602	San Telmo	Gimnasia Mendoza	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218484994	f	\N	\N	\N
6600	Central Cordoba	Victoriano Arenas	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218637990	f	\N	\N	\N
6605	CA Temperley	Patronato	2023-09-23 19:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218484891	f	\N	\N	\N
6598	Agudat Sport Ashdod	Ironi Modiin	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218589700	f	\N	\N	\N
6603	St Pauli	Schalke 04	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218014759	t	\N	\N	\N
6604	Real Pilar FC	CA Atlas	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218668708	f	\N	\N	\N
6607	Ancona	Juventus B	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218620834	f	\N	\N	\N
3087	Tecos FC	Colima FC	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3088	San Martin de San Juan	Agropecuario	2023-09-16 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3089	SE Palmeiras	Goias	2023-09-16 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
6608	Antwerp	Molenbeek	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218295827	t	\N	\N	\N
6610	Rimini	Perugia	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218620924	f	\N	\N	\N
6609	FK Velez Mostar	Sloga Doboj	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218639971	f	\N	\N	\N
6615	Heerenveen	Excelsior	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217939397	t	\N	\N	\N
6611	Deportes Rengo Unido	Fernandez Vial	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218669818	f	\N	\N	\N
6612	Deportes Limache	Deportes Valdivia	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218656655	f	\N	\N	\N
6624	Chacarita	Quilmes	2023-09-23 20:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218492770	f	\N	\N	\N
6618	Gimnasia La Plata	Rosario Central	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465043	f	\N	\N	\N
6613	EC Sao Jose Porto Alegre	Sao Bernardo	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218578995	f	\N	\N	\N
6620	Racing Santander	Albacete	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279055	f	\N	\N	\N
6614	Rayo Zuliano	Angostura FC	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218624153	f	\N	\N	\N
6619	Alcorcon	Huesca	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218278380	f	\N	\N	\N
6621	Burnley	Man Utd	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217895546	t	\N	\N	\N
6617	Uruguay de Coronado	Limon Black Star	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218640061	f	\N	\N	\N
6623	Botafogo PB	Paysandu	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218578905	f	\N	\N	\N
6616	Brest	Lyon	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965261	t	\N	\N	\N
6622	Almeria	Valencia	2023-09-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217928224	t	\N	\N	\N
6625	Provincial Osorno	Deportes Melipilla	2023-09-23 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218656277	f	\N	\N	\N
6626	FUS Rabat	USM Alger	2023-09-23 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218648610	f	\N	\N	\N
6627	Porto	Gil Vicente	2023-09-23 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218432446	f	\N	\N	\N
6629	Chapecoense	Ceara SC Fortaleza	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391845	f	\N	\N	\N
6632	Binacional	AD Cantolao	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218626595	f	\N	\N	\N
6633	Emelec	Mushuc Runa	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218397024	f	\N	\N	\N
6631	Sportivo Italiano	FC Midland	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218642225	f	\N	\N	\N
6630	CRB	Guarani	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218345950	f	\N	\N	\N
6628	Vancouver FC	HFX Wanderers	2023-09-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218571884	f	\N	\N	\N
6635	Chaco For Ever	Estudiantes de Caseros	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218492680	f	\N	\N	\N
6634	Colo Colo	Cobresal	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218018834	f	\N	\N	\N
6637	Tigres FC Zipaquira	Atletico FC Cali	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218582872	f	\N	\N	\N
6643	CD Trasandino	Real San Joaquin	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218656548	f	\N	\N	\N
6636	SCCM Chabab Mohamedia	Moghreb Tetouan	2023-09-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218649427	f	\N	\N	\N
6642	AD Guanacasteca	CS Cartagines	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218604891	f	\N	\N	\N
6645	Municipal Santa Ana	AD Aserri	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218644145	f	\N	\N	\N
6639	San Martin de Tucuman	CA Guemes	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218484788	f	\N	\N	\N
6640	Boyaca Chico	Rionegro	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218613629	f	\N	\N	\N
6644	Santa Tecla	Once Municipal	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625811	f	\N	\N	\N
6646	Boca Juniors	Lanus	2023-09-23 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218465151	f	\N	\N	\N
6641	Tombense MG	Botafogo SP	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218222768	f	\N	\N	\N
6647	Tacuary	Olimpia	2023-09-23 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218643197	f	\N	\N	\N
6648	Universidad de Venezuela	Puerto Cabello	2023-09-23 22:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218624243	f	\N	\N	\N
6650	Yalmakan FC	Aguacateros de Peribán F.C	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661542	f	\N	\N	\N
6649	UNIVERSIDAD O&M	Cibao FC	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650633	f	\N	\N	\N
6597	Grasshoppers Zurich	St Gallen	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959243	t	\N	\N	\N
6651	Nacional (Par)	Libertad	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643106	f	\N	\N	\N
6606	Lazio	AC Monza	2023-09-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217965881	t	\N	\N	\N
6656	Operario PR	Brusque FC	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218579085	f	\N	\N	\N
6655	Club CDM	Caja Oblatos C.FD	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661362	f	\N	\N	\N
6660	Llaneros FC	Real Santander	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218582782	f	\N	\N	\N
6657	Volta Redonda	Amazonas FC	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218579185	f	\N	\N	\N
6663	Halcones de Zapopan	Inter de Queretaro FC	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661812	f	\N	\N	\N
6659	Atlantico FC	Vega Real	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650542	f	\N	\N	\N
3419	NK Aluminij	NK Rogaska	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001568	f	\N	\N	\N
6654	Santamarina	Club Cipolletti	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648156	f	\N	\N	\N
6658	Chile (W)	New Zealand (W)	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218566722	f	\N	\N	\N
6664	Tuzos de la UAZ	Colima FC	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218653025	f	\N	\N	\N
6666	Club Sporting Canamy	Deportiva Venados	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649654	f	\N	\N	\N
6667	Real Cartagena	Quindio	2023-09-24 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218583005	f	\N	\N	\N
6662	Everton De Vina	Huachipato	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218022702	f	\N	\N	\N
6665	CA Liniers	Sol De Mayo	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218649744	f	\N	\N	\N
6661	Tecnico Universitario	Independiente (Ecu)	2023-09-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218416110	f	\N	\N	\N
6668	San Francisco FC	Arabe Unido	2023-09-24 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218579909	f	\N	\N	\N
6669	San Antonio FC	Orange County Blues	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218621027	f	\N	\N	\N
6673	CS Herediano	AD Municipal Liberia	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218604982	f	\N	\N	\N
6686	Chicago Fire	New England	2023-09-24 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424142	t	\N	\N	\N
6675	New York City	Toronto FC	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218422786	t	\N	\N	\N
6674	FC Cincinnati	Charlotte FC	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218422894	t	\N	\N	\N
6671	DC Utd	New York Red Bulls	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423388	t	\N	\N	\N
6676	Sport Recife	Londrina	2023-09-24 00:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218223146	f	\N	\N	\N
6672	Philadelphia	Los Angeles FC	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423182	t	\N	\N	\N
6677	Mexicali FC	Chihuahua FC	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661272	f	\N	\N	\N
6680	Central Cordoba (SdE)	Defensa y Justicia	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465259	f	\N	\N	\N
6682	Atletico MG	Cuiaba	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218081092	f	\N	\N	\N
6678	Alianza FC (SLV)	AD Isidro Metapan	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625541	f	\N	\N	\N
6679	Lobos ULMX	Cafetaleros de Chiapas II	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218651876	f	\N	\N	\N
6683	Portuguesa FC	Mineros Guayana	2023-09-24 01:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218624335	f	\N	\N	\N
6681	Huracan	Velez Sarsfield	2023-09-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218464933	f	\N	\N	\N
6684	Minnesota Utd	St Louis City SC	2023-09-24 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423628	f	\N	\N	\N
6685	Kansas City	Houston Dynamo	2023-09-24 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423788	f	\N	\N	\N
6690	Reboceros de La Piedad	Montaneses FC	2023-09-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661992	f	\N	\N	\N
6687	FC Dallas	Columbus	2023-09-24 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423936	t	\N	\N	\N
6689	Leon	Tijuana	2023-09-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217987684	f	\N	\N	\N
6691	Guadalajara	Pachuca	2023-09-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988046	f	\N	\N	\N
6692	America de Cali S.A	Atletico Nacional Medellin	2023-09-24 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218620248	f	\N	\N	\N
6688	Cd Fas	CD Aguila	2023-09-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625631	f	\N	\N	\N
6694	Real Salt Lake	Vancouver Whitecaps	2023-09-24 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424250	f	\N	\N	\N
6693	UMECIT	Tauro FC	2023-09-24 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218580359	f	\N	\N	\N
6697	LD Alajuelense	Santos de Guapiles	2023-09-24 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218604194	f	\N	\N	\N
6698	Portland Timbers	Colorado	2023-09-24 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424466	f	\N	\N	\N
6695	Guastatoya	Achuapa FC	2023-09-24 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625361	f	\N	\N	\N
6696	Tampico Madero	Escorpiones FC	2023-09-24 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661902	f	\N	\N	\N
6699	San Jose Earthquakes	Nashville SC	2023-09-24 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424358	f	\N	\N	\N
6700	Los Cabos United	CF Orgullo de Reynosa	2023-09-24 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661632	f	\N	\N	\N
6701	Tigres	Monterrey	2023-09-24 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217987775	f	\N	\N	\N
6703	ReinMeer Aomori	MIO Biwako Shiga	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528966	f	\N	\N	\N
6706	Okayama	Iwata	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343386	f	\N	\N	\N
6702	Sony Sendai FC	Kochi Univ	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528875	f	\N	\N	\N
6704	Shimizu	Kofu	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343476	f	\N	\N	\N
6670	Atlanta Utd	CF Montreal	2023-09-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218423520	t	\N	\N	\N
6705	Fukushima Utd	Sagamihara	2023-09-24 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522114	f	\N	\N	\N
6653	Deportivo Mixco	CSD Municipal	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625271	f	\N	\N	\N
6707	Gimpo Citizen	Chungnam Asan	2023-09-24 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218540216	f	\N	\N	\N
3499	HFX Wanderers	Atletico Ottawa	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218199019	f	\N	\N	\N
3480	Arenteiro	Real Union	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218233630	f	\N	\N	\N
6727	FS METTA/LU	FK Tukums 2000	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528604	f	\N	\N	\N
6235	Kenya Police FC	AFC Leopards SC (Kenya)	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218652072	f	\N	\N	\N
6750	Hessen Kassel	Bahlinger SC	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564809	f	\N	\N	\N
6240	1461 Trabzon	Afjet Afyonspor	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218660821	f	\N	\N	\N
6761	Bhayangkara FC	Persib Bandung	2023-09-23 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629567	f	\N	\N	\N
6259	Sapanca Genclikspor	Efeler 09	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218647263	f	\N	\N	\N
6311	Sao Joao Ver	Leixoes	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631365	f	\N	\N	\N
6394	CD Portosantense	CD Nacional Funchal	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218668938	f	\N	\N	\N
6426	Mansfield	Barrow	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209002	f	\N	\N	\N
6351	Stranraer	Forfar	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218379384	f	\N	\N	\N
6378	Dalkurd FF	United IK Nordic	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391558	f	\N	\N	\N
6329	Rotherham	Preston	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383849	f	\N	\N	\N
6427	Rushall Olympic	Scarborough Athletic	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218489256	f	\N	\N	\N
6909	Louletano	AVS Futebol SAD	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218682091	f	\N	\N	\N
6928	Weymouth	Chippenham	2023-09-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218337144	f	\N	\N	\N
6459	Al Wehdat	Shabab Al Ordon	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218631243	f	\N	\N	\N
6989	CD Illescas	CD Badajoz	2023-09-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635467	f	\N	\N	\N
6481	Cracovia Krakow	Pogon Szczecin	2023-09-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218302935	f	\N	\N	\N
6493	MFK Skalica	Dunajska Streda	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218142659	f	\N	\N	\N
7041	AD Union Adarve	CDE Ursaria	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635022	f	\N	\N	\N
6539	CA San Miguel	CA Colegiales	2023-09-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218632852	f	\N	\N	\N
6549	Coria CF	Puente Genil FC	2023-09-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218659029	f	\N	\N	\N
6587	AA Portuguesa U20	Agua Santa U20	2023-09-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637269	f	\N	\N	\N
6599	UAI Urquiza	Canuelas	2023-09-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218638080	f	\N	\N	\N
6638	Alianza FC (Pan)	CD Universitario	2023-09-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218580269	f	\N	\N	\N
6652	Aguacateros C.D.U. Uruapan	Club Deportivo Ayense	2023-09-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218661452	f	\N	\N	\N
6282	Skeid	Kongsvinger	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198389	t	\N	\N	\N
6283	Sogndal	Asane	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198479	t	\N	\N	\N
6287	Gefle	GAIS	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218421058	t	\N	\N	\N
6291	Skovde AIK	Ostersunds FK	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218386832	t	\N	\N	\N
6305	Jonkopings Sodra	Orgryte	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218386922	t	\N	\N	\N
6306	Hodd	Jerv	2023-09-23 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198569	t	\N	\N	\N
3566	Real Sociedad III	Real Zaragoza II	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252970	f	\N	\N	\N
7295	Haverfordwest County	Connahs Quay	2023-09-23 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218694609	f	\N	\N	\N
6509	CAP Ciudad de Murcia	Alcantarilla FC	2023-09-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218658266	f	\N	\N	\N
7698	Matsumoto	FC Gifu	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522204	f	\N	\N	\N
7699	Azul Claro Numazu	Tottori	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522384	f	\N	\N	\N
7700	FC Osaka	Kitakyushu	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521529	f	\N	\N	\N
7701	Kamatamare Sanuki	Yokohama SCC	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218522744	f	\N	\N	\N
7703	Melbourne City	Sydney FC	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218557435	f	\N	\N	\N
7704	Gwangju FC	Jeonbuk Motors	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406581	f	\N	\N	\N
7705	Kashima	Yokohama FM	2023-09-24 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159756	f	\N	\N	\N
7706	Kitchee SC	Hong Kong Rangers FC	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218669728	f	\N	\N	\N
7707	Tokushima	Omiya	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343566	f	\N	\N	\N
7708	Seoul E-Land FC	Ansan Greeners FC	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218514367	f	\N	\N	\N
7709	Shonan	Kawasaki	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159936	f	\N	\N	\N
7710	Tokyo-V	Fujieda MYFC	2023-09-24 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343656	f	\N	\N	\N
7711	Gangwon	Incheon Utd	2023-09-24 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218408060	f	\N	\N	\N
7712	Perserang Serang	Psim Yogyakarta	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694522	f	\N	\N	\N
7713	Putra Safin Group	Persikab Kabupateng Bandung	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694432	f	\N	\N	\N
7714	Persipa Pati	PSCS Cilacap	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698997	f	\N	\N	\N
7715	Deltras Sidoarjo	Gresik United	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698906	f	\N	\N	\N
7716	Levante UD II (W)	CD Juan Grande (W)	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709293	f	\N	\N	\N
7717	Kyrgyzstan U23	Chinese Taipei U23	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218613269	f	\N	\N	\N
7718	Real Murcia II	UCAM Murcia CF B	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218704759	f	\N	\N	\N
7719	PSS Sleman	Madura Utd	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673294	f	\N	\N	\N
7720	Chuncheon	Yangju Citizen	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550173	f	\N	\N	\N
7721	Melbourne Knights	Brisbane Roar	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218558219	f	\N	\N	\N
7722	G-Osaka	Urawa	2023-09-24 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218159666	f	\N	\N	\N
7723	Sigma Olomouc B	Lisen	2023-09-24 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218413508	f	\N	\N	\N
7724	PSMS Medan	Persiraja Banda Aceh	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218699087	f	\N	\N	\N
7725	FC Unirea Dej	Unirea Slobozia	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218526511	f	\N	\N	\N
7726	SV Horn	SK Sturm Graz II	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218341955	f	\N	\N	\N
7727	Malzenice	Pohronie	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218612812	f	\N	\N	\N
7728	Sparta Prague B	Vysocina Jihlava	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218413860	f	\N	\N	\N
7729	MSK Zilina II	Slovan Bratislava II	2023-09-24 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218612722	f	\N	\N	\N
7730	Albacete (W)	CF Union Viera (W)	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709383	f	\N	\N	\N
7731	Dortmund U19	Mgladbach U19	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218672934	f	\N	\N	\N
7732	MSV Duisburg U19	FC Schalke U19	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673024	f	\N	\N	\N
7733	Okzhetpes	FK Atyrau	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673654	f	\N	\N	\N
7734	FC Augsburg U19	1. FSV Mainz 05 U19	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673204	f	\N	\N	\N
7735	VfL Bochum U19	Wuppertaler SV U19	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218672844	f	\N	\N	\N
7736	Villarreal CF III	CD Acero	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218693838	f	\N	\N	\N
7737	Rayo Vallecano B	Leganes B	2023-09-24 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695500	f	\N	\N	\N
7738	Sevilla B	FC La Union Atletico	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636367	f	\N	\N	\N
7739	Real Oviedo (W)	Real Sociedad II (W)	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218709023	f	\N	\N	\N
7740	AC Torrellano	Levante UD II	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218693928	f	\N	\N	\N
7741	Getafe B	Gimnastica Segoviana CF	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218634833	f	\N	\N	\N
7742	FC Elva	Levadia Tallinn II	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613089	f	\N	\N	\N
7743	Trival Valderas Alcorcon	AD Alcorcon II	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218704957	f	\N	\N	\N
7744	Bucheon FC 1995	Gyeongnam	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218540036	f	\N	\N	\N
7745	Collado Villalba	Alcala RSD	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695603	f	\N	\N	\N
7746	Real Zaragoza II	SD Gernika Club	2023-09-24 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218633084	f	\N	\N	\N
7747	CD Fermarguin (W)	Elche CF (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709655	f	\N	\N	\N
7748	Balears FC (W)	CD Pradejon (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709203	f	\N	\N	\N
7749	Zaragoza CFF (W)	CA Osasuna II (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709473	f	\N	\N	\N
3192	Wolves	Liverpool	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217635221	f	\N	\N	\N
3328	FSV Frankfurt	Kickers Offenbach	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274430	f	\N	\N	\N
6197	Landskrona	Osters	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315138	t	\N	\N	\N
6194	Wehen Wiesbaden	Elversberg	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217942692	t	\N	\N	\N
6199	Greuther Furth	Karlsruhe	2023-09-23 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015083	t	\N	\N	\N
7750	FF La Solana (W)	Fundacion CD Tenerife (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709563	f	\N	\N	\N
7751	Racing Santander (W)	Bizkerre (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218709113	f	\N	\N	\N
7752	Melilla UD	Algeciras	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552868	f	\N	\N	\N
7753	Atletico Baleares	AD Ceuta FC	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552271	f	\N	\N	\N
7754	Mar Menor CF	Yeclano Deportivo	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636547	f	\N	\N	\N
7755	SCF Plaza Argel (W)	Real Betis II (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218710064	f	\N	\N	\N
7756	Real Union	CD Teruel	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551195	f	\N	\N	\N
7757	Santa Eulalia	Valencia-Mestalla	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673744	f	\N	\N	\N
7758	Ayamonte	Pozoblanco	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705894	f	\N	\N	\N
7759	Huetor Vega CD	Motril CF	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695705	f	\N	\N	\N
7760	UCAM Murcia	FC Cartagena II	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636097	f	\N	\N	\N
3481	Intercity Sant Joan C.F	San Fernando CD	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238496	f	\N	\N	\N
3543	New York City	New York Red Bulls	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938227	f	\N	\N	\N
3595	Orlando City	Columbus	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938747	f	\N	\N	\N
3606	AD Isidro Metapan	Fuerte San Francisco	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306953	f	\N	\N	\N
7761	SE Penya Independent	Cerdanyola del Valles	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635377	f	\N	\N	\N
7762	Castellon B	CD Roda	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695893	f	\N	\N	\N
7763	L' Hospitalet	Badalona	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705146	f	\N	\N	\N
7764	Lorca Deportiva CF	CD Algar	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218706217	f	\N	\N	\N
7765	Kumamoto	Tochigi SC	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343746	f	\N	\N	\N
7766	Daegu FC	Pohang Steelers	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417237	f	\N	\N	\N
7767	Giouchtas	Diagoras	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575953	f	\N	\N	\N
7768	SS Reyes	Talavera CF	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218634927	f	\N	\N	\N
7769	CD Alaves B	CD Brea	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218633282	f	\N	\N	\N
7770	UE Sant Andreu	Hercules	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635737	f	\N	\N	\N
7771	CD Diocesano	Moralo CP	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705245	f	\N	\N	\N
7772	CD Gerena	Conil FC	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705731	f	\N	\N	\N
7773	Las Rozas CF	AD Torrejon	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695803	f	\N	\N	\N
7774	CE Seagull (W)	Rayo Vallecano II (W)	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218710154	f	\N	\N	\N
7775	SD Logrones	CF Rayo Majadahonda	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551285	f	\N	\N	\N
7776	Deportivo La Coruna II	Arandina CF	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592266	f	\N	\N	\N
7777	Velez CF	CA Antoniano	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636187	f	\N	\N	\N
7778	CD Estepona	Marbella	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636277	f	\N	\N	\N
7779	El Palo	Orihuela CF	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636639	f	\N	\N	\N
7780	Guadalajara	UD San Fernando	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218640473	f	\N	\N	\N
7781	FC Carl Zeiss Jena U19	RB Leipzig U19	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218684017	f	\N	\N	\N
7782	CD Tenerife II	Club Atletico Victoria	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705551	f	\N	\N	\N
7783	CD Varea	CD Alfaro	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218706019	f	\N	\N	\N
7784	Cordoba CF II	CD Cabecense	2023-09-24 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705641	f	\N	\N	\N
7786	Zaglebie Lubin	Warta Poznan	2023-09-24 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218302845	f	\N	\N	\N
7787	Kasetsart FC	JL Chiangmai United	2023-09-24 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218673834	f	\N	\N	\N
7789	Wisla Plock	GKS Tychy	2023-09-24 11:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218399244	f	\N	\N	\N
7790	Air Force Central	Ratchaburi	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569005	f	\N	\N	\N
7791	Greifswalder SV 04	Hertha Berlin II	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560393	f	\N	\N	\N
7792	Stoke	Hull	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218383957	f	\N	\N	\N
7793	CD Marino	CD Buzanada	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695983	f	\N	\N	\N
7794	Valladolid B	Real Aviles	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592718	f	\N	\N	\N
7795	Rayong FC	Chiang Mai	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218682321	f	\N	\N	\N
7796	Utsiktens	Trelleborgs	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314778	f	\N	\N	\N
7797	FC Koln U19	Arminia Bielefeld U19	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218683927	f	\N	\N	\N
7798	Valmieras FK	FK Auda	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528423	f	\N	\N	\N
7799	Nurnberg U19	TSG Hoffenheim U19	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679971	f	\N	\N	\N
7800	Bayern Munich U19	TSV 1860 Munchen U19	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218680241	f	\N	\N	\N
7788	Empoli	Inter	2023-09-24 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217966003	t	\N	\N	\N
7801	Altglienicke	Cottbus	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565587	f	\N	\N	\N
7802	UD Las Palmas II	UD Teror Balompie	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218695375	f	\N	\N	\N
7803	Naestved	Hillerod Fodbold	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218440509	f	\N	\N	\N
7804	Metz	Strasbourg	2023-09-24 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217972848	f	\N	\N	\N
7805	South Korea U23	Bahrain U23	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613359	f	\N	\N	\N
7806	Iran U23	Mongolia U23	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613539	f	\N	\N	\N
7807	China U23	Bangladesh U23	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613449	f	\N	\N	\N
7812	SSV Ulm	Rot-Weiss Essen	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218416474	f	\N	\N	\N
7813	Genk	Sint Truiden	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218304560	f	\N	\N	\N
7814	Meuselwitz	Hansa Rostock II	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218565699	f	\N	\N	\N
7815	Qingdao Jonoon	Nantong Zhiyun F.C	2023-09-24 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218421495	f	\N	\N	\N
7816	Shenzhen FC	Zhejiang Greentown	2023-09-24 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218421383	f	\N	\N	\N
7817	Atyra FC	Rubio Nu	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218682001	f	\N	\N	\N
7818	Coimbra EC U20	America MG U20	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218729655	f	\N	\N	\N
7819	Norderstedt	SSV Jeddeloh	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560843	f	\N	\N	\N
7820	TSV Havelse	FC Phonix Lubeck	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560753	f	\N	\N	\N
7821	Liverpool U21	Wolves U21	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698345	f	\N	\N	\N
7822	Nairobi City Stars	Nzoia United FC	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681235	f	\N	\N	\N
7823	Blackburn U21	Aston Villa U21	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698435	f	\N	\N	\N
7824	Khonkaen United	Prachuap	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569095	f	\N	\N	\N
7825	Lampang FC	Customs United	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218682231	f	\N	\N	\N
7826	Ulinzi Stars	Sofapaka	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218703126	f	\N	\N	\N
7827	Aurora Pro Patria 1919	Triestina	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218605831	f	\N	\N	\N
7828	Teutonia 05 Ottensen	Hannover II	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560933	f	\N	\N	\N
7829	Novara	Giana Erminio	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218605921	f	\N	\N	\N
7830	SV Sandhausen U19	1. FC Heidenheim U19	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218680151	f	\N	\N	\N
7831	Hamburger SV U19	VfL Osnabruck U19	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218680061	f	\N	\N	\N
7832	Fortuna Dusseldorf II	Alemannia Aachen	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565480	f	\N	\N	\N
7833	Hegelmann Litauen	FK Siauliai	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218525481	f	\N	\N	\N
7834	Tobol Kostanay	FC Zhetysu	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681145	f	\N	\N	\N
7835	Alessandria	Lumezzane	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218606011	f	\N	\N	\N
7836	Kakamega Homeboyz	Gor Mahia FC	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218703216	f	\N	\N	\N
7838	KCB	Bandari FC (Kenya)	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218703035	f	\N	\N	\N
7840	Sandvikens	Bodens	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437321	f	\N	\N	\N
7841	TransINVEST Vilnius	FK Panevezys II	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681385	f	\N	\N	\N
7843	Real Sociedad	Getafe	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217927262	f	\N	\N	\N
7844	Zorya	Dnipro-1	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218621348	f	\N	\N	\N
7845	Villarreal B	Amorebieta	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218304807	f	\N	\N	\N
7846	Yverdon Sport	FC Basel	2023-09-24 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217958919	f	\N	\N	\N
7848	Kirsehir Belediyespor	Mersin Idman Yurdu	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218658462	f	\N	\N	\N
7849	Pitea	Taby FK	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218495219	f	\N	\N	\N
7809	Fortuna Dusseldorf	Hannover	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217943016	t	\N	\N	\N
7810	Kaiserslautern	Hansa Rostock	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218014651	t	\N	\N	\N
7811	Holstein Kiel	Hertha Berlin	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218014867	t	\N	\N	\N
7837	Brondby	FC Copenhagen	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158697	t	\N	\N	\N
7839	Silkeborg	Viborg	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158589	t	\N	\N	\N
7842	FC Helsingor	SonderjyskE	2023-09-24 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218423977	t	\N	\N	\N
7847	MVV Maastricht	De Graafschap	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218524617	t	\N	\N	\N
3265	RB Leipzig	Augsburg	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217628028	f	\N	\N	\N
3267	Mainz	Stuttgart	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217627788	f	\N	\N	\N
4226	Verspah Oita	Honda FC	2023-09-17 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342447	f	\N	\N	\N
4227	Sydney FC	Western United	2023-09-17 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217957756	f	\N	\N	\N
4228	Toyama	FC Osaka	2023-09-17 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218144252	f	\N	\N	\N
4229	FC Seoul	Gwangju FC	2023-09-17 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218392212	f	\N	\N	\N
4230	FC Tiamo Hirakata	Okinawa SV	2023-09-17 06:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218395361	f	\N	\N	\N
4231	Tokyo Musashino City	Kochi Univ	2023-09-17 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373773	f	\N	\N	\N
4232	Gangneung City	Yangju Citizen	2023-09-17 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218243153	f	\N	\N	\N
7853	Ruch Chorzow	Rakow Czestochowa	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303297	f	\N	\N	\N
7854	El Seka Elhadeed	La Viena FC	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711382	f	\N	\N	\N
7856	FK Jelgava	Rigas Futbola Skola	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528115	f	\N	\N	\N
7857	Athlitiki Enosi Larissa	Kampaniakos	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665864	f	\N	\N	\N
7858	Norrby IF	Lunds BK	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437230	f	\N	\N	\N
7859	MOL Vidi	Zalaegerszeg	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218181126	f	\N	\N	\N
7860	Vardar Skopje	FK Gostivar	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681565	f	\N	\N	\N
7861	Znicz Pruszkow	Stal Rzeszow	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406814	f	\N	\N	\N
7862	Panathinaikos B	Kalamata	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665546	f	\N	\N	\N
7863	FC Voska Sport	KF Shkupi	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707236	f	\N	\N	\N
7864	Kozani FC	Aiolikos Mytilene AFC	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665366	f	\N	\N	\N
7865	URSL Vise	K Sint-Eloois-Winkel	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678841	f	\N	\N	\N
7866	Hradec Kralove	FK Jablonec	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988770	f	\N	\N	\N
7867	AIK	Djurgardens	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218302481	f	\N	\N	\N
7868	Stal Stalowa Wola	Polonia Bytom	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218600147	f	\N	\N	\N
7869	FC Ordabasy	FC Astana	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681055	f	\N	\N	\N
7870	Plzen	Pardubice	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988410	f	\N	\N	\N
7872	Anagennisi Karditsas	AEK Athens B	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218576043	f	\N	\N	\N
7873	Orlando Pirates (SA)	Stellenbosch FC	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711568	f	\N	\N	\N
7874	Akademija Pandev	FK Sileks	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681475	f	\N	\N	\N
7875	Royal Knokke FC	Heist	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678751	f	\N	\N	\N
7877	Itrottarfelag Fuglafjaroar	AB Argir	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679524	f	\N	\N	\N
7878	Fremad Amager	Skive	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679111	f	\N	\N	\N
7879	CSF Spartanii	FC Milsami-Ursidos	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218701009	f	\N	\N	\N
7882	Bandirmaspor	Genclerbirligi	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436408	f	\N	\N	\N
7885	Shkendija	FK Makedonija	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681811	f	\N	\N	\N
7886	Mjallby	IFK Goteborg	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218168174	f	\N	\N	\N
7888	FC Sabah	Kapaz Ganja	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664242	f	\N	\N	\N
7889	SC Spelle Venhaus	FC Kilia Kiel 1902	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560663	f	\N	\N	\N
7891	Le Havre	Clermont	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218000865	f	\N	\N	\N
7894	Tilikratis Lefkadas	Egaleo	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665726	f	\N	\N	\N
7895	Selangor FA	Terengganu	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218701102	f	\N	\N	\N
7896	Shabab Sahel	Al-Ahed	2023-09-24 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218644891	f	\N	\N	\N
7897	Leverkusen	FC Heidenheim	2023-09-24 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217890590	f	\N	\N	\N
7898	Fjolnir	IF Vestri	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599876	f	\N	\N	\N
7899	Afturelding	Leiknir R	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599786	f	\N	\N	\N
7900	San Fernando CD	Real Murcia	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552687	f	\N	\N	\N
7901	NK Croatia Zmijavci	Vukovar	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569185	f	\N	\N	\N
7903	Cercle Brugge	Union St Gilloise	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218304452	f	\N	\N	\N
7904	Umea FC	Vasalunds IF	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437503	f	\N	\N	\N
7905	Lusitano	Covilha	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718379	f	\N	\N	\N
7906	Ribeirao	Santa Clara	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718199	f	\N	\N	\N
7907	Besiktas	Kayserispor	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218199744	f	\N	\N	\N
7908	Budafoki	Tiszakecske VSE	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461278	f	\N	\N	\N
7852	Ajax	Feyenoord	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940505	t	\N	\N	\N
4275	Ulsan Citizen FC	Siheung Citizen	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218243513	f	\N	\N	\N
7855	Raufoss	Sandnes Ulf	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198839	t	\N	\N	\N
7871	Start	Moss	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198929	t	\N	\N	\N
7876	Atalanta	Cagliari	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218019305	t	\N	\N	\N
7880	Lens	Toulouse	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217964661	t	\N	\N	\N
7881	KFUM Oslo	Mjondalen	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198749	t	\N	\N	\N
7883	Brighton	Bournemouth	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217895828	t	\N	\N	\N
7884	Liverpool	West Ham	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217896327	t	\N	\N	\N
7887	Bryne	Kristiansund	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198659	t	\N	\N	\N
7890	Udinese	Fiorentina	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965621	t	\N	\N	\N
7892	Chelsea	Aston Villa	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217901835	t	\N	\N	\N
7893	Arsenal	Tottenham	2023-09-24 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217895687	t	\N	\N	\N
7902	Sunderland	Cardiff	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384065	t	\N	\N	\N
7909	Keflavik	HK Kopavogur	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521439	f	\N	\N	\N
7910	KR Reykjavik	Valur	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521259	f	\N	\N	\N
7911	MTE 1904	Kozarmisleny	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461369	f	\N	\N	\N
7912	Dumiense CJP II Futebol	Santarem	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218731023	f	\N	\N	\N
7913	Aberdeen	Ross Co	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217937775	f	\N	\N	\N
7914	GD Peniche	Cultural Montalegre	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718649	f	\N	\N	\N
7915	GD Vitoria de Sernache	SC Vianense	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718289	f	\N	\N	\N
7916	Juventude	Su Sintrense	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718739	f	\N	\N	\N
7917	Mortagua FC	Amora FC	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718559	f	\N	\N	\N
7918	Valadares Gaia	Penafiel	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218717929	f	\N	\N	\N
7919	Waasland-Beveren	FC Liege	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612999	f	\N	\N	\N
7920	B68 Toftir	EB/Streymur	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679337	f	\N	\N	\N
7921	IF Sylvia	FC Stockholm Internazionale	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218437412	f	\N	\N	\N
7922	Hafnarfjordur	Stjarnan	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218440419	f	\N	\N	\N
7923	Olympiakos	Kifisias FC	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217992912	f	\N	\N	\N
7924	Randers	AGF	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339652	f	\N	\N	\N
7925	Sertanense	Amarante	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718109	f	\N	\N	\N
7926	Vikingur Gota	07 Vestur	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679434	f	\N	\N	\N
7927	Zvijezda 09 Bijeljina	Nk Posusje	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664512	f	\N	\N	\N
7928	Rangers	Motherwell	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217939072	f	\N	\N	\N
7929	Atletico Mitre	Brown de Adrogue	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218492500	f	\N	\N	\N
7930	1 Dezembro	Pacos Ferreira	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718019	f	\N	\N	\N
7931	Atletico Clube de Portugal	Alverca	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718829	f	\N	\N	\N
7932	FC Barreirense	Mirandela	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718469	f	\N	\N	\N
7933	CA Osasuna II	Union de Salamanca	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551807	f	\N	\N	\N
7934	Recreativa de Lamelas	FC Tirsense	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218718919	f	\N	\N	\N
7935	Ankaragucu	Konyaspor	2023-09-24 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218189712	f	\N	\N	\N
7936	LR Vicenza Virtus	Pergolettese	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218605651	f	\N	\N	\N
7937	SSD Bari	Catanzaro	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218402883	f	\N	\N	\N
7938	Parma	Sampdoria	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218403063	f	\N	\N	\N
7939	Oviedo	Valladolid	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218278875	f	\N	\N	\N
7940	Cittadella	Como	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218402973	f	\N	\N	\N
7942	Northeast United	Mumbai City FC	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218435915	f	\N	\N	\N
7943	CD Galapagar	AD Parla	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218707008	f	\N	\N	\N
7945	Club Sportif Sfaxien	Sportive de Tunis	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218703401	f	\N	\N	\N
7946	CDA Navalcarnero	AD Llerenense	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218635287	f	\N	\N	\N
7947	CD Huetor Tajar	CD Torreperogil	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218706918	f	\N	\N	\N
7948	Monastir	ES Metlaoui	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218703310	f	\N	\N	\N
7950	Aris	Panaitolikos	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993094	f	\N	\N	\N
7951	SJK	HJK Helsinki	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218431104	f	\N	\N	\N
7952	Freiburg II	Ingolstadt	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218417327	f	\N	\N	\N
7953	CA Bizertin	US Tataouine	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218703491	f	\N	\N	\N
7957	VMFD Zalgiris	FK Kauno Zalgiris	2023-09-24 15:55:00	https://www.orbitxch.com/customer/sport/1/market/1.218525571	f	\N	\N	\N
7958	Deportes Concepcion	Linares	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679021	f	\N	\N	\N
7959	Numancia	CD Atletico Paso	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635647	f	\N	\N	\N
7960	Haras El Hodood	Abo Qair Semads	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711476	f	\N	\N	\N
7963	Vasas	Gyirmot	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461188	f	\N	\N	\N
7964	Lleida	Club Atletico Saguntino	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635557	f	\N	\N	\N
7967	FC Ajka	Siofok	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461459	f	\N	\N	\N
4333	St Pauli	Holstein Kiel	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217704656	f	\N	\N	\N
7944	Luzern	Servette	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959135	t	\N	\N	\N
7949	Young Boys	Lugano	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959027	t	\N	\N	\N
7954	Chaves	Club Football Estrela	2023-09-24 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218471150	t	\N	\N	\N
7955	RKC Waalwijk	FC Twente	2023-09-24 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217940613	t	\N	\N	\N
7956	PEC Zwolle	Az Alkmaar	2023-09-24 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217939674	t	\N	\N	\N
7961	Bodo Glimt	Valerenga	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064683	t	\N	\N	\N
7962	Odds BK	Haugesund	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064143	t	\N	\N	\N
7965	Lillestrom	Rosenborg	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064251	t	\N	\N	\N
7966	Stromsgodset	Molde	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218063943	t	\N	\N	\N
7968	Dila Gori	Samgurali Tskaltubo	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679881	f	\N	\N	\N
7969	Kazincbarcika	BVSC Zuglo	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461098	f	\N	\N	\N
7971	Szeged 2011	Nyiregyhaza	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461008	f	\N	\N	\N
7973	Sevilla FC III	Xerez Deportivo FC	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708015	f	\N	\N	\N
7975	CD Soneja	UD Rayo Ibense	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696399	f	\N	\N	\N
7976	Lyn	Floy Flekkeroy	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218698815	f	\N	\N	\N
7977	CD Calahorra B	SD Oyonesa	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707925	f	\N	\N	\N
7978	CD Llosetense	UD Poblense	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708105	f	\N	\N	\N
7979	CD Quintanar del Rey	CD Puertollano	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708467	f	\N	\N	\N
7980	Slaven Belupo	Rijeka	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218432230	f	\N	\N	\N
7981	Pirin Blagoevgrad	Levski Krumovgrad	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032207	f	\N	\N	\N
7982	Pecs MFC	Csakvar	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218460918	f	\N	\N	\N
7983	CD Toledo	UB Conquense	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707745	f	\N	\N	\N
7984	CD Fuentes	CD Illueca	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707835	f	\N	\N	\N
7986	ACS Petrolul 52	Hermannstadt	2023-09-24 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218257806	f	\N	\N	\N
7987	Legia Warsaw	Gornik Zabrze	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218303207	f	\N	\N	\N
7988	CD Cayon	Pontevedra CF	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218592536	f	\N	\N	\N
7989	Ferencvaros	Kisvarda	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218180946	f	\N	\N	\N
7990	CD Belchite 97	CF Calamocha	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218694703	f	\N	\N	\N
7991	Slovan Bratislava	Zilina	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218201068	f	\N	\N	\N
7992	CD Minera	Montecasillas FC	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695285	f	\N	\N	\N
7993	CD Don Alvaro	CF Trujillo	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695195	f	\N	\N	\N
7996	AD Almudevar	CD Carinena	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218694886	f	\N	\N	\N
7997	CDFC La Calzada	Club Haro Deportivo	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695015	f	\N	\N	\N
7999	Sabail	Araz Nakhchivan PFK	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218664332	f	\N	\N	\N
8000	RCP Valverdeno	CF Jaraiz	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218695105	f	\N	\N	\N
8002	LKS Lodz II	Olimpia Elblag	2023-09-24 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218600238	f	\N	\N	\N
8003	Linares Deportivo	Malaga	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552545	f	\N	\N	\N
8004	Barakaldo	CD Calahorra	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218633372	f	\N	\N	\N
8005	East Riffa	Al Ahli (BRN)	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678661	f	\N	\N	\N
8006	FC Saburtalo Tbilisi	FC Telavi	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679791	f	\N	\N	\N
8007	Spartak Trnava	Ruzomberok	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218201158	f	\N	\N	\N
8008	Leioa	Pasaia Kirol Elkartea	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694110	f	\N	\N	\N
8009	UE Vilassar de Mar	UE Castelldefels	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694020	f	\N	\N	\N
8010	Sitra	Al Khalidiyah	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678571	f	\N	\N	\N
8012	Zaglebie Sosnowiec	Nieciecza	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218399639	f	\N	\N	\N
8013	Sliema Wanderers FC	Valletta	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529507	f	\N	\N	\N
8014	Viimsi JK	Tallinna JK Legion	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218613179	f	\N	\N	\N
8016	Adanaspor	Erzurum BB	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436318	f	\N	\N	\N
8017	Becerril	Salamanca UDS	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696516	f	\N	\N	\N
8018	CD Llanera	CD Llanes	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218694200	f	\N	\N	\N
8019	Pena Balsamaiso	CCD Alberite	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708557	f	\N	\N	\N
8020	UD Castellonense	CD Utiel	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696620	f	\N	\N	\N
8021	Raja Beni Mellal	Olympique Khouribga	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218702939	f	\N	\N	\N
8022	Villanovense	UD Montijo	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636007	f	\N	\N	\N
8023	Slavia Prague	Sparta Prague	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217985914	f	\N	\N	\N
8024	CD Izarra	Athletic Bilbao B	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218633174	f	\N	\N	\N
8025	Ponferradina	Fuenlabrada	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551897	f	\N	\N	\N
7972	Ham-Kam	Sarpsborg	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218063835	t	\N	\N	\N
7974	Viking	Sandefjord	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218064467	t	\N	\N	\N
7985	Montpellier	Rennes	2023-09-24 16:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217965021	t	\N	\N	\N
4390	Birmingham (W)	Charlton (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373322	f	\N	\N	\N
7994	Sheff Utd	Newcastle	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217896468	t	\N	\N	\N
7995	Varbergs BoIS	Hammarby	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218160277	t	\N	\N	\N
7998	Kalmar FF	Hacken	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218158946	t	\N	\N	\N
8001	Eintracht Frankfurt	Freiburg	2023-09-24 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217890840	t	\N	\N	\N
8011	Bologna	Napoli	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217965743	t	\N	\N	\N
8015	Midtjylland	OB	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158805	t	\N	\N	\N
8026	Zimbru Chisinau	Sheriff Tiraspol	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681911	f	\N	\N	\N
8027	CF Platges de Calvia	CE Constancia de Inca	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218708647	f	\N	\N	\N
8028	Sanliurfaspor	Kocaelispor	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520534	f	\N	\N	\N
8029	Linense	Aguilas	2023-09-24 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635827	f	\N	\N	\N
8030	CD Estradense	Silva SD	2023-09-24 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218694290	f	\N	\N	\N
8031	Mantova	Albinoleffe	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218605346	f	\N	\N	\N
8032	Padova	SS Virtus Verona 1921	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218605561	f	\N	\N	\N
8033	Club Africain	Stade Tunisien	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218682638	f	\N	\N	\N
8034	CF Badalona Futur	Centre d'Esports Manresa	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218635019	f	\N	\N	\N
8035	FC Legnago	Renate	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218605741	f	\N	\N	\N
8036	SSD Pro Sesto	Arzignanochiampo	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218605253	f	\N	\N	\N
8037	USD Sestri Levante 1919	Sassari Torres	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218622024	f	\N	\N	\N
8038	Mirandes	Leganes	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218278785	f	\N	\N	\N
8039	RS Gimnastica	SD Rayo Cantabria	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218592356	f	\N	\N	\N
8040	Betis	Cadiz	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217928103	f	\N	\N	\N
8041	Las Palmas	Granada	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217927142	f	\N	\N	\N
8043	CA Atlanta	Ferro Carril Oeste	2023-09-24 17:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218485397	f	\N	\N	\N
8044	Saint George FC	Al Ahly Cairo	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218707146	f	\N	\N	\N
8046	Ionikos	PAE Chania	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218680331	f	\N	\N	\N
8047	Dinamo Batumi	Dinamo Tbilisi	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679616	f	\N	\N	\N
8048	Celta Vigo B	Arenteiro	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551987	f	\N	\N	\N
8049	Arenas Armilla	Real Jaen	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711198	f	\N	\N	\N
8050	Fylkir	KA Akureyri	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521349	f	\N	\N	\N
8051	Kasimpasa	Adana Demirspor	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218203579	f	\N	\N	\N
8053	Torrent CF	La Nucia	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218635197	f	\N	\N	\N
8054	Comunicaciones	Deportivo Coatepeque	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625451	f	\N	\N	\N
8055	Municipal Turrialba	Futbol Consultants Moravia	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218684108	f	\N	\N	\N
8056	General Lamadrid	Excursionistas	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218684198	f	\N	\N	\N
8045	NFC Volos	Asteras Tripolis	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217993488	f	\N	\N	\N
8062	Rudes	Dinamo Zagreb	2023-09-24 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218439199	f	\N	\N	\N
8063	Dynamo Dresden	Erzgebirge	2023-09-24 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218416294	f	\N	\N	\N
8064	PAS Giannina	PAOK	2023-09-24 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993813	f	\N	\N	\N
8065	Lokomotiv Sofia	Ludogorets	2023-09-24 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218032387	f	\N	\N	\N
8066	Gimnastic	Sabadell	2023-09-24 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218551451	f	\N	\N	\N
8067	Zrinjski	Zeljeznicar	2023-09-24 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218586235	f	\N	\N	\N
8068	Gyori	Haladas	2023-09-24 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218460828	f	\N	\N	\N
8069	Atletico Sanluqueno CF	Antequera CF	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552777	f	\N	\N	\N
8070	Alcoyano	Cordoba	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218552432	f	\N	\N	\N
8071	Santos U20	Ferroviaria DE U20	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218678931	f	\N	\N	\N
8072	Cruzeiro U20	Atletico MG U20	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218729565	f	\N	\N	\N
8073	Club Gimnasia y Tiro	9 de Julio Rafaela	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218686121	f	\N	\N	\N
8074	CA Tarazona	Barcelona B	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218551541	f	\N	\N	\N
8075	CA Independiente	Instituto	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218464711	f	\N	\N	\N
8076	Sportivo AC Las Parejas	Club Defensores de P	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218686031	f	\N	\N	\N
8077	Atletico Ottawa	Valour	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569275	f	\N	\N	\N
8078	Toluca	CF America	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217987866	f	\N	\N	\N
8079	Gudja United	Marsaxlokk FC	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529326	f	\N	\N	\N
8080	Tristan Suarez	Gimnasia Jujuy	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218485097	f	\N	\N	\N
8081	Asociacion Deportiva Tarma	Alianza Atletico	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218634721	f	\N	\N	\N
8082	ACS Sepsi OSK	FCSB	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218257354	f	\N	\N	\N
8083	Deportes Copiapo	Universidad de Chile	2023-09-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218005524	f	\N	\N	\N
8042	Anderlecht	Club Brugge	2023-09-24 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218225307	t	\N	\N	\N
8052	New York City	Toronto FC	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218422786	t	\N	\N	\N
8057	Portimonense	Benfica	2023-09-24 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218466082	t	\N	\N	\N
4450	Como	Ternana	2023-09-17 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217943487	f	\N	\N	\N
8059	Gent	Eupen	2023-09-24 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218225199	t	\N	\N	\N
8060	Lierse	Kfco Beerschot Wilrijk	2023-09-24 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218437683	t	\N	\N	\N
8061	Brann	Tromso	2023-09-24 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218064359	t	\N	\N	\N
8084	NK Maribor	Koper	2023-09-24 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218429725	f	\N	\N	\N
8085	Raja Casablanca	Union de Touarga	2023-09-24 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218697037	f	\N	\N	\N
8086	Justo Jose de Urquiza	Deportivo Laferrere	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218687509	f	\N	\N	\N
8087	CSD Liniers de Ciudad Evita	Leandro N Alem	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218687599	f	\N	\N	\N
8088	Sansinena	Olimpo	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218686301	f	\N	\N	\N
8089	G, Brown	San Martin Juan	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218485700	f	\N	\N	\N
8090	Almagro BA	Alvarado	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218492410	f	\N	\N	\N
8091	Sacachispas	Argentino de Quilmes	2023-09-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218686825	f	\N	\N	\N
8092	Villa Mitre	CA Germinal	2023-09-24 19:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218686211	f	\N	\N	\N
8093	Avellino	Monopoli	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218656949	f	\N	\N	\N
8094	Crotone	Sorrento	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218657039	f	\N	\N	\N
8095	Potenza	Casertana	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218656859	f	\N	\N	\N
8097	USFrancavilla Calcio	ACR Messina	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218657218	f	\N	\N	\N
8098	Atalanta B	Pro Vercelli	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218656765	f	\N	\N	\N
8099	Torino	Roma	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217966244	f	\N	\N	\N
8100	Nueva Chicago	Deportivo Moron	2023-09-24 19:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218492230	f	\N	\N	\N
8101	Sao Paulo	Flamengo	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218460705	f	\N	\N	\N
8102	Gimnasia Conc del Uruguay	Sportivo Belgrano	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218687133	f	\N	\N	\N
8103	Cumbaya FC	Aucas	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218440599	f	\N	\N	\N
8104	Municipal Garabito	ADR Jicaral	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696848	f	\N	\N	\N
8107	CA Douglas Haig	CA Union de Sunchales	2023-09-24 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218693657	f	\N	\N	\N
8108	Racing Cordoba	Deportivo Riestr	2023-09-24 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218485790	f	\N	\N	\N
8109	Sport Boys (Per)	Universidad Cesar Vallejo	2023-09-24 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218634274	f	\N	\N	\N
8110	C J Antoniana	Boca Unidos	2023-09-24 21:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218693747	f	\N	\N	\N
8111	Melgar	Union Comercio	2023-09-24 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218634184	f	\N	\N	\N
8112	Univ Catolica (Chile)	Magallanes	2023-09-24 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218005254	f	\N	\N	\N
8113	Metropolitanos	Deportivo La Guaira	2023-09-24 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218624515	f	\N	\N	\N
8114	RSB Berkane	Wydad Casablanca	2023-09-24 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218697691	f	\N	\N	\N
8115	Newells	Estudiantes	2023-09-24 21:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218466479	f	\N	\N	\N
8116	San Diego Loyal SC	Las Vegas Lights FC	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218621117	f	\N	\N	\N
8117	Fuerte San Francisco	Jocoro	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629207	f	\N	\N	\N
8118	Envigado	Millonarios	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629747	f	\N	\N	\N
8119	CD Dragon	Platense Zacatecoluca	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625721	f	\N	\N	\N
8120	Estudiantes Rio Cuarto	Defensores de Belgrano	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218492320	f	\N	\N	\N
8121	Atletico Chiriqui	Costa del Este	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218579999	f	\N	\N	\N
8122	CD Marathon	Olancho	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218730375	f	\N	\N	\N
8123	Puntarenas F.C.	Municipal Perez Zeledon	2023-09-24 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450446	f	\N	\N	\N
8124	CD Luis Angel Firpo	CD Municipal Limeno	2023-09-24 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218629387	f	\N	\N	\N
8125	Guarani (Par)	Sportivo Luqueno	2023-09-24 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218643016	f	\N	\N	\N
8126	Delfin	Guayaquil City	2023-09-24 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218394837	f	\N	\N	\N
8127	Club Sportivo Ameliano	Club Sportivo Trinidense	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218642828	f	\N	\N	\N
8128	Cruz Azul	Queretaro	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217987594	f	\N	\N	\N
8129	Aldosivi	Villa Dalmine	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218485217	f	\N	\N	\N
8130	Escorpiones FC	AD Cariari Pococi	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218696939	f	\N	\N	\N
8131	Tigre	San Lorenzo	2023-09-24 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465758	f	\N	\N	\N
8132	Carlos Mannucci	Alianza Lima	2023-09-24 23:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218634364	f	\N	\N	\N
8133	Huehueteco Xinabajul	Malacateco	2023-09-25 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625001	f	\N	\N	\N
8134	CD Olimpia	CD Real Sociedad	2023-09-25 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218715944	f	\N	\N	\N
8136	Monagas	Deportivo Tachira	2023-09-25 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218624425	f	\N	\N	\N
8137	Santa Fe	Deportivo Pereira	2023-09-25 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218626685	f	\N	\N	\N
8138	Herrera FC	Sporting San Miguelito	2023-09-25 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218580179	f	\N	\N	\N
8105	Atletico Madrid	Real Madrid	2023-09-24 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217927502	t	\N	\N	\N
8106	Braga	Boavista	2023-09-24 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218465866	t	\N	\N	\N
8139	Orlando City	Inter Miami CF	2023-09-25 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218422599	t	\N	\N	\N
8135	Audax Italiano	Union La Calera	2023-09-25 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218013077	f	\N	\N	\N
4510	Genclerbirligi	Eyupspor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218078954	f	\N	\N	\N
8140	Deportivo Cuenca	Barcelona (Ecu)	2023-09-25 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450266	f	\N	\N	\N
8141	Banfield	River Plate	2023-09-25 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465650	f	\N	\N	\N
8142	Sporting San Jose FC	Deportivo Saprissa	2023-09-25 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218605073	f	\N	\N	\N
8143	Tapatio	CD Tepatitlan de Morelos	2023-09-25 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461549	f	\N	\N	\N
8144	Deportivo Garcilaso	Cienciano	2023-09-25 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218634544	f	\N	\N	\N
8145	Genesis Huracan	Vida	2023-09-25 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218715764	f	\N	\N	\N
8146	Junior FC Barranquilla	Tolima	2023-09-25 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218641433	f	\N	\N	\N
8148	Xelaju	Coban Imperial	2023-09-25 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625091	f	\N	\N	\N
8149	Santos Laguna	Necaxa	2023-09-25 03:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217987956	f	\N	\N	\N
8147	Austin FC	LA Galaxy	2023-09-25 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218424672	t	\N	\N	\N
4617	JS Saoura	US Biskra	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218370803	f	\N	\N	\N
7702	Suwon FC	Ulsan Hyundai Horang-i	2023-09-24 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406491	t	\N	\N	\N
8150	Persekat Kabupaten Tegal	Persela Lamongan	2023-09-25 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218736659	f	\N	\N	\N
8151	Mataram Utama	PSKC Cimahi	2023-09-25 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218737000	f	\N	\N	\N
8152	Bangladesh (W)	Vietnam (W)	2023-09-25 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218766720	f	\N	\N	\N
8153	PSDS Deli Serdang	Sriwijaya	2023-09-25 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218736838	f	\N	\N	\N
8154	Palestine U23	Japan U23	2023-09-25 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218622605	f	\N	\N	\N
8155	Philippines (W)	South Korea (W)	2023-09-25 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218766630	f	\N	\N	\N
8156	Nepal (W)	Japan (W)	2023-09-25 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218766540	f	\N	\N	\N
8157	Police Tero	Buriram Utd	2023-09-25 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218569365	f	\N	\N	\N
8158	PSPS Pekanbaru	Semen Padang	2023-09-25 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218776777	f	\N	\N	\N
8159	Bristol City U21	Ipswich Town U21	2023-09-25 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218736217	f	\N	\N	\N
8160	Wigan Athletic U21	Burnley U21	2023-09-25 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218736307	f	\N	\N	\N
8161	Pusamania Borneo FC	PSM Makassar	2023-09-25 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218673384	f	\N	\N	\N
8162	Molde II	Hamarkameratene II	2023-09-25 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218756664	f	\N	\N	\N
8163	Bangkok Utd	BG Pathumthani United	2023-09-25 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569455	f	\N	\N	\N
8164	Nasr Taaden	Asyut Petroleum	2023-09-25 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218773941	f	\N	\N	\N
8165	Polokwane City	AmaZulu	2023-09-25 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599426	f	\N	\N	\N
8166	PAOK B	Apollon Kalamaria FC	2023-09-25 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665456	f	\N	\N	\N
8167	National Bank	Pyramids	2023-09-25 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218619978	f	\N	\N	\N
8168	NK Dubrava Zagreb	NK Jarun	2023-09-25 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218567977	f	\N	\N	\N
8169	NK Bilje	Rudar	2023-09-25 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218736127	f	\N	\N	\N
8170	Baerum	Brann II	2023-09-25 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218735947	f	\N	\N	\N
8171	Tromsdalen	Stromsgodset II	2023-09-25 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218735857	f	\N	\N	\N
8172	Quess East Bengal	Jamshedpur FC	2023-09-25 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218484287	f	\N	\N	\N
8173	Mandalskameratene	Sandefjord II	2023-09-25 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218756574	f	\N	\N	\N
8174	Famalicao U23	Academico de Viseu U23	2023-09-25 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218747487	f	\N	\N	\N
8175	CSA Steaua Bucuresti	Csm Slatina	2023-09-25 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218573242	f	\N	\N	\N
8176	FK Riga	Liepajas Metalurgs	2023-09-25 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528514	f	\N	\N	\N
8177	FK Qabala	Qarabag Fk	2023-09-25 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218773761	f	\N	\N	\N
8178	FK Kauno Zalgiris 2	Marijampole City	2023-09-25 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218747847	f	\N	\N	\N
8179	Zamalek	Al Mokawloon	2023-09-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218617394	f	\N	\N	\N
8181	Vanlose U21	Snekkersten IF U21	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218774555	f	\N	\N	\N
8187	Ullern 2	Frigg	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218759886	f	\N	\N	\N
4461	Cambuur Leeuwarden	Willem II	2023-09-17 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218138697	f	\N	\N	\N
8193	Hatayspor	Trabzonspor	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218189226	f	\N	\N	\N
8192	B36 Torshavn	HB Torshavn	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218747941	f	\N	\N	\N
8184	FK Napredak	Cukaricki	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599516	f	\N	\N	\N
8191	Varnamo	Sirius	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218302574	t	\N	\N	\N
8182	Donn	Start 2	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218756484	f	\N	\N	\N
8183	Lillestrom SK 2	Skedsmo	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218759976	f	\N	\N	\N
8185	Lokomotiv Oslo	Stabaek II	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218756394	f	\N	\N	\N
8194	Altay	Bodrum Bel	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218495126	f	\N	\N	\N
8190	Halmstads	Elfsborg	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218302665	t	\N	\N	\N
8189	Valerenga II	Notodden	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218736037	f	\N	\N	\N
8186	Tronder Lyn	Rosenborg II	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218756304	f	\N	\N	\N
8196	Aarau	FC Vaduz	2023-09-25 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218520989	f	\N	\N	\N
8195	Patro Maasmechelen U21	K Lierse U21	2023-09-25 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218773851	f	\N	\N	\N
8197	Mageense FC	Belford Roxo Futebol Clube	2023-09-25 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218748184	f	\N	\N	\N
8201	West Brom U21	Fulham U21	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218765186	f	\N	\N	\N
8202	Grotta/Kria U19	Keflavik/Reynir	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218759465	f	\N	\N	\N
8199	Haukar Hafnarfjordur U19	UMFN Njarovik U19	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218775023	f	\N	\N	\N
8198	Stoke U21	Tottenham U21	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218765096	f	\N	\N	\N
8203	Deportivo Municipal	Cusco FC	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637539	f	\N	\N	\N
8200	Odds Ballklubb 2	Askollen FK	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218759796	f	\N	\N	\N
8204	Queens Park Rangers U21	Swansea U21	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218747667	f	\N	\N	\N
8188	FC Nordsjaelland	Hvidovre	2023-09-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339762	t	\N	\N	\N
7785	Sparta Rotterdam	Vitesse Arnhem	2023-09-24 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217939506	t	\N	\N	\N
8210	Sunderland U21	Derby U21	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218765276	f	\N	\N	\N
8208	Rapid Bucharest	CFR Cluj	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218257534	f	\N	\N	\N
8205	Panathinaikos	AEK Athens	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217992714	f	\N	\N	\N
8235	Coventry	Huddersfield	2023-09-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384218	t	\N	\N	\N
8207	Hull City U21	Coventry City U21	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218747577	f	\N	\N	\N
8211	Stirling University	Albion	2023-09-25 19:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218737990	f	\N	\N	\N
4629	Flamengo	Sao Paulo	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217730501	f	\N	\N	\N
4646	Coban Imperial	Comunicaciones	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299233	f	\N	\N	\N
8213	Sion	Thun	2023-09-25 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218520899	f	\N	\N	\N
8214	Mouloudia dOujda	FAR Rabat	2023-09-25 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218735767	f	\N	\N	\N
8212	GKS Jastrzebie	Olimpia Grudziadz	2023-09-25 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218599606	f	\N	\N	\N
8215	CS Dock Sud	Comunicaciones B Aires	2023-09-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218748274	f	\N	\N	\N
8216	Independiente Chivilcoy	Def Belgrano VR	2023-09-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218748094	f	\N	\N	\N
8217	CD MAIPU	Deportivo Madryn	2023-09-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218492590	f	\N	\N	\N
8218	Club Lujan	CSD Yupanqui	2023-09-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218748364	f	\N	\N	\N
8227	Cliftonville FC U20	Crusaders FC U20	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218756878	f	\N	\N	\N
8224	Galway Utd	Finn Harps	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218522024	f	\N	\N	\N
8221	Wexford F.C	Longford	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218521934	f	\N	\N	\N
8225	Audace Cerignola	Juve Stabia	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218768250	f	\N	\N	\N
8228	FC Giugliano	US Latina Calcio	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218768340	f	\N	\N	\N
8223	Nuova Monterosi	Taranto Sport	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218768520	f	\N	\N	\N
8230	Dundalk	Cork City	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218539002	f	\N	\N	\N
8220	St Patricks	Drogheda	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218538912	f	\N	\N	\N
8226	Brindisi	Benevento	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218768070	f	\N	\N	\N
8229	Carshalton Athletic FC	Hashtag United	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218759645	f	\N	\N	\N
8219	Bohemians	Shelbourne	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218539135	f	\N	\N	\N
8231	AP Turris Calcio	AZ Picerno ASD	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218768430	f	\N	\N	\N
8222	Catania	Foggia	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218768160	f	\N	\N	\N
8232	Stjarnan/KFG	HK/YMIR U19	2023-09-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218759414	f	\N	\N	\N
8236	Sarmiento de Junin	Belgrano	2023-09-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218466371	f	\N	\N	\N
8238	CA Platense	Union Santa Fe	2023-09-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465542	f	\N	\N	\N
8234	Racing de Ferrol	Zaragoza	2023-09-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218278109	f	\N	\N	\N
8233	Tenerife	Espanyol	2023-09-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218278470	f	\N	\N	\N
8237	Real Soacha Cundinamarca FC	Fortaleza FC	2023-09-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218622184	f	\N	\N	\N
8240	Sporting Lisbon	Rio Ave	2023-09-25 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218465974	t	\N	\N	\N
8239	Valur/KH U19	Throttur Reykjavik/SR U19	2023-09-25 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218759363	f	\N	\N	\N
8241	Breidablik	Vikingur Reykjavik	2023-09-25 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218521169	f	\N	\N	\N
8249	Colon	Argentinos Juniors	2023-09-25 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218466848	t	\N	\N	\N
8242	Atletico Grau	Sport Huancayo	2023-09-25 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218642315	f	\N	\N	\N
8243	Club R Zemamra	Mas Maghrib A Fes	2023-09-25 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218735587	f	\N	\N	\N
8244	Orsomarso	Bogota	2023-09-25 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218622274	f	\N	\N	\N
8246	Municipal Grecia	AD San Carlos	2023-09-25 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218604801	f	\N	\N	\N
8245	Cucuta Deportivo	Boyaca Patriotas	2023-09-25 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218582692	f	\N	\N	\N
8247	La Equidad	Jaguares de Cordoba	2023-09-25 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218670110	f	\N	\N	\N
8248	Avai	Juventude	2023-09-25 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218481149	f	\N	\N	\N
8251	America MG	Vasco Da Gama	2023-09-26 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272623	t	\N	\N	\N
8250	Godoy Cruz	Racing Club	2023-09-25 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218464821	t	\N	\N	\N
8252	Alianza Petrolera	Once Caldas	2023-09-26 00:25:00	https://www.orbitxch.com/customer/sport/1/market/1.218710649	t	\N	\N	\N
8254	Novorizontino	ABC RN	2023-09-26 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450536	f	\N	\N	\N
8256	Atl Tucuman	Arsenal De Sarandi	2023-09-26 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480017	f	\N	\N	\N
8255	Libertad FC	El Nacional	2023-09-26 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503025	f	\N	\N	\N
8253	Talleres	Barracas Central	2023-09-26 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218479693	f	\N	\N	\N
8257	All Boys	Almirante Brown	2023-09-26 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218533849	f	\N	\N	\N
8258	Sporting Cristal	UTC Cajamarca	2023-09-26 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218634454	f	\N	\N	\N
8206	Jong Ajax Amsterdam	FC Eindhoven	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218524527	t	\N	\N	\N
7808	Lommel	Francs Borains	2023-09-24 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218612908	t	\N	\N	\N
8259	Ind Medellin	Atletico Bucaramanga	2023-09-26 02:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218710466	f	\N	\N	\N
4899	CF Orgullo de Reynosa	Mexicali FC	2023-09-19 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218416654	f	\N	\N	\N
7850	LASK Linz	Hartberg	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217944587	t	\N	\N	\N
7851	SCR Altach	Austria Vienna	2023-09-24 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217944479	t	\N	\N	\N
8180	CC Riadi Salmi	Olympic Safi	2023-09-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218735677	f	\N	\N	\N
8262	Alhashemyya	Yarmouk	2023-09-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218792617	f	\N	\N	\N
8209	Leicester U21	Middlesbrough U21	2023-09-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218765006	f	\N	\N	\N
8298	AD Berazategui	CA Puerto Nuevo	2023-09-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218817091	f	\N	\N	\N
8303	Dungannon U20	Glentoran FC U20	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218792738	f	\N	\N	\N
8304	Ballymena United FC U20	Loughgall FC U20	2023-09-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218815734	f	\N	\N	\N
8336	Venezuela (W)	Uruguay (W)	2023-09-26 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218806117	f	\N	\N	\N
8346	Mineros de Fresnillo FC	Gavilanes Matamoros	2023-09-26 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218783861	f	\N	\N	\N
8359	Bournemouth U21	Charlton U21	2023-09-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218806910	f	\N	\N	\N
8360	Fleetwood Town U21	Crewe U21	2023-09-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218807000	f	\N	\N	\N
8361	Catalcaspor	Tepecik Belediye	2023-09-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218843857	f	\N	\N	\N
8362	Watford U21	Colchester United U21	2023-09-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218806820	f	\N	\N	\N
8363	Thimphu City	Transport United FC	2023-09-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218805662	f	\N	\N	\N
8364	Preston North End (Res)	Blackpool (Res)	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218843947	f	\N	\N	\N
8365	Tanta	Raya Sporting FC	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218805769	f	\N	\N	\N
8366	Gomhoryet Shebin	Ghazl El Mahallah	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218800507	f	\N	\N	\N
8367	Baladeyet Al-Mahalla	Smouha	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218800597	f	\N	\N	\N
8368	Pogon Siedlce	Podbeskidzie B-B	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218804266	f	\N	\N	\N
8369	FK Radnicki 1923	Radnik Surdulica	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218784491	f	\N	\N	\N
8370	Proxy Work Club	Olympic El Qanal	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218800417	f	\N	\N	\N
8371	Cardiff City U21	Millwall U21	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218784627	f	\N	\N	\N
8372	Wieczysta Krakow	Piast Gliwice	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218804086	f	\N	\N	\N
8373	Wadi degla	Misr El Makasa	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218806730	f	\N	\N	\N
8374	Start Krasnystaw	Zawisza Bydgoszcz	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218830269	f	\N	\N	\N
8375	Mafra U23	Benfica U23	2023-09-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218784311	f	\N	\N	\N
8376	FC Zalau	Otelul Galati	2023-09-26 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218579369	f	\N	\N	\N
8377	Banik Horna Nitra	MSK Povazska Bystrica	2023-09-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218820015	f	\N	\N	\N
8378	FK Slavija Sarajevo	Leotar Trebinje	2023-09-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218808464	f	\N	\N	\N
8379	NK Grobnican	Varazdin	2023-09-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218807093	f	\N	\N	\N
8396	Radnicki Nis	Zeleznicar Pancevo	2023-09-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218784401	f	\N	\N	\N
8384	Rio Ave FC U23	Vizela U23	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218784041	f	\N	\N	\N
8383	Estrela U23	Portimonense SC U23	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218784131	f	\N	\N	\N
8387	Sporting Braga U23	Gil Vicente U23	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218784221	f	\N	\N	\N
8386	SK Kladno	Slovan Liberec	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218808554	f	\N	\N	\N
8380	Zhenys	Elimai FC	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218848190	f	\N	\N	\N
8381	FK Podkonice	DUKLA BANSKA BYSTRICA	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218820121	f	\N	\N	\N
8388	Bosnia-Herzegovina (W)	Slovenia (W)	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218821851	f	\N	\N	\N
8385	Beroe Stara Za	CSKA 1948 Sofia	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218428825	f	\N	\N	\N
8382	Sahab SC	Al Buqaa	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218819501	f	\N	\N	\N
8390	Kuressaare	Nomme Kalju	2023-09-26 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218806210	f	\N	\N	\N
8391	GD Estoril Praia U23	Sporting Lisbon U23	2023-09-26 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218783951	f	\N	\N	\N
8392	Viven Bornova FK	Akhisar Belediye	2023-09-26 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218843767	f	\N	\N	\N
8397	Bulgaria (W)	Kosovo (W)	2023-09-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218822391	f	\N	\N	\N
8394	Turkey (W)	Lithuania (W)	2023-09-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218822031	f	\N	\N	\N
8399	Mlada Boleslav	Prostejov	2023-09-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218808644	f	\N	\N	\N
8398	Czech Republic (W)	Belarus (W)	2023-09-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218822571	f	\N	\N	\N
8395	Wisla Pulawy	Chrobry Glogow	2023-09-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218804718	f	\N	\N	\N
8393	Estonia (W)	Israel (W)	2023-09-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218822211	f	\N	\N	\N
8400	Italy (W)	Sweden (W)	2023-09-26 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218822751	f	\N	\N	\N
8405	Aali Club	Buri FC	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218800326	f	\N	\N	\N
8401	Slovakia (W)	Croatia (W)	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218822121	f	\N	\N	\N
8402	Romania (W)	Finland (W)	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218822301	f	\N	\N	\N
8403	Future FC	El Daklyeh	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218617701	f	\N	\N	\N
8404	LKP Motor Lublin	Puszcza Niepolomice	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218804989	f	\N	\N	\N
7941	Rayo Vallecano	Villarreal	2023-09-24 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217927382	t	\N	\N	\N
8424	FK Sloboda Point	Indija	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218802274	f	\N	\N	\N
8437	FK Backa Topola	FK Napredak	2023-09-26 18:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218802365	f	\N	\N	\N
8408	Concordia Elblag	Widzew Lodz	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218804447	f	\N	\N	\N
8409	Al Budaiya	Al-Ittihad (BRN)	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218799930	f	\N	\N	\N
8407	Montenegro (W)	Azerbaijan (W)	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218823147	f	\N	\N	\N
8411	Miedz Legnica	Arka Gdynia	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218804899	f	\N	\N	\N
8413	Santa Lucia FC	Balzan FC	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218801787	f	\N	\N	\N
8412	Poland (W)	Ukraine (W)	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218822481	f	\N	\N	\N
8410	Qalali	Al-Ettifaq	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218800020	f	\N	\N	\N
5067	Leyton Orient	Fulham U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342627	f	\N	\N	\N
5068	Morecambe	Liverpool U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258176	f	\N	\N	\N
5069	Derby	Lincoln	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258626	f	\N	\N	\N
8415	Lecco	Feralpisalo	2023-09-26 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218581913	f	\N	\N	\N
8416	Cosenza	US Cremonese	2023-09-26 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218581823	f	\N	\N	\N
8414	Germany (W)	Iceland (W)	2023-09-26 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218822661	f	\N	\N	\N
8418	Austria (W)	France (W)	2023-09-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218822882	f	\N	\N	\N
8420	Al Hussein	Dar Al-Dawaa	2023-09-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218819591	f	\N	\N	\N
8417	Cherno More	Botev Plovdiv	2023-09-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218428645	f	\N	\N	\N
8419	Kks Kalisz	LKS Lodz	2023-09-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218804627	f	\N	\N	\N
8421	Odra Opole	Stal Mielec	2023-09-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218804537	f	\N	\N	\N
8422	Harju JK Laagri	Fci Tallinn	2023-09-26 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218806300	f	\N	\N	\N
8427	Grazer AK	SV Stripfing/W	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218799837	f	\N	\N	\N
8434	Andorra (W)	Latvia (W)	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218823237	f	\N	\N	\N
8423	FC Dornbirn	St Polten	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218799750	f	\N	\N	\N
8433	Serbia (W)	Greece (W)	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218823417	f	\N	\N	\N
8425	Floriana	Paola Hibernians FC	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218801697	f	\N	\N	\N
8429	FIRST VIENNA FC 1894	SC AUSTRIA LUSTENAU	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218799535	f	\N	\N	\N
8432	Ciervos fc	Caja Oblatos C.FD	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218830359	f	\N	\N	\N
8426	DSV Leoben	WSG Wattens	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218799355	f	\N	\N	\N
8430	Skra Czestochowa	Polonia Warszawa	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218804809	f	\N	\N	\N
8428	Ksv 1919	SV Lafnitz	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218799654	f	\N	\N	\N
8431	SV Ried	Wolfsberger AC	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218799445	f	\N	\N	\N
8435	Sevilla	Almeria	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218392007	f	\N	\N	\N
8436	Istanbulspor	Galatasaray	2023-09-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564228	f	\N	\N	\N
8438	Portugal (W)	Norway (W)	2023-09-26 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218823597	f	\N	\N	\N
8444	Neuchatel Xamax	FC Baden	2023-09-26 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218544869	f	\N	\N	\N
8445	Stade Nyonnais	FC Wil	2023-09-26 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218544599	f	\N	\N	\N
8443	Luxembourg (W)	Georgia (W)	2023-09-26 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218823777	f	\N	\N	\N
8440	Chippa Utd	Supersport Utd	2023-09-26 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218827995	f	\N	\N	\N
8441	Schaffhausen	Bellinzona	2023-09-26 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218544779	f	\N	\N	\N
8439	Hungary (W)	Republic of Ireland (W)	2023-09-26 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218823867	f	\N	\N	\N
8451	Dinamo Bucharest	FC U Craiova 1948	2023-09-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218156702	f	\N	\N	\N
8448	Burton Albion	Everton U21	2023-09-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218613809	f	\N	\N	\N
8452	Northampton	Chelsea U21	2023-09-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218613719	f	\N	\N	\N
8450	Northern Ireland (W)	Albania (W)	2023-09-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218824063	f	\N	\N	\N
8447	Netherlands (W)	England (W)	2023-09-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218826841	f	\N	\N	\N
8446	Gzira United FC	Naxxar Lions	2023-09-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218801391	f	\N	\N	\N
8449	Morocco (W)	Zambia (W)	2023-09-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218809855	f	\N	\N	\N
8453	Hamarkameratene U19	Fredrikstad U19	2023-09-26 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218848297	f	\N	\N	\N
8454	Wales (W)	Denmark (W)	2023-09-26 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218823327	f	\N	\N	\N
8455	FC Zurich	Grasshoppers Zurich	2023-09-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218544689	f	\N	\N	\N
8457	Reggiana	Pisa	2023-09-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218582003	f	\N	\N	\N
8456	Barnsley	Man City U21	2023-09-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218704542	f	\N	\N	\N
8460	Ascoli	Ternana	2023-09-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218582093	f	\N	\N	\N
8458	Venezia	Palermo	2023-09-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218581643	f	\N	\N	\N
8459	Spezia	Brescia	2023-09-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218581733	f	\N	\N	\N
7970	Rapid Vienna	Sturm Graz	2023-09-24 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944911	t	\N	\N	\N
8464	Quevilly Rouen	Angers	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218753778	f	\N	\N	\N
8467	Loughgall	Larne	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218806394	f	\N	\N	\N
8483	Oxford City	Gateshead	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218662684	f	\N	\N	\N
8499	Wealdstone	Woking	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218662864	f	\N	\N	\N
8471	Ebbsfleet Utd	Dorking Wanderers	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218654957	f	\N	\N	\N
8476	Hartlepool	Solihull Moors	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218654867	f	\N	\N	\N
8494	Port Vale	Sutton Utd	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218297415	f	\N	\N	\N
8462	Scotland (W)	Belgium (W)	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218823507	f	\N	\N	\N
8472	Maidenhead	Altrincham	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218654417	f	\N	\N	\N
8486	Hornchurch	Dulwich Hamlet	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218759555	f	\N	\N	\N
8484	York City	Barnet	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218662774	f	\N	\N	\N
8469	AFC Fylde	Boreham Wood	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218654597	f	\N	\N	\N
8478	Aldershot	Southend	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218654687	f	\N	\N	\N
8493	Mansfield	Peterborough	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218297307	f	\N	\N	\N
8465	Bolton	Man Utd U21	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218613899	f	\N	\N	\N
8463	Cliftonville	Coleraine	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218756788	f	\N	\N	\N
8468	Caernarfon Town	The New Saints	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218820872	f	\N	\N	\N
8498	Paris FC	Laval	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218754265	f	\N	\N	\N
8473	Rangers B	Alloa	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218819727	f	\N	\N	\N
8479	Connahs Quay	Colwyn Bay	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218820962	f	\N	\N	\N
8470	SV Austria Salzburg	Red Bull Salzburg	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218805241	f	\N	\N	\N
8474	Bromley	Eastleigh	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218654507	f	\N	\N	\N
8490	Preussen Munster	Bayern Munich	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218300036	f	\N	\N	\N
8480	Penybont FC	Barry Town Utd	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218821052	f	\N	\N	\N
8482	Kilmarnock	Hearts	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218756124	f	\N	\N	\N
8466	Linfield	Crusaders	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218424499	f	\N	\N	\N
8495	Salford City	Burnley	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218296819	f	\N	\N	\N
8496	Guingamp	Bordeaux	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218754535	f	\N	\N	\N
8485	Valenciennes	Concarneau	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218753597	f	\N	\N	\N
8487	Auxerre	Annecy	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218753687	f	\N	\N	\N
8488	Bastia	Pau	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218754445	f	\N	\N	\N
8497	Cardiff Metropolitan	Haverfordwest County	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218821142	f	\N	\N	\N
8489	Bradford	Middlesbrough	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218297523	f	\N	\N	\N
8477	Pontypridd Town	Newtown	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218821448	f	\N	\N	\N
8475	FC Halifax Town	Dag and Red	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218654777	f	\N	\N	\N
8507	Rochdale	Chesterfield	2023-09-26 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218662954	f	\N	\N	\N
8492	Ipswich	Wolves	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218298950	f	\N	\N	\N
8491	Exeter	Luton	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218259528	f	\N	\N	\N
8481	Kidderminster	Oldham	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218655047	f	\N	\N	\N
8502	Juventus	Lecce	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218399355	f	\N	\N	\N
8500	Caen	Grenoble	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218753958	f	\N	\N	\N
8503	Amiens	AC Ajaccio	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218754355	f	\N	\N	\N
8505	Jagiellonia Bialystock	Slask Wroclaw	2023-09-26 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218804357	f	\N	\N	\N
8508	Lille	Reims	2023-09-26 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217964901	f	\N	\N	\N
8504	Spain (W)	Switzerland (W)	2023-09-26 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218823687	f	\N	\N	\N
8506	Man Utd	Crystal Palace	2023-09-26 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218297016	f	\N	\N	\N
8509	AVS Futebol SAD	Arouca	2023-09-26 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218806516	f	\N	\N	\N
8510	Mallorca	Barcelona	2023-09-26 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218399507	f	\N	\N	\N
8511	Juan Aurich	Comerciantes FC	2023-09-26 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218801967	f	\N	\N	\N
8512	Comerciantes Unidos	Uni San Martin	2023-09-26 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218801877	f	\N	\N	\N
8513	Boca Juniors de Cali	Cortulua	2023-09-26 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218582602	f	\N	\N	\N
8514	Fernandez Vial	CD Trasandino	2023-09-26 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218834689	f	\N	\N	\N
8515	Leones FC	Barranquilla	2023-09-26 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218582512	f	\N	\N	\N
8516	Canada (W)	Jamaica (W)	2023-09-27 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218773536	f	\N	\N	\N
8517	Union Magdalena	Deportivo Cali	2023-09-27 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218713586	f	\N	\N	\N
8518	St. Pauls United	Village Superstars	2023-09-27 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218834599	f	\N	\N	\N
8096	Paris St-G	Marseille	2023-09-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217965141	t	\N	\N	\N
8520	CA Fenix	Los Andes	2023-09-27 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218812171	f	\N	\N	\N
8521	Corinthians	Fortaleza EC	2023-09-27 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217844407	f	\N	\N	\N
8522	CSD Tellioz	Antigua GFC	2023-09-27 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218625181	f	\N	\N	\N
8524	Club Atletico La Paz	Tlaxcala F.C	2023-09-27 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218583530	f	\N	\N	\N
8523	Guadalajara	Mazatlan FC	2023-09-27 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218737544	f	\N	\N	\N
8525	Deportivo Pasto	Atletico Huila	2023-09-27 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218710557	f	\N	\N	\N
8526	CD Motagua	Atletico Independiente	2023-09-27 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218836194	f	\N	\N	\N
8527	Cimarrones de Sonora	Club Atletico Morelia	2023-09-27 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218583620	f	\N	\N	\N
8389	SC Uniao Torreense U23	Leixoes U23	2023-09-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218819837	f	\N	\N	\N
8406	Cyprus (W)	Faroe Islands (W)	2023-09-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218821941	f	\N	\N	\N
8442	Hapoel Tel Aviv	Maccabi Tel Aviv	2023-09-26 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218640383	f	\N	\N	\N
8461	Sudtirol	Modena	2023-09-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218582183	f	\N	\N	\N
8501	Rodez	ESTAC Troyes	2023-09-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218753868	f	\N	\N	\N
8519	Imbabura Sporting Club	Independiente Juniors	2023-09-27 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218826298	f	\N	\N	\N
5244	Rionegro	America de Cali S.A	2023-09-21 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218494425	f	\N	\N	\N
5245	Cienciano	Asociacion Deportiva Tarma	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218480624	f	\N	\N	\N
5250	DC Utd	Atlanta Utd	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218280577	f	\N	\N	\N
5252	New York City	Orlando City	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285569	f	\N	\N	\N
5253	Instituto	Colon	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218211440	f	\N	\N	\N
5254	Birmingham Legion FC	Memphis 901 FC	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294217	f	\N	\N	\N
5255	Sporting San Jose FC	CS Herediano	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502348	f	\N	\N	\N
5256	Racing Club	Newells	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031271	f	\N	\N	\N
5257	CD Victoria	CD Motagua	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218538732	f	\N	\N	\N
5258	Independiente Juniors	Guayaquil SC	2023-09-21 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218521799	f	\N	\N	\N
8673	Singapore (W)	Korea DPR (W)	2023-09-27 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218850238	f	\N	\N	\N
8674	Iran U23	Thailand U23	2023-09-27 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218847755	f	\N	\N	\N
8675	FK Kyzyl-Zhar	Tobol Kostanay	2023-09-27 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218837182	f	\N	\N	\N
8676	Tokushima	Kumamoto	2023-09-27 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218769757	f	\N	\N	\N
8677	Hapoel Bnei Musmus	Hapoel Beit Shean Mesilot	2023-09-27 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218869007	f	\N	\N	\N
8678	Sebat Genclik Spor	1954 Kelkit Belediyespor	2023-09-27 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218854930	f	\N	\N	\N
8679	Erbaaspor	Fatsa Belediyespor	2023-09-27 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218854840	f	\N	\N	\N
8680	Pazarspor	Gumushanespor	2023-09-27 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218854750	f	\N	\N	\N
8681	ACS Progresul Pecica	ACS Petrolul 52	2023-09-27 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307197	f	\N	\N	\N
8682	Anadolu Selcukluspor	Talasgucu Belediyespor	2023-09-27 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218857837	f	\N	\N	\N
8683	Thailand (W)	Chinese Taipei (W)	2023-09-27 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218830989	f	\N	\N	\N
8684	Bulvarspor	Karabuk Idmanyurdu	2023-09-27 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218860483	f	\N	\N	\N
8685	Bursa Yildirim Spor	Inegol Kafkas Genclikspor	2023-09-27 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218860393	f	\N	\N	\N
8686	Kozani FC	PAE Chania	2023-09-27 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218827691	f	\N	\N	\N
8687	Silivrispor	Ergene Velimese SK	2023-09-27 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218862425	f	\N	\N	\N
8688	Turgutluspor	Aliaga Futbol AS	2023-09-27 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218862516	f	\N	\N	\N
8689	Sapanca Genclikspor	Darica Genclerbirligi	2023-09-27 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218860303	f	\N	\N	\N
8690	Hebar	Botev Vratsa	2023-09-27 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218428735	f	\N	\N	\N
8691	Hapoel Ironi Arraba	Maccabi Bnei Jadeidi-Makr	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218868917	f	\N	\N	\N
8692	ENPPI	El Geish	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218568067	f	\N	\N	\N
8693	OFK Beograd	Tekstilac Odzaci	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218842748	f	\N	\N	\N
8694	Gloria Buzau	UTA Arad	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218201248	f	\N	\N	\N
8695	Johor Darul Takzim	PDRM	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218843587	f	\N	\N	\N
8696	FK Jedinstvo Ub	FK Vrsac	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218842928	f	\N	\N	\N
8697	Garbarnia	Radomiak Radom	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218868245	f	\N	\N	\N
8698	Radnicki Novi Beograd	FK Mladost Novi Sad	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218843018	f	\N	\N	\N
8699	SalPA	KPV	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218712133	f	\N	\N	\N
8700	Tuzla City	Zrinjski	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218880081	f	\N	\N	\N
8701	NK Rogaska	NK Bravo	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218623824	f	\N	\N	\N
8702	FC Astana	Okzhetpes	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218838050	f	\N	\N	\N
8703	Athlitiki Enosi Larissa	Tilikratis Lefkadas	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218827787	f	\N	\N	\N
8704	FC Voska Sport	FK Struga Trim-Lum	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218843497	f	\N	\N	\N
8705	Valmieras FK	SK Super Nova	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218857930	f	\N	\N	\N
8706	Sokol Kleczew	Zaglebie Lubin	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218867794	f	\N	\N	\N
8707	Stal Brzeg	Unia Skierniewice	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218868607	f	\N	\N	\N
8708	Panaitolikos	OFI	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218467246	f	\N	\N	\N
8709	RFK Novi Sad	FK Radnicki Sremska	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218842838	f	\N	\N	\N
8710	FC Legia Warsaw II	Ruch Chorzow	2023-09-27 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218868065	f	\N	\N	\N
8711	Jadran Porec	Oriolic Oriovac	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218878787	f	\N	\N	\N
8712	FK Raca Bratislava	Samorin	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218867140	f	\N	\N	\N
8713	FK Arsenal Tivat	Rudar Pljevlja	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218843677	f	\N	\N	\N
8714	FK Kozara	Jedinstvo	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218881754	f	\N	\N	\N
8715	SFC Opava	FC Zbrojovka Brno	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218864981	f	\N	\N	\N
8716	MFK Spisske Podhradie	Tatran Lip Mikulas	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218866508	f	\N	\N	\N
8717	NK Bosna Visoko	FK Velez Mostar	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218881934	f	\N	\N	\N
8718	NK Stupcanica Olovo	Rudar Prijedor	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218881844	f	\N	\N	\N
8719	Domazlice	FK Jablonec	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218864891	f	\N	\N	\N
8720	Gryf Wejherowo	Zaglebie Sosnowiec	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218867974	f	\N	\N	\N
8721	Radnik Krizevci	Sibenik	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218877829	f	\N	\N	\N
8722	TJ Sokol Zapy	Banik Ostrava	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218865071	f	\N	\N	\N
8723	MFK Vranov nad Toplou	Zemplin	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218874480	f	\N	\N	\N
8724	TJ Slovan Velvary	Pardubice	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218865161	f	\N	\N	\N
8725	NK Tosk Tesanj	FK Igman Konjic	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218881574	f	\N	\N	\N
8726	FC Slovan Galanta	FC Petrzalka	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218866868	f	\N	\N	\N
8727	Nove Zamky	Banik Kalinovo	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218866688	f	\N	\N	\N
5325	Atalanta	Rakow Czestochowa	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217882995	f	\N	\N	\N
8728	Brotnjo	Gosk Gabela	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218881664	f	\N	\N	\N
8729	NK Dugo Selo	Lokomotiva	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218877526	f	\N	\N	\N
8730	Fk Laktasi	FK Gorazde	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218881484	f	\N	\N	\N
8731	Lokomotiva Kosice	Slavoj Trebisov	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218866958	f	\N	\N	\N
8732	NK Ponikve	Dinamo Zagreb	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218877929	f	\N	\N	\N
8733	MSK Novohrad Lucenec	Pohronie	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218867048	f	\N	\N	\N
8734	Vukovar	BSK Bijelo Brdo	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218878877	f	\N	\N	\N
8735	Zagora	NK Istra	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218877738	f	\N	\N	\N
8736	RSC Hamsik Academy	Podbrezova	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218866418	f	\N	\N	\N
8737	Tj Slavoj Boleraz	TJ Kovo Belusa	2023-09-27 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218866778	f	\N	\N	\N
8738	CS Tunari	Universitatea Craiova	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218156972	f	\N	\N	\N
5913	Ponte Preta	Mirassol	2023-09-22 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218221319	f	\N	\N	\N
5299	Hapoel Bikat Hayarden	Maccabi Yavne	2023-09-21 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218551014	f	\N	\N	\N
5392	Brighton	AEK Athens	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217884911	f	\N	\N	\N
5519	Deportivo Recoleta	Atyra FC	2023-09-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608811	f	\N	\N	\N
5522	Cobreloa	Club Deportes Santa Cruz	2023-09-21 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218607620	f	\N	\N	\N
5340	Venezuela (W)	Uruguay (W)	2023-09-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218566438	f	\N	\N	\N
5529	Club Martin Ledesma	Rubio Nu	2023-09-22 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218610219	f	\N	\N	\N
5665	Salus FC	Juanico	2023-09-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218619697	f	\N	\N	\N
5351	Municipal Grecia	Puntarenas F.C.	2023-09-22 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218536896	f	\N	\N	\N
5350	CD Olimpia	Genesis Huracan	2023-09-22 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218563660	f	\N	\N	\N
5352	Atlante	Venados FC	2023-09-22 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218402194	f	\N	\N	\N
8757	FK Dubocica	FK Smederevo	2023-09-27 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218842658	f	\N	\N	\N
8758	Metalac Gornji Milanovac	Macva Sabac	2023-09-27 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218843127	f	\N	\N	\N
5672	PSBS Biak Numfor	Aceh United FC	2023-09-22 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218607715	f	\N	\N	\N
5673	Gangneung City	Mokpo City	2023-09-22 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550353	f	\N	\N	\N
5674	Maccabi Kiryat Gat	Beitar Yavne	2023-09-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614082	f	\N	\N	\N
5675	Beitar Nahariya	Shefa-amr FC	2023-09-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218613992	f	\N	\N	\N
5676	RANS Nusantara FC	Persis Solo	2023-09-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218584846	f	\N	\N	\N
5677	Hong Kong (W)	Philippines (W)	2023-09-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515558	f	\N	\N	\N
5678	Maccabi Ironi Amishav PT	Beitar Tel Aviv Bat Yam	2023-09-22 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218614172	f	\N	\N	\N
8739	H Slavia Kromeriz	Slavia Prague	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218865292	f	\N	\N	\N
8741	Vyskov	Teplice	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218864801	f	\N	\N	\N
8740	Kjelsas	Molde	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218862333	f	\N	\N	\N
8743	Gyirmot	FC Ajka	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218842388	f	\N	\N	\N
8749	Tallinna Kalev	Paide Linnameeskond	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218826028	f	\N	\N	\N
8746	Nyiregyhaza	MTE 1904	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218842568	f	\N	\N	\N
8744	FC Hunedoara	Chindia Targoviste	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218579279	f	\N	\N	\N
8748	Lisen	Sparta Prague	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218864621	f	\N	\N	\N
8745	Al Ahli Amman	Al Alyah	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218874083	f	\N	\N	\N
8751	Karsiyaka	Bergama Belediyespor	2023-09-27 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218862606	f	\N	\N	\N
8752	Poprad	MSK Tesla Stropkov	2023-09-27 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218866598	f	\N	\N	\N
8750	Atletico De Kolkata	Bengaluru FC	2023-09-27 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218730465	f	\N	\N	\N
8756	Slavia Sofia	PFC Levski Sofia	2023-09-27 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218428555	f	\N	\N	\N
8753	Kifisias FC	Lamia	2023-09-27 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218467065	f	\N	\N	\N
8759	HJK Helsinki	Honka	2023-09-27 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218583800	f	\N	\N	\N
8754	Paradou	USM Alger	2023-09-27 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218843317	f	\N	\N	\N
8755	Ilves	IFK Mariehamn	2023-09-27 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218583891	f	\N	\N	\N
8764	JaPS	Jaro	2023-09-27 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218712223	f	\N	\N	\N
8760	Gnistan	Mikkeli	2023-09-27 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218712313	f	\N	\N	\N
8763	NK Celje	NK Aluminij	2023-09-27 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218623914	f	\N	\N	\N
8762	KaPa	JJK	2023-09-27 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218711953	f	\N	\N	\N
8761	EIF	SJK 2	2023-09-27 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218712043	f	\N	\N	\N
8765	Hermannstadt	ACS Sepsi OSK	2023-09-27 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218157062	f	\N	\N	\N
8766	TPS	HIFK	2023-09-27 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218667688	f	\N	\N	\N
8767	Paks	DEBRECENI VSC	2023-09-27 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218722830	f	\N	\N	\N
8768	Maccabi Kabilio Jaffa	Ironi Tiberias	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218869098	f	\N	\N	\N
8783	Tammeka Tartu	Tallinna FC Flora	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218826118	f	\N	\N	\N
8769	Bahrain SC	Isa Town FC	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218885103	f	\N	\N	\N
8792	Parnu JK Vaprus	Trans Narva	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218826208	f	\N	\N	\N
8786	FK Jedinstvo Bijelo Polje	FK Decic	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218847483	f	\N	\N	\N
8776	Haladas	Soroksar	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218847033	f	\N	\N	\N
8794	Vysocina Jihlava	Hradec Kralove	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218865382	f	\N	\N	\N
8782	Hamrun Spartans FC	Gudja United	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218859944	f	\N	\N	\N
8790	Radnik Bijeljina	Sloga Doboj	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218878697	f	\N	\N	\N
8787	Al Hidd	Al Riffa	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218845143	f	\N	\N	\N
8770	Etihad Al Reef	Um Al Hassam	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218845233	f	\N	\N	\N
8784	Ruzomberok	Slovan Bratislava	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218579459	f	\N	\N	\N
8785	Karlovac	Vinogradar	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218878967	f	\N	\N	\N
8788	HIK Hellerup	Brondby	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218854197	f	\N	\N	\N
8774	Tiszakecske VSE	Szeged 2011	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218846853	f	\N	\N	\N
8772	Ceramica Cleopatra	Al Ahly Cairo	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218617791	f	\N	\N	\N
8771	El Gounah	ZED FC	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218855024	f	\N	\N	\N
8791	Levadia Tallinn II	Tabasalu JK	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218847845	f	\N	\N	\N
8780	Gagra	FC Shukura Kobuleti	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218846673	f	\N	\N	\N
8778	Siofok	Gyori	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218846943	f	\N	\N	\N
8773	Malkiya	Al Tadamun Buri	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218845323	f	\N	\N	\N
8777	FK Sutjeska	FK Jezero	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218847573	f	\N	\N	\N
8779	Gornik Leczna	Cracovia Krakow	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218868155	f	\N	\N	\N
8781	Stal Stalowa Wola	Znicz Pruszkow	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218868336	f	\N	\N	\N
8789	Marsaxlokk FC	Sirens FC	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218858506	f	\N	\N	\N
8793	Slovacko	Dukla Prague	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218864711	f	\N	\N	\N
8795	SC Mannsdorf	Austria Klagenfurt	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218883831	f	\N	\N	\N
8800	Juventus B	Recanatese	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218845586	f	\N	\N	\N
8798	SC Imst	LASK Linz	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218884805	f	\N	\N	\N
8803	St.Anna	Austria Vienna	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218884223	f	\N	\N	\N
8796	Ma'an	Etihad Al Ramtha	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218873993	f	\N	\N	\N
8801	Empoli	Salernitana	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218410828	f	\N	\N	\N
8802	Siroki Brijeg	Borac Banja Luka	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218880387	f	\N	\N	\N
8799	Cagliari	AC Milan	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218430539	f	\N	\N	\N
8805	PSV	Go Ahead Eagles	2023-09-27 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382600	t	\N	\N	\N
8807	Fauve Azur Elite	Victoria United Limbe	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218879775	f	\N	\N	\N
8808	Ferencvaros	Kecskemeti	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.216264525	f	\N	\N	\N
8806	Aurora FC	Cuilapa FC	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218846763	f	\N	\N	\N
8810	Skovde AIK	Landskrona	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218568247	t	2	\N	336
8809	Birkirkara	Valletta	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218858596	f	\N	\N	\N
8819	Osters	Helsingborgs	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218568337	f	\N	\N	\N
8816	Maccabi Haifa	Bnei Sakhnin	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218617881	f	\N	\N	\N
8820	SKU Amstetten	Floridsdorfer Ac	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218884313	f	\N	\N	\N
8822	Athletic Bilbao	Getafe	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218411308	f	\N	\N	\N
8812	AFC Eskilstuna	Vasteras SK	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218568427	f	\N	\N	\N
8811	CD Ibiza Islas Pitiusas	CF Badalona Futur	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218855675	f	\N	\N	\N
8814	Dortmund II	Duisburg	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218770027	f	\N	\N	\N
8821	SV Leobendorf	Sturm Graz	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218884699	f	\N	\N	\N
8817	Real Madrid	Las Palmas	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218434922	f	\N	\N	\N
8815	Adana Demirspor	Besiktas	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218578332	f	\N	\N	\N
8823	KSZO Ostrowiec	Warta Poznan	2023-09-27 18:29:00	https://www.orbitxch.com/customer/sport/1/market/1.218867884	f	\N	\N	\N
8827	Admira Wacker	Hartberg	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218884011	f	\N	\N	\N
8824	Chojniczanka Chojnice	Resovia Rzeszow	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218868426	f	\N	\N	\N
8825	Ludogorets	Lokomotiv Plovdiv	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218428465	f	\N	\N	\N
8826	KAA Gent II	UR Namur	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218870428	f	\N	\N	\N
8830	PAOK	NFC Volos	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218466883	f	\N	\N	\N
8828	Olympiakos	Aris	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218466974	f	\N	\N	\N
8829	Kaizer Chiefs	Sekhukhune United	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218731113	f	\N	\N	\N
5736	NK Sesvete U19	Slaven Belupo U19	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218607807	f	\N	\N	\N
8832	IF Lyseng	FC Copenhagen	2023-09-27 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218854291	f	\N	\N	\N
8835	S Lucia Cotzumalguapa	Suchitepequez	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218858113	f	\N	\N	\N
8833	Royal Knokke FC	Charleroi-Marchienne	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218870608	f	\N	\N	\N
8848	AD Union Adarve	Patacona CF	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218855857	f	\N	\N	\N
8834	Charleroi (Res)	Excelsior Virton	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218870518	f	\N	\N	\N
8844	AD San Juan	SE Penya Independent	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218856039	f	\N	\N	\N
8853	Una Strassen	F91 Dudelange	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218847213	f	\N	\N	\N
8842	UE Sant Andreu	Lleida	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218855314	f	\N	\N	\N
8851	SC Bruhl St Gallen	Cham	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218847665	f	\N	\N	\N
8845	Bihor Oradea	FCSB	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218156792	f	\N	\N	\N
8836	Botafogo SP U20	Gremio Novorizontino U20	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218848403	f	\N	\N	\N
8849	Mosta	Sliema Wanderers FC	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218858687	f	\N	\N	\N
8838	Sao Paulo U20	Desp Brasil P LTDA U20	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218848495	f	\N	\N	\N
8847	Fc Differdange 03	Jeunesse D'Esch	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218847303	f	\N	\N	\N
8841	Marino Luanco	Real Union	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218855585	f	\N	\N	\N
8852	Farense	Tondela	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218602511	f	\N	\N	\N
8854	Agua Santa U20	AA Portuguesa U20	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218848946	f	\N	\N	\N
8859	UN Kaerjeng 97	FC Schifflingen 95	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218857252	f	\N	\N	\N
8839	Guadalajara	Lanzarote	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218855495	f	\N	\N	\N
8850	Kuwait SC	Al Salmiyah	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218847120	f	\N	\N	\N
8856	Red Bull Bragantino U20	EC Sao Bernardo U20	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218848586	f	\N	\N	\N
8846	SRD Vimenor CF	L'Entregu CF	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218856178	f	\N	\N	\N
8837	Mirassol U20	Ibrachina FC U20	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218848766	f	\N	\N	\N
8843	Pogon Szczecin	Legia Warsaw	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218583710	f	\N	\N	\N
8840	Fola Esch	FC Victoria Rosport	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218847393	f	\N	\N	\N
8857	Ferroviaria DE U20	Santos U20	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218848676	f	\N	\N	\N
8855	Inter Limeira U20	Oeste U20	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218848856	f	\N	\N	\N
8858	FC Twente	Vitesse Arnhem	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218578548	f	\N	\N	\N
8861	Domzale	Mura	2023-09-27 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218624004	f	\N	\N	\N
8860	RS Gimnastica	UD Ourense	2023-09-27 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218855224	f	\N	\N	\N
8863	Spartak Trnava	FC Kosice	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218579549	f	\N	\N	\N
8884	Antwerp	Gent	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218574225	t	0	\N	68
8871	Union Gurten	Rapid Vienna	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218884419	f	\N	\N	\N
8870	UD Logrones	CD Laredo	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218855404	f	\N	\N	\N
8867	Catanzaro	Cittadella	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218581463	f	\N	\N	\N
8865	Parma	SSD Bari	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218581553	f	\N	\N	\N
8864	Barnsley U21	Sheff Utd U21	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218857161	f	\N	\N	\N
8868	Como	Sampdoria	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218581373	f	\N	\N	\N
8872	Ballymena United (W)	Mid Ulster (W)	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218870338	f	\N	\N	\N
8882	Casertana	Monopoli	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218826422	f	\N	\N	\N
8879	Hibernian	St Mirren	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218756034	f	\N	\N	\N
8877	Aston Villa	Everton	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218297173	f	\N	\N	\N
8874	Bala Town	Aberystwyth	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218826548	f	\N	\N	\N
8880	Liverpool	Leicester	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218298229	f	\N	\N	\N
8878	Blackburn	Cardiff	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218298896	f	\N	\N	\N
8883	Chelsea	Brighton	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218298620	f	\N	\N	\N
8876	Napoli	Udinese	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218412478	f	\N	\N	\N
8881	Inter	Sassuolo	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218410708	t	1	\N	4
8873	Cesena	Spal	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218845676	f	\N	\N	\N
8875	Brentford	Arsenal	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218298058	f	\N	\N	\N
8862	Lugano	Lausanne	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218579819	t	1	\N	15
8890	Bournemouth	Stoke	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218297877	f	\N	\N	\N
8894	Ajax	FC Volendam	2023-09-27 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218578764	f	\N	\N	\N
8887	Ross Co	Aberdeen	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218755944	f	\N	\N	\N
8888	Lincoln	West Ham	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218298439	f	\N	\N	\N
8885	Lazio	Torino	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218410948	f	\N	\N	\N
8889	Fulham	Norwich	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218297716	f	\N	\N	\N
8886	Wehen Wiesbaden	RB Leipzig	2023-09-27 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218280487	f	\N	\N	\N
8897	FUS Rabat	HUSA Agadir	2023-09-27 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218862029	f	\N	\N	\N
8896	GKS Katowice	Gornik Zabrze	2023-09-27 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218868517	f	\N	\N	\N
8892	College 1975 FC	Lions Gibraltar	2023-09-27 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218863199	f	\N	\N	\N
8893	Palmeiras U20	Corinthians U20	2023-09-27 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218851175	f	\N	\N	\N
8891	Rangers	Livingston	2023-09-27 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218756214	f	\N	\N	\N
8895	Newcastle	Man City	2023-09-27 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218298762	f	\N	\N	\N
8898	Cadiz	Rayo Vallecano	2023-09-27 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218413078	f	\N	\N	\N
8899	Valencia	Real Sociedad	2023-09-27 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218411548	f	\N	\N	\N
8900	Leixoes	Estoril Praia	2023-09-27 20:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218602279	f	\N	\N	\N
8901	Guayaquil SC	CD America de Quito	2023-09-27 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218837452	f	\N	\N	\N
8902	Alianza Universidad	Union Huaral	2023-09-27 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218854388	f	\N	\N	\N
8904	Deportivo Nueva Concepcion	Solola FC	2023-09-27 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218888655	f	\N	\N	\N
8903	Deportivo San Pedro	Marquense	2023-09-27 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218888745	f	\N	\N	\N
8908	CSD Municipal	Achuapa FC	2023-09-27 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218858022	f	\N	\N	\N
8905	Santa Tecla	Jocoro	2023-09-27 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218858296	f	\N	\N	\N
8906	Cerro Porteno	Club Sportivo Ameliano	2023-09-27 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218826638	f	\N	\N	\N
5797	Berliner AK	Chemnitzer	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559877	f	\N	\N	\N
8907	Cobreloa Calama	Colo Colo	2023-09-27 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218862153	f	\N	\N	\N
5805	Unterhaching	Arminia Bielefeld	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342846	f	\N	\N	\N
8909	Juventud Pinulteca FC	Deportivo Mictlan	2023-09-27 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218858203	f	\N	\N	\N
8910	Sao Paulo	Coritiba	2023-09-27 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229432	f	\N	\N	\N
8911	LDU	Defensa y Justicia	2023-09-27 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217844299	f	\N	\N	\N
5802	Lyngby	Vejle	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158913	t	\N	\N	\N
8912	Alebrijes de Oaxaca	Dorados	2023-09-28 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218583440	f	\N	\N	\N
8913	Santa Fe	Deportivo Pereira	2023-09-28 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218889015	f	\N	\N	\N
8914	Philadelphia	FC Dallas	2023-09-28 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217260883	f	\N	\N	\N
8915	Univ de Concepcion	Magallanes	2023-09-28 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218862243	f	\N	\N	\N
8916	Real Esteli FC	Deportivo Saprissa	2023-09-28 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218890725	f	\N	\N	\N
8917	Macara	Club Nueve de Octubre	2023-09-28 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218837362	f	\N	\N	\N
8918	Fluminense	Internacional	2023-09-28 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217844191	f	\N	\N	\N
8919	Inter Miami CF	Houston Dynamo	2023-09-28 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218850115	f	\N	\N	\N
8920	Cd Fas	CD Dragon	2023-09-28 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218867231	f	\N	\N	\N
8921	Venados FC	CD Tepatitlan de Morelos	2023-09-28 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218602189	f	\N	\N	\N
8922	Colorado	Vancouver Whitecaps	2023-09-28 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218734589	f	\N	\N	\N
8923	Rionegro	Atletico Nacional Medellin	2023-09-28 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218888385	f	\N	\N	\N
8924	CSD Sacachispas	Barberena FC	2023-09-28 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218888565	f	\N	\N	\N
8925	Quiche FC	Club Deportivo Iztapa	2023-09-28 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218888835	f	\N	\N	\N
8926	Comunicaciones	CS Herediano	2023-09-28 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218890905	f	\N	\N	\N
8927	Los Angeles FC	Tigres	2023-09-28 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218854478	f	\N	\N	\N
8928	Celaya	Cancun FC	2023-09-28 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218599335	f	\N	\N	\N
5858	ADO Den Haag	SC Telstar	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504186	t	\N	\N	\N
8742	BVSC Zuglo	Vasas	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218842478	f	\N	\N	\N
8747	FC Ordabasy	FK Maqtaaral Jetisay	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218528695	f	\N	\N	\N
8939	Obolon-Brovar Kiev	Dynamo Kiev	2023-09-27 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218900420	f	\N	\N	\N
8942	SC Ramla	Bnei Eilat	2023-09-27 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218899635	f	\N	\N	\N
8958	Beitar Yavne	SC Hapoel Segev Shalom	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218899773	f	\N	\N	\N
8797	ASV Drassburg	FC Blau Weiss Linz	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218883921	f	\N	\N	\N
9000	Hapoel Mahane Yehuda	Hapoel Azor	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218899953	f	\N	\N	\N
9001	MS Jerusalem	Hapoel Yeruham	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218899863	f	\N	\N	\N
9017	Beitar Petah Tikva	Hapoel Kiryat Ono	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218900043	f	\N	\N	\N
9018	Beitar Kiryat Gat FC	Hapoel Bnei Ashdod	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218900133	f	\N	\N	\N
8831	Mamelodi Sundowns	Stellenbosch FC	2023-09-27 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218599696	f	\N	\N	\N
9028	FC Shikhun HaMizrah	Maccabi Ramla	2023-09-27 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218900223	f	\N	\N	\N
9031	Crystal Palace U21	Athletic Bilbao U21	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218912009	f	\N	\N	\N
9040	Liverpool U21	AS Monaco U21	2023-09-27 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218911919	f	\N	\N	\N
9058	SS Cosmos	SP Tre Penne	2023-09-27 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218901858	f	\N	\N	\N
9059	FC Fiorentino	SS San Giovanni	2023-09-27 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218901768	f	\N	\N	\N
9067	SP Villafranca	Puente Genil FC	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218899267	f	\N	\N	\N
9091	Fylkir/Ellidi U19	IR/Lettir U19	2023-09-27 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218907671	f	\N	\N	\N
9094	San Roque Lepe	CAP Ciudad de Murcia	2023-09-27 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218900331	f	\N	\N	\N
9104	Fraijanes FC	Universidad San Carlos	2023-09-27 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218901462	f	\N	\N	\N
9114	Hartford Athletic FC	Tampa Bay Rowdies	2023-09-28 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218904855	f	\N	\N	\N
9118	Libertad	Club Olimpia	2023-09-28 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218901956	f	\N	\N	\N
8775	Hodd	Sandnes Ulf	2023-09-27 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218763424	t	\N	\N	\N
8813	Ostersunds FK	IK Brage	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218568157	t	\N	\N	\N
8818	Villarreal	Girona	2023-09-27 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218412778	t	0	\N	3
5930	FC Juarez	Atlas	2023-09-23 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.217988318	f	\N	\N	\N
5776	FK Spartak	Vozdovac	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575471	f	\N	\N	\N
5962	SC Bruck an der Mur	UFC Fehring	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218636819	f	\N	\N	\N
5807	Tennis Borussia Berlin	FC Hertha 03 Zehlendorf	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590030	f	\N	\N	\N
5793	Macva Sabac	FK Sloboda Point	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218594548	f	\N	\N	\N
5823	Bad Sauerbrunn	Deutschkreutz	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218609518	f	\N	\N	\N
5866	Everton U21	Norwich U21	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218598884	f	\N	\N	\N
6043	RFC de Liege U21	Waasland-Beveren (Res)	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218648429	f	\N	\N	\N
3337	FC Nordsjaelland	FC Copenhagen	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217900814	f	\N	\N	\N
3345	York City	Southend	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218121261	f	\N	\N	\N
3353	Barnsley	Burton Albion	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889960	f	\N	\N	\N
3304	Fjolnir	Njardvik	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319692	f	\N	\N	\N
3329	FC Pyunik	BKMA Yerevan	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268176	f	\N	\N	\N
3359	Celtic	Dundee	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637359	f	\N	\N	\N
8804	Verona	Atalanta	2023-09-27 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218411068	f	1	\N	4
8866	St Gallen	Young Boys	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218579729	t	0	\N	15
8869	Servette	Winterthur	2023-09-27 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218579639	t	1	\N	15
9133	Persipura Jayapura	Aceh United FC	2023-09-28 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218902046	f	\N	\N	\N
9134	Japan (W)	Vietnam (W)	2023-09-28 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218890995	f	\N	\N	\N
9135	Maccabi Ahva Shaab	Ahali Tamra	2023-09-28 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218902967	f	\N	\N	\N
9136	Zaqatala	MOIK Baku	2023-09-28 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218890185	f	\N	\N	\N
9137	South Korea (W)	Hong Kong (W)	2023-09-28 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218890815	f	\N	\N	\N
9138	Samgurali Tskaltubo	Samtredia	2023-09-28 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218890635	f	\N	\N	\N
9139	Mil-Mugan FK	Shamakhi FK	2023-09-28 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218890005	f	\N	\N	\N
9140	Etar	Pirin Blagoevgrad	2023-09-28 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218428242	f	\N	\N	\N
9141	Adana 1954 FK	Osmaniyespor 2011	2023-09-28 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218918445	f	\N	\N	\N
9142	Maccabi Shaaraim	Hapoel Herzliya	2023-09-28 13:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218858388	f	\N	\N	\N
9143	Maccabi Nujeidat Ahmad	MS Tzeirey Kfar Kana	2023-09-28 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218893089	f	\N	\N	\N
9144	Hapoel Migdal HaEmek	MS Tira	2023-09-28 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218892999	f	\N	\N	\N
9145	Al-Masry	Pharco FC	2023-09-28 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218650723	f	\N	\N	\N
9146	Hapoel Kaukab	MSK Kiryat Yam	2023-09-28 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218897958	f	\N	\N	\N
9147	Kalamata	Kallithea	2023-09-28 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218910428	f	\N	\N	\N
9148	AS Nordia Jerusalem	Hapoel Bikat Hayarden	2023-09-28 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218897598	f	\N	\N	\N
9149	CSA Steaua Bucuresti	Universitatea Cluj	2023-09-28 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218539856	f	\N	\N	\N
9150	Ironi Modiin	Hapoel Marmorek	2023-09-28 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218892909	f	\N	\N	\N
9154	Hapoel Kfar Shelem	Shimshon Kfar Qasem	2023-09-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218893972	f	\N	\N	\N
9155	FC Elva	Paide Linnameeskond II	2023-09-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218892729	f	\N	\N	\N
9151	Al Salt	Al Arabi (Jor)	2023-09-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218918717	f	\N	\N	\N
9152	Flora Tallinn II	Tallinna JK Legion	2023-09-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218892639	f	\N	\N	\N
9153	Nomme Utd	Viimsi JK	2023-09-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218892459	f	\N	\N	\N
9158	Odisha	Mumbai City FC	2023-09-28 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218774031	f	\N	\N	\N
9159	Panserraikos	PAS Giannina	2023-09-28 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218467337	f	\N	\N	\N
9166	NC Magra U21	US Biskra U21	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218890455	f	\N	\N	\N
9165	JS Saoura U21	ES Ben Aknoun U21	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218889735	f	\N	\N	\N
9169	ES Setif U21	USM Alger U21	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218889915	f	\N	\N	\N
9162	MC Alger U21	MC El Bayadh U21	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218890095	f	\N	\N	\N
9161	AC Paradou U21	CR Belouizdad U21	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218889645	f	\N	\N	\N
9167	Pogon Szczecin II	Polonia Bytom	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218913971	f	\N	\N	\N
9160	US Souf U21	MC Oran U21	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218890365	f	\N	\N	\N
9163	USM Khenchela U21	JS Kabylie U21	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218890275	f	\N	\N	\N
9168	ASO Chlef U21	CS Constantine U21	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218889825	f	\N	\N	\N
9164	Levski Krumovgrad	Arda	2023-09-28 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218428375	f	\N	\N	\N
9170	FCM Alexandria	CFR Cluj	2023-09-28 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218156882	f	\N	\N	\N
9172	NK Maribor	NK Radomlje	2023-09-28 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218629117	f	\N	\N	\N
9171	Tampereen Ilves II	HJS Akatemia	2023-09-28 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218892819	f	\N	\N	\N
9174	Manama Club	Al Hala	2023-09-28 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218889555	f	\N	\N	\N
9173	SV Turkgucu-Ataspor	Wurzburger Kickers	2023-09-28 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218904945	f	\N	\N	\N
9177	FK Kauno Zalgiris	FK Dainava Alytus	2023-09-28 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218923936	f	\N	\N	\N
9178	GKS Tychy	Wisla Plock	2023-09-28 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218910707	f	\N	\N	\N
9179	Torpedo Kutaisi	Dinamo Batumi	2023-09-28 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218893802	f	\N	\N	\N
9176	Al Najma (BRN)	Al-Shabbab (BRN)	2023-09-28 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218889465	f	\N	\N	\N
9175	Ismaily	Al Ittihad (EGY)	2023-09-28 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218620068	f	\N	\N	\N
9180	KA Akureyri	IBV	2023-09-28 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218775836	f	\N	\N	\N
9182	Molenbeek	Union St Gilloise	2023-09-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218574338	f	\N	\N	\N
9181	Maccabi Yavne	Shimshon Tel Aviv	2023-09-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218896893	f	\N	\N	\N
9183	AC Monza	Bologna	2023-09-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218411188	f	\N	\N	\N
9184	Frosinone	Fiorentina	2023-09-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218430419	t	1	\N	4
9185	Maccabi Tzur Shalom	Hapoel Raanana	2023-09-28 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218897778	f	\N	\N	\N
9186	MS Hapoel Lod	Hapoel Tzafririm Holon	2023-09-28 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218897508	f	\N	\N	\N
9187	Breidablik/Augn	KR/KV Reykjavik U19	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218918232	f	\N	\N	\N
9190	Maccabi Ashdod B.C.	Agudat Sport Ashdod	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218897688	f	\N	\N	\N
9198	Granada	Betis	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218435196	f	\N	\N	\N
9189	Kohtla-Jarve	FC Tallinn	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218892549	f	\N	\N	\N
9196	Orebro	Utsiktens	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218568607	f	\N	\N	\N
9188	Tzeirey Umm al-Fahm	Hapoel Bnei Zalafa	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218897868	f	\N	\N	\N
9197	Valerenga	Bodo Glimt	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218910524	f	\N	\N	\N
9194	Sundsvall	Gefle	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218568697	f	\N	\N	\N
9200	Celta Vigo	Alaves	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218435042	f	\N	\N	\N
9195	Kotwica Kolobrzeg	Nieciecza	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218910798	f	\N	\N	\N
9192	Nykobing FC	AGF	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218903189	f	\N	\N	\N
9199	Fenerbahce	Basaksehir	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218622785	f	\N	\N	\N
9193	Trelleborgs	Jonkopings Sodra	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218568787	t	\N	\N	\N
9201	HaMakhtesh Givatayim	Hakoah Amidar Ramat Gan	2023-09-28 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218902787	f	\N	\N	\N
9202	Asteras Tripolis	Panathinaikos	2023-09-28 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218467427	f	\N	\N	\N
9203	CSKA Sofia	Lokomotiv Sofia	2023-09-28 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218428915	f	\N	\N	\N
9204	Honved	Budafoki	2023-09-28 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218849806	f	\N	\N	\N
9209	Az Alkmaar	Heracles	2023-09-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218621750	t	1	\N	196
9205	Lech Poznan	Rakow Czestochowa	2023-09-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218593339	f	\N	\N	\N
9207	AEK Athens	Atromitos	2023-09-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218467156	f	\N	\N	\N
9208	Botosani	Rapid Bucharest	2023-09-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218158424	f	\N	\N	\N
9206	Union Comercio	Binacional	2023-09-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218857654	f	\N	\N	\N
9210	Olimpija	Koper	2023-09-28 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218626473	f	\N	\N	\N
9226	Osasuna	Atletico Madrid	2023-09-28 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218411428	t	1	\N	3
9212	FC Basel	Luzern	2023-09-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218593774	f	\N	\N	\N
9214	Genoa	Roma	2023-09-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218430299	f	\N	\N	\N
9222	Club Football Estrela	Braga	2023-09-28 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218634709	t	\N	\N	\N
9216	Wisla Krakow	Lechia Gdansk	2023-09-28 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218910888	f	\N	\N	\N
9215	St. Joseph's FC	Lincoln Red Imps	2023-09-28 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218912521	f	\N	\N	\N
9218	Vikingur Reykjavik	Hafnarfjordur	2023-09-28 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218598025	f	\N	\N	\N
9223	SS Folgore/Falciano	SS Pennarossa	2023-09-28 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218913517	f	\N	\N	\N
9211	Stade Lausanne-Ouchy	Yverdon Sport	2023-09-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218704447	t	1	\N	15
9220	HK Kopavogur	Fylkir	2023-09-28 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218680559	f	\N	\N	\N
9221	SS Murata	Domagnano	2023-09-28 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218919352	f	\N	\N	\N
9224	Stjarnan	KR Reykjavik	2023-09-28 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218680649	f	\N	\N	\N
9217	Valur	Breidablik	2023-09-28 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218680467	f	\N	\N	\N
9219	Fram	Keflavik	2023-09-28 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218604710	f	\N	\N	\N
9225	Casa Pia	CD Nacional Funchal	2023-09-28 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218648247	f	\N	\N	\N
9213	Club Brugge	Genk	2023-09-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218574474	t	1	\N	68
9227	Fjolnir/ Vaengir U19	Throttur Reykjavik/SR U19	2023-09-28 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218918185	f	\N	\N	\N
9229	Mirassol	CRB	2023-09-28 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218656532	f	\N	\N	\N
9228	Cucuta Deportivo	Ind Medellin	2023-09-28 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218910615	f	\N	\N	\N
9230	Universidad Cesar Vallejo	Universitario de Depor	2023-09-29 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218857744	f	\N	\N	\N
9231	Guarani (Par)	Guairena	2023-09-29 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218919536	f	\N	\N	\N
9232	Manta FC	Chacaritas SC	2023-09-29 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218837272	f	\N	\N	\N
9233	Millonarios	Alianza Petrolera	2023-09-29 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218919444	f	\N	\N	\N
9235	Londrina	Sampaio Correa FC	2023-09-29 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218669497	f	\N	\N	\N
9234	Boca Juniors	SE Palmeiras	2023-09-29 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217817430	f	\N	\N	\N
9236	Alianza Lima	Melgar	2023-09-29 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218855767	f	\N	\N	\N
9237	CS Cartagines	LD Alajuelense	2023-09-29 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218923609	f	\N	\N	\N
9238	Atlas	Puebla	2023-09-29 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218470769	f	\N	\N	\N
9191	Orgryte	GAIS	2023-09-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218568517	t	\N	\N	\N
9156	FC Telavi	Dila Gori	2023-09-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218893712	f	\N	\N	\N
9157	Ironi Nesher	Ironi Baka El Garbiya	2023-09-28 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218894895	f	\N	\N	\N
9258	Burgan SC	Al Tadhamon	2023-09-28 16:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218942539	f	\N	\N	\N
9268	Viking 2	Madla	2023-09-28 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218942629	f	\N	\N	\N
9329	PS Barito Putera	RANS Nusantara FC	2023-09-29 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218931894	f	\N	\N	\N
9330	Kirivong Sok Sen Chey	ISI Dangkor Senchey FC	2023-09-29 09:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218931793	f	\N	\N	\N
9331	MO Constantine U21	IB Khemis El Khechna U21	2023-09-29 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218953990	f	\N	\N	\N
9332	NK Varazdin U19	NK Dugopolje U19	2023-09-29 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218957171	f	\N	\N	\N
9333	Istanbul Basaksehir FK U19	Ankaraspor U19	2023-09-29 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218933006	f	\N	\N	\N
9334	Cangzhou Mighty Lions	Meizhou Hakka	2023-09-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218708197	f	\N	\N	\N
9335	Kawasaki	Albirex Niigata	2023-09-29 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664692	f	\N	\N	\N
9336	Yokohama FM	Kobe	2023-09-29 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218664602	f	\N	\N	\N
9337	Urawa	Yokohama FC	2023-09-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218664782	f	\N	\N	\N
9338	Nakhon Si United F.C.	Chainat Hornbill	2023-09-29 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218933096	f	\N	\N	\N
9339	Colchester United U21	Bournemouth U21	2023-09-29 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218964173	f	\N	\N	\N
9340	Boeung Ket	Nagaworld FC	2023-09-29 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218931578	f	\N	\N	\N
9341	BG Pathumthani United	Lamphun Warrior	2023-09-29 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218952982	f	\N	\N	\N
9342	Karvan Evlakh	Agsu	2023-09-29 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218956625	f	\N	\N	\N
9343	Shenzhen FC	Changchun Yatai	2023-09-29 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218758411	f	\N	\N	\N
9344	Nantong Zhiyun F.C	Shanghai Port FC	2023-09-29 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218758321	f	\N	\N	\N
9345	Shandong Taishan	Wuhan Three Towns	2023-09-29 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218708377	f	\N	\N	\N
9346	Tianjin Jinmen Tiger FC	Chengdu Rongcheng	2023-09-29 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218708287	f	\N	\N	\N
9347	Bali Utd Pusam	PS TIRA	2023-09-29 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218934576	f	\N	\N	\N
9348	Bangkok Utd	Buriram Utd	2023-09-29 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218933186	f	\N	\N	\N
9349	Muhoroni Youth FC	Ulinzi Stars	2023-09-29 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218914249	f	\N	\N	\N
9350	Znojmo	SK Kvítkovice	2023-09-29 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218935902	f	\N	\N	\N
9351	JKT Tanzania	Kagera Sugar	2023-09-29 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218965059	f	\N	\N	\N
9352	Terengganu	Selangor FA	2023-09-29 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218935992	f	\N	\N	\N
9353	Zrinski Jurjevac	NK Sesvete	2023-09-29 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218924051	f	\N	\N	\N
9354	Ilirija Extra-Lux	NK Primorje	2023-09-29 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218917890	f	\N	\N	\N
9355	Gorica	NK Fuzinar	2023-09-29 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218917778	f	\N	\N	\N
9356	Sepsi II	ASC Tărlungeni	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218979785	f	\N	\N	\N
9365	ACS Tg. Mures 1898	CS Universitatea Alba Iulia	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218950025	f	\N	\N	\N
9360	MCB Oued Sly	ES Mostaganem	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218935476	f	\N	\N	\N
9361	ACS Vedita Colonesti MS	AS Cozia Calimanesti	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218950271	f	\N	\N	\N
9363	JS Bordj Menaiel	AS Khroub	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218935206	f	\N	\N	\N
9362	ACS Inainte Modelu	Dunarea Calarasi	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218950484	f	\N	\N	\N
9358	Sanatatea Cluj	SCM Zalau	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218950592	f	\N	\N	\N
9366	U Craiova 1948 SA II	CS Uni Craiova II	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218950118	f	\N	\N	\N
9367	CA Batna	Olympique Akbou	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218935026	f	\N	\N	\N
9368	USM El Eulma	AS Ain M'lila	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218935116	f	\N	\N	\N
9359	NRB Teleghma	USM El Harrach	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218935296	f	\N	\N	\N
9357	CS Dinamo Bucuresti	Muscelul Campulung	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218950377	f	\N	\N	\N
9370	Northeast United	Chennaiyin FC	2023-09-29 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218774121	f	\N	\N	\N
9369	IPS	Union Plaani	2023-09-29 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218947949	f	\N	\N	\N
9372	USM Khenchela	Kabylie	2023-09-29 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218931488	f	\N	\N	\N
9371	NC Magra	US Biskra	2023-09-29 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218937722	f	\N	\N	\N
9373	US Souf	MC Oran	2023-09-29 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218931278	f	\N	\N	\N
9377	Ceahlaul	FC Unirea Dej	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218807924	f	\N	\N	\N
9376	Al-Hazm (KSA)	Al-Taawoun Buraidah	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218758760	f	\N	\N	\N
9374	VPS	FC Inter	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218667088	f	\N	\N	\N
9375	AC Oulu	KTP	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218667178	f	\N	\N	\N
9378	Hegelmann Litauen	FK Banga Gargzdu	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218915538	f	\N	\N	\N
9379	FK Babrungas	FK Nevezis	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218938016	f	\N	\N	\N
9381	BFC Daugavpils	FS METTA/LU	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218937926	f	\N	\N	\N
9383	Al-Feiha	Al-Ittihad	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218684309	f	\N	\N	\N
9382	Al Taee	Al Nassr	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218681676	f	\N	\N	\N
9384	Zilina	MFK Skalica	2023-09-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218622877	f	\N	\N	\N
9385	Kurvin Vauhti	FC Kirkkonummi	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218947769	f	\N	\N	\N
9387	Pisek	FK MAS Taborsko II	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218937812	f	\N	\N	\N
9397	Krka	Beltinci	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218917997	f	\N	\N	\N
9399	Al Ahli (BRN)	Sitra	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218906838	f	\N	\N	\N
9395	Correcaminos (Premier)	Mineros de Fresnillo FC	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218938394	f	\N	\N	\N
9396	Tampere Utd	FC Jazz	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218936442	f	\N	\N	\N
9393	Busaiteen Club	East Riffa	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218906568	f	\N	\N	\N
9390	Al Ahly Cairo	Saint George FC	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218932286	f	\N	\N	\N
9394	Qarabag Fk	FK Sumqayit	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218924410	f	\N	\N	\N
9392	Pribram	MFK Chrudim	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218672664	f	\N	\N	\N
9388	Dinamo Tbilisi	FC Saburtalo Tbilisi	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218938304	f	\N	\N	\N
9398	Polonia Warszawa	Podbeskidzie B-B	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218652721	f	\N	\N	\N
9389	Al-Muharraq	Al Khalidiyah	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218906441	f	\N	\N	\N
9386	SAK Klagenfurt	Asco Atsv Wolfsberg	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218936262	f	\N	\N	\N
9391	Stal Mielec	Korona Kielce	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218594077	f	\N	\N	\N
9400	GKS Wikielec	Legionovia Legionowo	2023-09-29 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218964353	f	\N	\N	\N
9401	FC Liefering	DSV Leoben	2023-09-29 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218664062	f	\N	\N	\N
9403	SV Ried	SV Horn	2023-09-29 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218663905	f	\N	\N	\N
9402	FC Dornbirn	SV Stripfing/Weiden	2023-09-29 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218664000	f	\N	\N	\N
9406	LPS	Sapa Helsinki	2023-09-29 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218948221	f	\N	\N	\N
9404	Aifk Turku	TPK	2023-09-29 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218939566	f	\N	\N	\N
9405	Tote	VJS	2023-09-29 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218939656	f	\N	\N	\N
9408	Kolding IF (W)	Thisted (W)	2023-09-29 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218939476	f	\N	\N	\N
9407	Valtti	JaPS/47	2023-09-29 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218948312	f	\N	\N	\N
9409	Vojvodina	FK IMT Novi Beograd	2023-09-29 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218965165	f	\N	\N	\N
9411	Hamburger SV	Fortuna Dusseldorf	2023-09-29 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218517244	t	0	\N	93
9412	Kazma SC	Al Jahra	2023-09-29 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218960076	f	\N	\N	\N
9415	Frederiksberg	Middelfart	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218957747	f	\N	\N	\N
9430	Viktoria Aschaffenburg	FC Memmingen	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218874631	f	\N	\N	\N
9423	Supersport Utd	Gaborone United	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218965470	f	\N	\N	\N
9421	Umraniyespor	Bandirmaspor	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218772935	f	\N	\N	\N
9429	Felgueiras	Braga B	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218854568	f	\N	\N	\N
9431	Atlantis	EPS	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218936352	f	\N	\N	\N
9420	Arminia Bielefeld	Saarbrucken	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218665636	f	\N	\N	\N
9424	Spartak Myjava	MSK Zilina II	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218917646	f	\N	\N	\N
9416	Treibach	SV Donau Klagenfurt	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218936082	f	\N	\N	\N
9426	Chemie Leipzig	Altglienicke	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218911470	f	\N	\N	\N
9428	FC Gleisdorf 09	St.Anna	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218934666	f	\N	\N	\N
9433	Eint Frankfurt II	TSG Balingen	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218915811	f	\N	\N	\N
9425	TUS Bad Gleichenberg	Deutschlandsberger SC Mithl	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218934846	f	\N	\N	\N
9432	Hertha Berlin II	Babelsberg	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218911379	f	\N	\N	\N
9419	SPG Lask Amateure	WSC Hertha Wels	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218934756	f	\N	\N	\N
9427	Voitsberg	Union Volksbank Vocklamarkt	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218934936	f	\N	\N	\N
9418	FC Astoria Walldorf	Kickers Offenbach	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218916025	f	\N	\N	\N
9422	FSV 63 Luckenwalde	Lokomotiv Leipzig	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218911289	f	\N	\N	\N
9414	Ace	Tervakosken Pato	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218947859	f	\N	\N	\N
9417	Fyllingsdalen	Bjarg	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218948946	f	\N	\N	\N
9413	Paderborn	Schalke 04	2023-09-29 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218516702	t	1	\N	93
9434	Hillerod Fodbold	AC Horsens	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218768899	t	0	\N	147
9476	Jong AZ Alkmaar	Willem II	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218748904	t	1	\N	199
9438	EsPa	NuPS	2023-09-29 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218948131	f	\N	\N	\N
9439	LJS	HIFK 2	2023-09-29 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218948040	f	\N	\N	\N
9437	Herto	Gnistan Ogeli	2023-09-29 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218948402	f	\N	\N	\N
9455	FC Wil	Aarau	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218731293	f	\N	\N	\N
9452	Niort	Dijon	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218670443	f	\N	\N	\N
9442	Kremser SC	Austria Wien (A)	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218934486	f	\N	\N	\N
9446	Villefranche Beaujolais	Orleans	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218672754	f	\N	\N	\N
9445	Nancy	Versailles 78 FC	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218665057	f	\N	\N	\N
9448	Flandria	Guillermo Brown	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218872003	f	\N	\N	\N
9451	Marignane-Gignac	Epinal	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218665147	f	\N	\N	\N
9441	Le Mans	Sochaux	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218664931	f	\N	\N	\N
9456	Cholet SO	Nimes	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218665237	f	\N	\N	\N
9454	FC Wegberg-Beeck	SV Rodinghausen	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218872935	f	\N	\N	\N
9449	Hassleholms IF	Karlskrona	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218955052	f	\N	\N	\N
9453	Rouen	Martigues	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218669638	f	\N	\N	\N
9440	Avranches	Goal	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218673111	f	\N	\N	\N
9450	Moroka Swallows	AmaZulu	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218704085	f	\N	\N	\N
9444	Velbert	Wuppertaler	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218872828	f	\N	\N	\N
9443	Lommel SK U21	KV Oostende (Res)	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218933946	f	\N	\N	\N
9457	Orlando Pirates (SA)	Jwaneng Galaxy FC	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218932196	f	\N	\N	\N
9460	Aston Villa U21	Sunderland U21	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218964083	f	\N	\N	\N
9478	SL 16 FC	Patro Eisden Maasmechelen	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218936172	f	\N	\N	\N
9467	FC Oss	Emmen	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218748634	f	\N	\N	\N
9479	Otelul Galati	Dinamo Bucharest	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526700	f	\N	\N	\N
9473	SC Neusiedl am See	Wiener Victoria	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218934396	f	\N	\N	\N
9469	FC Eindhoven	FC Dordrecht	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218748454	f	\N	\N	\N
9470	FCV Dender EH U21	AS Eupen (Res)	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218934126	f	\N	\N	\N
9458	Southampton U21	Reading U21	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218963993	f	\N	\N	\N
9464	FC Groningen	Den Bosch	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218748544	t	0	\N	199
9468	Zalaegerszeg	Puskas Akademia	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218427561	f	\N	\N	\N
9480	MVV Maastricht	ADO Den Haag	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218748724	t	\N	\N	\N
9474	Swansea U21	Hull City U21	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218964263	f	\N	\N	\N
9435	Vendsyssel FF	AaB	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218719756	t	2	4	147
9472	Deinze	Waasland-Beveren	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218769397	t	0	\N	136
9461	Derby U21	Brighton U21	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218958103	f	\N	\N	\N
9462	Middlesbrough U21	Stoke U21	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218958013	f	\N	\N	\N
9477	Fulham U21	Leicester U21	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218958193	f	\N	\N	\N
9466	RWD Molenbeek U21	KMSK Deinze U21	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218934036	f	\N	\N	\N
9471	SC Telstar	Jong Ajax Amsterdam	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218670246	f	\N	\N	\N
9475	De Graafschap	Roda JC	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218748814	f	\N	\N	\N
9463	Newcastle U21	Nottingham Forest U21	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218963903	f	\N	\N	\N
9481	Al-Hilal	Al-Shabab (KSA)	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218687929	f	\N	\N	\N
9459	Everton U21	Arsenal U21	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218957923	f	\N	\N	\N
9482	Neuchatel Xamax	Sion	2023-09-29 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218731383	f	\N	\N	\N
9485	St Polten	Grazer AK	2023-09-29 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218669055	f	\N	\N	\N
9487	Hoffenheim	Dortmund	2023-09-29 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218410348	f	\N	\N	\N
9483	Arka Gdynia	LKP Motor Lublin	2023-09-29 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218667268	f	\N	\N	\N
9484	Piast Gliwice	Widzew Lodz	2023-09-29 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218593897	f	\N	\N	\N
9486	Francs Borains U21	Westerlo (Res)	2023-09-29 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218954278	f	\N	\N	\N
9489	Waterford	Wexford F.C	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218835265	f	\N	\N	\N
9488	Derry City	UCD	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218673474	f	\N	\N	\N
9492	Dundalk	Drogheda	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218730555	f	\N	\N	\N
9496	Galway Utd	Athlone Town	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218835355	f	\N	\N	\N
9493	Shamrock Rovers	Shelbourne	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218730843	f	\N	\N	\N
9498	Cork City	St Patricks	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218730753	f	\N	\N	\N
9500	Pergolettese	Aurora Pro Patria 1919	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218835175	f	\N	\N	\N
9501	SS Virtus Verona 1921	Novara	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218834995	f	\N	\N	\N
9503	Sheff Wed	Sunderland	2023-09-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218577468	t	\N	\N	\N
9491	Bray Wanderers	Cobh Ramblers	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218673564	f	\N	\N	\N
9490	Triestina	Mantova	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218834905	f	\N	\N	\N
9494	Alessandria	SSD Pro Sesto	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218835085	f	\N	\N	\N
9499	Bohemians	Sligo Rovers	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218730933	f	\N	\N	\N
9497	Hamilton	Annan	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218673924	f	\N	\N	\N
9505	Paris FC (W)	Fleury 91 (W)	2023-09-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218955340	f	\N	\N	\N
9509	Benfica	Porto	2023-09-29 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218728329	t	0	\N	8
9504	Finn Harps	Kerry FC	2023-09-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218835445	f	\N	\N	\N
9507	Leganes	Racing Santander	2023-09-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218670608	f	\N	\N	\N
9502	Glacis Utd	Europa Point FC	2023-09-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218958454	f	\N	\N	\N
9512	UTC Cajamarca	Sport Boys (Per)	2023-09-29 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218855949	f	\N	\N	\N
9513	Sportivo Penarol	Juventud Uni	2023-09-29 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218966984	f	\N	\N	\N
9511	Sport Huancayo	Deportivo Municipal	2023-09-29 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218863677	f	\N	\N	\N
9510	RSB Berkane	Bendel Insurance	2023-09-29 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218932104	f	\N	\N	\N
9514	Boyaca Patriotas	Fortaleza FC	2023-09-29 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218837002	f	\N	\N	\N
9515	Avai	Sport Recife	2023-09-29 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218674089	f	\N	\N	\N
9517	Cusco FC	Sporting Cristal	2023-09-30 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218856129	f	\N	\N	\N
9518	Club Necaxa (W)	Monterrey (W)	2023-09-30 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218948855	f	\N	\N	\N
9516	Tigre	Velez Sarsfield	2023-09-30 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218780330	f	\N	\N	\N
9519	Jaguares de Cordoba	Junior FC Barranquilla	2023-09-30 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218869771	f	\N	\N	\N
9520	Christchurch United	Wellington Phoenix (Res)	2023-09-30 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218940200	f	\N	\N	\N
9521	Excursionistas	Justo Jose de Urquiza	2023-09-30 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218954188	f	\N	\N	\N
9524	Wellington Olympic AFC	Napier City Rovers	2023-09-30 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218940288	f	\N	\N	\N
9523	Gualaceo SC	Deportivo Cuenca	2023-09-30 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218679247	f	\N	\N	\N
9522	Quilmes	Tristan Suarez	2023-09-30 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218872291	f	\N	\N	\N
9525	EC Vitoria Salvador	Tombense MG	2023-09-30 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218677050	f	\N	\N	\N
9528	FC Santiago	Zitacuaro CF	2023-09-30 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218960613	f	\N	\N	\N
9531	Petone	Cashmere Technical	2023-09-30 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218940376	f	\N	\N	\N
9529	Arabe Unido	Atletico Independiente	2023-09-30 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218965380	f	\N	\N	\N
9532	Queretaro	Leon	2023-09-30 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218470499	f	\N	\N	\N
9526	CD Motagua	Genesis Huracan	2023-09-30 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218958770	f	\N	\N	\N
9527	Cavalry	Valour	2023-09-30 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829695	f	\N	\N	\N
9533	Tolima	Boyaca Chico	2023-09-30 02:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218870222	f	\N	\N	\N
9535	Chihuahua FC	Los Cabos United	2023-09-30 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218960703	f	\N	\N	\N
9534	Futbol Consultants Moravia	Escorpiones FC	2023-09-30 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218965650	f	\N	\N	\N
9536	Tijuana	FC Juarez	2023-09-30 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218470589	f	\N	\N	\N
9537	Atletico San Luis	Cruz Azul	2023-09-30 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218470679	f	\N	\N	\N
9538	Honda FC	Briobecca Urayasu SC	2023-09-30 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218964663	f	\N	\N	\N
9540	Sendai	Kumamoto	2023-09-30 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218691474	f	\N	\N	\N
9539	Criacao Shinjuku	Sony Sendai FC	2023-09-30 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218964753	f	\N	\N	\N
9541	Fujieda MYFC	Shimizu	2023-09-30 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218691384	f	\N	\N	\N
9542	Sapporo	Kashiwa	2023-09-30 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218701194	f	\N	\N	\N
9543	FC Anyang	Seongnam FC	2023-09-30 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218704357	f	\N	\N	\N
9364	MO Constantine	IB Khemis El Khechna	2023-09-29 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218935386	f	\N	\N	\N
9380	Pyramids	APR FC	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218932376	f	\N	\N	\N
9567	JS Guire	JSM Tiaret	2023-09-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218984328	f	\N	\N	\N
9410	1. FC Heidenheim U19	FC Ingolstadt 04 U19	2023-09-29 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218965560	f	\N	\N	\N
9436	Samsunspor	Gaziantep FK	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559446	f	\N	\N	\N
9615	Werder Bremen II	ESC Geestemunde	2023-09-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218979967	f	\N	\N	\N
9627	FC Hoyvik	Havnar Boltfelag II	2023-09-29 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218980060	f	\N	\N	\N
9447	Waasland-Beveren (Res)	Patro Maasmechelen U21	2023-09-29 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218934216	f	\N	\N	\N
9659	FV Engers 07	FC Bitburg	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218979877	f	\N	\N	\N
9708	Sportivo Trinidense	Club General Caballero JLM	2023-09-30 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218987416	f	\N	\N	\N
9530	Petroleros de Salamanca	Inter Playa Del Carmen	2023-09-30 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218960884	f	\N	\N	\N
9465	Cambuur Leeuwarden	Jong PSV Eindhoven	2023-09-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218748994	t	2	7	199
9495	Kortrijk	Cercle Brugge	2023-09-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218669605	t	0	\N	68
9508	Barcelona	Sevilla	2023-09-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218545553	t	0	\N	3
9506	Strasbourg	Lens	2023-09-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218411668	t	1	\N	5
5744	USM Alger U21	USM Khenchela U21	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218629837	f	\N	\N	\N
5679	Beitar Ramat Gan	Beitar Petah Tikva	2023-09-22 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218614262	f	\N	\N	\N
3317	SJK	Honka	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122644	f	\N	\N	\N
3319	MK Dons	Stockport	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951539	f	\N	\N	\N
3358	Cove Rangers	Kelty Hearts	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217919918	f	\N	\N	\N
3313	Bradford	Harrogate Town	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951176	f	\N	\N	\N
3314	Crawley Town	Tranmere	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217950996	f	\N	\N	\N
3316	Forest Green	Doncaster	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951266	f	\N	\N	\N
3335	Wrexham	Grimsby	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951447	f	\N	\N	\N
3354	Coleraine	Newry	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218123023	f	\N	\N	\N
3305	Selfoss	IF Vestri	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319962	f	\N	\N	\N
3322	KFG	Throttur Vogar	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320248	f	\N	\N	\N
3321	Rochdale	Barnet	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120541	f	\N	\N	\N
3355	Port Vale	Northampton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889322	f	\N	\N	\N
3357	Annan	Stirling	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217920404	f	\N	\N	\N
3325	Hamilton	Alloa	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217920717	f	\N	\N	\N
3330	Oxford City	Dag and Red	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120721	f	\N	\N	\N
3347	NK Fuzinar	Krka	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270328	f	\N	\N	\N
5210	Hull	Leeds	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884197	f	\N	\N	\N
3356	Wycombe	Blackpool	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217888994	f	\N	\N	\N
3352	Torns	FC Trollhattan	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137715	f	\N	\N	\N
3326	Ebbsfleet Utd	Chesterfield	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120361	f	\N	\N	\N
3301	Vasalunds IF	Orebro Syrianska	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137985	f	\N	\N	\N
3339	Hartlepool	Woking	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120631	f	\N	\N	\N
3350	Tabor Sezana	NK Jadran Dekani	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270148	f	\N	\N	\N
3341	FK Puchov	FK Humenne	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228468	f	\N	\N	\N
3318	Keflavik (W)	Selfoss (W)	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320664	f	\N	\N	\N
3311	Molenbeek	Cercle Brugge	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217902501	f	\N	\N	\N
3348	Eskilsminne	Vanersborgs IF	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138075	f	\N	\N	\N
3323	Peterborough	Leyton Orient	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889852	f	\N	\N	\N
3342	Colchester	Mansfield	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951719	f	\N	\N	\N
3327	AFC Wimbledon	Crewe	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217950816	f	\N	\N	\N
3344	Kayserispor	Gaziantep FK	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218113807	f	\N	\N	\N
3312	AFC Fylde	Eastleigh	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120451	f	\N	\N	\N
3303	Exeter	Cheltenham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889210	f	\N	\N	\N
3324	Falkirk	Queen of South	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217920008	f	\N	\N	\N
3306	Throttur	Afturelding	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319872	f	\N	\N	\N
3302	Watford	Birmingham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646009	f	\N	\N	\N
3338	Aldershot	Gateshead	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218121171	f	\N	\N	\N
3333	FK Igman Konjic	FK Velez Mostar	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319096	f	\N	\N	\N
5912	Chilangos FC	FC Santiago	2023-09-22 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218623464	f	\N	\N	\N
6047	Austria Wien (A)	SPG Oberwart/R	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595576	f	\N	\N	\N
6050	FK Lyn U19	Baerum SK U19	2023-09-22 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218649836	f	\N	\N	\N
5339	Tolima	Envigado	2023-09-21 23:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218512032	f	\N	\N	\N
3346	Swindon	Walsall	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951629	f	\N	\N	\N
3343	Fulham	Luton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634798	f	\N	\N	\N
3332	Hearts	Aberdeen	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637467	f	\N	\N	\N
3320	Bristol City	West Brom	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645253	f	\N	\N	\N
3349	Falkenbergs	Norrby IF	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138517	f	\N	\N	\N
5922	Ituano	EC Vitoria Salvador	2023-09-23 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218316585	f	\N	\N	\N
5925	Cimarrones de Sonora II	Real Apodaca FC	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218604616	f	\N	\N	\N
3309	Hottur	IR Reykjavik	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320158	f	\N	\N	\N
3308	Gillingham	Morecambe	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217950906	f	\N	\N	\N
3336	Anderlecht B	Patro Eisden Maasmechelen	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218230114	f	\N	\N	\N
3340	HJK Helsinki	FC Inter	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122464	f	\N	\N	\N
3300	Preston	Plymouth	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645901	f	\N	\N	\N
3331	Lincoln	Carlisle	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217888882	f	\N	\N	\N
3315	Kilmarnock	Hibernian	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217638037	f	\N	\N	\N
3307	West Ham	Man City	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634939	f	\N	\N	\N
3334	Tindastoll (W)	IBV (W)	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320574	f	\N	\N	\N
3351	Tottenham	Sheff Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217635503	f	\N	\N	\N
3361	Sheff Wed	Ipswich	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645793	f	\N	\N	\N
3298	Huddersfield	Rotherham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645577	f	\N	\N	\N
3373	Reading	Bolton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217888660	f	\N	\N	\N
3376	Wigan	Cambridge Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889102	f	\N	\N	\N
5909	Club General Caballero JLM	Resistencia SC	2023-09-22 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218616210	f	\N	\N	\N
5910	CD Hermanos Colmenarez	Caracas	2023-09-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599245	f	\N	\N	\N
5911	Jaguares de Cordoba	Alianza Petrolera	2023-09-22 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218515112	f	\N	\N	\N
3365	Ljungskile	BK Olympic	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138607	f	\N	\N	\N
3369	Thor	Grindavik	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319782	f	\N	\N	\N
3368	Fleetwood Town	Oxford Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217890068	f	\N	\N	\N
3372	Montrose	Edinburgh City	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217920098	f	\N	\N	\N
3360	Blackburn	Middlesbrough	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646442	f	\N	\N	\N
3363	Arbroath	Airdrieonians	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217864120	f	\N	\N	\N
3374	Shrewsbury	Bristol Rovers	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217890176	f	\N	\N	\N
3367	Ross Co	Livingston	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637929	f	\N	\N	\N
3364	Ahlafors IF	Ariana FC	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137445	f	\N	\N	\N
3375	Stevenage	Charlton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889432	f	\N	\N	\N
3366	Elgin City FC	Dumbarton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865305	f	\N	\N	\N
3391	Feyenoord	Heerenveen	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217639118	f	\N	\N	\N
3378	Valencia	Atletico Madrid	2023-09-16 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217673302	f	\N	\N	\N
3380	Huesca	Villarreal B	2023-09-16 15:16:00	https://www.orbitxch.com/customer/sport/1/market/1.218322539	f	\N	\N	\N
3382	Lamia	OFI	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217680327	f	\N	\N	\N
3394	Slavia Sofia	Lokomotiv Sofia	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217707246	f	\N	\N	\N
3387	Touring KE	SD Deusto	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218328371	f	\N	\N	\N
3385	BSK Bijelo Brdo	NK Dubrava Zagreb	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218254387	f	\N	\N	\N
3388	Rio Ave	Famalicao	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912989	f	\N	\N	\N
3383	Europa Point FC	Manchester 62 FC	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218334109	f	\N	\N	\N
3381	Ingolstadt	1860 Munich	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218117684	f	\N	\N	\N
3389	NK Solin	NK Sesvete	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218254207	f	\N	\N	\N
3406	Austria Klagenfurt	LASK Linz	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217674584	f	\N	\N	\N
3392	Lisen	FC Sellier & Bellot Vlasim	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217974991	f	\N	\N	\N
3390	H Slavia Kromeriz	Sigma Olomouc B	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217975081	f	\N	\N	\N
3384	Santa Clara	Penafiel	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218126231	f	\N	\N	\N
3393	Stade Tunisien	EGS Gafsa	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218333962	f	\N	\N	\N
3386	Elche B	FC Jove Espanol	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218328281	f	\N	\N	\N
3409	Al Salt	Al Ramtha	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320428	f	\N	\N	\N
3395	Dinamo Zagreb	Slaven Belupo	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217973056	f	\N	\N	\N
3397	MC Alger	ES Ben Aknoun	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328733	f	\N	\N	\N
3400	BFA Vilnius	Be1 NFA	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320338	f	\N	\N	\N
3399	Etoile Sportive Sahel	FAR Rabat	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329039	f	\N	\N	\N
3401	FK Banga Gargzdu	FK Dainava Alytus	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218230204	f	\N	\N	\N
3396	NC Magra	Kabylie	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328643	f	\N	\N	\N
3404	FK Aktobe	FC Ordabasy	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218179434	f	\N	\N	\N
3407	FC Blau Weiss Linz	SCR Altach	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217674465	f	\N	\N	\N
3405	Rennes	Lille	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217678244	f	\N	\N	\N
3410	Betis (W)	Villarreal (W)	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327699	f	\N	\N	\N
3398	Hoffenheim II	SV Steinbach	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274610	f	\N	\N	\N
3403	Al-Raed (KSA)	Al Nassr	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040278	f	\N	\N	\N
3412	Djurgardens	Varnamo	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217786342	f	\N	\N	\N
3402	FC Ajka	Mezokovesd-Zsory	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263735	f	\N	\N	\N
3408	Al-Hazm (KSA)	Al Taee	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040576	f	\N	\N	\N
3411	Mura	NK Bravo	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218001752	f	\N	\N	\N
3416	Barcelona B	Fuenlabrada	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218233736	f	\N	\N	\N
3415	Kaizer Chiefs	Bloemfontein Celtic	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218142029	f	\N	\N	\N
3414	Rakow Czestochowa	LKS Lodz	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217793293	f	\N	\N	\N
3418	Koper	NK Celje	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001387	f	\N	\N	\N
3362	Man Utd	Brighton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217635080	f	\N	\N	\N
3417	NK Radomlje	Domzale	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001477	f	\N	\N	\N
3379	Reggiana	US Cremonese	2023-09-16 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217959655	f	\N	\N	\N
3102	Sagamihara	FC Gifu	2023-09-16 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218101808	f	\N	\N	\N
3103	Blaublitz Akita	Nagasaki	2023-09-16 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015713	f	\N	\N	\N
3104	Incheon Utd	Jeju Utd	2023-09-16 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217880359	f	\N	\N	\N
3105	Jeonbuk Motors	Gangwon	2023-09-16 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217880569	f	\N	\N	\N
3106	Honda Lock	Sony Sendai FC	2023-09-16 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312696	f	\N	\N	\N
3107	Maruyasu Okazaki	MIO Biwako Shiga	2023-09-16 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312876	f	\N	\N	\N
3108	Ansan Greeners FC	Cheongju FC	2023-09-16 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217929112	f	\N	\N	\N
3109	Lee Man Warriors	Kitchee SC	2023-09-16 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218309632	f	\N	\N	\N
3110	Seoul E-Land FC	Cheonan City	2023-09-16 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217928834	f	\N	\N	\N
3111	Pohang Steelers	Suwon FC	2023-09-16 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218344201	f	\N	\N	\N
3112	Brisbane Roar	Western Sydney Wanderers	2023-09-16 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217952534	f	\N	\N	\N
3113	Pocheon FC	Busan Transportation Corp	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218256011	f	\N	\N	\N
3114	Arema Cronus	Persita Tangerang	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310543	f	\N	\N	\N
3115	Csikszereda	CS Mioveni	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945232	f	\N	\N	\N
3116	Gloria Buzau	FCM Alexandria	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945592	f	\N	\N	\N
3117	Hwaseong FC	Yangpyeong FC	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218242973	f	\N	\N	\N
3118	Persib Bandung	PS TIRA	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310453	f	\N	\N	\N
3119	Jiangxi Dark Horse Junior	Dalian Zhixing	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310272	f	\N	\N	\N
3120	Csm Slatina	CSC 1599 Selimbar	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217991481	f	\N	\N	\N
3121	Unirea Slobozia	FC Metaloglobus Bucuresti	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945322	f	\N	\N	\N
3122	Acs Dumbravita	CS Tunari	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945412	f	\N	\N	\N
3123	FC Hunedoara	CSM Scolar Resita	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945052	f	\N	\N	\N
3124	Haimen Codion	Quanzhou Yaxin	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310362	f	\N	\N	\N
3125	Progresul 1944 Spartac	ACS Viitorul Tg Jiu	2023-09-16 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945502	f	\N	\N	\N
3126	Vyskov	Prostejov	2023-09-16 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217974901	f	\N	\N	\N
3127	Taian Tiankuang	Hainan Star	2023-09-16 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218311638	f	\N	\N	\N
3128	Slovan Bratislava II	KFC Komarno	2023-09-16 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218228738	f	\N	\N	\N
3129	Prey Veng	National Defense Ministry	2023-09-16 09:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218335305	f	\N	\N	\N
3130	Sendai	Mito	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218058034	f	\N	\N	\N
3131	Viktoria Koln U19	Fortuna Dusseldorf U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311548	f	\N	\N	\N
3132	Istanbul Basaksehir FK U19	Antalyaspor U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312302	f	\N	\N	\N
3133	Omiya	Kumamoto	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218057943	f	\N	\N	\N
3134	Tensung FC	RTC FC	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218332224	f	\N	\N	\N
3135	Kitakyushu	Azul Claro Numazu	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218114072	f	\N	\N	\N
3136	Yamagata	Okayama	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218057853	f	\N	\N	\N
3137	Kashima	C-Osaka	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879265	f	\N	\N	\N
3138	Arminia Bielefeld U19	Dortmund U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329337	f	\N	\N	\N
3139	Leverkusen U19	FC Koln U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311368	f	\N	\N	\N
3140	Eyupspor U19	Sivasspor U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312392	f	\N	\N	\N
3141	Konyaspor U19	Istanbulspor AS U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312212	f	\N	\N	\N
3142	RB Leipzig U19	Hamburger SV U19	2023-09-16 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311458	f	\N	\N	\N
3143	Henan Songshan Longmen	Shanghai Shenhua	2023-09-16 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218110693	f	\N	\N	\N
3144	Busan IPark	Seongnam FC	2023-09-16 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217928927	f	\N	\N	\N
3145	FC Schalke U19	SC Paderborn 07 U19	2023-09-16 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218330244	f	\N	\N	\N
3146	Iwata	Renofa Yamaguchi	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015803	f	\N	\N	\N
3147	CD Berceo	CA Rivers Ebro	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328100	f	\N	\N	\N
3148	Tochigi SC	Jef Utd Chiba	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015983	f	\N	\N	\N
3149	Vanraure Hachinohe	Nara Club	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218114252	f	\N	\N	\N
3150	CD Atletico Melilla	Polideportivo Ejido	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328010	f	\N	\N	\N
3151	Oita	Tokushima	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015622	f	\N	\N	\N
3152	FC Imabari	Nagano Parceiro	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218115362	f	\N	\N	\N
3153	SD Eibar (W)	Levante Las Planas (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327391	f	\N	\N	\N
3154	Fukuoka	Nagoya	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879355	f	\N	\N	\N
3155	Hiroshima	Kobe	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217878995	f	\N	\N	\N
3156	FC Tatran Prešov (W)	FC Petrzalka (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329607	f	\N	\N	\N
3157	MFK Ruzomberok (W)	Spartak Myjava (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329517	f	\N	\N	\N
3158	Stomilanki Olsztyn (W)	Gornik Leczna (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334622	f	\N	\N	\N
3159	Atletico Madrid (W)	Athletic Bilbao (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218110330	f	\N	\N	\N
3161	Sapporo	Shonan	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879085	f	\N	\N	\N
3162	1. FSV Mainz 05 U19	SV Sandhausen U19	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314595	f	\N	\N	\N
3163	AVS Futebol SAD	Vilaverdense	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218118062	f	\N	\N	\N
3164	Ulsan Hyundai Horang-i	Daejeon Citizen	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218344309	f	\N	\N	\N
3165	Garliava Kaunas	TransINVEST Vilnius	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316114	f	\N	\N	\N
3166	Slask Wroclaw (W)	Pogon Tczew (W)	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316945	f	\N	\N	\N
3167	Benfica U23	Farense U23	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316204	f	\N	\N	\N
3168	Tottori	Fukushima Utd	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218114162	f	\N	\N	\N
3169	Sporting Braga U23	SC Uniao Torreense U23	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218338223	f	\N	\N	\N
3170	Porto B	Maritimo	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218142119	f	\N	\N	\N
3171	Czarni Sosnowiec (W)	Pogon Szczecin (W)	2023-09-16 11:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218316855	f	\N	\N	\N
3172	Hansa Rostock	Fortuna Dusseldorf	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217689179	f	\N	\N	\N
3173	IF Karlstad	Umea FC	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137805	f	\N	\N	\N
3174	Wuppertaler SV U19	SC Verl U19	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329427	f	\N	\N	\N
3175	Mikkeli	SJK 2	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218289962	f	\N	\N	\N
3176	FC Stockholm Internazionale	Hammarby TFF	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137535	f	\N	\N	\N
3177	Sollentuna FF	IF Sylvia	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137895	f	\N	\N	\N
3178	BG Pathumthani United	Muangthong Utd	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218180336	f	\N	\N	\N
3179	AFC Eskilstuna	Orgryte	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217874964	f	\N	\N	\N
3180	Elversberg	Hamburger SV	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217688981	f	\N	\N	\N
3181	Ayutthaya United	Kasetsart FC	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316492	f	\N	\N	\N
3182	FK Jelgava	BFC Daugavpils	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263371	f	\N	\N	\N
3183	Rot-Weiss Erfurt	Meuselwitz	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274070	f	\N	\N	\N
3184	Karlsruhe	Kaiserslautern	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217730844	f	\N	\N	\N
3185	Hannover II	Norderstedt	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273890	f	\N	\N	\N
3186	Nanjing Fengfan	Hebei KungFu	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314502	f	\N	\N	\N
3187	AZS UJ Krakow (W)	UKS SMS Lodz (W)	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316765	f	\N	\N	\N
3188	Hertha Berlin II	Carl Zeiss Jena	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274160	f	\N	\N	\N
3189	Svay Rieng FC	Angkor Tiger FC	2023-09-16 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314232	f	\N	\N	\N
3190	St Johnstone	Rangers	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217637578	f	\N	\N	\N
3191	Guangzhou FC	Dongguan Guanlian	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218314322	f	\N	\N	\N
3193	Yunnan Yukun	Qingdao Red Lions	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218314412	f	\N	\N	\N
3194	Phrae United	Rayong FC	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218316402	f	\N	\N	\N
3195	Meizhou Hakka	Shenzhen FC	2023-09-16 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218115452	f	\N	\N	\N
3196	SC Telstar (W)	Twente (W)	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218351349	f	\N	\N	\N
3197	SV Sandhausen	Preussen Munster	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122735	f	\N	\N	\N
3198	Lubeck	Dynamo Dresden	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218117594	f	\N	\N	\N
3199	Arminia Bielefeld	Freiburg II	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122825	f	\N	\N	\N
3200	Dortmund II	Viktoria Koln	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218117774	f	\N	\N	\N
3201	Ratchaburi	Police Tero	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218155337	f	\N	\N	\N
3202	Sundsvall (W)	Mallbackens IF (W)	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334297	f	\N	\N	\N
3203	Rot-Weiss Essen	Jahn Regensburg	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218117864	f	\N	\N	\N
3204	FC Koln II	Schalke 04 II	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218291133	f	\N	\N	\N
3205	Athletic Bilbao	Cadiz	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217662409	f	\N	\N	\N
3206	VfL Osnabruck U19	Wolfsburg U19	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218331448	f	\N	\N	\N
3207	AFC Leopards SC (Kenya)	Muhoroni Youth FC	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032992	f	\N	\N	\N
3208	Shabana	Kenya Police FC	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033180	f	\N	\N	\N
3209	Persis Solo	Psis Semarang	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315754	f	\N	\N	\N
3210	MFD Zalgiris Vilnius (Res)	FC Neptunas Klaipeda	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316024	f	\N	\N	\N
3211	Cosenza	Sudtirol	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217943595	f	\N	\N	\N
3212	Lecco	Brescia	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960696	f	\N	\N	\N
3213	Pisa	SSD Bari	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217946822	f	\N	\N	\N
3214	Ankaraspor	Bucaspor	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218333593	f	\N	\N	\N
3215	FK Panevezio Ekranas	FK Nevezis	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315844	f	\N	\N	\N
3216	Alemannia Aachen	SV Rodinghausen	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275127	f	\N	\N	\N
3006	ASO Chlef	MC Oran	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272136	f	\N	\N	\N
3217	Customs United	Samut Prakan	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218316312	f	\N	\N	\N
3218	Bandari FC (Kenya)	Ulinzi Stars	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033086	f	\N	\N	\N
3219	Kakamega Homeboyz	Tusker FC	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033452	f	\N	\N	\N
3220	FK Siauliai II	FK Riteriai II	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315934	f	\N	\N	\N
3221	Kapaz Ganja	Sabail	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262936	f	\N	\N	\N
3223	Abha	Al-Ettifaq	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040684	f	\N	\N	\N
3224	Stuttgart II	Homburg	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274520	f	\N	\N	\N
3225	VfB Oldenburg	Teutonia 05 Ottensen	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273800	f	\N	\N	\N
3226	Ascoli	Palermo	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944155	f	\N	\N	\N
3227	FK Atyrau	FK Kyzyl-Zhar	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190016	f	\N	\N	\N
3228	Feralpisalo	Modena	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217959475	f	\N	\N	\N
3229	FK Suduva	Panevezys	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218230024	f	\N	\N	\N
3230	SalPA	JJK	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218118152	f	\N	\N	\N
3231	Grorud IL	Lyn	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276707	f	\N	\N	\N
3232	Montpellier (W)	Dijon (W)	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319422	f	\N	\N	\N
3233	Floy Flekkeroy	Egersund	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276441	f	\N	\N	\N
3234	Chiangrai Utd	Khonkaen United	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218180426	f	\N	\N	\N
3235	Rigas Futbola Skola	FK Riga	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263191	f	\N	\N	\N
3236	Lille (W)	Paris FC (W)	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218321765	f	\N	\N	\N
3237	Mlada Boleslav	Hradec Kralove	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727920	f	\N	\N	\N
3238	Ostersunds FK	Gefle	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960110	f	\N	\N	\N
3239	Polonia Warszawa	Znicz Pruszkow	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798135	f	\N	\N	\N
3240	MFK Karvina	Teplice	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217740020	f	\N	\N	\N
3241	NK Jarun	NK Croatia Zmijavci	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218254027	f	\N	\N	\N
3242	Sigma Olomouc	Ceske Budejovice	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727560	f	\N	\N	\N
3243	FC Astana	Tobol Kostanay	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218179344	f	\N	\N	\N
3244	Keciorengucu	Sanliurfaspor	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218077783	f	\N	\N	\N
3245	IFK Goteborg	Brommapojkarna	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217786666	f	\N	\N	\N
3246	JaPS	KaPa	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122915	f	\N	\N	\N
3247	Egri FC	DEBRECENI VSC	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263553	f	\N	\N	\N
3248	Golden Arrows	Stellenbosch FC	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218141939	f	\N	\N	\N
3249	Juventus	Lazio	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672548	f	\N	\N	\N
3250	Caen	St Etienne	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218008133	f	\N	\N	\N
3251	Sirius	Varbergs BoIS	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217786558	f	\N	\N	\N
3252	Bohemians 1905	Banik Ostrava	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217730677	f	\N	\N	\N
3253	CD Nacional Funchal	Feirense	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218123490	f	\N	\N	\N
2831	Rionegro	Union Magdalena	2023-09-14 23:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2832	Coritiba	Bahia	2023-09-15 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2833	Deportivo Cali	Atletico Huila	2023-09-15 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2834	Ferroviaria (W)	Palmeiras (W)	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2835	Guayaquil SC	Manta FC	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2836	EC Realidade Jovem (W)	Sao Paulo (W)	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2837	EC Sao Jose (W)	EC Taubate (W)	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2838	Santos FC (W)	Pinda SC (W)	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2839	CA Independiente	Huracan	2023-09-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2840	Bragantino SP	Gremio	2023-09-15 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2841	Village Superstars	Conaree United	2023-09-15 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2842	Universidad Guadalajara	Dorados	2023-09-15 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2843	CD Victoria	Vida	2023-09-15 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2844	Alianza Petrolera	Junior FC Barranquilla	2023-09-15 02:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2845	FC Juarez (W)	Puebla FC (W)	2023-09-15 04:06:00	https://www.orbitxch.com/customer/sport/1/market/1.218219999	f	\N	\N	\N
2846	PSM Makassar	PS Barito Putera	2023-09-15 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276171	f	\N	\N	\N
2847	FC Spartak Trnava U19	Dukla Banska Bystrica U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294690	f	\N	\N	\N
2848	Slovan Bratislava U19	FK AS Trencin U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294780	f	\N	\N	\N
2849	Ispe FC	Rakhine Utd	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276261	f	\N	\N	\N
2850	FK Aksu Pavlodar	Okzhetpes	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218179614	f	\N	\N	\N
2909	FK Auda	FS METTA/LU	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218255923	f	\N	\N	\N
3254	IK Brage	Trelleborgs	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960020	f	\N	\N	\N
2851	Sport Academy Kairat	FC Astana U21	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218318403	f	\N	\N	\N
2852	FC Kosice U19	Dunajska Streda U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294510	f	\N	\N	\N
2853	FC Vion Zlate Moravce U19	Z Michalovce U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294403	f	\N	\N	\N
2854	Ruzomberok U19	MSK Zilina U19	2023-09-15 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294600	f	\N	\N	\N
2855	Ayeyawady United	Yadanarbon	2023-09-15 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218276351	f	\N	\N	\N
2856	Changwon City	Gimhae City	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218243063	f	\N	\N	\N
2857	Daejeon Korail FC	Paju Citizen	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218243243	f	\N	\N	\N
2858	Yokohama FM	Tosu	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879716	f	\N	\N	\N
2859	Kofu	Tokyo-V	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015532	f	\N	\N	\N
2860	Kawasaki	FC Tokyo	2023-09-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879536	f	\N	\N	\N
2861	Urawa	Kyoto	2023-09-15 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217879175	f	\N	\N	\N
2862	FK Kaspyi Aktau	FK Maqtaaral Jetisay	2023-09-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218189926	f	\N	\N	\N
2863	KMC	JKT Tanzania	2023-09-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299139	f	\N	\N	\N
2864	Shandong Taishan	Qingdao Jonoon	2023-09-15 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218065287	f	\N	\N	\N
2865	Shanghai Port FC	Changchun Yatai	2023-09-15 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218065503	f	\N	\N	\N
2866	Beijing Guoan	Zhejiang Greentown	2023-09-15 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218065395	f	\N	\N	\N
2927	CD Tropezon	UD Samano	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296206	f	\N	\N	\N
2867	Wuhan Three Towns	Cangzhou Mighty Lions	2023-09-15 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218065611	f	\N	\N	\N
2868	Balestier Khalsa	Tampines Rovers	2023-09-15 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218276977	f	\N	\N	\N
2869	Tanjong Pagar United	Brunei DPMM FC	2023-09-15 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217991390	f	\N	\N	\N
2870	Bali Utd Pusam	RANS Nusantara FC	2023-09-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275991	f	\N	\N	\N
2871	Dewa United FC	Bhayangkara FC	2023-09-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276081	f	\N	\N	\N
2872	Buriram Utd	Trat	2023-09-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218103929	f	\N	\N	\N
2873	Sabah FA	Perak	2023-09-15 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218288405	f	\N	\N	\N
2874	Bangkok Utd	Sukhothai	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218103839	f	\N	\N	\N
2875	Bright Stars	Bul FC	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295735	f	\N	\N	\N
2876	Zira	FK Sumqayit	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218255742	f	\N	\N	\N
2877	Bumamuru	Mamelodi Sundowns	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218300206	f	\N	\N	\N
2878	Club El Porvenir (W)	Social Atletico Television	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218289401	f	\N	\N	\N
2879	Birmingham U21	Wigan Athletic U21	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279415	f	\N	\N	\N
2880	Maritzburg Utd	Casric FC	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299659	f	\N	\N	\N
2881	SC Villa	Airtel Kitara FC	2023-09-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295645	f	\N	\N	\N
2882	Platense (W)	Club Ferro Carril Oeste (W)	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310814	f	\N	\N	\N
2883	Unia Skierniewice	Olimpia Zambrow	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295917	f	\N	\N	\N
2884	Zrinski Jurjevac	HNK Orijent 1919	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218254297	f	\N	\N	\N
2885	CS Dinamo Bucuresti	CSO Plopeni	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294127	f	\N	\N	\N
2886	CS Uni Craiova II	CSM Deva	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218293946	f	\N	\N	\N
2887	Gorica	NK Slovenska Bistrica	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218267906	f	\N	\N	\N
2888	Muscelul Camp	Cetate Rasnov	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294308	f	\N	\N	\N
2889	Sloga Doboj	Tuzla City	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279325	f	\N	\N	\N
2890	ACS Vedita Colonesti MS	CS Viitorul Daesti	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294037	f	\N	\N	\N
2891	Slavoj Trebisov	MFk Dolny Kubin	2023-09-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228378	f	\N	\N	\N
2892	Vukovar	NK Dugopolje	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218254117	f	\N	\N	\N
2893	Minija Kretinga	FK Kauno Zalgiris 2	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218280993	f	\N	\N	\N
2894	Arda	Botev Vratsa	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217707063	f	\N	\N	\N
2895	Beltinci	Nafta Lendava	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218267996	f	\N	\N	\N
2896	Siarka Tarnobrzeg	GP TS Avia Swidnik	2023-09-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218296007	f	\N	\N	\N
2897	FK Babrungas	Marijampole City	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218280903	f	\N	\N	\N
2898	Greuther Furth II	Nurnberg II	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218290913	f	\N	\N	\N
2899	Al-Jalil	Sahab SC	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279595	f	\N	\N	\N
2900	USM Khenchela	ES Setif	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272046	f	\N	\N	\N
2901	MC El Bayadh	CS Constantine	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272226	f	\N	\N	\N
2902	TSG Hoffenheim U19	Bayern Munich U19	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273529	f	\N	\N	\N
2903	Notec Czarnków	Unia Solec Kujawski	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296097	f	\N	\N	\N
2904	Atlantis	GrIFK	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218280757	f	\N	\N	\N
2905	Al-Feiha	Al-Shabab (KSA)	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040900	f	\N	\N	\N
2906	Vysocina Jihlava	FC Zbrojovka Brno	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217974631	f	\N	\N	\N
2907	Haka	Ilves	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218075577	f	\N	\N	\N
2908	Arsenal Ceska Lipa	Usti Nad Labem	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218280667	f	\N	\N	\N
2911	Metalist 1925	Zorya	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217921528	f	\N	\N	\N
2912	UTA Arad	Universitatea Cluj	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217713634	f	\N	\N	\N
2913	Podbrezova	MFK Skalica	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217761827	f	\N	\N	\N
2914	SV Fortuna Regensburg	Ingolstadt II	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218290056	f	\N	\N	\N
2915	SFC Opava	Dukla Prague	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217974721	f	\N	\N	\N
2916	TWL Elektra	SV Leobendorf	2023-09-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218289707	f	\N	\N	\N
2917	Puszcza Niepolomice	Slask Wroclaw	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217793394	f	\N	\N	\N
2918	Correcaminos (Premier)	Tritones Vallarta MFC	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218281928	f	\N	\N	\N
2919	Triglav	Ilirija Extra-Lux	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268086	f	\N	\N	\N
2920	Rosengard (W)	Brommapojkarna (W)	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218277249	f	\N	\N	\N
2921	Ilves Kissat	FC Jazz	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218281478	f	\N	\N	\N
2922	Stal Rzeszow	Wisla Plock	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798694	f	\N	\N	\N
2923	Lokomotiva	Rudes	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217978984	f	\N	\N	\N
2924	Pohronie	MSK Zilina II	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228288	f	\N	\N	\N
2925	Pribram	Sparta Prague B	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217974811	f	\N	\N	\N
2926	FC Kiffen	PK-35 RY	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218281568	f	\N	\N	\N
2928	St Polten	FIRST VIENNA FC 1894	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217936142	f	\N	\N	\N
2929	Floridsdorfer Ac	Admira Wacker	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217935961	f	\N	\N	\N
2930	FC Dornbirn	SKU Amstetten	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217936775	f	\N	\N	\N
2931	FC Liefering	SV Stripfing/Weiden	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217936866	f	\N	\N	\N
2932	SV Lafnitz	SV Horn	2023-09-15 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217936052	f	\N	\N	\N
2933	FC Bastia-Borgo	Stade Briochin	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218273120	f	\N	\N	\N
2934	Nurnberg	Greuther Furth	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217876626	f	\N	\N	\N
2935	Hannover 96 (U19)	SV Werder Bremen U19	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218277564	f	\N	\N	\N
2936	Paderborn	Wehen Wiesbaden	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217688693	f	\N	\N	\N
2937	Zeljeznicar	Gosk Gabela	2023-09-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218282153	f	\N	\N	\N
2938	Le Puy	Jura Sud	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273226	f	\N	\N	\N
2939	Ranheim IL	Raufoss	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885444	f	\N	\N	\N
2940	Lunds BK	Angelholms	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218101361	f	\N	\N	\N
2941	Cherno More	Beroe Stara Za	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217706702	f	\N	\N	\N
2942	Eimsbutteler	Weiche Flensburg	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273710	f	\N	\N	\N
2943	Viborg	Midtjylland	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217903844	f	\N	\N	\N
2944	Hobro	AC Horsens	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961654	f	\N	\N	\N
2946	FC Nottingen	Atsv Mutschelbach	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218290150	f	\N	\N	\N
2948	SC Weiz	Union Gurten	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272316	f	\N	\N	\N
2949	SK Vorwarts Steyr	ASK Klagenfurt	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272406	f	\N	\N	\N
2950	Viktoria Aschaffenburg	Schalding-Heining	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273620	f	\N	\N	\N
2951	Eint Frankfurt II	SV Stuttgarter Kickers	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274880	f	\N	\N	\N
2952	Spartak Myjava	Tatran Presov	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228197	f	\N	\N	\N
2953	HB Torshavn	Klaksvikar Itrottarfelag	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279505	f	\N	\N	\N
2954	Chemnitzer	Lokomotiv Leipzig	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274340	f	\N	\N	\N
2955	IFK Hassleholm	Nosaby IF	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218264005	f	\N	\N	\N
2956	TUS Bad Gleichenberg	Union Volksbank Vocklamarkt	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272496	f	\N	\N	\N
2957	Duisburg	Verl	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218080321	f	\N	\N	\N
2958	Skra Czestochowa	Radunia Stezyca	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251872	f	\N	\N	\N
2959	Sao Paulo U20	Mirassol U20	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307647	f	\N	\N	\N
2960	SAK Klagenfurt	SV Donau Klagenfurt	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276887	f	\N	\N	\N
2961	SC Eltersdorf	Jahn Regensburg II	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218290294	f	\N	\N	\N
2962	SV Lippstadt	Rot-Weiss Ahlen	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275413	f	\N	\N	\N
2963	Skive	Middelfart	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218288673	f	\N	\N	\N
2964	BFC Dynamo	Babelsberg	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274250	f	\N	\N	\N
2965	FSV 63 Luckenwalde	Greifswalder SV 04	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273980	f	\N	\N	\N
2966	Rouen	GO Lyon	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218200793	f	\N	\N	\N
2967	Moroka Swallows	Richards Bay FC	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218141849	f	\N	\N	\N
2947	Hillerod Fodbold	B93 Copenhagen	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961384	f	\N	\N	\N
2969	Niort	Epinal	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093476	f	\N	\N	\N
2970	Martigues	Sochaux	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218200704	f	\N	\N	\N
2971	Lommel SK U21	Sint Truidense (Res)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218288281	f	\N	\N	\N
2972	Favoritner AC	Austria Wien (A)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218274970	f	\N	\N	\N
2973	FC Zwolle (W)	FC Utrecht (W)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218272996	f	\N	\N	\N
2974	FC Wegberg-Beeck	Mgladbach II	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218275316	f	\N	\N	\N
2975	Excelsior (W)	Ajax (W)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218298316	f	\N	\N	\N
2976	Heerenveen (W)	AZ Alkmaar Women	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218272906	f	\N	\N	\N
2977	SC Victoria Hamburg	FC Turkiye	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218290726	f	\N	\N	\N
2978	ADO Den Haag (W)	PSV Eindhoven (W)	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218272816	f	\N	\N	\N
2979	Cholet SO	Marignane-Gignac	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093566	f	\N	\N	\N
2980	Wiener SK	Wiener Victoria	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218298117	f	\N	\N	\N
2981	FC Wil	Stade Lausanne-Ouchy	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218264095	f	\N	\N	\N
2982	Le Mans	Red Star	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093296	f	\N	\N	\N
2983	Avranches	Orleans	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093386	f	\N	\N	\N
2984	Chateauroux	Versailles 78 FC	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218141759	f	\N	\N	\N
2985	Villefranche Beaujolais	Nimes	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218093206	f	\N	\N	\N
2986	Neuchatel Xamax	Young Boys	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218264185	f	\N	\N	\N
2987	Bourgoin Jallieu	Toulouse B	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218273335	f	\N	\N	\N
2988	America MG U20	Coimbra EC U20	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218310182	f	\N	\N	\N
2989	Helmond Sport	FC Oss	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218080681	f	\N	\N	\N
2990	Jong AZ Alkmaar	FC Eindhoven	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218080591	f	\N	\N	\N
2991	Brentford U21	Fulham U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292909	f	\N	\N	\N
2992	Olimpia Elblag	Wisla Pulawy	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218240588	f	\N	\N	\N
2993	Jong Ajax Amsterdam	Emmen	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218082967	f	\N	\N	\N
2995	Leicester U21	Burnley U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292638	f	\N	\N	\N
2996	Al-Khaleej Saihat	Al-Fateh (KSA)	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040792	f	\N	\N	\N
2998	VVV Venlo	NAC Breda	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218083237	f	\N	\N	\N
3000	Royal Charleroi SC (W)	Femina WS (W)	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218279235	f	\N	\N	\N
3001	Kari	IF Magni	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307803	f	\N	\N	\N
3002	CA Huracan (W)	San Lorenzo Al (W)	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218288110	f	\N	\N	\N
3003	Atletico Grau	UTC Cajamarca	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218191763	f	\N	\N	\N
3004	Brighton U21	Aston Villa U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218293089	f	\N	\N	\N
3005	Leeds United U21	Colchester United U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292999	f	\N	\N	\N
3007	Fleetwood Town U21	Nottingham Forest U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292819	f	\N	\N	\N
3008	Al-Hilal	Al Riyadh SC	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040158	f	\N	\N	\N
3009	Den Bosch	MVV Maastricht	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218082787	f	\N	\N	\N
3012	Soroksar	Kecskemeti	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218255833	f	\N	\N	\N
3013	Middlesbrough U21	Crystal Palace U21	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218292728	f	\N	\N	\N
3014	FC Liege	Club Brugge B	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229177	f	\N	\N	\N
3015	Racing (W)	CA Independiente (W)	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218287933	f	\N	\N	\N
3016	River Plate (W)	Boca Juniors (W)	2023-09-15 19:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218288023	f	\N	\N	\N
3017	Deportivo Riestra	CA Atlanta	2023-09-15 19:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218210444	f	\N	\N	\N
3018	Club Football Estrela	Porto	2023-09-15 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217913097	f	\N	\N	\N
3019	Ammanford AFC	Taffs Well	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218295553	f	\N	\N	\N
3020	Venezia	Spezia	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959385	f	\N	\N	\N
3021	Newport City	Abergavenny Town	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218295373	f	\N	\N	\N
3022	Gornik Zabrze	Ruch Chorzow	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217793563	f	\N	\N	\N
3024	DSV Leoben	Grazer AK	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217937029	f	\N	\N	\N
3025	Dinamo Bucharest	FC U Craiova 1948	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217713184	f	\N	\N	\N
3026	GKS Katowice	Zaglebie Sosnowiec	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217868286	f	\N	\N	\N
3027	CD Cambaceres	Club El Porvenir (BA)	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218310724	f	\N	\N	\N
2997	Roda JC	SC Telstar	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218082877	f	\N	\N	\N
2999	Racing Genk B	Zulte-Waregem	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229465	f	\N	\N	\N
3010	FC Dordrecht	Jong FC Utrecht	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218083057	f	\N	\N	\N
3011	FC Groningen	ADO Den Haag	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218083147	f	\N	\N	\N
3028	Genk (W)	Oud-Heverlee Leuven (W)	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218279145	f	\N	\N	\N
3029	Bayern Munich	Leverkusen	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217627908	f	\N	\N	\N
3023	Braga B	Sanjoanense	2023-09-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218240710	f	\N	\N	\N
3031	Holyhead Hotspur	Bangor 1876	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218295463	f	\N	\N	\N
3032	Rimini	Juventus B	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218236244	f	\N	\N	\N
3033	Galway Utd	Dundalk	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218198013	f	\N	\N	\N
3034	Athlone Town	Kerry FC	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218083883	f	\N	\N	\N
3035	Hull	Coventry	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217646334	f	\N	\N	\N
3036	Salford City	Notts Co	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217951356	f	\N	\N	\N
3037	Derry City	Shamrock Rovers	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217934382	f	\N	\N	\N
3038	Atalanta B	Giana Erminio	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218239562	f	\N	\N	\N
3039	Waterford	Cobh Ramblers	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218083973	f	\N	\N	\N
3040	Spal	Perugia	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218236138	f	\N	\N	\N
3041	Drogheda	Bohemians	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218198103	f	\N	\N	\N
3042	Bray Wanderers	Treaty United	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218082037	f	\N	\N	\N
3043	Ancona	ASD Pineto Calcio	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235934	f	\N	\N	\N
3044	Ayr	Partick	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217864014	f	\N	\N	\N
3045	Pontedera	Cesena	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235624	f	\N	\N	\N
3046	Cork City	Wexford F.C	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218197923	f	\N	\N	\N
3047	Colwyn Bay	Aberystwyth	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218256817	f	\N	\N	\N
3048	Westerlo	Antwerp	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217902393	f	\N	\N	\N
3049	Larne	Linfield	2023-09-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218082127	f	\N	\N	\N
3050	Southampton	Leicester	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646550	f	\N	\N	\N
3051	Valencia (W)	Real Madrid FC (W)	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296656	f	\N	\N	\N
3052	Paris St-G	Nice	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217677469	f	\N	\N	\N
3053	Rayo Vallecano	Alaves	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217662542	f	\N	\N	\N
3054	Finn Harps	St Patricks	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218198193	f	\N	\N	\N
3055	Le Havre AC (W)	Lyon (W)	2023-09-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218288763	f	\N	\N	\N
3056	Pacos Ferreira	Leixoes	2023-09-15 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218101898	f	\N	\N	\N
3057	CD Buzanada	CD Santa Ursula	2023-09-15 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218296296	f	\N	\N	\N
3058	Zaragoza	Racing Santander	2023-09-15 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217991879	f	\N	\N	\N
3059	Tigre	Estudiantes	2023-09-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217822541	f	\N	\N	\N
3060	Carlos Mannucci	AD Cantolao	2023-09-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190377	f	\N	\N	\N
3061	UD Tamaraceite	CF Panaderia Pulido	2023-09-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296386	f	\N	\N	\N
3062	Melgar	Alianza Atletico	2023-09-15 21:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218190558	f	\N	\N	\N
3063	Real Soacha Cundinamarca FC	Boyaca Patriotas	2023-09-15 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218270720	f	\N	\N	\N
3064	Atletico FC Cali	Quindio	2023-09-15 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218202859	f	\N	\N	\N
3065	Platense Zacatecoluca	CD Aguila	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218277474	f	\N	\N	\N
3066	Angostura FC	Monagas	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307107	f	\N	\N	\N
3067	Guairena	Club Sportivo Trinidense	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218305636	f	\N	\N	\N
3068	Fortaleza FC	Cortulua	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204977	f	\N	\N	\N
3069	Limon Black Star	AD Aserri	2023-09-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299049	f	\N	\N	\N
3070	Defensa y Justicia	Boca Juniors	2023-09-15 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217819453	f	\N	\N	\N
3071	Vila Nova	Ponte Preta	2023-09-15 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217980361	f	\N	\N	\N
3072	Llaneros FC	Barranquilla	2023-09-15 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3073	St. Pauls United	Cayon FC	2023-09-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3074	Club Necaxa (W)	Santos Laguna (W)	2023-09-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3075	CD Poza Rica	Deportivo Gladiadores	2023-09-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3076	Cuiaba	America MG	2023-09-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3077	Queretaro (W)	Tigres (W)	2023-09-16 00:06:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3078	Once Caldas	Envigado	2023-09-16 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3079	Nacional (Par)	Sportivo Luqueno	2023-09-16 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3080	Deportivo La Guaira	CD Hermanos Colmenarez	2023-09-16 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3081	Banfield	Argentinos Juniors	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3082	Alianza FC (SLV)	CD Municipal Limeno	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3083	Orense Sporting Club	Univ Catolica (Ecu)	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3084	Binacional	Cienciano	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3085	Colon	Rosario Central	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3086	Deportivo Saprissa	Municipal Grecia	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3090	ABC RN	Sport Recife	2023-09-16 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3091	Mazatlan FC	Cruz Azul	2023-09-16 01:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3092	Petroleros de Salamanca	Yalmakan FC	2023-09-16 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3093	San Francisco FC	Tauro FC	2023-09-16 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3094	Atletico Saltillo	Tuzos de la UAZ	2023-09-16 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3095	Millonarios	Atletico Bucaramanga	2023-09-16 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3096	Futbol Consultants Moravia	Uruguay de Coronado	2023-09-16 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3097	AD Municipal Liberia	AD Guanacasteca	2023-09-16 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3098	Chihuahua FC	Mineros de Fresnillo FC	2023-09-16 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3099	Monterrey (W)	Pachuca (W)	2023-09-16 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3100	Tijuana	Toluca	2023-09-16 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3101	Suzuka Unlimited	Criacao Shinjuku	2023-09-16 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f	\N	\N	\N
3255	Fram Larvik	Kjelsas	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276797	f	\N	\N	\N
3256	Pogon Szczecin	Korona Kielce	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217794730	f	\N	\N	\N
3257	Stade Reims (W)	Saint-Etienne (W)	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319512	f	\N	\N	\N
3258	Sandnes Ulf	KFUM Oslo	2023-09-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885254	f	\N	\N	\N
3259	Sturm Graz (W)	USC Landhaus (W)	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218314102	f	\N	\N	\N
3260	CD Victoria	Lagun Onak	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218328191	f	\N	\N	\N
3261	Newtown	Barry Town Utd	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269564	f	\N	\N	\N
3262	Connahs Quay	Cardiff Metropolitan	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269204	f	\N	\N	\N
3264	FC Koln	Hoffenheim	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217641651	f	\N	\N	\N
3266	Penybont FC	Caernarfon Town	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269384	f	\N	\N	\N
3268	Freiburg	Dortmund	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217628780	f	\N	\N	\N
3269	Pontypridd Town	Bala Town	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269474	f	\N	\N	\N
3270	The New Saints	Haverfordwest County	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218269294	f	\N	\N	\N
3286	Forfar	Spartans	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865109	f	\N	\N	\N
3291	Bromley	Oldham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120991	f	\N	\N	\N
3299	Peterhead	Bonnyrigg	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865215	f	\N	\N	\N
3281	East Fife	Clyde	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865395	f	\N	\N	\N
3272	Norwich	Stoke	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646226	f	\N	\N	\N
3283	Newport County	Barrow	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951086	f	\N	\N	\N
3285	Accrington	Sutton Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960606	f	\N	\N	\N
3277	Tolmin	Rudar	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218269966	f	\N	\N	\N
3292	FC Halifax Town	Dorking Wanderers	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218121351	f	\N	\N	\N
3297	Queens Park	Dunfermline	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217864210	f	\N	\N	\N
3290	Aston Villa	Crystal Palace	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634516	f	\N	\N	\N
3296	Dundee Utd	Morton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217864390	f	\N	\N	\N
3278	Derby	Portsmouth	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889654	f	\N	\N	\N
3288	IA Akranes	Grotta	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319602	f	\N	\N	\N
3295	Maidenhead	Boreham Wood	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218121081	f	\N	\N	\N
3284	QPR	Sunderland	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217646117	f	\N	\N	\N
3275	NK Primorje	Dravinja Kostroj	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270238	f	\N	\N	\N
3271	Bohemians (W)	Sligo Rovers (W)	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303861	f	\N	\N	\N
3294	Ballymena	Loughgall	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218181306	f	\N	\N	\N
3276	Konyaspor	Rizespor	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218114023	f	\N	\N	\N
3273	Taby FK	Sandvikens	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137625	f	\N	\N	\N
3274	Stenhousemuir	Stranraer	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217865019	f	\N	\N	\N
3279	AC Oulu	IFK Mariehamn	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122554	f	\N	\N	\N
3289	Glentoran	Dungannon	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218123113	f	\N	\N	\N
3282	Raith	Inverness CT	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217864300	f	\N	\N	\N
3287	Motherwell	St Mirren	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637821	f	\N	\N	\N
3280	Wealdstone	Altrincham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120901	f	\N	\N	\N
3263	Wolfsburg	Union Berlin	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217641951	f	\N	\N	\N
3438	Umraniyespor	Corum Belediyespor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218077913	f	\N	\N	\N
3443	Cukaricki	Crvena Zvezda	2023-09-16 17:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218220574	f	\N	\N	\N
3423	Arandina CF	UD Ourense	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250603	f	\N	\N	\N
3439	AD Llerenense	Numancia	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252513	f	\N	\N	\N
3431	Ruzomberok	FC Kosice	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217761933	f	\N	\N	\N
3424	Real Aviles	RS Gimnastica	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251233	f	\N	\N	\N
3427	Zemplin	Spartak Trnava	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217762039	f	\N	\N	\N
3435	SSD Fiorentina WFC (W)	Sassuolo (W)	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218321945	f	\N	\N	\N
3430	Karacabey Belediyespor AS	Adiyamanspor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218333683	f	\N	\N	\N
3437	Kocaelispor	Boluspor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218077693	f	\N	\N	\N
3433	Oleksandria	FC Minaj	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217921618	f	\N	\N	\N
3434	Gagra	Dila Gori	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218321855	f	\N	\N	\N
3422	CS Petrocub	Zimbru Chisinau	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218322035	f	\N	\N	\N
3421	Zilina	DUKLA BANSKA BYSTRICA	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217761401	f	\N	\N	\N
3425	Menemen Belediyespor	Etimesgut Belediyespor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218333868	f	\N	\N	\N
3432	Inter	AC Milan	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672668	f	\N	\N	\N
3442	Erokspor A.S	1461 Trabzon	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218333773	f	\N	\N	\N
3440	Pardubice	Slavia Prague	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727470	f	\N	\N	\N
3436	CD Covadonga	SD Compostela	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250783	f	\N	\N	\N
3441	Haugesund	Viking	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668817	f	\N	\N	\N
3426	Sandefjord	Stromsgodset	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668907	f	\N	\N	\N
3444	Union St Gilloise	Genk	2023-09-16 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217902609	f	\N	\N	\N
3453	Alcorcon	Levante	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217994392	f	\N	\N	\N
3446	Celta Vigo	Mallorca	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217662123	f	\N	\N	\N
3454	Vitesse Arnhem	RKC Waalwijk	2023-09-16 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217639226	f	\N	\N	\N
3448	Carrarese	Pesaro	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218235833	f	\N	\N	\N
3450	Club Atletico Saguntino	CF Badalona Futur	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218252239	f	\N	\N	\N
3449	Kidderminster	Solihull Moors	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218120811	f	\N	\N	\N
3451	Bochum	Eintracht Frankfurt	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217627668	f	\N	\N	\N
3447	Recanatese	Lucchese	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218235081	f	\N	\N	\N
3452	Valladolid	FC Cartagena	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217994284	f	\N	\N	\N
3456	CD Ardoi	SD Lagunak	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327920	f	\N	\N	\N
3474	Annecy	ESTAC Troyes	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007952	f	\N	\N	\N
3467	Quevilly Rouen	Concarneau	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007505	f	\N	\N	\N
3458	Dunkerque	Grenoble	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007772	f	\N	\N	\N
3455	Auxerre	Pau	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007624	f	\N	\N	\N
3468	Farense	Braga	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217912881	f	\N	\N	\N
3478	Rijeka	Osijek	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217982859	f	\N	\N	\N
3472	Madrid (W)	Barcelona (W)	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327609	f	\N	\N	\N
3459	Galatasaray	Samsunspor	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218118029	f	\N	\N	\N
3466	Tondela	Mafra	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218126141	f	\N	\N	\N
3463	Valenciennes	Bordeaux	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007325	f	\N	\N	\N
3465	Vozdovac	Mladost Lucani	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218220934	f	\N	\N	\N
3471	Rodez	Angers	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007862	f	\N	\N	\N
3460	Alcantarilla FC	Union Molinense CF	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329697	f	\N	\N	\N
3457	Ludogorets	Botev Plovdiv	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217706792	f	\N	\N	\N
3470	Bastia	Laval	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007415	f	\N	\N	\N
3462	Paris FC	Amiens	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218008043	f	\N	\N	\N
3469	Adana Demirspor	Pendikspor	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218113915	f	\N	\N	\N
3464	FK Backa Topola	Zeleznicar Pancevo	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218227105	f	\N	\N	\N
3473	Deportiva Venados	Inter Playa Del Carmen	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218324156	f	\N	\N	\N
3475	St. Joseph's FC	Europa FC	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218334199	f	\N	\N	\N
3477	OFK Petrovac	FK Jedinstvo Bijelo Polje	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218323886	f	\N	\N	\N
3445	Newcastle	Brentford	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217633662	f	\N	\N	\N
3476	Manchego Ciudad Real	CD Estepona	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218252698	f	\N	\N	\N
3429	Molde	Odds BK	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668724	f	\N	\N	\N
3485	Union Kleinmunchen (W)	FFC Vorderland (W)	2023-09-16 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218313935	f	\N	\N	\N
3483	Real Madrid Castilla	Atletico Madrid II	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238586	f	\N	\N	\N
3484	FK Mladost Donja Gorica	FK Arsenal Tivat	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218323976	f	\N	\N	\N
3497	Fortuna Sittard	FC Volendam	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217639334	f	\N	\N	\N
3502	FK Spartak	Vojvodina	2023-09-16 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218220844	f	\N	\N	\N
3491	Odra Opole	Lechia Gdansk	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798333	f	\N	\N	\N
3489	PSV	NEC Nijmegen	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217639442	f	\N	\N	\N
3495	Piast Gliwice	Legia Warsaw	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217793923	f	\N	\N	\N
3498	Newells	Union Santa Fe	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217818026	f	\N	\N	\N
3500	Calor de San Pedro	Cimarrones de Sonora II	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218326889	f	\N	\N	\N
3492	Deportivo Municipal	Universidad Cesar Vallejo	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190287	f	\N	\N	\N
3531	Club Brugge	Charleroi	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217902717	f	\N	\N	\N
3488	UD Torre del Mar	UD Ciudad de Torredonjimeno	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328461	f	\N	\N	\N
3486	Athlone Town (W)	Peamount United (W)	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303771	f	\N	\N	\N
3501	Al Ahli	Al-Taawoun Buraidah	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040034	f	\N	\N	\N
3496	Mushuc Runa	Delfin	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030911	f	\N	\N	\N
3490	Kfco Beerschot Wilrijk	Waasland-Beveren	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218125959	f	\N	\N	\N
3493	Desp Brasil P LTDA U20	Ibrachina FC U20	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218326799	f	\N	\N	\N
3494	Gremio Novorizontino U20	Oeste U20	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218329960	f	\N	\N	\N
3503	Olympic Safi	FUS Rabat	2023-09-16 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218327122	f	\N	\N	\N
3518	Deportivo Merlo	Argentino de Merlo	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326075	f	\N	\N	\N
3505	Jerv	Start	2023-09-16 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217885764	f	\N	\N	\N
3516	CA Claypole	Sportivo Italiano	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326387	f	\N	\N	\N
3508	Comunicaciones B Aires	Talleres (RE)	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218325985	f	\N	\N	\N
3512	Deportivo Madryn	Villa Dalmine	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218210354	f	\N	\N	\N
3507	Criciuma	Mirassol	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218082004	f	\N	\N	\N
3520	CSD Yupanqui	Real Pilar FC	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218336244	f	\N	\N	\N
3522	Defensores Unidos	Guillermo Brown	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218210711	f	\N	\N	\N
3513	Flandria	Almagro BA	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218209994	f	\N	\N	\N
3514	Canuelas	CS Dock Sud	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326165	f	\N	\N	\N
3510	Deportivo Armenio	CA Fenix	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218325797	f	\N	\N	\N
3519	Gimnasia de La Plata (W)	Estudiantes de la plata	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326709	f	\N	\N	\N
3515	Los Andes	Sacachispas	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218325887	f	\N	\N	\N
3521	CA Guemes	Nueva Chicago	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218209724	f	\N	\N	\N
3511	Excursionistas	San Martin de Burzaco	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326477	f	\N	\N	\N
3509	Universitatea Craiova	ACS Sepsi OSK	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217713274	f	\N	\N	\N
3526	Entella	USD Sestri Levante 1919	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235534	f	\N	\N	\N
3517	FK Mornar	FK Buducnost Podgorica	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218326979	f	\N	\N	\N
3506	Schalke 04	FC Magdeburg	2023-09-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217695743	f	\N	\N	\N
3530	Olbia	Sassari Torres	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235730	f	\N	\N	\N
3529	Pescara	Arezzo	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218236035	f	\N	\N	\N
3533	Sao Bernardo	EC Sao Jose Porto Alegre	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262395	f	\N	\N	\N
3525	Sligo Rovers	UCD	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217934292	f	\N	\N	\N
3523	Cardiff	Swansea	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217645685	f	\N	\N	\N
3528	Sarajevo	Zrinjski	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218324066	f	\N	\N	\N
3524	Gubbio	Fermana	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218235444	f	\N	\N	\N
3527	Genoa	Napoli	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217672788	f	\N	\N	\N
3532	Mineros Guayana	Rayo Zuliano	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218308834	f	\N	\N	\N
3535	Barcelona	Betis	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217661961	f	\N	\N	\N
3534	Ferroviario	Ferroviaria	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328949	f	\N	\N	\N
3536	Lens	Metz	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217913475	f	\N	\N	\N
3487	FCV Dender	Lommel	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218126049	f	\N	\N	\N
3482	Sturm Graz	Red Bull Salzburg	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217656156	f	\N	\N	\N
3567	UD Logrones	CD Izarra	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253377	f	\N	\N	\N
3568	Utebo CF	Barakaldo	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253060	f	\N	\N	\N
3570	Naxara CD	UD Mutilvera	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253287	f	\N	\N	\N
3571	Athletic Bilbao B	UD Barbastro	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253647	f	\N	\N	\N
3574	CD Calahorra	Arenas Club de Getxo	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253557	f	\N	\N	\N
3575	SD Gernika Club	CD Alaves B	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252103	f	\N	\N	\N
3537	Vasco Da Gama	Fluminense	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217718603	f	\N	\N	\N
3545	Vizela	Benfica	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912773	f	\N	\N	\N
3539	Albacete	Burgos	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217994176	f	\N	\N	\N
3550	AD Cariari Pococi	Municipal Turrialba	2023-09-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218327301	f	\N	\N	\N
3544	Union de Salamanca	Deportivo	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218233431	f	\N	\N	\N
3541	Cordoba	Linares Deportivo	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238316	f	\N	\N	\N
3542	Sabadell	SD Logrones	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218233538	f	\N	\N	\N
3546	Malaga	Granada B	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238406	f	\N	\N	\N
3549	San Lorenzo	Racing Club	2023-09-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217817936	f	\N	\N	\N
3552	Tigres FC Zipaquira	Boca Juniors de Cali	2023-09-16 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218202769	f	\N	\N	\N
3548	Botafogo SP	Atletico Go	2023-09-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217957963	f	\N	\N	\N
3547	Sampaio Correa FC	Chapecoense	2023-09-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217957873	f	\N	\N	\N
3553	Yous Berrechid	SCCM Chabab Mohamedia	2023-09-16 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218336514	f	\N	\N	\N
3554	Tacuary	Libertad	2023-09-16 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218305456	f	\N	\N	\N
3555	Almirante Brown	Estudiantes Rio Cuarto	2023-09-16 21:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218242156	f	\N	\N	\N
3551	Guayaquil City	Deportivo Cuenca	2023-09-16 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218031001	f	\N	\N	\N
3564	Deportivo Garcilaso	Cusco FC	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190107	f	\N	\N	\N
3561	Santa Tecla	CD Dragon	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306773	f	\N	\N	\N
3557	Amazonas FC	Volta Redonda	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262485	f	\N	\N	\N
3562	Cavalry	Vancouver FC	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218199109	f	\N	\N	\N
3556	Cibao FC	UNIVERSIDAD O&M	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336694	f	\N	\N	\N
3565	Zamora FC	Metropolitanos	2023-09-16 22:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218308744	f	\N	\N	\N
3560	Cucuta Deportivo	Real Cartagena	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218155517	f	\N	\N	\N
3558	Arabe Unido	Atletico Chiriqui	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218309194	f	\N	\N	\N
3559	Juventude	CRB	2023-09-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218115272	f	\N	\N	\N
3569	Aguacateros de Peribán F.C	Halcones de Zapopan	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339314	f	\N	\N	\N
3577	Atl Tucuman	Barracas Central	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217822975	f	\N	\N	\N
3572	Olancho	Lobos UPNFM	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295087	f	\N	\N	\N
3573	Deportivo Mixco	Guastatoya	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275541	f	\N	\N	\N
3576	Artesanos Metepec F.C.	Chilangos FC	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218338926	f	\N	\N	\N
3578	Gavilanes Matamoros	Leones Negros Udg	2023-09-16 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218334894	f	\N	\N	\N
3583	Miami FC	Pittsburgh Riverhounds	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218134489	f	\N	\N	\N
3580	Necaxa	FC Juarez	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217717020	f	\N	\N	\N
3582	Olimpia	Club General Caballero JLM	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218305366	f	\N	\N	\N
3581	Escorpiones FC	Montaneses FC	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339132	f	\N	\N	\N
3579	Deportivo Irapuato FC	CD Pioneros de Cancun	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339224	f	\N	\N	\N
3584	El Nacional	Emelec	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030821	f	\N	\N	\N
3589	Leones FC	Bogota	2023-09-17 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218155427	f	\N	\N	\N
3587	Club Sporting Canamy	Reboceros de La Piedad	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218336604	f	\N	\N	\N
3586	Cafetaleros de Chiapas II	Tampico Madero	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334984	f	\N	\N	\N
3585	Municipal Perez Zeledon	AD San Carlos	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306503	f	\N	\N	\N
3590	Atletico Independiente	Alianza FC (Pan)	2023-09-17 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218309014	f	\N	\N	\N
3594	Charlotte FC	DC Utd	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938855	f	\N	\N	\N
3592	Philadelphia	FC Cincinnati	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938498	f	\N	\N	\N
3593	Toronto FC	Vancouver Whitecaps	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938356	f	\N	\N	\N
3540	Gimnasia Mendoza	CA Temperley	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209814	f	\N	\N	\N
3563	Atlanta Utd	Inter Miami CF	2023-09-16 23:55:00	https://www.orbitxch.com/customer/sport/1/market/1.218305366	f	\N	\N	\N
3591	CF Montreal	Chicago Fire	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938638	f	\N	\N	\N
3371	Araz Nakhchivan PFK	Neftchi Baku	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262756	f	\N	\N	\N
3635	FC Telavi	Dinamo Batumi	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218317356	f	\N	\N	\N
3293	Corinthians U20	AA Portuguesa U20	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319318	f	\N	\N	\N
3310	MSK Povazska Bystrica	FK Spisska Nova Ves	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228558	f	\N	\N	\N
3370	Dacia Buiucani	FC Milsami-Ursidos	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320052	f	\N	\N	\N
3683	Chippenham	Hungerford Town	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368477	f	\N	\N	\N
3597	Atletico MG	Botafogo	2023-09-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217717491	f	\N	\N	\N
3600	Santos de Guapiles	CS Herediano	2023-09-17 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218306413	f	\N	\N	\N
3598	Talleres	Instituto	2023-09-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217822866	f	\N	\N	\N
3596	Antigua GFC	CSD Municipal	2023-09-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275628	f	\N	\N	\N
3601	Caracas	Universidad de Venezuela	2023-09-17 01:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218308654	f	\N	\N	\N
3604	Houston Dynamo	St Louis City SC	2023-09-17 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940030	f	\N	\N	\N
3607	Cd Fas	Once Municipal	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307557	f	\N	\N	\N
3602	Minnesota Utd	Kansas City	2023-09-17 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217939922	f	\N	\N	\N
3615	San Jose Earthquakes	Real Salt Lake	2023-09-17 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940246	f	\N	\N	\N
3605	Monterrey	Leon	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217716750	f	\N	\N	\N
3608	CD Motagua	CD Real Sociedad	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295267	f	\N	\N	\N
3609	Venados FC	Celaya	2023-09-17 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218135413	f	\N	\N	\N
3610	America de Cali S.A	Boyaca Chico	2023-09-17 02:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218347594	f	\N	\N	\N
3612	Herrera FC	Plaza Amador	2023-09-17 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218308924	f	\N	\N	\N
3614	LD Alajuelense	Puntarenas F.C.	2023-09-17 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306593	f	\N	\N	\N
3611	Sporting Cristal	Universitario de Deportes	2023-09-17 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218190823	f	\N	\N	\N
3613	Colorado	New England	2023-09-17 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940138	f	\N	\N	\N
3616	Los Angeles FC	LA Galaxy	2023-09-17 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940355	f	\N	\N	\N
3617	Tlaxcala F.C	Alebrijes de Oaxaca	2023-09-17 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218135503	f	\N	\N	\N
3618	CF America	Guadalajara	2023-09-17 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217716930	f	\N	\N	\N
3619	Gyeongnam	Jeonnam Dragons	2023-09-17 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217929019	f	\N	\N	\N
3742	CF Epila	CD Belchite 97	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218362151	f	\N	\N	\N
3740	Casalarreina CF	CDFC La Calzada	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218362061	f	\N	\N	\N
3735	CE Constancia de Inca	CD Llosetense	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218361971	f	\N	\N	\N
3750	AB	Fremad Amager	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218359102	f	\N	\N	\N
3761	APLG Gdansk (W)	Rekord Bielsko-Biala (W)	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218361787	f	\N	\N	\N
3752	FC Vilafranca	Reus	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362241	f	\N	\N	\N
3756	Strommen	Alta	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218361877	f	\N	\N	\N
3767	CD Padura	Leioa	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362421	f	\N	\N	\N
3768	CD Roda	CD Acero	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362331	f	\N	\N	\N
3413	Wisla Krakow	Chrobry Glogow	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217875054	f	\N	\N	\N
3776	CD Union Sur Yaiza	UD Las Palmas II	2023-09-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218362511	f	\N	\N	\N
3777	HUSA Agadir	Moghreb Tetouan	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362601	f	\N	\N	\N
3420	Olimpija	NK Maribor	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001658	f	\N	\N	\N
3428	Hamrun Spartans FC	Balzan FC	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218269114	f	\N	\N	\N
3791	Vikingur Reykjavik	KA Akureyri	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362691	f	\N	\N	\N
3461	Dinamo Tbilisi	Torpedo Kutaisi	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218317266	f	\N	\N	\N
3825	Athletic Bilbao B	UD Barbastro	2023-09-16 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253647	f	\N	\N	\N
3479	Panaitolikos	Panathinaikos	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217680056	f	\N	\N	\N
3856	Santos U20	EC Sao Bernardo U20	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362797	f	\N	\N	\N
3864	Pumas UNAM (W)	Toluca (W)	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218362887	f	\N	\N	\N
3504	Gzira United FC	Paola Hibernians FC	2023-09-16 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218269024	f	\N	\N	\N
3603	FC Dallas	Seattle Sounders	2023-09-17 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217939814	f	\N	\N	\N
3901	Utebo CF	Barakaldo	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253060	f	\N	\N	\N
3588	Inter de Queretaro FC	Club San Juan de Aragon	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339016	f	\N	\N	\N
3599	Estudiantes de Caseros	Independiente Rivadavia	2023-09-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218210264	f	\N	\N	\N
3538	Heracles	FC Utrecht	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217639550	f	\N	\N	\N
4233	Shenyang Urban FC	Qingdao Youth Island	2023-09-17 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218344760	f	\N	\N	\N
4234	Chungnam Asan	FC Anyang	2023-09-17 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217928743	f	\N	\N	\N
4235	Sham Shui Po	Hong Kong FC	2023-09-17 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218344850	f	\N	\N	\N
4236	Suwon Bluewings FC	Daegu FC	2023-09-17 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218392302	f	\N	\N	\N
4237	Guangxi Lanhang	Beijing Tech FC	2023-09-17 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218345665	f	\N	\N	\N
4238	Heilongjiang Lava Spring	Guangxi Baoyun	2023-09-17 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218364155	f	\N	\N	\N
4239	Nantong Zhiyun F.C	Chengdu Rongcheng	2023-09-17 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218181471	f	\N	\N	\N
4240	Madura Utd	Persebaya Surabaya	2023-09-17 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218345575	f	\N	\N	\N
4241	Zizkov	MAS Taborsko	2023-09-17 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217975171	f	\N	\N	\N
4242	FC Petrzalka	Malzenice	2023-09-17 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218229009	f	\N	\N	\N
4243	SV Ried	Ksv 1919	2023-09-17 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217937120	f	\N	\N	\N
4244	SK Sturm Graz II	Bregenz	2023-09-17 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217937211	f	\N	\N	\N
4245	Samorin	Tatran Lip Mikulas	2023-09-17 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218228918	f	\N	\N	\N
4246	Veertien Kuwana	ReinMeer Aomori	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352620	f	\N	\N	\N
4247	Mgladbach U19	VfL Bochum U19	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348823	f	\N	\N	\N
4248	Tegevajaro Miyazaki	Matsumoto	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218153050	f	\N	\N	\N
4249	Fujieda MYFC	FC Machida	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218041699	f	\N	\N	\N
4250	Kanazawa	Shimizu	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218041609	f	\N	\N	\N
4251	FC La Union Atletico	San Roque Lepe	2023-09-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284315	f	\N	\N	\N
4252	CD Plus Ultra	Lorca Deportiva CF	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218392392	f	\N	\N	\N
4253	AD Torrejon	Collado Villalba	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218392482	f	\N	\N	\N
4254	Yokohama FC	Kashiwa	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217878661	f	\N	\N	\N
4255	Bucheon FC 1995	Gimpo Citizen	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217928653	f	\N	\N	\N
4256	Hunan Billows FC	Wuhan Jiangcheng	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218346737	f	\N	\N	\N
4257	Tianjin Jinmen Tiger FC	Dalian Yifang	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218144179	f	\N	\N	\N
4258	FC Ryukyu	Ehime	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218153141	f	\N	\N	\N
4259	AD Parla	CD Leganes II	2023-09-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218392572	f	\N	\N	\N
4260	FE Grama	CFJ Mollerusa	2023-09-17 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218392662	f	\N	\N	\N
4261	CD Siete Villas	CD Bezana	2023-09-17 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218392752	f	\N	\N	\N
4262	UD Logrones	CD Izarra	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253377	f	\N	\N	\N
4263	Real Madrid C	Trival Valderas Alcorcon	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393717	f	\N	\N	\N
4264	FC Zhetysu	Kairat Almaty	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218179794	f	\N	\N	\N
4265	CD Utrera	Ayamonte	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393266	f	\N	\N	\N
4266	CF Montanesa	Rapitenca	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393086	f	\N	\N	\N
4267	Huetor Vega CD	Atletico Malagueno	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393446	f	\N	\N	\N
4268	RCD Mallorca II	CF Soller	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393537	f	\N	\N	\N
4269	Aviles Stadium CF	UC Ceares	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218392842	f	\N	\N	\N
4270	Posta Rangers	Sofapaka	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033542	f	\N	\N	\N
4271	Cornella	CA Tarazona	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218234347	f	\N	\N	\N
4272	Leonesa	CA Osasuna II	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218233249	f	\N	\N	\N
4273	UD Montijo	CDA Navalcarnero	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218283861	f	\N	\N	\N
4274	CF Pozuelo de Alarcon	FC Villanueva del Pardillo	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393807	f	\N	\N	\N
4276	UDG Tenerife Sur (W)	Sporting de Huelva (W)	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218145532	f	\N	\N	\N
4277	Pobla de Mafumet CF	Olot	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393897	f	\N	\N	\N
4278	G-Osaka	Albirex Niigata	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217878815	f	\N	\N	\N
4279	Oliveirense	Academico de Viseu	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218145717	f	\N	\N	\N
4280	CDE Ursaria	SS Reyes	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218283951	f	\N	\N	\N
4281	Albacete Balompie II	CD Azuqueca	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218392943	f	\N	\N	\N
4282	CD Llanes	CD Praviano	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393356	f	\N	\N	\N
4283	Levadia Tallinn II	Paide Linnameeskond II	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218347009	f	\N	\N	\N
4284	Atletico Sanluqueno CF	Atletico Baleares	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218239106	f	\N	\N	\N
4285	Ibiza Eivissa	Real Murcia	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218239472	f	\N	\N	\N
4286	Melilla UD	Recreativo Huelva	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218239196	f	\N	\N	\N
4287	CP San Cristobal	LHospitalet	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218394077	f	\N	\N	\N
4288	Girona B	UE Vilassar de Mar	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393987	f	\N	\N	\N
4289	Real Oviedo II	Valladolid B	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251143	f	\N	\N	\N
4290	CD Teruel	Gimnastic	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218233069	f	\N	\N	\N
4291	CDF Tres Cantos	Rayo Vallecano B	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393176	f	\N	\N	\N
4292	Thespakusatsu Gunma	Iwaki SC	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218015893	f	\N	\N	\N
4293	Cacereno	Getafe B	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284041	f	\N	\N	\N
4294	Olivenza	Don Benito	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218393627	f	\N	\N	\N
4295	Valencia-Mestalla	SE Penya Independent	2023-09-17 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252834	f	\N	\N	\N
4296	Feyenoord (W)	Fortuna Sittard (W)	2023-09-17 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218348646	f	\N	\N	\N
4298	Silva SD	Polvorin FC	2023-09-17 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218394167	f	\N	\N	\N
4299	Cagliari	Udinese	2023-09-17 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217672908	f	\N	\N	\N
4300	Jagiellonia Bialystock	Radomiak Radom	2023-09-17 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217793833	f	\N	\N	\N
4301	Nakhon Si United F.C.	Lampang FC	2023-09-17 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218361518	f	\N	\N	\N
4302	Como FC (W)	Napoli Calcio (W)	2023-09-17 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218350588	f	\N	\N	\N
4303	GKS Tychy	LKP Motor Lublin	2023-09-17 11:40:00	https://www.orbitxch.com/customer/sport/1/market/1.217798423	f	\N	\N	\N
4304	SG E Frankfurt U19	Kaiserslautern U19	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384613	f	\N	\N	\N
4305	CD Marino	CD Union Puerto	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218394387	f	\N	\N	\N
4306	UD San Fernando	AD Union Adarve	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284131	f	\N	\N	\N
4307	Durham (W)	London City Lionesses	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373593	f	\N	\N	\N
4308	GAIS	Helsingborgs	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960471	f	\N	\N	\N
4309	Reading (W)	Southampton (W)	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373503	f	\N	\N	\N
4310	IK Uppsala (W)	Vittsjo (W)	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218350984	f	\N	\N	\N
4311	Oddevold	Tvaakers	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218162725	f	\N	\N	\N
4312	Viktoria Berlin	FC Eilenburg	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311908	f	\N	\N	\N
4313	ISI Dangkor Senchey FC	Nagaworld FC	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372344	f	\N	\N	\N
4314	Notodden	Brattvag	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334714	f	\N	\N	\N
4315	Boeung Ket	Kirivong Sok Sen Chey	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218347414	f	\N	\N	\N
4316	Visakha FC	Phnom Penh	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218347504	f	\N	\N	\N
4317	Liepajas Metalurgs	Valmieras FK	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263461	f	\N	\N	\N
4318	Chemie Leipzig	Berliner AK	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311818	f	\N	\N	\N
4319	Sheffield United (W)	Lewes (W)	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373413	f	\N	\N	\N
4320	Chonburi	Lamphun Warrior	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218152565	f	\N	\N	\N
4321	Hansa Rostock II	Altglienicke	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218312032	f	\N	\N	\N
4322	Suphanburi	Chanthaburi FC	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218360725	f	\N	\N	\N
4323	Alemannia Aachen U19	MSV Duisburg U19	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364245	f	\N	\N	\N
4324	Millwall	Leeds	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645145	f	\N	\N	\N
4325	TSV 1860 Munchen U19	FC Ingolstadt 04 U19	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374873	f	\N	\N	\N
4326	Lorient	Monaco	2023-09-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217677884	f	\N	\N	\N
4327	Sotra SK	Baerum	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390575	f	\N	\N	\N
4329	Jinan Xingzhou	Shanghai Jiading	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347993	f	\N	\N	\N
4330	Hannover	VFL Osnabruck	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217688585	f	\N	\N	\N
4331	Jiangxi Liansheng	Wuxi Wugou	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347813	f	\N	\N	\N
4328	Deinze	Seraing Utd	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218229555	f	\N	\N	\N
4334	Erzgebirge	Hallescher FC	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218145626	f	\N	\N	\N
4335	Hertha Berlin	Braunschweig	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217688440	f	\N	\N	\N
4336	Kieler SV Holstein II	SC Spelle Venhaus	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218311183	f	\N	\N	\N
4337	SGB Kanchanaburi	Chainat Horn	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218361695	f	\N	\N	\N
4338	Suzhou Dongwu	Dantong Hantong	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347903	f	\N	\N	\N
4339	Chongqing Tonglianglong	Hubei Chufeng Heli	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218348083	f	\N	\N	\N
4340	Sichuan Jiuniu FC	Yanbian Longding	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347723	f	\N	\N	\N
4341	Spartans WFC (W)	Hamilton WFC (W)	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371413	f	\N	\N	\N
4342	Sarmiento de Junin	Central Cordoba (SdE)	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217876183	f	\N	\N	\N
4343	Gimnasia La Plata	Velez Sarsfield	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217817846	f	\N	\N	\N
4344	Persik Kediri	Persija Jakarta	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348916	f	\N	\N	\N
4345	Dnipro-1	Kolos Kovalyovka	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217924563	f	\N	\N	\N
4346	Hegelmann Litauen	FC Dziugas	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229844	f	\N	\N	\N
4348	Shakhter Karagandy	FK Kaisar	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218291317	f	\N	\N	\N
4349	Nakhon Ratchasima	Krabi FC	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218361212	f	\N	\N	\N
4350	TSV Schott Mainz	Hessen Kassel	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218395127	f	\N	\N	\N
4351	Updf FC	Uganda Revenue Authority	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369063	f	\N	\N	\N
4353	Amorebieta	Mirandes	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217994068	f	\N	\N	\N
4354	FC Talanta	Muranga Seal	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033654	f	\N	\N	\N
4355	Gor Mahia FC	Nairobi City Stars	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033744	f	\N	\N	\N
4356	Druk Lhayul FC	Thimphu City	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373015	f	\N	\N	\N
4357	Pusamania Borneo FC	PSS Sleman	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218349632	f	\N	\N	\N
4358	Asteras Tripolis	PAS Giannina	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217680146	f	\N	\N	\N
4359	Karlsruher SC U19	Nurnberg U19	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348736	f	\N	\N	\N
4360	Samgurali Tskaltubo	FC Saburtalo Tbilisi	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348556	f	\N	\N	\N
4361	Port FC	Prachuap	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218152753	f	\N	\N	\N
4362	Samtredia	FC Shukura Kobuleti	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348466	f	\N	\N	\N
4363	Getafe	Osasuna	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217661841	f	\N	\N	\N
4364	Bodens	Motala	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218200887	f	\N	\N	\N
4365	Wakiso Giants	Maroons FC	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368970	f	\N	\N	\N
4366	FC Kariobangi Sharks	KCB	2023-09-17 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218033834	f	\N	\N	\N
4367	Kuala Lumpur	Pahang	2023-09-17 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218384793	f	\N	\N	\N
4368	Stjordals-Blink	Tromsdalen	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390485	f	\N	\N	\N
4369	SC AUSTRIA LUSTENAU	WSG Wattens	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217656336	f	\N	\N	\N
4370	Karbel Karakopru	Viven Bornova FK	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385963	f	\N	\N	\N
4372	Bahir Dar FC	Club Africain	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218370024	f	\N	\N	\N
4373	PFK Turan Tovuz	FK Qabala	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218262846	f	\N	\N	\N
4376	Palmeiras U20	Agua Santa U20	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218389457	f	\N	\N	\N
4377	Pontypridd Town (W)	The New Saints (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391073	f	\N	\N	\N
4378	Aberystwyth Town (W)	Barry Town United (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372525	f	\N	\N	\N
4379	United IK Nordic	Pitea	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218390893	f	\N	\N	\N
4380	Clermont	Nantes	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217678124	f	\N	\N	\N
4381	Bregalnica Stip	FK Struga Trim-Lum	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371130	f	\N	\N	\N
4382	Watford (W)	Blackburn Rovers (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373142	f	\N	\N	\N
4383	Widzew Lodz	Cracovia Krakow	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217794821	f	\N	\N	\N
4384	Gadafi FC	Vipers SC	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372705	f	\N	\N	\N
4385	NK Radomlje	Domzale	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001477	f	\N	\N	\N
4386	Strasbourg	Montpellier	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217677621	f	\N	\N	\N
4387	68 Aksaray Belediyespor	Amed Sportif Faaliyetler	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367465	f	\N	\N	\N
4388	Frosinone	Sassuolo	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217673438	f	\N	\N	\N
4389	Etincelles	Police FC	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218351256	f	\N	\N	\N
4347	Vejle	Randers	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217896973	f	\N	\N	\N
4352	Fredericia	FC Helsingor	2023-09-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961474	f	\N	\N	\N
4371	Hartberg	Austria Vienna	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217656246	f	\N	\N	\N
4374	Excelsior	Almere City	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217639874	f	\N	\N	\N
4375	FC Twente	Ajax	2023-09-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217639766	f	\N	\N	\N
4391	Kozani FC	Iraklis	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218334804	f	\N	\N	\N
4392	Mjondalen	Bryne	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885660	f	\N	\N	\N
4393	Linkopings FC (W)	KIF Orebro Dff (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352180	f	\N	\N	\N
4394	Moss	Skeid	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885858	f	\N	\N	\N
4395	Keruleti	Diosgyori	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218388141	f	\N	\N	\N
4396	FK Makedonija	FK Gostivar	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218390395	f	\N	\N	\N
4397	AC Milan (W)	AS Roma (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218350498	f	\N	\N	\N
4398	Cf Os Belenenses	Leiria	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218152459	f	\N	\N	\N
4399	Tuzlaspor	Adanaspor	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218077602	f	\N	\N	\N
4400	APR FC	Pyramids	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369932	f	\N	\N	\N
4401	Arua Hill SC	Busoga United	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368879	f	\N	\N	\N
4402	Giresunspor	Manisa FK	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218234991	f	\N	\N	\N
4403	PAE Chania	Apollon Kalamaria FC	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218374963	f	\N	\N	\N
4404	Hammarby	Malmo FF	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217787525	f	\N	\N	\N
4406	Djurgardens IF Dff (W)	BK Hacken (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218350894	f	\N	\N	\N
4407	Asane	Hodd	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885557	f	\N	\N	\N
4408	Fredrikstad	Sogndal	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885948	f	\N	\N	\N
4410	FK Jablonec	Slovan Liberec	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727740	f	\N	\N	\N
4411	Reims	Brest	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217678004	f	\N	\N	\N
4412	Kvik Halden	Levanger	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218276617	f	\N	\N	\N
4413	Sunderland (W)	Crystal Palace (W)	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373232	f	\N	\N	\N
4414	Sundsvall	Utsiktens	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960381	f	\N	\N	\N
4415	AC Monza	Lecce	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217673028	f	\N	\N	\N
4416	PTE PEAC	Kaposvar	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218388051	f	\N	\N	\N
4417	KuPS	VPS	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218150851	f	\N	\N	\N
4418	MUZA FC	Diables Noirs	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218396067	f	\N	\N	\N
4419	Singida Big Stars	Future FC	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369842	f	\N	\N	\N
4420	Bremer SV	Drochtersen-Assel	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311093	f	\N	\N	\N
4421	Duzcespor	Karaman Belediyespor	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352953	f	\N	\N	\N
4422	Kongsvinger	Kristiansund	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217885344	f	\N	\N	\N
4423	FK Tukums 2000	SK Super Nova	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218263281	f	\N	\N	\N
4424	Zlin	Plzen	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727650	f	\N	\N	\N
4425	SC Bruhl St Gallen	Lausanne	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375323	f	\N	\N	\N
4426	Aurora Pro Patria 1919	Arzignanochiampo	2023-09-17 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218390305	f	\N	\N	\N
4428	Iskenderunspor	Belediye Derincespor	2023-09-17 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218353044	f	\N	\N	\N
4429	Hearts (W)	Partick Thistle (W)	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371322	f	\N	\N	\N
4430	Real Sociedad III	Real Zaragoza II	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252970	f	\N	\N	\N
4431	NK Brinje Grosuplje	NK Bilje	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270056	f	\N	\N	\N
4432	Valur Reykjavik (W)	Hafnarfjordur (W)	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352000	f	\N	\N	\N
4433	Sol De Mayo	Sansinena	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352440	f	\N	\N	\N
4434	Nieciecza	Podbeskidzie B-B	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217879406	f	\N	\N	\N
4435	Oskarshamns AIK	Aatvidabergs FF	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218162635	f	\N	\N	\N
4436	KF Erzeni	Dinamo Tirana	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375413	f	\N	\N	\N
4437	Fola Esch	Swift Hesperange	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352726	f	\N	\N	\N
4438	Fenerbahce	Antalyaspor	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944047	f	\N	\N	\N
4439	Istanbulspor	Basaksehir	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217943939	f	\N	\N	\N
4440	Bellinzona	Schaffhausen	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218376434	f	\N	\N	\N
4441	Breidablik (W)	Stjarnan (W)	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352090	f	\N	\N	\N
4442	Hvidovre	Lyngby	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217900922	f	\N	\N	\N
4443	Hermannstadt	FC Voluntari	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217713814	f	\N	\N	\N
4444	Cottbus	FSV Zwickau	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311728	f	\N	\N	\N
4445	Gnistan	TPS	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218150381	f	\N	\N	\N
4446	FK Radnicki 1923	FK Javor Ivanjica	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218220754	f	\N	\N	\N
4449	Catanzaro	Parma	2023-09-17 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217959565	f	\N	\N	\N
4409	Bournemouth	Chelsea	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634657	f	\N	\N	\N
4427	FC Heidenheim	Werder Bremen	2023-09-17 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217642214	f	\N	\N	\N
4447	Kortrijk	Anderlecht	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217902825	f	\N	\N	\N
4448	Francs Borains	Lierse	2023-09-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229267	f	\N	\N	\N
4451	Villarreal	Almeria	2023-09-17 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217661720	f	\N	\N	\N
4452	Eibar	Racing de Ferrol	2023-09-17 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217993365	f	\N	\N	\N
4453	Arouca	Casa Pia	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912665	f	\N	\N	\N
4454	Avenir S Marsa	CA Bizertin	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385243	f	\N	\N	\N
4455	US Tataouine	Monastir	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385153	f	\N	\N	\N
4456	Lynx FC	Lions Gibraltar	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218376299	f	\N	\N	\N
4457	Varnsdorf	MFK Chrudim	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217975261	f	\N	\N	\N
4458	ES Metlaoui	Club Sportif Sfaxien	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218352530	f	\N	\N	\N
4459	Gil Vicente	Estoril Praia	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912557	f	\N	\N	\N
4460	Waldhof Mannheim	SSV Ulm	2023-09-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218152663	f	\N	\N	\N
4463	Etar	Lokomotiv Plovdiv	2023-09-17 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217706973	f	\N	\N	\N
4464	Riteriai	VMFD Zalgiris	2023-09-17 15:55:00	https://www.orbitxch.com/customer/sport/1/market/1.218229934	f	\N	\N	\N
4465	IFK Stocksund	Dalkurd FF	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218390983	f	\N	\N	\N
4466	Motherwell (W)	Hibernian (W)	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371503	f	\N	\N	\N
4467	Naxara CD	UD Mutilvera	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253287	f	\N	\N	\N
4468	Fk Novi Pazar	FK Napredak	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218220664	f	\N	\N	\N
4469	Rosenborg	Bodo Glimt	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668371	f	\N	\N	\N
4470	Pontevedra CF	UP Langreo	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250873	f	\N	\N	\N
4471	Marbella	El Palo	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284406	f	\N	\N	\N
4472	SD Rayo Cantabria	RC Villalbes	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251053	f	\N	\N	\N
4474	Shabab Al Ordon	Ma'an	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218395458	f	\N	\N	\N
4475	HNK Gorica	Hajduk Split	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217973231	f	\N	\N	\N
4476	CD Badajoz	Guadalajara	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218289045	f	\N	\N	\N
4477	Medeama SC	Horoya AC	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367735	f	\N	\N	\N
4478	Tromso	Ham-Kam	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668551	f	\N	\N	\N
4479	Marino Luanco	Deportivo La Coruna II	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218251323	f	\N	\N	\N
4480	Orebro	Skovde AIK	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960291	f	\N	\N	\N
4481	EIF	HIFK	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218150471	f	\N	\N	\N
4482	Jaro	KPV	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218150561	f	\N	\N	\N
4483	Kifisias FC	Panserraikos	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217679785	f	\N	\N	\N
4484	TuS BW Lohne	TSV Havelse	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218311002	f	\N	\N	\N
4485	Cerdanyola del Valles	CE Andratx	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218282737	f	\N	\N	\N
4486	Al Arabi (Jor)	Al Sarhan	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364335	f	\N	\N	\N
4487	Sarpsborg	Lillestrom	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668461	f	\N	\N	\N
4488	Stabaek	Brann	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668281	f	\N	\N	\N
4489	Marseille	Toulouse	2023-09-17 16:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217677764	f	\N	\N	\N
4490	Aberdeen (W)	Celtic (W)	2023-09-17 16:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218371231	f	\N	\N	\N
4491	Fiorenzuola	Albinoleffe	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390035	f	\N	\N	\N
4492	Alessandria	Padova	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218389945	f	\N	\N	\N
4493	LR Vicenza Virtus	Lumezzane	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390215	f	\N	\N	\N
4494	CD Calahorra	Arenas Club de Getxo	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218253557	f	\N	\N	\N
4496	SV Darmstadt	Mgladbach	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217643091	f	\N	\N	\N
4497	Elfsborg	Kalmar FF	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217786775	f	\N	\N	\N
4498	Hacken	Halmstads	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217786991	f	\N	\N	\N
4499	Sestao River	Sociedad B	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218234257	f	\N	\N	\N
4500	Qarabag Fk	FC Sabah	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218263026	f	\N	\N	\N
4501	UD Alzira	Lleida	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218282375	f	\N	\N	\N
4502	FC Legnago	SS Virtus Verona 1921	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218390125	f	\N	\N	\N
4503	Warta Poznan	Lech Poznan	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217794013	f	\N	\N	\N
4504	AmaZulu	Cape Town CIty F.C.	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218203309	f	\N	\N	\N
4505	Dunajska Streda	Slovan Bratislava	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217756085	f	\N	\N	\N
4506	Deportivo Coatepeque	Malacateco	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275718	f	\N	\N	\N
4507	Tudelano	AD San Juan	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253196	f	\N	\N	\N
4508	SD Gernika Club	CD Alaves B	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252103	f	\N	\N	\N
4509	Sampdoria (W)	Inter Milan (W)	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218350408	f	\N	\N	\N
4462	Az Alkmaar	Sparta Rotterdam	2023-09-17 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217639982	f	\N	\N	\N
4473	Rapid Vienna	Wolfsberger AC	2023-09-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217656426	f	\N	\N	\N
4495	Everton	Arsenal	2023-09-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217635362	f	\N	\N	\N
4511	Tabasalu JK	FC Tallinn	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218355964	f	\N	\N	\N
4512	Balikesirspor	Catalcaspor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367555	f	\N	\N	\N
4514	FC Cartagena II	Velez CF	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284768	f	\N	\N	\N
4515	Sparta Prague	Slovacko	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217727830	f	\N	\N	\N
4516	Aguilas	Cadiz B	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284859	f	\N	\N	\N
4517	CE Europa	UE Sant Andreu	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218288887	f	\N	\N	\N
4518	Birkirkara	Sliema Wanderers FC	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268844	f	\N	\N	\N
4519	Afjet Afyonspor	Zonguldakspor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387657	f	\N	\N	\N
4520	Akhisar Belediye	Agri 1970 Spor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391163	f	\N	\N	\N
4521	Arka Gdynia	Miedz Legnica	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798513	f	\N	\N	\N
4522	Goztepe	Bandirmaspor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218079068	f	\N	\N	\N
4523	CF Rayo Majadahonda	Celta Vigo B	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218234167	f	\N	\N	\N
4524	Santa Lucia FC	Floriana	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268664	f	\N	\N	\N
4525	Mersin Idman Yurdu	Serik Belediyespor	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218352862	f	\N	\N	\N
4526	CSF Balti	CSF Spartanii	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218370710	f	\N	\N	\N
4527	Karsiyaka	Amasyaspor 1968 FK	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218386406	f	\N	\N	\N
4528	Fiorentina	Atalanta	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217673150	f	\N	\N	\N
4529	Denizlispor	Arnavutkoy Belediyesi GVS	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218387459	f	\N	\N	\N
4530	Zlate Moravce	Trencin	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217789322	f	\N	\N	\N
4531	Yeni Orduspor	Tarsus Idman Yurdu	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218391269	f	\N	\N	\N
4532	Otelul Galati	Rapid Bucharest	2023-09-17 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217713544	f	\N	\N	\N
4533	Bnei Sakhnin	Hapoel Jerusalem	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218153648	f	\N	\N	\N
4534	Una Strassen	Fc Differdange 03	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218364426	f	\N	\N	\N
4535	Espanyol	Eldense	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993077	f	\N	\N	\N
4537	Novara	A.C. Trento S.C.S.D.	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218231256	f	\N	\N	\N
4538	Stade Malien de Bamako	Aigle Noir	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218369752	f	\N	\N	\N
4539	Elche	Leganes	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217993780	f	\N	\N	\N
4540	Sevilla	Las Palmas	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217661600	f	\N	\N	\N
4541	Maccabi Tel Aviv	Maccabi Bnei Raina	2023-09-17 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218153954	f	\N	\N	\N
4542	Hapoel Haifa	FC Ashdod	2023-09-17 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218154044	f	\N	\N	\N
4545	S Lucia Cotzumalguapa	Solola FC	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218396693	f	\N	\N	\N
4544	OFK Mladost	FK Kom	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372434	f	\N	\N	\N
4543	Aurora FC	Universidad San Carlos	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375503	f	\N	\N	\N
4560	Betis B	Mar Menor CF	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284225	f	\N	\N	\N
4559	Coruxo	CD Cayon	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250693	f	\N	\N	\N
4550	Fylkir	IBV	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218155030	f	\N	\N	\N
4546	Hercules	Torrent CF	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218282647	f	\N	\N	\N
4548	Benfica B	Torreense	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218155697	f	\N	\N	\N
4558	Maccabi Petach Tikva	Maccabi Haifa	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228098	f	\N	\N	\N
4556	Terrassa	Espanyol B	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218282556	f	\N	\N	\N
4554	Alanyaspor	Kasimpasa	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944371	f	\N	\N	\N
4553	Granada (W)	Real Sociedad (W)	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218351165	f	\N	\N	\N
4547	Guimaraes	Portimonense	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217912449	f	\N	\N	\N
4552	CS Cartagines	Sporting San Jose FC	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306683	f	\N	\N	\N
4551	Caja Oblatos C.FD	Zitacuaro CF	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218392122	f	\N	\N	\N
4557	Zamora	Guijuelo	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218250963	f	\N	\N	\N
4549	Maccabi Netanya	Hapoel Petach Tikva	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228008	f	\N	\N	\N
4555	Trabzonspor	Besiktas	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217943831	f	\N	\N	\N
4564	Varazdin	NK Istra	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217995886	f	\N	\N	\N
4562	Sint Truiden	Yellow-Red Mechelen	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217902966	f	\N	\N	\N
4561	Valerenga	Aalesunds	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217668191	f	\N	\N	\N
4568	Antequera CF	CD Castellon	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218240032	f	\N	\N	\N
4567	Algeciras	Merida AD	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218240800	f	\N	\N	\N
4566	Unterhaching	Saarbrucken	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218155607	f	\N	\N	\N
4536	Oud-Heverlee Leuven	Gent	2023-09-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217903728	f	\N	\N	\N
4565	SL 16 FC	KV Oostende	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218230294	f	\N	\N	\N
4618	Bordeaux (W)	Paris St-G (W)	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218349902	f	\N	\N	\N
4574	PAOK	Aris	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217679875	f	\N	\N	\N
4569	Lugo	Ponferradina	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218234077	f	\N	\N	\N
4572	Aucas	Tecnico Universitario	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218030731	f	\N	\N	\N
4571	Orihuela CF	UCAM Murcia	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218284496	f	\N	\N	\N
4575	Radnicki Nis	FK IMT Novi Beograd	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218226925	f	\N	\N	\N
4573	Glacis Utd	Mons Calpe SC	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218376208	f	\N	\N	\N
4576	Partizan Belgrade	Radnik Surdulica	2023-09-17 18:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218220484	f	\N	\N	\N
4578	Bonsucesso	Sao Cristovao	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218388933	f	\N	\N	\N
4581	Belford Roxo Futebol Clube	AA Carapebus	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218389200	f	\N	\N	\N
4580	Angra dos Reis EC	Acao RJ	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218389023	f	\N	\N	\N
4579	EC Rio Sao Paulo	Barra Mansa	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218389547	f	\N	\N	\N
4577	SE Buzios	Mageense FC	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218389110	f	\N	\N	\N
4582	Siroki Brijeg	Zvijezda 09 Bijeljina	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218364516	f	\N	\N	\N
4583	Borac Banja Luka	Nk Posusje	2023-09-17 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218364606	f	\N	\N	\N
4584	Achuapa FC	CSD Tellioz	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275808	f	\N	\N	\N
4585	Atletico MG U20	Cruzeiro U20	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218389367	f	\N	\N	\N
4588	Puebla FC (W)	Cruz Azul (W)	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364877	f	\N	\N	\N
4590	CA Germinal	CA Liniers	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365507	f	\N	\N	\N
4594	Ferro Carril Oeste GP	Huracan Las Heras	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365687	f	\N	\N	\N
4586	Pumas UNAM	Atletico San Luis	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217717200	f	\N	\N	\N
4593	Breidablik	Hafnarfjordur	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218123310	f	\N	\N	\N
4589	Botafogo SP U20	Inter Limeira U20	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364787	f	\N	\N	\N
4595	Brown de Adrogue	Chaco For Ever	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218210534	f	\N	\N	\N
4591	Ciudad de Bolivar	Sportivo Penarol	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218365327	f	\N	\N	\N
4592	Valletta	Sirens FC	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268754	f	\N	\N	\N
4587	CA Antoniano	Sevilla B	2023-09-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218284678	f	\N	\N	\N
4598	Gimnasia Jujuy	Chacarita	2023-09-17 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218210174	f	\N	\N	\N
4597	Mosta	Gudja United	2023-09-17 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218268934	f	\N	\N	\N
4601	CA Atlas	CSD Liniers de Ciudad Evita	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365417	f	\N	\N	\N
4604	Victoriano Arenas	Justo Jose de Urquiza	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218336334	f	\N	\N	\N
4600	Olimpo	Circulo Deportivo Otamendi	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365777	f	\N	\N	\N
4606	Deportivo Laferrere	General Lamadrid	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218336424	f	\N	\N	\N
4599	CA Colegiales	Villa San Carlos	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365237	f	\N	\N	\N
4603	CA Puerto Nuevo	Club Lujan	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365597	f	\N	\N	\N
4602	Def Belgrano VR	Sportivo AC Las Parejas	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218365867	f	\N	\N	\N
4605	AEK Athens	Olympiakos	2023-09-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217679966	f	\N	\N	\N
4615	Avellino	Foggia	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218243754	f	\N	\N	\N
4613	US Virtus Calcio	Crotone	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244872	f	\N	\N	\N
4607	Catania	AZ Picerno ASD	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218243664	f	\N	\N	\N
4616	Casertana	Benevento	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218270894	f	\N	\N	\N
4612	Potenza	Monopoli	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244384	f	\N	\N	\N
4610	Guarani	Tombense MG	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218029243	f	\N	\N	\N
4608	Farul Constanta	FCSB	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217712854	f	\N	\N	\N
4614	AP Turris Calcio	Sorrento	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244294	f	\N	\N	\N
4624	Real Madrid	Real Sociedad	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217662288	f	\N	\N	\N
4611	Roma	Empoli	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217673558	f	\N	\N	\N
4623	Club Cipolletti	Villa Mitre	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368005	f	\N	\N	\N
4620	Paysandu	Botafogo PB	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262575	f	\N	\N	\N
5013	ZED FC	Ismaily	2023-09-19 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218481182	f	\N	\N	\N
4622	Argentino Monte Maiz	Juventud Unida Universitari	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368095	f	\N	\N	\N
4625	Boca Unidos	Crucero del Norte	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368362	f	\N	\N	\N
4619	Alvarado	San Telmo	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218242426	f	\N	\N	\N
4621	Levante UD (W)	Sevilla FC (W)	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218351075	f	\N	\N	\N
4626	Sporting Gijon	Tenerife	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217992879	f	\N	\N	\N
4609	Lyon	Le Havre	2023-09-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217879827	f	\N	\N	\N
4513	AGF	Brondby	2023-09-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217904043	f	\N	\N	\N
4684	Deportivo Coatepeque	Malacateco	2023-09-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218275718	f	\N	\N	\N
4297	PEC Zwolle	Go Ahead Eagles	2023-09-17 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217639658	f	\N	\N	\N
4332	Eupen	Standard	2023-09-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217903620	f	\N	\N	\N
4405	Vendsyssel FF	Naestved	2023-09-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961294	f	\N	\N	\N
4563	CSKA Sofia	CSKA 1948 Sofia	2023-09-17 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217707337	f	\N	\N	\N
4570	FK Decic	FK Sutjeska	2023-09-17 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218364697	f	\N	\N	\N
4596	Mas Maghrib A Fes	Raja Casablanca	2023-09-17 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218367645	f	\N	\N	\N
4734	Koper	NK Celje	2023-09-17 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218001387	f	\N	\N	\N
4753	Club Defensores de P	Club Atletico el Linqueno	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218389704	f	\N	\N	\N
4763	CS Estudiantes San Luis	San Martin de Mendoza	2023-09-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368185	f	\N	\N	\N
4630	Valur	Stjarnan	2023-09-17 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218155787	f	\N	\N	\N
4631	Sporting Lisbon	Moreirense	2023-09-17 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217912233	f	\N	\N	\N
4632	Patronato	San Martin de Tucuman	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218242246	f	\N	\N	\N
4636	FC Midland	AD Berazategui	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218367915	f	\N	\N	\N
4634	Sol de America	Club Gimnasia y Tiro	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218368275	f	\N	\N	\N
4635	Independiente (Ecu)	Libertad FC	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030551	f	\N	\N	\N
4637	Asociacion Deportiva Tarma	Sport Huancayo	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190648	f	\N	\N	\N
4633	Godoy Cruz	Belgrano	2023-09-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217957012	f	\N	\N	\N
4638	Deportivo Moron	All Boys	2023-09-17 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218242336	f	\N	\N	\N
4836	El Geish	National Bank	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384343	f	\N	\N	\N
4639	IRT Tanger	Mouloudia dOujda	2023-09-17 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218369567	f	\N	\N	\N
4640	CA Central Norte	Sarmiento de Resistencia	2023-09-17 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218369658	f	\N	\N	\N
4641	Club Sportivo Ameliano	Resistencia FC	2023-09-17 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218305276	f	\N	\N	\N
4643	Deportivo San Pedro	Juventud Copalera	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218390700	f	\N	\N	\N
4642	Quilmes	Atletico Mitre	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218210084	f	\N	\N	\N
4649	Costa del Este	UMECIT	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218309104	f	\N	\N	\N
4650	CD Marathon	CD Olimpia	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294997	f	\N	\N	\N
4647	EC Vitoria Salvador	Avai	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218126500	f	\N	\N	\N
4648	Deportivo Tachira	Carabobo FC	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218308564	f	\N	\N	\N
4645	CA Racing de Cordoba	Aldosivi	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218210621	f	\N	\N	\N
4644	Santa Fe	Alianza Petrolera	2023-09-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218349366	f	\N	\N	\N
4651	CD Luis Angel Firpo	Platense Zacatecoluca	2023-09-17 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218308472	f	\N	\N	\N
4652	Juventud Pinulteca FC	Barberena FC	2023-09-17 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218375593	f	\N	\N	\N
4654	Jocoro	CD Aguila	2023-09-17 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218342537	f	\N	\N	\N
4653	Atletico Rafaela	CD MAIPU	2023-09-17 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218209904	f	\N	\N	\N
4656	9 de Julio Rafaela	CSg San Martin F	2023-09-17 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218372921	f	\N	\N	\N
4655	Brusque FC	Operario PR	2023-09-17 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262665	f	\N	\N	\N
4657	River Plate	Arsenal De Sarandi	2023-09-17 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217822650	f	\N	\N	\N
4658	Huehueteco Xinabajul	Xelaju	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218299323	f	\N	\N	\N
4659	Queretaro	Puebla	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217716840	f	\N	\N	\N
4661	CF America (W)	Guadalajara (W)	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218371960	f	\N	\N	\N
4660	Vida	Real Espana	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295177	f	\N	\N	\N
4663	Real Apodaca FC	Alacranes de Durango	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218373683	f	\N	\N	\N
4662	Barcelona (Ecu)	LDU	2023-09-18 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030641	f	\N	\N	\N
4664	Club Atletico Morelia	Tapatio	2023-09-18 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218162421	f	\N	\N	\N
4665	Junior FC Barranquilla	Atletico Nacional Medelli	2023-09-18 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218348270	f	\N	\N	\N
4666	Alianza Lima	Union Comercio	2023-09-18 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218190468	f	\N	\N	\N
4667	Atletico Huila	Rionegro	2023-09-18 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218348376	f	\N	\N	\N
4670	Atlas	Tigres	2023-09-18 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217717380	f	\N	\N	\N
4669	Genesis Huracan	CD Victoria	2023-09-18 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218294906	f	\N	\N	\N
4671	Club Leon FC (W)	Atletico San Luis (W)	2023-09-18 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.218372050	f	\N	\N	\N
4672	Club Tijuana (W)	FC Atlas (W)	2023-09-18 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.218372140	f	\N	\N	\N
4673	Deportivo Pasto	Tolima	2023-09-18 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218349276	f	\N	\N	\N
4674	Mazatlan FC(W)	FC Juarez (W)	2023-09-18 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218372230	f	\N	\N	\N
4668	Austin FC	Portland Timbers	2023-09-18 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217943124	f	\N	\N	\N
4803	Puerto Cabello	Portuguesa FC	2023-09-18 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218406721	f	\N	\N	\N
4812	Yokohama SCC	Grulla Morioka	2023-09-18 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218255366	f	\N	\N	\N
4815	Transport United FC	Paro FC	2023-09-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218423669	f	\N	\N	\N
4814	Crewe U21	Hull City U21	2023-09-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400380	f	\N	\N	\N
4816	KL Rovers	PDRM	2023-09-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436958	f	\N	\N	\N
4817	Gorilla FC	AS Kigali	2023-09-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406992	f	\N	\N	\N
4818	Argeș Pitești	FC Unirea Dej	2023-09-18 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218307287	f	\N	\N	\N
4822	Etihad Al Ramtha	Kaforsum	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218402793	f	\N	\N	\N
4823	Mumbai City FC	Nassaji Mazandaran F.C.	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417708	f	\N	\N	\N
4821	FK Jedinstvo Ub	FK Smederevo	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218407173	f	\N	\N	\N
4820	Dynamo Kiev	Vorskla	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218407082	f	\N	\N	\N
4819	Stromsgodset II	Ullensaker Kisa	2023-09-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218420040	f	\N	\N	\N
4825	Brann II	Ullern	2023-09-18 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218419950	f	\N	\N	\N
4824	Hebar	Pirin Blagoevgrad	2023-09-18 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217706883	f	\N	\N	\N
4826	KPV/Akatemia	SIF	2023-09-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429365	f	\N	\N	\N
4829	Atromitos	NFC Volos	2023-09-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217680236	f	\N	\N	\N
4827	Al-Jazeera	Samma	2023-09-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218375233	f	\N	\N	\N
4828	Al Buqaa	Alhashemyya	2023-09-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218403619	f	\N	\N	\N
4830	CSMS Iasi	Botosani	2023-09-18 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217712955	f	\N	\N	\N
4839	Al-Ittihad	Olmaliq	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218434141	f	\N	\N	\N
4834	Al Faisaly SC	Nasaf	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417816	f	\N	\N	\N
4832	Gornik Leczna	Resovia Rzeszow	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798603	f	\N	\N	\N
4837	Sibenik	Cibalia Vinkovci	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218254477	f	\N	\N	\N
4838	Al Quwa Al Jawiya	Sepahan	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218434231	f	\N	\N	\N
4833	Hapoel Nof Hagalil	Hapoel K Saba	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218304593	f	\N	\N	\N
4831	Jabal Al Mukaber	Al-Futowa	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218414040	f	\N	\N	\N
4840	Nancy	Dijon	2023-09-18 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218224944	f	\N	\N	\N
4841	Salernitana	Torino	2023-09-18 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217673678	f	\N	\N	\N
4842	Beitar Nahariya	Hapoel Ironi Karmiel	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218436138	f	\N	\N	\N
4846	Sakaryaspor	Bodrumspor	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218079155	f	\N	\N	\N
4850	Norrkoping	Mjallby	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217786883	f	\N	\N	\N
4849	Jonkopings Sodra	Landskrona	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217960201	f	\N	\N	\N
4852	Klaksvikar Itrottarfelag	B68 Toftir	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218406401	f	\N	\N	\N
4847	Beitar Jerusalem	Hapoel Eran Hadera	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218203129	f	\N	\N	\N
4853	Stal Mielec	Zaglebie Lubin	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217793383	f	\N	\N	\N
4843	Traeff	Valerenga II	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218420130	f	\N	\N	\N
4851	Sivasspor	Ankaragucu	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217944263	f	\N	\N	\N
4854	Fatih Karagumruk Istanbul	Hatayspor	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218113699	f	\N	\N	\N
4848	OB	Silkeborg	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217901030	f	\N	\N	\N
4844	Levski Krumovgrad	PFC Levski Sofia	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707153	f	\N	\N	\N
4845	Osters	Vasteras SK	2023-09-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217959930	f	\N	\N	\N
4855	AIK	Degerfors	2023-09-18 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217786450	f	\N	\N	\N
4856	Hapoel Beer Sheva	Hapoel Tel Aviv	2023-09-18 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218203039	f	\N	\N	\N
4864	Ipswich Town U21	Birmingham U21	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429005	f	\N	\N	\N
4859	Jong AZ Alkmaar	Jong Ajax Amsterdam	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204475	f	\N	\N	\N
4863	Al-Sadd	Al Sharjah	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417492	f	\N	\N	\N
4858	Emmen	Jong FC Utrecht	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204565	f	\N	\N	\N
4867	Uni San Martin	Deportivo Coopsol	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218394477	f	\N	\N	\N
4865	FC Groningen	Jong PSV Eindhoven	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204745	f	\N	\N	\N
4862	Nejmeh	Al Riffa	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413950	f	\N	\N	\N
4866	De Graafschap	Helmond Sport	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204835	f	\N	\N	\N
4861	FC Oss	FC Dordrecht	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204385	f	\N	\N	\N
4860	FC Eindhoven	ADO Den Haag	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218204655	f	\N	\N	\N
4813	Nakhon Pathom	Air Force Central	2023-09-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218413679	f	\N	\N	\N
4902	Persijap Jepara	Persipa Pati	2023-09-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218457006	f	\N	\N	\N
4919	Pachuca U23	Santos Laguna U23	2023-09-18 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218457555	f	\N	\N	\N
4835	Maccabi Kabilio Jaffa	Ihud Bnei Shfaram	2023-09-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218304683	f	\N	\N	\N
4868	Al-Hilal	FK Navbahor Namangan	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218417600	f	\N	\N	\N
4869	K Lierse U21	KV Oostende (Res)	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218407527	f	\N	\N	\N
4857	Ferroviaria DE U20	Red Bull Bragantino U20	2023-09-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218407617	f	\N	\N	\N
4872	Argentino de Quilmes	CA San Miguel	2023-09-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218407437	f	\N	\N	\N
4870	Leandro N Alem	Central Cordoba	2023-09-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218407347	f	\N	\N	\N
4871	CFR Cluj	ACS Petrolul 52	2023-09-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217713724	f	\N	\N	\N
4873	Sampdoria	Cittadella	2023-09-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217959745	f	\N	\N	\N
4880	Taranto Sport	ACR Messina	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244114	f	\N	\N	\N
4878	Audace Cerignola	Brindisi	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218243934	f	\N	\N	\N
4879	Nuova Monterosi	US Latina Calcio	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218244024	f	\N	\N	\N
4875	Guingamp	AC Ajaccio	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218010763	f	\N	\N	\N
4877	Crusaders	Cliftonville	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218270984	f	\N	\N	\N
4874	Nottm Forest	Burnley	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217634374	f	\N	\N	\N
4881	Verona	Bologna	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217673798	f	\N	\N	\N
4876	FC Giugliano	Juve Stabia	2023-09-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218243844	f	\N	\N	\N
4882	Andorra CF	Oviedo	2023-09-18 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218029710	f	\N	\N	\N
4884	Puerto Golfito F.C	A.D. Cofutpa	2023-09-18 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218413770	f	\N	\N	\N
4883	Granada	Girona	2023-09-18 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217661478	f	\N	\N	\N
4885	Boavista	Chaves	2023-09-18 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217912341	f	\N	\N	\N
4886	HK Kopavogur	Fram	2023-09-18 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218203219	f	\N	\N	\N
4887	Envigado	Jaguares de Cordoba	2023-09-18 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218349096	f	\N	\N	\N
4888	Union Magdalena	Once Caldas	2023-09-18 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218349542	f	\N	\N	\N
4889	HFX Wanderers	Atletico Ottawa	2023-09-18 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218199019	f	\N	\N	\N
4891	Lanus	Sarmiento de Junin	2023-09-19 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031631	f	\N	\N	\N
4890	Bahia	Santos	2023-09-19 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218081692	f	\N	\N	\N
4892	Sportivo Belgrano	Independiente Chivilcoy	2023-09-19 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218416564	f	\N	\N	\N
4893	Atletico Bucaramanga	Deportivo Pereira	2023-09-19 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218349006	f	\N	\N	\N
4895	Corinthians	Gremio	2023-09-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218084111	f	\N	\N	\N
4896	Gualaceo SC	Cumbaya FC	2023-09-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031847	f	\N	\N	\N
4894	Novorizontino	Ceara SC Fortaleza	2023-09-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218160532	f	\N	\N	\N
4897	Ferro Carril Oeste	Tristan Suarez	2023-09-19 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218455937	f	\N	\N	\N
4898	Ind Medellin	Millonarios	2023-09-19 02:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218349186	f	\N	\N	\N
4900	Pachuca	Santos Laguna	2023-09-19 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217716660	f	\N	\N	\N
4990	Bahrain U23	Thailand U23	2023-09-19 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218487393	f	\N	\N	\N
4991	Bangladesh U23	Myanmar U23	2023-09-19 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218487483	f	\N	\N	\N
4992	Shaoxing Shangyu Pterosaur	Weifang Juexiaoya	2023-09-19 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218441037	f	\N	\N	\N
4993	Vietnam U23	Mongolia U23	2023-09-19 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218370615	f	\N	\N	\N
4994	Yokohama FM	Incheon Utd	2023-09-19 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218467609	f	\N	\N	\N
4995	Busan IPark	Ansan Greeners FC	2023-09-19 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218271074	f	\N	\N	\N
4996	Ulsan Hyundai Horang-i	BG Pathumthani United	2023-09-19 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218472193	f	\N	\N	\N
4997	Leixoes U23	Famalicao U23	2023-09-19 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450314	f	\N	\N	\N
4998	Seongnam FC	Gimcheon Sangmu	2023-09-19 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218457097	f	\N	\N	\N
4999	Cheongju FC	Seoul E-Land FC	2023-09-19 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218277159	f	\N	\N	\N
5000	Hamburg II	Hannover II	2023-09-19 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369477	f	\N	\N	\N
5001	Burnley U21	Sheff Wed U21	2023-09-19 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218452350	f	\N	\N	\N
5002	Shakhtar U19	Porto U19	2023-09-19 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218479120	f	\N	\N	\N
5003	Saudi Arabia U23	Iran U23	2023-09-19 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218487703	f	\N	\N	\N
5004	Indonesia U23	Kyrgyzstan U23	2023-09-19 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218338400	f	\N	\N	\N
5005	Kaya	Shandong Taishan	2023-09-19 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218471344	f	\N	\N	\N
5006	Johor Darul Takzim	Kawasaki	2023-09-19 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218471469	f	\N	\N	\N
5007	SS Lazio U19	Atletico Madrid U19	2023-09-19 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483186	f	\N	\N	\N
5008	AC Milan U19	Newcastle United U19	2023-09-19 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218496939	f	\N	\N	\N
5009	Kuching FA	Kedah	2023-09-19 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218497119	f	\N	\N	\N
5010	Young Boys U19	RB Leipzig U19	2023-09-19 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218483891	f	\N	\N	\N
5011	Pulau Pinang	Harini FC	2023-09-19 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497209	f	\N	\N	\N
5012	Feyenoord Youth	Celtic U19	2023-09-19 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483796	f	\N	\N	\N
5014	Sheff Utd U21	Fleetwood Town U21	2023-09-19 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218484377	f	\N	\N	\N
5015	Paris St-G U19	Dortmund U19	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483284	f	\N	\N	\N
5016	Gil Vicente U23	Vizela U23	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450070	f	\N	\N	\N
5017	Barcelona U19	Royal Antwerp U19	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497029	f	\N	\N	\N
5018	Pakhtakor	Al Ain	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218471559	f	\N	\N	\N
5019	Academico de Viseu U23	Rio Ave FC U23	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218494823	f	\N	\N	\N
5020	Man City U19	FK Crvena Zvezda U19	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218481270	f	\N	\N	\N
5021	Portimonense SC U23	Santa Clara U23	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218494733	f	\N	\N	\N
5022	FCM Avantul Reghin	ACS Industria Galda	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218495325	f	\N	\N	\N
5023	Al Sareeh	Yarmouk	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483504	f	\N	\N	\N
5024	Ceahlaul	Chindia Targoviste	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217945142	f	\N	\N	\N
5025	Sporting Lisbon U23	Mafra U23	2023-09-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218450176	f	\N	\N	\N
5026	Estrela U23	GD Estoril Praia U23	2023-09-19 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218449575	f	\N	\N	\N
5027	RZ Pellets WAC (Am)	SK Vorwarts Steyr	2023-09-19 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218475272	f	\N	\N	\N
5028	Um El Quttein	Al Tora	2023-09-19 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218483594	f	\N	\N	\N
5029	Miedz II Legnica	Stal Rzeszow	2023-09-19 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218495415	f	\N	\N	\N
5030	Istiqlol	Al-Duhail SC	2023-09-19 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461639	f	\N	\N	\N
5031	Al Ahly Cairo	Al-Masry	2023-09-19 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384433	f	\N	\N	\N
5032	Ahal FC	Al-Feiha	2023-09-19 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461819	f	\N	\N	\N
5033	Fermana	Recanatese	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438673	f	\N	\N	\N
5034	Pesaro	Entella	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438403	f	\N	\N	\N
5035	Pergolettese	Triestina	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218436867	f	\N	\N	\N
5036	Arezzo	Olbia	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438583	f	\N	\N	\N
5037	Lucchese	Gubbio	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438313	f	\N	\N	\N
5038	ASD Pineto Calcio	Rimini	2023-09-19 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438493	f	\N	\N	\N
5039	Young Boys	RB Leipzig	2023-09-19 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217866491	f	\N	\N	\N
5040	AC Milan	Newcastle	2023-09-19 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217867901	f	\N	\N	\N
5107	Man City	Crvena Zvezda	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867478	f	\N	\N	\N
5041	Austria Wien (A)	SC Neusiedl am See	2023-09-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218472284	f	\N	\N	\N
5042	Mainz II	Hoffenheim II	2023-09-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218467518	f	\N	\N	\N
5043	HB Torshavn	Vikingur Gota	2023-09-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218457191	f	\N	\N	\N
5044	Augsburg II	Bayreuth	2023-09-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218466512	f	\N	\N	\N
5045	Ajax Cape Town	Golden Arrows	2023-09-19 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218391362	f	\N	\N	\N
5046	Richards Bay FC	Chippa Utd	2023-09-19 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218384883	f	\N	\N	\N
5047	Agovv Apeldoorn	OJC Rosmalen	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218484183	f	\N	\N	\N
5048	RKAV Volendam	Westlandia	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488699	f	\N	\N	\N
5049	GVVV	BVV Barendrecht	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488796	f	\N	\N	\N
5050	RKVV DEM	Sportlust 46	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488609	f	\N	\N	\N
5051	SV DVS 33 Ermelo	Ijsselmeervogels	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488420	f	\N	\N	\N
5052	VV Eemdijk	Harkemase Boys	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218484091	f	\N	\N	\N
5053	Spakenburg	V.V. Scherpenzeel	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488330	f	\N	\N	\N
5054	Sparta Nijkerk	Unitas Gorinchem	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488518	f	\N	\N	\N
5055	Norwich U21	Wolves U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218501068	f	\N	\N	\N
5056	Olde Veste 54	Noordwijk	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218497435	f	\N	\N	\N
5057	Scheveningen	Hoek	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218488238	f	\N	\N	\N
5058	Shrewsbury	Brighton U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258446	f	\N	\N	\N
5059	Al Wehdat	Al Ittihad Aleppo	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480534	f	\N	\N	\N
5060	Alianza Atletico	Binacional	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218476015	f	\N	\N	\N
5061	Charlton U21	Bournemouth U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218466115	f	\N	\N	\N
5062	Persepolis	Al Nassr	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218461729	f	\N	\N	\N
5063	Wycombe	Crystal Palace U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258266	f	\N	\N	\N
5064	Exeter	Reading	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296476	f	\N	\N	\N
5065	Oxford Utd	MK Dons	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258356	f	\N	\N	\N
5066	FC Cosmos Koblenz	FV Dudenhofen	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218457449	f	\N	\N	\N
5070	Doncaster	Everton U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258536	f	\N	\N	\N
5071	Wigan	Leicester U21	2023-09-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218258716	f	\N	\N	\N
5072	Colchester	Tottenham U21	2023-09-19 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218258807	f	\N	\N	\N
5073	Corinthian Casuals	Westfield	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218493254	f	\N	\N	\N
5074	Sittingbourne	Hythe Town	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218493344	f	\N	\N	\N
5075	Felixstowe & Walton Utd	Bowers & Pitsea	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218484469	f	\N	\N	\N
5076	Sutton Utd	Aston Villa U21	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218259417	f	\N	\N	\N
5077	Dag and Red	Bromley	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218268266	f	\N	\N	\N
5079	Chesterfield	FC Halifax Town	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218266941	f	\N	\N	\N
5080	Solihull Moors	AFC Fylde	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218266670	f	\N	\N	\N
5081	Dorking Wanderers	Wealdstone	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267122	f	\N	\N	\N
5082	Southampton	Ipswich	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884305	f	\N	\N	\N
5085	Altrincham	Hartlepool	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267031	f	\N	\N	\N
5086	Gateshead	Kidderminster	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267392	f	\N	\N	\N
5087	Cesena	Ancona	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218438896	f	\N	\N	\N
5088	Preston	Birmingham	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884629	f	\N	\N	\N
5089	Woking	Ebbsfleet Utd	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218266580	f	\N	\N	\N
5090	Juventus B	Spal	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218438986	f	\N	\N	\N
5091	Cardiff	Coventry	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217883977	f	\N	\N	\N
5092	Bristol Rovers	West Ham U21	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218296566	f	\N	\N	\N
5093	Boreham Wood	Rochdale	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267483	f	\N	\N	\N
5094	Port Vale	Burton Albion	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218258143	f	\N	\N	\N
5095	QPR	Swansea	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884089	f	\N	\N	\N
5096	Eastleigh	Oxford City	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218267212	f	\N	\N	\N
5097	Perugia	Pontedera	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218438806	f	\N	\N	\N
5098	USD Sestri Levante 1919	Pescara	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218474614	f	\N	\N	\N
5083	Barnsley	Portsmouth	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218303681	f	\N	\N	\N
5084	Peterborough	Cheltenham	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218303591	f	\N	\N	\N
5078	Barnet	Aldershot	2023-09-19 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218266851	f	\N	\N	\N
5102	Lazio	Atletico Madrid	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867055	f	\N	\N	\N
5103	Shakhtar	Porto	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866068	f	\N	\N	\N
5104	Feyenoord	Celtic	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867619	f	\N	\N	\N
5105	Sheff Wed	Middlesbrough	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217884737	f	\N	\N	\N
5106	Boyaca Patriotas	Orsomarso	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270614	f	\N	\N	\N
5108	Paris St-G	Dortmund	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217868042	f	\N	\N	\N
5109	Barcelona	Antwerp	2023-09-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866773	f	\N	\N	\N
5110	AD Cantolao	Melgar	2023-09-19 21:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218476105	f	\N	\N	\N
5111	Nacional (Par)	Sportivo Luqueno	2023-09-19 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218493678	f	\N	\N	\N
5112	AD Guanacasteca	LD Alajuelense	2023-09-19 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218455682	f	\N	\N	\N
5113	Quindio	Llaneros FC	2023-09-19 22:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218346827	f	\N	\N	\N
5114	Central Cordoba (SdE)	Boca Juniors	2023-09-19 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218029439	f	\N	\N	\N
5115	Corinthians U20	Fluminense U20	2023-09-19 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218475925	f	\N	\N	\N
5116	Celaya	Mineros de Zacatecas	2023-09-20 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218402088	f	\N	\N	\N
5117	Barranquilla	Atletico FC Cali	2023-09-20 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218346917	f	\N	\N	\N
5118	Tacuary	Sportivo Trinidense	2023-09-20 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218493588	f	\N	\N	\N
5119	CD America de Quito	Manta FC	2023-09-20 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480894	f	\N	\N	\N
5120	Rosario Central	CA Independiente	2023-09-20 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031451	f	\N	\N	\N
5121	Huracan	Gimnasia La Plata	2023-09-20 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218029890	f	\N	\N	\N
5122	America MG	Bragantino SP	2023-09-20 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218080222	f	\N	\N	\N
5123	Sampaio Correa FC	Vila Nova	2023-09-20 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218218853	f	\N	\N	\N
5124	Cancun FC	Cimarrones de Sonora	2023-09-20 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218491480	f	\N	\N	\N
5125	La Equidad	Deportivo Cali	2023-09-20 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218370500	f	\N	\N	\N
5126	Deportivo Saprissa	Santos de Guapiles	2023-09-20 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400470	f	\N	\N	\N
5127	Alebrijes de Oaxaca	Club Atletico La Paz	2023-09-20 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218403709	f	\N	\N	\N
5128	Stallion Penson FC	Bali Utd Pusam	2023-09-20 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505684	f	\N	\N	\N
5129	Selangor II	Terengganu FC 2	2023-09-20 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218509102	f	\N	\N	\N
5130	Galatasaray U19	FC Copenhagen U19	2023-09-20 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218514548	f	\N	\N	\N
5131	Melbourne City	Kofu	2023-09-20 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504505	f	\N	\N	\N
5132	Buriram Utd	Zhejiang Greentown	2023-09-20 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504006	f	\N	\N	\N
5133	Jeonbuk Motors	Kitchee SC	2023-09-20 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503826	f	\N	\N	\N
5134	FC Anyang	Gyeongnam	2023-09-20 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218277069	f	\N	\N	\N
5135	Chungnam Asan	Jeonnam Dragons	2023-09-20 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218408150	f	\N	\N	\N
5136	Cheonan City	Bucheon FC 1995	2023-09-20 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218415822	f	\N	\N	\N
5137	Japan U23	Qatar U23	2023-09-20 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218487827	f	\N	\N	\N
5138	Home Utd	Bangkok Utd	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504096	f	\N	\N	\N
5139	Real Madrid U19	1. FC Union Berlin U19	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218524113	f	\N	\N	\N
5140	Arsenal U19	PSV Eindhoven U19	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527342	f	\N	\N	\N
5141	Wuhan Three Towns	Urawa	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504398	f	\N	\N	\N
5142	Ha Noi T and T	Pohang Steelers	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503916	f	\N	\N	\N
5143	Terengganu	Central Coast Mariners	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505774	f	\N	\N	\N
5144	Sevilla U19	RC Lens U19	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218524293	f	\N	\N	\N
5145	SL Benfica Lisbon U19	Red Bull Salzburg U19	2023-09-20 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218513950	f	\N	\N	\N
5146	Sloga Doboj	Zeljeznicar	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218517821	f	\N	\N	\N
5147	Sporting de Braga U19	Napoli U19	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218524203	f	\N	\N	\N
5148	El Daklyeh	ENPPI	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218384523	f	\N	\N	\N
5149	Nkana	MUZA FC	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218501158	f	\N	\N	\N
5150	Zaglebie Lubin II	Kotwica Kolobrzeg	2023-09-20 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500978	f	\N	\N	\N
5151	Moslavina Kutina	Slaven Belupo	2023-09-20 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218523285	f	\N	\N	\N
5152	TJ Sokol Medzibrod	Rimavska Sobota	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218525752	f	\N	\N	\N
5153	Dravinja Kostroj	Tabor Sezana	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502568	f	\N	\N	\N
5154	TJ Slovan Velvary	FC Sellier & Bellot Vlasim	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520174	f	\N	\N	\N
5155	Ilirija Extra-Lux	Gorica	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502838	f	\N	\N	\N
5156	NK Slovenska Bistrica	NK Fuzinar	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502748	f	\N	\N	\N
5157	Bayern Munich U19	Man Utd U19	2023-09-20 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218514458	f	\N	\N	\N
5158	Lille	Olimpija	2023-09-20 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217930996	f	\N	\N	\N
5159	TSV Schwaben Augsburg	TSV Landsberg	2023-09-20 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500598	f	\N	\N	\N
5160	Isa Town FC	Malkiya	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503338	f	\N	\N	\N
5161	Etihad Al Reef	Qalali	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503248	f	\N	\N	\N
5162	Tallinna JK Legion	Tammeka Tartu	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218518001	f	\N	\N	\N
5163	Young Africans	Namungo FC	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503671	f	\N	\N	\N
5164	Smouha	El Gounah	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218518091	f	\N	\N	\N
5165	Olimpia Elblag	Pogon Siedlce	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503581	f	\N	\N	\N
5166	Dila Gori	Dinamo Batumi	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503158	f	\N	\N	\N
5167	Krka	NK Primorje	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502968	f	\N	\N	\N
5168	Union de Touarga	RSB Berkane	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218503429	f	\N	\N	\N
5169	Al Mokawloon	Baladeyet Al-Mahalla	2023-09-20 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218518181	f	\N	\N	\N
5170	KA Akureyri	Keflavik	2023-09-20 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218268356	f	\N	\N	\N
5171	Lumezzane	Fiorenzuola	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438043	f	\N	\N	\N
5172	Arzignanochiampo	Alessandria	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438133	f	\N	\N	\N
5173	Guadalajara	SS Reyes	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218532054	f	\N	\N	\N
5174	Leiknir R	Afturelding	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218505504	f	\N	\N	\N
5175	Pro Vercelli	SSD Pro Sesto	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218437773	f	\N	\N	\N
5176	Albinoleffe	Aurora Pro Patria 1919	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218474802	f	\N	\N	\N
5177	Sassari Torres	Carrarese	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218480984	f	\N	\N	\N
5178	A.C. Trento S.C.S.D.	FC Legnago	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218438223	f	\N	\N	\N
5179	IF Vestri	Fjolnir	2023-09-20 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218505594	f	\N	\N	\N
5180	Galatasaray	FC Copenhagen	2023-09-20 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217865927	f	\N	\N	\N
5181	Real Madrid	Union Berlin	2023-09-20 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217867337	f	\N	\N	\N
5182	Union Gurten	SPG Lask Amateure	2023-09-20 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515423	f	\N	\N	\N
5183	Reutlingen	FV Ravensburg	2023-09-20 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505875	f	\N	\N	\N
5184	SV Donaustrauf	DJK Ammerthal	2023-09-20 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500688	f	\N	\N	\N
5185	TS Galaxy FC	Cape Town CIty F.C.	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218437049	f	\N	\N	\N
5186	Supersport Utd	Kaizer Chiefs	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218385063	f	\N	\N	\N
5187	Orlando Pirates (SA)	Mamelodi Sundowns	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218437139	f	\N	\N	\N
5188	SW Rehden	Atlas Delmenhorst	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218500058	f	\N	\N	\N
5189	Waldalgesheim	SV Auersmacher	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218500508	f	\N	\N	\N
5190	TuS Mechtersheim	Arminia Ludwigshafen	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218500148	f	\N	\N	\N
5191	FC Kaiserslautern II	Eintracht Trier	2023-09-20 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218500418	f	\N	\N	\N
5192	Hoogeveen	Staphorst	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515918	f	\N	\N	\N
5193	RKSV Nuenen	Excelsior Maassluis	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520444	f	\N	\N	\N
5194	Ado '20	Quick Boys	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515828	f	\N	\N	\N
5195	Kloetinge	Koninklijke HFC	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515738	f	\N	\N	\N
5196	FC Lisse	Blauw Geel 38	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218516009	f	\N	\N	\N
5197	SV TEC Tiel	SV Meerssen	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218516099	f	\N	\N	\N
5198	ACV Assen	USV Hercules	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218515648	f	\N	\N	\N
5199	Groene Ster	Kozakken Boys	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218516279	f	\N	\N	\N
5200	IA/Kari U19	Fylkir/Ellidi U19	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218509346	f	\N	\N	\N
5201	VVSB	UNA Veldhoven	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218516189	f	\N	\N	\N
5202	Spvgg Quierschied	FC Karbach	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500328	f	\N	\N	\N
5203	SV Morlautern	FC Bitburg	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218500238	f	\N	\N	\N
5204	Achuapa FC	Antigua GFC	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218507287	f	\N	\N	\N
5205	FC Luzern II	Rapperswil-Jona	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218507197	f	\N	\N	\N
5206	Union Comercio	Carlos Mannucci	2023-09-20 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480354	f	\N	\N	\N
5207	FAR Rabat	Club R Zemamra	2023-09-20 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218509193	f	\N	\N	\N
5208	Almagro BA	San Martin de San Juan	2023-09-20 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218049453	f	\N	\N	\N
5209	New Salamis FC UK	Waltham Forest	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218517911	f	\N	\N	\N
5211	SS Virtus Verona 1921	LR Vicenza Virtus	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218474708	f	\N	\N	\N
5212	Padova	Novara	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218437953	f	\N	\N	\N
5213	Blackburn	Sunderland	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884413	f	\N	\N	\N
5214	Giana Erminio	Mantova	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218437863	f	\N	\N	\N
5215	Huddersfield	Stoke	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217883745	f	\N	\N	\N
5216	Renate	Atalanta B	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218493498	f	\N	\N	\N
5217	Watford	West Brom	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884521	f	\N	\N	\N
5218	Millwall	Rotherham	2023-09-20 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217883637	f	\N	\N	\N
5219	Norwich	Leicester	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217883529	f	\N	\N	\N
5220	Barracas Central	Banfield	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218029349	f	\N	\N	\N
5221	Arsenal	PSV	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866209	f	\N	\N	\N
5222	Real Sociedad	Inter	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866632	f	\N	\N	\N
5223	Benfica	Red Bull Salzburg	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866914	f	\N	\N	\N
5224	Braga	Napoli	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217866350	f	\N	\N	\N
5225	Defensa y Justicia	Tigre	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218031541	f	\N	\N	\N
5226	Bayern Munich	Man Utd	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867196	f	\N	\N	\N
5227	Sevilla	Lens	2023-09-20 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217867760	f	\N	\N	\N
5228	Vikingur Reykjavik	KR Reykjavik	2023-09-20 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218275901	f	\N	\N	\N
5229	Club Nueve de Octubre	Cuniburo FC	2023-09-20 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218509005	f	\N	\N	\N
5230	Chacaritas SC	Imbabura Sporting Club	2023-09-20 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218508915	f	\N	\N	\N
5231	Boca Juniors de Cali	Cucuta Deportivo	2023-09-20 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218394657	f	\N	\N	\N
5232	UTC Cajamarca	Deportivo Municipal	2023-09-20 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218480714	f	\N	\N	\N
5233	Fortaleza FC	Real Cartagena	2023-09-20 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218394567	f	\N	\N	\N
5234	Real Santander	Tigres FC Zipaquira	2023-09-20 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218394747	f	\N	\N	\N
5235	Cortulua	Leones FC	2023-09-20 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218396844	f	\N	\N	\N
5236	Boyaca Chico	Junior FC Barranquilla	2023-09-20 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218494643	f	\N	\N	\N
5237	Velez Sarsfield	Arsenal De Sarandi	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218031181	f	\N	\N	\N
5238	Fuerte San Francisco	CD Dragon	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218510601	f	\N	\N	\N
5239	Platense Zacatecoluca	Santa Tecla	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218510511	f	\N	\N	\N
5240	Estudiantes	San Lorenzo	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218031361	f	\N	\N	\N
5241	Once Municipal	CD Luis Angel Firpo	2023-09-20 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218510421	f	\N	\N	\N
5242	Goias	Flamengo	2023-09-20 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218081212	f	\N	\N	\N
5243	Tlaxcala F.C	Club Atletico Morelia	2023-09-21 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218451380	f	\N	\N	\N
5260	Fluminense	Cruzeiro MG	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218081572	f	\N	\N	\N
5261	Guastatoya	CSD Municipal	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218524023	f	\N	\N	\N
5264	Sao Paulo	Fortaleza EC	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218081332	f	\N	\N	\N
5265	CD Municipal Limeno	Cd Fas	2023-09-21 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539766	f	\N	\N	\N
5266	Correcaminos Uat	Universidad Guadalajara	2023-09-21 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218318493	f	\N	\N	\N
5267	Atletico Nacional Medellin	Santa Fe	2023-09-21 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218506595	f	\N	\N	\N
5268	Universitario de Deportes	Sport Boys (Per)	2023-09-21 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218480236	f	\N	\N	\N
5269	Colorado	Seattle Sounders	2023-09-21 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293691	f	\N	\N	\N
5271	AD Isidro Metapan	Jocoro	2023-09-21 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218525842	f	\N	\N	\N
5272	CD Aguila	Alianza FC (SLV)	2023-09-21 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527563	f	\N	\N	\N
5273	Real Espana	Olancho	2023-09-21 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218538822	f	\N	\N	\N
5326	Rangers	Betis	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217881954	f	\N	\N	\N
5274	CS Cartagines	Municipal Perez Zeledon	2023-09-21 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502168	f	\N	\N	\N
5275	Queretaro	CF America	2023-09-21 03:06:00	https://www.orbitxch.com/customer/sport/1/market/1.217987504	f	\N	\N	\N
5276	AD San Carlos	AD Municipal Liberia	2023-09-21 03:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218536986	f	\N	\N	\N
5278	Comunicaciones	Xelaju	2023-09-21 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218527473	f	\N	\N	\N
5246	Columbus	Chicago Fire	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285299	f	\N	\N	\N
5247	CF Montreal	FC Cincinnati	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285389	f	\N	\N	\N
5248	Inter Miami CF	Toronto FC	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285200	f	\N	\N	\N
5249	Charlotte FC	Philadelphia	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218285479	f	\N	\N	\N
5251	New York Red Bulls	Austin FC	2023-09-21 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293258	f	\N	\N	\N
5259	Houston Dynamo	Vancouver Whitecaps	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293474	f	\N	\N	\N
5262	Kansas City	Nashville SC	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293366	f	\N	\N	\N
5263	St Louis City SC	Los Angeles FC	2023-09-21 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218279850	f	\N	\N	\N
5270	Real Salt Lake	FC Dallas	2023-09-21 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293583	f	\N	\N	\N
5277	Portland Timbers	San Jose Earthquakes	2023-09-21 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293908	f	\N	\N	\N
5279	LA Galaxy	Minnesota Utd	2023-09-21 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218293800	f	\N	\N	\N
5287	Union St Gilloise	Toulouse	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217882440	f	\N	\N	\N
5286	Fenerbahce	FC Nordsjaelland	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930451	f	\N	\N	\N
5283	HJK Helsinki	PAOK	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930559	f	\N	\N	\N
5285	Sheriff Tiraspol	Roma	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217881056	f	\N	\N	\N
5288	Legia Warsaw	Aston Villa	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930125	f	\N	\N	\N
5284	Genk	Fiorentina	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217950103	f	\N	\N	\N
5280	Ferencvaros	Cukaricki	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930777	f	\N	\N	\N
5289	Zrinjski	Az Alkmaar	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217933067	f	\N	\N	\N
5281	Qarabag Fk	Molde	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217883355	f	\N	\N	\N
5290	Rennes	Maccabi Haifa	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217882200	f	\N	\N	\N
5282	Panathinaikos	Villarreal	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217884791	f	\N	\N	\N
5304	Throttur Reykjavik/SR U19	HK/YMIR U19	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218553417	f	\N	\N	\N
5293	Hapoel Herzliya	Maccabi Ashdod B.C.	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218553147	f	\N	\N	\N
5294	Ludogorets	Spartak Trnava	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217891698	f	\N	\N	\N
5295	Leverkusen	Hacken	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217880936	f	\N	\N	\N
5296	Servette	Slavia Prague	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217881176	f	\N	\N	\N
5291	Eintracht Frankfurt	Aberdeen	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217930887	f	\N	\N	\N
5302	Sport Huancayo	Deportivo Garcilaso	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480146	f	\N	\N	\N
5303	Al-Ittihad	Al-Fateh (KSA)	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218317602	f	\N	\N	\N
5300	Bahia EC U20	CSA U20	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218566258	f	\N	\N	\N
5308	Rudar	NK Brinje Grosuplje	2023-09-21 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218555843	f	\N	\N	\N
5310	Juve Stabia	Potenza	2023-09-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218501988	f	\N	\N	\N
5307	Shimshon Tel Aviv	Hapoel Tzafririm Holon	2023-09-21 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218576259	f	\N	\N	\N
5301	Al-Shabab (KSA)	Al-Hazm (KSA)	2023-09-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218317692	f	\N	\N	\N
5312	Monopoli	Catania	2023-09-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218502078	f	\N	\N	\N
5306	KFUM U19	Nordstrand U19	2023-09-21 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218566709	f	\N	\N	\N
5317	Lugano	Bodo Glimt	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217930342	f	\N	\N	\N
5309	Crotone	Audace Cerignola	2023-09-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218474898	f	\N	\N	\N
5311	AZ Picerno ASD	FC Giugliano	2023-09-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218475091	f	\N	\N	\N
5319	Sturm Graz	Sporting Lisbon	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217883115	f	\N	\N	\N
5313	Bogota	Real Soacha Cundinamarca FC	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218396934	f	\N	\N	\N
5324	Maccabi Tel Aviv	Breidablik	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217930668	f	\N	\N	\N
5321	West Ham	FK Backa Topola	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217882560	f	\N	\N	\N
5315	Club Brugge	Besiktas	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217969602	f	\N	\N	\N
5318	Wydad Casablanca	CC Riadi Salmi	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218553327	f	\N	\N	\N
5331	Comerciantes FC	Alianza Universidad	2023-09-21 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218546505	f	\N	\N	\N
5330	Cruzeiro U20	Sampaio Correa U20	2023-09-21 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218566348	f	\N	\N	\N
5316	Slovan Bratislava	Klaksvikar Itrottarfelag	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217891590	f	\N	\N	\N
5320	Zorya	Gent	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217949995	f	\N	\N	\N
5333	Cusco FC	Atletico Grau	2023-09-21 21:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218480804	f	\N	\N	\N
5323	Ajax	Marseille	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217883235	f	\N	\N	\N
5314	Plzen	KF Ballkani	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217891482	f	\N	\N	\N
5332	Belgrano	CA Platense	2023-09-21 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138787	f	\N	\N	\N
5327	Olympiakos	Freiburg	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217882680	f	\N	\N	\N
5322	Dinamo Zagreb	FC Astana	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217930234	f	\N	\N	\N
5329	Sparta Prague	Aris FC Limassol	2023-09-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217882862	f	\N	\N	\N
5336	Vasco Da Gama	Coritiba	2023-09-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218086654	f	\N	\N	\N
5337	Argentinos Juniors	Talleres	2023-09-21 23:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218208471	f	\N	\N	\N
5335	Union Santa Fe	Godoy Cruz	2023-09-21 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218208561	f	\N	\N	\N
5338	Athletico-PR	Internacional	2023-09-21 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218080972	f	\N	\N	\N
5341	Atletico Bucaramanga	Deportivo Pasto	2023-09-22 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218512122	f	\N	\N	\N
5342	USA (W)	South Africa (W)	2023-09-22 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218596022	f	\N	\N	\N
5343	Lobos UPNFM	CD Marathon	2023-09-22 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218563750	f	\N	\N	\N
5346	Gremio	SE Palmeiras	2023-09-22 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218081812	f	\N	\N	\N
5345	River Plate	Atl Tucuman	2023-09-22 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218211629	f	\N	\N	\N
5344	CD Vargas Torres	Macara	2023-09-22 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564261	f	\N	\N	\N
5348	Universidad Cesar Vallejo	Sporting Cristal	2023-09-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218480444	f	\N	\N	\N
5347	CD Real Sociedad	Vida	2023-09-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218563570	f	\N	\N	\N
5349	Millonarios	Atletico Huila	2023-09-22 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218515328	f	\N	\N	\N
5334	Deportivo Pereira	Union Magdalena	2023-09-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218512212	f	\N	\N	\N
5292	LASK Linz	Liverpool	2023-09-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217882320	f	\N	\N	\N
5305	Fredrikstad U19	Kongsvinger U19	2023-09-21 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218566619	f	\N	\N	\N
5297	Hermannstadt	FCSB	2023-09-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218439415	f	\N	\N	\N
5298	Al Aqaba	Al Hussein	2023-09-21 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218553237	f	\N	\N	\N
5680	Shimshon Kfar Qasem	Maccabi Shaaraim	2023-09-22 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585356	f	\N	\N	\N
5681	Project Veng FC	Venghnuai	2023-09-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218602943	f	\N	\N	\N
5682	Hapoel Kiryat Ono	Sporting Tel Aviv	2023-09-22 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218614352	f	\N	\N	\N
5683	Farense U23	Santa Clara U23	2023-09-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218605163	f	\N	\N	\N
5684	Changwon City	Siheung Citizen	2023-09-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218550443	f	\N	\N	\N
5685	Elimai FC	Khan Tengry	2023-09-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630427	f	\N	\N	\N
5686	Hapoel Tirat HaCarmel	Hapoel Qalansawe	2023-09-22 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218614442	f	\N	\N	\N
5687	Ironi Beit Dagan	Tzeirey Tira FC	2023-09-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614622	f	\N	\N	\N
5688	Sderot FC	FC Shikhun HaMizrah	2023-09-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614532	f	\N	\N	\N
5689	FC Astana U21	FK Akzhajik	2023-09-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630247	f	\N	\N	\N
5690	MS Bnei Jaffa Ortodoxim	HaMakhtesh Givatayim	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614712	f	\N	\N	\N
5691	Ahi Acre	Hapoel Ironi Karmiel	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218614802	f	\N	\N	\N
5692	Qatar U23	Palestine U23	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218556747	f	\N	\N	\N
5693	Japan (W)	Bangladesh (W)	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218630607	f	\N	\N	\N
5694	Hong Kong U23	Uzbekistan U23	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218546325	f	\N	\N	\N
5695	MSK Kiryat Yam	Ironi Nesher	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218589520	f	\N	\N	\N
5696	Hapoel Bueine	Hapoel Bnei Zalafa	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218585176	f	\N	\N	\N
5697	Hapoel Kaukab	Hapoel Migdal HaEmek	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218585266	f	\N	\N	\N
5698	Ironi Baka El Garbiya	Maccabi Nujeidat Ahmad	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218589430	f	\N	\N	\N
5699	Maccabi Kiryat Malakhi	Hapoel Kfar Shelem	2023-09-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218607965	f	\N	\N	\N
5700	Changchun Yatai	Beijing Guoan	2023-09-22 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218337688	f	\N	\N	\N
5701	Shanghai Shenhua	Cangzhou Mighty Lions	2023-09-22 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218370466	f	\N	\N	\N
5702	Hapoel Raanana	MS Tira	2023-09-22 12:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218589610	f	\N	\N	\N
5703	Ironi Bnei Kabul	Maccabi Bnei Abu Snan	2023-09-22 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218614892	f	\N	\N	\N
5704	Hapoel Marmorek	AS Nordia Jerusalem	2023-09-22 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218589880	f	\N	\N	\N
5705	Tzeirey Umm al-Fahm	Maccabi Tzur Shalom	2023-09-22 12:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218589752	f	\N	\N	\N
5706	Maccabi Neve Shaanan Eldad	Ihud Bnei Baqa	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218614982	f	\N	\N	\N
5707	Thimphu City	Ugyen Academy	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595258	f	\N	\N	\N
5708	Maccabi Ahi Iksal	Hapoel Bnei Fureidis FC	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218615072	f	\N	\N	\N
5709	Botev Vratsa	Beroe Stara Za	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032117	f	\N	\N	\N
5710	Trat	Port FC	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569596	f	\N	\N	\N
5711	Psis Semarang	PS Barito Putera	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218584666	f	\N	\N	\N
5712	Persita Tangerang	Dewa United FC	2023-09-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218584756	f	\N	\N	\N
5713	Hapoel Azor	Hapoel Hod HaSharon	2023-09-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218615162	f	\N	\N	\N
5714	KF Tirana	KF Erzeni	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585639	f	\N	\N	\N
5715	Uganda Revenue Authority	Gadafi FC	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218603937	f	\N	\N	\N
5716	Peterborough United U21	Birmingham U21	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590930	f	\N	\N	\N
5717	CSC 1599 Selimbar	Gloria Buzau	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218539946	f	\N	\N	\N
5718	Airtel Kitara FC	Updf FC	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218604494	f	\N	\N	\N
5719	NEC FC	Busoga United	2023-09-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218630824	f	\N	\N	\N
5720	ACS Viitorul Cluj	CF Metalurgistul Cugir	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218619033	f	\N	\N	\N
5721	KP Legia Warsaw II	Unia Skierniewice	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218616970	f	\N	\N	\N
5722	CSM Deva	ACS Viitorul Simian	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618550	f	\N	\N	\N
5723	ACS Tg. Mures 1898	FCM Avantul Reghin	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618640	f	\N	\N	\N
5724	Ghiroda si Giarmata Vii	CS Uni Craiova II	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618460	f	\N	\N	\N
5725	ACS Inainte Modelu	Agricola Borcea	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618280	f	\N	\N	\N
5726	Garbarnia	Karpaty Krosno	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218616880	f	\N	\N	\N
5727	NK Dugopolje	NK Solin	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218569686	f	\N	\N	\N
5728	Gilortul Targu Carbunesti	Jiul Petrosani	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618940	f	\N	\N	\N
5729	FK Nevezis	BFA Vilnius	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590210	f	\N	\N	\N
5730	CS Avantul Periam	Politehnica Timisoara	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618370	f	\N	\N	\N
5731	Indija	OFK Beograd	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591020	f	\N	\N	\N
5732	Csm Focsani	ACS Unirea Branistea	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618730	f	\N	\N	\N
5733	Dunarea Calarasi	CS Axiopolis Cernavoda	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218618820	f	\N	\N	\N
5734	Radnik Surdulica	Radnicki Nis	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575381	f	\N	\N	\N
5821	KAC 1909	Kottmannsdorf	2023-09-22 18:09:00	https://www.orbitxch.com/customer/sport/1/market/1.218590300	f	\N	\N	\N
5735	Paide Linnameeskond II	Nomme Utd	2023-09-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590750	f	\N	\N	\N
5737	SK Kvítkovice	Unicov	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218595168	f	\N	\N	\N
5738	CSKA 1948 Sofia	Cherno More	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218032495	f	\N	\N	\N
5739	MAS Taborsko	Pribram	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218340549	f	\N	\N	\N
5740	Hyderabad FC	FC Goa	2023-09-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218340458	f	\N	\N	\N
5741	Tzeirey Tamra	Maccabi Ahva Shaab	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218615469	f	\N	\N	\N
5742	Honka	VPS	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218431194	f	\N	\N	\N
5743	Unia Swarzedz	Gedania Gdansk	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218617302	f	\N	\N	\N
5745	KTP	Ilves	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218342717	f	\N	\N	\N
5746	CS Constantine	MC Alger	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585729	f	\N	\N	\N
5747	ES Ben Aknoun	ASO Chlef	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585925	f	\N	\N	\N
5748	Al Riyadh SC	Al-Feiha	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520821	f	\N	\N	\N
5749	Al-Akhdoud	Al-Khaleej Saihat	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218388228	f	\N	\N	\N
5750	Lahti	AC Oulu	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218226725	f	\N	\N	\N
5751	FC U Craiova 1948	Otelul Galati	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218257624	f	\N	\N	\N
5752	FK Kolin	FK Prepere	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590660	f	\N	\N	\N
5753	Wisla Pulawy	KKS Lech Poznan II	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591110	f	\N	\N	\N
5754	FK Dainava Alytus	Riteriai	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527744	f	\N	\N	\N
5755	ES Setif U21	MC El Bayadh U21	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218545442	f	\N	\N	\N
5756	MC Oran U21	JS Saoura U21	2023-09-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590570	f	\N	\N	\N
5757	Domzale	NK Aluminij	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218344390	f	\N	\N	\N
5758	SJK 2	TPS	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218429905	f	\N	\N	\N
5759	HIFK	Gnistan	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218435699	f	\N	\N	\N
5760	Moghayer Al Sarhan	Al-Jalil	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218591200	f	\N	\N	\N
5761	FC Kosice	Trencin	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218142209	f	\N	\N	\N
5762	IFK Mariehamn	Haka	2023-09-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218226834	f	\N	\N	\N
5763	SV Gerasdorf Stammersdorf	Red Star Penzing	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608935	f	\N	\N	\N
5771	Al Hidd	Al-Muharraq	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591800	f	\N	\N	\N
5764	Kraig	St Jakob Ros	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590390	f	\N	\N	\N
5773	Al-Shabbab (BRN)	Manama Club	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591890	f	\N	\N	\N
5769	Dinamo Tirana	Partizani Tirana	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585549	f	\N	\N	\N
5775	Oleksandria	Chernomorets Odesa	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218386562	f	\N	\N	\N
5768	Korona Kielce	Widzew Lodz	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303117	f	\N	\N	\N
5770	Podbeskidzie B-B	Gornik Leczna	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400753	f	\N	\N	\N
5772	PPJ	PKK-U	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591670	f	\N	\N	\N
5767	Usti Nad Labem	FK Teplice B	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592175	f	\N	\N	\N
5765	Osijek	Varazdin	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218343935	f	\N	\N	\N
5774	Miedz Legnica	Odra Opole	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218400903	f	\N	\N	\N
5766	SK Hranice	Csk Uhersky Brod	2023-09-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218592085	f	\N	\N	\N
5777	SKU Amstetten	SV Lafnitz	2023-09-22 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218341505	f	\N	\N	\N
5778	SV Stripfing/Weiden	Ksv 1919	2023-09-22 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218341454	f	\N	\N	\N
5779	DSV Leoben	Floridsdorfer Ac	2023-09-22 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218341364	f	\N	\N	\N
5784	Wurzburger Kickers	Burghausen	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218555026	f	\N	\N	\N
5782	FC Magdeburg	Paderborn	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217942908	f	\N	\N	\N
5780	SV Schwechat	Slovan Hutteldorfer AC	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218609025	f	\N	\N	\N
5781	VFL Osnabruck	Hamburger SV	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217942800	f	\N	\N	\N
5783	Salernitana	Frosinone	2023-09-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218025035	f	\N	\N	\N
5785	Tallinna FC Flora	Tallinna Kalev	2023-09-22 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218429275	f	\N	\N	\N
5786	SC Kalsdorf	FSC Eggendorf Hartberg II	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218609317	f	\N	\N	\N
5790	Salzburger AK 1914	SK Adnet	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218609411	f	\N	\N	\N
5789	Stade Briochin	Beauvais	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595667	f	\N	\N	\N
5788	Kematen	SV Worgl	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218609116	f	\N	\N	\N
5794	IK Brage	Orebro	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314868	f	\N	\N	\N
5787	SC Furstenfeld	SV Wildon	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218609214	f	\N	\N	\N
5791	Helsingborgs	AFC Eskilstuna	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218314958	f	\N	\N	\N
5811	Bayern Munich II	Illertissen	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218555663	f	\N	\N	\N
5810	ASV Drassburg	Kremser SC	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595438	f	\N	\N	\N
5800	Babelsberg	FSV 63 Luckenwalde	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559681	f	\N	\N	\N
5817	Homburg	FC Astoria Walldorf	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564713	f	\N	\N	\N
5812	Sirens FC	Mosta	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529687	f	\N	\N	\N
5801	SV Meppen	TuS BW Lohne	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559967	f	\N	\N	\N
5816	Gaziantep FK	Istanbulspor	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218189424	f	\N	\N	\N
5806	1. CfR Pforzheim	FSV 08 Bissingen	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585446	f	\N	\N	\N
5813	Roskilde	HIK Hellerup	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218596547	f	\N	\N	\N
5798	Boluspor	Tuzlaspor	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218429815	f	\N	\N	\N
5814	Kolubara Lazarevac	RFK Novi Sad	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218594458	f	\N	\N	\N
5808	Botev Plovdiv	CSKA Sofia	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032297	f	\N	\N	\N
5818	SV Steinbach	TSV Lehnerz	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565790	f	\N	\N	\N
5819	TSG Balingen	SGV Freiberg	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218565880	f	\N	\N	\N
5795	IFK Hassleholm	IFK Malmo	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218596762	f	\N	\N	\N
5815	Oddevold	Ljungskile	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218364967	f	\N	\N	\N
5809	Atlantis FC/Akatemia	FC Kiffen	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218591490	f	\N	\N	\N
5796	CD Avance Ezcabarte	UCD Burlades	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218619123	f	\N	\N	\N
5820	Kickers Offenbach	Stuttgart II	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218564579	f	\N	\N	\N
5803	Eyupspor	Umraniyespor	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218494913	f	\N	\N	\N
5822	Parndorf	SC Ritzing	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218609624	f	\N	\N	\N
5841	TUS Bovinghausen 04	SpVgg Erkenschwick	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218586832	f	\N	\N	\N
5846	Al Ahli Amman	Al Faisaly SC	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218603159	f	\N	\N	\N
5840	TuRa Harksheide	SC Victoria Hamburg	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218590120	f	\N	\N	\N
5824	Mgladbach II	SC Paderborn 07 II	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218565169	f	\N	\N	\N
5829	FC Wil	Neuchatel Xamax	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218200978	f	\N	\N	\N
5842	AS Eupen (Res)	RWD Molenbeek U21	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218594988	f	\N	\N	\N
5825	Dijon	Cholet SO	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347234	f	\N	\N	\N
5831	Marignane-Gignac	Niort	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347144	f	\N	\N	\N
5833	Pena Sport	SD Lagunak	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218619213	f	\N	\N	\N
5845	Orleans	Chateauroux	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218349722	f	\N	\N	\N
5843	GOAL FC	Le Mans	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218561922	f	\N	\N	\N
5830	Karlskrona	Kristianstads	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218524707	f	\N	\N	\N
5847	Ratingen 04/19	TSV Meerbusch	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218586919	f	\N	\N	\N
5844	Wuppertaler	SC Wiedenbruck	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218565079	f	\N	\N	\N
5838	FSV Zwickau	Chemie Leipzig	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218559779	f	\N	\N	\N
5832	Schaffhausen	Sion	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218142389	f	\N	\N	\N
5848	Vatanspor	Blumenthaler	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218586742	f	\N	\N	\N
5828	Bellinzona	FC Vaduz	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218142299	f	\N	\N	\N
5836	Vanersborgs IF	Ahlafors IF	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218367825	f	\N	\N	\N
5827	Red Star	Avranches	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218347324	f	\N	\N	\N
5835	KMSK Deinze U21	Lommel SK U21	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218594805	f	\N	\N	\N
5839	KV Oostende (Res)	FCV Dender EH U21	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218594898	f	\N	\N	\N
5837	Epinal	Martigues	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218466205	f	\N	\N	\N
5826	Nimes	Nancy	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218349812	f	\N	\N	\N
5834	Versailles 78 FC	Villefranche Beaujolais	2023-09-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218344496	f	\N	\N	\N
5850	NAC Breda	Emmen	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504278	f	\N	\N	\N
5851	Zulte-Waregem	Deinze	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612042	f	\N	\N	\N
5852	EC Sao Bernardo U20	Red Bull Bragantino U20	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612471	f	\N	\N	\N
5849	Reading U21	Leeds United U21	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218598794	f	\N	\N	\N
5862	Kecskemeti	Mezokovesd-Zsory	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218181216	f	\N	\N	\N
5870	Jong FC Utrecht	Cambuur Leeuwarden	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504704	f	\N	\N	\N
5855	Helmond Sport	FC Groningen	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504794	f	\N	\N	\N
5860	Al Nassr	Al Ahli	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218345776	f	\N	\N	\N
5869	Patro Eisden Maasmechelen	FCV Dender	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218612132	f	\N	\N	\N
5865	Dinamo Bucharest	Farul Constanta	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218257928	f	\N	\N	\N
5868	Man City U21	Chelsea U21	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599064	f	\N	\N	\N
5856	West Ham U21	Southampton U21	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218598974	f	\N	\N	\N
5861	Al-Wahda (KSA)	Abha	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218428209	f	\N	\N	\N
5864	Zeleznicar Pancevo	Partizan Belgrade	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218575561	f	\N	\N	\N
5867	FC Dordrecht	Jong AZ Alkmaar	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504885	t	\N	\N	\N
5857	Siroki Brijeg	Sarajevo	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218595348	f	\N	\N	\N
5872	Kabylie	Paradou	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218585819	f	\N	\N	\N
5894	Standard	Westerlo	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218224506	t	\N	\N	\N
5859	Jong PSV Eindhoven	VVV Venlo	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505065	f	\N	\N	\N
5854	Marisca Mersch	UN Kaerjeng 97	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218602853	f	\N	\N	\N
5873	Westerlo (Res)	Kortrijk (Res)	2023-09-22 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218594368	f	\N	\N	\N
5874	Thun	Aarau	2023-09-22 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218142479	f	\N	\N	\N
5878	Deportivo Espanol	CA Claypole	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218595901	f	\N	\N	\N
5875	LKS Lodz	Jagiellonia Bialystock	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218303477	f	\N	\N	\N
5877	Palermo	Cosenza	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218132552	f	\N	\N	\N
5876	Lechia Gdansk	GKS Katowice	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218401227	f	\N	\N	\N
5879	Stuttgart	SV Darmstadt	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217880470	f	\N	\N	\N
5893	Treaty United	Athlone Town	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218345030	f	\N	\N	\N
5882	Kerry FC	Galway Utd	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218345210	f	\N	\N	\N
5896	Newry	Dungannon	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218386652	f	\N	\N	\N
5880	Longford	Waterford	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218345120	f	\N	\N	\N
5886	St Patricks	Dundalk	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218184913	f	\N	\N	\N
5888	Sligo Rovers	Derry City	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218185003	f	\N	\N	\N
5883	Wexford F.C	Bray Wanderers	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218345300	f	\N	\N	\N
5887	Drogheda	Bohemians	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218152911	f	\N	\N	\N
5890	Glentoran	Coleraine	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218386742	f	\N	\N	\N
5891	Queens Park	Ayr	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218349992	f	\N	\N	\N
5895	Cardiff Metropolitan	The New Saints	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218534857	f	\N	\N	\N
5884	Larne	Carrick Rangers	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218387102	f	\N	\N	\N
5881	Cobh Ramblers	Finn Harps	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218344940	f	\N	\N	\N
5889	UCD	Shamrock Rovers	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218184823	f	\N	\N	\N
5892	Lecce	Genoa	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218024914	f	\N	\N	\N
5899	Admira Wacker	St Polten	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218341595	f	\N	\N	\N
5903	Huracan Las Heras	CS Estudiantes San Luis	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218610972	f	\N	\N	\N
5898	FC Cartagena	Eibar	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218278692	f	\N	\N	\N
5900	Corinthians U20	Palmeiras U20	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218597503	f	\N	\N	\N
5897	Aberystwyth	Penybont FC	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218535037	f	\N	\N	\N
5904	Birmingham	QPR	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218381570	f	\N	\N	\N
5901	Alaves	Athletic Bilbao	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217927622	f	\N	\N	\N
5905	Famalicao	Arouca	2023-09-22 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218391953	f	\N	\N	\N
5908	AD Carmelita	Marineros de Puntarenas FC	2023-09-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218599154	f	\N	\N	\N
5907	Arucas CF	UD Tamaraceite	2023-09-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218619303	f	\N	\N	\N
5906	PFA Antioquia FC	AD Barrio Mexico	2023-09-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608177	f	\N	\N	\N
6052	FC La Chaux-De-Fonds	FC Vevey	2023-09-22 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218638981	f	\N	\N	\N
6056	Itaberai U20	Vila Nova U20	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636909	f	\N	\N	\N
6057	ASC Korneuburg	USC Rohrbach	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636729	f	\N	\N	\N
6059	Cerrado U20	Vianopolis U20	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218636999	f	\N	\N	\N
6061	Csd Rangers	Santiago Morning	2023-09-22 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218637720	f	\N	\N	\N
5885	Shelbourne	Cork City	2023-09-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218185093	f	\N	\N	\N
6093	Universidad de Concepcion	Deportes Temuco	2023-09-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218637630	f	\N	\N	\N
5915	CD Poza Rica	Chilpancingo	2023-09-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218623554	f	\N	\N	\N
5914	Inter Playa Del Carmen	Deportivo Irapuato FC	2023-09-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218622425	f	\N	\N	\N
5916	Corinthians	Botafogo	2023-09-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218081452	f	\N	\N	\N
5917	Coquimbo Unido	OHiggins	2023-09-23 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218010578	f	\N	\N	\N
5919	Estudiantes de Merida	Zamora FC	2023-09-23 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218600346	f	\N	\N	\N
5918	Once Caldas	La Equidad	2023-09-23 00:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218515202	f	\N	\N	\N
6104	Guairena	Cerro Porteno	2023-09-23 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218643287	f	\N	\N	\N
5920	LDU	Orense Sporting Club	2023-09-23 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218440947	f	\N	\N	\N
5921	Independiente Rivadavia	Atletico Rafaela	2023-09-23 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218492140	f	\N	\N	\N
5924	San Martin de Mendoza	Argentino Monte Maiz	2023-09-23 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218611717	f	\N	\N	\N
5923	Atletico Go	Criciuma	2023-09-23 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218316675	f	\N	\N	\N
5928	Plaza Amador	Atletico Independiente	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218580089	f	\N	\N	\N
5902	Monaco	Nice	2023-09-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217964781	t	\N	\N	\N
5927	Atletico San Luis	Mazatlan FC	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988227	f	\N	\N	\N
5926	Atletico Saltillo	Calor de San Pedro	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218608267	f	\N	\N	\N
5929	Petroleros de Salamanca	CD Pioneros de Cancun	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218622515	f	\N	\N	\N
6115	FC Juarez	Atlas	2023-09-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217988318	f	\N	\N	\N
5931	Deportivo Cali	Ind Medellin	2023-09-23 02:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218521709	f	\N	\N	\N
5932	Alacranes de Durango	Coras de Nayarit FC	2023-09-23 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218620158	f	\N	\N	\N
5933	Japan (W)	Argentina (W)	2023-09-23 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218502658	f	\N	\N	\N
5934	Puebla	Pumas UNAM	2023-09-23 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217988137	f	\N	\N	\N
5935	Briobecca Urayasu SC	Criacao Shinjuku	2023-09-23 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218529056	f	\N	\N	\N
5936	Seongnam FC	Cheongju FC	2023-09-23 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218514277	f	\N	\N	\N
5792	B93 Copenhagen	Hobro	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369296	t	\N	\N	\N
5799	Kolding IF	Fredericia	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369386	t	\N	\N	\N
5804	AaB	HB Koge	2023-09-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218369206	t	\N	\N	\N
5853	Willem II	FC Oss	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218504614	t	\N	\N	\N
5863	Go Ahead Eagles	Fortuna Sittard	2023-09-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217938963	t	\N	\N	\N
\.


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 204
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 158, true);


--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 207
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 1311, true);


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 205
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 1600, true);


--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 209
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 9736, true);


--
-- TOC entry 2902 (class 2606 OID 16547)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 2906 (class 2606 OID 17073)
-- Name: over2p5footballsupertips over2p5footballsupertips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips
    ADD CONSTRAINT over2p5footballsupertips_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 2904 (class 2606 OID 17069)
-- Name: over2p5goalsnow over2p5goalsnow_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow
    ADD CONSTRAINT over2p5goalsnow_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 2908 (class 2606 OID 17077)
-- Name: over2p5orbitxch over2p5orbitxch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch
    ADD CONSTRAINT over2p5orbitxch_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE over2p5footballsupertips; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5footballsupertips FROM postgres;
GRANT ALL ON TABLE public.over2p5footballsupertips TO postgres WITH GRANT OPTION;


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE footballsupertips_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.footballsupertips_today FROM postgres;
GRANT ALL ON TABLE public.footballsupertips_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE over2p5goalsnow; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5goalsnow FROM postgres;
GRANT ALL ON TABLE public.over2p5goalsnow TO postgres WITH GRANT OPTION;


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE goalsnow_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.goalsnow_today FROM postgres;
GRANT ALL ON TABLE public.goalsnow_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE over2p5orbitxch; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5orbitxch FROM postgres;
GRANT ALL ON TABLE public.over2p5orbitxch TO postgres WITH GRANT OPTION;


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE orbitxch_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.orbitxch_today FROM postgres;
GRANT ALL ON TABLE public.orbitxch_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE "TodayMatches"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodayMatches" FROM postgres;
GRANT ALL ON TABLE public."TodayMatches" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodaysBets" FROM postgres;
GRANT ALL ON TABLE public."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE "YesterdaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."YesterdaysBets" FROM postgres;
GRANT ALL ON TABLE public."YesterdaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE "YesterdaysMatches"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."YesterdaysMatches" FROM postgres;
GRANT ALL ON TABLE public."YesterdaysMatches" TO postgres WITH GRANT OPTION;


--
-- TOC entry 1749 (class 826 OID 16567)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


-- Completed on 2023-09-29 21:54:00 BST

--
-- PostgreSQL database dump complete
--

