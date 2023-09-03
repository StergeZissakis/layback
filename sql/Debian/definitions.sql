--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-0+deb12u1)
-- Dumped by pg_dump version 15.3 (Debian 15.3-0+deb12u1)

-- Started on 2023-09-03 12:28:54 BST

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
-- TOC entry 3620 (class 1262 OID 5)
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
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 3620
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3622 (class 0 OID 0)
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
-- TOC entry 7 (class 2615 OID 16571)
-- Name: postgres; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA postgres;


--
-- TOC entry 2 (class 3079 OID 16572)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 937 (class 1247 OID 16583)
-- Name: ActionType; Type: TYPE; Schema: postgres; Owner: -
--

CREATE TYPE postgres."ActionType" AS ENUM (
    'Lay',
    'Back'
);


--
-- TOC entry 940 (class 1247 OID 16588)
-- Name: BetResult; Type: TYPE; Schema: postgres; Owner: -
--

CREATE TYPE postgres."BetResult" AS ENUM (
    'Won',
    'Lost'
);


--
-- TOC entry 943 (class 1247 OID 16594)
-- Name: MatchTime; Type: TYPE; Schema: postgres; Owner: -
--

CREATE TYPE postgres."MatchTime" AS ENUM (
    'Full Time',
    '1st Half',
    '2nd Half'
);


--
-- TOC entry 946 (class 1247 OID 16602)
-- Name: OverUnderType; Type: TYPE; Schema: postgres; Owner: -
--

CREATE TYPE postgres."OverUnderType" AS ENUM (
    'Over',
    'Under'
);


--
-- TOC entry 889 (class 1247 OID 16389)
-- Name: ActionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ActionType" AS ENUM (
    'Lay',
    'Back'
);


--
-- TOC entry 892 (class 1247 OID 16394)
-- Name: BetResult; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BetResult" AS ENUM (
    'Won',
    'Lost'
);


--
-- TOC entry 895 (class 1247 OID 16400)
-- Name: MatchTime; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."MatchTime" AS ENUM (
    'Full Time',
    '1st Half',
    '2nd Half'
);


--
-- TOC entry 898 (class 1247 OID 16408)
-- Name: OverUnderType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OverUnderType" AS ENUM (
    'Over',
    'Under'
);


--
-- TOC entry 262 (class 1255 OID 16607)
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
-- TOC entry 263 (class 1255 OID 16608)
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
-- TOC entry 275 (class 1255 OID 16609)
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
-- TOC entry 276 (class 1255 OID 16610)
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
-- TOC entry 277 (class 1255 OID 16611)
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
-- TOC entry 257 (class 1255 OID 16413)
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
-- TOC entry 258 (class 1255 OID 16414)
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
-- TOC entry 259 (class 1255 OID 16415)
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
-- TOC entry 260 (class 1255 OID 16416)
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
-- TOC entry 261 (class 1255 OID 16417)
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
-- TOC entry 235 (class 1259 OID 16612)
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
-- TOC entry 236 (class 1259 OID 16619)
-- Name: Match_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres."Match_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 236
-- Name: Match_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres."Match_id_seq" OWNED BY postgres."OddsPortalMatch".id;


--
-- TOC entry 237 (class 1259 OID 16620)
-- Name: OverUnder_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres."OverUnder_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 238 (class 1259 OID 16621)
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
-- TOC entry 239 (class 1259 OID 16629)
-- Name: OddsSafariMatch; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres."OddsSafariMatch" (
)
INHERITS (postgres."OddsPortalMatch");


--
-- TOC entry 240 (class 1259 OID 16636)
-- Name: OddsSafariOverUnder; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres."OddsSafariOverUnder" (
)
INHERITS (postgres."OddsPortalOverUnder");


--
-- TOC entry 241 (class 1259 OID 16644)
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres."OverUnderHistorical_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 242 (class 1259 OID 16645)
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
-- TOC entry 243 (class 1259 OID 16652)
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
-- TOC entry 244 (class 1259 OID 16656)
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
-- TOC entry 245 (class 1259 OID 16661)
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
-- TOC entry 246 (class 1259 OID 16667)
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
-- TOC entry 247 (class 1259 OID 16672)
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
-- TOC entry 248 (class 1259 OID 16677)
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
-- TOC entry 249 (class 1259 OID 16682)
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres.daily_over_2p5_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 249
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres.daily_over_2p5_id_seq OWNED BY postgres.daily_over_2p5.id;


