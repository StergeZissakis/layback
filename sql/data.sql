--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

-- Started on 2023-09-08 12:39:57 BST

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

INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (18, '2023-09-06 19:00:00', 'SonderjyskE', 'Vejle', '2023-09-06 20:15:04.824315', 'Lay', 'Under', 2.50, 1.50, 1.64, 1, NULL);
INSERT INTO public.over2p5bets (id, "MatchDateTime", "Home", "Away", "BetDateTime", "LayBack", "OverUnder", "Goals", "Odds", "OddsRecorded", "Amount", "BetResult") VALUES (19, '2023-09-06 19:00:00', 'SonderjyskE', 'Vejle', '2023-09-06 20:38:40.392177', 'Back', 'Under', 2.50, 1.00, 1.12, 1, NULL);


--
-- TOC entry 3075 (class 0 OID 17015)
-- Dependencies: 215
-- Data for Name: over2p5footballsupertips; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (2, 'Sonderjyske', 'Vejle', '2023-09-06 19:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (16, 'Ringsted IF', 'HB Køge', '2023-09-07 16:00:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (18, 'Poland', 'Faroe Islands', '2023-09-07 19:45:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (19, 'Denmark', 'San Marino', '2023-09-07 19:45:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (20, 'Croatia', 'Latvia', '2023-09-08 19:45:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (21, 'Turkey', 'Armenia', '2023-09-08 19:45:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (22, 'Bosnia-Herzegovina', 'Liechtenstein', '2023-09-08 19:45:00', NULL);
INSERT INTO public.over2p5footballsupertips (id, home, away, date_time, url) VALUES (23, 'Willem II', 'Maastricht', '2023-09-08 20:00:00', NULL);


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
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (76, 'Ringsted IF', 'HB Køge', '2023-09-07 16:00:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (78, 'France', 'Rep of Ireland', '2023-09-07 19:45:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (79, 'Netherlands', 'Greece', '2023-09-07 19:45:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (80, 'Cyprus', 'Scotland', '2023-09-08 19:45:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (81, 'Turkey', 'Armenia', '2023-09-08 19:45:00', NULL);
INSERT INTO public.over2p5goalsnow (id, home, away, date_time, url) VALUES (82, 'Willem II', 'Maastricht', '2023-09-08 20:00:00', NULL);


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
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (349, 'Electric Veng FC', 'Project Veng FC', '2023-09-07 06:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217981561', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (352, 'FC Magdeburg', 'Erzgebirge', '2023-09-07 11:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217991027', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (353, 'FC Spaeri', 'Torpedo Kutaisi', '2023-09-07 12:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020577', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (355, 'Nurnberg', 'FC Heidenheim', '2023-09-07 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217979760', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (356, 'Bochum', 'Sint Truiden', '2023-09-07 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217990937', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (357, 'Northern Ireland U21', 'Luxembourg U21', '2023-09-07 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217825497', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (359, 'Belarus U21', 'Faroe Islands U21', '2023-09-07 14:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217852237', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (358, 'Hoffenheim', 'Luzern', '2023-09-07 14:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217990847', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (360, 'Flamengo U20', 'Palmeiras U20', '2023-09-07 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217995490', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (361, 'Kazakhstan', 'Finland', '2023-09-07 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216913793', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (362, 'Estonia U21', 'Bulgaria U21', '2023-09-07 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217825587', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (363, 'Romania U20', 'Czech Republic U20', '2023-09-07 15:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218003019', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (365, 'FIRST VIENNA FC 1894', 'SV Horn', '2023-09-07 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218002929', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (364, 'Dynamo Dresden', 'SC Freital', '2023-09-07 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217996634', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (366, 'Germany U20', 'Italy U20', '2023-09-07 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218006986', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (367, 'Qatar', 'Kenya', '2023-09-07 16:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217996448', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (368, 'Hapoel Mahane Yehuda', 'Beitar Ramat Gan', '2023-09-07 16:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217991677', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (369, 'Hungary U21', 'Kazakhstan U21', '2023-09-07 16:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217835430', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (370, 'Czech Republic U21', 'Slovakia U21', '2023-09-07 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217958189', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (378, 'Staal Jorpeland', 'Vidar', '2023-09-07 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217995796', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (373, 'Angola', 'Madagascar', '2023-09-07 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982017', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (371, 'San Marino U21', 'Norway U21', '2023-09-07 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217892878', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (380, 'France U21', 'Denmark U21', '2023-09-07 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217941008', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (374, 'MS Hapoel Lod', 'Hapoel Kfar Shelem', '2023-09-07 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217985334', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (375, 'Ghana', 'Central African Republic', '2023-09-07 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217981927', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (377, 'Aalesund II', 'Brattvag', '2023-09-07 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217983415', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (376, 'Bulgaria', 'Iran', '2023-09-07 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217893166', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (372, 'Lithuania', 'Montenegro', '2023-09-07 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216912565', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (383, 'Hapoel Umm AL Fahm', 'Hapoel Akko', '2023-09-07 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982557', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (385, 'Maccabi Herzliya', 'Sektzia Nes Tziona', '2023-09-07 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982197', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (382, 'MS Kfar Kasem', 'Hapoel Rishon Lezion', '2023-09-07 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982467', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (386, 'Bosnia U21', 'Slovenia U21', '2023-09-07 17:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217825407', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (384, 'Hapoel K Saba', 'Hapoel Afula', '2023-09-07 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982377', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (379, 'Ramat HaSharon (W)', 'Hapoel Ironi PT (W)', '2023-09-07 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217991926', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (387, 'Cyprus U21', 'Austria U21', '2023-09-07 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217825317', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (389, 'Hamar Hveragerdi', 'Vaengir Jupiters', '2023-09-07 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217985152', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (388, 'Norway', 'Jordan', '2023-09-07 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217893256', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (390, 'Hapoel Bikat Hayarden', 'Shimshon Tel Aviv', '2023-09-07 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982647', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (394, 'Kongsvinger U19', 'KFUM U19', '2023-09-07 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217984818', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (391, 'Agudat Sport Ashdod', 'Maccabi Yavne', '2023-09-07 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982737', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (392, 'Arborg', 'UMF Alftanes', '2023-09-07 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218001056', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (393, 'KA Asvellir', 'UMF Tindstoll', '2023-09-07 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217985242', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (397, 'SER Caxias do Sul', 'Ferroviario', '2023-09-07 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217975713', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (399, 'Baerum SK U19', 'Nordstrand U19', '2023-09-07 19:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217984704', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (396, 'Alianza Universidad', 'Santa Rosa FC', '2023-09-07 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217997290', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (395, 'Borussia Freialdenhoven', 'SPVG Porz', '2023-09-07 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982965', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (398, 'Bahia EC U20', 'Pague Menos FC U20', '2023-09-07 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217995400', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (401, 'Alcorcon', 'Rayo Vallecano', '2023-09-07 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217979505', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (400, 'Austria', 'Moldova', '2023-09-07 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217890299', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (403, 'France', 'Republic of Ireland', '2023-09-07 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216913214', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (402, 'Wales', 'South Korea', '2023-09-07 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217890209', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (351, 'Leverkusen', 'Alemannia Aachen', '2023-09-07 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217996544', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (404, 'Denmark', 'San Marino', '2023-09-07 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217590423', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (413, 'Niger', 'Uganda', '2023-09-07 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217981837', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (411, 'Algeria', 'Tanzania', '2023-09-07 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982107', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (415, 'Porto Velho EC U20', 'Sampaio Correa U20', '2023-09-07 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217995310', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (416, 'FH/IH U19', 'IR/Lettir U19', '2023-09-07 21:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217983325', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (417, 'Comerciantes FC', 'Comerciantes Unidos', '2023-09-07 21:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218012849', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (418, 'Anguilla', 'Saint Martin', '2023-09-07 21:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217936505', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (419, 'Union Huaral', 'Deportivo Coopsol', '2023-09-07 21:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217991587', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (420, 'KH Hlidarendi', 'Skallagrimur', '2023-09-07 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217990757', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (582, 'Beitar Petah Tikva', 'Hakoah Ramat Gan', '2023-09-08 12:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218025874', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (585, 'Chinese Taipei', 'Philippines', '2023-09-08 12:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217893346', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (421, 'Tombense MG', 'ABC RN', '2023-09-07 22:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217808744', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (584, 'MS Tzeirey Kfar Kana', 'Hapoel Bnei Zalafa', '2023-09-08 12:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218018193', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (583, 'Burnley U21', 'Queens Park Rangers U21', '2023-09-08 12:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218018422', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (587, 'Hapoel Migdal HaEmek', 'Ironi Nesher', '2023-09-08 12:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218018013', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (594, 'Maccabi Neve Shaanan Eldad', 'Maccabi Ahva Fureidis', '2023-09-08 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218025604', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (589, 'Hapoel Hod HaSharon', 'Sporting Tel Aviv', '2023-09-08 12:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218025964', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (595, 'Hapoel Kiryat Ono', 'FC Inter Tel Aviv', '2023-09-08 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039105', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (593, 'Tzeirey Tira FC', 'Hapoel Kafr Qasim Shouaa', '2023-09-08 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218025514', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (597, 'Indonesia', 'Turkmenistan', '2023-09-08 13:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217985428', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (350, 'Venghnuai', 'Chhinga Veng', '2023-09-07 09:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217981651', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (354, 'Cambodia', 'Hong Kong', '2023-09-07 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217936414', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (381, 'Ironi Tiberias', 'Ironi Ramat HaSharon', '2023-09-07 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217982287', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (405, 'Poland', 'Faroe Islands', '2023-09-07 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216942888', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (406, 'Serbia', 'Hungary', '2023-09-07 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216922903', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (408, 'Slovenia', 'Northern Ireland', '2023-09-07 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216912686', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (409, 'Czech Republic', 'Albania', '2023-09-07 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216735709', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (407, 'Netherlands', 'Greece', '2023-09-07 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216913335', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (410, 'Morocco U23', 'Brazil U23', '2023-09-07 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218012716', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (412, 'Municipal Turrialba', 'Guadalupe F.C', '2023-09-07 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217959839', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (414, 'Tunisia', 'Botswana', '2023-09-07 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217981747', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (422, 'Sint Maarten', 'St Lucia', '2023-09-07 23:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217796847', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (423, 'Trinidad & Tobago', 'Curacao', '2023-09-07 23:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217798044', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (424, 'Paraguay', 'Peru', '2023-09-07 23:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217454961', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (575, 'Beitar Nahariya', 'Maccabi Bnei Jadeidi-Makr', '2023-09-08 09:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218049363', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (576, 'MS Jerusalem', 'SC Ramla', '2023-09-08 09:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218042352', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (577, 'Ruch Chorzow', 'Piast Gliwice', '2023-09-08 10:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039921', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (578, 'Beitar Yavne', 'FC Shikhun HaMizrah', '2023-09-08 10:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039195', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (579, 'Ironi Beit Dagan', 'HaMakhtesh Givatayim', '2023-09-08 11:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218025694', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (580, 'Myanmar', 'Nepal', '2023-09-08 11:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218029800', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (581, 'Hapoel Tirat HaCarmel', 'Hapoel Bnei Arrara Ara', '2023-09-08 11:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218025784', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (586, 'Hapoel Bueine', 'MS Tira', '2023-09-08 12:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218018103', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (588, 'Singapore', 'Tajikistan', '2023-09-08 12:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217941098', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (590, 'MSK Kiryat Yam', 'Maccabi Ahi Nazareth', '2023-09-08 12:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020484', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (591, 'Ironi Baka El Garbiya', 'Hapoel Kfar Kana', '2023-09-08 12:50:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020304', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (592, 'Hapoel Herzliya', 'AS Nordia Jerusalem', '2023-09-08 12:55:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020394', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (596, 'Hapoel Marmorek', 'Hapoel Tzafririm Holon', '2023-09-08 13:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017923', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (624, 'Tampere Utd', 'Atlantis', '2023-09-08 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217995024', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (600, 'FC Dornbirn', 'WSG Wattens', '2023-09-08 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218034549', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (599, 'FC Fastav Zlin B', 'Trinec', '2023-09-08 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218046647', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (603, 'Sporting Rosiori', 'ACS Vedita Colonesti MS', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038467', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (604, 'Latvia U21', 'Italy U21', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217955086', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (606, 'Muscelul Campulung', 'Popesti-Leordeni', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038197', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (609, 'CS Avantul Periam', 'CS Phoenix Buzias', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038557', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (607, 'ACS Tg. Mures 1898', 'CF Metalurgistul Cugir', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038647', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (602, 'ACS Kids Tampa Brasov', 'ACS Olimpic Zarnesti', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038737', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (611, 'Villarreal CF III', 'CD Roda', '2023-09-08 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039737', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (610, 'CSM Deva', 'Ghiroda si Giarmata Vii', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038377', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (605, 'ACS Inainte Modelu', 'CS Afumati', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038287', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (615, 'UC Ceares', 'Condal CF', '2023-09-08 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039647', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (612, 'FK Vrsac', 'Macva Sabac', '2023-09-08 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020669', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (613, 'NK Sesvete', 'Vukovar', '2023-09-08 15:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217970789', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (614, 'SK Kvítkovice', 'MFK Karvina B', '2023-09-08 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218033921', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (620, 'KTS-K Luzino', 'Sokol Kleczew', '2023-09-08 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039467', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (619, 'KS Wiazownica', 'NKP Podhale Nowy Targ', '2023-09-08 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039377', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (617, 'Armenia U21', 'Albania U21', '2023-09-08 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217915195', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (623, 'Cracovia Krakow', 'Zaglebie Sosnowiec', '2023-09-08 16:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218028507', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (616, 'Poland U20', 'Portugal U20', '2023-09-08 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218007076', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (618, 'GKS Jastrzebie', 'KKS Lech Poznan II', '2023-09-08 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217989856', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (621, 'Atlantis FC/Akatemia', 'PKK-U', '2023-09-08 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217992019', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (622, 'Sokol Brozany', 'Usti Nad Labem', '2023-09-08 16:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218019822', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (625, 'Lauterach', 'Lustenau II', '2023-09-08 16:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218036943', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (627, 'FC Ismaning', 'Heimstetten', '2023-09-08 16:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017521', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (628, 'Roskilde', 'AB', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218034209', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (626, 'Gørslev IF', 'Tarnby', '2023-09-08 16:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218022485', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (629, 'Thisted', 'Skive', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218034119', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (630, 'SV Gerasdorf', 'Wienerberg', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218037033', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (640, 'SK Hranice', 'FK Blansko', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218019732', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (639, 'AD Limianos', 'Varzim', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218028687', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (634, 'Sweden U21', 'North Macedonia U21', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217955446', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (638, 'Georgia', 'Spain', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216913456', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (632, 'BK Hacken (W)', 'Rosengard (W)', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218021071', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (631, 'Hlucin', 'Banik Ostrava B', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218019642', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (635, 'Egypt', 'Ethiopia', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218026146', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (636, 'Denmark U20', 'France U20', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218029620', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (633, 'Pallo-Iirot', 'HJS Akatemia', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217994934', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (641, 'Germany U21', 'Ukraine U21', '2023-09-08 17:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218002839', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (637, 'Viktoria Koln', 'Kaiserslautern', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218043986', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (643, 'SV Schwechat', 'Red Star P', '2023-09-08 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218037439', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (644, 'FC Hertha 03 Zehlendorf', 'Hertha Berlin', '2023-09-08 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218044076', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (642, 'St. Pauli (W)', 'Hamburger SV (W)', '2023-09-08 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218028777', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (645, 'Netherlands U21', 'Moldova U21', '2023-09-08 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217955176', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (646, 'Portugal U21', 'Andorra U21', '2023-09-08 17:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217955266', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (647, 'SC Furstenfeld', 'Ilzer SV', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218036386', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (649, 'SV Union Gnas', 'UFC Fehring', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218035413', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (652, 'Kematen', 'SV Vols', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218035987', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (654, 'Fugen', 'Innsbrucker AC', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218036077', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (651, 'Andrezieux Boutheon', 'Le Puy', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020115', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (648, 'Frederiksberg', 'HIK Hellerup', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218034335', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (650, 'Salzburger', 'U Henndorf', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218035730', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (655, 'Hibernian B', 'The New Saints', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218029137', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (656, 'FC 08 Villingen', 'Holzhausen FC', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017611', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (601, 'Sheff Wed U21', 'Charlton U21', '2023-09-08 14:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218018332', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (658, 'Hassleholms IF', 'Kristianstads', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218035048', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (666, 'KAC 1909', 'Klagenfurt Am', '2023-09-08 18:09:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218037340', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (664, 'Gamla Upsala (W)', 'Bollstanas SK (W)', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218000224', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (657, 'Spartak Myjava', 'Tatran Lip Mikulas', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217995706', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (665, 'Homburg', 'FSV Frankfurt', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218034640', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (659, 'ATSV Erlangen', 'TSV Abtswind', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017251', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (660, 'Atsv Mutschelbach', 'SG Sonnenhof', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017431', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (663, 'Urduliz FT', 'CD Vitoria', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039557', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (667, 'Parndorf', 'Deutschkreutz', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218035629', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (683, 'KV Oostende (Res)', 'Sint Truidense (Res)', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020801', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (682, 'Niort', 'Cholet SO', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217936323', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (669, '1. CfR Pforzheim', 'Vfr Mannheim', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017341', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (681, 'FCM TQS Traiskirchen', 'Wiener SK', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017833', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (680, 'Sportfreunde Lotte', 'FC Gievenbeck', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017161', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (673, 'SC Victoria Hamburg', 'TSV Sasel', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017071', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (687, 'Deportivo Gladiadores', 'Ciervos fc', '2023-09-08 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218030122', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (677, 'Chojniczanka Chojnice', 'Skra Czestochowa', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217990036', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (676, 'Epinal', 'Sochaux', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217966484', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (671, 'Nimes', 'Chateauroux', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217941188', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (668, 'Dijon', 'Villefranche Beaujolais', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217936232', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (670, 'Marignane-Gignac', 'Nancy', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217941278', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (679, 'TSV Havelse', 'St Pauli II', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218034731', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (675, 'ETSV Hamburg', 'FC Turkiye', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218016801', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (674, 'ASV Drassburg', 'Favoritner AC', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218017743', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (672, 'Fortuna Sittard (W)', 'FC Zwolle (W)', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218028415', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (690, 'UAI Urquiza (W)', 'SA Television (W)', '2023-09-08 19:10:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218032780', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (685, 'Burkina Faso', 'Eswatini', '2023-09-08 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218026236', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (689, 'Sportfreunde Siegen', 'ASC 09 Dortmund', '2023-09-08 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218016891', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (684, 'Poland U21', 'Kosovo U21', '2023-09-08 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217955356', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (686, 'SV Schermbeck', 'Turkspor Dortmund 2000', '2023-09-08 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218016981', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (688, 'Excursionistas (W)', 'Rosario Central (W)', '2023-09-08 19:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218032674', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (691, 'Augnablik', 'Hviti Riddarinn', '2023-09-08 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020002', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (693, 'Femina WS (W)', 'Genk (W)', '2023-09-08 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020891', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (694, 'Bowers & Pitsea', 'Gorleston', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218028957', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (692, 'Rep of Ireland U21', 'Turkey U21', '2023-09-08 19:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217955536', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (704, 'Treaty United', 'Wexford F.C', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217835642', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (705, 'ASD Pineto Calcio', 'Entella', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217986094', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (696, 'Luxembourg', 'Iceland', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216912806', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (698, 'Bosnia', 'Liechtenstein', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217590314', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (697, 'Bray Wanderers', 'Galway Utd', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217836788', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (702, 'Cyprus', 'Scotland', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216923041', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (708, 'Uxbridge', 'Sevenoaks Town', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218028867', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (699, 'Pesaro', 'Olbia', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217986004', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (706, 'Croatia', 'Latvia', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216913577', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (695, 'Cardiff Metropolitan', 'Pontypridd Town', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217964336', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (700, 'Kerry FC', 'Longford', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217836240', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (701, 'Malta U21', 'Spain U21', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217899480', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (703, 'Turkey', 'Armenia', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216923163', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (713, 'Saudi Arabia', 'Costa Rica', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217936595', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (710, 'Real San Joaquin', 'Deportes Limache', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038923', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (709, 'Deportes Melipilla', 'Lautaro de Buin', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038832', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (714, 'Levante', 'Espanyol', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217839282', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (715, 'Sevilla FC (W)', 'UDG Tenerife Sur (W)', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217836146', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (712, 'Willem II', 'MVV Maastricht', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217839009', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (711, 'Finn Harps', 'Waterford', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217835732', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (661, 'FBK Balkan', 'IFK Simrishamn', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218021161', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (718, 'Haiti', 'Cuba', '2023-09-08 21:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217797864', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (721, 'Fortaleza FC', 'Boyaca Patriotas', '2023-09-08 21:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217948709', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (722, 'Fernandez Vial', 'Deportes Concepcion', '2023-09-08 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039014', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (723, 'Ituano', 'Vila Nova', '2023-09-08 22:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217808852', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (598, 'Sturm Graz', 'SV Lafnitz', '2023-09-08 13:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218034459', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (608, 'AFC Odorheiu Secuiesc', 'ACS SR Municipal Brasov', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218038107', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (757, 'ACS Viitorul Cluj', 'CS Unirea Ungheni', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218055244', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (750, 'Dunarea Calaaisi', 'Acs Progresul Fund', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218055512', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (749, 'Csm Focsani', 'ACS Vointa Limpezis', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218055425', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (752, 'CS Gilortul TC', 'ACS Viitorul Simian', '2023-09-08 15:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218055604', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (784, 'Tampere Utd', 'Atlantis', '2023-09-08 17:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217995024', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (653, 'Stade Briochin', 'Guingamp B', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218020214', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (662, 'Bron Radom', 'Concordia Elblag', '2023-09-08 18:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218039287', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (678, 'AZ Alkmaar Women', 'Excelsior (W)', '2023-09-08 18:30:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218030217', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (707, 'Slovakia', 'Portugal', '2023-09-08 19:45:00', 'https://www.orbitxch.com/customer/sport/1/market/1.216735817', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (860, 'Crusaders Strikers (W)', 'Sion Swifts LFC (W)', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218055151', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (856, 'Club Olimpia (W)', 'Nacional - Humaita (W)', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218056690', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (862, 'CS Estudiantes San Luis', 'Sportivo Penarol', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218052639', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (716, 'Mali', 'South Sudan', '2023-09-08 20:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218026056', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (717, 'Ymir', 'Reynir Sandgeroi', '2023-09-08 20:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218019912', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (719, 'Belize', 'St Vincent & Grenadines', '2023-09-08 21:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217797232', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (720, 'Bermuda', 'French Guyana', '2023-09-08 21:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217797412', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (875, 'Sportivo Ameliano (W)', 'Club Guarani (W)', '2023-09-08 22:15:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218056600', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (724, 'Chilangos FC', 'Caja Oblatos C.FD', '2023-09-08 23:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.218044166', false);
INSERT INTO public.over2p5orbitxch (id, home, away, date_time, url, plaied) VALUES (725, 'Barranquilla', 'Real Cartagena', '2023-09-08 23:00:00', 'https://www.orbitxch.com/customer/sport/1/market/1.217948815', false);


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

SELECT pg_catalog.setval('public.over2p5bets_id_seq', 19, true);


--
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 214
-- Name: over2p5footballsupertips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5footballsupertips_id_seq', 39, true);


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 212
-- Name: over2p5goalsnow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5goalsnow_id_seq', 94, true);


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 216
-- Name: over2p5orbitxch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.over2p5orbitxch_id_seq', 1025, true);


-- Completed on 2023-09-08 12:39:57 BST

--
-- PostgreSQL database dump complete
--

