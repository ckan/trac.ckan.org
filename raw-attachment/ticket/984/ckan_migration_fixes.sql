-- fix group revision tables

ALTER TABLE group_extra_revision
	DROP CONSTRAINT group_extra_revision_pkey;

ALTER TABLE group_revision
	DROP CONSTRAINT group_revision_pkey;

ALTER TABLE package_group_revision
	DROP CONSTRAINT package_group_revision_pkey;

ALTER TABLE group_extra
	DROP CONSTRAINT group_extra_revision_fkey;

ALTER TABLE group_extra_revision
	DROP CONSTRAINT group_extra_revision_continuity_id_fkey;

ALTER TABLE group_revision
	DROP CONSTRAINT group_revision_name_key;

ALTER TABLE package_group
	DROP CONSTRAINT package_group_package_id_fkey;

ALTER TABLE package_group
	DROP CONSTRAINT package_group_revision_fkey;

ALTER TABLE package_group_revision
	DROP CONSTRAINT package_group_revision_continuity_id_fkey;


ALTER TABLE group_extra_revision
	ADD CONSTRAINT group_extra_revision_pkey PRIMARY KEY (id, revision_id);

ALTER TABLE group_revision
	ADD CONSTRAINT group_revision_pkey PRIMARY KEY (id, revision_id);

ALTER TABLE package_group_revision
	ADD CONSTRAINT package_group_revision_pkey PRIMARY KEY (id, revision_id);

ALTER TABLE group_extra
	ADD CONSTRAINT group_extra_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);

ALTER TABLE group_extra_revision
	ADD CONSTRAINT group_extra_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES group_extra(id);

ALTER TABLE group_revision
	ADD CONSTRAINT group_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES "group"(id);


ALTER TABLE package_group
	ADD CONSTRAINT package_group_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_group
	ADD CONSTRAINT package_group_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);

ALTER TABLE package_group_revision
	ADD CONSTRAINT package_group_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package_group(id);


-- add changemask table

CREATE TABLE changemask (
	ref text NOT NULL,
	timestamp timestamp without time zone
);

ALTER TABLE changemask
	ADD CONSTRAINT changemask_pkey PRIMARY KEY (ref);

-- fix defaults
ALTER TABLE package
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE package_extra
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE package_extra_revision
	ALTER COLUMN id DROP DEFAULT;


ALTER TABLE package_resource
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE package_resource_revision
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE package_revision
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE package_tag
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE package_tag_revision
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE revision
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE tag
	ALTER COLUMN id DROP DEFAULT;

DROP SEQUENCE package_extra_id_seq;

DROP SEQUENCE package_extra_revision_id_seq;

DROP SEQUENCE package_id_seq;

DROP SEQUENCE package_resource_id_seq;

DROP SEQUENCE package_resource_revision_id_seq;

DROP SEQUENCE package_revision_id_seq;

DROP SEQUENCE package_tag_id_seq;

DROP SEQUENCE package_tag_revision_id_seq;

DROP SEQUENCE revision_id_seq;

DROP SEQUENCE tag_id_seq;


-- fix licence id

ALTER TABLE package
	ALTER COLUMN license_id TYPE text /* TYPE change - table: package original: character varying(100) new: text */;

ALTER TABLE package_revision
	ALTER COLUMN license_id TYPE text /* TYPE change - table: package_revision original: character varying(100) new: text */;


-- drop download_url

ALTER TABLE package_revision
	DROP COLUMN download_url;

-- fix changeset

ALTER TABLE changeset
	DROP COLUMN status;

-- fix not null

ALTER TABLE package_group_revision
	ALTER COLUMN revision_id SET NOT NULL;

ALTER TABLE group_extra_revision
	ALTER COLUMN revision_id SET NOT NULL;

ALTER TABLE group_revision
	ALTER COLUMN revision_id SET NOT NULL;

ALTER TABLE harvesting_job
	ALTER COLUMN status SET NOT NULL;

-- add unique contraints

ALTER TABLE tag
	ADD CONSTRAINT tag_name_key UNIQUE (name);

