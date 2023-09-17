--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-17 01:03:47 BST

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
-- TOC entry 3046 (class 1262 OID 13465)
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
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 3046
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3048 (class 0 OID 0)
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
-- TOC entry 3049 (class 0 OID 0)
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
    'Lost'
);


--
-- TOC entry 640 (class 1247 OID 16404)
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
    url character varying
);


--
-- TOC entry 212 (class 1259 OID 17082)
-- Name: footballsupertips_today; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.footballsupertips_today AS
 SELECT over2p5footballsupertips.id,
    over2p5footballsupertips.home,
    over2p5footballsupertips.away,
    over2p5footballsupertips.date_time,
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
    url character varying
);


--
-- TOC entry 211 (class 1259 OID 17078)
-- Name: goalsnow_today; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.goalsnow_today AS
 SELECT over2p5goalsnow.id,
    over2p5goalsnow.home,
    over2p5goalsnow.away,
    over2p5goalsnow.date_time,
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
-- TOC entry 213 (class 1259 OID 17086)
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
-- TOC entry 214 (class 1259 OID 17090)
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
-- TOC entry 203 (class 1259 OID 16493)
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
    "BetResult" public."BetResult",
    "BetMatchTime" timestamp without time zone
);


--
-- TOC entry 215 (class 1259 OID 17110)
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
    a."BetMatchTime",
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
-- TOC entry 3059 (class 0 OID 0)
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
-- TOC entry 3060 (class 0 OID 0)
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
-- TOC entry 3061 (class 0 OID 0)
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
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 209
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5orbitxch_id_seq OWNED BY public.over2p5orbitxch.id;


--
-- TOC entry 2889 (class 2604 OID 16906)
-- Name: over2p5bets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets ALTER COLUMN id SET DEFAULT nextval('public.over2p5bets_id_seq'::regclass);


--
-- TOC entry 2891 (class 2604 OID 17018)
-- Name: over2p5footballsupertips id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips ALTER COLUMN id SET DEFAULT nextval('public.over2p5footballsupertips_id_seq'::regclass);


--
-- TOC entry 2890 (class 2604 OID 17007)
-- Name: over2p5goalsnow id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow ALTER COLUMN id SET DEFAULT nextval('public.over2p5goalsnow_id_seq'::regclass);


--
-- TOC entry 2893 (class 2604 OID 17029)
-- Name: over2p5orbitxch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch ALTER COLUMN id SET DEFAULT nextval('public.over2p5orbitxch_id_seq'::regclass);


--
-- TOC entry 3033 (class 0 OID 16493)
-- Dependencies: 203
-- Data for Name: over2p5bets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetMatchTime") FROM stdin;
18	2023-09-06 19:00:00	SonderjyskE	Vejle	2023-09-06 20:15:04.824315	Lay	Under	2.50	1.50	1.64	1	\N	\N
19	2023-09-06 19:00:00	SonderjyskE	Vejle	2023-09-06 20:38:40.392177	Back	Under	2.50	1.00	1.12	1	\N	\N
20	2023-09-08 19:45:00	Turkey	Armenia	2023-09-08 21:12:52.123619	Lay	Under	2.50	1.50	1.44	1	\N	\N
21	2023-09-08 19:45:00	Turkey	Armenia	2023-09-08 21:27:16.909669	Back	Under	2.50	1.00	1.13	1	\N	\N
22	2023-09-09 19:45:00	Romania	Israel	2023-09-09 20:00:01.58423	Lay	Under	2.50	1.50	1.71	1	\N	\N
23	2023-09-09 19:45:00	Romania	Israel	2023-09-09 21:27:19.539354	Back	Under	2.50	1.00	1.52	1	\N	\N
24	2023-09-16 23:00:00	Atlanta Utd	Inter Miami CF	2023-09-16 23:36:29.549506	Lay	Under	2.50	1.50	1.10	5	\N	\N
\.


