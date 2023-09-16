--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-16 04:33:43 BST

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
-- TOC entry 214 (class 1259 OID 17015)
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
-- TOC entry 218 (class 1259 OID 17082)
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
-- TOC entry 212 (class 1259 OID 17004)
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
-- TOC entry 217 (class 1259 OID 17078)
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
-- TOC entry 216 (class 1259 OID 17026)
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
-- TOC entry 219 (class 1259 OID 17086)
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
-- TOC entry 220 (class 1259 OID 17090)
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
    "BetResult" public."BetResult",
    "BetMatchTime" timestamp without time zone
);


--
-- TOC entry 221 (class 1259 OID 17110)
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
-- TOC entry 210 (class 1259 OID 16985)
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
-- TOC entry 209 (class 1259 OID 16983)
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
-- Dependencies: 209
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
-- TOC entry 213 (class 1259 OID 17013)
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
-- Dependencies: 213
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5footballsupertips_id_seq OWNED BY public.over2p5footballsupertips.id;


--
-- TOC entry 211 (class 1259 OID 17002)
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
-- Dependencies: 211
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5goalsnow_id_seq OWNED BY public.over2p5goalsnow.id;


--
-- TOC entry 215 (class 1259 OID 17024)
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
-- Dependencies: 215
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
-- Dependencies: 210
-- Data for Name: match_table_prototype; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.match_table_prototype (id, home, away, date_time, url) FROM stdin;
\.


--
-- TOC entry 3068 (class 0 OID 16493)
-- Dependencies: 207
-- Data for Name: over2p5bets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetMatchTime") FROM stdin;
18	2023-09-06 19:00:00	SonderjyskE	Vejle	2023-09-06 20:15:04.824315	Lay	Under	2.50	1.50	1.64	1	\N	\N
19	2023-09-06 19:00:00	SonderjyskE	Vejle	2023-09-06 20:38:40.392177	Back	Under	2.50	1.00	1.12	1	\N	\N
20	2023-09-08 19:45:00	Turkey	Armenia	2023-09-08 21:12:52.123619	Lay	Under	2.50	1.50	1.44	1	\N	\N
21	2023-09-08 19:45:00	Turkey	Armenia	2023-09-08 21:27:16.909669	Back	Under	2.50	1.00	1.13	1	\N	\N
22	2023-09-09 19:45:00	Romania	Israel	2023-09-09 20:00:01.58423	Lay	Under	2.50	1.50	1.71	1	\N	\N
23	2023-09-09 19:45:00	Romania	Israel	2023-09-09 21:27:19.539354	Back	Under	2.50	1.00	1.52	1	\N	\N
\.


--
-- TOC entry 3075 (class 0 OID 17015)
-- Dependencies: 214
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
\.


--
-- TOC entry 3073 (class 0 OID 17004)
-- Dependencies: 212
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
\.


--
-- TOC entry 3077 (class 0 OID 17026)
-- Dependencies: 216
-- Data for Name: over2p5orbitxch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.over2p5orbitxch (id, home, away, date_time, url, plaied) FROM stdin;
2945	SonderjyskE	AaB	2023-09-15 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217961564	t
2994	Jong PSV Eindhoven	De Graafschap	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218084970	t
3006	ASO Chlef	MC Oran	2023-09-15 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.218272136	f
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
-- Dependencies: 209
-- Name: match_table_prototype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.match_table_prototype_id_seq', 1, false);


--
-- TOC entry 3108 (class 0 OID 0)
-- Dependencies: 208
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 23, true);


--
-- TOC entry 3109 (class 0 OID 0)
-- Dependencies: 213
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 344, true);


--
-- TOC entry 3110 (class 0 OID 0)
-- Dependencies: 211
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 462, true);


--
-- TOC entry 3111 (class 0 OID 0)
-- Dependencies: 215
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 3101, true);


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
-- Dependencies: 214
-- Name: TABLE over2p5footballsupertips; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5footballsupertips FROM postgres;
GRANT ALL ON TABLE public.over2p5footballsupertips TO postgres WITH GRANT OPTION;


--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE footballsupertips_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.footballsupertips_today FROM postgres;
GRANT ALL ON TABLE public.footballsupertips_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE over2p5goalsnow; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5goalsnow FROM postgres;
GRANT ALL ON TABLE public.over2p5goalsnow TO postgres WITH GRANT OPTION;


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE goalsnow_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.goalsnow_today FROM postgres;
GRANT ALL ON TABLE public.goalsnow_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE over2p5orbitxch; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5orbitxch FROM postgres;
GRANT ALL ON TABLE public.over2p5orbitxch TO postgres WITH GRANT OPTION;


--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE orbitxch_today; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.orbitxch_today FROM postgres;
GRANT ALL ON TABLE public.orbitxch_today TO postgres WITH GRANT OPTION;


--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 220
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
-- Dependencies: 221
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
-- Dependencies: 210
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


-- Completed on 2023-09-16 04:33:43 BST

--
-- PostgreSQL database dump complete
--

