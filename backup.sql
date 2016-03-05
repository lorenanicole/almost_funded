--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: campaigns_campaign; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE campaigns_campaign (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    deadline date NOT NULL,
    goal integer NOT NULL,
    raised integer NOT NULL,
    url character varying(200) NOT NULL,
    description character varying(200) NOT NULL,
    last_updated date NOT NULL,
    recipient character varying(200) NOT NULL,
    creator character varying(200) NOT NULL,
    location character varying(200) NOT NULL,
    category_id integer NOT NULL,
    source integer NOT NULL
);


--
-- Name: campaigns_campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campaigns_campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaigns_campaign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campaigns_campaign_id_seq OWNED BY campaigns_campaign.id;


--
-- Name: campaigns_category; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE campaigns_category (
    id integer NOT NULL,
    category character varying(100) NOT NULL
);


--
-- Name: campaigns_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campaigns_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campaigns_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE campaigns_category_id_seq OWNED BY campaigns_category.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaigns_campaign ALTER COLUMN id SET DEFAULT nextval('campaigns_campaign_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaigns_category ALTER COLUMN id SET DEFAULT nextval('campaigns_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add category	7	add_category
20	Can change category	7	change_category
21	Can delete category	7	delete_category
22	Can add campaign	8	add_campaign
23	Can change campaign	8	change_campaign
24	Can delete campaign	8	delete_campaign
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('auth_permission_id_seq', 24, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, false);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: campaigns_campaign; Type: TABLE DATA; Schema: public; Owner: -
--

COPY campaigns_campaign (id, name, deadline, goal, raised, url, description, last_updated, recipient, creator, location, category_id, source) FROM stdin;
1	Rainbow Trout Angler's Pint	2016-03-25	5500	5183	https://www.kickstarter.com/projects/1003672417/rainbow-trout-anglers-pint?ref=discovery	Bigger than an American & British pint, this 21.5 ounce Angler's Pint is functional art for tall tales after a day on the water!	2016-03-05	https://www.kickstarter.com/locations/maine-caribou-me	Karen Talbot Art	Maine, ME	1	0
2	Art Nude Photobook: Pink Sands Explores Unspoiled Landscape	2016-03-14	5000	4806	https://www.kickstarter.com/projects/aknicholas/art-nude-photobook-documentary-film-gallery-prints?ref=discovery	Art Nudes in Pristine Island Landscape: 100+ image autographed photobook, HD documentary, limited edition prints, album, card sets	2016-03-05	https://www.kickstarter.com/locations/charleston-sc	A K Nicholas	Charleston, SC	1	0
3	Hand Drawn Pet Portraits!	2016-03-19	1100	1075	https://www.kickstarter.com/projects/doodlesumo/hand-drawn-pet-portraits?ref=discovery	You have pets and cherish them and I'd love to make their image into your own piece of fine art!	2016-03-05	https://www.kickstarter.com/locations/jacksonville-fl	Michael Thompson	Jacksonville, FL	1	0
4	Tales of Clockworktropolis: A Coloring Adventure Book!	2016-03-28	2000	1839	https://www.kickstarter.com/projects/bkartmerc/tales-of-clockworktropolis-a-coloring-adventure-bo?ref=discovery	An Original Steampunk Art and Coloring book for Airship Enthusiasts of all ages!	2016-03-05	https://www.kickstarter.com/locations/boston-ma	Brett Kelley	Boston, MA	1	0
5	Firedance Jewelry - Artisan Necklaces	2016-03-17	500	474	https://www.kickstarter.com/projects/1938938385/firedance-jewelry-artisan-necklaces?ref=discovery	Firedance Jewelry - the fusion of art & science	2016-03-05	https://www.kickstarter.com/locations/hampton-cove-al	Firedance Jewelry	Hampton Cove, AL	1	0
6	Collective Confluence: A Project Space, NCECA 2016	2016-03-12	1500	1357	https://www.kickstarter.com/projects/1869650879/collective-confluence-a-project-space-nceca-2016?ref=discovery	A 3-day participatory exhibition of unfired clay tile that records connections between makers at the annual ceramics conference.	2016-03-05	https://www.kickstarter.com/locations/kansas-city-mo	Brian Kluge	Kansas City, MO	1	0
7	Live in Germany! New CD from Namoli Brennet Trio	2016-03-18	1800	1780	https://www.kickstarter.com/projects/namolibrennet/live-in-germany-new-cd-from-namoli-brennet-trio?ref=discovery	Recorded in clubs, art galleries and convents while traipsing across Germany with drummer Micha Maas and bassist Amy Zapf. Wunderbar!	2016-03-05	https://www.kickstarter.com/locations/berlin-berlin-de	namoli brennet	Berlin, Germany	1	0
8	Genova, ruvida poesia	2016-03-17	900	866	https://www.kickstarter.com/projects/1760142046/genova-ruvida-poesia?ref=discovery	"Due giovani fotografi,  \n una burbera città di rara bellezza, e la loro celebrazione attraverso  la luce"	2016-03-05	https://www.kickstarter.com/locations/genoa-genoa-liguria	Diletta&Mattia	Genoa, Italy	1	0
9	SAFE - a book exploring London's queer performance scene	2016-03-14	1500	1402	https://www.kickstarter.com/projects/linneafrank/safe-a-book-exploring-londons-queer-performance-sc?ref=discovery	SAFE gives a glimpse into the London queer performance scene and what it means to perform and embody a wide range of genders.	2016-03-05	https://www.kickstarter.com/locations/london-gb	Linnea Frank	London, UK	1	0
10	My Deepest Empathy	2016-03-17	1500	1442	https://www.kickstarter.com/projects/662678279/my-deepest-empathy?ref=discovery	This is a fully illustrated book that serves as an appropriate gift to someone who is grieving.	2016-03-05	https://www.kickstarter.com/locations/salt-lake-city-ut	Micky Curtis	Salt Lake City, UT	1	0
11	Ultra Coins	2016-03-27	6500	6273	https://www.kickstarter.com/projects/1719872687/ultra-coins?ref=discovery	A different type of game for 2-8 players. No dice. No board. Solid brass spinning coins. Amazing art. Fun, challenging, easy to learn.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	J.M. Ward	Los Angeles, CA	1	0
12	TURNCOAT - The Complete Hardcover Graphic Novel	2016-03-30	18000	17281	https://www.kickstarter.com/projects/ryanosullivan/turncoat-the-complete-hardcover-graphic-novel?ref=discovery	What would your life be like if you killed superheroes for a living?	2016-03-05	https://www.kickstarter.com/locations/new-york-ny	Ryan O'Sullivan	New York, NY	2	0
13	YEAR OF THE GOAT ISSUE #4 COMIC BOOK	2016-03-24	1500	1438	https://www.kickstarter.com/projects/1891468611/year-of-the-goat-issue-4-comic-book-0?ref=discovery	THE GOATPOCALYPSE IS HERE! Goats are taking over the world and the one man that seems to know how to stop them is a very unlikely hero!	2016-03-05	https://www.kickstarter.com/locations/new-york-ny	Tom Spellman	New York, NY	2	0
14	The Mindgator: The Kiss	2016-03-09	3300	3175	https://www.kickstarter.com/projects/626802754/the-mindgator-the-kiss?ref=discovery	The Mindgator: The Kiss is part 1 of a 4-part story of the kinetic, self-destructive, city life of megalopolis, future Tokyo.	2016-03-05	https://www.kickstarter.com/locations/tokyo-jp	Mulele Redux	Tokyo, Japan	2	0
15	Love Not Found - Volume 1	2016-03-18	12500	12493	https://www.kickstarter.com/projects/1882684772/love-not-found-volume-1?ref=discovery	A sci-fi romance set in a time when touching has become outdated. Abeille seeks a partner interested in doing it the old-fashioned way.	2016-03-05	https://www.kickstarter.com/locations/portland-or	Gina Biggs	Portland, OR	2	0
16	Tobacco Road Dance Productions: In Concert 2016	2016-03-11	2500	2275	https://www.kickstarter.com/projects/557817637/tobacco-road-dance-productions-in-concert-2016?ref=discovery	Tobacco Road Dance Productions celebrates its second season with a dance concert highlighting vulnerability and the human condition.	2016-03-05	https://www.kickstarter.com/locations/durham-nc	Tobacco Road Dance Productions	Durham, NC	3	0
17	John Cantwell's FADE 2 CONNIE: The Roxy Files	2016-03-09	10000	9417	https://www.kickstarter.com/projects/993252159/john-cantwells-fade-2-connie-the-roxy-files?ref=discovery	A multi media solo dance tribute to 70s glam rock band, Roxy Music, featuring a backdrop of filmed projections and live performance.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	John Cantwell	Los Angeles, CA	3	0
18	INFINIT || Flight Deck Inspired Race Chronograph || Watch	2016-03-16	10000	9325	https://www.kickstarter.com/projects/infinit/infinit-flight-deck-inspired-race-chronograph?ref=discovery	A Swiss Made Luxury Timepiece, Sapphire Crystal, Chronograph & Tachymeter. 100 Meter Water Resistant || Limited Edition Watches.	2016-03-05	https://www.kickstarter.com/locations/downtown-toronto-toronto-ca	INFINIT DESIGNS	Downtown Toronto, Canada	4	0
19	NOZIPP: Building Better Sleeping Bags	2016-03-30	10000	9036	https://www.kickstarter.com/projects/nozipp/nozipp-building-better-sleeping-bags?ref=discovery	An innovative zipperless design. Effortless entry, wide-ranging temperature control, and enhanced comfort.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	Taylor Henderson	Los Angeles, CA	4	0
20	Rainbow Trout Angler's Pint	2016-03-25	5500	5183	https://www.kickstarter.com/projects/1003672417/rainbow-trout-anglers-pint?ref=discovery	Bigger than an American & British pint, this 21.5 ounce Angler's Pint is functional art for tall tales after a day on the water!	2016-03-05	https://www.kickstarter.com/locations/maine-caribou-me	Karen Talbot Art	Maine, ME	4	0
21	The World's First 3D Emoji Jewelry by Pow HiSo	2016-03-11	8000	7486	https://www.kickstarter.com/projects/765809437/the-worlds-first-3d-emoji-jewelry-by-pow-hiso?ref=discovery	Wearable Emotions: Turning your favorite 2D emojis into 3D jewelry pendants! Ancient practices meets new technology!	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	Pow HiSo	Los Angeles, CA	4	0
22	"MAGICTWEE" tweezers with 100% Performance & safety system.	2016-03-16	6000	5718	https://www.kickstarter.com/projects/2056965423/magictwee-tweezers-with-100-performance-and-safety?ref=discovery	"MAGICTWEE" are revolutionary tweezers with a swinging head, which enables the easy removal of undesired hairs.	2016-03-05	https://www.kickstarter.com/locations/luxemburg-lu	Madjid Ahrar	Luxemburg, Luxembourg	4	0
23	UV Pro Shoe Sanitizer - Eliminates 99% of Bacteria & Fungus	2016-03-17	40000	37031	https://www.kickstarter.com/projects/458136547/uv-pro-shoe-sanitizer-designed-to-fit-your-lifesty?ref=discovery	UV Pro is laboratory tested and guaranteed to sanitize and kill up to 99.99% of odor causing bacteria and fungus in shoes, bags, etc.	2016-03-05	https://www.kickstarter.com/locations/seattle-wa	Michael Fligil	Seattle, WA	4	0
24	Professional Dueling & Cosplay Lightsaber	2016-03-08	20000	18650	https://www.kickstarter.com/projects/605677994/professional-dueling-led-sabers?ref=discovery	We are glad to introduce you our project - fully modular, customizable, ready to battle lightsabers/LED Sabers - ForceBlades.	2016-03-05	https://www.kickstarter.com/locations/amsterdam-nl	Jaroslaw Scibiorek	Amsterdam, Netherlands	4	0
25	Pocket Nips	2016-03-23	1000	920	https://www.kickstarter.com/projects/2134525772/pocket-nips?ref=discovery	The Pocket Nips are a great addition to your fishing vest and your EDC arsenal. Aluminum body with replaceable titanium blades.	2016-03-05	https://www.kickstarter.com/locations/mooresville-nc	Steve Schram	Mooresville, NC	4	0
26	TURBO Footstool - A Bathroom Must Have for Better Health	2016-03-19	35000	34211	https://www.kickstarter.com/projects/2061222615/turbo-footstool-a-bathroom-must-have-for-better-he?ref=discovery	A toilet footstool for squatting and massage, leading to better health. Best value for LASTING WELLNESS!	2016-03-05	https://www.kickstarter.com/locations/sunnyvale-ca	Tikeswar Naik	Sunnyvale, CA	4	0
27	Black Site X and Rapid Vanguard Terrain by Death Ray Designs	2016-03-14	20000	18595	https://www.kickstarter.com/projects/brush4hire/black-site-x-and-rapid-vanguard-terrain-by-death-r?ref=discovery	Black Site X -Functional, modular terrain for skirmish games.\nRapid Vanguard -Highly detailed fortifications ready to drop from orbit.	2016-03-05	https://www.kickstarter.com/locations/greensboro-nc	Austin Thompson	Greensboro, NC	4	0
28	Super Clamp V1: The World's Most Versatile Mini Clamp	2016-03-10	5000	4828	https://www.kickstarter.com/projects/971024944/super-clamp-v1-the-worlds-most-versatile-mini-clam?ref=discovery	A key chain size "C-Clamp" with multi-tools designed for daily carry.	2016-03-05	https://www.kickstarter.com/locations/san-francisco-ca	Andrew Roxas	San Francisco, CA	4	0
29	Ravn Playing Cards	2016-04-02	130000	120637	https://www.kickstarter.com/projects/ravnmagic/ravn-playing-cards?ref=discovery	Custom Playing Cards, Poker size. Designed by Stockholm17 for Caroline Ravn magician. Printed by the United States Playing Card Co.	2016-03-05	https://www.kickstarter.com/locations/stockholm-stockholm-se	Ravn Magic	Stockholm, Sweden	4	0
30	Teliad - Poker Playing Cards in a fantasy world	2016-03-30	17000	15682	https://www.kickstarter.com/projects/passione/teliad-poker-playing-cards-in-a-fantasy-world?ref=discovery	Custom designed poker size playing cards inspired by a classic fantasy world with humans, elves, orcs and dwarves. Printed by LPCC	2016-03-05	https://www.kickstarter.com/locations/hayward-alameda-ca	PassioneTeam	Hayward, CA	4	0
31	Firedance Jewelry - Artisan Necklaces	2016-03-17	500	474	https://www.kickstarter.com/projects/1938938385/firedance-jewelry-artisan-necklaces?ref=discovery	Firedance Jewelry - the fusion of art & science	2016-03-05	https://www.kickstarter.com/locations/hampton-cove-al	Firedance Jewelry	Hampton Cove, AL	5	0
32	Love Not Found - Volume 1	2016-03-18	12500	12493	https://www.kickstarter.com/projects/1882684772/love-not-found-volume-1?ref=discovery	A sci-fi romance set in a time when touching has become outdated. Abeille seeks a partner interested in doing it the old-fashioned way.	2016-03-05	https://www.kickstarter.com/locations/portland-or	Gina Biggs	Portland, OR	5	0
33	Husky (Short Film)	2016-03-12	1000	905	https://www.kickstarter.com/projects/1162191345/husky-short-film?ref=discovery	A short film about Marcus, a boy on the brink of adulthood who struggles to decide where his loyalties lie.	2016-03-05	https://www.kickstarter.com/locations/london-gb	Polly Rosier	London, UK	6	0
34	H.P. Lovecraft Film Festival® & CthulhuCon™ - San Pedro 2016	2016-03-14	11000	10836	https://www.kickstarter.com/projects/372215552/hp-lovecraft-film-festival-and-cthulhucon-san-pedr-0?ref=discovery	The H.P. Lovecraft Film Festival® - San Pedro returns for the 7th year at the Warner Grand Theatre in historic San Pedro, California	2016-03-05	https://www.kickstarter.com/locations/san-pedro-los-angeles-ca	HPLFF-SoCal, LLC	San Pedro, CA	6	0
35	Zero-Two Short Film	2016-03-09	2800	2656	https://www.kickstarter.com/projects/354020428/zero-two-short-film?ref=discovery	A man who has spent his entire life in a cell falls in love with a mysterious voice on the other side of the wall.	2016-03-05	https://www.kickstarter.com/locations/austin-tx	Peter Richard and Elisabetta Diorio	Austin, TX	6	0
36	St. Louis Brews, a feature-length documentary film	2016-03-15	15000	14048	https://www.kickstarter.com/projects/bills/st-louis-brews-a-feature-length-documentary-film?ref=discovery	Learn how St. Louis became one of the great beer cities of the world and where it's going in the future.	2016-03-05	https://www.kickstarter.com/locations/st-louis-mo	bill streeter	St. Louis, MO	6	0
37	Sunrise Paradise	2016-03-17	10000	9212	https://www.kickstarter.com/projects/2144819920/sunrise-paradise?ref=discovery	Sunrise Paradise is a short film that tests just how far one boy will go to get the girl of his dreams.	2016-03-05	https://www.kickstarter.com/locations/miami-fl	Bronsen Bloom	Miami, FL	6	0
38	United States of Mind: A Documentary	2016-03-10	3000	2794	https://www.kickstarter.com/projects/543904581/united-states-of-mind-a-documentary?ref=discovery	10,000 Miles. 32 States. 3 Seekers of Happiness. 2 Missions. 1 Goal. A documentary about fighting depression and finding happiness.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	Paul Young Lee	Los Angeles, CA	6	0
39	KONTEMPORARY SOUND SYSTEM	2016-03-06	6500	6476	https://www.kickstarter.com/projects/744259184/kontemporary-sound-system?ref=discovery	A visually mesmerizing exploration of man and nature. "Kontemporary Sound System" will take place in Montreal, Canada.	2016-03-05	https://www.kickstarter.com/locations/montreal-ca	HIRVI	Montreal, Canada	6	0
40	Royal Affairs	2016-03-16	5000	4955	https://www.kickstarter.com/projects/459114096/royal-affairs?ref=discovery	Royal Affairs is a short comedy, (mostly) set in space. Greg is having a bad day, when he is selected to choose the fate of humanity.	2016-03-05	https://www.kickstarter.com/locations/cologne-de	Royal Pictures	Cologne, Germany	6	0
41	My Victoria	2016-03-26	5500	5150	https://www.kickstarter.com/projects/1511488429/my-victoria?ref=discovery	Within the vibrant and eccentric setting of the pub where he works, Fabio finds his muse and unleashes his creativity.	2016-03-05	https://www.kickstarter.com/locations/london-gb	Francesco Durante Viola	London, UK	6	0
42	Gigamunch	2016-03-12	10000	9256	https://www.kickstarter.com/projects/261196021/gigamunch?ref=discovery	There's a whole world of local cooks creating amazing, homemade food. We help you discover meals and deliver them to you.	2016-03-05	https://www.kickstarter.com/locations/nashville-tn	Gigamunch	Nashville, TN	7	0
43	Buttercream Bakeshop	2016-03-09	46000	42568	https://www.kickstarter.com/projects/944966502/buttercream-bakeshop?ref=discovery	Scratch baked cakes, cookies and confections by award winning pastry chef Tiffany MacIsaac and lead decorator Alexandra Mudry.	2016-03-05	https://www.kickstarter.com/locations/washington-dc	Tiffany MacIsaac	Washington, DC	7	0
44	Altais: Age of Ruin - A dystopian fantasy RPG - Relaunch	2016-03-08	10000	9434	https://www.kickstarter.com/projects/1121209158/altais-age-of-ruin-a-dystopian-fantasy-rpg-relaunc?ref=discovery	A dystopian fantasy game about fallen kingdoms, quantum magic, and alien worlds. A dark backdrop against which heroes shine brightest.	2016-03-05	https://www.kickstarter.com/locations/melbourne-au	Parhelia Games	Melbourne, AU	8	0
45	SILLY STREET the family Game!!!!	2016-03-18	20000	18292	https://www.kickstarter.com/projects/542836133/silly-street-the-family-game?ref=discovery	Want your kiddos to have GRIT? Character? Charisma? General awesomeness? DO NOT PASS GO, visit Silly Street! A new board game for fams.	2016-03-05	https://www.kickstarter.com/locations/venice-los-angeles-ca	Meghan DeRoma	Venice, CA	8	0
46	The Working Dead: An Undead Office Game	2016-03-09	5000	4705	https://www.kickstarter.com/projects/1492134624/the-working-dead-an-undead-office-game?ref=discovery	The Working Dead is a card game about working in the most toxic office environment possible. Oh, and there is also the Undead.	2016-03-05	https://www.kickstarter.com/locations/indianapolis-in	Andrew Young	Indianapolis, IN	8	0
47	House of Borgia	2016-03-16	25000	23400	https://www.kickstarter.com/projects/693352677/house-of-borgia?ref=discovery	A Hidden Role Dice Game with Deduction and Bluffing for 2-6 players that plays in 30 minutes.	2016-03-05	https://www.kickstarter.com/locations/surprise-az	Talon Strikes Studios	Surprise, AZ	8	0
48	Fantasy Champions from Around the Ancient World - Set Three	2016-03-11	2100	1891	https://www.kickstarter.com/projects/nickryan/fantasy-champions-from-around-the-ancient-world-se-0?ref=discovery	Unique fantasy miniatures inspired by historical civilizations of ancient times, forged in pewter for your tabletop gaming experience.	2016-03-05	https://www.kickstarter.com/locations/idlyllwild-pine-cove-ca	Nick Ryan	Idyllwild-Pine Cove, CA	8	0
49	Black Site X and Rapid Vanguard Terrain by Death Ray Designs	2016-03-14	20000	18595	https://www.kickstarter.com/projects/brush4hire/black-site-x-and-rapid-vanguard-terrain-by-death-r?ref=discovery	Black Site X -Functional, modular terrain for skirmish games.\nRapid Vanguard -Highly detailed fortifications ready to drop from orbit.	2016-03-05	https://www.kickstarter.com/locations/greensboro-nc	Austin Thompson	Greensboro, NC	8	0
50	Ultra Coins	2016-03-27	6500	6273	https://www.kickstarter.com/projects/1719872687/ultra-coins?ref=discovery	A different type of game for 2-8 players. No dice. No board. Solid brass spinning coins. Amazing art. Fun, challenging, easy to learn.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	J.M. Ward	Los Angeles, CA	8	0
51	Baby Bestiary Volume 2 & Vol. 1 Reprint	2016-03-09	38000	37285	https://www.kickstarter.com/projects/metalweavedesigns/baby-bestiary-volume-2-and-vol-1-reprint?ref=discovery	Discover the Adorable in the second volume (and first reprint) of the most adorable monster lorebook ever!	2016-03-05	https://www.kickstarter.com/locations/philadelphia-pa	Andreas Walters	Philadelphia, PA	8	0
52	Teliad - Poker Playing Cards in a fantasy world	2016-03-30	17000	15682	https://www.kickstarter.com/projects/passione/teliad-poker-playing-cards-in-a-fantasy-world?ref=discovery	Custom designed poker size playing cards inspired by a classic fantasy world with humans, elves, orcs and dwarves. Printed by LPCC	2016-03-05	https://www.kickstarter.com/locations/hayward-alameda-ca	PassioneTeam	Hayward, CA	8	0
53	Japanese Scrolls Playing Cards	2016-04-08	5000	4675	https://www.kickstarter.com/projects/521277495/japanese-scrolls-playing-cards?ref=discovery	The third installment of the ancient culture playing cards by Emmanuel Valtierra Illustrator.	2016-03-05	https://www.kickstarter.com/locations/san-antonio-tx	Emmanuel Valtierra	San Antonio, TX	8	0
54	Ravn Playing Cards	2016-04-02	130000	120637	https://www.kickstarter.com/projects/ravnmagic/ravn-playing-cards?ref=discovery	Custom Playing Cards, Poker size. Designed by Stockholm17 for Caroline Ravn magician. Printed by the United States Playing Card Co.	2016-03-05	https://www.kickstarter.com/locations/stockholm-stockholm-se	Ravn Magic	Stockholm, Sweden	8	0
55	New EP/Music Development	2016-03-10	3000	2719	https://www.kickstarter.com/projects/109494405/new-ep-music-development-47?ref=discovery	Breakout Artist Management has offered to work with and develop this project in the studio and we need your help!	2016-03-05	https://www.kickstarter.com/locations/dublin-nh	Hug The Dog	Dublin, NH	9	0
56	Tobacco Fields	2016-03-18	2500	2361	https://www.kickstarter.com/projects/ronleary/tobacco-fields?ref=discovery	Support the making of Ron Leary's 3rd full-length release "Tobacco Fields"	2016-03-05	https://www.kickstarter.com/locations/windsor-qc-ca	Ron Leary	Windsor, Canada	9	0
57	Dana Lynn Dufrene ...and so it begins!	2016-03-15	10000	9015	https://www.kickstarter.com/projects/danalynndufrene/dana-lynn-dufrene-and-so-it-begins?ref=discovery	Song writing team of Dana Lynn Dufrene and Michael J. O'Hara are working on a full record with David Treadway @ DDTstudio  New Orleans	2016-03-05	https://www.kickstarter.com/locations/new-orleans-la	Dana Lynn Dufrene	New Orleans, LA	9	0
58	Beaver Nelson's Positive  - CD	2016-03-10	13500	13000	https://www.kickstarter.com/projects/1259507576/beaver-nelsons-positive-cd?ref=discovery	Finishing my new CD Positive, promoting it, and finishing an EP of otherwise unreleased material.	2016-03-05	https://www.kickstarter.com/locations/austin-tx	Beaver Nelson	Austin, TX	9	0
59	Saint Adeline's first EP	2016-03-12	12000	11251	https://www.kickstarter.com/projects/1330120090/saint-adelines-first-ep?ref=discovery	Saint Adeline - a young folk pop band composed of siblings Drew, Kasie, and Chloe Gasparini - is recording its very first EP!	2016-03-05	https://www.kickstarter.com/locations/brooklyn-ny	Erica Rotstein	Brooklyn, NY	9	0
60	Djake plays Django	2016-03-07	5000	4501	https://www.kickstarter.com/projects/1468329360/djake-plays-django?ref=discovery	Musician Jacob Johnson and artist Zach Landrum collaborate on a tribute to the legacy of jazz guitarist Django Reinhardt.	2016-03-05	https://www.kickstarter.com/locations/travelers-rest-sc	Jacob Johnson	Travelers Rest, SC	9	0
61	Grant Farm - Kiss the Ground Album	2016-03-06	12500	11863	https://www.kickstarter.com/projects/2135802094/grant-farm-kiss-the-ground-album?ref=discovery	The third Full-Length Album from Grant Farm is an ambitious concept album focusing on struggle and achievement in modern society.	2016-03-05	https://www.kickstarter.com/locations/boulder-co	Tyler Grant	Boulder, CO	9	0
62	Help fund the printing of Joakim Hansson's first album!	2016-03-11	2500	2370	https://www.kickstarter.com/projects/240219455/help-fund-the-printing-of-joakim-hanssons-first-al?ref=discovery	I recorded for more than a year. Found a great label with online distribution. And of course, i want to release it as CD & Vinyl also.	2016-03-05	https://www.kickstarter.com/locations/berlin-berlin-de	Joakim Hansson	Berlin, Germany	9	0
63	John Cantwell's FADE 2 CONNIE: The Roxy Files	2016-03-09	10000	9417	https://www.kickstarter.com/projects/993252159/john-cantwells-fade-2-connie-the-roxy-files?ref=discovery	A multi media solo dance tribute to 70s glam rock band, Roxy Music, featuring a backdrop of filmed projections and live performance.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	John Cantwell	Los Angeles, CA	9	0
64	Genova, ruvida poesia	2016-03-17	900	866	https://www.kickstarter.com/projects/1760142046/genova-ruvida-poesia?ref=discovery	"Due giovani fotografi,  \n una burbera città di rara bellezza, e la loro celebrazione attraverso  la luce"	2016-03-05	https://www.kickstarter.com/locations/genoa-genoa-liguria	Diletta&Mattia	Genoa, Italy	10	0
65	Documenting the 2016 International Rapier Seminar	2016-03-14	800	765	https://www.kickstarter.com/projects/1472712851/documenting-the-2016-international-rapier-seminar?ref=discovery	Send a swordfighting photographer from Vancouver, BC to Godalming, UK to document the event and fight all comers.	2016-03-05	https://www.kickstarter.com/locations/godalming-gb	Courtney Rice	Godalming, UK	10	0
66	Art Nude Photobook: Pink Sands Explores Unspoiled Landscape	2016-03-14	5000	4806	https://www.kickstarter.com/projects/aknicholas/art-nude-photobook-documentary-film-gallery-prints?ref=discovery	Art Nudes in Pristine Island Landscape: 100+ image autographed photobook, HD documentary, limited edition prints, album, card sets	2016-03-05	https://www.kickstarter.com/locations/charleston-sc	A K Nicholas	Charleston, SC	10	0
67	Anomalous Press 2016 Chapbook Series	2016-03-08	5000	4705	https://www.kickstarter.com/projects/1722705325/anomalous-press-2016-chapbook-series?ref=discovery	Anomalous Press (now an imprint of Drunken Boat) is publishing its 4th season of beautiful, mind-bending books.	2016-03-05	https://www.kickstarter.com/locations/san-francisco-ca	Anomalous Press	San Francisco, CA	11	0
68	"CONFUSION" - A collection of hysterical feminisms	2016-03-13	1000	919	https://www.kickstarter.com/projects/829143091/confusion-a-collection-of-hysterical-feminisms?ref=discovery	HYSTERIA is raising funds for the printing and distribution of our seventh periodical, "CONFUSION"	2016-03-05	https://www.kickstarter.com/locations/london-gb	Bjørk Grue Lidin	London, UK	11	0
69	The Perfect People	2016-03-20	7030	6521	https://www.kickstarter.com/projects/171957126/the-perfect-people?ref=discovery	Posthumously publishing our mom's children's book about disability: about a princess who can see past first appearances	2016-03-05	https://www.kickstarter.com/locations/cincinnati-oh	Danielle D	Cincinnati, OH	11	0
70	Voices from the Other War: Reporting the Truth in Mexico	2016-03-08	5000	4721	https://www.kickstarter.com/projects/1541251064/voices-from-the-other-war-reporting-the-truth-in-m?ref=discovery	A book of translations, photographs, interviews, and essays highlighting the best frontline reporting from Mexico's at-risk journalists	2016-03-05	https://www.kickstarter.com/locations/san-diego-ca	The Trans-Border Institute	San Diego, CA	11	0
71	Voices from the Other War: Reporting the Truth in Mexico	2016-03-08	5000	4721	https://www.kickstarter.com/projects/1541251064/voices-from-the-other-war-reporting-the-truth-in-m?ref=discovery	A book of translations, photographs, interviews, and essays highlighting the best frontline reporting from Mexico's at-risk journalists	2016-03-05	https://www.kickstarter.com/locations/san-diego-ca	The Trans-Border Institute	San Diego, CA	11	0
72	SAFE - a book exploring London's queer performance scene	2016-03-14	1500	1402	https://www.kickstarter.com/projects/linneafrank/safe-a-book-exploring-londons-queer-performance-sc?ref=discovery	SAFE gives a glimpse into the London queer performance scene and what it means to perform and embody a wide range of genders.	2016-03-05	https://www.kickstarter.com/locations/london-gb	Linnea Frank	London, UK	11	0
73	My Deepest Empathy	2016-03-17	1500	1442	https://www.kickstarter.com/projects/662678279/my-deepest-empathy?ref=discovery	This is a fully illustrated book that serves as an appropriate gift to someone who is grieving.	2016-03-05	https://www.kickstarter.com/locations/salt-lake-city-ut	Micky Curtis	Salt Lake City, UT	11	0
74	Tales of Clockworktropolis: A Coloring Adventure Book!	2016-03-28	2000	1839	https://www.kickstarter.com/projects/bkartmerc/tales-of-clockworktropolis-a-coloring-adventure-bo?ref=discovery	An Original Steampunk Art and Coloring book for Airship Enthusiasts of all ages!	2016-03-05	https://www.kickstarter.com/locations/boston-ma	Brett Kelley	Boston, MA	11	0
75	A Skyboat Audiobook of Harlan Ellison's Star Trek Teleplay	2016-03-18	15000	14740	https://www.kickstarter.com/projects/342254102/a-skyboat-audiobook-of-harlan-ellisons-star-trek-t?ref=discovery	A full-cast audiobook of the original Star Trek episode "The City on The Edge of Forever" by Harlan Ellison and all the controversy.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	Skyboat Media, Inc.	Los Angeles, CA	11	0
76	My Deepest Empathy	2016-03-17	1500	1442	https://www.kickstarter.com/projects/662678279/my-deepest-empathy?ref=discovery	This is a fully illustrated book that serves as an appropriate gift to someone who is grieving.	2016-03-05	https://www.kickstarter.com/locations/salt-lake-city-ut	Micky Curtis	Salt Lake City, UT	11	0
77	A Skyboat Audiobook of Harlan Ellison's Star Trek Teleplay	2016-03-18	15000	14740	https://www.kickstarter.com/projects/342254102/a-skyboat-audiobook-of-harlan-ellisons-star-trek-t?ref=discovery	A full-cast audiobook of the original Star Trek episode "The City on The Edge of Forever" by Harlan Ellison and all the controversy.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	Skyboat Media, Inc.	Los Angeles, CA	11	0
78	WiCAM: The programmable wireless coin cam	2016-04-15	40000	36698	https://www.kickstarter.com/projects/1628949700/wicam-the-programmable-wireless-coin-cam?ref=discovery	Imagine a camera that's smaller and wireless that you install anywhere. That’s WiCAM. WiFi and Bluetooth enabled coin cam!	2016-03-05	https://www.kickstarter.com/locations/ottawa-ca	Armstart Inc.	Ottawa, Canada	12	0
79	Super Clamp V1: The World's Most Versatile Mini Clamp	2016-03-10	5000	4828	https://www.kickstarter.com/projects/971024944/super-clamp-v1-the-worlds-most-versatile-mini-clam?ref=discovery	A key chain size "C-Clamp" with multi-tools designed for daily carry.	2016-03-05	https://www.kickstarter.com/locations/san-francisco-ca	Andrew Roxas	San Francisco, CA	12	0
80	The World's First 3D Emoji Jewelry by Pow HiSo	2016-03-11	8000	7486	https://www.kickstarter.com/projects/765809437/the-worlds-first-3d-emoji-jewelry-by-pow-hiso?ref=discovery	Wearable Emotions: Turning your favorite 2D emojis into 3D jewelry pendants! Ancient practices meets new technology!	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	Pow HiSo	Los Angeles, CA	12	0
81	BAT-SAFE	2016-03-18	25000	23254	https://www.kickstarter.com/projects/228823410/bat-safe?ref=discovery	BAT-SAFE is an easy to use device that ensures your safety while charging and storing LiPo batteries. And it really works!	2016-03-05	https://www.kickstarter.com/locations/carrollton-tx	Tom Mast	Carrollton, TX	12	0
82	BAT-SAFE	2016-03-18	25000	23254	https://www.kickstarter.com/projects/228823410/bat-safe?ref=discovery	BAT-SAFE is an easy to use device that ensures your safety while charging and storing LiPo batteries. And it really works!	2016-03-05	https://www.kickstarter.com/locations/carrollton-tx	Tom Mast	Carrollton, TX	12	0
83	Kasia - What did you forget to turn off today?	2016-04-08	30000	28523	https://www.kickstarter.com/projects/1505213132/kasia-what-did-you-forget-to-turn-off-today?ref=discovery	The most affordable #SmartHome system offering you peace of mind, convenience, while saving time and energy.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	Kasia Inc	Los Angeles, CA	12	0
84	John Cantwell's FADE 2 CONNIE: The Roxy Files	2016-03-09	10000	9417	https://www.kickstarter.com/projects/993252159/john-cantwells-fade-2-connie-the-roxy-files?ref=discovery	A multi media solo dance tribute to 70s glam rock band, Roxy Music, featuring a backdrop of filmed projections and live performance.	2016-03-05	https://www.kickstarter.com/locations/los-angeles-ca	John Cantwell	Los Angeles, CA	13	0
85	Get Conti to the Ed Fringe!	2016-04-21	1000	910	https://www.kickstarter.com/projects/italiaconti/get-conti-to-the-ed-fringe?ref=discovery	The Italia Conti 2nd years are going to Ed Fringe! But not without your help!	2016-03-05	https://www.kickstarter.com/locations/edinburgh-gb	Italia Conti 2nd Years	Edinburgh, UK	13	0
\.


--
-- Name: campaigns_campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('campaigns_campaign_id_seq', 85, true);


--
-- Data for Name: campaigns_category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY campaigns_category (id, category) FROM stdin;
1	art
2	comics
3	dance
4	design
5	fashion
6	film+%26+video
7	food
8	games
9	music
10	photography
11	publishing
12	technology
13	theater
\.


--
-- Name: campaigns_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('campaigns_category_id_seq', 13, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	campaigns	category
8	campaigns	campaign
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('django_content_type_id_seq', 8, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2016-03-03 20:38:26.258998-05
2	auth	0001_initial	2016-03-03 20:38:26.319209-05
3	admin	0001_initial	2016-03-03 20:38:26.342387-05
4	admin	0002_logentry_remove_auto_add	2016-03-03 20:38:26.357778-05
5	contenttypes	0002_remove_content_type_name	2016-03-03 20:38:26.391186-05
6	auth	0002_alter_permission_name_max_length	2016-03-03 20:38:26.404734-05
7	auth	0003_alter_user_email_max_length	2016-03-03 20:38:26.430699-05
8	auth	0004_alter_user_username_opts	2016-03-03 20:38:26.441082-05
9	auth	0005_alter_user_last_login_null	2016-03-03 20:38:26.452067-05
10	auth	0006_require_contenttypes_0002	2016-03-03 20:38:26.453758-05
11	auth	0007_alter_validators_add_error_messages	2016-03-03 20:38:26.465398-05
12	campaigns	0001_initial	2016-03-03 20:38:26.494269-05
13	campaigns	0002_campaign_source	2016-03-03 20:38:26.508408-05
14	sessions	0001_initial	2016-03-03 20:38:26.518338-05
15	campaigns	0003_auto_20160305_1815	2016-03-05 13:15:19.650322-05
16	campaigns	0004_auto_20160305_1820	2016-03-05 13:20:32.022571-05
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('django_migrations_id_seq', 16, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: campaigns_campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY campaigns_campaign
    ADD CONSTRAINT campaigns_campaign_pkey PRIMARY KEY (id);


--
-- Name: campaigns_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY campaigns_category
    ADD CONSTRAINT campaigns_category_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: campaigns_campaign_30e482a8; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX campaigns_campaign_30e482a8 ON campaigns_campaign USING btree (deadline);


--
-- Name: campaigns_campaign_72e22a4a; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX campaigns_campaign_72e22a4a ON campaigns_campaign USING btree (raised);


--
-- Name: campaigns_campaign_a3898573; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX campaigns_campaign_a3898573 ON campaigns_campaign USING btree (goal);


--
-- Name: campaigns_campaign_b068931c; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX campaigns_campaign_b068931c ON campaigns_campaign USING btree (name);


--
-- Name: campaigns_campaign_b583a629; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX campaigns_campaign_b583a629 ON campaigns_campaign USING btree (category_id);


--
-- Name: campaigns_campaign_name_fa815cc6_like; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX campaigns_campaign_name_fa815cc6_like ON campaigns_campaign USING btree (name varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: campaigns_campaig_category_id_c38f2a7d_fk_campaigns_category_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaigns_campaign
    ADD CONSTRAINT campaigns_campaig_category_id_c38f2a7d_fk_campaigns_category_id FOREIGN KEY (category_id) REFERENCES campaigns_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