--
-- TOC entry 250 (class 1259 OID 16683)
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
-- TOC entry 251 (class 1259 OID 16688)
-- Name: daily_over_under_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres.daily_over_under_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 251
-- Name: daily_over_under_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres.daily_over_under_id_seq OWNED BY postgres.daily_over_under.id;


--
-- TOC entry 252 (class 1259 OID 16689)
-- Name: hePublicKeys; Type: TABLE; Schema: postgres; Owner: -
--

CREATE TABLE postgres."hePublicKeys" (
    id bigint NOT NULL,
    url character varying NOT NULL,
    size character varying DEFAULT 0 NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 16695)
-- Name: hePublicKeys_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres."hePublicKeys_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 253
-- Name: hePublicKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres."hePublicKeys_id_seq" OWNED BY postgres."hePublicKeys".id;


--
-- TOC entry 254 (class 1259 OID 16696)
-- Name: over2p5bets_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres.over2p5bets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 254
-- Name: over2p5bets_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres.over2p5bets_id_seq OWNED BY postgres.over2p5bets.id;


--
-- TOC entry 255 (class 1259 OID 16697)
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
-- TOC entry 256 (class 1259 OID 16703)
-- Name: soccer_statistics_id_seq; Type: SEQUENCE; Schema: postgres; Owner: -
--

CREATE SEQUENCE postgres.soccer_statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 256
-- Name: soccer_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: postgres; Owner: -
--

ALTER SEQUENCE postgres.soccer_statistics_id_seq OWNED BY postgres.soccer_statistics.id;


--
-- TOC entry 216 (class 1259 OID 16418)
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
-- TOC entry 217 (class 1259 OID 16425)
-- Name: Match_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Match_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 217
-- Name: Match_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Match_id_seq" OWNED BY public."OddsPortalMatch".id;


--
-- TOC entry 218 (class 1259 OID 16426)
-- Name: OverUnder_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."OverUnder_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 219 (class 1259 OID 16427)
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
-- TOC entry 220 (class 1259 OID 16435)
-- Name: OddsSafariMatch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."OddsSafariMatch" (
)
INHERITS (public."OddsPortalMatch");


--
-- TOC entry 221 (class 1259 OID 16442)
-- Name: OddsSafariOverUnder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."OddsSafariOverUnder" (
)
INHERITS (public."OddsPortalOverUnder");


--
-- TOC entry 222 (class 1259 OID 16450)
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."OverUnderHistorical_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 223 (class 1259 OID 16451)
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
-- TOC entry 224 (class 1259 OID 16458)
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
-- TOC entry 225 (class 1259 OID 16462)
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
-- TOC entry 226 (class 1259 OID 16467)
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
-- TOC entry 227 (class 1259 OID 16472)
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
-- TOC entry 228 (class 1259 OID 16477)
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_over_2p5_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 228
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_over_2p5_id_seq OWNED BY public.daily_over_2p5.id;


--
-- TOC entry 229 (class 1259 OID 16478)
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
-- TOC entry 230 (class 1259 OID 16483)
-- Name: daily_over_under_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_over_under_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 230
-- Name: daily_over_under_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_over_under_id_seq OWNED BY public.daily_over_under.id;


--
-- TOC entry 231 (class 1259 OID 16484)
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
-- TOC entry 232 (class 1259 OID 16490)
-- Name: over2p5bets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.over2p5bets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 232
-- Name: over2p5bets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.over2p5bets_id_seq OWNED BY public.over2p5bets.id;


--
-- TOC entry 233 (class 1259 OID 16491)
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
-- TOC entry 234 (class 1259 OID 16497)
-- Name: soccer_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.soccer_statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3660 (class 0 OID 0)
-- Dependencies: 234
-- Name: soccer_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.soccer_statistics_id_seq OWNED BY public.soccer_statistics.id;


--
-- TOC entry 3370 (class 2604 OID 16704)
-- Name: OddsPortalMatch id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalMatch" ALTER COLUMN id SET DEFAULT nextval('postgres."Match_id_seq"'::regclass);


--
-- TOC entry 3376 (class 2604 OID 16705)
-- Name: OddsSafariMatch id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch" ALTER COLUMN id SET DEFAULT nextval('postgres."Match_id_seq"'::regclass);


--
-- TOC entry 3377 (class 2604 OID 16706)
-- Name: OddsSafariMatch created; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch" ALTER COLUMN created SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3378 (class 2604 OID 16707)
-- Name: OddsSafariMatch updated; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch" ALTER COLUMN updated SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3379 (class 2604 OID 16708)
-- Name: OddsSafariOverUnder id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder" ALTER COLUMN id SET DEFAULT nextval('postgres."OverUnder_id_seq"'::regclass);


