--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-03 20:22:05 BST

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
-- TOC entry 3290 (class 1262 OID 13465)
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
-- TOC entry 3291 (class 0 OID 0)
-- Dependencies: 3290
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3292 (class 0 OID 0)
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
-- TOC entry 9 (class 2615 OID 16671)
-- Name: postgres; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA postgres;


--
-- TOC entry 1 (class 3079 OID 16584)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3293 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 749 (class 1247 OID 16673)
-- Name: ActionType; Type: TYPE; Schema: postgres; Owner: -
--

CREATE TYPE postgres."ActionType" AS ENUM (
    'Lay',
    'Back'
);


--
-- TOC entry 752 (class 1247 OID 16678)
-- Name: BetResult; Type: TYPE; Schema: postgres; Owner: -
--

CREATE TYPE postgres."BetResult" AS ENUM (
    'Won',
    'Lost'
);


--
-- TOC entry 755 (class 1247 OID 16684)
-- Name: MatchTime; Type: TYPE; Schema: postgres; Owner: -
--

CREATE TYPE postgres."MatchTime" AS ENUM (
    'Full Time',
    '1st Half',
    '2nd Half'
);


--
-- TOC entry 758 (class 1247 OID 16692)
-- Name: OverUnderType; Type: TYPE; Schema: postgres; Owner: -
--

CREATE TYPE postgres."OverUnderType" AS ENUM (
    'Over',
    'Under'
);


--
-- TOC entry 591 (class 1247 OID 16385)
-- Name: ActionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ActionType" AS ENUM (
    'Lay',
    'Back'
);


--
-- TOC entry 594 (class 1247 OID 16390)
-- Name: BetResult; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BetResult" AS ENUM (
    'Won',
    'Lost'
);


--
-- TOC entry 682 (class 1247 OID 16396)
-- Name: MatchTime; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."MatchTime" AS ENUM (
    'Full Time',
    '1st Half',
    '2nd Half'
);


--
-- TOC entry 685 (class 1247 OID 16404)
-- Name: OverUnderType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OverUnderType" AS ENUM (
    'Over',
    'Under'
);


--
-- TOC entry 253 (class 1255 OID 16697)
-- Name: ArchiveDailyOver2p5(); Type: FUNCTION; Schema: postgres; Owner: -
--

CREATE FUNCTION postgres."ArchiveDailyOver2p5"() RETURNS void
    LANGUAGE sql
    AS $$
INSERT INTO postgres."daily_over_2p5_historical" 
SELECT *
FROM postgres."daily_over_2p5";

DELETE FROM postgres."daily_over_2p5";

$$;


--
-- TOC entry 254 (class 1255 OID 16698)
-- Name: ArchivePastMatches(); Type: FUNCTION; Schema: postgres; Owner: -
--

CREATE FUNCTION postgres."ArchivePastMatches"() RETURNS void
    LANGUAGE sql
    AS $$
INSERT INTO postgres."OverUnderHistorical"("Home_Team", "Guest_Team", "Date_Time", "Type", "Half", "Goals", "Odds_bet", "Margin", "Payout", "Bet_link")
SELECT SPLIT_PART(Event, ' - ', 1), SPLIT_PART(Event, ' - ', 2), DateTime, Type, Half, Goals, SafariOdds, Margin, SafariPayout, bookie 
FROM   postgres."PortalSafariBets"
WHERE  DateTime + interval '5 hours' < now();

DELETE FROM postgres."OddsPortalMatch" where date_time + interval '5 hours' < now();
DELETE FROM postgres."OddsSafariMatch" where date_time + interval '5 hours' < now();$$;


--
-- TOC entry 267 (class 1255 OID 16699)
-- Name: CalculateOverUnderResults(); Type: FUNCTION; Schema: postgres; Owner: -
--

CREATE FUNCTION postgres."CalculateOverUnderResults"() RETURNS void
    LANGUAGE sql
    AS $$UPDATE	postgres."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals" + t."Guest_Team_Goals") > (t."Home_Team_Goals" + t."Guest_Team_Goals") AND  t."Type" = 'Over' AND t."Half" = 'Full Time';

UPDATE	postgres."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals" + t."Guest_Team_Goals") < (t."Home_Team_Goals" + t."Guest_Team_Goals") AND  t."Type" = 'Under' AND t."Half" = 'Full Time';

UPDATE	postgres."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals_1st_Half" + t."Guest_Team_Goals_1st_Half") > t."Goals" AND  t."Type" = 'Over' AND t."Half" = '1st Half';

UPDATE	postgres."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals_1st_Half" + t."Guest_Team_Goals_1st_Half") < t."Goals" AND  t."Type" = 'Over' AND t."Half" = '1st Half';

UPDATE	postgres."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals_2nd_Half" + t."Guest_Team_Goals_2nd_Half") > t."Goals" AND  t."Type" = 'Over' AND t."Half" = '2nd Half';

UPDATE	postgres."OverUnderHistorical" AS t SET Won = 'Won'
WHERE 	(t."Home_Team_Goals_2nd_Half" + t."Guest_Team_Goals_2nd_Half") < t."Goals" AND  t."Type" = 'Over' AND t."Half" = '2nd Half';

$$;


--
-- TOC entry 268 (class 1255 OID 16700)
-- Name: update_updated_on_Match(); Type: FUNCTION; Schema: postgres; Owner: -
--

