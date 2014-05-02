
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

ALTER TABLE package_group
	DROP CONSTRAINT package_group_package_id_fkey;

ALTER TABLE package_group
	DROP CONSTRAINT package_group_revision_fkey;

ALTER TABLE package_group_revision
	DROP CONSTRAINT package_group_revision_continuity_id_fkey;

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


ALTER TABLE authorization_group_role
	DROP COLUMN id;

ALTER TABLE changeset
	DROP COLUMN status;

ALTER TABLE group_extra_revision
	ALTER COLUMN revision_id SET NOT NULL;

ALTER TABLE group_revision
	ALTER COLUMN revision_id SET NOT NULL;

ALTER TABLE harvesting_job
	ALTER COLUMN status SET NOT NULL;

ALTER TABLE migrate_version
	ALTER COLUMN repository_id TYPE character varying(250) /* TYPE change - table: migrate_version original: character varying(255) new: character varying(250) */;

ALTER TABLE package
	ALTER COLUMN id DROP DEFAULT,
	ALTER COLUMN name SET NOT NULL,
	ALTER COLUMN license_id TYPE text /* TYPE change - table: package original: character varying(100) new: text */;

ALTER TABLE package_extra
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE package_extra_revision
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE package_group_revision
	ALTER COLUMN revision_id SET NOT NULL;

ALTER TABLE package_revision
	DROP COLUMN download_url,
	ALTER COLUMN id DROP DEFAULT,
	ALTER COLUMN name SET NOT NULL,
	ALTER COLUMN license_id TYPE text /* TYPE change - table: package_revision original: character varying(100) new: text */;

ALTER TABLE package_tag
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE package_tag_revision
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE rating
	ALTER COLUMN rating TYPE double precision /* TYPE change - table: rating original: real new: double precision */;

ALTER TABLE resource
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE resource_revision
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE revision
	ALTER COLUMN id DROP DEFAULT;

ALTER TABLE tag
	ALTER COLUMN id DROP DEFAULT,
	ALTER COLUMN name SET NOT NULL;

update package_group_revision set continuity_id = id;

delete from package_group_revision where continuity_id = '36e4722b-1a72-4627-ba8d-1368cf9245cd';

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

ALTER TABLE harvested_document
	ADD CONSTRAINT harvested_document_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE harvested_document
	ADD CONSTRAINT harvested_document_source_id_fkey FOREIGN KEY (source_id) REFERENCES harvest_source(id);

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

ALTER TABLE package_group
	ADD CONSTRAINT package_group_package_id_fkey FOREIGN KEY (package_id) REFERENCES package(id);

ALTER TABLE package_group
	ADD CONSTRAINT package_group_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES revision(id);

ALTER TABLE package_group_revision
	ADD CONSTRAINT package_group_revision_continuity_id_fkey FOREIGN KEY (continuity_id) REFERENCES package_group(id);

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

ALTER TABLE user_object_role
	ADD CONSTRAINT user_object_role_authorized_group_id_fkey FOREIGN KEY (authorized_group_id) REFERENCES authorization_group(id);

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