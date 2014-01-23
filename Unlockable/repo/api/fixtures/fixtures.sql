--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: commercials; Type: TABLE; Schema: public; Owner: unlockable; Tablespace:
--

CREATE TABLE commercials (
    id integer NOT NULL,
    video character varying(256) NOT NULL
);



--
-- Name: commercials_id_seq; Type: SEQUENCE; Schema: public; Owner: unlockable
--

CREATE SEQUENCE commercials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- Name: commercials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: unlockable
--

ALTER SEQUENCE commercials_id_seq OWNED BY commercials.id;


--
-- Name: commercials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: unlockable
--

SELECT pg_catalog.setval('commercials_id_seq', 1, false);


--
-- Name: foreign_users; Type: TABLE; Schema: public; Owner: unlockable; Tablespace:
--

CREATE TABLE foreign_users (
    id integer NOT NULL,
    domain character varying(80) NOT NULL,
    user_id integer
);




--
-- Name: foreign_users_id_seq; Type: SEQUENCE; Schema: public; Owner: unlockable
--

CREATE SEQUENCE foreign_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: foreign_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: unlockable
--

ALTER SEQUENCE foreign_users_id_seq OWNED BY foreign_users.id;


--
-- Name: foreign_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: unlockable
--

SELECT pg_catalog.setval('foreign_users_id_seq', 1, false);


--
-- Name: frame_frame; Type: TABLE; Schema: public; Owner: unlockable; Tablespace:
--

CREATE TABLE frame_frame (
    id integer NOT NULL,
    image_path character varying(256) NOT NULL,
    "order" smallint NOT NULL,
    game_id integer
);




--
-- Name: frame_frame_id_seq; Type: SEQUENCE; Schema: public; Owner: unlockable
--

CREATE SEQUENCE frame_frame_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: frame_frame_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: unlockable
--

ALTER SEQUENCE frame_frame_id_seq OWNED BY frame_frame.id;


--
-- Name: frame_frame_id_seq; Type: SEQUENCE SET; Schema: public; Owner: unlockable
--

SELECT pg_catalog.setval('frame_frame_id_seq', 12, true);


--
-- Name: frame_frames; Type: TABLE; Schema: public; Owner: unlockable; Tablespace:
--

CREATE TABLE frame_frames (
    id integer NOT NULL
);




--
-- Name: frame_frames_id_seq; Type: SEQUENCE; Schema: public; Owner: unlockable
--

CREATE SEQUENCE frame_frames_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- Name: frame_frames_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: unlockable
--

ALTER SEQUENCE frame_frames_id_seq OWNED BY frame_frames.id;


--
-- Name: frame_frames_id_seq; Type: SEQUENCE SET; Schema: public; Owner: unlockable
--

SELECT pg_catalog.setval('frame_frames_id_seq', 2, true);


--
-- Name: games; Type: TABLE; Schema: public; Owner: unlockable; Tablespace:
--

CREATE TABLE games (
    id integer NOT NULL,
    type character varying(15) NOT NULL
);




--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: unlockable
--

CREATE SEQUENCE games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: unlockable
--

ALTER SEQUENCE games_id_seq OWNED BY games.id;


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: unlockable
--

SELECT pg_catalog.setval('games_id_seq', 1, true);


--
-- Name: trivia_answer; Type: TABLE; Schema: public; Owner: unlockable; Tablespace:
--

CREATE TABLE trivia_answer (
    id integer NOT NULL,
    answer character varying(256) NOT NULL,
    correct boolean,
    question_id integer
);



--
-- Name: trivia_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: unlockable
--

CREATE SEQUENCE trivia_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: trivia_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: unlockable
--

ALTER SEQUENCE trivia_answer_id_seq OWNED BY trivia_answer.id;


--
-- Name: trivia_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: unlockable
--

SELECT pg_catalog.setval('trivia_answer_id_seq', 28, true);


--
-- Name: trivia_question; Type: TABLE; Schema: public; Owner: unlockable; Tablespace:
--