CREATE FUNCTION postgres."update_updated_on_Match"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated = now();
    RETURN NEW;
END;
$$;


--
-- TOC entry 269 (class 1255 OID 16701)
-- Name: update_updated_on_OverUnder(); Type: FUNCTION; Schema: postgres; Owner: -
--

CREATE FUNCTION postgres."update_updated_on_OverUnder"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated = now();
    RETURN NEW;
END;
$$;


--
-- TOC entry 248 (class 1255 OID 16409)
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
-- TOC entry 249 (class 1255 OID 16410)
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
-- TOC entry 250 (class 1255 OID 16411)
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
-- TOC entry 251 (class 1255 OID 16412)
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
-- TOC entry 252 (class 1255 OID 16413)
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


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16702)
-- Name: OddsPortalMatch; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres."OddsPortalMatch" (
    id bigint NOT NULL,
    home_team character varying NOT NULL,
    guest_team character varying NOT NULL,
    date_time timestamp with time zone NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16710)
-- Name: Match_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres."Match_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3295 (class 0 OID 0)
-- Dependencies: 227
-- Name: Match_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres."Match_id_seq" OWNED BY postgres."OddsPortalMatch".id;


--
-- TOC entry 228 (class 1259 OID 16712)
-- Name: OverUnder_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres."OverUnder_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 229 (class 1259 OID 16714)
-- Name: OddsPortalOverUnder; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres."OddsPortalOverUnder" (
    id bigint DEFAULT nextval('postgres."OverUnder_id_seq"'::regclass) NOT NULL,
    goals numeric NOT NULL,
    odds numeric(100,2),
    match_id bigint NOT NULL,
    half postgres."MatchTime" NOT NULL,
    payout character varying,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type postgres."OverUnderType" NOT NULL,
    bet_links character varying[]
);


--
-- TOC entry 230 (class 1259 OID 16723)
-- Name: OddsSafariMatch; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres."OddsSafariMatch" (
)
INHERITS (postgres."OddsPortalMatch");


--
-- TOC entry 231 (class 1259 OID 16731)
-- Name: OddsSafariOverUnder; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres."OddsSafariOverUnder" (
)
INHERITS (postgres."OddsPortalOverUnder");


--
-- TOC entry 232 (class 1259 OID 16740)
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres."OverUnderHistorical_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 233 (class 1259 OID 16742)
-- Name: OverUnderHistorical; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres."OverUnderHistorical" (
    id bigint DEFAULT nextval('postgres."OverUnderHistorical_id_seq"'::regclass) NOT NULL,
    "Date_Time" timestamp with time zone NOT NULL,
    "Home_Team" character varying NOT NULL,
    "Guest_Team" character varying NOT NULL,
    "Type" postgres."OverUnderType" NOT NULL,
    "Half" postgres."MatchTime",
    "Odds_bet" numeric NOT NULL,
    "Margin" numeric NOT NULL,
    won postgres."BetResult" DEFAULT 'Lost'::postgres."BetResult" NOT NULL,
    "Goals" numeric NOT NULL,
    "Home_Team_Goals" smallint,
    "Guest_Team_Goals" smallint,
    "Home_Team_Goals_1st_Half" smallint,
    "Home_Team_Goals_2nd_Half" smallint,
    "Guest_Team_Goals_1st_Half" smallint,
    "Guest_Team_Goals_2nd_Half" smallint,
    "Payout" character varying NOT NULL,
    "Bet_link" character varying NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 16750)
-- Name: PortalSafariMatch; Type: VIEW; Schema: postgres; Owner: -
--

CREATE VIEW postgres."PortalSafariMatch" AS
 SELECT portal.id AS portal_id,
    portal.date_time AS portal_time,
    portal.home_team AS portal_home_team,
    portal.guest_team AS portal_guest_team,
    safari.id AS safari_id,
    safari.date_time AS safari_time,
    safari.home_team AS safari_home_team,
    safari.guest_team AS safari_guest_team
   FROM (postgres."OddsPortalMatch" portal
     JOIN postgres."OddsSafariMatch" safari ON ((portal.date_time = safari.date_time)))
  WHERE (((portal.home_team)::text = (safari.home_team)::text) AND ((portal.guest_team)::text = (safari.guest_team)::text))
  ORDER BY portal.date_time;


--
-- TOC entry 235 (class 1259 OID 16754)
-- Name: PortalSafariBets; Type: VIEW; Schema: postgres; Owner: -
--

CREATE VIEW postgres."PortalSafariBets" AS
 SELECT global_match.portal_time AS datetime,
    concat(global_match.portal_home_team, ' - ', global_match.portal_guest_team) AS event,
    portal_over_under.type,
    portal_over_under.half,
    portal_over_under.goals,
    portal_over_under.odds AS portalodds,
    safari_over_under.odds AS safariodds,
    (safari_over_under.odds - portal_over_under.odds) AS margin,
    portal_over_under.payout AS portalpayout,
    safari_over_under.payout AS safaripayout,
    safari_over_under.bet_links AS bookie
   FROM ((postgres."PortalSafariMatch" global_match
     JOIN postgres."OddsPortalOverUnder" portal_over_under ON ((global_match.portal_id = portal_over_under.match_id)))
     JOIN postgres."OddsSafariOverUnder" safari_over_under ON ((global_match.safari_id = safari_over_under.match_id)))
  WHERE ((portal_over_under.type = safari_over_under.type) AND (portal_over_under.half = safari_over_under.half) AND (portal_over_under.goals = safari_over_under.goals) AND (safari_over_under.odds >= portal_over_under.odds) AND (safari_over_under.odds >= 1.7))
  ORDER BY global_match.portal_time, (concat(global_match.portal_home_team, ' - ', global_match.portal_guest_team)), portal_over_under.type, portal_over_under.goals, portal_over_under.odds, safari_over_under.odds, (portal_over_under.odds - safari_over_under.odds) DESC;


