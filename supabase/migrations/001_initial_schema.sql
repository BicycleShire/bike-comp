-- 001_initial_schema.sql
-- Bike Part Compatibility Database — Phase 1 tables
-- Run this in the Supabase SQL Editor to create all tables.

-- ============================================================
-- standards — interface specifications (the heart of the system)
-- ============================================================
CREATE TABLE IF NOT EXISTS standards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  measurements JSONB,
  aliases TEXT[],
  era_start TEXT,
  era_end TEXT,
  region TEXT,
  source_url TEXT,
  source_notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_standards_category ON standards(category);
CREATE INDEX idx_standards_region ON standards(region);

-- ============================================================
-- compatibility_rules — edges in the compatibility graph
-- ============================================================
CREATE TABLE IF NOT EXISTS compatibility_rules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  standard_a_id UUID NOT NULL REFERENCES standards(id) ON DELETE CASCADE,
  standard_b_id UUID NOT NULL REFERENCES standards(id) ON DELETE CASCADE,
  compatibility_type TEXT NOT NULL CHECK (compatibility_type IN ('direct_fit', 'with_adapter', 'partial', 'incompatible')),
  adapter_needed TEXT,
  confidence TEXT NOT NULL DEFAULT 'widely_reported' CHECK (confidence IN ('confirmed', 'widely_reported', 'anecdotal')),
  caveats TEXT,
  source_url TEXT,
  source_notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_compat_standard_a ON compatibility_rules(standard_a_id);
CREATE INDEX idx_compat_standard_b ON compatibility_rules(standard_b_id);
CREATE INDEX idx_compat_type ON compatibility_rules(compatibility_type);

-- ============================================================
-- components — real-world parts implementing standards
-- ============================================================
CREATE TABLE IF NOT EXISTS components (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  manufacturer TEXT NOT NULL,
  model TEXT,
  year_start TEXT,
  year_end TEXT,
  category TEXT NOT NULL,
  standard_interfaces JSONB,
  specifications JSONB,
  notes TEXT,
  source_url TEXT,
  image_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_components_category ON components(category);
CREATE INDEX idx_components_manufacturer ON components(manufacturer);

-- ============================================================
-- groupsets — collections of components designed together
-- ============================================================
CREATE TABLE IF NOT EXISTS groupsets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  manufacturer TEXT NOT NULL,
  year_start TEXT,
  year_end TEXT,
  tier TEXT,
  region TEXT,
  component_ids UUID[],
  notes TEXT,
  source_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_groupsets_manufacturer ON groupsets(manufacturer);

-- ============================================================
-- measurement_conversions — unit converter data
-- ============================================================
CREATE TABLE IF NOT EXISTS measurement_conversions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  category TEXT NOT NULL,
  value_a TEXT NOT NULL,
  value_b TEXT NOT NULL,
  system_a TEXT NOT NULL,
  system_b TEXT NOT NULL,
  notes TEXT,
  source_url TEXT
);

CREATE INDEX idx_conversions_category ON measurement_conversions(category);

-- ============================================================
-- Trigger: auto-update updated_at on row changes
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER standards_updated_at
  BEFORE UPDATE ON standards
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER compatibility_rules_updated_at
  BEFORE UPDATE ON compatibility_rules
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER components_updated_at
  BEFORE UPDATE ON components
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER groupsets_updated_at
  BEFORE UPDATE ON groupsets
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
