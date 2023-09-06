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

--
-- TOC entry 3066 (class 0 OID 16471)
-- Dependencies: 205
-- Data for Name: daily_over_2p5; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3071 (class 0 OID 16985)
-- Dependencies: 211
-- Data for Name: match_table_prototype; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3068 (class 0 OID 16493)
-- Dependencies: 207
-- Data for Name: over2p5bets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (5, NULL, 'dummy', 'dummy', '2023-08-23 13:31:06.64272', 'Lay', 'Under', 2.50, 1.50, 1.28, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (6, NULL, 'dummy', 'dummy', '2023-08-23 13:31:10.10603', 'Back', 'Under', 2.50, 1.00, 1.26, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (7, NULL, 'FC Viktoria Köln', 'Rot-Weiss Essen', '2023-08-23 21:19:24.147703', 'Lay', 'Under', 1.50, 1.50, 1.53, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (8, NULL, 'FC Viktoria Köln', 'Rot-Weiss Essen', '2023-08-23 21:21:18.203664', 'Lay', 'Under', 1.50, 1.50, 1.42, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (9, NULL, 'FC Viktoria Köln', 'Rot-Weiss Essen', '2023-08-23 21:22:14.950051', 'Back', 'Under', 1.50, 1.50, 1.42, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (10, NULL, 'dummy', 'dummy', '2023-08-23 22:08:16.857423', 'Lay', 'Under', 1.50, 1.50, 2.14, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (11, NULL, 'dummy', 'dummy', '2023-08-23 22:11:21.875465', 'Back', 'Under', 2.50, 1.00, 1.26, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (12, NULL, 'dummy', 'dummy', '2023-08-23 22:35:37.360146', 'Lay', 'Under', 1.50, 1.50, 4.70, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (13, NULL, 'dummy', 'dummy', '2023-08-23 22:48:46.640338', 'Lay', 'Under', 2.50, 1.50, 2.60, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (15, NULL, 'FC Eindhoven', 'NAC', '2023-08-25 20:05:26.785306', 'Lay', 'Under', 2.50, 1.50, 2.10, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (16, NULL, 'FC Eindhoven', 'NAC', '2023-08-25 20:42:36.56641', 'Back', 'Under', 2.50, 1.00, 1.10, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (14, NULL, 'Schalke', 'Holstein Kiel', '2023-08-25 18:35:23.3757', 'Lay', 'Under', 2.50, 1.50, 2.40, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (17, NULL, 'Unterhaching', 'FC Viktoria Köln', '2023-08-26 14:08:31.67134', 'Lay', 'Under', 2.50, 1.50, 2.16, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (18, NULL, 'Pardubice', 'Slovacko', '2023-08-26 14:53:12.639809', 'Lay', 'Under', 2.50, 1.50, 1.88, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (19, NULL, 'Power Dynamos', 'African Stars Windhoek', '2023-08-26 15:02:43.487886', 'Lay', 'Under', 2.50, 1.50, 1.67, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (20, NULL, 'Bochum', 'Borussia Dortmund', '2023-08-26 15:34:28.232996', 'Lay', 'Under', 2.50, 1.50, 2.40, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (21, NULL, 'Power Dynamos', 'African Stars Windhoek', '2023-08-26 15:34:48.537574', 'Back', 'Under', 2.50, 1.00, 1.10, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (22, NULL, 'Heidenheim', 'TSG Hoffenheim', '2023-08-26 15:38:59.043165', 'Lay', 'Under', 2.50, 1.50, 2.24, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (23, NULL, 'Pardubice', 'Slovacko', '2023-08-26 15:41:19.928344', 'Back', 'Under', 2.50, 1.00, 1.11, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (24, NULL, 'Oxford Utd', 'Charlton', '2023-08-26 16:03:28.705916', 'Lay', 'Under', 2.50, 1.50, 2.08, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (25, NULL, 'Gateshead', 'Woking', '2023-08-26 16:10:43.925107', 'Lay', 'Under', 2.50, 1.50, 1.87, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (26, NULL, 'Aldershot', 'Wealdstone', '2023-08-26 16:10:59.778293', 'Lay', 'Under', 2.50, 1.50, 2.02, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (27, NULL, 'Oxford Utd', 'Charlton', '2023-08-26 16:24:32.457011', 'Back', 'Under', 2.50, 1.00, 1.33, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (28, NULL, 'SK Lisen', 'Hanacka Slavia Kromeriz', '2023-08-26 17:03:13.472264', 'Lay', 'Under', 2.50, 1.50, 2.06, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (29, NULL, 'SK Lisen', 'Hanacka Slavia Kromeriz', '2023-08-26 17:35:18.36182', 'Back', 'Under', 2.50, 1.00, 1.13, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (30, NULL, 'Krumovgrad', 'Lokomotiv 1929 Sofia', '2023-08-26 18:06:29.058861', 'Lay', 'Under', 2.50, 1.50, 1.60, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (31, NULL, 'Yverdon Sport FC', 'Servette', '2023-08-26 18:08:13.781206', 'Lay', 'Under', 2.50, 1.50, 2.14, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (32, NULL, 'Monza', 'Empoli', '2023-08-26 18:20:27.360705', 'Lay', 'Under', 2.50, 1.50, 1.83, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (33, NULL, 'Eupen', 'OH Leuven', '2023-08-26 18:21:14.070062', 'Lay', 'Under', 2.50, 1.50, 2.02, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (34, NULL, 'Kasimpasa', 'Pendikspor', '2023-08-26 18:24:29.368743', 'Lay', 'Under', 2.50, 1.50, 1.86, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (35, NULL, 'Krumovgrad', 'Lokomotiv 1929 Sofia', '2023-08-26 18:34:33.51482', 'Back', 'Under', 2.50, 1.00, 1.10, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (36, NULL, 'NEC', 'RKC', '2023-08-26 18:51:14.004835', 'Lay', 'Under', 2.50, 1.50, 2.10, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (37, NULL, 'Maccabi Netanya', 'Maccabi Bnei Raina', '2023-08-26 19:06:44.134102', 'Lay', 'Under', 2.50, 1.50, 1.85, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (38, NULL, 'NEC', 'RKC', '2023-08-26 19:23:18.919781', 'Back', 'Under', 2.50, 1.00, 1.13, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (39, NULL, 'Ujpest', 'Zalaegerszegi TE', '2023-08-26 20:07:14.746604', 'Lay', 'Under', 2.50, 1.50, 1.77, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (40, NULL, 'Como', 'AC Reggiana', '2023-08-26 20:20:12.937474', 'Lay', 'Under', 2.50, 1.50, 1.65, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (41, NULL, 'KV Kortrijk', 'Standard Liege', '2023-08-26 20:51:14.490536', 'Lay', 'Under', 2.50, 1.50, 2.06, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (42, NULL, 'Excelsior', 'Fortuna Sittard', '2023-08-26 21:02:29.31157', 'Lay', 'Under', 2.50, 1.50, 1.91, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (43, NULL, 'PSG', 'Lens', '2023-08-26 21:08:15.557908', 'Lay', 'Under', 2.50, 1.50, 1.93, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (44, NULL, 'KV Kortrijk', 'Standard Liege', '2023-08-26 21:18:19.147548', 'Back', 'Under', 2.50, 1.00, 1.26, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (45, NULL, 'Excelsior', 'Fortuna Sittard', '2023-08-26 21:25:33.119001', 'Back', 'Under', 2.50, 1.00, 1.27, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (48, NULL, 'Hapoel Umm Al Fahm', 'Hapoel Umm Al Fahm', '2023-08-28 17:47:00.016907', 'Lay', 'Under', 1.50, 1.50, 1.74, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (49, NULL, 'Vejle', 'Vejle', '2023-08-28 19:13:51.695857', 'Lay', 'Under', 1.50, 1.50, 1.52, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (50, NULL, 'Vejle', 'Vejle', '2023-08-28 19:41:27.938099', 'Lay', 'Under', 2.50, 1.50, 1.06, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (51, NULL, 'Vejle', 'Vejle', '2023-08-28 19:42:59.754929', 'Back', 'Under', 2.50, 1.00, 1.05, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (52, '2023-08-28 19:00:00', 'Giresunspor', 'Bandirmaspor', '2023-08-28 20:10:11.453416', 'Lay', 'Under', 2.50, 1.50, 1.73, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (53, '2023-08-28 19:00:00', 'Giresunspor', 'Bandirmaspor', '2023-08-28 20:40:20.007184', 'Back', 'Under', 2.50, 1.00, 1.13, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (54, '2023-08-30 17:30:00', 'Pogon Szczecin', 'Slask Wroclaw', '2023-08-30 18:39:03.298965', 'Lay', 'Under', 2.50, 1.50, 2.28, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (55, '2023-08-30 20:00:00', 'AEK Athens', 'Antwerp', '2023-08-30 21:05:51.594146', 'Lay', 'Under', 1.50, 1.50, 1.83, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (56, '2023-08-30 20:00:00', 'PSV', 'Rangers', '2023-08-30 21:08:06.045835', 'Lay', 'Under', 2.50, 1.50, 2.10, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (57, '2023-08-30 20:00:00', 'AEK Athens', 'Antwerp', '2023-08-30 21:46:02.655204', 'Back', 'Under', 1.50, 1.50, 1.48, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (58, '2023-08-31 17:00:00', 'HJK Helsinki', 'Farul Constanta', '2023-08-31 18:06:05.820979', 'Lay', 'Under', 2.50, 1.50, 1.63, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (59, '2023-08-31 17:00:00', 'HJK Helsinki', 'Farul Constanta', '2023-08-31 18:41:15.473242', 'Back', 'Under', 2.50, 1.00, 1.52, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (60, '2023-08-31 17:45:00', 'Breidablik', 'FC Struga Trim & Lum', '2023-08-31 18:50:51.267824', 'Lay', 'Under', 2.50, 1.50, 1.84, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (61, '2023-08-31 18:00:00', 'Viktoria Plzen', 'Tobol Kostanay', '2023-08-31 19:07:36.838141', 'Lay', 'Under', 2.50, 1.50, 2.00, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (62, '2023-08-31 18:00:00', 'Apoel Nicosia', 'Gent', '2023-08-31 19:10:07.669752', 'Lay', 'Under', 2.50, 1.50, 1.76, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (63, '2023-08-31 18:00:00', 'FC Twente', 'Fenerbahce', '2023-08-31 19:13:22.223835', 'Lay', 'Under', 1.50, 1.50, 1.86, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (64, '2023-08-31 17:45:00', 'Breidablik', 'FC Struga Trim & Lum', '2023-08-31 19:17:59.524112', 'Back', 'Under', 2.50, 1.00, 1.14, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (65, '2023-08-31 18:00:00', 'Viktoria Plzen', 'Tobol Kostanay', '2023-08-31 19:41:46.435676', 'Back', 'Under', 2.50, 1.00, 1.49, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (66, '2023-08-31 18:00:00', 'FC Twente', 'Fenerbahce', '2023-08-31 19:49:32.433628', 'Back', 'Under', 1.50, 1.50, 1.45, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (67, '2023-08-31 19:00:00', 'BATE Borisov', 'KF Ballkani', '2023-08-31 20:04:51.931013', 'Lay', 'Under', 2.50, 1.50, 1.73, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (68, '2023-08-31 19:00:00', 'NK Celje', 'Maccabi Tel Aviv', '2023-08-31 20:05:37.109055', 'Lay', 'Under', 2.50, 1.50, 1.87, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (69, '2023-08-31 19:00:00', 'Besiktas', 'Dynamo Kyiv', '2023-08-31 20:06:21.491612', 'Lay', 'Under', 1.50, 1.50, 1.95, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (70, '2023-08-31 19:00:00', 'Ajax', 'Ludogorets Razgrad', '2023-08-31 20:06:53.297341', 'Lay', 'Under', 1.50, 1.50, 1.94, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (71, '2023-08-31 19:00:00', 'Fiorentina', 'Rapid Vienna', '2023-08-31 20:08:08.030322', 'Lay', 'Under', 1.50, 1.50, 2.76, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (72, '2023-08-31 19:00:00', 'Adana Demirspor', 'Genk', '2023-08-31 20:20:09.713914', 'Lay', 'Under', 2.50, 1.50, 2.06, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (73, '2023-08-31 19:15:00', 'HNK Rijeka', 'Lille', '2023-08-31 20:23:51.92046', 'Lay', 'Under', 1.50, 1.50, 1.69, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (74, '2023-08-31 19:00:00', 'BATE Borisov', 'KF Ballkani', '2023-08-31 20:35:00.403919', 'Back', 'Under', 2.50, 1.00, 1.13, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (75, '2023-08-31 19:30:00', 'Lugano', 'Union Saint Gilloise', '2023-08-31 20:38:07.514487', 'Lay', 'Under', 2.50, 1.50, 1.91, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (76, '2023-08-31 19:00:00', 'NK Celje', 'Maccabi Tel Aviv', '2023-08-31 20:40:46.531653', 'Back', 'Under', 2.50, 1.00, 1.52, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (77, '2023-08-31 19:30:00', 'Eintracht Frankfurt', 'Levski Sofia', '2023-08-31 20:41:23.060925', 'Lay', 'Under', 1.50, 1.50, 1.68, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (78, '2023-08-31 19:30:00', 'Club Brugge', 'Osasuna', '2023-08-31 20:41:52.790398', 'Lay', 'Under', 2.50, 1.50, 1.63, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (79, '2023-08-31 19:00:00', 'Besiktas', 'Dynamo Kyiv', '2023-08-31 20:43:32.501581', 'Back', 'Under', 1.50, 1.50, 1.51, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (80, '2023-08-31 19:00:00', 'Ajax', 'Ludogorets Razgrad', '2023-08-31 20:45:04.292601', 'Back', 'Under', 1.50, 1.50, 1.44, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (81, '2023-08-31 19:00:00', 'Fiorentina', 'Rapid Vienna', '2023-08-31 20:45:18.926556', 'Back', 'Under', 1.50, 1.50, 1.52, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (82, '2023-08-31 19:00:00', 'Adana Demirspor', 'Genk', '2023-08-31 20:49:17.94391', 'Back', 'Under', 2.50, 1.00, 1.14, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (83, '2023-08-31 20:00:00', 'Partizan Belgrade', 'FC Nordsjaelland', '2023-08-31 21:06:08.018614', 'Lay', 'Under', 2.50, 1.50, 1.83, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (84, '2023-08-31 19:30:00', 'Lugano', 'Union Saint Gilloise', '2023-08-31 21:07:15.777576', 'Back', 'Under', 2.50, 1.00, 1.14, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (85, '2023-08-31 19:30:00', 'Eintracht Frankfurt', 'Levski Sofia', '2023-08-31 21:07:30.689661', 'Back', 'Under', 1.50, 1.00, 1.13, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (86, '2023-08-31 20:00:00', 'Zrinjski Mostar', 'LASK Linz', '2023-08-31 21:08:22.311831', 'Lay', 'Under', 2.50, 1.50, 1.60, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (87, '2023-08-31 20:00:00', 'Legia Warsaw', 'Midtjylland', '2023-08-31 21:10:52.5968', 'Lay', 'Under', 1.50, 1.50, 1.57, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (88, '2023-08-31 20:00:00', 'Partizan Belgrade', 'FC Nordsjaelland', '2023-08-31 21:32:17.410008', 'Back', 'Under', 2.50, 1.00, 1.13, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (89, '2023-08-31 20:00:00', 'Zrinjski Mostar', 'LASK Linz', '2023-08-31 21:44:32.424994', 'Back', 'Under', 2.50, 1.00, 1.50, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (90, '2023-09-01 11:00:00', 'Daejeon Hana Citizen', 'Suwon FC', '2023-09-01 12:06:50.135008', 'Lay', 'Under', 2.50, 1.50, 2.22, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (91, '2023-09-01 11:00:00', 'Daejeon Hana Citizen', 'Suwon FC', '2023-09-01 12:39:00.653155', 'Back', 'Under', 2.50, 1.00, 1.12, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (92, '2023-09-01 16:00:00', 'Al Taee', 'Abha', '2023-09-01 17:13:06.453458', 'Lay', 'Under', 1.50, 1.50, 1.76, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (93, '2023-09-01 16:00:00', 'Al Taee', 'Abha', '2023-09-01 17:41:15.635818', 'Back', 'Under', 1.50, 1.00, 1.14, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (94, '2023-09-01 17:00:00', 'Resovia Rzeszow', 'Termalica BB Nieciecza', '2023-09-01 18:11:51.221068', 'Lay', 'Under', 2.50, 1.50, 2.10, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (95, '2023-09-01 17:30:00', 'Eintracht Braunschweig', 'St Pauli', '2023-09-01 18:39:04.91302', 'Lay', 'Under', 1.50, 1.50, 1.93, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (96, '2023-09-01 18:00:00', 'AC Horsens', 'B93 Copenhagen', '2023-09-01 19:05:05.312783', 'Lay', 'Under', 1.50, 1.50, 2.02, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (97, '2023-09-01 18:00:00', 'Vendsyssel FF', 'FC Fredericia', '2023-09-01 19:05:20.645749', 'Lay', 'Under', 1.50, 1.50, 2.22, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (98, '2023-09-01 18:00:00', 'Skeid', 'Asane', '2023-09-01 19:05:35.469657', 'Lay', 'Under', 1.50, 1.50, 1.99, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (101, '2023-09-01 18:00:00', 'AC Horsens', 'B93 Copenhagen', '2023-09-01 19:34:13.786876', 'Back', 'Under', 1.50, 1.00, 1.14, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (99, '2023-09-01 18:00:00', 'Saarbrucken', 'Borussia Dortmund II', '2023-09-01 19:07:51.615755', 'Lay', 'Under', 2.50, 1.50, 1.97, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (100, '2023-09-01 18:00:00', 'Hillerød', 'Sonderjyske', '2023-09-01 19:10:52.320153', 'Lay', 'Under', 2.50, 1.50, 2.06, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (102, '2023-09-01 18:00:00', 'Saarbrucken', 'Borussia Dortmund II', '2023-09-01 19:43:01.398217', 'Back', 'Under', 2.50, 1.00, 1.46, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (103, '2023-09-01 18:00:00', 'Vendsyssel FF', 'FC Fredericia', '2023-09-01 19:43:31.514338', 'Back', 'Under', 1.50, 1.50, 1.51, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (104, '2023-09-01 19:00:00', 'Al Ittihad Jeddah', 'Al Hilal Riyadh', '2023-09-01 20:06:22.667395', 'Lay', 'Under', 1.50, 1.50, 1.54, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (105, '2023-09-01 19:00:00', 'Helmond Sport', 'Cambuur Leeuwarden', '2023-09-01 20:07:52.723178', 'Lay', 'Under', 2.50, 1.50, 1.86, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (106, '2023-09-01 19:00:00', 'VVV', 'De Graafschap', '2023-09-01 20:08:10.448192', 'Lay', 'Under', 2.50, 1.50, 2.18, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (107, '2023-09-01 19:00:00', 'Sparta Rotterdam', 'NEC', '2023-09-01 20:08:38.986956', 'Lay', 'Under', 1.50, 1.50, 1.86, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (108, '2023-09-01 19:00:00', 'Caykur Rizespor', 'Fatih Karagumruk', '2023-09-01 20:08:55.215379', 'Lay', 'Under', 2.50, 1.50, 1.78, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (109, '2023-09-01 19:00:00', 'Telstar', 'FC Eindhoven', '2023-09-01 20:09:08.50325', 'Lay', 'Under', 1.50, 1.50, 1.72, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (110, '2023-09-01 19:00:00', 'Zulte-Waregem', 'FCV Dender EH', '2023-09-01 20:09:39.510243', 'Lay', 'Under', 2.50, 1.50, 2.34, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (111, '2023-09-01 19:00:00', 'Slaven Belupo', 'NK Lokomotiva Zagreb', '2023-09-01 20:10:10.391471', 'Lay', 'Under', 1.50, 1.50, 1.63, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (112, '2023-09-01 19:00:00', 'FC Utrecht Reserves', 'Roda JC', '2023-09-01 20:11:54.678343', 'Lay', 'Under', 2.50, 1.50, 1.99, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (113, '2023-09-01 19:00:00', 'Caykur Rizespor', 'Fatih Karagumruk', '2023-09-01 20:38:04.401263', 'Back', 'Under', 2.50, 1.00, 1.13, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (114, '2023-09-01 19:00:00', 'Zulte-Waregem', 'FCV Dender EH', '2023-09-01 20:41:49.785543', 'Back', 'Under', 2.50, 1.00, 1.12, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (115, '2023-09-01 19:00:00', 'Slaven Belupo', 'NK Lokomotiva Zagreb', '2023-09-01 20:42:20.433782', 'Back', 'Under', 1.50, 1.50, 1.49, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (116, '2023-09-01 19:00:00', 'Al Ittihad Jeddah', 'Al Hilal Riyadh', '2023-09-01 20:42:34.942111', 'Back', 'Under', 1.50, 1.50, 1.49, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (117, '2023-09-01 19:00:00', 'Helmond Sport', 'Cambuur Leeuwarden', '2023-09-01 20:45:04.278033', 'Back', 'Under', 2.50, 1.00, 1.50, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (118, '2023-09-01 19:00:00', 'Telstar', 'FC Eindhoven', '2023-09-01 20:45:20.806975', 'Back', 'Under', 1.50, 1.50, 1.50, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (119, '2023-09-01 19:00:00', 'VVV', 'De Graafschap', '2023-09-01 20:45:22.339204', 'Back', 'Under', 2.50, 1.00, 1.49, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (120, '2023-09-01 19:00:00', 'FC Utrecht Reserves', 'Roda JC', '2023-09-01 20:49:05.761916', 'Back', 'Under', 2.50, 1.00, 1.51, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (121, '2023-09-01 19:45:00', 'Drogheda United', 'UCD', '2023-09-01 20:52:04.628352', 'Lay', 'Under', 2.50, 1.50, 1.80, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (122, '2023-09-01 19:45:00', 'Drogheda United', 'UCD', '2023-09-01 21:26:13.919098', 'Back', 'Under', 2.50, 1.00, 1.50, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (127, '2023-09-03 14:30:00', 'Eintracht Frankfurt', 'Cologne', '2023-09-03 15:39:56.42434', 'Lay', 'Under', 2.50, 1.50, 1.62, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (128, '2023-09-03 14:30:00', 'Eintracht Frankfurt', 'Cologne', '2023-09-03 16:09:02.479735', 'Back', 'Under', 2.50, 1.00, 1.12, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (129, '2023-09-03 15:45:00', 'Vitesse', 'AZ', '2023-09-03 16:53:56.036388', 'Lay', 'Under', 1.50, 1.50, 1.84, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (130, '2023-09-03 18:15:00', 'Charleroi', 'Sint-Truidense', '2023-09-03 19:20:49.841339', 'Lay', 'Under', 1.50, 1.50, 1.87, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (131, '2023-09-03 18:15:00', 'Charleroi', 'Sint-Truidense', '2023-09-03 19:48:57.658322', 'Back', 'Under', 1.50, 1.00, 1.12, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (123, '2023-09-03 13:30:00', 'FC Volendam', 'FC Twente', '2023-09-03 14:38:26.428093', 'Lay', 'Under', 2.50, 1.50, 2.06, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (124, '2023-09-03 13:30:00', 'Fortuna Sittard', 'Ajax', '2023-09-03 14:42:11.893245', 'Lay', 'Under', 1.50, 1.50, 1.97, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (125, '2023-09-03 13:30:00', 'Fortuna Sittard', 'Ajax', '2023-09-03 15:11:18.079473', 'Back', 'Under', 1.50, 1.00, 1.11, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (126, '2023-09-03 13:30:00', 'FC Volendam', 'FC Twente', '2023-09-03 15:16:34.556346', 'Back', 'Under', 2.50, 1.00, 1.39, 1, NULL);


--
-- TOC entry 3075 (class 0 OID 17015)
-- Dependencies: 215
-- Data for Name: over2p5footballsupertips; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (2, 'Sonderjyske', 'Vejle', '2023-09-06 19:00:00', NULL);


--
-- TOC entry 3073 (class 0 OID 17004)
-- Dependencies: 213
-- Data for Name: over2p5goalsnow; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (1, 'Dalum', 'FC Fredericia', '2023-09-06 16:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (2, 'Fjordager IF', 'Hvidovre IF', '2023-09-06 16:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (3, 'IF Lyseng', 'Middelfart', '2023-09-06 16:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (4, 'Viby', 'VSK Aarhus', '2023-09-06 16:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (5, 'Hillerød', 'Lyngby', '2023-09-06 17:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (6, 'Skjold', 'FC Helsingor', '2023-09-06 17:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (7, 'AB Tårnby', 'Nykobing', '2023-09-06 18:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (8, 'Sonderjyske', 'Vejle', '2023-09-06 19:00:00', NULL);


--
-- TOC entry 3077 (class 0 OID 17026)
-- Dependencies: 217
-- Data for Name: over2p5orbitxch; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (241, 'TJ Sokol Zubrohlava', 'Ruzomberok', '2023-09-06 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217954543', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (242, 'Unicov', 'MFK Karvina', '2023-09-06 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217949649', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (243, 'SK Kladno', 'Varnsdorf', '2023-09-06 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217949829', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (244, 'Arsenal Ceska Lipa', 'MFK Chrudim', '2023-09-06 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217949739', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (245, 'Hlinsko', 'Lisen', '2023-09-06 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217954074', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (246, 'FK Spartak Sobeslav', 'Hradec Kralove', '2023-09-06 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217949559', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (247, 'TJ Sokol Zapy', 'MAS Taborsko', '2023-09-06 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217949469', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (248, 'Arsenal (W)', 'Linkopings FC (W)', '2023-09-06 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217962616', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (249, 'Gintra (W)', 'Cardiff City FC (W)', '2023-09-06 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217969729', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (252, 'VfB Oldenburg', 'SV Meppen', '2023-09-06 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217953534', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (253, 'IF Magni', 'KFS', '2023-09-06 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217963294', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (254, 'Hillerod Fodbold', 'Lyngby', '2023-09-06 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217968802', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (251, 'Georgia U21', 'Gibraltar U21', '2023-09-06 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217825677', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (255, 'Saudi Arabia U23', 'Mongolia U23', '2023-09-06 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217962104', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (256, 'Eintracht Frankfurt (W)', '1 FC Slovacko (W)', '2023-09-06 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217962796', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (258, 'Koge (W)', 'KuPs (W)', '2023-09-06 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217962706', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (257, 'Simmeringer', 'SV Donau', '2023-09-06 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217978750', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (263, 'Twente (W)', 'Sturm Graz (W)', '2023-09-06 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217962886', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (262, 'SV Fortuna Magdeburg', 'FSV Saxonia Tangermunde', '2023-09-06 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217978569', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (261, 'FC Luzern U19', 'FC Aarau U19', '2023-09-06 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217979074', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (260, 'Dynamo Schwerin', 'Optik Rathenow', '2023-09-06 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217953134', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (264, 'Hapoel Jerusalem (W)', 'Maccabi Kishronot Hadera (W', '2023-09-06 18:20:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217979167', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (269, 'Norderstedt', 'Teutonia 05 Ottensen', '2023-09-06 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217953624', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (265, 'SV Auersmacher', 'SV Morlautern', '2023-09-06 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217968180', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (267, 'Arminia Ludwigshafen', 'TSG Pfeddersheim', '2023-09-06 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217953444', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (270, 'SV Gonsenheim', 'FC Bitburg', '2023-09-06 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217953044', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (271, 'Karlbergs BK', 'Viggbyholms IK FF', '2023-09-06 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217954723', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (268, 'Wormatia Worms', 'FC Cosmos Koblenz', '2023-09-06 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217952954', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (266, 'FC Kaiserslautern II', 'Spvgg Quierschied', '2023-09-06 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217953224', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (276, 'Jordan U23', 'Brunei Darussalam U23', '2023-09-06 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217977688', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (272, 'Anderlecht (W)', 'GKS Katowice (W)', '2023-09-06 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217962976', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (274, 'FC Arlanda', 'Kvarnsvedens IK', '2023-09-06 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217968622', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (277, 'FC Minsk (W)', 'Valerenga (W)', '2023-09-06 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217971442', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (273, 'Malta', 'Gibraltar', '2023-09-06 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217893076', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (278, 'Linfield (W)', 'Larne (W)', '2023-09-06 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217960981', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (281, 'Havant and W', 'Eastbourne', '2023-09-06 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217886552', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (280, 'Derry City (W)', 'Mid Ulster (W)', '2023-09-06 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217961071', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (279, 'UCD', 'Derry City', '2023-09-06 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217765113', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (284, 'Limon Black Star', 'Futbol Consultants Moravia', '2023-09-06 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217968360', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (286, 'Real Soacha Cundinamarca FC', 'Leones FC', '2023-09-06 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217932812', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (285, 'Tigres FC Zipaquira', 'Bogota', '2023-09-06 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217913754', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (283, 'Municipal Santa Ana', 'Escorpiones FC', '2023-09-06 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217968270', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (287, 'PFA Antioquia FC', 'Puerto Golfito F.C', '2023-09-06 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217977888', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (282, 'Libya', 'Equatorial Guinea', '2023-09-06 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217954813', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (288, 'Quepos Cambute', 'ADR Jicaral', '2023-09-06 20:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217968450', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (289, 'Molinos El Pirata', 'Deportivo Llacuabamba', '2023-09-06 21:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217964246', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (290, 'Club Nueve de Octubre', 'Chacaritas SC', '2023-09-06 21:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217940646', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (292, 'Fraijanes FC', 'CD Heredia', '2023-09-06 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217983235', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (291, 'Orsomarso', 'Quindio', '2023-09-06 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217913664', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (293, 'Envigado', 'America de Cali S.A', '2023-09-06 22:05:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217935775', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (294, 'CD Luis Angel Firpo', 'Santa Tecla', '2023-09-06 22:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217958612', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (296, 'Jocoro', 'Once Municipal', '2023-09-06 22:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217958522', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (297, 'Cuniburo FC', 'Manta FC', '2023-09-06 22:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217942062', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (295, 'CD Aguila', 'Fuerte San Francisco', '2023-09-06 22:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217958432', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (298, 'America MG U20', 'Cruzeiro U20', '2023-09-06 23:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217983055', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (275, 'SonderjyskE', 'Vejle', '2023-09-06 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217968712', true);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (299, 'Laos U23', 'Australia U23', '2023-09-06 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218004948', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (250, 'Bahrain U23', 'Palestine U23', '2023-09-06 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217874828', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (259, 'Eintracht Trier', 'Rot-Weiss Koblenz', '2023-09-06 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217953314', false);


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
-- Dependencies: 210
-- Name: match_table_prototype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.match_table_prototype_id_seq', 1, false);


--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 208
-- Name: over2p5bets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 16, true);


--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 214
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 15, true);


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 212
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 75, true);


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 216
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 348, true);


-- Completed on 2023-09-06 19:37:04 BST

--
-- PostgreSQL database dump complete
--