--
-- TOC entry 236 (class 1259 OID 16759)
-- Name: over2p5bets; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres.over2p5bets (
    id bigint NOT NULL,
    "MatchDateTime" timestamp without time zone,
    "Home" character varying NOT NULL,
    "Away" character varying NOT NULL,
    "BetDateTime" timestamp without time zone DEFAULT now() NOT NULL,
    "LayBack" postgres."ActionType" NOT NULL,
    "OverUnder" postgres."OverUnderType" NOT NULL,
    "Goals" numeric(3,2) NOT NULL,
    "Odds" numeric(3,2) NOT NULL,
    "OddsRecorded" numeric(3,2) NOT NULL,
    "Amount" numeric NOT NULL,
    "BetResult" postgres."BetResult"
);


--
-- TOC entry 237 (class 1259 OID 16766)
-- Name: TodaysBets; Type: VIEW; Schema: postgres; Owner: -
--

CREATE VIEW postgres."TodaysBets" AS
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
   FROM (postgres.over2p5bets a
     FULL JOIN postgres.over2p5bets b ON ((((a."Home")::text = (b."Home")::text) AND ((a."Away")::text = (b."Away")::text) AND (a."LayBack" <> b."LayBack") AND (a."BetDateTime" <> b."BetDateTime") AND (b.id IS NULL))))
  WHERE (a."BetDateTime" >= '2023-08-26 00:00:00'::timestamp without time zone)
  ORDER BY a."BetDateTime", a.id;


--
-- TOC entry 238 (class 1259 OID 16771)
-- Name: daily_over_2p5; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres.daily_over_2p5 (
    id bigint NOT NULL,
    home character varying NOT NULL,
    away character varying NOT NULL,
    date_time timestamp without time zone NOT NULL,
    url character varying
);


--
-- TOC entry 239 (class 1259 OID 16777)
-- Name: daily_over_2p5_historical; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres.daily_over_2p5_historical (
    id bigint,
    home character varying NOT NULL,
    away character varying NOT NULL,
    date_time timestamp without time zone NOT NULL,
    url character varying
);


--
-- TOC entry 240 (class 1259 OID 16783)
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres.daily_over_2p5_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3306 (class 0 OID 0)
-- Dependencies: 240
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres.daily_over_2p5_id_seq OWNED BY postgres.daily_over_2p5.id;


--
-- TOC entry 241 (class 1259 OID 16785)
-- Name: daily_over_under; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres.daily_over_under (
    id bigint NOT NULL,
    home character varying NOT NULL,
    away character varying NOT NULL,
    date_time timestamp with time zone NOT NULL,
    url character varying
);


--
-- TOC entry 242 (class 1259 OID 16791)
-- Name: daily_over_under_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres.daily_over_under_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3308 (class 0 OID 0)
-- Dependencies: 242
-- Name: daily_over_under_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres.daily_over_under_id_seq OWNED BY postgres.daily_over_under.id;


--
-- TOC entry 243 (class 1259 OID 16793)
-- Name: hePublicKeys; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres."hePublicKeys" (
    id bigint NOT NULL,
    url character varying NOT NULL,
    size character varying DEFAULT 0 NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 16800)
-- Name: hePublicKeys_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres."hePublicKeys_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3310 (class 0 OID 0)
-- Dependencies: 244
-- Name: hePublicKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres."hePublicKeys_id_seq" OWNED BY postgres."hePublicKeys".id;


--
-- TOC entry 245 (class 1259 OID 16802)
-- Name: over2p5bets_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres.over2p5bets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3311 (class 0 OID 0)
-- Dependencies: 245
-- Name: over2p5bets_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres.over2p5bets_id_seq OWNED BY postgres.over2p5bets.id;


--
-- TOC entry 246 (class 1259 OID 16804)
-- Name: soccer_statistics; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres.soccer_statistics (
    id bigint NOT NULL,
    home_team character varying NOT NULL,
    guest_team character varying NOT NULL,
    date_time timestamp with time zone NOT NULL,
    goals_home smallint NOT NULL,
    goals_guest smallint NOT NULL,
    full_time_home_win_odds numeric,
    full_time_draw_odds numeric,
    full_time_guest_win_odds smallint,
    first_half_home_win_odds numeric,
    first_half_draw_odds numeric,
    second_half_goals_guest smallint,
    second_half_goals_home smallint,
    first_half_goals_guest smallint,
    first_half_goals_home smallint,
    first_half_guest_win_odds numeric,
    second_half_home_win_odds numeric,
    second_half_draw_odds numeric,
    second_half_guest_win_odds numeric,
    full_time_over_under_goals numeric[],
    full_time_over_odds numeric[],
    full_time_under_odds numeric[],
    first_half_over_under_goals numeric[],
    first_half_over_odds numeric[],
    first_half_under_odds numeric[],
    second_half_over_under_goals numeric[],
    second_half_over_odds numeric[],
    second_half_under_odds numeric[],
    url character varying,
    last_updated timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 16811)