CREATE TABLE trivia_question (
    id integer NOT NULL,
    question character varying(256) NOT NULL,
    game_id integer
);



--
-- Name: trivia_question_id_seq; Type: SEQUENCE; Schema: public; Owner: unlockable
--

CREATE SEQUENCE trivia_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: trivia_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: unlockable
--

ALTER SEQUENCE trivia_question_id_seq OWNED BY trivia_question.id;


--
-- Name: trivia_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: unlockable
--

SELECT pg_catalog.setval('trivia_question_id_seq', 1, false);


--
-- Name: trivia_trivia; Type: TABLE; Schema: public; Owner: unlockable; Tablespace:
--

CREATE TABLE trivia_trivia (
    id integer NOT NULL
);




--
-- Name: trivia_trivia_id_seq; Type: SEQUENCE; Schema: public; Owner: unlockable
--

CREATE SEQUENCE trivia_trivia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- Name: trivia_trivia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: unlockable
--

ALTER SEQUENCE trivia_trivia_id_seq OWNED BY trivia_trivia.id;


--
-- Name: trivia_trivia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: unlockable
--

SELECT pg_catalog.setval('trivia_trivia_id_seq', 1, false);


--
-- Name: users; Type: TABLE; Schema: public; Owner: unlockable; Tablespace:
--

CREATE TABLE users (
    id integer NOT NULL
);



