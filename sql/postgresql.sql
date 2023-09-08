--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-08 12:39:57 BST

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
-- TOC entry 3083 (class 1262 OID 13465)
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
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 3083
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3085 (class 0 OID 0)
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
-- TOC entry 2562 (class 3456 OID 17065)
-- Name: match_team_names_collation; Type: COLLATION; Schema: public; Owner: -
--

CREATE COLLATION public.match_team_names_collation (provider = icu, deterministic = false, locale = 'und');


--
-- TOC entry 1 (class 3079 OID 16584)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 560 (class 1247 OID 16385)
-- Name: ActionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ActionType" AS ENUM (
    'Lay',
    'Back'
);


--
-- TOC entry 563 (class 1247 OID 16390)
-- Name: BetResult; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BetResult" AS ENUM (
    'Won',
    'Lost'
);


--
-- TOC entry 651 (class 1247 OID 16404)
-- Name: OverUnderType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OverUnderType" AS ENUM (
    'Over',
    'Under'
);


--
-- TOC entry 222 (class 1255 OID 16409)
-- Name: ArchiveDailyOver2p5(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public."ArchiveDailyOver2p5"() RETURNS void
    LANGUAGE sql
    AS $$
INSERT INTO public."daily_over_2p5_historical" 
SELECT *
FROM public."daily_over_2p5";

DELETE FROM public."daily_over_2p5";

$$;


--
-- TOC entry 223 (class 1255 OID 16410)
-- Name: ArchivePastMatches(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public."ArchivePastMatches"() RETURNS void
    LANGUAGE sql
    AS $$
INSERT INTO public."OverUnderHistorical"("Home_Team", "Guest_Team", "Date_Time", "Type", "Half", "Goals", "Odds_bet", "Margin", "Payout", "Bet_link")
SELECT SPLIT_PART(Event, ' - ', 1), SPLIT_PART(Event, ' - ', 2), DateTime, Type, Half, Goals, SafariOdds, Margin, SafariPayout, bookie 
FROM   public."PortalSafariBets"
WHERE  DateTime + interval '5 hours' < now();

DELETE FROM public."OddsPortalMatch" where date_time + interval '5 hours' < now();
DELETE FROM public."OddsSafariMatch" where date_time + interval '5 hours' < now();$$;


--
-- TOC entry 224 (class 1255 OID 16411)
-- Name: CalculateOverUnderResults(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public."CalculateOverUnderResults"() RETURNS void
    LANGUAGE sql
    AS $$UPDATE	public."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals" + t."Guest_Team_Goals") > (t."Home_Team_Goals" + t."Guest_Team_Goals") AND  t."Type" = 'Over' AND t."Half" = 'Full Time';

UPDATE	public."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals" + t."Guest_Team_Goals") < (t."Home_Team_Goals" + t."Guest_Team_Goals") AND  t."Type" = 'Under' AND t."Half" = 'Full Time';

UPDATE	public."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals_1st_Half" + t."Guest_Team_Goals_1st_Half") > t."Goals" AND  t."Type" = 'Over' AND t."Half" = '1st Half';

UPDATE	public."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals_1st_Half" + t."Guest_Team_Goals_1st_Half") < t."Goals" AND  t."Type" = 'Over' AND t."Half" = '1st Half';

UPDATE	public."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals_2nd_Half" + t."Guest_Team_Goals_2nd_Half") > t."Goals" AND  t."Type" = 'Over' AND t."Half" = '2nd Half';

UPDATE	public."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals_2nd_Half" + t."Guest_Team_Goals_2nd_Half") < t."Goals" AND  t."Type" = 'Over' AND t."Half" = '2nd Half';

$$;


