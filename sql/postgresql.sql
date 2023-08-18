--
-- PostgreSQL database dump
--

-- Dumped from database version 13.11 (Debian 13.11-0+deb11u1)
-- Dumped by pg_dump version 13.11 (Debian 13.11-0+deb11u1)

-- Started on 2023-08-18 06:40:16 BST

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
-- TOC entry 3022 (class 1262 OID 13445)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_GB.UTF-8';


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
-- TOC entry 631 (class 1247 OID 16385)
-- Name: BetResult; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BetResult" AS ENUM (
    'Won',
    'Lost'
);


--
-- TOC entry 634 (class 1247 OID 16390)
-- Name: MatchTime; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."MatchTime" AS ENUM (
    'Full Time',
    '1st Half',
    '2nd Half'
);


--
-- TOC entry 637 (class 1247 OID 16398)
-- Name: OverUnderType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OverUnderType" AS ENUM (
    'Over',
    'Under'
);


--
-- TOC entry 206 (class 1255 OID 16901)
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
-- TOC entry 205 (class 1255 OID 16403)
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
-- TOC entry 207 (class 1255 OID 16405)
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
-- TOC entry 208 (class 1255 OID 16406)
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
-- TOC entry 201 (class 1259 OID 16455)
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."OverUnderHistorical_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 200 (class 1259 OID 16427)
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
-- TOC entry 203 (class 1259 OID 16850)
-- Name: daily_over_2p5; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_over_2p5 (
    id bigint NOT NULL,
    home character varying NOT NULL,
    away character varying NOT NULL,
    date_time timestamp with time zone NOT NULL,
    url character varying
);


--
-- TOC entry 204 (class 1259 OID 16902)
-- Name: daily_over_2p5_historical; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_over_2p5_historical (
    id bigint NOT NULL,
    home character varying NOT NULL,
    away character varying NOT NULL,
    date_time timestamp with time zone NOT NULL,
    url character varying
);


--
-- TOC entry 202 (class 1259 OID 16848)
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_over_2p5_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3026 (class 0 OID 0)
-- Dependencies: 202
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_over_2p5_id_seq OWNED BY public.daily_over_2p5.id;


--
-- TOC entry 2877 (class 2604 OID 16853)
-- Name: daily_over_2p5 id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5 ALTER COLUMN id SET DEFAULT nextval('public.daily_over_2p5_id_seq'::regclass);


--
-- TOC entry 3015 (class 0 OID 16850)
-- Dependencies: 203
-- Data for Name: daily_over_2p5; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.daily_over_2p5 (id, home, away, date_time, url) FROM stdin;
380	Utsiktens BK	Västerås SK FK	2023-08-18 18:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216931805
381	Metz	Marseille	2023-08-18 20:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216940204
382	Suwon Bluewings	Jeju United	2023-08-18 11:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217020664
383	NAC	AZ Reserves	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217055520
384	AaB	Naestved IF	2023-08-18 17:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217023132
385	JJK	MP	2023-08-18 16:30:00+01	\N
386	Defensa y Justicia	Godoy Cruz	2023-08-18 20:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216920673
387	Antalyaspor	Konyaspor	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216551896
388	Zaglebie Lubin	Puszcza Niepolomice	2023-08-18 17:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216995755
389	Telstar	Cambuur Leeuwarden	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217055068
390	B93 Copenhagen	FC Fredericia	2023-08-18 18:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217023222
391	OH Leuven	Antwerp	2023-08-18 19:45:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216995524
392	Hvidovre IF	FC Copenhagen	2023-08-18 18:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216976289
393	HIFK	EIF	2023-08-18 16:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216992799
394	FCV Dender EH	Anderlecht II	2023-08-18 19:00:00+01	\N
395	AC Horsens	FC Helsingor	2023-08-18 18:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217023402
396	Maritimo	AVS	2023-08-18 18:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217076650
397	Breitenrain	Young Boys	2023-08-18 18:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217219753
398	Maastricht	FC Eindhoven	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217055428
399	Willem II	FC Dordrecht	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217055338
400	LDU Quito	El Nacional	2023-08-18 23:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217020340
401	Deportivo Maldonado	Plaza Colonia	2023-08-18 23:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217152154
402	ADO Den Haag	Roda JC	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217055248
403	Alianza Atletico	Union Comercio	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217227087
404	Top Oss	PSV Reserves	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217054888
405	Wisla Krakow	Odra Opole	2023-08-18 19:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216981097
406	Lommel	Club Brugge II	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217071942
407	Al Akhdoud	Al Fateh SC	2023-08-18 16:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217213019
408	Gornik Zabrze	Widzew Lodz	2023-08-18 19:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216992443
409	Puskas Academy	MOL Fehervar FC	2023-08-18 17:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217076028
410	Leeds	West Brom	2023-08-18 20:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216838262
411	Werder Bremen	Bayern Munich	2023-08-18 19:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.215651423
412	Zalaegerszegi TE	Diosgyori VTK	2023-08-18 19:15:00+01	\N
413	Kolding IF	Sonderjyske	2023-08-18 18:00:00+01	\N
414	Al-Nassr Riyadh	Al Taawon Buraidah	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217115944
415	Etoile Carouge	FC Sion	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217218909
416	Wehen SV	Karlsruher SC	2023-08-18 17:30:00+01	\N
417	Zhejiang	Qingdao Hainiu	2023-08-18 12:35:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217027536
418	FC Emmen	VVV	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217054978
419	Istanbulspor	Kayserispor	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217208560
420	Heracles	NEC	2023-08-18 19:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216876851
421	Puntarenas	AD Carmelita	2023-08-18 03:00:00+01	\N
422	Kaiserslautern	Elversberg	2023-08-18 17:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216610184
423	Sandhausen	Dynamo Dresden	2023-08-18 18:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.216995845
424	Shanghai Port	Meizhou Hakka	2023-08-18 12:35:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217110456
\.