-- Name: soccer_statistics_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres.soccer_statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3313 (class 0 OID 0)
-- Dependencies: 247
-- Name: soccer_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres.soccer_statistics_id_seq OWNED BY postgres.soccer_statistics.id;


--
-- TOC entry 204 (class 1259 OID 16414)
-- Name: OddsPortalMatch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."OddsPortalMatch" (
    id bigint NOT NULL,
    home_team character varying NOT NULL,
    guest_team character varying NOT NULL,
    date_time timestamp with time zone NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 16422)
-- Name: Match_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Match_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3315 (class 0 OID 0)
-- Dependencies: 205
-- Name: Match_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Match_id_seq" OWNED BY public."OddsPortalMatch".id;


--
-- TOC entry 206 (class 1259 OID 16424)
-- Name: OverUnder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."OverUnder_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 207 (class 1259 OID 16426)
-- Name: OddsPortalOverUnder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."OddsPortalOverUnder" (
    id bigint DEFAULT nextval('public."OverUnder_id_seq"'::regclass) NOT NULL,
    goals numeric NOT NULL,
    odds numeric(100,2),
    match_id bigint NOT NULL,
    half public."MatchTime" NOT NULL,
    payout character varying,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type public."OverUnderType" NOT NULL,
    bet_links character varying[]
);


--
-- TOC entry 208 (class 1259 OID 16435)
-- Name: OddsSafariMatch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."OddsSafariMatch" (
)
INHERITS (public."OddsPortalMatch");


--
-- TOC entry 209 (class 1259 OID 16443)
-- Name: OddsSafariOverUnder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."OddsSafariOverUnder" (
)
INHERITS (public."OddsPortalOverUnder");


--
-- TOC entry 210 (class 1259 OID 16452)
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."OverUnderHistorical_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 211 (class 1259 OID 16454)
-- Name: OverUnderHistorical; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."OverUnderHistorical" (
    id bigint DEFAULT nextval('public."OverUnderHistorical_id_seq"'::regclass) NOT NULL,
    "Date_Time" timestamp with time zone NOT NULL,
    "Home_Team" character varying NOT NULL,
    "Guest_Team" character varying NOT NULL,
    "Type" public."OverUnderType" NOT NULL,
    "Half" public."MatchTime",
    "Odds_bet" numeric NOT NULL,
    "Margin" numeric NOT NULL,
    won public."BetResult" DEFAULT 'Lost'::public."BetResult" NOT NULL,
    "Goals" numeric NOT NULL,
    "Home_Team_Goals" smallint,
    "Guest_Team_Goals" smallint,
    "Home_Team_Goals_1st_Half" smallint,
    "Home_Team_Goals_2nd_Half" smallint,
    "Guest_Team_Goals_1st_Half" smallint,
    "Guest_Team_Goals_2nd_Half" smallint,
    "Payout" character varying NOT NULL,
    "Bet_link" character varying NOT NULL
);


--
-- TOC entry 212 (class 1259 OID 16462)
-- Name: PortalSafariMatch; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."PortalSafariMatch" AS
 SELECT portal.id AS portal_id,
    portal.date_time AS portal_time,
    portal.home_team AS portal_home_team,
    portal.guest_team AS portal_guest_team,
    safari.id AS safari_id,
    safari.date_time AS safari_time,
    safari.home_team AS safari_home_team,
    safari.guest_team AS safari_guest_team
   FROM (public."OddsPortalMatch" portal
     JOIN public."OddsSafariMatch" safari ON ((portal.date_time = safari.date_time)))
  WHERE (((portal.home_team)::text = (safari.home_team)::text) AND ((portal.guest_team)::text = (safari.guest_team)::text))
  ORDER BY portal.date_time;


--
-- TOC entry 213 (class 1259 OID 16466)
-- Name: PortalSafariBets; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public."PortalSafariBets" AS
 SELECT global_match.portal_time AS datetime,
    concat(global_match.portal_home_team, ' - ', global_match.portal_guest_team) AS event,
    portal_over_under.type,
    portal_over_under.half,
    portal_over_under.goals,
    portal_over_under.odds AS portalodds,
    safari_over_under.odds AS safariodds,
    (safari_over_under.odds - portal_over_under.odds) AS margin,
    portal_over_under.payout AS portalpayout,
    safari_over_under.payout AS safaripayout,
    safari_over_under.bet_links AS bookie
   FROM ((public."PortalSafariMatch" global_match
     JOIN public."OddsPortalOverUnder" portal_over_under ON ((global_match.portal_id = portal_over_under.match_id)))
     JOIN public."OddsSafariOverUnder" safari_over_under ON ((global_match.safari_id = safari_over_under.match_id)))
  WHERE ((portal_over_under.type = safari_over_under.type) AND (portal_over_under.half = safari_over_under.half) AND (portal_over_under.goals = safari_over_under.goals) AND (safari_over_under.odds >= portal_over_under.odds) AND (safari_over_under.odds >= 1.7))
  ORDER BY global_match.portal_time, (concat(global_match.portal_home_team, ' - ', global_match.portal_guest_team)), portal_over_under.type, portal_over_under.goals, portal_over_under.odds, safari_over_under.odds, (portal_over_under.odds - safari_over_under.odds) DESC;


