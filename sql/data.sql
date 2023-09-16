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

INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (327, 'HB Køge', 'Kolding IF', '2023-09-14 18:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (328, 'Westerlo', 'Antwerp', '2023-09-15 19:45:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (329, 'Genk II', 'Zulte-Waregem', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (330, 'RFC Liege', 'Club Brugge II', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (331, 'Viborg', 'Midtjylland', '2023-09-15 18:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (332, 'Hobro IK', 'AC Horsens', '2023-09-15 18:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (333, 'Sonderjyske', 'AaB', '2023-09-15 18:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (334, 'Hillerød', 'B93 Copenhagen', '2023-09-15 18:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (335, 'Bayern Munich', 'Bayer Leverkusen', '2023-09-15 19:30:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (336, 'FC Dordrecht', 'FC Utrecht Reserves', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (337, 'Helmond Sport', 'Top Oss', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (338, 'Ajax Reserves', 'FC Emmen', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (339, 'AZ Reserves', 'FC Eindhoven', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (340, 'FC Groningen', 'ADO Den Haag', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (341, 'PSV Reserves', 'De Graafschap', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (342, 'FC Den Bosch', 'Maastricht', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (343, 'Roda JC', 'Telstar', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (344, 'VVV', 'NAC', '2023-09-15 19:00:00', NULL);


--
-- TOC entry 3073 (class 0 OID 17004)
-- Dependencies: 212
-- Data for Name: over2p5goalsnow; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (449, 'HB Køge', 'Kolding IF', '2023-09-14 18:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (450, 'Bayern Munich', 'Bayer Leverkusen', '2023-09-15 19:30:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (451, 'Westerlo', 'Antwerp', '2023-09-15 19:45:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (452, 'Genk II', 'Zulte-Waregem', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (453, 'RFC Liege', 'Club Brugge II', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (454, 'Sonderjyske', 'AaB', '2023-09-15 18:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (455, 'Hillerød', 'B93 Copenhagen', '2023-09-15 18:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (456, 'FC Dordrecht', 'FC Utrecht Reserves', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (457, 'Ajax Reserves', 'FC Emmen', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (458, 'FC Groningen', 'ADO Den Haag', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (459, 'PSV Reserves', 'De Graafschap', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (460, 'FC Den Bosch', 'Maastricht', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (461, 'Roda JC', 'Telstar', '2023-09-15 19:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (462, 'VVV', 'NAC', '2023-09-15 19:00:00', NULL);


--
-- TOC entry 3077 (class 0 OID 17026)
-- Dependencies: 216
-- Data for Name: over2p5orbitxch; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2945, 'SonderjyskE', 'AaB', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217961564', true);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2994, 'Jong PSV Eindhoven', 'De Graafschap', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218084970', true);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3006, 'ASO Chlef', 'MC Oran', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218272136', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2831, 'Rionegro', 'Union Magdalena', '2023-09-14 23:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2832, 'Coritiba', 'Bahia', '2023-09-15 00:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2833, 'Deportivo Cali', 'Atletico Huila', '2023-09-15 00:40:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2834, 'Ferroviaria (W)', 'Palmeiras (W)', '2023-09-15 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2835, 'Guayaquil SC', 'Manta FC', '2023-09-15 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2836, 'EC Realidade Jovem (W)', 'Sao Paulo (W)', '2023-09-15 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2837, 'EC Sao Jose (W)', 'EC Taubate (W)', '2023-09-15 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2838, 'Santos FC (W)', 'Pinda SC (W)', '2023-09-15 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2839, 'CA Independiente', 'Huracan', '2023-09-15 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2840, 'Bragantino SP', 'Gremio', '2023-09-15 01:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2841, 'Village Superstars', 'Conaree United', '2023-09-15 02:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2842, 'Universidad Guadalajara', 'Dorados', '2023-09-15 02:05:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2843, 'CD Victoria', 'Vida', '2023-09-15 02:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2844, 'Alianza Petrolera', 'Junior FC Barranquilla', '2023-09-15 02:50:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2845, 'FC Juarez (W)', 'Puebla FC (W)', '2023-09-15 04:06:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218219999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2846, 'PSM Makassar', 'PS Barito Putera', '2023-09-15 09:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218276171', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2847, 'FC Spartak Trnava U19', 'Dukla Banska Bystrica U19', '2023-09-15 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218294690', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2848, 'Slovan Bratislava U19', 'FK AS Trencin U19', '2023-09-15 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218294780', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2849, 'Ispe FC', 'Rakhine Utd', '2023-09-15 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218276261', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2850, 'FK Aksu Pavlodar', 'Okzhetpes', '2023-09-15 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218179614', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2909, 'FK Auda', 'FS METTA/LU', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218255923', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2851, 'Sport Academy Kairat', 'FC Astana U21', '2023-09-15 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218318403', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2852, 'FC Kosice U19', 'Dunajska Streda U19', '2023-09-15 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218294510', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2853, 'FC Vion Zlate Moravce U19', 'Z Michalovce U19', '2023-09-15 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218294403', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2854, 'Ruzomberok U19', 'MSK Zilina U19', '2023-09-15 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218294600', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2855, 'Ayeyawady United', 'Yadanarbon', '2023-09-15 10:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218276351', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2856, 'Changwon City', 'Gimhae City', '2023-09-15 11:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218243063', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2857, 'Daejeon Korail FC', 'Paju Citizen', '2023-09-15 11:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218243243', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2858, 'Yokohama FM', 'Tosu', '2023-09-15 11:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217879716', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2859, 'Kofu', 'Tokyo-V', '2023-09-15 11:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218015532', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2860, 'Kawasaki', 'FC Tokyo', '2023-09-15 11:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217879536', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2861, 'Urawa', 'Kyoto', '2023-09-15 11:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217879175', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2862, 'FK Kaspyi Aktau', 'FK Maqtaaral Jetisay', '2023-09-15 12:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218189926', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2863, 'KMC', 'JKT Tanzania', '2023-09-15 12:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218299139', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2864, 'Shandong Taishan', 'Qingdao Jonoon', '2023-09-15 12:35:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218065287', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2865, 'Shanghai Port FC', 'Changchun Yatai', '2023-09-15 12:35:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218065503', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2866, 'Beijing Guoan', 'Zhejiang Greentown', '2023-09-15 12:35:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218065395', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2867, 'Wuhan Three Towns', 'Cangzhou Mighty Lions', '2023-09-15 12:35:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218065611', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2868, 'Balestier Khalsa', 'Tampines Rovers', '2023-09-15 12:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218276977', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2869, 'Tanjong Pagar United', 'Brunei DPMM FC', '2023-09-15 12:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217991390', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2870, 'Bali Utd Pusam', 'RANS Nusantara FC', '2023-09-15 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218275991', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2871, 'Dewa United FC', 'Bhayangkara FC', '2023-09-15 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218276081', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2872, 'Buriram Utd', 'Trat', '2023-09-15 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218103929', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2873, 'Sabah FA', 'Perak', '2023-09-15 13:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218288405', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2874, 'Bangkok Utd', 'Sukhothai', '2023-09-15 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218103839', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2875, 'Bright Stars', 'Bul FC', '2023-09-15 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218295735', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2876, 'Zira', 'FK Sumqayit', '2023-09-15 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218255742', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2877, 'Bumamuru', 'Mamelodi Sundowns', '2023-09-15 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218300206', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2878, 'Club El Porvenir (W)', 'Social Atletico Television', '2023-09-15 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218289401', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2879, 'Birmingham U21', 'Wigan Athletic U21', '2023-09-15 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218279415', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2880, 'Maritzburg Utd', 'Casric FC', '2023-09-15 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218299659', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2881, 'SC Villa', 'Airtel Kitara FC', '2023-09-15 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218295645', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2882, 'Platense (W)', 'Club Ferro Carril Oeste (W)', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218310814', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2883, 'Unia Skierniewice', 'Olimpia Zambrow', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218295917', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2884, 'Zrinski Jurjevac', 'HNK Orijent 1919', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218254297', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2885, 'CS Dinamo Bucuresti', 'CSO Plopeni', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218294127', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2886, 'CS Uni Craiova II', 'CSM Deva', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218293946', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2887, 'Gorica', 'NK Slovenska Bistrica', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218267906', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2888, 'Muscelul Camp', 'Cetate Rasnov', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218294308', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2889, 'Sloga Doboj', 'Tuzla City', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218279325', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2890, 'ACS Vedita Colonesti MS', 'CS Viitorul Daesti', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218294037', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2891, 'Slavoj Trebisov', 'MFk Dolny Kubin', '2023-09-15 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218228378', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2892, 'Vukovar', 'NK Dugopolje', '2023-09-15 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218254117', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2893, 'Minija Kretinga', 'FK Kauno Zalgiris 2', '2023-09-15 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218280993', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2894, 'Arda', 'Botev Vratsa', '2023-09-15 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217707063', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2895, 'Beltinci', 'Nafta Lendava', '2023-09-15 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218267996', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2896, 'Siarka Tarnobrzeg', 'GP TS Avia Swidnik', '2023-09-15 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218296007', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2897, 'FK Babrungas', 'Marijampole City', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218280903', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2898, 'Greuther Furth II', 'Nurnberg II', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218290913', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2899, 'Al-Jalil', 'Sahab SC', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218279595', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2900, 'USM Khenchela', 'ES Setif', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218272046', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2901, 'MC El Bayadh', 'CS Constantine', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218272226', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2902, 'TSG Hoffenheim U19', 'Bayern Munich U19', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218273529', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2903, 'Notec Czarnków', 'Unia Solec Kujawski', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218296097', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2904, 'Atlantis', 'GrIFK', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218280757', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2905, 'Al-Feiha', 'Al-Shabab (KSA)', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218040900', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2906, 'Vysocina Jihlava', 'FC Zbrojovka Brno', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217974631', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2907, 'Haka', 'Ilves', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218075577', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2908, 'Arsenal Ceska Lipa', 'Usti Nad Labem', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218280667', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2910, 'Lahti', 'KTP', '2023-09-15 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218075271', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2911, 'Metalist 1925', 'Zorya', '2023-09-15 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217921528', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2912, 'UTA Arad', 'Universitatea Cluj', '2023-09-15 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217713634', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2913, 'Podbrezova', 'MFK Skalica', '2023-09-15 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217761827', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2914, 'SV Fortuna Regensburg', 'Ingolstadt II', '2023-09-15 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218290056', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2915, 'SFC Opava', 'Dukla Prague', '2023-09-15 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217974721', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2916, 'TWL Elektra', 'SV Leobendorf', '2023-09-15 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218289707', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2917, 'Puszcza Niepolomice', 'Slask Wroclaw', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217793394', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2918, 'Correcaminos (Premier)', 'Tritones Vallarta MFC', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218281928', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2919, 'Triglav', 'Ilirija Extra-Lux', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218268086', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2920, 'Rosengard (W)', 'Brommapojkarna (W)', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218277249', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2921, 'Ilves Kissat', 'FC Jazz', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218281478', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2922, 'Stal Rzeszow', 'Wisla Plock', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217798694', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2923, 'Lokomotiva', 'Rudes', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217978984', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2924, 'Pohronie', 'MSK Zilina II', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218228288', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2925, 'Pribram', 'Sparta Prague B', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217974811', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2926, 'FC Kiffen', 'PK-35 RY', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218281568', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2927, 'CD Tropezon', 'UD Samano', '2023-09-15 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218296206', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2928, 'St Polten', 'FIRST VIENNA FC 1894', '2023-09-15 17:10:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217936142', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2929, 'Floridsdorfer Ac', 'Admira Wacker', '2023-09-15 17:10:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217935961', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2930, 'FC Dornbirn', 'SKU Amstetten', '2023-09-15 17:10:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217936775', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2931, 'FC Liefering', 'SV Stripfing/Weiden', '2023-09-15 17:10:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217936866', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2932, 'SV Lafnitz', 'SV Horn', '2023-09-15 17:10:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217936052', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2933, 'FC Bastia-Borgo', 'Stade Briochin', '2023-09-15 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218273120', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2934, 'Nurnberg', 'Greuther Furth', '2023-09-15 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217876626', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2935, 'Hannover 96 (U19)', 'SV Werder Bremen U19', '2023-09-15 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218277564', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2936, 'Paderborn', 'Wehen Wiesbaden', '2023-09-15 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217688693', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2937, 'Zeljeznicar', 'Gosk Gabela', '2023-09-15 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218282153', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2938, 'Le Puy', 'Jura Sud', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218273226', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2939, 'Ranheim IL', 'Raufoss', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217885444', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2940, 'Lunds BK', 'Angelholms', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218101361', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2941, 'Cherno More', 'Beroe Stara Za', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217706702', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2942, 'Eimsbutteler', 'Weiche Flensburg', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218273710', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2943, 'Viborg', 'Midtjylland', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217903844', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2944, 'Hobro', 'AC Horsens', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217961654', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2946, 'FC Nottingen', 'Atsv Mutschelbach', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218290150', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2948, 'SC Weiz', 'Union Gurten', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218272316', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2949, 'SK Vorwarts Steyr', 'ASK Klagenfurt', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218272406', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2950, 'Viktoria Aschaffenburg', 'Schalding-Heining', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218273620', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2951, 'Eint Frankfurt II', 'SV Stuttgarter Kickers', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218274880', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2952, 'Spartak Myjava', 'Tatran Presov', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218228197', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2953, 'HB Torshavn', 'Klaksvikar Itrottarfelag', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218279505', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2954, 'Chemnitzer', 'Lokomotiv Leipzig', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218274340', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2955, 'IFK Hassleholm', 'Nosaby IF', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218264005', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2956, 'TUS Bad Gleichenberg', 'Union Volksbank Vocklamarkt', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218272496', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2957, 'Duisburg', 'Verl', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218080321', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2958, 'Skra Czestochowa', 'Radunia Stezyca', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218251872', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2959, 'Sao Paulo U20', 'Mirassol U20', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218307647', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2960, 'SAK Klagenfurt', 'SV Donau Klagenfurt', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218276887', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2961, 'SC Eltersdorf', 'Jahn Regensburg II', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218290294', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2962, 'SV Lippstadt', 'Rot-Weiss Ahlen', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218275413', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2963, 'Skive', 'Middelfart', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218288673', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2964, 'BFC Dynamo', 'Babelsberg', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218274250', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2965, 'FSV 63 Luckenwalde', 'Greifswalder SV 04', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218273980', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2966, 'Rouen', 'GO Lyon', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218200793', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2967, 'Moroka Swallows', 'Richards Bay FC', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218141849', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2947, 'Hillerod Fodbold', 'B93 Copenhagen', '2023-09-15 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217961384', true);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2968, 'ETSV Hamburg', 'Dassendorf', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218290536', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2969, 'Niort', 'Epinal', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218093476', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2970, 'Martigues', 'Sochaux', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218200704', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2971, 'Lommel SK U21', 'Sint Truidense (Res)', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218288281', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2972, 'Favoritner AC', 'Austria Wien (A)', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218274970', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2973, 'FC Zwolle (W)', 'FC Utrecht (W)', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218272996', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2974, 'FC Wegberg-Beeck', 'Mgladbach II', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218275316', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2975, 'Excelsior (W)', 'Ajax (W)', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218298316', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2976, 'Heerenveen (W)', 'AZ Alkmaar Women', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218272906', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2977, 'SC Victoria Hamburg', 'FC Turkiye', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218290726', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2978, 'ADO Den Haag (W)', 'PSV Eindhoven (W)', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218272816', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2979, 'Cholet SO', 'Marignane-Gignac', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218093566', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2980, 'Wiener SK', 'Wiener Victoria', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218298117', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2981, 'FC Wil', 'Stade Lausanne-Ouchy', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218264095', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2982, 'Le Mans', 'Red Star', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218093296', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2983, 'Avranches', 'Orleans', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218093386', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2984, 'Chateauroux', 'Versailles 78 FC', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218141759', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2985, 'Villefranche Beaujolais', 'Nimes', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218093206', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2986, 'Neuchatel Xamax', 'Young Boys', '2023-09-15 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218264185', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2987, 'Bourgoin Jallieu', 'Toulouse B', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218273335', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2988, 'America MG U20', 'Coimbra EC U20', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218310182', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2989, 'Helmond Sport', 'FC Oss', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218080681', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2990, 'Jong AZ Alkmaar', 'FC Eindhoven', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218080591', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2991, 'Brentford U21', 'Fulham U21', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218292909', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2992, 'Olimpia Elblag', 'Wisla Pulawy', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218240588', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2993, 'Jong Ajax Amsterdam', 'Emmen', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218082967', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2995, 'Leicester U21', 'Burnley U21', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218292638', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2996, 'Al-Khaleej Saihat', 'Al-Fateh (KSA)', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218040792', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2998, 'VVV Venlo', 'NAC Breda', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218083237', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3000, 'Royal Charleroi SC (W)', 'Femina WS (W)', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218279235', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3001, 'Kari', 'IF Magni', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218307803', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3002, 'CA Huracan (W)', 'San Lorenzo Al (W)', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218288110', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3003, 'Atletico Grau', 'UTC Cajamarca', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218191763', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3004, 'Brighton U21', 'Aston Villa U21', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218293089', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3005, 'Leeds United U21', 'Colchester United U21', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218292999', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3007, 'Fleetwood Town U21', 'Nottingham Forest U21', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218292819', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3008, 'Al-Hilal', 'Al Riyadh SC', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218040158', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3009, 'Den Bosch', 'MVV Maastricht', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218082787', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3012, 'Soroksar', 'Kecskemeti', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218255833', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3013, 'Middlesbrough U21', 'Crystal Palace U21', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218292728', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3014, 'FC Liege', 'Club Brugge B', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218229177', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3015, 'Racing (W)', 'CA Independiente (W)', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218287933', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3016, 'River Plate (W)', 'Boca Juniors (W)', '2023-09-15 19:10:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218288023', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3017, 'Deportivo Riestra', 'CA Atlanta', '2023-09-15 19:10:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218210444', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3018, 'Club Football Estrela', 'Porto', '2023-09-15 19:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217913097', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3019, 'Ammanford AFC', 'Taffs Well', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218295553', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3020, 'Venezia', 'Spezia', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217959385', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3021, 'Newport City', 'Abergavenny Town', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218295373', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3022, 'Gornik Zabrze', 'Ruch Chorzow', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217793563', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3024, 'DSV Leoben', 'Grazer AK', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217937029', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3025, 'Dinamo Bucharest', 'FC U Craiova 1948', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217713184', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3026, 'GKS Katowice', 'Zaglebie Sosnowiec', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217868286', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3027, 'CD Cambaceres', 'Club El Porvenir (BA)', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218310724', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2997, 'Roda JC', 'SC Telstar', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218082877', true);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (2999, 'Racing Genk B', 'Zulte-Waregem', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218229465', true);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3010, 'FC Dordrecht', 'Jong FC Utrecht', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218083057', true);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3011, 'FC Groningen', 'ADO Den Haag', '2023-09-15 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218083147', true);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3028, 'Genk (W)', 'Oud-Heverlee Leuven (W)', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218279145', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3029, 'Bayern Munich', 'Leverkusen', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217627908', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3023, 'Braga B', 'Sanjoanense', '2023-09-15 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218240710', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3031, 'Holyhead Hotspur', 'Bangor 1876', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218295463', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3032, 'Rimini', 'Juventus B', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218236244', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3033, 'Galway Utd', 'Dundalk', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218198013', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3034, 'Athlone Town', 'Kerry FC', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218083883', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3035, 'Hull', 'Coventry', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217646334', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3036, 'Salford City', 'Notts Co', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217951356', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3037, 'Derry City', 'Shamrock Rovers', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217934382', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3038, 'Atalanta B', 'Giana Erminio', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218239562', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3039, 'Waterford', 'Cobh Ramblers', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218083973', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3040, 'Spal', 'Perugia', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218236138', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3041, 'Drogheda', 'Bohemians', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218198103', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3042, 'Bray Wanderers', 'Treaty United', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218082037', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3043, 'Ancona', 'ASD Pineto Calcio', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218235934', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3044, 'Ayr', 'Partick', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217864014', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3045, 'Pontedera', 'Cesena', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218235624', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3046, 'Cork City', 'Wexford F.C', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218197923', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3047, 'Colwyn Bay', 'Aberystwyth', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218256817', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3048, 'Westerlo', 'Antwerp', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217902393', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3049, 'Larne', 'Linfield', '2023-09-15 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218082127', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3050, 'Southampton', 'Leicester', '2023-09-15 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217646550', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3051, 'Valencia (W)', 'Real Madrid FC (W)', '2023-09-15 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218296656', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3052, 'Paris St-G', 'Nice', '2023-09-15 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217677469', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3053, 'Rayo Vallecano', 'Alaves', '2023-09-15 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217662542', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3054, 'Finn Harps', 'St Patricks', '2023-09-15 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218198193', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3055, 'Le Havre AC (W)', 'Lyon (W)', '2023-09-15 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218288763', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3056, 'Pacos Ferreira', 'Leixoes', '2023-09-15 20:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218101898', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3057, 'CD Buzanada', 'CD Santa Ursula', '2023-09-15 20:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218296296', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3058, 'Zaragoza', 'Racing Santander', '2023-09-15 20:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217991879', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3059, 'Tigre', 'Estudiantes', '2023-09-15 21:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217822541', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3060, 'Carlos Mannucci', 'AD Cantolao', '2023-09-15 21:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218190377', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3061, 'UD Tamaraceite', 'CF Panaderia Pulido', '2023-09-15 21:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218296386', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3062, 'Melgar', 'Alianza Atletico', '2023-09-15 21:20:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218190558', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3063, 'Real Soacha Cundinamarca FC', 'Boyaca Patriotas', '2023-09-15 21:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218270720', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3064, 'Atletico FC Cali', 'Quindio', '2023-09-15 21:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218202859', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3065, 'Platense Zacatecoluca', 'CD Aguila', '2023-09-15 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218277474', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3066, 'Angostura FC', 'Monagas', '2023-09-15 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218307107', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3067, 'Guairena', 'Club Sportivo Trinidense', '2023-09-15 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218305636', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3068, 'Fortaleza FC', 'Cortulua', '2023-09-15 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218204977', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3069, 'Limon Black Star', 'AD Aserri', '2023-09-15 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218299049', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3070, 'Defensa y Justicia', 'Boca Juniors', '2023-09-15 22:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217819453', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3071, 'Vila Nova', 'Ponte Preta', '2023-09-15 23:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217980361', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3072, 'Llaneros FC', 'Barranquilla', '2023-09-15 23:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3073, 'St. Pauls United', 'Cayon FC', '2023-09-16 00:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3074, 'Club Necaxa (W)', 'Santos Laguna (W)', '2023-09-16 00:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3075, 'CD Poza Rica', 'Deportivo Gladiadores', '2023-09-16 00:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3076, 'Cuiaba', 'America MG', '2023-09-16 00:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3077, 'Queretaro (W)', 'Tigres (W)', '2023-09-16 00:06:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3078, 'Once Caldas', 'Envigado', '2023-09-16 00:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3079, 'Nacional (Par)', 'Sportivo Luqueno', '2023-09-16 00:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3080, 'Deportivo La Guaira', 'CD Hermanos Colmenarez', '2023-09-16 00:40:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3081, 'Banfield', 'Argentinos Juniors', '2023-09-16 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3082, 'Alianza FC (SLV)', 'CD Municipal Limeno', '2023-09-16 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3083, 'Orense Sporting Club', 'Univ Catolica (Ecu)', '2023-09-16 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3084, 'Binacional', 'Cienciano', '2023-09-16 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3085, 'Colon', 'Rosario Central', '2023-09-16 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3086, 'Deportivo Saprissa', 'Municipal Grecia', '2023-09-16 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3087, 'Tecos FC', 'Colima FC', '2023-09-16 01:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3088, 'San Martin de San Juan', 'Agropecuario', '2023-09-16 01:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3089, 'SE Palmeiras', 'Goias', '2023-09-16 01:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3090, 'ABC RN', 'Sport Recife', '2023-09-16 01:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3091, 'Mazatlan FC', 'Cruz Azul', '2023-09-16 01:50:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3092, 'Petroleros de Salamanca', 'Yalmakan FC', '2023-09-16 02:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3093, 'San Francisco FC', 'Tauro FC', '2023-09-16 02:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3094, 'Atletico Saltillo', 'Tuzos de la UAZ', '2023-09-16 02:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3095, 'Millonarios', 'Atletico Bucaramanga', '2023-09-16 02:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3096, 'Futbol Consultants Moravia', 'Uruguay de Coronado', '2023-09-16 03:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3097, 'AD Municipal Liberia', 'AD Guanacasteca', '2023-09-16 03:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3098, 'Chihuahua FC', 'Mineros de Fresnillo FC', '2023-09-16 03:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3099, 'Monterrey (W)', 'Pachuca (W)', '2023-09-16 04:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3100, 'Tijuana', 'Toluca', '2023-09-16 04:10:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (3101, 'Suzuka Unlimited', 'Criacao Shinjuku', '2023-09-16 05:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218205067', false);


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

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 344, true);


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 211
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 462, true);


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 215
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 3101, true);


-- Completed on 2023-09-16 04:33:43 BST

--
-- PostgreSQL database dump complete
--

