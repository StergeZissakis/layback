--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-0+deb12u1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-0+deb12u1)

-- Started on 2023-10-24 09:41:52 BST

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
-- TOC entry 3429 (class 1262 OID 16499)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_GB.UTF-8';


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
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 3429
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3431 (class 0 OID 0)
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
-- TOC entry 2902 (class 3456 OID 16500)
-- Name: match_team_names_collation; Type: COLLATION; Schema: public; Owner: -
--

CREATE COLLATION public.match_team_names_collation (provider = icu, deterministic = false, locale = 'und');


--
-- TOC entry 2 (class 3079 OID 16501)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 852 (class 1247 OID 16512)
-- Name: ActionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ActionType" AS ENUM (
    'Lay',
    'Back'
);


--
-- TOC entry 855 (class 1247 OID 16518)
-- Name: BetResult; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BetResult" AS ENUM (
    'Won',
    'Lost',
    'Lapsed'
);


--
-- TOC entry 858 (class 1247 OID 16526)
-- Name: OverUnderType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OverUnderType" AS ENUM (
    'Over',
    'Under'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16531)
-- Name: over2p5footballsupertips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5footballsupertips (
    id bigint NOT NULL,
    home character varying NOT NULL COLLATE pg_catalog."en_GB",
    away character varying NOT NULL COLLATE pg_catalog."en_GB",
    date_time timestamp without time zone NOT NULL,
    url character varying,
    league_id smallint
);


--
-- TOC entry 216 (class 1259 OID 16536)
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
-- TOC entry 217 (class 1259 OID 16540)
-- Name: over2p5goalsnow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5goalsnow (
    id bigint NOT NULL,
    home character varying NOT NULL COLLATE pg_catalog."en_GB",
    away character varying NOT NULL COLLATE pg_catalog."en_GB",
    date_time timestamp without time zone NOT NULL,
    url character varying,
    league_id smallint
);


--
-- TOC entry 218 (class 1259 OID 16545)
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
-- TOC entry 219 (class 1259 OID 16549)
-- Name: over2p5orbitxch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5orbitxch (
    id bigint NOT NULL,
    home character varying NOT NULL COLLATE pg_catalog."en_GB",
    away character varying NOT NULL COLLATE pg_catalog."en_GB",
    date_time timestamp without time zone NOT NULL,
    url character varying,
    plaied boolean DEFAULT false NOT NULL,
    ht_goals smallint,
    ft_goals smallint,
    league_id smallint
);


--
-- TOC entry 220 (class 1259 OID 16555)
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
-- TOC entry 226 (class 1259 OID 16619)
-- Name: TodayMatches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."TodayMatches" AS
 SELECT c.id,
    c.date_time,
    c.home,
    c.away,
    c.plaied,
    b.league_id,
    c.ht_goals,
    c.ft_goals,
    c.url
   FROM ((public.goalsnow_today a
     JOIN public.footballsupertips_today b ON ((((a.league_id = b.league_id) AND (a.date_time = b.date_time) AND (lower((a.home)::text) ~~ lower((b.home)::text))) OR (lower((a.away)::text) ~~ lower((b.away)::text)))))
     JOIN public.orbitxch_today c ON ((((b.date_time = c.date_time) AND (lower((b.home)::text) ~~ lower((c.home)::text))) OR (lower((b.away)::text) ~~ lower((c.away)::text)))))
  ORDER BY c.date_time, c.id, c.url;


--
-- TOC entry 221 (class 1259 OID 16564)
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
    "Goals" numeric NOT NULL,
    "Odds" numeric NOT NULL,
    "OddsRecorded" numeric,
    "Amount" numeric,
    "BetResult" public."BetResult",
    "BetResultTime" timestamp without time zone
);


--
-- TOC entry 229 (class 1259 OID 24832)
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
    a."BetResult",
    a."BetResultTime" AS "BetMatchTime"
   FROM public.over2p5bets a
  WHERE ((a."BetDateTime")::date >= CURRENT_DATE)
  ORDER BY a."BetDateTime", a.id;


--
-- TOC entry 228 (class 1259 OID 24827)
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
    a."BetResult",
    a."BetResultTime" AS "BetMatchTime"
   FROM public.over2p5bets a
  WHERE (((a."BetDateTime")::date >= (CURRENT_DATE - '1 day'::interval)) AND ((a."BetDateTime")::date < CURRENT_DATE))
  ORDER BY a."BetDateTime", a.id;


--
-- TOC entry 227 (class 1259 OID 16624)
-- Name: YesterdaysMatches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."YesterdaysMatches" AS
 SELECT c.id,
    c.date_time,
    c.home,
    c.away,
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
-- TOC entry 222 (class 1259 OID 16583)
-- Name: over2p5bets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5bets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 222
-- Name: over2p5bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5bets_id_seq OWNED BY public.over2p5bets.id;


--
-- TOC entry 223 (class 1259 OID 16584)
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5footballsupertips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 223
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5footballsupertips_id_seq OWNED BY public.over2p5footballsupertips.id;


--
-- TOC entry 224 (class 1259 OID 16585)
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5goalsnow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 224
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5goalsnow_id_seq OWNED BY public.over2p5goalsnow.id;


--
-- TOC entry 225 (class 1259 OID 16586)
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5orbitxch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 225
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5orbitxch_id_seq OWNED BY public.over2p5orbitxch.id;


--
-- TOC entry 3258 (class 2604 OID 16587)
-- Name: over2p5bets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets ALTER COLUMN id SET DEFAULT nextval('public.over2p5bets_id_seq'::regclass);


--
-- TOC entry 3254 (class 2604 OID 16588)
-- Name: over2p5footballsupertips id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips ALTER COLUMN id SET DEFAULT nextval('public.over2p5footballsupertips_id_seq'::regclass);


--
-- TOC entry 3255 (class 2604 OID 16589)
-- Name: over2p5goalsnow id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow ALTER COLUMN id SET DEFAULT nextval('public.over2p5goalsnow_id_seq'::regclass);


--
-- TOC entry 3256 (class 2604 OID 16590)
-- Name: over2p5orbitxch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch ALTER COLUMN id SET DEFAULT nextval('public.over2p5orbitxch_id_seq'::regclass);


--
-- TOC entry 3419 (class 0 OID 16564)
-- Dependencies: 221
-- Data for Name: over2p5bets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetResultTime") FROM stdin;
1	2023-09-30 16:30:00	Norrkoping	Kalmar FF	2023-09-30 17:34:58	Lay	Under	2.50	1.50	1.53	6	\N	2023-09-30 17:36:26.000087
2	2023-09-30 16:30:00	Norrkoping	Kalmar FF	2023-09-30 17:34:58	Back	Under	2.50	1.13	1.13	6	\N	2023-09-30 18:03:27.528227
4	2023-09-30 17:00:00	AC Milan	Lazio	2023-09-30 18:13:03	Lay	Under	1.50	1.50	1.63	6	\N	2023-09-30 18:13:18.047226
5	2023-09-30 17:00:00	Servette	Lausanne	2023-09-30 18:10:09	Lay	Under	2.50	1.50	2.22	6	Lapsed	2023-09-30 18:14:46.527172
3	2023-09-30 17:00:00	Winterthur	Lugano	2023-09-30 18:04:57	Lay	Under	2.50	1.50	2.00	6	\N	2023-09-30 18:16:56.500735
6	2023-09-30 17:00:00	Servette	Lausanne	2023-09-30 18:14:54	Lay	Under	2.50	1.50	2.22	6	Lapsed	2023-09-30 18:17:10.161939
7	2023-09-30 17:00:00	AC Milan	Lazio	2023-09-30 18:13:03	Back	Under	1.50	1.50	1.52	6	\N	2023-09-30 18:41:57.174993
8	2023-09-30 17:45:00	FC Utrecht	Almere City	2023-09-30 18:55:07	Lay	Under	1.50	1.50	1.90	6	\N	2023-09-30 19:07:24.404697
9	2023-09-30 17:45:00	FC Utrecht	Almere City	2023-09-30 18:55:07	Back	Under	1.50	1.12	1.12	6	\N	2023-09-30 19:24:31.210813
10	2023-09-30 19:00:00	Francs Borains	Seraing Utd	2023-09-30 20:02:43	Lay	Under	1.50	1.50	1.93	6	Lapsed	2023-09-30 20:05:34.295916
42	2023-10-01 13:30:00	Heracles	PEC Zwolle	2023-10-01 14:58:10	Lay	Under	2.50	1.50	\N	6	Lapsed	2023-10-01 15:11:40.833
30	2023-10-01 12:30:00	Nurnberg	FC Magdeburg	2023-10-01 13:35:24.393082	Lay	Under	1.50	1.50	2.14	6	\N	\N
28	2023-10-01 12:00:00	HB Koge	FC Helsingor	2023-10-01 13:03:17	Lay	Under	1.50	1.50	2.08	6	Lost	2023-10-01 13:15:58.029922
29	2023-10-01 12:00:00	HB Koge	FC Helsingor	2023-10-01 13:03:17	Back	Under	1.50	1.12	1.12	6	Won	2023-10-01 13:34:28.460682
44	2023-10-01 14:00:00	Sirius	Degerfors	2023-10-01 15:08:47	Lay	Under	2.50	1.50	2.02	6	Lapsed	2023-10-01 15:20:10.24436
35	2023-10-01 13:30:00	Hartberg	SCR Altach	2023-10-01 14:34:27	Lay	Under	1.50	1.50	1.57	6	Lost	2023-10-01 14:37:17.738453
31	2023-10-01 12:30:00	Zulte-Waregem	Club Brugge B	2023-10-01 13:37:23	Lay	Under	2.50	1.50	2.64	6	Lost	2023-10-01 13:57:28.175848
33	2023-10-01 12:30:00	Zulte-Waregem	Club Brugge B	2023-10-01 13:37:23	Back	Under	2.50	1.11	1.11	6	Won	2023-10-01 14:12:51.029177
24	2023-09-30 20:00:00	FC Twente	Heerenveen	2023-09-30 21:05:52	Lay	Under	1.50	1.50	1.91	6	Lapsed	2023-09-30 21:06:46.148153
21	2023-09-30 19:30:00	Grasshoppers Zurich	Young Boys	2023-09-30 20:33:39	Lay	Under	2.50	1.50	2.10	6	Lost	2023-09-30 20:48:58.446879
23	2023-09-30 19:30:00	Grasshoppers Zurich	Young Boys	2023-09-30 20:33:39	Back	Under	2.50	1.50	1.30	6	Won	2023-09-30 20:57:18.773222
22	2023-09-30 19:30:00	Hertha Berlin	St Pauli	2023-09-30 20:38:29	Lay	Under	2.50	1.50	1.96	6	Won	2023-09-30 20:51:35.39823
26	2023-10-01 11:15:00	VVV Venlo	Helmond Sport	2023-10-01 12:25:21	Lay	Under	2.50	1.50	2.18	6	Lapsed	2023-10-01 12:27:20.145133
27	2023-10-01 11:15:00	VVV Venlo	Helmond Sport	2023-10-01 12:27:22	Lay	Under	2.50	1.50	\N	6	Lapsed	2023-10-01 12:42:10.31188
41	2023-10-01 13:30:00	Hartberg	SCR Altach	2023-10-01 14:34:27	Back	Under	1.50	1.13	1.13	6	Won	2023-10-01 14:56:52.439023
53	2023-10-01 15:00:00	FC Liege	Lommel	2023-10-01 16:14:35	Lay	Under	2.50	1.50	\N	6	Lapsed	2023-10-01 16:26:20.99343
37	2023-10-01 13:30:00	Excelsior	Sparta Rotterdam	2023-10-01 14:36:26	Lay	Under	1.50	1.50	1.81	6	Won	2023-10-01 14:45:27.842747
46	2023-10-01 14:00:00	Hacken	AIK	2023-10-01 15:11:02	Lay	Under	1.50	1.50	2.08	6	\N	2023-10-01 15:25:52.254904
36	2023-10-01 13:30:00	Heracles	PEC Zwolle	2023-10-01 14:36:22	Lay	Under	1.50	1.50	2.12	6	Lapsed	2023-10-01 14:42:37.758817
39	2023-10-01 13:30:00	Heracles	PEC Zwolle	2023-10-01 14:42:39	Lay	Under	1.50	1.50	\N	6	Lapsed	2023-10-01 14:58:08.262068
32	2023-10-01 13:00:00	Vejle	FC Nordsjaelland	2023-10-01 14:11:30	Lay	Under	1.50	1.50	1.85	6	Lost	2023-10-01 14:22:22.824769
38	2023-10-01 13:00:00	Vejle	FC Nordsjaelland	2023-10-01 14:11:30	Back	Under	1.50	1.14	1.14	6	Won	2023-10-01 14:41:45.839116
34	2023-10-01 13:15:00	Yverdon Sport	St Gallen	2023-10-01 14:18:26	Lay	Under	2.50	1.50	2.40	6	Lost	2023-10-01 14:38:53.005535
40	2023-10-01 13:15:00	Yverdon Sport	St Gallen	2023-10-01 14:18:26	Back	Under	2.50	1.13	1.13	6	Won	2023-10-01 14:54:23.134339
43	2023-10-01 14:00:00	Le Havre	Lille	2023-10-01 15:05:54	Lay	Under	2.50	1.50	1.65	6	Lapsed	2023-10-01 15:10:27.758429
65	2023-10-01 15:30:00	Arouca	Chaves	2023-10-01 16:39:15	Back	Under	1.50	1.50	1.47	6	Lost	2023-10-01 17:16:09.018217
54	2023-10-01 15:30:00	Luzern	FC Zurich	2023-10-01 16:34:54	Lay	Under	2.50	1.50	1.85	6	Lapsed	2023-10-01 16:41:06.189934
45	2023-10-01 14:00:00	Le Havre	Lille	2023-10-01 15:10:29	Lay	Under	2.50	1.50	\N	6	Lost	2023-10-01 15:41:06.094333
48	2023-10-01 14:00:00	Le Havre	Lille	2023-10-01 15:10:29	Back	Under	2.50	1.50	1.48	6	Won	2023-10-01 15:41:12.725556
47	2023-10-01 14:00:00	Sirius	Degerfors	2023-10-01 15:20:17	Lay	Under	2.50	1.50	\N	6	Won	2023-10-01 15:48:57.641869
49	2023-10-01 14:00:00	Sirius	Degerfors	2023-10-01 15:20:17	Back	Under	2.50	1.50	1.44	6	Lost	2023-10-01 15:49:04.00469
50	2023-10-01 15:00:00	Hvidovre	Brondby	2023-10-01 16:04:03	Lay	Under	2.50	1.50	2.06	6	Lapsed	2023-10-01 16:06:57.212619
51	2023-10-01 15:00:00	FC Liege	Lommel	2023-10-01 16:05:51	Lay	Under	2.50	1.50	2.30	6	Lapsed	2023-10-01 16:14:33.013132
63	2023-10-01 16:00:00	Sandefjord	Valerenga	2023-10-01 17:13:07	Lay	Under	2.50	1.50	\N	6	Lapsed	2023-10-01 17:25:06.129513
59	2023-10-01 16:00:00	Sandefjord	Valerenga	2023-10-01 17:03:57	Lay	Under	2.50	1.50	1.87	6	Lapsed	2023-10-01 17:13:02.992712
62	2023-10-01 15:30:00	FC Basel	Stade Lausanne-Ouchy	2023-10-01 16:38:02	Back	Under	2.50	1.50	1.51	6	Lost	2023-10-01 17:11:23.633498
57	2023-10-01 15:30:00	Luzern	FC Zurich	2023-10-01 16:41:09	Lay	Under	2.50	1.50	\N	6	Lapsed	2023-10-01 16:52:33.683898
52	2023-10-01 15:00:00	Hvidovre	Brondby	2023-10-01 16:06:59	Lay	Under	2.50	1.50	\N	6	Won	2023-10-01 16:42:39.012048
58	2023-10-01 15:00:00	Hvidovre	Brondby	2023-10-01 16:06:59	Back	Under	2.50	1.50	1.50	6	Lost	2023-10-01 16:42:42.139834
60	2023-10-01 16:00:00	Austria Vienna	Rapid Vienna	2023-10-01 17:05:56	Lay	Under	1.50	1.50	2.18	6	Lapsed	2023-10-01 17:13:14.498392
70	2023-10-01 18:15:00	Bodo Glimt	Stromsgodset	2023-10-01 19:21:20	Lay	Under	2.50	1.50	2.38	6	Lapsed	2023-10-01 19:35:03.33788
69	2023-10-01 16:05:00	Lorient	Montpellier	2023-10-01 17:09:22	Back	Under	2.50	1.50	1.51	6	Lost	2023-10-01 17:46:50.134498
55	2023-10-01 15:30:00	FC Basel	Stade Lausanne-Ouchy	2023-10-01 16:38:02	Lay	Under	2.50	1.50	1.81	6	Won	2023-10-01 16:47:27.72442
64	2023-10-01 16:00:00	Austria Vienna	Rapid Vienna	2023-10-01 17:13:16	Lay	Under	1.50	1.50	\N	6	Lapsed	2023-10-01 17:25:59.538236
68	2023-10-01 16:00:00	Austria Vienna	Rapid Vienna	2023-10-01 17:26:04	Back	Under	1.50	1.12	1.12	6	Won	2023-10-01 17:45:48.98766
56	2023-10-01 15:30:00	Arouca	Chaves	2023-10-01 16:39:15	Lay	Under	1.50	1.50	1.53	6	Won	2023-10-01 16:40:50.998379
61	2023-10-01 16:05:00	Lorient	Montpellier	2023-10-01 17:09:22	Lay	Under	2.50	1.50	1.83	6	Won	2023-10-01 17:20:46.773118
67	2023-10-01 16:30:00	Freiburg	Augsburg	2023-10-01 17:36:20	Lay	Under	2.50	1.50	1.63	6	Lost	2023-10-01 17:41:46.17893
66	2023-10-01 16:00:00	Austria Vienna	Rapid Vienna	2023-10-01 17:26:04	Lay	Under	1.50	1.50	\N	6	Lost	2023-10-01 17:28:49.567692
95	2023-10-04 20:00:00	RB Leipzig	Man City	2023-10-04 21:05:02	Lay	Under	2.50	1.50	1.80	6	Lapsed	2023-10-04 21:06:37.085242
71	2023-10-01 18:15:00	Bodo Glimt	Stromsgodset	2023-10-01 19:35:05	Lay	Under	2.50	1.50	\N	6	Lost	2023-10-01 20:00:11.369903
72	2023-10-01 18:15:00	Bodo Glimt	Stromsgodset	2023-10-01 19:35:05	Back	Under	2.50	1.50	1.47	6	Won	2023-10-01 20:00:14.980717
106	2023-10-05 17:45:00	Freiburg	West Ham	2023-10-05 18:50:14	Lay	Under	2.50	1.50	1.78	6	Lapsed	2023-10-05 18:52:52.323625
97	2023-10-04 20:00:00	Crvena Zvezda	Young Boys	2023-10-04 21:08:11	Lay	Under	2.50	1.50	1.86	6	Lapsed	2023-10-04 21:09:17.121656
73	2023-10-02 01:00:00	Los Angeles FC	Real Salt Lake	2023-10-02 02:30:30	Lay	Under	1.50	1.50	2.14	6	Lost	2023-10-02 02:47:44.164695
74	2023-10-02 01:00:00	Los Angeles FC	Real Salt Lake	2023-10-02 02:30:30	Back	Under	1.50	1.50	1.50	6	Won	2023-10-02 03:12:12.373131
112	2023-10-06 18:00:00	B93 Copenhagen	Hillerod Fodbold	2023-10-06 19:03:56	Lay	Under	1.50	1.50	2.02	6	Lapsed	2023-10-06 19:08:37.835666
107	2023-10-05 17:45:00	Aris FC Limassol	Rangers	2023-10-05 18:52:14	Lay	Under	2.50	1.50	2.04	6	Lapsed	2023-10-05 19:04:13.38924
78	2023-10-02 18:00:00	OB	Lyngby	2023-10-02 19:10:11	Lay	Under	2.50	1.50	1.97	6	Lapsed	2023-10-02 19:13:09.383784
75	2023-10-02 17:30:00	Sassuolo	AC Monza	2023-10-02 18:34:11	Lay	Under	1.50	1.50	2.12	6	Lost	2023-10-02 18:51:30.278805
109	2023-10-06 17:30:00	Fredericia	SonderjyskE	2023-10-06 18:34:14	Lay	Under	2.50	1.50	3.10	6	Won	2023-10-06 18:59:59.139725
76	2023-10-02 18:00:00	Utsiktens	AFC Eskilstuna	2023-10-02 19:03:11	Lay	Under	2.50	1.50	1.87	6	Lost	2023-10-02 19:14:36.133125
80	2023-10-02 18:00:00	Utsiktens	AFC Eskilstuna	2023-10-02 19:03:11	Back	Under	2.50	1.13	1.13	6	Won	2023-10-02 19:34:09.401941
77	2023-10-02 18:00:00	Jonkopings Sodra	Ostersunds FK	2023-10-02 19:03:17	Lay	Under	2.50	1.50	1.60	6	Lost	2023-10-02 19:05:53.121624
79	2023-10-02 18:00:00	Jonkopings Sodra	Ostersunds FK	2023-10-02 19:03:17	Back	Under	2.50	1.14	1.14	6	Won	2023-10-02 19:29:29.183981
81	2023-10-02 19:00:00	MVV Maastricht	FC Eindhoven	2023-10-02 20:10:25	Lay	Under	1.50	1.50	2.16	6	\N	2023-10-02 20:24:31.919997
82	2023-10-03 18:00:00	Landskrona	Sundsvall	2023-10-03 19:03:08	Lay	Under	2.50	1.50	2.18	6	Lapsed	2023-10-03 19:08:49.503154
83	2023-10-03 18:00:00	GAIS	Osters	2023-10-03 19:08:08	Lay	Under	1.50	1.50	1.96	6	Lost	2023-10-03 19:19:43.959537
84	2023-10-03 18:00:00	GAIS	Osters	2023-10-03 19:47:26	Back	Under	1.50	1.50	1.11	6	Won	2023-10-03 19:56:28.260455
85	2023-10-03 19:00:00	Willem II	FC Oss	2023-10-03 20:09:02	Lay	Under	2.50	1.50	2.52	6	Lapsed	2023-10-03 20:22:41.957567
86	2023-10-03 19:45:00	Middlesbrough	Cardiff	2023-10-03 20:48:53	Lay	Under	1.50	1.50	1.69	6	\N	2023-10-03 20:56:46.493171
87	2023-10-03 19:45:00	Plymouth	Millwall	2023-10-03 20:51:54	Lay	Under	1.50	1.50	1.85	6	\N	2023-10-03 21:03:00.005644
88	2023-10-03 20:00:00	FC Copenhagen	Bayern Munich	2023-10-03 21:04:35	Lay	Under	1.50	1.50	2.58	6	Lapsed	2023-10-03 21:13:35.121687
89	2023-10-03 20:00:00	Stoke	Southampton	2023-10-03 21:04:38	Lay	Under	2.50	1.50	1.83	6	\N	2023-10-03 21:16:18.110532
90	2023-10-03 20:00:00	Inter	Benfica	2023-10-03 21:06:20	Lay	Under	1.50	1.50	2.04	6	Lapsed	2023-10-03 21:20:30.945157
91	2023-10-04 19:45:00	Coventry	Blackburn	2023-10-04 20:51:07	Lay	Under	1.50	1.50	2.18	6	Lapsed	2023-10-04 20:54:41.74275
92	2023-10-04 19:45:00	Sunderland	Watford	2023-10-04 20:51:08	Lay	Under	2.50	1.50	1.84	6	\N	2023-10-04 21:02:10.129692
111	2023-10-06 17:30:00	Empoli	Udinese	2023-10-06 18:35:37	Lay	Under	1.50	1.50	1.83	6	Lost	2023-10-06 18:44:41.335806
93	2023-10-04 20:00:00	Dortmund	AC Milan	2023-10-04 21:04:16	Lay	Under	1.50	1.50	1.80	6	Lost	2023-10-04 21:13:27.005283
99	2023-10-04 20:00:00	Dortmund	AC Milan	2023-10-04 21:04:16	Back	Under	1.50	1.13	1.14	6	Won	2023-10-04 21:30:46.761045
94	2023-10-04 20:00:00	Porto	Barcelona	2023-10-04 21:04:32	Lay	Under	2.50	1.50	1.77	6	Lost	2023-10-04 21:16:17.018271
100	2023-10-04 20:00:00	Porto	Barcelona	2023-10-04 21:04:32	Back	Under	2.50	1.13	1.15	6	Won	2023-10-04 21:34:41.570366
96	2023-10-04 20:00:00	Rotherham	Bristol City	2023-10-04 21:05:16	Lay	Under	1.50	1.50	1.59	6	Won	2023-10-04 21:08:43.62192
98	2023-10-04 20:00:00	Rotherham	Bristol City	2023-10-04 21:05:16	Back	Under	1.50	1.13	1.15	6	Lost	2023-10-04 21:30:15.907681
104	2023-10-05 17:46:00	FK Backa Topola	Olympiakos	2023-10-05 18:47:55	Lay	Under	2.50	1.50	1.79	6	Won	2023-10-05 18:56:57.903663
105	2023-10-05 17:45:00	AEK Athens	Ajax	2023-10-05 18:49:22	Lay	Under	2.50	1.50	2.22	6	Lost	2023-10-05 19:08:10.6337
101	2023-10-05 00:30:00	CF Montreal	Houston Dynamo	2023-10-05 01:43:20	Lay	Under	2.50	1.50	1.81	6	Lost	2023-10-05 01:56:27.834424
102	2023-10-05 00:30:00	CF Montreal	Houston Dynamo	2023-10-05 01:43:20	Back	Under	2.50	1.13	1.15	6	Won	2023-10-05 02:12:47.52534
103	2023-10-05 01:30:00	Chicago Fire	Inter Miami CF	2023-10-05 02:43:19	Lay	Under	1.50	1.50	1.71	6	Lapsed	2023-10-05 02:45:44.11617
108	2023-10-05 17:45:00	AEK Athens	Ajax	2023-10-05 18:49:22	Back	Under	2.50	1.50	1.46	6	Won	2023-10-05 19:30:17.742265
118	2023-10-06 19:45:00	Lecce	Sassuolo	2023-10-06 20:54:58	Lay	Under	2.50	1.50	1.91	6	Lapsed	2023-10-06 20:56:07.383158
110	2023-10-06 17:30:00	Fortuna Dusseldorf	VfL Osnabruck	2023-10-06 18:35:21	Lay	Under	1.50	1.50	2.34	6	Lapsed	2023-10-06 18:48:10.21188
115	2023-10-06 19:00:00	Lommel	SL 16 FC	2023-10-06 20:25:25	Lay	Under	2.50	1.50	1.48	6	Lost	2023-10-06 20:25:40.679275
116	2023-10-06 19:00:00	Lommel	SL 16 FC	2023-10-06 20:25:25	Back	Under	2.50	1.13	1.14	6	Won	2023-10-06 20:39:59.898974
113	2023-10-06 17:30:00	Empoli	Udinese	2023-10-06 18:35:37	Back	Under	1.50	1.13	1.14	6	Won	2023-10-06 19:04:37.723187
114	2023-10-06 19:00:00	FC Volendam	FC Utrecht	2023-10-06 20:13:45	Lay	Under	1.50	1.50	1.86	6	Lapsed	2023-10-06 20:17:58.585435
123	2023-10-07 12:00:00	Greuther Furth	Hansa Rostock	2023-10-07 13:09:19	Back	Under	2.50	1.13	1.14	6	Won	2023-10-07 13:40:26.408382
117	2023-10-06 19:45:00	Charleroi	Molenbeek	2023-10-06 20:49:05	Lay	Under	1.50	1.50	2.06	6	\N	2023-10-06 21:04:20.542755
119	2023-10-06 20:00:00	Strasbourg	Nantes	2023-10-06 21:07:17	Lay	Under	1.50	1.50	1.53	6	Won	2023-10-06 21:09:31.979694
125	2023-10-07 13:00:00	Cadiz	Girona	2023-10-07 14:14:28	Back	Under	1.50	1.50	1.52	6	Won	2023-10-07 14:53:45.974572
122	2023-10-07 12:30:00	Luton	Tottenham	2023-10-07 13:38:23	Lay	Under	1.50	1.50	1.82	6	Lapsed	2023-10-07 13:43:43.683715
121	2023-10-07 12:30:00	Sunderland	Middlesbrough	2023-10-07 13:37:16	Lay	Under	1.50	1.50	1.90	6	Lapsed	2023-10-07 13:49:02.853245
120	2023-10-07 12:00:00	Greuther Furth	Hansa Rostock	2023-10-07 13:09:19	Lay	Under	2.50	1.50	1.96	6	Lost	2023-10-07 13:23:01.783475
124	2023-10-07 13:00:00	Cadiz	Girona	2023-10-07 14:14:28	Lay	Under	1.50	1.50	1.84	6	Lost	2023-10-07 14:24:50.856405
128	2023-10-07 14:00:00	Kolding IF	HB Koge	2023-10-07 15:12:00	Lay	Under	1.50	1.50	1.97	6	Lapsed	2023-10-07 15:12:38.978965
127	2023-10-07 14:00:00	Vasteras SK	Jonkopings Sodra	2023-10-07 15:04:49	Lay	Under	2.50	1.50	2.14	6	Lapsed	2023-10-07 15:16:34.480813
126	2023-10-07 14:00:00	Halmstads	Degerfors	2023-10-07 15:04:33	Lay	Under	1.50	1.50	1.74	6	Lost	2023-10-07 15:11:40.944735
149	2023-10-07 19:45:00	Anderlecht	Yellow-Red Mechelen	2023-10-07 20:52:28	Lay	Under	2.50	1.50	1.93	6	Won	2023-10-07 21:05:34.564359
130	2023-10-07 14:30:00	Augsburg	SV Darmstadt	2023-10-07 15:35:37	Lay	Under	1.50	1.50	1.72	6	Lapsed	2023-10-07 15:39:35.684545
148	2023-10-07 19:45:00	Genoa	AC Milan	2023-10-07 20:51:29	Lay	Under	1.50	1.50	1.58	6	Lost	2023-10-07 20:53:24.601728
129	2023-10-07 14:00:00	Halmstads	Degerfors	2023-10-07 15:04:33	Back	Under	1.50	1.13	1.15	6	Won	2023-10-07 15:28:07.060048
150	2023-10-07 19:45:00	Genoa	AC Milan	2023-10-07 20:51:29	Back	Under	1.50	1.13	1.14	6	Won	2023-10-07 21:16:06.094909
162	2023-10-08 13:00:00	FC Nordsjaelland	OB	2023-10-08 14:10:26	Lay	Under	2.50	1.50	2.42	6	Lapsed	2023-10-08 14:15:46.921914
134	2023-10-07 15:00:00	Man Utd	Brentford	2023-10-07 16:10:09	Lay	Under	2.50	1.50	2.12	6	Lapsed	2023-10-07 16:25:08.655026
137	2023-10-07 15:15:00	Real Madrid	Osasuna	2023-10-07 16:23:07	Lay	Under	2.50	1.50	1.93	6	Lapsed	2023-10-07 16:28:14.938841
131	2023-10-07 14:30:00	RB Leipzig	Bochum	2023-10-07 15:37:11	Lay	Under	1.50	1.50	2.18	6	Lost	2023-10-07 15:53:27.173871
133	2023-10-07 14:30:00	RB Leipzig	Bochum	2023-10-07 15:37:11	Back	Under	1.50	1.13	1.14	6	Won	2023-10-07 16:06:54.125085
132	2023-10-07 14:30:00	Stuttgart	Wolfsburg	2023-10-07 15:41:57	Lay	Under	2.50	1.50	2.12	6	Won	2023-10-07 15:57:18.622985
151	2023-10-07 20:30:00	Estoril Praia	Benfica	2023-10-07 21:34:09	Lay	Under	1.50	1.50	2.34	6	Lost	2023-10-07 21:54:23.190094
152	2023-10-07 20:30:00	Estoril Praia	Benfica	2023-10-07 21:34:09	Back	Under	1.50	1.13	1.15	6	Won	2023-10-07 22:08:43.64332
135	2023-10-07 15:00:00	Coventry	Norwich	2023-10-07 16:10:09	Lay	Under	2.50	1.50	1.94	6	Lost	2023-10-07 16:22:17.973966
139	2023-10-07 15:00:00	Coventry	Norwich	2023-10-07 16:10:09	Back	Under	2.50	1.13	1.15	6	Won	2023-10-07 16:38:07.148913
136	2023-10-07 15:00:00	Leicester	Stoke	2023-10-07 16:10:53	Lay	Under	2.50	1.50	1.73	6	Lost	2023-10-07 16:18:03.725048
138	2023-10-07 15:00:00	Leicester	Stoke	2023-10-07 16:10:53	Back	Under	2.50	1.13	1.15	6	Won	2023-10-07 16:34:55.607516
143	2023-10-07 16:00:00	Hartberg	WSG Wattens	2023-10-07 17:07:45	Lay	Under	1.50	1.50	1.69	6	\N	2023-10-07 17:13:43.13927
154	2023-10-08 00:30:00	New York Red Bulls	Toronto FC	2023-10-08 01:43:21	Lay	Under	2.50	1.50	2.16	6	Lapsed	2023-10-08 01:45:06.860251
140	2023-10-07 15:30:00	Farense	Vizela	2023-10-07 16:40:09	Lay	Under	1.50	1.50	1.68	6	Lost	2023-10-07 16:45:29.811379
142	2023-10-07 15:30:00	Farense	Vizela	2023-10-07 16:40:09	Back	Under	1.50	1.13	1.15	6	Won	2023-10-07 17:05:04.852524
145	2023-10-07 16:30:00	IFK Goteborg	Sirius	2023-10-07 17:37:05	Lay	Under	1.50	1.50	1.65	6	\N	2023-10-07 17:41:32.891827
141	2023-10-07 16:00:00	Ostersunds FK	Helsingborgs	2023-10-07 17:02:33	Lay	Under	1.50	1.50	1.61	6	Lost	2023-10-07 17:07:19.888864
144	2023-10-07 16:00:00	Ostersunds FK	Helsingborgs	2023-10-07 17:02:33	Back	Under	1.50	1.13	1.15	6	Won	2023-10-07 17:25:31.89135
146	2023-10-07 18:00:00	Braga	Rio Ave	2023-10-07 19:11:24	Lay	Under	2.50	1.50	2.22	6	Lapsed	2023-10-07 19:31:05.093807
167	2023-10-08 13:15:00	Lugano	Servette	2023-10-08 14:20:13	Back	Under	2.50	1.13	1.15	6	Won	2023-10-08 14:51:35.231434
147	2023-10-07 19:00:00	Patro Eisden Maasmechelen	FC Liege	2023-10-07 20:01:33	Lay	Under	1.50	1.50	1.71	6	Won	2023-10-07 20:08:02.917031
165	2023-10-08 13:30:00	Fortuna Sittard	FC Twente	2023-10-08 14:37:23	Lay	Under	2.50	1.50	1.80	6	Lapsed	2023-10-08 14:38:39.540486
164	2023-10-08 13:30:00	Wolfsberger AC	Sturm Graz	2023-10-08 14:34:20	Lay	Under	2.50	1.50	1.91	6	Lapsed	2023-10-08 14:40:58.595353
166	2023-10-08 13:30:00	Ajax	AZ Alkmaar	2023-10-08 14:41:31	Lay	Under	2.50	1.50	1.95	6	Lapsed	2023-10-08 14:51:03.637245
155	2023-10-08 00:30:00	Philadelphia	Nashville SC	2023-10-08 01:43:35	Lay	Under	1.50	1.50	1.62	6	Lost	2023-10-08 01:47:56.742198
156	2023-10-08 00:30:00	Philadelphia	Nashville SC	2023-10-08 01:43:35	Back	Under	1.50	1.13	1.14	6	Won	2023-10-08 02:09:21.745012
153	2023-10-08 00:30:00	Inter Miami CF	FC Cincinnati	2023-10-08 01:43:19	Lay	Under	1.50	1.50	2.34	6	Lost	2023-10-08 02:03:43.473276
157	2023-10-08 00:30:00	Inter Miami CF	FC Cincinnati	2023-10-08 01:43:19	Back	Under	1.50	1.50	1.50	6	Won	2023-10-08 02:27:09.854197
158	2023-10-08 11:15:00	PEC Zwolle	Feyenoord	2023-10-08 12:19:10	Lay	Under	2.50	1.50	2.36	6	Lapsed	2023-10-08 12:30:45.745922
176	2023-10-08 14:00:00	Brest	Toulouse	2023-10-08 15:08:45	Lay	Under	2.50	1.50	1.79	6	Lapsed	2023-10-08 15:17:49.373997
161	2023-10-08 12:30:00	Schalke 04	Hertha Berlin	2023-10-08 13:34:24	Lay	Under	2.50	1.50	2.34	6	Lapsed	2023-10-08 13:40:07.024371
159	2023-10-08 12:00:00	AFC Eskilstuna	Landskrona	2023-10-08 13:02:10	Lay	Under	1.50	1.50	1.91	6	Lost	2023-10-08 13:12:44.472493
160	2023-10-08 12:00:00	AFC Eskilstuna	Landskrona	2023-10-08 13:02:10	Back	Under	1.50	1.13	1.15	6	Won	2023-10-08 13:30:10.513709
169	2023-10-08 14:00:00	Sundsvall	IK Brage	2023-10-08 15:04:40	Lay	Under	2.50	1.50	2.02	6	Lapsed	2023-10-08 15:10:38.141937
163	2023-10-08 13:15:00	Lugano	Servette	2023-10-08 14:20:13	Lay	Under	2.50	1.50	1.86	6	Lost	2023-10-08 14:31:53.774587
172	2023-10-08 14:00:00	Wolves	Aston Villa	2023-10-08 15:06:33	Lay	Under	1.50	1.50	1.80	6	Lapsed	2023-10-08 15:12:32.544485
168	2023-10-08 14:00:00	Brommapojkarna	Elfsborg	2023-10-08 15:01:14	Lay	Under	1.50	1.50	1.89	6	Lapsed	2023-10-08 15:12:41.962103
179	2023-10-08 14:00:00	Frosinone	Verona	2023-10-08 15:06:33	Back	Under	2.50	1.50	1.50	6	Lost	2023-10-08 15:38:23.883282
174	2023-10-08 14:00:00	West Ham	Newcastle	2023-10-08 15:06:44	Lay	Under	2.50	1.50	1.85	6	Lapsed	2023-10-08 15:16:17.877648
181	2023-10-08 15:00:00	Brondby	Viborg	2023-10-08 16:06:08	Back	Under	1.50	1.13	1.15	6	Won	2023-10-08 16:32:59.93086
171	2023-10-08 14:00:00	Start	Kongsvinger	2023-10-08 15:05:48	Lay	Under	2.50	1.50	2.08	6	Lapsed	2023-10-08 15:17:50.158636
175	2023-10-08 14:00:00	Kalmar FF	Malmo FF	2023-10-08 15:08:34	Lay	Under	1.50	1.50	1.74	6	Lost	2023-10-08 15:17:09.658868
183	2023-10-08 16:00:00	Sarpsborg	Rosenborg	2023-10-08 17:04:24	Lay	Under	2.50	1.50	2.36	6	Lapsed	2023-10-08 17:07:03.135199
170	2023-10-08 14:00:00	KFUM Oslo	Bryne	2023-10-08 15:05:30	Lay	Under	1.50	1.50	1.82	6	Lost	2023-10-08 15:15:50.627525
177	2023-10-08 14:00:00	KFUM Oslo	Bryne	2023-10-08 15:05:30	Back	Under	1.50	1.13	1.14	6	Won	2023-10-08 15:33:23.468329
173	2023-10-08 14:00:00	Frosinone	Verona	2023-10-08 15:06:33	Lay	Under	2.50	1.50	1.69	6	Won	2023-10-08 15:13:41.1371
178	2023-10-08 14:00:00	Kalmar FF	Malmo FF	2023-10-08 15:08:34	Back	Under	1.50	1.13	1.15	6	Won	2023-10-08 15:36:44.659414
182	2023-10-08 15:45:00	Sparta Rotterdam	PSV	2023-10-08 16:55:10	Lay	Under	1.50	1.50	2.36	6	Lapsed	2023-10-08 16:57:30.697054
180	2023-10-08 15:00:00	Brondby	Viborg	2023-10-08 16:06:08	Lay	Under	1.50	1.50	2.00	6	Lost	2023-10-08 16:19:26.82456
184	2023-10-08 16:00:00	Tromso	阿利辛特	2023-10-08 17:06:04.0933	Lay	Under	2.50	1.50	2.18	6	\N	\N
185	2023-10-08 16:00:00	Sandefjord	Ham-Kam	2023-10-08 17:06:25	Lay	Under	1.50	1.50	1.97	6	Lapsed	2023-10-08 17:18:28.004459
187	2023-10-08 16:30:00	Hammarby	Hacken	2023-10-08 17:35:49	Lay	Under	2.50	1.50	2.24	6	Lapsed	2023-10-08 17:50:05.733796
186	2023-10-08 16:00:00	Stabaek	Lillestrom	2023-10-08 17:07:29	Lay	Under	1.50	1.50	1.67	6	Lost	2023-10-08 17:14:05.836116
188	2023-10-08 16:30:00	Arsenal	Man City	2023-10-08 17:36:25	Lay	Under	1.50	1.50	1.59	6	Lost	2023-10-08 17:41:09.377861
189	2023-10-08 16:00:00	Stabaek	Lillestrom	2023-10-08 17:07:29	Back	Under	1.50	1.50	1.48	6	Won	2023-10-08 17:41:57.340482
209	2023-10-21 12:00:00	GAIS	Ostersunds FK	2023-10-21 13:06:12	Lay	Under	2.5	1.5	2.06	6	Lapsed	2023-10-21 13:19:47.798972
190	2023-10-08 16:30:00	Arsenal	Man City	2023-10-08 17:36:25	Back	Under	1.50	1.13	1.15	6	Won	2023-10-08 18:00:47.647932
191	2023-10-08 17:00:00	Midtjylland	Randers	2023-10-08 18:05:46	Lay	Under	2.50	1.50	1.77	6	Won	2023-10-08 18:15:08.784393
231	2023-10-21 19:00:00	Roda JC	Willem II	2023-10-21 20:06:05	Lay	Under	2.5	1.5	1.98	6	Lost	2023-10-21 20:20:38.335992
211	2023-10-21 12:30:00	Liverpool	Everton	2023-10-21 13:35:04	Lay	Under	1.5	1.5	3.25	6	Won	2023-10-21 13:57:35.327291
212	2023-10-21 12:30:00	Liverpool	Everton	2023-10-21 13:35:04	Back	Under	1.5	1.5	1.45	6	Lost	2023-10-21 14:17:24.327052
192	2023-10-08 18:00:00	Porto	Portimonense	2023-10-08 19:08:56	Lay	Under	2.50	1.50	2.20	6	Lost	2023-10-08 19:30:29.480452
195	2023-10-08 18:00:00	Porto	Portimonense	2023-10-08 19:08:56	Back	Under	2.50	1.13	1.14	6	Won	2023-10-08 19:44:47.941462
193	2023-10-08 18:15:00	Lierse	Deinze	2023-10-08 19:19:24	Lay	Under	2.50	1.50	2.18	6	Lost	2023-10-08 19:36:31.526156
196	2023-10-08 18:15:00	Lierse	Deinze	2023-10-08 19:19:24	Back	Under	2.50	1.13	1.14	6	Won	2023-10-08 19:52:54.520651
194	2023-10-08 18:30:00	Eintracht Frankfurt	FC Heidenheim	2023-10-08 19:35:28	Lay	Under	2.50	1.50	1.94	6	Lost	2023-10-08 19:46:46.918727
197	2023-10-08 18:30:00	Eintracht Frankfurt	FC Heidenheim	2023-10-08 19:35:28	Back	Under	2.50	1.50	1.50	6	Won	2023-10-08 20:13:27.576243
198	2023-10-14 15:30:00	VVV Venlo	Roda JC	2023-10-14 16:38:05	Lay	Under	1.5	1.5	2.06	6	Won	2023-10-14 16:50:35.552181
200	2023-10-15 17:00:00	Switzerland	Belarus	2023-10-15 18:04:04	Lay	Under	2.5	1.5	2.16	6	Lapsed	2023-10-15 18:18:34.578979
199	2023-10-15 17:00:00	Czech Republic	Faroe Islands	2023-10-15 18:03:59	Lay	Under	1.5	1.5	3.4	6	Lost	2023-10-15 18:27:13.909373
201	2023-10-15 17:00:00	Czech Republic	Faroe Islands	2023-10-15 18:03:59	Back	Under	1.5	1.5	1.51	6	Won	2023-10-15 18:45:10.320395
202	2023-10-15 19:45:00	Turkey	Latvia	2023-10-15 21:06:06.287014	Lay	Under	2.5	1.5	1.77	6	\N	\N
203	2023-10-15 19:45:00	Norway	Spain	2023-10-15 21:06:06	Lay	Under	2.5	1.5	1.41	6	\N	2023-10-15 21:06:17.764679
204	2023-10-15 19:45:00	Norway	Spain	2023-10-15 21:06:06	Lay	Under	2.5	1.5	1.33	6	Lost	2023-10-15 21:08:36.278005
205	2023-10-15 19:45:00	Norway	Spain	2023-10-15 21:06:06	Back	Under	2.5	1.13	1.15	6	Won	2023-10-15 21:20:06.514965
216	2023-10-21 15:00:00	Blackburn	Cardiff	2023-10-21 16:06:23	Lay	Under	1.5	1.5	1.74	6	Lapsed	2023-10-21 16:12:04.416856
206	2023-10-16 19:45:00	Greece	Netherlands	2023-10-16 21:10:01	Lay	Under	1.5	1.5	1.3	6	Lost	2023-10-16 21:10:07.828667
207	2023-10-16 19:45:00	Greece	Netherlands	2023-10-16 21:10:01	Back	Under	1.5	1.13	1.15	6	Won	2023-10-16 21:16:16.891295
208	2023-10-19 18:00:00	Vendsyssel FF	AC Horsens	2023-10-19 19:05:02	Lay	Under	2.5	1.5	2.14	6	Lapsed	2023-10-19 19:17:09.077231
210	2023-10-21 12:00:00	Paderborn	St Pauli	2023-10-21 13:06:14	Lay	Under	2.5	1.5	1.9	6	Lapsed	2023-10-21 13:07:40.285846
215	2023-10-21 15:00:00	Bournemouth	Wolves	2023-10-21 16:06:08	Lay	Under	2.5	1.5	4.2	6	Lapsed	2023-10-21 16:12:35.349914
225	2023-10-21 17:30:00	Sevilla	Real Madrid	2023-10-21 18:38:12	Lay	Under	1.5	1.5	2.08	6	\N	2023-10-21 18:52:07.100104
213	2023-10-21 14:30:00	Union Berlin	Stuttgart	2023-10-21 15:38:28	Lay	Under	2.5	1.5	1.66	6	Won	2023-10-21 15:45:42.576686
214	2023-10-21 14:30:00	Union Berlin	Stuttgart	2023-10-21 15:38:28	Back	Under	2.5	1.13	1.14	6	Lost	2023-10-21 16:04:06.545288
217	2023-10-21 15:00:00	Middlesbrough	Birmingham	2023-10-21 16:09:20	Lay	Under	1.5	1.5	1.81	6	Lost	2023-10-21 16:21:52.928429
218	2023-10-21 15:00:00	Middlesbrough	Birmingham	2023-10-21 16:09:20	Back	Under	1.5	1.13	1.15	6	Won	2023-10-21 16:39:17.081186
219	2023-10-21 16:00:00	FC Copenhagen	Vejle	2023-10-21 17:12:25	Lay	Under	1.5	1.5	2.14	6	\N	2023-10-21 17:27:56.319292
232	2023-10-21 19:30:00	FC Basel	Servette	2023-10-21 20:36:03	Lay	Under	1.5	1.5	1.84	6	Lost	2023-10-21 20:47:17.10263
238	2023-10-21 19:30:00	FC Basel	Servette	2023-10-21 20:36:03	Back	Under	1.5	1.5	1.51	6	Won	2023-10-21 21:12:47.435614
226	2023-10-21 17:45:00	PSV	Fortuna Sittard	2023-10-21 18:50:22	Lay	Under	2.5	1.5	2.44	6	Lapsed	2023-10-21 18:58:39.549154
221	2023-10-21 17:00:00	Young Boys	FC Zurich	2023-10-21 18:08:16	Lay	Under	1.5	1.5	1.84	6	Lost	2023-10-21 18:20:26.904818
224	2023-10-21 17:00:00	Young Boys	FC Zurich	2023-10-21 18:08:16	Back	Under	1.5	1.13	1.14	6	Won	2023-10-21 18:35:43.809505
220	2023-10-21 17:00:00	Stade Lausanne-Ouchy	Lausanne	2023-10-21 18:07:06	Lay	Under	2.5	1.5	1.76	6	Won	2023-10-21 18:16:20.570786
223	2023-10-21 17:00:00	Stade Lausanne-Ouchy	Lausanne	2023-10-21 18:07:06	Back	Under	2.5	1.13	1.15	6	Lost	2023-10-21 18:35:43.258386
233	2023-10-21 19:00:00	Roda JC	Willem II	2023-10-21 20:06:05	Back	Under	2.5	1.13	1.15	6	Won	2023-10-21 20:36:56.85995
222	2023-10-21 17:15:00	Molenbeek	Westerlo	2023-10-21 18:21:10	Lay	Under	1.5	1.5	1.82	6	Won	2023-10-21 18:30:56.456288
228	2023-10-21 17:15:00	Molenbeek	Westerlo	2023-10-21 18:21:10	Back	Under	1.5	1.5	1.41	6	Lost	2023-10-21 18:57:43.260961
240	2023-10-21 23:00:00	Toronto FC	Orlando City	2023-10-22 00:26:29	Lay	Under	1.5	1.5	2.02	6	Lapsed	2023-10-22 00:32:37.930719
227	2023-10-21 17:45:00	RKC Waalwijk	FC Volendam	2023-10-21 18:52:06	Lay	Under	2.5	1.5	2.04	6	Won	2023-10-21 19:05:31.979801
229	2023-10-21 17:45:00	RKC Waalwijk	FC Volendam	2023-10-21 18:52:06	Back	Under	2.5	1.13	1.14	6	Lost	2023-10-21 19:22:52.744483
230	2023-10-21 19:00:00	Zulte-Waregem	FC Liege	2023-10-21 20:03:13	Lay	Under	1.5	1.5	2.24	6	Lost	2023-10-21 20:19:01.442771
234	2023-10-21 19:00:00	Zulte-Waregem	FC Liege	2023-10-21 20:03:13	Back	Under	1.5	1.5	1.5	6	Won	2023-10-21 20:41:26.87092
235	2023-10-21 19:45:00	Charleroi	Antwerp	2023-10-21 20:50:04	Lay	Under	1.5	1.5	1.93	6	Lapsed	2023-10-21 20:53:27.187
236	2023-10-21 20:00:00	AZ Alkmaar	Heerenveen	2023-10-21 21:04:06	Lay	Under	2.5	1.5	1.8	6	\N	2023-10-21 21:14:50.558843
237	2023-10-21 20:00:00	Celta Vigo	Atletico Madrid	2023-10-21 21:07:11	Lay	Under	2.5	1.5	2.0	6	\N	2023-10-21 21:22:58.209305
239	2023-10-21 23:00:00	Charlotte FC	Inter Miami CF	2023-10-22 00:16:54	Lay	Under	2.5	1.5	2.1	6	Lapsed	2023-10-22 00:19:56.622418
241	2023-10-22 02:00:00	Vancouver Whitecaps	Los Angeles FC	2023-10-22 03:23:20	Lay	Under	2.5	1.5	2.04	6	Lapsed	2023-10-22 03:35:11.628625
243	2023-10-22 02:00:00	Colorado	Real Salt Lake	2023-10-22 03:23:21	Back	Under	1.5	1.13	1.07	6	Won	2023-10-22 03:51:28.160435
244	2023-10-22 11:15:00	FC Utrecht	Ajax	2023-10-22 12:25:43	Lay	Under	2.5	1.5	2.14	6	Lapsed	2023-10-22 12:26:31.889478
242	2023-10-22 02:00:00	Colorado	Real Salt Lake	2023-10-22 03:23:21	Lay	Under	1.5	1.5	2.1	6	Lost	2023-10-22 03:39:12.641059
247	2023-10-22 11:30:00	Roma	AC Monza	2023-10-22 12:39:07	Back	Under	1.5	1.13	1.15	6	Won	2023-10-22 13:10:18.110418
245	2023-10-22 11:30:00	Roma	AC Monza	2023-10-22 12:39:07	Lay	Under	1.5	1.5	2.08	6	Lost	2023-10-22 12:54:58.796578
270	2023-10-22 16:30:00	Malmo FF	Varbergs BoIS	2023-10-22 17:41:14	Lay	Under	2.5	1.5	2.96	6	Lapsed	2023-10-22 17:54:37.626637
264	2023-10-22 16:00:00	Ham-Kam	Haugesund	2023-10-22 17:04:06	Lay	Under	2.5	1.5	1.75	6	Won	2023-10-22 17:13:31.325797
249	2023-10-22 12:30:00	Nurnberg	Hertha Berlin	2023-10-22 13:37:17	Lay	Under	2.5	1.5	1.99	6	Lapsed	2023-10-22 13:47:22.050889
246	2023-10-22 12:00:00	Landskrona	Vasteras SK	2023-10-22 13:04:11	Lay	Under	1.5	1.5	2.32	6	Lost	2023-10-22 13:22:13.823167
250	2023-10-22 12:00:00	Landskrona	Vasteras SK	2023-10-22 13:04:11	Back	Under	1.5	1.5	1.48	6	Won	2023-10-22 13:43:39.202204
268	2023-10-22 16:00:00	Ham-Kam	Haugesund	2023-10-22 17:04:06	Back	Under	2.5	1.13	1.13	6	Lost	2023-10-22 17:32:52.81779
248	2023-10-22 12:30:00	FCV Dender	KV Oostende	2023-10-22 13:34:07	Lay	Under	2.5	1.5	1.84	6	Lost	2023-10-22 13:45:01.188836
251	2023-10-22 12:30:00	FCV Dender	KV Oostende	2023-10-22 13:34:07	Back	Under	2.5	1.13	1.15	6	Won	2023-10-22 14:01:19.418248
252	2023-10-22 13:30:00	Excelsior	PEC Zwolle	2023-10-22 14:35:11.996677	Lay	Under	2.5	1.5	2.18	6	\N	\N
257	2023-10-22 14:00:00	Toulouse	Reims	2023-10-22 15:08:43.019345	Lay	Under	1.5	1.5	1.68	6	\N	\N
272	2023-10-22 18:15:00	Viking	Tromso	2023-10-22 19:20:04	Lay	Under	1.5	1.5	1.88	6	Lapsed	2023-10-22 19:21:44.033063
256	2023-10-22 14:00:00	AaB	B93 Copenhagen	2023-10-22 15:08:17	Lay	Under	2.5	1.5	2.42	6	\N	2023-10-22 15:28:22.552616
253	2023-10-22 13:30:00	Lillestrom	Valerenga	2023-10-22 14:44:09	Lay	Under	2.5	1.5	1.75	6	Lost	2023-10-22 14:52:12.707896
258	2023-10-22 13:30:00	Lillestrom	Valerenga	2023-10-22 14:44:09	Back	Under	2.5	1.5	1.52	6	Won	2023-10-22 15:19:55.485528
255	2023-10-22 14:00:00	KFUM Oslo	Raufoss	2023-10-22 15:06:17	Lay	Under	1.5	1.5	1.75	6	Lost	2023-10-22 15:14:25.425703
259	2023-10-22 14:00:00	KFUM Oslo	Raufoss	2023-10-22 15:06:17	Back	Under	1.5	1.13	1.15	6	Won	2023-10-22 15:33:47.991018
254	2023-10-22 14:00:00	Nantes	Montpellier	2023-10-22 15:05:35	Lay	Under	2.5	1.5	1.81	6	Lost	2023-10-22 15:15:56.348964
260	2023-10-22 14:00:00	Nantes	Montpellier	2023-10-22 15:05:35	Back	Under	2.5	1.5	1.49	6	Won	2023-10-22 15:42:26.654125
261	2023-10-22 15:00:00	Viborg	FC Nordsjaelland	2023-10-22 16:05:30	Lay	Under	1.5	1.5	2.1	6	\N	2023-10-22 16:19:40.211216
271	2023-10-22 18:15:00	Francs Borains	Patro Eisden Maasmechelen	2023-10-22 19:17:03	Lay	Under	1.5	1.5	1.59	6	Lost	2023-10-22 19:19:52.429633
273	2023-10-22 18:15:00	Francs Borains	Patro Eisden Maasmechelen	2023-10-22 19:17:03	Back	Under	1.5	1.13	1.15	6	Won	2023-10-22 19:40:23.550191
265	2023-10-22 16:00:00	Rapid Vienna	Austria Klagenfurt	2023-10-22 17:08:07	Lay	Under	2.5	1.5	2.1	6	Lapsed	2023-10-22 17:20:41.502129
266	2023-10-22 16:00:00	Stromsgodset	Odds BK	2023-10-22 17:09:22	Lay	Under	2.5	1.5	1.93	6	\N	2023-10-22 17:22:13.566728
262	2023-10-22 15:30:00	Grasshoppers Zurich	Lugano	2023-10-22 16:37:06	Lay	Under	1.5	1.5	2.02	6	Won	2023-10-22 16:50:44.562959
263	2023-10-22 15:45:00	Go Ahead Eagles	Sparta Rotterdam	2023-10-22 16:50:21	Lay	Under	1.5	1.5	2.22	6	Lost	2023-10-22 17:07:50.049562
267	2023-10-22 15:45:00	Go Ahead Eagles	Sparta Rotterdam	2023-10-22 16:50:21	Back	Under	1.5	1.13	1.15	6	Won	2023-10-22 17:21:06.282568
269	2023-10-22 16:30:00	Aston Villa	West Ham	2023-10-22 17:36:14	Lay	Under	2.5	1.5	2.06	6	Lapsed	2023-10-22 17:45:30.152617
274	2023-10-22 20:00:00	Barcelona	Athletic Bilbao	2023-10-22 21:07:05	Lay	Under	1.5	1.5	1.84	6	Lost	2023-10-22 21:19:50.058541
275	2023-10-22 20:00:00	Barcelona	Athletic Bilbao	2023-10-22 21:07:05	Back	Under	1.5	1.13	1.14	6	Won	2023-10-22 21:37:15.762021
\.


--
-- TOC entry 3416 (class 0 OID 16531)
-- Dependencies: 215
-- Data for Name: over2p5footballsupertips; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5footballsupertips (id, home, away, date_time, url, league_id) FROM stdin;
1	Wolfsberger AC	LASK Linz	2023-09-30 16:00:00	\N	43
2	FC Blau Weiss Linz	Austria Klagenfurt	2023-09-30 16:00:00	\N	43
3	Austria Lustenau	FC Salzburg	2023-09-30 16:00:00	\N	43
4	Eupen	Anderlecht	2023-09-30 15:00:00	\N	68
5	OH Leuven	Standard Liege	2023-09-30 17:15:00	\N	68
6	KV Mechelen	Antwerp	2023-09-30 19:45:00	\N	68
7	KFCO Beerschot Wilrijk	KV Oostende	2023-09-30 15:00:00	\N	136
8	Anderlecht II	Lierse Kempenzonen	2023-09-30 19:00:00	\N	136
9	Francs Borains	RFC Seraing	2023-09-30 19:00:00	\N	136
10	FC Copenhagen	Midtjylland	2023-09-30 14:00:00	\N	40
11	Sonderjyske	B93 Copenhagen	2023-09-30 13:00:00	\N	147
12	Aston Villa	Brighton	2023-09-30 12:30:00	\N	2
13	Bournemouth	Arsenal	2023-09-30 15:00:00	\N	2
14	Man Utd	Crystal Palace	2023-09-30 15:00:00	\N	2
15	Newcastle	Burnley	2023-09-30 15:00:00	\N	2
16	West Ham	Sheff Utd	2023-09-30 15:00:00	\N	2
17	Wolverhampton	Man City	2023-09-30 15:00:00	\N	2
18	Southampton	Leeds	2023-09-30 12:30:00	\N	77
19	Bristol City	Stoke	2023-09-30 15:00:00	\N	77
20	Cardiff	Rotherham	2023-09-30 15:00:00	\N	77
21	Huddersfield	Ipswich	2023-09-30 15:00:00	\N	77
22	Hull	Plymouth	2023-09-30 15:00:00	\N	77
23	Millwall	Swansea	2023-09-30 15:00:00	\N	77
24	Norwich	Birmingham	2023-09-30 15:00:00	\N	77
25	Clermont Foot	PSG	2023-09-30 16:00:00	\N	5
26	Monaco	Marseille	2023-09-30 20:00:00	\N	5
27	Wolfsburg	Eintracht Frankfurt	2023-09-30 14:30:00	\N	1
28	Mainz	Bayer Leverkusen	2023-09-30 14:30:00	\N	1
29	Cologne	VfB Stuttgart	2023-09-30 14:30:00	\N	1
30	Bochum	Borussia Mgladbach	2023-09-30 14:30:00	\N	1
31	Heidenheim	Union Berlin	2023-09-30 14:30:00	\N	1
32	RB Leipzig	Bayern Munich	2023-09-30 17:30:00	\N	1
33	Karlsruher SC	Holstein Kiel	2023-09-30 12:00:00	\N	93
34	Hannover 96	Wehen SV	2023-09-30 12:00:00	\N	93
35	Hansa Rostock	Eintracht Braunschweig	2023-09-30 12:00:00	\N	93
36	Hertha Berlin	St Pauli	2023-09-30 19:30:00	\N	93
37	AC Milan	Lazio	2023-09-30 17:00:00	\N	4
38	Salernitana	Inter Milan	2023-09-30 19:45:00	\N	4
39	Consadole Sapporo	Kashiwa Reysol	2023-09-30 05:00:00	\N	28
40	Cerezo Osaka	Shonan Bellmare	2023-09-30 10:00:00	\N	28
41	Sagan Tosu	Kyoto Sanga FC	2023-09-30 11:00:00	\N	28
42	Feyenoord	Go Ahead Eagles	2023-09-30 15:30:00	\N	196
43	FC Utrecht	Almere City FC	2023-09-30 17:45:00	\N	196
44	PSV	FC Volendam	2023-09-30 17:45:00	\N	196
45	FC Twente	Heerenveen	2023-09-30 20:00:00	\N	196
46	RKC	Ajax	2023-09-30 20:00:00	\N	196
47	FK Jerv	Sogndal	2023-09-30 14:00:00	\N	204
48	Kristiansund BK	KFUM	2023-09-30 14:00:00	\N	204
49	Mjondalen	Skeid	2023-09-30 14:00:00	\N	204
50	Sandnes Ulf	IK Start	2023-09-30 14:00:00	\N	204
51	Vizela	Portimonense	2023-09-30 15:30:00	\N	8
52	Boavista	Famalicao	2023-09-30 18:00:00	\N	8
53	SC Farense	Sporting	2023-09-30 20:30:00	\N	8
54	Suwon FC	FC Seoul	2023-09-30 06:00:00	\N	66
55	Jeonbuk Motors	Daegu FC	2023-09-30 08:30:00	\N	66
56	Incheon Utd	Suwon Bluewings	2023-09-30 11:00:00	\N	66
57	Girona	Real Madrid	2023-09-30 17:30:00	\N	3
58	IFK Norrkoping	Kalmar FF	2023-09-30 16:30:00	\N	14
59	Servette	Lausanne Sports	2023-09-30 17:00:00	\N	15
60	Winterthur	Lugano	2023-09-30 17:00:00	\N	15
61	Grasshoppers	Young Boys	2023-09-30 19:30:00	\N	15
68	Houston Dynamo	FC Dallas	2023-10-01 01:30:00	\N	76
66	Orlando City SC	CF Montreal	2023-10-01 00:30:00	\N	76
69	SK Sturm Graz	WSG Swarovski Tirol	2023-10-01 13:30:00	\N	43
70	Hartberg	SCR Altach	2023-10-01 13:30:00	\N	43
71	FK Austria Vienna	Rapid Vienna	2023-10-01 16:00:00	\N	43
72	Union Saint Gilloise	Charleroi	2023-10-01 12:30:00	\N	68
73	Genk	Westerlo	2023-10-01 15:00:00	\N	68
74	Club Brugge	Sint-Truidense	2023-10-01 17:30:00	\N	68
75	RWD Molenbeek	Gent	2023-10-01 18:15:00	\N	68
76	Zulte-Waregem	Club Brugge II	2023-10-01 12:30:00	\N	136
77	RFC Liege	Lommel	2023-10-01 15:00:00	\N	136
78	FCV Dender EH	Genk II	2023-10-01 18:15:00	\N	136
79	Vejle	FC Nordsjaelland	2023-10-01 13:00:00	\N	40
80	Randers FC	Silkeborg IF	2023-10-01 13:00:00	\N	40
81	Hvidovre IF	Brondby	2023-10-01 15:00:00	\N	40
82	HB Køge	FC Helsingor	2023-10-01 12:00:00	\N	147
83	FC Fredericia	Naestved IF	2023-10-01 13:00:00	\N	147
84	Blackburn	Leicester	2023-10-01 12:00:00	\N	77
85	Reims	Lyon	2023-10-01 12:00:00	\N	5
86	Toulouse	Metz	2023-10-01 14:00:00	\N	5
87	Nice	Brest	2023-10-01 14:00:00	\N	5
88	Le Havre	Lille	2023-10-01 14:00:00	\N	5
89	Lorient	Montpellier	2023-10-01 16:05:00	\N	5
90	Rennes	Nantes	2023-10-01 19:45:00	\N	5
92	SC Freiburg	Augsburg	2023-10-01 16:30:00	\N	1
93	Nurnberg	Magdeburg	2023-10-01 12:30:00	\N	93
94	Elversberg	Greuther Furth	2023-10-01 12:30:00	\N	93
95	VfL Osnabruck	Kaiserslautern	2023-10-01 12:30:00	\N	93
96	FC Tokyo	Gamba Osaka	2023-10-01 07:00:00	\N	28
97	NEC	Vitesse	2023-10-01 11:15:00	\N	196
98	Excelsior	Sparta Rotterdam	2023-10-01 13:30:00	\N	196
99	Heracles	PEC Zwolle	2023-10-01 13:30:00	\N	196
100	AZ	Fortuna Sittard	2023-10-01 15:45:00	\N	196
101	VVV	Helmond Sport	2023-10-01 11:15:00	\N	199
102	Lillestrom	SK Brann	2023-10-01 14:00:00	\N	13
103	Sandefjord	Valerenga	2023-10-01 16:00:00	\N	13
104	Molde	Viking FK	2023-10-01 16:00:00	\N	13
63	Inter Miami CF	New York City FC	2023-10-01 00:30:00	\N	76
65	New York Red Bulls	Chicago Fire	2023-10-01 00:30:00	\N	76
277	Birmingham	Huddersfield	2023-10-03 19:45:00	\N	77
278	Ipswich	Hull	2023-10-03 19:45:00	\N	77
279	Middlesbrough	Cardiff	2023-10-03 19:45:00	\N	77
280	Plymouth	Millwall	2023-10-03 19:45:00	\N	77
281	Stoke	Southampton	2023-10-03 20:00:00	\N	77
282	Willem II	Top Oss	2023-10-03 19:00:00	\N	199
283	GAIS	Osters IF	2023-10-03 18:00:00	\N	336
284	Landskrona	GIF Sundsvall	2023-10-03 18:00:00	\N	336
285	Helsingborg	Orebro SK	2023-10-03 18:00:00	\N	336
286	Gefle IF	Orgryte IS	2023-10-03 18:00:00	\N	336
287	Union Berlin	Braga	2023-10-03 17:45:00	\N	244
288	FC Salzburg	Real Sociedad	2023-10-03 17:45:00	\N	244
289	Man Utd	Galatasaray	2023-10-03 20:00:00	\N	244
91	Darmstadt	Werder Bremen	2023-10-01 14:30:00	\N	1
105	Bodo/Glimt	Stromsgodset	2023-10-01 18:15:00	\N	13
106	Fredrikstad	Raufoss	2023-10-01 14:00:00	\N	204
107	Kongsvinger	Bryne	2023-10-01 14:00:00	\N	204
108	Moss	Hodd	2023-10-01 14:00:00	\N	204
109	Asane	Ranheim	2023-10-01 14:00:00	\N	204
110	FC Arouca	Chaves	2023-10-01 15:30:00	\N	8
111	Guimaraes	Estoril	2023-10-01 18:00:00	\N	8
112	Rio Ave	Moreirense	2023-10-01 20:30:00	\N	8
113	Gangwon FC	Daejeon Hana Citizen	2023-10-01 06:00:00	\N	66
114	Almeria	Granada	2023-10-01 13:00:00	\N	3
115	Real Betis	Valencia	2023-10-01 20:00:00	\N	3
116	BK Hacken	AIK	2023-10-01 14:00:00	\N	14
117	Sirius	Degerfors	2023-10-01 14:00:00	\N	14
118	Hammarby	IFK Goteborg	2023-10-01 16:30:00	\N	14
119	Mjällby AIF	IFK Varnamo	2023-10-01 16:30:00	\N	14
120	Västerås SK FK	Trelleborgs FF	2023-10-01 14:00:00	\N	336
121	Yverdon Sport FC	St Gallen	2023-10-01 13:15:00	\N	15
122	Basel	Stade Lausanne-Ouchy	2023-10-01 15:30:00	\N	15
123	Lucerne	FC Zurich	2023-10-01 15:30:00	\N	15
62	Columbus Crew	Philadelphia Union	2023-10-01 00:30:00	\N	76
64	New England Revolution	Charlotte FC	2023-10-01 00:30:00	\N	76
67	Toronto FC	FC Cincinnati	2023-10-01 00:30:00	\N	76
255	Odense BK	Lyngby	2023-10-02 18:00:00	\N	40
256	Fulham	Chelsea	2023-10-02 20:00:00	\N	2
257	Sassuolo	Monza	2023-10-02 17:30:00	\N	4
258	Maastricht	FC Eindhoven	2023-10-02 19:00:00	\N	199
259	FC Utrecht Reserves	NAC	2023-10-02 19:00:00	\N	199
260	Elfsborg	Varbergs BoIS FC	2023-10-02 18:00:00	\N	14
261	Malmo FF	Brommapojkarna	2023-10-02 18:10:00	\N	14
262	Jonkopings Sodra	Ostersunds FK	2023-10-02 18:00:00	\N	336
263	IK Brage	Skövde AIK	2023-10-02 18:00:00	\N	336
264	Utsiktens BK	AFC Eskilstuna	2023-10-02 18:00:00	\N	336
130	Los Angeles FC	Real Salt Lake	2023-10-02 01:00:00	\N	76
290	FC Copenhagen	Bayern Munich	2023-10-03 20:00:00	\N	244
291	PSV	Sevilla	2023-10-03 20:00:00	\N	244
292	Lens	Arsenal	2023-10-03 20:00:00	\N	244
293	Napoli	Real Madrid	2023-10-03 20:00:00	\N	244
294	Inter Milan	Benfica	2023-10-03 20:00:00	\N	244
313	Coventry	Blackburn	2023-10-04 19:45:00	\N	77
314	Leeds	QPR	2023-10-04 19:45:00	\N	77
315	Sunderland	Watford	2023-10-04 19:45:00	\N	77
316	Swansea	Norwich	2023-10-04 19:45:00	\N	77
317	Rotherham	Bristol City	2023-10-04 20:00:00	\N	77
318	Stabaek	HamKam	2023-10-04 18:00:00	\N	13
319	Sogndal	Kristiansund BK	2023-10-04 17:00:00	\N	204
320	Antwerp	Shakhtar Donetsk	2023-10-04 17:45:00	\N	244
321	Atletico Madrid	Feyenoord	2023-10-04 17:45:00	\N	244
322	Celtic	Lazio	2023-10-04 20:00:00	\N	244
323	Borussia Dortmund	AC Milan	2023-10-04 20:00:00	\N	244
324	Newcastle	PSG	2023-10-04 20:00:00	\N	244
325	RB Leipzig	Man City	2023-10-04 20:00:00	\N	244
326	Crvena Zvezda	Young Boys	2023-10-04 20:00:00	\N	244
327	FC Porto	Barcelona	2023-10-04 20:00:00	\N	244
330	CF Montreal	Houston Dynamo	2023-10-05 00:30:00	\N	76
357	SC Freiburg	West Ham	2023-10-05 17:45:00	\N	245
358	FK Backa Topola	Olympiakos	2023-10-05 17:45:00	\N	245
359	Marseille	Brighton	2023-10-05 17:45:00	\N	245
360	AEK Athens	Ajax	2023-10-05 17:45:00	\N	245
361	Real Betis	Sparta Prague	2023-10-05 17:45:00	\N	245
362	Aris Limassol	Rangers	2023-10-05 17:45:00	\N	245
363	Sporting	Atalanta	2023-10-05 17:45:00	\N	245
328	Charlotte FC	Toronto FC	2023-10-05 00:30:00	\N	76
329	FC Cincinnati	New York Red Bulls	2023-10-05 00:30:00	\N	76
331	New England Revolution	Columbus Crew	2023-10-05 00:30:00	\N	76
332	Philadelphia Union	Atlanta United	2023-10-05 00:30:00	\N	76
333	Austin FC	DC United	2023-10-05 01:30:00	\N	76
334	Chicago Fire	Inter Miami CF	2023-10-05 01:30:00	\N	76
488	FK Austria Vienna	FC Blau Weiss Linz	2023-10-07 16:00:00	\N	43
489	Austria Lustenau	Rapid Vienna	2023-10-07 16:00:00	\N	43
490	Hartberg	WSG Swarovski Tirol	2023-10-07 16:00:00	\N	43
491	Cercle Brugge	OH Leuven	2023-10-07 15:00:00	\N	68
396	Charleroi	RWD Molenbeek	2023-10-06 19:45:00	\N	68
492	Westerlo	KV Kortrijk	2023-10-07 17:15:00	\N	68
493	Anderlecht	KV Mechelen	2023-10-07 19:45:00	\N	68
494	Genk II	KFCO Beerschot Wilrijk	2023-10-07 15:00:00	\N	136
495	Patro Eisden Maasmechelen	RFC Liege	2023-10-07 19:00:00	\N	136
496	Kolding IF	HB Køge	2023-10-07 14:00:00	\N	147
497	Luton	Tottenham	2023-10-07 12:30:00	\N	2
397	Lommel	Standard Liege II	2023-10-06 19:00:00	\N	136
398	RFC Seraing	FCV Dender EH	2023-10-06 19:00:00	\N	136
399	Silkeborg IF	Lyngby	2023-10-06 18:00:00	\N	40
400	FC Fredericia	Sonderjyske	2023-10-06 17:30:00	\N	147
401	AC Horsens	AaB	2023-10-06 18:00:00	\N	147
402	B93 Copenhagen	Hillerød	2023-10-06 18:00:00	\N	147
403	Strasbourg	Nantes	2023-10-06 20:00:00	\N	5
404	Borussia Mgladbach	Mainz	2023-10-06 19:30:00	\N	1
405	Fortuna Dusseldorf	VfL Osnabruck	2023-10-06 17:30:00	\N	93
406	Kaiserslautern	Hannover 96	2023-10-06 17:30:00	\N	93
407	Empoli	Udinese	2023-10-06 17:30:00	\N	4
408	Lecce	Sassuolo	2023-10-06 19:45:00	\N	4
409	FC Volendam	FC Utrecht	2023-10-06 19:00:00	\N	196
410	ADO Den Haag	Top Oss	2023-10-06 19:00:00	\N	199
411	FC Den Bosch	FC Eindhoven	2023-10-06 19:00:00	\N	199
412	FC Emmen	Telstar	2023-10-06 19:00:00	\N	199
413	Helmond Sport	FC Utrecht Reserves	2023-10-06 19:00:00	\N	199
414	Ajax Reserves	VVV	2023-10-06 19:00:00	\N	199
415	Willem II	De Graafschap	2023-10-06 19:00:00	\N	199
416	NAC	FC Groningen	2023-10-06 19:00:00	\N	199
417	Moreirense	Boavista	2023-10-06 20:15:00	\N	8
418	Athletic Bilbao	Almeria	2023-10-06 20:00:00	\N	3
548	CF Montreal	Portland Timbers	2023-10-08 00:30:00	\N	76
808	LASK Linz	SCR Altach	2023-10-08 13:30:00	\N	43
498	Burnley	Chelsea	2023-10-07 15:00:00	\N	2
499	Everton	Bournemouth	2023-10-07 15:00:00	\N	2
500	Man Utd	Brentford	2023-10-07 15:00:00	\N	2
501	Sunderland	Middlesbrough	2023-10-07 12:30:00	\N	77
502	Coventry	Norwich	2023-10-07 15:00:00	\N	77
503	Ipswich	Preston	2023-10-07 15:00:00	\N	77
504	Leeds	Bristol City	2023-10-07 15:00:00	\N	77
505	Leicester	Stoke	2023-10-07 15:00:00	\N	77
506	Millwall	Hull	2023-10-07 15:00:00	\N	77
507	Metz	Nice	2023-10-07 16:00:00	\N	5
508	Reims	Monaco	2023-10-07 20:00:00	\N	5
509	Borussia Dortmund	Union Berlin	2023-10-07 14:30:00	\N	1
510	RB Leipzig	Bochum	2023-10-07 14:30:00	\N	1
511	Augsburg	Darmstadt	2023-10-07 14:30:00	\N	1
512	VfB Stuttgart	Wolfsburg	2023-10-07 14:30:00	\N	1
513	Werder Bremen	TSG Hoffenheim	2023-10-07 17:30:00	\N	1
514	Magdeburg	Karlsruher SC	2023-10-07 12:00:00	\N	93
515	Greuther Furth	Hansa Rostock	2023-10-07 12:00:00	\N	93
516	Wehen SV	Hamburg	2023-10-07 12:00:00	\N	93
517	St Pauli	Nurnberg	2023-10-07 19:30:00	\N	93
518	Inter Milan	Bologna	2023-10-07 14:00:00	\N	4
519	Genoa	AC Milan	2023-10-07 19:45:00	\N	4
536	Halmstad	Degerfors	2023-10-07 14:00:00	\N	14
537	IFK Goteborg	Sirius	2023-10-07 16:30:00	\N	14
538	Västerås SK FK	Jonkopings Sodra	2023-10-07 14:00:00	\N	336
539	Skövde AIK	Gefle IF	2023-10-07 14:00:00	\N	336
540	Osters IF	Orebro SK	2023-10-07 14:00:00	\N	336
541	Ostersunds FK	Helsingborg	2023-10-07 16:00:00	\N	336
542	Yverdon Sport FC	Grasshoppers	2023-10-07 17:00:00	\N	15
543	FC Zurich	Winterthur	2023-10-07 17:00:00	\N	15
544	St Gallen	Stade Lausanne-Ouchy	2023-10-07 19:30:00	\N	15
814	Sint-Truidense	Union Saint Gilloise	2023-10-08 18:15:00	\N	68
815	SK Beveren	Zulte-Waregem	2023-10-08 12:30:00	\N	136
819	Vejle	Hvidovre IF	2023-10-08 13:00:00	\N	40
820	Brondby	Viborg	2023-10-08 15:00:00	\N	40
821	Midtjylland	Randers FC	2023-10-08 17:00:00	\N	40
822	AGF Aarhus	FC Copenhagen	2023-10-08 19:00:00	\N	40
825	West Ham	Newcastle	2023-10-08 14:00:00	\N	2
816	KV Oostende	Anderlecht II	2023-10-08 15:00:00	\N	136
817	Lierse Kempenzonen	Deinze	2023-10-08 18:15:00	\N	136
818	FC Nordsjaelland	Odense BK	2023-10-08 13:00:00	\N	40
823	Naestved IF	Hobro IK	2023-10-08 12:00:00	\N	147
826	Wolverhampton	Aston Villa	2023-10-08 14:00:00	\N	2
827	Arsenal	Man City	2023-10-08 16:30:00	\N	2
828	Lyon	Lorient	2023-10-08 14:00:00	\N	5
829	Montpellier	Clermont Foot	2023-10-08 14:00:00	\N	5
830	Brest	Toulouse	2023-10-08 14:00:00	\N	5
831	Lens	Lille	2023-10-08 16:05:00	\N	5
832	Rennes	PSG	2023-10-08 19:45:00	\N	5
833	Bayer Leverkusen	Cologne	2023-10-08 14:30:00	\N	1
834	Bayern Munich	SC Freiburg	2023-10-08 16:30:00	\N	1
835	Eintracht Frankfurt	Heidenheim	2023-10-08 18:30:00	\N	1
520	Heerenveen	NEC	2023-10-07 15:30:00	\N	196
521	Almere City FC	RKC	2023-10-07 17:45:00	\N	196
522	Go Ahead Eagles	Heracles	2023-10-07 19:00:00	\N	196
523	Vitesse	Excelsior	2023-10-07 20:00:00	\N	196
524	Odd BK	Viking FK	2023-10-07 17:00:00	\N	13
525	Raufoss	Mjondalen	2023-10-07 14:00:00	\N	204
526	Skeid	Sandnes Ulf	2023-10-07 14:00:00	\N	204
527	Sogndal	Moss	2023-10-07 14:00:00	\N	204
528	Hodd	Kristiansund BK	2023-10-07 17:00:00	\N	204
529	SC Farense	Vizela	2023-10-07 15:30:00	\N	8
530	Chaves	Gil Vicente	2023-10-07 15:30:00	\N	8
531	Braga	Rio Ave	2023-10-07 18:00:00	\N	8
532	Estoril	Benfica	2023-10-07 20:30:00	\N	8
533	Cadiz	Girona	2023-10-07 13:00:00	\N	3
534	Real Madrid	Osasuna	2023-10-07 15:15:00	\N	3
535	Sevilla	Rayo Vallecano	2023-10-07 20:00:00	\N	3
836	Schalke	Hertha Berlin	2023-10-08 12:30:00	\N	93
837	Holstein Kiel	Elversberg	2023-10-08 12:30:00	\N	93
838	Eintracht Braunschweig	Paderborn	2023-10-08 12:30:00	\N	93
545	Atlanta United	Columbus Crew	2023-10-08 00:30:00	\N	76
546	DC United	New York City FC	2023-10-08 00:30:00	\N	76
547	Inter Miami CF	FC Cincinnati	2023-10-08 00:30:00	\N	76
549	New York Red Bulls	Toronto FC	2023-10-08 00:30:00	\N	76
550	Orlando City SC	New England Revolution	2023-10-08 00:30:00	\N	76
551	Philadelphia Union	Nashville SC	2023-10-08 00:30:00	\N	76
809	Wolfsberger AC	SK Sturm Graz	2023-10-08 13:30:00	\N	43
810	Austria Klagenfurt	FC Salzburg	2023-10-08 16:00:00	\N	43
811	Standard Liege	Club Brugge	2023-10-08 12:30:00	\N	68
812	Antwerp	Eupen	2023-10-08 15:00:00	\N	68
813	Gent	Genk	2023-10-08 17:30:00	\N	68
824	Brighton	Liverpool	2023-10-08 14:00:00	\N	2
870	Hammarby	BK Hacken	2023-10-08 16:30:00	\N	14
871	Varbergs BoIS FC	Djurgarden	2023-10-08 16:30:00	\N	14
872	AFC Eskilstuna	Landskrona	2023-10-08 12:00:00	\N	336
873	Trelleborgs FF	GAIS	2023-10-08 12:00:00	\N	336
874	Orgryte IS	Utsiktens BK	2023-10-08 14:00:00	\N	336
875	GIF Sundsvall	IK Brage	2023-10-08 14:00:00	\N	336
876	Lugano	Servette	2023-10-08 13:15:00	\N	15
877	Lausanne Sports	Lucerne	2023-10-08 15:30:00	\N	15
878	Young Boys	Basel	2023-10-08 15:30:00	\N	15
1193	Greece	Netherlands	2023-10-16 19:45:00	\N	274
1120	FC Helsingor	Vendsyssel FF	2023-10-09 18:00:00	\N	147
1194	Belgium	Sweden	2023-10-16 19:45:00	\N	274
1195	Iceland	Liechtenstein	2023-10-16 19:45:00	\N	274
1223	KV Kortrijk	Club Brugge	2023-10-21 15:00:00	\N	68
1224	RWD Molenbeek	Westerlo	2023-10-21 17:15:00	\N	68
1206	San Marino	Denmark	2023-10-17 19:45:00	\N	274
1123	Spain	Scotland	2023-10-12 19:45:00	\N	274
1124	Cyprus	Norway	2023-10-12 19:45:00	\N	274
1225	Charleroi	Antwerp	2023-10-21 19:45:00	\N	68
1226	Anderlecht II	Standard Liege II	2023-10-21 15:00:00	\N	136
1227	Zulte-Waregem	RFC Liege	2023-10-21 19:00:00	\N	136
1131	Portugal	Slovakia	2023-10-13 19:45:00	\N	274
1132	Liechtenstein	Bosnia-Herzegovina	2023-10-13 19:45:00	\N	274
1133	Netherlands	France	2023-10-13 19:45:00	\N	274
1164	Czech Republic	Faroe Islands	2023-10-15 17:00:00	\N	274
1165	Switzerland	Belarus	2023-10-15 17:00:00	\N	274
1166	Norway	Spain	2023-10-15 19:45:00	\N	274
1167	Turkey	Latvia	2023-10-15 19:45:00	\N	274
1168	Willem II	FC Den Bosch	2023-10-15 13:30:00	\N	199
1169	Cambuur Leeuwarden	NAC	2023-10-15 15:45:00	\N	199
1145	FC Dallas	Colorado Rapids	2023-10-15 01:30:00	\N	76
1140	Northern Ireland	San Marino	2023-10-14 14:00:00	\N	274
1141	Italy	Malta	2023-10-14 19:45:00	\N	274
1142	Denmark	Kazakhstan	2023-10-14 19:45:00	\N	274
1143	VVV	Roda JC	2023-10-14 15:30:00	\N	199
1144	Telstar	Maastricht	2023-10-14 19:00:00	\N	199
1228	Lierse Kempenzonen	RFC Seraing	2023-10-21 19:00:00	\N	136
1229	FC Copenhagen	Vejle	2023-10-21 16:00:00	\N	40
1230	Liverpool	Everton	2023-10-21 12:30:00	\N	2
1146	Nashville SC	New England Revolution	2023-10-15 01:30:00	\N	76
1147	LA Galaxy	Real Salt Lake	2023-10-15 03:30:00	\N	76
839	Monza	Salernitana	2023-10-08 11:30:00	\N	4
840	Frosinone	Verona	2023-10-08 14:00:00	\N	4
841	Napoli	Fiorentina	2023-10-08 19:45:00	\N	4
842	PEC Zwolle	Feyenoord	2023-10-08 11:15:00	\N	196
843	Fortuna Sittard	FC Twente	2023-10-08 13:30:00	\N	196
844	Ajax	AZ	2023-10-08 13:30:00	\N	196
845	Sparta Rotterdam	PSV	2023-10-08 15:45:00	\N	196
846	Haugesund	Stromsgodset	2023-10-08 16:00:00	\N	13
847	Molde	Bodo/Glimt	2023-10-08 16:00:00	\N	13
848	Sandefjord	HamKam	2023-10-08 16:00:00	\N	13
849	Sarpsborg	Rosenborg	2023-10-08 16:00:00	\N	13
850	Stabaek	Lillestrom	2023-10-08 16:00:00	\N	13
851	Tromso	Aalesund	2023-10-08 16:00:00	\N	13
852	Valerenga	SK Brann	2023-10-08 18:15:00	\N	13
853	KFUM	Bryne	2023-10-08 14:00:00	\N	204
854	Ranheim	FK Jerv	2023-10-08 14:00:00	\N	204
855	IK Start	Kongsvinger	2023-10-08 14:00:00	\N	204
856	Asane	Fredrikstad	2023-10-08 14:00:00	\N	204
857	FC Porto	Portimonense	2023-10-08 18:00:00	\N	8
858	Sporting	FC Arouca	2023-10-08 20:30:00	\N	8
859	Daegu FC	Suwon FC	2023-10-08 07:00:00	\N	66
860	FC Seoul	Jeonbuk Motors	2023-10-08 07:00:00	\N	66
861	Daejeon Hana Citizen	Jeju United	2023-10-08 07:00:00	\N	66
862	Ulsan Hyundai	Incheon Utd	2023-10-08 07:00:00	\N	66
863	Suwon Bluewings	Pohang Steelers	2023-10-08 07:00:00	\N	66
864	Gwangju FC	Gangwon FC	2023-10-08 07:00:00	\N	66
865	Villarreal	Las Palmas	2023-10-08 13:00:00	\N	3
866	Granada	Barcelona	2023-10-08 20:00:00	\N	3
867	Kalmar FF	Malmo FF	2023-10-08 14:00:00	\N	14
868	IFK Varnamo	IFK Norrkoping	2023-10-08 14:00:00	\N	14
869	Brommapojkarna	Elfsborg	2023-10-08 14:00:00	\N	14
1214	Vendsyssel FF	AC Horsens	2023-10-19 18:00:00	\N	147
1210	Inter Miami CF	Charlotte FC	2023-10-19 01:00:00	\N	76
1231	Bournemouth	Wolverhampton	2023-10-21 15:00:00	\N	2
1232	Brentford	Burnley	2023-10-21 15:00:00	\N	2
1233	Man City	Brighton	2023-10-21 15:00:00	\N	2
1191	Azerbaijan	Austria	2023-10-16 17:00:00	\N	274
1192	Gibraltar	Rep of Ireland	2023-10-16 19:45:00	\N	274
1234	Chelsea	Arsenal	2023-10-21 17:30:00	\N	2
1235	Blackburn	Cardiff	2023-10-21 15:00:00	\N	77
1236	Huddersfield	QPR	2023-10-21 15:00:00	\N	77
1237	Hull	Southampton	2023-10-21 15:00:00	\N	77
1238	Middlesbrough	Birmingham	2023-10-21 15:00:00	\N	77
1239	Norwich	Leeds	2023-10-21 15:00:00	\N	77
1220	FC Salzburg	LASK Linz	2023-10-21 16:00:00	\N	43
1221	SK Sturm Graz	Hartberg	2023-10-21 16:00:00	\N	43
1222	FC Blau Weiss Linz	Austria Lustenau	2023-10-21 16:00:00	\N	43
1259	RKC	FC Volendam	2023-10-21 17:45:00	\N	196
1260	PSV	Fortuna Sittard	2023-10-21 17:45:00	\N	196
1261	NEC	Almere City FC	2023-10-21 19:00:00	\N	196
1262	Feyenoord	Vitesse	2023-10-21 20:00:00	\N	196
1263	AZ	Heerenveen	2023-10-21 20:00:00	\N	196
1264	Roda JC	Willem II	2023-10-21 19:00:00	\N	199
1265	Bodo/Glimt	Sandefjord	2023-10-21 14:00:00	\N	13
1266	SK Brann	Molde	2023-10-21 17:00:00	\N	13
1267	Hodd	Sogndal	2023-10-21 14:00:00	\N	204
1268	FK Jerv	Kongsvinger	2023-10-21 14:00:00	\N	204
1269	Kristiansund BK	Asane	2023-10-21 14:00:00	\N	204
1270	Mjondalen	IK Start	2023-10-21 14:00:00	\N	204
1271	Sandnes Ulf	Fredrikstad	2023-10-21 14:00:00	\N	204
1272	Gwangju FC	Ulsan Hyundai	2023-10-21 06:00:00	\N	66
1273	Sevilla	Real Madrid	2023-10-21 17:30:00	\N	3
1274	Celta Vigo	Atletico Madrid	2023-10-21 20:00:00	\N	3
1275	Sirius	Brommapojkarna	2023-10-21 16:30:00	\N	14
1276	GAIS	Ostersunds FK	2023-10-21 12:00:00	\N	336
1277	Helsingborg	Gefle IF	2023-10-21 14:00:00	\N	336
1446	Rapid Vienna	Austria Klagenfurt	2023-10-22 16:00:00	\N	43
1290	St. Louis City SC	Seattle Sounders FC	2023-10-22 02:00:00	\N	76
1240	PSG	Strasbourg	2023-10-21 16:00:00	\N	5
1241	Nice	Marseille	2023-10-21 20:00:00	\N	5
1242	Union Berlin	VfB Stuttgart	2023-10-21 14:30:00	\N	1
1243	SC Freiburg	Bochum	2023-10-21 14:30:00	\N	1
1244	Wolfsburg	Bayer Leverkusen	2023-10-21 14:30:00	\N	1
1245	TSG Hoffenheim	Eintracht Frankfurt	2023-10-21 14:30:00	\N	1
1246	Darmstadt	RB Leipzig	2023-10-21 14:30:00	\N	1
1247	Mainz	Bayern Munich	2023-10-21 17:30:00	\N	1
1248	Paderborn	St Pauli	2023-10-21 12:00:00	\N	93
1249	VfL Osnabruck	Wehen SV	2023-10-21 12:00:00	\N	93
1250	Hamburg	Greuther Furth	2023-10-21 12:00:00	\N	93
1251	Fortuna Dusseldorf	Kaiserslautern	2023-10-21 19:30:00	\N	93
1252	Verona	Napoli	2023-10-21 14:00:00	\N	4
1253	Sassuolo	Lazio	2023-10-21 19:45:00	\N	4
1254	Albirex Niigata	Sagan Tosu	2023-10-21 05:00:00	\N	28
1255	Yokohama F-Marinos	Consadole Sapporo	2023-10-21 06:00:00	\N	28
1256	Yokohama FC	FC Tokyo	2023-10-21 06:00:00	\N	28
1257	Vissel Kobe	Kashima Antlers	2023-10-21 06:00:00	\N	28
1258	Kyoto Sanga FC	Shonan Bellmare	2023-10-21 07:00:00	\N	28
1278	Stade Lausanne-Ouchy	Lausanne Sports	2023-10-21 17:00:00	\N	15
1279	Young Boys	FC Zurich	2023-10-21 17:00:00	\N	15
1280	Basel	Servette	2023-10-21 19:30:00	\N	15
1281	FC Cincinnati	Atlanta United	2023-10-21 23:00:00	\N	76
1282	Columbus Crew	CF Montreal	2023-10-21 23:00:00	\N	76
1283	New York City FC	Chicago Fire	2023-10-21 23:00:00	\N	76
1284	Toronto FC	Orlando City SC	2023-10-21 23:00:00	\N	76
1285	Charlotte FC	Inter Miami CF	2023-10-21 23:00:00	\N	76
1286	Nashville SC	New York Red Bulls	2023-10-21 23:00:00	\N	76
1287	New England Revolution	Philadelphia Union	2023-10-21 23:00:00	\N	76
1291	Vancouver Whitecaps	Los Angeles FC	2023-10-22 02:00:00	\N	76
1292	Colorado Rapids	Real Salt Lake	2023-10-22 02:00:00	\N	76
1293	LA Galaxy	FC Dallas	2023-10-22 02:00:00	\N	76
1294	San Jose Earthquakes	Austin FC	2023-10-22 02:00:00	\N	76
1445	WSG Swarovski Tirol	FK Austria Vienna	2023-10-22 13:30:00	\N	43
1447	Genk	KV Mechelen	2023-10-22 12:30:00	\N	68
1448	Cercle Brugge	Gent	2023-10-22 15:00:00	\N	68
1449	Standard Liege	Anderlecht	2023-10-22 17:30:00	\N	68
1451	FCV Dender EH	KV Oostende	2023-10-22 12:30:00	\N	136
1452	Club Brugge II	SK Beveren	2023-10-22 15:00:00	\N	136
1453	Francs Borains	Patro Eisden Maasmechelen	2023-10-22 18:15:00	\N	136
1454	Viborg	FC Nordsjaelland	2023-10-22 15:00:00	\N	40
1455	Randers FC	Brondby	2023-10-22 17:00:00	\N	40
1456	AaB	B93 Copenhagen	2023-10-22 14:00:00	\N	147
1457	HB Køge	Naestved IF	2023-10-22 15:00:00	\N	147
1458	Aston Villa	West Ham	2023-10-22 16:30:00	\N	2
1459	Lorient	Rennes	2023-10-22 12:00:00	\N	5
1460	Toulouse	Reims	2023-10-22 14:00:00	\N	5
1461	Lille	Brest	2023-10-22 14:00:00	\N	5
1462	Nantes	Montpellier	2023-10-22 14:00:00	\N	5
1463	Monaco	Metz	2023-10-22 16:05:00	\N	5
1464	Lyon	Clermont Foot	2023-10-22 19:45:00	\N	5
1465	Cologne	Borussia Mgladbach	2023-10-22 14:30:00	\N	1
1466	Heidenheim	Augsburg	2023-10-22 16:30:00	\N	1
1467	Hansa Rostock	Holstein Kiel	2023-10-22 12:30:00	\N	93
1468	Karlsruher SC	Schalke	2023-10-22 12:30:00	\N	93
1469	Nurnberg	Hertha Berlin	2023-10-22 12:30:00	\N	93
1470	Roma	Monza	2023-10-22 11:30:00	\N	4
1471	Bologna	Frosinone	2023-10-22 14:00:00	\N	4
1472	Salernitana	Cagliari	2023-10-22 14:00:00	\N	4
1474	FC Utrecht	Ajax	2023-10-22 11:15:00	\N	196
1475	Heracles	FC Twente	2023-10-22 13:30:00	\N	196
1476	Excelsior	PEC Zwolle	2023-10-22 13:30:00	\N	196
1477	Go Ahead Eagles	Sparta Rotterdam	2023-10-22 15:45:00	\N	196
1478	Lillestrom	Valerenga	2023-10-22 13:30:00	\N	13
1479	Aalesund	Sarpsborg	2023-10-22 16:00:00	\N	13
1480	HamKam	Haugesund	2023-10-22 16:00:00	\N	13
1481	Rosenborg	Stabaek	2023-10-22 16:00:00	\N	13
1482	Stromsgodset	Odd BK	2023-10-22 16:00:00	\N	13
1483	Viking FK	Tromso	2023-10-22 18:15:00	\N	13
1484	Bryne	Skeid	2023-10-22 14:00:00	\N	204
1485	KFUM	Raufoss	2023-10-22 14:00:00	\N	204
1486	Moss	Ranheim	2023-10-22 14:00:00	\N	204
1487	FC Seoul	Gangwon FC	2023-10-22 06:00:00	\N	66
1488	Jeju United	Suwon Bluewings	2023-10-22 06:00:00	\N	66
1489	Daejeon Hana Citizen	Suwon FC	2023-10-22 08:40:00	\N	66
1289	Portland Timbers	Houston Dynamo	2023-10-22 02:00:00	\N	76
1450	OH Leuven	Sint-Truidense	2023-10-22 18:15:00	\N	68
1473	AC Milan	Juventus	2023-10-22 19:45:00	\N	4
1490	Girona	Almeria	2023-10-22 15:15:00	\N	3
1491	Villarreal	CD Alaves	2023-10-22 17:30:00	\N	3
1492	Barcelona	Athletic Bilbao	2023-10-22 20:00:00	\N	3
1493	Djurgarden	Hammarby	2023-10-22 14:00:00	\N	14
1494	Halmstad	Mjällby AIF	2023-10-22 14:00:00	\N	14
1495	Malmo FF	Varbergs BoIS FC	2023-10-22 16:30:00	\N	14
1496	BK Hacken	IFK Norrkoping	2023-10-22 16:30:00	\N	14
1497	Landskrona	Västerås SK FK	2023-10-22 12:00:00	\N	336
1498	Orgryte IS	Trelleborgs FF	2023-10-22 14:00:00	\N	336
1499	IK Brage	AFC Eskilstuna	2023-10-22 14:00:00	\N	336
1500	Winterthur	St Gallen	2023-10-22 13:15:00	\N	15
1501	Grasshoppers	Lugano	2023-10-22 15:30:00	\N	15
1502	Lucerne	Yverdon Sport FC	2023-10-22 15:30:00	\N	15
1288	Sporting Kansas City	Minnesota United	2023-10-22 02:00:00	\N	76
1640	Odense BK	Midtjylland	2023-10-23 18:00:00	\N	40
1641	Tottenham	Fulham	2023-10-23 20:00:00	\N	2
1642	Fiorentina	Empoli	2023-10-23 19:45:00	\N	4
1643	AZ Reserves	De Graafschap	2023-10-23 19:00:00	\N	199
1644	Top Oss	FC Utrecht Reserves	2023-10-23 19:00:00	\N	199
1645	Ajax Reserves	ADO Den Haag	2023-10-23 19:00:00	\N	199
1646	Helmond Sport	FC Dordrecht	2023-10-23 19:00:00	\N	199
1647	PSV Reserves	FC Eindhoven	2023-10-23 19:00:00	\N	199
1648	FC Groningen	FC Emmen	2023-10-23 19:00:00	\N	199
1649	Elfsborg	AIK	2023-10-23 18:10:00	\N	14
1650	Jonkopings Sodra	Skövde AIK	2023-10-23 18:00:00	\N	336
\.


--
-- TOC entry 3417 (class 0 OID 16540)
-- Dependencies: 217
-- Data for Name: over2p5goalsnow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5goalsnow (id, home, away, date_time, url, league_id) FROM stdin;
1	Aston Villa	Brighton	2023-09-30 12:30:00	\N	2
2	Man Utd	Crystal Palace	2023-09-30 15:00:00	\N	2
3	Newcastle	Burnley	2023-09-30 15:00:00	\N	2
4	West Ham	Sheff Utd	2023-09-30 15:00:00	\N	2
5	Wolverhampton	Man City	2023-09-30 15:00:00	\N	2
6	Tottenham	Liverpool	2023-09-30 17:30:00	\N	2
7	Southampton	Leeds	2023-09-30 12:30:00	\N	77
8	Cardiff	Rotherham	2023-09-30 15:00:00	\N	77
9	Hull	Plymouth	2023-09-30 15:00:00	\N	77
10	Millwall	Swansea	2023-09-30 15:00:00	\N	77
11	Preston	West Brom	2023-09-30 15:00:00	\N	77
12	QPR	Coventry	2023-09-30 15:00:00	\N	77
13	Watford	Middlesbrough	2023-09-30 15:00:00	\N	77
14	Mainz	Bayer Leverkusen	2023-09-30 14:30:00	\N	1
15	Cologne	VfB Stuttgart	2023-09-30 14:30:00	\N	1
16	Bochum	Borussia Mgladbach	2023-09-30 14:30:00	\N	1
17	Heidenheim	Union Berlin	2023-09-30 14:30:00	\N	1
18	RB Leipzig	Bayern Munich	2023-09-30 17:30:00	\N	1
19	Karlsruher SC	Holstein Kiel	2023-09-30 12:00:00	\N	93
20	Hannover 96	Wehen SV	2023-09-30 12:00:00	\N	93
21	Hansa Rostock	Eintracht Braunschweig	2023-09-30 12:00:00	\N	93
22	Hertha Berlin	St Pauli	2023-09-30 19:30:00	\N	93
23	Getafe	Villarreal	2023-09-30 13:00:00	\N	3
24	Girona	Real Madrid	2023-09-30 17:30:00	\N	3
25	Lecce	Napoli	2023-09-30 14:00:00	\N	4
26	AC Milan	Lazio	2023-09-30 17:00:00	\N	4
27	Clermont Foot	PSG	2023-09-30 16:00:00	\N	5
28	Monaco	Marseille	2023-09-30 20:00:00	\N	5
29	Wolfsberger AC	LASK Linz	2023-09-30 16:00:00	\N	43
30	FC Blau Weiss Linz	Austria Klagenfurt	2023-09-30 16:00:00	\N	43
31	Austria Lustenau	FC Salzburg	2023-09-30 16:00:00	\N	43
32	Eupen	Anderlecht	2023-09-30 15:00:00	\N	68
33	OH Leuven	Standard Liege	2023-09-30 17:15:00	\N	68
34	KFCO Beerschot Wilrijk	KV Oostende	2023-09-30 15:00:00	\N	136
35	Anderlecht II	Lierse Kempenzonen	2023-09-30 19:00:00	\N	136
36	Francs Borains	RFC Seraing	2023-09-30 19:00:00	\N	136
37	FC Copenhagen	Midtjylland	2023-09-30 14:00:00	\N	40
38	Sonderjyske	B93 Copenhagen	2023-09-30 13:00:00	\N	147
39	Sagan Tosu	Kyoto Sanga FC	2023-09-30 11:00:00	\N	28
40	Feyenoord	Go Ahead Eagles	2023-09-30 15:30:00	\N	196
41	FC Utrecht	Almere City FC	2023-09-30 17:45:00	\N	196
42	PSV	FC Volendam	2023-09-30 17:45:00	\N	196
43	FC Twente	Heerenveen	2023-09-30 20:00:00	\N	196
44	RKC	Ajax	2023-09-30 20:00:00	\N	196
45	Stabaek	Tromso	2023-09-30 14:00:00	\N	13
46	FK Jerv	Sogndal	2023-09-30 14:00:00	\N	204
47	Kristiansund BK	KFUM	2023-09-30 14:00:00	\N	204
48	Mjondalen	Skeid	2023-09-30 14:00:00	\N	204
49	Sandnes Ulf	IK Start	2023-09-30 14:00:00	\N	204
50	Vizela	Portimonense	2023-09-30 15:30:00	\N	8
51	Boavista	Famalicao	2023-09-30 18:00:00	\N	8
52	SC Farense	Sporting	2023-09-30 20:30:00	\N	8
53	Suwon FC	FC Seoul	2023-09-30 06:00:00	\N	66
54	Djurgarden	Halmstad	2023-09-30 14:00:00	\N	14
55	IFK Norrkoping	Kalmar FF	2023-09-30 16:30:00	\N	14
56	Servette	Lausanne Sports	2023-09-30 17:00:00	\N	15
57	Winterthur	Lugano	2023-09-30 17:00:00	\N	15
58	Grasshoppers	Young Boys	2023-09-30 19:30:00	\N	15
63	Orlando City SC	CF Montreal	2023-10-01 00:30:00	\N	76
62	New York Red Bulls	Chicago Fire	2023-10-01 00:30:00	\N	76
64	Toronto FC	FC Cincinnati	2023-10-01 00:30:00	\N	76
65	Houston Dynamo	FC Dallas	2023-10-01 01:30:00	\N	76
66	Blackburn	Leicester	2023-10-01 12:00:00	\N	77
67	Darmstadt	Werder Bremen	2023-10-01 14:30:00	\N	1
68	SC Freiburg	Augsburg	2023-10-01 16:30:00	\N	1
69	Nurnberg	Magdeburg	2023-10-01 12:30:00	\N	93
70	Elversberg	Greuther Furth	2023-10-01 12:30:00	\N	93
71	VfL Osnabruck	Kaiserslautern	2023-10-01 12:30:00	\N	93
72	Almeria	Granada	2023-10-01 13:00:00	\N	3
73	Udinese	Genoa	2023-10-01 14:00:00	\N	4
75	Roma	Frosinone	2023-10-01 19:45:00	\N	4
76	Reims	Lyon	2023-10-01 12:00:00	\N	5
77	Toulouse	Metz	2023-10-01 14:00:00	\N	5
78	Le Havre	Lille	2023-10-01 14:00:00	\N	5
79	Lorient	Montpellier	2023-10-01 16:05:00	\N	5
80	Rennes	Nantes	2023-10-01 19:45:00	\N	5
81	SK Sturm Graz	WSG Swarovski Tirol	2023-10-01 13:30:00	\N	43
82	Hartberg	SCR Altach	2023-10-01 13:30:00	\N	43
83	FK Austria Vienna	Rapid Vienna	2023-10-01 16:00:00	\N	43
84	Genk	Westerlo	2023-10-01 15:00:00	\N	68
85	RWD Molenbeek	Gent	2023-10-01 18:15:00	\N	68
86	Zulte-Waregem	Club Brugge II	2023-10-01 12:30:00	\N	136
87	RFC Liege	Lommel	2023-10-01 15:00:00	\N	136
88	FCV Dender EH	Genk II	2023-10-01 18:15:00	\N	136
89	Vejle	FC Nordsjaelland	2023-10-01 13:00:00	\N	40
90	Randers FC	Silkeborg IF	2023-10-01 13:00:00	\N	40
91	Hvidovre IF	Brondby	2023-10-01 15:00:00	\N	40
92	HB Køge	FC Helsingor	2023-10-01 12:00:00	\N	147
94	Hobro IK	Kolding IF	2023-10-01 16:00:00	\N	147
95	NEC	Vitesse	2023-10-01 11:15:00	\N	196
96	Excelsior	Sparta Rotterdam	2023-10-01 13:30:00	\N	196
97	Heracles	PEC Zwolle	2023-10-01 13:30:00	\N	196
98	VVV	Helmond Sport	2023-10-01 11:15:00	\N	199
99	Lillestrom	SK Brann	2023-10-01 14:00:00	\N	13
100	Sandefjord	Valerenga	2023-10-01 16:00:00	\N	13
101	Molde	Viking FK	2023-10-01 16:00:00	\N	13
102	Bodo/Glimt	Stromsgodset	2023-10-01 18:15:00	\N	13
103	Fredrikstad	Raufoss	2023-10-01 14:00:00	\N	204
104	Kongsvinger	Bryne	2023-10-01 14:00:00	\N	204
105	Moss	Hodd	2023-10-01 14:00:00	\N	204
60	Inter Miami CF	New York City FC	2023-10-01 00:30:00	\N	76
61	New England Revolution	Charlotte FC	2023-10-01 00:30:00	\N	76
277	Union Berlin	Braga	2023-10-03 17:45:00	\N	244
278	FC Salzburg	Real Sociedad	2023-10-03 17:45:00	\N	244
279	Man Utd	Galatasaray	2023-10-03 20:00:00	\N	244
280	FC Copenhagen	Bayern Munich	2023-10-03 20:00:00	\N	244
281	PSV	Sevilla	2023-10-03 20:00:00	\N	244
282	Lens	Arsenal	2023-10-03 20:00:00	\N	244
283	Napoli	Real Madrid	2023-10-03 20:00:00	\N	244
284	Inter Milan	Benfica	2023-10-03 20:00:00	\N	244
285	Middlesbrough	Cardiff	2023-10-03 19:45:00	\N	77
286	Plymouth	Millwall	2023-10-03 19:45:00	\N	77
287	Stoke	Southampton	2023-10-03 20:00:00	\N	77
288	West Brom	Sheff Wed	2023-10-03 20:00:00	\N	77
289	Willem II	Top Oss	2023-10-03 19:00:00	\N	199
290	GAIS	Osters IF	2023-10-03 18:00:00	\N	336
291	Landskrona	GIF Sundsvall	2023-10-03 18:00:00	\N	336
292	Helsingborg	Orebro SK	2023-10-03 18:00:00	\N	336
293	Gefle IF	Orgryte IS	2023-10-03 18:00:00	\N	336
74	Atalanta	Juventus	2023-10-01 17:00:00	\N	4
93	FC Fredericia	Naestved IF	2023-10-01 13:00:00	\N	147
106	Asane	Ranheim	2023-10-01 14:00:00	\N	204
107	FC Arouca	Chaves	2023-10-01 15:30:00	\N	8
108	Guimaraes	Estoril	2023-10-01 18:00:00	\N	8
109	Rio Ave	Moreirense	2023-10-01 20:30:00	\N	8
110	BK Hacken	AIK	2023-10-01 14:00:00	\N	14
111	Sirius	Degerfors	2023-10-01 14:00:00	\N	14
112	Mjällby AIF	IFK Varnamo	2023-10-01 16:30:00	\N	14
113	Västerås SK FK	Trelleborgs FF	2023-10-01 14:00:00	\N	336
114	Yverdon Sport FC	St Gallen	2023-10-01 13:15:00	\N	15
115	Basel	Stade Lausanne-Ouchy	2023-10-01 15:30:00	\N	15
116	Lucerne	FC Zurich	2023-10-01 15:30:00	\N	15
59	Columbus Crew	Philadelphia Union	2023-10-01 00:30:00	\N	76
123	Minnesota United	San Jose Earthquakes	2023-10-01 01:30:00	\N	76
124	St. Louis City SC	Sporting Kansas City	2023-10-01 01:30:00	\N	76
125	Colorado Rapids	Austin FC	2023-10-01 02:30:00	\N	76
126	LA Galaxy	Portland Timbers	2023-10-01 03:30:00	\N	76
127	Vancouver Whitecaps	DC United	2023-10-01 03:30:00	\N	76
255	Sassuolo	Monza	2023-10-02 17:30:00	\N	4
256	Torino	Verona	2023-10-02 17:30:00	\N	4
257	Odense BK	Lyngby	2023-10-02 18:00:00	\N	40
258	Maastricht	FC Eindhoven	2023-10-02 19:00:00	\N	199
259	FC Utrecht Reserves	NAC	2023-10-02 19:00:00	\N	199
260	Elfsborg	Varbergs BoIS FC	2023-10-02 18:00:00	\N	14
261	Malmo FF	Brommapojkarna	2023-10-02 18:10:00	\N	14
262	Jonkopings Sodra	Ostersunds FK	2023-10-02 18:00:00	\N	336
263	IK Brage	Skövde AIK	2023-10-02 18:00:00	\N	336
264	Utsiktens BK	AFC Eskilstuna	2023-10-02 18:00:00	\N	336
128	Los Angeles FC	Real Salt Lake	2023-10-02 01:00:00	\N	76
311	Atletico Madrid	Feyenoord	2023-10-04 17:45:00	\N	244
312	Antwerp	Shakhtar Donetsk	2023-10-04 17:45:00	\N	244
313	Celtic	Lazio	2023-10-04 20:00:00	\N	244
314	Borussia Dortmund	AC Milan	2023-10-04 20:00:00	\N	244
315	Newcastle	PSG	2023-10-04 20:00:00	\N	244
316	RB Leipzig	Man City	2023-10-04 20:00:00	\N	244
317	Crvena Zvezda	Young Boys	2023-10-04 20:00:00	\N	244
318	FC Porto	Barcelona	2023-10-04 20:00:00	\N	244
319	Coventry	Blackburn	2023-10-04 19:45:00	\N	77
320	Leicester	Preston	2023-10-04 19:45:00	\N	77
321	Sunderland	Watford	2023-10-04 19:45:00	\N	77
322	Swansea	Norwich	2023-10-04 19:45:00	\N	77
323	Rotherham	Bristol City	2023-10-04 20:00:00	\N	77
324	Stabaek	HamKam	2023-10-04 18:00:00	\N	13
325	Sogndal	Kristiansund BK	2023-10-04 17:00:00	\N	204
356	FK Backa Topola	Olympiakos	2023-10-05 17:45:00	\N	245
357	Marseille	Brighton	2023-10-05 17:45:00	\N	245
328	CF Montreal	Houston Dynamo	2023-10-05 00:30:00	\N	76
358	AEK Athens	Ajax	2023-10-05 17:45:00	\N	245
359	Aris Limassol	Rangers	2023-10-05 17:45:00	\N	245
360	Sporting	Atalanta	2023-10-05 17:45:00	\N	245
361	Rakow Czestochowa	SK Sturm Graz	2023-10-05 17:45:00	\N	245
330	Philadelphia Union	Atlanta United	2023-10-05 00:30:00	\N	76
331	Austin FC	DC United	2023-10-05 01:30:00	\N	76
332	Chicago Fire	Inter Miami CF	2023-10-05 01:30:00	\N	76
375	FC Dallas	Colorado Rapids	2023-10-05 01:30:00	\N	76
376	Nashville SC	Orlando City SC	2023-10-05 01:30:00	\N	76
377	Los Angeles FC	Minnesota United	2023-10-05 03:30:00	\N	76
362	Liverpool	Union Saint Gilloise	2023-10-05 20:00:00	\N	245
363	Toulouse	LASK Linz	2023-10-05 20:00:00	\N	245
364	Villarreal	Rennes	2023-10-05 20:00:00	\N	245
365	Maccabi Haifa	Panathinaikos	2023-10-05 20:00:00	\N	245
366	Roma	Servette	2023-10-05 20:00:00	\N	245
367	Molde	Bayer Leverkusen	2023-10-05 20:00:00	\N	245
368	BK Hacken	FK Qarabag	2023-10-05 20:00:00	\N	245
326	Charlotte FC	Toronto FC	2023-10-05 00:30:00	\N	76
327	FC Cincinnati	New York Red Bulls	2023-10-05 00:30:00	\N	76
329	New England Revolution	Columbus Crew	2023-10-05 00:30:00	\N	76
378	Seattle Sounders FC	LA Galaxy	2023-10-05 03:30:00	\N	76
379	Vancouver Whitecaps	St. Louis City SC	2023-10-05 03:30:00	\N	76
355	SC Freiburg	West Ham	2023-10-05 17:45:00	\N	245
434	Empoli	Udinese	2023-10-06 17:30:00	\N	4
435	Lecce	Sassuolo	2023-10-06 19:45:00	\N	4
436	Strasbourg	Nantes	2023-10-06 20:00:00	\N	5
437	Charleroi	RWD Molenbeek	2023-10-06 19:45:00	\N	68
438	Lommel	Standard Liege II	2023-10-06 19:00:00	\N	136
439	RFC Seraing	FCV Dender EH	2023-10-06 19:00:00	\N	136
440	FC Fredericia	Sonderjyske	2023-10-06 17:30:00	\N	147
431	Borussia Mgladbach	Mainz	2023-10-06 19:30:00	\N	1
433	Kaiserslautern	Hannover 96	2023-10-06 17:30:00	\N	93
567	AIK	Mjällby AIF	2023-10-07 14:00:00	\N	14
568	Halmstad	Degerfors	2023-10-07 14:00:00	\N	14
569	IFK Goteborg	Sirius	2023-10-07 16:30:00	\N	14
570	Västerås SK FK	Jonkopings Sodra	2023-10-07 14:00:00	\N	336
571	Skövde AIK	Gefle IF	2023-10-07 14:00:00	\N	336
572	Osters IF	Orebro SK	2023-10-07 14:00:00	\N	336
573	Ostersunds FK	Helsingborg	2023-10-07 16:00:00	\N	336
520	Man Utd	Brentford	2023-10-07 15:00:00	\N	2
521	Sunderland	Middlesbrough	2023-10-07 12:30:00	\N	77
522	Cardiff	Watford	2023-10-07 15:00:00	\N	77
523	Coventry	Norwich	2023-10-07 15:00:00	\N	77
524	Ipswich	Preston	2023-10-07 15:00:00	\N	77
525	Leicester	Stoke	2023-10-07 15:00:00	\N	77
526	Plymouth	Swansea	2023-10-07 15:00:00	\N	77
527	QPR	Blackburn	2023-10-07 15:00:00	\N	77
528	Southampton	Rotherham	2023-10-07 15:00:00	\N	77
529	Borussia Dortmund	Union Berlin	2023-10-07 14:30:00	\N	1
430	Birmingham	West Brom	2023-10-06 20:00:00	\N	77
432	Fortuna Dusseldorf	VfL Osnabruck	2023-10-06 17:30:00	\N	93
441	AC Horsens	AaB	2023-10-06 18:00:00	\N	147
442	B93 Copenhagen	Hillerød	2023-10-06 18:00:00	\N	147
443	FC Volendam	FC Utrecht	2023-10-06 19:00:00	\N	196
444	FC Emmen	Telstar	2023-10-06 19:00:00	\N	199
445	Ajax Reserves	VVV	2023-10-06 19:00:00	\N	199
446	Willem II	De Graafschap	2023-10-06 19:00:00	\N	199
447	NAC	FC Groningen	2023-10-06 19:00:00	\N	199
448	Roda JC	AZ Reserves	2023-10-06 19:00:00	\N	199
449	PSV Reserves	Maastricht	2023-10-06 19:00:00	\N	199
450	FC Dordrecht	Cambuur Leeuwarden	2023-10-06 19:00:00	\N	199
451	Moreirense	Boavista	2023-10-06 20:15:00	\N	8
530	RB Leipzig	Bochum	2023-10-07 14:30:00	\N	1
531	Augsburg	Darmstadt	2023-10-07 14:30:00	\N	1
532	VfB Stuttgart	Wolfsburg	2023-10-07 14:30:00	\N	1
533	Werder Bremen	TSG Hoffenheim	2023-10-07 17:30:00	\N	1
534	Magdeburg	Karlsruher SC	2023-10-07 12:00:00	\N	93
535	Greuther Furth	Hansa Rostock	2023-10-07 12:00:00	\N	93
536	Wehen SV	Hamburg	2023-10-07 12:00:00	\N	93
537	St Pauli	Nurnberg	2023-10-07 19:30:00	\N	93
538	Cadiz	Girona	2023-10-07 13:00:00	\N	3
539	Real Madrid	Osasuna	2023-10-07 15:15:00	\N	3
540	Mallorca	Valencia	2023-10-07 17:30:00	\N	3
544	FK Austria Vienna	FC Blau Weiss Linz	2023-10-07 16:00:00	\N	43
545	Austria Lustenau	Rapid Vienna	2023-10-07 16:00:00	\N	43
546	Hartberg	WSG Swarovski Tirol	2023-10-07 16:00:00	\N	43
547	Cercle Brugge	OH Leuven	2023-10-07 15:00:00	\N	68
548	Westerlo	KV Kortrijk	2023-10-07 17:15:00	\N	68
549	Anderlecht	KV Mechelen	2023-10-07 19:45:00	\N	68
550	Genk II	KFCO Beerschot Wilrijk	2023-10-07 15:00:00	\N	136
551	Club Brugge II	Francs Borains	2023-10-07 19:00:00	\N	136
552	Patro Eisden Maasmechelen	RFC Liege	2023-10-07 19:00:00	\N	136
553	Kolding IF	HB Køge	2023-10-07 14:00:00	\N	147
554	Heerenveen	NEC	2023-10-07 15:30:00	\N	196
555	Almere City FC	RKC	2023-10-07 17:45:00	\N	196
556	Go Ahead Eagles	Heracles	2023-10-07 19:00:00	\N	196
557	Vitesse	Excelsior	2023-10-07 20:00:00	\N	196
558	Odd BK	Viking FK	2023-10-07 17:00:00	\N	13
559	Raufoss	Mjondalen	2023-10-07 14:00:00	\N	204
560	Skeid	Sandnes Ulf	2023-10-07 14:00:00	\N	204
561	Sogndal	Moss	2023-10-07 14:00:00	\N	204
562	Hodd	Kristiansund BK	2023-10-07 17:00:00	\N	204
563	SC Farense	Vizela	2023-10-07 15:30:00	\N	8
564	Chaves	Gil Vicente	2023-10-07 15:30:00	\N	8
565	Braga	Rio Ave	2023-10-07 18:00:00	\N	8
566	Estoril	Benfica	2023-10-07 20:30:00	\N	8
518	Luton	Tottenham	2023-10-07 12:30:00	\N	2
519	Fulham	Sheff Utd	2023-10-07 15:00:00	\N	2
541	Inter Milan	Bologna	2023-10-07 14:00:00	\N	4
542	Genoa	AC Milan	2023-10-07 19:45:00	\N	4
543	Reims	Monaco	2023-10-07 20:00:00	\N	5
855	Schalke	Hertha Berlin	2023-10-08 12:30:00	\N	93
856	Holstein Kiel	Elversberg	2023-10-08 12:30:00	\N	93
857	Eintracht Braunschweig	Paderborn	2023-10-08 12:30:00	\N	93
858	Atletico Madrid	Real Sociedad	2023-10-08 15:15:00	\N	3
859	Celta Vigo	Getafe	2023-10-08 17:30:00	\N	3
886	Sparta Rotterdam	PSV	2023-10-08 15:45:00	\N	196
887	Molde	Bodo/Glimt	2023-10-08 16:00:00	\N	13
888	Sandefjord	HamKam	2023-10-08 16:00:00	\N	13
889	Sarpsborg	Rosenborg	2023-10-08 16:00:00	\N	13
890	Stabaek	Lillestrom	2023-10-08 16:00:00	\N	13
891	Tromso	Aalesund	2023-10-08 16:00:00	\N	13
892	Valerenga	SK Brann	2023-10-08 18:15:00	\N	13
893	KFUM	Bryne	2023-10-08 14:00:00	\N	204
574	Yverdon Sport FC	Grasshoppers	2023-10-07 17:00:00	\N	15
575	FC Zurich	Winterthur	2023-10-07 17:00:00	\N	15
576	St Gallen	Stade Lausanne-Ouchy	2023-10-07 19:30:00	\N	15
578	DC United	New York City FC	2023-10-08 00:30:00	\N	76
848	Brighton	Liverpool	2023-10-08 14:00:00	\N	2
849	West Ham	Newcastle	2023-10-08 14:00:00	\N	2
850	Wolverhampton	Aston Villa	2023-10-08 14:00:00	\N	2
851	Arsenal	Man City	2023-10-08 16:30:00	\N	2
852	Bayer Leverkusen	Cologne	2023-10-08 14:30:00	\N	1
853	Bayern Munich	SC Freiburg	2023-10-08 16:30:00	\N	1
854	Eintracht Frankfurt	Heidenheim	2023-10-08 18:30:00	\N	1
860	Granada	Barcelona	2023-10-08 20:00:00	\N	3
861	Frosinone	Verona	2023-10-08 14:00:00	\N	4
862	Lazio	Atalanta	2023-10-08 14:00:00	\N	4
863	Cagliari	Roma	2023-10-08 17:00:00	\N	4
864	Napoli	Fiorentina	2023-10-08 19:45:00	\N	4
865	Marseille	Le Havre	2023-10-08 12:00:00	\N	5
866	Lyon	Lorient	2023-10-08 14:00:00	\N	5
867	Montpellier	Clermont Foot	2023-10-08 14:00:00	\N	5
868	Brest	Toulouse	2023-10-08 14:00:00	\N	5
869	Lens	Lille	2023-10-08 16:05:00	\N	5
870	Rennes	PSG	2023-10-08 19:45:00	\N	5
871	Wolfsberger AC	SK Sturm Graz	2023-10-08 13:30:00	\N	43
872	Austria Klagenfurt	FC Salzburg	2023-10-08 16:00:00	\N	43
873	Standard Liege	Club Brugge	2023-10-08 12:30:00	\N	68
874	Antwerp	Eupen	2023-10-08 15:00:00	\N	68
875	SK Beveren	Zulte-Waregem	2023-10-08 12:30:00	\N	136
876	KV Oostende	Anderlecht II	2023-10-08 15:00:00	\N	136
877	Lierse Kempenzonen	Deinze	2023-10-08 18:15:00	\N	136
878	FC Nordsjaelland	Odense BK	2023-10-08 13:00:00	\N	40
879	Vejle	Hvidovre IF	2023-10-08 13:00:00	\N	40
880	Brondby	Viborg	2023-10-08 15:00:00	\N	40
881	Midtjylland	Randers FC	2023-10-08 17:00:00	\N	40
882	Naestved IF	Hobro IK	2023-10-08 12:00:00	\N	147
883	PEC Zwolle	Feyenoord	2023-10-08 11:15:00	\N	196
884	Fortuna Sittard	FC Twente	2023-10-08 13:30:00	\N	196
885	Ajax	AZ	2023-10-08 13:30:00	\N	196
894	Ranheim	FK Jerv	2023-10-08 14:00:00	\N	204
895	IK Start	Kongsvinger	2023-10-08 14:00:00	\N	204
896	Asane	Fredrikstad	2023-10-08 14:00:00	\N	204
897	Famalicao	Guimaraes	2023-10-08 15:30:00	\N	8
898	FC Porto	Portimonense	2023-10-08 18:00:00	\N	8
577	Atlanta United	Columbus Crew	2023-10-08 00:30:00	\N	76
579	Inter Miami CF	FC Cincinnati	2023-10-08 00:30:00	\N	76
580	CF Montreal	Portland Timbers	2023-10-08 00:30:00	\N	76
581	New York Red Bulls	Toronto FC	2023-10-08 00:30:00	\N	76
582	Orlando City SC	New England Revolution	2023-10-08 00:30:00	\N	76
583	Philadelphia Union	Nashville SC	2023-10-08 00:30:00	\N	76
1193	LA Galaxy	Real Salt Lake	2023-10-15 03:30:00	\N	76
1159	Latvia	Armenia	2023-10-12 17:00:00	\N	274
1160	Israel	Switzerland	2023-10-12 19:45:00	\N	274
1161	Spain	Scotland	2023-10-12 19:45:00	\N	274
1162	Cyprus	Norway	2023-10-12 19:45:00	\N	274
1163	Croatia	Turkey	2023-10-12 19:45:00	\N	274
1280	Huddersfield	QPR	2023-10-21 15:00:00	\N	77
1281	Hull	Southampton	2023-10-21 15:00:00	\N	77
1282	Middlesbrough	Birmingham	2023-10-21 15:00:00	\N	77
1179	Estonia	Azerbaijan	2023-10-13 17:00:00	\N	274
1180	Netherlands	France	2023-10-13 19:45:00	\N	274
1181	Rep of Ireland	Greece	2023-10-13 19:45:00	\N	274
1283	Norwich	Leeds	2023-10-21 15:00:00	\N	77
1239	Gibraltar	Rep of Ireland	2023-10-16 19:45:00	\N	274
1240	Greece	Netherlands	2023-10-16 19:45:00	\N	274
1241	Belgium	Sweden	2023-10-16 19:45:00	\N	274
1242	Bosnia-Herzegovina	Portugal	2023-10-16 19:45:00	\N	274
1188	Hungary	Serbia	2023-10-14 19:45:00	\N	274
1189	VVV	Roda JC	2023-10-14 15:30:00	\N	199
1190	Telstar	Maastricht	2023-10-14 19:00:00	\N	199
1284	Swansea	Leicester	2023-10-21 15:00:00	\N	77
899	Sporting	FC Arouca	2023-10-08 20:30:00	\N	8
900	FC Seoul	Jeonbuk Motors	2023-10-08 07:00:00	\N	66
901	Kalmar FF	Malmo FF	2023-10-08 14:00:00	\N	14
902	IFK Varnamo	IFK Norrkoping	2023-10-08 14:00:00	\N	14
903	Brommapojkarna	Elfsborg	2023-10-08 14:00:00	\N	14
904	Hammarby	BK Hacken	2023-10-08 16:30:00	\N	14
905	Varbergs BoIS FC	Djurgarden	2023-10-08 16:30:00	\N	14
906	AFC Eskilstuna	Landskrona	2023-10-08 12:00:00	\N	336
907	Trelleborgs FF	GAIS	2023-10-08 12:00:00	\N	336
908	Orgryte IS	Utsiktens BK	2023-10-08 14:00:00	\N	336
909	GIF Sundsvall	IK Brage	2023-10-08 14:00:00	\N	336
910	Lugano	Servette	2023-10-08 13:15:00	\N	15
911	Lausanne Sports	Lucerne	2023-10-08 15:30:00	\N	15
912	Young Boys	Basel	2023-10-08 15:30:00	\N	15
919	Austin FC	Los Angeles FC	2023-10-08 01:30:00	\N	76
920	Chicago Fire	Charlotte FC	2023-10-08 01:30:00	\N	76
921	Houston Dynamo	Colorado Rapids	2023-10-08 01:30:00	\N	76
922	Minnesota United	LA Galaxy	2023-10-08 01:30:00	\N	76
923	Real Salt Lake	Sporting Kansas City	2023-10-08 02:30:00	\N	76
924	Seattle Sounders FC	Vancouver Whitecaps	2023-10-08 03:30:00	\N	76
1156	FC Helsingor	Vendsyssel FF	2023-10-09 18:00:00	\N	147
1285	West Brom	Plymouth	2023-10-21 15:00:00	\N	77
1286	Stoke	Sunderland	2023-10-21 15:00:00	\N	77
1295	Fortuna Dusseldorf	Kaiserslautern	2023-10-21 19:30:00	\N	93
1296	Sevilla	Real Madrid	2023-10-21 17:30:00	\N	3
1251	England	Italy	2023-10-17 19:45:00	\N	274
1252	Serbia	Montenegro	2023-10-17 19:45:00	\N	274
1253	Northern Ireland	Slovenia	2023-10-17 19:45:00	\N	274
1267	Vendsyssel FF	AC Horsens	2023-10-19 18:00:00	\N	147
1263	Inter Miami CF	Charlotte FC	2023-10-19 01:00:00	\N	76
1206	Georgia	Cyprus	2023-10-15 14:00:00	\N	274
1207	Czech Republic	Faroe Islands	2023-10-15 17:00:00	\N	274
1208	Switzerland	Belarus	2023-10-15 17:00:00	\N	274
1209	Norway	Spain	2023-10-15 19:45:00	\N	274
1210	Turkey	Latvia	2023-10-15 19:45:00	\N	274
1211	Romania	Andorra	2023-10-15 19:45:00	\N	274
1212	Willem II	FC Den Bosch	2023-10-15 13:30:00	\N	199
1213	Cambuur Leeuwarden	NAC	2023-10-15 15:45:00	\N	199
1191	FC Dallas	Colorado Rapids	2023-10-15 01:30:00	\N	76
1192	Nashville SC	New England Revolution	2023-10-15 01:30:00	\N	76
1273	Liverpool	Everton	2023-10-21 12:30:00	\N	2
1274	Bournemouth	Wolverhampton	2023-10-21 15:00:00	\N	2
1275	Man City	Brighton	2023-10-21 15:00:00	\N	2
1276	Newcastle	Crystal Palace	2023-10-21 15:00:00	\N	2
1277	Sheff Utd	Man Utd	2023-10-21 20:00:00	\N	2
1278	Preston	Millwall	2023-10-21 12:30:00	\N	77
1279	Blackburn	Cardiff	2023-10-21 15:00:00	\N	77
1287	Union Berlin	VfB Stuttgart	2023-10-21 14:30:00	\N	1
1288	SC Freiburg	Bochum	2023-10-21 14:30:00	\N	1
1289	Wolfsburg	Bayer Leverkusen	2023-10-21 14:30:00	\N	1
1290	TSG Hoffenheim	Eintracht Frankfurt	2023-10-21 14:30:00	\N	1
1291	Darmstadt	RB Leipzig	2023-10-21 14:30:00	\N	1
1292	Mainz	Bayern Munich	2023-10-21 17:30:00	\N	1
1293	Paderborn	St Pauli	2023-10-21 12:00:00	\N	93
1294	Hamburg	Greuther Furth	2023-10-21 12:00:00	\N	93
1298	Verona	Napoli	2023-10-21 14:00:00	\N	4
1297	Celta Vigo	Atletico Madrid	2023-10-21 20:00:00	\N	3
1299	Sassuolo	Lazio	2023-10-21 19:45:00	\N	4
1300	PSG	Strasbourg	2023-10-21 16:00:00	\N	5
1301	SK Sturm Graz	Hartberg	2023-10-21 16:00:00	\N	43
1302	FC Blau Weiss Linz	Austria Lustenau	2023-10-21 16:00:00	\N	43
1303	KV Kortrijk	Club Brugge	2023-10-21 15:00:00	\N	68
1304	RWD Molenbeek	Westerlo	2023-10-21 17:15:00	\N	68
1305	Charleroi	Antwerp	2023-10-21 19:45:00	\N	68
1306	Anderlecht II	Standard Liege II	2023-10-21 15:00:00	\N	136
1307	Zulte-Waregem	RFC Liege	2023-10-21 19:00:00	\N	136
1308	Lierse Kempenzonen	RFC Seraing	2023-10-21 19:00:00	\N	136
1309	FC Copenhagen	Vejle	2023-10-21 16:00:00	\N	40
1310	Yokohama F-Marinos	Consadole Sapporo	2023-10-21 06:00:00	\N	28
1311	RKC	FC Volendam	2023-10-21 17:45:00	\N	196
1312	PSV	Fortuna Sittard	2023-10-21 17:45:00	\N	196
1313	NEC	Almere City FC	2023-10-21 19:00:00	\N	196
1314	Feyenoord	Vitesse	2023-10-21 20:00:00	\N	196
1315	AZ	Heerenveen	2023-10-21 20:00:00	\N	196
1316	Roda JC	Willem II	2023-10-21 19:00:00	\N	199
1317	Bodo/Glimt	Sandefjord	2023-10-21 14:00:00	\N	13
1318	SK Brann	Molde	2023-10-21 17:00:00	\N	13
1319	Hodd	Sogndal	2023-10-21 14:00:00	\N	204
1320	FK Jerv	Kongsvinger	2023-10-21 14:00:00	\N	204
1321	Kristiansund BK	Asane	2023-10-21 14:00:00	\N	204
1322	Mjondalen	IK Start	2023-10-21 14:00:00	\N	204
1323	Sandnes Ulf	Fredrikstad	2023-10-21 14:00:00	\N	204
1324	Degerfors	Kalmar FF	2023-10-21 14:00:00	\N	14
1325	Sirius	Brommapojkarna	2023-10-21 16:30:00	\N	14
1326	GAIS	Ostersunds FK	2023-10-21 12:00:00	\N	336
1327	Helsingborg	Gefle IF	2023-10-21 14:00:00	\N	336
1328	Stade Lausanne-Ouchy	Lausanne Sports	2023-10-21 17:00:00	\N	15
1329	Young Boys	FC Zurich	2023-10-21 17:00:00	\N	15
1330	Basel	Servette	2023-10-21 19:30:00	\N	15
1331	FC Cincinnati	Atlanta United	2023-10-21 23:00:00	\N	76
1332	Columbus Crew	CF Montreal	2023-10-21 23:00:00	\N	76
1333	Toronto FC	Orlando City SC	2023-10-21 23:00:00	\N	76
1334	Charlotte FC	Inter Miami CF	2023-10-21 23:00:00	\N	76
1335	New England Revolution	Philadelphia Union	2023-10-21 23:00:00	\N	76
1339	Vancouver Whitecaps	Los Angeles FC	2023-10-22 02:00:00	\N	76
1340	Colorado Rapids	Real Salt Lake	2023-10-22 02:00:00	\N	76
1341	LA Galaxy	FC Dallas	2023-10-22 02:00:00	\N	76
1342	San Jose Earthquakes	Austin FC	2023-10-22 02:00:00	\N	76
1483	Aston Villa	West Ham	2023-10-22 16:30:00	\N	2
1484	Cologne	Borussia Mgladbach	2023-10-22 14:30:00	\N	1
1338	St. Louis City SC	Seattle Sounders FC	2023-10-22 02:00:00	\N	76
1485	Heidenheim	Augsburg	2023-10-22 16:30:00	\N	1
1486	Karlsruher SC	Schalke	2023-10-22 12:30:00	\N	93
1487	Hansa Rostock	Holstein Kiel	2023-10-22 12:30:00	\N	93
1488	Nurnberg	Hertha Berlin	2023-10-22 12:30:00	\N	93
1489	Girona	Almeria	2023-10-22 15:15:00	\N	3
1490	Barcelona	Athletic Bilbao	2023-10-22 20:00:00	\N	3
1491	Roma	Monza	2023-10-22 11:30:00	\N	4
1492	Bologna	Frosinone	2023-10-22 14:00:00	\N	4
1493	Atalanta	Genoa	2023-10-22 17:00:00	\N	4
1494	Lorient	Rennes	2023-10-22 12:00:00	\N	5
1495	Toulouse	Reims	2023-10-22 14:00:00	\N	5
1496	Nantes	Montpellier	2023-10-22 14:00:00	\N	5
1497	Monaco	Metz	2023-10-22 16:05:00	\N	5
1498	SCR Altach	Wolfsberger AC	2023-10-22 13:30:00	\N	43
1499	WSG Swarovski Tirol	FK Austria Vienna	2023-10-22 13:30:00	\N	43
1500	Rapid Vienna	Austria Klagenfurt	2023-10-22 16:00:00	\N	43
1501	Standard Liege	Anderlecht	2023-10-22 17:30:00	\N	68
1502	OH Leuven	Sint-Truidense	2023-10-22 18:15:00	\N	68
1503	FCV Dender EH	KV Oostende	2023-10-22 12:30:00	\N	136
1504	Club Brugge II	SK Beveren	2023-10-22 15:00:00	\N	136
1505	Francs Borains	Patro Eisden Maasmechelen	2023-10-22 18:15:00	\N	136
1506	Viborg	FC Nordsjaelland	2023-10-22 15:00:00	\N	40
1507	Randers FC	Brondby	2023-10-22 17:00:00	\N	40
1508	AaB	B93 Copenhagen	2023-10-22 14:00:00	\N	147
1509	HB Køge	Naestved IF	2023-10-22 15:00:00	\N	147
1510	FC Utrecht	Ajax	2023-10-22 11:15:00	\N	196
1511	Heracles	FC Twente	2023-10-22 13:30:00	\N	196
1512	Excelsior	PEC Zwolle	2023-10-22 13:30:00	\N	196
1513	Go Ahead Eagles	Sparta Rotterdam	2023-10-22 15:45:00	\N	196
1514	Lillestrom	Valerenga	2023-10-22 13:30:00	\N	13
1515	Aalesund	Sarpsborg	2023-10-22 16:00:00	\N	13
1516	HamKam	Haugesund	2023-10-22 16:00:00	\N	13
1517	Rosenborg	Stabaek	2023-10-22 16:00:00	\N	13
1518	Stromsgodset	Odd BK	2023-10-22 16:00:00	\N	13
1519	Viking FK	Tromso	2023-10-22 18:15:00	\N	13
1520	Bryne	Skeid	2023-10-22 14:00:00	\N	204
1521	KFUM	Raufoss	2023-10-22 14:00:00	\N	204
1522	Moss	Ranheim	2023-10-22 14:00:00	\N	204
1523	Halmstad	Mjällby AIF	2023-10-22 14:00:00	\N	14
1524	Malmo FF	Varbergs BoIS FC	2023-10-22 16:30:00	\N	14
1525	BK Hacken	IFK Norrkoping	2023-10-22 16:30:00	\N	14
1526	Landskrona	Västerås SK FK	2023-10-22 12:00:00	\N	336
1527	Orgryte IS	Trelleborgs FF	2023-10-22 14:00:00	\N	336
1528	IK Brage	AFC Eskilstuna	2023-10-22 14:00:00	\N	336
1529	Winterthur	St Gallen	2023-10-22 13:15:00	\N	15
1530	Grasshoppers	Lugano	2023-10-22 15:30:00	\N	15
1531	Lucerne	Yverdon Sport FC	2023-10-22 15:30:00	\N	15
1336	Sporting Kansas City	Minnesota United	2023-10-22 02:00:00	\N	76
1337	Portland Timbers	Houston Dynamo	2023-10-22 02:00:00	\N	76
1652	Fiorentina	Empoli	2023-10-23 19:45:00	\N	4
1653	Odense BK	Midtjylland	2023-10-23 18:00:00	\N	40
1654	AZ Reserves	De Graafschap	2023-10-23 19:00:00	\N	199
1651	Tottenham	Fulham	2023-10-23 20:00:00	\N	2
1655	Ajax Reserves	ADO Den Haag	2023-10-23 19:00:00	\N	199
1656	Helmond Sport	FC Dordrecht	2023-10-23 19:00:00	\N	199
1657	PSV Reserves	FC Eindhoven	2023-10-23 19:00:00	\N	199
1658	FC Groningen	FC Emmen	2023-10-23 19:00:00	\N	199
1659	Jonkopings Sodra	Skövde AIK	2023-10-23 18:00:00	\N	336
\.


--
-- TOC entry 3418 (class 0 OID 16549)
-- Dependencies: 219
-- Data for Name: over2p5orbitxch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5orbitxch (id, home, away, date_time, url, plaied, ht_goals, ft_goals, league_id) FROM stdin;
1	Polokwane City	Bloemfontein Celtic	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218763604	f	\N	\N	\N
2	Poblense	CF Platges de Calvia	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219003201	f	\N	\N	\N
3	Yeclano Deportivo	San Roque Lepe	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218971384	f	\N	\N	\N
4	CE Manacor	Santanyi	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219003324	f	\N	\N	\N
5	Puszcza Niepolomice	Ruch Chorzow	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218593429	f	\N	\N	\N
6	CD Burgos Promesas	CD La Virgen	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218997332	f	\N	\N	\N
7	Odra Opole	GKS Katowice	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218652631	f	\N	\N	\N
8	Coquimbo Unido	Nublense	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218719576	f	\N	\N	\N
10	Real Sociedad III	AD San Juan	2023-09-30 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218894805	f	\N	\N	\N
11	Wiener SK	SV Leobendorf	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218934306	f	\N	\N	\N
12	IF Vestri	Afturelding	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218982831	f	\N	\N	\N
13	Motala	IF Sylvia	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218739035	f	\N	\N	\N
14	Anderlecht (W)	Club Brugge (W)	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218988788	f	\N	\N	\N
15	Mamelodi Sundowns	Bumamuru	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219009979	f	\N	\N	\N
16	Athletic Bilbao B	Valle de Egüés	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218894715	f	\N	\N	\N
17	CD Castellon	Merida AD	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218902697	f	\N	\N	\N
18	Ponferradina	CA Osasuna II	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218808824	f	\N	\N	\N
19	07 Vestur	AB Argir	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218989151	f	\N	\N	\N
21	Sligo Rovers (W)	Bohemians (W)	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218920530	f	\N	\N	\N
22	Skra Czestochowa	GKS Jastrzebie	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218982513	f	\N	\N	\N
23	Ruzomberok	Zemplin	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218828885	f	\N	\N	\N
24	Zamalek	Solar7	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219006565	f	\N	\N	\N
25	FC Vilafranca	Girona FC II	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218996961	f	\N	\N	\N
26	Chernomorets Odesa	Zorya	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218757012	f	\N	\N	\N
28	Sol De Mayo	Villa Mitre	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218980991	f	\N	\N	\N
29	Genclerbirligi	Manisa FK	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218731473	f	\N	\N	\N
30	Valencia-Mestalla	Cerdanyola del Valles	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218896353	f	\N	\N	\N
31	Sparta Prague	Plzen	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505965	f	\N	\N	\N
32	Trencin	DUKLA BANSKA BYSTRICA	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218617971	f	\N	\N	\N
34	Rayon Sports FC	Al Hilal	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219006655	f	\N	\N	\N
35	Galatasaray	Ankaragucu	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560132	f	\N	\N	\N
36	Crvena Zvezda	Radnicki Nis	2023-09-30 17:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218982242	f	\N	\N	\N
37	Oud-Heverlee Leuven	Standard	2023-09-30 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218722677	f	\N	\N	\N
38	Connahs Quay	Penybont FC	2023-09-30 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218951219	f	\N	\N	\N
39	TuS BW Lohne	Weiche Flensburg	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218876855	f	\N	\N	\N
40	Carrarese	Entella	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218874991	f	\N	\N	\N
41	Glenavon	Larne	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218885643	f	\N	\N	\N
42	SD Solares	Castro FC	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218997141	f	\N	\N	\N
43	CD Derio	Urduliz FT	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218997051	f	\N	\N	\N
44	Potenza	Nuova Monterosi	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218908901	f	\N	\N	\N
45	Stirling	Cove Rangers	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218720116	f	\N	\N	\N
46	Nk Posusje	Tuzla City	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218972929	f	\N	\N	\N
47	Defensores de Belgrano	All Boys	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218871552	f	\N	\N	\N
48	Elche	Levante	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218683711	f	\N	\N	\N
50	Tottenham	Liverpool	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218409626	f	\N	\N	\N
52	Maccabi Petach Tikva	Bnei Sakhnin	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218907071	f	\N	\N	\N
53	Oxford City	Altrincham	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218715494	f	\N	\N	\N
54	Giana Erminio	Arzignanochiampo	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218867413	f	\N	\N	\N
55	Pro Vercelli	Fiorenzuola	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218867503	f	\N	\N	\N
56	FC Ashdod	Hapoel Eran Hadera	2023-09-30 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218723364	f	\N	\N	\N
5754	Hapoel Marmorek	Maccabi Ashdod B.C.	2023-10-09 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219419674	f	\N	\N	\N
33	AC Milan	Lazio	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218580648	t	0	2	4
27	Servette	Lausanne	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218798925	t	1	\N	15
49	Girona	Real Madrid	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218580528	t	\N	\N	\N
51	RB Leipzig	Bayern Munich	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218409706	t	\N	\N	\N
20	Winterthur	Lugano	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218798817	t	1	\N	15
57	Hapoel Haifa	Maccabi Bnei Raina	2023-09-30 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218723273	f	\N	\N	\N
4650	FC Seoul	Jeonbuk Motors	2023-10-08 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219083851	t	0	\N	66
60	Shabab Al Dharia	Ahli Al Khalil	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218982423	f	\N	\N	\N
61	Skala	Vikingur II	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218989242	f	\N	\N	\N
62	Caen	Guingamp	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218723835	f	\N	\N	\N
63	Macva Sabac	FK Jedinstvo Ub	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218982062	f	\N	\N	\N
64	Deportiva Venados	Reboceros de La Piedad	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218982603	f	\N	\N	\N
65	Angers	Concarneau	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218828492	f	\N	\N	\N
66	Auxerre	Rodez	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218831269	f	\N	\N	\N
67	Grenoble	Bordeaux	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218723619	f	\N	\N	\N
68	FK Auda	FK Riga	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218948765	f	\N	\N	\N
69	Lugo	Gimnastic	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218808914	f	\N	\N	\N
70	Club Atletico el Linqueno	Sportivo AC Las Pareja	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218966895	f	\N	\N	\N
71	Villarreal (W)	Valencia (W)	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218987123	f	\N	\N	\N
72	KV Mechelen (W)	Oud-Heverlee Leuven (W)	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218981486	f	\N	\N	\N
73	Mladost Lucani	FK Backa Topola	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218982152	f	\N	\N	\N
74	Dunkerque	Quevilly Rouen	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218856579	f	\N	\N	\N
75	Laval	Valenciennes	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218723727	f	\N	\N	\N
76	Pau	Amiens	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218723943	f	\N	\N	\N
77	Botev Plovdiv	Beroe Stara Za	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218767440	f	\N	\N	\N
79	HB Torshavn	B68 Toftir	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218978689	f	\N	\N	\N
80	Utebo CF	CD Calahorra	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218895075	f	\N	\N	\N
81	Hapoel Beer Sheva	Hapoel Jerusalem	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218723454	f	\N	\N	\N
82	SD Borja	CD Belchite 97	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218997231	f	\N	\N	\N
83	Annecy	Paris FC	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218831154	f	\N	\N	\N
84	Sheriff Tiraspol	CSF Balti	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218982332	f	\N	\N	\N
85	Slaven Belupo	Osijek	2023-09-30 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218729835	f	\N	\N	\N
86	Ciudad de Bolivar	San Martin de Mendoza	2023-09-30 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218981124	f	\N	\N	\N
87	DEBRECENI VSC	Ujpest	2023-09-30 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218427885	f	\N	\N	\N
88	FCB Magpies	Manchester 62 FC	2023-09-30 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219019069	f	\N	\N	\N
89	St Pauli II	Hamburg II	2023-09-30 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218877377	f	\N	\N	\N
91	Al-Khaleej Saihat	Dhamk	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218735554	f	\N	\N	\N
92	CA Germinal	Santamarina	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218981214	f	\N	\N	\N
93	Cordoba	Granada B	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218902247	f	\N	\N	\N
94	Cruz Azul (W)	Club Leon FC (W)	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218982709	f	\N	\N	\N
95	JS Saoura	ES Ben Aknoun	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219000082	f	\N	\N	\N
96	ASO Chlef	CS Constantine	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219000172	f	\N	\N	\N
97	Mushuc Runa	Cumbaya FC	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218730285	f	\N	\N	\N
98	Magallanes	Everton De Vina	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218719306	f	\N	\N	\N
99	HFX Wanderers	Forge	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829605	f	\N	\N	\N
100	Anderlecht B	Lierse	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218769185	f	\N	\N	\N
101	Stal Rzeszow	Resovia Rzeszow	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218652811	f	\N	\N	\N
102	Al Ahli	Al-Ettifaq	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218758814	f	\N	\N	\N
103	Warta Poznan	Slask Wroclaw	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218593519	f	\N	\N	\N
104	CF Rayo Majadahonda	CD Teruel	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218808284	f	\N	\N	\N
105	Mura	NK Celje	2023-09-30 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218915414	f	\N	\N	\N
106	Villa San Carlos	CA San Miguel	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218981304	f	\N	\N	\N
107	Longford	Treaty United	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218835535	f	\N	\N	\N
108	CA Colegiales	Sacachispas	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218981396	f	\N	\N	\N
109	Estudiantes de Caseros	Atletico Mitre	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218871462	f	\N	\N	\N
110	Hercules	CE Andratx	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218903093	f	\N	\N	\N
111	CA Guemes	CA Temperley	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218871764	f	\N	\N	\N
112	Juventude	Criciuma	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218730720	f	\N	\N	\N
59	PSV	FC Volendam	2023-09-30 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218426696	t	\N	\N	\N
90	Francs Borains	Seraing Utd	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218971715	t	0	\N	136
78	Boavista	Famalicao	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218771434	t	2	4	8
115	Farul Constanta	ACS Sepsi OSK	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218526974	f	\N	\N	\N
116	Wexford Youths (W)	Shamrock Rovers (W)	2023-09-30 19:35:00	https://www.orbitxch.com/customer/sport/1/market/1.218920416	f	\N	\N	\N
117	LR Vicenza Virtus	Atalanta B	2023-09-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218909202	f	\N	\N	\N
118	Arezzo	Pontedera	2023-09-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218874811	f	\N	\N	\N
119	Yellow-Red Mechelen	Antwerp	2023-09-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218729475	f	\N	\N	\N
120	Sarajevo	Zvijezda 09 Bijeljina	2023-09-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218973037	f	\N	\N	\N
121	Salernitana	Inter	2023-09-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218585077	f	\N	\N	\N
122	Linares	Provincial Osorno	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219002281	f	\N	\N	\N
123	Deportes Melipilla	Deportes Rengo Unido	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219002371	f	\N	\N	\N
124	Sao Bernardo	Brusque FC	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218913572	f	\N	\N	\N
125	Bogota	Tigres FC Zipaquira	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218843407	f	\N	\N	\N
127	San Lorenzo	Huracan	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218776363	f	\N	\N	\N
128	Ferro Carril	Racing Cordoba	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218956268	f	\N	\N	\N
130	CD General Velasquez	Deportes Limache	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219002191	f	\N	\N	\N
131	Albacete	Andorra CF	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218683603	f	\N	\N	\N
132	Villarreal B	Alcorcon	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705518	f	\N	\N	\N
134	Real Sociedad	Athletic Bilbao	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218584957	f	\N	\N	\N
135	Flamengo	Bahia	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218460531	f	\N	\N	\N
136	Fortaleza EC	Gremio	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218460411	f	\N	\N	\N
137	Deportivo La Guaira	Universidad de Venezuela	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218970275	f	\N	\N	\N
138	San Martin de San Juan	Defensores Unidos	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218872095	f	\N	\N	\N
139	Deportivo Tachira	CD Hermanos Colmenarez	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218970455	f	\N	\N	\N
140	Zamora FC	Carabobo FC	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218970365	f	\N	\N	\N
141	Rosario Central	Newells	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218776471	f	\N	\N	\N
142	Argentino Monte Maiz	Huracan Las Heras	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218984452	f	\N	\N	\N
143	Farense	Sporting Lisbon	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218780618	f	\N	\N	\N
144	Angostura FC	Portuguesa FC	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218970635	f	\N	\N	\N
145	Puerto Cabello	Estudiantes de Merida	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218970185	f	\N	\N	\N
146	Mineros Guayana	Monagas	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218970725	f	\N	\N	\N
147	Rayo Zuliano	Caracas	2023-09-30 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218970545	f	\N	\N	\N
148	Real San Joaquin	Lautaro de Buin	2023-09-30 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219005535	f	\N	\N	\N
149	Guarani	Novorizontino	2023-09-30 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218670914	f	\N	\N	\N
150	Cienciano	Atletico Grau	2023-09-30 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218856669	f	\N	\N	\N
151	Ituano	Botafogo SP	2023-09-30 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218670806	f	\N	\N	\N
152	Atletico FC Cali	Llaneros FC	2023-09-30 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218729745	f	\N	\N	\N
153	Huachipato	Deportes Copiapo	2023-09-30 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218719396	f	\N	\N	\N
154	El Nacional	Delfin	2023-09-30 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218730195	f	\N	\N	\N
155	CSD Municipal	CSD Tellioz	2023-09-30 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218975035	f	\N	\N	\N
156	Patronato	San Telmo	2023-09-30 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218871658	f	\N	\N	\N
157	ABC RN	Ponte Preta	2023-09-30 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218674197	f	\N	\N	\N
158	Atletico Bucaramanga	Santa Fe	2023-09-30 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218869862	f	\N	\N	\N
159	Tauro FC	Herrera FC	2023-09-30 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218972525	f	\N	\N	\N
160	Sao Paulo	Corinthians	2023-09-30 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218460290	f	\N	\N	\N
161	Cuiaba	Fluminense	2023-09-30 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218460170	f	\N	\N	\N
162	Gavilanes Matamoros	Mexicali FC	2023-09-30 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218995808	f	\N	\N	\N
163	Club Atletico Pantoja	Moca FC	2023-09-30 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219007513	f	\N	\N	\N
164	Colima FC	Tritones Vallarta MFC	2023-09-30 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218995900	f	\N	\N	\N
165	Alvarado	Agropecuario	2023-09-30 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218872198	f	\N	\N	\N
166	Racing Club	CA Independiente	2023-09-30 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218776255	f	\N	\N	\N
167	Olancho	CD Victoria	2023-09-30 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218972345	f	\N	\N	\N
168	Artesanos Metepec F.C.	Club CDM	2023-09-30 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219010069	f	\N	\N	\N
129	RKC Waalwijk	Ajax	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218426912	t	3	\N	196
5893	PSKC Cimahi	Putra Safin Group	2023-10-10 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219514783	f	\N	\N	\N
126	FC Twente	Heerenveen	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218427021	t	0	\N	196
133	Monaco	Marseille	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218408412	t	\N	\N	\N
169	Botafogo PB	Volta Redonda	2023-09-30 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218913662	f	\N	\N	\N
170	Yalmakan FC	Inter de Queretaro FC	2023-09-30 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218995990	f	\N	\N	\N
171	Deportivo Irapuato FC	Club Sporting Canamy	2023-10-01 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219015714	f	\N	\N	\N
172	Escorpiones FC	Lobos ULMX	2023-10-01 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219001141	f	\N	\N	\N
173	Independiente (Ecu)	Emelec	2023-10-01 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218736478	f	\N	\N	\N
174	Cafetaleros de Chiapas II	Club San Juan de Arago	2023-10-01 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219015894	f	\N	\N	\N
175	Pachuca	Necaxa	2023-10-01 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218470283	f	\N	\N	\N
176	Union Espanola	Curico Unido	2023-10-01 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218719486	f	\N	\N	\N
177	Tacuary	Nacional (Par)	2023-10-01 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218987937	f	\N	\N	\N
178	Atlante	Tapatio	2023-10-01 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218763334	f	\N	\N	\N
179	Atletico Nacional Medellin	Envigado	2023-10-01 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218869501	f	\N	\N	\N
180	Alianza FC (Pan)	UMECIT	2023-10-01 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218972435	f	\N	\N	\N
181	Columbus	Philadelphia	2023-10-01 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218734697	f	\N	\N	\N
182	Toronto FC	FC Cincinnati	2023-10-01 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218735230	f	\N	\N	\N
183	Orlando City	CF Montreal	2023-10-01 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218757964	f	\N	\N	\N
184	New York Red Bulls	Chicago Fire	2023-10-01 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218734860	f	\N	\N	\N
185	New England	Charlotte FC	2023-10-01 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218735122	f	\N	\N	\N
186	Inter Miami CF	New York City	2023-10-01 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218734219	f	\N	\N	\N
187	Santos de Guapiles	Puntarenas F.C.	2023-10-01 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218963813	f	\N	\N	\N
188	Coras de Nayarit FC	Cimarrones de Sonora II	2023-10-01 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219015804	f	\N	\N	\N
189	Rionegro	Deportivo Pasto	2023-10-01 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218870132	f	\N	\N	\N
190	Antigua GFC	Guastatoya	2023-10-01 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218974945	f	\N	\N	\N
191	CD Real Sociedad	Lobos UPNFM	2023-10-01 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218972075	f	\N	\N	\N
192	CD Municipal Limeno	Santa Tecla	2023-10-01 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218977235	f	\N	\N	\N
193	Internacional	Atletico MG	2023-10-01 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218465341	f	\N	\N	\N
194	Banfield	Lanus	2023-10-01 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218829425	f	\N	\N	\N
195	Minnesota Utd	San Jose Earthquakes	2023-10-01 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218734435	f	\N	\N	\N
196	Nashville SC	Seattle Sounders	2023-10-01 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218734327	f	\N	\N	\N
197	St Louis City SC	Kansas City	2023-10-01 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218734968	f	\N	\N	\N
198	Houston Dynamo	FC Dallas	2023-10-01 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218758072	f	\N	\N	\N
199	CF America	Pumas UNAM	2023-10-01 01:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218470193	f	\N	\N	\N
200	Mazatlan FC	Tigres	2023-10-01 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218470013	f	\N	\N	\N
201	Racing FC Porto Palmeiras	Halcones de Zapopan	2023-10-01 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219015984	f	\N	\N	\N
202	AD Isidro Metapan	Cd Fas	2023-10-01 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218977325	f	\N	\N	\N
203	Monterrey	Santos Laguna	2023-10-01 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218470985	f	\N	\N	\N
204	Deportivo Pereira	America de Cali S.A	2023-10-01 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218869952	f	\N	\N	\N
205	Sporting San Miguelito	Atletico Chiriqui	2023-10-01 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218972614	f	\N	\N	\N
206	Colorado	Austin FC	2023-10-01 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218757854	f	\N	\N	\N
207	Municipal Perez Zeledon	CS Herediano	2023-10-01 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218963363	f	\N	\N	\N
208	Auckland City	Manurewa AFC	2023-10-01 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218940552	f	\N	\N	\N
209	Malacateco	Comunicaciones	2023-10-01 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218974855	f	\N	\N	\N
210	Vida	CD Marathon	2023-10-01 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218972255	f	\N	\N	\N
211	AD San Carlos	Sporting San Jose FC	2023-10-01 03:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218963543	f	\N	\N	\N
212	Vancouver Whitecaps	DC Utd	2023-10-01 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218758180	f	\N	\N	\N
213	LA Galaxy	Portland Timbers	2023-10-01 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218758288	f	\N	\N	\N
214	Toyama	Ehime	2023-10-01 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218854105	f	\N	\N	\N
215	Tottori	FC Imabari	2023-10-01 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218853925	f	\N	\N	\N
216	Cheongju FC	Bucheon FC 1995	2023-10-01 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218759273	f	\N	\N	\N
9	Norrkoping	Kalmar FF	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218572509	t	1	1	14
58	FC Utrecht	Almere City	2023-09-30 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218426804	t	0	2	196
217	FE Grama	AE Prat	2023-10-01 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219050503	f	\N	\N	\N
114	Grasshoppers Zurich	Young Boys	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218803023	t	1	1	15
113	Hertha Berlin	St Pauli	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218517026	t	1	3	93
218	CD Siete Villas	CD Colindres	2023-10-01 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219050953	f	\N	\N	\N
219	Santa Eulalia	CF Badalona Futur	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218938484	f	\N	\N	\N
220	CA Antoniano	UCAM Murcia	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218971907	f	\N	\N	\N
221	Fuenlabrada	Deportivo	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218809124	f	\N	\N	\N
222	Cacereno	SS Reyes	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218970815	f	\N	\N	\N
223	Ibiza Eivissa	Linares Deportivo	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218902517	f	\N	\N	\N
224	Olivenza	SP Villafranca	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219048162	f	\N	\N	\N
225	Puente Genil FC	Ayamonte	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219048882	f	\N	\N	\N
226	CD Cabecense	Xerez CD	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219048972	f	\N	\N	\N
227	CD Utrera	CD Gerena	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219049062	f	\N	\N	\N
228	Algeciras	Atletico Sanluqueno CF	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218906963	f	\N	\N	\N
229	CF Montanesa	UE Tona	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219050413	f	\N	\N	\N
230	Mallorca B	CD Llosetense	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219048612	f	\N	\N	\N
231	FC Zhetysu	FC Ordabasy	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219015264	f	\N	\N	\N
232	CE Europa	SE Penya Independent	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218938754	f	\N	\N	\N
233	AD Alcorcon II	CD Colonia Moscardo	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219049422	f	\N	\N	\N
234	CDE Ursaria	Guadalajara	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218974405	f	\N	\N	\N
235	Academico de Viseu	AVS Futebol SAD	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218757689	f	\N	\N	\N
236	FC Minaj	Obolon-Brovar Kiev	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829335	f	\N	\N	\N
237	CD Las Rozas	Alcala RSD	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219049242	f	\N	\N	\N
238	CF Pozuelo de Alarcon	CDF Tres Cantos	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219049332	f	\N	\N	\N
239	Pobla de Mafumet CF	Rapitenca	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219050323	f	\N	\N	\N
240	UD Logrones II	CD Calahora B	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047712	f	\N	\N	\N
241	CD Badajoz	UD San Fernando	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218970995	f	\N	\N	\N
242	Centre d'Esports Manresa	Lleida	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218939024	f	\N	\N	\N
243	Antequera CF	Atletico Baleares	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218902877	f	\N	\N	\N
244	Cornella	Sociedad B	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218810309	f	\N	\N	\N
245	Real Sociedad (W)	Betis (W)	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219024222	f	\N	\N	\N
246	Club Atletico Saguntino	Espanyol B	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218938844	f	\N	\N	\N
247	Comillas	Casalarreina CF	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047802	f	\N	\N	\N
248	UDG Tenerife Sur (W)	Real Madrid FC (W)	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219021764	f	\N	\N	\N
249	CD Berceo	CDFC La Calzada	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047892	f	\N	\N	\N
250	Pogon Tczew (W)	GKS Katowice (W)	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219016074	f	\N	\N	\N
251	Socuellamos	CD Tarancon	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047262	f	\N	\N	\N
252	UE Castelldefels	L'Hospitalet	2023-10-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219050233	f	\N	\N	\N
253	FC Utrecht (W)	Heerenveen (W)	2023-10-01 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219023158	f	\N	\N	\N
254	PSV Eindhoven (W)	AZ Alkmaar Women	2023-10-01 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219023052	f	\N	\N	\N
256	Silva SD	UD Paiosaco	2023-10-01 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219051223	f	\N	\N	\N
257	Fortuna Sittard (W)	Excelsior (W)	2023-10-01 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219016347	f	\N	\N	\N
258	Twente (W)	Feyenoord (W)	2023-10-01 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219016437	f	\N	\N	\N
259	NEC Nijmegen	Vitesse Arnhem	2023-10-01 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218427129	f	\N	\N	\N
260	Ayutthaya United	Nongbua Pitchaya FC	2023-10-01 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219025302	f	\N	\N	\N
261	Nakhon Pathom	Police Tero	2023-10-01 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218952892	f	\N	\N	\N
262	Belediyesi Bodrumspor	Corum Belediyespor	2023-10-01 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218773111	f	\N	\N	\N
263	Napoli Calcio (W)	AC Milan (W)	2023-10-01 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219015534	f	\N	\N	\N
264	Erzurum BB	Boluspor	2023-10-01 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218763964	f	\N	\N	\N
265	Fatih Karagumruk Istanbul	Kasimpasa	2023-10-01 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218558816	f	\N	\N	\N
266	Bologna	Empoli	2023-10-01 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218619879	f	\N	\N	\N
267	Wisla Krakow	Wisla Plock	2023-10-01 11:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218652541	f	\N	\N	\N
268	CD Vitoria	Leioa	2023-10-01 11:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219050683	f	\N	\N	\N
269	Lee Man Warriors	Hong Kong Rangers FC	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219016953	f	\N	\N	\N
272	Floy Flekkeroy	Brattvag	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219016255	f	\N	\N	\N
273	Brommapojkarna (W)	Kristianstads (W)	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219017043	f	\N	\N	\N
274	TSG Hoffenheim U19	Kaiserslautern U19	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219061621	f	\N	\N	\N
255	VVV Venlo	Helmond Sport	2023-10-01 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218770207	t	1	4	199
270	Blackburn	Leicester	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218602678	t	2	\N	77
5894	Angola (W)	Mozambique (W)	2023-10-10 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219511759	f	\N	\N	\N
275	BK Olympic	Ariana FC	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218758913	f	\N	\N	\N
276	Eimsbutteler	Norderstedt	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218876645	f	\N	\N	\N
277	SKN St. Polten (W)	SG FC Bergheim/USK Hof (W)	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219017898	f	\N	\N	\N
279	Karlsruher SC U19	SpVgg Greuther Furth U19	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219061531	f	\N	\N	\N
280	FK Kaspyi Aktau	Kairat Almaty	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219016683	f	\N	\N	\N
282	CD Buzanada	CD La Cuadra	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219048432	f	\N	\N	\N
283	Hammarby (W)	IK Uppsala (W)	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219021242	f	\N	\N	\N
284	Berliner AK	FSV Zwickau	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218912281	f	\N	\N	\N
278	Durham (W)	Reading (W)	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219061829	f	\N	\N	\N
271	SK Super Nova	FK Jelgava	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218948672	f	\N	\N	\N
288	Iran U23	Hong Kong U23	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218983101	f	\N	\N	\N
289	Rot-Weiss Essen	Dynamo Dresden	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218769937	f	\N	\N	\N
292	Kuressaare	Tallinna Kalev	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218856801	f	\N	\N	\N
4720	PEC Zwolle	Feyenoord	2023-10-08 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218766183	t	1	\N	196
294	Aston Villa (W)	Man Utd (W)	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218865614	f	\N	\N	\N
296	Union St Gilloise	Charleroi	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218771002	f	\N	\N	\N
297	JL Chiangmai United	Chanthaburi FC	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219019339	f	\N	\N	\N
298	KF Shkupi	FK Struga Trim-Lum	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219018709	f	\N	\N	\N
299	Bandari FC (Kenya)	Kakamega Homeboyz	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218915165	f	\N	\N	\N
300	Chonburi	Air Force Central	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218952529	f	\N	\N	\N
301	Bodens	Dalkurd FF	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218793577	f	\N	\N	\N
302	Norwich U21	West Brom U21	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219031658	f	\N	\N	\N
303	Egnatia Rrogozhine	KS Teuta Durres	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219029578	f	\N	\N	\N
304	Elazigspor	Batman Petrolspor	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052142	f	\N	\N	\N
305	Juventus B	Sassari Torres	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218875388	f	\N	\N	\N
306	Casertana	Catania	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218908991	f	\N	\N	\N
307	AFC Leopards SC (Kenya)	Shabana	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218914429	f	\N	\N	\N
308	FK Gostivar	Shkendija	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219018979	f	\N	\N	\N
309	ACR Messina	Avellino	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218909115	f	\N	\N	\N
310	Kapaz Ganja	FK Qabala	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218928358	f	\N	\N	\N
311	Suphanburi	Samut Prakan	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219019249	f	\N	\N	\N
312	1954 Kelkit Belediyespor	Amasyaspor 1968 FK	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052232	f	\N	\N	\N
313	Olbia	Ancona	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218875478	f	\N	\N	\N
314	Everton (W)	Brighton (W)	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218865704	f	\N	\N	\N
315	Diyarbekirspor	1461 Trabzon	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219026623	f	\N	\N	\N
316	Fredericia	Naestved	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218768651	f	\N	\N	\N
317	Kryvbas Krivyi Rih	Rukh Vynnyky	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218757507	f	\N	\N	\N
318	Gor Mahia FC	KCB	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218914701	f	\N	\N	\N
319	Traeff	Egersund	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219016165	f	\N	\N	\N
320	Rabotnicki	Tikves Kavadarci	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219018889	f	\N	\N	\N
321	FC Talanta	Tusker FC	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218915075	f	\N	\N	\N
322	Eldense	Oviedo	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218763694	f	\N	\N	\N
323	Lamia	Panaitolikos	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218881125	f	\N	\N	\N
324	Universitatea Craiova	Botosani	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527247	f	\N	\N	\N
326	Randers	Silkeborg	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218712887	f	\N	\N	\N
327	Bregalnica Stip	Vardar Skopje	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219018799	f	\N	\N	\N
328	China U23	South Korea U23	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218983281	f	\N	\N	\N
329	Persib Bandung	Persita Tangerang	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219019429	f	\N	\N	\N
285	Reims	Lyon	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218408542	t	1	\N	5
290	VFL Osnabruck	Kaiserslautern	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218523558	t	2	\N	93
291	Zulte-Waregem	Club Brugge B	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218971535	t	1	1	136
330	Almeria	Granada	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218737270	t	2	\N	3
295	Nurnberg	FC Magdeburg	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218523450	t	0	1	93
281	HB Koge	FC Helsingor	2023-10-01 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218768989	t	0	1	147
325	Vejle	FC Nordsjaelland	2023-10-01 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218669918	t	0	0	40
331	Bellinzona	Stade Nyonnais	2023-10-01 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218854658	f	\N	\N	\N
332	Arda	Etar	2023-10-01 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218767530	f	\N	\N	\N
334	FC Baden	Schaffhausen	2023-10-01 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218763874	f	\N	\N	\N
335	FC Vaduz	Thun	2023-10-01 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218763784	f	\N	\N	\N
336	68 Aksaray Belediyespor	Ispartaspor	2023-10-01 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219026713	f	\N	\N	\N
339	Ankaraspor	Serik Belediyespor	2023-10-01 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219026803	f	\N	\N	\N
340	Talasgucu Belediyespor	Gumushanespor	2023-10-01 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219052412	f	\N	\N	\N
342	Sassuolo (W)	Pomigliano (W)	2023-10-01 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219015624	f	\N	\N	\N
343	Sturm Graz	WSG Wattens	2023-10-01 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218426370	f	\N	\N	\N
344	Vasteras SK	Trelleborgs	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829245	f	\N	\N	\N
345	Crystal Palace U21	Liverpool U21	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219031567	f	\N	\N	\N
346	Teplice	Slavia Prague	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218506415	f	\N	\N	\N
347	Gyirmot	Siofok	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219020003	f	\N	\N	\N
348	Duzcespor	Arnavutkoy Belediyesi GVS	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219026983	f	\N	\N	\N
349	NK Rogaska	Olimpija	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218914704	f	\N	\N	\N
350	Iraklis	Anagennisi Karditsas	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219020363	f	\N	\N	\N
351	Kocaelispor	Keciorengucu	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218772845	f	\N	\N	\N
352	Arsenal (W)	Liverpool (W)	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218865900	f	\N	\N	\N
353	Budafoki	Haladas	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219020093	f	\N	\N	\N
354	Sloga Doboj	Gosk Gabela	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218972821	f	\N	\N	\N
356	MTE 1904	Tiszakecske VSE	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219020183	f	\N	\N	\N
357	Sirens FC	Hamrun Spartans FC	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219005716	f	\N	\N	\N
358	FK Tukums 2000	Valmieras FK	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218948492	f	\N	\N	\N
360	JaPS	KPV	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218920891	f	\N	\N	\N
361	Nykobing FC	Fremad Amager	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219020830	f	\N	\N	\N
362	Ghazl El Mahallah	Haras El Hodood	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219072102	f	\N	\N	\N
363	Soroksar	Gyori	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219019697	f	\N	\N	\N
364	Sunderland (W)	Watford (W)	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219031477	f	\N	\N	\N
365	Bristol City (W)	Leicester City (W)	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218865508	f	\N	\N	\N
368	Leixoes	Porto B	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218763514	f	\N	\N	\N
369	Halide Edip Adivarspor	Bursaspor	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219027163	f	\N	\N	\N
370	Rakow Czestochowa	Radomiak Radom	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218593987	f	\N	\N	\N
371	Ilioupoli	Ionikos	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218953165	f	\N	\N	\N
372	VfB Oldenburg	Kieler SV Holstein II	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218876735	f	\N	\N	\N
374	MOL Vidi	Kisvarda	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218638530	f	\N	\N	\N
375	Junkeren	Baerum	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219016863	f	\N	\N	\N
376	Nieciecza	Lechia Gdansk	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218652919	f	\N	\N	\N
378	Iskenderunspor	Karaman Belediyespor	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219026893	f	\N	\N	\N
379	Umea FC	Hammarby TFF	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218863297	f	\N	\N	\N
381	Nice	Brest	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218408803	f	\N	\N	\N
382	Inegol Kafkas Genclikspor	Kirikkale Buyuk Anadol	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052322	f	\N	\N	\N
383	Mlada Boleslav	Bohemians 1905	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218506505	f	\N	\N	\N
4735	AFC Eskilstuna	Landskrona	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219166982	t	0	1	336
385	Udinese	Genoa	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218765366	f	\N	\N	\N
386	Nottm Forest	Brentford	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218410154	f	\N	\N	\N
337	Heracles	PEC Zwolle	2023-10-01 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218427237	t	0	3	196
367	Kongsvinger	Bryne	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218657582	t	2	\N	204
359	Sirius	Degerfors	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218572620	t	1	5	14
377	Asane	Ranheim IL	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218657763	t	2	\N	204
373	Hacken	AIK	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218572728	t	0	\N	14
10106	Olmaliq	Sepahan	2023-10-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220084325	f	\N	\N	\N
380	Toulouse	Metz	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218430179	t	2	\N	5
341	Hartberg	SCR Altach	2023-10-01 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218426479	t	0	0	43
338	Excelsior	Sparta Rotterdam	2023-10-01 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218427345	t	0	3	196
366	Fredrikstad	Raufoss	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218657402	t	0	\N	204
355	Moss	Hodd	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218657492	t	2	\N	204
388	Naxxar Lions	Santa Lucia FC	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219005807	f	\N	\N	\N
389	Southampton (W)	Birmingham (W)	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219061742	f	\N	\N	\N
390	Bursa Yildirim Spor	Nevsehir Belediyespor	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219051962	f	\N	\N	\N
391	JJK	Jaro	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218921260	f	\N	\N	\N
392	Haka	Lahti	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218590480	f	\N	\N	\N
393	KaPa	SalPA	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218921076	f	\N	\N	\N
394	Fenerbahce	Rizespor	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559140	f	\N	\N	\N
395	FK Igman Konjic	Zrinjski	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218972726	f	\N	\N	\N
396	London City Lionesses	Charlton (W)	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219020740	f	\N	\N	\N
397	Fortuna Hjorring (W)	Aalborg BK (W)	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219021152	f	\N	\N	\N
398	Sariyer G.K.	Etimesgut Belediyespor	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219027073	f	\N	\N	\N
399	Kutahyaspor	Akhisar Belediye	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052502	f	\N	\N	\N
400	Rudes	Rijeka	2023-10-01 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218770657	f	\N	\N	\N
401	NFC Volos	Panserraikos	2023-10-01 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218767260	f	\N	\N	\N
402	TS Galaxy FC	Richards Bay FC	2023-10-01 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218803992	f	\N	\N	\N
408	Vikingur Gota	B36 Torshavn	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219021618	f	\N	\N	\N
425	Gnistan	SJK 2	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218920984	f	\N	\N	\N
426	Argentino de Quilmes	CA Fenix	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219021348	f	\N	\N	\N
429	Rot-Weiss Erfurt	Carl Zeiss Jena	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219072408	f	\N	\N	\N
427	Radnik Surdulica	FK Javor Ivanjica	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219012104	f	\N	\N	\N
404	TB Tvoroyri	EB/Streymur	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219076363	f	\N	\N	\N
416	Levante UD II	Atzeneta UE	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219049963	f	\N	\N	\N
428	Parnu JK Vaprus	Tallinna FC Flora	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218856891	f	\N	\N	\N
417	Angelholms	Vanersborgs IF	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218807455	f	\N	\N	\N
422	Gremio FBPA U20	Bahia EC U20	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219061922	f	\N	\N	\N
420	KR Reykjavik	Breidablik	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218966496	f	\N	\N	\N
406	Klaksvikar Itrottarfelag	Itrottarfelag Fuglafjar	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219021528	f	\N	\N	\N
421	Kaforsum	Dar Al-Dawaa	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219074075	f	\N	\N	\N
407	Intercity Sant Joan C.F	Atletico Madrid II	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218902152	f	\N	\N	\N
415	IFK Stocksund	Pitea	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218807545	f	\N	\N	\N
410	Sabadell	Sestao River	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218809945	f	\N	\N	\N
405	FC Liege	Lommel	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218971355	t	1	3	136
424	Keflavik	Fylkir	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218966406	f	\N	\N	\N
412	CF Canelas 2010	Lusitania Futebol Clube	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218932736	f	\N	\N	\N
431	Covilha	Oliveira Hospital	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218932556	f	\N	\N	\N
423	Circulo Deportivo Otamendi	Sansinena	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219024417	f	\N	\N	\N
414	Genk	Westerlo	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218771110	t	2	\N	68
411	Al-Jazeera	Etihad Al Ramtha	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219062012	f	\N	\N	\N
430	Los Andes	Argentino de Merlo	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219021438	f	\N	\N	\N
413	Fafe	CD Trofense	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218932916	f	\N	\N	\N
432	Varnsdorf	Vyskov	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218770297	f	\N	\N	\N
409	West Ham United (W)	Man City (W)	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218865794	f	\N	\N	\N
437	Virtus Francavilla	FC Giugliano	2023-10-01 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218909363	f	\N	\N	\N
433	Sampdoria	Catanzaro	2023-10-01 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218918540	f	\N	\N	\N
435	OHiggins	Union La Calera	2023-10-01 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218719189	f	\N	\N	\N
434	Cittadella	Lecco	2023-10-01 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218918810	f	\N	\N	\N
439	Cesena	Rimini	2023-10-01 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218875298	f	\N	\N	\N
438	SSD Bari	Como	2023-10-01 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218918901	f	\N	\N	\N
436	Palermo	Sudtirol	2023-10-01 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218886333	f	\N	\N	\N
440	Alaves	Osasuna	2023-10-01 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218736949	f	\N	\N	\N
441	Luzern	FC Zurich	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218805441	t	1	\N	15
442	Kerala Blasters FC	Jamshedpur FC	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218828615	f	\N	\N	\N
403	SV Darmstadt	Werder Bremen	2023-10-01 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218422468	t	2	\N	1
5129	Al Arabi (Jor)	Al-Jazeera	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219404557	f	\N	\N	\N
448	Dortmund II	Unterhaching	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218769847	f	\N	\N	\N
450	Araz Nakhchivan PFK	Zira	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218928484	f	\N	\N	\N
445	TransINVEST Vilnius	FK Siauliai	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219082784	f	\N	\N	\N
481	Austria Vienna	Rapid Vienna	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218422927	t	0	0	43
451	SD Rayo Cantabria	Valladolid B	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218895765	f	\N	\N	\N
443	CD Brea	Real Zaragoza II	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218894985	f	\N	\N	\N
446	Kallithea	Olympiacos B	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218953255	f	\N	\N	\N
494	Lorient	Montpellier	2023-10-01 16:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218409325	t	1	3	5
453	Ajax (W)	SC Telstar (W)	2023-10-01 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219022962	f	\N	\N	\N
454	Az Alkmaar	Fortuna Sittard	2023-10-01 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218427453	f	\N	\N	\N
457	FK Decic	FK Buducnost Podgorica	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219074346	f	\N	\N	\N
483	CD Cuarte	CD Ebro	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047532	f	\N	\N	\N
461	Levante Las Planas (W)	Athletic Bilbao (W)	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219021854	f	\N	\N	\N
463	UD Barbastro	CD Izarra	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218896623	f	\N	\N	\N
479	Sliema Wanderers FC	Marsaxlokk FC	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219006077	f	\N	\N	\N
465	HUSA Agadir	Raja Casablanca	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219024325	f	\N	\N	\N
462	Hobro	Kolding IF	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218768753	f	\N	\N	\N
476	Barcelona B	Celta Vigo B	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218810035	f	\N	\N	\N
468	Future FC	Singida Big Stars	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219062102	f	\N	\N	\N
477	CD Covadonga	Deportivo La Coruna II	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218895675	f	\N	\N	\N
474	Hermannstadt	Rapid Bucharest	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526791	f	\N	\N	\N
460	Marino Luanco	RS Gimnastica	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218895435	f	\N	\N	\N
467	Pontevedra CF	Guijuelo	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218895165	f	\N	\N	\N
473	Real Aviles	UP Langreo	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218895345	f	\N	\N	\N
487	CD Paracuellos Antamira	Rayo Vallecano B	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219049152	f	\N	\N	\N
447	FC Basel	Stade Lausanne-Ouchy	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218802549	t	1	3	15
469	CD Binissalem FC	CD Ibiza Islas Pitiusas	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219048522	f	\N	\N	\N
493	Rivers United FC	Etoile Filante	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219089411	f	\N	\N	\N
470	CD Burriana CF	Villarreal CF III	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219049873	f	\N	\N	\N
478	Terrassa	Torrent CF	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218938574	f	\N	\N	\N
475	Vysocina Jihlava	Prostejov	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218770387	f	\N	\N	\N
486	Conquense	CD Villacanas	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047172	f	\N	\N	\N
492	Aalesund II	Arendal	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219074436	f	\N	\N	\N
480	KuPS	SJK	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218770117	f	\N	\N	\N
489	Molde	Viking	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218519618	t	2	\N	13
482	CD Illescas	Numancia	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218974495	f	\N	\N	\N
466	Szeged 2011	Honved	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219022826	f	\N	\N	\N
491	Vasas	Csakvar	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219022736	f	\N	\N	\N
455	Naxara CD	Arenas Club de Getxo	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218896713	f	\N	\N	\N
472	SD Gernika Club	UD Mutilvera	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218896803	f	\N	\N	\N
458	Club Africain	Bahir Dar FC	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219062192	f	\N	\N	\N
485	CF Calamocha	CD Caspe	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047442	f	\N	\N	\N
471	CF Peralada	Reus FC Reddis	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219050143	f	\N	\N	\N
456	Club Haro Deportivo	CD Varea	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047622	f	\N	\N	\N
490	FK Napredak	Partizan Belgrade	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219012194	f	\N	\N	\N
464	Marbella	Orihuela CF	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218971175	f	\N	\N	\N
488	Silla CF	FC Jove Espanol	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219049783	f	\N	\N	\N
449	Arouca	Chaves	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218771542	t	0	2	8
495	Gudja United	Gzira United FC	2023-10-01 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219005626	f	\N	\N	\N
497	Hammarby	IFK Goteborg	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218572836	f	\N	\N	\N
496	CD Binefar	Fraga	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219047352	f	\N	\N	\N
498	Mjallby	Varnamo	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218572945	f	\N	\N	\N
459	Sandefjord	Valerenga	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520033	t	1	3	13
4856	Nyiregyhaza	Kazincbarcika	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219174200	f	\N	\N	\N
531	Juventus FC (W)	Sampdoria (W)	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219015444	f	\N	\N	\N
504	Diosgyori	Kecskemeti	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218428101	f	\N	\N	\N
502	NK Radomlje	Koper	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218915324	f	\N	\N	\N
499	Podbrezova	FC Kosice	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218828975	f	\N	\N	\N
503	CF Badalona Futur	CFJ Mollerussa	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219050053	f	\N	\N	\N
505	SD Sarriana	Polvorin FC	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219051043	f	\N	\N	\N
506	Pogon Szczecin	Lech Poznan	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218594183	f	\N	\N	\N
501	Jerez CF	CD Azuaga	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219048072	f	\N	\N	\N
535	FK Mladost Donja Gorica	OFK Petrovac	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219074256	f	\N	\N	\N
522	ASEC Mimosas	Al Ahly Benghazi	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219032732	f	\N	\N	\N
521	Hajduk Split	Dinamo Zagreb	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218770567	f	\N	\N	\N
530	CD Algar	Caravaca	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219048252	f	\N	\N	\N
520	Viborg	AGF	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218706184	f	\N	\N	\N
515	Zamora	Coruxo	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218895525	f	\N	\N	\N
534	Karacabey Belediyespor AS	Kirsehir Belediyespor	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219027523	f	\N	\N	\N
536	CDB Atletico Tomelloso	CD Torrijos	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219046992	f	\N	\N	\N
541	Denizlispor	Erzincanspor	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219027253	f	\N	\N	\N
543	Panathinaikos	PAOK	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218767170	f	\N	\N	\N
509	CD Coria	Pueblonuevo CA	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047982	f	\N	\N	\N
540	Dunajska Streda	Spartak Trnava	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829155	f	\N	\N	\N
524	Zlate Moravce	Slovan Bratislava	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829065	f	\N	\N	\N
517	Dynamo Kiev	Oleksandria	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218757147	f	\N	\N	\N
538	Xerez Deportivo FC	La Palma CF	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219048792	f	\N	\N	\N
511	GKS Tychy	Znicz Pruszkow	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218652361	f	\N	\N	\N
519	Tudelano	Barakaldo	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218896533	f	\N	\N	\N
516	Almeria B	Juventud Torremolinos	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219049692	f	\N	\N	\N
525	Cankaya	Sultanbeyli Belediyespor	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052052	f	\N	\N	\N
532	Union de Salamanca	Real Union	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218810125	f	\N	\N	\N
518	Fci Tallinn	Trans Narva	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219024128	f	\N	\N	\N
528	CD Huracan de Balazote	CD Toledo	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219046902	f	\N	\N	\N
513	Afjet Afyonspor	Erokspor A.S	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219027433	f	\N	\N	\N
514	Real Murcia	Alcoyano	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218902337	f	\N	\N	\N
537	CD Puertollano	CD Azuqueca	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219047082	f	\N	\N	\N
529	Mersin Idman Yurdu	Kirklarelispor	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219027343	f	\N	\N	\N
508	Aguilas	Mar Menor CF	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218971085	f	\N	\N	\N
526	Zeleznicar Pancevo	FK Radnicki 1923	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219012531	f	\N	\N	\N
512	Pardubice	Hradec Kralove	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218506325	f	\N	\N	\N
533	Konyaspor	Besiktas	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559554	f	\N	\N	\N
510	Adana Demirspor	Alanyaspor	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218559032	f	\N	\N	\N
542	Atalanta	Juventus	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218624782	f	\N	\N	\N
539	Sakaryaspor	Eyupspor	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218764171	f	\N	\N	\N
523	UD Logrones	CD Alaves B	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218896443	f	\N	\N	\N
551	Amorebieta	FC Cartagena	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218683171	f	\N	\N	\N
554	Foggia	AP Turris Calcio	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218913156	f	\N	\N	\N
545	Anadia	Varzim	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218932466	f	\N	\N	\N
544	Bollullos CF	Coria CF	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219048702	f	\N	\N	\N
552	Club Brugge	Sint Truiden	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218771218	f	\N	\N	\N
548	Benevento	Crotone	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218913246	f	\N	\N	\N
546	Lumezzane	Renate	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218867323	f	\N	\N	\N
547	Chelsea (W)	Tottenham (W)	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218865993	f	\N	\N	\N
550	Zaragoza	Mirandes	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218683495	f	\N	\N	\N
553	Valladolid	Burgos	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218683279	f	\N	\N	\N
549	US Cremonese	Parma	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218918630	f	\N	\N	\N
5143	Resovia Rzeszow	GKS Tychy	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218992551	f	\N	\N	\N
565	CD San Ignacio	CD Basconia	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219050593	f	\N	\N	\N
566	York9	Atletico Ottawa	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829515	f	\N	\N	\N
555	Juve Stabia	Monopoli	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218913066	f	\N	\N	\N
570	SD Compostela	UD Ourense	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218895255	f	\N	\N	\N
569	Arenteiro	CA Tarazona	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218810215	f	\N	\N	\N
564	HK Kopavogur	IBV	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218966711	f	\N	\N	\N
560	Feirense	Pacos Ferreira	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218793261	f	\N	\N	\N
596	Rennes	Nantes	2023-10-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218411878	t	2	\N	5
563	CS Cartagines	Municipal Grecia	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218963633	f	\N	\N	\N
558	Deportivo Coatepeque	Xelaju	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218976377	f	\N	\N	\N
557	La Nucia	UE Sant Andreu	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218938664	f	\N	\N	\N
568	Guimaraes	Estoril Praia	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218825080	t	2	\N	8
562	Caja Oblatos C.FD	Huracanes Izcalli FC	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219070722	f	\N	\N	\N
567	Boca Juniors	River Plate	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218793351	f	\N	\N	\N
561	Fram	KA Akureyri	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218966621	f	\N	\N	\N
574	Mas Maghrib A Fes	CC Riadi Salmi	2023-10-01 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219025593	f	\N	\N	\N
576	Yous Berrechid	Mouloudia dOujda	2023-10-01 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219039191	f	\N	\N	\N
575	Molenbeek	Gent	2023-10-01 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218771326	t	2	\N	68
573	Maccabi Netanya	Maccabi Haifa	2023-10-01 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218907185	f	\N	\N	\N
571	FCV Dender	Racing Genk B	2023-10-01 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218769291	f	\N	\N	\N
579	PAS Giannina	Olympiakos	2023-10-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218766990	f	\N	\N	\N
578	PFC Levski Sofia	Ludogorets	2023-10-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218767710	f	\N	\N	\N
577	Erzgebirge	Jahn Regensburg	2023-10-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218665816	f	\N	\N	\N
586	CFR Cluj	FC U Craiova 1948	2023-10-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218526882	f	\N	\N	\N
585	Montaneses FC	Tampico Madero	2023-10-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219026498	f	\N	\N	\N
582	Colo Colo	Univ Catolica (Chile)	2023-10-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218719099	f	\N	\N	\N
583	Alianza Atletico	Deportivo Garcilaso	2023-10-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218856981	f	\N	\N	\N
581	Jagiellonia Bialystock	Legia Warsaw	2023-10-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218593609	f	\N	\N	\N
587	Calor de San Pedro	Tuzos de la UAZ	2023-10-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218960794	f	\N	\N	\N
584	Guayaquil City	Aucas	2023-10-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218780363	f	\N	\N	\N
580	Malaga	San Fernando CD	2023-10-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218902427	f	\N	\N	\N
588	NK Aluminij	NK Maribor	2023-10-01 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218914519	f	\N	\N	\N
590	CA Puerto Nuevo	Sportivo Italiano	2023-10-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219017509	f	\N	\N	\N
589	Victoriano Arenas	CSD Liniers de Ciudad Evita	2023-10-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219017419	f	\N	\N	\N
593	Vila Nova	Chapecoense	2023-10-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218676942	f	\N	\N	\N
592	Recanatese	Spal	2023-10-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218876063	f	\N	\N	\N
591	AZ Picerno ASD	Sorrento	2023-10-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218913336	f	\N	\N	\N
595	Roma	Frosinone	2023-10-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218773046	f	\N	\N	\N
572	Bodo Glimt	Stromsgodset	2023-10-01 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218519757	t	1	2	13
594	Borac Banja Luka	FK Velez Mostar	2023-10-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218973144	f	\N	\N	\N
604	CD Trasandino	CSD San Antonio Unido	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219062283	f	\N	\N	\N
601	Achuapa FC	Deportivo Mixco	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218976287	f	\N	\N	\N
603	Paris St-G (W)	Lyon (W)	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219027901	f	\N	\N	\N
605	Cruzeiro MG	America MG	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218463246	f	\N	\N	\N
602	Santos	Vasco Da Gama	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218463005	f	\N	\N	\N
599	USM Alger	FUS Rabat	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219039281	f	\N	\N	\N
606	Coritiba	Athletico-PR	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218463125	f	\N	\N	\N
608	Olimpo	CA Liniers	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219029085	f	\N	\N	\N
609	Atletico Madrid	Cadiz	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218624902	f	\N	\N	\N
610	Betis	Valencia	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218775593	f	\N	\N	\N
598	EC Sao Jose Porto Alegre	Operario PR	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218913752	f	\N	\N	\N
607	Huesca	Sporting Gijon	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218683063	f	\N	\N	\N
597	Gimnasia Jujuy	CA Atlanta	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218871156	f	\N	\N	\N
5161	AGF Aarhus (W)	Aalborg BK (W)	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219364914	f	\N	\N	\N
293	Elversberg	Greuther Furth	2023-10-01 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218523202	t	2	\N	93
387	Le Havre	Lille	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218430059	t	1	2	5
418	Kolos Kovalyovka	Polissya Zhytomyr	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218757237	f	\N	\N	\N
444	Aris	Kifisias FC	2023-10-01 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218767080	f	\N	\N	\N
452	Lokomotiv Sofia	Cherno More	2023-10-01 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218767620	f	\N	\N	\N
484	CD Tropezon	SD Atletico Albericia	2023-10-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219050863	f	\N	\N	\N
500	Bergantinos CF	CSD Arzua	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219051133	f	\N	\N	\N
613	Gimnasia Mendoza	Almagro BA	2023-10-01 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218870704	f	\N	\N	\N
614	Colon	Union Santa Fe	2023-10-01 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218805116	f	\N	\N	\N
618	Union de Touarga	IRT Tanger	2023-10-01 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219029450	f	\N	\N	\N
612	Def Belgrano VR	Gimnasia Conc del Uruguay	2023-10-01 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219017615	f	\N	\N	\N
616	Leiria	Tondela	2023-10-01 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218793170	f	\N	\N	\N
615	Club Defensores de P	Independiente Chivilcoy	2023-10-01 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219017705	f	\N	\N	\N
617	Rio Ave	Moreirense	2023-10-01 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218825220	t	2	\N	8
619	Sarmiento de Resistencia	CS General San Martin d	2023-10-01 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219029702	f	\N	\N	\N
620	Estudiantes	Gimnasia La Plata	2023-10-01 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218783450	f	\N	\N	\N
621	AD Cantolao	Asociacion Deportiva Tarma	2023-10-01 21:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218857071	f	\N	\N	\N
624	LDU	Univ Catolica (Ecu)	2023-10-01 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218780453	f	\N	\N	\N
622	Real Santander	Cucuta Deportivo	2023-10-01 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218837092	f	\N	\N	\N
623	Paysandu	Amazonas FC	2023-10-01 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218913842	f	\N	\N	\N
630	Coban Imperial	Huehueteco Xinabajul	2023-10-01 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218976197	f	\N	\N	\N
625	Once Caldas	Ind Medellin	2023-10-01 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218869591	f	\N	\N	\N
627	Ceara SC Fortaleza	Atletico Go	2023-10-01 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218753109	f	\N	\N	\N
631	Costa del Este	San Francisco FC	2023-10-01 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219074742	f	\N	\N	\N
626	Once Municipal	CD Dragon	2023-10-01 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219051657	f	\N	\N	\N
629	Cobresal	Palestino	2023-10-01 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218719009	f	\N	\N	\N
632	AD Municipal Liberia	LD Alajuelense	2023-10-01 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218963453	f	\N	\N	\N
628	Cerro Porteno	Club Sportivo Ameliano	2023-10-01 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218987845	f	\N	\N	\N
633	Sol de America	C J Antoniana	2023-10-01 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219036412	f	\N	\N	\N
634	9 de Julio Rafaela	Crucero del Norte	2023-10-01 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219036730	f	\N	\N	\N
636	Fluminense U20	Cruzeiro U20	2023-10-01 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219062373	f	\N	\N	\N
638	CD Aguila	CD Luis Angel Firpo	2023-10-01 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218998066	f	\N	\N	\N
639	Bragantino SP	SE Palmeiras	2023-10-01 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218460046	f	\N	\N	\N
640	Atletico Rafaela	Chaco For Ever	2023-10-01 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218870796	f	\N	\N	\N
637	Jocoro	Alianza FC (SLV)	2023-10-01 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218997976	f	\N	\N	\N
641	CA Central Norte	Club Gimnasia y Tiro	2023-10-01 22:35:00	https://www.orbitxch.com/customer/sport/1/market/1.219036502	f	\N	\N	\N
642	Talleres	Belgrano	2023-10-01 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218807365	f	\N	\N	\N
643	Real Apodaca FC	Atletico Saltillo	2023-10-01 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219074166	f	\N	\N	\N
644	Guadalajara (W)	Mazatlan FC(W)	2023-10-01 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219037021	f	\N	\N	\N
646	Millonarios	Union Magdalena	2023-10-02 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218870042	f	\N	\N	\N
647	CD Universitario	Plaza Amador	2023-10-02 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219082966	f	\N	\N	\N
648	Toluca	Guadalajara	2023-10-02 00:20:00	https://www.orbitxch.com/customer/sport/1/market/1.218470103	f	\N	\N	\N
649	Libertad	Guarani (Par)	2023-10-02 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218987712	f	\N	\N	\N
652	Deportivo Saprissa	AD Guanacasteca	2023-10-02 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218963723	f	\N	\N	\N
653	Pachuca (W)	CF America (W)	2023-10-02 01:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219062463	f	\N	\N	\N
651	Real Espana	CD Olimpia	2023-10-02 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219082440	f	\N	\N	\N
654	Deportivo Cali	Alianza Petrolera	2023-10-02 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218869681	f	\N	\N	\N
655	Universidad Guadalajara	Mineros de Zacatecas	2023-10-02 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218783771	f	\N	\N	\N
656	FC Juarez (W)	Queretaro (W)	2023-10-02 03:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219062643	f	\N	\N	\N
650	Los Angeles FC	Real Salt Lake	2023-10-02 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218776001	t	0	1	76
645	Barcelona (Ecu)	Tecnico Universitario	2023-10-02 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218783681	f	\N	\N	\N
333	Yverdon Sport	St Gallen	2023-10-01 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218802769	t	1	1	15
527	Yeni Orduspor	Ayvalikgucu Belediyespor	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052769	f	\N	\N	\N
767	FK Sutjeska	FK Mornar	2023-10-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219097690	f	\N	\N	\N
556	Perugia	USD Sestri Levante 1919	2023-10-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218875592	f	\N	\N	\N
559	Sporting de Huelva (W)	Barcelona (W)	2023-10-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219032642	f	\N	\N	\N
600	Deportivo Madryn	Independiente Rivadavia	2023-10-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218871066	f	\N	\N	\N
611	Valur	Hafnarfjordur	2023-10-01 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218966805	f	\N	\N	\N
635	Platense Zacatecoluca	Fuerte San Francisco	2023-10-01 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218998156	f	\N	\N	\N
384	Lillestrom	Brann	2023-10-01 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218519491	t	1	\N	13
419	Hvidovre	Brondby	2023-10-01 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218710816	t	1	3	40
507	Freiburg	Augsburg	2023-10-01 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218412178	t	1	2	1
914	San Luis de Quillota	La Serena	2023-10-02 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219106752	f	\N	\N	\N
937	FC Turan	Sport Academy Kairat	2023-10-02 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219129036	f	\N	\N	\N
938	FK Ekibastuz	Zhenys	2023-10-02 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219128946	f	\N	\N	\N
939	FC Shukura Kobuleti	Dinamo Batumi	2023-10-02 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219074923	f	\N	\N	\N
940	Swansea U21	Watford U21	2023-10-02 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219089320	f	\N	\N	\N
941	Samgurali Tskaltubo	Gagra	2023-10-02 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219076454	f	\N	\N	\N
942	Chiangrai Utd	Sukhothai	2023-10-02 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218952319	f	\N	\N	\N
943	Olmaliq	Al Quwa Al Jawiya	2023-10-02 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219099936	f	\N	\N	\N
944	Vejle BK (Res)	Viborg (Res)	2023-10-02 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219148698	f	\N	\N	\N
945	PAE Chania	Tilikratis Lefkadas	2023-10-02 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219090327	f	\N	\N	\N
946	Hebar	Levski Krumovgrad	2023-10-02 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218767800	f	\N	\N	\N
947	Bashundhara Kings	Odisha	2023-10-02 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219099182	f	\N	\N	\N
948	FK Kukesi	KF Erzeni	2023-10-02 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219125227	f	\N	\N	\N
949	Charlton U21	Bristol City U21	2023-10-02 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219076909	f	\N	\N	\N
950	Aswan FC	Nogoom El Mostakbal	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219075103	f	\N	\N	\N
951	FC Hunedoara	CS Mioveni	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218905842	f	\N	\N	\N
952	Misr El Makasa	El Seka Elhadeed	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219075013	f	\N	\N	\N
953	FK Mladost Novi Sad	FK Dubocica	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219078252	f	\N	\N	\N
954	Sheff Utd U21	Hull City U21	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219104830	f	\N	\N	\N
955	SC Kiyovu	Gorilla FC	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218976695	f	\N	\N	\N
956	Asyut Petroleum	Proxy Work Club	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219075193	f	\N	\N	\N
957	Taranto Sport	Audace Cerignola	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218913427	f	\N	\N	\N
958	Kalamata	Giouchtas	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219090237	f	\N	\N	\N
959	Levadiakos	Kozani FC	2023-10-02 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219098727	f	\N	\N	\N
960	Stromsgodset II	Levanger	2023-10-02 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219090698	f	\N	\N	\N
961	FC Telavi	Samtredia	2023-10-02 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219076544	f	\N	\N	\N
962	Dnipro-1	Metalist 1925	2023-10-02 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218757327	f	\N	\N	\N
963	Al Alyah	Al Sareeh	2023-10-02 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219080298	f	\N	\N	\N
964	Samma	Al Arabi (Jor)	2023-10-02 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219139167	f	\N	\N	\N
924	Quindio	Orsomarso	2023-10-03 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218837909	f	\N	\N	\N
925	Botafogo	Goias	2023-10-03 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218459926	f	\N	\N	\N
923	FC Midland	Deportivo Espanol	2023-10-03 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219097794	f	\N	\N	\N
927	Sportivo Belgrano	CA Douglas Haig	2023-10-03 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219098637	f	\N	\N	\N
926	Olimpia	Resistencia FC	2023-10-03 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218987532	f	\N	\N	\N
928	Atl Tucuman	Central Cordoba (SdE)	2023-10-03 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218809334	f	\N	\N	\N
929	CA Platense	Argentinos Juniors	2023-10-03 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218812261	f	\N	\N	\N
930	Deportivo Moron	San Martin de Tucuman	2023-10-03 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218871248	f	\N	\N	\N
931	Tigres (W)	Pumas UNAM (W)	2023-10-03 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219107330	f	\N	\N	\N
932	Atletico San Luis (W)	Club Tijuana (W)	2023-10-03 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219107422	f	\N	\N	\N
933	FC Atlas (W)	Puebla FC (W)	2023-10-03 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219107239	f	\N	\N	\N
934	Atletico Huila	La Equidad	2023-10-03 02:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218890545	f	\N	\N	\N
935	Universitario de Deportes	UTC Cajamarca	2023-10-03 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219107562	f	\N	\N	\N
936	Santos Laguna (W)	Toluca (W)	2023-10-03 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219107149	f	\N	\N	\N
4858	Crusaders Strikers (W)	Glentoran (W)	2023-10-08 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219404377	f	\N	\N	\N
965	Fram Larvik	Valerenga II	2023-10-02 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219090608	f	\N	\N	\N
966	Atletico De Kolkata	Maziya S & RC	2023-10-02 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219099272	f	\N	\N	\N
967	Yarmouk	Al Buqaa	2023-10-02 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219079545	f	\N	\N	\N
968	Pirin Blagoevgrad	Slavia Sofia	2023-10-02 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218767890	f	\N	\N	\N
969	FC Goa	Punjab FC	2023-10-02 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219085818	f	\N	\N	\N
970	CSMS Iasi	ACS Petrolul 52	2023-10-02 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218527064	f	\N	\N	\N
971	Atromitos	Asteras Tripolis	2023-10-02 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218766810	f	\N	\N	\N
972	FK Siauliai II	FK Kauno Zalgiris 2	2023-10-02 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219082690	f	\N	\N	\N
973	TPS	EIF	2023-10-02 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218920710	f	\N	\N	\N
974	Sigma Olomouc B	Dukla Prague	2023-10-02 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218828525	f	\N	\N	\N
975	HIFK	Mikkeli	2023-10-02 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218921169	f	\N	\N	\N
976	Platense (W)	River Plate (W)	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219104940	f	\N	\N	\N
977	Al Sharjah	Al Faisaly SC	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219099756	f	\N	\N	\N
978	FC Tallinn	Levadia Tallinn II	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219076634	f	\N	\N	\N
979	Tabasalu JK	Flora Tallinn II	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219076182	f	\N	\N	\N
980	Viimsi JK	FC Elva	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219076002	f	\N	\N	\N
981	Gornik Leczna	Zaglebie Sosnowiec	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218652451	f	\N	\N	\N
982	Sepahan	Al-Ittihad	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219099666	f	\N	\N	\N
983	Dinamo Tirana	Vllaznia Shkoder	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219075283	f	\N	\N	\N
984	Inter Milan (W)	SSD Fiorentina WFC (W)	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219079707	f	\N	\N	\N
985	NK Istra	Lokomotiva	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218954962	f	\N	\N	\N
986	Zeljeznicar	Siroki Brijeg	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219106873	f	\N	\N	\N
987	Al Arabi Kuwait	Nejmeh	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219106203	f	\N	\N	\N
988	Tallinna JK Legion	Nomme Utd	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219076272	f	\N	\N	\N
989	Al-Futowa	Al-Ahed	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219106098	f	\N	\N	\N
990	Nasaf	Al-Sadd	2023-10-02 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219099846	f	\N	\N	\N
991	Polonia Bytom	Stomil Olsztyn	2023-10-02 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219081688	f	\N	\N	\N
992	Chateauroux	Red Star	2023-10-02 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218703995	f	\N	\N	\N
993	Brann II	Sotra SK	2023-10-02 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219090518	f	\N	\N	\N
995	Torino	Verona	2023-10-02 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218667469	f	\N	\N	\N
996	Belouizdad	Bo Rangers	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219090428	f	\N	\N	\N
997	Gornik Zabrze	Zaglebie Lubin	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218594278	f	\N	\N	\N
998	AL Nahdha	Jabal Al Mukaber	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219106390	f	\N	\N	\N
999	Växjö DFF (W)	Rosengard (W)	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219080993	f	\N	\N	\N
1000	FC Trollhattan	Norrby IF	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218851084	f	\N	\N	\N
1001	Goztepe	Adanaspor	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218764261	f	\N	\N	\N
1003	Vozdovac	Fk Novi Pazar	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219012284	f	\N	\N	\N
1005	Penafiel	CD Nacional Funchal	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218835625	f	\N	\N	\N
1006	Lokomotiv Plovdiv	CSKA Sofia	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218767980	f	\N	\N	\N
1008	IFK Norrkoping DFK (W)	BK Hacken (W)	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219081083	f	\N	\N	\N
1009	Kolubara Lazarevac	OFK Beograd	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219081779	f	\N	\N	\N
1012	OFI	AEK Athens	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218766900	f	\N	\N	\N
1013	Kayserispor	Basaksehir	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560240	f	\N	\N	\N
1015	Beitar Jerusalem	Hapoel Tel Aviv	2023-10-02 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218881394	f	\N	\N	\N
1016	Wolves U21	Leeds United U21	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219105355	f	\N	\N	\N
1017	Pecs MFC	Nyiregyhaza	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219084243	f	\N	\N	\N
1018	FCSB	Universitatea Cluj	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218903495	f	\N	\N	\N
1019	Brown de Adrogue	Chacarita	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218870886	f	\N	\N	\N
1020	K Lierse U21	RFC de Liege U21	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219105193	f	\N	\N	\N
1007	Utsiktens	AFC Eskilstuna	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218905934	t	1	2	336
1011	Elfsborg	Varbergs BoIS	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218573053	t	2	\N	14
1002	OB	Lyngby	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705904	t	1	\N	40
1010	Jonkopings Sodra	Ostersunds FK	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218906024	t	1	2	336
1004	IK Brage	Skovde AIK	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218906114	t	2	\N	336
1014	Malmo FF	Brommapojkarna	2023-10-02 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218573161	t	2	\N	14
1021	Al Nassr	Istiqlol	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219099576	f	\N	\N	\N
1022	Al Riffa	Al Zawraa	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219091526	f	\N	\N	\N
1023	Jong FC Utrecht	NAC Breda	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218828795	f	\N	\N	\N
1024	Uni San Martin	Deportivo Llacuabamba	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219105103	f	\N	\N	\N
1025	CA Ituzaingo	CS Dock Sud	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219084136	f	\N	\N	\N
1026	Al-Duhail SC	Persepolis	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219091436	f	\N	\N	\N
1028	Tottenham U21	Chelsea U21	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219105445	f	\N	\N	\N
1029	Sibenik	NK Dugopolje	2023-10-02 19:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218964843	f	\N	\N	\N
1031	CA Atlas	Club Lujan	2023-10-02 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219084597	f	\N	\N	\N
1032	Comunicaciones B Aires	UAI Urquiza	2023-10-02 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219084507	f	\N	\N	\N
1033	Deportivo Riestra	Aldosivi	2023-10-02 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218870976	f	\N	\N	\N
1030	Pescara	Gubbio	2023-10-02 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218876153	f	\N	\N	\N
1035	Carrick Rangers U20	Larne FC U20	2023-10-02 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219099001	f	\N	\N	\N
1036	Glentoran (W)	Cliftonville (W)	2023-10-02 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219125317	f	\N	\N	\N
1037	Coleraine U20	Glentoran FC U20	2023-10-02 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219098911	f	\N	\N	\N
1038	AC Ajaccio	Bastia	2023-10-02 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218886958	f	\N	\N	\N
1039	Pesaro	Fermana	2023-10-02 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218875682	f	\N	\N	\N
1040	Fiorentina	Cagliari	2023-10-02 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218773256	f	\N	\N	\N
1041	Espanyol	Racing de Ferrol	2023-10-02 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218682955	f	\N	\N	\N
1042	Las Palmas	Celta Vigo	2023-10-02 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218736649	f	\N	\N	\N
1043	Fulham	Chelsea	2023-10-02 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218408984	f	\N	\N	\N
1044	Stjarnan	Vikingur Reykjavik	2023-10-02 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218982921	f	\N	\N	\N
1045	Gil Vicente	Casa Pia	2023-10-02 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218825346	f	\N	\N	\N
1046	Torreense	Cf Os Belenenses	2023-10-02 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218907292	f	\N	\N	\N
1047	Comerciantes FC	Santos FC de Ica	2023-10-02 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219139587	f	\N	\N	\N
1048	Barranquilla	Boca Juniors de Cali	2023-10-02 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218888475	f	\N	\N	\N
1049	Fernandez Vial	Deportes Valdivia	2023-10-02 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219111438	f	\N	\N	\N
1050	Sportivo Luqueno	Guairena	2023-10-02 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218987622	f	\N	\N	\N
1051	Deportivo Laferrere	Central Cordoba	2023-10-02 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219091346	f	\N	\N	\N
1052	Barracas Central	Sarmiento de Junin	2023-10-02 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218807275	f	\N	\N	\N
1053	Godoy Cruz	Instituto	2023-10-02 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218807185	f	\N	\N	\N
1054	Universidad de Chile	Audax Italiano	2023-10-02 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218783591	f	\N	\N	\N
994	Sassuolo	AC Monza	2023-10-02 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218667589	t	0	1	4
1027	MVV Maastricht	FC Eindhoven	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218808014	t	0	\N	199
1069	Uzbekistan (W)	Korea DPR (W)	2023-10-03 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219162787	f	\N	\N	\N
1070	Incheon Utd	Kaya	2023-10-03 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219149738	f	\N	\N	\N
1071	Portimonense SC U23	Farense U23	2023-10-03 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219122009	f	\N	\N	\N
1072	Inter U19	SL Benfica Lisbon U19	2023-10-03 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219192212	f	\N	\N	\N
1073	Kawasaki	Ulsan Hyundai Horang-i	2023-10-03 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219149614	f	\N	\N	\N
1074	1. FC Union Berlin U19	Sporting de Braga U19	2023-10-03 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219164047	f	\N	\N	\N
1075	TSG Balingen	Homburg	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219160854	f	\N	\N	\N
1076	Hessen Kassel	Stuttgart II	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219160944	f	\N	\N	\N
1077	Arezzo	Lucchese	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219162098	f	\N	\N	\N
1078	DJK Gebenbach	SpVgg Bayern Hof	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219123101	f	\N	\N	\N
1079	China (W)	Japan (W)	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219162697	f	\N	\N	\N
1080	Bayern Munich II	SpVgg Ansbach	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219161124	f	\N	\N	\N
1081	KF Tirana	KF Laci	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219075373	f	\N	\N	\N
1082	Aalen	TSV Lehnerz	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219160760	f	\N	\N	\N
1083	Kickers Offenbach	SGV Freiberg	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219161034	f	\N	\N	\N
1084	BG Pathumthani United	Johor Darul Takzim	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219149434	f	\N	\N	\N
4936	RS Gimnastica	Arandina CF	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219233724	f	\N	\N	\N
4957	FK Backa Topola	FK Spartak	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219367625	f	\N	\N	\N
4987	Plzen	FK Jablonec	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218852172	f	\N	\N	\N
5305	CD Coria	CF Trujillo	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388791	f	\N	\N	\N
1085	Southern District	Resources Capital FC	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219123479	f	\N	\N	\N
1086	Barnsley U21	Peterborough United U21	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219123008	f	\N	\N	\N
1087	ATSV Erlangen	SV Donaustrauf	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219123281	f	\N	\N	\N
1088	Jahn Regensburg II	SV Fortuna Regensburg	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219123191	f	\N	\N	\N
1089	RC Lens U19	Arsenal U19	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219107652	f	\N	\N	\N
1090	SV Steinbach	Bahlinger SC	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219160670	f	\N	\N	\N
1091	Augsburg II	Viktoria Aschaffenburg	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219161214	f	\N	\N	\N
1092	Ipswich Town U21	Cardiff City U21	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219122918	f	\N	\N	\N
1093	Shandong Taishan	Yokohama FM	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219149524	f	\N	\N	\N
1094	Napoli U19	Real Madrid U19	2023-10-03 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219180290	f	\N	\N	\N
1095	Olympic El Qanal	Petrojet	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219179787	f	\N	\N	\N
1096	Raya Sporting FC	Wadi degla	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219193564	f	\N	\N	\N
1097	Man Utd U19	Galatasaray U19	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219180380	f	\N	\N	\N
1098	Millwall U21	Queens Park Rangers U21	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219128762	f	\N	\N	\N
1099	FV Diefflen	FC Cosmos Koblenz	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219128669	f	\N	\N	\N
1100	La Viena FC	Nasr Taaden	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219179967	f	\N	\N	\N
1101	Telecom Egypt SC	Gomhoryet Shebin	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219179697	f	\N	\N	\N
1102	Al Sarhan	Um El Quttein	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219187741	f	\N	\N	\N
1103	Birmingham U21	Sheff Wed U21	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219128852	f	\N	\N	\N
1104	Abo Qair Semads	Tanta	2023-10-03 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219179877	f	\N	\N	\N
1105	MS Tzeirey Taibe	Maccabi Tzur Shalom	2023-10-03 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219164918	f	\N	\N	\N
1106	Sampion Celje	Krsko	2023-10-03 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219182238	f	\N	\N	\N
1107	SV Oberachern	Normannia Schwabisch Gmund	2023-10-03 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219182618	f	\N	\N	\N
1108	SK Odeva Lipany	MFk Dolny Kubin	2023-10-03 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219182148	f	\N	\N	\N
1109	Vfr Mannheim	SG Sonnenhof	2023-10-03 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219129755	f	\N	\N	\N
1126	Al Ain	Ahal FC	2023-10-03 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219157399	f	\N	\N	\N
1117	Gil Vicente U23	Rio Ave FC U23	2023-10-03 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219180772	f	\N	\N	\N
1115	Sporting Lisbon U23	Estrela U23	2023-10-03 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219180682	f	\N	\N	\N
1114	FK Navbahor Namangan	Mumbai City FC	2023-10-03 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219157489	f	\N	\N	\N
1111	PSV Eindhoven U19	Sevilla U19	2023-10-03 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219164137	f	\N	\N	\N
1116	Schalding-Heining	FC Eintracht Bamberg	2023-10-03 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219164255	f	\N	\N	\N
1113	FC Copenhagen U19	Bayern Munich U19	2023-10-03 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219192122	f	\N	\N	\N
1112	Al Tora	Alhashemyya	2023-10-03 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219139257	f	\N	\N	\N
1118	FC Memmingen	Buchbach	2023-10-03 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219164345	f	\N	\N	\N
1120	Bloemfontein Celtic	Mamelodi Sundowns	2023-10-03 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219006962	f	\N	\N	\N
1123	Al-Feiha	Pakhtakor	2023-10-03 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219157309	f	\N	\N	\N
1127	Hapoel Marmorek	Hapoel Tzafririm Holon	2023-10-03 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219165032	f	\N	\N	\N
1124	Dinamo Tbilisi	Dila Gori	2023-10-03 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219139497	f	\N	\N	\N
1121	Nassaji Mazandaran F.C.	Al-Hilal	2023-10-03 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219157219	f	\N	\N	\N
1122	Dodoma FC	Azam FC	2023-10-03 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219139689	f	\N	\N	\N
1125	Kuwait SC	Al Wehdat	2023-10-03 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219183068	f	\N	\N	\N
1129	Mantova	Aurora Pro Patria 1919	2023-10-03 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219180862	f	\N	\N	\N
1130	Alessandria	Pergolettese	2023-10-03 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219162278	f	\N	\N	\N
1128	Arzignanochiampo	A.C. Trento S.C.S.D.	2023-10-03 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219162458	f	\N	\N	\N
1131	FC Legnago	Padova	2023-10-03 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219162368	f	\N	\N	\N
1132	Fiorenzuola	Novara	2023-10-03 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219162188	f	\N	\N	\N
1135	Red Bull Salzburg	Real Sociedad	2023-10-03 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218588813	t	2	\N	244
1136	Bordeaux	Caen	2023-10-03 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218886003	f	\N	\N	\N
1137	GAIS	Osters	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218885373	t	0	1	336
1133	B71 Sandur	Havnar Boltfelag II	2023-10-03 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219148608	f	\N	\N	\N
1134	Union Berlin	Braga	2023-10-03 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218588612	t	2	\N	244
1139	Alcorcon	Albacete	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218998775	f	\N	\N	\N
1138	Landskrona	Sundsvall	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218885193	t	1	\N	336
1142	Al Bukayriyah	Al Faisaly ( KSA )	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219148518	f	\N	\N	\N
1141	SSV Ulm	1860 Munich	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218905526	f	\N	\N	\N
1149	Verl	Arminia Bielefeld	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218905436	f	\N	\N	\N
1144	Viktoria Koln	Ingolstadt	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218905616	f	\N	\N	\N
1140	Saarbrucken	Lubeck	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218905256	f	\N	\N	\N
1145	Levante	Villarreal B	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218999603	f	\N	\N	\N
1143	Mainz II	FSV Frankfurt	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219164435	f	\N	\N	\N
1146	Gefle	Orgryte	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218885463	f	\N	\N	\N
1147	Helsingborgs	Orebro	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218885283	f	\N	\N	\N
1150	Versailles 78 FC	Sochaux	2023-10-03 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219182708	f	\N	\N	\N
1152	IR/Lettir U19	Selfoss/Arborg U19	2023-10-03 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219164860	f	\N	\N	\N
1153	Throttur Reykjavik/SR U19	Breidablik/Augn	2023-10-03 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219164618	f	\N	\N	\N
1154	Al Ittihad Aleppo	Al Kahrabaa	2023-10-03 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219152053	f	\N	\N	\N
1157	Sportivo Barracas	Club Mercedes	2023-10-03 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219150008	f	\N	\N	\N
1160	Leandro N Alem	Real Pilar FC	2023-10-03 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219180470	f	\N	\N	\N
1158	CSD Yupanqui	AD Berazategui	2023-10-03 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219149918	f	\N	\N	\N
1156	Deportivo Merlo	Talleres (RE)	2023-10-03 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219149828	f	\N	\N	\N
1159	Luton	Burnley	2023-10-03 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218775776	f	\N	\N	\N
1163	Grimsby	Barrow	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218882223	f	\N	\N	\N
1185	Bristol Rovers	Port Vale	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219046139	f	\N	\N	\N
1175	Chesterfield	Bromley	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219042966	f	\N	\N	\N
1178	Cambridge Utd	Barnsley	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219046463	f	\N	\N	\N
1172	Limavady United	Dundela	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219181402	f	\N	\N	\N
1181	H & W Welders	Newry	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219181586	f	\N	\N	\N
1164	Walsall	MK Dons	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218925364	f	\N	\N	\N
1192	Ballymena	Lisburn Distillery	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219181688	f	\N	\N	\N
1162	Blackpool	Derby	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219046355	f	\N	\N	\N
1173	Portadown	Coagh United	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219181312	f	\N	\N	\N
1188	Charlton	Exeter	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219046031	f	\N	\N	\N
1174	Leyton Orient	Lincoln	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219045417	f	\N	\N	\N
1189	Solihull Moors	Rochdale	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219043056	f	\N	\N	\N
1166	Ipswich	Hull	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218777744	f	\N	\N	\N
1187	Eastleigh	Ebbsfleet Utd	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219043326	f	\N	\N	\N
1179	Plymouth	Millwall	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218777528	t	0	\N	77
1169	Cheltenham	Fleetwood Town	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219046247	f	\N	\N	\N
1182	Barnet	AFC Fylde	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219043416	f	\N	\N	\N
1177	Concord Rangers	Cray Wanderers	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219089140	f	\N	\N	\N
1167	Burton Albion	Wigan	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219045525	f	\N	\N	\N
1194	Woking	FC Halifax Town	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219042696	f	\N	\N	\N
1186	Dorking Wanderers	Kidderminster	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219043506	f	\N	\N	\N
1165	Billericay Town	Canvey Island	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219089230	f	\N	\N	\N
1168	Altrincham	Aldershot	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219042606	f	\N	\N	\N
1180	Newport County	Colchester	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218893362	f	\N	\N	\N
1190	Southend	Oxford City	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219042876	f	\N	\N	\N
1171	Oxford Utd	Shrewsbury	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219045309	f	\N	\N	\N
1183	Harrogate Town	AFC Wimbledon	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218925634	f	\N	\N	\N
1195	Sutton Utd	Salford City	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218893254	f	\N	\N	\N
1193	Mansfield	Wrexham	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218925454	f	\N	\N	\N
1161	Morecambe	Accrington	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218879418	f	\N	\N	\N
1176	Dag and Red	York City	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219042786	f	\N	\N	\N
1170	Northampton	Reading	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219045201	f	\N	\N	\N
1191	Portsmouth	Wycombe	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219045923	f	\N	\N	\N
1184	SS Virtus Verona 1921	Triestina	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219180952	f	\N	\N	\N
1155	Willem II	FC Oss	2023-10-03 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218907385	t	1	3	199
1209	JKT Tanzania	Mashujaa FC	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219187865	f	\N	\N	\N
1232	Correcaminos Uat	Celaya	2023-10-04 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218938196	f	\N	\N	\N
1110	Torpedo Kutaisi	FC Saburtalo Tbilisi	2023-10-03 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219187441	f	\N	\N	\N
1119	Academico de Viseu U23	SC Uniao Torreense U23	2023-10-03 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219180576	f	\N	\N	\N
1148	Freiburg II	SV Sandhausen	2023-10-03 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218905346	f	\N	\N	\N
1151	Kaizer Chiefs	Cape Town CIty F.C.	2023-10-03 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218955610	f	\N	\N	\N
1202	Linfield	Queens University	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219181222	f	\N	\N	\N
1207	Birmingham	Huddersfield	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218777636	f	\N	\N	\N
1208	Carlisle	Peterborough	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219046699	f	\N	\N	\N
1198	Doncaster	Crawley Town	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218882115	f	\N	\N	\N
1203	Notts Co	Swindon	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218925544	f	\N	\N	\N
1201	Bolton	Stevenage	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219045815	f	\N	\N	\N
1200	SSD Pro Sesto	Giana Erminio	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219162548	f	\N	\N	\N
1197	Crewe	Gillingham	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218879742	f	\N	\N	\N
1373	Pohang Steelers	Wuhan Three Towns	2023-10-04 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219156948	f	\N	\N	\N
1206	Tranmere	Bradford	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218879634	f	\N	\N	\N
1204	Gateshead	Wealdstone	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219042516	f	\N	\N	\N
1196	Stockport	Forest Green	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218879526	f	\N	\N	\N
1205	Oldham	Maidenhead	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219043236	f	\N	\N	\N
1210	Carrick Rangers	Moyola Park	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219181492	f	\N	\N	\N
1211	West Brom	Sheff Wed	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218777312	f	\N	\N	\N
1215	College 1975 FC	St. Joseph's FC	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219182978	f	\N	\N	\N
1212	Universitario de Vinto	Nacional Potosi	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219150098	f	\N	\N	\N
1221	Napoli	Real Madrid	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218588954	t	2	\N	244
1213	Villarreal (W)	Atletico Madrid (W)	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063633	f	\N	\N	\N
1214	Inter	Benfica	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218588447	t	0	\N	244
1217	PSV	Sevilla	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218588306	t	\N	\N	\N
1220	Lens	Arsenal	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218587839	t	2	\N	244
1219	Stoke	Southampton	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218777420	t	1	\N	77
1199	Middlesbrough	Cardiff	2023-10-03 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218783558	t	0	\N	77
1216	Man Utd	Galatasaray	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218588024	t	2	\N	244
1222	Tenerife	Racing Santander	2023-10-03 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218999405	f	\N	\N	\N
1224	Fjolnir/ Vaengir U19	Stjarnan/KFG	2023-10-03 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219164768	f	\N	\N	\N
1223	Fram Ulfarnir U19	KR/KV Reykjavik U19	2023-10-03 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219164707	f	\N	\N	\N
1225	Sporting Cristal	Sport Huancayo	2023-10-03 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219171213	f	\N	\N	\N
1226	Sport Boys (Per)	Cusco FC	2023-10-03 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219171303	f	\N	\N	\N
1227	Cortulua	Real Cartagena	2023-10-03 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218954764	f	\N	\N	\N
1228	Club Petrolero	Jorge Wilstermann	2023-10-03 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219182795	f	\N	\N	\N
1229	Mirassol	Londrina	2023-10-03 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218905731	f	\N	\N	\N
1231	Melgar	Carlos Mannucci	2023-10-04 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219171393	f	\N	\N	\N
1230	Mineros de Fresnillo FC	Tecos FC	2023-10-04 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219163507	f	\N	\N	\N
1233	Chacaritas SC	Guayaquil SC	2023-10-04 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219163147	f	\N	\N	\N
1234	Bolivar	Always Ready	2023-10-04 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219179605	f	\N	\N	\N
1235	Fortaleza EC	Corinthians	2023-10-04 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219151875	f	\N	\N	\N
1236	Cimarrones de Sonora II	CF Orgullo de Reynosa	2023-10-04 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219194104	f	\N	\N	\N
1237	Puebla	Monterrey	2023-10-04 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218830055	f	\N	\N	\N
1238	Leones FC	Real Soacha Cundinamarca FC	2023-10-04 02:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218892369	f	\N	\N	\N
1239	Binacional	Alianza Lima	2023-10-04 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219171483	f	\N	\N	\N
1240	Atletico Independiente	CD Motagua	2023-10-04 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219194014	f	\N	\N	\N
1241	CF America	Pachuca	2023-10-04 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829965	f	\N	\N	\N
1242	Dorados	Tlaxcala F.C	2023-10-04 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218932646	f	\N	\N	\N
1218	FC Copenhagen	Bayern Munich	2023-10-03 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218588165	t	0	\N	244
1374	Urawa	Ha Noi T and T	2023-10-04 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219157039	f	\N	\N	\N
1375	Hong Kong U23	Japan U23	2023-10-04 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219162877	f	\N	\N	\N
1376	Kofu	Buriram Utd	2023-10-04 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219157129	f	\N	\N	\N
1377	Royal Antwerp U19	Shakhtar U19	2023-10-04 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219223546	f	\N	\N	\N
1378	Egaleo	Diagoras	2023-10-04 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219183410	f	\N	\N	\N
1379	Zaqatala	Karvan Evlakh	2023-10-04 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219212035	f	\N	\N	\N
1380	Agsu	Qaradag Lokbatan	2023-10-04 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219226654	f	\N	\N	\N
1381	South Korea U23	Uzbekistan U23	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219193474	f	\N	\N	\N
1382	Dinamo Zagreb U19	Istanbul Basaksehir FK U19	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219223636	f	\N	\N	\N
1383	FC Rukh Lviv U19	FK Sarajevo U19	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219223816	f	\N	\N	\N
1385	Lumezzane	Atalanta B	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219213512	f	\N	\N	\N
1386	Dortmund U19	AC Milan U19	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219207905	f	\N	\N	\N
1387	RB Leipzig U19	Man City U19	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219208382	f	\N	\N	\N
1388	Atletico Madrid U19	Feyenoord Youth	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219223726	f	\N	\N	\N
1389	Zhejiang Greentown	Melbourne City	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219156768	f	\N	\N	\N
1390	Shkendija	FK Struga Trim-Lum	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219193924	f	\N	\N	\N
1391	Bangkok Utd	Jeonbuk Motors	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219156858	f	\N	\N	\N
1392	Bali Utd Pusam	Terengganu	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219195783	f	\N	\N	\N
1384	Lech Poznan U19	Nantes U19 FC	2023-10-04 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219214717	f	\N	\N	\N
1394	Kedah	Kuching FA	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219218093	f	\N	\N	\N
1395	Trapani	Real Casalnuova	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220711	f	\N	\N	\N
1396	Siracusa	Acireale	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220817	f	\N	\N	\N
1397	Varese	Vado FC	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220907	f	\N	\N	\N
1398	ASD Varesina	Virtus Ciserano Bergamo	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219219975	f	\N	\N	\N
1399	Dynamo Douala	AS Fortuna Mfou	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219211615	f	\N	\N	\N
1400	ASD Castrovillari	Akragas	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219219885	f	\N	\N	\N
1401	AC Ponte San Pietro-Isola	Caravaggio	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220515	f	\N	\N	\N
1402	FC Clivense	ASD Club Milano	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220065	f	\N	\N	\N
1403	Nuova Gioiese	Sancataldese Calcio	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220245	f	\N	\N	\N
1404	Celtic U19	SS Lazio U19	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219208202	f	\N	\N	\N
1405	USD Castellanzese	USD Casatese	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220997	f	\N	\N	\N
1406	Sparta Prague U19	Maccabi Haifa U19	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219208292	f	\N	\N	\N
1407	ASD Calcio Caldiero Terme	GS Arconatese	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220155	f	\N	\N	\N
1408	ASD Portici 1906	Reggio Calabria	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220605	f	\N	\N	\N
1409	Ihefu SC	Young Africans	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219193834	f	\N	\N	\N
1410	ASD Calcio Brusaporto	US Folgore Caratese ASD	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219219795	f	\N	\N	\N
1411	Piacenza Calcio	Tritium	2023-10-04 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220425	f	\N	\N	\N
1412	NK Smartno	Rudar	2023-10-04 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219204504	f	\N	\N	\N
1413	Banik Horna Nitra	MSK Povazska Bystrica	2023-10-04 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219204414	f	\N	\N	\N
1414	CF Badalona Futur	AD San Juan	2023-10-04 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219224948	f	\N	\N	\N
1415	Adria Miren	NK Primorje	2023-10-04 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219204797	f	\N	\N	\N
1416	Tolmin	NK Bilje	2023-10-04 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219204900	f	\N	\N	\N
1417	NK Jadran Dekani	Tabor Sezana	2023-10-04 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219204687	f	\N	\N	\N
1418	Olympiacos U19	US Lecce U19	2023-10-04 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219216799	f	\N	\N	\N
1419	Famalicao U19	FC Midtjylland U19	2023-10-04 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219214614	f	\N	\N	\N
1420	Porto U19	Barcelona U19	2023-10-04 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219208013	f	\N	\N	\N
1421	FK CrvenaZvezdaU19	Young Boys U19	2023-10-04 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219214407	f	\N	\N	\N
1422	Newcastle United U19	Paris St-G U19	2023-10-04 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219208110	f	\N	\N	\N
1423	Albinoleffe	Renate	2023-10-04 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219191762	f	\N	\N	\N
1424	Carrarese	Pontedera	2023-10-04 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219191852	f	\N	\N	\N
1425	NK Lukavec	NK Sava Strmec	2023-10-04 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219221522	f	\N	\N	\N
1426	Fovu Club de Baham	APEJES Academy	2023-10-04 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219211525	f	\N	\N	\N
1427	Bengaluru FC	Quess East Bengal	2023-10-04 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219063813	f	\N	\N	\N
1428	SK Brann	Roa (W)	2023-10-04 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219195963	f	\N	\N	\N
1429	Moroka Swallows	Chippa Utd	2023-10-04 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219106572	f	\N	\N	\N
1430	Les Astres FC de Douala	Aigle Royal de la Menoua	2023-10-04 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219211729	f	\N	\N	\N
1431	CD Pioneros de Cancun	Inter de Queretaro FC	2023-10-04 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219196173	f	\N	\N	\N
1432	Sevilla FC (W)	UDG Tenerife Sur (W)	2023-10-04 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219097330	f	\N	\N	\N
1433	NK Maribor U19	1. FSV Mainz 05 U19	2023-10-04 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219213139	f	\N	\N	\N
1434	Athletic Bilbao (W)	Granada (W)	2023-10-04 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219224588	f	\N	\N	\N
1435	Canon Sportif De Yaounde	Colombe du Dja et Lobo	2023-10-04 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219211819	f	\N	\N	\N
1436	Isa Town FC	Etihad Al Reef	2023-10-04 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219196403	f	\N	\N	\N
1437	Um Al Hassam	Qalali	2023-10-04 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219196493	f	\N	\N	\N
1439	Pisek	Slavia Praha B	2023-10-04 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219196583	f	\N	\N	\N
1440	Be1 NFA	FK Nevezis	2023-10-04 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219196297	f	\N	\N	\N
1441	AP Turris Calcio	Audace Cerignola	2023-10-04 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219191582	f	\N	\N	\N
1442	Avellino	Monopoli	2023-10-04 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219191672	f	\N	\N	\N
1443	Pro Vercelli	Juventus B	2023-10-04 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219191942	f	\N	\N	\N
1445	St Etienne	Dunkerque	2023-10-04 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218926084	f	\N	\N	\N
1447	Ilirija Extra-Lux	Krka	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219205004	f	\N	\N	\N
1449	Deportiva Venados	Deportivo Irapuato FC	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219226274	f	\N	\N	\N
1450	Eint Frankfurt II	Hoffenheim II	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219192662	f	\N	\N	\N
1451	Leones Negros Udg	Colima FC	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219208657	f	\N	\N	\N
1452	Preussen Munster	Erzgebirge	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218925724	f	\N	\N	\N
1453	Eldense	Valladolid	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218999297	f	\N	\N	\N
1454	Oviedo	Huesca	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218999189	f	\N	\N	\N
1455	Unterhaching	Rot-Weiss Essen	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218925994	f	\N	\N	\N
1456	Real Sociedad (W)	Levante UD (W)	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219224498	f	\N	\N	\N
1457	TuS Koblenz	FC Astoria Walldorf	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219192752	f	\N	\N	\N
1458	Dynamo Dresden	Hallescher FC	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218925904	f	\N	\N	\N
1459	Jahn Regensburg	Waldhof Mannheim	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218925814	f	\N	\N	\N
1460	SV Stuttgarter Kickers	TSV Schott Mainz	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219192842	f	\N	\N	\N
1461	Wydad Casablanca	Club R Zemamra	2023-10-04 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219216892	f	\N	\N	\N
1462	AmaZulu	Orlando Pirates (SA)	2023-10-04 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219163777	f	\N	\N	\N
1463	Stellenbosch FC	TS Galaxy FC	2023-10-04 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219077441	f	\N	\N	\N
1464	Ajax Cape Town	Supersport Utd	2023-10-04 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219064353	f	\N	\N	\N
1465	Richards Bay FC	Polokwane City	2023-10-04 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219064173	f	\N	\N	\N
1466	SD Ejea	UE Sant Andreu	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219224768	f	\N	\N	\N
1467	Ibrachina FC U20	Desp Brasil P LTDA U20	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219198308	f	\N	\N	\N
1468	Coimbra EC U20	Cruzeiro U20	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219218503	f	\N	\N	\N
1469	Al Ahly Cairo	ENPPI	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219226924	f	\N	\N	\N
1470	SD Eibar (W)	Madrid (W)	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219224318	f	\N	\N	\N
1471	Oeste U20	Gremio Novorizontino U20	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219198038	f	\N	\N	\N
1472	Real Madrid FC (W)	Betis (W)	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219224408	f	\N	\N	\N
1473	EC Sao Bernardo U20	Santos U20	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219198218	f	\N	\N	\N
1474	Red Bull Bragantino U20	Ferroviaria DE U20	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219197948	f	\N	\N	\N
1475	Agua Santa U20	Palmeiras U20	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219198128	f	\N	\N	\N
1476	Club San Juan de Aragon	Escorpiones FC	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219208567	f	\N	\N	\N
1477	Inter Limeira U20	Botafogo SP U20	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219197640	f	\N	\N	\N
1478	Mirassol U20	Sao Paulo U20	2023-10-04 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219197858	f	\N	\N	\N
1479	Santa Helena	ASEEV GO	2023-10-04 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219221792	f	\N	\N	\N
1480	UD Logrones	RS Gimnastica	2023-10-04 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219224678	f	\N	\N	\N
1481	Guadalajara	CD Illescas	2023-10-04 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219225038	f	\N	\N	\N
1482	Magallanes	Univ de Concepcion	2023-10-04 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219162967	f	\N	\N	\N
1483	Virtus Franca	Brindisi	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219192029	f	\N	\N	\N
1484	Catania	ACR Messina	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219191132	f	\N	\N	\N
1485	Sassari Torres	Olbia	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219191492	f	\N	\N	\N
1448	Stabaek	Ham-Kam	2023-10-04 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218520141	t	\N	\N	\N
1444	Atletico Madrid	Feyenoord	2023-10-04 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218540773	t	2	\N	244
1446	Antwerp	Shakhtar	2023-10-04 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218540914	t	2	\N	244
1486	US Latina Calcio	Casertana	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219191312	f	\N	\N	\N
1487	Leicester	Preston	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218776988	f	\N	\N	\N
1490	Ancona	ASD Pineto Calcio	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219190934	f	\N	\N	\N
1491	Benevento	FC Giugliano	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219191402	f	\N	\N	\N
1492	Boreham Wood	Hartlepool	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219043146	f	\N	\N	\N
1493	Foggia	Sorrento	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219191222	f	\N	\N	\N
1494	Juve Stabia	Potenza	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219191042	f	\N	\N	\N
1495	Leeds	QPR	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218777204	f	\N	\N	\N
1497	Centro Oeste SAF	Jaragua EC	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219221882	f	\N	\N	\N
1498	Club Real Santa Cruz	Aurora	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219199030	f	\N	\N	\N
1504	Lincoln Red Imps	Glacis Utd	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219217140	f	\N	\N	\N
1507	Sporting Gijon	Elche	2023-10-04 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218998883	f	\N	\N	\N
1508	Burgos	Leganes	2023-10-04 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218998991	f	\N	\N	\N
1509	FAR Rabat	RSB Berkane	2023-10-04 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219199711	f	\N	\N	\N
1510	CD Vargas Torres	Manta FC	2023-10-04 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219178862	f	\N	\N	\N
1511	Club Nueve de Octubre	Imbabura Sporting Club	2023-10-04 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219178682	f	\N	\N	\N
1512	Platense Zacatecoluca	Cd Fas	2023-10-04 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219214810	f	\N	\N	\N
1513	CD Trasandino	CD General Velasquez	2023-10-04 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219221341	f	\N	\N	\N
1514	EC Cruzeiro Arapiraca U20	CRB Maceio U20	2023-10-04 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219237536	f	\N	\N	\N
1515	Real Tomayapo	FC Libertad Gran Mamoré	2023-10-04 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219212217	f	\N	\N	\N
1516	Defensa y Justicia	LDU	2023-10-04 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218943114	f	\N	\N	\N
1517	Colo Colo	Cobreloa Calama	2023-10-04 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219163057	f	\N	\N	\N
1518	AE Jataiense	Goiatuba EC	2023-10-04 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219221612	f	\N	\N	\N
1519	Anapolina Go	Aparecida EC	2023-10-04 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219221702	f	\N	\N	\N
1499	RB Leipzig	Man City	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218541196	t	1	4	244
1523	Deportivo Pereira	Santa Fe	2023-10-05 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219210984	f	\N	\N	\N
1496	Swansea	Norwich	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218780113	t	2	\N	77
1502	Dortmund	AC Milan	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218548472	t	0	0	244
1505	Porto	Barcelona	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218548241	t	1	1	244
1500	Crvena Zvezda	Young Boys	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218541337	t	1	4	244
1489	Sunderland	Watford	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218780005	t	1	\N	77
1521	Hartford Athletic FC	Rio Grande Valley FC	2023-10-05 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219241380	f	\N	\N	\N
1503	Newcastle	Paris St-G	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218541478	t	2	\N	244
1506	Celtic	Lazio	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218541055	t	2	\N	244
1520	Club Sporting Canamy	Petroleros de Salamanca	2023-10-05 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219226184	f	\N	\N	\N
1524	Halcones de Zapopan	Cafetaleros de Chiapas II	2023-10-05 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219208477	f	\N	\N	\N
1522	Inter Playa Del Carmen	Aguacateros de Peribán F	2023-10-05 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219226364	f	\N	\N	\N
1525	Charlotte FC	Toronto FC	2023-10-05 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218798709	t	2	\N	76
1527	CF Montreal	Houston Dynamo	2023-10-05 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218863971	t	1	2	76
1528	FC Cincinnati	New York Red Bulls	2023-10-05 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218798601	t	2	\N	76
1526	Philadelphia	Atlanta Utd	2023-10-05 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218803241	f	\N	\N	\N
1529	New England	Columbus	2023-10-05 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218798245	f	\N	\N	\N
1532	Independiente Juniors	CD America de Quito	2023-10-05 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219178772	f	\N	\N	\N
1533	Deportivo Saprissa	Real Esteli FC	2023-10-05 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219226834	f	\N	\N	\N
1530	Malacateco	CSD Municipal	2023-10-05 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219227107	f	\N	\N	\N
1531	Llaneros FC	Boyaca Patriotas	2023-10-05 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219070293	f	\N	\N	\N
1534	Internacional	Fluminense	2023-10-05 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218955866	f	\N	\N	\N
1539	Royal Pari	Oriente Petrolero	2023-10-05 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219212127	f	\N	\N	\N
1536	Chicago Fire	Inter Miami CF	2023-10-05 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218803887	t	0	5	76
1535	Austin FC	DC Utd	2023-10-05 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218803582	t	2	\N	76
1538	FC Dallas	Colorado	2023-10-05 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218807635	f	\N	\N	\N
1537	Nashville SC	Orlando City	2023-10-05 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218803133	f	\N	\N	\N
1540	Atletico Saltillo	Coras de Nayarit FC	2023-10-05 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219226454	f	\N	\N	\N
1438	Sogndal	Kristiansund	2023-10-04 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063993	t	2	6	204
1488	Coventry	Blackburn	2023-10-04 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218777096	t	0	1	77
1501	Rotherham	Bristol City	2023-10-04 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218779897	t	0	3	77
1541	CD Olimpia	Olancho	2023-10-05 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219193654	f	\N	\N	\N
1542	Necaxa	Cruz Azul	2023-10-05 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218830145	f	\N	\N	\N
1543	Pumas UNAM	Queretaro	2023-10-05 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829785	f	\N	\N	\N
1544	Mineros de Zacatecas	Venados FC	2023-10-05 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218964933	f	\N	\N	\N
1545	Atletico Nacional Medellin	Rionegro	2023-10-05 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219211074	f	\N	\N	\N
1546	Reboceros de La Piedad	Tampico Madero	2023-10-05 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219212492	f	\N	\N	\N
1550	Alacranes de Durango	Chihuahua FC	2023-10-05 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219212310	f	\N	\N	\N
1547	Calor de San Pedro	Real Apodaca FC	2023-10-05 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219212400	f	\N	\N	\N
1548	Orange County Blues	Oakland Roots	2023-10-05 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219182056	f	\N	\N	\N
1549	Antigua GFC	Deportivo Mixco	2023-10-05 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219217230	f	\N	\N	\N
1551	CS Herediano	Comunicaciones	2023-10-05 03:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219226744	f	\N	\N	\N
1554	Los Angeles FC	Minnesota Utd	2023-10-05 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218863644	f	\N	\N	\N
1553	Vancouver Whitecaps	St Louis City SC	2023-10-05 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218866166	f	\N	\N	\N
1552	Seattle Sounders	LA Galaxy	2023-10-05 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218805547	f	\N	\N	\N
1556	Santos Laguna	Tijuana	2023-10-05 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219121171	f	\N	\N	\N
1558	Tigres	Toluca	2023-10-05 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218829875	f	\N	\N	\N
1557	Los Cabos United	Gavilanes Matamoros	2023-10-05 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219215446	f	\N	\N	\N
1555	FC Juarez (W)	Club Leon FC (W)	2023-10-05 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219227199	f	\N	\N	\N
1559	Club Atletico Morelia	Alebrijes de Oaxaca	2023-10-05 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218938106	f	\N	\N	\N
1600	FC Ulaanbaatar	Taichung Futuro FC	2023-10-05 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219229140	f	\N	\N	\N
1601	Macarthur FC	Dynamic Herb Cebu FC	2023-10-05 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219195675	f	\N	\N	\N
1602	FK Maqtaaral Jetisay	Tobol Kostanay	2023-10-05 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219219702	f	\N	\N	\N
1603	FC Osaka	Kagoshima Utd	2023-10-05 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219070542	f	\N	\N	\N
1604	MOIK Baku	Shamakhi FK	2023-10-05 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219231116	f	\N	\N	\N
1605	Energetik Mingechevir	Mil-Mugan FK	2023-10-05 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219237734	f	\N	\N	\N
1606	Dhamk	Al-Hazm (KSA)	2023-10-05 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218954155	f	\N	\N	\N
1607	FC Merw	FC Abdish-Ata Kant	2023-10-05 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219229050	f	\N	\N	\N
1608	Hougang Utd	Hai Phong	2023-10-05 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219228960	f	\N	\N	\N
5049	Pasion Celeste FC	Fancesa	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219402667	f	\N	\N	\N
5084	Once Municipal	Platense Zacatecoluca	2023-10-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219330555	f	\N	\N	\N
5772	Argentino de Merlo	Argentino de Quilmes	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219425459	f	\N	\N	\N
5774	Talleres (RE)	Deportivo Armenio	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219425639	f	\N	\N	\N
5776	Sheff Utd U21	Reading U21	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219450965	f	\N	\N	\N
5759	Baerum	Stromsgodset II	2023-10-09 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219450361	f	\N	\N	\N
5761	Zrinjski	Sloga Doboj	2023-10-09 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219426488	f	\N	\N	\N
5760	Lyn	Aalesund II	2023-10-09 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219450543	f	\N	\N	\N
5764	IK Uppsala (W)	Växjö DFF (W)	2023-10-09 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219426760	f	\N	\N	\N
5766	Canon Sportif De Yaounde	PWD Bamenda	2023-10-09 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219394615	f	\N	\N	\N
5763	FK Riteriai II	MFD Zalgiris Vilnius (Res)	2023-10-09 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219426669	f	\N	\N	\N
5762	Elche	Andorra CF	2023-10-09 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219251838	f	\N	\N	\N
5768	Sint Truidense (Res)	K Lierse U21	2023-10-09 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219426397	f	\N	\N	\N
5767	KV Oostende (Res)	Kortrijk (Res)	2023-10-09 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219426307	f	\N	\N	\N
5770	Deportes Concepcion	Deportes Rengo Unido	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219454861	f	\N	\N	\N
5769	Westerlo (Res)	FCV Dender EH U21	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219449549	f	\N	\N	\N
5765	FC Helsingor	Vendsyssel FF	2023-10-09 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219182888	t	0	1	147
5775	CS Dock Sud	Deportivo Merlo	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219425979	f	\N	\N	\N
5773	Canuelas	Comunicaciones B Aires	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219425789	f	\N	\N	\N
5777	CA Fenix	CA Colegiales	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219425369	f	\N	\N	\N
5771	Valencia (W)	Levante Las Planas (W)	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362060	f	\N	\N	\N
1609	Phnom Penh	Shan United	2023-10-05 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219225687	f	\N	\N	\N
1610	PSM Makassar	Sabah FA	2023-10-05 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219225597	f	\N	\N	\N
1611	Taiwan Steel	CPK	2023-10-05 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219225417	f	\N	\N	\N
1612	PDRM	KL Rovers	2023-10-05 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219249121	f	\N	\N	\N
1613	ZED FC	Baladeyet Al-Mahalla	2023-10-05 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219233908	f	\N	\N	\N
1614	Tanzania Prisons	Simba	2023-10-05 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219129128	f	\N	\N	\N
1615	CSA Steaua Bucuresti	Argeș Pitești	2023-10-05 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219214500	f	\N	\N	\N
1616	Stomilanki Olsztyn (W)	Medyk Konin (W)	2023-10-05 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219232078	f	\N	\N	\N
1617	Nuova Monterosi	Perugia	2023-10-05 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219228797	f	\N	\N	\N
1618	AZ Picerno ASD	Taranto Sport	2023-10-05 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219228707	f	\N	\N	\N
1619	FC Astana	Plzen	2023-10-05 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218704726	f	\N	\N	\N
1620	PWD Bamenda	Bamboutos FC de Mbouda	2023-10-05 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219233002	f	\N	\N	\N
1621	Jamshedpur FC	Hyderabad FC	2023-10-05 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219106481	f	\N	\N	\N
1622	Union Sportive de Douala	Gazelle de Garoua	2023-10-05 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219278017	f	\N	\N	\N
1623	MC Alger U21	ES Setif U21	2023-10-05 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219229590	f	\N	\N	\N
1624	CS Constantine U21	JS Saoura U21	2023-10-05 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219229230	f	\N	\N	\N
1625	JS Kabylie U21	USM Alger U21	2023-10-05 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219229500	f	\N	\N	\N
1626	CR Belouizdad U21	USM Khenchela U21	2023-10-05 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219229680	f	\N	\N	\N
1627	ES Ben Aknoun U21	US Souf U21	2023-10-05 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219229770	f	\N	\N	\N
1628	MC Oran U21	NC Magra U21	2023-10-05 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219229320	f	\N	\N	\N
1629	US Biskra U21	AC Paradou U21	2023-10-05 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219229410	f	\N	\N	\N
1630	Al Riyadh SC	Al-Shabab (KSA)	2023-10-05 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218954929	f	\N	\N	\N
1631	Al-Taawoun Buraidah	Al Taee	2023-10-05 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218954443	f	\N	\N	\N
1632	Levante Las Planas (W)	Sporting de Huelva (W)	2023-10-05 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219224228	f	\N	\N	\N
1633	Smouha	Al Mokawloon	2023-10-05 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219178499	f	\N	\N	\N
1634	Buri FC	Malkiya	2023-10-05 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219231628	f	\N	\N	\N
1635	Flora Tallinn II	Levadia Tallinn II	2023-10-05 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219238060	f	\N	\N	\N
1636	Al-Ittihad (BRN)	Aali Club	2023-10-05 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219231501	f	\N	\N	\N
1637	Altyn Asyr	Ravshan	2023-10-05 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219225507	f	\N	\N	\N
1638	Al-Ettifaq	Al Budaiya	2023-10-05 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219231718	f	\N	\N	\N
1639	Al Salmiyah	Kazma SC	2023-10-05 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219231898	f	\N	\N	\N
1640	Spal	USD Sestri Levante 1919	2023-10-05 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219228617	f	\N	\N	\N
1641	Staal Jorpeland	Viking FK II	2023-10-05 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219249284	f	\N	\N	\N
1642	Recanatese	Pesaro	2023-10-05 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219228437	f	\N	\N	\N
1643	Gent	Maccabi Tel Aviv	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218702678	f	\N	\N	\N
1644	Olimpija	Slovan Bratislava	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218702895	f	\N	\N	\N
1646	Klaksvikar Itrottarfelag	Lille	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218702570	f	\N	\N	\N
1647	Bodo Glimt	Club Brugge	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218702028	f	\N	\N	\N
4771	FC Nordsjaelland	OB	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219115626	t	1	1	40
1651	Rakow Czestochowa	Sturm Graz	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218700319	f	\N	\N	\N
1652	Besiktas	Lugano	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218701920	f	\N	\N	\N
1653	KF Ballkani	Dinamo Zagreb	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218702461	f	\N	\N	\N
1654	Betis	Sparta Prague	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218699200	f	\N	\N	\N
1655	Breidablik	Zorya	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218702786	f	\N	\N	\N
1658	Pitea	Umea FC	2023-10-05 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218999636	f	\N	\N	\N
1659	CFR Cluj	ACS Sepsi OSK	2023-10-05 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219031387	f	\N	\N	\N
1660	Andorra CF	Zaragoza	2023-10-05 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219009408	f	\N	\N	\N
1661	Mirandes	Eibar	2023-10-05 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219010159	f	\N	\N	\N
1662	Sekhukhune United	Golden Arrows	2023-10-05 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219112196	f	\N	\N	\N
1663	Shimshon Tel Aviv	AS Nordia Jerusalem	2023-10-05 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219238199	f	\N	\N	\N
1664	Barcelona (W)	Valencia (W)	2023-10-05 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219224138	f	\N	\N	\N
1657	FK Backa Topola	Olympiakos	2023-10-05 17:46:00	https://www.orbitxch.com/customer/sport/1/market/1.218700198	t	1	4	245
1648	Aris FC Limassol	Rangers	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218700559	t	1	3	245
1656	AEK Athens	Ajax	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218700680	t	1	2	245
1650	Marseille	Brighton	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218700439	t	2	\N	245
1665	Al-Ettifaq	Al-Fateh (KSA)	2023-10-05 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218954641	f	\N	\N	\N
1666	Celtic (W)	Glasgow City (W)	2023-10-05 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219238295	f	\N	\N	\N
1667	Rimini	Gubbio	2023-10-05 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219228527	f	\N	\N	\N
1668	Pescara	Fermana	2023-10-05 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219228347	f	\N	\N	\N
1677	Villarreal	Rennes	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218699321	f	\N	\N	\N
1645	Sporting Lisbon	Atalanta	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218700078	t	2	\N	245
1649	Freiburg	West Ham	2023-10-05 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218642833	t	1	3	245
1685	Atletico Palmaflor Vinto	Vaca Diez	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219239881	f	\N	\N	\N
1684	Moghreb Tetouan	FUS Rabat	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219231988	f	\N	\N	\N
1672	Lions Gibraltar	FCB Magpies	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219227017	f	\N	\N	\N
1681	Aston Villa	Zrinjski	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711141	f	\N	\N	\N
1669	FC Nordsjaelland	Ludogorets	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218704924	f	\N	\N	\N
1675	Aberdeen	HJK Helsinki	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218702136	f	\N	\N	\N
1689	Racing de Ferrol	Amorebieta	2023-10-05 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219011647	f	\N	\N	\N
1678	PAOK	Eintracht Frankfurt	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705410	f	\N	\N	\N
1676	Fiorentina	Ferencvaros	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218701811	f	\N	\N	\N
1671	Cukaricki	Genk	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218702245	f	\N	\N	\N
1680	Liverpool	Union St Gilloise	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218699837	f	\N	\N	\N
1679	Maccabi Haifa	Panathinaikos	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218699716	f	\N	\N	\N
1670	Toulouse	LASK Linz	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218699441	f	\N	\N	\N
1686	Molde	Leverkusen	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218699957	f	\N	\N	\N
1674	Hacken	Qarabag Fk	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218711032	f	\N	\N	\N
1683	Roma	Servette	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218710924	f	\N	\N	\N
1673	Spartak Trnava	Fenerbahce	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705122	f	\N	\N	\N
1682	Az Alkmaar	Legia Warsaw	2023-10-05 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218702353	f	\N	\N	\N
1687	Slavia Prague	Sheriff Tiraspol	2023-10-05 20:01:00	https://www.orbitxch.com/customer/sport/1/market/1.218699596	f	\N	\N	\N
1688	FC Cartagena	Espanyol	2023-10-05 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219012439	f	\N	\N	\N
1690	Uni Deportes (W)	Uni de Chile (W)	2023-10-05 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219266613	f	\N	\N	\N
1691	Palmeiras (W)	Barcelona Women	2023-10-05 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219266522	f	\N	\N	\N
1692	Tigres FC Zipaquira	Quindio	2023-10-05 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219193744	f	\N	\N	\N
1693	Yalmakan FC	Racing FC Porto Palmeiras	2023-10-05 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219226094	f	\N	\N	\N
1694	Chapecoense	ABC RN	2023-10-05 23:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218993436	f	\N	\N	\N
1695	Independiente Santa Fe (W)	Club Olimpia Women	2023-10-05 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219268326	f	\N	\N	\N
1700	Tapatio	Cimarrones de Sonora	2023-10-06 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218985738	f	\N	\N	\N
1702	Cuniburo FC	Macara	2023-10-06 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219220335	f	\N	\N	\N
1696	Tuzos de la UAZ	Tritones Vallarta MFC	2023-10-06 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219226004	f	\N	\N	\N
1701	Guabira	Blooming Santa Cruz	2023-10-06 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219253121	f	\N	\N	\N
1704	Cancun FC	Universidad Guadalajara	2023-10-06 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219036840	f	\N	\N	\N
1705	Alianza Petrolera	Millonarios	2023-10-06 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219210802	f	\N	\N	\N
1706	LD Alajuelense	CS Cartagines	2023-10-06 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219249468	f	\N	\N	\N
1707	CD Tepatitlan de Morelos	Club Atletico La Paz	2023-10-06 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218980901	f	\N	\N	\N
1761	Sulut United FC	Persipura Jayapura	2023-10-06 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219286347	f	\N	\N	\N
1762	RANS Nusantara FC	Psis Semarang	2023-10-06 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219267467	f	\N	\N	\N
1699	Toluca (W)	Puebla FC (W)	2023-10-06 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219249377	f	\N	\N	\N
1738	Lobos ULMX	Montaneses FC	2023-10-06 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219301620	f	\N	\N	\N
1697	Racing Club (Uru)	Nacional (Uru)	2023-10-06 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219064533	f	\N	\N	\N
1698	Ind Medellin	Cucuta Deportivo	2023-10-06 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219210892	f	\N	\N	\N
1703	SE Palmeiras	Boca Juniors	2023-10-06 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218977560	f	\N	\N	\N
1763	PS TIRA	Persis Solo	2023-10-06 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219267377	f	\N	\N	\N
1764	Gilortul Tg Carbunesti	FC U Craiova II	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219304495	f	\N	\N	\N
1765	ACS Viitorul Cluj	ACS Tg. Mures 1898	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219303558	f	\N	\N	\N
1766	Egnatia Rrogozhine	Dinamo Tirana	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219270903	f	\N	\N	\N
1767	AFC Odorheiu Secuiesc	Viitorul Curita	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219303828	f	\N	\N	\N
4879	Kryvbas Krivyi Rih	Chernomorets Odesa	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219103105	f	\N	\N	\N
5198	Itrottarfelag Fuglafjaroar	EB/Streymur	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365566	f	\N	\N	\N
7336	Brattvag	Lyn	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219713236	f	\N	\N	\N
1780	Gloria Bistrita	ACS Medias 2022	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219303444	f	\N	\N	\N
1775	Arema Cronus	Pusamania Borneo FC	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219275183	f	\N	\N	\N
1774	Lamphun Warrior	Ratchaburi	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219268453	f	\N	\N	\N
1779	FC Paulesti	CSM Flacara Moreni	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219289515	f	\N	\N	\N
1772	Tusker FC	Shabana	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219280945	f	\N	\N	\N
1783	Csm Focsani	CS Sporting Liesti	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219289334	f	\N	\N	\N
1770	Posta Rangers	Nzoia United FC	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219281037	f	\N	\N	\N
1784	Ghiroda si Giarmata Vii	Cso Turceni	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219303648	f	\N	\N	\N
1773	Muscelul Campulung	FC Pucioasa	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219304134	f	\N	\N	\N
1781	Japan (W)	Korea DPR (W)	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219261186	f	\N	\N	\N
1771	Polissya Zhytomyr	Dynamo Kiev	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219145788	f	\N	\N	\N
1778	Dunarea Calarasi	Agricola Borcea	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219289608	f	\N	\N	\N
1768	GKS Katowice (W)	Rekord Bielsko-Biala (W)	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219290185	f	\N	\N	\N
1776	Dewa United FC	PSS Sleman	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219275273	f	\N	\N	\N
1769	Kakamega Homeboyz	FC Talanta	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219281127	f	\N	\N	\N
1785	Harini FC	Pulau Pinang	2023-10-06 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219287118	f	\N	\N	\N
1786	NK Radomlje U19	NK Brinje-Grosuplje U19	2023-10-06 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219305608	f	\N	\N	\N
1787	Air Force Central	Port FC	2023-10-06 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219311685	f	\N	\N	\N
1790	Kieler SV Holstein II	Hannover II	2023-10-06 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219271623	f	\N	\N	\N
1791	Al Ittihad (EGY)	El Gounah	2023-10-06 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219286848	f	\N	\N	\N
1788	Kitayosce FC	Dodoma FC	2023-10-06 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219275877	f	\N	\N	\N
1789	NK Sesvete	HNK Orijent 1919	2023-10-06 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219259781	f	\N	\N	\N
1792	NK Olimpija Ljubljana U19	Mura U19	2023-10-06 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219305518	f	\N	\N	\N
1800	ES Mostaganem	JS Guire	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219274533	f	\N	\N	\N
1803	FK IMT Novi Beograd	Radnik Surdulica	2023-10-06 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219282214	f	\N	\N	\N
1802	Blektini Stargard	Zawisza Bydgoszcz	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219303067	f	\N	\N	\N
1797	JSM Tiaret	Cr Temouchent	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219274353	f	\N	\N	\N
1796	RC Arba	GC Mascara	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219274173	f	\N	\N	\N
1799	WA Boufarik	MCB Oued Sly	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219274443	f	\N	\N	\N
1794	NA Hussein Dey	ESM Kolea	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219274623	f	\N	\N	\N
1793	SK Kvítkovice	Slovacko B	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219275517	f	\N	\N	\N
1795	Zira	PFK Turan Tovuz	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219261667	f	\N	\N	\N
1801	SC Mecheria	ASM Oran	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219274263	f	\N	\N	\N
1805	Levski Krumovgrad	Botev Vratsa	2023-10-06 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219178091	f	\N	\N	\N
1804	Punjab FC	Northeast United	2023-10-06 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219290005	f	\N	\N	\N
1806	CS Constantine	JS Saoura	2023-10-06 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219270993	f	\N	\N	\N
1808	Al Jahra	Al Fahaheel FC	2023-10-06 15:55:00	https://www.orbitxch.com/customer/sport/1/market/1.219282394	f	\N	\N	\N
1807	MC Alger	ES Setif	2023-10-06 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219271263	f	\N	\N	\N
1811	FK Riga	FK Tukums 2000	2023-10-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219232482	f	\N	\N	\N
1814	Ilves	AC Oulu	2023-10-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219005429	f	\N	\N	\N
1809	Hajduk Split U19	NK Varazdin U19	2023-10-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219286708	f	\N	\N	\N
1812	FC U Craiova 1948	Hermannstadt	2023-10-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218886093	f	\N	\N	\N
1815	Ruzomberok	Zlate Moravce	2023-10-06 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219002840	f	\N	\N	\N
1813	Pohronie	Spartak Myjava	2023-10-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219253376	f	\N	\N	\N
1810	Al Nassr	Abha	2023-10-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218953763	f	\N	\N	\N
1816	SK Hranice	Trinec	2023-10-06 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219275697	f	\N	\N	\N
1817	FC Zbrojovka Brno	Pribram	2023-10-06 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219010249	f	\N	\N	\N
1822	Al-Shabbab (BRN)	Al Hidd	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219282484	f	\N	\N	\N
1819	Pharco FC	Ceramica Cleopatra	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219178319	f	\N	\N	\N
1820	FK Velez Mostar	Nk Posusje	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219285729	f	\N	\N	\N
1821	Chrobry Glogow	Odra Opole	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218993130	f	\N	\N	\N
1818	Korona Kielce	Warta Poznan	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218838230	f	\N	\N	\N
4882	Gimnasia de La Plata (W)	Excursionistas (W)	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365707	f	\N	\N	\N
1830	Slaven Belupo	Varazdin	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219007421	f	\N	\N	\N
1831	APR FC	Musanze	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219311087	f	\N	\N	\N
1825	Usti Nad Labem	FK Prepere	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219275607	f	\N	\N	\N
1827	LKS Lodz II	Kotwica Kolobrzeg	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219281219	f	\N	\N	\N
1826	Al Hala	Al Najma (BRN)	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219282575	f	\N	\N	\N
1823	BK Hacken (W)	Vittsjo (W)	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219269339	f	\N	\N	\N
1835	DSV Leoben	SV Lafnitz	2023-10-06 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219009083	f	\N	\N	\N
1828	Hlucin	Rsm Hodonin	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219275787	f	\N	\N	\N
1824	Rosengard (W)	Djurgardens IF Dff (W)	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219269069	f	\N	\N	\N
1834	Radnicki Nis	FK Napredak	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219282123	f	\N	\N	\N
1836	SV Horn	Ksv 1919	2023-10-06 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219008903	f	\N	\N	\N
1837	SKU Amstetten	SV Ried	2023-10-06 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219008993	f	\N	\N	\N
1855	B93 Copenhagen	Hillerod Fodbold	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219064713	t	0	3	147
1841	Empoli	Udinese	2023-10-06 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218930699	t	0	0	4
1842	Asco Atsv Wolfsberg	KAC 1909	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219281669	f	\N	\N	\N
1849	AC Horsens	AaB	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219010429	t	2	\N	147
1854	Froya	Fyllingsdalen	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219302342	f	\N	\N	\N
1839	Fortuna Dusseldorf	VFL Osnabruck	2023-10-06 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218828179	t	0	2	93
1862	Adana Demirspor	Trabzonspor	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218903984	f	\N	\N	\N
1860	SC Weiz	SPG Lask Amateure	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219281399	f	\N	\N	\N
1848	Silkeborg	Lyngby	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219025179	f	\N	\N	\N
1850	Bron Radom	Unia Skierniewice	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219303157	f	\N	\N	\N
1844	SV Sandhausen	SSV Ulm	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219201794	f	\N	\N	\N
1864	TSV Rudow	SpVg Blau-Weiss 1890 Berlin	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219298028	f	\N	\N	\N
1843	Kufstein	Dornbirner SV	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219294874	f	\N	\N	\N
1857	Lokomotiv Leipzig	Hertha Berlin II	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219272821	f	\N	\N	\N
1852	Husqvarna	IK Tord	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219311223	f	\N	\N	\N
1851	FC Eilenburg	Cottbus	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273001	f	\N	\N	\N
1853	Vanersborgs IF	Ljungskile	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219259058	f	\N	\N	\N
1840	Kaiserslautern	Hannover	2023-10-06 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218825454	t	2	\N	93
1859	Beroe Stara Za	Lokomotiv Sofia	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219105626	f	\N	\N	\N
1858	Hammarby TFF	IFK Stocksund	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219097600	f	\N	\N	\N
1847	Kocaelispor	Erzurum BB	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219010339	f	\N	\N	\N
1846	ASV Drassburg	TWL Elektra	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219281579	f	\N	\N	\N
1845	Babelsberg	Viktoria Berlin	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273453	f	\N	\N	\N
1856	Weiche Flensburg	FC Phonix Lubeck	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219271533	f	\N	\N	\N
1861	Alanyaspor	Fatih Karagumruk Istanbul	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218903768	f	\N	\N	\N
1876	Red Star	Villefranche Beaujolais	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219262582	f	\N	\N	\N
1866	GOAL FC	Chateauroux	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219262705	f	\N	\N	\N
1872	Austria Wien (A)	SR Donaufeld	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219281489	f	\N	\N	\N
1868	Stade Nyonnais	FC Baden	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219018529	f	\N	\N	\N
1838	Fredericia	SonderjyskE	2023-10-06 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219078509	t	1	3	147
1869	TSG Sprockhovel	SpVgg Erkenschwick	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219271729	f	\N	\N	\N
1873	Epinal	Rouen	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219262026	f	\N	\N	\N
1867	Martigues	Le Mans	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219262219	f	\N	\N	\N
1871	Nimes	Niort	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219262129	f	\N	\N	\N
1874	Excelsior (W)	Twente (W)	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219269429	f	\N	\N	\N
1870	AZ Alkmaar Women	Fortuna Sittard (W)	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219269519	f	\N	\N	\N
1878	Schaffhausen	FC Vaduz	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219018439	f	\N	\N	\N
1877	AS Eupen (Res)	Waasland-Beveren (Res)	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219281759	f	\N	\N	\N
1865	Berlin Turkspor	Berlin Hilalspor	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219297938	f	\N	\N	\N
1875	FC Zwolle (W)	PSV Eindhoven (W)	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219269609	f	\N	\N	\N
1832	Mazatlan FC U23	Club America U23	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219301949	f	\N	\N	\N
4877	Varnsdorf	Vysocina Jihlava	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219114399	f	\N	\N	\N
5306	Poli Ejido	Almeria B	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390429	f	\N	\N	\N
1881	Fortuna Koln	Alemannia Aachen	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219271926	f	\N	\N	\N
1882	Khaitan	Al Nasar (KUW)	2023-10-06 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219282304	f	\N	\N	\N
1884	AA Portuguesa U20	Corinthians U20	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219286527	f	\N	\N	\N
1908	Wolves U21	Bournemouth U21	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219293307	f	\N	\N	\N
1903	Jong PSV Eindhoven	MVV Maastricht	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219065703	f	\N	\N	\N
1902	Jong Ajax Amsterdam	VVV Venlo	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219066243	f	\N	\N	\N
1885	Tvd Velbert	FC Kleve	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219271819	f	\N	\N	\N
1912	CA Banfield (W)	Defensores de Belgrano (W)	2023-10-06 19:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219310759	f	\N	\N	\N
1910	Rapid Bucharest	CSMS Iasi	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218886243	f	\N	\N	\N
1889	Helmond Sport	Jong FC Utrecht	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219065523	f	\N	\N	\N
1911	FC Volendam	FC Utrecht	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218765751	t	0	1	196
1904	Roda JC	Jong AZ Alkmaar	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219018079	f	\N	\N	\N
1906	Al-Ittihad	Al Ahli	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218953891	f	\N	\N	\N
1892	Tennis Borussia Berlin	Dynamo Schwerin	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219268618	f	\N	\N	\N
1883	RFC de Liege U21	KMSK Deinze U21	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219281849	f	\N	\N	\N
1909	Colchester United U21	Chelsea U21	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219293487	f	\N	\N	\N
1894	Fulham U21	Leicester U21	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219293397	f	\N	\N	\N
1905	Willem II	De Graafschap	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219065973	t	2	\N	199
1901	Emmen	SC Telstar	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219066423	f	\N	\N	\N
1891	Nottingham Forest U21	Huddersfield Town U21	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219293217	f	\N	\N	\N
1896	Seraing Utd	FCV Dender	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219282029	f	\N	\N	\N
1907	Middlesbrough U21	Ipswich Town U21	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219293667	f	\N	\N	\N
1886	Den Bosch	FC Eindhoven	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219066603	f	\N	\N	\N
1898	MC Oran	NC Magra	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219271173	f	\N	\N	\N
1890	NAC Breda	FC Groningen	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219066063	t	2	\N	199
1888	FC Dordrecht	Cambuur Leeuwarden	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219065883	f	\N	\N	\N
1900	ADO Den Haag	FC Oss	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219017989	f	\N	\N	\N
1899	US Biskra	Paradou	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219271083	f	\N	\N	\N
1895	Leeds United U21	Luton Town U21	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219314402	f	\N	\N	\N
1893	Aston Villa U21	Hull City U21	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219293577	f	\N	\N	\N
1913	Sion	FC Wil	2023-10-06 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219018349	f	\N	\N	\N
1914	AA Aparecidense U20	Aparecida EC U20	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219300482	f	\N	\N	\N
1920	Guillermo Brown	Alvarado	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219188174	f	\N	\N	\N
1915	Cerrado U20	Itaberai U20	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219300303	f	\N	\N	\N
1917	Goias EC U20	Guanabara City U20	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219300213	f	\N	\N	\N
1916	Vila Nova U20	Jataiense U20	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219300123	f	\N	\N	\N
1924	Academica	Covilha	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219218616	f	\N	\N	\N
1919	Brescia	Feralpisalo	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219064983	f	\N	\N	\N
1929	GKS Jastrzebie	Radunia Stezyca	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219281309	f	\N	\N	\N
1922	Francs Borains U21	Lommel SK U21	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219281939	f	\N	\N	\N
1927	Mgladbach	Mainz	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218721157	t	2	\N	1
1918	Lech Poznan	Puszcza Niepolomice	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218838410	f	\N	\N	\N
1931	Shelbourne	Dundalk	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219010609	f	\N	\N	\N
1926	Puskas Akademia	Kisvarda	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218951351	f	\N	\N	\N
1921	FIRST VIENNA FC 1894	Floridsdorfer Ac	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219010519	f	\N	\N	\N
1923	Lechia Gdansk	Gornik Leczna	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218992641	f	\N	\N	\N
1925	Man Utd (W)	Arsenal (W)	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219264634	f	\N	\N	\N
1928	Femina WS (W)	Anderlecht (W)	2023-10-06 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219274895	f	\N	\N	\N
1933	Cardiff Metropolitan	Barry Town Utd	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219209064	f	\N	\N	\N
1932	Treaty United	Finn Harps	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219069222	f	\N	\N	\N
1930	Mantova	Alessandria	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219258322	f	\N	\N	\N
1880	Orleans	Nancy	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219262492	f	\N	\N	\N
4993	Progres Niedercorn	Fola Esch	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219368607	f	\N	\N	\N
1937	Potters Bar Town	Berkhamsted Town	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219262891	f	\N	\N	\N
1940	Athlone Town	Bray Wanderers	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219010968	f	\N	\N	\N
1934	Drogheda	Derry City	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218838590	f	\N	\N	\N
1942	Lecce	Sassuolo	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218931689	t	1	2	4
1936	Cobh Ramblers	Longford	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219069033	f	\N	\N	\N
1939	Larne	Crusaders	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219066333	f	\N	\N	\N
1938	Linfield	Glentoran	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219066693	f	\N	\N	\N
1944	Le Havre AC (W)	Paris FC (W)	2023-10-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219283384	f	\N	\N	\N
1945	Albacete	Levante	2023-10-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219221162	f	\N	\N	\N
1947	Athletic Bilbao	Almeria	2023-10-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218889191	f	\N	\N	\N
1946	Birmingham	West Brom	2023-10-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219011148	f	\N	\N	\N
1948	Strasbourg	Nantes	2023-10-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218752026	t	0	3	5
1943	Aberystwyth	Connahs Quay	2023-10-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219208884	f	\N	\N	\N
1952	Stjarnan (W)	Throttur Reykjavik (W)	2023-10-06 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219285519	f	\N	\N	\N
1951	Moreirense	Boavista	2023-10-06 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219067053	t	2	\N	8
1950	Valur Reykjavik (W)	Breidablik (W)	2023-10-06 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219285429	f	\N	\N	\N
1953	SCCM Chabab Mohamedia	HUSA Agadir	2023-10-06 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219286017	f	\N	\N	\N
1954	CD Buzanada	CD Herbania	2023-10-06 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219305153	f	\N	\N	\N
1957	Monagas	Deportivo La Guaira	2023-10-06 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219267228	f	\N	\N	\N
1958	Arucas CF	UD Teror Balompie	2023-10-06 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219305063	f	\N	\N	\N
1955	Club Nacional (W)	SC Internacional (W)	2023-10-06 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219297771	f	\N	\N	\N
1961	Deportivo Llacuabamba	Uni San Martin	2023-10-06 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219286256	f	\N	\N	\N
1956	CD Hermanos Colmenarez	Zamora FC	2023-10-06 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219267048	f	\N	\N	\N
1960	Nueva Chicago	Defensores de Belgrano	2023-10-06 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219189254	f	\N	\N	\N
1959	Mineros Guayana	Angostura FC	2023-10-06 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219267138	f	\N	\N	\N
1962	Vianopolis U20	Trindade AC U20	2023-10-06 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219300393	f	\N	\N	\N
1963	Boca Juniors de Cali	Atletico FC Cali	2023-10-06 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219182438	f	\N	\N	\N
1964	Cruz Azul (W)	Atletico San Luis (W)	2023-10-06 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219270149	f	\N	\N	\N
1966	Union La Calera	Huachipato	2023-10-06 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219062553	f	\N	\N	\N
1965	Chilangos FC	Ciervos fc	2023-10-06 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219269699	f	\N	\N	\N
1967	Corinthians (W)	Colo Colo (W)	2023-10-06 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219292292	f	\N	\N	\N
1969	CD Poza Rica	Caja Oblatos C.FD	2023-10-07 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219274714	f	\N	\N	\N
1968	Boca Juniors (W)	America de Cali (W)	2023-10-06 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219292382	f	\N	\N	\N
1973	Correcaminos Uat	Celaya	2023-10-07 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218938196	f	\N	\N	\N
1974	Valour	HFX Wanderers	2023-10-07 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219297483	f	\N	\N	\N
1970	Torque	La Luz FC	2023-10-07 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219018619	f	\N	\N	\N
1971	Jaguares de Cordoba	Tolima	2023-10-07 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219083948	f	\N	\N	\N
1975	Rosario Central	Huracan	2023-10-07 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218830449	f	\N	\N	\N
1977	Deportivo Cuenca	Univ Catolica (Ecu)	2023-10-07 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219018169	f	\N	\N	\N
1976	Alianza FC (SLV)	Fuerte San Francisco	2023-10-07 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219286437	f	\N	\N	\N
1980	CRB	Ceara SC Fortaleza	2023-10-07 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219006475	f	\N	\N	\N
1978	All Boys	Estudiantes Rio Cuarto	2023-10-07 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219188624	f	\N	\N	\N
1979	Atletico Go	Ituano	2023-10-07 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218975200	f	\N	\N	\N
1981	San Francisco FC	UMECIT	2023-10-07 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219298532	f	\N	\N	\N
1982	Municipal Grecia	Santos de Guapiles	2023-10-07 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219266958	f	\N	\N	\N
1986	Mazatlan FC	CF America	2023-10-07 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219102359	f	\N	\N	\N
1984	Junior FC Barranquilla	Deportivo Cali	2023-10-07 02:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219115308	f	\N	\N	\N
1983	FC Atlas (W)	Mazatlan FC(W)	2023-10-07 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219270059	f	\N	\N	\N
1987	Maruyasu Okazaki	Tokyo Musashino City	2023-10-07 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219307880	f	\N	\N	\N
1988	Busan IPark	Cheonan City	2023-10-07 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219069843	f	\N	\N	\N
1972	Cashmere Technical	Wellington Olympic AFC	2023-10-07 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219193051	f	\N	\N	\N
1941	Kerry FC	Wexford F.C	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219011058	f	\N	\N	\N
1782	CSM Deva	CSM Jiul Petrosani	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219303738	f	\N	\N	\N
1777	CS Unirea Bascov	ACS Vedita Colonesti MS	2023-10-06 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219289424	f	\N	\N	\N
1989	FC Ryukyu	Kamatamare Sanuki	2023-10-07 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219070632	f	\N	\N	\N
2449	Omiya	Renofa Yamaguchi	2023-10-07 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219027613	f	\N	\N	\N
2032	Viktoria FC-Szombathely (W)	Puskas Akademia (W)	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219323566	f	\N	\N	\N
2223	RC Kouba	WA Mostaganem	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219334986	f	\N	\N	\N
1798	KP Starogard Gdanski	Swit Skolwin	2023-10-06 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219302977	f	\N	\N	\N
2048	Club A.B.B.	Ciudad Nueva Santa Cruz	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324916	f	\N	\N	\N
1829	Saint-Etienne (W)	Paris St-G (W)	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219283294	f	\N	\N	\N
1833	Linkopings FC (W)	Pitea IF (W)	2023-10-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219269249	f	\N	\N	\N
1863	Taraji Wadi Al-Nes	Hilal Al Quds	2023-10-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219283024	f	\N	\N	\N
1879	Dijon	Marignane-Gignac	2023-10-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219262310	f	\N	\N	\N
1897	Royal Charleroi SC (W)	SV Zulte Waregem (W)	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219274805	f	\N	\N	\N
2362	Newton Aycliffe	Hebburn Town	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219333233	f	\N	\N	\N
2450	Shimizu	Iwata	2023-10-07 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218769577	f	\N	\N	\N
2368	Avro FC	Rylands FC	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219262981	f	\N	\N	\N
1949	Guadalupe F.C	Futbol Consultants Moravia	2023-10-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219310944	f	\N	\N	\N
2451	Tokyo-V	Oita	2023-10-07 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218769487	f	\N	\N	\N
2453	Wofoo Tai Po	Resources Capital FC	2023-10-07 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219313391	f	\N	\N	\N
1935	Charleroi	Molenbeek	2023-10-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219123446	t	0	\N	68
1887	Lommel	SL 16 FC	2023-10-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219104607	t	1	1	136
2417	FC Atlas (W)	Mazatlan FC(W)	2023-10-07 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219270059	f	\N	\N	\N
1985	Auckland United	Christchurch United	2023-10-07 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219193187	f	\N	\N	\N
2422	Sony Sendai FC	Honda FC	2023-10-07 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219344741	f	\N	\N	\N
1990	Gimcheon Sangmu	Bucheon FC 1995	2023-10-07 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219069933	f	\N	\N	\N
5327	Municipal Turrialba	AD Aserri	2023-10-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219403204	f	\N	\N	\N
2454	Eastern AA	Sham Shui Po	2023-10-07 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219313301	f	\N	\N	\N
2455	Jeonnam Dragons	Ansan Greeners FC	2023-10-07 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219028995	f	\N	\N	\N
2452	Seongnam FC	Chungnam Asan	2023-10-07 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219039101	f	\N	\N	\N
2461	Persebaya Surabaya	Persib Bandung	2023-10-07 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219314542	f	\N	\N	\N
2460	Chindia Targoviste	Progresul 1944 Spartac	2023-10-07 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168794	f	\N	\N	\N
2464	ACS Viitorul Tg Jiu	Concordia Chiajna	2023-10-07 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168433	f	\N	\N	\N
2459	FC Unirea Dej	Acs Dumbravita	2023-10-07 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168343	f	\N	\N	\N
2463	CS Mioveni	CSM Scolar Resita	2023-10-07 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168163	f	\N	\N	\N
2466	Vyskov	Zizkov	2023-10-07 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219042246	f	\N	\N	\N
2456	Uzbekistan U23	Hong Kong U23	2023-10-07 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219290092	f	\N	\N	\N
2458	FC Metaloglobus Bucuresti	Csikszereda	2023-10-07 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168253	f	\N	\N	\N
2457	FCM Alexandria	Ceahlaul	2023-10-07 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168614	f	\N	\N	\N
2465	MFK Chrudim	SFC Opava	2023-10-07 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219042336	f	\N	\N	\N
2468	Prostejov	Lisen	2023-10-07 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219042426	f	\N	\N	\N
2467	Csm Slatina	Gloria Buzau	2023-10-07 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219168073	f	\N	\N	\N
2469	Sydney FC	Brisbane Roar	2023-10-07 09:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218891638	f	\N	\N	\N
2470	FC Schalke U19	FC Koln U19	2023-10-07 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219351980	f	\N	\N	\N
2473	MFKRuzomberok (W)	Topolcany (W)	2023-10-07 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219363783	f	\N	\N	\N
2474	MSV Duisburg U19	Mgladbach U19	2023-10-07 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219317638	f	\N	\N	\N
2472	SV Sandhausen U19	Leverkusen U19	2023-10-07 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219351890	f	\N	\N	\N
2471	FC Sp. Trnava (W)	FK AS Trencin (W)	2023-10-07 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219364089	f	\N	\N	\N
2478	Seoul E-Land FC	Gyeongnam	2023-10-07 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219091249	f	\N	\N	\N
2479	Gimpo Citizen	FC Anyang	2023-10-07 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219036931	f	\N	\N	\N
2477	Tallinna JK Legion	Paide Linnameeskond II	2023-10-07 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219317548	f	\N	\N	\N
2480	Nomme Kalju	Parnu JK Vaprus	2023-10-07 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219172696	f	\N	\N	\N
2476	AC Torrellano	Elche B	2023-10-07 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219335481	f	\N	\N	\N
2462	Nagasaki	Fujieda MYFC	2023-10-07 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218769667	f	\N	\N	\N
8642	Caen	Auxerre	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510186	f	\N	\N	\N
5026	Club Gimnasia y Tiro	Sarmiento de Resistencia	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219371810	f	\N	\N	\N
2485	Atletico Madrid (W)	Sevilla FC (W)	2023-10-07 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219265756	f	\N	\N	\N
2488	Hutnik Krakow	Sandecja Nowy Sacz	2023-10-07 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219319169	f	\N	\N	\N
2484	BFC Daugavpils	Valmieras FK	2023-10-07 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219232752	f	\N	\N	\N
2481	Dnipro-1	Veres Rivne	2023-10-07 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219146112	f	\N	\N	\N
2489	Pendikspor	Sivasspor	2023-10-07 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219212837	f	\N	\N	\N
2487	Sampdoria (W)	Como FC (W)	2023-10-07 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219319838	f	\N	\N	\N
2486	Radomiak Radom	LKS Lodz	2023-10-07 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218838320	f	\N	\N	\N
2494	Mezokovesd-Zsory	Zalaegerszeg	2023-10-07 11:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218951452	f	\N	\N	\N
2491	Manisa FK	Sakaryaspor	2023-10-07 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219070203	f	\N	\N	\N
2490	Bandirmaspor	Corum Belediyespor	2023-10-07 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219122221	f	\N	\N	\N
2492	Samut Prakan	Phrae United	2023-10-07 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219319047	f	\N	\N	\N
2495	Persiba Balikpapan	Kalteng Putra FC	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219344651	f	\N	\N	\N
2493	Koge (W)	Fortuna Hjorring (W)	2023-10-07 11:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219319626	f	\N	\N	\N
2496	FK Kauno Zalgiris	FK Banga Gargzdu	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219329878	f	\N	\N	\N
2513	Wehen Wiesbaden	Hamburger SV	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218798028	f	\N	\N	\N
2501	Jaro	KaPa	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219103619	f	\N	\N	\N
2511	Krabi FC	Customs United	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219319427	f	\N	\N	\N
2500	Orebro Syrianska	Taby FK	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219094360	f	\N	\N	\N
2502	CF Panaderia Pulido	UD Gran Tarajal	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219337276	f	\N	\N	\N
2509	Altglienicke	Berliner AK	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273271	f	\N	\N	\N
2503	Carl Zeiss Jena	Hansa Rostock II	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273091	f	\N	\N	\N
2510	Kasetsart FC	Chanthaburi FC	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219319517	f	\N	\N	\N
2515	Burnley U21	Brentford U21	2023-10-07 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219345014	f	\N	\N	\N
2497	FC Magdeburg	Karlsruhe	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218867760	f	\N	\N	\N
2504	Sukhothai	BG Pathumthani United	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219338733	f	\N	\N	\N
2498	Tvaakers	Falkenbergs	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219111258	f	\N	\N	\N
2512	ACS Petrolul 52	UTA Arad	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218886423	f	\N	\N	\N
2499	Samtredia	Dinamo Tbilisi	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219319745	f	\N	\N	\N
2518	Lampang FC	JL Chiangmai United	2023-10-07 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219319928	f	\N	\N	\N
2505	KPV	JJK	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219103823	f	\N	\N	\N
2516	Sunderland	Middlesbrough	2023-10-07 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219046807	t	0	4	77
2517	Oxford Utd	Bristol Rovers	2023-10-07 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219102959	f	\N	\N	\N
2508	Greuther Furth	Hansa Rostock	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218825778	t	1	1	93
2520	CSKA Sofia	PFC Levski Sofia	2023-10-07 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219177985	f	\N	\N	\N
2514	Tallinna Kalev	Fci Tallinn	2023-10-07 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219172335	f	\N	\N	\N
2521	NK Jarun	Vukovar	2023-10-07 12:50:00	https://www.orbitxch.com/customer/sport/1/market/1.219259691	f	\N	\N	\N
2522	Blackburn U21	West Brom U21	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219345284	f	\N	\N	\N
2533	Rot-Weiss Essen	Verl	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219200685	f	\N	\N	\N
2523	AFC Leopards SC (Kenya)	Gor Mahia FC	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219344161	f	\N	\N	\N
2535	Dacia Buiucani	CSF Balti	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219321568	f	\N	\N	\N
2531	FK Qabala	Sabail	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219261772	f	\N	\N	\N
2525	South Korea U23	Japan U23	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219289915	f	\N	\N	\N
2526	Tikves Kavadarci	KF Shkupi	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219322985	f	\N	\N	\N
2519	Luton	Tottenham	2023-10-07 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218752684	t	0	1	2
2530	TransINVEST Vilnius	FK Panevezio Ekranas	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219322592	f	\N	\N	\N
2532	1860 Munich	Dynamo Dresden	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219201703	f	\N	\N	\N
2528	Ulinzi Stars	FC Kariobangi Sharks	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219344252	f	\N	\N	\N
2534	Liepajas Metalurgs	FK Jelgava	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219232842	f	\N	\N	\N
2524	Chainat Hornbill	Suphanburi	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219323746	f	\N	\N	\N
2529	FC Goa	Odisha	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219257533	f	\N	\N	\N
2483	CD Nacional Funchal	Oliveirense	2023-10-07 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219067683	f	\N	\N	\N
2507	SalPA	JaPS	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219103709	f	\N	\N	\N
2527	Modena	Palermo	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219065343	f	\N	\N	\N
5041	Aldosivi	CD MAIPU	2023-10-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219188444	f	\N	\N	\N
2547	Police Tero	Prachuap	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219342854	f	\N	\N	\N
2563	FSV Frankfurt	SV Steinbach	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273813	f	\N	\N	\N
2541	Wurzburger Kickers	Nurnberg II	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219272605	f	\N	\N	\N
2564	Kirsehir Belediyespor	Ankaraspor	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219323255	f	\N	\N	\N
2566	FC Dornbirn	SK Sturm Graz II	2023-10-07 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219068673	f	\N	\N	\N
2551	FC Astoria Walldorf	Hessen Kassel	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219274083	f	\N	\N	\N
2562	Bahlinger SC	SV Stuttgarter Kickers	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273723	f	\N	\N	\N
2544	Wuppertaler	SV Lippstadt	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219272173	f	\N	\N	\N
2545	Skive	Nykobing FC	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219321762	f	\N	\N	\N
2559	Sheffield United (W)	London City Lionesses	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219344559	f	\N	\N	\N
2540	FC Inter	SJK	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219069213	f	\N	\N	\N
2554	Arminia Bielefeld	Dortmund II	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219201523	f	\N	\N	\N
2555	Cosenza	Lecco	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219065433	f	\N	\N	\N
2553	Duisburg	Unterhaching	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219201885	f	\N	\N	\N
2557	Homburg	Kickers Offenbach	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273633	f	\N	\N	\N
2542	Reggiana	SSD Bari	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219065613	f	\N	\N	\N
2548	Feyenoord (W)	Ajax (W)	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324016	f	\N	\N	\N
2558	PAS Giannina	NFC Volos	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219338532	f	\N	\N	\N
2549	Middelfart	Roskilde	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219321672	f	\N	\N	\N
2572	Halmstads	Degerfors	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219003597	t	0	0	14
2539	Waldhof Mannheim	Viktoria Koln	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219201975	f	\N	\N	\N
2538	Rigas Futbola Skola	FK Auda	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219232662	f	\N	\N	\N
2561	Akademija Pandev	FK Gostivar	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219323075	f	\N	\N	\N
2543	Schalke 04 II	SC Wiedenbruck	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219272353	f	\N	\N	\N
2550	LNZ-Lebedyn	Oleksandria	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219111348	f	\N	\N	\N
2552	FC Duren	Rot-Weiss Oberhausen	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219272263	f	\N	\N	\N
2537	Sudtirol	Catanzaro	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219065793	f	\N	\N	\N
2568	Grazer AK	Bregenz	2023-10-07 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219068763	f	\N	\N	\N
2565	Kirklarelispor	Karacabey Belediyespor AS	2023-10-07 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219323165	f	\N	\N	\N
2573	Sl. Bratislava (W)	FC Petrzalka (W)	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219364179	f	\N	\N	\N
2567	Belediyespor	Genclik Spor	2023-10-07 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219364391	f	\N	\N	\N
2585	Mikkeli	TPS	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219175561	f	\N	\N	\N
2581	Ullern	Strommen	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219270453	f	\N	\N	\N
2569	Thisted	Frederiksberg	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219322289	f	\N	\N	\N
2578	Kjelsas	Grorud IL	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219270633	f	\N	\N	\N
2587	Stabaek (W)	Lsk Kvinner (W)	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219348812	f	\N	\N	\N
2570	Swansea U21	Brighton U21	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219345104	f	\N	\N	\N
2575	Sigma Olomouc	Mlada Boleslav	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218850814	f	\N	\N	\N
2571	AIK	Mjallby	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219003778	f	\N	\N	\N
2588	Vasteras SK	Jonkopings Sodra	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219166712	t	1	4	336
2589	Wisla Pulawy	Olimpia Grudziadz	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219323926	f	\N	\N	\N
2556	Cadiz	Girona	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218917276	t	0	1	3
2574	Sanliurfaspor	Genclerbirligi	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219070113	f	\N	\N	\N
2580	Rosenborg BK (W)	Asane Football (W)	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219348688	f	\N	\N	\N
2591	Tondela	Leixoes	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219067413	f	\N	\N	\N
2590	Newcastle U21	Fleetwood Town U21	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219345194	f	\N	\N	\N
2584	Montpellier (W)	EA Guingamp (W)	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324466	f	\N	\N	\N
2586	Trat	Nakhon Pathom	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219343215	f	\N	\N	\N
2583	SJK 2	HIFK	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219175651	f	\N	\N	\N
2577	Bohemians 1905	Zlin	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218850508	f	\N	\N	\N
2576	Bordeaux	Laval	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219064263	f	\N	\N	\N
2579	Bella Vista	Uruguay Montevideo FC	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219323476	f	\N	\N	\N
2536	Persija Jakarta	PS Barito Putera	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324286	f	\N	\N	\N
4870	KV Oostende	Anderlecht B	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219394149	t	2	\N	136
2621	Stuttgart	Wolfsburg	2023-10-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218722263	t	1	4	1
2609	Skovde AIK	Gefle	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219167162	f	\N	\N	\N
2592	FK Humenne	MFk Dolny Kubin	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219253646	f	\N	\N	\N
2608	Osters	Orebro	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219167343	f	\N	\N	\N
2601	Cibalia Vinkovci	BSK Bijelo Brdo	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219259961	f	\N	\N	\N
2594	Hammarby (W)	Kristianstads (W)	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219322790	f	\N	\N	\N
2606	Inter	Bologna	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218931059	t	2	\N	4
2599	Slovacko	Teplice	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218850328	f	\N	\N	\N
2602	NK Dugopolje	Zrinski Jurjevac	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219259871	f	\N	\N	\N
2593	KFC Komarno	MSK Povazska Bystrica	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219253466	f	\N	\N	\N
2616	El Daklyeh	Al-Masry	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219178229	f	\N	\N	\N
2615	PAOK B	AEK Athens B	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324376	f	\N	\N	\N
2610	Ankaragucu	Kayserispor	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218904092	f	\N	\N	\N
2596	Raufoss	Mjondalen	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219085638	t	0	\N	204
2638	Motala	United IK Nordic	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219107059	f	\N	\N	\N
2605	Podbeskidzie B-B	Stal Rzeszow	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218993007	f	\N	\N	\N
2597	Ceske Budejovice	MFK Karvina	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218850994	f	\N	\N	\N
2598	Stade Reims (W)	Dijon (W)	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324556	f	\N	\N	\N
2595	Tatran Presov	FK Puchov	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219253736	f	\N	\N	\N
2607	Lille (W)	Fleury 91 (W)	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219348231	f	\N	\N	\N
2600	Widzew Lodz	Stal Mielec	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218838140	f	\N	\N	\N
2613	Skeid	Sandnes Ulf	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219069663	t	2	\N	204
2622	Bala Town	Colwyn Bay	2023-10-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219209155	f	\N	\N	\N
2611	Zvijezda 09 Bijeljina	Tuzla City	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324736	f	\N	\N	\N
2617	Newtown	Caernarfon Town	2023-10-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219209335	f	\N	\N	\N
2620	Dortmund	Union Berlin	2023-10-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218722731	t	2	\N	1
2614	Sogndal	Moss	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219086313	t	0	\N	204
2625	Galway Utd	Bohemians	2023-10-07 14:40:00	https://www.orbitxch.com/customer/sport/1/market/1.219163327	f	\N	\N	\N
2624	Penybont FC	The New Saints	2023-10-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219208974	f	\N	\N	\N
2603	Kolding IF	HB Koge	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219078419	t	0	4	147
2634	Celtic	Kilmarnock	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218713105	f	\N	\N	\N
2623	RB Leipzig	Bochum	2023-10-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218721037	t	0	0	1
2632	Loughgall	Carrick Rangers	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219103913	f	\N	\N	\N
2635	Charlton	Blackpool	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219100905	f	\N	\N	\N
2640	Barrow	Notts Co	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095710	f	\N	\N	\N
2644	IBV	Keflavik	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219110628	f	\N	\N	\N
2636	Mansfield	AFC Wimbledon	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095890	f	\N	\N	\N
2629	Livingston	Motherwell	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218713321	f	\N	\N	\N
2633	Ballymena	Newry	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219066783	f	\N	\N	\N
2630	Coleraine	Glenavon	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219066153	f	\N	\N	\N
2647	Stevenage	Wigan	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219102524	f	\N	\N	\N
2648	Kolos Kovalyovka	Vorskla	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219103198	f	\N	\N	\N
2626	Bolton	Carlisle	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219102755	f	\N	\N	\N
2646	Marske United	Marine FC	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248236	f	\N	\N	\N
2627	Dundee	Ross Co	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218713537	f	\N	\N	\N
2645	Southampton	Rotherham	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219044229	f	\N	\N	\N
2643	Elgin City FC	Stenhousemuir	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219053222	f	\N	\N	\N
2639	Alfreton Town	Warrington Town	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113726	f	\N	\N	\N
2631	Cliftonville	Dungannon	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219066513	f	\N	\N	\N
2628	Hearts	Hibernian	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218713429	f	\N	\N	\N
2637	Norrby IF	Eskilsminne	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219094450	f	\N	\N	\N
2641	QPR	Blackburn	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219044445	f	\N	\N	\N
2642	Stockport	Doncaster	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096700	f	\N	\N	\N
2612	EIF	Gnistan	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219175741	f	\N	\N	\N
4931	Stabaek	Lillestrom	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218861564	t	0	1	13
2657	Bishops Stortford	Southport	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113366	f	\N	\N	\N
2659	Gainsborough	Guiseley	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219293757	f	\N	\N	\N
2697	Dunfermline	Arbroath	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219043686	f	\N	\N	\N
2698	Shrewsbury	Northampton	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219102038	f	\N	\N	\N
2669	Cercle Brugge	Oud-Heverlee Leuven	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219068493	t	2	\N	68
2684	FC Sellier & Bellot Vlasim	Dukla Prague	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219067863	f	\N	\N	\N
2687	Bognor Regis	Hayes & Yeading	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219262801	f	\N	\N	\N
2680	Maidenhead	Rochdale	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095170	f	\N	\N	\N
2674	Leiston	Hornchurch	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248417	f	\N	\N	\N
2653	Queen of South	Stirling	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052592	f	\N	\N	\N
2694	Banbury Utd	Blyth Spartans	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113906	f	\N	\N	\N
2693	Airdrieonians	Ayr	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219043956	f	\N	\N	\N
2691	Salford City	Crewe	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095620	f	\N	\N	\N
2678	Boreham Wood	Chesterfield	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095800	f	\N	\N	\N
2655	Sheff Wed	Huddersfield	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219044337	f	\N	\N	\N
2656	Vikingur Reykjavik	Valur	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219181042	f	\N	\N	\N
2671	Aatvidabergs FF	BK Olympic	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219097150	f	\N	\N	\N
2650	Coventry	Norwich	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219045093	t	1	2	77
2673	Hitchin Town	Stamford	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248055	f	\N	\N	\N
2668	Gimnastic	Ponferradina	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168523	f	\N	\N	\N
2662	Exeter	Barnsley	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219102326	f	\N	\N	\N
2663	CD Binissalem FC	UD Arenal	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219337407	f	\N	\N	\N
2664	Thagafi Tulkarem	Shabab Al-Obaideya	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219316576	f	\N	\N	\N
2665	Clyde	Dumbarton	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219053042	f	\N	\N	\N
2690	Stade Tunisien	Etoile Sportive Sahel	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219323656	f	\N	\N	\N
2679	Sutton Utd	Walsall	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096970	f	\N	\N	\N
2666	Curzon Ashton	Boston Utd	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219111926	f	\N	\N	\N
2704	Queens Park	Morton	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219043596	f	\N	\N	\N
2682	York City	Bromley	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219094720	f	\N	\N	\N
2660	Morpeth Town AFC	FC Utd Manchester	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248326	f	\N	\N	\N
2689	Fleetwood Town	Wycombe	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219101122	f	\N	\N	\N
2701	Inverness CT	Partick	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219043866	f	\N	\N	\N
2667	Ebbsfleet Utd	FC Halifax Town	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096610	f	\N	\N	\N
2654	Leyton Orient	Reading	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219101526	f	\N	\N	\N
2670	Edinburgh City	Kelty Hearts	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052682	f	\N	\N	\N
2651	Ipswich	Preston	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219044877	t	2	\N	77
2677	Swindon Supermarine	Tiverton Town	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248757	f	\N	\N	\N
2702	St Albans	Eastbourne	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112286	f	\N	\N	\N
2658	Kings Lynn	Buxton	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113096	f	\N	\N	\N
2661	Fk Novi Pazar	Vojvodina	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219322682	f	\N	\N	\N
2703	Redditch United	Leamington	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248938	f	\N	\N	\N
2675	Colchester	Morecambe	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095980	f	\N	\N	\N
2652	Cove Rangers	Annan	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219066963	f	\N	\N	\N
2649	KA Akureyri	HK Kopavogur	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219110538	f	\N	\N	\N
2676	Crawley Town	Wrexham	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095350	f	\N	\N	\N
2683	Bonnyrigg	East Fife	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219053132	f	\N	\N	\N
2681	Oxford City	AFC Fylde	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219094900	f	\N	\N	\N
2686	Ahlafors IF	Lunds BK	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219084045	f	\N	\N	\N
2672	CD Calahorra B	CCD Alberite	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219336690	f	\N	\N	\N
2692	Peterborough	Lincoln	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219101233	f	\N	\N	\N
2700	Chester	Peterborough Sports FC	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113816	f	\N	\N	\N
2685	Forfar	Peterhead	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052952	f	\N	\N	\N
2696	Needham Market	Cray Wanderers	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219265665	f	\N	\N	\N
5710	Cafetaleros de Chiapas II	Yalmakan FC	2023-10-09 00:01:00	https://www.orbitxch.com/customer/sport/1/market/1.219404920	f	\N	\N	\N
2760	Stratford Town	Basford United FC	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248667	f	\N	\N	\N
2726	Ariana FC	FC Trollhattan	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219097510	f	\N	\N	\N
2705	Torquay	Maidstone Utd	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112826	f	\N	\N	\N
2746	Gillingham	MK Dons	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095530	f	\N	\N	\N
2741	Everton	Bournemouth	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218752825	f	\N	\N	\N
2757	Tranmere	Grimsby	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096880	f	\N	\N	\N
2721	Haka	KTP	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219069393	f	\N	\N	\N
2744	FC Sabah	Araz Nakhchivan PFK	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219261561	f	\N	\N	\N
2719	Leeds	Bristol City	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219044769	f	\N	\N	\N
2755	Yeovil	Aveley	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219111836	f	\N	\N	\N
2759	St Ives Town	Kettering Town FC	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219249028	f	\N	\N	\N
2728	Montrose	Alloa	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219052862	f	\N	\N	\N
2715	Woking	Southend	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219094810	f	\N	\N	\N
2761	Osijek	Rudes	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219067953	f	\N	\N	\N
2709	SD Atletico Albericia	UC Cartes	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219336346	f	\N	\N	\N
2733	Tamworth FC	Darlington	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113456	f	\N	\N	\N
2732	Portsmouth	Port Vale	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219101014	f	\N	\N	\N
2710	Gateshead	Altrincham	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219094990	f	\N	\N	\N
2730	Bradford	Swindon	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096070	f	\N	\N	\N
2749	Stranraer	Spartans	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219070023	f	\N	\N	\N
2722	Leicester	Stoke	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219044661	t	1	2	77
2720	Raith	Dundee Utd	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219043776	f	\N	\N	\N
2752	Oskarshamns AIK	Angelholms	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219097240	f	\N	\N	\N
2731	Tonbridge Angels	Hemel Hempstead	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112376	f	\N	\N	\N
2713	Kidderminster	Wealdstone	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095080	f	\N	\N	\N
2734	Vasalunds IF	IF Sylvia	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219097420	f	\N	\N	\N
2736	Newport County	Harrogate Town	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096520	f	\N	\N	\N
2750	Weston-super-Mare	Chelmsford	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112106	f	\N	\N	\N
2743	Burnley	Chelsea	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218752543	f	\N	\N	\N
2739	Long Eaton United	Stourbridge	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248507	f	\N	\N	\N
2737	Hendon	AFC Sudbury	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248145	f	\N	\N	\N
2756	Spennymoor Town	Rushall Olympic	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219114057	f	\N	\N	\N
2748	Welling Utd	Farnborough FC	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112016	f	\N	\N	\N
2729	Slough Town	Weymouth	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112556	f	\N	\N	\N
2742	Man Utd	Brentford	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218752261	t	1	3	2
2751	Cheltenham	Derby	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219101726	f	\N	\N	\N
2735	MAS Taborsko	Sigma Olomouc B	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219067773	f	\N	\N	\N
2707	Worthing	Truro City	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112736	f	\N	\N	\N
2708	Scarborough Athletic	Farsley Celtic	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113636	f	\N	\N	\N
2740	Hartlepool	Eastleigh	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095440	f	\N	\N	\N
2727	Gloucester	Chorley	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113276	f	\N	\N	\N
2758	Royston Town	Coalville Town	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219248847	f	\N	\N	\N
2711	Scunthorpe	Brackley Town	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113546	f	\N	\N	\N
2717	Braintree	Bath City	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113006	f	\N	\N	\N
2738	Club Ferro Carril Oeste (W)	Lanus (W)	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324826	f	\N	\N	\N
2706	Ponferradina II	Atletico Astorga CF	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219335932	f	\N	\N	\N
2753	Radcliffe Borough	Whitby Town	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219363307	f	\N	\N	\N
2725	Plymouth	Swansea	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219044121	f	\N	\N	\N
2724	Millwall	Hull	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219044553	f	\N	\N	\N
2747	Trans Narva	Tammeka Tartu	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219172426	f	\N	\N	\N
2716	Cardiff	Watford	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219044985	f	\N	\N	\N
2712	South Shields	Hereford FC	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219113186	f	\N	\N	\N
2718	Chippenham	Dartford	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112916	f	\N	\N	\N
2754	Torns	Oddevold	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219097060	f	\N	\N	\N
5724	Shenyang Urban FC	Shanghai Jiading	2023-10-09 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219434392	f	\N	\N	\N
2764	Hafnarfjordur	KR Reykjavik	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219115128	f	\N	\N	\N
2765	Oldham	Dag and Red	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219095260	f	\N	\N	\N
2766	Fulham	Sheff Utd	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218752022	f	\N	\N	\N
2773	Huesca	Eldense	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219252651	f	\N	\N	\N
2777	Erzgebirge	Saarbrucken	2023-10-07 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219201613	f	\N	\N	\N
2768	Ascoli	Sampdoria	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219065073	f	\N	\N	\N
2769	Valle de Egüés	UD Barbastro	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219236996	f	\N	\N	\N
2770	Cittadella	Ternana	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219065163	f	\N	\N	\N
2772	Venezia	Parma	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219065253	f	\N	\N	\N
2771	Renate	Triestina	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219257875	f	\N	\N	\N
2776	SSD Pro Sesto	Novara	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219257965	f	\N	\N	\N
2782	UE Tona	CF Peralada	2023-10-07 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219335571	f	\N	\N	\N
2780	Heerenveen	NEC Nijmegen	2023-10-07 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218765967	t	2	\N	196
2805	Ostersunds FK	Helsingborgs	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219167253	t	0	1	336
2785	ES Ben Aknoun	US Souf	2023-10-07 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219318426	f	\N	\N	\N
2781	CD Beti Onak	UCD Burlades	2023-10-07 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219337003	f	\N	\N	\N
2779	Chaves	Gil Vicente	2023-10-07 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219067233	t	2	\N	8
2786	CD Laguna del Duero	SD Almazan	2023-10-07 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219336913	f	\N	\N	\N
2783	Farense	Vizela	2023-10-07 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219067143	t	0	0	8
2778	Chennaiyin FC	Atletico De Kolkata	2023-10-07 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219069483	f	\N	\N	\N
2787	Slavia Sofia	Arda	2023-10-07 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219172245	f	\N	\N	\N
2789	Linares	CDSC Iberia	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219353329	f	\N	\N	\N
2784	Belouizdad	USM Khenchela	2023-10-07 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219318606	f	\N	\N	\N
2788	Riteriai	Hegelmann Litauen	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219329968	f	\N	\N	\N
2800	Hapoel Tel Aviv	Hapoel Haifa	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219192302	f	\N	\N	\N
2804	Sporting Lisbon B	Alverca	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219268979	f	\N	\N	\N
2799	Metz	Nice	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218809025	f	\N	\N	\N
2808	CD Mirandes II	CD Burgos Promesas	2023-10-07 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219336780	f	\N	\N	\N
2803	Deportivo La Coruna II	SD Compostela	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219233542	f	\N	\N	\N
2790	UD Ourense	Zamora	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219233362	f	\N	\N	\N
2795	Austria Vienna	FC Blau Weiss Linz	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218764972	t	2	\N	43
2802	SC Vianense	Felgueiras	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219268799	f	\N	\N	\N
2791	Chojniczanka Chojnice	Zaglebie Lubin II	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219323836	f	\N	\N	\N
2797	SC AUSTRIA LUSTENAU	Rapid Vienna	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218764648	t	2	\N	43
2810	Curico Unido	Cobresal	2023-10-07 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219062733	f	\N	\N	\N
2774	Real Madrid	Osasuna	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218926963	t	1	4	3
2806	Al-Akhdoud	Al-Hilal	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218953637	f	\N	\N	\N
2796	Hartberg	WSG Wattens	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218764432	t	0	\N	43
2801	Oliveira Hospital	Atletico Clube de Portugal	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219268709	f	\N	\N	\N
2811	Cerro Largo FC	Centro Atletico Fenix	2023-10-07 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219120090	f	\N	\N	\N
2793	CD Anaitasuna	SD Beasain	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219336022	f	\N	\N	\N
2798	Union de Touarga	FAR Rabat	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219330365	f	\N	\N	\N
2794	Leioa	Lagun Onak	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219335842	f	\N	\N	\N
2815	FC Voluntari	Universitatea Craiova	2023-10-07 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218886697	f	\N	\N	\N
2812	Wisla Krakow	Znicz Pruszkow	2023-10-07 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218992371	f	\N	\N	\N
2817	Akh. Belediye	Silivrispor	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219364713	f	\N	\N	\N
2814	NK Celje	NK Bravo	2023-10-07 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219069753	f	\N	\N	\N
2813	Zaglebie Lubin	Piast Gliwice	2023-10-07 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218838770	f	\N	\N	\N
2809	IFK Goteborg	Sirius	2023-10-07 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219003688	t	0	\N	14
2816	Shamrock Rovers (W)	Shelbourne (W)	2023-10-07 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219179449	f	\N	\N	\N
2762	Rayo Vallecano B	CD Galapagar	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219335211	f	\N	\N	\N
2767	FC Legnago	Giana Erminio	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219258235	f	\N	\N	\N
2792	FC Milsami-Ursidos	Zimbru Chisinau	2023-10-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324106	f	\N	\N	\N
2847	Espanyol B	Centre d'Esports Manresa	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219237176	f	\N	\N	\N
2824	Zemplin	Zilina	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218879057	f	\N	\N	\N
2844	Odds BK	Viking	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218861240	f	\N	\N	\N
5725	Weifang Juexiaoya	Hunan Billows FC	2023-10-09 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219410750	f	\N	\N	\N
2869	Padova	Aurora Pro Patria 1919	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219258055	f	\N	\N	\N
2822	National Bank	Zamalek	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219068943	f	\N	\N	\N
2832	Sligo Rovers (W)	Cork City (W)	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219179359	f	\N	\N	\N
2827	Arenas Club de Getxo	Real Sociedad III	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219236906	f	\N	\N	\N
2821	Balsicas Atletico	Alcantarilla FC	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219337093	f	\N	\N	\N
2849	El Geish	Future FC	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219069123	f	\N	\N	\N
2837	Dila Gori	Torpedo Kutaisi	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219333357	f	\N	\N	\N
2845	Banik Ostrava	Pardubice	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218851502	f	\N	\N	\N
2848	Antalyaspor	Galatasaray	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218903354	f	\N	\N	\N
2830	East Riffa	Manama Club	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219325560	f	\N	\N	\N
2818	FC Zurich	Winterthur	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219103472	t	2	\N	15
2836	Getafe B	AD Llerenense	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219258971	f	\N	\N	\N
2833	Yverdon Sport	Grasshoppers Zurich	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219151480	f	\N	\N	\N
2843	Maccabi Bnei Raina	FC Ashdod	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219068853	f	\N	\N	\N
2851	Juventus	Torino	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218930939	f	\N	\N	\N
2839	Sitra	Busaiteen Club	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219352070	f	\N	\N	\N
2854	Westerlo	Kortrijk	2023-10-07 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219104483	t	1	\N	68
2820	Guijuelo	Real Oviedo II	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219233452	f	\N	\N	\N
2829	Orlando Pirates (SA)	Mamelodi Sundowns	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219344831	f	\N	\N	\N
2838	V de Santa Brigida	Club Atletico Victoria	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219337184	f	\N	\N	\N
2834	CD Trofense	CF Canelas 2010	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219268889	f	\N	\N	\N
2826	Algeciras	Cordoba	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219197046	f	\N	\N	\N
2861	Dorking Wanderers	Barnet	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219094630	f	\N	\N	\N
2846	Basaksehir	Gaziantep FK	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218904308	f	\N	\N	\N
2841	Huracanes Izcalli FC	Artesanos Metepec F.C.	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219269879	f	\N	\N	\N
2840	Peamount United (W)	Treaty United (W)	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219179269	f	\N	\N	\N
2835	MFK Skalica	FC Kosice	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219002750	f	\N	\N	\N
2819	FK Javor Ivanjica	Zeleznicar Pancevo	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219325289	f	\N	\N	\N
2842	Bucaspor	Halide Edip Adivarspor	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219345638	f	\N	\N	\N
2831	FC Koln II	FC Wegberg-Beeck	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219272083	f	\N	\N	\N
2858	Partizan Belgrade	Mladost Lucani	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219333571	f	\N	\N	\N
2875	Almere City	RKC Waalwijk	2023-10-07 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218766291	f	\N	\N	\N
2860	Rijeka	Hajduk Split	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219068043	f	\N	\N	\N
2872	CD Ebro	CD Carinena	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219336600	f	\N	\N	\N
2859	Tallinna FC Flora	Kuressaare	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219172516	f	\N	\N	\N
2867	UD Mutilvera	CD Brea	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219236726	f	\N	\N	\N
2868	Crystal Palace	Nottm Forest	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218752402	f	\N	\N	\N
2865	Mallorca	Valencia	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218926411	f	\N	\N	\N
2862	Atalanta B	Albinoleffe	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219298348	f	\N	\N	\N
2871	Falkirk	Hamilton	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219066873	f	\N	\N	\N
2866	Anorga KKE	CD Padura	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219335751	f	\N	\N	\N
2863	Racing Santander	Sporting Gijon	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219252741	f	\N	\N	\N
2856	Sportive de Tunis	Monastir	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219332988	f	\N	\N	\N
2857	Villarrubia CF	AD San Clemente	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219336510	f	\N	\N	\N
2874	CA Atlanta	Quilmes	2023-10-07 17:35:00	https://www.orbitxch.com/customer/sport/1/market/1.219188354	f	\N	\N	\N
2870	Werder Bremen	Hoffenheim	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218721903	t	2	\N	1
2864	Hapoel Eran Hadera	Maccabi Petach Tikva	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219216710	f	\N	\N	\N
2825	Hodd	Kristiansund	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219085728	t	0	\N	204
2828	Correcaminos (Premier)	Los Cabos United	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219269969	f	\N	\N	\N
2823	Thun	Neuchatel Xamax	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219064893	f	\N	\N	\N
5726	Wuhan Jiangcheng	Shaoxing Shangyu Pterosaur	2023-10-09 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219410660	f	\N	\N	\N
2914	Patro Eisden Maasmechelen	FC Liege	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219352501	t	0	2	136
2892	Paris FC	Auxerre	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219064083	f	\N	\N	\N
2887	Concarneau	Dunkerque	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063543	f	\N	\N	\N
2878	CD Teruel	Arenteiro	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168884	f	\N	\N	\N
2890	Markaz Balata	Al Birah	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219330455	f	\N	\N	\N
2888	Guingamp	Grenoble	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219064623	f	\N	\N	\N
2889	AC Milan (W)	Juventus FC (W)	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219333481	f	\N	\N	\N
2880	Quevilly Rouen	Pau	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219064803	f	\N	\N	\N
2883	Hapoel Petach Tikva	Beitar Jerusalem	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219216618	f	\N	\N	\N
2894	Valenciennes	ESTAC Troyes	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063363	f	\N	\N	\N
2897	Atletico Sanluqueno CF	Ibiza Eivissa	2023-10-07 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219197226	f	\N	\N	\N
2896	Mouloudia dOujda	Mas Maghrib A Fes	2023-10-07 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219330278	f	\N	\N	\N
2881	Amiens	Angers	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063723	f	\N	\N	\N
2886	Bastia	Annecy	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219064443	f	\N	\N	\N
2879	Bohemians (W)	Wexford Youths (W)	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219179179	f	\N	\N	\N
2882	SD Revilla	SRD Vimenor CF	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219336220	f	\N	\N	\N
2884	St Etienne	AC Ajaccio	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063453	f	\N	\N	\N
2900	CD Rincon	Atletico Mancha Real	2023-10-07 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219335121	f	\N	\N	\N
2895	Cherno More	Lokomotiv Plovdiv	2023-10-07 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219177895	f	\N	\N	\N
2901	Urduliz FT	SCD Durango	2023-10-07 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219335661	f	\N	\N	\N
2899	Sochaux	Avranches	2023-10-07 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219262401	f	\N	\N	\N
2907	Ruch Chorzow	Pogon Szczecin	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218838950	f	\N	\N	\N
2898	Versailles 78 FC	Cholet SO	2023-10-07 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219261926	f	\N	\N	\N
2917	Go Ahead Eagles	Heracles	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218766507	t	2	\N	196
2920	Tecnico Universitario	Orense Sporting Club	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219119910	f	\N	\N	\N
2923	Rosario Central (W)	CA Huracan (W)	2023-10-07 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219326220	f	\N	\N	\N
2924	NK Maribor	Mura	2023-10-07 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219114579	f	\N	\N	\N
2915	Al-Shabab	Kuwait SC	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219348905	f	\N	\N	\N
2908	Wisla Plock	Arka Gdynia	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218993220	f	\N	\N	\N
2903	Al-Khaleej Saihat	Al-Raed (KSA)	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219259580	f	\N	\N	\N
2905	Al-Wahda (KSA)	Al-Feiha	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219185472	f	\N	\N	\N
2911	SD Logrones	Union de Salamanca	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168974	f	\N	\N	\N
2906	OHiggins	Univ Catolica (Chile)	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219062823	f	\N	\N	\N
2902	Deportes Valdivia	Real San Joaquin	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219353509	f	\N	\N	\N
2922	Chilpancingo	Atlético Pachuca	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219269789	f	\N	\N	\N
2909	San Telmo	CA Guemes	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219189164	f	\N	\N	\N
2918	Kabylie	USM Alger	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219318516	f	\N	\N	\N
2921	Athlone Town (W)	DLR Waves (W)	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219179089	f	\N	\N	\N
2912	Ferro Carril Oeste GP	CS Estudiantes San Luis	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219326670	f	\N	\N	\N
2919	Merida AD	Antequera CF	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219198668	f	\N	\N	\N
2910	Deportivo Municipal	Cienciano	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219171573	f	\N	\N	\N
2916	Liverpool Montevideo	Wanderers (Uru)	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219120360	f	\N	\N	\N
2913	Club Brugge B	Francs Borains	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219352606	f	\N	\N	\N
2930	Palencia Cristo Atletico	CD Diocesanos	2023-10-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219337999	f	\N	\N	\N
2928	Kecskemeti	Paks	2023-10-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218951565	f	\N	\N	\N
2931	Real Madrid FC (W)	Villarreal (W)	2023-10-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219316486	f	\N	\N	\N
2925	Tombense MG	Juventude	2023-10-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219036378	f	\N	\N	\N
2885	Braga	Rio Ave	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219067323	t	1	3	8
2927	Botosani	FCSB	2023-10-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218886517	f	\N	\N	\N
2929	St Pauli	Nurnberg	2023-10-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218798137	t	2	\N	93
2926	Almagro BA	Patronato	2023-10-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219188804	f	\N	\N	\N
2891	Pacos Ferreira	Vilaverdense	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219067503	f	\N	\N	\N
2893	Rodez	Caen	2023-10-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063903	f	\N	\N	\N
5727	Persikab Kabupateng Bandung	Perserang Serang	2023-10-09 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219450271	f	\N	\N	\N
2936	CSD San Antonio Unido	Provincial Osorno	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219353419	f	\N	\N	\N
2938	CMC del Norte	CA Central Norte	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219363213	f	\N	\N	\N
2986	Inter de Queretaro FC	Inter Playa Del Carmen	2023-10-08 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219354154	f	\N	\N	\N
2943	Sevilla	Rayo Vallecano	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218932005	f	\N	\N	\N
2947	San Lorenzo	Newells	2023-10-07 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218830539	f	\N	\N	\N
2941	Agropecuario	Gimnasia Mendoza	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219189074	f	\N	\N	\N
2937	Goias	Bahia	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218772664	f	\N	\N	\N
2946	Rayo Zuliano	Puerto Cabello	2023-10-07 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219312805	f	\N	\N	\N
2942	Fortaleza FC	Bogota	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219068133	f	\N	\N	\N
2934	Anderlecht	Yellow-Red Mechelen	2023-10-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219068403	t	1	4	68
2940	Leganes	Oviedo	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219252469	f	\N	\N	\N
2939	FC Libertad Gran Mamoré	Club Real Santa Cruz	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219312265	f	\N	\N	\N
2944	Vitesse Arnhem	Excelsior	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218766075	t	0	\N	196
2948	Universidad de Venezuela	Metropolitanos	2023-10-07 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219313497	f	\N	\N	\N
2950	Estudiantes de Merida	Deportivo Tachira	2023-10-07 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219312715	f	\N	\N	\N
2952	Sampaio Correa FC	Novorizontino	2023-10-07 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219011827	f	\N	\N	\N
2951	Deportivo Garcilaso	AD Cantolao	2023-10-07 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219171663	f	\N	\N	\N
2949	Estoril Praia	Benfica	2023-10-07 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219110235	t	0	1	8
2953	Botafogo SP	Avai	2023-10-07 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219011737	f	\N	\N	\N
2954	Real Santander	Barranquilla	2023-10-07 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219182528	f	\N	\N	\N
2957	Emelec	Cumbaya FC	2023-10-07 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219076092	f	\N	\N	\N
2955	Universidad de Chile	Everton De Vina	2023-10-07 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219062913	f	\N	\N	\N
2956	Cortulua	Boyaca Patriotas	2023-10-07 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219315345	f	\N	\N	\N
2960	Coban Imperial	Achuapa FC	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219314861	f	\N	\N	\N
2963	Tauro FC	Sporting San Miguelito	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219312355	f	\N	\N	\N
2962	Chaco For Ever	Deportivo Madryn	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219188264	f	\N	\N	\N
2959	Amazonas FC	Botafogo PB	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219311796	f	\N	\N	\N
2967	Cavalry	Pacific	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219309490	f	\N	\N	\N
2966	Guarani	Vila Nova	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219013709	f	\N	\N	\N
2961	Volta Redonda	Paysandu	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219311992	f	\N	\N	\N
2970	Jocoro	Cd Fas	2023-10-07 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219313875	f	\N	\N	\N
2968	CA Temperley	Deportivo Moron	2023-10-07 22:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219188894	f	\N	\N	\N
2958	Forge	Atletico Ottawa	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219309400	f	\N	\N	\N
2965	CD Marathon	CD Motagua	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219317458	f	\N	\N	\N
2969	Vasco Da Gama	Sao Paulo	2023-10-07 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218772424	f	\N	\N	\N
2977	Lanus	Defensa y Justicia	2023-10-07 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218830719	f	\N	\N	\N
2973	Aguacateros de Peribán F.C	Club Sporting Canamy	2023-10-07 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219358310	f	\N	\N	\N
2971	Penarol	Defensor Sporting	2023-10-07 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219120450	f	\N	\N	\N
2975	Estudiantes	Godoy Cruz	2023-10-07 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218830629	f	\N	\N	\N
2974	Club CDM	FC Santiago	2023-10-07 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219353977	f	\N	\N	\N
2983	Municipal Perez Zeledon	AD Municipal Liberia	2023-10-08 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219312895	f	\N	\N	\N
2972	Colima FC	MinerosFresnillo	2023-10-07 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219363397	f	\N	\N	\N
2976	Santamarina	Sol De Mayo	2023-10-07 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219342494	f	\N	\N	\N
2979	Loudoun United FC	Detroit City FC	2023-10-07 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219181966	f	\N	\N	\N
2978	Deportivo Irapuato FC	Reboceros de La Piedad	2023-10-07 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219358220	f	\N	\N	\N
2981	Lobos UPNFM	Real Espana	2023-10-08 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219317278	f	\N	\N	\N
2985	CA Liniers	Circulo Deportivo Otamendi	2023-10-08 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219342404	f	\N	\N	\N
2945	Reims	Monaco	2023-10-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218751819	t	1	\N	5
2982	Aucas	Barcelona (Ecu)	2023-10-08 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219119820	f	\N	\N	\N
2984	Coquimbo Unido	Union Espanola	2023-10-08 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063003	f	\N	\N	\N
2980	Monterrey	FC Juarez	2023-10-08 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219101873	f	\N	\N	\N
2933	Tristan Suarez	Brown de Adrogue	2023-10-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219188534	f	\N	\N	\N
2935	Genoa	AC Milan	2023-10-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218998477	t	0	1	4
5728	Qingdao Red Lions	Jiangxi Dark Horse Junior	2023-10-09 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219410939	f	\N	\N	\N
2604	Kvik Halden	Gjovik-Lyn	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219270723	f	\N	\N	\N
2990	New York Red Bulls	Toronto FC	2023-10-08 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219349599	t	1	3	76
2996	Coras de Nayarit FC	Calor de San Pedro	2023-10-08 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219354067	f	\N	\N	\N
2993	Philadelphia	Nashville SC	2023-10-08 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219147624	t	0	0	76
2989	Inter Miami CF	FC Cincinnati	2023-10-08 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219148123	t	0	1	76
2988	CF Montreal	Portland Timbers	2023-10-08 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219349707	t	2	\N	76
2997	Corinthians	Flamengo	2023-10-08 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218772304	f	\N	\N	\N
3000	Austin FC	Los Angeles FC	2023-10-08 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219349383	f	\N	\N	\N
2991	Orlando City	New England	2023-10-08 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219349491	f	\N	\N	\N
2995	DC Utd	New York City	2023-10-08 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219349815	f	\N	\N	\N
2998	CD Municipal Limeno	CD Dragon	2023-10-08 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219313785	f	\N	\N	\N
3002	Chicago Fire	Charlotte FC	2023-10-08 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219147516	f	\N	\N	\N
2999	Minnesota Utd	LA Galaxy	2023-10-08 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219147840	f	\N	\N	\N
3006	Guadalajara	Atlas	2023-10-08 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219101750	f	\N	\N	\N
3004	FC Dallas	San Jose Earthquakes	2023-10-08 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219349275	f	\N	\N	\N
3005	Argentinos Juniors	CA Independiente	2023-10-08 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218830809	f	\N	\N	\N
3001	Central Cordoba (SdE)	Tigre	2023-10-08 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218833753	f	\N	\N	\N
3011	Santa Fe	Rionegro	2023-10-08 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.219158638	f	\N	\N	\N
3003	Houston Dynamo	Colorado	2023-10-08 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219147408	f	\N	\N	\N
3010	Petroleros de Salamanca	Deportiva Venados	2023-10-08 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219348591	f	\N	\N	\N
3015	CS Herediano	Deportivo Saprissa	2023-10-08 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219303341	f	\N	\N	\N
3009	AD Isidro Metapan	CD Luis Angel Firpo	2023-10-08 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219314008	f	\N	\N	\N
3007	Pachuca	Tigres	2023-10-08 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219101359	f	\N	\N	\N
3012	Real Salt Lake	Kansas City	2023-10-08 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219125194	f	\N	\N	\N
3008	Napier City Rovers	Auckland City	2023-10-08 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219196680	f	\N	\N	\N
3013	Atletico Independiente	Herrera FC	2023-10-08 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219312445	f	\N	\N	\N
3016	Vida	Olancho	2023-10-08 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219317368	f	\N	\N	\N
3017	San Diego Loyal SC	Oakland Roots	2023-10-08 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219181786	f	\N	\N	\N
3019	Eastern Suburbs Auckland	Petone	2023-10-08 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219193291	f	\N	\N	\N
3014	Chihuahua FC	Cimarrones de Sonora II	2023-10-08 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219348501	f	\N	\N	\N
3022	Cruz Azul	Pumas UNAM	2023-10-08 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219102161	f	\N	\N	\N
3021	Xelaju	Guastatoya	2023-10-08 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219314756	f	\N	\N	\N
3018	Manurewa AFC	Wellington Phoenix (Res)	2023-10-08 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219201085	f	\N	\N	\N
3024	Briobecca Urayasu SC	Verspah Oita	2023-10-08 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219352353	f	\N	\N	\N
3020	Seattle Sounders	Vancouver Whitecaps	2023-10-08 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219147948	f	\N	\N	\N
3028	Tottori	Sagamihara	2023-10-08 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219163417	f	\N	\N	\N
3027	Yokohama SCC	Nara Club	2023-10-08 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219120991	f	\N	\N	\N
3026	Fukushima Utd	FC Imabari	2023-10-08 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219120901	f	\N	\N	\N
3025	Okinawa SV	Kochi Univ	2023-10-08 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219352160	f	\N	\N	\N
2987	Union Magdalena	Atletico Nacional Medellin	2023-10-08 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219158998	f	\N	\N	\N
3029	Kumamoto	Kashiwa	2023-10-08 05:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218964465	f	\N	\N	\N
2745	Accrington	Forest Green	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096790	f	\N	\N	\N
2475	FC Tatran Prešov (W)	MSK Zilina (W)	2023-10-07 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219364269	f	\N	\N	\N
2482	Lee Man Warriors	Southern District	2023-10-07 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219318835	f	\N	\N	\N
2506	Union Kleinmunchen (W)	FC Wacker Innsbruck (W)	2023-10-07 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219325006	f	\N	\N	\N
2546	Arendal	Vard Haugesund	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219270813	f	\N	\N	\N
2560	Nairobi City Stars	Kenya Police FC	2023-10-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219344071	f	\N	\N	\N
3156	Ullensaker Kisa	Stjordals-Blink	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219369756	f	\N	\N	\N
2582	Pomigliano (W)	AS Roma (W)	2023-10-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219324196	f	\N	\N	\N
2619	FC Nordsjaelland (W)	Thisted (W)	2023-10-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219324646	f	\N	\N	\N
2992	Atlanta Utd	Columbus	2023-10-08 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219147732	f	\N	\N	\N
2994	Tampa Bay Rowdies	Pittsburgh Riverhounds	2023-10-08 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219181876	f	\N	\N	\N
2855	Pontypridd Town	Haverfordwest County	2023-10-07 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219209245	f	\N	\N	\N
3439	A.C. Trento S.C.S.D.	Lumezzane	2023-10-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219258145	f	\N	\N	\N
2877	CD Burriana CF	Atletico Levante UD	2023-10-07 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219335301	f	\N	\N	\N
2904	CD Castellon	Real Madrid Castilla	2023-10-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219197136	f	\N	\N	\N
5729	Hainan Star	Haimen Codion	2023-10-09 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219411029	f	\N	\N	\N
2964	Envigado	Deportivo Pereira	2023-10-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219115218	f	\N	\N	\N
4521	Nacional Potosi	Independiente Petrolero	2023-10-07 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219372691	f	\N	\N	\N
5730	Quanzhou Yaxin	Taian Tiankuang	2023-10-09 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219415783	f	\N	\N	\N
5731	Leixoes U23	Sporting Braga U23	2023-10-09 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219419566	f	\N	\N	\N
5732	Guangzhou FC	Wuxi Wugou	2023-10-09 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219434482	f	\N	\N	\N
5733	Suzhou Dongwu	Dongguan Guanlian	2023-10-09 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219417085	f	\N	\N	\N
2876	Bnei Sakhnin	Maccabi Netanya	2023-10-07 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219110808	f	\N	\N	\N
5734	Qingdao Youth Island	Jinan Xingzhou	2023-10-09 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219434572	f	\N	\N	\N
5735	Semen Padang	PSMS Medan	2023-10-09 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219452801	f	\N	\N	\N
5736	Kampaniakos	Asteras Tripolis	2023-10-09 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219407110	f	\N	\N	\N
5737	Bidco United	Bandari FC (Kenya)	2023-10-09 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219452315	f	\N	\N	\N
5738	Muhoroni Youth FC	KCB	2023-10-09 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219452405	f	\N	\N	\N
5739	MS Tzeirey Kfar Kana	Ironi Nesher	2023-10-09 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219417308	f	\N	\N	\N
2695	Havant and W	Hampton and Richmond	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112646	f	\N	\N	\N
4216	Concord Rangers	Hythe Town	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219381051	f	\N	\N	\N
2723	Dover	Taunton Town	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219112466	f	\N	\N	\N
2763	Fylkir	Fram	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219110718	f	\N	\N	\N
2688	IF Karlstad	FC Stockholm Internazionale	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219106967	f	\N	\N	\N
2714	Solihull Moors	Aldershot	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219094540	f	\N	\N	\N
2775	Ujpest	Diosgyori	2023-10-07 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219069573	f	\N	\N	\N
2807	Al-Qadsia	Al Arabi Kuwait	2023-10-07 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219325470	f	\N	\N	\N
3430	Villarreal CF III	Castellon B	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219335391	f	\N	\N	\N
4380	Riteriai	Hegelmann Litauen	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219329968	f	\N	\N	\N
3398	Sestao River	Cornella	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219168704	f	\N	\N	\N
4389	Eyupspor	Bodrum B B	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219376791	f	\N	\N	\N
3420	Ispartaspor	Iskenderunspor	2023-10-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219325379	f	\N	\N	\N
2699	Racing Genk B	Kfco Beerschot Wilrijk	2023-10-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219110268	t	0	\N	136
2618	Augsburg	SV Darmstadt	2023-10-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218722143	t	0	3	1
5740	Nogoom El Mostakbal	Olympic El Qanal	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219449129	f	\N	\N	\N
2932	St Gallen	Stade Lausanne-Ouchy	2023-10-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219147084	t	2	\N	15
4591	Atletico Chiriqui	CD Universitario	2023-10-08 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219406274	f	\N	\N	\N
4601	CA Rentistas	Progreso	2023-10-08 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219407017	f	\N	\N	\N
4602	Escorpiones FC	Limon Black Star	2023-10-08 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219403024	f	\N	\N	\N
4614	A.D. Cofutpa	AD Carmelita	2023-10-08 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219403114	f	\N	\N	\N
3604	Honda Lock	Suzuka Unlimited	2023-10-08 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219367985	f	\N	\N	\N
3023	FC Tiamo Hirakata	Veertien Kuwana	2023-10-08 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219352250	f	\N	\N	\N
4637	Matsumoto	Grulla Morioka	2023-10-08 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219121903	f	\N	\N	\N
4638	Kitakyushu	Toyama	2023-10-08 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219121081	f	\N	\N	\N
4639	Jef Utd Chiba	Mito	2023-10-08 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219081325	f	\N	\N	\N
4640	FC Gifu	Azul Claro Numazu	2023-10-08 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219120811	f	\N	\N	\N
4641	FC Machida	Kofu	2023-10-08 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219081416	f	\N	\N	\N
4642	Yamagata	Tochigi SC	2023-10-08 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219081596	f	\N	\N	\N
4643	Nagano Parceiro	Vanraure Hachinohe	2023-10-08 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219120721	f	\N	\N	\N
4644	Kanazawa	Blaublitz Akita	2023-10-08 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219081235	f	\N	\N	\N
4645	Iwaki SC	Sendai	2023-10-08 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219081506	f	\N	\N	\N
4646	Ulsan Hyundai Horang-i	Incheon Utd	2023-10-08 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219083606	f	\N	\N	\N
4647	Daejeon Citizen	Jeju Utd	2023-10-08 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219088997	f	\N	\N	\N
4648	Daegu FC	Suwon FC	2023-10-08 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219083743	f	\N	\N	\N
5741	CS Tunari	FC Hunedoara	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219249559	f	\N	\N	\N
4649	Ehime	Tegevajaro Miyazaki	2023-10-08 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219121797	f	\N	\N	\N
4651	Suwon Bluewings	Pohang Steelers	2023-10-08 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219083490	f	\N	\N	\N
4652	Gwangju FC	Gangwon	2023-10-08 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219089107	f	\N	\N	\N
4653	Kawasaki	Fukuoka	2023-10-08 07:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218964555	f	\N	\N	\N
4654	HK U23	Kitchee SC	2023-10-08 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219382695	f	\N	\N	\N
4655	Mlada Boleslav B	FK Chlumec	2023-10-08 08:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219407989	f	\N	\N	\N
4656	Hradec Kralove B	Slovan Liberec B	2023-10-08 08:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219407899	f	\N	\N	\N
4657	Admira Prague	FK Dukla Praha B	2023-10-08 08:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219407719	f	\N	\N	\N
4658	Pardubice B	TJ Slovan Velvary	2023-10-08 08:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219408079	f	\N	\N	\N
4659	FC Fastav Zlin B	MFK Karvina B	2023-10-08 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219407809	f	\N	\N	\N
4660	Persijap Jepara	Persekat Kabupaten Tegal	2023-10-08 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391341	f	\N	\N	\N
4661	Sriwijaya	PSPS Pekanbaru	2023-10-08 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390978	f	\N	\N	\N
4662	Gresik United	Persipa Pati	2023-10-08 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391159	f	\N	\N	\N
4663	PSM Makassar	Madura Utd	2023-10-08 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219354247	f	\N	\N	\N
4664	Slavia Praha B	Bohemians 1905 B	2023-10-08 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219408175	f	\N	\N	\N
4665	Karo United	PSDS Deli Serdang	2023-10-08 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219390797	f	\N	\N	\N
4666	FC Liefering	Admira Wacker	2023-10-08 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219068583	f	\N	\N	\N
4667	Malzenice	Slovan Bratislava II	2023-10-08 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219253556	f	\N	\N	\N
4668	Sparta Prague B	H Slavia Kromeriz	2023-10-08 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219120631	f	\N	\N	\N
4669	CSC 1599 Selimbar	Unirea Slobozia	2023-10-08 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219249921	f	\N	\N	\N
4670	1. FSV Mainz 05 U19	Kaiserslautern U19	2023-10-08 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219403297	f	\N	\N	\N
4671	SD Formentera	Club Atletico Saguntino	2023-10-08 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219237266	f	\N	\N	\N
4672	Real Murcia B	Lorca Deportiva CF	2023-10-08 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389889	f	\N	\N	\N
4673	Union Molinense CF	CD Algar	2023-10-08 10:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219389799	f	\N	\N	\N
4674	Kohtla-Jarve	Viimsi JK	2023-10-08 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219357823	f	\N	\N	\N
4675	Trival Valderas	Alcala RSD	2023-10-08 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219391068	f	\N	\N	\N
4676	FC Tallinn	FC Elva	2023-10-08 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219357937	f	\N	\N	\N
4677	Real Zaragoza II	UD Logrones	2023-10-08 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219236636	f	\N	\N	\N
4678	Poli Ejido	Almeria B	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390429	f	\N	\N	\N
4679	Egersund	Notodden	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219292757	f	\N	\N	\N
4680	CD Coria	CF Trujillo	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388791	f	\N	\N	\N
4681	Gran Pena FC	UD Ourense	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219392149	f	\N	\N	\N
4682	CD Alaves B	Athletic Bilbao B	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219237086	f	\N	\N	\N
4683	Mafra	Leiria	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219163597	f	\N	\N	\N
4684	Girona FC II	CF Montanesa	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391789	f	\N	\N	\N
4685	SS Reyes	Gimnastica Segoviana CF	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219265193	f	\N	\N	\N
4686	Thespakusatsu Gunma	Okayama	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219089991	f	\N	\N	\N
4687	Coria CF	Xerez Deportivo FC	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390249	f	\N	\N	\N
4688	AD Union Adarve	Cacereno	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219265283	f	\N	\N	\N
4689	Numancia	CD Badajoz	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219265103	f	\N	\N	\N
4690	Guadalajara	Talavera CF	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219265013	f	\N	\N	\N
4691	Las Rozas CF	AD Parla	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390888	f	\N	\N	\N
4692	Prat	CP San Cristobal	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391699	f	\N	\N	\N
4693	Racing Rioja CF	Club Haro Deportivo	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388429	f	\N	\N	\N
4694	CE Andratx	La Nucia	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219236456	f	\N	\N	\N
4695	Arenas Armilla	CD Atletico Melilla	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390614	f	\N	\N	\N
4696	Linares Deportivo	AD Ceuta FC	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219198578	f	\N	\N	\N
4697	Mar Menor CF	Manchego Ciudad Real	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219250419	f	\N	\N	\N
4698	CD Berceo	Comillas	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388609	f	\N	\N	\N
4699	Melilla UD	Intercity Sant Joan C.F	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219196953	f	\N	\N	\N
4700	Torrent CF	UD Alzira	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219236006	f	\N	\N	\N
4701	Brondby (W)	Kolding IF (W)	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219359562	f	\N	\N	\N
4702	UCAM Murcia	FC La Union Atletico	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219250196	f	\N	\N	\N
4703	Pena Balsamaiso	Anguiano	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388519	f	\N	\N	\N
4704	SD Eibar (W)	UDG Tenerife Sur (W)	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362330	f	\N	\N	\N
4705	El Palo	CA Antoniano	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219250105	f	\N	\N	\N
4706	Obolon-Brovar Kiev	Metalist 1925	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219146760	f	\N	\N	\N
4707	FS METTA/LU	SK Super Nova	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219232572	f	\N	\N	\N
4708	San Roque Lepe	Aguilas	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219250014	f	\N	\N	\N
4709	Velez CF	Betis B	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219250286	f	\N	\N	\N
4710	Lleida	Santa Eulalia	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219237356	f	\N	\N	\N
4711	SE Penya Independent	Hercules	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219235916	f	\N	\N	\N
4712	Aviles Stadium CF	Caudal Deportivo	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219392059	f	\N	\N	\N
4713	Real Union	CA Tarazona	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219169064	f	\N	\N	\N
4714	CD Calamonte	CF Jaraiz	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389169	f	\N	\N	\N
4715	Atletico Baleares	Real Murcia	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219198758	f	\N	\N	\N
4716	Sevilla B	Yeclano Deportivo	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219250641	f	\N	\N	\N
4717	Valladolid B	Marino Luanco	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219233092	f	\N	\N	\N
4718	Cordoba B	Conil FC	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390339	f	\N	\N	\N
4719	Rapitenca	FE Grama	2023-10-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391609	f	\N	\N	\N
4721	Heerenveen (W)	ADO Den Haag (W)	2023-10-08 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219360300	f	\N	\N	\N
4722	AC Monza	Salernitana	2023-10-08 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218931389	f	\N	\N	\N
4723	Keciorengucu	Tuzlaspor	2023-10-08 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219098817	f	\N	\N	\N
4724	Esan Pattaya	Nakhon Ratchasima	2023-10-08 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219360390	f	\N	\N	\N
4725	Khonkaen United	Muangthong Utd	2023-10-08 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219342944	f	\N	\N	\N
4726	SSD Fiorentina WFC (W)	Napoli Calcio (W)	2023-10-08 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219403477	f	\N	\N	\N
4727	RC Villalbes	CD Covadonga	2023-10-08 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219233272	f	\N	\N	\N
4728	Slask Wroclaw	Gornik Zabrze	2023-10-08 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218838860	f	\N	\N	\N
4729	Rizespor	Samsunspor	2023-10-08 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218903876	f	\N	\N	\N
4730	LKP Motor Lublin	Miedz Legnica	2023-10-08 11:40:00	https://www.orbitxch.com/customer/sport/1/market/1.218992824	f	\N	\N	\N
4731	CD Marino	UD Tamaraceite	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389979	f	\N	\N	\N
4732	Fremad Amager	Brabrand	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219361620	f	\N	\N	\N
4733	BFC Dynamo	FSV 63 Luckenwalde	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273361	f	\N	\N	\N
4734	UD San Fernando	CDE Ursaria	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219265397	f	\N	\N	\N
4736	Betis (W)	Levante UD (W)	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362150	f	\N	\N	\N
4737	St Mirren	Rangers	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218712997	f	\N	\N	\N
4738	Marseille	Le Havre	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218809235	f	\N	\N	\N
4739	Buriram Utd	Chonburi	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219343034	f	\N	\N	\N
4740	Samgurali Tskaltubo	FC Shukura Kobuleti	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219361530	f	\N	\N	\N
4741	Charlton (W)	Durham (W)	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388881	f	\N	\N	\N
4742	Naestved	Hobro	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219125452	f	\N	\N	\N
4743	MOL Vidi	MTK Budapest	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218951656	f	\N	\N	\N
4744	Brighton (W)	West Ham United (W)	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219264544	f	\N	\N	\N
4746	Man City (W)	Chelsea (W)	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219264724	f	\N	\N	\N
4748	1461 Trabzon	Van Buyuksehir Belediyespor	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219366247	f	\N	\N	\N
4749	Paide Linnameeskond	Harju JK Laagri	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219172606	f	\N	\N	\N
4752	Adiyamanspor	Altinordu	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219366337	f	\N	\N	\N
4755	Nomme Utd	Tabasalu JK	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219361440	f	\N	\N	\N
4756	Meuselwitz	Chemie Leipzig	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219272911	f	\N	\N	\N
4757	Chiang Mai	Nakhon Si United F.C.	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219361350	f	\N	\N	\N
4758	Lubeck	Freiburg II	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219201433	f	\N	\N	\N
4759	FK Siauliai	FK Dainava Alytus	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219298131	f	\N	\N	\N
4745	Trelleborgs	GAIS	2023-10-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219166892	t	2	\N	336
4753	Waasland-Beveren	Zulte-Waregem	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219394042	t	2	\N	136
4754	Standard	Club Brugge	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219109911	t	1	\N	68
4747	Holstein Kiel	Elversberg	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218825995	t	1	\N	93
4751	Schalke 04	Hertha Berlin	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218797764	t	1	3	93
4750	Braunschweig	Paderborn	2023-10-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218825887	t	2	\N	93
4760	Sollentuna FF	Bodens	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219294781	f	\N	\N	\N
4761	IFK Mariehamn	Lahti	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219104003	f	\N	\N	\N
4762	Greuther Furth II	FC Memmingen	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219272515	f	\N	\N	\N
4763	FK Struga Trim-Lum	FK Sileks	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362690	f	\N	\N	\N
4764	Vardar Skopje	Shkendija	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362600	f	\N	\N	\N
4765	Esbjerg	HIK Hellerup	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362780	f	\N	\N	\N
4766	Glasgow City (W)	Spartans WFC (W)	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219392240	f	\N	\N	\N
4768	Stuttgart II	Mainz II	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273993	f	\N	\N	\N
4769	Zonguldakspor	Mersin Idman Yurdu	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219366157	f	\N	\N	\N
4770	Villarreal	Las Palmas	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218951977	f	\N	\N	\N
4772	Reading (W)	Lewes (W)	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389061	f	\N	\N	\N
4773	Tarsus Idman Yurdu	Arguvan	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219404017	f	\N	\N	\N
4774	Viven Bornova FK	Fatsa Belediyespor	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219408373	f	\N	\N	\N
4775	TSV Schott Mainz	Aalen	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273903	f	\N	\N	\N
4776	Etimesgut Belediyespor	Duzcespor	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219366697	f	\N	\N	\N
4777	Karaman Belediyespor	Usakspor	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219366787	f	\N	\N	\N
4778	Kastamonuspor	Somaspor Spor Kulubu	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219366517	f	\N	\N	\N
4779	Rayong FC	Ayutthaya United	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362420	f	\N	\N	\N
4780	Bhayangkara FC	Bali Utd Pusam	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219363050	f	\N	\N	\N
4781	Nuova Monterosi	Casertana	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219290727	f	\N	\N	\N
4782	Persita Tangerang	Persik Kediri	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362960	f	\N	\N	\N
4783	Montrose FC (W)	Hearts (W)	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219392543	f	\N	\N	\N
4784	Amorebieta	Eibar	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219252561	f	\N	\N	\N
4785	Hoffenheim II	TSG Balingen	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273543	f	\N	\N	\N
4786	Kepez Belediyespor	Inegol Kafkas Genclikspor	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219369521	f	\N	\N	\N
4787	SV Turkgucu-Ataspor	Bayreuth	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219272695	f	\N	\N	\N
4788	FSV Zwickau	Chemnitzer	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219273181	f	\N	\N	\N
4789	Levanger	Tromsdalen	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219292850	f	\N	\N	\N
4790	Bangkok Utd	Chiangrai Utd	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219343124	f	\N	\N	\N
4791	Teutonia 05 Ottensen	Eimsbutteler	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219271353	f	\N	\N	\N
4792	CSF Spartanii	FC Floresti	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362510	f	\N	\N	\N
4793	Aarau	Bellinzona	2023-10-08 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219122115	f	\N	\N	\N
4794	Etar	Hebar	2023-10-08 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219172155	f	\N	\N	\N
4797	Turgutluspor	ANADOLU UNIVERSITY	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219368877	f	\N	\N	\N
4798	FK Sumqayit	Kapaz Ganja	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219263139	f	\N	\N	\N
4799	Inegolspor	Menemen Belediyespor	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219366427	f	\N	\N	\N
4800	Sapanca Genclikspor	Yeni Altindag B	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219368967	f	\N	\N	\N
4801	Darica Genclerbirligi	Karbel Karakopru	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219369235	f	\N	\N	\N
4802	LASK Linz	SCR Altach	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218764540	f	\N	\N	\N
4804	Ayvalikgucu Belediyespor	Kucukcekmece Sinop Spor	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219369666	f	\N	\N	\N
4805	Ajax	Az Alkmaar	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218765859	t	1	3	196
4806	Cardiff Metropolitan (W)	Aberystwyth Town (W)	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219393528	f	\N	\N	\N
4807	The New Saints (W)	Barry Town (W)	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219393438	f	\N	\N	\N
4810	BVSC Zuglo	Gyirmot	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219174381	f	\N	\N	\N
4796	Fortuna Sittard	FC Twente	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218766399	t	1	3	196
4808	VPS	HJK Helsinki	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219104093	f	\N	\N	\N
4803	Wolfsberger AC	Sturm Graz	2023-10-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218764864	t	1	3	43
4812	Orgryte	Utsiktens	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219166802	f	\N	\N	\N
4811	Celtic (W)	Motherwell (W)	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219392634	f	\N	\N	\N
4795	Lugano	Servette	2023-10-08 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219103580	t	1	1	15
4809	Lyon	Lorient	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218751055	t	2	\N	5
4813	Sundsvall	IK Brage	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219167072	t	1	3	336
4767	Vejle	Hvidovre	2023-10-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219115518	t	2	\N	40
6123	Bogota	Cortulua	2023-10-11 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219472255	f	\N	\N	\N
4814	Asane	Fredrikstad	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096430	t	2	\N	204
4837	Bremer SV	VfB Oldenburg	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219271443	f	\N	\N	\N
4827	Kozarmisleny	Vasas	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219174471	f	\N	\N	\N
4820	Cf Os Belenenses	Maritimo	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219111636	f	\N	\N	\N
4834	NK Croatia Zmijavci	Sibenik	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219263448	f	\N	\N	\N
4833	Birmingham (W)	Sunderland (W)	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389442	f	\N	\N	\N
4826	Csakvar	FC Ajka	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219174291	f	\N	\N	\N
4819	Ranheim IL	Jerv	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096160	f	\N	\N	\N
4853	Cracovia Krakow	Jagiellonia Bialystock	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218838680	f	\N	\N	\N
4844	KuPS	Honka	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219106263	f	\N	\N	\N
4841	FK Radnicki 1923	Crvena Zvezda	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219362870	f	\N	\N	\N
4822	West Ham	Newcastle	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218751217	t	1	4	2
4847	Honved	MTE 1904	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219174561	f	\N	\N	\N
4817	Watford (W)	Southampton (W)	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389259	f	\N	\N	\N
4843	Frosinone	Verona	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218998597	t	1	3	4
4846	Ghazl El Mahallah	Abo Qair Semads	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219383390	f	\N	\N	\N
4838	Haras El Hodood	Telecom Egypt SC	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219383482	f	\N	\N	\N
4852	Tottenham (W)	Bristol City (W)	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219264814	f	\N	\N	\N
4836	Domzale	NK Rogaska	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219115787	f	\N	\N	\N
4830	Sassuolo (W)	Inter Milan (W)	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219404467	f	\N	\N	\N
4840	Gosk Gabela	Borac Banja Luka	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365004	f	\N	\N	\N
4823	Wolves	Aston Villa	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218751478	t	0	\N	2
4825	Avion Academy FC	Fovu Club de Baham	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219394345	f	\N	\N	\N
4848	Siofok	Soroksar	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219174741	f	\N	\N	\N
4854	Otelul Galati	Farul Constanta	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218886607	f	\N	\N	\N
4832	Hradec Kralove	Sparta Prague	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218850904	f	\N	\N	\N
4818	Montpellier	Clermont	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218751297	t	2	\N	5
4849	Varnamo	Norrkoping	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219007323	f	\N	\N	\N
4821	Adanaspor	Giresunspor	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219163957	f	\N	\N	\N
4815	Lokomotiva	HNK Gorica	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219106022	f	\N	\N	\N
4850	Boluspor	Goztepe	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219148428	f	\N	\N	\N
4851	Blackburn Rovers (W)	Crystal Palace (W)	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389709	f	\N	\N	\N
4842	Tiszakecske VSE	Pecs MFC	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219174651	f	\N	\N	\N
4828	Lazio	Atalanta	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218930819	f	\N	\N	\N
4835	Start	Kongsvinger	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096250	t	1	3	204
4839	Brommapojkarna	Elfsborg	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219007142	t	0	3	14
4845	Besiktas	Istanbulspor	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218904200	f	\N	\N	\N
4863	Panevezys	VMFD Zalgiris	2023-10-08 14:55:00	https://www.orbitxch.com/customer/sport/1/market/1.219298237	f	\N	\N	\N
4829	Kalmar FF	Malmo FF	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219003507	t	0	1	14
4824	Brest	Toulouse	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218751558	t	1	\N	5
4861	Brattvag	Fram Larvik	2023-10-08 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219270543	f	\N	\N	\N
4859	Sekhukhune United	Polokwane City	2023-10-08 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219298442	f	\N	\N	\N
4860	Leverkusen	FC Koln	2023-10-08 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218722503	f	\N	\N	\N
4862	Cork City	St Patricks	2023-10-08 14:40:00	https://www.orbitxch.com/customer/sport/1/market/1.219163237	f	\N	\N	\N
4864	Sandvikens	Dalkurd FF	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219294875	f	\N	\N	\N
4869	Sotra SK	Junkeren	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219270363	f	\N	\N	\N
4831	KFUM Oslo	Bryne	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219096340	t	0	1	204
4868	AB Argir	Klaksvikar Itrottarfelag	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365476	f	\N	\N	\N
4872	Aberdeen	St Johnstone	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218713213	f	\N	\N	\N
4865	Granada B	Alcoyano	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219197316	f	\N	\N	\N
4816	Brighton	Liverpool	2023-10-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218751739	t	2	\N	2
4871	Patacona CF	Silla CF	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391344	f	\N	\N	\N
4867	Leicester City (W)	Everton (W)	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219264364	f	\N	\N	\N
4866	Antwerp	Eupen	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219104330	t	2	\N	68
6167	Bolivia	Ecuador	2023-10-13 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218300588	f	\N	\N	\N
4878	Al Arabi (Jor)	Al-Jazeera	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219404557	f	\N	\N	\N
4881	B36 Torshavn	07 Vestur	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365797	f	\N	\N	\N
4884	Breidablik	Stjarnan	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219181132	f	\N	\N	\N
4873	Jeunesse D'Esch	F91 Dudelange	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365386	f	\N	\N	\N
4875	Platense (W)	UAI Urquiza (W)	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365617	f	\N	\N	\N
4874	Swift Hesperange	UN Kaerjeng 97	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365296	f	\N	\N	\N
4885	Gagra	FC Telavi	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365977	f	\N	\N	\N
4880	B68 Toftir	Vikingur Gota	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365887	f	\N	\N	\N
4886	Leonesa	CF Rayo Majadahonda	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219169154	f	\N	\N	\N
4892	Catania	US Latina Calcio	2023-10-08 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219290455	f	\N	\N	\N
4883	ES Metlaoui	CA Bizertin	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219365206	f	\N	\N	\N
4891	Stomil Olsztyn	Olimpia Elblag	2023-10-08 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219408463	f	\N	\N	\N
4887	Spezia	Pisa	2023-10-08 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219139407	f	\N	\N	\N
4890	Como	US Cremonese	2023-10-08 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219121691	f	\N	\N	\N
4893	Valladolid	Mirandes	2023-10-08 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219252109	f	\N	\N	\N
4889	Atletico Madrid	Real Sociedad	2023-10-08 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218952219	f	\N	\N	\N
4888	Crotone	AZ Picerno ASD	2023-10-08 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219290196	f	\N	\N	\N
4903	Casa Pia	Club Football Estrela	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219121336	f	\N	\N	\N
4901	Famalicao	Guimaraes	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219121552	f	\N	\N	\N
4897	CDA Navalcarnero	CD Illescas	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219265495	f	\N	\N	\N
4895	Bamboutos FC de Mbouda	Gazelle de Garoua	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219394435	f	\N	\N	\N
4876	Brondby	Viborg	2023-10-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219110019	t	0	1	40
4904	Madrid (W)	Granada (W)	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219362240	f	\N	\N	\N
4906	SC Telstar (W)	FC Utrecht (W)	2023-10-08 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219404647	f	\N	\N	\N
4899	Lausanne	Luzern	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219146436	f	\N	\N	\N
4896	Mumbai City FC	Kerala Blasters FC	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219106662	f	\N	\N	\N
4902	UD Santa Marta	SD Atletico Tordesillas	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219390706	f	\N	\N	\N
4894	Hallescher FC	Preussen Munster	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219201343	f	\N	\N	\N
4900	Ferencvaros	DEBRECENI VSC	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218951866	f	\N	\N	\N
4907	CSKA 1948 Sofia	Botev Plovdiv	2023-10-08 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219105536	f	\N	\N	\N
4926	Tromso	Aalesunds	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218861456	t	1	\N	13
4909	Lautaro de Buin	CD Trasandino	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219408556	f	\N	\N	\N
4914	Orn Horten	Traeff	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219270273	f	\N	\N	\N
4908	Deportes Limache	Fernandez Vial	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219413588	f	\N	\N	\N
4917	Haugesund	Stromsgodset	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218861780	f	\N	\N	\N
4919	UC Ceares	Tuilla	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391879	f	\N	\N	\N
4898	Young Boys	FC Basel	2023-10-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219103363	t	2	\N	15
4910	CD Izarra	Utebo CF	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219236276	f	\N	\N	\N
4920	UD Castellonense	Ontinyent CF	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391249	f	\N	\N	\N
4922	Dundee United (W)	Aberdeen (W)	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219392724	f	\N	\N	\N
4923	Haladas	Szeged 2011	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219194194	f	\N	\N	\N
4924	CD Cayon	Real Aviles	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219233182	f	\N	\N	\N
4925	UP Langreo	SD Rayo Cantabria	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219233634	f	\N	\N	\N
4913	Cadiz B	Marbella	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219250770	f	\N	\N	\N
4927	Sheriff Tiraspol	CS Petrocub	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219367144	f	\N	\N	\N
4905	Sparta Rotterdam	PSV	2023-10-08 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218765643	t	0	4	196
4912	Linense	CD Estepona	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219250860	f	\N	\N	\N
4911	CC Riadi Salmi	FUS Rabat	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219367234	f	\N	\N	\N
4916	Les Astres FC de Douala	Dynamo Douala	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219394525	f	\N	\N	\N
4918	CD Soneja	CD Acero	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391519	f	\N	\N	\N
4928	Molde	Bodo Glimt	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218861672	t	2	\N	13
4915	Coruxo	Pontevedra CF	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219233814	f	\N	\N	\N
4921	Austria Klagenfurt	Red Bull Salzburg	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218764756	t	2	\N	43
9802	CD Castellon	Atletico Madrid II	2023-10-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219865165	f	\N	\N	\N
4960	Juventud Torremolinos	Polideportivo Almeria	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390522	f	\N	\N	\N
4961	Municipal Turrialba	AD Aserri	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219403204	f	\N	\N	\N
4937	Gyori	Budafoki	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219174110	f	\N	\N	\N
4941	CD Cantolagua	SD Lagunak	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388700	f	\N	\N	\N
4938	Erokspor A.S	Diyarbekirspor	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219366067	f	\N	\N	\N
4934	Sabadell	Fuenlabrada	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219169244	f	\N	\N	\N
4942	CDFC La Calzada	CD Varea	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388333	f	\N	\N	\N
4939	Hibernian (W)	Partick Thistle (W)	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219392442	f	\N	\N	\N
4944	Lens	Lille	2023-10-08 16:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218750916	t	\N	\N	\N
4935	Muleno	CD Bullense	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389443	f	\N	\N	\N
4952	Hammarby	Hacken	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219007052	t	1	4	14
4930	Deportiva Minera	Cieza	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389619	f	\N	\N	\N
4929	CD Tedeon	CD Arnedo	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388240	f	\N	\N	\N
4940	CD Calahorra	Tudelano	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219236546	f	\N	\N	\N
4959	Arsenal	Man City	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218750746	t	0	1	2
4945	Hamilton WFC (W)	Rangers (W)	2023-10-08 16:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219392346	f	\N	\N	\N
4946	Dinamo Zagreb	NK Istra	2023-10-08 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219105716	f	\N	\N	\N
4949	Legia Warsaw	Rakow Czestochowa	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218838500	f	\N	\N	\N
4951	Deportes Copiapo	Magallanes	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219063093	f	\N	\N	\N
4956	Cukaricki	Vozdovac	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219367715	f	\N	\N	\N
4932	Sandefjord	Ham-Kam	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218861996	t	0	1	13
4955	FK Buducnost Podgorica	Rudar Pljevlja	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219368075	f	\N	\N	\N
4954	RCP Valverdeno	Jerez CF	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219388971	f	\N	\N	\N
4933	Sarpsborg	Rosenborg	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218861348	t	1	7	13
4950	Dunajska Streda	Podbrezova	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219002931	f	\N	\N	\N
4958	Neftchi Baku	Qarabag Fk	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219263229	f	\N	\N	\N
4947	Olimpija	NK Radomlje	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219111168	f	\N	\N	\N
4948	Varbergs BoIS	Djurgardens	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219007232	f	\N	\N	\N
4953	Bayern Munich	Freiburg	2023-10-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218722383	t	2	\N	1
4976	FC Saburtalo Tbilisi	Dinamo Batumi	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219368165	f	\N	\N	\N
4973	Zaglebie Sosnowiec	Polonia Warszawa	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218992734	f	\N	\N	\N
4968	Fethiyespor	Denizlispor	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219366607	f	\N	\N	\N
4967	Erzincanspor	Sariyer G.K.	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219366877	f	\N	\N	\N
4970	UE Sant Andreu	Terrassa	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219236096	f	\N	\N	\N
4972	Ciudad Lucena	Puente Genil FC	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390159	f	\N	\N	\N
4964	Plaza Colonia	Danubio	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219120180	f	\N	\N	\N
4969	Al Ahly Cairo	Ismaily	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219178409	f	\N	\N	\N
4984	DUKLA BANSKA BYSTRICA	Spartak Trnava	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219003873	f	\N	\N	\N
4978	Al Riffa	Al-Muharraq	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219367895	f	\N	\N	\N
4962	AD San Juan	SD Gernika Club	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219236366	f	\N	\N	\N
4981	Kasimpasa	Fenerbahce	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218903660	f	\N	\N	\N
4977	Slovan Bratislava	Trencin	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219006872	f	\N	\N	\N
4975	Altay	Umraniyespor	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219163867	f	\N	\N	\N
4979	Slovan Liberec	Slavia Prague	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218850418	f	\N	\N	\N
4974	Pyramids	ENPPI	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219110448	f	\N	\N	\N
4983	Partizani Tirana	FK Kukesi	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219407542	f	\N	\N	\N
4966	Club Atletico Pulpileno	Montecasillas FC	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219389349	f	\N	\N	\N
4982	Barakaldo	Naxara CD	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219236816	f	\N	\N	\N
4971	Cagliari	Roma	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218998357	f	\N	\N	\N
4963	FK Dubocica	FK Vrsac	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219409756	f	\N	\N	\N
4980	Hatayspor	Konyaspor	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218903462	f	\N	\N	\N
4965	Atletico Madrid II	San Fernando CD	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219198398	f	\N	\N	\N
4943	Luarca CF	CD Llanes	2023-10-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219391969	f	\N	\N	\N
5006	Porto B	Torreense	2023-10-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219163687	f	\N	\N	\N
9805	Mura	Koper	2023-10-22 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219505673	f	\N	\N	\N
5015	Lierse	Deinze	2023-10-08 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219110358	t	1	1	136
4985	Xerez CD	AD Cartaya	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219390069	f	\N	\N	\N
4988	GKS Katowice	Nieciecza	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218992461	f	\N	\N	\N
4990	Cerdanyola del Valles	CE Europa	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219236186	f	\N	\N	\N
4998	CF Badalona Futur	Valencia-Mestalla	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219239702	f	\N	\N	\N
4991	Siroki Brijeg	FK Igman Konjic	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219368398	f	\N	\N	\N
4995	Orihuela CF	FC Cartagena II	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219250950	f	\N	\N	\N
4996	Alaves	Betis	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218951767	f	\N	\N	\N
5001	Racing de Ferrol	FC Cartagena	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219252379	f	\N	\N	\N
5005	Celta Vigo	Getafe	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218952430	f	\N	\N	\N
5007	Benfica B	Feirense	2023-10-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219111078	f	\N	\N	\N
4997	Tenerife	Burgos	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219252019	f	\N	\N	\N
4992	ASD Pineto Calcio	Pontedera	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219263790	f	\N	\N	\N
4999	FC Giugliano	Taranto Sport	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219290365	f	\N	\N	\N
5004	Gent	Genk	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219109695	f	\N	\N	\N
5000	Spal	Pescara	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219264150	f	\N	\N	\N
4994	AP Turris Calcio	Francavilla Calcio	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219290814	f	\N	\N	\N
5003	Barcelona (W)	Real Sociedad (W)	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219361970	f	\N	\N	\N
5002	AEK Athens	Panaitolikos	2023-10-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218953436	f	\N	\N	\N
5009	Tecos FC	Mexicali FC	2023-10-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219359440	f	\N	\N	\N
4989	Midtjylland	Randers	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219110127	t	1	4	40
5010	Deportivo	Celta Vigo B	2023-10-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219169334	f	\N	\N	\N
5016	RSB Berkane	Yous Berrechid	2023-10-08 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219393165	f	\N	\N	\N
5012	Club R Zemamra	Olympic Safi	2023-10-08 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219393255	f	\N	\N	\N
5011	Ludogorets	Pirin Blagoevgrad	2023-10-08 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219171943	f	\N	\N	\N
5013	Sint Truiden	Union St Gilloise	2023-10-08 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219109803	f	\N	\N	\N
5008	Porto	Portimonense	2023-10-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219121444	t	1	1	8
5021	Liverpool (W)	Aston Villa (W)	2023-10-08 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219264454	f	\N	\N	\N
5019	Ingolstadt	Jahn Regensburg	2023-10-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219201252	f	\N	\N	\N
5017	Union Santa Fe	Sarmiento de Junin	2023-10-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218833843	f	\N	\N	\N
5014	Valerenga	Brann	2023-10-08 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218861888	t	2	\N	13
5018	Instituto	Gimnasia La Plata	2023-10-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218833933	f	\N	\N	\N
5029	Zitacuaro CF	Club Deportivo Ayense	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219410398	f	\N	\N	\N
5031	Palestino	Colo Colo	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063183	f	\N	\N	\N
5027	Atletico Grau	Alianza Atletico	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219171753	f	\N	\N	\N
5032	CA Osasuna II	Lugo	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219169424	f	\N	\N	\N
5025	AGF	FC Copenhagen	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219111803	f	\N	\N	\N
5034	Koper	NK Aluminij	2023-10-08 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219114489	f	\N	\N	\N
5024	El Nacional	Mushuc Runa	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219111530	f	\N	\N	\N
5030	Sociedad B	Barcelona B	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219169515	f	\N	\N	\N
5028	Puebla FC (W)	Santos Laguna (W)	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219372082	f	\N	\N	\N
5022	San Martin de Tucuman	Almirante Brown	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219188984	f	\N	\N	\N
5033	Recreativo Huelva	Malaga	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219198488	f	\N	\N	\N
5023	Toluca	Queretaro	2023-10-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219101561	f	\N	\N	\N
5037	Boston River	Deportivo Maldonado	2023-10-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219120540	f	\N	\N	\N
5039	Deportivo Riestra	Ferro Carril Oeste	2023-10-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219189434	f	\N	\N	\N
5020	Eintracht Frankfurt	FC Heidenheim	2023-10-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218722023	t	1	2	1
5036	Sarajevo	Zeljeznicar	2023-10-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219372388	f	\N	\N	\N
5038	Defensores Unidos	Flandria	2023-10-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219188714	f	\N	\N	\N
5035	Panathinaikos	Atromitos	2023-10-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218953526	f	\N	\N	\N
5040	Dinamo Bucharest	CFR Cluj	2023-10-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218886787	f	\N	\N	\N
4986	Al Khalidiyah	Al Ahli (BRN)	2023-10-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219367805	f	\N	\N	\N
5044	Fiorenzuola	Pergolettese	2023-10-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219263970	f	\N	\N	\N
5057	Granada	Barcelona	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218952099	t	2	\N	3
5047	CD General Velasquez	Deportes Melipilla	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219409940	f	\N	\N	\N
5043	Napoli	Fiorentina	2023-10-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218931179	t	2	\N	4
5046	USD Sestri Levante 1919	Juventus B	2023-10-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219264240	f	\N	\N	\N
5054	Lyon (W)	Bordeaux (W)	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219368255	f	\N	\N	\N
5048	Club Deportivo Sur Car	CD Municipal Tarija	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219402757	f	\N	\N	\N
5056	Always Ready	Atletico Palmaflor Vinto	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219312175	f	\N	\N	\N
5060	Brusque FC	EC Sao Jose Porto Alegre	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219409850	f	\N	\N	\N
5053	Club Cipolletti	CA Germinal	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219371900	f	\N	\N	\N
5050	Operario PR	Sao Bernardo	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219311902	f	\N	\N	\N
5051	Internacional	Gremio	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218772064	f	\N	\N	\N
5055	Villa Mitre	Olimpo	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219371992	f	\N	\N	\N
5058	Fluminense	Botafogo	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218772184	f	\N	\N	\N
5061	Gimnasia Conc del Uruguay	Club Defensores de P	2023-10-08 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219374436	f	\N	\N	\N
5059	SE Palmeiras	Santos	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218771824	f	\N	\N	\N
5045	Rennes	Paris St-G	2023-10-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218750475	t	2	\N	5
5052	Zaragoza	Alcorcon	2023-10-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219251928	f	\N	\N	\N
5065	Huracan Las Heras	Ciudad de Bolivar	2023-10-08 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219374616	f	\N	\N	\N
5064	Raja Casablanca	Moghreb Tetouan	2023-10-08 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219393348	f	\N	\N	\N
5062	CA Douglas Haig	Def Belgrano VR	2023-10-08 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219374526	f	\N	\N	\N
5063	Sporting Lisbon	Arouca	2023-10-08 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219115734	f	\N	\N	\N
5066	River Plate	Talleres	2023-10-08 20:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218834239	f	\N	\N	\N
5067	Chacarita	Estudiantes de Caseros	2023-10-08 20:50:00	https://www.orbitxch.com/customer/sport/1/market/1.219188084	f	\N	\N	\N
5072	PFA Antioquia FC	Quepos Cambute	2023-10-08 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219402937	f	\N	\N	\N
5068	San Martin de Mendoza	Sportivo Penarol	2023-10-08 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219381840	f	\N	\N	\N
5074	Asociacion Deportiva Tarma	Union Comercio	2023-10-08 21:20:00	https://www.orbitxch.com/customer/sport/1/market/1.219171843	f	\N	\N	\N
5071	Independiente Chivilcoy	Club Atletico el Linquen	2023-10-08 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219374346	f	\N	\N	\N
5069	CA Union de Sunchales	Sportivo Belgrano	2023-10-08 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219381750	f	\N	\N	\N
5073	Club Olimpia Women	Universidad de Chile (W)	2023-10-08 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219406051	f	\N	\N	\N
5070	Atletico Mitre	Atletico Rafaela	2023-10-08 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219187994	f	\N	\N	\N
5075	Independiente (Ecu)	Gualaceo SC	2023-10-08 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219115877	f	\N	\N	\N
5082	La Equidad	Deportivo Pasto	2023-10-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219158728	f	\N	\N	\N
5077	Cerro	River Plate (Uru)	2023-10-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219120270	f	\N	\N	\N
5089	Jorge Wilstermann	Bolivar	2023-10-08 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219312085	f	\N	\N	\N
5076	Moca FC	Club Atletico Pantoja	2023-10-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219410210	f	\N	\N	\N
5081	Criciuma	EC Vitoria Salvador	2023-10-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219068313	f	\N	\N	\N
5080	Racing Cor	Gim. Jujuy	2023-10-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219189521	f	\N	\N	\N
5083	Alianza FC (Pan)	Arabe Unido	2023-10-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219312625	f	\N	\N	\N
5078	Cucuta Deportivo	Leones FC	2023-10-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219231808	f	\N	\N	\N
5079	Puntarenas F.C.	CS Cartagines	2023-10-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219221431	f	\N	\N	\N
5088	Fortaleza EC	America MG	2023-10-08 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218771704	f	\N	\N	\N
5087	Atletico MG	Coritiba	2023-10-08 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218772544	f	\N	\N	\N
5090	CD Aguila	Santa Tecla	2023-10-08 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219314312	f	\N	\N	\N
5086	Athletico-PR	Bragantino SP	2023-10-08 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218771944	f	\N	\N	\N
5085	Boca Unidos	Sol de America	2023-10-08 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219381930	f	\N	\N	\N
5091	Racing Club	CA Platense	2023-10-08 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218834069	f	\N	\N	\N
5093	C J Antoniana	9 de Julio Rafaela	2023-10-08 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219382020	f	\N	\N	\N
5092	CF America (W)	FC Juarez (W)	2023-10-08 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219402363	f	\N	\N	\N
5094	LD Alajuelense	Sporting San Jose FC	2023-10-08 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219298622	f	\N	\N	\N
5095	Carabobo FC	Caracas	2023-10-08 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219313587	f	\N	\N	\N
5042	Ancona	Pesaro	2023-10-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219263610	f	\N	\N	\N
5752	CA Belgrano (W)	Estudiantes de La Plata (W)	2023-10-09 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219422227	f	\N	\N	\N
5750	PAE Chania	OFI	2023-10-09 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219452495	f	\N	\N	\N
5751	Alhashemyya	Al Sarhan	2023-10-09 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219426578	f	\N	\N	\N
5753	Stade Renard	Fauve Azur Elite	2023-10-09 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219394255	f	\N	\N	\N
5102	Tampico Madero	Lobos ULMX	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219348411	f	\N	\N	\N
5101	Cibao FC	Atlantico FC	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219410120	f	\N	\N	\N
5105	Necaxa	Puebla	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219102071	f	\N	\N	\N
5111	Ind Medellin	Atletico Huila	2023-10-09 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219158818	f	\N	\N	\N
5112	Plaza Amador	Costa del Este	2023-10-09 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219312535	f	\N	\N	\N
5114	Oriente Petrolero	The Strongest	2023-10-09 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219342764	f	\N	\N	\N
5113	Independiente Rivadavia	Villa Dalmine	2023-10-09 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219189344	f	\N	\N	\N
5115	Comunicaciones	CSD Tellioz	2023-10-09 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219315041	f	\N	\N	\N
5116	AD San Carlos	AD Guanacasteca	2023-10-09 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219298712	f	\N	\N	\N
5118	CD Real Sociedad	Genesis Huracan	2023-10-09 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219407200	f	\N	\N	\N
5119	Orsomarso	Real Soacha Cundinamarca FC	2023-10-09 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219315162	f	\N	\N	\N
5117	Racing FC Porto Palmeiras	CD Pioneros de Cancun	2023-10-09 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219018259	f	\N	\N	\N
5120	Santos Laguna	Leon	2023-10-09 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219101266	f	\N	\N	\N
5121	Boyaca Chico	Once Caldas	2023-10-09 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.219158908	f	\N	\N	\N
5122	Tijuana	Atletico San Luis	2023-10-09 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219104516	f	\N	\N	\N
5096	Real Apodaca FC	Tuzos de la UAZ	2023-10-08 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219404829	f	\N	\N	\N
5097	Bahia EC U20	Gremio FBPA U20	2023-10-08 23:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219410030	f	\N	\N	\N
5100	Tritones Vallarta MFC	Leones Negros Udg	2023-10-08 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219405679	f	\N	\N	\N
5098	CS Atenas	Argentino Monte Maiz	2023-10-08 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219382110	f	\N	\N	\N
5099	Independiente Santa Fe (W)	Universitario de Depo	2023-10-08 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219406141	f	\N	\N	\N
5123	Club Leon FC (W)	Pachuca (W)	2023-10-09 04:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219402183	f	\N	\N	\N
5742	MS Tira	Maccabi Tzur Shalom	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219419854	f	\N	\N	\N
5103	Cafetaleros de Chiapas II	Yalmakan FC	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219404920	f	\N	\N	\N
5743	MS Tzeirey Taibe	Maccabi Nujeidat Ahmad	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219419944	f	\N	\N	\N
5744	Hapoel Tzafririm Holon	Maccabi Yavne	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219419764	f	\N	\N	\N
5745	FK Graficar	FK Smederevo	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219420034	f	\N	\N	\N
5746	Nasr Taaden	Misr El Makasa	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219448949	f	\N	\N	\N
5747	NK Dubrava Zagreb	NK Solin	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219263358	f	\N	\N	\N
5748	RFK Novi Sad	FK Mladost Novi Sad	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219420148	f	\N	\N	\N
5110	Huehueteco Xinabajul	Deportivo Mixco	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219314951	f	\N	\N	\N
5106	Audax Italiano	Nublense	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219063273	f	\N	\N	\N
5109	Club Tijuana (W)	Tigres (W)	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219402273	f	\N	\N	\N
5104	Delfin	LDU	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219120000	f	\N	\N	\N
5107	CD Olimpia	CD Victoria	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219410846	f	\N	\N	\N
5108	Real Cartagena	Llaneros FC	2023-10-09 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219315258	f	\N	\N	\N
5749	Proxy Work Club	La Viena FC	2023-10-09 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219449039	f	\N	\N	\N
9808	Club A.B.B.	CD Aleman	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220039979	f	\N	\N	\N
9810	AE Jataiense	Centro Oeste SAF	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220052373	f	\N	\N	\N
9818	Internacional	Santos	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219524940	f	\N	\N	\N
9809	Club Deportivo Sur Car	Club Deportivo FATIC	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220039889	f	\N	\N	\N
9811	CD Municipalidad de Yacuiba	CDT Real Oruro	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220039799	f	\N	\N	\N
9813	River Plate (Uru)	Penarol	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219953144	f	\N	\N	\N
9814	Atletico MG	Cruzeiro MG	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219525180	f	\N	\N	\N
9816	Aparecida EC	ASEEV GO	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220052463	f	\N	\N	\N
9815	Flamengo	Vasco Da Gama	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219525060	f	\N	\N	\N
9819	Fortaleza FC	Leones FC	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219830127	f	\N	\N	\N
9820	Valladolid	Andorra CF	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219789937	f	\N	\N	\N
9812	Oliveirense	Boavista	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219968100	f	\N	\N	\N
5755	Colombe du Dja et Lobo	Union Sportive de Douala	2023-10-09 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219406927	f	\N	\N	\N
5756	Floy Flekkeroy	Valerenga II	2023-10-09 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219450451	f	\N	\N	\N
5814	CA San Lorenzo (W)	Independiente (W)	2023-10-09 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219468289	f	\N	\N	\N
5757	Petrojet	Asyut Petroleum	2023-10-09 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219449219	f	\N	\N	\N
5758	Athletic Bilbao (W)	Sporting de Huelva (W)	2023-10-09 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219308148	f	\N	\N	\N
5781	Universitatea Cluj	ACS Sepsi OSK	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219148338	f	\N	\N	\N
5833	CA Estudiantes (W)	Club El Porvenir (W)	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219426069	f	\N	\N	\N
5780	Sunderland U21	Peterborough United U21	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219450695	f	\N	\N	\N
5779	Sacachispas	Villa San Carlos	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219425549	f	\N	\N	\N
5778	Bristol City U21	Tottenham U21	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219450785	f	\N	\N	\N
5830	Patro Maasmechelen U21	RWD Molenbeek U21	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219449326	f	\N	\N	\N
5785	Club Oriental de La Paz	Juventud De Las Piedras	2023-10-09 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219456140	f	\N	\N	\N
5844	Aparecida EC U20	Atletico Goianiense U20	2023-10-09 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219485668	f	\N	\N	\N
5845	Goias EC U20	Vianopolis U20	2023-10-09 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219484368	f	\N	\N	\N
5846	Aragoiania U20	Cerrado U20	2023-10-09 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219485577	f	\N	\N	\N
5847	Guanabara City U20	Vila Nova U20	2023-10-09 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219485487	f	\N	\N	\N
5848	Trindade AC U20	Jataiense U20	2023-10-09 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219485397	f	\N	\N	\N
5786	Pro Vercelli	LR Vicenza Virtus	2023-10-09 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219312989	f	\N	\N	\N
5850	Ballymena United FC U20	Dungannon U20	2023-10-09 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219486030	f	\N	\N	\N
5851	Glentoran FC U20	Carrick Rangers U20	2023-10-09 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219485940	f	\N	\N	\N
5787	Gubbio	Carrarese	2023-10-09 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219264060	f	\N	\N	\N
5789	Carshalton Athletic FC	Canvey Island	2023-10-09 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219452092	f	\N	\N	\N
5790	Fermana	Perugia	2023-10-09 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219263880	f	\N	\N	\N
5788	Arezzo	Cesena	2023-10-09 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219263700	f	\N	\N	\N
5792	Vaca Diez	Real Tomayapo	2023-10-09 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219342674	f	\N	\N	\N
5791	Burton Albion	Cambridge Utd	2023-10-09 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219102845	f	\N	\N	\N
5793	Villarreal B	Espanyol	2023-10-09 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219264904	f	\N	\N	\N
5794	AVS Futebol SAD	Penafiel	2023-10-09 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219192392	f	\N	\N	\N
5795	Boca Juniors (W)	CNFootball (W)	2023-10-09 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219461924	f	\N	\N	\N
5796	Colo Colo (W)	Libertad Limpeno (W)	2023-10-09 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219454957	f	\N	\N	\N
5862	Santiago Wanderers	Deportes Temuco	2023-10-09 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219488009	f	\N	\N	\N
5863	Cruzeiro U20	Fluminense U20	2023-10-09 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219478041	f	\N	\N	\N
5864	San Marcos	Antofagasta	2023-10-09 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219488189	f	\N	\N	\N
5865	Club Deportes Santa Cruz	Deportes Iquique	2023-10-09 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219488279	f	\N	\N	\N
5866	Cobreloa	Club Deportivo San Luis	2023-10-09 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219488099	f	\N	\N	\N
5798	Arsenal De Sarandi	Banfield	2023-10-09 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218834329	f	\N	\N	\N
5797	Barracas Central	Colon	2023-10-09 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218836104	f	\N	\N	\N
5799	Aurora	Guabira	2023-10-09 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219352706	f	\N	\N	\N
5870	Corinthians (W)	Always Ready FC Women	2023-10-09 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219473607	f	\N	\N	\N
5800	America de Cali (W)	SC Internacional (W)	2023-10-09 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219455988	f	\N	\N	\N
5802	Velez Sarsfield	Atl Tucuman	2023-10-10 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218834419	f	\N	\N	\N
5803	Libertad FC	Guayaquil City	2023-10-10 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219192482	f	\N	\N	\N
5804	Blooming Santa Cruz	Royal Pari	2023-10-10 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219342584	f	\N	\N	\N
5805	Pumas UNAM (W)	Club Necaxa (W)	2023-10-10 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451640	f	\N	\N	\N
5806	Escorpiones FC	Halcones de Zapopan	2023-10-10 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451730	f	\N	\N	\N
5807	Monterrey (W)	Queretaro (W)	2023-10-10 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451822	f	\N	\N	\N
5888	Beijing Tech FC	Chongqing Tonglianglong	2023-10-10 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219457410	f	\N	\N	\N
5872	Toluca (W)	Guadalajara (W)	2023-10-10 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492991	f	\N	\N	\N
5801	Sport Recife	Ponte Preta	2023-10-10 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219075969	f	\N	\N	\N
5889	Dantong Hantong	Nanjing Fengfan	2023-10-10 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219458117	f	\N	\N	\N
5890	Dalian Zhixing	Yunnan Yukun	2023-10-10 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219457919	f	\N	\N	\N
5891	Deltras Sidoarjo	Persela Lamongan	2023-10-10 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219520783	f	\N	\N	\N
5892	Hubei Chufeng Heli	Guangxi Lanhang	2023-10-10 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219458682	f	\N	\N	\N
5900	Santa Clara U23	Mafra U23	2023-10-10 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219497453	f	\N	\N	\N
5902	Gorilla FC	Gasogi United	2023-10-10 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219467407	f	\N	\N	\N
5903	South Africa (W)	Eswatini (W)	2023-10-10 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219511849	f	\N	\N	\N
5904	Ispartaspor	Sincan Belediyespor	2023-10-10 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219485758	f	\N	\N	\N
5906	Al Buqaa	Al Alyah	2023-10-10 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219467767	f	\N	\N	\N
5908	Wadi degla	Tanta	2023-10-10 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219498124	f	\N	\N	\N
5907	Ceske Budejovice	MFK Chrudim	2023-10-10 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219497053	f	\N	\N	\N
5909	APR FC	Bugesera	2023-10-10 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219467497	f	\N	\N	\N
5910	Brindisi	Juve Stabia	2023-10-10 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219468645	f	\N	\N	\N
5911	Bursaspor	Golcukspor	2023-10-10 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219484969	f	\N	\N	\N
5913	Heimstetten	TSV 1865 Dachau	2023-10-10 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219468510	f	\N	\N	\N
5914	Eintracht Frankfurt (W)	Sparta Prague (W)	2023-10-10 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219488675	f	\N	\N	\N
5918	Deportivo Espanol	CA Puerto Nuevo	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219471135	f	\N	\N	\N
5912	Paris FC (W)	Wolfsburg (W)	2023-10-10 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219488585	f	\N	\N	\N
5927	AD Berazategui	CA Atlas	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219471765	f	\N	\N	\N
5917	Tranmere	Leicester U21	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219301136	f	\N	\N	\N
5933	Walsall	Forest Green	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219301046	f	\N	\N	\N
5929	CSD Liniers de Ciudad Evita	Deportivo Laferrere	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219471495	f	\N	\N	\N
5921	Mansfield	Doncaster	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219246428	f	\N	\N	\N
5924	Social Atletico (W)	River Plate (W)	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219471858	f	\N	\N	\N
5928	Club Lujan	Leandro N Alem	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219471405	f	\N	\N	\N
5916	Reading	Swindon	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219246337	f	\N	\N	\N
5935	Central Cordoba	Excursionistas	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219471315	f	\N	\N	\N
5932	Stevenage	Wycombe	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219246702	f	\N	\N	\N
5936	Charlton	Aston Villa U21	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219299281	f	\N	\N	\N
5930	Justo Jose de Urquiza	San Martin de Burzaco	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219471585	f	\N	\N	\N
5931	Real Pilar FC	Victoriano Arenas	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219529319	f	\N	\N	\N
5925	CA Claypole	FC Midland	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219471675	f	\N	\N	\N
5934	Valur Reykjavik (W)	SKN St. Polten (W)	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219488765	f	\N	\N	\N
5938	Wigan	Fleetwood Town	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219246518	f	\N	\N	\N
5926	Notts Co	Derby	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219313211	f	\N	\N	\N
5919	Sportivo Italiano	CSD Yupanqui	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219471225	f	\N	\N	\N
5915	Uni San Martin	Alianza Universidad	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219470461	f	\N	\N	\N
5937	Lincoln	Wolves U21	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219301226	f	\N	\N	\N
5923	Carlisle	Nottingham Forest U21	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219299372	f	\N	\N	\N
5920	Morecambe	Barrow	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219246608	f	\N	\N	\N
5922	Blackpool	Liverpool U21	2023-10-10 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219299462	f	\N	\N	\N
5939	FCJ Alt-Ottakring	SV Donau	2023-10-10 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219519011	f	\N	\N	\N
5940	Exeter	Arsenal U21	2023-10-10 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219246792	f	\N	\N	\N
5944	Grimsby	Bradford	2023-10-10 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219301316	f	\N	\N	\N
5943	Crewe	Wrexham	2023-10-10 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219246882	f	\N	\N	\N
5951	Bowers & Pitsea	Heybridge Swifts	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219489469	f	\N	\N	\N
5942	Cheltenham	Newport County	2023-10-10 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219299100	f	\N	\N	\N
5949	Northwood	Marlow	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219489739	f	\N	\N	\N
5952	Larne	Bangor	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219497723	f	\N	\N	\N
5948	Carrick Rangers	Dundela	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219497633	f	\N	\N	\N
5947	Felixstowe & Walton Utd	Brightlingsea Regent	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219489829	f	\N	\N	\N
5950	Ards	Glentoran	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219497543	f	\N	\N	\N
5946	Brentwood Town	Redbridge	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219489649	f	\N	\N	\N
5945	Bury Town	Gorleston	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219489379	f	\N	\N	\N
5953	Ballymacash Rangers	Knockbreda	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219497813	f	\N	\N	\N
5954	Maldon & Tiptree	Basildon United	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219489559	f	\N	\N	\N
5905	LKS Wislanie Jaskowice	Garbarnia	2023-10-10 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219514873	f	\N	\N	\N
5896	Heilongjiang Lava Spring	Yanbian Longding	2023-10-10 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219503362	f	\N	\N	\N
5970	Kirsehir Belediyespor	Sirnak Idmanyurdu Spor	2023-10-10 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219533005	f	\N	\N	\N
5895	Kirklarelispor	Corlu 1947 Spor	2023-10-10 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219485849	f	\N	\N	\N
5898	Guangxi Baoyun	Sichuan Jiuniu FC	2023-10-10 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219462335	f	\N	\N	\N
5897	Hebei KungFu	Jiangxi Liansheng	2023-10-10 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219462425	f	\N	\N	\N
5899	El Seka Elhadeed	Raya Sporting FC	2023-10-10 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219498030	f	\N	\N	\N
5976	Samma	Um El Quttein	2023-10-10 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219497147	f	\N	\N	\N
5901	Mukura Victory Sports	Sunrise FC	2023-10-10 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219467677	f	\N	\N	\N
5978	Madagascar (W)	Malawi (W)	2023-10-10 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219532012	f	\N	\N	\N
5981	Santa Clara U23	Mafra U23	2023-10-10 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219497453	f	\N	\N	\N
5986	FC Lys Sassandra	Racing Club D'Abidjan	2023-10-10 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219533102	f	\N	\N	\N
6064	SV Anadolu Spor Koblenz	TuS Immendorf 1899	2023-10-10 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219554221	f	\N	\N	\N
5941	Salford City	Stockport	2023-10-10 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219246972	f	\N	\N	\N
6031	Nantwich Town	Runcorn Linnets FC	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219532567	f	\N	\N	\N
6027	Harborough Town	Coleshill Town	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219532657	f	\N	\N	\N
6023	Sporting Khalsa	Hinckley LRFC	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219532747	f	\N	\N	\N
5959	Whitehawk	Haringey Borough	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219461837	f	\N	\N	\N
5962	Port Vale	Newcastle U21	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219298956	f	\N	\N	\N
5956	Hornchurch	Hastings United	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219451912	f	\N	\N	\N
5957	Galway Utd	Waterford	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219192572	f	\N	\N	\N
5958	Billericay Town	Dulwich Hamlet	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219452002	f	\N	\N	\N
5961	Portsmouth	Gillingham	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219247062	f	\N	\N	\N
6036	Chichester City United	Three Bridges FC	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219535746	f	\N	\N	\N
5960	Harrogate Town	Accrington	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219247152	f	\N	\N	\N
5955	Sutton Utd	Crawley Town	2023-10-10 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219247242	f	\N	\N	\N
5963	Man Utd (W)	Paris St-G (W)	2023-10-10 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219488855	f	\N	\N	\N
5964	San Lorenzo	San Martin de San Juan	2023-10-10 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219512929	f	\N	\N	\N
5965	Belgrano	Boca Juniors	2023-10-11 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218834509	f	\N	\N	\N
5966	Imbabura Sporting Club	CD Vargas Torres	2023-10-11 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219462169	f	\N	\N	\N
5967	ABC RN	Mirassol	2023-10-11 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219230955	f	\N	\N	\N
5968	Alianza Petrolera	Atletico Bucaramanga	2023-10-11 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219462019	f	\N	\N	\N
9837	CD Real Sociedad	Olancho	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952690	f	\N	\N	\N
9823	Atenas	Juventud De Las Piedras	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220024058	f	\N	\N	\N
9826	Sport Huancayo	Sport Boys (Per)	2023-10-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219524289	f	\N	\N	\N
9828	Brusque FC	Amazonas FC	2023-10-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219951880	f	\N	\N	\N
9827	Union Comercio	Deportivo Garcilaso	2023-10-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219524379	f	\N	\N	\N
9825	Carlos Mannucci	Binacional	2023-10-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219524019	f	\N	\N	\N
9824	Guayaquil City	Independiente (Ecu)	2023-10-22 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219649311	f	\N	\N	\N
9830	Deportivo San Pedro	Club Deportivo Iztapa	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220051493	f	\N	\N	\N
9831	Juventud Pinulteca FC	CSD Sacachispas	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220056028	f	\N	\N	\N
9839	CD Dragon	Jocoro	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220025822	f	\N	\N	\N
9832	Sporting San Miguelito	Plaza Amador	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219995590	f	\N	\N	\N
9842	Once Municipal	CD Aguila	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220025912	f	\N	\N	\N
9833	ART Municipal Jalapa	Indigenas de Matagalpa FC	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220053411	f	\N	\N	\N
9840	Platense Zacatecoluca	AD Isidro Metapan	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220026092	f	\N	\N	\N
9838	Costa del Este	Alianza FC (Pan)	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219995500	f	\N	\N	\N
9834	Avai	Ceara SC Fortaleza	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219537210	f	\N	\N	\N
9829	Chile (W)	Paraguay (W)	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220054840	f	\N	\N	\N
9835	Sport Recife	Chapecoense	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219536562	f	\N	\N	\N
9836	CD Luis Angel Firpo	Cd Fas	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220026002	f	\N	\N	\N
9841	Boyaca Chico	Atletico Nacional Medellin	2023-10-22 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219819623	f	\N	\N	\N
9843	Santa Tecla	Alianza FC (SLV)	2023-10-22 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.220029369	f	\N	\N	\N
6124	Llaneros FC	Cucuta Deportivo	2023-10-11 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219472435	f	\N	\N	\N
6125	Atletico FC Cali	Fortaleza FC	2023-10-11 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219472525	f	\N	\N	\N
6126	Boyaca Patriotas	Tigres FC Zipaquira	2023-10-11 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219472615	f	\N	\N	\N
6127	Leones FC	Real Cartagena	2023-10-11 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219472165	f	\N	\N	\N
6128	Barranquilla	Orsomarso	2023-10-11 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219472705	f	\N	\N	\N
6129	Real Soacha Cundinamarca FC	Real Santander	2023-10-11 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219472075	f	\N	\N	\N
6130	Quindio	Boca Juniors de Cali	2023-10-11 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219472345	f	\N	\N	\N
6131	Club Atletico Basanez	Cerrito	2023-10-11 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219604875	f	\N	\N	\N
6132	CD America de Quito	Club Nueve de Octubre	2023-10-11 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219529686	f	\N	\N	\N
6133	Olimpia Women	Universitario	2023-10-11 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219577788	f	\N	\N	\N
6134	Ferro Carril de Salto	CA Bella Vista	2023-10-12 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219600551	f	\N	\N	\N
6135	Deportivo Cali	Tolima	2023-10-12 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219463084	f	\N	\N	\N
6136	CA Juventud Colonia	Albion FC	2023-10-12 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219600641	f	\N	\N	\N
6137	Macara	Chacaritas SC	2023-10-12 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219529505	f	\N	\N	\N
6138	Chaco For Ever	Defensa y Justicia	2023-10-12 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219561250	f	\N	\N	\N
6139	Vila Nova	Botafogo SP	2023-10-12 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219230847	f	\N	\N	\N
6140	Tapatio	Universidad Guadalajara	2023-10-12 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219314222	f	\N	\N	\N
6141	Mazatlan FC(W)	Santos Laguna (W)	2023-10-12 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219569700	f	\N	\N	\N
6142	Deportivo Pereira	Rionegro	2023-10-12 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219498304	f	\N	\N	\N
6143	Pacific	York9	2023-10-12 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219513235	f	\N	\N	\N
9846	Coritiba	SE Palmeiras	2023-10-22 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219524580	f	\N	\N	\N
9844	Bragantino SP	Fluminense	2023-10-22 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219524820	f	\N	\N	\N
9845	Corinthians	America MG	2023-10-22 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219525540	f	\N	\N	\N
9847	Municipal Grecia	AD Municipal Liberia	2023-10-22 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952240	f	\N	\N	\N
9849	Santos de Guapiles	Municipal Perez Zeledon	2023-10-22 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952060	f	\N	\N	\N
9848	La Luz FC	Plaza Colonia	2023-10-22 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952964	f	\N	\N	\N
9858	CD Victoria	CD Marathon	2023-10-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952510	f	\N	\N	\N
9860	Alianza Petrolera	Tolima	2023-10-23 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.219819803	f	\N	\N	\N
10107	Aalesund II	Orn Horten	2023-10-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010472	f	\N	\N	\N
10108	Al Alyah	Al Tora	2023-10-23 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220105127	f	\N	\N	\N
10109	Hyderabad FC	Chennaiyin FC	2023-10-23 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219819893	f	\N	\N	\N
10110	KF Erzeni	Partizani Tirana	2023-10-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220081492	f	\N	\N	\N
10111	ACS Sepsi OSK	Botosani	2023-10-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219173083	f	\N	\N	\N
10112	FK Siauliai II	MFD Zalgiris Vilnius (Res)	2023-10-23 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220068856	f	\N	\N	\N
10113	Young Africans	Azam FC	2023-10-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220069006	f	\N	\N	\N
9851	CD Olimpia	CD Motagua	2023-10-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952780	f	\N	\N	\N
9850	Costa Rica (W)	Argentina (W)	2023-10-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220049876	f	\N	\N	\N
9855	Tampico Madero	Halcones de Zapopan	2023-10-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220033617	f	\N	\N	\N
9854	Real Cartagena	Boca Juniors de Cali	2023-10-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219830217	f	\N	\N	\N
9853	Huehueteco Xinabajul	Achuapa FC	2023-10-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219924742	f	\N	\N	\N
9852	LDU	Emelec	2023-10-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219649401	f	\N	\N	\N
9856	Ind Medellin	Deportivo Pereira	2023-10-23 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219819713	f	\N	\N	\N
9857	Atletico San Luis	Necaxa	2023-10-23 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219494775	f	\N	\N	\N
9859	Cienciano	Sporting Cristal	2023-10-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219523749	f	\N	\N	\N
10114	Ghazl El Mahallah	Makadi FC	2023-10-23 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220086969	f	\N	\N	\N
10115	Zeleznicar Pancevo	FK IMT Novi Beograd	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220011912	f	\N	\N	\N
10116	Al-Muharraq	Al Ahli (BRN)	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220068766	f	\N	\N	\N
10117	Al-Ittihad	Al Quwa Al Jawiya	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220084507	f	\N	\N	\N
10118	Al Sharjah	Nasaf	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220084415	f	\N	\N	\N
10119	Al Zawraa	Nejmeh	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220103712	f	\N	\N	\N
10120	FK Navbahor Namangan	Nassaji Mazandaran F.C.	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220084613	f	\N	\N	\N
10121	Arka Gdynia	Znicz Pruszkow	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219416060	f	\N	\N	\N
10122	Levadia Tallinn II	Tallinna JK Legion	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220068676	f	\N	\N	\N
6178	CD Subiza	CD Avance Ezcabarte	2023-10-12 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219598693	f	\N	\N	\N
6179	Malaga	Melilla UD	2023-10-12 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219561918	f	\N	\N	\N
6180	CD Oberena	CD Alesves	2023-10-12 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219599053	f	\N	\N	\N
6181	CP Montehermoso	CD Calamonte	2023-10-12 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219598873	f	\N	\N	\N
6182	Pazarspor	Silifke Belediye Spor	2023-10-12 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219585007	f	\N	\N	\N
6183	Olivenza	RCP Valverdeno	2023-10-12 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219598783	f	\N	\N	\N
6184	Adiyamanspor	Viven Bornova FK	2023-10-12 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219584737	f	\N	\N	\N
6185	Arroyo	CD Azuaga	2023-10-12 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219598963	f	\N	\N	\N
6186	CD Diocesano	Don Benito	2023-10-12 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219621710	f	\N	\N	\N
6187	CD Pamplona	CD Beti Onak	2023-10-12 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219599234	f	\N	\N	\N
6188	Barcia	CD Llanera	2023-10-12 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219599143	f	\N	\N	\N
6189	Hansa Rostock	Naestved	2023-10-12 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219608556	f	\N	\N	\N
6190	KV Oostende	Valenciennes	2023-10-12 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219621265	f	\N	\N	\N
6191	Mgladbach	Sint Truiden	2023-10-12 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219601096	f	\N	\N	\N
6192	Republic of Maldives	Bangladesh	2023-10-12 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219610268	f	\N	\N	\N
6193	Chinese Taipei	Timor-Leste	2023-10-12 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219530326	f	\N	\N	\N
6194	Schalke 04	Heracles	2023-10-12 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219601186	f	\N	\N	\N
6195	FC Magdeburg	Braunschweig	2023-10-12 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219602748	f	\N	\N	\N
6196	Singapore	Guam	2023-10-12 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219555613	f	\N	\N	\N
6197	Nepal	Laos	2023-10-12 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219562844	f	\N	\N	\N
6198	Augsburg	Nurnberg	2023-10-12 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219601276	f	\N	\N	\N
6199	Indonesia	Brunei	2023-10-12 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219562717	f	\N	\N	\N
6200	Cambodia	Pakistan	2023-10-12 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219534035	f	\N	\N	\N
6201	Hong Kong	Bhutan	2023-10-12 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219555708	f	\N	\N	\N
6202	Karlsruhe	Strasbourg	2023-10-12 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219593056	f	\N	\N	\N
6203	SCR Altach	FC Dornbirn	2023-10-12 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219602839	f	\N	\N	\N
6204	Lazio (W)	Inter Milan (W)	2023-10-12 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219621620	f	\N	\N	\N
6170	Chile	Peru	2023-10-13 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218300371	f	\N	\N	\N
6173	Cuba	Honduras	2023-10-13 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219424188	f	\N	\N	\N
6174	Atletico San Luis (W)	Monterrey (W)	2023-10-13 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219596313	f	\N	\N	\N
6175	Guadalajara (W)	Club Leon FC (W)	2023-10-13 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219596403	f	\N	\N	\N
6176	Tigres (W)	Cruz Azul (W)	2023-10-13 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219596493	f	\N	\N	\N
6177	Pachuca (W)	Club Tijuana (W)	2023-10-13 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219596583	f	\N	\N	\N
6171	Toluca (W)	FC Atlas (W)	2023-10-13 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219596223	f	\N	\N	\N
6209	UD Collerense	CD Binissalem	2023-10-12 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219599414	f	\N	\N	\N
6210	UCD Burlades	Pena Sport	2023-10-12 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219599324	f	\N	\N	\N
6206	Afghanistan	Mongolia	2023-10-12 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219530416	f	\N	\N	\N
6205	Viktoria Marianske Lazne	Plzen	2023-10-12 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219602418	f	\N	\N	\N
6207	Azerbaijan U21	Northern Ireland U21	2023-10-12 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219461125	f	\N	\N	\N
6208	Georgia U21	Netherlands U21	2023-10-12 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219403927	f	\N	\N	\N
6215	SD Lagunak	CD Cortes	2023-10-12 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219601734	f	\N	\N	\N
6216	CF Trujillo	AC Pueblonuevo	2023-10-12 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219622092	f	\N	\N	\N
6212	SD Beasain	CD Derio	2023-10-12 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219601464	f	\N	\N	\N
6211	Real Titanico	Urraca	2023-10-12 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219601554	f	\N	\N	\N
6213	Condal CF	UD Gijon Industrial	2023-10-12 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219601644	f	\N	\N	\N
6214	Romania U20	England U20	2023-10-12 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219599816	f	\N	\N	\N
6218	FIRST VIENNA FC 1894	Rapid Vienna	2023-10-12 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219602568	f	\N	\N	\N
6217	San Pedro FC	CO Korhogo	2023-10-12 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219610128	f	\N	\N	\N
6221	Club Portugalete	Urduliz FT	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219602147	f	\N	\N	\N
6219	Israel U21	Estonia U21	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219351767	f	\N	\N	\N
6224	Karsiyaka	Bigaspor	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219584917	f	\N	\N	\N
6222	Slovakia U21	Poland U21	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219450091	f	\N	\N	\N
6223	CD San Ignacio	Anaitasuna FT	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219602327	f	\N	\N	\N
6220	UAE	Kuwait	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219450001	f	\N	\N	\N
6172	Brazil	Venezuela	2023-10-13 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218300804	f	\N	\N	\N
6286	Turegano CF	CD Santurtzi	2023-10-12 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219630004	f	\N	\N	\N
6287	AD Tardienta	CD Zirauki	2023-10-12 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219630094	f	\N	\N	\N
6225	SCD Durango	Leioa	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219603265	f	\N	\N	\N
6226	Bahrain	Kyrgyzstan	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219596908	f	\N	\N	\N
6227	Georgia	Thailand	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219449821	f	\N	\N	\N
6228	Montenegro	Lebanon	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219565635	f	\N	\N	\N
6231	Egypt	Zambia	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219565725	f	\N	\N	\N
6229	Colombe du Dja et Lobo	PWD Bamenda	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219605347	f	\N	\N	\N
6230	Latvia	Armenia	2023-10-12 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218779530	f	\N	\N	\N
6233	Lorca Deportiva CF	Caravaca	2023-10-12 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219603175	f	\N	\N	\N
6232	Jerez CF	CD Don Alvaro	2023-10-12 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219603085	f	\N	\N	\N
6234	Bidezarra	CD Cantolagua	2023-10-12 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219605253	f	\N	\N	\N
6235	Chievo Verona (W)	Juventus FC (W)	2023-10-12 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219622182	f	\N	\N	\N
6236	Sweden	Moldova	2023-10-12 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219449731	f	\N	\N	\N
6237	Jitex BK (W)	Lidkopings FK (W)	2023-10-12 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219584827	f	\N	\N	\N
6238	Luxembourg U21	Ukraine U21	2023-10-12 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219351677	f	\N	\N	\N
6241	Ibis SC	CA Pernambucano	2023-10-12 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219622905	f	\N	\N	\N
6239	Egypt U23	Jordan U23	2023-10-12 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219602052	f	\N	\N	\N
6240	Cruzeiro U20	Coimbra EC U20	2023-10-12 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219610365	f	\N	\N	\N
6242	Kongsvinger U19	Hamarkameratene U19	2023-10-12 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219584434	f	\N	\N	\N
6243	FK Lyn U19	Nordstrand U19	2023-10-12 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219584344	f	\N	\N	\N
6244	Fredrikstad U19	Baerum SK U19	2023-10-12 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219584254	f	\N	\N	\N
6245	Austria U21	Norway U21	2023-10-12 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219499673	f	\N	\N	\N
6251	Cheltenham Town (W)	Oxford United (W)	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219622725	f	\N	\N	\N
6246	Hull City (W)	Barnsley (W)	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219622634	f	\N	\N	\N
6249	Leek Town (W)	Loughborough Lightning (W)	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219622544	f	\N	\N	\N
6248	Fylde (W)	Liverpool Feds (W)	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219622815	f	\N	\N	\N
6252	London Seaward (W)	Cambridge United (W)	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219622454	f	\N	\N	\N
6247	Northampton Town (W)	Boldmere St. Michaels (W)	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219622364	f	\N	\N	\N
6254	England U21	Serbia U21	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219343739	f	\N	\N	\N
6253	UCD	Bohemians	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219314098	f	\N	\N	\N
6168	Argentina	Paraguay	2023-10-13 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218300480	f	\N	\N	\N
6256	Albania	Czech Republic	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218779140	f	\N	\N	\N
6258	Cyprus	Norway	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218778538	t	1	4	274
6255	Faroe Islands	Poland	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218778658	f	\N	\N	\N
6250	Andorra	Kosovo	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218779746	f	\N	\N	\N
6257	Belarus	Romania	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218779638	f	\N	\N	\N
6260	Croatia	Turkey	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218778780	f	\N	\N	\N
6261	Algeria	Cape Verde	2023-10-12 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219565544	f	\N	\N	\N
6262	Libertad Limpeno (W)	Corinthians (W)	2023-10-12 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219599932	f	\N	\N	\N
6263	Colombia	Uruguay	2023-10-12 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218300696	f	\N	\N	\N
6264	CF America (W)	Club Necaxa (W)	2023-10-12 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219599676	f	\N	\N	\N
6265	Suriname	Haiti	2023-10-12 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219416510	f	\N	\N	\N
6266	America de Cali (W)	Club Nacional (W)	2023-10-12 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219600270	f	\N	\N	\N
6267	SC Internacional (W)	Boca Juniors (W)	2023-10-12 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219600461	f	\N	\N	\N
6169	Queretaro (W)	Pumas UNAM (W)	2023-10-13 00:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219595916	f	\N	\N	\N
6369	Sulut United FC	PSBS Biak Numfor	2023-10-13 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219628150	f	\N	\N	\N
6370	Palestine	Tajikistan	2023-10-13 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219512209	f	\N	\N	\N
6259	Spain	Scotland	2023-10-12 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218778218	t	0	2	274
6166	Grenada	Jamaica	2023-10-13 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219416600	f	\N	\N	\N
6371	Japan	Canada	2023-10-13 11:35:00	https://www.orbitxch.com/customer/sport/1/market/1.219499763	f	\N	\N	\N
6372	SV Darmstadt	Elversberg	2023-10-13 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219627415	f	\N	\N	\N
6373	South Korea	Tunisia	2023-10-13 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219449911	f	\N	\N	\N
6374	ACS Targu Mures 1898	CS Glor2018 Bistrita-Nasaud	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219633883	f	\N	\N	\N
6375	AFC Dunarea Ciocanesti	ACS Recolta Gheorghe Doja	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219634624	f	\N	\N	\N
6376	Semen Padang	Karo United	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219628240	f	\N	\N	\N
6377	Sturm Graz	Floridsdorfer Ac	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219627757	f	\N	\N	\N
6379	DSV Leoben	Austria Klagenfurt	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219627847	f	\N	\N	\N
6380	CS Avantul Periam	ACB Ineu	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219634333	f	\N	\N	\N
6383	Latvia U21	Rep of Ireland U21	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219610725	f	\N	\N	\N
6384	ACS Inainte Modelu	CS Gloria Baneasa	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219635489	f	\N	\N	\N
6385	Csm Focsani	Dacia Unirea Braila	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219634714	f	\N	\N	\N
6386	FCM Baia Mare	Crisul Santandrei	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219634808	f	\N	\N	\N
6387	ACS Kids Tampa Brasov	ASC Ciucas Tarlungeni	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219634063	f	\N	\N	\N
6381	ACS Vedita Colonesti MS	SCM Ramnicu Valcea	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219634513	f	\N	\N	\N
6382	CF Metalurgistul Cugir	CS Unirea Ungheni	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219634153	f	\N	\N	\N
6378	FCM Avantul Reghin	CSM Unirea Alba Iulia	2023-10-13 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219634423	f	\N	\N	\N
6391	Kaiserslautern	Metz	2023-10-13 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219627955	f	\N	\N	\N
6392	Trinec	FK Blansko	2023-10-13 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219617649	f	\N	\N	\N
6393	Gorica	Tabor Sezana	2023-10-13 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219563450	f	\N	\N	\N
6394	Malaysia	India	2023-10-13 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219516043	f	\N	\N	\N
6413	IFK Hassleholm	FBK Balkan	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219647662	f	\N	\N	\N
6414	Lindome	Qviding FIF	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219647482	f	\N	\N	\N
6429	Karlskrona	IFK Berga	2023-10-13 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219647572	f	\N	\N	\N
6406	USM Annaba	CA Batna	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219619070	f	\N	\N	\N
6407	ESM Kolea	JSM Tiaret	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219637119	f	\N	\N	\N
6397	GC Mascara	SC Mecheria	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219619340	f	\N	\N	\N
6398	MCB Oued Sly	RC Arba	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219639313	f	\N	\N	\N
6402	ASM Oran	RC Kouba	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219619250	f	\N	\N	\N
6404	JS Bordj Menaiel	Chelghoum Laid	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219637026	f	\N	\N	\N
6396	Medea	NA Hussein Dey	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219619430	f	\N	\N	\N
6395	MSP Batna	AS Ain M'lila	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219637837	f	\N	\N	\N
6399	WA Mostaganem	ES Mostaganem	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219662606	f	\N	\N	\N
6405	JS Guire	WA Boufarik	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219637320	f	\N	\N	\N
6401	Portugal U20	Germany U20	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219606368	f	\N	\N	\N
6403	Cr Temouchent	Skaf Khemis Miliana	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219619160	f	\N	\N	\N
6408	NRB Teleghma	IB Khemis El Khechna	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219619520	f	\N	\N	\N
6400	Greece U21	Croatia U21	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219447961	f	\N	\N	\N
6409	US Souf	Belouizdad	2023-10-13 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219639088	f	\N	\N	\N
6410	Finland U21	Albania U21	2023-10-13 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219448051	f	\N	\N	\N
6411	Iraq	Qatar	2023-10-13 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219512299	f	\N	\N	\N
6412	Cracovia Krakow	Stal Rzeszow	2023-10-13 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219628045	f	\N	\N	\N
6415	Garliava Kaunas	FK Kauno Zalgiris 2	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219620733	f	\N	\N	\N
6416	APR FC	Mukura Victory Sports	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219620823	f	\N	\N	\N
6420	Saudi Arabia	Nigeria	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219516133	f	\N	\N	\N
6426	Olimpia Elblag	Kks Kalisz	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219606084	f	\N	\N	\N
6424	Cyprus U21	Slovenia U21	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219448141	f	\N	\N	\N
6423	FC Zurich II	Bulle	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219621035	f	\N	\N	\N
6425	Malta U21	Belgium U21	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219416690	f	\N	\N	\N
6422	Estonia	Azerbaijan	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218779314	f	\N	\N	\N
6419	New Zealand	DR Congo	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219566101	f	\N	\N	\N
6421	Sweden U21	Moldova U21	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219416780	f	\N	\N	\N
6427	Czech Republic U21	Wales U21	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219448231	f	\N	\N	\N
6418	Guinea	Guinea-Bissau	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219626921	f	\N	\N	\N
6417	South Africa	Eswatini	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219566191	f	\N	\N	\N
6428	Bulgaria U21	Germany U21	2023-10-13 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219448321	f	\N	\N	\N
6430	KAC 1909	SV Oberwinkler Lendorf	2023-10-13 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219615437	f	\N	\N	\N
9521	Lorient	Rennes	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219117051	t	2	\N	5
10123	Fauve Azur Elite	Fovu Club de Baham	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220008650	f	\N	\N	\N
10124	Busaiteen Club	Al Khalidiyah	2023-10-23 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219910533	f	\N	\N	\N
9490	FC Utrecht	Ajax	2023-10-22 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219480046	t	1	\N	196
6454	Eimsbutteler	Drochtersen-Assel	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219593829	f	\N	\N	\N
6469	Carrick Rangers	Linfield	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219400384	f	\N	\N	\N
6432	Portugal U21	Belarus U21	2023-10-13 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219448501	f	\N	\N	\N
6434	Herlev IF	Bronshoj	2023-10-13 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219620945	f	\N	\N	\N
6435	SK Vorwarts Steyr	St.Anna	2023-10-13 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219615167	f	\N	\N	\N
6433	Bosnia U21	France U21	2023-10-13 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219448411	f	\N	\N	\N
6437	VST Volkermarkt	Atus Velden	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219615527	f	\N	\N	\N
6436	Favoritner AC	SC Mannsdorf	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219645789	f	\N	\N	\N
6441	Turkey U21	San Marino U21	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219458988	f	\N	\N	\N
6439	Kremser SC	FCM TQS Traiskirchen	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219615347	f	\N	\N	\N
6438	FC Gleisdorf 09	WSC Hertha Wels	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219615257	f	\N	\N	\N
6440	ASV Drassburg	Austria Wien (A)	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219615077	f	\N	\N	\N
6444	Dortmund II	Rot-Weiss Essen	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219353827	f	\N	\N	\N
6453	Chemie Leipzig	Eintracht Frankfurt	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219627104	f	\N	\N	\N
6449	FSV 08 Bissingen	SG Sonnenhof	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219615887	f	\N	\N	\N
6451	Skra Czestochowa	Wisla Pulawy	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219606174	f	\N	\N	\N
6443	SC Eltersdorf	DJK Ammerthal	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219614987	f	\N	\N	\N
6455	Switzerland U21	Montenegro U21	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219369325	f	\N	\N	\N
6447	Djurgardens IF Dff (W)	IFK Norrkoping DFK (W)	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219616585	f	\N	\N	\N
6452	1. CfR Pforzheim	Holzhausen FC	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219615977	f	\N	\N	\N
6445	Spartak Myjava	Slovan Bratislava II	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219602237	f	\N	\N	\N
6450	TuS Koblenz	Homburg	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219613881	f	\N	\N	\N
6446	FC Memmingen	FC Eintracht Bamberg	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219593919	f	\N	\N	\N
6448	FC Kilia Kiel 1902	Weiche Flensburg	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219594443	f	\N	\N	\N
6457	SW Rehden	Bersenbruck	2023-10-13 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219617741	f	\N	\N	\N
6459	SC Wiedenbruck	SV Rodinghausen	2023-10-13 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219614512	f	\N	\N	\N
6462	Bergisch Gladbach 09	Bonner SC	2023-10-13 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219615707	f	\N	\N	\N
6463	Romania U21	Armenia U21	2023-10-13 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219530836	f	\N	\N	\N
6460	SC Victoria Hamburg	ETSV Hamburg	2023-10-13 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219615797	f	\N	\N	\N
6458	Fortuna Koln	Rot-Weiss Ahlen	2023-10-13 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219614332	f	\N	\N	\N
6461	AZ Alkmaar Women	SC Telstar (W)	2023-10-13 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219616280	f	\N	\N	\N
6456	FC Utrecht (W)	ADO Den Haag (W)	2023-10-13 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219616370	f	\N	\N	\N
6466	SV 19 Straelen	Tvd Velbert	2023-10-13 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219616189	f	\N	\N	\N
6465	Sheff Wed U21	Sheff Utd U21	2023-10-13 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219628864	f	\N	\N	\N
6464	VfB 03 Hilden	Teutonia St. Tonis	2023-10-13 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219616099	f	\N	\N	\N
6468	Scotland U21	Hungary U21	2023-10-13 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219369415	f	\N	\N	\N
6467	Jordan	Iran	2023-10-13 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219594537	f	\N	\N	\N
6471	Crusaders	Ballymena	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219400598	f	\N	\N	\N
6470	Fiorenzuola	FC Legnago	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219558287	f	\N	\N	\N
6476	Novara	Arzignanochiampo	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219558197	f	\N	\N	\N
6485	24 de Septiembre Santa Cruz	Club Universitario B	2023-10-13 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219650076	f	\N	\N	\N
6481	Glentoran	Loughgall	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219400294	f	\N	\N	\N
6484	Albinoleffe	SS Virtus Verona 1921	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219558377	f	\N	\N	\N
6472	Glenavon	Cliftonville	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219400508	f	\N	\N	\N
6475	Portugal	Slovakia	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218779020	f	\N	\N	\N
6482	Newry	Coleraine	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219403657	f	\N	\N	\N
6474	Republic of Ireland	Greece	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218778298	f	\N	\N	\N
6477	Iceland	Luxembourg	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218779422	f	\N	\N	\N
6483	England	Australia	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219361057	f	\N	\N	\N
6478	Austria	Belgium	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218778418	f	\N	\N	\N
6473	Liechtenstein	Bosnia	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218801229	f	\N	\N	\N
6480	Dungannon	Larne	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219403567	f	\N	\N	\N
6479	Netherlands	France	2023-10-13 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218778077	t	1	3	274
6527	Uzbekistan U23	Spain U21	2023-10-13 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219667156	f	\N	\N	\N
6533	CE L Hospitalet	CFJ Mollerusa	2023-10-13 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219675666	f	\N	\N	\N
6547	Treibach	SAK Klagenfurt	2023-10-13 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219667672	f	\N	\N	\N
6550	SV Lafnitz II	SC Kalsdorf	2023-10-13 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219667066	f	\N	\N	\N
6431	Bordeaux (W)	Montpellier (W)	2023-10-13 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219616460	f	\N	\N	\N
6556	UFC Fehring	Fleischereimaschinen Schenk	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219668033	f	\N	\N	\N
6557	Salzburger AK 1914	USK Anif	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219668123	f	\N	\N	\N
6559	FC Zwettl	SCU Kilb	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219667762	f	\N	\N	\N
6560	SV Wildon	SC Bruck an der Mur	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219668393	f	\N	\N	\N
6561	Parndorf	Ask Horitschon	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219668303	f	\N	\N	\N
6562	ASV Siegendorf	ASK Marz	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219668213	f	\N	\N	\N
6563	ASK Kottingbrunn	SV Gloggnitz	2023-10-13 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219667852	f	\N	\N	\N
6573	Lindome	Qviding FIF	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219647482	f	\N	\N	\N
6577	IFK Hassleholm	FBK Balkan	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219647662	f	\N	\N	\N
6442	Frederiksberg Alliancen 2000	Fremad Amager	2023-10-13 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219626363	f	\N	\N	\N
6588	Karlskrona	IFK Berga	2023-10-13 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219647572	f	\N	\N	\N
6595	Ciudad de Bolivar	CS Atenas	2023-10-13 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219638671	f	\N	\N	\N
6487	Mali	Uganda	2023-10-13 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219627012	f	\N	\N	\N
6488	Centro Atletico Fenix	Plaza Colonia	2023-10-13 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219520243	f	\N	\N	\N
6486	Oviedo	Albacete	2023-10-13 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219410627	f	\N	\N	\N
6489	AD Carmelita	PFA Antioquia FC	2023-10-13 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219628437	f	\N	\N	\N
6490	Huracan	Estudiantes	2023-10-13 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219626569	f	\N	\N	\N
6491	Curacao	Panama	2023-10-13 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219521017	f	\N	\N	\N
6492	Defensor Sporting	Torque	2023-10-13 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219520333	f	\N	\N	\N
6623	Club Sporting Canamy	Inter de Queretaro FC	2023-10-13 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219677786	f	\N	\N	\N
6493	Deportivo Pasto	Union Magdalena	2023-10-14 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219498214	f	\N	\N	\N
6499	Deportivo Maldonado	Penarol	2023-10-14 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219530227	f	\N	\N	\N
6497	Tlaxcala F.C	CD Tepatitlan de Morelos	2023-10-14 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219361710	f	\N	\N	\N
6498	9 de Julio Rafaela	Boca Unidos	2023-10-14 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219638761	f	\N	\N	\N
6500	Barbados	Dominican Republic	2023-10-14 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219544828	f	\N	\N	\N
6501	Criciuma	Chapecoense	2023-10-14 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219251566	f	\N	\N	\N
6505	Arabe Unido	Sporting San Miguelito	2023-10-14 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219639698	f	\N	\N	\N
6504	FC Santiago	Huracanes Izcalli FC	2023-10-14 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219657519	f	\N	\N	\N
6502	Petone	Auckland United	2023-10-14 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219629359	f	\N	\N	\N
6503	Trinidad & Tobago	Guatemala	2023-10-14 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219521197	f	\N	\N	\N
6506	Auckland City	Cashmere Technical	2023-10-14 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219629271	f	\N	\N	\N
6508	Christchurch United	Manurewa AFC	2023-10-14 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219629447	f	\N	\N	\N
6511	Cimarrones de Sonora	Correcaminos	2023-10-14 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219611719	f	\N	\N	\N
6507	Once Caldas	Jaguares de Cordoba	2023-10-14 02:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219498395	f	\N	\N	\N
6510	Alacranes de Durango	Correcaminos (Premier)	2023-10-14 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219635822	f	\N	\N	\N
6509	Wellington Olympic AFC	Eastern Suburbs Auckland	2023-10-14 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219629535	f	\N	\N	\N
6512	Grulla Morioka	FC Ryukyu	2023-10-14 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219463804	f	\N	\N	\N
6513	Nara Club	Fukushima Utd	2023-10-14 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219463444	f	\N	\N	\N
6666	Blaublitz Akita	FC Machida	2023-10-14 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219447513	f	\N	\N	\N
6667	Central Coast (W)	Newcastle Jets (W)	2023-10-14 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219628329	f	\N	\N	\N
6668	Wellington Phoenix (Res)	Napier City Rovers	2023-10-14 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219629623	f	\N	\N	\N
6495	Inter Playa Del Carmen	Racing FC Porto Palmeiras	2023-10-14 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219635912	f	\N	\N	\N
6494	Martinique	El Salvador	2023-10-14 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219521107	f	\N	\N	\N
6496	Hartford Athletic FC	Tulsa Roughnecks FC	2023-10-14 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219560546	f	\N	\N	\N
6669	Lee Man Warriors	North District	2023-10-14 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219697887	f	\N	\N	\N
6670	Hainan Star	Wuhan Jiangcheng	2023-10-14 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219649945	f	\N	\N	\N
6671	Chungnam Asan	Cheongju FC	2023-10-14 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219385992	f	\N	\N	\N
6672	Shaoxing Shangyu Pterosaur	Haimen Codion	2023-10-14 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219649671	f	\N	\N	\N
6673	Hunan Billows FC	Taian Tiankuang	2023-10-14 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219649761	f	\N	\N	\N
6674	Sham Shui Po	HK U23	2023-10-14 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714617	f	\N	\N	\N
6675	Quanzhou Yaxin	Zibo Qisheng FC	2023-10-14 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219649851	f	\N	\N	\N
6676	Dantong Hantong	Heilongjiang Lava Spring	2023-10-14 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219650256	f	\N	\N	\N
6677	Nanjing Fengfan	Qingdao Youth Island	2023-10-14 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219650346	f	\N	\N	\N
6678	Mataram Utama	Psim Yogyakarta	2023-10-14 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219677386	f	\N	\N	\N
6679	Concordia Chiajna	FCM Alexandria	2023-10-14 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219691757	f	\N	\N	\N
6680	Gresik United	Persijap Jepara	2023-10-14 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219677296	f	\N	\N	\N
6681	Persekat Kabupaten Tegal	PSCS Cilacap	2023-10-14 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219677206	f	\N	\N	\N
6682	Fujieda MYFC	Thespakusatsu Gunma	2023-10-14 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219447603	f	\N	\N	\N
6683	MSK Zilina (W)	Slovan Bratislava (W)	2023-10-14 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219682645	f	\N	\N	\N
6684	Jinan Xingzhou	Suzhou Dongwu	2023-10-14 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219650444	f	\N	\N	\N
6685	PSDS Deli Serdang	Persiraja Banda Aceh	2023-10-14 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219677477	f	\N	\N	\N
6686	Sydney FC (W)	Western Sydney (W)	2023-10-14 09:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219466500	f	\N	\N	\N
6687	Rudes	NK Radomlje	2023-10-14 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219684431	f	\N	\N	\N
6688	GKS Katowice	Piast Gliwice	2023-10-14 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219691847	f	\N	\N	\N
6689	Herspice (W)	FC Viktoria Plzen (W)	2023-10-14 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219688248	f	\N	\N	\N
6690	Zaglebie Sosnowiec	Podbeskidzie B-B	2023-10-14 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219684341	f	\N	\N	\N
6691	Medyk Konin (W)	Gornik Leczna (W)	2023-10-14 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219656349	f	\N	\N	\N
6692	Kitchee SC	Hong Kong Rangers FC	2023-10-14 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219685315	f	\N	\N	\N
6693	Pogon Tczew (W)	Stomilanki Olsztyn (W)	2023-10-14 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219684222	f	\N	\N	\N
6694	Villarreal (W)	Athletic Bilbao (W)	2023-10-14 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219512659	f	\N	\N	\N
6695	Napoli Calcio (W)	Sampdoria (W)	2023-10-14 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219711153	f	\N	\N	\N
6696	Dobrudzha	Lokomotiv Plovdiv	2023-10-14 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219710828	f	\N	\N	\N
6697	Diyarbekirspor	Afjet Afyonspor	2023-10-14 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219632141	f	\N	\N	\N
6698	Perth Glory (W)	Western United (W)	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219613592	f	\N	\N	\N
6699	Hannover II	Bremer SV	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219595150	f	\N	\N	\N
6700	Fortuna Hjorring (W)	AGF Aarhus (W)	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219658450	f	\N	\N	\N
6701	FC Stockholm Internazionale	Sollentuna FF	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219447693	f	\N	\N	\N
6702	Hansa Rostock II	FSV 63 Luckenwalde	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219560033	f	\N	\N	\N
6703	Nomme Kalju	Harju JK Laagri	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219682797	f	\N	\N	\N
6704	Rekord Bielsko-Biala (W)	Czarni Sosnowiec (W)	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219684132	f	\N	\N	\N
6705	FC Phonix Lubeck	Hamburg II	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219595059	f	\N	\N	\N
6706	Slavoj Trebisov	Tatran Presov	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219605446	f	\N	\N	\N
6707	Oddevold	Norrby IF	2023-10-14 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219433835	f	\N	\N	\N
6708	Poland U19	Kazakhstan U19	2023-10-14 12:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219710603	f	\N	\N	\N
6709	UD Teror Balompie	CD Santa Ursula	2023-10-14 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219675393	f	\N	\N	\N
6710	Jiangxi Liansheng	Guangzhou FC	2023-10-14 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219657838	f	\N	\N	\N
6711	Bracknell Town FC	Dag and Red	2023-10-14 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219713056	f	\N	\N	\N
6712	Notts Co	Mansfield	2023-10-14 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219387548	f	\N	\N	\N
6713	UKS SMS Lodz (W)	Pogon Szczecin (W)	2023-10-14 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219658630	f	\N	\N	\N
6714	Kisumu All Stars	Kibera Black Stars	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219682325	f	\N	\N	\N
6715	Naivas	SS Assad FC	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219682415	f	\N	\N	\N
6716	Indija	Kolubara Lazarevac	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219690806	f	\N	\N	\N
6717	FK Sloboda Point	Radnicki Novi Beograd	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219690903	f	\N	\N	\N
6718	Mainz II	FC Astoria Walldorf	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219613971	f	\N	\N	\N
6719	Sparta Prague (W)	1 FC Slovacko (W)	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219678549	f	\N	\N	\N
6720	SV Lippstadt	Mgladbach II	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219614783	f	\N	\N	\N
6721	Velbert	Schalke 04 II	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219614242	f	\N	\N	\N
6722	Triestina	Lumezzane	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219625313	f	\N	\N	\N
6723	Augsburg II	Greuther Furth II	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219595609	f	\N	\N	\N
6724	Viktoria Koln	Erzgebirge	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386174	f	\N	\N	\N
6725	Nuova Monterosi	Audace Cerignola	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219557927	f	\N	\N	\N
6726	68 Aksaray Belediyespor	Etimesgut Belediyespor	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219632321	f	\N	\N	\N
6727	Ankara Demirspor	Bucaspor	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219632411	f	\N	\N	\N
6728	Sportist Svoge	Hebar	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219713511	f	\N	\N	\N
6729	Verl	Ingolstadt	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386264	f	\N	\N	\N
6730	Blyth Spartans	Bishops Stortford	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219611137	f	\N	\N	\N
6731	Fortuna Sittard (W)	PSV Eindhoven (W)	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219661384	f	\N	\N	\N
6732	Hessen Kassel	SGV Freiberg	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219614061	f	\N	\N	\N
6733	Alemannia Aachen	FC Wegberg-Beeck	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219614890	f	\N	\N	\N
6734	FC Gutersloh	FC Duren	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219614603	f	\N	\N	\N
6735	Unterhaching	SV Sandhausen	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386358	f	\N	\N	\N
6736	Aurora Pro Patria 1919	Mantova	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219558017	f	\N	\N	\N
6737	Ankaraspor	Kirklarelispor	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219643093	f	\N	\N	\N
6738	SV Stuttgarter Kickers	FSV Frankfurt	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219614151	f	\N	\N	\N
6739	Spartak Pleven	Lokomotiv Sofia	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219713421	f	\N	\N	\N
6740	Duzcespor	Erzincanspor	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219632231	f	\N	\N	\N
6741	Fortuna Dusseldorf II	FC Bocholt	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219614422	f	\N	\N	\N
6742	Rot-Weiss Oberhausen	Wuppertaler	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219614693	f	\N	\N	\N
6743	Freiburg II	Hallescher FC	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219475434	f	\N	\N	\N
6744	Mikkeli	SJK 2	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219635706	f	\N	\N	\N
6745	Aarhus Fremad	Esbjerg	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219553639	f	\N	\N	\N
6746	Roskilde	Thisted	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219660717	f	\N	\N	\N
6747	Pergolettese	A.C. Trento S.C.S.D.	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219558107	f	\N	\N	\N
6748	Jahn Regensburg	Lubeck	2023-10-14 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386082	f	\N	\N	\N
6749	UMS Loum	Fovu Club	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219691438	f	\N	\N	\N
6750	Kucukcekmece Sinop Spor	Gumushanespor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219643583	f	\N	\N	\N
6751	Inegol Kafkas Genclikspor	Edirnespor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219643485	f	\N	\N	\N
6752	Silivrispor	Kutahyaspor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219643763	f	\N	\N	\N
6753	Denizlispor	Inegolspor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219633709	f	\N	\N	\N
6754	Nazilli Belediyespor	Kirsehir Belediyespor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219709814	f	\N	\N	\N
6755	Somaspor Spor Kulubu	76 Igdir Belediyespor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219632625	f	\N	\N	\N
6756	Altinordu	Serik Belediyespor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219632929	f	\N	\N	\N
6757	Belediye Derincespor	Karaman Belediyespor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219632805	f	\N	\N	\N
6758	Sariyer G.K.	Fethiyespor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219632715	f	\N	\N	\N
6759	AS Fortuna Mfou	Les Astres FC de Douala	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219686573	f	\N	\N	\N
6760	Halide Edip Adivarspor	Adiyamanspor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219709290	f	\N	\N	\N
6761	Usakspor	Ispartaspor	2023-10-14 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219632535	f	\N	\N	\N
6762	Sudtirol	WSG Wattens	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219697362	f	\N	\N	\N
6763	Romania U19	San Marino U19	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219671741	f	\N	\N	\N
6764	NK Jadran Dekani	Rudar	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219563540	f	\N	\N	\N
6765	Zrinski Jurjevac	NK Croatia Zmijavci	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219660315	f	\N	\N	\N
6766	Rosengard (W)	Hammarby (W)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219661024	f	\N	\N	\N
6767	MSK Povazska Bystrica	MSK Zilina II	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219605718	f	\N	\N	\N
6768	Nykobing FC	Brabrand	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219660537	f	\N	\N	\N
6769	Paris FC (W)	EA Guingamp (W)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219661294	f	\N	\N	\N
6770	Giouchtas	Panachaiki	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219671561	f	\N	\N	\N
6771	Olympiacos B	Ionikos	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219671651	f	\N	\N	\N
6772	Ljungskile	Torns	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219434286	f	\N	\N	\N
6773	NK Fuzinar	NK Primorje	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219565364	f	\N	\N	\N
6774	Cibalia Vinkovci	NK Sesvete	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219660134	f	\N	\N	\N
6775	Cork City (W)	Treaty United (W)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219516223	f	\N	\N	\N
6776	NK Solin	NK Jarun	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219660405	f	\N	\N	\N
6777	FK Puchov	KFC Komarno	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219605536	f	\N	\N	\N
6778	MFk Dolny Kubin	FK Spisska Nova Ves	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219605626	f	\N	\N	\N
6779	BK Olympic	Vanersborgs IF	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219434016	f	\N	\N	\N
6780	Albion FC	Cerrito	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219661654	f	\N	\N	\N
6781	England U19	Wales U19	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219672191	f	\N	\N	\N
6782	Northern Ireland	San Marino	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219291334	f	\N	\N	\N
6783	Le Havre AC (W)	Lille (W)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219678729	f	\N	\N	\N
6784	Gasogi United	Amagaju	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219685222	f	\N	\N	\N
6785	AB	Skive	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219660627	f	\N	\N	\N
6786	Czech Rep U19	Finland U19	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219672101	f	\N	\N	\N
6787	Bugesera	Gorilla FC	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219661114	f	\N	\N	\N
6788	FK Humenne	Malzenice	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219605808	f	\N	\N	\N
6789	Dravinja Kostroj	NK Bilje	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219565454	f	\N	\N	\N
6790	NK Slovenska Bistrica	Tolmin	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219565274	f	\N	\N	\N
6791	Sunrise FC	Etincelles	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219661204	f	\N	\N	\N
6792	Danubio	Racing Club (Uru)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219520423	f	\N	\N	\N
6793	BK Hacken (W)	Brommapojkarna (W)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219660934	f	\N	\N	\N
6794	Wexford Youths (W)	Peamount United (W)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219516313	f	\N	\N	\N
6795	Ahlafors IF	Aatvidabergs FF	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219434196	f	\N	\N	\N
6796	Ukraine	North Macedonia	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219326571	f	\N	\N	\N
6797	Roa (W)	Lsk Kvinner (W)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219680471	f	\N	\N	\N
6798	Rosenborg BK (W)	Stabaek (W)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219680561	f	\N	\N	\N
6799	Valerenga (W)	Avaldsnes (W)	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219660844	f	\N	\N	\N
6800	Egaleo	Kalamata	2023-10-14 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219661564	f	\N	\N	\N
6801	Finn Harps	Athlone Town	2023-10-14 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219404107	f	\N	\N	\N
6802	Germany U19	N Macedonia U19	2023-10-14 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219671831	f	\N	\N	\N
10125	Pogon Siedlce	Zaglebie Lubin II	2023-10-23 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219891480	f	\N	\N	\N
6824	Farnborough FC	St Albans	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219611047	f	\N	\N	\N
6807	Hampton and Richmond	Dartford	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219610957	f	\N	\N	\N
6810	Ebbsfleet United	Slough Town	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712066	f	\N	\N	\N
6834	Queen of South	Arbroath	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451460	f	\N	\N	\N
6813	Alcoyano	Linares Deportivo	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219583165	f	\N	\N	\N
6815	United IK Nordic	IF Karlstad	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219512839	f	\N	\N	\N
6804	O Magran	Olympique Akbou	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219696666	f	\N	\N	\N
6831	CF Rayo Majadahonda	Sabadell	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582085	f	\N	\N	\N
6818	Bromley	Wealdstone	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712426	f	\N	\N	\N
6805	Shamrock Rovers (W)	Shelbourne (W)	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219698429	f	\N	\N	\N
6827	Wrexham	Salford City	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388093	f	\N	\N	\N
6836	Lunds BK	Oskarshamns AIK	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219433745	f	\N	\N	\N
6825	Grimsby	Accrington	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219387656	f	\N	\N	\N
6837	Raith	Montrose	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451550	f	\N	\N	\N
6823	Southport	Gloucester	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219611497	f	\N	\N	\N
6829	East Kilbride	Hamilton	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451057	f	\N	\N	\N
6811	FC Halifax Town	Marine FC	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219711976	f	\N	\N	\N
6822	Reading	Oxford Utd	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219399653	f	\N	\N	\N
6828	AD Alcorcon II	CD Canillas	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219675303	f	\N	\N	\N
6819	Darlington	Kings Lynn	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219611407	f	\N	\N	\N
6830	USM El Eulma	ES El Ghozlane	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219637735	f	\N	\N	\N
6821	Altrincham	Oldham	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712786	f	\N	\N	\N
6814	Treaty United	Galway Utd	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219411121	f	\N	\N	\N
6832	Dalkurd FF	Orebro Syrianska	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219433925	f	\N	\N	\N
6833	CD Diocesanos	Ponferradina II	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219675213	f	\N	\N	\N
6826	Swindon	Newport County	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219387982	f	\N	\N	\N
6809	MK Dons	Barrow	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386451	f	\N	\N	\N
6835	Brackley Town	Spennymoor Town	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219611227	f	\N	\N	\N
6806	Braintree	Chesham Utd	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712516	f	\N	\N	\N
6808	Falkirk	Queens Park	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451147	f	\N	\N	\N
6816	Yong Sport Academy	Avion Academy FC	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219686663	f	\N	\N	\N
6820	Sandvikens	Hammarby TFF	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219434106	f	\N	\N	\N
6817	Carlisle	Leyton Orient	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219400119	f	\N	\N	\N
10126	Rouen	Avranches	2023-10-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219945531	f	\N	\N	\N
6884	Excursionistas (W)	Club El Porvenir (W)	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219647823	f	\N	\N	\N
6853	Cornella	Union de Salamanca	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582355	f	\N	\N	\N
6838	AFC Fylde	Leek Town FC	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712966	f	\N	\N	\N
6861	Victoria United Limbe	Stade Renard	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219691137	f	\N	\N	\N
6867	UD Rayo Ibense	Patacona CF	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219674456	f	\N	\N	\N
6848	Harrogate Town	Stockport	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386636	f	\N	\N	\N
6844	AFC Wimbledon	Bradford	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219388207	f	\N	\N	\N
6842	Torquay	Maidstone Utd	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219711706	f	\N	\N	\N
6852	Lincoln	Burton Albion	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219399869	f	\N	\N	\N
6855	Alfreton Town	Macclesfield	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712876	f	\N	\N	\N
6851	Morton	Kelty Hearts	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451237	f	\N	\N	\N
6860	Blackpool	Stevenage	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219400227	f	\N	\N	\N
6857	Chesterfield FC	Kettering Town FC	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712246	f	\N	\N	\N
6858	Eastleigh	Dover Athletic	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712156	f	\N	\N	\N
6866	Atletico Levante UD	Villarreal CF III	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219675123	f	\N	\N	\N
6847	Forest Green	Colchester	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219387874	f	\N	\N	\N
6862	Weymouth	Tonbridge Angels	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219610867	f	\N	\N	\N
6863	Peterborough Sports FC	Banbury Utd	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219611317	f	\N	\N	\N
6856	Aveley	Barnet	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712696	f	\N	\N	\N
6859	Warrington Town	South Shields	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219611587	f	\N	\N	\N
6839	Boreham Wood	Welling Utd	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712606	f	\N	\N	\N
6845	Crewe	Tranmere	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219387764	f	\N	\N	\N
6841	Scarborough Athletic	Oxford City	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219711796	f	\N	\N	\N
6843	York City	Needham Market	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219711616	f	\N	\N	\N
6849	Morecambe	Crawley Town	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219461699	f	\N	\N	\N
6850	Walsall	Gillingham	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386734	f	\N	\N	\N
6865	AD Cartaya	AD Ceuta B	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219675480	f	\N	\N	\N
6840	Chelmsford	Whitby Town	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219712336	f	\N	\N	\N
6846	Doncaster	Sutton Utd	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386544	f	\N	\N	\N
6869	Foggia	Brindisi	2023-10-14 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219559630	f	\N	\N	\N
6868	Mirandes	Tenerife	2023-10-14 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219447152	f	\N	\N	\N
6870	SSD Pro Sesto	Padova	2023-10-14 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219557837	f	\N	\N	\N
6872	Dynamo Douala	Aigle Royal de la Menoua	2023-10-14 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219691227	f	\N	\N	\N
6876	USM Alger	USM Khenchela	2023-10-14 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219662759	f	\N	\N	\N
6871	Granada (W)	Real Madrid FC (W)	2023-10-14 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219631702	f	\N	\N	\N
6874	Fauve Azur Elite	Coton S De Garoua	2023-10-14 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219691317	f	\N	\N	\N
6877	Leganes B	CD Las Rozas	2023-10-14 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219701419	f	\N	\N	\N
6873	Arminia Bielefeld	Waldhof Mannheim	2023-10-14 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219403387	f	\N	\N	\N
6878	Asane Football (W)	Lyn (W)	2023-10-14 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219680651	f	\N	\N	\N
6879	Rijeka	Udinese	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219679860	f	\N	\N	\N
6881	UD Montijo	SS Reyes	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219572757	f	\N	\N	\N
6883	CD Carinena	UD Fraga	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219675033	f	\N	\N	\N
6886	Arandina CF	Valladolid B	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219568117	f	\N	\N	\N
6880	CD Illescas	Villanovense	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219572667	f	\N	\N	\N
6887	Cadiz B	Linense	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219571011	f	\N	\N	\N
6882	Longford	Bray Wanderers	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219409669	f	\N	\N	\N
6889	CD Tropezon	CD Naval	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219674853	f	\N	\N	\N
6885	Celta Vigo B	Real Union	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582175	f	\N	\N	\N
6888	CD Padura	CD Basconia	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219674943	f	\N	\N	\N
6890	RCD Mallorca II	Felanitx	2023-10-14 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219674763	f	\N	\N	\N
6893	Manchego Ciudad Real	San Roque Lepe	2023-10-14 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219573673	f	\N	\N	\N
6892	Elche Ilicitano	Atzeneta U.E	2023-10-14 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219675576	f	\N	\N	\N
6891	Niger	Somalia	2023-10-14 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219691667	f	\N	\N	\N
6875	VVV Venlo	Roda JC	2023-10-14 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219467510	t	0	2	199
9620	Bologna	Frosinone	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219332408	t	2	\N	4
6894	Sligo Rovers (W)	Athlone Town (W)	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219698519	f	\N	\N	\N
6895	Como FC (W)	AC Milan (W)	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219713947	f	\N	\N	\N
6913	Karacabey Belediyespor AS	Zonguldakspor	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219633380	f	\N	\N	\N
6915	Mersin Idman Yurdu	1461 Trabzon	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219633290	f	\N	\N	\N
6909	CA Tarazona	CA Osasuna II	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582265	f	\N	\N	\N
6912	SC Kiyovu	Marines FC	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219663128	f	\N	\N	\N
6904	Sibenik	NK Dubrava Zagreb	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219660225	f	\N	\N	\N
6898	FC Tallinn	Viimsi JK	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219682887	f	\N	\N	\N
6900	Club Atletico Saguntino	Torrent CF	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219570291	f	\N	\N	\N
6901	Valencia-Mestalla	CE Europa	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219570741	f	\N	\N	\N
6899	UD Ourense	Deportivo La Coruna II	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219568027	f	\N	\N	\N
6914	Menemen Belediyespor	Kastamonuspor	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219633200	f	\N	\N	\N
6905	Fleury 91 (W)	Dijon (W)	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219663038	f	\N	\N	\N
6916	Slovenia	Finland	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219291442	f	\N	\N	\N
6896	Yeni Orduspor	Aliaga Futbol AS	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219643673	f	\N	\N	\N
6911	Al Hala	Aali Club	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219679282	f	\N	\N	\N
6907	Bahrain SC	Busaiteen Club	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219679462	f	\N	\N	\N
6906	Manama Club	Al Hidd	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219679372	f	\N	\N	\N
6903	Iskenderunspor	Arnavutkoy Belediyesi GVS	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219643003	f	\N	\N	\N
6908	Austria U19	Montenegro U19	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219671921	f	\N	\N	\N
6897	Bulgaria	Lithuania	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219291550	f	\N	\N	\N
6917	The New Saints	East Fife	2023-10-14 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219693889	f	\N	\N	\N
6922	Kerry FC	Waterford	2023-10-14 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219475728	f	\N	\N	\N
6919	Peterhead	Dundee Utd	2023-10-14 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219451327	f	\N	\N	\N
6921	Chelsea (W)	West Ham United (W)	2023-10-14 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219540663	f	\N	\N	\N
6923	Alcantarilla FC	Deportiva Minera	2023-10-14 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219675753	f	\N	\N	\N
6924	Real Sociedad (W)	SD Eibar (W)	2023-10-14 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219569798	f	\N	\N	\N
6918	Sporting Gijon	Zaragoza	2023-10-14 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219447260	f	\N	\N	\N
6920	FC Cartagena	Racing Santander	2023-10-14 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219447368	f	\N	\N	\N
6925	CD Torre Fuerte	Fancesa	2023-10-14 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219692615	f	\N	\N	\N
6927	Ivory Coast	Morocco	2023-10-14 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219544637	f	\N	\N	\N
6926	UE Castelldefels	Olot	2023-10-14 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219680085	f	\N	\N	\N
6932	Platense (W)	SATelevision (W)	2023-10-14 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219648030	f	\N	\N	\N
6928	Excursionistas	San Martin de Burzaco	2023-10-14 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219676546	f	\N	\N	\N
6929	HFX Wanderers	Pacific	2023-10-14 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219664576	f	\N	\N	\N
6930	Club San Juan de Aragon	Tampico Madero	2023-10-14 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219664672	f	\N	\N	\N
6931	Deportiva Venados	Aguacateros de Peribán F.C	2023-10-14 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219687010	f	\N	\N	\N
6933	SC Telstar	MVV Maastricht	2023-10-14 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219476088	f	\N	\N	\N
6934	Deportivo Armenio	Comunicaciones B Aires	2023-10-14 19:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219676366	f	\N	\N	\N
6935	Real Sociedad III	Barakaldo	2023-10-14 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219566377	f	\N	\N	\N
6939	Sevilla FC (W)	Valencia (W)	2023-10-14 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219569169	f	\N	\N	\N
6940	CA Atlas	FC Midland	2023-10-14 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219675935	f	\N	\N	\N
6941	CA Claypole	Justo Jose de Urquiza	2023-10-14 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219676065	f	\N	\N	\N
6937	Hercules	Cerdanyola del Valles	2023-10-14 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219570381	f	\N	\N	\N
6938	Cacereno	Guadalajara	2023-10-14 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219572847	f	\N	\N	\N
6942	General Lamadrid	Sportivo Italiano	2023-10-14 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219676456	f	\N	\N	\N
6943	Real Pilar FC	CSD Liniers de Ciudad Evita	2023-10-14 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219676241	f	\N	\N	\N
6945	Denmark	Kazakhstan	2023-10-14 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219291159	f	\N	\N	\N
6946	Italy	Malta	2023-10-14 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219326451	f	\N	\N	\N
6944	Hungary	Serbia	2023-10-14 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219291038	f	\N	\N	\N
6947	CDSC Iberia	Deportes Valdivia	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219692027	f	\N	\N	\N
6948	Real San Joaquin	CD General Velasquez	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219691937	f	\N	\N	\N
9866	Motala	Dalkurd FF	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220086286	f	\N	\N	\N
9673	Sampdoria	Cosenza	2023-10-22 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219482651	f	\N	\N	\N
6974	Mexicali FC	Colima FC	2023-10-14 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219683826	f	\N	\N	\N
6986	Halcones de Zapopan	Montaneses FC	2023-10-15 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219677966	f	\N	\N	\N
6950	Deportes Rengo Unido	Linares	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219692117	f	\N	\N	\N
6951	Lyon (W)	Saint-Etienne (W)	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219678639	f	\N	\N	\N
6957	USA	Germany	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219448857	f	\N	\N	\N
6955	Sansinena	CA Liniers	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219665375	f	\N	\N	\N
6956	Puerto Rico	Guyana	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219467857	f	\N	\N	\N
6953	Uruguay Montevideo FC	IA Potencia	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219665069	f	\N	\N	\N
6954	Aruba	US Virgin Islands	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219573853	f	\N	\N	\N
6952	Espanyol	Valladolid	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219447476	f	\N	\N	\N
6960	Sarmiento de Resistencia	Club Mutual Crucero del	2023-10-14 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219676817	f	\N	\N	\N
6961	La Luz FC	Liverpool Montevideo	2023-10-14 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219520513	f	\N	\N	\N
6959	Argentino Monte Maiz	Ferro Carril Oeste GP	2023-10-14 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219648123	f	\N	\N	\N
6962	Sportivo Penarol	Huracan Las Heras	2023-10-14 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219676727	f	\N	\N	\N
6965	Uruguay de Coronado	Municipal Turrialba	2023-10-14 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219688153	f	\N	\N	\N
6964	Novorizontino	Tombense MG	2023-10-14 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219251386	f	\N	\N	\N
6963	Ituano	CRB	2023-10-14 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219251656	f	\N	\N	\N
6966	Universidad de Chile (W)	Atletico Nacional (W)	2023-10-14 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219714707	f	\N	\N	\N
6969	Alianza FC (Pan)	Plaza Amador	2023-10-14 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219656259	f	\N	\N	\N
6971	Cavalry	Forge	2023-10-14 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219680336	f	\N	\N	\N
6970	Deportivo Pereira	La Equidad	2023-10-14 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219499458	f	\N	\N	\N
6972	Santa Tecla	AD Isidro Metapan	2023-10-14 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219658018	f	\N	\N	\N
6968	Argentino de Merlo	Los Andes	2023-10-14 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219676636	f	\N	\N	\N
6967	Club Sportivo Ameliano	Sportivo Trinidense	2023-10-14 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219686046	f	\N	\N	\N
6973	Ceara SC Fortaleza	Sampaio Correa FC	2023-10-14 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219251476	f	\N	\N	\N
6977	Artesanos Metepec F.C.	CD Poza Rica	2023-10-14 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219693007	f	\N	\N	\N
6981	CA Huracan (W)	Gimnasia de La Plata (W)	2023-10-14 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219647913	f	\N	\N	\N
6976	Ciervos fc	Zitacuaro CF	2023-10-14 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219677606	f	\N	\N	\N
6975	Deportivo Mixco	Deportivo Coatepeque	2023-10-14 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219655287	f	\N	\N	\N
6978	Bahamas	Antigua and Barbuda	2023-10-14 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219573763	f	\N	\N	\N
6979	Yalmakan FC	Escorpiones FC	2023-10-14 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219678108	f	\N	\N	\N
6980	Wanderers (Uru)	Cerro Largo FC	2023-10-14 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219473393	f	\N	\N	\N
6984	Cafetaleros de Chiapas II	CD Pioneros de Cancun	2023-10-15 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219677876	f	\N	\N	\N
6987	Alebrijes de Oaxaca	Cancun FC	2023-10-15 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219417218	f	\N	\N	\N
6982	Mineros de Fresnillo FC	Tritones Vallarta MFC	2023-10-15 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219677696	f	\N	\N	\N
6985	Deportivo Irapuato FC	Petroleros de Salamanca	2023-10-15 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219683916	f	\N	\N	\N
6988	Atletico Nacional Medellin	Ind Medellin	2023-10-15 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219499188	f	\N	\N	\N
6989	UMECIT	Atletico Chiriqui	2023-10-15 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219684654	f	\N	\N	\N
6991	Guarani (Par)	Deportivo Recoleta	2023-10-15 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219692885	f	\N	\N	\N
6992	Cimarrones de Sonora II	Gavilanes Matamoros	2023-10-15 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219678318	f	\N	\N	\N
6993	Juventud	San Mendo	2023-10-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219687319	f	\N	\N	\N
6990	Palmeiras (W)	Club Olimpia Women	2023-10-15 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219718657	f	\N	\N	\N
6998	Mexico	Ghana	2023-10-15 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219494226	f	\N	\N	\N
6994	Cuiaba	Cruzeiro MG	2023-10-15 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219148003	f	\N	\N	\N
6999	Reboceros de La Piedad	Lobos ULMX	2023-10-15 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219684008	f	\N	\N	\N
6996	Nashville SC	New England	2023-10-15 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219420481	t	2	\N	76
6997	San Antonio FC	Indy Eleven	2023-10-15 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219560726	f	\N	\N	\N
6995	FC Dallas	Colorado	2023-10-15 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219420373	t	2	\N	76
7000	Millonarios	Junior FC Barranquilla	2023-10-15 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.219499278	f	\N	\N	\N
7002	Guastatoya	Huehueteco Xinabajul	2023-10-15 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219655593	f	\N	\N	\N
6983	Tuzos de la UAZ	Leones Negros Udg	2023-10-15 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219678212	f	\N	\N	\N
6854	Atletico Baleares	Atletico Madrid II	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219583075	f	\N	\N	\N
6803	Olimpija	HNK Gorica	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219679770	f	\N	\N	\N
6812	Cambridge Utd	Shrewsbury	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219399761	f	\N	\N	\N
6864	Kidderminster	Ashton Utd	2023-10-14 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219711886	f	\N	\N	\N
7087	CD Brea	AD San Juan	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219567634	f	\N	\N	\N
7089	Deportivo Toluca U23	Monterrey U23	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219720966	f	\N	\N	\N
7097	Cruz Azul U23	Santos Laguna U23	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219721056	f	\N	\N	\N
7099	Wolayta Dicha FC	Adama Kenema fc	2023-10-14 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219720599	f	\N	\N	\N
6910	Cordoba	Merida AD	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582985	f	\N	\N	\N
6902	Paris St-G (W)	Stade Reims (W)	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219662928	f	\N	\N	\N
7124	Athletic Bilbao B	Real Zaragoza II	2023-10-14 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219566468	f	\N	\N	\N
6936	Defensores de Belgrano (W)	CA Belgrano (W)	2023-10-14 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219696758	f	\N	\N	\N
7149	Sol De Mayo	Club Cipolletti	2023-10-14 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219721858	f	\N	\N	\N
6949	CDT Real Oruro	CD Gualberto Villarroel	2023-10-14 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219692705	f	\N	\N	\N
6958	Club Deportivo FATIC	CD Municipal Tarija	2023-10-14 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219696392	f	\N	\N	\N
7192	Halcones de Zapopan	Montaneses FC	2023-10-14 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219677966	f	\N	\N	\N
7011	Ehime	Kitakyushu	2023-10-15 05:55:00	https://www.orbitxch.com/customer/sport/1/market/1.219463174	f	\N	\N	\N
7255	FC Osaka	FC Gifu	2023-10-15 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219463984	f	\N	\N	\N
7256	Kamatamare Sanuki	Tottori	2023-10-15 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219463534	f	\N	\N	\N
7257	Toyama	Azul Claro Numazu	2023-10-15 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219463894	f	\N	\N	\N
7258	Melbourne Victory (W)	Brisbane Roar FC (W)	2023-10-15 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219613697	f	\N	\N	\N
7259	Vanraure Hachinohe	Kagoshima Utd	2023-10-15 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219463354	f	\N	\N	\N
7260	Shatin SA	South China	2023-10-15 06:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219739279	f	\N	\N	\N
7261	Wing Yee	Wong Tai Sin	2023-10-15 06:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219739369	f	\N	\N	\N
7262	Nagoya	Fukuoka	2023-10-15 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219638997	f	\N	\N	\N
7195	Mexicali FC	Colima FC	2023-10-15 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219683826	f	\N	\N	\N
7001	Atletico Independiente	San Francisco FC	2023-10-15 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219656169	f	\N	\N	\N
7003	Wellington Phoenix (W)	Melbourne City (W)	2023-10-15 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219466605	f	\N	\N	\N
7004	Las Vegas Lights FC	San Diego Loyal SC	2023-10-15 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219560636	f	\N	\N	\N
7263	Wofoo Tai Po	Hong Kong FC	2023-10-15 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219740762	f	\N	\N	\N
7006	Los Cabos United	Tecos FC	2023-10-15 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219692795	f	\N	\N	\N
7007	Adelaide United (W)	Canberra United (W)	2023-10-15 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219628524	f	\N	\N	\N
7010	FC Imabari	Yokohama SCC	2023-10-15 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219463264	f	\N	\N	\N
7009	Matsumoto	Nagano Parceiro	2023-10-15 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219463624	f	\N	\N	\N
7008	Tegevajaro Miyazaki	Sagamihara	2023-10-15 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219463714	f	\N	\N	\N
9718	Deportivo La Coruna II	Zamora	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219895766	f	\N	\N	\N
7264	Kyrgyzstan	Philippines	2023-10-15 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219749634	f	\N	\N	\N
7005	LA Galaxy	Real Salt Lake	2023-10-15 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219422337	t	2	\N	76
7266	Beijing Tech FC	Jiangxi Dark Horse Junior	2023-10-15 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219695992	f	\N	\N	\N
7267	Yanbian Longding	Guangxi Baoyun	2023-10-15 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219696262	f	\N	\N	\N
7268	Hubei Chufeng Heli	Yunnan Yukun	2023-10-15 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219695812	f	\N	\N	\N
7265	Wuxi Wugou	Shenyang Urban FC	2023-10-15 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219696172	f	\N	\N	\N
7270	3 Sing FC	Yuen Long	2023-10-15 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219739099	f	\N	\N	\N
7271	Central & West DR & SA	Kowloon City FC	2023-10-15 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219739189	f	\N	\N	\N
7272	Citizen AA	Sai Kung	2023-10-15 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219738919	f	\N	\N	\N
7273	Hoi King SA	Eastern District SA	2023-10-15 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219739009	f	\N	\N	\N
7274	PSPS Pekanbaru	PSMS Medan	2023-10-15 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219733034	f	\N	\N	\N
7275	Persipa Pati	Deltras Sidoarjo	2023-10-15 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219732944	f	\N	\N	\N
7276	Urawa	Yokohama FM	2023-10-15 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219638907	f	\N	\N	\N
7277	FC Petrzalka	Tatran Lip Mikulas	2023-10-15 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219605922	f	\N	\N	\N
7278	Betis B	UCAM Murcia	2023-10-15 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219570831	f	\N	\N	\N
7279	FC La Union Atletico	El Palo	2023-10-15 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219571207	f	\N	\N	\N
7280	AD Parla	Trival Valderas	2023-10-15 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219740473	f	\N	\N	\N
9941	Al Riyadh SC	Al-Ettifaq	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219609529	f	\N	\N	\N
7281	AD Torrejon	FC Villanueva del Pardillo	2023-10-15 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219740337	f	\N	\N	\N
7282	CD Siete Villas	CD Laredo	2023-10-15 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219733911	f	\N	\N	\N
7283	FE Grama	Reus FC Reddis	2023-10-15 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219733793	f	\N	\N	\N
7284	Southern District	Eastern AA	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219741678	f	\N	\N	\N
7285	AD Ceuta FC	CD Castellon	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582625	f	\N	\N	\N
7286	UDG Tenerife Sur (W)	Betis (W)	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219569079	f	\N	\N	\N
7287	Santa Eulalia	Espanyol B	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219570561	f	\N	\N	\N
7288	Terrassa	CE Andratx	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219569888	f	\N	\N	\N
7292	Ibiza Eivissa	Recreativo Huelva	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582805	f	\N	\N	\N
7293	Real Murcia	Algeciras	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582715	f	\N	\N	\N
7294	Pablo De Mafumet	UE Tona	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219734001	f	\N	\N	\N
7295	Real Jaen	Motril CF	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219739831	f	\N	\N	\N
7296	Socuellamos	Azuqueca	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219741302	f	\N	\N	\N
7297	UD Logrones II	Casalarreina CF	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219742582	f	\N	\N	\N
7298	Centre d'Esports Manresa	SD Formentera	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219570079	f	\N	\N	\N
7299	La Nucia	SE Penya Independent	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219570471	f	\N	\N	\N
7300	CD Calamonte	Jerez CF	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219742132	f	\N	\N	\N
7301	CF Pozuelo de Alarcon	Rayo Vallecano B	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219739647	f	\N	\N	\N
7302	Sporting Gijon B	SD Lenense	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219734181	f	\N	\N	\N
7303	Sporting de Huelva (W)	Madrid (W)	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219512749	f	\N	\N	\N
7304	CD Estepona	Mar Menor CF	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219571117	f	\N	\N	\N
7305	UD Barbastro	CD Alaves B	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219566918	f	\N	\N	\N
7306	CP San Cristobal	Rapitenca	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219734091	f	\N	\N	\N
7307	Albacete Balompie II	CD Toledo II	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219741482	f	\N	\N	\N
7308	Real Oviedo II	Coruxo	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219567937	f	\N	\N	\N
7289	CD Cuarte	CD Belchite 97	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219741032	f	\N	\N	\N
7290	CD Mostoles	CD Paracuellos Antamira	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219740137	f	\N	\N	\N
7291	CD Utrera	Cordoba CF II	2023-10-15 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219741861	f	\N	\N	\N
7312	Excelsior (W)	Feyenoord (W)	2023-10-15 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219710920	f	\N	\N	\N
7313	Pomigliano (W)	SSD Fiorentina WFC (W)	2023-10-15 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219722993	f	\N	\N	\N
7314	CF Trujillo	CF Jaraiz	2023-10-15 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219742222	f	\N	\N	\N
7315	SD Rayo Cantabria	CD Cayon	2023-10-15 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219567830	f	\N	\N	\N
7316	Southampton (W)	Durham (W)	2023-10-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219727873	f	\N	\N	\N
7317	CD Atletico Paso	Getafe B	2023-10-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219573043	f	\N	\N	\N
7318	Man Utd (W)	Leicester City (W)	2023-10-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219541023	f	\N	\N	\N
7319	Aalborg BK (W)	Koge (W)	2023-10-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219711243	f	\N	\N	\N
7320	AZS UJ Krakow (W)	GKS Katowice (W)	2023-10-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219711029	f	\N	\N	\N
7321	Angelholms	Ariana FC	2023-10-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219535438	f	\N	\N	\N
7322	Eskilsminne	Tvaakers	2023-10-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219461429	f	\N	\N	\N
7323	Umea FC	Motala	2023-10-15 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219461519	f	\N	\N	\N
7324	Shanghai Jiading	Hebei KungFu	2023-10-15 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219711333	f	\N	\N	\N
7325	Sivas Belediyespor	Erbaaspor	2023-10-15 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219716317	f	\N	\N	\N
7326	Fatsa Belediyespor	Tepecik Belediye	2023-10-15 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219716497	f	\N	\N	\N
7327	Sebat Genclik Spor	Cankaya	2023-10-15 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219716939	f	\N	\N	\N
7328	Dongguan Guanlian	Sichuan Jiuniu FC	2023-10-15 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219732763	f	\N	\N	\N
7329	Karbel Karakopru	Kusadasispor	2023-10-15 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219716227	f	\N	\N	\N
7330	SSV Ulm	Dynamo Dresden	2023-10-15 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219446446	f	\N	\N	\N
7331	Putra Safin Group	Perserang Serang	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219732854	f	\N	\N	\N
7333	Bodens	IFK Stocksund	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219535528	f	\N	\N	\N
7334	ANADOLU UNIVERSITY	Batman Petrolspor	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219716047	f	\N	\N	\N
7335	Juve Stabia	Catania	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219557657	f	\N	\N	\N
7332	Entella	Gubbio	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219625496	f	\N	\N	\N
9736	Gornik Zabrze	Rakow Czestochowa	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219408933	f	\N	\N	\N
10006	Fraijanes FC	Cuilapa FC	2023-10-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220084050	f	\N	\N	\N
9787	ADR Jicaral	AD Barrio Mexico	2023-10-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220014357	f	\N	\N	\N
7337	ACR Messina	FC Giugliano	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219557567	f	\N	\N	\N
7338	Benevento	AZ Picerno ASD	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219667940	f	\N	\N	\N
7339	Giana Erminio	Pro Vercelli	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219560330	f	\N	\N	\N
7340	Perugia	Sassari Torres	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219667488	f	\N	\N	\N
7341	Tilikratis Lefkadas	Ilioupoli	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219674217	f	\N	\N	\N
7342	Man City (W)	Bristol City (W)	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219540573	f	\N	\N	\N
7343	Spartans WFC (W)	Hearts (W)	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219735601	f	\N	\N	\N
7344	TSV Havelse	SV Meppen	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219595330	f	\N	\N	\N
7345	Talasgucu Belediyespor	Kirikkale Buyuk Anadolusp	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219715267	f	\N	\N	\N
7346	Burgos	Villarreal B	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219461092	f	\N	\N	\N
7347	Rangers (W)	Hibernian (W)	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219735748	f	\N	\N	\N
7348	Osmaniyespor 2011	Darica Genclerbirligi	2023-10-15 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219715777	f	\N	\N	\N
7350	Efeler 09	Pazarspor	2023-10-15 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219715867	f	\N	\N	\N
9786	Aurora FC	Deportivo Mictlan	2023-10-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220049537	f	\N	\N	\N
7352	Bergama Belediyespor	Or1967 Futbol Isletmeciligi	2023-10-15 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219716637	f	\N	\N	\N
7353	Bulvarspor	Amasyaspor 1968 FK	2023-10-15 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219716137	f	\N	\N	\N
7354	Bursa Yildirim Spor	Mus Spor	2023-10-15 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219716727	f	\N	\N	\N
7355	Estudiantes de La Plata (W)	River Plate (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714127	f	\N	\N	\N
7356	Sunderland (W)	Reading (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219727963	f	\N	\N	\N
7357	Georgia	Cyprus	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219459369	f	\N	\N	\N
7358	Sheffield United (W)	Birmingham (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219728255	f	\N	\N	\N
7359	FK Smederevo	OFK Beograd	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714037	f	\N	\N	\N
7360	Blackburn Rovers (W)	Charlton (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714889	f	\N	\N	\N
7361	Kristianstads (W)	KIF Orebro Dff (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219715069	f	\N	\N	\N
7362	Crystal Palace (W)	London City Lionesses	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714799	f	\N	\N	\N
7363	Watford (W)	Lewes (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219728053	f	\N	\N	\N
7364	Thisted (W)	Brondby (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714347	f	\N	\N	\N
7365	Linkopings FC (W)	Växjö DFF (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714979	f	\N	\N	\N
7366	Arsenal (W)	Aston Villa (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219540753	f	\N	\N	\N
7367	Ilirija Extra-Lux	Beltinci	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219565093	f	\N	\N	\N
7368	Aberdeen (W)	Glasgow City (W)	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219735267	f	\N	\N	\N
7369	Nafta Lendava	Triglav	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219565184	f	\N	\N	\N
7370	HNK Orijent 1919	NK Dugopolje	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714217	f	\N	\N	\N
7371	Levadiakos	Apollon Kalamaria FC	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219674127	f	\N	\N	\N
7372	AS Kigali	Police FC	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219713857	f	\N	\N	\N
7373	Makedonikos	Anagennisi Karditsas	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219674037	f	\N	\N	\N
7374	Miramar Misiones	CA Rentistas	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714527	f	\N	\N	\N
7375	Niki Volou	Kozani FC	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219673946	f	\N	\N	\N
7376	Etoile de l'Est	Rwamagana City FC	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219736650	f	\N	\N	\N
7377	Falkenbergs	FC Trollhattan	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219473269	f	\N	\N	\N
7378	Musanze	Rayon Sports FC	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219713767	f	\N	\N	\N
7379	FC St. Pauli U19	SV Meppen U19	2023-10-15 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219714437	f	\N	\N	\N
7387	Taby FK	Vasalunds IF	2023-10-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219461609	f	\N	\N	\N
7386	Dfo Pardubice (W)	Slavia Prague (W)	2023-10-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219678459	f	\N	\N	\N
7384	Union Sportive de Douala	Bamboutos FC de Mbouda	2023-10-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219732545	f	\N	\N	\N
7383	UCAM Murcia CF B	Union Molinense CF	2023-10-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219741952	f	\N	\N	\N
7382	SD Compostela	RC Villalbes	2023-10-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219567724	f	\N	\N	\N
7381	San Fernando CD	Granada B	2023-10-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582895	f	\N	\N	\N
7385	AS Roma (W)	Inter Milan (W)	2023-10-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219715687	f	\N	\N	\N
7380	Wexford F.C	Cobh Ramblers	2023-10-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219553729	f	\N	\N	\N
7388	Cruzeiro U20	Gremio FBPA U20	2023-10-15 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219756660	f	\N	\N	\N
7390	Recanatese	Arezzo	2023-10-15 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219667578	f	\N	\N	\N
7391	Virtus Francavilla	Sorrento	2023-10-15 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219626016	f	\N	\N	\N
7389	LR Vicenza Virtus	Renate	2023-10-15 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219625404	f	\N	\N	\N
9788	Universidad San Carlos	San Benito FC	2023-10-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220039285	f	\N	\N	\N
7396	Carrarese	Ancona	2023-10-15 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219625638	f	\N	\N	\N
7395	Eldense	Elche	2023-10-15 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219460984	f	\N	\N	\N
7392	US Latina Calcio	Monopoli	2023-10-15 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219557747	f	\N	\N	\N
7394	Barcelona B	CD Teruel	2023-10-15 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219581905	f	\N	\N	\N
7393	Andorra CF	Alcorcon	2023-10-15 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219460876	f	\N	\N	\N
7400	Levante UD (W)	Levante Las Planas (W)	2023-10-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219568989	f	\N	\N	\N
7401	IF Sylvia	Pitea	2023-10-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219535618	f	\N	\N	\N
7398	Preussen Munster	1860 Munich	2023-10-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219454252	f	\N	\N	\N
7399	Marbella	FC Cartagena II	2023-10-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219571297	f	\N	\N	\N
7403	Cambuur Leeuwarden	NAC Breda	2023-10-15 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219469128	t	2	\N	199
7404	Fernandez Vial	CSD San Antonio Unido	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219733230	f	\N	\N	\N
7422	Naxara CD	CD Calahorra	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219567244	f	\N	\N	\N
7421	Marino Luanco	UP Langreo	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219567346	f	\N	\N	\N
7411	Salamanca UDS	Real Avila CF	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219739741	f	\N	\N	\N
7413	Real Aviles	Guijuelo	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219567544	f	\N	\N	\N
7405	AD Llerenense	CD Mensajero	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219573223	f	\N	\N	\N
7419	Motherwell (W)	Dundee United (W)	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219735357	f	\N	\N	\N
7415	Hamilton WFC (W)	Montrose FC (W)	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219735450	f	\N	\N	\N
7420	Yeclano Deportivo	Velez CF	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219573493	f	\N	\N	\N
7412	CD Covadonga	RS Gimnastica	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219567453	f	\N	\N	\N
7408	Krka	NK Brinje Grosuplje	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219565003	f	\N	\N	\N
7407	CD Izarra	Valle de Egüés	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219567024	f	\N	\N	\N
7409	CD Badajoz	CDE Ursaria	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219573313	f	\N	\N	\N
7406	Numancia	CDA Navalcarnero	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219573133	f	\N	\N	\N
7423	SD Gernika Club	Arenas Club de Getxo	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219566558	f	\N	\N	\N
7418	UD Alzira	UE Sant Andreu	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219570651	f	\N	\N	\N
7410	CD Binefar	CD Caspe	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219741122	f	\N	\N	\N
7416	SD Solares	CD Bezana	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219734271	f	\N	\N	\N
7417	Silla CF	UD Castellonense	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219740047	f	\N	\N	\N
7414	Brighton (W)	Tottenham (W)	2023-10-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219540843	f	\N	\N	\N
7424	Partick Thistle (W)	Celtic (W)	2023-10-15 16:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219724634	f	\N	\N	\N
7425	CD Utrillas	AD Almudevar	2023-10-15 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219740942	f	\N	\N	\N
7435	CD Marchamalo	UB Conquense	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219741212	f	\N	\N	\N
7434	CD Don Alvaro	Olivenza	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219742312	f	\N	\N	\N
7429	Arosa FC	CD Estradense	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219734631	f	\N	\N	\N
7427	Badalona	AE Prat	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219734361	f	\N	\N	\N
7426	Liverpool (W)	Everton (W)	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219540933	f	\N	\N	\N
7433	CD Algar	CAP Ciudad de Murcia	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219742042	f	\N	\N	\N
7432	CCD Alberite	CA Rivers Ebro	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219742492	f	\N	\N	\N
7436	SD Ejea	CD Ebro	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219740852	f	\N	\N	\N
7431	SRD Vimenor CF	CD Colindres	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219734463	f	\N	\N	\N
7430	Progreso	Bella Vista	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219718567	f	\N	\N	\N
7441	East Riffa	Al-Ettifaq	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219756570	f	\N	\N	\N
7437	Al Riffa	Sitra	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219728606	f	\N	\N	\N
7440	Aguilas	Sevilla B	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219573583	f	\N	\N	\N
7444	CD Acero	CF Gandia	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219739957	f	\N	\N	\N
7442	Balikesirspor	Kestel Spor	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219716817	f	\N	\N	\N
7443	Juventus FC (W)	Sassuolo (W)	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219723083	f	\N	\N	\N
7447	Antequera CF	Intercity Sant Joan C.F	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582535	f	\N	\N	\N
7439	Czech Republic	Faroe Islands	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219477297	t	0	1	274
7446	Switzerland	Belarus	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219459597	t	1	6	274
7445	CD Coria	CP Montehermoso	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219742402	f	\N	\N	\N
7438	Utebo CF	Tudelano	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219566738	f	\N	\N	\N
9790	Deportivo Coatepeque	Guastatoya	2023-10-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219925102	f	\N	\N	\N
7465	ADR Jicaral	A.D. Cofutpa	2023-10-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219724405	f	\N	\N	\N
7469	Ponte Preta	Atletico Go	2023-10-15 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219683278	f	\N	\N	\N
9789	Arenas Armilla	UD Torre del Mar	2023-10-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220020611	f	\N	\N	\N
7449	Lugo	SD Logrones	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219581635	f	\N	\N	\N
7456	Macva Sabac	FK Dubocica	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219718784	f	\N	\N	\N
7452	UD Logrones	UD Mutilvera	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219567134	f	\N	\N	\N
7450	Ponferradina	Deportivo	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219581995	f	\N	\N	\N
7454	Karabuk Idmanyurdu	Kepez Belediyespor	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219715177	f	\N	\N	\N
7457	Metalac Gornji Milanovac	FK Jedinstvo Ub	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219718874	f	\N	\N	\N
7455	Karsiyaka	Ergene Velimese SK	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219716407	f	\N	\N	\N
7453	Zamora	Pontevedra CF	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219566287	f	\N	\N	\N
7448	Gimnastica Segoviana CF	AD Union Adarve	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219573403	f	\N	\N	\N
7458	Atletico Madrid (W)	Barcelona (W)	2023-10-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219486122	f	\N	\N	\N
7462	Cesena	USD Sestri Levante 1919	2023-10-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219626252	f	\N	\N	\N
7463	Spal	Fermana	2023-10-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219625762	f	\N	\N	\N
7461	Eibar	Huesca	2023-10-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219456305	f	\N	\N	\N
7459	Leganes	Amorebieta	2023-10-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219460768	f	\N	\N	\N
7460	CF Badalona Futur	Lleida	2023-10-15 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219570180	f	\N	\N	\N
7464	Caja Oblatos C.FD	Chilpancingo	2023-10-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219722903	f	\N	\N	\N
7467	Alianza Universidad	Uni San Martin	2023-10-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219686143	f	\N	\N	\N
7466	Xerez Deportivo FC	Ayamonte	2023-10-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219741771	f	\N	\N	\N
7468	AD Aserri	Escorpiones FC	2023-10-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219724315	f	\N	\N	\N
7475	Lanus (W)	Racing (W)	2023-10-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219722586	f	\N	\N	\N
7472	Sociedad B	Leonesa	2023-10-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219581725	f	\N	\N	\N
7471	Real Madrid Castilla	Atletico Sanluqueno CF	2023-10-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219582445	f	\N	\N	\N
7470	Arenteiro	Sestao River	2023-10-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219581815	f	\N	\N	\N
7474	Cruz Azul (W)	Club Tijuana (W)	2023-10-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219722813	f	\N	\N	\N
7473	Puebla FC (W)	CF America (W)	2023-10-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219722723	f	\N	\N	\N
7476	River Plate (Uru)	Boston River	2023-10-15 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219520603	f	\N	\N	\N
7484	ASEEV GO	AE Jataiense	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219753241	f	\N	\N	\N
7488	Ferro Carril Oeste	Aldosivi	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526384	f	\N	\N	\N
7481	CD MAIPU	Independiente Rivadavia	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526204	f	\N	\N	\N
7483	Club Atletico el Linqueno	Gimnasia Conc del Urug	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219726628	f	\N	\N	\N
7486	Centro Oeste SAF	Aparecida EC	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219753331	f	\N	\N	\N
7487	Santa Helena	Goiatuba EC	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219753421	f	\N	\N	\N
7485	Atletico Rafaela	Chacarita	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526654	f	\N	\N	\N
7482	Gimnasia Jujuy	Deportivo Riestra	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526114	f	\N	\N	\N
7479	Brown de Adrogue	CA Atlanta	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526564	f	\N	\N	\N
7480	Deportivo Madryn	Atletico Mitre	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526474	f	\N	\N	\N
7489	Quilmes	CA Rac Cordoba	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526742	f	\N	\N	\N
7477	Villa Dalmine	Chaco For Ever	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526024	f	\N	\N	\N
7492	Romania	Andorra	2023-10-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219476865	f	\N	\N	\N
7494	Norway	Spain	2023-10-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219343971	f	1	1	274
7490	Poland	Moldova	2023-10-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219477406	f	\N	\N	\N
7493	Wales	Croatia	2023-10-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219343851	f	\N	\N	\N
7495	CD Trasandino	Deportes Limache	2023-10-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219756318	f	\N	\N	\N
7497	Real Mizque	Universitario De Pando	2023-10-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219756094	f	\N	\N	\N
7496	Deportes Melipilla	Deportes Concepcion	2023-10-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219756408	f	\N	\N	\N
7502	Tigre	Newells	2023-10-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219186012	f	\N	\N	\N
7499	Sarmiento de Junin	Racing Club	2023-10-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219189689	f	\N	\N	\N
7501	Def Belgrano VR	CA Union de Sunchales	2023-10-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219722493	f	\N	\N	\N
7500	Atenas	Tacuarembo	2023-10-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219726448	f	\N	\N	\N
7498	CD Hiska Nacional	Real Potosi	2023-10-15 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219756004	f	\N	\N	\N
7351	Willem II	Den Bosch	2023-10-15 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219489035	t	2	\N	199
7397	Taranto Sport	Crotone	2023-10-15 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219626157	f	\N	\N	\N
7402	CD Galapagar	Collado Villalba	2023-10-15 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219739551	f	\N	\N	\N
7428	CDB Atletico Tomelloso	CD Quintanar del Rey	2023-10-15 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219741392	f	\N	\N	\N
7451	Etihad Al Reef	Buri FC	2023-10-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219728514	f	\N	\N	\N
7629	Calor de San Pedro	CF Orgullo de Reynosa	2023-10-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219781765	f	\N	\N	\N
7478	Estudiantes de Caseros	Tristan Suarez	2023-10-15 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526294	f	\N	\N	\N
7650	Ponte Preta	Atletico Go	2023-10-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219683278	f	\N	\N	\N
7503	Provincial Osorno	Lautaro de Buin	2023-10-15 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219733342	f	\N	\N	\N
7504	Club Defensores de P	CA Douglas Haig	2023-10-15 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219722313	f	\N	\N	\N
7505	Olimpo	Santamarina	2023-10-15 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219722403	f	\N	\N	\N
7508	Limon Black Star	Guadalupe F.C	2023-10-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219724135	f	\N	\N	\N
7509	Quepos Cambute	Municipal Garabito	2023-10-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219724045	f	\N	\N	\N
7506	San Martin De Formosa	Club Gimnasia y Tiro	2023-10-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219726806	f	\N	\N	\N
7510	Santa Rosa FC	Comerciantes FC	2023-10-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219726538	f	\N	\N	\N
7511	Atletico Palmaflor Vinto	Jorge Wilstermann	2023-10-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219661474	f	\N	\N	\N
7507	AD Cariari Pococi	Municipal Santa Ana	2023-10-15 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219724225	f	\N	\N	\N
7512	Londrina	Avai	2023-10-15 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219683170	f	\N	\N	\N
7513	Corinthians (W)	America de Cali (W)	2023-10-15 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219732669	f	\N	\N	\N
7519	Achuapa FC	Xelaju	2023-10-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219655683	f	\N	\N	\N
7516	Costa del Este	Tauro FC	2023-10-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219655989	f	\N	\N	\N
7514	Sportivo AC Las Parejas	Independiente Chivilcoy	2023-10-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219726718	f	\N	\N	\N
7517	Amazonas FC	Brusque FC	2023-10-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219658540	f	\N	\N	\N
7518	Rionegro	Alianza Petrolera	2023-10-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219499368	f	\N	\N	\N
7521	Platense Zacatecoluca	CD Municipal Limeno	2023-10-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219658108	f	\N	\N	\N
7520	CD Dragon	CD Aguila	2023-10-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219657928	f	\N	\N	\N
7515	EC Vitoria Salvador	Guarani	2023-10-15 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219251747	f	\N	\N	\N
7522	CD Luis Angel Firpo	Jocoro	2023-10-15 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219658198	f	\N	\N	\N
7523	Nacional (Uru)	Cerro	2023-10-15 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219520693	f	\N	\N	\N
7524	CA Central Norte	C J Antoniana	2023-10-15 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219722223	f	\N	\N	\N
7525	Real Apodaca FC	Coras de Nayarit FC	2023-10-15 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219756228	f	\N	\N	\N
7529	Deportivo Cali	America de Cali S.A	2023-10-16 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219499008	f	\N	\N	\N
7526	St Kitts & Nevis	Sint Maarten	2023-10-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219734853	f	\N	\N	\N
7530	Herrera FC	CD Universitario	2023-10-16 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219656079	f	\N	\N	\N
7532	Haiti	Jamaica	2023-10-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219732237	f	\N	\N	\N
7535	Guadalajara (W)	Pumas UNAM (W)	2023-10-16 01:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219734643	f	\N	\N	\N
7531	CF America	Guadalajara	2023-10-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219679680	f	\N	\N	\N
7533	Honduras	Cuba	2023-10-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219732417	f	\N	\N	\N
7534	Suriname	Grenada	2023-10-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219732327	f	\N	\N	\N
7536	Talleres	Boca Juniors	2023-10-16 01:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219738203	f	\N	\N	\N
7713	CF America	Guadalajara	2023-10-16 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219679680	f	\N	\N	\N
7538	Venados FC	Dorados	2023-10-16 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219468798	f	\N	\N	\N
7537	Club Atletico Morelia	Atlante	2023-10-16 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219469038	f	\N	\N	\N
7539	Tolima	Santa Fe	2023-10-16 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.219499098	f	\N	\N	\N
7540	Club Atletico La Paz	Mineros de Zacatecas	2023-10-16 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219468948	f	\N	\N	\N
7718	China	Uzbekistan	2023-10-16 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.219753950	f	\N	\N	\N
7491	Turkey	Latvia	2023-10-15 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219459423	f	1	\N	274
7527	Atletico San Luis (W)	Tigres (W)	2023-10-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219731524	f	\N	\N	\N
7528	Club Necaxa (W)	FC Atlas (W)	2023-10-16 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219734451	f	\N	\N	\N
7707	SC Internacional (W)	Colo Colo (W)	2023-10-16 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219792694	f	\N	\N	\N
7719	Charlton U21	Millwall U21	2023-10-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219762622	f	\N	\N	\N
7720	FK Mladost Novi Sad	FK Graficar	2023-10-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219764806	f	\N	\N	\N
7721	FK Vrsac	RFK Novi Sad	2023-10-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219764626	f	\N	\N	\N
7722	FK Radnicki Sremska	Tekstilac Odzaci	2023-10-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219764716	f	\N	\N	\N
7723	Fleetwood Town U21	Birmingham U21	2023-10-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219764535	f	\N	\N	\N
7724	Misr El Makasa	Proxy Work Club	2023-10-16 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219798725	f	\N	\N	\N
9791	AD Cariari Pococi	Futbol Consultants Moravia	2023-10-22 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220014447	f	\N	\N	\N
7742	Alvarado	Defensores Unidos	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219532169	f	\N	\N	\N
7727	CA Independiente (W)	CA Banfield (W)	2023-10-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219765198	f	\N	\N	\N
7725	Botswana	Eswatini	2023-10-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219791422	f	\N	\N	\N
7728	Club Ferro Carril Oeste (W)	CA Estudiantes (W)	2023-10-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219765288	f	\N	\N	\N
7729	Mozambique	Nigeria	2023-10-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219766148	f	\N	\N	\N
7730	Al Khalidiyah	Al-Shabbab (BRN)	2023-10-16 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219733124	f	\N	\N	\N
7731	Germany U20	Czech Republic U20	2023-10-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219790023	f	\N	\N	\N
7732	Algeria	Egypt	2023-10-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219657626	f	\N	\N	\N
7733	Azerbaijan	Austria	2023-10-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219477189	f	\N	\N	\N
7734	Norway U20	Romania U20	2023-10-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219782754	f	\N	\N	\N
7735	Olimpia Grudziadz	LKS Lodz II	2023-10-16 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219606264	f	\N	\N	\N
7736	Ukraine U21	England U21	2023-10-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219590477	f	\N	\N	\N
7737	Stade Abidjan	Stella Club d'Adjame	2023-10-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219784017	f	\N	\N	\N
7738	Sud America	Club Oriental de La Paz	2023-10-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219769245	f	\N	\N	\N
7749	Patronato	Agropecuario	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219529139	f	\N	\N	\N
7748	Flandria	San Martin de San Juan	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526925	f	\N	\N	\N
7747	Estudiantes Rio Cuarto	Nueva Chicago	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219529229	f	\N	\N	\N
7752	Pescara	Pesaro	2023-10-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219560126	f	\N	\N	\N
7739	Almirante Brown	CA Temperley	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219525934	f	\N	\N	\N
7744	Senegal	Cameroon	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219642913	f	\N	\N	\N
7750	Potenza	AP Turris Calcio	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219559540	f	\N	\N	\N
7740	Northern Ireland U21	Serbia U21	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219590567	f	\N	\N	\N
7743	CA Guemes	Almagro BA	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219762868	f	\N	\N	\N
7745	Defensores de Belgrano	San Martin de Tucuman	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219526835	f	\N	\N	\N
7746	Deportivo Moron	San Telmo	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219527015	f	\N	\N	\N
7741	Gimnasia Mendoza	Guillermo Brown	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219529409	f	\N	\N	\N
7756	Iceland	Liechtenstein	2023-10-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219476382	f	\N	\N	\N
7758	Casertana	Avellino	2023-10-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219794317	f	\N	\N	\N
7754	Bosnia	Portugal	2023-10-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219477461	f	\N	\N	\N
7768	Queretaro (W)	Pachuca (W)	2023-10-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219780139	f	\N	\N	\N
7751	Belgium	Sweden	2023-10-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219477822	t	2	\N	274
7753	Pontedera	Rimini	2023-10-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219560216	f	\N	\N	\N
7757	Luxembourg	Slovakia	2023-10-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219476756	f	\N	\N	\N
7760	Banfield	Atl Tucuman	2023-10-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219186438	f	\N	\N	\N
7761	Levante	Racing de Ferrol	2023-10-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219460603	f	\N	\N	\N
7763	Saint Martin	Anguilla	2023-10-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219743169	f	\N	\N	\N
7762	Turks and Caicos Islands	British Virgin Islands	2023-10-16 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219755881	f	\N	\N	\N
7764	Boca Juniors de Cali	Fortaleza FC	2023-10-16 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219734993	f	\N	\N	\N
7765	Talleres (RE)	CA San Miguel	2023-10-16 21:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219775680	f	\N	\N	\N
7766	Central Cordoba (SdE)	Lanus	2023-10-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219351520	f	\N	\N	\N
7767	Leones FC	Real Cartagena	2023-10-16 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219692207	f	\N	\N	\N
7771	Juventude	Sport Recife	2023-10-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219353784	f	\N	\N	\N
7772	Atletico Huila	Envigado	2023-10-17 00:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219544727	f	\N	\N	\N
7769	Defensa y Justicia	Belgrano	2023-10-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219331483	f	\N	\N	\N
7770	French Guyana	St Vincent & Grenadines	2023-10-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219753084	f	\N	\N	\N
7773	Dominican Republic	Barbados	2023-10-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219735982	f	\N	\N	\N
7774	Monterrey (W)	Mazatlan FC(W)	2023-10-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219782460	f	\N	\N	\N
7775	Club Leon FC (W)	Toluca (W)	2023-10-17 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219782368	f	\N	\N	\N
7776	Atletico Bucaramanga	Boyaca Chico	2023-10-17 02:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219530522	f	\N	\N	\N
7777	Nicaragua	Montserrat	2023-10-17 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219752938	f	\N	\N	\N
7759	Greece	Netherlands	2023-10-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219477701	t	0	1	274
7726	MO Constantine	AS Khroub	2023-10-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219692525	f	\N	\N	\N
7785	Uzbekistan U23	Egypt U23	2023-10-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219803808	f	\N	\N	\N
7788	Raya Sporting FC	Nasr Taaden	2023-10-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219801905	f	\N	\N	\N
7789	SOL FC	Zoman FC	2023-10-16 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219803718	f	\N	\N	\N
7796	Rosenborg BK 2	Verdal IL	2023-10-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219803538	f	\N	\N	\N
7799	Vianopolis U20	Jataiense U20	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219807583	f	\N	\N	\N
7800	AA Aparecidense U20	Aragoiania U20	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219808196	f	\N	\N	\N
7801	Aparecida EC U20	Guanabara City U20	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219808286	f	\N	\N	\N
7802	Goias EC U20	Vila Nova U20	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219808015	f	\N	\N	\N
7807	Cerrado U20	Trindade AC U20	2023-10-16 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219808105	f	\N	\N	\N
7861	Selangor II	Perak II	2023-10-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219833215	f	\N	\N	\N
7862	Sri Lanka	Yemen	2023-10-17 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219657729	f	\N	\N	\N
7863	Japan	Tunisia	2023-10-17 11:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219664763	f	\N	\N	\N
7864	Salford City (Res)	Rotherham United (Res)	2023-10-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219832175	f	\N	\N	\N
7755	Gibraltar	Republic of Ireland	2023-10-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219477942	t	2	\N	274
7778	Atletico Saltillo	Chihuahua FC	2023-10-17 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219782664	f	\N	\N	\N
7779	Santos Laguna (W)	FC Juarez (W)	2023-10-17 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219782550	f	\N	\N	\N
7780	Guam	Singapore	2023-10-17 05:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219639872	f	\N	\N	\N
7859	Mongolia	Afghanistan	2023-10-17 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219650644	f	\N	\N	\N
7860	Pakistan	Cambodia	2023-10-17 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219641559	f	\N	\N	\N
7871	Mauritania	Burkina Faso	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219816825	f	\N	\N	\N
7866	Timor-Leste	Chinese Taipei	2023-10-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219736964	f	\N	\N	\N
7865	South Korea	Vietnam	2023-10-17 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219769740	f	\N	\N	\N
7867	Macau	Myanmar	2023-10-17 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219639962	f	\N	\N	\N
7868	Bangladesh	Republic of Maldives	2023-10-17 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219641649	f	\N	\N	\N
7869	Carlisle (Res)	Blackpool (Res)	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219808377	f	\N	\N	\N
7874	Peterborough United U21	Burnley U21	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219815695	f	\N	\N	\N
7872	Laos	Nepal	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219686483	f	\N	\N	\N
7873	Bhutan	Hong Kong	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219641469	f	\N	\N	\N
7870	Bristol City U21	Queens Park Rangers U21	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219797118	f	\N	\N	\N
7875	Latvia U21	Turkey U21	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219590657	f	\N	\N	\N
7876	Brunei	Indonesia	2023-10-17 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219642607	f	\N	\N	\N
7878	Ipswich Town U21	Watford U21	2023-10-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219815790	f	\N	\N	\N
7877	Albania U21	Montenegro U21	2023-10-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219590747	f	\N	\N	\N
7881	Bolton (Res)	Huddersfield (Res)	2023-10-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219834913	f	\N	\N	\N
7886	Abo Qair Semads	Wadi degla	2023-10-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219803041	f	\N	\N	\N
7882	La Viena FC	Petrojet	2023-10-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219803315	f	\N	\N	\N
7883	Olympic El Qanal	Dekernes	2023-10-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219803405	f	\N	\N	\N
7885	Tanta	El Seka Elhadeed	2023-10-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219803131	f	\N	\N	\N
7880	Malaysia	Tajikistan	2023-10-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219769830	f	\N	\N	\N
7884	North Macedonia	Armenia	2023-10-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219766058	f	\N	\N	\N
7879	Cape Verde	Comoros	2023-10-17 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219798223	f	\N	\N	\N
7887	Kazakhstan U21	Spain U21	2023-10-17 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219590837	f	\N	\N	\N
7889	Kazakhstan U19	N Macedonia U19	2023-10-17 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219801179	f	\N	\N	\N
7888	Poland U19	Germany U19	2023-10-17 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219801269	f	\N	\N	\N
7890	Nurnberg II	Bayreuth	2023-10-17 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219797953	f	\N	\N	\N
7892	Jordan	Iraq	2023-10-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219822248	f	\N	\N	\N
9793	Oud-Heverlee Leuven	Sint Truiden	2023-10-22 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219457886	f	\N	\N	\N
7891	Azerbaijan U21	Luxembourg U21	2023-10-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219590927	f	\N	\N	\N
9795	Gualaceo SC	Aucas	2023-10-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219649491	f	\N	\N	\N
9796	Erzgebirge	SSV Ulm	2023-10-22 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219789658	f	\N	\N	\N
9797	Bristol City (W)	Arsenal (W)	2023-10-22 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219895456	f	\N	\N	\N
9798	Borac Banja Luka	Zrinjski	2023-10-22 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219857505	f	\N	\N	\N
9794	Francs Borains	Patro Eisden Maasmechelen	2023-10-22 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219791307	t	0	0	136
9804	Montaneses FC	Yalmakan FC	2023-10-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220017156	f	\N	\N	\N
7896	Armenia U21	Switzerland U21	2023-10-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219591017	f	\N	\N	\N
7895	Lithuania U21	Iceland U21	2023-10-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219593125	f	\N	\N	\N
7894	Romania U21	Finland U21	2023-10-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219591107	f	\N	\N	\N
7900	Zambia	Uganda	2023-10-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219817992	f	\N	\N	\N
7904	Telecom Egypt SC	Ghazl El Mahallah	2023-10-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219803221	f	\N	\N	\N
7898	Saudi Arabia	Mali	2023-10-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219638485	f	\N	\N	\N
7903	Croatia U21	Belarus U21	2023-10-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219743418	f	\N	\N	\N
7902	Bulgaria U21	Kosovo U21	2023-10-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219591330	f	\N	\N	\N
7901	Gibraltar U21	Netherlands U21	2023-10-17 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219753117	f	\N	\N	\N
7905	Hungary U21	Belgium U21	2023-10-17 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219591420	f	\N	\N	\N
7906	Italy U21	Norway U21	2023-10-17 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219591510	f	\N	\N	\N
7907	Syria	Kuwait	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219818085	f	\N	\N	\N
7912	Bahrain	Philippines	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219780232	f	\N	\N	\N
7909	Poland U21	Estonia U21	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219591600	f	\N	\N	\N
7914	Slovenia U21	Austria U21	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219591690	f	\N	\N	\N
7913	Estonia	Thailand	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219736238	f	\N	\N	\N
7908	Austria U19	England U19	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219801359	f	\N	\N	\N
7910	Finland	Kazakhstan	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219476630	f	\N	\N	\N
7911	Czech Republic U21	Denmark U21	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219593215	f	\N	\N	\N
7919	Scotland U21	Malta U21	2023-10-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219591781	f	\N	\N	\N
7915	UAE	Lebanon	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219802764	f	\N	\N	\N
7916	Albania	Bulgaria	2023-10-17 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219736148	f	\N	\N	\N
7918	France U21	Cyprus U21	2023-10-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219595510	f	\N	\N	\N
7920	FC Nottingen	FC Astoria Walldorf	2023-10-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219821712	f	\N	\N	\N
7923	SV Turkgucu-Ataspor	DJK Vilzing	2023-10-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219813586	f	\N	\N	\N
7921	Sportunion Schonbrunn	Mannsworth	2023-10-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219821802	f	\N	\N	\N
7922	Buchbach	Illertissen	2023-10-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219813495	f	\N	\N	\N
7924	Burghausen	FC Memmingen	2023-10-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219813315	f	\N	\N	\N
7925	Viktoria Aschaffenburg	TSV Aubstadt	2023-10-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219813405	f	\N	\N	\N
7929	Hull City U21	Barnsley U21	2023-10-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219819172	f	\N	\N	\N
7926	England U20	Portugal U20	2023-10-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219831274	f	\N	\N	\N
7933	UAI Urquiza (W)	Lorenzo de Almagro (W)	2023-10-17 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219804294	f	\N	\N	\N
7930	Portugal U21	Greece U21	2023-10-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219591871	f	\N	\N	\N
7931	Qatar	Iran	2023-10-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219803900	f	\N	\N	\N
7927	Andorra U21	Faroe Islands U21	2023-10-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219591961	f	\N	\N	\N
7928	Cambridge Utd	Colchester	2023-10-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219775182	f	\N	\N	\N
7932	Excursionistas (W)	Club El Porvenir (W)	2023-10-17 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219794019	f	\N	\N	\N
7934	Waltham Abbey	Bedford Town	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219822338	f	\N	\N	\N
7937	Herne Bay	Folkestone Invicta	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219834546	f	\N	\N	\N
7941	Lithuania	Hungary	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219476973	f	\N	\N	\N
7935	Brightlingsea Regent	Basildon United	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219808468	f	\N	\N	\N
7936	Hanworth Villa	Hartley Wintney	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219808558	f	\N	\N	\N
7946	Northern Ireland	Slovenia	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219476506	f	\N	\N	\N
7949	Ivory Coast	South Africa	2023-10-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219780324	f	\N	\N	\N
7940	Serbia	Montenegro	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219477581	f	\N	\N	\N
7944	England	Italy	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219350687	f	\N	\N	\N
7945	Cardiff Metropolitan	Newtown	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219802951	f	\N	\N	\N
7938	Caernarfon Town	Aberystwyth	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219802861	f	\N	\N	\N
7942	Malta	Ukraine	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219477081	f	\N	\N	\N
7939	Haverfordwest County	Penybont FC	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219816414	f	\N	\N	\N
7943	San Marino	Denmark	2023-10-17 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219476258	f	\N	\N	\N
7947	Morocco	Liberia	2023-10-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219785045	f	\N	\N	\N
7948	France	Scotland	2023-10-17 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219639423	f	\N	\N	\N
7899	Moldova U21	North Macedonia U21	2023-10-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219595420	f	\N	\N	\N
7976	Ayr (Res)	Queen of South (Res)	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219837718	f	\N	\N	\N
7977	Dundee (Res)	Dundee Utd (Res)	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219837538	f	\N	\N	\N
7978	Hibernian (Res)	Hamilton (Res)	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219837628	f	\N	\N	\N
7979	Preston North End (Res)	Wrexham (Res)	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219840436	f	\N	\N	\N
7980	Queens Park (Res)	Livingston (Res)	2023-10-17 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219837808	f	\N	\N	\N
7988	Atletico Goianiense U20	Itaberai U20	2023-10-17 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219837330	f	\N	\N	\N
8000	Lincoln City (Res)	Notts County FC (Res)	2023-10-17 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219840542	f	\N	\N	\N
7966	Peru	Argentina	2023-10-18 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219311607	f	\N	\N	\N
7967	Deportivo Saprissa	Puntarenas F.C.	2023-10-18 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219678819	f	\N	\N	\N
8179	Shenyang Urban FC	Yanbian Longding	2023-10-18 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219826418	f	\N	\N	\N
8180	Qingdao Youth Island	Suzhou Dongwu	2023-10-18 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219826891	f	\N	\N	\N
8181	Nanjing Fengfan	Jinan Xingzhou	2023-10-18 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219826981	f	\N	\N	\N
8182	Sichuan Jiuniu FC	Wuxi Wugou	2023-10-18 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219826801	f	\N	\N	\N
9800	Pumas UNAM	Monterrey	2023-10-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219494316	f	\N	\N	\N
9801	Atletico Sanluqueno CF	Cordoba	2023-10-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864985	f	\N	\N	\N
7957	Ecuador	Colombia	2023-10-18 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219313752	f	\N	\N	\N
7958	Mexico	Germany	2023-10-18 00:55:00	https://www.orbitxch.com/customer/sport/1/market/1.219610545	f	\N	\N	\N
8183	Mil-Mugan FK	Irevan FK	2023-10-18 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219851940	f	\N	\N	\N
8184	Afjet Afyonspor	Van Buyuksehir Belediyespor	2023-10-18 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219832085	f	\N	\N	\N
8185	76 Igdir Belediyespor	Menemen Belediyespor	2023-10-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219853714	f	\N	\N	\N
8186	Guangxi Baoyun	Dongguan Guanlian	2023-10-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219832313	f	\N	\N	\N
8187	Jiangxi Liansheng	Shanghai Jiading	2023-10-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219832403	f	\N	\N	\N
8188	Guangzhou FC	Dantong Hantong	2023-10-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219832808	f	\N	\N	\N
8189	1461 Trabzon	Karacabey Belediyespor AS	2023-10-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219847597	f	\N	\N	\N
8190	Hebei KungFu	Heilongjiang Lava Spring	2023-10-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219832898	f	\N	\N	\N
8086	Avion Academy FC	Coton S De Garoua	2023-10-17 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219845454	f	\N	\N	\N
7893	Angola	DR Congo	2023-10-17 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219826328	f	\N	\N	\N
7897	Georgia U21	Sweden U21	2023-10-17 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219591200	f	\N	\N	\N
7917	Wurzburger Kickers	Schalding-Heining	2023-10-17 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219799266	f	\N	\N	\N
8035	Grosspetersdorf	Pinkafeld	2023-10-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219838122	f	\N	\N	\N
8038	AIK (W)	IFK Norrkoping (W)	2023-10-17 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219837904	f	\N	\N	\N
8049	Mauritania	Burkina Faso	2023-10-17 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219816825	f	\N	\N	\N
7950	Antigua and Barbuda	Bahamas	2023-10-17 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219791274	f	\N	\N	\N
7951	Guyana	Puerto Rico	2023-10-17 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219782923	f	\N	\N	\N
7952	Cayman Islands	US Virgin Islands	2023-10-17 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219783035	f	\N	\N	\N
8069	CD Luis Angel Firpo (W)	Municipal Limeno (W)	2023-10-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219838594	f	\N	\N	\N
7954	AD Municipal Liberia	Santos de Guapiles	2023-10-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219683328	f	\N	\N	\N
7953	Venezuela	Chile	2023-10-17 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219311391	f	\N	\N	\N
7956	Paraguay	Bolivia	2023-10-17 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219311499	f	\N	\N	\N
7955	Bermuda	Belize	2023-10-17 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219755773	f	\N	\N	\N
8191	Adiyamanspor	Ankara Demirspor	2023-10-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219847507	f	\N	\N	\N
8192	Kirklarelispor	Nazilli Belediyespor	2023-10-18 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219847417	f	\N	\N	\N
8193	FK Smederevo	FK Backa Topola	2023-10-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219846966	f	\N	\N	\N
7959	Sporting San Jose FC	Municipal Grecia	2023-10-18 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219678909	f	\N	\N	\N
7960	Uruguay	Brazil	2023-10-18 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219318771	f	\N	\N	\N
8171	Palmeiras (W)	Atletico Nacional (W)	2023-10-18 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219873155	f	\N	\N	\N
7961	USA	Ghana	2023-10-18 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219638575	f	\N	\N	\N
7962	Genesis Huracan	Lobos UPNFM	2023-10-18 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219826711	f	\N	\N	\N
7963	Panama	Guatemala	2023-10-18 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219752830	f	\N	\N	\N
7964	El Salvador	Martinique	2023-10-18 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219752522	f	\N	\N	\N
7965	Curacao	Trinidad & Tobago	2023-10-18 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219752192	f	\N	\N	\N
8194	Zonguldakspor	Ankaraspor	2023-10-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219847687	f	\N	\N	\N
8195	Kastamonuspor	Denizlispor	2023-10-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219854001	f	\N	\N	\N
8196	Etimesgut Belediyespor	Iskenderunspor	2023-10-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219853804	f	\N	\N	\N
8197	Karaman Belediyespor	Amed Sportif Faaliyetler	2023-10-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219855418	f	\N	\N	\N
8198	Serik Belediyespor	Halide Edip Adivarspor	2023-10-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219847970	f	\N	\N	\N
8199	Sandecja Nowy Sacz	Chojniczanka Chojnice	2023-10-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219832583	f	\N	\N	\N
8200	Kirsehir Belediyespor	Altinordu	2023-10-18 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219847777	f	\N	\N	\N
8201	FC Vorskla Poltava (W)	AS Roma (W)	2023-10-18 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219839513	f	\N	\N	\N
8202	Arnavutkoy Belediyesi GVS	Usakspor	2023-10-18 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219854497	f	\N	\N	\N
8203	Union Sportive de Douala	Aigle Royal de la Menou	2023-10-18 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219845760	f	\N	\N	\N
8204	Inegolspor	Sariyer G.K.	2023-10-18 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219854407	f	\N	\N	\N
8205	Bucaspor	Bursaspor	2023-10-18 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219848189	f	\N	\N	\N
8206	Fovu Club de Baham	Victoria United Limbe	2023-10-18 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219841259	f	\N	\N	\N
8207	SSD US Angri 1927	Real Casalnuova	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219866795	f	\N	\N	\N
8208	Poggibonsi	AC Aglianese	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219866615	f	\N	\N	\N
8209	ASD Asti	PDHA Evancon	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219852795	f	\N	\N	\N
8210	Vivi Altotevere Sansepolcro	Pistoiese	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219855222	f	\N	\N	\N
8211	USD Castellanzese	ASD Varesina	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219867065	f	\N	\N	\N
8212	Follonica Gavorrano	Sangiovannese	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219855312	f	\N	\N	\N
8213	Acd Campodarsego Calcio	Montecchio Maggiore	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219855037	f	\N	\N	\N
8214	AC Dolomiti Bellunesi	Virtus Bolzano	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219851850	f	\N	\N	\N
8215	Borgo San Donnino	US Corticella	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219854947	f	\N	\N	\N
8216	San Nicolo Notaresco	Campobasso	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219866705	f	\N	\N	\N
8217	USD Citta di Fasano	SSD Casarano Calcio	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219867155	f	\N	\N	\N
8218	AJ Fano 1906	Sambenedettese	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219866435	f	\N	\N	\N
8219	Vibonese	FC Lamezia Terme	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219867245	f	\N	\N	\N
8220	FK Tekstilac Derventa	Tuzla City	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219852030	f	\N	\N	\N
8221	Real Calepina FC	AC Ponte San Pietro-Isola	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219856061	f	\N	\N	\N
8222	Luparense FC	APDC Chions	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219854767	f	\N	\N	\N
8223	Union Clodiense Chioggia	Ravenna	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219866885	f	\N	\N	\N
8224	FK Trayal Krusevac	Crvena Zvezda	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219847057	f	\N	\N	\N
8225	USD Casatese	ASD Fanfulla	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219866975	f	\N	\N	\N
8226	GS Arconatese	ASD Alcione	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219852885	f	\N	\N	\N
8227	ASD Real Monterotondo Scalo	Cynthiabalonga	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219866525	f	\N	\N	\N
8228	Cavese 1919	Rotonda Calcio	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219854857	f	\N	\N	\N
8229	SK Sered	Slovan Bratislava	2023-10-18 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219852248	f	\N	\N	\N
8231	Bamboutos FC de Mbouda	AS Fortuna Mfou	2023-10-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219845850	f	\N	\N	\N
9799	FCSB	FC Voluntari	2023-10-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219173353	f	\N	\N	\N
10127	Udinese	Lecce	2023-10-23 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219118133	f	\N	\N	\N
8230	Fezzanese	Vado FC	2023-10-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219871121	f	\N	\N	\N
8234	PWD Bamenda	Dynamo Douala	2023-10-18 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219846030	f	\N	\N	\N
8237	MFD Zalgiris Vilnius (Res)	TransINVEST Vilnius	2023-10-18 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219834636	f	\N	\N	\N
8236	Les Astres FC de Douala	Canon Sportif De Yaounde	2023-10-18 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219845940	f	\N	\N	\N
8235	Zrinjski	FK Velez Mostar	2023-10-18 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219835027	f	\N	\N	\N
8239	CFF Clujana (W)	Slavia Prague (W)	2023-10-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219839603	f	\N	\N	\N
8238	Liverpool Montevideo	Defensor Sporting	2023-10-18 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219755914	f	\N	\N	\N
8240	Fethiyespor	Duzcespor	2023-10-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219853894	f	\N	\N	\N
8243	Ispartaspor	Belediye Derincespor	2023-10-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219854263	f	\N	\N	\N
8242	Tabasalu JK	Paide Linnameeskond	2023-10-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219839151	f	\N	\N	\N
8241	FC Paradiso	Rapperswil-Jona	2023-10-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219835745	f	\N	\N	\N
8244	Erokspor A.S	Mersin Idman Yurdu	2023-10-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219848279	f	\N	\N	\N
8245	Rosengard (W)	Zfk Spartak Subotica (W)	2023-10-18 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219854677	f	\N	\N	\N
8246	Sparta Prague (W)	Eintracht Frankfurt (W)	2023-10-18 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219854587	f	\N	\N	\N
8247	Wolfsburg (W)	Paris FC (W)	2023-10-18 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219839694	f	\N	\N	\N
8248	Fidelis Andria	US Bitonto Calcio	2023-10-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219871211	f	\N	\N	\N
8249	Twente (W)	BK Hacken (W)	2023-10-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219839784	f	\N	\N	\N
9803	Zitacuaro CF	Canoneros Marina	2023-10-22 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220055926	f	\N	\N	\N
8286	AD Guanacasteca	CS Herediano	2023-10-18 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219679089	f	\N	\N	\N
9806	Lyon	Clermont	2023-10-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219117533	f	\N	\N	\N
8296	Arabe Unido	Costa del Este	2023-10-19 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219883274	f	\N	\N	\N
8299	Macara	Manta FC	2023-10-19 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219853072	f	\N	\N	\N
8300	CS Cartagines	AD San Carlos	2023-10-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219650166	f	\N	\N	\N
8297	CD Universitario	UMECIT	2023-10-19 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219883670	f	\N	\N	\N
8303	CA Independiente	Barracas Central	2023-10-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386840	f	\N	\N	\N
8302	Olancho	CD Olimpia	2023-10-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219879869	f	\N	\N	\N
8304	Vasco Da Gama	Fortaleza EC	2023-10-19 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219230617	f	\N	\N	\N
8301	Inter Miami CF	Charlotte FC	2023-10-19 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219487784	t	2	\N	76
8294	Cucuta Deportivo	Llaneros FC	2023-10-19 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219692387	f	\N	\N	\N
8295	Coritiba	Cuiaba	2023-10-19 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219230257	f	\N	\N	\N
8252	SK Brann (W)	Glasgow City (W)	2023-10-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219863096	f	\N	\N	\N
8250	SSV Jeddeloh	TuS BW Lohne	2023-10-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219839241	f	\N	\N	\N
8251	Borac Banja Luka	Sarajevo	2023-10-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219839061	f	\N	\N	\N
8253	SKN St. Polten (W)	Valur Reykjavik (W)	2023-10-18 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219858886	f	\N	\N	\N
8258	Plaza Colonia	Wanderers (Uru)	2023-10-18 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219761059	f	\N	\N	\N
8255	FC Cosmos Koblenz	Rot-Weiss Koblenz	2023-10-18 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219839423	f	\N	\N	\N
8256	Cham	FC Luzern II	2023-10-18 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219840338	f	\N	\N	\N
8257	Valerenga (W)	Real Madrid FC (W)	2023-10-18 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219879987	f	\N	\N	\N
8259	Bavois	FC Zurich II	2023-10-18 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219840242	f	\N	\N	\N
8260	Eintracht Trier	SV Auersmacher	2023-10-18 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219839333	f	\N	\N	\N
8261	L'Hospitalet	Andorra CF	2023-10-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219857017	f	\N	\N	\N
8262	Etoile Carouge	Breitenrain	2023-10-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219840152	f	\N	\N	\N
8263	Racing Club D'Abidjan	SC Gagnoa	2023-10-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219838971	f	\N	\N	\N
8264	Paris St-G (W)	Man Utd (W)	2023-10-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219876444	f	\N	\N	\N
8266	Palazzolo	Calcio Desenzano	2023-10-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219871301	f	\N	\N	\N
8267	CE Europa	Olot	2023-10-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219855132	f	\N	\N	\N
8265	Trapani	Sancataldese Calcio	2023-10-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219871607	f	\N	\N	\N
8268	Servette FC U21	Biel Bienne	2023-10-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219840062	f	\N	\N	\N
8271	Ramsgate	Erith & Belvedere	2023-10-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219885732	f	\N	\N	\N
8269	Larkhall Athletic	Bashley	2023-10-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219872013	f	\N	\N	\N
8270	Southall	Thatcham Town	2023-10-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219840634	f	\N	\N	\N
8275	DLR Waves (W)	Shamrock Rovers (W)	2023-10-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219824482	f	\N	\N	\N
8276	Galway WFC (W)	Athlone Town (W)	2023-10-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219824662	f	\N	\N	\N
8273	Kingstonian	Enfield Town	2023-10-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219783096	f	\N	\N	\N
8274	Shelbourne (W)	Sligo Rovers (W)	2023-10-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219824572	f	\N	\N	\N
8272	Connahs Quay	Bala Town	2023-10-18 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219839971	f	\N	\N	\N
8277	Universidad San Carlos	Barberena FC	2023-10-18 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219847147	f	\N	\N	\N
8278	Cerro Largo FC	La Luz FC	2023-10-18 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219760969	f	\N	\N	\N
8280	Barranquilla	Atletico FC Cali	2023-10-18 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219692297	f	\N	\N	\N
8281	Chacaritas SC	Independiente Juniors	2023-10-18 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219840814	f	\N	\N	\N
8279	Club Nueve de Octubre	Guayaquil SC	2023-10-18 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219840724	f	\N	\N	\N
8284	Fraijanes FC	Deportivo Mictlan	2023-10-18 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219859848	f	\N	\N	\N
8283	Deportivo Nueva Concepcion	S Lucia Cotzumalguapa	2023-10-18 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219859938	f	\N	\N	\N
8282	Solola FC	Marquense	2023-10-18 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219859757	f	\N	\N	\N
8285	CD Aguila	Platense Zacatecoluca	2023-10-18 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219841164	f	\N	\N	\N
8287	CD Luis Angel Firpo	Alianza FC (SLV)	2023-10-18 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219847237	f	\N	\N	\N
8288	Juventud Pinulteca FC	Aurora FC	2023-10-18 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219860028	f	\N	\N	\N
8289	Jocoro	Santa Tecla	2023-10-18 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219847327	f	\N	\N	\N
8290	CA Platense	Estudiantes	2023-10-18 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219351628	f	\N	\N	\N
8291	Gremio	Athletico-PR	2023-10-18 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219230497	f	\N	\N	\N
8292	Torque	Penarol	2023-10-18 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219713146	f	\N	\N	\N
9807	AC Milan	Juventus	2023-10-22 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219118013	f	\N	\N	\N
10031	Shamrock Rovers	Drogheda	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219512569	f	\N	\N	\N
9822	Anapolina Go	Santa Helena	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220052193	f	\N	\N	\N
9817	Stade Reims (W)	Lyon (W)	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220023967	f	\N	\N	\N
8445	CD Victoria	CD Real Sociedad	2023-10-20 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219919232	f	\N	\N	\N
8446	San Francisco FC	Herrera FC	2023-10-20 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219910839	f	\N	\N	\N
8447	Santos	Bragantino SP	2023-10-20 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219238646	f	\N	\N	\N
8232	APEJES Academy	Fauve Azur Elite	2023-10-18 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219841349	f	\N	\N	\N
8233	ASD Trastevere Calcio	Sassari Calcio Latte Dolce	2023-10-18 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219871031	f	\N	\N	\N
8352	Poggibonsi	AC Aglianese	2023-10-18 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219866615	f	\N	\N	\N
8254	Kotwica Kolobrzeg	Stal Stalowa Wola	2023-10-18 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219769920	f	\N	\N	\N
8368	COB	AS Black Stars	2023-10-18 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219894024	f	\N	\N	\N
8373	US Livorno 1915 SSD	GSD Ghiviborgo VSD	2023-10-18 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219894117	f	\N	\N	\N
8395	Nacional (Par)	Guarani (Par)	2023-10-18 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219894211	f	\N	\N	\N
8444	Royal Pari	Aurora	2023-10-20 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219918426	f	\N	\N	\N
8448	Boston River	Nacional (Uru)	2023-10-20 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219792897	f	\N	\N	\N
8305	Corinthians (W)	SC Internacional (W)	2023-10-19 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219826582	f	\N	\N	\N
8449	Rosario Central	Velez Sarsfield	2023-10-20 00:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219185796	f	\N	\N	\N
9821	Barcelona	Athletic Bilbao	2023-10-22 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219118853	t	0	1	3
10128	Vanlose U21	Boldklubben 1908 U21	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220132681	f	\N	\N	\N
10129	Varnamo	IFK Goteborg	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219484278	f	\N	\N	\N
10130	Valerenga II	Kjelsas	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220081583	f	\N	\N	\N
10131	Stal Mielec	Warta Poznan	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219409023	f	\N	\N	\N
8293	America MG	Botafogo	2023-10-19 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219230137	f	\N	\N	\N
8407	Tacuary	Guairena	2023-10-19 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219894301	f	\N	\N	\N
8298	Cuniburo FC	Imbabura Sporting Club	2023-10-19 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219853163	f	\N	\N	\N
8307	Goias	Sao Paulo	2023-10-19 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219246243	f	\N	\N	\N
8306	Bahia	Internacional	2023-10-19 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219230017	f	\N	\N	\N
8308	Millonarios	Union Magdalena	2023-10-19 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218954674	f	\N	\N	\N
8310	AD Isidro Metapan	CD Dragon	2023-10-19 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219860781	f	\N	\N	\N
8309	Plaza Amador	Tauro FC	2023-10-19 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219883489	f	\N	\N	\N
8312	CD Motagua	Vida	2023-10-19 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219879779	f	\N	\N	\N
8311	Quiche FC	Deportivo San Pedro	2023-10-19 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219866345	f	\N	\N	\N
8313	LD Alajuelense	Municipal Perez Zeledon	2023-10-19 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219678999	f	\N	\N	\N
10132	OB	Midtjylland	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219458498	f	\N	\N	\N
10133	AL Nahdha	Al-Futowa	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220120437	f	\N	\N	\N
10134	Stromsgodset II	Kvik Halden	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010202	f	\N	\N	\N
10135	Trabzonspor	Alanyaspor	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219200325	f	\N	\N	\N
10136	Jonkopings Sodra	Skovde AIK	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219500663	f	\N	\N	\N
10137	Genclerbirligi	Altay	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219788178	f	\N	\N	\N
10138	Fatih Karagumruk Istanbul	Adana Demirspor	2023-10-23 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219200217	f	\N	\N	\N
10139	Elfsborg	AIK	2023-10-23 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219483918	f	\N	\N	\N
10140	Red Star	Cholet SO	2023-10-23 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219943332	f	\N	\N	\N
10141	Jong PSV Eindhoven	FC Eindhoven	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219910028	f	\N	\N	\N
10142	FC Groningen	Emmen	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219910118	f	\N	\N	\N
10143	FC Oss	Jong FC Utrecht	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219857396	f	\N	\N	\N
10144	Stade Abidjan	Racing Club D'Abidjan	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220033707	f	\N	\N	\N
10145	Jong AZ Alkmaar	De Graafschap	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219857785	f	\N	\N	\N
10146	Al-Hilal	Mumbai City FC	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220088959	f	\N	\N	\N
10147	Al-Sadd	Al Faisaly SC	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220084703	f	\N	\N	\N
10148	Al Arabi Kuwait	Al Riffa	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220103892	f	\N	\N	\N
10149	AD Cantolao	Atletico Grau	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219524199	f	\N	\N	\N
8460	Al-Jalil	Al Aqaba	2023-10-19 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219884066	f	\N	\N	\N
8461	Racing Club (Uru)	Centro Atletico Fenix	2023-10-19 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219738294	f	\N	\N	\N
8462	Aali Club	Al-Ettifaq	2023-10-19 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219887718	f	\N	\N	\N
8463	Malkiya	Al-Ittihad (BRN)	2023-10-19 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219885608	f	\N	\N	\N
8464	Qalali	Al Budaiya	2023-10-19 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219885302	f	\N	\N	\N
8465	Partizani Tirana	KF Tirana	2023-10-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219883976	f	\N	\N	\N
8467	Hansa Rostock II	Greifswalder SV 04	2023-10-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219888019	f	\N	\N	\N
8468	CSMS Iasi	ACS Sepsi OSK	2023-10-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219173173	f	\N	\N	\N
8469	Deportivo Maldonado	River Plate (Uru)	2023-10-19 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219790158	f	\N	\N	\N
8470	K Lierse U21	AS Eupen (Res)	2023-10-19 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219887808	f	\N	\N	\N
8471	Gimnasia La Plata	Argentinos Juniors	2023-10-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219386930	f	\N	\N	\N
8472	Rebordosa	Braga	2023-10-19 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219892296	f	\N	\N	\N
8473	Godoy Cruz	San Lorenzo	2023-10-19 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219185688	f	\N	\N	\N
8474	Cerro	Danubio	2023-10-19 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219792987	f	\N	\N	\N
8475	Colon	River Plate	2023-10-19 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219353676	f	\N	\N	\N
8476	CF America (W)	Queretaro (W)	2023-10-19 22:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219882217	f	\N	\N	\N
8477	Tombense MG	Vila Nova	2023-10-19 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219536778	f	\N	\N	\N
8478	Atletico Go	ABC RN	2023-10-19 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219658360	f	\N	\N	\N
8479	Cruzeiro MG	Flamengo	2023-10-19 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219229897	f	\N	\N	\N
8480	SE Palmeiras	Atletico MG	2023-10-19 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219258544	f	\N	\N	\N
8481	Sportivo Luqueno	Club General Caballero JLM	2023-10-19 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219894481	f	\N	\N	\N
8454	Sporting San Miguelito	Alianza FC (Pan)	2023-10-20 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219919131	f	\N	\N	\N
8453	Cd Fas	Fuerte San Francisco	2023-10-20 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219918021	f	\N	\N	\N
8456	FC Atlas (W)	Guadalajara (W)	2023-10-20 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219916822	f	\N	\N	\N
8457	Venados FC	Club Atletico Morelia	2023-10-20 04:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219780414	f	\N	\N	\N
9626	Nantes	Montpellier	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219117411	t	1	2	5
10150	CFR Cluj	Otelul Galati	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219173929	f	\N	\N	\N
10151	Helmond Sport	FC Dordrecht	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219853390	f	\N	\N	\N
10152	Jong Ajax Amsterdam	ADO Den Haag	2023-10-23 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219853480	f	\N	\N	\N
10153	St Patricks	Sligo Rovers	2023-10-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219839874	f	\N	\N	\N
8458	Tigres (W)	Monterrey (W)	2023-10-20 04:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219916732	f	\N	\N	\N
8459	Pachuca (W)	Club Necaxa (W)	2023-10-20 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219916642	f	\N	\N	\N
8466	Vendsyssel FF	AC Horsens	2023-10-19 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219803990	t	1	3	147
8504	Sarmiento de Junin	Racing Club	2023-10-20 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219944485	f	\N	\N	\N
8450	CD Municipal Limeno	Once Municipal	2023-10-20 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219917931	f	\N	\N	\N
8451	Fluminense	Corinthians	2023-10-20 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219230377	f	\N	\N	\N
8452	Real Espana	CD Marathon	2023-10-20 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219918610	f	\N	\N	\N
8455	Deportivo Pereira	Atletico Nacional Medellin	2023-10-20 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219918120	f	\N	\N	\N
8515	Csikszereda	FC Unirea Dej	2023-10-21 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219571521	f	\N	\N	\N
8516	Bhayangkara FC	PS Barito Putera	2023-10-21 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219960217	f	\N	\N	\N
8517	Progresul 1944 Spartac	FC Metaloglobus Bucuresti	2023-10-21 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219571431	f	\N	\N	\N
8518	CSM Scolar Resita	CS Tunari	2023-10-21 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219588991	f	\N	\N	\N
8519	PSS Sleman	Persik Kediri	2023-10-21 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219960127	f	\N	\N	\N
8520	Acs Dumbravita	FCM Alexandria	2023-10-21 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219571701	f	\N	\N	\N
8521	Unirea Slobozia	CSA Steaua Bucuresti	2023-10-21 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219593305	f	\N	\N	\N
8522	RB Leipzig U19	Hannover 96 (U19)	2023-10-21 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219964113	f	\N	\N	\N
8523	Inter Milan (W)	Napoli Calcio (W)	2023-10-21 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219982947	f	\N	\N	\N
8524	Tuzlaspor	Kocaelispor	2023-10-21 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219736552	f	\N	\N	\N
8525	CF Panaderia Pulido	Club Atletico Victoria	2023-10-21 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219975900	f	\N	\N	\N
8526	Customs United	Rayong FC	2023-10-21 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219963933	f	\N	\N	\N
8527	Erzurum BB	Keciorengucu	2023-10-21 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219736372	f	\N	\N	\N
8528	Villarreal CF III	CD Soneja	2023-10-21 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219975810	f	\N	\N	\N
8529	Kisvarda	Mezokovesd-Zsory	2023-10-21 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219502462	f	\N	\N	\N
10154	USD Sestri Levante 1919	Carrarese	2023-10-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219842447	f	\N	\N	\N
8530	Kayserispor	Rizespor	2023-10-21 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219200433	f	\N	\N	\N
8531	Beltinci	Gorica	2023-10-21 11:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219896750	f	\N	\N	\N
8532	Nakhon Pathom	Khonkaen United	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219912193	f	\N	\N	\N
8533	Botev Vratsa	Botev Plovdiv	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219534862	f	\N	\N	\N
8534	Geita Gold FC	Dodoma FC	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219964895	f	\N	\N	\N
8535	Sollentuna FF	Taby FK	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219852430	f	\N	\N	\N
8536	Tvaakers	Lunds BK	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219865616	f	\N	\N	\N
8537	Thanh Hoa	Hong Linh Ha Tinh	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219983591	f	\N	\N	\N
8538	VFL Osnabruck	Wehen Wiesbaden	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219175457	f	\N	\N	\N
8539	Phnom Penh	Prey Veng	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219964591	f	\N	\N	\N
8540	Berliner AK	Meuselwitz	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219923404	f	\N	\N	\N
8543	BK Olympic	Norrby IF	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864353	f	\N	\N	\N
8544	Ayutthaya United	Lampang FC	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219964023	f	\N	\N	\N
8546	Sloga Doboj	Siroki Brijeg	2023-10-21 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219855791	f	\N	\N	\N
8547	Suzhou Dongwu	Jiangxi Liansheng	2023-10-21 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219965130	f	\N	\N	\N
8548	Preston	Millwall	2023-10-21 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219383971	f	\N	\N	\N
8549	JL Chiangmai United	Chainat Hornbill	2023-10-21 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219963843	f	\N	\N	\N
8550	Aston Villa (W)	Tottenham (W)	2023-10-21 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219895365	f	\N	\N	\N
8551	Weiche Flensburg	TSV Havelse	2023-10-21 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219927019	f	\N	\N	\N
8552	Trans Narva	Nomme Kalju	2023-10-21 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219510096	f	\N	\N	\N
8553	Guangxi Baoyun	Nanjing Fengfan	2023-10-21 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219965040	f	\N	\N	\N
8555	Nantong Zhiyun F.C	Shanghai Shenhua	2023-10-21 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.219733758	f	\N	\N	\N
8556	NK Dubrava Zagreb	Zrinski Jurjevac	2023-10-21 12:50:00	https://www.orbitxch.com/customer/sport/1/market/1.219856617	f	\N	\N	\N
8557	FK Jedinstvo Ub	Indija	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219971536	f	\N	\N	\N
8558	KTP	IFK Mariehamn	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219484698	f	\N	\N	\N
8559	FSV Frankfurt	Aalen	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219923224	f	\N	\N	\N
8560	Homburg	Hessen Kassel	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219923314	f	\N	\N	\N
8561	Hallescher FC	Jahn Regensburg	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219733593	f	\N	\N	\N
8562	Lahti	Ilves	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219484879	f	\N	\N	\N
8563	Ternana	Brescia	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219482380	f	\N	\N	\N
8564	FK Tukums 2000	Rigas Futbola Skola	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219905165	f	\N	\N	\N
8565	FC Bocholt	Fortuna Koln	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219924562	f	\N	\N	\N
8566	Sheriff Tiraspol	CSF Spartanii	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219967163	f	\N	\N	\N
8567	VfB Stuttgart U19	SG E Frankfurt U19	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219965565	f	\N	\N	\N
8568	Dukla Prague	MFK Chrudim	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219538032	f	\N	\N	\N
8569	Gnistan	SJK 2	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219852338	f	\N	\N	\N
8570	FC Astoria Walldorf	SV Steinbach	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219923982	f	\N	\N	\N
8571	FC Dziugas	FK Kauno Zalgiris	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219564372	f	\N	\N	\N
8572	Tobol Kostanay	FK Kaspyi Aktau	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219939918	f	\N	\N	\N
8573	Stuttgart II	SV Stuttgarter Kickers	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219923044	f	\N	\N	\N
8574	Ratchaburi	Sukhothai	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219911777	f	\N	\N	\N
8575	Dynamo Dresden	Preussen Munster	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219738490	f	\N	\N	\N
8576	Lecco	Ascoli	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219482561	f	\N	\N	\N
8577	OFK Beograd	FK Mladost Novi Sad	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219966031	f	\N	\N	\N
8578	FC Neptunas Klaipeda	Be1 NFA	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219967073	f	\N	\N	\N
8579	Radnicki Novi Beograd	Metalac Gornji Milanovac	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219966121	f	\N	\N	\N
8580	TransINVEST Vilnius	FK Babrungas	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219966983	f	\N	\N	\N
8581	Hegelmann Litauen	Panevezys	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219564281	f	\N	\N	\N
8582	AC Oulu	Haka	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219484789	f	\N	\N	\N
8583	SGV Freiberg	Mainz II	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219926771	f	\N	\N	\N
8584	Quess East Bengal	FC Goa	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219738384	f	\N	\N	\N
8585	TSV Schott Mainz	Hoffenheim II	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219923134	f	\N	\N	\N
8554	Liverpool	Everton	2023-10-21 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219119577	t	0	2	2
10155	Palermo	Spezia	2023-10-23 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219482290	f	\N	\N	\N
8542	GAIS	Ostersunds FK	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219500754	t	1	3	336
8545	Paderborn	St Pauli	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219249739	t	1	4	93
8586	Chernomorets Odesa	FC Minaj	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219466957	f	\N	\N	\N
8587	Kairat Almaty	FK Aksu Pavlodar	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219940009	f	\N	\N	\N
8588	Pisa	Cittadella	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219483063	f	\N	\N	\N
8589	US Cremonese	Sudtirol	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219482020	f	\N	\N	\N
8590	Skive	Roskilde	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219966497	f	\N	\N	\N
8591	1860 Munich	Freiburg II	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219607211	f	\N	\N	\N
8592	Rot-Weiss Ahlen	Alemannia Aachen	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219923800	f	\N	\N	\N
8593	Ingolstadt	Unterhaching	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219733503	f	\N	\N	\N
8594	Lubeck	Viktoria Koln	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219607121	f	\N	\N	\N
8595	Strommen	Levanger	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219963052	f	\N	\N	\N
8596	Real Sociedad	Mallorca	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219118373	f	\N	\N	\N
8597	Zimbru Chisinau	FC Floresti	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219967253	f	\N	\N	\N
8598	SSD Bari	Modena	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219482200	f	\N	\N	\N
8599	SC Spelle Venhaus	SV Meppen	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219922774	f	\N	\N	\N
8600	FC Augsburg U19	1. FC Heidenheim U19	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219965655	f	\N	\N	\N
8601	Sofapaka	Kenya Police FC	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219812307	f	\N	\N	\N
8602	FC Talanta	Posta Rangers	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219812487	f	\N	\N	\N
8603	ADO Den Haag (W)	Twente (W)	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219982625	f	\N	\N	\N
8604	Liepajas Metalurgs	FK Auda	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219905255	f	\N	\N	\N
8605	Kieler SV Holstein II	Eimsbutteler	2023-10-21 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219922954	f	\N	\N	\N
8606	FK Spisska Nova Ves	FK Humenne	2023-10-21 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219963411	f	\N	\N	\N
8607	MFk Dolny Kubin	Tatran Lip Mikulas	2023-10-21 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219965745	f	\N	\N	\N
8608	Ksv 1919	FC Dornbirn	2023-10-21 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219571791	f	\N	\N	\N
8609	Tatran Presov	FC Petrzalka	2023-10-21 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219963684	f	\N	\N	\N
8610	SK Sturm Graz II	FC Liefering	2023-10-21 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219607302	f	\N	\N	\N
8611	Bregenz	SV Horn	2023-10-21 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219571881	f	\N	\N	\N
8612	KFC Komarno	Slavoj Trebisov	2023-10-21 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219963504	f	\N	\N	\N
8613	Zalaegerszeg	Paks	2023-10-21 13:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219502282	f	\N	\N	\N
8614	Grorud IL	Floy Flekkeroy	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219962692	f	\N	\N	\N
8617	Tolmin	Ilirija Extra-Lux	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219897697	f	\N	\N	\N
8618	Birkirkara	Mosta	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219906282	f	\N	\N	\N
8619	NK Dugopolje	Cibalia Vinkovci	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219856437	f	\N	\N	\N
8620	Vukovar	NK Solin	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219856527	f	\N	\N	\N
8621	FC Telavi	Samgurali Tskaltubo	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219966587	f	\N	\N	\N
8622	Hammarby (W)	Linkopings FC (W)	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219966391	f	\N	\N	\N
8623	Fram Larvik	Egersund	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219962602	f	\N	\N	\N
8625	Puszcza Niepolomice	Cracovia Krakow	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219408663	f	\N	\N	\N
8626	Ullensaker Kisa	Ullern	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219962782	f	\N	\N	\N
8627	Zlin	Mlada Boleslav	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219446626	f	\N	\N	\N
8629	Pardubice	Sigma Olomouc	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219407362	f	\N	\N	\N
8631	Slovan Liberec	Plzen	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219446716	f	\N	\N	\N
8633	NK Rogaska	NK Celje	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219505312	f	\N	\N	\N
8634	Cerrito	Uruguay Montevideo FC	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219966211	f	\N	\N	\N
8635	Helsingborgs	Gefle	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219498485	f	\N	\N	\N
8636	Floriana	Naxxar Lions	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219906190	f	\N	\N	\N
8637	Baladeyet Al-Mahalla	Al Ittihad (EGY)	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219982049	f	\N	\N	\N
8638	Lille (W)	Paris St-G (W)	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219943026	f	\N	\N	\N
8639	Saint-Etienne (W)	Le Havre AC (W)	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219943233	f	\N	\N	\N
8640	Stal Rzeszow	Zaglebie Sosnowiec	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219415970	f	\N	\N	\N
8641	SFC Opava	MAS Taborsko	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219538122	f	\N	\N	\N
8632	Sandnes Ulf	Fredrikstad	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219551602	t	2	\N	204
8624	Kristiansund	Asane	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219551938	t	2	\N	204
8616	Jerv	Kongsvinger	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219551848	t	1	\N	204
8630	Mjondalen	Start	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219552028	t	1	\N	204
8628	Hodd	Sogndal	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219551465	t	2	\N	204
8643	Sakaryaspor	Adanaspor	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219736462	f	\N	\N	\N
8644	Gaziantep FK	Antalyaspor	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219457377	f	\N	\N	\N
8645	Konyaspor	Pendikspor	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219200541	f	\N	\N	\N
8646	MFK Karvina	Hradec Kralove	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219446536	f	\N	\N	\N
8648	KCB	Ulinzi Stars	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219812577	f	\N	\N	\N
8649	Ihefu SC	Coastal Union	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219966301	f	\N	\N	\N
8650	Rudar	Dravinja Kostroj	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219896930	f	\N	\N	\N
8651	EA Guingamp (W)	Bordeaux (W)	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219943132	f	\N	\N	\N
8652	Degerfors	Kalmar FF	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219914745	f	\N	\N	\N
8653	Bala Town	Haverfordwest County	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219943696	f	\N	\N	\N
8655	H Slavia Kromeriz	Varnsdorf	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219540122	f	\N	\N	\N
9792	Viking	Tromso	2023-10-22 18:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219210336	t	0	7	13
8658	Barry Town Utd	The New Saints	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219943422	f	\N	\N	\N
8659	Lokomotiv Sofia	CSKA 1948 Sofia	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219537538	f	\N	\N	\N
8660	Lisen	Sparta Prague B	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219540393	f	\N	\N	\N
8662	Caernarfon Town	Cardiff Metropolitan	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219943512	f	\N	\N	\N
8663	Monastir	Club Sportif Sfaxien	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219982720	f	\N	\N	\N
8665	Pontypridd Town	Connahs Quay	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219943604	f	\N	\N	\N
8685	Worthing	Yeovil	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219827248	f	\N	\N	\N
8681	Kortrijk	Club Brugge	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219458649	t	1	\N	68
8670	FC Cartagena II	CA Antoniano	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899011	f	\N	\N	\N
8671	Shakhtar	LNZ-Lebedyn	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219467137	f	\N	\N	\N
8672	St Johnstone	Motherwell	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219098382	f	\N	\N	\N
8666	Ballymena	Coleraine	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219746931	f	\N	\N	\N
8680	Ariana FC	Oddevold	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864263	f	\N	\N	\N
8668	Glentoran	Glenavon	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219746841	f	\N	\N	\N
8693	Honka	FC Inter	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219483558	f	\N	\N	\N
8683	AFC Fylde	Ebbsfleet Utd	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219347306	f	\N	\N	\N
8694	Atletico Clube de Portugal	Vizela	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219933867	f	\N	\N	\N
8699	Maidstone Utd	Farnborough FC	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219780865	f	\N	\N	\N
8696	Barrow	AFC Wimbledon	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492721	f	\N	\N	\N
8689	Stenhousemuir	Peterhead	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219402487	f	\N	\N	\N
8682	Bromley	Oxford City	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219346643	f	\N	\N	\N
8688	Orebro Syrianska	Sandvikens	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219867784	f	\N	\N	\N
8695	Ross Co	St Mirren	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219098034	f	\N	\N	\N
8684	Rochdale	Oldham	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219346553	f	\N	\N	\N
8692	Chester	Scunthorpe	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219781405	f	\N	\N	\N
8690	Rushall Olympic	Chorley	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219813044	f	\N	\N	\N
8691	South Shields	Kings Lynn	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219783492	f	\N	\N	\N
8667	Dungannon	Crusaders	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219747021	f	\N	\N	\N
8674	Cheltenham	Cambridge Utd	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219637702	f	\N	\N	\N
8687	Bishops Stortford	Warrington Town	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219781495	f	\N	\N	\N
8686	East Fife	Stranraer	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219401859	f	\N	\N	\N
8678	Deportivo Alaves C	Lagun Onak	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219975991	f	\N	\N	\N
8676	CD Nacional Funchal	Mirandela	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219932973	f	\N	\N	\N
8677	Gillingham	Notts Co	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492361	f	\N	\N	\N
8675	Eskilsminne	Ahlafors IF	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219865526	f	\N	\N	\N
8673	Arbroath	Raith	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219387380	f	\N	\N	\N
8697	Stoke	Sunderland	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219384191	f	\N	\N	\N
8669	Loughgall	Newry	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219746751	f	\N	\N	\N
8657	SV Darmstadt	RB Leipzig	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219109200	t	2	\N	1
8664	Union Berlin	Stuttgart	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219109080	t	1	3	1
8661	Freiburg	Bochum	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219109320	t	2	\N	1
8647	Verona	Napoli	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219117653	t	2	\N	4
8654	Hoffenheim	Eintracht Frankfurt	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219114180	t	2	\N	1
10088	Atletico Chiriqui	San Francisco FC	2023-10-23 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220102902	f	\N	\N	\N
8738	Gloucester	Alfreton Town	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219813225	f	\N	\N	\N
8730	Sporting de Huelva (W)	Atletico Madrid (W)	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219788638	f	\N	\N	\N
8702	Colchester	Harrogate Town	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492811	f	\N	\N	\N
8717	Barnet	Maidenhead	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219346733	f	\N	\N	\N
8722	Elgin City FC	Forfar	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219401949	f	\N	\N	\N
8724	Torns	Vanersborgs IF	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219863530	f	\N	\N	\N
8746	Weymouth	Eastbourne	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219781045	f	\N	\N	\N
8755	IFK Stocksund	FC Stockholm Internazionale	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219863371	f	\N	\N	\N
8706	Stockport	Grimsby	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492091	f	\N	\N	\N
8709	Aveley	Truro City	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219827700	f	\N	\N	\N
8719	Annan	Queen of South	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219393711	f	\N	\N	\N
8734	Banbury Utd	Darlington	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219781585	f	\N	\N	\N
8727	Leyton Orient	Barnsley	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219638122	f	\N	\N	\N
8754	Oxford Utd	Blackpool	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219636880	f	\N	\N	\N
8728	Shrewsbury	Derby	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219636261	f	\N	\N	\N
8716	Aldershot	Hartlepool	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219347100	f	\N	\N	\N
8721	Bolton	Northampton	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219636745	f	\N	\N	\N
8748	Hermannstadt	Dinamo Bucharest	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219173443	f	\N	\N	\N
8740	Peterborough Sports FC	Southport	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219781225	f	\N	\N	\N
8732	Huddersfield	QPR	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219384625	t	2	\N	77
8749	FC Astana	FC Zhetysu	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219939828	f	\N	\N	\N
8704	Dunfermline	Ayr	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219387290	f	\N	\N	\N
8723	Hamilton	Edinburgh City	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219393806	f	\N	\N	\N
8712	Eastleigh	York City	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219347396	f	\N	\N	\N
8726	Fleetwood Town	Lincoln	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219638446	f	\N	\N	\N
8753	Rangers	Hibernian	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219098162	f	\N	\N	\N
8742	Dartford	Havant and W	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219827429	f	\N	\N	\N
8743	Dover	Hemel Hempstead	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219827158	f	\N	\N	\N
8745	Slough Town	Chelmsford	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219780955	f	\N	\N	\N
8752	CSF Balti	FC Milsami-Ursidos	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219967618	f	\N	\N	\N
8750	Algeciras	AD Ceuta FC	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864624	f	\N	\N	\N
8725	Southend	Solihull Moors	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219347486	f	\N	\N	\N
8756	Spartans	Dumbarton	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219402577	f	\N	\N	\N
8729	Crawley Town	Crewe	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492541	f	\N	\N	\N
8737	West Brom	Plymouth	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219384083	f	\N	\N	\N
8735	Varazdin	Lokomotiva	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219537718	f	\N	\N	\N
8705	Watford	Sheff Wed	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219384299	f	\N	\N	\N
8739	Hereford FC	Curzon Ashton	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219781315	f	\N	\N	\N
8744	CD Cortes	Bidezarra	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219976082	f	\N	\N	\N
8701	Tonbridge Angels	Bath City	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219827610	f	\N	\N	\N
8711	Torquay	Welling Utd	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219827338	f	\N	\N	\N
8715	Fci Tallinn	Tammeka Tartu	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510276	f	\N	\N	\N
8708	Chesterfield	Gateshead	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219346463	f	\N	\N	\N
8720	Dag and Red	Woking	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219347010	f	\N	\N	\N
8736	Swansea	Leicester	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219384515	f	\N	\N	\N
8700	Accrington	MK Dons	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219491911	f	\N	\N	\N
8703	Bradford	Wrexham	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492901	f	\N	\N	\N
8731	Mansfield	Forest Green	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492181	f	\N	\N	\N
8707	Sutton Utd	Morecambe	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492001	f	\N	\N	\N
8713	Bournemouth	Wolves	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219122859	t	1	3	2
8751	Exeter	Wigan	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219636493	f	\N	\N	\N
8718	Morton	Inverness CT	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219387200	f	\N	\N	\N
8747	Nottm Forest	Luton	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219148952	f	\N	\N	\N
8733	Middlesbrough	Birmingham	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219384849	t	0	1	77
10093	UNAN Managua	CD Walter Ferreti	2023-10-23 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220086550	f	\N	\N	\N
8780	Farsley Celtic	Brackley Town	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219813134	f	\N	\N	\N
8769	Cove Rangers	Montrose	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219392969	f	\N	\N	\N
8771	HJK Helsinki	KuPS	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219483648	f	\N	\N	\N
8774	Charlton	Reading	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219638014	f	\N	\N	\N
8778	Peterborough	Wycombe	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219636992	f	\N	\N	\N
8781	FC Halifax Town	Kidderminster	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219347216	f	\N	\N	\N
8698	Braintree	Weston-super-Mare	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219781675	f	\N	\N	\N
8710	Chippenham	St Albans	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219827519	f	\N	\N	\N
8773	Norwich	Leeds	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219384741	t	2	\N	77
8761	Bristol City	Coventry	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219384959	f	\N	\N	\N
8759	SJK	VPS	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219483466	f	\N	\N	\N
8758	Partick	Dundee Utd	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219387110	f	\N	\N	\N
8765	Anderlecht B	SL 16 FC	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219749779	f	\N	\N	\N
8757	Stevenage	Port Vale	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219636369	f	\N	\N	\N
8770	Cottbus	Carl Zeiss Jena	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219921694	f	\N	\N	\N
8762	Hull	Southampton	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219384407	t	2	\N	77
8766	Kilmarnock	Livingston	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219098274	f	\N	\N	\N
8775	Alloa	Kelty Hearts	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219393075	f	\N	\N	\N
8767	Bonnyrigg	Clyde	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219402073	f	\N	\N	\N
8772	Scarborough Athletic	Buxton	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219783186	f	\N	\N	\N
8779	Portsmouth	Carlisle	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219636621	f	\N	\N	\N
8789	Pro Vercelli	Pergolettese	2023-10-21 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219817185	f	\N	\N	\N
8763	Union de Salamanca	CA Tarazona	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219788728	f	\N	\N	\N
8768	Tromsdalen	Baerum	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219962872	f	\N	\N	\N
8782	Man City	Brighton	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219119154	t	2	\N	2
8776	Brentford	Burnley	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219149093	f	\N	\N	\N
8788	Catanzaro	Feralpisalo	2023-10-21 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219482110	f	\N	\N	\N
8792	Lumezzane	Giana Erminio	2023-10-21 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219817095	f	\N	\N	\N
8791	Villarreal B	Mirandes	2023-10-21 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219775091	f	\N	\N	\N
8787	Renate	Aurora Pro Patria 1919	2023-10-21 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219817005	f	\N	\N	\N
8786	Amorebieta	Oviedo	2023-10-21 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219775001	f	\N	\N	\N
8790	Getafe	Betis	2023-10-21 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219118493	f	\N	\N	\N
8797	Panaitolikos	NFC Volos	2023-10-21 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219000907	f	\N	\N	\N
8793	Pena Balsamaiso	Club Haro Deportivo	2023-10-21 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219976352	f	\N	\N	\N
8794	Vila Mea	Club Football Estrela	2023-10-21 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219932823	f	\N	\N	\N
8795	Kerala Blasters FC	Northeast United	2023-10-21 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219749869	f	\N	\N	\N
8799	CD Villacanas	CD Tarancon	2023-10-21 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219976262	f	\N	\N	\N
8796	Duisburg	Arminia Bielefeld	2023-10-21 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219610455	f	\N	\N	\N
8800	Felanitx	SD Portmany	2023-10-21 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219976476	f	\N	\N	\N
8801	Rabo de Peixe	Casa Pia	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219933333	f	\N	\N	\N
8808	CLub Rapido de Bouzas	Atletico Arteixo	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219976837	f	\N	\N	\N
8803	Ujpest	Kecskemeti	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219502372	f	\N	\N	\N
8810	Nafta Lendava	NK Jadran Dekani	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219897020	f	\N	\N	\N
8805	CD Basconia	Pasaia Kirol Elkartea	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219976747	f	\N	\N	\N
8804	Drochtersen-Assel	St Pauli II	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219922594	f	\N	\N	\N
8811	Santa Lucia FC	Gudja United	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219906372	f	\N	\N	\N
8802	AD San Juan	UD Logrones	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219897393	f	\N	\N	\N
8812	Dinamo Tbilisi	Gagra	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219967920	f	\N	\N	\N
8814	FC Jove Espanol	CD Acero	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219976566	f	\N	\N	\N
8809	SS Reyes	AD Llerenense	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219907292	f	\N	\N	\N
8806	UD Mutilvera	Athletic Bilbao B	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219897483	f	\N	\N	\N
8807	Sturm Graz	Hartberg	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219486396	t	2	\N	43
8813	Al Nassr	Dhamk	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219609154	f	\N	\N	\N
8760	Blackburn	Cardiff	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219385236	t	0	1	77
10096	San Diego Loyal SC	Phoenix Rising FC	2023-10-23 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220101348	f	\N	\N	\N
8818	Al-Hazm (KSA)	Al-Raed (KSA)	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219609784	f	\N	\N	\N
8819	Paris St-G	Strasbourg	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219116811	t	2	\N	5
8816	Red Bull Salzburg	LASK Linz	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219486504	f	\N	\N	\N
8831	Stade Lausanne-Ouchy	Lausanne	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219569364	t	1	4	15
8821	Hamrun Spartans FC	Sliema Wanderers FC	2023-10-21 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219906098	f	\N	\N	\N
8823	Malveira	AD Marco 09	2023-10-21 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219932733	f	\N	\N	\N
8826	Balsicas Atletico	CD Plus Ultra	2023-10-21 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219976927	f	\N	\N	\N
8822	CF Platges de Calvia	CE Alaior	2023-10-21 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219977017	f	\N	\N	\N
8827	Gjovik-Lyn	Alta	2023-10-21 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219962962	f	\N	\N	\N
8824	Slask Wroclaw	Legia Warsaw	2023-10-21 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219408753	f	\N	\N	\N
8828	GKS Tychy	Podbeskidzie B-B	2023-10-21 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219416420	f	\N	\N	\N
8825	Sirius	Brommapojkarna	2023-10-21 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219483738	t	2	\N	14
8829	SD Deusto	SCD Durango	2023-10-21 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219977107	f	\N	\N	\N
8830	Treaty United (W)	Galway WFC (W)	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219995106	f	\N	\N	\N
8843	V de Santa Brigida	CD Tenerife II	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219977197	f	\N	\N	\N
8834	FC Baden	Sion	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219564823	f	\N	\N	\N
8871	Sevilla	Real Madrid	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219118613	t	0	\N	3
8841	Goztepe	Sanliurfaspor	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219754064	f	\N	\N	\N
8840	FK Dubocica	FK Sloboda Point	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219968788	f	\N	\N	\N
8836	ENPPI	National Bank	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219825768	f	\N	\N	\N
8838	Torpedo Kutaisi	Samtredia	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219969345	f	\N	\N	\N
8853	Zilina	Dunajska Streda	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219252937	f	\N	\N	\N
8837	Pirin Blagoevgrad	CSKA Sofia	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219535042	f	\N	\N	\N
8850	Sassuolo (W)	Como FC (W)	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219983037	f	\N	\N	\N
8844	CD Teruel	Fuenlabrada	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219788088	f	\N	\N	\N
8835	Leixoes	Setubal	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219933423	f	\N	\N	\N
8851	Galatasaray	Besiktas	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219200650	f	\N	\N	\N
8848	Slavia Prague	Slovacko	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219404197	f	\N	\N	\N
8832	Podbrezova	Ruzomberok	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219252847	f	\N	\N	\N
8845	Al Najma (BRN)	East Riffa	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219961448	f	\N	\N	\N
8847	FC Kosice	DUKLA BANSKA BYSTRICA	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219266310	f	\N	\N	\N
8846	Merida AD	Real Murcia	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864895	f	\N	\N	\N
8842	Oleksandria	Kolos Kovalyovka	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219467317	f	\N	\N	\N
8852	Trencin	MFK Skalica	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219266220	f	\N	\N	\N
8833	Brann	Molde	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219210444	t	1	\N	13
8839	Zamalek	Smouha	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219804579	f	\N	\N	\N
8849	Torino	Inter	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219117773	f	\N	\N	\N
8855	HNK Gorica	Dinamo Zagreb	2023-10-21 17:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219537898	f	\N	\N	\N
8856	UD Las Palmas II	UD Ibarra	2023-10-21 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219977287	f	\N	\N	\N
8857	Leicester City (W)	Man City (W)	2023-10-21 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219895546	f	\N	\N	\N
8858	Molenbeek	Westerlo	2023-10-21 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219458955	t	0	2	68
8867	Mantova	Novara	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219817635	f	\N	\N	\N
8862	Audace Cerignola	US Latina Calcio	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219818265	f	\N	\N	\N
8866	Crotone	Foggia	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219817455	f	\N	\N	\N
8860	Espanyol B	CF Badalona Futur	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219897573	f	\N	\N	\N
8868	Sorrento	Benevento	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219817275	f	\N	\N	\N
8863	Wealdstone	Boreham Wood	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219346825	f	\N	\N	\N
8864	Mainz	Bayern Munich	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219109440	t	2	\N	1
8861	Nk Posusje	Gosk Gabela	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219856167	f	\N	\N	\N
8869	Barcelona (W)	Granada (W)	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219862958	f	\N	\N	\N
8854	Young Boys	FC Zurich	2023-10-21 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219486538	t	0	0	15
8859	Tenerife	Levante	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219764972	f	\N	\N	\N
8870	Chelsea	Arsenal	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219119718	f	\N	\N	\N
8820	FC Copenhagen	Vejle	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219457161	t	0	\N	40
8878	Vozdovac	FK Backa Topola	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219891996	f	\N	\N	\N
8885	ESTAC Troyes	Concarneau	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510726	f	\N	\N	\N
10097	Club Tijuana (W)	FC Juarez (W)	2023-10-23 03:06:00	https://www.orbitxch.com/customer/sport/1/market/1.220102992	f	\N	\N	\N
8872	FC Giugliano	Potenza	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219818355	f	\N	\N	\N
8921	Feyenoord	Vitesse Arnhem	2023-10-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219480661	t	2	\N	196
8873	RKC Waalwijk	FC Volendam	2023-10-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219481094	t	1	3	196
8875	Xerez CD	CD Utrera	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219977591	f	\N	\N	\N
8880	Aris	Panserraikos	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219999571	f	\N	\N	\N
8882	Sabadell	Deportivo	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219787998	f	\N	\N	\N
8877	AC Ajaccio	Pau	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510996	f	\N	\N	\N
8887	Guingamp	Quevilly Rouen	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510546	f	\N	\N	\N
8879	Angers	Bordeaux	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510906	f	\N	\N	\N
8881	Annecy	Amiens	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510456	f	\N	\N	\N
8886	Grenoble	Valenciennes	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510816	f	\N	\N	\N
8888	Rodez	Bastia	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510366	f	\N	\N	\N
8884	Dunkerque	Paris FC	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219510636	f	\N	\N	\N
8876	Aberdeen	Dundee	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219098492	f	\N	\N	\N
8883	SD Revilla	SD Solares-Medio Cudeyo	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219977377	f	\N	\N	\N
8892	Miedz Legnica	Wisla Plock	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219416240	f	\N	\N	\N
8891	Leonesa	Arenteiro	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219787908	f	\N	\N	\N
8874	PSV	Fortuna Sittard	2023-10-21 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219480986	t	1	4	196
8896	Felgueiras	Arouca	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219933063	f	\N	\N	\N
8902	Al-Shabab (KSA)	Al Taee	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219753834	f	\N	\N	\N
8918	Az Alkmaar	Heerenveen	2023-10-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219480155	t	1	\N	196
8903	Alianza Atletico	Deportivo Municipal	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219523929	f	\N	\N	\N
8897	Cumbaya FC	Tecnico Universitario	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219612650	f	\N	\N	\N
8893	Lierse	Seraing Utd	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219780504	f	\N	\N	\N
8899	Malaga	Real Madrid Castilla	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219865075	f	\N	\N	\N
8895	NEC Nijmegen	Almere City	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219480553	f	\N	\N	\N
8901	Pumas UNAM (W)	Atletico San Luis (W)	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219971685	f	\N	\N	\N
8894	Lech Poznan	LKS Lodz	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219408843	f	\N	\N	\N
8904	Al Ahli	Al-Wahda (KSA)	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219753660	f	\N	\N	\N
8905	Domzale	Olimpija	2023-10-21 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219505402	f	\N	\N	\N
8898	Roda JC	Willem II	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219770010	t	1	1	199
8900	Zulte-Waregem	FC Liege	2023-10-21 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219782217	t	0	1	136
8914	Zeljeznicar	Zvijezda 09 Bijeljina	2023-10-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219855881	f	\N	\N	\N
8913	AP Turris Calcio	Juve Stabia	2023-10-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219817545	f	\N	\N	\N
8910	Albinoleffe	Alessandria	2023-10-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219817725	f	\N	\N	\N
8911	Arzignanochiampo	Padova	2023-10-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219817365	f	\N	\N	\N
8907	Fortuna Dusseldorf	Kaiserslautern	2023-10-21 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219174909	t	2	\N	93
8922	Rampla Juniors	Sud America	2023-10-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219973525	f	\N	\N	\N
8906	FC Basel	Servette	2023-10-21 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219486628	t	0	1	15
8912	Sassuolo	Lazio	2023-10-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219122678	t	2	\N	4
8916	Academico de Viseu	Leiria	2023-10-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219933243	f	\N	\N	\N
8920	Zaragoza	Eibar	2023-10-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219774911	f	\N	\N	\N
8908	Charleroi	Antwerp	2023-10-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219459261	t	0	\N	68
8917	Sheff Utd	Man Utd	2023-10-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219149234	f	\N	\N	\N
8915	Nice	Marseille	2023-10-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219116931	f	\N	\N	\N
8923	Olivais e Moscavide	Sporting Lisbon	2023-10-21 20:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219934427	f	\N	\N	\N
8927	Municipal Santa Ana	Municipal Turrialba	2023-10-21 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219982855	f	\N	\N	\N
8925	CRB	Criciuma	2023-10-21 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219536886	f	\N	\N	\N
8924	Botafogo SP	Novorizontino	2023-10-21 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219536994	f	\N	\N	\N
8926	Cavalry	Pacific	2023-10-21 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219812037	f	\N	\N	\N
8928	Atletico Nacional (W)	SC Internacional (W)	2023-10-21 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220001491	f	\N	\N	\N
8919	Celta Vigo	Atletico Madrid	2023-10-21 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219118733	t	1	\N	3
8931	Gavilanes Matamoros	Atletico Saltillo	2023-10-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219981473	f	\N	\N	\N
8930	Tauro FC	Arabe Unido	2023-10-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219994948	f	\N	\N	\N
8932	Olimpia	Club Sportivo Trinidense	2023-10-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219900277	f	\N	\N	\N
8938	Coban Imperial	CSD Municipal	2023-10-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219924832	f	\N	\N	\N
8934	Santa Fe	Millonarios	2023-10-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219819353	f	\N	\N	\N
8935	Caracas	Deportivo Tachira	2023-10-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219953405	f	\N	\N	\N
8933	Alianza Lima	Asociacion Deportiva Tarma	2023-10-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219523839	f	\N	\N	\N
8936	Juventude	Londrina	2023-10-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219537102	f	\N	\N	\N
8937	Bolivar	Nacional Potosi	2023-10-21 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219924076	f	\N	\N	\N
8941	Sao Paulo	Gremio	2023-10-21 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219524700	f	\N	\N	\N
8939	Bahia	Fortaleza EC	2023-10-21 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219525660	f	\N	\N	\N
8940	Cuiaba	Goias	2023-10-21 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219525420	f	\N	\N	\N
8944	Aguacateros de Peribán F.C	Deportivo Irapuato F	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219999227	f	\N	\N	\N
8942	Tritones Vallarta MFC	Mexicali FC	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219983313	f	\N	\N	\N
8943	Colima FC	Los Cabos United	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219983133	f	\N	\N	\N
8945	Atlético Pachuca	Caja Oblatos C.FD	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219981293	f	\N	\N	\N
8947	Columbus	CF Montreal	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219555477	t	2	\N	76
8946	New England	Philadelphia	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219763339	f	\N	\N	\N
8960	Inter de Queretaro FC	Deportiva Venados	2023-10-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219983494	f	\N	\N	\N
8954	Defensor Sporting	Cerro Largo FC	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219921334	f	\N	\N	\N
8952	Charlotte FC	Inter Miami CF	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219942900	t	1	1	76
8948	Nashville SC	New York Red Bulls	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219762243	f	\N	\N	\N
8950	New York City	Chicago Fire	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219555981	f	\N	\N	\N
8949	Club Oriental de La Paz	Albion FC	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219982445	f	\N	\N	\N
8955	Club CDM	Ciervos fc	2023-10-21 23:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219981383	f	\N	\N	\N
8956	Tacuarembo	CA Rentistas	2023-10-21 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219982535	f	\N	\N	\N
8961	Barcelona (Ecu)	Libertad FC	2023-10-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219649581	f	\N	\N	\N
8967	Palmeiras (W)	Corinthians (W)	2023-10-22 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219985656	f	\N	\N	\N
8959	Lobos UPNFM	Vida	2023-10-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952600	f	\N	\N	\N
8962	CS Cartagines	Deportivo Saprissa	2023-10-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952330	f	\N	\N	\N
8963	Sporting San Jose FC	AD Guanacasteca	2023-10-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952420	f	\N	\N	\N
8957	Leon	Toluca	2023-10-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219495486	f	\N	\N	\N
8964	Escorpiones FC	CD Pioneros de Cancun	2023-10-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219983404	f	\N	\N	\N
8966	Tampa Bay Rowdies	Birmingham Legion FC	2023-10-22 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219856797	f	\N	\N	\N
8970	Botafogo	Athletico-PR	2023-10-22 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219525300	f	\N	\N	\N
8969	Portuguesa FC	Puerto Cabello	2023-10-22 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219953495	f	\N	\N	\N
8968	Cerro Porteno	Resistencia SC	2023-10-22 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219900367	f	\N	\N	\N
8977	CF America	Santos Laguna	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219494991	f	\N	\N	\N
8972	Escorpiones FC	Uruguay de Coronado	2023-10-22 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219985014	f	\N	\N	\N
8971	Guabira	FC Libertad Gran Mamoré	2023-10-22 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219922324	f	\N	\N	\N
8982	St Louis City SC	Seattle Sounders	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219556305	f	\N	\N	\N
8978	Colorado	Real Salt Lake	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219765588	t	0	1	76
8980	Portland Timbers	Houston Dynamo	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219556197	t	2	\N	76
8951	Toronto FC	Orlando City	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219555873	t	0	2	76
8953	FC Cincinnati	Atlanta Utd	2023-10-21 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219555585	t	2	\N	76
8976	Napier City Rovers	Manurewa AFC	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219931027	f	\N	\N	\N
8973	Kansas City	Minnesota Utd	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219556521	f	\N	\N	\N
8981	San Jose Earthquakes	Austin FC	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219556413	t	2	\N	76
8974	Vancouver Whitecaps	Los Angeles FC	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219556089	t	1	2	76
8979	LA Galaxy	FC Dallas	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219764481	t	2	\N	76
8965	Union Magdalena	Atletico Bucaramanga	2023-10-22 00:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219819443	f	\N	\N	\N
8975	Northern Colorado FC	Forward Madison FC	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219985753	f	\N	\N	\N
8541	Hamburger SV	Greuther Furth	2023-10-21 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219175341	t	2	\N	93
8615	Bodo Glimt	Sandefjord	2023-10-21 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219210553	t	2	\N	13
8777	Stirling	Falkirk	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219392863	f	\N	\N	\N
8764	Taunton Town	Hampton and Richmond	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219781135	f	\N	\N	\N
8741	Spennymoor Town	Boston Utd	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219783582	f	\N	\N	\N
9043	Burton Albion	Bristol Rovers	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219637285	f	\N	\N	\N
9044	Blyth Spartans	Tamworth FC	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219812954	f	\N	\N	\N
8679	Salford City	Swindon	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492271	f	\N	\N	\N
8714	Newcastle	Crystal Palace	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219119436	f	\N	\N	\N
9118	FK Banga Gargzdu	Riteriai	2023-10-21 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219564191	f	\N	\N	\N
8798	CD La Virgen del Camino	Atletico Astorga CF	2023-10-21 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219976172	f	\N	\N	\N
8817	Atzeneta UE	Ontinyent CF	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219976656	f	\N	\N	\N
8865	Crvena Zvezda	FK Javor Ivanjica	2023-10-21 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219892206	f	\N	\N	\N
9220	Leones Negros Udg	Mineros de Fresnillo FC	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219969533	f	\N	\N	\N
9221	FC Inter Manacor	UD Poblense	2023-10-21 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219977501	f	\N	\N	\N
8909	Farul Constanta	Universitatea Cluj	2023-10-21 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219173533	f	\N	\N	\N
8929	Mushuc Runa	Deportivo Cuenca	2023-10-21 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219612740	f	\N	\N	\N
8988	Junior FC Barranquilla	Once Caldas	2023-10-22 02:20:00	https://www.orbitxch.com/customer/sport/1/market/1.219819533	f	\N	\N	\N
8989	Xelaju	CSD Tellioz	2023-10-22 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219924922	f	\N	\N	\N
8991	Eastern Suburbs Auckland	Auckland City	2023-10-22 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219930939	f	\N	\N	\N
8990	CS Herediano	Puntarenas F.C.	2023-10-22 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219952150	f	\N	\N	\N
8992	Orange County Blues	El Paso Locomotive FC	2023-10-22 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219856887	f	\N	\N	\N
8993	Tigres	Cruz Azul	2023-10-22 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.219494901	f	\N	\N	\N
8994	Renofa Yamaguchi	Okayama	2023-10-22 04:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219475818	f	\N	\N	\N
8998	Veertien Kuwana	Briobecca Urayasu SC	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220011732	f	\N	\N	\N
8995	Criacao Shinjuku	Kochi Univ	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219991995	f	\N	\N	\N
8997	Verspah Oita	Okinawa SV	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219992085	f	\N	\N	\N
8996	Suzuka Unlimited	MIO Biwako Shiga	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219991905	f	\N	\N	\N
8999	Kumamoto	FC Machida	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219478597	f	\N	\N	\N
9004	Tottori	Toyama	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219833365	f	\N	\N	\N
9002	Nagano Parceiro	FC Osaka	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219834201	f	\N	\N	\N
9000	Western Sydney Wanderers	Wellington Phoenix	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219278889	f	\N	\N	\N
9001	Fukushima Utd	Vanraure Hachinohe	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219833455	f	\N	\N	\N
9398	Tokushima	Iwata	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219478237	f	\N	\N	\N
9003	Yokohama SCC	Tegevajaro Miyazaki	2023-10-22 05:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219833605	f	\N	\N	\N
9005	Gimpo Citizen	Jeonnam Dragons	2023-10-22 05:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219750094	f	\N	\N	\N
9396	Kamatamare Sanuki	Kitakyushu	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219833695	f	\N	\N	\N
9397	FC Seoul	Gangwon	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219731795	f	\N	\N	\N
8656	Wolfsburg	Leverkusen	2023-10-21 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219114300	t	2	\N	1
8815	FC Blau Weiss Linz	SC AUSTRIA LUSTENAU	2023-10-21 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219485249	t	\N	\N	\N
8958	Cafetaleros de Chiapas II	Inter Playa Del Carmen	2023-10-22 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219983223	f	\N	\N	\N
8983	Cusco FC	Universitario de Deportes	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219524469	f	\N	\N	\N
8984	A.D. Cofutpa	PFA Antioquia FC	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219986100	f	\N	\N	\N
9370	Diriangen FC	Managua FC	2023-10-22 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220053501	f	\N	\N	\N
8985	Queretaro	Tijuana	2023-10-22 02:06:00	https://www.orbitxch.com/customer/sport/1/market/1.219495666	f	\N	\N	\N
8986	Herrera FC	UMECIT	2023-10-22 02:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219995320	f	\N	\N	\N
8987	Atletico Independiente	CD Universitario	2023-10-22 02:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219995196	f	\N	\N	\N
9399	Western United (W)	Melbourne Victory (W)	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219930039	f	\N	\N	\N
9400	Azul Claro Numazu	Matsumoto	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219834111	f	\N	\N	\N
9401	Blaublitz Akita	Sendai	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219478778	f	\N	\N	\N
10100	Nacional (Uru)	Deportivo Maldonado	2023-10-24 00:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219959947	f	\N	\N	\N
10101	Club Sportivo Ameliano	Tacuary	2023-10-24 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220104767	f	\N	\N	\N
9402	Mito	Thespakusatsu Gunma	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219478687	f	\N	\N	\N
9403	Tokyo-V	Jef Utd Chiba	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219478147	f	\N	\N	\N
9404	Tochigi SC	Oita	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219478507	f	\N	\N	\N
9406	Kanazawa	Yamagata	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219478417	f	\N	\N	\N
9407	Jeju Utd	Suwon Bluewings	2023-10-22 06:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219731705	f	\N	\N	\N
9408	Perth Glory (W)	Newcastle Jets (W)	2023-10-22 07:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219930144	f	\N	\N	\N
9409	Western Sydney (W)	Wellington Phoenix (W)	2023-10-22 07:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219769137	f	\N	\N	\N
9410	Jiangxi Dark Horse Junior	Hubei Chufeng Heli	2023-10-22 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220014537	f	\N	\N	\N
9411	Wuxi Wugou	Heilongjiang Lava Spring	2023-10-22 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219998398	f	\N	\N	\N
9412	Yanbian Longding	Guangzhou FC	2023-10-22 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220008744	f	\N	\N	\N
9413	Sham Shui Po	Resources Capital FC	2023-10-22 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219998753	f	\N	\N	\N
9414	Dalian Zhixing	Chongqing Tonglianglong	2023-10-22 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220009106	f	\N	\N	\N
9415	Qingdao Red Lions	Guangxi Lanhang	2023-10-22 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220009016	f	\N	\N	\N
9416	Cheongju FC	Gyeongnam	2023-10-22 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219750184	f	\N	\N	\N
9417	Yunnan Yukun	Beijing Tech FC	2023-10-22 08:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220008836	f	\N	\N	\N
9418	Yuen Long	South China	2023-10-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220012608	f	\N	\N	\N
9419	Eastern District SA	Citizen AA	2023-10-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220012518	f	\N	\N	\N
9420	Hoi King SA	Wong Tai Sin	2023-10-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220012788	f	\N	\N	\N
9421	Kowloon City FC	Sai Kung	2023-10-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220012698	f	\N	\N	\N
9422	Qingdao Jonoon	Tianjin Jinmen Tiger FC	2023-10-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219774821	f	\N	\N	\N
9423	Wing Yee	Shatin SA	2023-10-22 08:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220012878	f	\N	\N	\N
9424	Daejeon Citizen	Suwon FC	2023-10-22 08:40:00	https://www.orbitxch.com/customer/sport/1/market/1.219731885	f	\N	\N	\N
9425	Persita Tangerang	Persis Solo	2023-10-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219998867	f	\N	\N	\N
9426	Madura Utd	Dewa United FC	2023-10-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219999317	f	\N	\N	\N
9427	Kagoshima Utd	Grulla Morioka	2023-10-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219834291	f	\N	\N	\N
9428	FC Hunedoara	Chindia Targoviste	2023-10-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219589081	f	\N	\N	\N
9429	ACS Viitorul Tg Jiu	CS Mioveni	2023-10-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219589171	f	\N	\N	\N
9430	Okzhetpes	FK Aktobe	2023-10-22 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219999047	f	\N	\N	\N
9431	Sigma Olomouc B	FC Sellier & Bellot Vlasim	2023-10-22 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219540212	f	\N	\N	\N
9432	Zizkov	FC Zbrojovka Brno	2023-10-22 09:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219538212	f	\N	\N	\N
9433	Slovan Bratislava II	Samorin	2023-10-22 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220001581	f	\N	\N	\N
9434	St Polten	DSV Leoben	2023-10-22 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219353158	f	\N	\N	\N
9435	Hong Kong FC	Eastern AA	2023-10-22 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220001401	f	\N	\N	\N
9436	Perth Glory	Newcastle Jets	2023-10-22 09:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218897400	f	\N	\N	\N
9437	FC Schalke U19	Leverkusen U19	2023-10-22 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220001311	f	\N	\N	\N
9438	Marsaxlokk FC	Valletta	2023-10-22 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219906462	f	\N	\N	\N
9439	CD Calahorra B	Anguiano	2023-10-22 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220017727	f	\N	\N	\N
9440	Getafe B	CD Illescas	2023-10-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219907472	f	\N	\N	\N
9441	Ansan Greeners FC	Gimcheon Sangmu	2023-10-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219751888	f	\N	\N	\N
9442	Real Zaragoza II	UD Barbastro	2023-10-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219907382	f	\N	\N	\N
9443	Aurrera Ondarroa	CD Padura	2023-10-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220017908	f	\N	\N	\N
9444	Sevilla B	Manchego Ciudad Real	2023-10-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219899192	f	\N	\N	\N
9445	Arroyo	CD Don Alvaro	2023-10-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220017998	f	\N	\N	\N
9446	Club Portugalete	SD Beasain	2023-10-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220017817	f	\N	\N	\N
9447	Trival Valderas Alcorcon	CD Leganes II	2023-10-22 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220020702	f	\N	\N	\N
9448	CD Siete Villas	SD Torina	2023-10-22 10:45:00	https://www.orbitxch.com/customer/sport/1/market/1.220018090	f	\N	\N	\N
9449	Tuv Azarganuud	Khovd	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220053321	f	\N	\N	\N
9450	Gran Pena FC	Somozas	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220046201	f	\N	\N	\N
9451	Vihiga Bullets	Coast Stima FC	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220037683	f	\N	\N	\N
9452	Su Sintrense	Estoril Praia	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219937254	f	\N	\N	\N
9453	UCAM Murcia	Yeclano Deportivo	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899283	f	\N	\N	\N
9454	Dong Nai	Dong Thap	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220037593	f	\N	\N	\N
9455	FC Gifu	Nara Club	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219833875	f	\N	\N	\N
9456	Athletic Bilbao (W)	Real Sociedad (W)	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219859402	f	\N	\N	\N
9457	Torrent CF	Centre d'Esports Manresa	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899915	f	\N	\N	\N
9458	Madrid (W)	UDG Tenerife Sur (W)	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219780775	f	\N	\N	\N
9459	UD San Fernando	Cacereno	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219907562	f	\N	\N	\N
9460	Melilla UD	Antequera CF	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219865255	f	\N	\N	\N
9461	Malaga CF II	Juventud Torremolinos	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018540	f	\N	\N	\N
9462	Racing Murcia FC	Alcantarilla FC	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018900	f	\N	\N	\N
9463	Song Lam Nghe An	Viettel FC	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220009752	f	\N	\N	\N
9464	El Palo	Betis B	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899373	f	\N	\N	\N
9465	Mar Menor CF	Cadiz B	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899463	f	\N	\N	\N
9466	AD Union Adarve	UD Montijo	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219907652	f	\N	\N	\N
9467	AE Prat	UE Castelldefels	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018450	f	\N	\N	\N
9468	Veres Rivne	Rukh Vynnyky	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219780595	f	\N	\N	\N
9469	CD Alaves B	CD Izarra	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219898740	f	\N	\N	\N
9470	SD Logrones	Cornella	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219789388	f	\N	\N	\N
9471	CD Berceo	UD Logrones II	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018810	f	\N	\N	\N
9472	Intercity Sant Joan C.F	Atletico Baleares	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864714	f	\N	\N	\N
9473	CF Pozuelo de Alarcon	CD Mostoles	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220020792	f	\N	\N	\N
9474	FK Kauno Zalgiris 2	FK Nevezis	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220012092	f	\N	\N	\N
9475	Cordoba CF II	Pozoblanco	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220019080	f	\N	\N	\N
9476	FC L'Escala	CF Peralada	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018360	f	\N	\N	\N
9477	FK Riteriai II	BFA Vilnius	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220012002	f	\N	\N	\N
9478	Granada B	Ibiza Eivissa	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864534	f	\N	\N	\N
9479	Valladolid B	CD Covadonga	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219896300	f	\N	\N	\N
9480	CDE Ursaria	Talavera CF	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219907742	f	\N	\N	\N
9481	CE Andratx	UD Alzira	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899644	f	\N	\N	\N
9482	CE Europa	Hercules	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899734	f	\N	\N	\N
9483	SE Penya Independent	Terrassa	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219900006	f	\N	\N	\N
9484	Aviles Stadium CF	Barcia	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018720	f	\N	\N	\N
9485	FS METTA/LU	FK Jelgava	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219905436	f	\N	\N	\N
9486	CD Llanes	Caudal Deportivo	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018630	f	\N	\N	\N
9487	CD Llosetense	Manacor	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018990	f	\N	\N	\N
9488	Girona FC II	Pobla de Mafumet CF	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018270	f	\N	\N	\N
9489	Rapitenca	Badalona	2023-10-22 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220018180	f	\N	\N	\N
9491	Fortuna Sittard (W)	Ajax (W)	2023-10-22 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.220037773	f	\N	\N	\N
9492	CD Rincon	Almeria B	2023-10-22 11:15:00	https://www.orbitxch.com/customer/sport/1/market/1.220019170	f	\N	\N	\N
9493	Prachuap	Air Force Central	2023-10-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219912084	f	\N	\N	\N
9494	AC Milan (W)	Pomigliano (W)	2023-10-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220032802	f	\N	\N	\N
9495	Suphanburi	Kasetsart FC	2023-10-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220011642	f	\N	\N	\N
9496	Sivasspor	Kasimpasa	2023-10-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219199387	f	\N	\N	\N
9498	Belediyesi Bodrumspor	Bandirmaspor	2023-10-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219914461	f	\N	\N	\N
9499	Radomiak Radom	Korona Kielce	2023-10-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219403837	f	\N	\N	\N
9500	Iskenderunspor	Erzincanspor	2023-10-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219987880	f	\N	\N	\N
9501	Polonia Warszawa	Lechia Gdansk	2023-10-22 11:40:00	https://www.orbitxch.com/customer/sport/1/market/1.219415880	f	\N	\N	\N
9502	OGC Nice (W)	RC Lens (W)	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220054724	f	\N	\N	\N
9503	FSV Zwickau	Altglienicke	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219921604	f	\N	\N	\N
9504	Viktoria Berlin	Lokomotiv Leipzig	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219923892	f	\N	\N	\N
9505	Durham (W)	Blackburn Rovers (W)	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220009392	f	\N	\N	\N
9506	Celtic (W)	Rangers (W)	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220032892	f	\N	\N	\N
9507	Hebar	Slavia Sofia	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219536161	f	\N	\N	\N
9508	Ilioupoli	Diagoras	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220050150	f	\N	\N	\N
9509	Nakhon Ratchasima	Chiang Mai	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220011462	f	\N	\N	\N
9510	Karacabey Belediyespor AS	Erokspor A.S	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219987021	f	\N	\N	\N
9511	Nam Dinh	Quang Nam	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220009482	f	\N	\N	\N
9512	Gyirmot	Csakvar	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219820960	f	\N	\N	\N
9513	Lewes (W)	Sunderland (W)	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220036896	f	\N	\N	\N
9497	Roma	AC Monza	2023-10-22 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219117893	t	0	1	4
9514	Reading (W)	Sheffield United (W)	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220036986	f	\N	\N	\N
9515	Hamburg II	FC Kilia Kiel 1902	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219922864	f	\N	\N	\N
9516	FK Kaisar	FK Atyrau	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219940099	f	\N	\N	\N
9517	Traeff	Lyn	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010652	f	\N	\N	\N
9518	Vard Haugesund	Brattvag	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010382	f	\N	\N	\N
9519	Fremad Amager	Aarhus Fremad	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010832	f	\N	\N	\N
9520	Police Tero	Muangthong Utd	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219985982	f	\N	\N	\N
9522	Budafoki	Soroksar	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219820870	f	\N	\N	\N
9523	Hammarby TFF	United IK Nordic	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219870418	f	\N	\N	\N
9524	Fortuna Dusseldorf U19	Arminia Bielefeld U19	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220029275	f	\N	\N	\N
9525	IF Karlstad	Bodens	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219868218	f	\N	\N	\N
9526	Kazincbarcika	Tiszakecske VSE	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219820780	f	\N	\N	\N
9527	MTE 1904	Haladas	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219827948	f	\N	\N	\N
9528	FK Igman Konjic	Sarajevo	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219857598	f	\N	\N	\N
9529	Koge (W)	Thisted (W)	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010742	f	\N	\N	\N
9531	MTK Budapest	Puskas Akademia	2023-10-22 12:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219502642	f	\N	\N	\N
9534	Chanthaburi FC	Nongbua Pitchaya FC	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220011244	f	\N	\N	\N
9535	Genk	Yellow-Red Mechelen	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219458847	f	\N	\N	\N
9537	Van Buyuksehir Belediyespor	Diyarbekirspor	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219986817	f	\N	\N	\N
9538	Karlsruhe	Schalke 04	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219258490	f	\N	\N	\N
9539	Dongguan Guanlian	Shanghai Jiading	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220008926	f	\N	\N	\N
9540	Paide Linnameeskond	Kuressaare	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219511086	f	\N	\N	\N
9541	SV Sandhausen	Verl	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219780685	f	\N	\N	\N
9542	MCF	Kisumu All Stars	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220037863	f	\N	\N	\N
9543	Lyngby	AGF	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219458084	f	\N	\N	\N
9544	London City Lionesses	Southampton (W)	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220009302	f	\N	\N	\N
9545	Hibernian (W)	Hamilton WFC (W)	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220033163	f	\N	\N	\N
9546	Juventus B	Perugia	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219842085	f	\N	\N	\N
9547	Sassari Torres	Pontedera	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219841993	f	\N	\N	\N
9548	Bidco United	Muranga Seal	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219812217	f	\N	\N	\N
9549	68 Aksaray Belediyespor	Fethiyespor	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219987971	f	\N	\N	\N
9550	Duzcespor	Inegolspor	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219988151	f	\N	\N	\N
9551	PWD Bamenda	AS Fortuna Mfou	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220008250	f	\N	\N	\N
9552	Racing de Ferrol	Eldense	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219783926	f	\N	\N	\N
9553	Vorskla	Polissya Zhytomyr	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219912628	f	\N	\N	\N
9554	Brindisi	Casertana	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219818445	f	\N	\N	\N
9555	Fermana	Entella	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219841713	f	\N	\N	\N
9556	Ankara Demirspor	Serik Belediyespor	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219987404	f	\N	\N	\N
9557	Mersin Idman Yurdu	Afjet Afyonspor	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219987202	f	\N	\N	\N
9558	Schalke 04 II	SV Lippstadt	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219923710	f	\N	\N	\N
9559	FK Makedonija	FK Struga Trim-Lum	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010022	f	\N	\N	\N
9560	KF Shkupi	Bregalnica Stip	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220009842	f	\N	\N	\N
9561	Rabotnicki	Vardar Skopje	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220009932	f	\N	\N	\N
9562	Shkendija	Akademija Pandev	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010112	f	\N	\N	\N
9563	Everton (W)	Man Utd (W)	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219895185	f	\N	\N	\N
9564	Norderstedt	FC Phonix Lubeck	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219922684	f	\N	\N	\N
9565	Aberdeen (W)	Partick Thistle (W)	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220032983	f	\N	\N	\N
9566	SK Super Nova	Valmieras FK	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219905526	f	\N	\N	\N
9567	Ankaraspor	1461 Trabzon	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219987508	f	\N	\N	\N
9568	Las Palmas	Rayo Vallecano	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219165463	f	\N	\N	\N
9532	Hansa Rostock	Holstein Kiel	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219245381	t	2	\N	93
9536	Nurnberg	Hertha Berlin	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219175125	t	1	\N	93
9530	Landskrona	Vasteras SK	2023-10-22 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219500934	t	0	1	336
9533	FCV Dender	KV Oostende	2023-10-22 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219852524	t	1	2	136
9569	Persija Jakarta	RANS Nusantara FC	2023-10-22 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220050396	f	\N	\N	\N
9570	Bellinzona	Schaffhausen	2023-10-22 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219564733	f	\N	\N	\N
9571	Cong An Nhan Dan	Binh Dinh	2023-10-22 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.220009662	f	\N	\N	\N
9572	Ho Chi Minh City	Sanna Khanh Hoa	2023-10-22 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.220009572	f	\N	\N	\N
9573	FC Vaduz	Aarau	2023-10-22 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219564552	f	\N	\N	\N
9577	Denizlispor	76 Igdir Belediyespor	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219988061	f	\N	\N	\N
9578	Halide Edip Adivarspor	Kirsehir Belediyespor	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219986514	f	\N	\N	\N
9579	SCR Altach	Wolfsberger AC	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219485141	f	\N	\N	\N
9580	WSG Wattens	Austria Vienna	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219485362	f	\N	\N	\N
9581	Belediye Derincespor	Arnavutkoy Belediyesi GVS	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219988241	f	\N	\N	\N
9582	Usakspor	Etimesgut Belediyespor	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219988693	f	\N	\N	\N
9584	Altinordu	Kirklarelispor	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219987293	f	\N	\N	\N
9585	Bursaspor	Adiyamanspor	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219987112	f	\N	\N	\N
9586	Nazilli Belediyespor	Zonguldakspor	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219986930	f	\N	\N	\N
9587	Sariyer G.K.	Kastamonuspor	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219988513	f	\N	\N	\N
9616	Bryne	Skeid	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219683537	t	0	\N	204
9589	Kitayosce FC	KMC	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220033345	f	\N	\N	\N
9590	Rodez (W)	Thonon EG Geneve (W)	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220054544	f	\N	\N	\N
9591	Metz (W)	US Orleans Loiret (W)	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220054634	f	\N	\N	\N
9592	Torreense	Rio Ave	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219937344	f	\N	\N	\N
9596	Birmingham (W)	Watford (W)	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220037076	f	\N	\N	\N
9597	Charlton (W)	Crystal Palace (W)	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220009212	f	\N	\N	\N
9598	Istanbulspor	Ankaragucu	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219199496	f	\N	\N	\N
9599	Halmstads	Mjallby	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219484098	f	\N	\N	\N
9600	Lille	Brest	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219117171	f	\N	\N	\N
9601	Widzew Lodz	Ruch Chorzow	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219413282	f	\N	\N	\N
9602	Asteras Tripolis	AEK Athens	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219001503	f	\N	\N	\N
9603	Etihad Al Ramtha	Al Arabi (Jor)	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220011822	f	\N	\N	\N
9604	Kifisias FC	OFI	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219001593	f	\N	\N	\N
9605	Vittsjo (W)	Rosengard (W)	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220012272	f	\N	\N	\N
9606	Umraniyespor	Manisa FK	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219783366	f	\N	\N	\N
9607	Haras El Hodood	Aswan FC	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010922	f	\N	\N	\N
9610	Chelsea (W)	Brighton (W)	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219895095	f	\N	\N	\N
9611	Sparta Prague	Ceske Budejovice	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219446986	f	\N	\N	\N
9612	Teplice	Banik Ostrava	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219446896	f	\N	\N	\N
9613	VfB Oldenburg	Hannover II	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219926895	f	\N	\N	\N
9614	Pitea	Vasalunds IF	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219870724	f	\N	\N	\N
9615	NK Croatia Zmijavci	HNK Orijent 1919	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219856257	f	\N	\N	\N
9618	Lyn (W)	Valerenga (W)	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220037969	f	\N	\N	\N
9619	Odra Opole	Nieciecza	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219446806	f	\N	\N	\N
9621	Nomme Utd	Kohtla-Jarve	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220011192	f	\N	\N	\N
9622	Al Mokawloon	ZED FC	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220011068	f	\N	\N	\N
9624	Orgryte	Trelleborgs	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219500844	f	\N	\N	\N
9594	NK Bravo	NK Maribor	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219505493	f	\N	\N	\N
9593	SSD Fiorentina WFC (W)	Juventus FC (W)	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220033253	f	\N	\N	\N
9595	Tusker FC	Gor Mahia FC	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219812397	f	\N	\N	\N
9623	IK Brage	AFC Eskilstuna	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219501024	t	2	\N	336
9608	Moss	Ranheim IL	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219552118	t	0	\N	204
9617	KFUM Oslo	Raufoss	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219552211	t	0	0	204
9576	Heracles	FC Twente	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219479756	t	2	\N	196
9575	Lillestrom	Valerenga	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219210120	t	1	2	13
9609	AaB	B93 Copenhagen	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219607404	t	1	\N	147
9583	Excelsior	PEC Zwolle	2023-10-22 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219480769	t	1	\N	196
9574	Winterthur	St Gallen	2023-10-22 13:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219497020	t	0	\N	15
9625	Salernitana	Cagliari	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219332528	f	\N	\N	\N
9627	Djurgardens	Hammarby	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219484008	f	\N	\N	\N
9628	Giresunspor	Boluspor	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219783276	f	\N	\N	\N
9630	Oskarshamns AIK	Falkenbergs	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219865436	f	\N	\N	\N
9634	Hearts	Celtic	2023-10-22 14:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219098604	f	\N	\N	\N
9635	Avenir S Marsa	ES Metlaoui	2023-10-22 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220036806	f	\N	\N	\N
9636	DEBRECENI VSC	MOL Vidi	2023-10-22 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219502192	f	\N	\N	\N
9637	FC Koln	Mgladbach	2023-10-22 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219114773	f	\N	\N	\N
9638	IF Sylvia	Umea FC	2023-10-22 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219868524	f	\N	\N	\N
9639	PFC Levski Sofia	Cherno More	2023-10-22 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219537443	f	\N	\N	\N
9640	Etoile Sportive Sahel	AS Solimane	2023-10-22 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220036715	f	\N	\N	\N
9647	Cultural Montalegre	Pevidem SC	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219967708	f	\N	\N	\N
9659	Harju JK Laagri	Tallinna FC Flora	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219509284	f	\N	\N	\N
9664	West Ham United (W)	Liverpool (W)	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219895275	f	\N	\N	\N
9665	Linares Deportivo	San Fernando CD	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864444	f	\N	\N	\N
9651	Atletico Levante UD	CD Utiel	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220019260	f	\N	\N	\N
9660	Aigle Royal de la Menoua	Gazelle de Garoua	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220008430	f	\N	\N	\N
9669	B36 Torshavn	Klaksvikar Itrottarfelag	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220011372	f	\N	\N	\N
9661	Notodden	Arendal	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220010562	f	\N	\N	\N
9667	Hearts (W)	Motherwell (W)	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220033525	f	\N	\N	\N
9662	HB Koge	Naestved	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219607511	f	\N	\N	\N
9648	Chemie Leipzig	FC Eilenburg	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219922414	f	\N	\N	\N
9655	Real Union	Ponferradina	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219789205	f	\N	\N	\N
9653	Aatvidabergs FF	Ljungskile	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864173	f	\N	\N	\N
9650	Colombe du Dja et Lobo	Les Astres FC de Douala	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220008160	f	\N	\N	\N
9656	Alhashemyya	Samma	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220033435	f	\N	\N	\N
9641	Maritimo	Mortagua FC	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219968460	f	\N	\N	\N
9670	CS Petrocub	Dacia Buiucani	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220012182	f	\N	\N	\N
9646	Vilaverdense	Farense	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219995410	f	\N	\N	\N
9652	Dynamo Kiev	Dnipro-1	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219467227	f	\N	\N	\N
9649	Mafra	Feirense	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219937164	f	\N	\N	\N
9666	Ibrachina FC U20	Sao Paulo U20	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220008560	f	\N	\N	\N
9668	Levante Las Planas (W)	Sevilla FC (W)	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219859198	f	\N	\N	\N
9642	CF Canelas 2010	Chaves	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219937074	f	\N	\N	\N
9645	Pero Pinheiro	Fc Serpa	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219968370	f	\N	\N	\N
9643	O Elvas CAD	FC Tirsense	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219968550	f	\N	\N	\N
9644	Tondela	1 Dezembro	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219968280	f	\N	\N	\N
9658	Cercle Brugge	Gent	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219459153	f	\N	\N	\N
9682	Grasshoppers Zurich	Lugano	2023-10-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219486831	t	0	3	15
9663	UCD	Cork City	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219695504	f	\N	\N	\N
9657	Club Brugge B	Waasland-Beveren	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219785135	f	\N	\N	\N
9675	Catania	Taranto Sport	2023-10-22 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219818797	f	\N	\N	\N
9676	Junkeren	Brann II	2023-10-22 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.220010292	f	\N	\N	\N
9671	Gubbio	Olbia	2023-10-22 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219842177	f	\N	\N	\N
9672	Huesca	Elche	2023-10-22 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219788983	f	\N	\N	\N
9674	Girona	Almeria	2023-10-22 15:15:00	https://www.orbitxch.com/customer/sport/1/market/1.219122558	t	2	\N	3
9654	Viborg	FC Nordsjaelland	2023-10-22 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219458282	t	0	\N	40
9681	CDA Navalcarnero	CD Badajoz	2023-10-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219907832	f	\N	\N	\N
9679	Jamshedpur FC	Punjab FC	2023-10-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220038253	f	\N	\N	\N
9678	Luzern	Yverdon Sport	2023-10-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219569256	f	\N	\N	\N
9683	Rot-Weiss Essen	Saarbrucken	2023-10-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219785270	f	\N	\N	\N
9677	AD Camacha	Famalicao	2023-10-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219968190	f	\N	\N	\N
9680	CD Alesves	CD Subiza	2023-10-22 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220019350	f	\N	\N	\N
9629	Toulouse	Reims	2023-10-22 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219117291	t	0	\N	5
9720	Becerril	CD Palencia	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220020972	f	\N	\N	\N
9713	Stromsgodset	Odds BK	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219210661	t	1	\N	13
9685	CD Cayon	Marino Luanco	2023-10-22 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219896086	f	\N	\N	\N
9686	VMFD Zalgiris	FK Siauliai	2023-10-22 15:55:00	https://www.orbitxch.com/customer/sport/1/market/1.219564101	f	\N	\N	\N
9700	CD Paracuellos Antamira	Real Madrid C	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220021062	f	\N	\N	\N
9687	Union Molinense CF	Lorca Deportiva CF	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220019980	f	\N	\N	\N
9689	Linense	Marbella	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219898830	f	\N	\N	\N
9724	Olot	LHospitalet	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220019440	f	\N	\N	\N
9688	Rapid Vienna	Austria Klagenfurt	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219486288	t	1	5	43
9692	FC Trollhattan	Angelholms	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219865346	f	\N	\N	\N
9706	CD Minera	CD Bullense	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220020070	f	\N	\N	\N
9707	FC Ajka	Kozarmisleny	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219820510	f	\N	\N	\N
9690	AD Almudevar	CD Fuentes	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220019800	f	\N	\N	\N
9712	Szeged 2011	Gyori	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219820690	f	\N	\N	\N
9708	Gimnastic	Sociedad B	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219789568	f	\N	\N	\N
9702	Arenas Club de Getxo	CD Brea	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899553	f	\N	\N	\N
9714	Vasas	Nyiregyhaza	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219820600	f	\N	\N	\N
9734	Malmo FF	Varbergs BoIS	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219484188	t	1	\N	14
9697	Sampdoria (W)	AS Roma (W)	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220052094	f	\N	\N	\N
9705	CF Rayo Majadahonda	Lugo	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219789115	f	\N	\N	\N
9696	Cerdanyola del Valles	La Nucia	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219900097	f	\N	\N	\N
9693	CD Calahorra	Real Sociedad III	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219908138	f	\N	\N	\N
9716	Aalesunds	Sarpsborg	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219210769	t	2	\N	13
9737	Aston Villa	West Ham	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219119295	t	1	\N	2
9721	CD Belchite 97	CD Carinena	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220019710	f	\N	\N	\N
9699	CD Mirandes II	SD Atletico Tordesillas	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220020882	f	\N	\N	\N
9722	CD Quintanar del Rey	CD Torrijos	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220019620	f	\N	\N	\N
9723	CD Tedeon	CD Alfaro	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220019890	f	\N	\N	\N
9717	Coruxo	Real Aviles	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219896406	f	\N	\N	\N
9704	Dinamo Tirana	KS Teuta Durres	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220038772	f	\N	\N	\N
9701	Gzira United FC	Sirens FC	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219905786	f	\N	\N	\N
9710	Guadalajara	Gimnastica Segoviana CF	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219908230	f	\N	\N	\N
9719	RS Gimnastica	SD Compostela	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219896176	f	\N	\N	\N
9698	UP Langreo	Arandina CF	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219895994	f	\N	\N	\N
9703	Pontevedra CF	Real Oviedo II	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219895890	f	\N	\N	\N
9694	CD Binissalem FC	CE Constancia de Inca	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220020160	f	\N	\N	\N
9695	CD Burriana CF	Elche II	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220019530	f	\N	\N	\N
9715	Velez CF	Aguilas	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899101	f	\N	\N	\N
9691	Universitatea Craiova	ACS Petrolul 52	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219173263	f	\N	\N	\N
9711	Rosenborg	Stabaek	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219210012	t	2	\N	13
9732	San Pedro FC	Asi D'Abengourou	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220011552	f	\N	\N	\N
9738	Olivenza	CD Calamonte	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220020250	f	\N	\N	\N
9684	Go Ahead Eagles	Sparta Rotterdam	2023-10-22 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219480878	t	0	0	196
9729	Spartak Trnava	Slovan Bratislava	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219249830	f	\N	\N	\N
9731	Don Benito	UD Fuente de Cantos	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220043175	f	\N	\N	\N
9727	NK Aluminij	NK Radomlje	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219505583	f	\N	\N	\N
9733	Hacken	Norrkoping	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219483828	f	\N	\N	\N
9735	UE Vilassar de Mar	CFJ Mollerussa	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220021152	f	\N	\N	\N
9709	Ham-Kam	Haugesund	2023-10-22 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219210228	t	1	3	13
9730	PAOK	Atromitos	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219002073	f	\N	\N	\N
9726	Monaco	Metz	2023-10-22 16:05:00	https://www.orbitxch.com/customer/sport/1/market/1.219332733	t	2	\N	5
9739	Diosgyori	Ferencvaros	2023-10-22 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219502552	f	\N	\N	\N
9728	FC Heidenheim	Augsburg	2023-10-22 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219114894	t	2	\N	1
9763	Polideportivo Ejido	UD Ciudad de Torredonjimeno	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220020340	f	\N	\N	\N
9769	Canon Sportif De Yaounde	Union Sportive de Doual	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220008340	f	\N	\N	\N
9770	Arda	Ludogorets	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219534952	f	\N	\N	\N
9758	Tudelano	Naxara CD	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219900187	f	\N	\N	\N
9754	Mladost Lucani	Radnicki Nis	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219927177	f	\N	\N	\N
9747	Centro Atletico Fenix	Cerro	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219953054	f	\N	\N	\N
9750	Ismaily	Pharco FC	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219804399	f	\N	\N	\N
9742	Vojvodina	Radnik Surdulica	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219892086	f	\N	\N	\N
9741	Cf Os Belenenses	Gil Vicente	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219968010	f	\N	\N	\N
9767	Al Hidd	Al Hala	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220014132	f	\N	\N	\N
9752	Manama Club	Sitra	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220014222	f	\N	\N	\N
9765	Future FC	Pyramids	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219825858	f	\N	\N	\N
9768	Orihuela CF	FC La Union Atletico	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219898920	f	\N	\N	\N
9760	Gornik Leczna	GKS Katowice	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219416150	f	\N	\N	\N
9762	Tabasalu JK	Viimsi JK	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220014665	f	\N	\N	\N
9744	Hajduk Split	Osijek	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219537353	f	\N	\N	\N
9771	Recreativo Huelva	Alcoyano	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219864804	f	\N	\N	\N
9759	Sestao River	Barcelona B	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219789478	f	\N	\N	\N
9756	FK Jablonec	Bohemians 1905	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219404287	f	\N	\N	\N
9757	Samsunspor	Basaksehir	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219199277	f	\N	\N	\N
9740	Mexico (W)	Jamaica (W)	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220049786	f	\N	\N	\N
9753	Amed Sportif Faaliyetler	Ispartaspor	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219988784	f	\N	\N	\N
9749	UE Sant Andreu	Club Atletico Saguntino	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219899825	f	\N	\N	\N
9755	Barakaldo	SD Gernika Club	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219895676	f	\N	\N	\N
9766	Kolubara Lazarevac	FK Radnicki Sremska	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220014755	f	\N	\N	\N
9748	FK Jezero	FK Buducnost Podgorica	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219984391	f	\N	\N	\N
9751	Club Atletico Bembibre	CD Leonesa B	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220021242	f	\N	\N	\N
9772	Club Atletico Espeleno	Puente Genil FC	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220020431	f	\N	\N	\N
9764	Menemen Belediyespor	Somaspor Spor Kulubu	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219988603	f	\N	\N	\N
9746	Corum Belediyespor	Eyupspor	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219788268	f	\N	\N	\N
9745	Randers	Brondby	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219458390	t	2	\N	40
9761	Atalanta	Genoa	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219332889	f	\N	\N	\N
9743	Fenerbahce	Hatayspor	2023-10-22 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219212705	f	\N	\N	\N
9776	ASD Pineto Calcio	Cesena	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219841803	f	\N	\N	\N
10156	Linfield U20	Carrick Rangers U20	2023-10-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.220104279	f	\N	\N	\N
9774	Albacete	Sporting Gijon	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219788587	f	\N	\N	\N
9775	Reggiana	Venezia	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219482471	f	\N	\N	\N
9785	Real Madrid FC (W)	Levante UD (W)	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219859298	f	\N	\N	\N
9778	CA Pulpileno	CD Cieza	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220020521	f	\N	\N	\N
9773	Olympiakos	Panathinaikos	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219001683	f	\N	\N	\N
9777	Racing Santander	Burgos	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219788479	f	\N	\N	\N
9779	Pesaro	Recanatese	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219842267	f	\N	\N	\N
9782	Avellino	Nuova Monterosi	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219818535	f	\N	\N	\N
9784	Lucchese	Pescara	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219841895	f	\N	\N	\N
9781	Rimini	Ancona	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219842357	f	\N	\N	\N
9783	Villarreal	Alaves	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219156667	f	\N	\N	\N
10157	Cliftonville FC U20	Glenavon FC U20	2023-10-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.220104369	f	\N	\N	\N
10158	Ballymena United FC U20	Crusaders FC U20	2023-10-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.220104459	f	\N	\N	\N
9780	Standard	Anderlecht	2023-10-22 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219457778	t	2	\N	68
10159	Chelmsford	Dover	2023-10-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.220040175	f	\N	\N	\N
10160	Arezzo	Spal	2023-10-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219842537	f	\N	\N	\N
10161	Laval	St Etienne	2023-10-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219511176	f	\N	\N	\N
10105	Real Espana	Genesis Huracan	2023-10-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220105942	f	\N	\N	\N
10162	Hashtag United	Chatham Town	2023-10-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.220099315	f	\N	\N	\N
10163	Carshalton Athletic FC	Lewes	2023-10-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.220099225	f	\N	\N	\N
10164	Fiorentina	Empoli	2023-10-23 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219118253	f	\N	\N	\N
10165	Larne FC U20	Dungannon U20	2023-10-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220104189	f	\N	\N	\N
10166	Alcorcon	FC Cartagena	2023-10-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219789829	f	\N	\N	\N
10167	Valencia	Cadiz	2023-10-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219118973	f	\N	\N	\N
10168	Tottenham	Fulham	2023-10-23 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219149375	f	\N	\N	\N
10169	Torque	Liverpool Montevideo	2023-10-23 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219960037	f	\N	\N	\N
10170	Atletico FC Cali	Cucuta Deportivo	2023-10-23 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219928130	f	\N	\N	\N
10171	Club General Caballero JLM	Libertad	2023-10-23 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220104677	f	\N	\N	\N
10172	Molynes United FC	Vere United FC	2023-10-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220081673	f	\N	\N	\N
10173	Estudiantes	Sarmiento de Junin	2023-10-23 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219523569	f	\N	\N	\N
10174	Llaneros FC	Barranquilla	2023-10-23 23:45:00	https://www.orbitxch.com/customer/sport/1/market/1.219928220	f	\N	\N	\N
10099	Ponte Preta	Ituano	2023-10-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219537318	f	\N	\N	\N
10098	AA Portuguesa U20	Palmeiras U20	2023-10-24 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220088684	f	\N	\N	\N
10102	Univ Catolica (Ecu)	Delfin	2023-10-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219649221	f	\N	\N	\N
10103	Velez Sarsfield	Banfield	2023-10-24 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219523479	f	\N	\N	\N
10181	Arnett Gardens FC	Dunbeholden FC	2023-10-24 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.220139593	f	\N	\N	\N
10104	America de Cali S.A	Atletico Huila	2023-10-24 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219833121	f	\N	\N	\N
10184	Racing FC Porto Palmeiras	Club Sporting Canamy	2023-10-24 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.220139704	f	\N	\N	\N
\.


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 222
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 275, true);


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 223
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 1661, true);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 224
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 1668, true);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 225
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 10184, true);


--
-- TOC entry 3266 (class 2606 OID 16592)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 3260 (class 2606 OID 16594)
-- Name: over2p5footballsupertips over2p5footballsupertips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips
    ADD CONSTRAINT over2p5footballsupertips_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 3262 (class 2606 OID 16596)
-- Name: over2p5goalsnow over2p5goalsnow_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow
    ADD CONSTRAINT over2p5goalsnow_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 3264 (class 2606 OID 16598)
-- Name: over2p5orbitxch over2p5orbitxch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch
    ADD CONSTRAINT over2p5orbitxch_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE over2p5footballsupertips; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5footballsupertips FROM postgres;
GRANT ALL ON TABLE public.over2p5footballsupertips TO postgres WITH GRANT OPTION;


--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE footballsupertips_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.footballsupertips_today FROM postgres;
GRANT ALL ON TABLE public.footballsupertips_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE over2p5goalsnow; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5goalsnow FROM postgres;
GRANT ALL ON TABLE public.over2p5goalsnow TO postgres WITH GRANT OPTION;


--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE goalsnow_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.goalsnow_today FROM postgres;
GRANT ALL ON TABLE public.goalsnow_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE over2p5orbitxch; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5orbitxch FROM postgres;
GRANT ALL ON TABLE public.over2p5orbitxch TO postgres WITH GRANT OPTION;


--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE orbitxch_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.orbitxch_today FROM postgres;
GRANT ALL ON TABLE public.orbitxch_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE "TodayMatches"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodayMatches" FROM postgres;
GRANT ALL ON TABLE public."TodayMatches" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodaysBets" FROM postgres;
GRANT ALL ON TABLE public."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE "YesterdaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."YesterdaysBets" FROM postgres;
GRANT ALL ON TABLE public."YesterdaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE "YesterdaysMatches"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."YesterdaysMatches" FROM postgres;
GRANT ALL ON TABLE public."YesterdaysMatches" TO postgres WITH GRANT OPTION;


--
-- TOC entry 2088 (class 826 OID 16599)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


-- Completed on 2023-10-24 09:41:52 BST

--
-- PostgreSQL database dump complete
--