--
-- TOC entry 3380 (class 2604 OID 16709)
-- Name: OddsSafariOverUnder created; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder" ALTER COLUMN created SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3381 (class 2604 OID 16710)
-- Name: OddsSafariOverUnder updated; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder" ALTER COLUMN updated SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3386 (class 2604 OID 16711)
-- Name: daily_over_2p5 id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_2p5 ALTER COLUMN id SET DEFAULT nextval('postgres.daily_over_2p5_id_seq'::regclass);


--
-- TOC entry 3387 (class 2604 OID 16712)
-- Name: daily_over_under id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_under ALTER COLUMN id SET DEFAULT nextval('postgres.daily_over_under_id_seq'::regclass);


--
-- TOC entry 3388 (class 2604 OID 16713)
-- Name: hePublicKeys id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."hePublicKeys" ALTER COLUMN id SET DEFAULT nextval('postgres."hePublicKeys_id_seq"'::regclass);


--
-- TOC entry 3384 (class 2604 OID 16714)
-- Name: over2p5bets id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.over2p5bets ALTER COLUMN id SET DEFAULT nextval('postgres.over2p5bets_id_seq'::regclass);


--
-- TOC entry 3390 (class 2604 OID 16715)
-- Name: soccer_statistics id; Type: DEFAULT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.soccer_statistics ALTER COLUMN id SET DEFAULT nextval('postgres.soccer_statistics_id_seq'::regclass);


--
-- TOC entry 3350 (class 2604 OID 16498)
-- Name: OddsPortalMatch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalMatch" ALTER COLUMN id SET DEFAULT nextval('public."Match_id_seq"'::regclass);


--
-- TOC entry 3356 (class 2604 OID 16499)
-- Name: OddsSafariMatch id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch" ALTER COLUMN id SET DEFAULT nextval('public."Match_id_seq"'::regclass);


--
-- TOC entry 3357 (class 2604 OID 16500)
-- Name: OddsSafariMatch created; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch" ALTER COLUMN created SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3358 (class 2604 OID 16501)
-- Name: OddsSafariMatch updated; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch" ALTER COLUMN updated SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3359 (class 2604 OID 16502)
-- Name: OddsSafariOverUnder id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder" ALTER COLUMN id SET DEFAULT nextval('public."OverUnder_id_seq"'::regclass);


--
-- TOC entry 3360 (class 2604 OID 16503)
-- Name: OddsSafariOverUnder created; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder" ALTER COLUMN created SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3361 (class 2604 OID 16504)
-- Name: OddsSafariOverUnder updated; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder" ALTER COLUMN updated SET DEFAULT CURRENT_TIMESTAMP;


--
-- TOC entry 3364 (class 2604 OID 16505)
-- Name: daily_over_2p5 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5 ALTER COLUMN id SET DEFAULT nextval('public.daily_over_2p5_id_seq'::regclass);


--
-- TOC entry 3365 (class 2604 OID 16506)
-- Name: daily_over_under id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_under ALTER COLUMN id SET DEFAULT nextval('public.daily_over_under_id_seq'::regclass);


--
-- TOC entry 3366 (class 2604 OID 16507)
-- Name: over2p5bets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets ALTER COLUMN id SET DEFAULT nextval('public.over2p5bets_id_seq'::regclass);


--
-- TOC entry 3368 (class 2604 OID 16508)
-- Name: soccer_statistics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.soccer_statistics ALTER COLUMN id SET DEFAULT nextval('public.soccer_statistics_id_seq'::regclass);


--
-- TOC entry 3426 (class 2606 OID 16717)
-- Name: OddsPortalMatch OddsPortalMatch_pk; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalMatch"
    ADD CONSTRAINT "OddsPortalMatch_pk" PRIMARY KEY (id);


--
-- TOC entry 3428 (class 2606 OID 16719)
-- Name: OddsPortalMatch OddsPortalMatch_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalMatch"
    ADD CONSTRAINT "OddsPortalMatch_unique" UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3430 (class 2606 OID 16721)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_pk; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_pk" PRIMARY KEY (id, match_id, half, type, goals);


--
-- TOC entry 3432 (class 2606 OID 16723)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_unique" UNIQUE (goals, match_id, half, type);


--
-- TOC entry 3435 (class 2606 OID 16725)
-- Name: OddsSafariMatch OddsSafariMatch_pk; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch"
    ADD CONSTRAINT "OddsSafariMatch_pk" PRIMARY KEY (id);