--
-- TOC entry 225 (class 1255 OID 16412)
-- Name: update_updated_on_Match(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public."update_updated_on_Match"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated = now();
    RETURN NEW;
END;
$$;


--
-- TOC entry 226 (class 1255 OID 16413)
-- Name: update_updated_on_OverUnder(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public."update_updated_on_OverUnder"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated = now();
    RETURN NEW;
END;
$$;


--
-- TOC entry 204 (class 1259 OID 16452)
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."OverUnderHistorical_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 203 (class 1259 OID 16424)
-- Name: OverUnder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."OverUnder_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 17015)
-- Name: over2p5footballsupertips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5footballsupertips (
    id bigint NOT NULL,
    home character varying NOT NULL COLLATE pg_catalog."en_US",
    away character varying NOT NULL COLLATE pg_catalog."en_US",
    date_time timestamp without time zone NOT NULL,
    url character varying
);


--
-- TOC entry 219 (class 1259 OID 17082)
-- Name: footballsupertips_today; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.footballsupertips_today AS
 SELECT over2p5footballsupertips.id,
    over2p5footballsupertips.home,
    over2p5footballsupertips.away,
    over2p5footballsupertips.date_time,
    over2p5footballsupertips.url
   FROM public.over2p5footballsupertips
  WHERE (over2p5footballsupertips.date_time >= CURRENT_DATE)
  ORDER BY over2p5footballsupertips.date_time, over2p5footballsupertips.id;


--
-- TOC entry 213 (class 1259 OID 17004)
-- Name: over2p5goalsnow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5goalsnow (
    id bigint NOT NULL,
    home character varying NOT NULL COLLATE pg_catalog."en_US",
    away character varying NOT NULL COLLATE pg_catalog."en_US",
    date_time timestamp without time zone NOT NULL,
    url character varying
);


--
-- TOC entry 218 (class 1259 OID 17078)
-- Name: goalsnow_today; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.goalsnow_today AS
 SELECT over2p5goalsnow.id,
    over2p5goalsnow.home,
    over2p5goalsnow.away,
    over2p5goalsnow.date_time,
    over2p5goalsnow.url
   FROM public.over2p5goalsnow
  WHERE (over2p5goalsnow.date_time >= CURRENT_DATE)
  ORDER BY over2p5goalsnow.date_time, over2p5goalsnow.id;


--
-- TOC entry 217 (class 1259 OID 17026)
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
-- TOC entry 220 (class 1259 OID 17086)
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
  WHERE (over2p5orbitxch.date_time >= CURRENT_DATE)
  ORDER BY over2p5orbitxch.date_time, over2p5orbitxch.id;


--
-- TOC entry 221 (class 1259 OID 17090)
-- Name: TodayMatches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."TodayMatches" AS
 SELECT c.id,
    c.home,
    c.away,
    c.date_time,
    c.url,
    c.plaied
   FROM ((public.goalsnow_today a
     JOIN public.footballsupertips_today b ON ((((a.date_time = b.date_time) AND (lower((a.home)::text) ~~ lower((b.home)::text))) OR (lower((a.away)::text) ~~ lower((b.away)::text)))))
     JOIN public.orbitxch_today c ON ((((b.date_time = c.date_time) AND (lower((b.home)::text) ~~ lower((c.home)::text))) OR (lower((b.away)::text) ~~ lower((c.away)::text)))))
  ORDER BY c.date_time, c.id, c.url;


--
-- TOC entry 207 (class 1259 OID 16493)
-- Name: over2p5bets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.over2p5bets (
    id bigint NOT NULL,
    "MatchDateTime" timestamp without time zone,
    "Home" character varying NOT NULL,
    "Away" character varying NOT NULL,
    "BetDateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "LayBack" public."ActionType" NOT NULL,
    "OverUnder" public."OverUnderType" NOT NULL,
    "Goals" numeric(3,2) NOT NULL,
    "Odds" numeric(3,2) NOT NULL,
    "OddsRecorded" numeric(3,2) NOT NULL,
    "Amount" numeric NOT NULL,
    "BetResult" public."BetResult"
);


--
-- TOC entry 209 (class 1259 OID 16593)
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
    a."BetResult"
   FROM public.over2p5bets a
  WHERE (a."BetDateTime" >= CURRENT_DATE)
  ORDER BY a."BetDateTime", a.id;


--
-- TOC entry 205 (class 1259 OID 16471)
-- Name: daily_over_2p5; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_over_2p5 (
    id bigint NOT NULL,
    home character varying NOT NULL,
    away character varying NOT NULL,
    date_time timestamp without time zone NOT NULL,
    url character varying
);


--
-- TOC entry 206 (class 1259 OID 16483)
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_over_2p5_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3097 (class 0 OID 0)
-- Dependencies: 206
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_over_2p5_id_seq OWNED BY public.daily_over_2p5.id;


--
-- TOC entry 211 (class 1259 OID 16985)
-- Name: match_table_prototype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.match_table_prototype (
    id bigint NOT NULL,
    home character varying NOT NULL,
    away character varying NOT NULL,
    date_time timestamp without time zone NOT NULL,
    url character varying
);


--
-- TOC entry 210 (class 1259 OID 16983)
-- Name: match_table_prototype_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.match_table_prototype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 210
-- Name: match_table_prototype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.match_table_prototype_id_seq OWNED BY public.match_table_prototype.id;


--
-- TOC entry 208 (class 1259 OID 16500)
-- Name: over2p5bets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5bets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 208
-- Name: over2p5bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5bets_id_seq OWNED BY public.over2p5bets.id;


--
-- TOC entry 214 (class 1259 OID 17013)
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5footballsupertips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 214
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5footballsupertips_id_seq OWNED BY public.over2p5footballsupertips.id;


--
-- TOC entry 212 (class 1259 OID 17002)
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5goalsnow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3102 (class 0 OID 0)
-- Dependencies: 212
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5goalsnow_id_seq OWNED BY public.over2p5goalsnow.id;


--
-- TOC entry 216 (class 1259 OID 17024)
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5orbitxch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3103 (class 0 OID 0)
-- Dependencies: 216
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5orbitxch_id_seq OWNED BY public.over2p5orbitxch.id;


--
-- TOC entry 2911 (class 2604 OID 16904)
-- Name: daily_over_2p5 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5 ALTER COLUMN id SET DEFAULT nextval('public.daily_over_2p5_id_seq'::regclass);


--
-- TOC entry 2914 (class 2604 OID 16988)
-- Name: match_table_prototype id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.match_table_prototype ALTER COLUMN id SET DEFAULT nextval('public.match_table_prototype_id_seq'::regclass);


--
-- TOC entry 2913 (class 2604 OID 16906)
-- Name: over2p5bets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets ALTER COLUMN id SET DEFAULT nextval('public.over2p5bets_id_seq'::regclass);


--
-- TOC entry 2916 (class 2604 OID 17018)
-- Name: over2p5footballsupertips id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips ALTER COLUMN id SET DEFAULT nextval('public.over2p5footballsupertips_id_seq'::regclass);


--
-- TOC entry 2915 (class 2604 OID 17007)
-- Name: over2p5goalsnow id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow ALTER COLUMN id SET DEFAULT nextval('public.over2p5goalsnow_id_seq'::regclass);


--
-- TOC entry 2918 (class 2604 OID 17029)
-- Name: over2p5orbitxch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch ALTER COLUMN id SET DEFAULT nextval('public.over2p5orbitxch_id_seq'::regclass);


--
-- TOC entry 3066 (class 0 OID 16471)
-- Dependencies: 205
-- Data for Name: daily_over_2p5; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.daily_over_2p5 (id, home, away, date_time, url) FROM stdin;
\.


--
-- TOC entry 3071 (class 0 OID 16985)
-- Dependencies: 211
-- Data for Name: match_table_prototype; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.match_table_prototype (id, home, away, date_time, url) FROM stdin;
\.


--
-- TOC entry 3068 (class 0 OID 16493)
-- Dependencies: 207
-- Data for Name: over2p5bets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") FROM stdin;
18	2023-09-06 19:00:00	SonderjyskE	Vejle	2023-09-06 20:15:04.824315	Lay	Under	2.50	1.50	1.64	1	\N
19	2023-09-06 19:00:00	SonderjyskE	Vejle	2023-09-06 20:38:40.392177	Back	Under	2.50	1.00	1.12	1	\N
\.


--
-- TOC entry 3075 (class 0 OID 17015)
-- Dependencies: 215
-- Data for Name: over2p5footballsupertips; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5footballsupertips (id, home, away, date_time, url) FROM stdin;
2	Sonderjyske	Vejle	2023-09-06 19:00:00	\N
16	Ringsted IF	HB Køge	2023-09-07 16:00:00	\N
18	Poland	Faroe Islands	2023-09-07 19:45:00	\N
19	Denmark	San Marino	2023-09-07 19:45:00	\N
20	Croatia	Latvia	2023-09-08 19:45:00	\N
21	Turkey	Armenia	2023-09-08 19:45:00	\N
22	Bosnia-Herzegovina	Liechtenstein	2023-09-08 19:45:00	\N
23	Willem II	Maastricht	2023-09-08 20:00:00	\N
\.


--
-- TOC entry 3073 (class 0 OID 17004)
-- Dependencies: 213
-- Data for Name: over2p5goalsnow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5goalsnow (id, home, away, date_time, url) FROM stdin;
1	Dalum	FC Fredericia	2023-09-06 16:00:00	\N
2	Fjordager IF	Hvidovre IF	2023-09-06 16:00:00	\N
3	IF Lyseng	Middelfart	2023-09-06 16:00:00	\N
4	Viby	VSK Aarhus	2023-09-06 16:00:00	\N
5	Hillerød	Lyngby	2023-09-06 17:00:00	\N
6	Skjold	FC Helsingor	2023-09-06 17:00:00	\N
7	AB Tårnby	Nykobing	2023-09-06 18:00:00	\N
8	Sonderjyske	Vejle	2023-09-06 19:00:00	\N
76	Ringsted IF	HB Køge	2023-09-07 16:00:00	\N
78	France	Rep of Ireland	2023-09-07 19:45:00	\N
79	Netherlands	Greece	2023-09-07 19:45:00	\N
80	Cyprus	Scotland	2023-09-08 19:45:00	\N
81	Turkey	Armenia	2023-09-08 19:45:00	\N
82	Willem II	Maastricht	2023-09-08 20:00:00	\N
\.


--
-- TOC entry 3077 (class 0 OID 17026)
-- Dependencies: 217
-- Data for Name: over2p5orbitxch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5orbitxch (id, home, away, date_time, url, plaied) FROM stdin;
241	TJ Sokol Zubrohlava	Ruzomberok	2023-09-06 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217954543	f
242	Unicov	MFK Karvina	2023-09-06 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217949649	f
243	SK Kladno	Varnsdorf	2023-09-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217949829	f
244	Arsenal Ceska Lipa	MFK Chrudim	2023-09-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217949739	f
245	Hlinsko	Lisen	2023-09-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217954074	f
246	FK Spartak Sobeslav	Hradec Kralove	2023-09-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217949559	f
247	TJ Sokol Zapy	MAS Taborsko	2023-09-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217949469	f
248	Arsenal (W)	Linkopings FC (W)	2023-09-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217962616	f
249	Gintra (W)	Cardiff City FC (W)	2023-09-06 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217969729	f
252	VfB Oldenburg	SV Meppen	2023-09-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217953534	f
253	IF Magni	KFS	2023-09-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217963294	f
254	Hillerod Fodbold	Lyngby	2023-09-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217968802	f
251	Georgia U21	Gibraltar U21	2023-09-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217825677	f
255	Saudi Arabia U23	Mongolia U23	2023-09-06 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217962104	f
256	Eintracht Frankfurt (W)	1 FC Slovacko (W)	2023-09-06 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217962796	f
258	Koge (W)	KuPs (W)	2023-09-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217962706	f
257	Simmeringer	SV Donau	2023-09-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217978750	f
263	Twente (W)	Sturm Graz (W)	2023-09-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217962886	f
262	SV Fortuna Magdeburg	FSV Saxonia Tangermunde	2023-09-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217978569	f
261	FC Luzern U19	FC Aarau U19	2023-09-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217979074	f
260	Dynamo Schwerin	Optik Rathenow	2023-09-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217953134	f
264	Hapoel Jerusalem (W)	Maccabi Kishronot Hadera (W	2023-09-06 18:20:00	https://www.orbitxch.com/customer/sport/1/market/1.217979167	f
269	Norderstedt	Teutonia 05 Ottensen	2023-09-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217953624	f
265	SV Auersmacher	SV Morlautern	2023-09-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217968180	f
267	Arminia Ludwigshafen	TSG Pfeddersheim	2023-09-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217953444	f
270	SV Gonsenheim	FC Bitburg	2023-09-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217953044	f
271	Karlbergs BK	Viggbyholms IK FF	2023-09-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217954723	f
268	Wormatia Worms	FC Cosmos Koblenz	2023-09-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217952954	f
266	FC Kaiserslautern II	Spvgg Quierschied	2023-09-06 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217953224	f
276	Jordan U23	Brunei Darussalam U23	2023-09-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217977688	f
272	Anderlecht (W)	GKS Katowice (W)	2023-09-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217962976	f
274	FC Arlanda	Kvarnsvedens IK	2023-09-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217968622	f
277	FC Minsk (W)	Valerenga (W)	2023-09-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217971442	f
273	Malta	Gibraltar	2023-09-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217893076	f
278	Linfield (W)	Larne (W)	2023-09-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217960981	f
281	Havant and W	Eastbourne	2023-09-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217886552	f
280	Derry City (W)	Mid Ulster (W)	2023-09-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217961071	f
279	UCD	Derry City	2023-09-06 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217765113	f
284	Limon Black Star	Futbol Consultants Moravia	2023-09-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217968360	f
286	Real Soacha Cundinamarca FC	Leones FC	2023-09-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217932812	f
285	Tigres FC Zipaquira	Bogota	2023-09-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217913754	f
283	Municipal Santa Ana	Escorpiones FC	2023-09-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217968270	f
287	PFA Antioquia FC	Puerto Golfito F.C	2023-09-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217977888	f
282	Libya	Equatorial Guinea	2023-09-06 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217954813	f
288	Quepos Cambute	ADR Jicaral	2023-09-06 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217968450	f
289	Molinos El Pirata	Deportivo Llacuabamba	2023-09-06 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217964246	f
290	Club Nueve de Octubre	Chacaritas SC	2023-09-06 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940646	f
292	Fraijanes FC	CD Heredia	2023-09-06 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217983235	f
291	Orsomarso	Quindio	2023-09-06 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217913664	f
293	Envigado	America de Cali S.A	2023-09-06 22:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217935775	f
294	CD Luis Angel Firpo	Santa Tecla	2023-09-06 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217958612	f
296	Jocoro	Once Municipal	2023-09-06 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217958522	f
297	Cuniburo FC	Manta FC	2023-09-06 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217942062	f
295	CD Aguila	Fuerte San Francisco	2023-09-06 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217958432	f
298	America MG U20	Cruzeiro U20	2023-09-06 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217983055	f
275	SonderjyskE	Vejle	2023-09-06 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217968712	t
299	Laos U23	Australia U23	2023-09-06 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218004948	f
250	Bahrain U23	Palestine U23	2023-09-06 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217874828	f
259	Eintracht Trier	Rot-Weiss Koblenz	2023-09-06 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217953314	f
349	Electric Veng FC	Project Veng FC	2023-09-07 06:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217981561	f
352	FC Magdeburg	Erzgebirge	2023-09-07 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217991027	f
353	FC Spaeri	Torpedo Kutaisi	2023-09-07 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218020577	f
355	Nurnberg	FC Heidenheim	2023-09-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217979760	f
356	Bochum	Sint Truiden	2023-09-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217990937	f
357	Northern Ireland U21	Luxembourg U21	2023-09-07 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217825497	f
359	Belarus U21	Faroe Islands U21	2023-09-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217852237	f
358	Hoffenheim	Luzern	2023-09-07 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217990847	f
360	Flamengo U20	Palmeiras U20	2023-09-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217995490	f
361	Kazakhstan	Finland	2023-09-07 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.216913793	f
362	Estonia U21	Bulgaria U21	2023-09-07 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217825587	f
363	Romania U20	Czech Republic U20	2023-09-07 15:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218003019	f
365	FIRST VIENNA FC 1894	SV Horn	2023-09-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218002929	f
364	Dynamo Dresden	SC Freital	2023-09-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217996634	f
366	Germany U20	Italy U20	2023-09-07 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218006986	f
367	Qatar	Kenya	2023-09-07 16:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217996448	f
368	Hapoel Mahane Yehuda	Beitar Ramat Gan	2023-09-07 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217991677	f
369	Hungary U21	Kazakhstan U21	2023-09-07 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217835430	f
370	Czech Republic U21	Slovakia U21	2023-09-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217958189	f
378	Staal Jorpeland	Vidar	2023-09-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217995796	f
373	Angola	Madagascar	2023-09-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217982017	f
371	San Marino U21	Norway U21	2023-09-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217892878	f
380	France U21	Denmark U21	2023-09-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217941008	f
374	MS Hapoel Lod	Hapoel Kfar Shelem	2023-09-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217985334	f
375	Ghana	Central African Republic	2023-09-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217981927	f
377	Aalesund II	Brattvag	2023-09-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217983415	f
376	Bulgaria	Iran	2023-09-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217893166	f
372	Lithuania	Montenegro	2023-09-07 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.216912565	f
383	Hapoel Umm AL Fahm	Hapoel Akko	2023-09-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217982557	f
385	Maccabi Herzliya	Sektzia Nes Tziona	2023-09-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217982197	f
382	MS Kfar Kasem	Hapoel Rishon Lezion	2023-09-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217982467	f
386	Bosnia U21	Slovenia U21	2023-09-07 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217825407	f
384	Hapoel K Saba	Hapoel Afula	2023-09-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217982377	f
379	Ramat HaSharon (W)	Hapoel Ironi PT (W)	2023-09-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217991926	f
387	Cyprus U21	Austria U21	2023-09-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217825317	f
389	Hamar Hveragerdi	Vaengir Jupiters	2023-09-07 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217985152	f
388	Norway	Jordan	2023-09-07 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217893256	f
390	Hapoel Bikat Hayarden	Shimshon Tel Aviv	2023-09-07 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217982647	f
394	Kongsvinger U19	KFUM U19	2023-09-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217984818	f
391	Agudat Sport Ashdod	Maccabi Yavne	2023-09-07 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217982737	f
392	Arborg	UMF Alftanes	2023-09-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001056	f
393	KA Asvellir	UMF Tindstoll	2023-09-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217985242	f
397	SER Caxias do Sul	Ferroviario	2023-09-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217975713	f
399	Baerum SK U19	Nordstrand U19	2023-09-07 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217984704	f
396	Alianza Universidad	Santa Rosa FC	2023-09-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217997290	f
395	Borussia Freialdenhoven	SPVG Porz	2023-09-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217982965	f
398	Bahia EC U20	Pague Menos FC U20	2023-09-07 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217995400	f
401	Alcorcon	Rayo Vallecano	2023-09-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217979505	f
400	Austria	Moldova	2023-09-07 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217890299	f
403	France	Republic of Ireland	2023-09-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216913214	f
402	Wales	South Korea	2023-09-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217890209	f
351	Leverkusen	Alemannia Aachen	2023-09-07 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217996544	f
404	Denmark	San Marino	2023-09-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217590423	f
413	Niger	Uganda	2023-09-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217981837	f
411	Algeria	Tanzania	2023-09-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217982107	f
415	Porto Velho EC U20	Sampaio Correa U20	2023-09-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217995310	f
416	FH/IH U19	IR/Lettir U19	2023-09-07 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217983325	f
417	Comerciantes FC	Comerciantes Unidos	2023-09-07 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218012849	f
418	Anguilla	Saint Martin	2023-09-07 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217936505	f
419	Union Huaral	Deportivo Coopsol	2023-09-07 21:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217991587	f
420	KH Hlidarendi	Skallagrimur	2023-09-07 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217990757	f
582	Beitar Petah Tikva	Hakoah Ramat Gan	2023-09-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218025874	f
585	Chinese Taipei	Philippines	2023-09-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217893346	f
421	Tombense MG	ABC RN	2023-09-07 22:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217808744	f
584	MS Tzeirey Kfar Kana	Hapoel Bnei Zalafa	2023-09-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218018193	f
583	Burnley U21	Queens Park Rangers U21	2023-09-08 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218018422	f
587	Hapoel Migdal HaEmek	Ironi Nesher	2023-09-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218018013	f
594	Maccabi Neve Shaanan Eldad	Maccabi Ahva Fureidis	2023-09-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218025604	f
589	Hapoel Hod HaSharon	Sporting Tel Aviv	2023-09-08 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218025964	f
595	Hapoel Kiryat Ono	FC Inter Tel Aviv	2023-09-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218039105	f
593	Tzeirey Tira FC	Hapoel Kafr Qasim Shouaa	2023-09-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218025514	f
597	Indonesia	Turkmenistan	2023-09-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217985428	f
350	Venghnuai	Chhinga Veng	2023-09-07 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217981651	f
354	Cambodia	Hong Kong	2023-09-07 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217936414	f
381	Ironi Tiberias	Ironi Ramat HaSharon	2023-09-07 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217982287	f
405	Poland	Faroe Islands	2023-09-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216942888	f
406	Serbia	Hungary	2023-09-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216922903	f
408	Slovenia	Northern Ireland	2023-09-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216912686	f
409	Czech Republic	Albania	2023-09-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216735709	f
407	Netherlands	Greece	2023-09-07 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216913335	f
410	Morocco U23	Brazil U23	2023-09-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218012716	f
412	Municipal Turrialba	Guadalupe F.C	2023-09-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217959839	f
414	Tunisia	Botswana	2023-09-07 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217981747	f
422	Sint Maarten	St Lucia	2023-09-07 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217796847	f
423	Trinidad & Tobago	Curacao	2023-09-07 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798044	f
424	Paraguay	Peru	2023-09-07 23:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217454961	f
575	Beitar Nahariya	Maccabi Bnei Jadeidi-Makr	2023-09-08 09:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218049363	f
576	MS Jerusalem	SC Ramla	2023-09-08 09:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218042352	f
577	Ruch Chorzow	Piast Gliwice	2023-09-08 10:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218039921	f
578	Beitar Yavne	FC Shikhun HaMizrah	2023-09-08 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218039195	f
579	Ironi Beit Dagan	HaMakhtesh Givatayim	2023-09-08 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218025694	f
580	Myanmar	Nepal	2023-09-08 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218029800	f
581	Hapoel Tirat HaCarmel	Hapoel Bnei Arrara Ara	2023-09-08 11:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218025784	f
586	Hapoel Bueine	MS Tira	2023-09-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218018103	f
588	Singapore	Tajikistan	2023-09-08 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217941098	f
590	MSK Kiryat Yam	Maccabi Ahi Nazareth	2023-09-08 12:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218020484	f
591	Ironi Baka El Garbiya	Hapoel Kfar Kana	2023-09-08 12:50:00	https://www.orbitxch.com/customer/sport/1/market/1.218020304	f
592	Hapoel Herzliya	AS Nordia Jerusalem	2023-09-08 12:55:00	https://www.orbitxch.com/customer/sport/1/market/1.218020394	f
596	Hapoel Marmorek	Hapoel Tzafririm Holon	2023-09-08 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218017923	f
624	Tampere Utd	Atlantis	2023-09-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217995024	f
600	FC Dornbirn	WSG Wattens	2023-09-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218034549	f
599	FC Fastav Zlin B	Trinec	2023-09-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218046647	f
603	Sporting Rosiori	ACS Vedita Colonesti MS	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038467	f
604	Latvia U21	Italy U21	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217955086	f
606	Muscelul Campulung	Popesti-Leordeni	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038197	f
609	CS Avantul Periam	CS Phoenix Buzias	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038557	f
607	ACS Tg. Mures 1898	CF Metalurgistul Cugir	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038647	f
602	ACS Kids Tampa Brasov	ACS Olimpic Zarnesti	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038737	f
611	Villarreal CF III	CD Roda	2023-09-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218039737	f
610	CSM Deva	Ghiroda si Giarmata Vii	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038377	f
605	ACS Inainte Modelu	CS Afumati	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038287	f
615	UC Ceares	Condal CF	2023-09-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218039647	f
612	FK Vrsac	Macva Sabac	2023-09-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218020669	f
613	NK Sesvete	Vukovar	2023-09-08 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217970789	f
614	SK Kvítkovice	MFK Karvina B	2023-09-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218033921	f
620	KTS-K Luzino	Sokol Kleczew	2023-09-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218039467	f
619	KS Wiazownica	NKP Podhale Nowy Targ	2023-09-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218039377	f
617	Armenia U21	Albania U21	2023-09-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217915195	f
623	Cracovia Krakow	Zaglebie Sosnowiec	2023-09-08 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218028507	f
616	Poland U20	Portugal U20	2023-09-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218007076	f
618	GKS Jastrzebie	KKS Lech Poznan II	2023-09-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217989856	f
621	Atlantis FC/Akatemia	PKK-U	2023-09-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217992019	f
622	Sokol Brozany	Usti Nad Labem	2023-09-08 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218019822	f
625	Lauterach	Lustenau II	2023-09-08 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218036943	f
627	FC Ismaning	Heimstetten	2023-09-08 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218017521	f
628	Roskilde	AB	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218034209	f
626	Gørslev IF	Tarnby	2023-09-08 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218022485	f
629	Thisted	Skive	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218034119	f
630	SV Gerasdorf	Wienerberg	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218037033	f
640	SK Hranice	FK Blansko	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218019732	f
639	AD Limianos	Varzim	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218028687	f
634	Sweden U21	North Macedonia U21	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217955446	f
638	Georgia	Spain	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.216913456	f
632	BK Hacken (W)	Rosengard (W)	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218021071	f
631	Hlucin	Banik Ostrava B	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218019642	f
635	Egypt	Ethiopia	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218026146	f
636	Denmark U20	France U20	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218029620	f
633	Pallo-Iirot	HJS Akatemia	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217994934	f
641	Germany U21	Ukraine U21	2023-09-08 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218002839	f
637	Viktoria Koln	Kaiserslautern	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218043986	f
643	SV Schwechat	Red Star P	2023-09-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218037439	f
644	FC Hertha 03 Zehlendorf	Hertha Berlin	2023-09-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218044076	f
642	St. Pauli (W)	Hamburger SV (W)	2023-09-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218028777	f
645	Netherlands U21	Moldova U21	2023-09-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217955176	f
646	Portugal U21	Andorra U21	2023-09-08 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217955266	f
647	SC Furstenfeld	Ilzer SV	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218036386	f
649	SV Union Gnas	UFC Fehring	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218035413	f
652	Kematen	SV Vols	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218035987	f
654	Fugen	Innsbrucker AC	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218036077	f
651	Andrezieux Boutheon	Le Puy	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218020115	f
648	Frederiksberg	HIK Hellerup	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218034335	f
650	Salzburger	U Henndorf	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218035730	f
655	Hibernian B	The New Saints	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218029137	f
656	FC 08 Villingen	Holzhausen FC	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218017611	f
601	Sheff Wed U21	Charlton U21	2023-09-08 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218018332	f
658	Hassleholms IF	Kristianstads	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218035048	f
666	KAC 1909	Klagenfurt Am	2023-09-08 18:09:00	https://www.orbitxch.com/customer/sport/1/market/1.218037340	f
664	Gamla Upsala (W)	Bollstanas SK (W)	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218000224	f
657	Spartak Myjava	Tatran Lip Mikulas	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217995706	f
665	Homburg	FSV Frankfurt	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218034640	f
659	ATSV Erlangen	TSV Abtswind	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218017251	f
660	Atsv Mutschelbach	SG Sonnenhof	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218017431	f
663	Urduliz FT	CD Vitoria	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218039557	f
667	Parndorf	Deutschkreutz	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218035629	f
683	KV Oostende (Res)	Sint Truidense (Res)	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218020801	f
682	Niort	Cholet SO	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217936323	f
669	1. CfR Pforzheim	Vfr Mannheim	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218017341	f
681	FCM TQS Traiskirchen	Wiener SK	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218017833	f
680	Sportfreunde Lotte	FC Gievenbeck	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218017161	f
673	SC Victoria Hamburg	TSV Sasel	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218017071	f
687	Deportivo Gladiadores	Ciervos fc	2023-09-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030122	f
677	Chojniczanka Chojnice	Skra Czestochowa	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217990036	f
676	Epinal	Sochaux	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217966484	f
671	Nimes	Chateauroux	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217941188	f
668	Dijon	Villefranche Beaujolais	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217936232	f
670	Marignane-Gignac	Nancy	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217941278	f
679	TSV Havelse	St Pauli II	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218034731	f
675	ETSV Hamburg	FC Turkiye	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218016801	f
674	ASV Drassburg	Favoritner AC	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218017743	f
672	Fortuna Sittard (W)	FC Zwolle (W)	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218028415	f
690	UAI Urquiza (W)	SA Television (W)	2023-09-08 19:10:00	https://www.orbitxch.com/customer/sport/1/market/1.218032780	f
685	Burkina Faso	Eswatini	2023-09-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218026236	f
689	Sportfreunde Siegen	ASC 09 Dortmund	2023-09-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218016891	f
684	Poland U21	Kosovo U21	2023-09-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217955356	f
686	SV Schermbeck	Turkspor Dortmund 2000	2023-09-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218016981	f
688	Excursionistas (W)	Rosario Central (W)	2023-09-08 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218032674	f
691	Augnablik	Hviti Riddarinn	2023-09-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218020002	f
693	Femina WS (W)	Genk (W)	2023-09-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218020891	f
694	Bowers & Pitsea	Gorleston	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218028957	f
692	Rep of Ireland U21	Turkey U21	2023-09-08 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217955536	f
704	Treaty United	Wexford F.C	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217835642	f
705	ASD Pineto Calcio	Entella	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217986094	f
696	Luxembourg	Iceland	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216912806	f
698	Bosnia	Liechtenstein	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217590314	f
697	Bray Wanderers	Galway Utd	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217836788	f
702	Cyprus	Scotland	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216923041	f
708	Uxbridge	Sevenoaks Town	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218028867	f
699	Pesaro	Olbia	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217986004	f
706	Croatia	Latvia	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216913577	f
695	Cardiff Metropolitan	Pontypridd Town	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217964336	f
700	Kerry FC	Longford	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217836240	f
701	Malta U21	Spain U21	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217899480	f
703	Turkey	Armenia	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216923163	f
713	Saudi Arabia	Costa Rica	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217936595	f
710	Real San Joaquin	Deportes Limache	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038923	f
709	Deportes Melipilla	Lautaro de Buin	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038832	f
714	Levante	Espanyol	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217839282	f
715	Sevilla FC (W)	UDG Tenerife Sur (W)	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217836146	f
712	Willem II	MVV Maastricht	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217839009	f
711	Finn Harps	Waterford	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217835732	f
661	FBK Balkan	IFK Simrishamn	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218021161	f
718	Haiti	Cuba	2023-09-08 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217797864	f
721	Fortaleza FC	Boyaca Patriotas	2023-09-08 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217948709	f
722	Fernandez Vial	Deportes Concepcion	2023-09-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218039014	f
723	Ituano	Vila Nova	2023-09-08 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217808852	f
598	Sturm Graz	SV Lafnitz	2023-09-08 13:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218034459	f
608	AFC Odorheiu Secuiesc	ACS SR Municipal Brasov	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218038107	f
757	ACS Viitorul Cluj	CS Unirea Ungheni	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218055244	f
750	Dunarea Calaaisi	Acs Progresul Fund	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218055512	f
749	Csm Focsani	ACS Vointa Limpezis	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218055425	f
752	CS Gilortul TC	ACS Viitorul Simian	2023-09-08 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218055604	f
784	Tampere Utd	Atlantis	2023-09-08 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217995024	f
653	Stade Briochin	Guingamp B	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218020214	f
662	Bron Radom	Concordia Elblag	2023-09-08 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218039287	f
678	AZ Alkmaar Women	Excelsior (W)	2023-09-08 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218030217	f
707	Slovakia	Portugal	2023-09-08 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.216735817	f
860	Crusaders Strikers (W)	Sion Swifts LFC (W)	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218055151	f
856	Club Olimpia (W)	Nacional - Humaita (W)	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218056690	f
862	CS Estudiantes San Luis	Sportivo Penarol	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218052639	f
716	Mali	South Sudan	2023-09-08 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218026056	f
717	Ymir	Reynir Sandgeroi	2023-09-08 20:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218019912	f
719	Belize	St Vincent & Grenadines	2023-09-08 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217797232	f
720	Bermuda	French Guyana	2023-09-08 21:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217797412	f
875	Sportivo Ameliano (W)	Club Guarani (W)	2023-09-08 22:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218056600	f
724	Chilangos FC	Caja Oblatos C.FD	2023-09-08 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218044166	f
725	Barranquilla	Real Cartagena	2023-09-08 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217948815	f
\.


--
-- TOC entry 3104 (class 0 OID 0)
-- Dependencies: 204
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."OverUnderHistorical_id_seq"', 279, true);


--
-- TOC entry 3105 (class 0 OID 0)
-- Dependencies: 203
-- Name: OverUnder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."OverUnder_id_seq"', 24889, true);


--
-- TOC entry 3106 (class 0 OID 0)
-- Dependencies: 206
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.daily_over_2p5_id_seq', 5061, true);


--
-- TOC entry 3107 (class 0 OID 0)
-- Dependencies: 210
-- Name: match_table_prototype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.match_table_prototype_id_seq', 1, false);


--
-- TOC entry 3108 (class 0 OID 0)
-- Dependencies: 208
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 19, true);


--
-- TOC entry 3109 (class 0 OID 0)
-- Dependencies: 214
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 39, true);


--
-- TOC entry 3110 (class 0 OID 0)
-- Dependencies: 212
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 94, true);


