SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: body_part_translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.body_part_translations (
    id uuid DEFAULT uuidv7() NOT NULL,
    body_part_id uuid NOT NULL,
    locale character varying NOT NULL,
    name text NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: body_parts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.body_parts (
    id uuid DEFAULT uuidv7() NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    key text NOT NULL,
    "position" integer DEFAULT 100 NOT NULL
);


--
-- Name: equipment_type_translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equipment_type_translations (
    id uuid DEFAULT uuidv7() NOT NULL,
    equipment_type_id uuid NOT NULL,
    locale character varying NOT NULL,
    name text NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: equipment_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equipment_types (
    id uuid DEFAULT uuidv7() NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    key text NOT NULL,
    "position" integer DEFAULT 100 NOT NULL
);


--
-- Name: exercise_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_tags (
    id uuid DEFAULT uuidv7() NOT NULL,
    exercise_id uuid NOT NULL,
    tag_id uuid NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: exercise_translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercise_translations (
    id uuid DEFAULT uuidv7() NOT NULL,
    exercise_id uuid NOT NULL,
    locale character varying NOT NULL,
    name text NOT NULL,
    description text,
    synonyms text[] DEFAULT '{}'::text[] NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: exercises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exercises (
    id uuid DEFAULT uuidv7() NOT NULL,
    body_part_id uuid NOT NULL,
    muscle_group_id uuid NOT NULL,
    equipment_type_id uuid NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    key text NOT NULL
);


--
-- Name: muscle_group_translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.muscle_group_translations (
    id uuid DEFAULT uuidv7() NOT NULL,
    muscle_group_id uuid NOT NULL,
    locale character varying NOT NULL,
    name text NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: muscle_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.muscle_groups (
    id uuid DEFAULT uuidv7() NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    key text NOT NULL,
    "position" integer DEFAULT 100 NOT NULL
);


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    id uuid DEFAULT uuidv7() NOT NULL,
    user_id uuid NOT NULL,
    token_digest character varying NOT NULL,
    expires_at timestamp(6) without time zone NOT NULL,
    used_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tag_translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tag_translations (
    id uuid DEFAULT uuidv7() NOT NULL,
    tag_id uuid NOT NULL,
    locale character varying NOT NULL,
    name text NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id uuid DEFAULT uuidv7() NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    key text NOT NULL,
    "position" integer DEFAULT 100 NOT NULL
);


--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_sessions (
    id uuid DEFAULT uuidv7() NOT NULL,
    user_id uuid NOT NULL,
    ip_address text,
    user_agent text,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT uuidv7() NOT NULL,
    email text NOT NULL,
    password_digest text NOT NULL,
    role character varying DEFAULT 'member'::character varying NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    preferred_locale character varying DEFAULT 'en'::character varying NOT NULL
);


--
-- Name: workout_template_exercises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workout_template_exercises (
    id uuid DEFAULT uuidv7() NOT NULL,
    workout_template_id uuid NOT NULL,
    exercise_id uuid NOT NULL,
    "position" integer NOT NULL,
    planned_sets_count integer,
    target_reps_min integer,
    target_reps_max integer,
    rest_seconds integer,
    notes text,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: workout_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workout_templates (
    id uuid DEFAULT uuidv7() NOT NULL,
    user_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    notes text,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: body_part_translations body_part_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.body_part_translations
    ADD CONSTRAINT body_part_translations_pkey PRIMARY KEY (id);


--
-- Name: body_parts body_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.body_parts
    ADD CONSTRAINT body_parts_pkey PRIMARY KEY (id);


--
-- Name: equipment_type_translations equipment_type_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment_type_translations
    ADD CONSTRAINT equipment_type_translations_pkey PRIMARY KEY (id);


--
-- Name: equipment_types equipment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment_types
    ADD CONSTRAINT equipment_types_pkey PRIMARY KEY (id);


--
-- Name: exercise_tags exercise_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_tags
    ADD CONSTRAINT exercise_tags_pkey PRIMARY KEY (id);


--
-- Name: exercise_translations exercise_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_translations
    ADD CONSTRAINT exercise_translations_pkey PRIMARY KEY (id);


--
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- Name: muscle_group_translations muscle_group_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscle_group_translations
    ADD CONSTRAINT muscle_group_translations_pkey PRIMARY KEY (id);


--
-- Name: muscle_groups muscle_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscle_groups
    ADD CONSTRAINT muscle_groups_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tag_translations tag_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag_translations
    ADD CONSTRAINT tag_translations_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: workout_template_exercises workout_template_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workout_template_exercises
    ADD CONSTRAINT workout_template_exercises_pkey PRIMARY KEY (id);


--
-- Name: workout_templates workout_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workout_templates
    ADD CONSTRAINT workout_templates_pkey PRIMARY KEY (id);


--
-- Name: idx_eq_type_tr_on_eq_type_id_locale; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_eq_type_tr_on_eq_type_id_locale ON public.equipment_type_translations USING btree (equipment_type_id, locale);


--
-- Name: idx_wt_ex_on_exercise_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wt_ex_on_exercise_id ON public.workout_template_exercises USING btree (exercise_id);


--
-- Name: idx_wt_ex_on_template_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wt_ex_on_template_id ON public.workout_template_exercises USING btree (workout_template_id);


--
-- Name: idx_wt_ex_on_template_id_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_wt_ex_on_template_id_position ON public.workout_template_exercises USING btree (workout_template_id, "position");


--
-- Name: index_body_part_translations_on_body_part_id_and_locale; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_body_part_translations_on_body_part_id_and_locale ON public.body_part_translations USING btree (body_part_id, locale);


--
-- Name: index_body_part_translations_on_locale_and_lower_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_body_part_translations_on_locale_and_lower_name ON public.body_part_translations USING btree (locale, lower(name));


--
-- Name: index_body_parts_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_body_parts_on_key ON public.body_parts USING btree (key);


--
-- Name: index_body_parts_on_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_body_parts_on_position ON public.body_parts USING btree ("position");


--
-- Name: index_equipment_type_translations_on_locale_and_lower_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_equipment_type_translations_on_locale_and_lower_name ON public.equipment_type_translations USING btree (locale, lower(name));


--
-- Name: index_equipment_types_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_equipment_types_on_key ON public.equipment_types USING btree (key);


--
-- Name: index_equipment_types_on_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_equipment_types_on_position ON public.equipment_types USING btree ("position");


--
-- Name: index_exercise_tags_on_exercise_id_and_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_exercise_tags_on_exercise_id_and_tag_id ON public.exercise_tags USING btree (exercise_id, tag_id);


--
-- Name: index_exercise_tags_on_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_tags_on_tag_id ON public.exercise_tags USING btree (tag_id);


--
-- Name: index_exercise_translations_on_exercise_id_and_locale; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_exercise_translations_on_exercise_id_and_locale ON public.exercise_translations USING btree (exercise_id, locale);


--
-- Name: index_exercise_translations_on_locale_and_lower_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_translations_on_locale_and_lower_name ON public.exercise_translations USING btree (locale, lower(name));


--
-- Name: index_exercise_translations_on_synonyms; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercise_translations_on_synonyms ON public.exercise_translations USING gin (synonyms);


--
-- Name: index_exercises_on_body_part_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercises_on_body_part_id ON public.exercises USING btree (body_part_id);


--
-- Name: index_exercises_on_equipment_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercises_on_equipment_type_id ON public.exercises USING btree (equipment_type_id);


--
-- Name: index_exercises_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_exercises_on_key ON public.exercises USING btree (key);


--
-- Name: index_exercises_on_muscle_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exercises_on_muscle_group_id ON public.exercises USING btree (muscle_group_id);


--
-- Name: index_muscle_group_translations_on_locale_and_lower_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_muscle_group_translations_on_locale_and_lower_name ON public.muscle_group_translations USING btree (locale, lower(name));


--
-- Name: index_muscle_group_translations_on_muscle_group_id_and_locale; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_muscle_group_translations_on_muscle_group_id_and_locale ON public.muscle_group_translations USING btree (muscle_group_id, locale);


--
-- Name: index_muscle_groups_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_muscle_groups_on_key ON public.muscle_groups USING btree (key);


--
-- Name: index_muscle_groups_on_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_muscle_groups_on_position ON public.muscle_groups USING btree ("position");


--
-- Name: index_password_reset_tokens_on_token_digest; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_password_reset_tokens_on_token_digest ON public.password_reset_tokens USING btree (token_digest);


--
-- Name: index_password_reset_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_password_reset_tokens_on_user_id ON public.password_reset_tokens USING btree (user_id);


--
-- Name: index_tag_translations_on_locale_and_lower_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tag_translations_on_locale_and_lower_name ON public.tag_translations USING btree (locale, lower(name));


--
-- Name: index_tag_translations_on_tag_id_and_locale; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tag_translations_on_tag_id_and_locale ON public.tag_translations USING btree (tag_id, locale);


--
-- Name: index_tags_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_key ON public.tags USING btree (key);


--
-- Name: index_tags_on_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tags_on_position ON public.tags USING btree ("position");


--
-- Name: index_user_sessions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_sessions_on_user_id ON public.user_sessions USING btree (user_id);


--
-- Name: index_users_on_lower_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_lower_email ON public.users USING btree (lower(email));


--
-- Name: index_workout_templates_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_workout_templates_on_user_id ON public.workout_templates USING btree (user_id);


--
-- Name: body_part_translations fk_body_part_translations_body_parts; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.body_part_translations
    ADD CONSTRAINT fk_body_part_translations_body_parts FOREIGN KEY (body_part_id) REFERENCES public.body_parts(id) ON DELETE CASCADE;


--
-- Name: equipment_type_translations fk_equipment_type_translations_equipment_types; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equipment_type_translations
    ADD CONSTRAINT fk_equipment_type_translations_equipment_types FOREIGN KEY (equipment_type_id) REFERENCES public.equipment_types(id) ON DELETE CASCADE;


--
-- Name: exercise_tags fk_exercise_tags_exercises; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_tags
    ADD CONSTRAINT fk_exercise_tags_exercises FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) ON DELETE CASCADE;


--
-- Name: exercise_tags fk_exercise_tags_tags; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_tags
    ADD CONSTRAINT fk_exercise_tags_tags FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: exercise_translations fk_exercise_translations_exercises; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercise_translations
    ADD CONSTRAINT fk_exercise_translations_exercises FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) ON DELETE CASCADE;


--
-- Name: exercises fk_exercises_body_parts; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT fk_exercises_body_parts FOREIGN KEY (body_part_id) REFERENCES public.body_parts(id) ON DELETE RESTRICT;


--
-- Name: exercises fk_exercises_equipment_types; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT fk_exercises_equipment_types FOREIGN KEY (equipment_type_id) REFERENCES public.equipment_types(id) ON DELETE RESTRICT;


--
-- Name: exercises fk_exercises_muscle_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT fk_exercises_muscle_groups FOREIGN KEY (muscle_group_id) REFERENCES public.muscle_groups(id) ON DELETE RESTRICT;


--
-- Name: muscle_group_translations fk_muscle_group_translations_muscle_groups; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.muscle_group_translations
    ADD CONSTRAINT fk_muscle_group_translations_muscle_groups FOREIGN KEY (muscle_group_id) REFERENCES public.muscle_groups(id) ON DELETE CASCADE;


--
-- Name: password_reset_tokens fk_password_reset_tokens_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT fk_password_reset_tokens_users FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: tag_translations fk_tag_translations_tags; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag_translations
    ADD CONSTRAINT fk_tag_translations_tags FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: user_sessions fk_user_sessions_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT fk_user_sessions_users FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: workout_templates fk_workout_templates_users; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workout_templates
    ADD CONSTRAINT fk_workout_templates_users FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: workout_template_exercises fk_wt_ex_exercises; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workout_template_exercises
    ADD CONSTRAINT fk_wt_ex_exercises FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) ON DELETE RESTRICT;


--
-- Name: workout_template_exercises fk_wt_ex_templates; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workout_template_exercises
    ADD CONSTRAINT fk_wt_ex_templates FOREIGN KEY (workout_template_id) REFERENCES public.workout_templates(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20260311150100'),
('20260311150000'),
('20260311130200'),
('20260311130100'),
('20260311130000'),
('20260311120000'),
('20260311112200'),
('20260311112100'),
('20260311112000'),
('20260311111900'),
('20260311111800'),
('20260311111700'),
('20260311111600'),
('20260311111500'),
('20260311111400'),
('20260311111300'),
('20260311111200'),
('20260311111100'),
('20260311111000'),
('20260306150000'),
('20260306140000');

