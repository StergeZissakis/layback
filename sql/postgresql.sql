--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-05 16:31:18 BST

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
-- TOC entry 3022 (class 1262 OID 13465)
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
-- TOC entry 3023 (class 0 OID 0)
-- Dependencies: 3022
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3024 (class 0 OID 0)
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
-- TOC entry 1 (class 3079 OID 16584)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3025 (class 0 OID 0)
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
-- TOC entry 640 (class 1247 OID 16396)
-- Name: MatchTime; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."MatchTime" AS ENUM (
    'Full Time',
    '1st Half',
    '2nd Half'
);


--
-- TOC entry 643 (class 1247 OID 16404)
-- Name: OverUnderType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OverUnderType" AS ENUM (
    'Over',
    'Under'
);


--
-- TOC entry 211 (class 1255 OID 16409)
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
-- TOC entry 212 (class 1255 OID 16410)
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
-- TOC entry 213 (class 1255 OID 16411)
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
-- TOC entry 214 (class 1255 OID 16412)
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
-- TOC entry 215 (class 1255 OID 16413)
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
-- TOC entry 208 (class 1259 OID 16493)
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
-- TOC entry 210 (class 1259 OID 16593)
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
   FROM (public.over2p5bets a
     FULL JOIN public.over2p5bets b ON ((((a."Home")::text = (b."Home")::text) AND ((a."Away")::text = (b."Away")::text) AND (a."LayBack" <> b."LayBack") AND (a."BetDateTime" <> b."BetDateTime") AND (b.id IS NULL))))
  WHERE (a."BetDateTime" >= '2023-08-26 00:00:00'::timestamp without time zone)
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
-- TOC entry 206 (class 1259 OID 16477)
-- Name: daily_over_2p5_historical; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_over_2p5_historical (
    id bigint,
    home character varying NOT NULL,
    away character varying NOT NULL,
    date_time timestamp without time zone NOT NULL,
    url character varying
);


--
-- TOC entry 207 (class 1259 OID 16483)
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_over_2p5_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3030 (class 0 OID 0)
-- Dependencies: 207
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_over_2p5_id_seq OWNED BY public.daily_over_2p5.id;


--
-- TOC entry 209 (class 1259 OID 16500)
-- Name: over2p5bets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5bets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3031 (class 0 OID 0)
-- Dependencies: 209
-- Name: over2p5bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5bets_id_seq OWNED BY public.over2p5bets.id;


--
-- TOC entry 2874 (class 2604 OID 16904)
-- Name: daily_over_2p5 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5 ALTER COLUMN id SET DEFAULT nextval('public.daily_over_2p5_id_seq'::regclass);


--
-- TOC entry 2876 (class 2604 OID 16906)
-- Name: over2p5bets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets ALTER COLUMN id SET DEFAULT nextval('public.over2p5bets_id_seq'::regclass);


--
-- TOC entry 3012 (class 0 OID 16471)
-- Dependencies: 205
-- Data for Name: daily_over_2p5; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.daily_over_2p5 (id, home, away, date_time, url) FROM stdin;
\.