--
-- TOC entry 219 (class 1259 OID 16493)
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
-- TOC entry 223 (class 1259 OID 16593)
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
-- TOC entry 214 (class 1259 OID 16471)
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
-- TOC entry 215 (class 1259 OID 16477)
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
-- TOC entry 216 (class 1259 OID 16483)
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_over_2p5_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 216
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_over_2p5_id_seq OWNED BY public.daily_over_2p5.id;


--
-- TOC entry 217 (class 1259 OID 16485)
-- Name: daily_over_under; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_over_under (
    id bigint NOT NULL,
    home character varying NOT NULL,
    away character varying NOT NULL,
    date_time timestamp with time zone NOT NULL,
    url character varying
);


--
-- TOC entry 218 (class 1259 OID 16491)
-- Name: daily_over_under_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_over_under_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3328 (class 0 OID 0)
-- Dependencies: 218
-- Name: daily_over_under_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_over_under_id_seq OWNED BY public.daily_over_under.id;


--
-- TOC entry 224 (class 1259 OID 16598)
-- Name: hePublicKeys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."hePublicKeys" (
    id bigint NOT NULL,
    url character varying NOT NULL,
    size character varying DEFAULT 0 NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16605)
-- Name: hePublicKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."hePublicKeys_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3330 (class 0 OID 0)
-- Dependencies: 225
-- Name: hePublicKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."hePublicKeys_id_seq" OWNED BY public."hePublicKeys".id;


--
-- TOC entry 220 (class 1259 OID 16500)
-- Name: over2p5bets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5bets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3331 (class 0 OID 0)
-- Dependencies: 220
-- Name: over2p5bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5bets_id_seq OWNED BY public.over2p5bets.id;


--
-- TOC entry 221 (class 1259 OID 16502)
-- Name: soccer_statistics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.soccer_statistics (
    id bigint NOT NULL,
    home_team character varying NOT NULL,
    guest_team character varying NOT NULL,
    date_time timestamp with time zone NOT NULL,
    goals_home smallint NOT NULL,
    goals_guest smallint NOT NULL,
    full_time_home_win_odds numeric,
    full_time_draw_odds numeric,
    full_time_guest_win_odds smallint,
    first_half_home_win_odds numeric,
    first_half_draw_odds numeric,
    second_half_goals_guest smallint,
    second_half_goals_home smallint,
    first_half_goals_guest smallint,
    first_half_goals_home smallint,
    first_half_guest_win_odds numeric,
    second_half_home_win_odds numeric,
    second_half_draw_odds numeric,
    second_half_guest_win_odds numeric,
    full_time_over_under_goals numeric[],
    full_time_over_odds numeric[],
    full_time_under_odds numeric[],
    first_half_over_under_goals numeric[],
    first_half_over_odds numeric[],
    first_half_under_odds numeric[],
    second_half_over_under_goals numeric[],
    second_half_over_odds numeric[],
    second_half_under_odds numeric[],
    url character varying,
    last_updated timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 16509)
-- Name: soccer_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.soccer_statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3333 (class 0 OID 0)
-- Dependencies: 222
-- Name: soccer_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.soccer_statistics_id_seq OWNED BY public.soccer_statistics.id;


--
-- TOC entry 3055 (class 2604 OID 16885)
-- Name: OddsPortalMatch id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalMatch" ALTER COLUMN id SET DEFAULT nextval('postgres."Match_id_seq"'::regclass);


--
-- TOC entry 3059 (class 2604 OID 16886)
-- Name: OddsSafariMatch id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch" ALTER COLUMN id SET DEFAULT nextval('postgres."Match_id_seq"'::regclass);


--
-- TOC entry 3060 (class 2604 OID 16887)
-- Name: OddsSafariMatch created; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch" ALTER COLUMN created SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3061 (class 2604 OID 16888)
-- Name: OddsSafariMatch updated; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch" ALTER COLUMN updated SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3062 (class 2604 OID 16889)
-- Name: OddsSafariOverUnder id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder" ALTER COLUMN id SET DEFAULT nextval('postgres."OverUnder_id_seq"'::regclass);


--
-- TOC entry 3063 (class 2604 OID 16890)
-- Name: OddsSafariOverUnder created; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder" ALTER COLUMN created SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3064 (class 2604 OID 16891)
-- Name: OddsSafariOverUnder updated; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder" ALTER COLUMN updated SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3069 (class 2604 OID 16892)
-- Name: daily_over_2p5 id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_2p5 ALTER COLUMN id SET DEFAULT nextval('postgres.daily_over_2p5_id_seq'::regclass);


--
-- TOC entry 3070 (class 2604 OID 16893)
-- Name: daily_over_under id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_under ALTER COLUMN id SET DEFAULT nextval('postgres.daily_over_under_id_seq'::regclass);


--
-- TOC entry 3072 (class 2604 OID 16894)
-- Name: hePublicKeys id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."hePublicKeys" ALTER COLUMN id SET DEFAULT nextval('postgres."hePublicKeys_id_seq"'::regclass);


--
-- TOC entry 3068 (class 2604 OID 16895)
-- Name: over2p5bets id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.over2p5bets ALTER COLUMN id SET DEFAULT nextval('postgres.over2p5bets_id_seq'::regclass);


--
-- TOC entry 3074 (class 2604 OID 16896)
-- Name: soccer_statistics id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.soccer_statistics ALTER COLUMN id SET DEFAULT nextval('postgres.soccer_statistics_id_seq'::regclass);