--
-- TOC entry 3038 (class 0 OID 17015)
-- Dependencies: 208
-- Data for Name: over2p5footballsupertips; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5footballsupertips (id, home, away, date_time, url) FROM stdin;
327	HB Køge	Kolding IF	2023-09-14 18:00:00	\N
328	Westerlo	Antwerp	2023-09-15 19:45:00	\N
329	Genk II	Zulte-Waregem	2023-09-15 19:00:00	\N
330	RFC Liege	Club Brugge II	2023-09-15 19:00:00	\N
331	Viborg	Midtjylland	2023-09-15 18:00:00	\N
332	Hobro IK	AC Horsens	2023-09-15 18:00:00	\N
333	Sonderjyske	AaB	2023-09-15 18:00:00	\N
334	Hillerød	B93 Copenhagen	2023-09-15 18:00:00	\N
335	Bayern Munich	Bayer Leverkusen	2023-09-15 19:30:00	\N
336	FC Dordrecht	FC Utrecht Reserves	2023-09-15 19:00:00	\N
337	Helmond Sport	Top Oss	2023-09-15 19:00:00	\N
338	Ajax Reserves	FC Emmen	2023-09-15 19:00:00	\N
339	AZ Reserves	FC Eindhoven	2023-09-15 19:00:00	\N
340	FC Groningen	ADO Den Haag	2023-09-15 19:00:00	\N
341	PSV Reserves	De Graafschap	2023-09-15 19:00:00	\N
342	FC Den Bosch	Maastricht	2023-09-15 19:00:00	\N
343	Roda JC	Telstar	2023-09-15 19:00:00	\N
344	VVV	NAC	2023-09-15 19:00:00	\N
368	Feyenoord	Heerenveen	2023-09-16 15:30:00	\N
345	Austria Klagenfurt	LASK Linz	2023-09-16 16:00:00	\N
346	FC Blau Weiss Linz	SCR Altach	2023-09-16 16:00:00	\N
347	SK Sturm Graz	FC Salzburg	2023-09-16 18:30:00	\N
348	RWD Molenbeek	Cercle Brugge	2023-09-16 15:00:00	\N
349	Union Saint Gilloise	Genk	2023-09-16 17:15:00	\N
350	Club Brugge	Charleroi	2023-09-16 19:45:00	\N
351	Anderlecht II	Patro Eisden Maasmechelen	2023-09-16 15:00:00	\N
352	FCV Dender EH	Lommel	2023-09-16 19:00:00	\N
353	KFCO Beerschot Wilrijk	SK Beveren	2023-09-16 19:00:00	\N
354	FC Nordsjaelland	FC Copenhagen	2023-09-16 15:00:00	\N
355	Wolverhampton	Liverpool	2023-09-16 12:30:00	\N
356	Aston Villa	Crystal Palace	2023-09-16 15:00:00	\N
357	Fulham	Luton	2023-09-16 15:00:00	\N
358	Man Utd	Brighton	2023-09-16 15:00:00	\N
359	Tottenham	Sheff Utd	2023-09-16 15:00:00	\N
360	West Ham	Man City	2023-09-16 15:00:00	\N
361	Newcastle	Brentford	2023-09-16 17:30:00	\N
362	RB Leipzig	Augsburg	2023-09-16 14:30:00	\N
363	SC Freiburg	Borussia Dortmund	2023-09-16 14:30:00	\N
364	Wolfsburg	Union Berlin	2023-09-16 14:30:00	\N
365	Mainz	VfB Stuttgart	2023-09-16 14:30:00	\N
366	Cologne	TSG Hoffenheim	2023-09-16 14:30:00	\N
367	Bochum	Eintracht Frankfurt	2023-09-16 17:30:00	\N
369	Vitesse	RKC	2023-09-16 17:45:00	\N
370	PSV	NEC	2023-09-16 19:00:00	\N
371	Fortuna Sittard	FC Volendam	2023-09-16 19:00:00	\N
372	Heracles	FC Utrecht	2023-09-16 20:00:00	\N
373	New York City FC	New York Red Bulls	2023-09-16 20:30:00	\N
375	Charlotte FC	DC United	2023-09-17 00:30:00	\N
376	CF Montreal	Chicago Fire	2023-09-17 00:30:00	\N
377	Orlando City SC	Columbus Crew	2023-09-17 00:30:00	\N
378	Philadelphia Union	FC Cincinnati	2023-09-17 00:30:00	\N
379	Toronto FC	Vancouver Whitecaps	2023-09-17 00:30:00	\N
380	Houston Dynamo	St. Louis City SC	2023-09-17 01:30:00	\N
381	Minnesota United	Sporting Kansas City	2023-09-17 01:30:00	\N
382	FC Dallas	Seattle Sounders FC	2023-09-17 01:30:00	\N
383	Colorado Rapids	New England Revolution	2023-09-17 02:30:00	\N
384	Los Angeles FC	LA Galaxy	2023-09-17 03:30:00	\N
385	San Jose Earthquakes	Real Salt Lake	2023-09-17 03:30:00	\N
374	Atlanta United	Inter Miami CF	2023-09-16 23:55:00	\N
\.