--
-- TOC entry 3013 (class 0 OID 16477)
-- Dependencies: 206
-- Data for Name: daily_over_2p5_historical; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.daily_over_2p5_historical (id, home, away, date_time, url) FROM stdin;
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
4899	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217298311
4900	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217254229
4901	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343324
4902	Gent	Apoel Nicosia	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217298635
4903	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217480391
4904	Genk	Adana Demirspor	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297987
4905	Lille	HNK Rijeka	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297879
4906	Osasuna	Club Brugge	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217297663
4907	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217254445
4908	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217254953
4909	AZ	SK Brann	2023-08-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217299716
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	AZ	SK Brann	2023-08-24 19:45:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	Osasuna	Club Brugge	2023-08-24 19:30:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	\N
\N	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	AZ	SK Brann	2023-08-24 19:45:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	Osasuna	Club Brugge	2023-08-24 19:30:00	\N
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Shenzhen	Shandong Taishan	2023-08-25 12:35:00	\N
\N	Cambuur Leeuwarden	Ajax Reserves	2023-08-25 19:00:00	\N
\N	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	\N
4914	De Graafschap	FC Emmen	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498634
4915	FK Pribram	Dukla Praha	2023-08-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217296962
4916	FC Dordrecht	Maastricht	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339130
4917	MSV Duisburg	SSV Ulm 1846	2023-08-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368790
4918	Schalke	Holstein Kiel	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217041949
4919	Roda JC	Top Oss	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339587
4920	Henan Songshan Longmen	Shanghai Port	2023-08-25 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217303179
4921	Konyaspor	Gaziantep FK	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319409
4922	Jeonbuk Motors	Daejeon Hana Citizen	2023-08-25 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217270886
4923	Nantes	Monaco	2023-08-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217058034
4924	AC Horsens	Naestved IF	2023-08-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217443432
4925	Lechia Gdansk	Podbeskidzie Bielsko Biala	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217493623
4926	UCD	St Patricks Athletic	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192189
4927	Widzew Lodz	Slask Wroclaw	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217219179
4928	Drogheda United	Cork City	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192279
4929	Al Taawon Buraidah	Abha	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498544
4930	FC Den Bosch	ADO Den Haag	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217499620
4931	RB Leipzig	VfB Stuttgart	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215652027
4932	Suwon FC	Incheon Utd	2023-08-25 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217261077
4933	Paderborn	Kaiserslautern	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217041841
4934	Opava	Sigma Olomouc B	2023-08-25 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217271362
4935	Randers FC	Viborg	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217301071
4936	RFC Seraing	Zulte-Waregem	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450418
4937	FC U Craiova 1948	Rapid Bucuresti	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156407
4938	Azam FC	Bahir Dar Kenema FC	2023-08-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217493125
4939	FC Eindhoven	NAC	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217272289
4914	De Graafschap	FC Emmen	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498634
4916	FC Dordrecht	Maastricht	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339130
4919	Roda JC	Top Oss	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339587
4921	Konyaspor	Gaziantep FK	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319409
4923	Nantes	Monaco	2023-08-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217058034
4925	Lechia Gdansk	Podbeskidzie Bielsko Biala	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217493623
4926	UCD	St Patricks Athletic	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192189
4927	Widzew Lodz	Slask Wroclaw	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217219179
4928	Drogheda United	Cork City	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192279
4929	Al Taawon Buraidah	Abha	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498544
4930	FC Den Bosch	ADO Den Haag	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217499620
4931	RB Leipzig	VfB Stuttgart	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215652027
4936	RFC Seraing	Zulte-Waregem	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450418
4937	FC U Craiova 1948	Rapid Bucuresti	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156407
4939	FC Eindhoven	NAC	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217272289
\N	Jeonbuk Motors	Daejeon Hana Citizen	2023-08-25 11:30:00	\N
\N	Henan Songshan Longmen	Shanghai Port	2023-08-25 12:35:00	\N
\N	Suwon FC	Incheon Utd	2023-08-25 11:00:00	\N
\N	Shenzhen	Shandong Taishan	2023-08-25 12:35:00	\N
\N	Marseille	Brest	2023-08-26 16:00:00	\N
\N	Sportivo Ameliano	Guairena FC	2023-08-26 00:00:00	\N
\N	El Nacional	Cumbaya FC	2023-08-26 01:00:00	\N
\N	Sydney United 58	Brisbane Roar	2023-08-26 05:00:00	\N
\N	Once Caldas	Atletico Bucaramanga	2023-08-26 00:15:00	\N
\N	Standard Liege II	KFCO Beerschot Wilrijk	2023-08-26 15:00:00	\N
\N	Tijuana	Mazatlan FC	2023-08-26 04:10:00	\N
\N	Coventry	Sunderland	2023-08-26 15:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
4899	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217298311
4900	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217254229
4901	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343324
4902	Gent	Apoel Nicosia	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217298635
4903	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217480391
4904	Genk	Adana Demirspor	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297987
4905	Lille	HNK Rijeka	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297879
4906	Osasuna	Club Brugge	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217297663
4907	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217254445
4908	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217254953
4909	AZ	SK Brann	2023-08-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217299716
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	AZ	SK Brann	2023-08-24 19:45:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	Osasuna	Club Brugge	2023-08-24 19:30:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	\N
\N	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	AZ	SK Brann	2023-08-24 19:45:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	Osasuna	Club Brugge	2023-08-24 19:30:00	\N
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Shenzhen	Shandong Taishan	2023-08-25 12:35:00	\N
\N	Cambuur Leeuwarden	Ajax Reserves	2023-08-25 19:00:00	\N
4914	De Graafschap	FC Emmen	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498634
4915	FK Pribram	Dukla Praha	2023-08-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217296962
4916	FC Dordrecht	Maastricht	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339130
4917	MSV Duisburg	SSV Ulm 1846	2023-08-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368790
4918	Schalke	Holstein Kiel	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217041949
4919	Roda JC	Top Oss	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339587
4920	Henan Songshan Longmen	Shanghai Port	2023-08-25 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217303179
4921	Konyaspor	Gaziantep FK	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319409
4922	Jeonbuk Motors	Daejeon Hana Citizen	2023-08-25 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217270886
4923	Nantes	Monaco	2023-08-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217058034
4924	AC Horsens	Naestved IF	2023-08-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217443432
4925	Lechia Gdansk	Podbeskidzie Bielsko Biala	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217493623
4926	UCD	St Patricks Athletic	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192189
4927	Widzew Lodz	Slask Wroclaw	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217219179
4928	Drogheda United	Cork City	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192279
4929	Al Taawon Buraidah	Abha	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498544
4930	FC Den Bosch	ADO Den Haag	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217499620
4931	RB Leipzig	VfB Stuttgart	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215652027
4932	Suwon FC	Incheon Utd	2023-08-25 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217261077
4933	Paderborn	Kaiserslautern	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217041841
4934	Opava	Sigma Olomouc B	2023-08-25 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217271362
4935	Randers FC	Viborg	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217301071
4936	RFC Seraing	Zulte-Waregem	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450418
4937	FC U Craiova 1948	Rapid Bucuresti	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156407
4938	Azam FC	Bahir Dar Kenema FC	2023-08-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217493125
4939	FC Eindhoven	NAC	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217272289
4914	De Graafschap	FC Emmen	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498634
4916	FC Dordrecht	Maastricht	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339130
4919	Roda JC	Top Oss	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339587
4921	Konyaspor	Gaziantep FK	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319409
4923	Nantes	Monaco	2023-08-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217058034
4925	Lechia Gdansk	Podbeskidzie Bielsko Biala	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217493623
4926	UCD	St Patricks Athletic	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192189
4927	Widzew Lodz	Slask Wroclaw	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217219179
4928	Drogheda United	Cork City	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192279
4929	Al Taawon Buraidah	Abha	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498544
4930	FC Den Bosch	ADO Den Haag	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217499620
4931	RB Leipzig	VfB Stuttgart	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215652027
4936	RFC Seraing	Zulte-Waregem	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450418
4937	FC U Craiova 1948	Rapid Bucuresti	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156407
4939	FC Eindhoven	NAC	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217272289
\N	Jeonbuk Motors	Daejeon Hana Citizen	2023-08-25 11:30:00	\N
\N	Henan Songshan Longmen	Shanghai Port	2023-08-25 12:35:00	\N
\N	Suwon FC	Incheon Utd	2023-08-25 11:00:00	\N
\N	Shenzhen	Shandong Taishan	2023-08-25 12:35:00	\N
\N	Marseille	Brest	2023-08-26 16:00:00	\N
\N	Sportivo Ameliano	Guairena FC	2023-08-26 00:00:00	\N
\N	El Nacional	Cumbaya FC	2023-08-26 01:00:00	\N
\N	Sydney United 58	Brisbane Roar	2023-08-26 05:00:00	\N
\N	Once Caldas	Atletico Bucaramanga	2023-08-26 00:15:00	\N
\N	Standard Liege II	KFCO Beerschot Wilrijk	2023-08-26 15:00:00	\N
\N	Tijuana	Mazatlan FC	2023-08-26 04:10:00	\N
\N	Coventry	Sunderland	2023-08-26 15:00:00	\N
\N	Columbus Crew	Toronto FC	2023-08-27 00:30:00	\N
\N	Real Salt Lake	Houston Dynamo	2023-08-27 02:30:00	\N
\N	Deportivo Binacional	Cusco FC	2023-08-27 00:00:00	\N
\N	FC Cincinnati	New York City FC	2023-08-27 00:30:00	\N
\N	Orlando City SC	St. Louis City SC	2023-08-27 00:30:00	\N
\N	Charlotte FC	Los Angeles FC	2023-08-27 00:30:00	\N
\N	Club America	Leon	2023-08-27 02:00:00	\N
\N	Atlanta United	Nashville SC	2023-08-27 00:30:00	\N
\N	CF Montreal	New England Revolution	2023-08-27 00:30:00	\N
\N	Sporting Kansas City	San Jose Earthquakes	2023-08-27 01:30:00	\N
\N	LA Galaxy	Chicago Fire	2023-08-27 03:30:00	\N
\N	FC Dallas	Austin FC	2023-08-27 01:30:00	\N
\N	DC United	Philadelphia Union	2023-08-27 00:30:00	\N
\N	New York Red Bulls	Inter Miami CF	2023-08-27 00:30:00	\N
\N	Santos Laguna	Chivas Guadalajara	2023-08-27 04:05:00	\N
\N	Portland Timbers	Vancouver Whitecaps	2023-08-27 03:30:00	\N
\N	Melbourne City	Wellington Phoenix	2023-08-27 05:00:00	\N
\N	CA Tigre	Racing Club	2023-08-27 01:30:00	\N
\N	AD San Carlos	Deportivo Saprissa	2023-08-27 02:00:00	\N
\N	Viktoria Zizkov	FC Sellier & Bellot Vlasim	2023-08-27 09:15:00	\N
\N	Magallanes	Colo Colo	2023-08-27 17:30:00	\N
5077	Sportivo Luqueno	Olimpia Asuncion	2023-08-27 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217561166
5097	Sporting	Famalicao	2023-08-27 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473430
5115	Minnesota United	Seattle Sounders FC	2023-08-27 21:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217349870
5139	Dinamo Zagreb	HNK Rijeka	2023-08-27 20:05:00	https://www.orbitxch.com/customer/sport/1/market/1.217194368
\N	Oldham	Solihull Moors	2023-08-28 15:00:00	\N
\N	Nacional	Leixoes	2023-08-28 18:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	Adana Demirspor	Besiktas	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Oxford City	Boreham Wood	2023-08-28 15:00:00	\N
\N	UTA Arad	FCSB	2023-08-28 19:30:00	\N
\N	Woking	Dorking	2023-08-28 15:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	\N
\N	Annecy	St Etienne	2023-08-28 19:45:00	\N
\N	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	\N
\N	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	\N
\N	Sirius	Malmo FF	2023-08-28 18:10:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	\N
\N	Chesterfield	Hartlepool	2023-08-28 15:00:00	\N
\N	Moss	Kristiansund BK	2023-08-28 18:00:00	\N
\N	Hobro IK	Sonderjyske	2023-08-28 17:30:00	\N
\N	Bromley	Southend	2023-08-28 15:00:00	\N
\N	Vejle	Brondby	2023-08-28 18:00:00	\N
\N	Wealdstone	Dag & Red	2023-08-28 15:00:00	\N
\N	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	\N
\N	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	\N
\N	UTA Arad	FCSB	2023-08-28 19:30:00	\N
\N	Oldham	Solihull Moors	2023-08-28 15:00:00	\N
\N	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Oxford City	Boreham Wood	2023-08-28 15:00:00	\N
\N	Adana Demirspor	Besiktas	2023-08-28 19:00:00	\N
\N	Woking	Dorking	2023-08-28 15:00:00	\N
\N	Annecy	St Etienne	2023-08-28 19:45:00	\N
\N	Moss	Kristiansund BK	2023-08-28 18:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Nacional	Leixoes	2023-08-28 18:00:00	\N
\N	Hobro IK	Sonderjyske	2023-08-28 17:30:00	\N
\N	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Sirius	Malmo FF	2023-08-28 18:10:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	Chesterfield	Hartlepool	2023-08-28 15:00:00	\N
\N	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	\N
\N	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	\N
\N	Bromley	Southend	2023-08-28 15:00:00	\N
\N	Vejle	Brondby	2023-08-28 18:00:00	\N
\N	Wealdstone	Dag & Red	2023-08-28 15:00:00	\N
\N	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	\N
5146	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217602255
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
5147	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5148	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5149	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5150	GAIS	Skövde AIK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5151	Al Raed	Al Riyadh	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
5152	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5153	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5154	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5155	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5156	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5157	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5158	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5159	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5160	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5161	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5162	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5163	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5164	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5165	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5166	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5167	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5168	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5169	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5170	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5171	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5172	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5173	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5174	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5175	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5176	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5177	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5178	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5179	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5180	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5181	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5182	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5183	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5184	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5185	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5186	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5187	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5188	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
5189	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5190	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5191	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5192	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5193	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5194	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5195	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5196	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5197	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5198	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5199	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5200	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5201	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5202	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5203	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5204	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5205	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5206	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5207	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5208	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5209	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5210	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
5211	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5212	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5213	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5214	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5215	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5216	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5217	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5218	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5219	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5220	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5221	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5222	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5223	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5224	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5225	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5226	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5227	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5228	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217647501
5229	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5230	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5231	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5232	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5233	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5234	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5235	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5236	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5237	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5238	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5239	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5240	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5241	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5242	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5243	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
5244	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5245	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5246	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5247	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5248	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5249	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5250	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5251	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5252	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5253	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5254	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5255	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5256	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5257	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5258	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5259	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5260	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5261	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5262	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5263	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5264	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5265	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5266	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5267	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5268	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5269	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5270	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5271	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5272	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5273	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5274	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5275	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5276	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5277	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5278	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5279	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5280	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5281	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5282	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5283	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5284	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5285	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5286	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5287	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5288	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5289	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5290	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5291	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5292	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5293	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5294	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5295	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5296	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5297	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5298	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5299	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5300	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5301	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5302	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5303	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5304	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5305	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5306	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5307	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5308	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5309	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5310	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5311	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5312	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5313	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5314	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5315	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5316	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5317	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5318	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5319	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5320	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5321	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5322	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5323	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5324	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5325	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5326	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5327	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5328	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5329	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5330	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5331	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5332	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5333	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5334	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5335	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217647501
5336	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5337	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5338	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5339	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5340	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5341	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5342	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5343	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5344	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5345	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5346	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5347	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5348	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5349	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5350	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5351	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5352	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5353	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5354	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5355	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5356	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5357	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5358	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5359	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5360	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5361	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5362	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5363	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5364	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5365	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5366	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5367	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5368	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5369	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5370	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5371	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5372	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5373	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5374	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5375	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5376	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5377	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
5378	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5379	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5380	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5381	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5382	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5383	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5384	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5385	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5386	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5387	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5388	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5389	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5390	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5391	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5392	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5393	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5394	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5395	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5396	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5397	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5398	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5399	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5400	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5401	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5402	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5403	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5404	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5405	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5406	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5407	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5408	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5409	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5410	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5411	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5412	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5413	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5414	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5415	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5416	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5417	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5418	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5419	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217647501
5420	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5421	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5422	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5423	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5424	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5425	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5426	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5427	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5428	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5429	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5430	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5431	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5432	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5433	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5434	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5435	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5436	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5437	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5438	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5439	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5440	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5441	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5442	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5443	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5444	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5445	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5446	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5447	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5448	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5449	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5450	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5451	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5452	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5453	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5454	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5455	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5456	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5457	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5458	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5459	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5460	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5461	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5462	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
5463	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5464	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5465	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5466	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5467	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5468	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5469	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5470	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5471	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5472	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5473	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5474	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5475	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5476	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5477	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5478	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5479	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5480	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5481	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5482	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5483	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
5484	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5485	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5486	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5487	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5488	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5489	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5490	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5491	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5492	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5493	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5494	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5495	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5496	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5497	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5498	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5499	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5500	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5501	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5502	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5503	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5504	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
5505	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5506	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5507	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5508	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5509	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5510	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5511	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5512	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5513	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5514	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5515	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5516	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5517	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5518	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5519	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5520	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5521	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5522	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5523	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5524	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5525	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5526	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5527	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5528	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5529	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5530	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5531	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5532	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5533	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5534	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5535	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5536	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5537	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5538	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5539	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5540	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5541	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5542	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5543	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5544	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5545	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5546	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5547	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5548	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5549	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5550	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5551	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5552	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5553	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5554	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5555	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5556	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5557	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5558	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5559	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5560	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5561	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5562	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5563	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5564	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5565	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5566	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5567	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5568	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5569	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5570	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
5571	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5572	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5573	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5574	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5575	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5576	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5577	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5578	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5579	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5580	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5581	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5582	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5583	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5584	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5585	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5586	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5587	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5588	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5589	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5590	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5591	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5592	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5593	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5594	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5595	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5596	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5597	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5598	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5599	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5600	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5601	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5602	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5603	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5604	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5605	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5606	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5607	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5608	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5609	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
5610	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5611	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5612	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5613	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5614	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5615	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5616	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5617	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5618	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5619	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5620	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5621	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5622	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5623	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5624	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5625	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5626	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5627	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5628	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5629	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5630	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5631	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5632	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5633	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5634	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5635	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5636	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5637	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5638	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5639	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5640	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5641	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5642	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5643	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5644	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5645	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5646	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5647	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5648	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5649	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5650	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5651	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5652	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5653	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5654	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5655	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5656	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5657	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5658	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5659	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5660	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5661	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5662	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5663	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5664	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5665	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5666	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5667	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5668	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5669	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5670	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5671	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5672	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5673	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5674	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5675	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5676	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5677	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5678	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5679	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5680	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5681	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5682	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5683	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5684	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5685	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5686	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5687	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5688	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5689	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5690	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5691	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5692	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5693	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5694	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5695	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5696	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5697	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5698	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5699	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5700	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5701	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5702	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5703	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5704	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5705	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5706	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5707	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5708	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5709	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5710	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5711	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5712	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5713	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5714	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5715	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5716	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5717	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5718	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5719	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5720	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5721	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5722	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5723	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5724	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5725	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5726	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5727	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5728	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5729	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5730	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5731	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5732	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5733	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5734	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5735	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
5736	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5737	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5738	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5739	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5740	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5741	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5742	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5743	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5744	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5745	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5746	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5747	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5748	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5749	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5750	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5751	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5752	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5753	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5754	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5755	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5756	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
5757	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5758	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5759	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5760	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5761	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5762	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5763	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5764	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5765	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5766	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5767	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5768	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5769	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5770	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5771	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5772	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5773	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5774	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5775	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5776	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5777	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5778	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5779	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5780	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5781	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5782	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5783	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5784	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5785	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5786	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5787	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5788	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5789	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5790	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5791	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5792	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5793	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5794	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5795	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
5796	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5797	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5798	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
5799	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5800	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5801	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5802	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5803	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5804	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5805	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5806	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5807	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5808	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5809	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5810	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5811	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5812	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5813	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5814	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5815	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5816	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5817	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5818	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5819	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5820	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5821	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5822	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5823	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5824	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5825	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5826	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5827	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5828	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5829	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5830	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5831	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5832	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5833	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5834	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5835	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5836	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5837	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5838	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5839	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5840	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5841	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5842	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5843	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5844	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
5845	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5846	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5847	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5848	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5849	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5850	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5851	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5852	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5853	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5854	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5855	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5856	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5857	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5858	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5859	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5860	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5861	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5862	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5863	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5864	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5865	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5866	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5867	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5868	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5869	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5870	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5871	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5872	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5873	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5874	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5875	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5876	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5877	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5878	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5879	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5880	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5881	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
5882	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5883	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5884	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5885	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5886	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
5887	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5888	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5889	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5890	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5891	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5892	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5893	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5894	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5895	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5896	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5897	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5898	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5899	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5900	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5901	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5902	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5903	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5904	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5905	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5906	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5907	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5908	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5909	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5910	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5911	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5912	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5913	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5914	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5915	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5916	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5917	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5918	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5919	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5920	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5921	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5922	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5923	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5924	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5925	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5926	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5927	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5928	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5929	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5930	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5931	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5932	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5933	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5934	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5935	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5936	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5937	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5938	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5939	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5940	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5941	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5942	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5943	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5944	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5945	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5946	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5947	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5948	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5949	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5950	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5951	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5952	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5953	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5954	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5955	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5956	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5957	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5958	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5959	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5960	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5961	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5962	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5963	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
5964	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5965	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
5966	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5967	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5968	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5969	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
5970	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
5971	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5972	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5973	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5974	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5975	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
5976	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5977	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
5978	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
5979	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
5980	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5981	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
5982	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
5983	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
5984	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5985	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5986	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
5987	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
5988	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
5989	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
5990	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
5991	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
5992	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
5993	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
5994	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
5995	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
5996	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
5997	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
5998	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
5999	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6000	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6001	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6002	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6003	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6004	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6005	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6006	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6007	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
6008	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Moss	Kristiansund BK	2023-08-28 18:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
6009	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6010	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6011	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6012	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6013	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6014	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6015	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6016	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6017	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6018	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6019	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6020	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6021	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6022	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6023	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6024	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6025	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
6026	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6027	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
6028	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6029	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6030	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6031	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
6032	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
6033	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6034	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6035	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6036	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6037	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6038	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6039	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6040	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6041	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6042	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6043	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6044	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6045	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6046	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6047	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6048	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
6049	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6050	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6051	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6052	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6053	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6054	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6055	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6056	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6057	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6058	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6059	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6060	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6061	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6062	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6063	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6064	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6065	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6066	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6067	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
6068	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6069	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
6070	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6071	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6072	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6073	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6074	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
6075	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
6076	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6077	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6078	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6079	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6080	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6081	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6082	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6083	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6084	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6085	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6086	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6087	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6088	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217647501
6089	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6090	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
6091	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6092	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6093	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6094	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399533
6095	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
6096	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6097	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6098	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6099	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6100	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6101	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6102	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6103	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6104	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6105	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6106	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6107	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6108	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6109	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6110	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6111	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217647501
6112	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6113	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6114	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6115	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6116	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
6117	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6118	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6119	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6120	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6121	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6122	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6123	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6124	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6125	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6126	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6127	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6128	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6129	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6130	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6131	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6132	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
6133	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6134	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6135	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6136	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
6137	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6138	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6139	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6140	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6141	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6142	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6143	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6144	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6145	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6146	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6147	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6148	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6149	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6150	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6151	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6152	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6153	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
6154	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6155	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6156	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6157	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6158	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
6159	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6160	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6161	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6162	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6163	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6164	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6165	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6166	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6167	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6168	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6169	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6170	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6171	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6172	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6173	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6174	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
6175	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6176	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6177	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6178	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6179	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
6180	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6181	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6182	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6183	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6184	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6185	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6186	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6187	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6188	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6189	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6190	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6191	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6192	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6193	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6194	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6195	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
6196	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6197	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6198	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6199	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6200	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6201	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6202	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6203	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6204	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6205	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6206	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6207	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6208	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6209	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6210	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6211	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6212	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6213	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6214	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
6215	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6216	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
6217	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6218	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6219	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6220	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6221	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6222	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6223	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6224	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6225	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6226	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6227	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6228	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6229	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6230	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6231	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6232	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6233	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6234	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6235	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
6236	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6237	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
6238	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
6239	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6240	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6241	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6242	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6243	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6244	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6245	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6246	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6247	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6248	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6249	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6250	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6251	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6252	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6253	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6254	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6255	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6256	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
6257	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6258	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
6259	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6260	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6261	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6262	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217186831
6263	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6264	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6265	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6266	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6267	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6268	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6269	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6270	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6271	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6272	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6273	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6274	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6275	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6276	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6277	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6278	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6279	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
6280	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
6281	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6282	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6283	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6284	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6285	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6286	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6287	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6288	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6289	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6290	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6291	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6292	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6293	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6294	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6295	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6296	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6297	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6298	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505202
6299	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6300	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
6301	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
6302	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6303	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6304	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6305	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6306	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6307	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6308	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6309	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6310	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6311	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6312	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6313	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6314	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6315	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6316	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6317	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6318	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6319	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
6320	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6321	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
6322	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6323	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6324	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6325	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6326	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6327	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6328	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6329	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6330	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6331	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6332	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6333	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6334	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6335	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6336	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6337	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6338	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6339	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6340	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486845
6341	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6342	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
6343	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6344	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6345	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6346	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6347	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6348	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6349	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6350	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6351	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6352	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6353	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6354	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6355	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6356	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6357	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6358	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6359	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6360	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6361	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6362	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6363	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
6364	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
6365	Nacional	Leixoes	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217378921
6366	Adana Demirspor	Besiktas	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321219
6367	GIF Sundsvall	Jonkopings Sodra	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217187191
6368	Hobro IK	Sonderjyske	2023-08-28 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217441560
6369	Vejle	Brondby	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217287404
6370	Bromley	Southend	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431622
6371	Annecy	St Etienne	2023-08-28 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217372122
6372	AFC Fylde	Altrincham	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217429839
6373	Beitar Jerusalem	Hapoel Haifa	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317448
6374	Moss	Kristiansund BK	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217358365
6375	Woking	Dorking	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432502
6376	Wealdstone	Dag & Red	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217457067
6377	Elfsborg	IFK Norrkoping	2023-08-28 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217180983
6378	Chesterfield	Hartlepool	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217431441
6379	Oldham	Solihull Moors	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432726
6380	Sirius	Malmo FF	2023-08-28 18:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217180785
6381	PSV Reserves	Helmond Sport	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217399443
6382	Oxford City	Boreham Wood	2023-08-28 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217432636
6383	Giresunspor	Bandirmaspor	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217405590
6384	Al Hilal Riyadh	Al Ittifaq Dammam	2023-08-28 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486725
6385	UTA Arad	FCSB	2023-08-28 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156908
\N	AZ Reserves	Telstar	2023-08-28 19:00:00	\N
\N	GAIS	Skövde AIK	2023-08-28 18:00:00	\N
\N	Al Wahda Mecca	Al Ittihad Jeddah	2023-08-28 19:00:00	\N
\N	Al Raed	Al Riyadh	2023-08-28 19:00:00	\N
\N	Herediano	Alajuelense	2023-08-28 01:00:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
6407	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6408	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6409	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6410	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6411	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6412	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6413	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6414	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6415	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6416	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6417	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6418	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6419	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6420	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6421	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6422	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6423	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6424	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6425	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6426	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6427	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6428	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6429	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6430	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6431	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6432	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6433	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6434	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6435	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6436	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6437	Pachuca	Atletico San Luis	2023-08-29 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217346920
6438	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6439	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6440	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6441	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6442	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6443	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6444	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6445	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6446	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6447	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6448	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6449	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6450	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6451	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6452	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6453	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6454	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6455	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6456	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6457	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6458	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6459	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
6460	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6461	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6462	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6463	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6464	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6465	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6466	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6467	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6468	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6469	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6470	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6471	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6472	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6473	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6474	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6475	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
6476	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6477	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6478	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6479	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6480	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6481	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6482	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6483	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6484	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6485	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6486	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6487	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6488	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6489	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6490	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6491	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6492	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6493	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505311
6494	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6495	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6496	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6497	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6498	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6499	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6500	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6501	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6502	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6503	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6504	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6505	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6506	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6507	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6508	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6509	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6510	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6511	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6512	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6513	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6514	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6515	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6516	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6517	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6518	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6519	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6520	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6521	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6522	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6523	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6524	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6525	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6526	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6527	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
6528	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6529	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6530	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6531	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6532	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6533	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6534	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6535	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6536	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6537	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6538	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6539	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6540	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6541	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6542	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6543	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6544	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6545	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6546	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6547	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6548	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6549	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6550	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6551	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6552	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6553	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6554	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6555	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6556	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6557	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6558	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6559	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6560	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6561	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6562	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6563	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6564	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6565	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6566	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6567	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6568	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6569	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6570	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6571	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6572	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6573	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6574	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6575	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6576	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6577	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6578	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6579	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6580	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6581	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6582	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6583	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6584	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6585	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6586	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6587	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6588	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6589	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6590	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6591	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6592	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6593	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6594	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6595	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6596	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6597	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6598	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6599	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6600	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6601	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6602	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6603	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6604	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6605	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6606	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6607	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6608	Pachuca	Atletico San Luis	2023-08-29 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217346920
6609	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6610	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6611	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6612	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6613	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6614	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6615	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6616	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6617	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6618	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6619	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6620	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6621	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6622	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6623	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6624	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6625	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6626	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6627	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6628	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6629	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6630	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6631	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6632	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6633	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6634	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6635	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6636	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6637	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6638	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6639	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6640	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6641	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6642	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6643	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6644	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6645	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505311
6646	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6647	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6648	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6649	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6650	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6651	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6652	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6653	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6654	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6655	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6656	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6657	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6658	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6659	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6660	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6661	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6662	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
6663	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6664	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6665	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6666	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6667	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6668	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217663912
6669	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6670	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6671	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6672	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6673	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6674	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6675	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6676	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6677	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6678	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6679	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6680	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
6681	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6682	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6683	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6684	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6685	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6686	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6687	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6688	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6689	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6690	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505311
6691	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6692	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6693	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6694	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6695	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217663912
6696	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6697	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6698	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6699	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6700	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6701	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6702	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6703	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6704	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6705	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217663912
6706	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6707	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6708	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6709	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6710	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6711	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6712	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6713	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6714	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6715	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6716	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6717	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6718	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6719	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6720	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6721	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6722	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6723	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6724	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217663912
6725	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6726	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6727	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6728	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6729	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6730	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6731	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6732	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6733	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6734	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6735	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6736	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6737	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6738	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6739	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6740	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6741	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6742	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6743	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6744	Pachuca	Atletico San Luis	2023-08-29 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217346920
6745	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6746	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6747	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6748	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6749	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6750	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6751	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6752	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6753	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6754	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6755	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6756	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6757	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6758	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6759	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6760	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6761	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6762	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6763	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6764	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6765	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
6766	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6767	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505311
6768	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6769	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6770	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6771	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6772	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6773	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6774	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6775	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6776	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6777	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6778	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6779	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6780	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6781	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6782	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6783	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6784	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6785	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6786	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6787	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6788	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6789	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6790	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6791	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6792	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6793	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6794	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6795	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6796	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6797	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6798	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6799	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6800	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6801	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6802	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6803	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6804	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6805	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6806	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6807	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6808	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6809	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6810	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6811	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6812	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6813	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6814	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6815	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
6816	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6817	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6818	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6819	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6820	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6821	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6822	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6823	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6824	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6825	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6826	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6827	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6828	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6829	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6830	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6831	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6832	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6833	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6834	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6835	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6836	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6837	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6838	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6839	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6840	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6841	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6842	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6843	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6844	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6845	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6846	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6847	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6848	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6849	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6850	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6851	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6852	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6853	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6854	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6855	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6856	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6857	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6858	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6859	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6860	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6861	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6862	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6863	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6864	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6865	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6866	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6867	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6868	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6869	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6870	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6871	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6872	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6873	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6874	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6875	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217663912
6876	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6877	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6878	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6879	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6880	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6881	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6882	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6883	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6884	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6885	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6886	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6887	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6888	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6889	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6890	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6891	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6892	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6893	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6894	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6895	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6896	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6897	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6898	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6899	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6900	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6901	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6902	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6903	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6904	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6905	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6906	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6907	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6908	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6909	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6910	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6911	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6912	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6913	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6914	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6915	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6916	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6917	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
6918	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6919	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6920	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6921	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6922	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6923	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6924	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6925	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6926	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217663912
6927	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6928	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6929	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6930	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6931	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6932	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6933	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6934	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6935	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6936	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
6937	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6938	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6939	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6940	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6941	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6942	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6943	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217663912
6944	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6945	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6946	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6947	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6948	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6949	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
6950	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6951	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6952	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6953	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
6954	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6955	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6956	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6957	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6958	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6959	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
6960	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6961	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6962	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6963	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6964	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6965	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6966	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6967	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6968	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
6969	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6970	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6971	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6972	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6973	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6974	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6975	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6976	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6977	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6978	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6979	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6980	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6981	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6982	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
6983	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
6984	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
6985	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
6986	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
6987	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
6988	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
6989	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
6990	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
6991	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
6992	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
6993	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
6994	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
6995	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
6996	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
6997	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
6998	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
6999	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7000	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7001	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7002	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7003	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7004	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7005	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7006	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7007	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7008	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7009	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7010	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7011	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7012	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7013	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7014	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7015	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7016	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7017	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7018	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7019	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7020	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7021	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7022	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7023	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7024	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7025	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7026	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7027	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7028	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7029	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7030	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7031	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7032	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7033	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7034	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7035	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7036	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7037	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7038	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7039	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7040	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7041	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7042	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7043	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7044	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7045	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7046	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7047	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7048	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7049	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7050	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7051	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7052	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7053	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7054	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7055	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7056	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7057	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7058	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7059	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7060	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7061	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7062	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7063	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7064	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7065	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7066	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7067	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7068	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7069	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7070	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7071	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7072	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7073	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7074	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7075	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7076	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7077	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7078	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7079	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7080	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7081	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7082	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7083	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7084	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7085	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7086	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7087	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7088	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7089	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7090	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7091	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7092	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7093	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7094	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7095	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7096	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7097	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7098	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7099	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7100	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7101	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7102	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7103	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7104	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7105	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7106	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7107	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7108	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
7109	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7110	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7111	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7112	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7113	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7114	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7115	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7116	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7117	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7118	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7119	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7120	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7121	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7122	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7123	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7124	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7125	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7126	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7127	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7128	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7129	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7130	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7131	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7132	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7133	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7134	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7135	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7136	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7137	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7138	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7139	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7140	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7141	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
7142	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7143	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7144	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7145	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7146	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7147	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7148	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7149	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7150	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7151	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7152	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7153	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7154	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7155	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7157	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7158	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7159	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7160	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7161	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7162	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7163	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7164	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7165	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7166	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7167	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7168	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7169	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7170	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7171	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7172	Pachuca	Atletico San Luis	2023-08-29 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217346920
7173	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7174	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7175	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
7176	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
7177	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7178	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7179	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7180	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7181	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7182	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7183	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7184	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7185	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7186	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7187	Pachuca	Atletico San Luis	2023-08-29 04:10:00	https://www.orbitxch.com/customer/sport/1/market/1.217346920
7188	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7189	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7190	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
7191	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7192	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7193	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7194	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7195	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7196	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7197	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7198	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7199	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7200	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7201	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7202	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7203	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7204	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7205	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7206	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7207	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7208	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7209	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7210	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7211	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
7212	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7213	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7214	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7215	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7216	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7217	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7218	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7219	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7220	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7221	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7222	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7223	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7224	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7225	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7226	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7227	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7228	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
7229	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7230	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7231	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7232	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7233	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7234	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7235	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7236	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7237	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7238	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7239	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7240	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7241	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7242	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7243	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7244	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7245	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7246	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7247	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7248	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7249	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7250	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7251	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7252	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7253	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7254	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7255	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7256	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7257	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7258	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7259	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7260	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7261	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7262	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
7263	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7264	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7265	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7266	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7267	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7268	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7269	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7270	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7271	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7272	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7273	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7274	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7275	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7276	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7277	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7278	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7279	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7280	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7281	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7282	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7283	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7284	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7285	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7286	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7287	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7288	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7289	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7290	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7291	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7292	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7293	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7294	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7295	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7296	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7297	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7298	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7299	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7300	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7301	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7302	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7303	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7304	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7305	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7306	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7307	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7308	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7309	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7310	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7311	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7312	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7313	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7314	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7315	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7316	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7317	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7318	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7319	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7320	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7321	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7322	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7323	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7324	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7325	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7326	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7327	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7328	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7329	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505311
7330	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7331	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7332	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7333	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7334	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7335	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7336	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7337	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7338	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7339	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7340	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7341	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7342	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476094
7343	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7344	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7345	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7346	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7347	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7348	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217505311
7349	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7350	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7351	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7352	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7353	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7354	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7355	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7356	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7357	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7358	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7359	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7360	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7361	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7362	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7363	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7364	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7365	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7366	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7367	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7368	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7369	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7370	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7371	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7372	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7373	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7374	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7375	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7376	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7377	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7378	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7379	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7380	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7381	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
7382	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217487085
7383	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7384	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7385	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7386	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7387	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7388	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7389	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7390	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7391	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7392	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7393	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7394	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7395	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
7396	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7397	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7398	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
7399	Wycombe	Sutton Utd	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259294
7400	Helsingborg	Landskrona	2023-08-29 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217439099
7401	Exeter	Stevenage	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256680
7402	Tranmere	Leicester	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217259618
7403	JJK	JaPS	2023-08-29 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217444585
7404	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217672437
7405	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217490447
7406	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217504986
7407	Birmingham	Cardiff	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256896
7408	Newport County	Brentford	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256356
7409	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217476520
7410	Salford City	Leeds	2023-08-29 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217260195
7411	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217294829
7412	Fulham	Tottenham	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256572
7413	Port Vale	Crewe	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217256140
7414	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217486965
7415	Sheff Wed	Mansfield	2023-08-29 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217255908
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	Everton de Vina	Cobresal	2023-08-29 00:00:00	\N
\N	Wycombe	Sutton Utd	2023-08-29 19:45:00	\N
\N	Newport County	Brentford	2023-08-29 19:45:00	\N
\N	JJK	JaPS	2023-08-29 16:30:00	\N
\N	Western Sydney Wanderers	Adelaide United	2023-08-29 10:30:00	\N
\N	Busan I Park	Gimcheon Sangmu FC	2023-08-29 11:30:00	\N
\N	Port Vale	Crewe	2023-08-29 19:45:00	\N
\N	Sokol Nespeky	Vysocina Jihlava	2023-08-29 16:30:00	\N
\N	Sheff Wed	Mansfield	2023-08-29 19:45:00	\N
\N	Pachuca	Atletico San Luis	2023-08-29 04:10:00	\N
\N	Swansea	Bournemouth	2023-08-29 19:45:00	\N
\N	FC Zlinsko	MFK Vyskov	2023-08-29 16:30:00	\N
\N	SK Petrin Plzen	Viktoria Marianske Lazne	2023-08-29 16:00:00	\N
\N	Salford City	Leeds	2023-08-29 20:00:00	\N
\N	Metrostars	Inter Lions	2023-08-29 10:30:00	\N
\N	Tranmere	Leicester	2023-08-29 19:45:00	\N
\N	Melbourne Knights	Campbelltown City	2023-08-29 10:30:00	\N
\N	Helsingborg	Landskrona	2023-08-29 18:00:00	\N
\N	Fulham	Tottenham	2023-08-29 19:45:00	\N
\N	Young Boys	Maccabi Haifa	2023-08-29 20:00:00	\N
\N	Al Akhdoud	Al Taawon Buraidah	2023-08-29 16:00:00	\N
\N	Birmingham	Cardiff	2023-08-29 19:45:00	\N
\N	Exeter	Stevenage	2023-08-29 19:45:00	\N
\N	Al Ahli Jeddah	Al Taee	2023-08-29 19:00:00	\N
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7434	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7435	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7436	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7437	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7438	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7439	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7440	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7441	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7442	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7443	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7444	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7445	FC Vsetin	FC Brno	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7446	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7447	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7448	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7449	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7450	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7451	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7452	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7453	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7454	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7455	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7456	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7457	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7458	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7459	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7460	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7461	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7462	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7463	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7464	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7465	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7466	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7467	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7468	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7469	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
7470	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7471	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7472	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7473	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7474	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7475	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7476	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7477	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7478	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7479	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7480	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7481	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7482	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7483	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7484	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7485	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7486	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7487	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7488	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7489	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7490	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7491	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7492	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7493	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7494	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7495	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7496	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7497	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7498	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7499	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7500	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7501	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7502	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7503	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7504	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7505	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7506	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7507	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7508	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7509	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7510	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7511	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7512	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7513	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7514	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7515	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7516	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7517	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7518	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7519	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7520	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7521	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7522	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7523	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
\N	Harrogate Town	Blackburn	2023-08-30 19:45:00	\N
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7524	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7525	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7526	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7527	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7528	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7529	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7530	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7531	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7532	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7533	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7534	FC Vsetin	FC Brno	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7535	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7536	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7537	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7538	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7539	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7540	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7541	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7542	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7543	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7544	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7545	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7546	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7547	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7548	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7549	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7550	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7551	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7552	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7553	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7554	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7555	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7556	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7557	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7558	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7559	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7560	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7561	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7562	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7563	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7564	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7565	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7566	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7567	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7568	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7569	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7570	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7571	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7572	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7573	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7574	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7575	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7576	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7577	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7578	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7579	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7580	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7581	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7582	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7583	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7584	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7585	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7586	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7587	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7588	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7589	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7590	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7591	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7592	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7593	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7594	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7595	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7596	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7597	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7598	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7599	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7600	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7601	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7602	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7603	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7604	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7605	FC Vsetin	FC Brno	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7606	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7607	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7608	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7609	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7610	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7611	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7612	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7613	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7614	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7615	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7616	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7617	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7618	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7619	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7620	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7621	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7622	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7623	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7624	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7625	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7626	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7627	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7628	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7629	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7630	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7631	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7632	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7633	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7634	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217713454
7635	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7636	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7637	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7638	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7639	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7640	FC Vsetin	FC Brno	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7641	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7642	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7643	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7644	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7645	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7646	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7647	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7648	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7649	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7650	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7651	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7652	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7653	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7654	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7655	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7656	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7657	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7658	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7659	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7660	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7661	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7662	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7663	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7664	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7665	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7666	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7667	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7668	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7669	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7670	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
7671	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7672	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7673	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7674	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7675	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7676	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7677	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7678	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7679	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7680	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7681	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7682	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7683	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7684	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7685	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7686	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7687	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7688	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7689	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7690	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7691	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7692	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7693	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7694	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7695	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7696	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7697	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7698	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7699	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7700	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7701	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7702	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7703	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7704	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7705	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7706	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7707	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7708	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7709	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7710	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7711	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7712	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7713	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7714	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7715	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7716	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7717	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
7718	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
7719	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7720	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7721	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7722	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7723	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7724	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7725	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7726	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7727	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7728	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7729	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7730	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7731	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7732	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7733	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7734	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7735	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7736	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7737	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7738	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7739	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7740	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7741	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7742	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7743	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7744	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7745	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7746	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7747	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7748	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7749	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7750	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7751	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7752	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7753	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7754	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7755	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7756	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7757	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7758	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7759	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7760	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7761	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7762	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7763	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7764	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7765	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7766	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7767	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7768	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7769	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7770	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7771	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7772	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7773	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7774	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7775	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7776	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7777	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7778	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7779	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7780	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7781	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7782	FC Vsetin	FC Brno	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7783	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7784	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7785	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7786	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7787	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7788	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7789	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7790	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7791	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7792	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7793	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7794	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7795	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7796	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7797	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7798	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7799	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7800	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7801	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7802	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7803	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7804	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7805	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7806	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7807	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7808	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7809	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7810	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7811	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7812	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7813	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7814	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7815	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7816	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7817	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7818	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7819	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7820	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7821	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
7822	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7823	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7824	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7825	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7826	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7827	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7828	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7829	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7830	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7831	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7832	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7833	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7834	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7835	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7836	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7837	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7838	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7839	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7840	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7841	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7842	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7843	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7844	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7845	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7846	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7847	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7848	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7849	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7850	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7851	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7852	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7853	FC Vsetin	FC Brno	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7854	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7855	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7856	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7857	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7858	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7859	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7860	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7861	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7862	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7863	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7864	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7865	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7866	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7867	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7868	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7869	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7870	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7871	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7872	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7873	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7874	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7875	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7876	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7877	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7878	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7879	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7880	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7881	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7882	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7883	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7884	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7885	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7886	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7887	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7888	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7889	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7890	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7891	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7892	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7893	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7894	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
\N	Harrogate Town	Blackburn	2023-08-30 19:45:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7895	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7896	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7897	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7898	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7899	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7900	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7901	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7902	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7903	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7904	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7905	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7906	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7907	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7908	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7909	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7910	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7911	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7912	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7913	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7914	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7915	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7916	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7917	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7918	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7919	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7920	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7921	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7922	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7923	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7924	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7925	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7926	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7927	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7928	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7929	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7930	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7931	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7932	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7933	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7934	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7935	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7936	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7937	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7938	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7939	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7940	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7941	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7942	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7943	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7944	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7945	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7946	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
7947	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7948	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7949	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7950	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7951	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7952	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7953	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7954	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7955	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7956	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7957	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7958	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7959	FC Vsetin	FC Brno	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
7960	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7961	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7962	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
7963	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7964	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7965	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
7966	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
7967	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7968	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
7969	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7970	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7971	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7972	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7973	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7974	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7975	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7976	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7977	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
7978	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7979	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7980	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7981	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
7982	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7983	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
7984	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
7985	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
7986	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
7987	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
7988	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
7989	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
7990	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
7991	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
7992	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
7993	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710678
7994	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
7995	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
7996	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
7997	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
7998	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
7999	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8000	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
8001	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8002	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8003	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8004	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8005	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8006	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8007	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8008	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8009	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8010	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8011	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8012	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8013	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8014	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8015	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8016	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8017	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8018	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8019	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8020	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8021	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8022	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8023	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8024	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8025	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8026	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8027	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8028	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8029	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8030	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8031	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8032	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8033	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8034	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8035	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8036	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8037	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8038	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8039	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8040	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8041	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8042	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8043	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8044	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8045	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8046	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8047	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710678
8048	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8049	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8050	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8051	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8052	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8053	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8054	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8055	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8056	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8057	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8058	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8059	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8060	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8061	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8062	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8063	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8064	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8065	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8066	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8067	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8068	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8069	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8070	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8071	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8072	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8073	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8074	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8075	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8076	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8077	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8078	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8079	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8080	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8081	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8082	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8083	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8084	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8085	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8086	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8087	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8088	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8089	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8090	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8091	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8092	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8093	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8094	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8095	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8096	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8097	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8098	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8099	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8100	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8101	FC Vsetin	FC Brno	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8102	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8103	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8104	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8105	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8106	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8107	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8108	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8109	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8110	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8111	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8112	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8113	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8114	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8115	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8116	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8117	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8118	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8119	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8120	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8121	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8122	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8123	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8124	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8125	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8126	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8127	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8128	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8129	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8130	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8131	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8132	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8133	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8134	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217713454
8135	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8136	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8137	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8138	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8139	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8140	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8141	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8142	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8143	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8144	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8145	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8146	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8147	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8148	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8149	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8150	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8151	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8152	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8153	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8154	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8155	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8156	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8157	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8158	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8159	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8160	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8161	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8162	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710678
8163	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8164	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8165	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8166	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8167	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8168	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8169	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8170	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8171	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8172	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8173	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8174	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8175	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8176	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8177	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8178	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8179	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8180	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8181	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8182	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8183	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8184	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8185	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8186	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8187	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8188	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8189	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8190	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8191	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8192	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8193	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8194	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8195	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8196	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8197	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8198	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8199	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8200	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8201	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8202	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8203	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8204	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8205	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8206	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8207	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8208	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8209	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8210	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8211	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8212	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8213	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8214	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8215	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8216	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8217	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8218	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8219	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8220	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8221	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8222	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8223	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8224	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8225	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8226	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8227	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8228	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8229	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8230	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8231	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8232	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8233	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8234	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8235	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8236	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8237	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8238	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8239	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8240	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8241	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8242	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8243	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8244	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8245	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8246	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8247	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8248	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8249	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8250	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8251	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8252	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8253	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8254	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8255	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8256	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8257	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8258	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8259	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8260	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8261	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8262	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8263	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8264	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8265	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8266	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8267	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8268	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8269	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8270	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
8271	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8272	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8273	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8274	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8275	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8276	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8277	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8278	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8279	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8280	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8281	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8282	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8283	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8284	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8285	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8286	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8287	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8288	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8289	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8290	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8291	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8292	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8293	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8294	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8295	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8296	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8297	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8298	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8299	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8300	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8301	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8302	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8303	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8304	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8305	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8306	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8307	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8308	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8309	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8310	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8311	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8312	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8313	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8314	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8315	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8316	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8317	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8318	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8319	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8320	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
8321	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8322	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8323	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8324	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8325	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8326	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8327	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8328	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8329	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8330	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8331	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8332	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8333	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8334	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8335	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8336	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8337	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8338	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8339	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8340	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8341	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8342	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8343	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8344	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8345	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8346	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8347	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8348	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8349	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8350	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8351	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8352	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8353	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8354	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8355	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8356	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8357	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8358	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8359	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8360	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8361	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8362	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8363	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8364	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8365	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8366	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8367	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8368	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8369	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8370	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8371	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
8372	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8373	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8374	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8375	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8376	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8377	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8378	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8379	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8380	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8381	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8382	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8383	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8384	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8385	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8386	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8387	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8388	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8389	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217709952
8390	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8391	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8392	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8393	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8394	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8395	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8396	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8397	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8398	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8399	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8400	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8401	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8402	FC Vsetin	FC Brno	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8403	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8404	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8405	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
8406	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8407	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8408	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8409	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8410	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8411	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8412	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8413	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8414	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8415	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8416	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8417	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8418	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8419	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8420	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8421	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8422	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
8423	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8424	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8425	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8426	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
8427	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8428	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217698313
8429	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8430	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8431	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8432	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8433	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8434	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8435	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8436	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8437	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8438	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8439	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8440	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8441	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710312
8442	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8443	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8444	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8445	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8446	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8447	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8448	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8449	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8450	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8451	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8452	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8453	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8454	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8455	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8456	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8457	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8458	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8459	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8460	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8461	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8462	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	Banik Most-Sous	Pardubice	2023-08-30 16:30:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	FC Strani	Hanacka Slavia Kromeriz	2023-08-30 16:00:00	\N
8463	Catanzaro	Spezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217472788
8464	Nottm Forest	Burnley	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260998
8465	Povltavska FA	Viktoria Zizkov	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710222
8466	AEK Athens	Antwerp	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217461281
8467	Pogon Szczecin	Slask Wroclaw	2023-08-30 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217477205
8468	Sheff Utd	Lincoln City	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260481
8469	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710588
8470	PSV	Rangers	2023-08-30 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217464996
8471	TJ Sokol Lanzhot	FC Trinity Zlin	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217593630
8472	Trinec	Sigma Olomouc	2023-08-30 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217710042
8473	Harrogate Town	Blackburn	2023-08-30 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217260775
8474	Roasso Kumamoto	Vissel Kobe	2023-08-30 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217195544
8475	Jiskra Domazlice	FK Pribram	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710132
8476	Apia L Tigers	Sydney FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295273
8477	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217710402
8478	Gold Coast Knights	Western United FC	2023-08-30 10:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217295162
8479	FK Kolin	FK Chlumec N.C	2023-08-30 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217712027
8480	Sampdoria	Venezia	2023-08-30 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217473147
\N	AD San Carlos	Santos de Guápiles	2023-08-30 03:00:00	\N
\N	SK Sokol Brozany	FK Teplice	2023-08-30 16:30:00	\N
\N	Municipal Liberia	Puntarenas	2023-08-30 03:00:00	\N
\N	Mt Druitt Town Rangers	Heidelberg Utd	2023-08-30 10:30:00	\N
\N	Slovan Velvary	FC Sellier & Bellot Vlasim	2023-08-30 16:00:00	\N
\N	FC Vsetin	FC Brno	2023-08-30 16:00:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
8499	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8500	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8501	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8502	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8503	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8504	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8505	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8506	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8507	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8508	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8509	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8510	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8511	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8512	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8513	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8514	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8515	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8516	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8517	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8518	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8519	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8520	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8521	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8522	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8523	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8524	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
8525	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
8526	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8527	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8528	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8529	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
8530	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8531	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8532	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8533	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8534	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8535	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8536	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8537	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8538	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8539	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8540	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8541	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8542	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8543	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8544	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8545	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8546	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8547	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8548	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8549	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8550	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8551	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8552	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
8553	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8554	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8555	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8556	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8557	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8558	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8559	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8560	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8561	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8562	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8563	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8564	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8565	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8566	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8567	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8568	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8569	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8570	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8571	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8572	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8573	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8574	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8575	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8576	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8577	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8578	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8579	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
8580	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8581	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8582	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8583	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8584	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8585	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8586	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8587	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8588	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8589	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8590	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8591	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8592	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8593	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8594	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8595	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8596	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8597	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8598	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8599	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8600	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8601	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8602	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8603	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8604	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8605	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8606	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
8607	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8608	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8609	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8610	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8611	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8612	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8613	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8614	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8615	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8616	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8617	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8618	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8619	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8620	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8621	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8622	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8623	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8624	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8625	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
8626	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8627	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8628	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8629	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8630	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8631	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8632	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8633	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
8634	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8635	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8636	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8637	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8638	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8639	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8640	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8641	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8642	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8643	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8644	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8645	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8646	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8647	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8648	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8649	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8650	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8651	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8652	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8653	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8654	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8655	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8656	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8657	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8658	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8659	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8660	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
8661	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8662	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8663	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8664	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8665	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8666	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8667	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8668	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8669	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8670	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8671	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8672	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8673	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8674	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8675	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8676	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8677	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8678	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8679	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8680	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8681	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8682	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8683	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8684	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8685	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8686	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8687	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
8688	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8689	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8690	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8691	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8692	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8693	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8694	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8695	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8696	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8697	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8698	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8699	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8700	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8701	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8702	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8703	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8704	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8705	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8706	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8707	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8708	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8709	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8710	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8711	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8712	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8713	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8714	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
8715	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8716	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8717	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8718	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8719	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8720	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8721	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8722	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8723	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8724	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8725	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8726	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8727	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8728	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8729	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8730	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8731	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8732	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8733	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8734	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8735	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8736	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8737	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8738	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8739	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8740	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
8741	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
8742	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8743	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8744	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8745	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8746	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8747	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8748	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8749	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8750	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8751	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8752	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8753	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8754	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8755	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8756	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8757	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8758	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8759	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8760	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8761	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8762	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
8763	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8764	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8765	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8766	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8767	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
8768	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
8769	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8770	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8771	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8772	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8773	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8774	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8775	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8776	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8777	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8778	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8779	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8780	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8781	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8782	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8783	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8784	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8785	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8786	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8787	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8788	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8789	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8790	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8791	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8792	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8793	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8794	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8795	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
8796	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8797	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8798	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8799	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8800	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8801	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8802	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8803	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8804	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8805	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8806	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8807	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8808	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8809	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8810	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8811	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8812	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8813	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8814	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8815	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8816	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8817	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8818	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8819	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8820	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8821	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
8822	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
8823	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8824	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8825	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8826	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8827	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8828	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8829	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8830	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8831	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8832	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8833	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8834	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8835	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8836	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8837	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8838	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8839	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8840	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8841	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8842	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8843	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8844	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8845	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8846	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8847	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8848	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
8849	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
8850	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8851	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8852	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8853	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8854	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8855	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8856	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8857	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8858	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8859	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8860	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8861	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8862	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8863	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8864	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8865	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8866	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8867	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8868	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8869	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8870	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8871	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8872	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8873	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8874	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8875	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8876	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
8877	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8878	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8879	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8880	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8881	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8882	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8883	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8884	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8885	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8886	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8887	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8888	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8889	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8890	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8891	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8892	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8893	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8894	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8895	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8896	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8897	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8898	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8899	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
8900	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8901	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8902	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8903	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
8904	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8905	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8906	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8907	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8908	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8909	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8910	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8911	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8912	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8913	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8914	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8915	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8916	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8917	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8918	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8919	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8920	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8921	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8922	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8923	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8924	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8925	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8926	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8927	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8928	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8929	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8930	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
8931	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8932	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
8933	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8934	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8935	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8936	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8937	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8938	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8939	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8940	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8941	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8942	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8943	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8944	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8945	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8946	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8947	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8948	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8949	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8950	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8951	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8952	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8953	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8954	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8955	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8956	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8957	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
8958	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8959	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8960	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8961	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8962	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8963	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8964	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8965	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8966	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8967	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8968	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8969	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8970	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8971	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8972	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
8973	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
8974	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
8975	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
8976	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
8977	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
8978	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
8979	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
8980	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
8981	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
8982	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
8983	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
8984	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
8985	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
8986	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
8987	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
8988	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
8989	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
8990	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
8991	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
8992	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
8993	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
8994	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
8995	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
8996	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
8997	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
8998	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
8999	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9000	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9001	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9002	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9003	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9004	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9005	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9006	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9007	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9008	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9009	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9010	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9011	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9012	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9013	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9014	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9015	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9016	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9017	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9018	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9019	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9020	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9021	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9022	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9023	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9024	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9025	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9026	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9027	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9028	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9029	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9030	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9031	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9032	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9033	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9034	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9035	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9036	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9037	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9038	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9039	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9040	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9041	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9042	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9043	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9044	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9045	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9046	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9047	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9048	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9049	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9050	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9051	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9052	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9053	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9054	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9055	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9056	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9057	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9058	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9059	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9060	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9061	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9062	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9063	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9064	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9065	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9066	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9067	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9068	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9069	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9070	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9071	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9072	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9073	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9074	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9075	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9076	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9077	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9078	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9079	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9080	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9081	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9082	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9083	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9084	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9085	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9086	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9087	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9088	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9089	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9090	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9091	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9092	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9093	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9094	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9095	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9096	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9097	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9098	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9099	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9100	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9101	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9102	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9103	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9104	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9105	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9106	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9107	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9108	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9109	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9110	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9111	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9112	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9113	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9114	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9115	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9116	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9117	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9118	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9119	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9120	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9121	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9122	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9123	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9124	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9125	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9126	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9127	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9128	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9129	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9130	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9131	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9132	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9133	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9134	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9135	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9136	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9137	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9138	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9139	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9140	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9141	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9142	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9143	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9144	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9145	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9146	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9147	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9148	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9149	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9150	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9151	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9152	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9153	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9154	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9155	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9156	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9157	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9158	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9159	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9160	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9161	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9162	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9163	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9164	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9165	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9166	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9167	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9168	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9169	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9170	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9171	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9172	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
9173	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9174	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9175	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9176	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9177	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9178	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9179	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9180	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9181	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9182	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9183	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9184	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9185	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9186	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9187	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9188	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9189	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9190	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9191	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9192	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9193	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9194	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9195	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9196	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9197	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9198	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9199	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9200	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9201	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9202	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9203	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9204	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9205	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9206	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9207	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9208	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9209	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9210	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9211	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9212	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9213	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9214	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9215	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9216	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
9217	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9218	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9219	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9220	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9221	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9222	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9223	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9224	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9225	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9226	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9227	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9228	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9229	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9230	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9231	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9232	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9233	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9234	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9235	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9236	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9237	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9238	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9239	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9240	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9241	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9242	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9243	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9244	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9245	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9246	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9247	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9248	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9249	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9250	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9251	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9252	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9253	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9254	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9255	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9256	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9257	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9258	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9259	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9260	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9261	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9262	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9263	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9264	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9265	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9266	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9267	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9268	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9269	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9270	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9271	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9272	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9273	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9274	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9275	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9276	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9277	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9278	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9279	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9280	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
9281	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9282	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9283	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9284	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9285	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9286	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9287	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9288	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9289	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9290	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9291	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9292	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9293	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9294	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9295	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9296	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9297	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9298	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9299	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9300	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9301	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9302	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9303	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9304	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9305	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9306	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9307	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9308	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9309	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9310	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9311	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9312	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9313	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9314	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9315	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9316	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9317	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9318	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9319	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9320	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9321	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9322	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9323	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9324	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9325	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9326	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9327	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9328	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9329	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9330	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9331	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9332	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9333	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9334	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
9335	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9336	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9337	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9338	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9339	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9340	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9341	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9342	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9343	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9344	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9345	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9346	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9347	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9348	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9349	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9350	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9351	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9352	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9353	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
9354	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9355	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9356	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9357	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9358	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9359	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9360	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9361	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9362	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9363	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9364	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9365	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9366	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9367	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9368	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9369	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9370	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9371	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9372	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9373	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9374	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9375	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9376	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9377	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9378	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9379	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9380	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9381	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9382	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9383	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9384	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9385	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9386	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9387	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9388	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
9389	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9390	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9391	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9392	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9393	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9394	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9395	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9396	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9397	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9398	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9399	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9400	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9401	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9402	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9403	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9404	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9405	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9406	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9407	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9408	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9409	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9410	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9411	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9412	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9413	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9414	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9415	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9416	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9417	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9418	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9419	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9420	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9421	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9422	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9423	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9424	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9425	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9426	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9427	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9428	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9429	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9430	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9431	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9432	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9433	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9434	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9435	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9436	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9437	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9438	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9439	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9440	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9441	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9442	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9443	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9444	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9445	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9446	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9447	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9448	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9449	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9450	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9451	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9452	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9453	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9454	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9455	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9456	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9457	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9458	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9459	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9460	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9461	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9462	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9463	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9464	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9465	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9466	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9467	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9468	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9469	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9470	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9471	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9472	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9473	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9474	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9475	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9476	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9477	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9478	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9479	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9480	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9481	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9482	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9483	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9484	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9485	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9486	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9487	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9488	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9489	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9490	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
9491	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9492	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9493	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9494	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9495	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9496	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
9497	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9498	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9499	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9500	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9501	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9502	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9503	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9504	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9505	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9506	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9507	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9508	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9509	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9510	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9511	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9512	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9513	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9514	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9515	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9516	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9517	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9518	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9519	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9520	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9521	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9522	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9523	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9524	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9525	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9526	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9527	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9528	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9529	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9530	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9531	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9532	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9533	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9534	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9535	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9536	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9537	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9538	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9539	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9540	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9541	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9542	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9543	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9544	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9545	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9546	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9547	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9548	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9549	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9550	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9551	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9552	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9553	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9554	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9555	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9556	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9557	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9558	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9559	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9560	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9561	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9562	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9563	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9564	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9565	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9566	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9567	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9568	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9569	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9570	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9571	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9572	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9573	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9574	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9575	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9576	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9577	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
9578	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9579	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9580	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9581	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9582	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9583	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9584	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9585	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9586	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9587	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9588	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9589	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9590	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9591	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9592	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9593	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9594	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9595	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9596	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9597	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9598	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9599	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9600	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9601	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9602	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9603	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9604	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9605	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9606	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9607	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9608	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9609	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9610	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9611	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9612	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9613	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9614	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9615	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9616	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9617	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9618	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9619	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9620	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9621	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9622	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9623	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9624	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9625	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9626	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9627	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
9628	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9629	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9630	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9631	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9632	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9633	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9634	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9635	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9636	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9637	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9638	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9639	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9640	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9641	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9642	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9643	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9644	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9645	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9646	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9647	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9648	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9649	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9650	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9651	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9652	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9653	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9654	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9655	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9656	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9657	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9658	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9659	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9660	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9661	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9662	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9663	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9664	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9665	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9666	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9667	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9668	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9669	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9670	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9671	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9672	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9673	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9674	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9675	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9676	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9677	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9678	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9679	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9680	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9681	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9682	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9683	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9684	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9685	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9686	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9687	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9688	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9689	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9690	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9691	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9692	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9693	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9694	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9695	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9696	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9697	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9698	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9699	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9700	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9701	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9702	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9703	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9704	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9705	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9706	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9707	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9708	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9709	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9710	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9711	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9712	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9713	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9714	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9715	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9716	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9717	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9718	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9719	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9720	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9721	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9722	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9723	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9724	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9725	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9726	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9727	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9728	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9729	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9730	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9731	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9732	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9733	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9734	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9735	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9736	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9737	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9738	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9739	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9740	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9741	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9742	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9743	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9744	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9745	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9746	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9747	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9748	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217395428
9749	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9750	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9751	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9752	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9753	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9754	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9755	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9756	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9757	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9758	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9759	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9760	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9761	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9762	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9763	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9764	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9765	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9766	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9767	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9768	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9769	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9770	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9771	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9772	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9773	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9774	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9775	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9776	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9777	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9778	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9779	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9780	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9781	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9782	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9783	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9784	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9785	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9786	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9787	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9788	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9789	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9790	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9791	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9792	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9793	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
9794	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9795	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9796	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9797	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9798	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9799	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9800	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9801	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9802	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9803	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9804	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9805	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9806	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9807	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9808	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9809	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9810	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9811	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9812	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9813	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9814	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9815	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9816	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9817	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9818	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9819	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9820	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9821	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9822	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9823	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9824	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9825	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9826	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9827	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9828	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9829	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9830	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9831	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9832	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9833	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9834	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9835	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9836	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9837	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9838	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9839	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9840	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9841	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9842	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9843	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9844	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9845	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9846	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9847	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
9848	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9849	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9850	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9851	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9852	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9853	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9854	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9855	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9856	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9857	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9858	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9859	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9860	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9861	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9862	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9863	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9864	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9865	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9866	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9867	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9868	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9869	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9870	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9871	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9872	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9873	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
9874	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
9875	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9876	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9877	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9878	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9879	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9880	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9881	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9882	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9883	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217395428
9884	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9885	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9886	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9887	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9888	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9889	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9890	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9891	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9892	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9893	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9894	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9895	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9896	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9897	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9898	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9899	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9900	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9901	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
9902	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9903	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9904	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9905	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9906	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9907	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9908	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9909	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9910	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9911	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9912	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9913	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9914	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9915	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9916	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9917	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9918	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9919	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9920	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9921	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9922	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9923	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9924	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9925	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9926	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9927	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9928	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9929	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9930	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9931	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9932	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9933	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9934	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9935	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9936	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9937	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9938	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9939	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9940	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9941	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9942	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9943	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9944	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9945	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9946	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9947	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9948	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9949	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9950	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9951	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9952	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9953	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9954	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9955	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9956	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
9957	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9958	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
9959	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9960	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9961	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9962	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9963	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9964	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9965	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9966	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9967	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
9968	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9969	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9970	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9971	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9972	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
9973	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
9974	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
9975	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
9976	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9977	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
9978	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
9979	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
9980	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
9981	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
9982	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
9983	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	SK Brann	AZ	2023-08-31 18:00:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
9984	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
9985	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
9986	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
9987	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
9988	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
9989	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
9990	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
9991	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
9992	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
9993	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
9994	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
9995	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
9996	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
9997	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
9998	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
9999	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
10000	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
10001	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
10002	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
10003	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
10004	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
10005	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
10006	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
10007	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
10008	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
10009	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
10010	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
10011	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
10012	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
10013	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
10014	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
10015	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
10016	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
10017	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
10018	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
10019	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
10020	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
10021	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
10022	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
10023	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
10024	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
10025	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
10026	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
10027	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
10028	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
10029	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
10030	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
10031	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
10032	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
10033	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
10034	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
10035	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
10036	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
10037	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
10038	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
10039	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
10040	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
10041	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
10042	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
10043	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
10044	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
10045	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
10046	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
10047	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
10048	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
10049	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
10050	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
10051	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
10052	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
10053	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
10054	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
10055	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
10056	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
10057	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
10058	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
10059	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
10060	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
10061	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
10062	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
10063	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
10064	Fiorentina	Rapid Vienna	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556240
10065	BATE Borisov	KF Ballkani	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551536
10066	Ferencvarosi TC	FK Zalgiris Vilnius	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550815
10067	Legia Warsaw	Midtjylland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552040
10068	Viktoria Plzen	Tobol Kostanay	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217556456
10069	Club Brugge	Osasuna	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217550924
10070	Apoel Nicosia	Gent	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550491
10071	Sparta Prague	Dinamo Zagreb	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548995
10072	Adana Demirspor	Genk	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551320
10073	Eintracht Frankfurt	Levski Sofia	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217556348
10074	Aris Limassol	Slovan Bratislava	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548547
10075	SK Brann	AZ	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550185
10076	Aberdeen	BK Hacken	2023-08-31 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217548215
10077	FK Qarabag	Olimpija Ljubljana	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548661
10078	NK Celje	Maccabi Tel Aviv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551428
10079	Zrinjski Mostar	LASK Linz	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548107
10080	HJK Helsinki	Farul Constanta	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551644
10081	Zorya	Slavia Prague	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217548877
10082	Breidablik	FC Struga Trim & Lum	2023-08-31 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217549987
10083	FC Twente	Fenerbahce	2023-08-31 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217550383
10084	Partizan Belgrade	FC Nordsjaelland	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217552238
10085	Ajax	Ludogorets Razgrad	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549312
10086	HNK Rijeka	Lille	2023-08-31 19:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217551752
10087	Bodo/Glimt	ACS Sepsi	2023-08-31 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217549879
10088	Lugano	Union Saint Gilloise	2023-08-31 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217547999
10089	Aston Villa	Hibernian	2023-08-31 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217513080
10090	Besiktas	Dynamo Kyiv	2023-08-31 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217551032
\N	New England Revolution	New York Red Bulls	2023-08-31 00:30:00	\N
\N	Chicago Fire	Vancouver Whitecaps	2023-08-31 01:30:00	\N
\N	St. Louis City SC	FC Dallas	2023-08-31 01:30:00	\N
\N	Portland Timbers	Real Salt Lake	2023-08-31 03:30:00	\N
\N	Toronto FC	Philadelphia Union	2023-08-31 00:30:00	\N
\N	San Jose Earthquakes	LA Galaxy	2023-08-31 03:30:00	\N
\N	Tigres UANL	Santos Laguna	2023-08-31 04:00:00	\N
\N	Toluca	Monterrey	2023-08-31 02:00:00	\N
\N	Houston Dynamo	Columbus Crew	2023-08-31 01:30:00	\N
\N	Minnesota United	Colorado Rapids	2023-08-31 01:30:00	\N
\N	Austin FC	Seattle Sounders FC	2023-08-31 01:30:00	\N
\N	Charlotte FC	Orlando City SC	2023-08-31 00:30:00	\N
\N	Racing Club	Boca Juniors	2023-08-31 01:30:00	\N
\N	Municipal Perez Zeledon	Sporting San Jose	2023-08-31 01:00:00	\N
\N	Atlanta United	FC Cincinnati	2023-08-31 00:30:00	\N
\N	Inter Miami CF	Nashville SC	2023-08-31 00:30:00	\N
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10118	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10119	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10120	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217788098
10121	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10122	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10123	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10124	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10125	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10126	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10127	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10128	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10129	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10130	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10131	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10132	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217760521
10133	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10134	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10135	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10136	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10137	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10138	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10139	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10140	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10141	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10142	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
10143	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10144	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10145	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10146	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10147	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
10148	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10149	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10150	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10151	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10152	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
10153	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10154	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10155	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10156	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10157	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
10158	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10159	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10160	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10161	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10162	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10163	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10164	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10165	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10166	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10167	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10168	Top Oss	FC Groningen	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10169	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10170	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10171	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10172	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10173	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10174	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10175	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10176	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10177	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10178	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10179	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10180	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10181	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10182	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10183	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10184	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10185	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10186	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10187	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10188	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10189	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10190	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10191	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10192	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10193	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10194	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10195	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10196	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10197	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10198	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10199	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10200	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10201	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10202	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10203	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10204	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10205	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10206	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10207	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10208	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10209	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10210	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10211	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10212	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10213	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10214	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10215	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10216	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10217	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10218	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10219	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10220	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10221	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10222	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10223	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10224	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Cadiz	Villarreal	2023-09-01 18:30:00	\N
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10249	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10250	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10251	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10252	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10253	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10254	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10255	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10256	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10257	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10258	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10225	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10226	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10227	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10228	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10229	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10230	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10231	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10232	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10233	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10234	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10235	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10236	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10237	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10238	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10239	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10240	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10241	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10242	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10243	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10244	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10245	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10246	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10247	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10248	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10259	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10260	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10261	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10262	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10263	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10264	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10265	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10266	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10267	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10268	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10269	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10270	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10271	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10272	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10273	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10274	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10275	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10276	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10277	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10278	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10279	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10280	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10281	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10282	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10283	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
10284	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10285	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10286	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10287	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10288	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10289	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10290	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10291	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10292	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10293	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10294	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10295	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10296	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10297	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10298	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10299	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10300	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10301	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10302	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10303	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10304	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10305	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10306	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10307	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10308	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10309	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10310	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10311	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10312	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10313	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10314	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10315	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10316	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10317	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10318	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10319	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10320	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10321	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10322	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10323	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10324	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10325	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10326	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10327	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10328	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10329	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	VVV	De Graafschap	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10330	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10331	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10332	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10333	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10334	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10335	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10336	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10337	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10338	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10339	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10340	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10341	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10342	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10343	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10344	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10345	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10346	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10347	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10348	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10349	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10350	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10351	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10352	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10353	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10354	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10355	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
10356	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10357	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10358	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10359	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10360	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10361	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10362	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10363	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
10364	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10365	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10366	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10367	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10368	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10369	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10370	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10371	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10372	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10373	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10374	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10375	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10376	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10377	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10378	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10379	Top Oss	FC Groningen	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10380	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10381	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10382	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10383	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10384	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10385	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10386	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
10387	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10388	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10389	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10390	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10391	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10392	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10393	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10394	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10395	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10396	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10397	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10398	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10399	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10400	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10401	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10402	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217788098
10403	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10404	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10405	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10406	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10407	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10408	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10409	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10410	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10411	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10412	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10413	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10414	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10415	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10416	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10417	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10418	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10419	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10420	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10421	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10422	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10423	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10424	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
10425	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10426	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10427	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10428	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10429	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10430	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10431	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10432	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10433	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10434	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10458	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10459	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10460	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10461	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10462	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10463	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10464	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10465	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10466	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10467	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10468	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10469	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10470	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
10435	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10436	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10437	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10438	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10439	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10440	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10441	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10442	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10443	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10444	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10445	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10446	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10447	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10448	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10449	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10450	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10451	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10452	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10453	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10454	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10455	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10456	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10457	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Anderlecht II	Genk II	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10471	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10472	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10473	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10474	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10475	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10476	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10477	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217760521
10478	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10479	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10480	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10481	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10482	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10483	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10484	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10485	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10486	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10487	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10488	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10489	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10490	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10491	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10492	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10493	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10494	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10495	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10496	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10497	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10498	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10499	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10500	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10501	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10502	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10503	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10504	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10505	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10506	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10507	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10508	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10509	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10510	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10511	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10512	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10513	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10514	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10515	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10516	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10517	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10518	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10519	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10520	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10521	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10522	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10523	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10524	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10525	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10526	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10527	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10528	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10529	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10530	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10531	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10532	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10533	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10534	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10535	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10536	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
10537	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10538	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10539	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10540	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10541	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	VVV	De Graafschap	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10542	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10543	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10544	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10545	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10546	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10547	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10548	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10549	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10550	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10551	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10552	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10553	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10554	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10555	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10556	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
10557	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10558	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10559	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10560	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10561	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10562	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10563	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10564	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10565	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10566	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
10567	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10568	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10569	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10570	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
10571	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10572	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10573	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10574	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10575	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10599	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10600	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10601	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10602	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10603	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10604	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10605	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
10606	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10607	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10608	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10609	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10610	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10611	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10576	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10577	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10578	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10579	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10580	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10581	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10582	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10583	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10584	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10585	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10586	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10587	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10588	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10589	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10590	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10591	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10592	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10593	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10594	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
10595	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10596	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10597	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10598	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10612	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10613	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10614	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10615	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10616	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10617	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10618	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10619	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10620	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10621	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10622	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10623	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10624	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10625	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10626	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10627	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10628	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10629	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10630	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10631	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10632	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10633	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10634	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10635	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10636	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
10637	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10638	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10639	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10640	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10641	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10642	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10643	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10644	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10645	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10646	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10647	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10648	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10649	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10650	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10651	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10652	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10653	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10654	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10655	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10656	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10657	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10658	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10659	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10660	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10661	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10662	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10663	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10664	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10665	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10666	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10667	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10668	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10669	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10670	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10749	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10671	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10672	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10673	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10674	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10675	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10676	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10677	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10678	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10679	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10680	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10681	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10682	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10683	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10684	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10685	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10686	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10687	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10688	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10689	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10690	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10691	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10692	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10693	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10694	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10695	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10696	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10697	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10698	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10699	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10700	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10701	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10702	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10703	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10704	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10705	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10706	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10707	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
10708	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10709	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10710	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10711	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10712	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
10713	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10714	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10715	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10716	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10717	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10741	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10742	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10743	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10744	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10745	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10746	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10747	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10748	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
\N	Osasuna	Club Brugge	2023-08-24 19:30:00	\N
10750	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
10751	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10752	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10718	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10719	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10720	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10721	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10722	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10723	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10724	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10725	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10726	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10727	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10728	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10729	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10730	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10731	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10732	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10733	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10734	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
10735	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10736	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10737	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10738	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10739	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10740	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10753	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10754	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10755	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10756	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10757	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10758	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10759	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10760	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10761	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10762	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10763	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10764	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10765	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10766	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10767	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10768	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10769	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10770	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10771	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10772	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10773	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10774	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10775	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10776	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10777	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10778	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10779	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10780	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
10781	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10782	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10783	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10784	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10785	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10786	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10787	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10788	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
10789	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10790	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10791	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10792	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10793	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10794	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10795	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10796	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10797	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10798	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10799	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10800	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10801	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10802	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10803	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10804	Top Oss	FC Groningen	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10805	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10806	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10807	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10808	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10809	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10810	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10811	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
10812	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10813	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10814	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10815	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10816	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10817	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10818	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10819	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10820	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
10821	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10822	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10823	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10824	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10825	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10826	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10827	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10828	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10829	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10830	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10831	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10832	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10833	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10834	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10835	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10836	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10837	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10838	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10839	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10840	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10841	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10842	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10843	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10844	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10845	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10846	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10847	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10848	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10849	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
10850	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10851	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10852	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10853	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10854	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10855	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10856	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10857	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10858	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10859	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
10883	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10884	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10885	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10886	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10887	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10888	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10889	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10890	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10891	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10892	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10893	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10894	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10895	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
10860	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10861	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10862	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10863	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10864	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10865	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10866	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10867	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10868	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10869	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10870	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10871	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10872	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10873	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10874	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10875	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10876	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10877	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10878	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10879	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10880	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10881	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10882	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10896	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10897	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10898	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
10899	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10900	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10901	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10902	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10903	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10904	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10905	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10906	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10907	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10908	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10909	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10910	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10911	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
10912	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10913	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10914	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10915	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10916	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10917	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10918	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10919	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10920	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
10921	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10922	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10923	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10924	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10925	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
10926	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
10927	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10928	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10929	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10930	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
10931	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10932	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10933	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10934	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10935	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10936	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10937	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10938	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10939	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10940	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10941	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
10942	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10943	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10944	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10945	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10946	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10947	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10948	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10949	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10950	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10951	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10952	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10953	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10954	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10955	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
10956	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
10957	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
10958	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10959	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
10960	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10961	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10962	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10963	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10964	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10965	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
10966	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
10967	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
10968	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
10969	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
10970	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
10971	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
10972	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
10973	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
10974	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
10975	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
10976	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
10977	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
10978	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
10979	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
10980	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
10981	Top Oss	FC Groningen	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
10982	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
10983	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
10984	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
10985	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
10986	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
10987	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
10988	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
10989	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
10990	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
10991	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
10992	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
10993	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
10994	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
10995	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
10996	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
10997	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
10998	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
10999	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11000	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11001	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11026	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11027	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11028	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11029	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11030	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11031	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11032	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11033	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11034	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11035	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11036	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11002	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11003	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11004	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11005	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11006	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11007	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11008	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11009	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11010	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11011	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11012	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11013	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11014	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11015	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11016	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11017	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11018	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11019	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11020	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11021	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11022	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11023	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11024	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11025	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
11037	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11038	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11039	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11040	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11041	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11042	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11043	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11044	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11045	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11046	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11047	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11048	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11049	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11050	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11051	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11052	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11053	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11054	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11055	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11056	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11057	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11058	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11059	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11060	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11061	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11062	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11063	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11064	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11065	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11066	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11067	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11068	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11069	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11070	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
11071	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11072	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11073	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11074	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11075	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11076	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11077	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11078	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11079	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11080	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11081	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11082	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11083	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11084	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11085	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11086	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11087	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11088	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
11089	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11090	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11091	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11092	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11093	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11094	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11095	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11096	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11097	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11098	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11099	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11100	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11101	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11102	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11103	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11104	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11105	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11106	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11107	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	VVV	De Graafschap	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11108	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11109	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11110	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11111	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11112	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11113	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11114	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11115	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11116	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11117	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11118	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11119	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11120	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11121	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11122	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11123	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
11124	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11125	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11126	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11127	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11128	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11129	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11130	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11131	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11132	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
11133	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11134	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11135	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11136	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11137	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11138	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11139	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11140	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11141	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
11166	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11167	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11168	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11169	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11170	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11171	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11172	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11173	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11174	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11175	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11176	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11177	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11142	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11143	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11144	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11145	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11146	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11147	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11148	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11149	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11150	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11151	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11152	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11153	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11154	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11155	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11156	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11157	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11158	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11159	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11160	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11161	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11162	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11163	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11164	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11165	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
11178	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11179	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11180	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11181	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11182	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11183	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11184	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11185	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11186	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11187	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11188	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11189	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11190	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11191	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11192	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11193	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11194	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11195	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11196	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11197	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11198	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11199	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11200	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11201	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11202	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11203	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11204	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11205	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11206	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11207	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11208	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11209	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11210	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11211	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11212	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
\N	Al Feiha	Al Raed	2023-09-01 16:00:00	\N
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Taee	Abha	2023-09-01 16:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	\N
11213	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11214	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11215	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11216	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11217	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11218	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11219	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11220	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11221	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11222	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11223	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11224	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11225	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11226	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11227	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11228	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11229	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11230	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11231	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11232	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11233	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11234	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11235	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11236	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11237	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11238	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11239	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11240	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11241	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11242	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11243	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11244	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11245	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
11246	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11247	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11248	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11249	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11250	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11251	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11252	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11253	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11254	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11255	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11256	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11257	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11258	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11259	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11260	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11261	Top Oss	FC Groningen	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11262	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11263	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11264	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11265	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11266	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11267	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11268	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
11269	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11270	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11271	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11272	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11273	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11274	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11275	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11276	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11277	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11278	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11279	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11280	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11281	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11308	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11309	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11310	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11311	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11312	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11313	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11314	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11315	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11316	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11282	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11283	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11284	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11285	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11286	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
11287	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11288	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11289	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11290	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11291	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11292	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11293	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11294	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11295	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11296	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11297	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11298	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
11299	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11300	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11301	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11302	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11303	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11304	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11305	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11306	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
11307	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11317	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11318	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11319	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11320	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11321	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11322	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11323	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11324	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11325	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11326	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11327	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11328	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11329	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11330	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11331	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11332	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
11333	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11334	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11335	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11336	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11337	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11338	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11339	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11340	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11341	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11342	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11343	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11344	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11345	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11346	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11347	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11348	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11349	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11350	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11351	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
11385	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11386	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11387	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11352	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11353	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11354	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11355	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11356	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11357	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11358	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11359	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11360	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
11361	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11362	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11363	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11364	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11365	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11366	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11367	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11368	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
11369	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11370	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11371	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11372	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11373	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11374	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11375	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11376	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11377	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11378	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11379	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11380	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11381	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11382	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11383	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11384	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11388	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11389	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11390	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217788098
11391	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11392	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11393	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11394	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11395	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11396	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11397	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11398	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11399	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11400	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11401	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11402	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11403	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11404	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11405	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11406	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11407	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11408	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11409	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11410	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11411	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11412	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
11413	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11414	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11415	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11416	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11417	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11418	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11419	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11420	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11421	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11422	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11449	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11450	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11451	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11452	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11453	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11454	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11455	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11456	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11457	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11423	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11424	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11425	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217788098
11426	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11427	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11428	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11429	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11430	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11431	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11432	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11433	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11434	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11435	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11436	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11437	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11438	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11439	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11440	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11441	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11442	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11443	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11444	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11445	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11446	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11447	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11448	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
11458	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11459	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217788098
11460	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11461	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11462	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11463	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11464	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11465	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
\N	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	\N
11466	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11467	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11468	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11469	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11470	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11471	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11472	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11473	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11474	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11475	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11476	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
11477	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11478	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11479	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11480	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11481	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11482	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11483	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11484	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11485	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11486	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11487	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11488	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11489	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11490	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11491	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11492	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11493	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
11527	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11528	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11529	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11494	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11495	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11496	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11497	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11498	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11499	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11500	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11501	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11502	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11503	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11504	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11505	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11506	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11507	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11508	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11509	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11510	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
11511	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11512	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11513	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11514	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11515	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11516	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11517	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11518	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11519	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11520	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11521	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11522	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11523	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11524	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11525	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11526	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	VVV	De Graafschap	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	\N
11530	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11531	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11532	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11533	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11534	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11535	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11536	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11537	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11538	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11539	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11540	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11541	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11542	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11543	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11544	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11545	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11546	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11547	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11548	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11549	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
11550	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11551	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11552	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11553	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11554	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11555	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11556	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11557	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11558	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11559	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11560	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11561	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11562	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11563	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
11590	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11591	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11592	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11593	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11594	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11595	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11596	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11597	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11598	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11599	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11564	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11565	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11566	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11567	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11568	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11569	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11570	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11571	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11572	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11573	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11574	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11575	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11576	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11577	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11578	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11579	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11580	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11581	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11582	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11583	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11584	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
11585	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11586	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11587	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11588	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11589	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
11600	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11601	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217788098
11602	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11603	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11604	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11605	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11606	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11607	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11608	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11609	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11610	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11611	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11612	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11613	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11614	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11615	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11616	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11617	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
11618	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11619	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11620	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11621	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11622	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11623	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11624	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11625	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11626	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11627	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11628	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11629	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11630	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11631	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11632	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11633	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11634	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11635	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
11669	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11670	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11636	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11637	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11638	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11639	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11640	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11641	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11642	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11643	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11644	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11645	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11646	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11647	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11648	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11649	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11650	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11651	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11652	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11653	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11654	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11655	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11656	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11657	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11658	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11659	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11660	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11661	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11662	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11663	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11664	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11665	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11666	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11667	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11668	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
11671	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11672	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11673	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11674	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11675	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11676	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11677	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11678	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11679	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11680	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11681	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11682	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11683	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11684	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11685	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11686	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11687	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11688	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11689	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11690	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11691	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11692	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11693	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11694	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11695	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11696	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11697	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11698	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11699	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11700	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11701	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11702	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11703	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11704	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11705	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11706	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11733	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11734	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11735	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11736	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11737	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11738	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11739	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11740	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11741	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11707	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11708	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11709	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11710	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11711	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11712	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11713	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11714	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11715	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11716	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11717	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11718	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11719	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11720	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11721	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11722	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11723	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11724	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11725	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11726	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11727	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11728	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11729	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11730	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11731	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11732	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11742	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11743	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11744	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11745	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11746	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11747	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11748	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11749	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11750	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11751	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11752	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11753	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11754	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11755	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11756	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11757	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
11758	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11759	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11760	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11761	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11762	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11763	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11764	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11765	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11766	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
11767	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11768	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11769	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11770	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11771	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11772	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11773	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11774	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217777922
11775	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11776	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11810	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11811	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11777	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11778	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11779	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11780	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11781	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11782	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11783	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11784	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11785	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11786	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11787	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11788	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11789	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11790	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11791	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11792	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11793	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11794	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11795	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11796	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11797	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11798	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11799	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11800	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11801	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
11802	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11803	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11804	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11805	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11806	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11807	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
11808	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11809	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11812	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11813	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11814	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11815	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11816	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11817	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11818	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11819	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11820	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11821	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11822	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11823	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11824	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11825	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11826	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11827	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11828	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11829	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11830	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11831	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11832	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11833	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11834	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11835	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11836	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11837	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11838	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11839	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11840	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
11841	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11842	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11843	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11844	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11845	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11846	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11847	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11848	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11849	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11850	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11851	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11852	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11853	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11854	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11855	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11856	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725658
11857	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11858	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11859	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11860	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11861	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11862	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11863	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11864	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11865	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11866	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11867	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11868	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11869	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11870	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
11871	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11872	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11873	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11874	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11875	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11876	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11877	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11878	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217777922
11879	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11880	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11881	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11882	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11883	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11884	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11885	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11886	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11887	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11888	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11889	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11890	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11891	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11892	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11893	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11894	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11895	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11896	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11897	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
11898	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11899	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11900	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11901	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11902	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11903	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11904	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11905	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11906	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11907	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11908	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11909	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11910	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11911	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11912	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11913	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11914	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11915	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
11940	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
11941	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11942	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11943	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
12035	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11944	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11945	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11946	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11947	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11948	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11949	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11950	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11916	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11917	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11918	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11919	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11920	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11921	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11922	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11923	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11924	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11925	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11926	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11927	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11928	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11929	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11930	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11931	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11932	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
11933	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11934	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11935	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11936	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11937	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11938	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
11939	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
11951	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
11952	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217788098
11953	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11954	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11955	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11956	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11957	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
11958	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
11959	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11960	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
11961	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
11962	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
11963	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11964	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
11965	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11966	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
11967	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11968	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
11969	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
11970	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
11971	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11972	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11973	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
11974	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
11975	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
11976	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
11977	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
11978	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
11979	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
11980	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
11981	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
11982	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
11983	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
11984	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
11985	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11986	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217779945
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
12022	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
11987	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
11988	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
11989	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
11990	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
11991	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
11992	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
11993	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
11994	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
11995	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
11996	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
11997	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
11998	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
11999	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
12000	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
12001	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
12002	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
12003	Top Oss	FC Groningen	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
12004	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
12005	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
12006	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
12007	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
12008	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
12009	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
12010	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
12011	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
12012	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
12013	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
12014	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
12015	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
12016	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
12017	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
12018	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
12019	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
12020	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
12021	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
\N	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	\N
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
12023	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
12024	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
12025	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
12026	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
12027	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
12028	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
12029	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
12030	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643528
12031	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
12032	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
12033	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
12034	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
12036	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
12037	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
12038	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
12039	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
12040	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
12041	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
12042	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
12043	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
12044	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
12045	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
12046	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
12047	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
12048	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
12049	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
12050	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
12051	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
12052	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
12053	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780218
12054	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
12055	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
12056	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
12057	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
12082	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
12083	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
12084	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
12085	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
12086	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217777922
12087	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
12088	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
12089	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
12090	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
12091	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
12092	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
12093	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
12058	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
12059	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
12060	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
12061	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
12062	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
12063	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
12064	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
12065	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
12066	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
12067	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
12068	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
12069	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
12070	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
12071	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
12072	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
12073	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
12074	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
12075	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
12076	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
12077	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
12078	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
12079	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
12080	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
12081	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
12094	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
12095	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
12096	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
12097	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
12098	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
12099	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
12100	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
12101	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
12102	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
12103	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
12104	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
12105	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
12106	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
12107	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
12108	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
12109	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
12110	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626058
12111	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
12112	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
12113	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
12114	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
12115	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
12116	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
12117	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
12118	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
12119	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
12120	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
12121	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
12122	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
12123	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
12124	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
12125	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
12126	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
12127	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
12128	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
12129	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
12130	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
12131	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217427295
12132	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
12133	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
12134	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
12135	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
12136	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
12137	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
12138	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
12139	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
12140	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
12141	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
12142	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
12143	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
12144	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
12145	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
12146	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
12147	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
12148	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
12149	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
12150	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
12151	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
12152	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
12153	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
12154	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
12155	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
12156	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
12157	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
12158	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
12159	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626155
12160	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
12161	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
12162	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
12163	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
12164	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Kasimpasa	Trabzonspor	2023-09-01 19:00:00	\N
\N	FC Utrecht Reserves	Roda JC	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
12165	Vendsyssel FF	FC Fredericia	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625426
12166	Al Taee	Abha	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217725086
12167	Miedz Legnica	Wisla Krakow	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217603788
12168	AC Horsens	B93 Copenhagen	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217630840
12169	Telstar	FC Eindhoven	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625697
12170	OH Leuven	KV Kortrijk	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217552666
12171	Hillerød	Sonderjyske	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625516
12172	Sassuolo	Verona	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343882
12173	Al Feiha	Al Raed	2023-09-01 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217803578
12174	Anderlecht II	Genk II	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217649907
12175	Odense BK	Vejle	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217447444
12176	Ujpest	Kisvarda FC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217707792
12177	Nantes	Marseille	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217338476
12178	Drogheda United	UCD	2023-09-01 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217382900
12179	Top Oss	FC Groningen	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625787
12180	Al Ittihad Jeddah	Al Hilal Riyadh	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217643211
12181	Zulte-Waregem	FCV Dender EH	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780584
12182	Sparta Rotterdam	NEC	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217445563
12183	Cadiz	Villarreal	2023-09-01 18:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217341775
12184	VVV	De Graafschap	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570117
12185	Borussia Dortmund	Heidenheim	2023-09-01 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217344123
12186	Saarbrucken	Borussia Dortmund II	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217592906
12187	FC Emmen	FC Dordrecht	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625877
12188	Helmond Sport	Cambuur Leeuwarden	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217626245
12189	Caykur Rizespor	Fatih Karagumruk	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217426619
12190	Slaven Belupo	NK Lokomotiva Zagreb	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570497
12191	Daejeon Hana Citizen	Suwon FC	2023-09-01 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217561533
12192	Maastricht	Ajax Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217625968
12193	Fortuna Dusseldorf	Karlsruher SC	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217361899
12194	Luton	West Ham	2023-09-01 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217362429
12195	FC Den Bosch	PSV Reserves	2023-09-01 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217780866
12196	Orgryte IS	Orebro SK	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217369830
12197	Resovia Rzeszow	Termalica BB Nieciecza	2023-09-01 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217603608
12198	Eintracht Braunschweig	St Pauli	2023-09-01 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217378831
12199	Skeid	Asane	2023-09-01 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217532475
\N	Kisvarda FC	Ujpest	2023-09-01 19:00:00	\N
\N	Al Riyadh	Al Akhdoud	2023-09-01 19:00:00	\N
\N	Top Oss	FC Groningen	2023-09-01 19:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
4899	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217298311
4900	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217254229
4901	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343324
4902	Gent	Apoel Nicosia	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217298635
4903	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217480391
4904	Genk	Adana Demirspor	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297987
4905	Lille	HNK Rijeka	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297879
4906	Osasuna	Club Brugge	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217297663
4907	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217254445
4908	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217254953
4909	AZ	SK Brann	2023-08-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217299716
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	AZ	SK Brann	2023-08-24 19:45:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	Osasuna	Club Brugge	2023-08-24 19:30:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	\N
\N	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	AZ	SK Brann	2023-08-24 19:45:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	Osasuna	Club Brugge	2023-08-24 19:30:00	\N
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Shenzhen	Shandong Taishan	2023-08-25 12:35:00	\N
\N	Cambuur Leeuwarden	Ajax Reserves	2023-08-25 19:00:00	\N
4914	De Graafschap	FC Emmen	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498634
4915	FK Pribram	Dukla Praha	2023-08-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217296962
4916	FC Dordrecht	Maastricht	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339130
4917	MSV Duisburg	SSV Ulm 1846	2023-08-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368790
4918	Schalke	Holstein Kiel	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217041949
4919	Roda JC	Top Oss	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339587
4920	Henan Songshan Longmen	Shanghai Port	2023-08-25 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217303179
4921	Konyaspor	Gaziantep FK	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319409
4922	Jeonbuk Motors	Daejeon Hana Citizen	2023-08-25 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217270886
4923	Nantes	Monaco	2023-08-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217058034
4924	AC Horsens	Naestved IF	2023-08-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217443432
4925	Lechia Gdansk	Podbeskidzie Bielsko Biala	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217493623
4926	UCD	St Patricks Athletic	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192189
4927	Widzew Lodz	Slask Wroclaw	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217219179
4928	Drogheda United	Cork City	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192279
4929	Al Taawon Buraidah	Abha	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498544
4930	FC Den Bosch	ADO Den Haag	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217499620
4931	RB Leipzig	VfB Stuttgart	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215652027
4932	Suwon FC	Incheon Utd	2023-08-25 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217261077
4933	Paderborn	Kaiserslautern	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217041841
4934	Opava	Sigma Olomouc B	2023-08-25 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217271362
4935	Randers FC	Viborg	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217301071
4936	RFC Seraing	Zulte-Waregem	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450418
4937	FC U Craiova 1948	Rapid Bucuresti	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156407
4938	Azam FC	Bahir Dar Kenema FC	2023-08-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217493125
4939	FC Eindhoven	NAC	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217272289
4914	De Graafschap	FC Emmen	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498634
4916	FC Dordrecht	Maastricht	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339130
4919	Roda JC	Top Oss	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339587
4921	Konyaspor	Gaziantep FK	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319409
4923	Nantes	Monaco	2023-08-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217058034
4925	Lechia Gdansk	Podbeskidzie Bielsko Biala	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217493623
4926	UCD	St Patricks Athletic	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192189
4927	Widzew Lodz	Slask Wroclaw	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217219179
4928	Drogheda United	Cork City	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192279
4929	Al Taawon Buraidah	Abha	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498544
4930	FC Den Bosch	ADO Den Haag	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217499620
4931	RB Leipzig	VfB Stuttgart	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215652027
4936	RFC Seraing	Zulte-Waregem	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450418
4937	FC U Craiova 1948	Rapid Bucuresti	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156407
4939	FC Eindhoven	NAC	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217272289
\N	Jeonbuk Motors	Daejeon Hana Citizen	2023-08-25 11:30:00	\N
\N	Henan Songshan Longmen	Shanghai Port	2023-08-25 12:35:00	\N
\N	Suwon FC	Incheon Utd	2023-08-25 11:00:00	\N
\N	Shenzhen	Shandong Taishan	2023-08-25 12:35:00	\N
\N	Marseille	Brest	2023-08-26 16:00:00	\N
\N	Sportivo Ameliano	Guairena FC	2023-08-26 00:00:00	\N
\N	El Nacional	Cumbaya FC	2023-08-26 01:00:00	\N
\N	Sydney United 58	Brisbane Roar	2023-08-26 05:00:00	\N
\N	Once Caldas	Atletico Bucaramanga	2023-08-26 00:15:00	\N
\N	Standard Liege II	KFCO Beerschot Wilrijk	2023-08-26 15:00:00	\N
\N	Tijuana	Mazatlan FC	2023-08-26 04:10:00	\N
\N	Coventry	Sunderland	2023-08-26 15:00:00	\N
4964	Gangwon FC	Pohang Steelers	2023-08-26 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217317920
4965	Unterhaching	FC Viktoria Köln	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368430
4967	Bradford	Crewe	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309613
4969	Rotherham	Leicester	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217076923
4970	Kawasaki Frontale	Consadole Sapporo	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217173948
4971	Ross County	Rangers	2023-08-26 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217107975
4972	Brighton	West Ham	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217056630
4974	GKS Katowice	Resovia Rzeszow	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217257919
4975	SC Farense	Chaves	2023-08-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217278488
4976	FC Tokyo	Vissel Kobe	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217175300
4977	Kecskemeti TE	Puskas Academy	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217316091
4978	PSG	Lens	2023-08-26 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217057914
4979	Arsenal	Fulham	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217057053
4980	Yverdon Sport FC	Servette	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217124539
4981	Kolding IF	FC Helsingor	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217443522
4983	Hertha Berlin	Greuther Furth	2023-08-26 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217541591
4984	Monza	Empoli	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.216826059
4985	Sevilla	Girona	2023-08-26 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217058154
4986	KV Kortrijk	Standard Liege	2023-08-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217179611
4987	Omiya Ardija	V-Varen Nagasaki	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217173317
4988	Sagan Tosu	Gamba Osaka	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217345655
4989	Hartlepool	AFC Fylde	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217304166
4990	Orebro SK	Västerås SK FK	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217470899
4991	SC Bastia	Troyes	2023-08-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217320349
4992	Partick	Queens Park	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217314331
4993	Vfb Lubeck	Erzgebirge Aue	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368880
4994	Cardiff	Sheff Wed	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217077679
4995	Oxford Utd	Charlton	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217391389
4996	SK Lisen	Hanacka Slavia Kromeriz	2023-08-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317086
4997	Cerezo Osaka	Nagoya Grampus	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217174309
4998	Altrincham	Chesterfield	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217308965
4999	Como	AC Reggiana	2023-08-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217321105
5000	Gyeongnam FC	Seongnam FC	2023-08-26 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217388327
5001	Verl	SC Freiburg II	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368340
5002	Krumovgrad	Lokomotiv 1929 Sofia	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297232
5003	Ujpest	Zalaegerszegi TE	2023-08-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217318471
5004	Eupen	OH Leuven	2023-08-26 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217179743
5005	Ipswich	Leeds	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217078111
5006	Burton Albion	Bolton	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217304526
5007	West Brom	Middlesbrough	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217077355
5008	SK Sturm Graz	FC Blau Weiss Linz	2023-08-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217059372
5009	Sportivo Trinidense	Tacuary	2023-08-26 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217560985
5010	Hibernian	Livingston	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217108084
5011	Bournemouth	Tottenham	2023-08-26 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217056489
5012	Southampton	QPR	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217077787
5013	Swindon	Crawley Town	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217304436
5014	FC Zurich	St Gallen	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217124355
5015	Frosinone	Atalanta	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.216826179
5016	Tianjin Jinmen Tigers	Meizhou Hakka	2023-08-26 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217303755
5017	NK Zrinski Jurjevac	NK Solin	2023-08-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217544898
5018	Ebbsfleet United	Kidderminster	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217304256
5019	Sandhausen	1860 Munich	2023-08-26 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217368610
5020	Westerlo	KV Mechelen	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217179933
5021	Patro Eisden Maasmechelen	SK Beveren	2023-08-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450328
5022	Maccabi Netanya	Maccabi Bnei Raina	2023-08-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217310949
5023	Jubilo Iwata	JEF Utd Chiba	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217174038
5024	Bochum	Borussia Dortmund	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215730347
5025	Aldershot	Wealdstone	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309736
5026	Hannover 96	Hamburg	2023-08-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217055794
5027	Power Dynamos	African Stars Windhoek	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570211
5028	Borussia Mgladbach	Bayer Leverkusen	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215730468
5029	Dorking	York	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309916
5030	Harrogate Town	Morecambe	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217322120
5031	Kasimpasa	Pendikspor	2023-08-26 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217322458
5032	Lommel	Deinze	2023-08-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319014
5033	Gimcheon Sangmu FC	Chungnam Asan FC	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217474701
5034	Gateshead	Woking	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309646
5035	Elversberg	Fortuna Dusseldorf	2023-08-26 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217055904
5036	Sarpsborg	Tromso	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217103621
5037	AD Grecia	Municipal Perez Zeledon	2023-08-26 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217470238
5038	Milton Keynes Dons	Doncaster	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321940
5039	Banik Ostrava	Ceske Budejovice	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217223479
5040	KaPa	KPV	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217316001
5041	US Quevilly	Laval	2023-08-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217313500
5042	Excelsior	Fortuna Sittard	2023-08-26 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217172640
5043	Darmstadt	Union Berlin	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215762426
5044	Zhejiang	Dalian Pro	2023-08-26 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217303515
5045	Newport County	Sutton Utd	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309397
5046	B93 Copenhagen	Vendsyssel FF	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570021
5047	Trabzonspor	Caykur Rizespor	2023-08-26 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217322246
5048	Wolfsberger AC	FC Salzburg	2023-08-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217059156
5049	Pardubice	Slovacko	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217223365
5050	NEC	RKC	2023-08-26 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217172748
5051	Celtic	St Johnstone	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217304346
5052	FC Copenhagen	Silkeborg IF	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217334731
5053	Cangzhou Mighty Lions	Beijing Guoan	2023-08-26 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217381104
5054	FC Ingolstadt	Saarbrucken	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368700
5055	Diosgyori VTK	Kisvarda FC	2023-08-26 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217317177
5056	Airdrieonians	Inverness CT	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217305267
5057	Heidenheim	TSG Hoffenheim	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215730588
5058	Salford City	Accrington Stanley	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217056912
5059	SC Freiburg	Werder Bremen	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215653587
5060	Academico Viseu	Feirense	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217301592
5061	Maidenhead Utd	Oxford City	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217056348
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
4899	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217298311
4900	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217254229
4901	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217343324
4902	Gent	Apoel Nicosia	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217298635
4903	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217480391
4904	Genk	Adana Demirspor	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297987
4905	Lille	HNK Rijeka	2023-08-24 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297879
4906	Osasuna	Club Brugge	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217297663
4907	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217254445
4908	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217254953
4909	AZ	SK Brann	2023-08-24 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217299716
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	The Strongest	Royal Pari FC	2023-08-24 01:00:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	AZ	SK Brann	2023-08-24 19:45:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Atletico San Luis	Leon	2023-08-24 04:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Lille	HNK Rijeka	2023-08-24 19:00:00	\N
\N	Genk	Adana Demirspor	2023-08-24 19:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	Osasuna	Club Brugge	2023-08-24 19:30:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	\N
\N	Slovan Bratislava	Aris Limassol	2023-08-24 19:30:00	\N
\N	Gent	Apoel Nicosia	2023-08-24 19:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Al Raed	Al Hilal Riyadh	2023-08-24 19:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Midtjylland	Legia Warsaw	2023-08-24 19:00:00	\N
\N	Union Saint Gilloise	Lugano	2023-08-24 19:30:00	\N
\N	Al Taee	Al Wahda Mecca	2023-08-24 16:00:00	\N
\N	Farul Constanta	HJK Helsinki	2023-08-24 18:00:00	\N
\N	Los Angeles FC	Colorado Rapids	2023-08-24 03:30:00	\N
\N	AZ	SK Brann	2023-08-24 19:45:00	\N
\N	Houston Dynamo	Real Salt Lake	2023-08-24 02:30:00	\N
\N	Rapid Vienna	Fiorentina	2023-08-24 18:00:00	\N
\N	Fenerbahce	FC Twente	2023-08-24 18:00:00	\N
\N	BK Hacken	Aberdeen	2023-08-24 18:00:00	\N
\N	Slavia Prague	Zorya	2023-08-24 18:00:00	\N
\N	Al Ahli Jeddah	Al Akhdoud	2023-08-24 19:00:00	\N
\N	Al Riyadh	Al Ittihad Jeddah	2023-08-24 19:00:00	\N
\N	FK Zalgiris Vilnius	Ferencvarosi TC	2023-08-24 17:00:00	\N
\N	Ludogorets Razgrad	Ajax	2023-08-24 19:00:00	\N
\N	TPS	HIFK	2023-08-24 16:30:00	\N
\N	Al Ittifaq Dammam	Al Khaleej Saihat	2023-08-24 19:00:00	\N
\N	FC Struga Trim & Lum	Breidablik	2023-08-24 16:00:00	\N
\N	ACS Sepsi	Bodo/Glimt	2023-08-24 18:00:00	\N
\N	Dynamo Kyiv	Besiktas	2023-08-24 18:00:00	\N
\N	Dinamo Zagreb	Sparta Prague	2023-08-24 19:00:00	\N
\N	Shenzhen	Shandong Taishan	2023-08-25 12:35:00	\N
\N	Cambuur Leeuwarden	Ajax Reserves	2023-08-25 19:00:00	\N
4914	De Graafschap	FC Emmen	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498634
4915	FK Pribram	Dukla Praha	2023-08-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217296962
4916	FC Dordrecht	Maastricht	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339130
4917	MSV Duisburg	SSV Ulm 1846	2023-08-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368790
4918	Schalke	Holstein Kiel	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217041949
4919	Roda JC	Top Oss	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339587
4920	Henan Songshan Longmen	Shanghai Port	2023-08-25 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217303179
4921	Konyaspor	Gaziantep FK	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319409
4922	Jeonbuk Motors	Daejeon Hana Citizen	2023-08-25 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217270886
4923	Nantes	Monaco	2023-08-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217058034
4924	AC Horsens	Naestved IF	2023-08-25 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217443432
4925	Lechia Gdansk	Podbeskidzie Bielsko Biala	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217493623
4926	UCD	St Patricks Athletic	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192189
4927	Widzew Lodz	Slask Wroclaw	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217219179
4928	Drogheda United	Cork City	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192279
4929	Al Taawon Buraidah	Abha	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498544
4930	FC Den Bosch	ADO Den Haag	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217499620
4931	RB Leipzig	VfB Stuttgart	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215652027
4932	Suwon FC	Incheon Utd	2023-08-25 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217261077
4933	Paderborn	Kaiserslautern	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217041841
4934	Opava	Sigma Olomouc B	2023-08-25 16:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217271362
4935	Randers FC	Viborg	2023-08-25 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217301071
4936	RFC Seraing	Zulte-Waregem	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450418
4937	FC U Craiova 1948	Rapid Bucuresti	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156407
4938	Azam FC	Bahir Dar Kenema FC	2023-08-25 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217493125
4939	FC Eindhoven	NAC	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217272289
4914	De Graafschap	FC Emmen	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498634
4916	FC Dordrecht	Maastricht	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339130
4919	Roda JC	Top Oss	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217339587
4921	Konyaspor	Gaziantep FK	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319409
4923	Nantes	Monaco	2023-08-25 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217058034
4925	Lechia Gdansk	Podbeskidzie Bielsko Biala	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217493623
4926	UCD	St Patricks Athletic	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192189
4927	Widzew Lodz	Slask Wroclaw	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217219179
4928	Drogheda United	Cork City	2023-08-25 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217192279
4929	Al Taawon Buraidah	Abha	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217498544
4930	FC Den Bosch	ADO Den Haag	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217499620
4931	RB Leipzig	VfB Stuttgart	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215652027
4936	RFC Seraing	Zulte-Waregem	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450418
4937	FC U Craiova 1948	Rapid Bucuresti	2023-08-25 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217156407
4939	FC Eindhoven	NAC	2023-08-25 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217272289
\N	Jeonbuk Motors	Daejeon Hana Citizen	2023-08-25 11:30:00	\N
\N	Henan Songshan Longmen	Shanghai Port	2023-08-25 12:35:00	\N
\N	Suwon FC	Incheon Utd	2023-08-25 11:00:00	\N
\N	Shenzhen	Shandong Taishan	2023-08-25 12:35:00	\N
\N	Marseille	Brest	2023-08-26 16:00:00	\N
\N	Sportivo Ameliano	Guairena FC	2023-08-26 00:00:00	\N
\N	El Nacional	Cumbaya FC	2023-08-26 01:00:00	\N
\N	Sydney United 58	Brisbane Roar	2023-08-26 05:00:00	\N
\N	Once Caldas	Atletico Bucaramanga	2023-08-26 00:15:00	\N
\N	Standard Liege II	KFCO Beerschot Wilrijk	2023-08-26 15:00:00	\N
\N	Tijuana	Mazatlan FC	2023-08-26 04:10:00	\N
\N	Coventry	Sunderland	2023-08-26 15:00:00	\N
4964	Gangwon FC	Pohang Steelers	2023-08-26 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217317920
4965	Unterhaching	FC Viktoria Köln	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368430
4967	Bradford	Crewe	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309613
4969	Rotherham	Leicester	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217076923
4970	Kawasaki Frontale	Consadole Sapporo	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217173948
4971	Ross County	Rangers	2023-08-26 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217107975
4972	Brighton	West Ham	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217056630
4974	GKS Katowice	Resovia Rzeszow	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217257919
4975	SC Farense	Chaves	2023-08-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217278488
4976	FC Tokyo	Vissel Kobe	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217175300
4977	Kecskemeti TE	Puskas Academy	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217316091
4978	PSG	Lens	2023-08-26 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217057914
4979	Arsenal	Fulham	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217057053
4980	Yverdon Sport FC	Servette	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217124539
4981	Kolding IF	FC Helsingor	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217443522
4983	Hertha Berlin	Greuther Furth	2023-08-26 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217541591
4984	Monza	Empoli	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.216826059
4985	Sevilla	Girona	2023-08-26 20:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217058154
4986	KV Kortrijk	Standard Liege	2023-08-26 19:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217179611
4987	Omiya Ardija	V-Varen Nagasaki	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217173317
4988	Sagan Tosu	Gamba Osaka	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217345655
4989	Hartlepool	AFC Fylde	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217304166
4990	Orebro SK	Västerås SK FK	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217470899
4991	SC Bastia	Troyes	2023-08-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217320349
4992	Partick	Queens Park	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217314331
4993	Vfb Lubeck	Erzgebirge Aue	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368880
4994	Cardiff	Sheff Wed	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217077679
4995	Oxford Utd	Charlton	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217391389
4996	SK Lisen	Hanacka Slavia Kromeriz	2023-08-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217317086
4997	Cerezo Osaka	Nagoya Grampus	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217174309
4998	Altrincham	Chesterfield	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217308965
4999	Como	AC Reggiana	2023-08-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217321105
5000	Gyeongnam FC	Seongnam FC	2023-08-26 11:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217388327
5001	Verl	SC Freiburg II	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368340
5002	Krumovgrad	Lokomotiv 1929 Sofia	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217297232
5003	Ujpest	Zalaegerszegi TE	2023-08-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217318471
5004	Eupen	OH Leuven	2023-08-26 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217179743
5005	Ipswich	Leeds	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217078111
5006	Burton Albion	Bolton	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217304526
5007	West Brom	Middlesbrough	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217077355
5008	SK Sturm Graz	FC Blau Weiss Linz	2023-08-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217059372
5009	Sportivo Trinidense	Tacuary	2023-08-26 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217560985
5010	Hibernian	Livingston	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217108084
5011	Bournemouth	Tottenham	2023-08-26 12:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217056489
5012	Southampton	QPR	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217077787
5013	Swindon	Crawley Town	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217304436
5014	FC Zurich	St Gallen	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217124355
5015	Frosinone	Atalanta	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.216826179
5016	Tianjin Jinmen Tigers	Meizhou Hakka	2023-08-26 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217303755
5017	NK Zrinski Jurjevac	NK Solin	2023-08-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217544898
5018	Ebbsfleet United	Kidderminster	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217304256
5019	Sandhausen	1860 Munich	2023-08-26 15:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217368610
5020	Westerlo	KV Mechelen	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217179933
5021	Patro Eisden Maasmechelen	SK Beveren	2023-08-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217450328
5022	Maccabi Netanya	Maccabi Bnei Raina	2023-08-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217310949
5023	Jubilo Iwata	JEF Utd Chiba	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217174038
5024	Bochum	Borussia Dortmund	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215730347
5025	Aldershot	Wealdstone	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309736
5026	Hannover 96	Hamburg	2023-08-26 19:30:00	https://www.orbitxch.com/customer/sport/1/market/1.217055794
5027	Power Dynamos	African Stars Windhoek	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570211
5028	Borussia Mgladbach	Bayer Leverkusen	2023-08-26 17:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215730468
5029	Dorking	York	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309916
5030	Harrogate Town	Morecambe	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217322120
5031	Kasimpasa	Pendikspor	2023-08-26 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217322458
5032	Lommel	Deinze	2023-08-26 19:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217319014
5033	Gimcheon Sangmu FC	Chungnam Asan FC	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217474701
5034	Gateshead	Woking	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309646
5035	Elversberg	Fortuna Dusseldorf	2023-08-26 12:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217055904
5036	Sarpsborg	Tromso	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217103621
5037	AD Grecia	Municipal Perez Zeledon	2023-08-26 22:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217470238
5038	Milton Keynes Dons	Doncaster	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217321940
5039	Banik Ostrava	Ceske Budejovice	2023-08-26 17:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217223479
5040	KaPa	KPV	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217316001
5041	US Quevilly	Laval	2023-08-26 18:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217313500
5042	Excelsior	Fortuna Sittard	2023-08-26 20:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217172640
5043	Darmstadt	Union Berlin	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215762426
5044	Zhejiang	Dalian Pro	2023-08-26 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217303515
5045	Newport County	Sutton Utd	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217309397
5046	B93 Copenhagen	Vendsyssel FF	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217570021
5047	Trabzonspor	Caykur Rizespor	2023-08-26 17:15:00	https://www.orbitxch.com/customer/sport/1/market/1.217322246
5048	Wolfsberger AC	FC Salzburg	2023-08-26 16:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217059156
5049	Pardubice	Slovacko	2023-08-26 14:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217223365
5050	NEC	RKC	2023-08-26 17:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217172748
5051	Celtic	St Johnstone	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217304346
5052	FC Copenhagen	Silkeborg IF	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217334731
5053	Cangzhou Mighty Lions	Beijing Guoan	2023-08-26 12:35:00	https://www.orbitxch.com/customer/sport/1/market/1.217381104
5054	FC Ingolstadt	Saarbrucken	2023-08-26 13:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217368700
5055	Diosgyori VTK	Kisvarda FC	2023-08-26 16:45:00	https://www.orbitxch.com/customer/sport/1/market/1.217317177
5056	Airdrieonians	Inverness CT	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217305267
5057	Heidenheim	TSG Hoffenheim	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215730588
5058	Salford City	Accrington Stanley	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217056912
5059	SC Freiburg	Werder Bremen	2023-08-26 14:30:00	https://www.orbitxch.com/customer/sport/1/market/1.215653587
5060	Academico Viseu	Feirense	2023-08-26 11:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217301592
5061	Maidenhead Utd	Oxford City	2023-08-26 15:00:00	https://www.orbitxch.com/customer/sport/1/market/1.217056348
\N	Naestved IF	HB Køge	2023-09-04 18:00:00	\N
\N	Los Angeles FC	Inter Miami CF	2023-09-04 03:00:00	\N
\N	Philadelphia Union	New York Red Bulls	2023-09-04 00:30:00	\N
\.