--
-- TOC entry 3033 (class 2604 OID 16897)
-- Name: OddsPortalMatch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalMatch" ALTER COLUMN id SET DEFAULT nextval('public."Match_id_seq"'::regclass);


--
-- TOC entry 3037 (class 2604 OID 16898)
-- Name: OddsSafariMatch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch" ALTER COLUMN id SET DEFAULT nextval('public."Match_id_seq"'::regclass);


--
-- TOC entry 3038 (class 2604 OID 16899)
-- Name: OddsSafariMatch created; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch" ALTER COLUMN created SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3039 (class 2604 OID 16900)
-- Name: OddsSafariMatch updated; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch" ALTER COLUMN updated SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3040 (class 2604 OID 16901)
-- Name: OddsSafariOverUnder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder" ALTER COLUMN id SET DEFAULT nextval('public."OverUnder_id_seq"'::regclass);


--
-- TOC entry 3041 (class 2604 OID 16902)
-- Name: OddsSafariOverUnder created; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder" ALTER COLUMN created SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3042 (class 2604 OID 16903)
-- Name: OddsSafariOverUnder updated; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder" ALTER COLUMN updated SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3045 (class 2604 OID 16904)
-- Name: daily_over_2p5 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5 ALTER COLUMN id SET DEFAULT nextval('public.daily_over_2p5_id_seq'::regclass);


--
-- TOC entry 3046 (class 2604 OID 16905)
-- Name: daily_over_under id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_under ALTER COLUMN id SET DEFAULT nextval('public.daily_over_under_id_seq'::regclass);


--
-- TOC entry 3052 (class 2604 OID 16616)
-- Name: hePublicKeys id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."hePublicKeys" ALTER COLUMN id SET DEFAULT nextval('public."hePublicKeys_id_seq"'::regclass);


--
-- TOC entry 3048 (class 2604 OID 16906)
-- Name: over2p5bets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets ALTER COLUMN id SET DEFAULT nextval('public.over2p5bets_id_seq'::regclass);


--
-- TOC entry 3050 (class 2604 OID 16907)
-- Name: soccer_statistics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.soccer_statistics ALTER COLUMN id SET DEFAULT nextval('public.soccer_statistics_id_seq'::regclass);


--
-- TOC entry 3111 (class 2606 OID 16837)
-- Name: OddsPortalMatch OddsPortalMatch_pk; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalMatch"
    ADD CONSTRAINT "OddsPortalMatch_pk" PRIMARY KEY (id);


--
-- TOC entry 3113 (class 2606 OID 16839)
-- Name: OddsPortalMatch OddsPortalMatch_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalMatch"
    ADD CONSTRAINT "OddsPortalMatch_unique" UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3115 (class 2606 OID 16841)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_pk; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_pk" PRIMARY KEY (id, match_id, half, type, goals);


--
-- TOC entry 3117 (class 2606 OID 16843)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_unique" UNIQUE (goals, match_id, half, type);


--
-- TOC entry 3120 (class 2606 OID 16845)
-- Name: OddsSafariMatch OddsSafariMatch_pk; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch"
    ADD CONSTRAINT "OddsSafariMatch_pk" PRIMARY KEY (id);


--
-- TOC entry 3122 (class 2606 OID 16847)
-- Name: OddsSafariMatch OddsSafariMatch_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch"
    ADD CONSTRAINT "OddsSafariMatch_unique" UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3124 (class 2606 OID 16849)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_pk; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_pk" PRIMARY KEY (id);


--
-- TOC entry 3126 (class 2606 OID 16851)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_unique" UNIQUE (goals, match_id, half, type);


--
-- TOC entry 3130 (class 2606 OID 16853)
-- Name: OverUnderHistorical OverUnderHistorical_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OverUnderHistorical"
    ADD CONSTRAINT "OverUnderHistorical_pkey" PRIMARY KEY (id);


--
-- TOC entry 3134 (class 2606 OID 16855)
-- Name: daily_over_2p5 daily_over_2p5_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_pkey PRIMARY KEY (id);


--
-- TOC entry 3136 (class 2606 OID 16857)
-- Name: daily_over_2p5 daily_over_2p5_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_unique UNIQUE (home, away, date_time);


--
-- TOC entry 3138 (class 2606 OID 16859)
-- Name: daily_over_under daily_over_under_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_under
    ADD CONSTRAINT daily_over_under_pkey PRIMARY KEY (id);


--
-- TOC entry 3140 (class 2606 OID 16861)
-- Name: hePublicKeys hePublicKeys_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."hePublicKeys"
    ADD CONSTRAINT "hePublicKeys_pkey" PRIMARY KEY (id);


--
-- TOC entry 3132 (class 2606 OID 16863)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 3142 (class 2606 OID 16865)
-- Name: soccer_statistics soccer_statistics_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.soccer_statistics
    ADD CONSTRAINT soccer_statistics_pkey PRIMARY KEY (id);


--
-- TOC entry 3144 (class 2606 OID 16867)
-- Name: soccer_statistics soccer_statistics_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.soccer_statistics
    ADD CONSTRAINT soccer_statistics_unique UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3076 (class 2606 OID 16523)
-- Name: OddsPortalMatch OddsPortalMatch_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalMatch"
    ADD CONSTRAINT "OddsPortalMatch_pk" PRIMARY KEY (id);


