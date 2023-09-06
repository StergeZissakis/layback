--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-06 19:37:04 BST

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
5	\N	dummy	dummy	2023-08-23 13:31:06.64272	Lay	Under	2.50	1.50	1.28	1	\N
6	\N	dummy	dummy	2023-08-23 13:31:10.10603	Back	Under	2.50	1.00	1.26	1	\N
7	\N	FC Viktoria Köln	Rot-Weiss Essen	2023-08-23 21:19:24.147703	Lay	Under	1.50	1.50	1.53	1	\N
8	\N	FC Viktoria Köln	Rot-Weiss Essen	2023-08-23 21:21:18.203664	Lay	Under	1.50	1.50	1.42	1	\N
9	\N	FC Viktoria Köln	Rot-Weiss Essen	2023-08-23 21:22:14.950051	Back	Under	1.50	1.50	1.42	1	\N
10	\N	dummy	dummy	2023-08-23 22:08:16.857423	Lay	Under	1.50	1.50	2.14	1	\N
11	\N	dummy	dummy	2023-08-23 22:11:21.875465	Back	Under	2.50	1.00	1.26	1	\N
12	\N	dummy	dummy	2023-08-23 22:35:37.360146	Lay	Under	1.50	1.50	4.70	1	\N
13	\N	dummy	dummy	2023-08-23 22:48:46.640338	Lay	Under	2.50	1.50	2.60	1	\N
15	\N	FC Eindhoven	NAC	2023-08-25 20:05:26.785306	Lay	Under	2.50	1.50	2.10	1	\N
16	\N	FC Eindhoven	NAC	2023-08-25 20:42:36.56641	Back	Under	2.50	1.00	1.10	1	\N
14	\N	Schalke	Holstein Kiel	2023-08-25 18:35:23.3757	Lay	Under	2.50	1.50	2.40	1	\N
17	\N	Unterhaching	FC Viktoria Köln	2023-08-26 14:08:31.67134	Lay	Under	2.50	1.50	2.16	1	\N
18	\N	Pardubice	Slovacko	2023-08-26 14:53:12.639809	Lay	Under	2.50	1.50	1.88	1	\N
19	\N	Power Dynamos	African Stars Windhoek	2023-08-26 15:02:43.487886	Lay	Under	2.50	1.50	1.67	1	\N
20	\N	Bochum	Borussia Dortmund	2023-08-26 15:34:28.232996	Lay	Under	2.50	1.50	2.40	1	\N
21	\N	Power Dynamos	African Stars Windhoek	2023-08-26 15:34:48.537574	Back	Under	2.50	1.00	1.10	1	\N
22	\N	Heidenheim	TSG Hoffenheim	2023-08-26 15:38:59.043165	Lay	Under	2.50	1.50	2.24	1	\N
23	\N	Pardubice	Slovacko	2023-08-26 15:41:19.928344	Back	Under	2.50	1.00	1.11	1	\N
24	\N	Oxford Utd	Charlton	2023-08-26 16:03:28.705916	Lay	Under	2.50	1.50	2.08	1	\N
25	\N	Gateshead	Woking	2023-08-26 16:10:43.925107	Lay	Under	2.50	1.50	1.87	1	\N
26	\N	Aldershot	Wealdstone	2023-08-26 16:10:59.778293	Lay	Under	2.50	1.50	2.02	1	\N
27	\N	Oxford Utd	Charlton	2023-08-26 16:24:32.457011	Back	Under	2.50	1.00	1.33	1	\N
28	\N	SK Lisen	Hanacka Slavia Kromeriz	2023-08-26 17:03:13.472264	Lay	Under	2.50	1.50	2.06	1	\N
29	\N	SK Lisen	Hanacka Slavia Kromeriz	2023-08-26 17:35:18.36182	Back	Under	2.50	1.00	1.13	1	\N
30	\N	Krumovgrad	Lokomotiv 1929 Sofia	2023-08-26 18:06:29.058861	Lay	Under	2.50	1.50	1.60	1	\N
31	\N	Yverdon Sport FC	Servette	2023-08-26 18:08:13.781206	Lay	Under	2.50	1.50	2.14	1	\N
32	\N	Monza	Empoli	2023-08-26 18:20:27.360705	Lay	Under	2.50	1.50	1.83	1	\N
33	\N	Eupen	OH Leuven	2023-08-26 18:21:14.070062	Lay	Under	2.50	1.50	2.02	1	\N
34	\N	Kasimpasa	Pendikspor	2023-08-26 18:24:29.368743	Lay	Under	2.50	1.50	1.86	1	\N
35	\N	Krumovgrad	Lokomotiv 1929 Sofia	2023-08-26 18:34:33.51482	Back	Under	2.50	1.00	1.10	1	\N
36	\N	NEC	RKC	2023-08-26 18:51:14.004835	Lay	Under	2.50	1.50	2.10	1	\N
37	\N	Maccabi Netanya	Maccabi Bnei Raina	2023-08-26 19:06:44.134102	Lay	Under	2.50	1.50	1.85	1	\N
38	\N	NEC	RKC	2023-08-26 19:23:18.919781	Back	Under	2.50	1.00	1.13	1	\N
39	\N	Ujpest	Zalaegerszegi TE	2023-08-26 20:07:14.746604	Lay	Under	2.50	1.50	1.77	1	\N
40	\N	Como	AC Reggiana	2023-08-26 20:20:12.937474	Lay	Under	2.50	1.50	1.65	1	\N
41	\N	KV Kortrijk	Standard Liege	2023-08-26 20:51:14.490536	Lay	Under	2.50	1.50	2.06	1	\N
42	\N	Excelsior	Fortuna Sittard	2023-08-26 21:02:29.31157	Lay	Under	2.50	1.50	1.91	1	\N
43	\N	PSG	Lens	2023-08-26 21:08:15.557908	Lay	Under	2.50	1.50	1.93	1	\N
44	\N	KV Kortrijk	Standard Liege	2023-08-26 21:18:19.147548	Back	Under	2.50	1.00	1.26	1	\N
45	\N	Excelsior	Fortuna Sittard	2023-08-26 21:25:33.119001	Back	Under	2.50	1.00	1.27	1	\N
48	\N	Hapoel Umm Al Fahm	Hapoel Umm Al Fahm	2023-08-28 17:47:00.016907	Lay	Under	1.50	1.50	1.74	1	\N
49	\N	Vejle	Vejle	2023-08-28 19:13:51.695857	Lay	Under	1.50	1.50	1.52	1	\N
50	\N	Vejle	Vejle	2023-08-28 19:41:27.938099	Lay	Under	2.50	1.50	1.06	1	\N
51	\N	Vejle	Vejle	2023-08-28 19:42:59.754929	Back	Under	2.50	1.00	1.05	1	\N
52	2023-08-28 19:00:00	Giresunspor	Bandirmaspor	2023-08-28 20:10:11.453416	Lay	Under	2.50	1.50	1.73	1	\N
53	2023-08-28 19:00:00	Giresunspor	Bandirmaspor	2023-08-28 20:40:20.007184	Back	Under	2.50	1.00	1.13	1	\N
54	2023-08-30 17:30:00	Pogon Szczecin	Slask Wroclaw	2023-08-30 18:39:03.298965	Lay	Under	2.50	1.50	2.28	1	\N
55	2023-08-30 20:00:00	AEK Athens	Antwerp	2023-08-30 21:05:51.594146	Lay	Under	1.50	1.50	1.83	1	\N
56	2023-08-30 20:00:00	PSV	Rangers	2023-08-30 21:08:06.045835	Lay	Under	2.50	1.50	2.10	1	\N
57	2023-08-30 20:00:00	AEK Athens	Antwerp	2023-08-30 21:46:02.655204	Back	Under	1.50	1.50	1.48	1	\N
58	2023-08-31 17:00:00	HJK Helsinki	Farul Constanta	2023-08-31 18:06:05.820979	Lay	Under	2.50	1.50	1.63	1	\N
59	2023-08-31 17:00:00	HJK Helsinki	Farul Constanta	2023-08-31 18:41:15.473242	Back	Under	2.50	1.00	1.52	1	\N
60	2023-08-31 17:45:00	Breidablik	FC Struga Trim & Lum	2023-08-31 18:50:51.267824	Lay	Under	2.50	1.50	1.84	1	\N
61	2023-08-31 18:00:00	Viktoria Plzen	Tobol Kostanay	2023-08-31 19:07:36.838141	Lay	Under	2.50	1.50	2.00	1	\N
62	2023-08-31 18:00:00	Apoel Nicosia	Gent	2023-08-31 19:10:07.669752	Lay	Under	2.50	1.50	1.76	1	\N
63	2023-08-31 18:00:00	FC Twente	Fenerbahce	2023-08-31 19:13:22.223835	Lay	Under	1.50	1.50	1.86	1	\N
64	2023-08-31 17:45:00	Breidablik	FC Struga Trim & Lum	2023-08-31 19:17:59.524112	Back	Under	2.50	1.00	1.14	1	\N
65	2023-08-31 18:00:00	Viktoria Plzen	Tobol Kostanay	2023-08-31 19:41:46.435676	Back	Under	2.50	1.00	1.49	1	\N
66	2023-08-31 18:00:00	FC Twente	Fenerbahce	2023-08-31 19:49:32.433628	Back	Under	1.50	1.50	1.45	1	\N
67	2023-08-31 19:00:00	BATE Borisov	KF Ballkani	2023-08-31 20:04:51.931013	Lay	Under	2.50	1.50	1.73	1	\N
68	2023-08-31 19:00:00	NK Celje	Maccabi Tel Aviv	2023-08-31 20:05:37.109055	Lay	Under	2.50	1.50	1.87	1	\N
69	2023-08-31 19:00:00	Besiktas	Dynamo Kyiv	2023-08-31 20:06:21.491612	Lay	Under	1.50	1.50	1.95	1	\N
70	2023-08-31 19:00:00	Ajax	Ludogorets Razgrad	2023-08-31 20:06:53.297341	Lay	Under	1.50	1.50	1.94	1	\N
71	2023-08-31 19:00:00	Fiorentina	Rapid Vienna	2023-08-31 20:08:08.030322	Lay	Under	1.50	1.50	2.76	1	\N
72	2023-08-31 19:00:00	Adana Demirspor	Genk	2023-08-31 20:20:09.713914	Lay	Under	2.50	1.50	2.06	1	\N
73	2023-08-31 19:15:00	HNK Rijeka	Lille	2023-08-31 20:23:51.92046	Lay	Under	1.50	1.50	1.69	1	\N
74	2023-08-31 19:00:00	BATE Borisov	KF Ballkani	2023-08-31 20:35:00.403919	Back	Under	2.50	1.00	1.13	1	\N
75	2023-08-31 19:30:00	Lugano	Union Saint Gilloise	2023-08-31 20:38:07.514487	Lay	Under	2.50	1.50	1.91	1	\N
76	2023-08-31 19:00:00	NK Celje	Maccabi Tel Aviv	2023-08-31 20:40:46.531653	Back	Under	2.50	1.00	1.52	1	\N
77	2023-08-31 19:30:00	Eintracht Frankfurt	Levski Sofia	2023-08-31 20:41:23.060925	Lay	Under	1.50	1.50	1.68	1	\N
78	2023-08-31 19:30:00	Club Brugge	Osasuna	2023-08-31 20:41:52.790398	Lay	Under	2.50	1.50	1.63	1	\N
79	2023-08-31 19:00:00	Besiktas	Dynamo Kyiv	2023-08-31 20:43:32.501581	Back	Under	1.50	1.50	1.51	1	\N
80	2023-08-31 19:00:00	Ajax	Ludogorets Razgrad	2023-08-31 20:45:04.292601	Back	Under	1.50	1.50	1.44	1	\N
81	2023-08-31 19:00:00	Fiorentina	Rapid Vienna	2023-08-31 20:45:18.926556	Back	Under	1.50	1.50	1.52	1	\N
82	2023-08-31 19:00:00	Adana Demirspor	Genk	2023-08-31 20:49:17.94391	Back	Under	2.50	1.00	1.14	1	\N
83	2023-08-31 20:00:00	Partizan Belgrade	FC Nordsjaelland	2023-08-31 21:06:08.018614	Lay	Under	2.50	1.50	1.83	1	\N
84	2023-08-31 19:30:00	Lugano	Union Saint Gilloise	2023-08-31 21:07:15.777576	Back	Under	2.50	1.00	1.14	1	\N
85	2023-08-31 19:30:00	Eintracht Frankfurt	Levski Sofia	2023-08-31 21:07:30.689661	Back	Under	1.50	1.00	1.13	1	\N
86	2023-08-31 20:00:00	Zrinjski Mostar	LASK Linz	2023-08-31 21:08:22.311831	Lay	Under	2.50	1.50	1.60	1	\N
87	2023-08-31 20:00:00	Legia Warsaw	Midtjylland	2023-08-31 21:10:52.5968	Lay	Under	1.50	1.50	1.57	1	\N
88	2023-08-31 20:00:00	Partizan Belgrade	FC Nordsjaelland	2023-08-31 21:32:17.410008	Back	Under	2.50	1.00	1.13	1	\N
89	2023-08-31 20:00:00	Zrinjski Mostar	LASK Linz	2023-08-31 21:44:32.424994	Back	Under	2.50	1.00	1.50	1	\N
90	2023-09-01 11:00:00	Daejeon Hana Citizen	Suwon FC	2023-09-01 12:06:50.135008	Lay	Under	2.50	1.50	2.22	1	\N
91	2023-09-01 11:00:00	Daejeon Hana Citizen	Suwon FC	2023-09-01 12:39:00.653155	Back	Under	2.50	1.00	1.12	1	\N
92	2023-09-01 16:00:00	Al Taee	Abha	2023-09-01 17:13:06.453458	Lay	Under	1.50	1.50	1.76	1	\N
93	2023-09-01 16:00:00	Al Taee	Abha	2023-09-01 17:41:15.635818	Back	Under	1.50	1.00	1.14	1	\N
94	2023-09-01 17:00:00	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 18:11:51.221068	Lay	Under	2.50	1.50	2.10	1	\N
95	2023-09-01 17:30:00	Eintracht Braunschweig	St Pauli	2023-09-01 18:39:04.91302	Lay	Under	1.50	1.50	1.93	1	\N
96	2023-09-01 18:00:00	AC Horsens	B93 Copenhagen	2023-09-01 19:05:05.312783	Lay	Under	1.50	1.50	2.02	1	\N
97	2023-09-01 18:00:00	Vendsyssel FF	FC Fredericia	2023-09-01 19:05:20.645749	Lay	Under	1.50	1.50	2.22	1	\N
98	2023-09-01 18:00:00	Skeid	Asane	2023-09-01 19:05:35.469657	Lay	Under	1.50	1.50	1.99	1	\N
101	2023-09-01 18:00:00	AC Horsens	B93 Copenhagen	2023-09-01 19:34:13.786876	Back	Under	1.50	1.00	1.14	1	\N
99	2023-09-01 18:00:00	Saarbrucken	Borussia Dortmund II	2023-09-01 19:07:51.615755	Lay	Under	2.50	1.50	1.97	1	\N
100	2023-09-01 18:00:00	Hillerød	Sonderjyske	2023-09-01 19:10:52.320153	Lay	Under	2.50	1.50	2.06	1	\N
102	2023-09-01 18:00:00	Saarbrucken	Borussia Dortmund II	2023-09-01 19:43:01.398217	Back	Under	2.50	1.00	1.46	1	\N
103	2023-09-01 18:00:00	Vendsyssel FF	FC Fredericia	2023-09-01 19:43:31.514338	Back	Under	1.50	1.50	1.51	1	\N
104	2023-09-01 19:00:00	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 20:06:22.667395	Lay	Under	1.50	1.50	1.54	1	\N
105	2023-09-01 19:00:00	Helmond Sport	Cambuur Leeuwarden	2023-09-01 20:07:52.723178	Lay	Under	2.50	1.50	1.86	1	\N
106	2023-09-01 19:00:00	VVV	De Graafschap	2023-09-01 20:08:10.448192	Lay	Under	2.50	1.50	2.18	1	\N
107	2023-09-01 19:00:00	Sparta Rotterdam	NEC	2023-09-01 20:08:38.986956	Lay	Under	1.50	1.50	1.86	1	\N
108	2023-09-01 19:00:00	Caykur Rizespor	Fatih Karagumruk	2023-09-01 20:08:55.215379	Lay	Under	2.50	1.50	1.78	1	\N
109	2023-09-01 19:00:00	Telstar	FC Eindhoven	2023-09-01 20:09:08.50325	Lay	Under	1.50	1.50	1.72	1	\N
110	2023-09-01 19:00:00	Zulte-Waregem	FCV Dender EH	2023-09-01 20:09:39.510243	Lay	Under	2.50	1.50	2.34	1	\N
111	2023-09-01 19:00:00	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 20:10:10.391471	Lay	Under	1.50	1.50	1.63	1	\N
112	2023-09-01 19:00:00	FC Utrecht Reserves	Roda JC	2023-09-01 20:11:54.678343	Lay	Under	2.50	1.50	1.99	1	\N
113	2023-09-01 19:00:00	Caykur Rizespor	Fatih Karagumruk	2023-09-01 20:38:04.401263	Back	Under	2.50	1.00	1.13	1	\N
114	2023-09-01 19:00:00	Zulte-Waregem	FCV Dender EH	2023-09-01 20:41:49.785543	Back	Under	2.50	1.00	1.12	1	\N
115	2023-09-01 19:00:00	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 20:42:20.433782	Back	Under	1.50	1.50	1.49	1	\N
116	2023-09-01 19:00:00	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 20:42:34.942111	Back	Under	1.50	1.50	1.49	1	\N
117	2023-09-01 19:00:00	Helmond Sport	Cambuur Leeuwarden	2023-09-01 20:45:04.278033	Back	Under	2.50	1.00	1.50	1	\N
118	2023-09-01 19:00:00	Telstar	FC Eindhoven	2023-09-01 20:45:20.806975	Back	Under	1.50	1.50	1.50	1	\N
119	2023-09-01 19:00:00	VVV	De Graafschap	2023-09-01 20:45:22.339204	Back	Under	2.50	1.00	1.49	1	\N
120	2023-09-01 19:00:00	FC Utrecht Reserves	Roda JC	2023-09-01 20:49:05.761916	Back	Under	2.50	1.00	1.51	1	\N
121	2023-09-01 19:45:00	Drogheda United	UCD	2023-09-01 20:52:04.628352	Lay	Under	2.50	1.50	1.80	1	\N
122	2023-09-01 19:45:00	Drogheda United	UCD	2023-09-01 21:26:13.919098	Back	Under	2.50	1.00	1.50	1	\N
127	2023-09-03 14:30:00	Eintracht Frankfurt	Cologne	2023-09-03 15:39:56.42434	Lay	Under	2.50	1.50	1.62	1	\N
128	2023-09-03 14:30:00	Eintracht Frankfurt	Cologne	2023-09-03 16:09:02.479735	Back	Under	2.50	1.00	1.12	1	\N
129	2023-09-03 15:45:00	Vitesse	AZ	2023-09-03 16:53:56.036388	Lay	Under	1.50	1.50	1.84	1	\N
130	2023-09-03 18:15:00	Charleroi	Sint-Truidense	2023-09-03 19:20:49.841339	Lay	Under	1.50	1.50	1.87	1	\N
131	2023-09-03 18:15:00	Charleroi	Sint-Truidense	2023-09-03 19:48:57.658322	Back	Under	1.50	1.00	1.12	1	\N
123	2023-09-03 13:30:00	FC Volendam	FC Twente	2023-09-03 14:38:26.428093	Lay	Under	2.50	1.50	2.06	1	\N
124	2023-09-03 13:30:00	Fortuna Sittard	Ajax	2023-09-03 14:42:11.893245	Lay	Under	1.50	1.50	1.97	1	\N
125	2023-09-03 13:30:00	Fortuna Sittard	Ajax	2023-09-03 15:11:18.079473	Back	Under	1.50	1.00	1.11	1	\N
126	2023-09-03 13:30:00	FC Volendam	FC Twente	2023-09-03 15:16:34.556346	Back	Under	2.50	1.00	1.39	1	\N
\.


--
-- TOC entry 3075 (class 0 OID 17015)
-- Dependencies: 215
-- Data for Name: over2p5footballsupertips; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5footballsupertips (id, home, away, date_time, url) FROM stdin;
2	Sonderjyske	Vejle	2023-09-06 19:00:00	\N
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

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 16, true);


--
-- TOC entry 3109 (class 0 OID 0)
-- Dependencies: 214
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 15, true);


--
-- TOC entry 3110 (class 0 OID 0)
-- Dependencies: 212
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 75, true);


--
-- TOC entry 3111 (class 0 OID 0)
-- Dependencies: 216
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 348, true);


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


-- Completed on 2023-09-06 19:37:04 BST

--
-- PostgreSQL database dump complete
--