--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: unlockable
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: unlockable
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: unlockable
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY commercials ALTER COLUMN id SET DEFAULT nextval('commercials_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY foreign_users ALTER COLUMN id SET DEFAULT nextval('foreign_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY frame_frame ALTER COLUMN id SET DEFAULT nextval('frame_frame_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY frame_frames ALTER COLUMN id SET DEFAULT nextval('frame_frames_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY trivia_answer ALTER COLUMN id SET DEFAULT nextval('trivia_answer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY trivia_question ALTER COLUMN id SET DEFAULT nextval('trivia_question_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY trivia_trivia ALTER COLUMN id SET DEFAULT nextval('trivia_trivia_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: commercials; Type: TABLE DATA; Schema: public; Owner: unlockable
--

COPY commercials (id, video) FROM stdin;
\.


--
-- Data for Name: foreign_users; Type: TABLE DATA; Schema: public; Owner: unlockable
--

COPY foreign_users (id, domain, user_id) FROM stdin;
\.


--
-- Data for Name: frame_frame; Type: TABLE DATA; Schema: public; Owner: unlockable
--

COPY frame_frame (id, image_path, "order", game_id) FROM stdin;
1	img/fixtures/frames/duck.jpg	0	1
2	img/fixtures/frames/duck.jpg	1	1
9	img/fixtures/frames/duck.jpg	2	1
10	img/fixtures/frames/duck.jpg	3	1
11	img/fixtures/frames/duck.jpg	4	1
12	img/fixtures/frames/duck.jpg	5	1
3	img/fixtures/frames/old_spice_swagger_01.png	0	2
4	img/fixtures/frames/old_spice_swagger_02.png	1	2
5	img/fixtures/frames/old_spice_swagger_03.png	2	2
6	img/fixtures/frames/old_spice_swagger_04.png	3	2
7	img/fixtures/frames/old_spice_swagger_05.png	4	2
8	img/fixtures/frames/old_spice_swagger_06.png	5	2
\.


--
-- Data for Name: frame_frames; Type: TABLE DATA; Schema: public; Owner: unlockable
--

COPY frame_frames (id) FROM stdin;
1
2
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: unlockable
--

COPY games (id, type) FROM stdin;
1	Frames
\.


--
-- Data for Name: trivia_answer; Type: TABLE DATA; Schema: public; Owner: unlockable
--

COPY trivia_answer (id, answer, correct, question_id) FROM stdin;
2	T-Rex	f	1
3	Brontosaurus	f	1
4	That spitter thing	f	1
6	Steering Wheel	f	2
7	Hot Coffee	f	2
8	Windshield Wipers	f	2
10	Cut-Rate Insurance	f	3
11	No-Credit Insurance	f	3
12	High-Mileage Insurance	f	3
14	Blue	f	4
15	Red	f	4
16	White	f	4
18	Can't connect to satellites	f	5
19	It's an older model	f	5
20	It's out of batteries	f	5
22	Ford	f	6
23	State Farm	f	6
24	Volkswagen	f	6
26	GPS	f	7
27	Car	f	7
28	Extended Warranty	f	7
1	Raptor	t	1
5	GPS	t	2
9	15-Minute Insurance	t	3
13	Green	t	4
17	It's never updated	t	5
21	Allstate	t	6
25	Insurance	t	7
\.


--
-- Data for Name: trivia_question; Type: TABLE DATA; Schema: public; Owner: unlockable
--

COPY trivia_question (id, question, game_id) FROM stdin;
1	What is the best dinosaur?	1
2	What's causing mayhem?	2
3	What may not pay for repairs?	2
4	What color is the driver's car?	2
5	Why does the GPS have to wing it?	2
6	What brand protects you from Mayhem?	2
7	What product is being advertised?	2
\.


--
-- Data for Name: trivia_trivia; Type: TABLE DATA; Schema: public; Owner: unlockable
--

COPY trivia_trivia (id) FROM stdin;
1
2
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: unlockable
--

COPY users (id) FROM stdin;
1
\.


--
-- Name: commercials_pkey; Type: CONSTRAINT; Schema: public; Owner: unlockable; Tablespace:
--

ALTER TABLE ONLY commercials
    ADD CONSTRAINT commercials_pkey PRIMARY KEY (id);


--
-- Name: foreign_users_pkey; Type: CONSTRAINT; Schema: public; Owner: unlockable; Tablespace:
--

ALTER TABLE ONLY foreign_users
    ADD CONSTRAINT foreign_users_pkey PRIMARY KEY (id);


--
-- Name: frame_frame_pkey; Type: CONSTRAINT; Schema: public; Owner: unlockable; Tablespace:
--

ALTER TABLE ONLY frame_frame
    ADD CONSTRAINT frame_frame_pkey PRIMARY KEY (id);


--
-- Name: frame_frames_pkey; Type: CONSTRAINT; Schema: public; Owner: unlockable; Tablespace:
--

ALTER TABLE ONLY frame_frames
    ADD CONSTRAINT frame_frames_pkey PRIMARY KEY (id);


--
-- Name: games_pkey; Type: CONSTRAINT; Schema: public; Owner: unlockable; Tablespace:
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: trivia_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: unlockable; Tablespace:
--

ALTER TABLE ONLY trivia_answer
    ADD CONSTRAINT trivia_answer_pkey PRIMARY KEY (id);


--
-- Name: trivia_question_pkey; Type: CONSTRAINT; Schema: public; Owner: unlockable; Tablespace:
--

ALTER TABLE ONLY trivia_question
    ADD CONSTRAINT trivia_question_pkey PRIMARY KEY (id);


--
-- Name: trivia_trivia_pkey; Type: CONSTRAINT; Schema: public; Owner: unlockable; Tablespace:
--

ALTER TABLE ONLY trivia_trivia
    ADD CONSTRAINT trivia_trivia_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: unlockable; Tablespace:
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: foreign_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY foreign_users
    ADD CONSTRAINT foreign_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: frame_frame_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY frame_frame
    ADD CONSTRAINT frame_frame_game_id_fkey FOREIGN KEY (game_id) REFERENCES frame_frames(id);


--
-- Name: trivia_answer_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY trivia_answer
    ADD CONSTRAINT trivia_answer_question_id_fkey FOREIGN KEY (question_id) REFERENCES trivia_question(id);


--
-- Name: trivia_question_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: unlockable
--

ALTER TABLE ONLY trivia_question
    ADD CONSTRAINT trivia_question_game_id_fkey FOREIGN KEY (game_id) REFERENCES trivia_trivia(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
