--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-04 21:33:26 BST

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
-- TOC entry 3015 (class 1262 OID 13465)
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
-- TOC entry 3016 (class 0 OID 0)
-- Dependencies: 3015
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3017 (class 0 OID 0)
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
-- TOC entry 3018 (class 0 OID 0)
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
-- TOC entry 3023 (class 0 OID 0)
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
-- TOC entry 3024 (class 0 OID 0)
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
-- TOC entry 3019 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3020 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodaysBets" FROM postgres;
GRANT ALL ON TABLE public."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3021 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE daily_over_2p5; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5 FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5 TO postgres WITH GRANT OPTION;


--
-- TOC entry 3022 (class 0 OID 0)
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


-- Completed on 2023-09-04 21:33:26 BST

--
-- PostgreSQL database dump complete
--