--
-- TOC entry 3015 (class 0 OID 16493)
-- Dependencies: 208
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
-- TOC entry 3032 (class 0 OID 0)
-- Dependencies: 204
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."OverUnderHistorical_id_seq"', 279, true);


--
-- TOC entry 3033 (class 0 OID 0)
-- Dependencies: 203
-- Name: OverUnder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."OverUnder_id_seq"', 24889, true);


--
-- TOC entry 3034 (class 0 OID 0)
-- Dependencies: 207
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.daily_over_2p5_id_seq', 5061, true);


--
-- TOC entry 3035 (class 0 OID 0)
-- Dependencies: 209
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 16, true);


--
-- TOC entry 2878 (class 2606 OID 16541)
-- Name: daily_over_2p5 daily_over_2p5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_pkey PRIMARY KEY (id);


--
-- TOC entry 2880 (class 2606 OID 16543)
-- Name: daily_over_2p5 daily_over_2p5_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_unique UNIQUE (home, away, date_time);


--
-- TOC entry 2882 (class 2606 OID 16547)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 3026 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3027 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodaysBets" FROM postgres;
GRANT ALL ON TABLE public."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3028 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE daily_over_2p5; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5 FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5 TO postgres WITH GRANT OPTION;


--
-- TOC entry 3029 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE daily_over_2p5_historical; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5_historical FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5_historical TO postgres WITH GRANT OPTION;


--
-- TOC entry 1728 (class 826 OID 16567)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


-- Completed on 2023-09-05 16:31:19 BST

--
-- PostgreSQL database dump complete
--

