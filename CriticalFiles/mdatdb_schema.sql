BEGIN TRANSACTION;
CREATE TABLE "sync" (
  "version" char(50) DEFAULT('2.0'),
  "last_synced_ts" integer,
  "synced" integer NOT NULL DEFAULT(0),
  "password" char(128),
  "backup_copy_months" integer(128)
);
CREATE TABLE "session_data" (
  "session_id" text NOT NULL,
  "ts" float,
  "keyevent_type" text,
  "keyevent_topography" text,
  "observation_type_id" integer,
  "discard" integer DEFAULT(0),
  "note" text,
  "synced" integer DEFAULT(0)
);
CREATE TABLE "session_analysis" (
	`session_analysis_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`session_analysis_date`	TEXT,
	`keyevent_type`	TEXT,
	`keyevent_typography`	TEXT,
	`session_id`	TEXT NOT NULL,
	`measure`	REAL,
	`R_min`	REAL,
	`AdjR_min`	REAL,
	`percent_Int`	REAL,
	`percent_session`	REAL,
	`1x1`	REAL,
	`OCC`	REAL,
	`NON`	REAL,
	`TOTAL`	REAL,
	`TOTAL_Duration`	REAL,
	`EXACT`	REAL
);
CREATE TABLE "session" (
  "session_id" text PRIMARY KEY NOT NULL,
  "assessment_name" text,
  "analysis_name" text,
  "condition_name" text,
  "type_of_session" text,
  "admission_id" integer,
  "session_number" integer,
  "session_duration" integer,
  "session_datetime" integer,
  "observation_type_id" numeric,
  "therapist_initial" text,
  "observer1_initial" text,
  "observer2_initial" text,
  "beep_min" integer DEFAULT(0),
  "beep_max" integer DEFAULT(0),
  "note" text,
  "synced" integer DEFAULT(0)
);
CREATE TABLE "program" (
	`program_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`program_name`	TEXT NOT NULL
);
CREATE TABLE "patient" (
	`patient_id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`firstname`	TEXT NOT NULL,
	`middlename`	TEXT,
	`lastname`	TEXT NOT NULL,
	`dateofbirth`	TEXT NOT NULL,
	`mrn`	TEXT UNIQUE,
	`dexid`	TEXT,
	`last_updated_ts`	INTEGER
);
CREATE TABLE "keymap_entry" (
	`keymap_entry_id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`session_id`	text NOT NULL,
	`keyevent_type`	text NOT NULL,
	`keyevent_topography`	text NOT NULL,
	`keychar_1`	text NOT NULL,
	`duration`	integer DEFAULT (0),
	`enable_audio_timer`	integer DEFAULT (2),
	`synced`	integer DEFAULT (0),
	`order_number`	integer DEFAULT (0)
);
CREATE TABLE "enable_audio_timer" (
	`enable_audio_timer_id`	INTEGER,
	`enable_audio_timer_option`	TEXT,
	PRIMARY KEY(enable_audio_timer_id)
);
CREATE TABLE "department" (
	`department_id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`department_name`	NUMERIC NOT NULL
);
CREATE TABLE "deleted" (
	`table_str`	TEXT NOT NULL,
	`deleted_id`	INTEGER NOT NULL,
	`deleted_ts`	INTEGER NOT NULL
);
CREATE TABLE "condition" (
	`condition_id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`analysis_id`	INTEGER NOT NULL,
	`condition_name`	TEXT UNIQUE,
	`sort_order`	INTEGER DEFAULT 0
);
CREATE TABLE "component_2" (
	`component_2_id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`component_1_id`	INTEGER NOT NULL,
	`component_2_name`	TEXT NOT NULL UNIQUE,
	`sort_order`	INTEGER DEFAULT 0
);
CREATE TABLE "component_1" (
	`component_1_id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`component_id`	INTEGER NOT NULL,
	`component_1_name`	TEXT NOT NULL UNIQUE,
	`sort_order`	INTEGER DEFAULT 0
);
CREATE TABLE "component" (
	`component_id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`analysis_id`	INTEGER NOT NULL,
	`component_name`	TEXT NOT NULL UNIQUE,
	`sort_order`	INTEGER DEFAULT 0
);
CREATE TABLE "assessment" (
	`admission_id`	integer NOT NULL,
	`name`	text NOT NULL,
	`last_updated_ts`	INTEGER
);
CREATE TABLE "analysis" (
	`analysis_id`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
	`analysis_name`	TEXT NOT NULL UNIQUE,
	`sort_order`	INTEGER DEFAULT 0
);
CREATE TABLE "admission" (
  "admission_id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
  "patient_id" integer NOT NULL,
  "admission_date" text NOT NULL,
  "program_id" integer NOT NULL,
  "department_id" integer NOT NULL,
  "last_updated_ts" integer
);
CREATE TABLE "active_sessions" (
  "machine_id" text PRIMARY KEY NOT NULL,
  "last_logged_ts" integer,
  "observation_type_id" integer,
  "session_number" integer,
  "admission_id" integer,
  "assessment_name" text
);
CREATE INDEX admissions ON "admission" ("admission_id" ASC);
CREATE VIEW analysis_session as select distinct (s.session_id), s.assessment_name, s.analysis_name, s.condition_name, s.type_of_session, s.admission_id, s.session_number, s.session_duration, s.session_datetime, s.observation_type_id, s.therapist_initial, s.observer1_initial, s.observer2_initial, s.note, sd.discard
from session s  left outer join session_data sd on
  s.session_id = sd.session_id where s.session_datetime is not NULL and s.session_datetime >  0 
  and s.observation_type_id < 2 and sd.discard = 0;
COMMIT;