--
-- TOC entry 3078 (class 2606 OID 16525)
-- Name: OddsPortalMatch OddsPortalMatch_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalMatch"
    ADD CONSTRAINT "OddsPortalMatch_unique" UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3080 (class 2606 OID 16527)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_pk" PRIMARY KEY (id, match_id, half, type, goals);


--
-- TOC entry 3082 (class 2606 OID 16529)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_unique" UNIQUE (goals, match_id, half, type);


--
-- TOC entry 3085 (class 2606 OID 16531)
-- Name: OddsSafariMatch OddsSafariMatch_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch"
    ADD CONSTRAINT "OddsSafariMatch_pk" PRIMARY KEY (id);


--
-- TOC entry 3087 (class 2606 OID 16533)
-- Name: OddsSafariMatch OddsSafariMatch_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch"
    ADD CONSTRAINT "OddsSafariMatch_unique" UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3089 (class 2606 OID 16535)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_pk" PRIMARY KEY (id);


--
-- TOC entry 3091 (class 2606 OID 16537)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_unique" UNIQUE (goals, match_id, half, type);


--
-- TOC entry 3095 (class 2606 OID 16539)
-- Name: OverUnderHistorical OverUnderHistorical_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OverUnderHistorical"
    ADD CONSTRAINT "OverUnderHistorical_pkey" PRIMARY KEY (id);


--
-- TOC entry 3097 (class 2606 OID 16541)
-- Name: daily_over_2p5 daily_over_2p5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_pkey PRIMARY KEY (id);


--
-- TOC entry 3099 (class 2606 OID 16543)
-- Name: daily_over_2p5 daily_over_2p5_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_unique UNIQUE (home, away, date_time);


--
-- TOC entry 3101 (class 2606 OID 16545)
-- Name: daily_over_under daily_over_under_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_under
    ADD CONSTRAINT daily_over_under_pkey PRIMARY KEY (id);


--
-- TOC entry 3109 (class 2606 OID 16620)
-- Name: hePublicKeys hePublicKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."hePublicKeys"
    ADD CONSTRAINT "hePublicKeys_pkey" PRIMARY KEY (id);


--
-- TOC entry 3103 (class 2606 OID 16547)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 3105 (class 2606 OID 16549)
-- Name: soccer_statistics soccer_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.soccer_statistics
    ADD CONSTRAINT soccer_statistics_pkey PRIMARY KEY (id);


--
-- TOC entry 3107 (class 2606 OID 16551)
-- Name: soccer_statistics soccer_statistics_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.soccer_statistics
    ADD CONSTRAINT soccer_statistics_unique UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3118 (class 1259 OID 16868)
-- Name: fki_OddsPortalOverUnder_Match_fk; Type: INDEX; Schema: postgres; Owner: -
--

CREATE INDEX "fki_OddsPortalOverUnder_Match_fk" ON postgres."OddsPortalOverUnder" USING btree (match_id);


--
-- TOC entry 3127 (class 1259 OID 16869)
-- Name: fki_OddsSafariOverUnder_Match_fk; Type: INDEX; Schema: postgres; Owner: -
--

CREATE INDEX "fki_OddsSafariOverUnder_Match_fk" ON postgres."OddsSafariOverUnder" USING btree (match_id);


--
-- TOC entry 3128 (class 1259 OID 16870)
-- Name: fki_OddsSafariOverUnder_match_id_fk; Type: INDEX; Schema: postgres; Owner: -
--

CREATE INDEX "fki_OddsSafariOverUnder_match_id_fk" ON postgres."OddsSafariOverUnder" USING btree (match_id);


--
-- TOC entry 3083 (class 1259 OID 16552)
-- Name: fki_OddsPortalOverUnder_Match_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fki_OddsPortalOverUnder_Match_fk" ON public."OddsPortalOverUnder" USING btree (match_id);


--
-- TOC entry 3092 (class 1259 OID 16553)
-- Name: fki_OddsSafariOverUnder_Match_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fki_OddsSafariOverUnder_Match_fk" ON public."OddsSafariOverUnder" USING btree (match_id);


--
-- TOC entry 3093 (class 1259 OID 16554)
-- Name: fki_OddsSafariOverUnder_match_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fki_OddsSafariOverUnder_match_id_fk" ON public."OddsSafariOverUnder" USING btree (match_id);


--
-- TOC entry 3151 (class 2620 OID 16871)
-- Name: OddsPortalOverUnder update_updated_Match_trigger; Type: TRIGGER; Schema: postgres; Owner: -
--

CREATE TRIGGER "update_updated_Match_trigger" AFTER UPDATE ON postgres."OddsPortalOverUnder" FOR EACH ROW EXECUTE FUNCTION postgres."update_updated_on_Match"();


--
-- TOC entry 3152 (class 2620 OID 16872)
-- Name: OddsPortalOverUnder update_updated_OverUnder_trigger; Type: TRIGGER; Schema: postgres; Owner: -
--

CREATE TRIGGER "update_updated_OverUnder_trigger" AFTER UPDATE ON postgres."OddsPortalOverUnder" FOR EACH ROW EXECUTE FUNCTION postgres."update_updated_on_OverUnder"();


--
-- TOC entry 3149 (class 2620 OID 16555)
-- Name: OddsPortalOverUnder update_updated_Match_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER "update_updated_Match_trigger" AFTER UPDATE ON public."OddsPortalOverUnder" FOR EACH ROW EXECUTE FUNCTION public."update_updated_on_Match"();


