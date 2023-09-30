--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-0+deb12u1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-0+deb12u1)

-- Started on 2023-09-30 16:22:23 BST

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
-- TOC entry 221 (class 1259 OID 16559)
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
-- TOC entry 222 (class 1259 OID 16564)
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
    "BetResultTime" timestamp without time zone
);


--
-- TOC entry 228 (class 1259 OID 16600)
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
-- TOC entry 229 (class 1259 OID 16604)
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
-- TOC entry 223 (class 1259 OID 16578)
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
-- TOC entry 224 (class 1259 OID 16583)
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
-- Dependencies: 224
-- Name: over2p5bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5bets_id_seq OWNED BY public.over2p5bets.id;


--
-- TOC entry 225 (class 1259 OID 16584)
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
-- Dependencies: 225
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5footballsupertips_id_seq OWNED BY public.over2p5footballsupertips.id;


--
-- TOC entry 226 (class 1259 OID 16585)
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
-- Dependencies: 226
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5goalsnow_id_seq OWNED BY public.over2p5goalsnow.id;


--
-- TOC entry 227 (class 1259 OID 16586)
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
-- Dependencies: 227
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
-- Dependencies: 222
-- Data for Name: over2p5bets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetResultTime") FROM stdin;
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
62	Columbus Crew	Philadelphia Union	2023-10-01 00:30:00	\N	76
63	Inter Miami CF	New York City FC	2023-10-01 00:30:00	\N	76
64	New England Revolution	Charlotte FC	2023-10-01 00:30:00	\N	76
65	New York Red Bulls	Chicago Fire	2023-10-01 00:30:00	\N	76
66	Orlando City SC	CF Montreal	2023-10-01 00:30:00	\N	76
67	Toronto FC	FC Cincinnati	2023-10-01 00:30:00	\N	76
68	Houston Dynamo	FC Dallas	2023-10-01 01:30:00	\N	76
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
59	Columbus Crew	Philadelphia Union	2023-10-01 00:30:00	\N	76
60	Inter Miami CF	New York City FC	2023-10-01 00:30:00	\N	76
61	New England Revolution	Charlotte FC	2023-10-01 00:30:00	\N	76
62	New York Red Bulls	Chicago Fire	2023-10-01 00:30:00	\N	76
63	Orlando City SC	CF Montreal	2023-10-01 00:30:00	\N	76
64	Toronto FC	FC Cincinnati	2023-10-01 00:30:00	\N	76
65	Houston Dynamo	FC Dallas	2023-10-01 01:30:00	\N	76
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
9	Norrkoping	Kalmar FF	2023-09-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218572509	f	\N	\N	\N
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
20	Winterthur	Lugano	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218798817	f	\N	\N	\N
21	Sligo Rovers (W)	Bohemians (W)	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218920530	f	\N	\N	\N
22	Skra Czestochowa	GKS Jastrzebie	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218982513	f	\N	\N	\N
23	Ruzomberok	Zemplin	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218828885	f	\N	\N	\N
24	Zamalek	Solar7	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219006565	f	\N	\N	\N
25	FC Vilafranca	Girona FC II	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218996961	f	\N	\N	\N
26	Chernomorets Odesa	Zorya	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218757012	f	\N	\N	\N
27	Servette	Lausanne	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218798925	f	\N	\N	\N
28	Sol De Mayo	Villa Mitre	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218980991	f	\N	\N	\N
29	Genclerbirligi	Manisa FK	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218731473	f	\N	\N	\N
30	Valencia-Mestalla	Cerdanyola del Valles	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218896353	f	\N	\N	\N
31	Sparta Prague	Plzen	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218505965	f	\N	\N	\N
32	Trencin	DUKLA BANSKA BYSTRICA	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218617971	f	\N	\N	\N
33	AC Milan	Lazio	2023-09-30 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218580648	f	\N	\N	\N
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
49	Girona	Real Madrid	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218580528	f	\N	\N	\N
50	Tottenham	Liverpool	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218409626	f	\N	\N	\N
51	RB Leipzig	Bayern Munich	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218409706	f	\N	\N	\N
52	Maccabi Petach Tikva	Bnei Sakhnin	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218907071	f	\N	\N	\N
53	Oxford City	Altrincham	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218715494	f	\N	\N	\N
54	Giana Erminio	Arzignanochiampo	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218867413	f	\N	\N	\N
55	Pro Vercelli	Fiorenzuola	2023-09-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218867503	f	\N	\N	\N
56	FC Ashdod	Hapoel Eran Hadera	2023-09-30 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218723364	f	\N	\N	\N
57	Hapoel Haifa	Maccabi Bnei Raina	2023-09-30 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218723273	f	\N	\N	\N
58	FC Utrecht	Almere City	2023-09-30 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218426804	f	\N	\N	\N
59	PSV	FC Volendam	2023-09-30 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218426696	f	\N	\N	\N
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
78	Boavista	Famalicao	2023-09-30 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218771434	f	\N	\N	\N
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
90	Francs Borains	Seraing Utd	2023-09-30 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218971715	f	\N	\N	\N
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
113	Hertha Berlin	St Pauli	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218517026	f	\N	\N	\N
114	Grasshoppers Zurich	Young Boys	2023-09-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218803023	f	\N	\N	\N
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
126	FC Twente	Heerenveen	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218427021	f	\N	\N	\N
127	San Lorenzo	Huracan	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218776363	f	\N	\N	\N
128	Ferro Carril	Racing Cordoba	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218956268	f	\N	\N	\N
129	RKC Waalwijk	Ajax	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218426912	f	\N	\N	\N
130	CD General Velasquez	Deportes Limache	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.219002191	f	\N	\N	\N
131	Albacete	Andorra CF	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218683603	f	\N	\N	\N
132	Villarreal B	Alcorcon	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218705518	f	\N	\N	\N
133	Monaco	Marseille	2023-09-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218408412	f	\N	\N	\N
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
\.


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 224
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 1, false);


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 225
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 68, true);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 226
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 65, true);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 227
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 216, true);


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
-- Dependencies: 221
-- Name: TABLE "TodayMatches"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodayMatches" FROM postgres;
GRANT ALL ON TABLE public."TodayMatches" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodaysBets" FROM postgres;
GRANT ALL ON TABLE public."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE "YesterdaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."YesterdaysBets" FROM postgres;
GRANT ALL ON TABLE public."YesterdaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 223
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


-- Completed on 2023-09-30 16:22:23 BST

--
-- PostgreSQL database dump complete
--

