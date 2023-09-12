--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.16 (Ubuntu 12.16-0ubuntu0.20.04.1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE postgres OWNER TO postgres;

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: stats; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.stats (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    guesses integer NOT NULL
);


ALTER TABLE public.stats OWNER TO freecodecamp;

--
-- Name: stats_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.stats_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stats_game_id_seq OWNER TO freecodecamp;

--
-- Name: stats_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.stats_game_id_seq OWNED BY public.stats.game_id;


--
-- Name: usernames; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.usernames (
    user_id integer NOT NULL,
    username character varying(22)
);


ALTER TABLE public.usernames OWNER TO freecodecamp;

--
-- Name: usernames_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.usernames_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usernames_user_id_seq OWNER TO freecodecamp;

--
-- Name: usernames_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.usernames_user_id_seq OWNED BY public.usernames.user_id;


--
-- Name: stats game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.stats ALTER COLUMN game_id SET DEFAULT nextval('public.stats_game_id_seq'::regclass);


--
-- Name: usernames user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames ALTER COLUMN user_id SET DEFAULT nextval('public.usernames_user_id_seq'::regclass);


--
-- Data for Name: stats; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.stats VALUES (5, 4, 617);
INSERT INTO public.stats VALUES (6, 5, 233);
INSERT INTO public.stats VALUES (7, 4, 315);
INSERT INTO public.stats VALUES (8, 4, 529);
INSERT INTO public.stats VALUES (9, 4, 542);
INSERT INTO public.stats VALUES (10, 6, 877);
INSERT INTO public.stats VALUES (11, 7, 503);
INSERT INTO public.stats VALUES (12, 6, 618);
INSERT INTO public.stats VALUES (13, 6, 20);
INSERT INTO public.stats VALUES (14, 6, 896);
INSERT INTO public.stats VALUES (15, 9, 912);
INSERT INTO public.stats VALUES (16, 10, 973);
INSERT INTO public.stats VALUES (17, 9, 428);
INSERT INTO public.stats VALUES (18, 9, 294);
INSERT INTO public.stats VALUES (19, 9, 856);


--
-- Data for Name: usernames; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.usernames VALUES (4, 'user_1694110755979');
INSERT INTO public.usernames VALUES (5, 'user_1694110755978');
INSERT INTO public.usernames VALUES (6, 'user_1694110761307');
INSERT INTO public.usernames VALUES (7, 'user_1694110761306');
INSERT INTO public.usernames VALUES (8, 'Oliver');
INSERT INTO public.usernames VALUES (9, 'user_1694110996632');
INSERT INTO public.usernames VALUES (10, 'user_1694110996631');


--
-- Name: stats_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.stats_game_id_seq', 19, true);


--
-- Name: usernames_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.usernames_user_id_seq', 10, true);


--
-- Name: stats stats_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.stats
    ADD CONSTRAINT stats_pkey PRIMARY KEY (game_id);


--
-- Name: usernames usernames_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames
    ADD CONSTRAINT usernames_pkey PRIMARY KEY (user_id);


--
-- Name: usernames usernames_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames
    ADD CONSTRAINT usernames_username_key UNIQUE (username);


--
-- Name: stats stats_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.stats
    ADD CONSTRAINT stats_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.usernames(user_id);


--
-- PostgreSQL database dump complete
--