--
-- TOC entry 3036 (class 0 OID 17004)
-- Dependencies: 206
-- Data for Name: over2p5goalsnow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5goalsnow (id, home, away, date_time, url) FROM stdin;
449	HB Køge	Kolding IF	2023-09-14 18:00:00	\N
450	Bayern Munich	Bayer Leverkusen	2023-09-15 19:30:00	\N
451	Westerlo	Antwerp	2023-09-15 19:45:00	\N
452	Genk II	Zulte-Waregem	2023-09-15 19:00:00	\N
453	RFC Liege	Club Brugge II	2023-09-15 19:00:00	\N
454	Sonderjyske	AaB	2023-09-15 18:00:00	\N
455	Hillerød	B93 Copenhagen	2023-09-15 18:00:00	\N
456	FC Dordrecht	FC Utrecht Reserves	2023-09-15 19:00:00	\N
457	Ajax Reserves	FC Emmen	2023-09-15 19:00:00	\N
458	FC Groningen	ADO Den Haag	2023-09-15 19:00:00	\N
459	PSV Reserves	De Graafschap	2023-09-15 19:00:00	\N
460	FC Den Bosch	Maastricht	2023-09-15 19:00:00	\N
461	Roda JC	Telstar	2023-09-15 19:00:00	\N
462	VVV	NAC	2023-09-15 19:00:00	\N
471	SC Freiburg	Borussia Dortmund	2023-09-16 14:30:00	\N
472	Wolfsburg	Union Berlin	2023-09-16 14:30:00	\N
473	Mainz	VfB Stuttgart	2023-09-16 14:30:00	\N
474	Cologne	TSG Hoffenheim	2023-09-16 14:30:00	\N
475	Bochum	Eintracht Frankfurt	2023-09-16 17:30:00	\N
476	Austria Klagenfurt	LASK Linz	2023-09-16 16:00:00	\N
477	FC Blau Weiss Linz	SCR Altach	2023-09-16 16:00:00	\N
478	SK Sturm Graz	FC Salzburg	2023-09-16 18:30:00	\N
479	RWD Molenbeek	Cercle Brugge	2023-09-16 15:00:00	\N
480	Club Brugge	Charleroi	2023-09-16 19:45:00	\N
481	Anderlecht II	Patro Eisden Maasmechelen	2023-09-16 15:00:00	\N
482	FCV Dender EH	Lommel	2023-09-16 19:00:00	\N
483	KFCO Beerschot Wilrijk	SK Beveren	2023-09-16 19:00:00	\N
484	Feyenoord	Heerenveen	2023-09-16 15:30:00	\N
485	Vitesse	RKC	2023-09-16 17:45:00	\N
486	PSV	NEC	2023-09-16 19:00:00	\N
487	Fortuna Sittard	FC Volendam	2023-09-16 19:00:00	\N
488	Heracles	FC Utrecht	2023-09-16 20:00:00	\N
375	Charlotte FC	DC United	2023-09-17 00:30:00	\N
376	CF Montreal	Chicago Fire	2023-09-17 00:30:00	\N
377	Orlando City SC	Columbus Crew	2023-09-17 00:30:00	\N
378	Philadelphia Union	FC Cincinnati	2023-09-17 00:30:00	\N
379	Toronto FC	Vancouver Whitecaps	2023-09-17 00:30:00	\N
380	Houston Dynamo	St. Louis City SC	2023-09-17 01:30:00	\N
381	Minnesota United	Sporting Kansas City	2023-09-17 01:30:00	\N
382	FC Dallas	Seattle Sounders FC	2023-09-17 01:30:00	\N
383	Colorado Rapids	New England Revolution	2023-09-17 02:30:00	\N
384	Los Angeles FC	LA Galaxy	2023-09-17 03:30:00	\N
385	San Jose Earthquakes	Real Salt Lake	2023-09-17 03:30:00	\N
489	Atlanta United	Inter Miami CF	2023-09-16 23:55:00	\N
463	Wolverhampton	Liverpool	2023-09-16 12:30:00	\N
464	Aston Villa	Crystal Palace	2023-09-16 15:00:00	\N
465	Fulham	Luton	2023-09-16 15:00:00	\N
466	Man Utd	Brighton	2023-09-16 15:00:00	\N
467	Tottenham	Sheff Utd	2023-09-16 15:00:00	\N
468	West Ham	Man City	2023-09-16 15:00:00	\N
469	Newcastle	Brentford	2023-09-16 17:30:00	\N
470	RB Leipzig	Augsburg	2023-09-16 14:30:00	\N
\.