--
-- TOC entry 3111 (class 0 OID 0)
-- Dependencies: 216
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 1025, true);


--
-- TOC entry 2920 (class 2606 OID 16541)
-- Name: daily_over_2p5 daily_over_2p5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_pkey PRIMARY KEY (id);


--
-- TOC entry 2922 (class 2606 OID 16543)
-- Name: daily_over_2p5 daily_over_2p5_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_unique UNIQUE (home, away, date_time);


--
-- TOC entry 2926 (class 2606 OID 16993)
-- Name: match_table_prototype match_table_prototype_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.match_table_prototype
    ADD CONSTRAINT match_table_prototype_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 2924 (class 2606 OID 16547)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 2930 (class 2606 OID 17073)
-- Name: over2p5footballsupertips over2p5footballsupertips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips
    ADD CONSTRAINT over2p5footballsupertips_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 2928 (class 2606 OID 17069)
-- Name: over2p5goalsnow over2p5goalsnow_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow
    ADD CONSTRAINT over2p5goalsnow_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 2932 (class 2606 OID 17077)
-- Name: over2p5orbitxch over2p5orbitxch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch
    ADD CONSTRAINT over2p5orbitxch_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE over2p5footballsupertips; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5footballsupertips FROM postgres;
GRANT ALL ON TABLE public.over2p5footballsupertips TO postgres WITH GRANT OPTION;