--
-- TOC entry 3437 (class 2606 OID 16727)
-- Name: OddsSafariMatch OddsSafariMatch_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariMatch"
    ADD CONSTRAINT "OddsSafariMatch_unique" UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3439 (class 2606 OID 16729)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_pk; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_pk" PRIMARY KEY (id);


--
-- TOC entry 3441 (class 2606 OID 16731)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_unique" UNIQUE (goals, match_id, half, type);


--
-- TOC entry 3445 (class 2606 OID 16733)
-- Name: OverUnderHistorical OverUnderHistorical_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OverUnderHistorical"
    ADD CONSTRAINT "OverUnderHistorical_pkey" PRIMARY KEY (id);


--
-- TOC entry 3449 (class 2606 OID 16735)
-- Name: daily_over_2p5 daily_over_2p5_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_pkey PRIMARY KEY (id);


--
-- TOC entry 3451 (class 2606 OID 16737)
-- Name: daily_over_2p5 daily_over_2p5_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_unique UNIQUE (home, away, date_time);


--
-- TOC entry 3453 (class 2606 OID 16739)
-- Name: daily_over_under daily_over_under_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.daily_over_under
    ADD CONSTRAINT daily_over_under_pkey PRIMARY KEY (id);


--
-- TOC entry 3455 (class 2606 OID 16741)
-- Name: hePublicKeys hePublicKeys_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."hePublicKeys"
    ADD CONSTRAINT "hePublicKeys_pkey" PRIMARY KEY (id);


--
-- TOC entry 3447 (class 2606 OID 16743)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 3457 (class 2606 OID 16745)
-- Name: soccer_statistics soccer_statistics_pkey; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.soccer_statistics
    ADD CONSTRAINT soccer_statistics_pkey PRIMARY KEY (id);


--
-- TOC entry 3459 (class 2606 OID 16747)
-- Name: soccer_statistics soccer_statistics_unique; Type: CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres.soccer_statistics
    ADD CONSTRAINT soccer_statistics_unique UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3393 (class 2606 OID 16510)
-- Name: OddsPortalMatch OddsPortalMatch_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalMatch"
    ADD CONSTRAINT "OddsPortalMatch_pk" PRIMARY KEY (id);


--
-- TOC entry 3395 (class 2606 OID 16512)
-- Name: OddsPortalMatch OddsPortalMatch_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalMatch"
    ADD CONSTRAINT "OddsPortalMatch_unique" UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3397 (class 2606 OID 16514)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_pk" PRIMARY KEY (id, match_id, half, type, goals);


--
-- TOC entry 3399 (class 2606 OID 16516)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_unique" UNIQUE (goals, match_id, half, type);


--
-- TOC entry 3402 (class 2606 OID 16518)
-- Name: OddsSafariMatch OddsSafariMatch_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch"
    ADD CONSTRAINT "OddsSafariMatch_pk" PRIMARY KEY (id);


--
-- TOC entry 3404 (class 2606 OID 16520)
-- Name: OddsSafariMatch OddsSafariMatch_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariMatch"
    ADD CONSTRAINT "OddsSafariMatch_unique" UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3406 (class 2606 OID 16522)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_pk" PRIMARY KEY (id);


--
-- TOC entry 3408 (class 2606 OID 16524)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_unique" UNIQUE (goals, match_id, half, type);


--
-- TOC entry 3412 (class 2606 OID 16526)
-- Name: OverUnderHistorical OverUnderHistorical_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OverUnderHistorical"
    ADD CONSTRAINT "OverUnderHistorical_pkey" PRIMARY KEY (id);


--
-- TOC entry 3414 (class 2606 OID 16528)
-- Name: daily_over_2p5 daily_over_2p5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_pkey PRIMARY KEY (id);


--
-- TOC entry 3416 (class 2606 OID 16530)
-- Name: daily_over_2p5 daily_over_2p5_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_unique UNIQUE (home, away, date_time);


--
-- TOC entry 3418 (class 2606 OID 16532)
-- Name: daily_over_under daily_over_under_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_under
    ADD CONSTRAINT daily_over_under_pkey PRIMARY KEY (id);


--
-- TOC entry 3420 (class 2606 OID 16534)
-- Name: over2p5bets over2p5bets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.over2p5bets
    ADD CONSTRAINT over2p5bets_pkey PRIMARY KEY (id);


