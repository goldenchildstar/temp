--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_points; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE access_points (
    id integer NOT NULL,
    mac_address character varying NOT NULL,
    network_id integer,
    organization_id integer NOT NULL,
    name character varying(255),
    uuid uuid DEFAULT uuid_generate_v4(),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    serial_number character varying,
    model character varying,
    installed_at timestamp without time zone
);


--
-- Name: access_points_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE access_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: access_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE access_points_id_seq OWNED BY access_points.id;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE addresses (
    id integer NOT NULL,
    street character varying(255),
    city character varying(255),
    region character varying(255),
    country character varying(255),
    postal_code character varying(255),
    network_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    gmt_offset integer,
    dst_offset integer,
    time_zone character varying(255)
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- Name: admins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE admins (
    id integer NOT NULL,
    name character varying(255),
    uuid uuid DEFAULT uuid_generate_v4(),
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    disabled_at timestamp without time zone
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admins_id_seq OWNED BY admins.id;


--
-- Name: affiliations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE affiliations (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: affiliations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE affiliations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: affiliations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE affiliations_id_seq OWNED BY affiliations.id;


--
-- Name: devices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE devices (
    id integer NOT NULL,
    mac_address macaddr NOT NULL,
    human boolean DEFAULT true NOT NULL,
    uuid uuid DEFAULT uuid_generate_v4(),
    created_at timestamp without time zone DEFAULT timezone('UTC'::text, now()),
    updated_at timestamp without time zone DEFAULT timezone('UTC'::text, now())
);


--
-- Name: devices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE devices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE devices_id_seq OWNED BY devices.id;


--
-- Name: networks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE networks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    uuid uuid DEFAULT uuid_generate_v4(),
    splash_url text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    organization_id integer,
    disabled_at timestamp without time zone
);


--
-- Name: networks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE networks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: networks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE networks_id_seq OWNED BY networks.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE organizations (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    uuid uuid DEFAULT uuid_generate_v4(),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    disabled_at timestamp without time zone
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE organizations_id_seq OWNED BY organizations.id;


--
-- Name: portal_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE portal_registrations (
    id integer NOT NULL,
    client_mac_address macaddr NOT NULL,
    access_point_mac_address macaddr NOT NULL,
    authentication_provider character varying NOT NULL,
    registration_time timestamp without time zone NOT NULL,
    data jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: portal_registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE portal_registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: portal_registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE portal_registrations_id_seq OWNED BY portal_registrations.id;


--
-- Name: presence_metrics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE presence_metrics (
    id integer NOT NULL,
    datetime timestamp with time zone NOT NULL,
    network_id integer NOT NULL,
    visit_mean_duration interval,
    visit_count integer,
    new_visitor_count integer,
    returning_visitor_count integer,
    passerby_count integer,
    visit_duration_histogram_counts integer[] DEFAULT '{}'::integer[],
    returning_visitor_ids character varying[] DEFAULT '{}'::character varying[],
    visitor_mac_addresses character varying[] DEFAULT '{}'::character varying[]
);


--
-- Name: presence_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE presence_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: presence_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE presence_metrics_id_seq OWNED BY presence_metrics.id;


--
-- Name: presence_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE presence_sessions (
    id integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    duration interval,
    device_id integer NOT NULL,
    network_id integer NOT NULL,
    type character varying(255) DEFAULT ''::character varying NOT NULL,
    uuid uuid DEFAULT uuid_generate_v4(),
    created_at timestamp without time zone DEFAULT timezone('UTC'::text, now()),
    updated_at timestamp without time zone DEFAULT timezone('UTC'::text, now()),
    CONSTRAINT proper_time_constraint CHECK ((end_time >= start_time))
);


--
-- Name: presence_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE presence_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: presence_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE presence_sessions_id_seq OWNED BY presence_sessions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255),
    uuid uuid DEFAULT uuid_generate_v4(),
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    disabled_at timestamp without time zone,
    preferences character varying(255) DEFAULT '--- {}
'::character varying,
    super_user boolean DEFAULT false
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY access_points ALTER COLUMN id SET DEFAULT nextval('access_points_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins ALTER COLUMN id SET DEFAULT nextval('admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliations ALTER COLUMN id SET DEFAULT nextval('affiliations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY devices ALTER COLUMN id SET DEFAULT nextval('devices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY networks ALTER COLUMN id SET DEFAULT nextval('networks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY organizations ALTER COLUMN id SET DEFAULT nextval('organizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY portal_registrations ALTER COLUMN id SET DEFAULT nextval('portal_registrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY presence_metrics ALTER COLUMN id SET DEFAULT nextval('presence_metrics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY presence_sessions ALTER COLUMN id SET DEFAULT nextval('presence_sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: access_points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY access_points
    ADD CONSTRAINT access_points_pkey PRIMARY KEY (id);


--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: affiliations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_pkey PRIMARY KEY (id);


--
-- Name: devices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (id);


--
-- Name: networks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY networks
    ADD CONSTRAINT networks_pkey PRIMARY KEY (id);


--
-- Name: organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: portal_registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY portal_registrations
    ADD CONSTRAINT portal_registrations_pkey PRIMARY KEY (id);


--
-- Name: presence_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY presence_metrics
    ADD CONSTRAINT presence_metrics_pkey PRIMARY KEY (id);


--
-- Name: presence_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY presence_sessions
    ADD CONSTRAINT presence_sessions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_access_points_on_mac_address; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_access_points_on_mac_address ON access_points USING btree (mac_address);


--
-- Name: index_access_points_on_network_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_access_points_on_network_id ON access_points USING btree (network_id);


--
-- Name: index_access_points_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_access_points_on_organization_id ON access_points USING btree (organization_id);


--
-- Name: index_access_points_on_serial_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_access_points_on_serial_number ON access_points USING btree (serial_number);


--
-- Name: index_access_points_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_access_points_on_uuid ON access_points USING btree (uuid);


--
-- Name: index_addresses_on_network_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_addresses_on_network_id ON addresses USING btree (network_id);


--
-- Name: index_admins_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admins_on_confirmation_token ON admins USING btree (confirmation_token);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admins_on_email ON admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON admins USING btree (reset_password_token);


--
-- Name: index_admins_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admins_on_uuid ON admins USING btree (uuid);


--
-- Name: index_affiliations_on_organization_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_affiliations_on_organization_id_and_user_id ON affiliations USING btree (organization_id, user_id);


--
-- Name: index_affiliations_on_user_id_and_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_affiliations_on_user_id_and_organization_id ON affiliations USING btree (user_id, organization_id);


--
-- Name: index_devices_on_mac_address; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_devices_on_mac_address ON devices USING btree (mac_address);


--
-- Name: index_devices_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_devices_on_uuid ON devices USING btree (uuid);


--
-- Name: index_networks_on_name_and_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_networks_on_name_and_organization_id ON networks USING btree (name, organization_id);


--
-- Name: index_networks_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_networks_on_organization_id ON networks USING btree (organization_id);


--
-- Name: index_networks_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_networks_on_uuid ON networks USING btree (uuid);


--
-- Name: index_organizations_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_organizations_on_name ON organizations USING btree (name);


--
-- Name: index_portal_registrations_on_access_point_mac_address; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_portal_registrations_on_access_point_mac_address ON portal_registrations USING btree (access_point_mac_address);


--
-- Name: index_portal_registrations_on_data; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_portal_registrations_on_data ON portal_registrations USING gin (data);


--
-- Name: index_presence_metrics_on_datetime; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_presence_metrics_on_datetime ON presence_metrics USING btree (datetime);


--
-- Name: index_presence_metrics_on_network_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_presence_metrics_on_network_id ON presence_metrics USING btree (network_id);


--
-- Name: index_presence_sessions_on_device_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_presence_sessions_on_device_id ON presence_sessions USING btree (device_id);


--
-- Name: index_presence_sessions_on_device_id_and_network_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_presence_sessions_on_device_id_and_network_id ON presence_sessions USING btree (device_id, network_id);


--
-- Name: index_presence_sessions_on_device_id_and_network_id_and_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_presence_sessions_on_device_id_and_network_id_and_type ON presence_sessions USING btree (device_id, network_id, type);


--
-- Name: index_presence_sessions_on_network_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_presence_sessions_on_network_id ON presence_sessions USING btree (network_id);


--
-- Name: index_presence_sessions_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_presence_sessions_on_type ON presence_sessions USING btree (type);


--
-- Name: index_presence_sessions_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_presence_sessions_on_uuid ON presence_sessions USING btree (uuid);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_uuid ON users USING btree (uuid);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: access_points_network_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY access_points
    ADD CONSTRAINT access_points_network_id_fk FOREIGN KEY (network_id) REFERENCES networks(id);


--
-- Name: access_points_organization_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY access_points
    ADD CONSTRAINT access_points_organization_id_fk FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: addresses_network_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_network_id_fk FOREIGN KEY (network_id) REFERENCES networks(id);


--
-- Name: affiliations_organization_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_organization_id_fk FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: affiliations_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY affiliations
    ADD CONSTRAINT affiliations_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: networks_organization_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY networks
    ADD CONSTRAINT networks_organization_id_fk FOREIGN KEY (organization_id) REFERENCES organizations(id);


--
-- Name: presence_sessions_device_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY presence_sessions
    ADD CONSTRAINT presence_sessions_device_id_fk FOREIGN KEY (device_id) REFERENCES devices(id);


--
-- Name: presence_sessions_network_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY presence_sessions
    ADD CONSTRAINT presence_sessions_network_id_fk FOREIGN KEY (network_id) REFERENCES networks(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20140423124303');

INSERT INTO schema_migrations (version) VALUES ('20140423125126');

INSERT INTO schema_migrations (version) VALUES ('20140423132707');

INSERT INTO schema_migrations (version) VALUES ('20140423133210');

INSERT INTO schema_migrations (version) VALUES ('20140423134259');

INSERT INTO schema_migrations (version) VALUES ('20140423143758');

INSERT INTO schema_migrations (version) VALUES ('20140423145102');

INSERT INTO schema_migrations (version) VALUES ('20140423145533');

INSERT INTO schema_migrations (version) VALUES ('20140423145639');

INSERT INTO schema_migrations (version) VALUES ('20140423164727');

INSERT INTO schema_migrations (version) VALUES ('20140423164923');

INSERT INTO schema_migrations (version) VALUES ('20140424032008');

INSERT INTO schema_migrations (version) VALUES ('20140428012545');

INSERT INTO schema_migrations (version) VALUES ('20140428012758');

INSERT INTO schema_migrations (version) VALUES ('20140502181156');

INSERT INTO schema_migrations (version) VALUES ('20140505163201');

INSERT INTO schema_migrations (version) VALUES ('20140506111624');

INSERT INTO schema_migrations (version) VALUES ('20140506113155');

INSERT INTO schema_migrations (version) VALUES ('20140519180138');

INSERT INTO schema_migrations (version) VALUES ('20140529225250');

INSERT INTO schema_migrations (version) VALUES ('20140623172405');

INSERT INTO schema_migrations (version) VALUES ('20140626130605');

INSERT INTO schema_migrations (version) VALUES ('20140807205420');

INSERT INTO schema_migrations (version) VALUES ('20150509180045');

INSERT INTO schema_migrations (version) VALUES ('20150512000810');

INSERT INTO schema_migrations (version) VALUES ('20150523191335');

INSERT INTO schema_migrations (version) VALUES ('20151002202609');

INSERT INTO schema_migrations (version) VALUES ('20151109141309');

INSERT INTO schema_migrations (version) VALUES ('20151205232900');

INSERT INTO schema_migrations (version) VALUES ('20160428112441');

INSERT INTO schema_migrations (version) VALUES ('20161018210805');

