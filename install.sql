BEGIN TRANSACTION;
DROP TABLE IF EXISTS "company";
CREATE TABLE IF NOT EXISTS "company" (
	"company_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	PRIMARY KEY("company_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "position_category";
CREATE TABLE IF NOT EXISTS "position_category" (
	"position_category_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	PRIMARY KEY("position_category_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "platform";
CREATE TABLE IF NOT EXISTS "platform" (
	"platform_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	PRIMARY KEY("platform_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "position_status";
CREATE TABLE IF NOT EXISTS "position_status" (
	"position_status_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	PRIMARY KEY("position_status_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "recruiter";
CREATE TABLE IF NOT EXISTS "recruiter" (
	"recruiter_id"	INTEGER NOT NULL UNIQUE,
	"first_name"	TEXT NOT NULL,
	"last_name"	TEXT NOT NULL,
	"email"	TEXT NOT NULL,
	"phone"	TEXT,
	"team"	INTEGER,
	PRIMARY KEY("recruiter_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "application_stage";
CREATE TABLE IF NOT EXISTS "application_stage" (
	"application_stage_id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	"priority"	INTEGER,
	PRIMARY KEY("application_stage_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "candidate_status";
CREATE TABLE IF NOT EXISTS "candidate_status" (
	"candidate_status_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	PRIMARY KEY("candidate_status_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "candidate_source";
CREATE TABLE IF NOT EXISTS "candidate_source" (
	"candidat_source_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	PRIMARY KEY("candidat_source_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "position_stage";
CREATE TABLE IF NOT EXISTS "position_stage" (
	"position_stage_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	PRIMARY KEY("position_stage_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "position";
CREATE TABLE IF NOT EXISTS "position" (
	"position_id"	INTEGER NOT NULL UNIQUE,
	"related_to"	INTEGER,
	"title"	REAL NOT NULL,
	"description"	REAL,
	"published_date"	TEXT NOT NULL,
	"vacancies_num"	INTEGER NOT NULL,
	"start_date"	TEXT,
	"company"	INTEGER,
	"category"	INTEGER,
	"platform"	INTEGER,
	"owner"	INTEGER,
	"status"	INTEGER,
	"stage"	INTEGER,
	"created_by"	INTEGER NOT NULL,
	"created_timestamp"	TEXT NOT NULL,
	"update_timestamp"	TEXT,
	"updated_by"	INTEGER,
	PRIMARY KEY("position_id" AUTOINCREMENT),
	FOREIGN KEY("status") REFERENCES "position_status"("position_status_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY("stage") REFERENCES "position_stage"("position_stage_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY("company") REFERENCES "company"("company_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY("category") REFERENCES "position_category"("position_category_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY("related_to") REFERENCES "position"("position_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY("platform") REFERENCES "platform"("platform_id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
DROP TABLE IF EXISTS "candidate";
CREATE TABLE IF NOT EXISTS "candidate" (
	"candidate_id"	INTEGER NOT NULL UNIQUE,
	"first_name"	TEXT NOT NULL,
	"last_name"	TEXT NOT NULL,
	"email"	TEXT NOT NULL,
	"phone"	TEXT,
	"notes"	TEXT,
	"owner"	INTEGER,
	"status"	INTEGER,
	"source"	INTEGER,
	"created_by"	INTEGER NOT NULL,
	"created_timestamp"	TEXT NOT NULL,
	"update_timestamp"	TEXT,
	"updated_by"	INTEGER,
	PRIMARY KEY("candidate_id" AUTOINCREMENT),
	FOREIGN KEY("status") REFERENCES "candidate_status"("candidate_status_id"),
	FOREIGN KEY("source") REFERENCES "candidate_source"("candidat_source_id") ON DELETE NO ACTION ON UPDATE NO ACTION
);
DROP TABLE IF EXISTS "application_status";
CREATE TABLE IF NOT EXISTS "application_status" (
	"application_status_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	PRIMARY KEY("application_status_id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "application";
CREATE TABLE IF NOT EXISTS "application" (
	"application_id"	INTEGER NOT NULL UNIQUE,
	"position_id"	INTEGER,
	"candidate_id"	INTEGER,
	"stage_id"	INTEGER,
	"stage_date"	TEXT,
	"status_id"	INTEGER,
	"status_date"	TEXT,
	"owner"	INTEGER,
	"created_by"	INTEGER NOT NULL,
	"created_timestamp"	TEXT NOT NULL,
	"updated_by"	INTEGER,
	"update_timestamp"	TEXT,
	PRIMARY KEY("application_id" AUTOINCREMENT),
	FOREIGN KEY("stage_id") REFERENCES "application_stage"("application_stage_id"),
	FOREIGN KEY("candidate_id") REFERENCES "candidate"("candidate_id"),
	FOREIGN KEY("status_id") REFERENCES "application_status"("application_status_id") ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY("owner") REFERENCES "recruiter"("recruiter_id"),
	FOREIGN KEY("position_id") REFERENCES "position"("position_id")
);
DROP TABLE IF EXISTS "application_log";
CREATE TABLE IF NOT EXISTS "application_log" (
	"application_log_id"	INTEGER NOT NULL UNIQUE,
	"application_id"	INTEGER,
	"stage_id"	INTEGER,
	"stage_date"	TEXT,
	"status_id"	INTEGER,
	"status_date"	TEXT,
	"owner"	INTEGER,
	"created_timestamp"	TEXT,
	"created_by"	INTEGER,
	"updated_by"	INTEGER,
	"update_timestamp"	TEXT,
	PRIMARY KEY("application_log_id" AUTOINCREMENT),
	FOREIGN KEY("stage_id") REFERENCES "application_stage"("application_stage_id"),
	FOREIGN KEY("application_id") REFERENCES "application"("application_id"),
	FOREIGN KEY("status_id") REFERENCES "application_status"("application_status_id")
);
COMMIT;