ALTER TABLE package
	ADD CONSTRAINT package_name_key UNIQUE (name);


-- fix on update cascades

ALTER TABLE package
	DROP CONSTRAINT package_revision_id_fkey;

ALTER TABLE package_extra
	DROP CONSTRAINT package_extra_package_id_fkey;

ALTER TABLE package_extra
	DROP CONSTRAINT package_extra_revision_id_fkey;

ALTER TABLE package_extra_revision
	DROP CONSTRAINT package_extra_revision_continuity_id_fkey;

ALTER TABLE package_extra_revision
	DROP CONSTRAINT package_extra_revision_package_id_fkey;

ALTER TABLE package_extra_revision
	DROP CONSTRAINT package_extra_revision_revision_id_fkey;

ALTER TABLE package_resource
	DROP CONSTRAINT package_resource_package_id_fkey;

ALTER TABLE package_resource_revision
	DROP CONSTRAINT package_resource_revision_continuity_id_fkey;

ALTER TABLE package_resource_revision
	DROP CONSTRAINT package_resource_revision_package_id_fkey;

ALTER TABLE package_revision
	DROP CONSTRAINT package_revision_continuity_id_fkey;

ALTER TABLE package_revision
	DROP CONSTRAINT package_revision_revision_id_fkey;

ALTER TABLE package_role
	DROP CONSTRAINT package_role_package_id_fkey;

ALTER TABLE package_search
	DROP CONSTRAINT package_search_package_id_fkey;

ALTER TABLE package_tag
	DROP CONSTRAINT package_tag_package_id_fkey;

ALTER TABLE package_tag
	DROP CONSTRAINT package_tag_revision_id_fkey;

ALTER TABLE package_tag
	DROP CONSTRAINT package_tag_tag_id_fkey;

ALTER TABLE package_tag_revision
	DROP CONSTRAINT package_tag_revision_continuity_id_fkey;

ALTER TABLE package_tag_revision
	DROP CONSTRAINT package_tag_revision_package_id_fkey;

ALTER TABLE package_tag_revision
	DROP CONSTRAINT package_tag_revision_revision_id_fkey;

ALTER TABLE package_tag_revision
	DROP CONSTRAINT package_tag_revision_tag_id_fkey;

ALTER TABLE rating
	DROP CONSTRAINT rating_package_id_fkey;


ALTER TABLE package
	ADD CONSTRAINT package_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);

ALTER TABLE package_extra
	ADD CONSTRAINT package_extra_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_extra
	ADD CONSTRAINT package_extra_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);

ALTER TABLE package_extra_revision
	ADD CONSTRAINT package_extra_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package_extra(id);

ALTER TABLE package_extra_revision
	ADD CONSTRAINT package_extra_revision_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_extra_revision
	ADD CONSTRAINT package_extra_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);


ALTER TABLE package_resource
	ADD CONSTRAINT package_resource_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_resource_revision
	ADD CONSTRAINT package_resource_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package_resource(id);

ALTER TABLE package_resource_revision
	ADD CONSTRAINT package_resource_revision_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_revision
	ADD CONSTRAINT package_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package(id);

ALTER TABLE package_revision
	ADD CONSTRAINT package_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);

ALTER TABLE package_role
	ADD CONSTRAINT package_role_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_search
	ADD CONSTRAINT package_search_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_tag
	ADD CONSTRAINT package_tag_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_tag
	ADD CONSTRAINT package_tag_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);

ALTER TABLE package_tag
	ADD CONSTRAINT package_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tag(id);

ALTER TABLE package_tag_revision
	ADD CONSTRAINT package_tag_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package_tag(id);

ALTER TABLE package_tag_revision
	ADD CONSTRAINT package_tag_revision_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_tag_revision
	ADD CONSTRAINT package_tag_revision_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);

ALTER TABLE package_tag_revision
	ADD CONSTRAINT package_tag_revision_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tag(id);

ALTER TABLE rating
	ADD CONSTRAINT rating_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