--
-- TOC entry 3040 (class 0 OID 17026)
-- Dependencies: 210
-- Data for Name: over2p5orbitxch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5orbitxch (id, home, away, date_time, url, plaied) FROM stdin;
2945	SonderjyskE	AaB	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961564	t
3337	FC Nordsjaelland	FC Copenhagen	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217900814	f
3345	York City	Southend	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218121261	f
3353	Barnsley	Burton Albion	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889960	f
3304	Fjolnir	Njardvik	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218319692	f
3329	FC Pyunik	BKMA Yerevan	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218268176	f
3359	Celtic	Dundee	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637359	f
3346	Swindon	Walsall	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217951629	f
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
3356	Wycombe	Blackpool	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217888994	f
3352	Torns	FC Trollhattan	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137715	f
3326	Ebbsfleet Utd	Chesterfield	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120361	f
3301	Vasalunds IF	Orebro Syrianska	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218137985	f
3339	Hartlepool	Woking	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218120631	f
3350	Tabor Sezana	NK Jadran Dekani	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218270148	f
3341	FK Puchov	FK Humenne	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218228468	f
3318	Keflavik (W)	Selfoss (W)	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320664	f
3311	Molenbeek	Cercle Brugge	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217902501	t
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
3343	Fulham	Luton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634798	t
3332	Hearts	Aberdeen	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217637467	f
3320	Bristol City	West Brom	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645253	f
3349	Falkenbergs	Norrby IF	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138517	f
3309	Hottur	IR Reykjavik	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320158	f
3308	Gillingham	Morecambe	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217950906	f
3336	Anderlecht B	Patro Eisden Maasmechelen	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218230114	t
3340	HJK Helsinki	FC Inter	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218122464	f
3300	Preston	Plymouth	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645901	f
3331	Lincoln	Carlisle	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217888882	f
3315	Kilmarnock	Hibernian	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217638037	f
3307	West Ham	Man City	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634939	t
3334	Tindastoll (W)	IBV (W)	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218320574	f
3351	Tottenham	Sheff Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217635503	t
2994	Jong PSV Eindhoven	De Graafschap	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218084970	t
3361	Sheff Wed	Ipswich	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645793	f
3298	Huddersfield	Rotherham	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217645577	f
3373	Reading	Bolton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217888660	f
3376	Wigan	Cambridge Utd	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217889102	f
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
3391	Feyenoord	Heerenveen	2023-09-16 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217639118	t
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
3406	Austria Klagenfurt	LASK Linz	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217674584	t
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
3407	FC Blau Weiss Linz	SCR Altach	2023-09-16 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217674465	t
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
3362	Man Utd	Brighton	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217635080	t
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
3160	Kagoshima Utd	Kamatamare Sanuki	2023-09-16 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218138165	f
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
3222	Aegir	Leiknir R	2023-09-16 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218315663	f
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
2910	Lahti	KTP	2023-09-15 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218075271	f
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
2927	CD Tropezon	UD Samano	2023-09-15 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218296206	f
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
2947	Hillerod Fodbold	B93 Copenhagen	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961384	t
2968	ETSV Hamburg	Dassendorf	2023-09-15 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218290536	f
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
2997	Roda JC	SC Telstar	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218082877	t
2999	Racing Genk B	Zulte-Waregem	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218229465	t
3010	FC Dordrecht	Jong FC Utrecht	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218083057	t
3011	FC Groningen	ADO Den Haag	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218083147	t
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
3087	Tecos FC	Colima FC	2023-09-16 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3088	San Martin de San Juan	Agropecuario	2023-09-16 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
3089	SE Palmeiras	Goias	2023-09-16 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218205067	f
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
3290	Aston Villa	Crystal Palace	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217634516	t
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
3419	NK Aluminij	NK Rogaska	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218001568	f
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
3451	Bochum	Eintracht Frankfurt	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217627668	t
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
3445	Newcastle	Brentford	2023-09-16 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217633662	t
3476	Manchego Ciudad Real	CD Estepona	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218252698	f
3429	Molde	Odds BK	2023-09-16 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217668724	f
3499	HFX Wanderers	Atletico Ottawa	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218199019	f
3480	Arenteiro	Real Union	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218233630	f
3485	Union Kleinmunchen (W)	FFC Vorderland (W)	2023-09-16 18:45:00	https://www.orbitxch.com/customer/sport/1/market/1.218313935	f
3483	Real Madrid Castilla	Atletico Madrid II	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238586	f
3484	FK Mladost Donja Gorica	FK Arsenal Tivat	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218323976	f
3497	Fortuna Sittard	FC Volendam	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217639334	t
3502	FK Spartak	Vojvodina	2023-09-16 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218220844	f
3491	Odra Opole	Lechia Gdansk	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217798333	f
3489	PSV	NEC Nijmegen	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217639442	t
3495	Piast Gliwice	Legia Warsaw	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217793923	f
3498	Newells	Union Santa Fe	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217818026	f
3500	Calor de San Pedro	Cimarrones de Sonora II	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218326889	f
3492	Deportivo Municipal	Universidad Cesar Vallejo	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218190287	f
3531	Club Brugge	Charleroi	2023-09-16 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217902717	t
3488	UD Torre del Mar	UD Ciudad de Torredonjimeno	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218328461	f
3486	Athlone Town (W)	Peamount United (W)	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218303771	f
3501	Al Ahli	Al-Taawoun Buraidah	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218040034	f
3496	Mushuc Runa	Delfin	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218030911	f
3490	Kfco Beerschot Wilrijk	Waasland-Beveren	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218125959	t
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
3487	FCV Dender	Lommel	2023-09-16 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218126049	t
3482	Sturm Graz	Red Bull Salzburg	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217656156	f
3566	Real Sociedad III	Real Zaragoza II	2023-09-16 23:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218252970	f
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
3593	Toronto FC	Vancouver Whitecaps	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938356	f
3592	Philadelphia	FC Cincinnati	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938498	f
3594	Charlotte FC	DC Utd	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938855	f
3540	Gimnasia Mendoza	CA Temperley	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218209814	f
3563	Atlanta Utd	Inter Miami CF	2023-09-16 23:55:00	https://www.orbitxch.com/customer/sport/1/market/1.218305366	f
3591	CF Montreal	Chicago Fire	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938638	t
3192	Wolves	Liverpool	2023-09-16 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217635221	t
3371	Araz Nakhchivan PFK	Neftchi Baku	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218262756	f
3328	FSV Frankfurt	Kickers Offenbach	2023-09-16 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218274430	f
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
3603	FC Dallas	Seattle Sounders	2023-09-17 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217939814	f
3607	Cd Fas	Once Municipal	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218307557	f
3602	Minnesota Utd	Kansas City	2023-09-17 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217939922	f
3604	Houston Dynamo	St Louis City SC	2023-09-17 01:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940030	f
3605	Monterrey	Leon	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217716750	f
3608	CD Motagua	CD Real Sociedad	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218295267	f
3609	Venados FC	Celaya	2023-09-17 02:05:00	https://www.orbitxch.com/customer/sport/1/market/1.218135413	f
3610	America de Cali S.A	Boyaca Chico	2023-09-17 02:15:00	https://www.orbitxch.com/customer/sport/1/market/1.218347594	f
3612	Herrera FC	Plaza Amador	2023-09-17 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218308924	f
3614	LD Alajuelense	Puntarenas F.C.	2023-09-17 03:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306593	f
3611	Sporting Cristal	Universitario de Deportes	2023-09-17 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218190823	f
3613	Colorado	New England	2023-09-17 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940138	f
3616	Los Angeles FC	LA Galaxy	2023-09-17 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940355	f
3615	San Jose Earthquakes	Real Salt Lake	2023-09-17 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217940246	f
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
3901	Utebo CF	Barakaldo	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218253060	f
3588	Inter de Queretaro FC	Club San Juan de Aragon	2023-09-17 00:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218339016	f
3599	Estudiantes de Caseros	Independiente Rivadavia	2023-09-17 01:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218210264	f
3538	Heracles	FC Utrecht	2023-09-16 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217639550	t
3481	Intercity Sant Joan C.F	San Fernando CD	2023-09-16 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.218238496	f
3543	New York City	New York Red Bulls	2023-09-16 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938227	f
3595	Orlando City	Columbus	2023-09-17 00:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217938747	f
3606	AD Isidro Metapan	Fuerte San Francisco	2023-09-17 02:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218306953	f
3265	RB Leipzig	Augsburg	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217628028	f
3267	Mainz	Stuttgart	2023-09-16 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217627788	f
\.


