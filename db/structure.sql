--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: post_tsv_trigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION post_tsv_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN
          new.tsv := to_tsvector('english', coalesce(new.text, '')) || 
          (SELECT to_tsvector('english', coalesce(forums_topics.subject, ' ')) FROM forums_topics WHERE forums_topics.id = new.topic_id);
          return new;
        END
      $$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: banner_images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE banner_images (
    id integer NOT NULL,
    file character varying(255),
    active boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: banner_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE banner_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: banner_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE banner_images_id_seq OWNED BY banner_images.id;


--
-- Name: boards_managers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE boards_managers (
    board_id integer,
    manager_id integer
);


--
-- Name: categories_user_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories_user_groups (
    category_id integer,
    user_group_id integer
);


--
-- Name: forem_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forem_categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    slug character varying(255)
);


--
-- Name: forem_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forem_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forem_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forem_categories_id_seq OWNED BY forem_categories.id;


--
-- Name: forem_forums; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forem_forums (
    id integer NOT NULL,
    name character varying(255),
    description text,
    category_id integer,
    views_count integer DEFAULT 0,
    slug character varying(255)
);


--
-- Name: forem_forums_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forem_forums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forem_forums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forem_forums_id_seq OWNED BY forem_forums.id;


--
-- Name: forem_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forem_groups (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: forem_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forem_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forem_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forem_groups_id_seq OWNED BY forem_groups.id;


--
-- Name: forem_memberships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forem_memberships (
    id integer NOT NULL,
    group_id integer,
    member_id integer
);


--
-- Name: forem_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forem_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forem_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forem_memberships_id_seq OWNED BY forem_memberships.id;


--
-- Name: forem_moderator_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forem_moderator_groups (
    id integer NOT NULL,
    forum_id integer,
    group_id integer
);


--
-- Name: forem_moderator_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forem_moderator_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forem_moderator_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forem_moderator_groups_id_seq OWNED BY forem_moderator_groups.id;


--
-- Name: forem_posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forem_posts (
    id integer NOT NULL,
    topic_id integer,
    text text,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reply_to_id integer,
    state character varying(255) DEFAULT 'pending_review'::character varying,
    notified boolean DEFAULT false
);


--
-- Name: forem_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forem_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forem_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forem_posts_id_seq OWNED BY forem_posts.id;


--
-- Name: forem_subscriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forem_subscriptions (
    id integer NOT NULL,
    subscriber_id integer,
    topic_id integer
);


--
-- Name: forem_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forem_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forem_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forem_subscriptions_id_seq OWNED BY forem_subscriptions.id;


--
-- Name: forem_topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forem_topics (
    id integer NOT NULL,
    forum_id integer,
    user_id integer,
    subject character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    locked boolean DEFAULT false NOT NULL,
    pinned boolean DEFAULT false,
    hidden boolean DEFAULT false,
    last_post_at timestamp without time zone,
    state character varying(255) DEFAULT 'pending_review'::character varying,
    views_count integer DEFAULT 0,
    slug character varying(255)
);


--
-- Name: forem_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forem_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forem_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forem_topics_id_seq OWNED BY forem_topics.id;


--
-- Name: forem_views; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forem_views (
    id integer NOT NULL,
    user_id integer,
    viewable_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    count integer DEFAULT 0,
    viewable_type character varying(255),
    current_viewed_at timestamp without time zone,
    past_viewed_at timestamp without time zone
);


--
-- Name: forem_views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forem_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forem_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forem_views_id_seq OWNED BY forem_views.id;


--
-- Name: forums_boards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forums_boards (
    id integer NOT NULL,
    name character varying(255),
    slug character varying(255),
    description text,
    category_id integer,
    views_count integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: forums_boards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forums_boards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forums_boards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forums_boards_id_seq OWNED BY forums_boards.id;


--
-- Name: forums_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forums_categories (
    id integer NOT NULL,
    name character varying(255),
    slug character varying(255),
    description text,
    public boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: forums_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forums_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forums_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forums_categories_id_seq OWNED BY forums_categories.id;


--
-- Name: forums_posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forums_posts (
    id integer NOT NULL,
    topic_id integer,
    user_id integer,
    reply_to_id integer,
    text text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tsv tsvector
);


--
-- Name: forums_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forums_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forums_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forums_posts_id_seq OWNED BY forums_posts.id;


--
-- Name: forums_topics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forums_topics (
    id integer NOT NULL,
    board_id integer,
    user_id integer,
    subject character varying(255),
    slug character varying(255),
    locked boolean DEFAULT false,
    pinned boolean DEFAULT false,
    hidden boolean DEFAULT false,
    last_post_at timestamp without time zone,
    views_count integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: forums_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forums_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forums_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forums_topics_id_seq OWNED BY forums_topics.id;


--
-- Name: forums_views; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE forums_views (
    id integer NOT NULL,
    user_id integer,
    viewable_id integer,
    viewable_type character varying(255),
    count integer DEFAULT 0,
    current_viewed_at timestamp without time zone,
    past_viewed_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: forums_views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forums_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forums_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forums_views_id_seq OWNED BY forums_views.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    topic character varying(255),
    body text,
    received_messageable_id integer,
    received_messageable_type character varying(255),
    sent_messageable_id integer,
    sent_messageable_type character varying(255),
    opened boolean DEFAULT false,
    recipient_delete boolean DEFAULT false,
    sender_delete boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying(255),
    recipient_permanent_delete boolean DEFAULT false,
    sender_permanent_delete boolean DEFAULT false
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: news_entries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE news_entries (
    id integer NOT NULL,
    title character varying(255),
    slug character varying(255),
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    cover_image character varying(255)
);


--
-- Name: news_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE news_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: news_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE news_entries_id_seq OWNED BY news_entries.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    title character varying(255),
    slug character varying(255),
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    display_shoutbox boolean DEFAULT true,
    display_recruitment boolean DEFAULT true
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE permissions (
    id integer NOT NULL,
    identifier character varying(255),
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;


--
-- Name: permissions_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE permissions_users (
    permission_id integer,
    user_id integer
);


--
-- Name: recruitments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE recruitments (
    id integer NOT NULL,
    identifier character varying(255),
    name character varying(255),
    spec character varying(255),
    active boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: recruitments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE recruitments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recruitments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE recruitments_id_seq OWNED BY recruitments.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: shoutbox_messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE shoutbox_messages (
    id integer NOT NULL,
    user_id integer,
    message text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: shoutbox_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE shoutbox_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shoutbox_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE shoutbox_messages_id_seq OWNED BY shoutbox_messages.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE system_settings (
    id integer NOT NULL,
    identifier character varying(255) NOT NULL,
    description character varying(255),
    metadata text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE system_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE system_settings_id_seq OWNED BY system_settings.id;


--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_groups (
    id integer NOT NULL,
    identifier character varying(255),
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_groups_id_seq OWNED BY user_groups.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    name character varying(255),
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    unconfirmed_email character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    forem_admin boolean DEFAULT false,
    forem_state character varying(255) DEFAULT 'pending_review'::character varying,
    forem_auto_subscribe boolean DEFAULT false,
    user_group_id integer
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
-- Name: versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY banner_images ALTER COLUMN id SET DEFAULT nextval('banner_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forem_categories ALTER COLUMN id SET DEFAULT nextval('forem_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forem_forums ALTER COLUMN id SET DEFAULT nextval('forem_forums_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forem_groups ALTER COLUMN id SET DEFAULT nextval('forem_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forem_memberships ALTER COLUMN id SET DEFAULT nextval('forem_memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forem_moderator_groups ALTER COLUMN id SET DEFAULT nextval('forem_moderator_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forem_posts ALTER COLUMN id SET DEFAULT nextval('forem_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forem_subscriptions ALTER COLUMN id SET DEFAULT nextval('forem_subscriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forem_topics ALTER COLUMN id SET DEFAULT nextval('forem_topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forem_views ALTER COLUMN id SET DEFAULT nextval('forem_views_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forums_boards ALTER COLUMN id SET DEFAULT nextval('forums_boards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forums_categories ALTER COLUMN id SET DEFAULT nextval('forums_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forums_posts ALTER COLUMN id SET DEFAULT nextval('forums_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forums_topics ALTER COLUMN id SET DEFAULT nextval('forums_topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forums_views ALTER COLUMN id SET DEFAULT nextval('forums_views_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY news_entries ALTER COLUMN id SET DEFAULT nextval('news_entries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY permissions ALTER COLUMN id SET DEFAULT nextval('permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY recruitments ALTER COLUMN id SET DEFAULT nextval('recruitments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY shoutbox_messages ALTER COLUMN id SET DEFAULT nextval('shoutbox_messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY system_settings ALTER COLUMN id SET DEFAULT nextval('system_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_groups ALTER COLUMN id SET DEFAULT nextval('user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: banner_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY banner_images
    ADD CONSTRAINT banner_images_pkey PRIMARY KEY (id);


--
-- Name: forem_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forem_categories
    ADD CONSTRAINT forem_categories_pkey PRIMARY KEY (id);


--
-- Name: forem_forums_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forem_forums
    ADD CONSTRAINT forem_forums_pkey PRIMARY KEY (id);


--
-- Name: forem_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forem_groups
    ADD CONSTRAINT forem_groups_pkey PRIMARY KEY (id);


--
-- Name: forem_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forem_memberships
    ADD CONSTRAINT forem_memberships_pkey PRIMARY KEY (id);


--
-- Name: forem_moderator_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forem_moderator_groups
    ADD CONSTRAINT forem_moderator_groups_pkey PRIMARY KEY (id);


--
-- Name: forem_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forem_posts
    ADD CONSTRAINT forem_posts_pkey PRIMARY KEY (id);


--
-- Name: forem_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forem_subscriptions
    ADD CONSTRAINT forem_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: forem_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forem_topics
    ADD CONSTRAINT forem_topics_pkey PRIMARY KEY (id);


--
-- Name: forem_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forem_views
    ADD CONSTRAINT forem_views_pkey PRIMARY KEY (id);


--
-- Name: forums_boards_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forums_boards
    ADD CONSTRAINT forums_boards_pkey PRIMARY KEY (id);


--
-- Name: forums_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forums_categories
    ADD CONSTRAINT forums_categories_pkey PRIMARY KEY (id);


--
-- Name: forums_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forums_posts
    ADD CONSTRAINT forums_posts_pkey PRIMARY KEY (id);


--
-- Name: forums_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forums_topics
    ADD CONSTRAINT forums_topics_pkey PRIMARY KEY (id);


--
-- Name: forums_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY forums_views
    ADD CONSTRAINT forums_views_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: news_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY news_entries
    ADD CONSTRAINT news_entries_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: recruitments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY recruitments
    ADD CONSTRAINT recruitments_pkey PRIMARY KEY (id);


--
-- Name: shoutbox_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY shoutbox_messages
    ADD CONSTRAINT shoutbox_messages_pkey PRIMARY KEY (id);


--
-- Name: system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: acts_as_messageable_ids; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX acts_as_messageable_ids ON messages USING btree (sent_messageable_id, received_messageable_id);


--
-- Name: index_boards_managers_on_board_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_boards_managers_on_board_id ON boards_managers USING btree (board_id);


--
-- Name: index_boards_managers_on_manager_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_boards_managers_on_manager_id ON boards_managers USING btree (manager_id);


--
-- Name: index_categories_user_groups_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_categories_user_groups_on_category_id ON categories_user_groups USING btree (category_id);


--
-- Name: index_categories_user_groups_on_user_group_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_categories_user_groups_on_user_group_id ON categories_user_groups USING btree (user_group_id);


--
-- Name: index_forem_categories_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_forem_categories_on_slug ON forem_categories USING btree (slug);


--
-- Name: index_forem_forums_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_forem_forums_on_slug ON forem_forums USING btree (slug);


--
-- Name: index_forem_groups_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_groups_on_name ON forem_groups USING btree (name);


--
-- Name: index_forem_memberships_on_group_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_memberships_on_group_id ON forem_memberships USING btree (group_id);


--
-- Name: index_forem_moderator_groups_on_forum_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_moderator_groups_on_forum_id ON forem_moderator_groups USING btree (forum_id);


--
-- Name: index_forem_posts_on_reply_to_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_posts_on_reply_to_id ON forem_posts USING btree (reply_to_id);


--
-- Name: index_forem_posts_on_state; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_posts_on_state ON forem_posts USING btree (state);


--
-- Name: index_forem_posts_on_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_posts_on_topic_id ON forem_posts USING btree (topic_id);


--
-- Name: index_forem_posts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_posts_on_user_id ON forem_posts USING btree (user_id);


--
-- Name: index_forem_topics_on_forum_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_topics_on_forum_id ON forem_topics USING btree (forum_id);


--
-- Name: index_forem_topics_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_forem_topics_on_slug ON forem_topics USING btree (slug);


--
-- Name: index_forem_topics_on_state; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_topics_on_state ON forem_topics USING btree (state);


--
-- Name: index_forem_topics_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_topics_on_user_id ON forem_topics USING btree (user_id);


--
-- Name: index_forem_views_on_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_views_on_topic_id ON forem_views USING btree (viewable_id);


--
-- Name: index_forem_views_on_updated_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_views_on_updated_at ON forem_views USING btree (updated_at);


--
-- Name: index_forem_views_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forem_views_on_user_id ON forem_views USING btree (user_id);


--
-- Name: index_forums_boards_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_boards_on_category_id ON forums_boards USING btree (category_id);


--
-- Name: index_forums_boards_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_forums_boards_on_slug ON forums_boards USING btree (slug);


--
-- Name: index_forums_categories_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_forums_categories_on_slug ON forums_categories USING btree (slug);


--
-- Name: index_forums_posts_on_reply_to_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_posts_on_reply_to_id ON forums_posts USING btree (reply_to_id);


--
-- Name: index_forums_posts_on_topic_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_posts_on_topic_id ON forums_posts USING btree (topic_id);


--
-- Name: index_forums_posts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_posts_on_user_id ON forums_posts USING btree (user_id);


--
-- Name: index_forums_topics_on_board_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_topics_on_board_id ON forums_topics USING btree (board_id);


--
-- Name: index_forums_topics_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_forums_topics_on_slug ON forums_topics USING btree (slug);


--
-- Name: index_forums_topics_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_topics_on_user_id ON forums_topics USING btree (user_id);


--
-- Name: index_forums_views_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_views_on_user_id ON forums_views USING btree (user_id);


--
-- Name: index_forums_views_on_viewable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_forums_views_on_viewable_id ON forums_views USING btree (viewable_id);


--
-- Name: index_messages_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_ancestry ON messages USING btree (ancestry);


--
-- Name: index_news_entries_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_news_entries_on_slug ON news_entries USING btree (slug);


--
-- Name: index_pages_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_pages_on_slug ON pages USING btree (slug);


--
-- Name: index_permissions_on_identifier; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_permissions_on_identifier ON permissions USING btree (identifier);


--
-- Name: index_permissions_users_on_permission_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_permissions_users_on_permission_id ON permissions_users USING btree (permission_id);


--
-- Name: index_permissions_users_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_permissions_users_on_user_id ON permissions_users USING btree (user_id);


--
-- Name: index_shoutbox_messages_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_shoutbox_messages_on_user_id ON shoutbox_messages USING btree (user_id);


--
-- Name: index_system_settings_on_identifier; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_system_settings_on_identifier ON system_settings USING btree (identifier);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_name ON users USING btree (name);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_user_group_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_user_group_id ON users USING btree (user_group_id);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: tsvectorupdate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON forums_posts FOR EACH ROW EXECUTE PROCEDURE post_tsv_trigger();


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130624210201');

INSERT INTO schema_migrations (version) VALUES ('20130625000524');

INSERT INTO schema_migrations (version) VALUES ('20130625000525');

INSERT INTO schema_migrations (version) VALUES ('20130625005130');

INSERT INTO schema_migrations (version) VALUES ('20130625014237');

INSERT INTO schema_migrations (version) VALUES ('20130625014423');

INSERT INTO schema_migrations (version) VALUES ('20130625131047');

INSERT INTO schema_migrations (version) VALUES ('20130625162627');

INSERT INTO schema_migrations (version) VALUES ('20130625230908');

INSERT INTO schema_migrations (version) VALUES ('20130625230940');

INSERT INTO schema_migrations (version) VALUES ('20130626170548');

INSERT INTO schema_migrations (version) VALUES ('20130626233603');

INSERT INTO schema_migrations (version) VALUES ('20130626233604');

INSERT INTO schema_migrations (version) VALUES ('20130627115543');

INSERT INTO schema_migrations (version) VALUES ('20130627115544');

INSERT INTO schema_migrations (version) VALUES ('20130627115545');

INSERT INTO schema_migrations (version) VALUES ('20130627115546');

INSERT INTO schema_migrations (version) VALUES ('20130627115547');

INSERT INTO schema_migrations (version) VALUES ('20130627115548');

INSERT INTO schema_migrations (version) VALUES ('20130627115549');

INSERT INTO schema_migrations (version) VALUES ('20130627115550');

INSERT INTO schema_migrations (version) VALUES ('20130627115551');

INSERT INTO schema_migrations (version) VALUES ('20130627115552');

INSERT INTO schema_migrations (version) VALUES ('20130627115553');

INSERT INTO schema_migrations (version) VALUES ('20130627115554');

INSERT INTO schema_migrations (version) VALUES ('20130627115555');

INSERT INTO schema_migrations (version) VALUES ('20130627115556');

INSERT INTO schema_migrations (version) VALUES ('20130627115557');

INSERT INTO schema_migrations (version) VALUES ('20130627115558');

INSERT INTO schema_migrations (version) VALUES ('20130627115559');

INSERT INTO schema_migrations (version) VALUES ('20130627115560');

INSERT INTO schema_migrations (version) VALUES ('20130627115561');

INSERT INTO schema_migrations (version) VALUES ('20130627115562');

INSERT INTO schema_migrations (version) VALUES ('20130627115563');

INSERT INTO schema_migrations (version) VALUES ('20130627115564');

INSERT INTO schema_migrations (version) VALUES ('20130627115565');

INSERT INTO schema_migrations (version) VALUES ('20130627115566');

INSERT INTO schema_migrations (version) VALUES ('20130627115567');

INSERT INTO schema_migrations (version) VALUES ('20130627115568');

INSERT INTO schema_migrations (version) VALUES ('20130627115569');

INSERT INTO schema_migrations (version) VALUES ('20130627115570');

INSERT INTO schema_migrations (version) VALUES ('20130627115571');

INSERT INTO schema_migrations (version) VALUES ('20130627115572');

INSERT INTO schema_migrations (version) VALUES ('20130627120040');

INSERT INTO schema_migrations (version) VALUES ('20130627120218');

INSERT INTO schema_migrations (version) VALUES ('20130627121157');

INSERT INTO schema_migrations (version) VALUES ('20130627121759');

INSERT INTO schema_migrations (version) VALUES ('20130627121924');

INSERT INTO schema_migrations (version) VALUES ('20130627193509');

INSERT INTO schema_migrations (version) VALUES ('20130627194213');

INSERT INTO schema_migrations (version) VALUES ('20130627195518');

INSERT INTO schema_migrations (version) VALUES ('20130627233719');

INSERT INTO schema_migrations (version) VALUES ('20130628011800');

INSERT INTO schema_migrations (version) VALUES ('20130628124022');

INSERT INTO schema_migrations (version) VALUES ('20130628200107');

INSERT INTO schema_migrations (version) VALUES ('20130628200250');

INSERT INTO schema_migrations (version) VALUES ('20130628224156');

INSERT INTO schema_migrations (version) VALUES ('20130628224221');

INSERT INTO schema_migrations (version) VALUES ('20130701205928');
