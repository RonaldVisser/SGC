--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

-- Started on 2020-01-31 14:41:42 CET

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
-- TOC entry 6 (class 2615 OID 16386)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 203 (class 1259 OID 16387)
-- Name: GC_af_tbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GC_af_tbl" (
    "ID1" text NOT NULL,
    "ID2" text NOT NULL,
    "SGC" numeric(7,6),
    "SSGC" numeric(7,6),
    "Overlap" smallint
);


ALTER TABLE public."GC_af_tbl" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16393)
-- Name: GC_as_tbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GC_as_tbl" (
    "ID1" text NOT NULL,
    "ID2" text NOT NULL,
    "SGC" numeric(7,6),
    "SSGC" numeric(7,6),
    "Overlap" smallint
);


ALTER TABLE public."GC_as_tbl" OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16399)
-- Name: GC_au_tbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GC_au_tbl" (
    "ID1" text NOT NULL,
    "ID2" text NOT NULL,
    "SGC" numeric(7,6),
    "SSGC" numeric(7,6),
    "Overlap" smallint
);


ALTER TABLE public."GC_au_tbl" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16405)
-- Name: GC_ca_tbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GC_ca_tbl" (
    "ID1" text NOT NULL,
    "ID2" text NOT NULL,
    "SGC" numeric(7,6),
    "SSGC" numeric(7,6),
    "Overlap" smallint
);


ALTER TABLE public."GC_ca_tbl" OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16411)
-- Name: GC_eu_tbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GC_eu_tbl" (
    "ID1" text NOT NULL,
    "ID2" text NOT NULL,
    "SGC" numeric(7,6),
    "SSGC" numeric(7,6),
    "Overlap" smallint
);


ALTER TABLE public."GC_eu_tbl" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16417)
-- Name: GC_mx_tbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GC_mx_tbl" (
    "ID1" text NOT NULL,
    "ID2" text NOT NULL,
    "SGC" numeric(7,6),
    "SSGC" numeric(7,6),
    "Overlap" smallint
);


ALTER TABLE public."GC_mx_tbl" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16423)
-- Name: GC_sa_tbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GC_sa_tbl" (
    "ID1" text NOT NULL,
    "ID2" text NOT NULL,
    "SGC" double precision,
    "SSGC" double precision,
    "Overlap" smallint
);


ALTER TABLE public."GC_sa_tbl" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16429)
-- Name: GC_us_tbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GC_us_tbl" (
    "ID1" text,
    "ID2" text,
    "SGC" numeric(7,6),
    "SSGC" numeric(7,6),
    "Overlap" smallint
);


ALTER TABLE public."GC_us_tbl" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16441)
-- Name: headers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.headers (
    continent character(2) NOT NULL,
    filename text NOT NULL,
    line_nr integer NOT NULL,
    header_text text
);


ALTER TABLE public.headers OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16435)
-- Name: names; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.names (
    filename text NOT NULL,
    name_orig text NOT NULL,
    name_new text NOT NULL
);


ALTER TABLE public.names OWNER TO postgres;

--
-- TOC entry 2865 (class 2606 OID 16448)
-- Name: GC_af_tbl gc_af_tbl_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GC_af_tbl"
    ADD CONSTRAINT gc_af_tbl_pk PRIMARY KEY ("ID1", "ID2");


--
-- TOC entry 2867 (class 2606 OID 16450)
-- Name: GC_as_tbl gc_as_tbl_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GC_as_tbl"
    ADD CONSTRAINT gc_as_tbl_pk PRIMARY KEY ("ID1", "ID2");


--
-- TOC entry 2869 (class 2606 OID 16452)
-- Name: GC_au_tbl gc_au_tbl_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GC_au_tbl"
    ADD CONSTRAINT gc_au_tbl_pk PRIMARY KEY ("ID1", "ID2");


--
-- TOC entry 2871 (class 2606 OID 16454)
-- Name: GC_ca_tbl gc_ca_tbl_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GC_ca_tbl"
    ADD CONSTRAINT gc_ca_tbl_pk PRIMARY KEY ("ID1", "ID2");


--
-- TOC entry 2873 (class 2606 OID 16456)
-- Name: GC_eu_tbl gc_eu_tbl_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GC_eu_tbl"
    ADD CONSTRAINT gc_eu_tbl_pk PRIMARY KEY ("ID1", "ID2");


--
-- TOC entry 2875 (class 2606 OID 16458)
-- Name: GC_mx_tbl gc_mx_tbl_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GC_mx_tbl"
    ADD CONSTRAINT gc_mx_tbl_pk PRIMARY KEY ("ID1", "ID2");


--
-- TOC entry 2877 (class 2606 OID 16460)
-- Name: GC_sa_tbl gc_sa_tbl_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GC_sa_tbl"
    ADD CONSTRAINT gc_sa_tbl_pk PRIMARY KEY ("ID2", "ID1");


--
-- TOC entry 2881 (class 2606 OID 16462)
-- Name: headers headers_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.headers
    ADD CONSTRAINT headers_pk PRIMARY KEY (continent, filename, line_nr);


--
-- TOC entry 2879 (class 2606 OID 16464)
-- Name: names names_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.names
    ADD CONSTRAINT names_pk PRIMARY KEY (name_new);


-- Completed on 2020-01-31 14:41:42 CET

--
-- PostgreSQL database dump complete
--