--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 204
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 24, true);


--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 207
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 529, true);


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 205
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 619, true);


--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 209
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 4225, true);


--
-- TOC entry 2895 (class 2606 OID 16547)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 2899 (class 2606 OID 17073)
-- Name: over2p5footballsupertips over2p5footballsupertips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5footballsupertips
    ADD CONSTRAINT over2p5footballsupertips_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 2897 (class 2606 OID 17069)
-- Name: over2p5goalsnow over2p5goalsnow_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5goalsnow
    ADD CONSTRAINT over2p5goalsnow_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 2901 (class 2606 OID 17077)
-- Name: over2p5orbitxch over2p5orbitxch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5orbitxch
    ADD CONSTRAINT over2p5orbitxch_pkey PRIMARY KEY (home, away, date_time);


--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE over2p5footballsupertips; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5footballsupertips FROM postgres;
GRANT ALL ON TABLE public.over2p5footballsupertips TO postgres WITH GRANT OPTION;


--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE footballsupertips_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.footballsupertips_today FROM postgres;
GRANT ALL ON TABLE public.footballsupertips_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE over2p5goalsnow; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5goalsnow FROM postgres;
GRANT ALL ON TABLE public.over2p5goalsnow TO postgres WITH GRANT OPTION;


--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE goalsnow_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.goalsnow_today FROM postgres;
GRANT ALL ON TABLE public.goalsnow_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE over2p5orbitxch; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5orbitxch FROM postgres;
GRANT ALL ON TABLE public.over2p5orbitxch TO postgres WITH GRANT OPTION;


--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE orbitxch_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.orbitxch_today FROM postgres;
GRANT ALL ON TABLE public.orbitxch_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE "TodayMatches"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodayMatches" FROM postgres;
GRANT ALL ON TABLE public."TodayMatches" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 215
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


-- Completed on 2023-09-17 01:03:47 BST

--
-- PostgreSQL database dump complete
--