--
-- TOC entry 3016 (class 0 OID 16902)
-- Dependencies: 204
-- Data for Name: daily_over_2p5_historical; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.daily_over_2p5_historical (id, home, away, date_time, url) FROM stdin;
321	x	y	2023-08-16 05:58:03.343672+01	u
322	x	y	2023-08-16 05:58:03.798301+01	u
323	x	y	2023-08-16 05:58:04.210902+01	u
321	x	y	2023-08-16 05:58:03.343672+01	u
322	x	y	2023-08-16 05:58:03.798301+01	u
323	x	y	2023-08-16 05:58:04.210902+01	u
324	AD San Carlos	Escorpiones de Belen FC	2023-08-16 02:45:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217147875
325	Man City	Sevilla	2023-08-16 20:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.215192739
326	Mushuc Runa	Guayaquil City	2023-08-16 22:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217005481
327	Boreham Wood	Solihull Moors	2023-08-16 19:45:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217030255
328	Philadelphia Union	Inter Miami CF	2023-08-16 00:00:00+01	\N
329	AD San Carlos	Escorpiones de Belen FC	2023-08-16 02:45:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217147875
330	Mushuc Runa	Guayaquil City	2023-08-16 22:30:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217005481
331	Man City	Sevilla	2023-08-16 20:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.215192739
332	Philadelphia Union	Inter Miami CF	2023-08-16 00:00:00+01	\N
333	Boreham Wood	Solihull Moors	2023-08-16 19:45:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217030255
357	Lincoln Red Imps FC	KF Ballkani	2023-08-17 17:00:00+01	https://www.orbitxch.com/customer/sport/1/market/1.217191417
\.


--
-- TOC entry 3027 (class 0 OID 0)
-- Dependencies: 201
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."OverUnderHistorical_id_seq"', 279, true);


--
-- TOC entry 3028 (class 0 OID 0)
-- Dependencies: 200
-- Name: OverUnder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."OverUnder_id_seq"', 24889, true);


--
-- TOC entry 3029 (class 0 OID 0)
-- Dependencies: 202
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.daily_over_2p5_id_seq', 424, true);


--
-- TOC entry 2879 (class 2606 OID 16858)
-- Name: daily_over_2p5 daily_over_2p5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_pkey PRIMARY KEY (id);


--
-- TOC entry 2881 (class 2606 OID 16860)
-- Name: daily_over_2p5 daily_over_2p5_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_over_2p5
    ADD CONSTRAINT daily_over_2p5_unique UNIQUE (home, away, date_time);


--
-- TOC entry 3024 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE daily_over_2p5; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5 FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5 TO postgres WITH GRANT OPTION;


--
-- TOC entry 3025 (class 0 OID 0)
-- Dependencies: 204
-- Name: TABLE daily_over_2p5_historical; Type: ACL; Schema: public; Owner: -
--

REVOKE ALL ON TABLE public.daily_over_2p5_historical FROM postgres;
GRANT ALL ON TABLE public.daily_over_2p5_historical TO postgres WITH GRANT OPTION;


--
-- TOC entry 1734 (class 826 OID 16531)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


-- Completed on 2023-08-18 06:40:16 BST

--
-- PostgreSQL database dump complete
--

