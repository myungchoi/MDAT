USE MDAT;

BEGIN TRANSACTION;
CREATE TABLE "sync" (
  "version" char(50) DEFAULT('2.0'),
  "last_synced_ts" integer,
  "synced" integer NOT NULL DEFAULT(0),
  "password" char(128),
  "backup_copy_months" integer
);
CREATE TABLE "session_data" (
  "session_id" varchar(150) NOT NULL,
  "ts" float,
  "keyevent_type" varchar(70),
  "keyevent_topography" varchar(70),
  "observation_type_id" integer,
  "discard" integer DEFAULT(0),
  "note" varchar(300),
  "synced" integer DEFAULT(0)
);
CREATE TABLE "session_analysis" (
	"session_analysis_id"	INTEGER PRIMARY KEY IDENTITY(1,1),
	"session_analysis_date"	varchar(15),
	"keyevent_type"	varchar(70),
	"keyevent_typography"	varchar(70),
	"session_id"	varchar(150) NOT NULL,
	"measure"	REAL,
	"R_min"	REAL,
	"AdjR_min"	REAL,
	"percent_Int"	REAL,
	"percent_session"	REAL,
	"1x1"	REAL,
	"OCC"	REAL,
	"NON"	REAL,
	"TOTAL"	REAL,
	"TOTAL_Duration"	REAL,
	"EXACT"	REAL
);
CREATE TABLE "session" (
  "session_id" varchar(150) PRIMARY KEY NOT NULL,
  "assessment_name" varchar(70),
  "analysis_name" varchar(70),
  "condition_name" varchar(70),
  "type_of_session" varchar(70),
  "admission_id" integer,
  "session_number" integer,
  "session_duration" integer,
  "session_datetime" integer,
  "observation_type_id" numeric,
  "therapist_initial" varchar(7),
  "observer1_initial" varchar(7),
  "observer2_initial" varchar(7),
  "beep_min" integer DEFAULT(0),
  "beep_max" integer DEFAULT(0),
  "note" varchar(300),
  "synced" integer DEFAULT(0)
);
CREATE TABLE "program" (
	"program_id"	INTEGER PRIMARY KEY IDENTITY(1,1),
	"program_name"	varchar(70) NOT NULL
);
CREATE TABLE "patient" (
	"patient_id"	INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	"firstname"	varchar(70) NOT NULL,
	"middlename"	varchar(70),
	"lastname"	varchar(70) NOT NULL,
	"dateofbirth"	varchar(15) NOT NULL,
	"mrn"	varchar(70),
	"dexid"	varchar(70),
	"last_updated_ts"	INTEGER
);
CREATE TABLE "keymap_entry" (
	"keymap_entry_id"	INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	"session_id"	varchar(150) NOT NULL,
	"keyevent_type"	varchar(70) NOT NULL,
	"keyevent_topography"	varchar(70) NOT NULL,
	"keychar_1"	varchar(1) NOT NULL,
	"duration"	integer DEFAULT (0),
	"enable_audio_timer"	integer DEFAULT (2),
	"synced"	integer DEFAULT (0),
	"order_number"	integer DEFAULT (0)
);
CREATE TABLE "enable_audio_timer" (
	"enable_audio_timer_id"	INTEGER,
	"enable_audio_timer_option"	varchar(10),
	PRIMARY KEY(enable_audio_timer_id)
);
CREATE TABLE "department" (
	"department_id"	INTEGER PRIMARY KEY IDENTITY(1,1),
	"department_name"	varchar(70) NOT NULL
);
CREATE TABLE "deleted" (
	"table_str"	varchar(70) NOT NULL,
	"deleted_id"	INTEGER NOT NULL,
	"deleted_ts"	INTEGER NOT NULL
);
CREATE TABLE "condition" (
	"condition_id"	INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	"analysis_id"	INTEGER NOT NULL,
	"condition_name"	varchar(70),
	"sort_order"	INTEGER DEFAULT 0
);
CREATE TABLE "component_2" (
	"component_2_id"	INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	"component_1_id"	INTEGER NOT NULL,
	"component_2_name"	varchar(70) NOT NULL,
	"sort_order"	INTEGER DEFAULT 0
);
CREATE TABLE "component_1" (
	"component_1_id"	INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	"component_id"	INTEGER NOT NULL,
	"component_1_name"	varchar(70) NOT NULL,
	"sort_order"	INTEGER DEFAULT 0
);
CREATE TABLE "component" (
	"component_id"	INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	"analysis_id"	INTEGER NOT NULL,
	"component_name"	varchar(70) NOT NULL,
	"sort_order"	INTEGER DEFAULT 0
);
CREATE TABLE "assessment" (
	"admission_id"	integer NOT NULL,
	"name"	varchar(70) NOT NULL,
	"last_updated_ts"	INTEGER
);
CREATE TABLE "analysis" (
	"analysis_id"	INTEGER PRIMARY KEY IDENTITY(1,1),
	"analysis_name"	varchar(70) NOT NULL,
	"sort_order"	INTEGER DEFAULT 0
);
CREATE TABLE "admission" (
  "admission_id" integer PRIMARY KEY IDENTITY(1,1),
  "patient_id" integer NOT NULL,
  "admission_date" varchar(15) NOT NULL,
  "program_id" integer NOT NULL,
  "department_id" integer NOT NULL,
  "last_updated_ts" integer
);
CREATE TABLE "active_sessions" (
  "machine_id" text NOT NULL,
  "last_logged_ts" integer,
  "observation_type_id" integer,
  "session_number" integer,
  "admission_id" integer,
  "assessment_name" varchar(70)
);
CREATE INDEX admissions ON "admission" ("admission_id" ASC);
COMMIT;