--
-- TOC entry 3422 (class 2606 OID 16536)
-- Name: soccer_statistics soccer_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.soccer_statistics
    ADD CONSTRAINT soccer_statistics_pkey PRIMARY KEY (id);


--
-- TOC entry 3424 (class 2606 OID 16538)
-- Name: soccer_statistics soccer_statistics_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.soccer_statistics
    ADD CONSTRAINT soccer_statistics_unique UNIQUE (home_team, guest_team, date_time);


--
-- TOC entry 3433 (class 1259 OID 16748)
-- Name: fki_OddsPortalOverUnder_Match_fk; Type: INDEX; Schema: postgres; Owner: -
--

CREATE INDEX "fki_OddsPortalOverUnder_Match_fk" ON postgres."OddsPortalOverUnder" USING btree (match_id);


--
-- TOC entry 3442 (class 1259 OID 16749)
-- Name: fki_OddsSafariOverUnder_Match_fk; Type: INDEX; Schema: postgres; Owner: -
--

CREATE INDEX "fki_OddsSafariOverUnder_Match_fk" ON postgres."OddsSafariOverUnder" USING btree (match_id);


--
-- TOC entry 3443 (class 1259 OID 16750)
-- Name: fki_OddsSafariOverUnder_match_id_fk; Type: INDEX; Schema: postgres; Owner: -
--

CREATE INDEX "fki_OddsSafariOverUnder_match_id_fk" ON postgres."OddsSafariOverUnder" USING btree (match_id);


--
-- TOC entry 3400 (class 1259 OID 16539)
-- Name: fki_OddsPortalOverUnder_Match_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fki_OddsPortalOverUnder_Match_fk" ON public."OddsPortalOverUnder" USING btree (match_id);


--
-- TOC entry 3409 (class 1259 OID 16540)
-- Name: fki_OddsSafariOverUnder_Match_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fki_OddsSafariOverUnder_Match_fk" ON public."OddsSafariOverUnder" USING btree (match_id);


--
-- TOC entry 3410 (class 1259 OID 16541)
-- Name: fki_OddsSafariOverUnder_match_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fki_OddsSafariOverUnder_match_id_fk" ON public."OddsSafariOverUnder" USING btree (match_id);


--
-- TOC entry 3466 (class 2620 OID 16751)
-- Name: OddsPortalOverUnder update_updated_Match_trigger; Type: TRIGGER; Schema: postgres; Owner: -
--

CREATE TRIGGER "update_updated_Match_trigger" AFTER UPDATE ON postgres."OddsPortalOverUnder" FOR EACH ROW EXECUTE FUNCTION postgres."update_updated_on_Match"();


--
-- TOC entry 3467 (class 2620 OID 16752)
-- Name: OddsPortalOverUnder update_updated_OverUnder_trigger; Type: TRIGGER; Schema: postgres; Owner: -
--

CREATE TRIGGER "update_updated_OverUnder_trigger" AFTER UPDATE ON postgres."OddsPortalOverUnder" FOR EACH ROW EXECUTE FUNCTION postgres."update_updated_on_OverUnder"();


--
-- TOC entry 3464 (class 2620 OID 16542)
-- Name: OddsPortalOverUnder update_updated_Match_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER "update_updated_Match_trigger" AFTER UPDATE ON public."OddsPortalOverUnder" FOR EACH ROW EXECUTE FUNCTION public."update_updated_on_Match"();


--
-- TOC entry 3465 (class 2620 OID 16543)
-- Name: OddsPortalOverUnder update_updated_OverUnder_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER "update_updated_OverUnder_trigger" AFTER UPDATE ON public."OddsPortalOverUnder" FOR EACH ROW EXECUTE FUNCTION public."update_updated_on_OverUnder"();


--
-- TOC entry 3462 (class 2606 OID 16753)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_Match_fk; Type: FK CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_Match_fk" FOREIGN KEY (match_id) REFERENCES postgres."OddsPortalMatch"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3463 (class 2606 OID 16758)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_Match_fk; Type: FK CONSTRAINT; Schema: postgres; Owner: -
--

ALTER TABLE ONLY postgres."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_Match_fk" FOREIGN KEY (match_id) REFERENCES postgres."OddsSafariMatch"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3460 (class 2606 OID 16544)
-- Name: OddsPortalOverUnder OddsPortalOverUnder_Match_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsPortalOverUnder"
    ADD CONSTRAINT "OddsPortalOverUnder_Match_fk" FOREIGN KEY (match_id) REFERENCES public."OddsPortalMatch"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3461 (class 2606 OID 16549)