--
-- TOC entry 3150 (class 2620 OID 16556)
-- Name: OddsPortalOverUnder update_updated_OverUnder_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER "update_updated_OverUnder_trigger" AFTER UPDATE ON public."OddsPortalOverUnder" FOR EACH ROW EXECUTE FUNCTION public."update_updated_on_OverUnder"();


--
-- TOC entry 3147 (class 2606 OID 16875)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_Match_fk; Type: FK CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_Match_fk" FOREIGN KEY (match_id) REFERENCES postgres."OddsPortalMatch"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3148 (class 2606 OID 16880)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_Match_fk; Type: FK CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_Match_fk" FOREIGN KEY (match_id) REFERENCES postgres."OddsSafariMatch"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3145 (class 2606 OID 16557)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_Match_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_Match_fk" FOREIGN KEY (match_id) REFERENCES public."OddsPortalMatch"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3146 (class 2606 OID 16562)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_Match_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_Match_fk" FOREIGN KEY (match_id) REFERENCES public."OddsSafariMatch"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3294 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE "OddsPortalMatch"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OddsPortalMatch" FROM postgres;


--
-- TOC entry 3296 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE "OddsPortalOverUnder"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OddsPortalOverUnder" FROM postgres;
GRANT ALL ON TABLE postgres."OddsPortalOverUnder" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3297 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE "OddsSafariMatch"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OddsSafariMatch" FROM postgres;
GRANT ALL ON TABLE postgres."OddsSafariMatch" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3298 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE "OddsSafariOverUnder"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OddsSafariOverUnder" FROM postgres;
GRANT ALL ON TABLE postgres."OddsSafariOverUnder" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3299 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE "OverUnderHistorical"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OverUnderHistorical" FROM postgres;
GRANT ALL ON TABLE postgres."OverUnderHistorical" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3300 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE "PortalSafariMatch"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."PortalSafariMatch" FROM postgres;
GRANT ALL ON TABLE postgres."PortalSafariMatch" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3301 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE "PortalSafariBets"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."PortalSafariBets" FROM postgres;
GRANT ALL ON TABLE postgres."PortalSafariBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3302 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE over2p5bets; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.over2p5bets FROM postgres;
GRANT ALL ON TABLE postgres.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3303 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."TodaysBets" FROM postgres;
GRANT ALL ON TABLE postgres."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3304 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE daily_over_2p5; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.daily_over_2p5 FROM postgres;
GRANT ALL ON TABLE postgres.daily_over_2p5 TO postgres WITH GRANT OPTION;


--
-- TOC entry 3305 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE daily_over_2p5_historical; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.daily_over_2p5_historical FROM postgres;
GRANT ALL ON TABLE postgres.daily_over_2p5_historical TO postgres WITH GRANT OPTION;


--
-- TOC entry 3307 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE daily_over_under; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.daily_over_under FROM postgres;
GRANT ALL ON TABLE postgres.daily_over_under TO postgres WITH GRANT OPTION;


--
-- TOC entry 3309 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE "hePublicKeys"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."hePublicKeys" FROM postgres;
GRANT ALL ON TABLE postgres."hePublicKeys" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3312 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE soccer_statistics; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.soccer_statistics FROM postgres;
GRANT ALL ON TABLE postgres.soccer_statistics TO postgres WITH GRANT OPTION;


--
-- TOC entry 3314 (class 0 OID 0)
-- Dependencies: 204
-- Name: TABLE "OddsPortalMatch"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OddsPortalMatch" FROM postgres;


--
-- TOC entry 3316 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE "OddsPortalOverUnder"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OddsPortalOverUnder" FROM postgres;
GRANT ALL ON TABLE public."OddsPortalOverUnder" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3317 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE "OddsSafariMatch"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OddsSafariMatch" FROM postgres;
GRANT ALL ON TABLE public."OddsSafariMatch" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3318 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE "OddsSafariOverUnder"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OddsSafariOverUnder" FROM postgres;
GRANT ALL ON TABLE public."OddsSafariOverUnder" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3319 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE "OverUnderHistorical"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OverUnderHistorical" FROM postgres;
GRANT ALL ON TABLE public."OverUnderHistorical" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3320 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE "PortalSafariMatch"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."PortalSafariMatch" FROM postgres;
GRANT ALL ON TABLE public."PortalSafariMatch" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3321 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE "PortalSafariBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."PortalSafariBets" FROM postgres;
GRANT ALL ON TABLE public."PortalSafariBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3322 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3323 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."TodaysBets" FROM postgres;
GRANT ALL ON TABLE public."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3324 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE daily_over_2p5; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5 FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5 TO postgres WITH GRANT OPTION;


--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE daily_over_2p5_historical; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5_historical FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5_historical TO postgres WITH GRANT OPTION;


--
-- TOC entry 3327 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE daily_over_under; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_under FROM postgres;
GRANT ALL ON TABLE public.daily_over_under TO postgres WITH GRANT OPTION;


--
-- TOC entry 3329 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE "hePublicKeys"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."hePublicKeys" FROM postgres;
GRANT ALL ON TABLE public."hePublicKeys" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3332 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE soccer_statistics; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.soccer_statistics FROM postgres;
GRANT ALL ON TABLE public.soccer_statistics TO postgres WITH GRANT OPTION;


--
-- TOC entry 1885 (class 826 OID 16567)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


-- Completed on 2023-09-03 20:22:06 BST

--
-- PostgreSQL database dump complete
--

