--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-14 21:40:18 BST

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
-- TOC entry 3066 (class 0 OID 16471)
-- Dependencies: 205
-- Data for Name: daily_over_2p5; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3071 (class 0 OID 16985)
-- Dependencies: 210
-- Data for Name: match_table_prototype; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3068 (class 0 OID 16493)
-- Dependencies: 207
-- Data for Name: over2p5bets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetMatchTime") VALUES (18, '2023-09-06 19:00:00', 'SonderjyskE', 'Vejle', '2023-09-06 20:15:04.824315', 'Lay', 'Under', 2.50, 1.50, 1.64, 1, NULL, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetMatchTime") VALUES (19, '2023-09-06 19:00:00', 'SonderjyskE', 'Vejle', '2023-09-06 20:38:40.392177', 'Back', 'Under', 2.50, 1.00, 1.12, 1, NULL, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetMatchTime") VALUES (20, '2023-09-08 19:45:00', 'Turkey', 'Armenia', '2023-09-08 21:12:52.123619', 'Lay', 'Under', 2.50, 1.50, 1.44, 1, NULL, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetMatchTime") VALUES (21, '2023-09-08 19:45:00', 'Turkey', 'Armenia', '2023-09-08 21:27:16.909669', 'Back', 'Under', 2.50, 1.00, 1.13, 1, NULL, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetMatchTime") VALUES (22, '2023-09-09 19:45:00', 'Romania', 'Israel', '2023-09-09 20:00:01.58423', 'Lay', 'Under', 2.50, 1.50, 1.71, 1, NULL, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult", "BetMatchTime") VALUES (23, '2023-09-09 19:45:00', 'Romania', 'Israel', '2023-09-09 21:27:19.539354', 'Back', 'Under', 2.50, 1.00, 1.52, 1, NULL, NULL);


--
-- TOC entry 3075 (class 0 OID 17015)
-- Dependencies: 214
-- Data for Name: over2p5footballsupertips; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3073 (class 0 OID 17004)
-- Dependencies: 212
-- Data for Name: over2p5goalsnow; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3077 (class 0 OID 17026)
-- Dependencies: 216
-- Data for Name: over2p5orbitxch; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 204
-- Name: OverUnderHistorical_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."OverUnderHistorical_id_seq"', 279, true);


--
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 203
-- Name: OverUnder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."OverUnder_id_seq"', 24889, true);


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 206
-- Name: daily_over_2p5_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.daily_over_2p5_id_seq', 5061, true);


--
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 209
-- Name: match_table_prototype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.match_table_prototype_id_seq', 1, false);


--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 208
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 23, true);


--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 213
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 326, true);


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 211
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 448, true);


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 215
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 2830, true);


-- Completed on 2023-09-14 21:40:18 BST

--
-- PostgreSQL database dump complete
--

