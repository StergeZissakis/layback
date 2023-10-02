--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-0+deb12u1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-0+deb12u1)

-- Started on 2023-10-02 09:54:17 BST

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
71	2023-10-01 18:15:00	Bodo Glimt	Stromsgodset	2023-10-01 19:35:05	Lay	Under	2.50	1.50	\N	6	Lost	2023-10-01 20:00:11.369903
72	2023-10-01 18:15:00	Bodo Glimt	Stromsgodset	2023-10-01 19:35:05	Back	Under	2.50	1.50	1.47	6	Won	2023-10-01 20:00:14.980717
73	2023-10-02 01:00:00	Los Angeles FC	Real Salt Lake	2023-10-02 02:30:30	Lay	Under	1.50	1.50	2.14	6	Lost	2023-10-02 02:47:44.164695
74	2023-10-02 01:00:00	Los Angeles FC	Real Salt Lake	2023-10-02 02:30:30	Back	Under	1.50	1.50	1.50	6	Won	2023-10-02 03:12:12.373131
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
33	AC Milan	Lazio	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218580648	t	0	2	4
27	Servette	Lausanne	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218798925	t	1	\N	15
49	Girona	Real Madrid	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218580528	t	\N	\N	\N
51	RB Leipzig	Bayern Munich	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218409706	t	\N	\N	\N
20	Winterthur	Lugano	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218798817	t	1	\N	15
57	Hapoel Haifa	Maccabi Bnei Raina	2023-09-30 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218723273	f	\N	\N	\N
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
994	Sassuolo	AC Monza	2023-10-02 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218667589	f	\N	\N	\N
995	Torino	Verona	2023-10-02 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218667469	f	\N	\N	\N
996	Belouizdad	Bo Rangers	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219090428	f	\N	\N	\N
997	Gornik Zabrze	Zaglebie Lubin	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218594278	f	\N	\N	\N
998	AL Nahdha	Jabal Al Mukaber	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219106390	f	\N	\N	\N
999	Växjö DFF (W)	Rosengard (W)	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219080993	f	\N	\N	\N
1000	FC Trollhattan	Norrby IF	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218851084	f	\N	\N	\N
1001	Goztepe	Adanaspor	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218764261	f	\N	\N	\N
1002	OB	Lyngby	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705904	f	\N	\N	\N
1003	Vozdovac	Fk Novi Pazar	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219012284	f	\N	\N	\N
1004	IK Brage	Skovde AIK	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218906114	f	\N	\N	\N
1005	Penafiel	CD Nacional Funchal	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218835625	f	\N	\N	\N
1006	Lokomotiv Plovdiv	CSKA Sofia	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218767980	f	\N	\N	\N
1007	Utsiktens	AFC Eskilstuna	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218905934	f	\N	\N	\N
1008	IFK Norrkoping DFK (W)	BK Hacken (W)	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219081083	f	\N	\N	\N
1009	Kolubara Lazarevac	OFK Beograd	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219081779	f	\N	\N	\N
1010	Jonkopings Sodra	Ostersunds FK	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218906024	f	\N	\N	\N
1011	Elfsborg	Varbergs BoIS	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218573053	f	\N	\N	\N
1012	OFI	AEK Athens	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218766900	f	\N	\N	\N
1013	Kayserispor	Basaksehir	2023-10-02 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218560240	f	\N	\N	\N
1014	Malmo FF	Brommapojkarna	2023-10-02 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218573161	f	\N	\N	\N
1015	Beitar Jerusalem	Hapoel Tel Aviv	2023-10-02 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218881394	f	\N	\N	\N
1016	Wolves U21	Leeds United U21	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219105355	f	\N	\N	\N
1017	Pecs MFC	Nyiregyhaza	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219084243	f	\N	\N	\N
1018	FCSB	Universitatea Cluj	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218903495	f	\N	\N	\N
1019	Brown de Adrogue	Chacarita	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218870886	f	\N	\N	\N
1020	K Lierse U21	RFC de Liege U21	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219105193	f	\N	\N	\N
1021	Al Nassr	Istiqlol	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219099576	f	\N	\N	\N
1022	Al Riffa	Al Zawraa	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219091526	f	\N	\N	\N
1023	Jong FC Utrecht	NAC Breda	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218828795	f	\N	\N	\N
1024	Uni San Martin	Deportivo Llacuabamba	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219105103	f	\N	\N	\N
1025	CA Ituzaingo	CS Dock Sud	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219084136	f	\N	\N	\N
1026	Al-Duhail SC	Persepolis	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219091436	f	\N	\N	\N
1027	MVV Maastricht	FC Eindhoven	2023-10-02 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218808014	f	\N	\N	\N
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
\.


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 222
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 74, true);


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 223
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 276, true);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 224
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 276, true);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 225
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 1068, true);


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


-- Completed on 2023-10-02 09:54:17 BST

--
-- PostgreSQL database dump complete
--