-- Name: OddsSafariOverUnder OddsSafariOverUnder_Match_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OddsSafariOverUnder"
    ADD CONSTRAINT "OddsSafariOverUnder_Match_fk" FOREIGN KEY (match_id) REFERENCES public."OddsSafariMatch"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE "OddsPortalMatch"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OddsPortalMatch" FROM postgres;


--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE "OddsPortalOverUnder"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OddsPortalOverUnder" FROM postgres;
GRANT ALL ON TABLE postgres."OddsPortalOverUnder" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3627 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE "OddsSafariMatch"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OddsSafariMatch" FROM postgres;
GRANT ALL ON TABLE postgres."OddsSafariMatch" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE "OddsSafariOverUnder"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OddsSafariOverUnder" FROM postgres;
GRANT ALL ON TABLE postgres."OddsSafariOverUnder" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE "OverUnderHistorical"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."OverUnderHistorical" FROM postgres;
GRANT ALL ON TABLE postgres."OverUnderHistorical" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE "PortalSafariMatch"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."PortalSafariMatch" FROM postgres;
GRANT ALL ON TABLE postgres."PortalSafariMatch" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE "PortalSafariBets"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."PortalSafariBets" FROM postgres;
GRANT ALL ON TABLE postgres."PortalSafariBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE over2p5bets; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.over2p5bets FROM postgres;
GRANT ALL ON TABLE postgres.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE "TodaysBets"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."TodaysBets" FROM postgres;
GRANT ALL ON TABLE postgres."TodaysBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 247
-- Name: TABLE daily_over_2p5; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.daily_over_2p5 FROM postgres;
GRANT ALL ON TABLE postgres.daily_over_2p5 TO postgres WITH GRANT OPTION;


--
-- TOC entry 3635 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE daily_over_2p5_historical; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.daily_over_2p5_historical FROM postgres;
GRANT ALL ON TABLE postgres.daily_over_2p5_historical TO postgres WITH GRANT OPTION;


--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE daily_over_under; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.daily_over_under FROM postgres;
GRANT ALL ON TABLE postgres.daily_over_under TO postgres WITH GRANT OPTION;


--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE "hePublicKeys"; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres."hePublicKeys" FROM postgres;
GRANT ALL ON TABLE postgres."hePublicKeys" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE soccer_statistics; Type: ACL; Schema: postgres; Owner: -
--

REVOKE ALL ON TABLE postgres.soccer_statistics FROM postgres;
GRANT ALL ON TABLE postgres.soccer_statistics TO postgres WITH GRANT OPTION;


--
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE "OddsPortalMatch"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OddsPortalMatch" FROM postgres;


--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE "OddsPortalOverUnder"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OddsPortalOverUnder" FROM postgres;
GRANT ALL ON TABLE public."OddsPortalOverUnder" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3647 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE "OddsSafariMatch"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OddsSafariMatch" FROM postgres;
GRANT ALL ON TABLE public."OddsSafariMatch" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3648 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE "OddsSafariOverUnder"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OddsSafariOverUnder" FROM postgres;
GRANT ALL ON TABLE public."OddsSafariOverUnder" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3649 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE "OverUnderHistorical"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."OverUnderHistorical" FROM postgres;
GRANT ALL ON TABLE public."OverUnderHistorical" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3650 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE "PortalSafariMatch"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."PortalSafariMatch" FROM postgres;
GRANT ALL ON TABLE public."PortalSafariMatch" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3651 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE "PortalSafariBets"; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public."PortalSafariBets" FROM postgres;
GRANT ALL ON TABLE public."PortalSafariBets" TO postgres WITH GRANT OPTION;


--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE daily_over_2p5; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5 FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5 TO postgres WITH GRANT OPTION;


--
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE daily_over_2p5_historical; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5_historical FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5_historical TO postgres WITH GRANT OPTION;


--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE daily_over_under; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_under FROM postgres;
GRANT ALL ON TABLE public.daily_over_under TO postgres WITH GRANT OPTION;


--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE over2p5bets; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.over2p5bets FROM postgres;
GRANT ALL ON TABLE public.over2p5bets TO postgres WITH GRANT OPTION;


--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE soccer_statistics; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.soccer_statistics FROM postgres;
GRANT ALL ON TABLE public.soccer_statistics TO postgres WITH GRANT OPTION;


--
-- TOC entry 2185 (class 826 OID 16554)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


-- Completed on 2023-09-03 12:28:54 BST

--
-- PostgreSQL database dump complete
--