--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE footballsupertips_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.footballsupertips_today FROM postgres;
GRANT ALL ON TABLE public.footballsupertips_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE over2p5goalsnow; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5goalsnow FROM postgres;
GRANT ALL ON TABLE public.over2p5goalsnow TO postgres WITH GRANT OPTION;


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE goalsnow_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.goalsnow_today FROM postgres;
GRANT ALL ON TABLE public.goalsnow_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE over2p5orbitxch; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5orbitxch FROM postgres;
GRANT ALL ON TABLE public.over2p5orbitxch TO postgres WITH GRANT OPTION;


--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE orbitxch_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.orbitxch_today FROM postgres;
GRANT ALL ON TABLE public.orbitxch_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE "TodayMatches"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodayMatches" FROM postgres;
GRANT ALL ON TABLE public."TodayMatches" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3094 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3095 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodaysBets" FROM postgres;
GRANT ALL ON TABLE public."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3096 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE daily_over_2p5; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5 FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5 TO postgres WITH GRANT OPTION;


--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE match_table_prototype; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.match_table_prototype FROM postgres;
GRANT ALL ON TABLE public.match_table_prototype TO postgres WITH GRANT OPTION;


--
-- TOC entry 1764 (class 826 OID 16567)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


-- Completed on 2023-09-08 12:39:57 BST

--
-- PostgreSQL database dump complete
--

