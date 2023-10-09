--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-0+deb12u1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-0+deb12u1)

-- Started on 2023-10-09 15:18:22 BST

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
-- TOC entry 228 (class 1259 OID 16619)
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
    "Goals" numeric(3,2) NOT NULL,
    "Odds" numeric(3,2) NOT NULL,
    "OddsRecorded" numeric(3,2),
    "Amount" numeric,
    "BetResult" public."BetResult",
    "BetResultTime" timestamp without time zone
);


--
-- TOC entry 226 (class 1259 OID 16600)
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
-- TOC entry 227 (class 1259 OID 16604)
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
-- TOC entry 229 (class 1259 OID 16624)
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
190	2023-10-08 16:30:00	Arsenal	Man City	2023-10-08 17:36:25	Back	Under	1.50	1.13	1.15	6	Won	2023-10-08 18:00:47.647932
191	2023-10-08 17:00:00	Midtjylland	Randers	2023-10-08 18:05:46	Lay	Under	2.50	1.50	1.77	6	Won	2023-10-08 18:15:08.784393
192	2023-10-08 18:00:00	Porto	Portimonense	2023-10-08 19:08:56	Lay	Under	2.50	1.50	2.20	6	Lost	2023-10-08 19:30:29.480452
195	2023-10-08 18:00:00	Porto	Portimonense	2023-10-08 19:08:56	Back	Under	2.50	1.13	1.14	6	Won	2023-10-08 19:44:47.941462
193	2023-10-08 18:15:00	Lierse	Deinze	2023-10-08 19:19:24	Lay	Under	2.50	1.50	2.18	6	Lost	2023-10-08 19:36:31.526156
196	2023-10-08 18:15:00	Lierse	Deinze	2023-10-08 19:19:24	Back	Under	2.50	1.13	1.14	6	Won	2023-10-08 19:52:54.520651
194	2023-10-08 18:30:00	Eintracht Frankfurt	FC Heidenheim	2023-10-08 19:35:28	Lay	Under	2.50	1.50	1.94	6	Lost	2023-10-08 19:46:46.918727
197	2023-10-08 18:30:00	Eintracht Frankfurt	FC Heidenheim	2023-10-08 19:35:28	Back	Under	2.50	1.50	1.50	6	Won	2023-10-08 20:13:27.576243
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
1120	FC Helsingor	Vendsyssel FF	2023-10-09 18:00:00	\N	147
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
5765	FC Helsingor	Vendsyssel FF	2023-10-09 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219182888	f	\N	\N	\N
5762	Elche	Andorra CF	2023-10-09 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219251838	f	\N	\N	\N
5768	Sint Truidense (Res)	K Lierse U21	2023-10-09 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219426397	f	\N	\N	\N
5767	KV Oostende (Res)	Kortrijk (Res)	2023-10-09 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219426307	f	\N	\N	\N
5770	Deportes Concepcion	Deportes Rengo Unido	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219454861	f	\N	\N	\N
5769	Westerlo (Res)	FCV Dender EH U21	2023-10-09 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219449549	f	\N	\N	\N
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
5872	Toluca (W)	Guadalajara (W)	2023-10-10 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219492991	f	\N	\N	\N
5801	Sport Recife	Ponte Preta	2023-10-10 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219075969	f	\N	\N	\N
5802	Velez Sarsfield	Atl Tucuman	2023-10-10 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218834419	f	\N	\N	\N
5803	Libertad FC	Guayaquil City	2023-10-10 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219192482	f	\N	\N	\N
5804	Blooming Santa Cruz	Royal Pari	2023-10-10 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.219342584	f	\N	\N	\N
5805	Pumas UNAM (W)	Club Necaxa (W)	2023-10-10 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451640	f	\N	\N	\N
5806	Escorpiones FC	Halcones de Zapopan	2023-10-10 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451730	f	\N	\N	\N
5807	Monterrey (W)	Queretaro (W)	2023-10-10 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219451822	f	\N	\N	\N
\.


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 222
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 197, true);


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 223
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 1121, true);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 224
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 1157, true);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 225
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 5879, true);


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
-- Dependencies: 228
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
-- Dependencies: 226
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodaysBets" FROM postgres;
GRANT ALL ON TABLE public."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE "YesterdaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."YesterdaysBets" FROM postgres;
GRANT ALL ON TABLE public."YesterdaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 229
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


-- Completed on 2023-10-09 15:18:22 BST

--
-- PostgreSQL database dump complete
--

