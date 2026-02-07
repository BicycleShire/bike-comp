-- 002_rls_policies.sql
-- Row Level Security policies for Phase 1 tables.
-- Public read on all reference tables; service-role-only write.

-- Enable RLS on all tables
ALTER TABLE standards ENABLE ROW LEVEL SECURITY;
ALTER TABLE compatibility_rules ENABLE ROW LEVEL SECURITY;
ALTER TABLE components ENABLE ROW LEVEL SECURITY;
ALTER TABLE groupsets ENABLE ROW LEVEL SECURITY;
ALTER TABLE measurement_conversions ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- Public read policies (anyone can read reference data)
-- ============================================================
CREATE POLICY "Public read access on standards"
  ON standards FOR SELECT
  USING (true);

CREATE POLICY "Public read access on compatibility_rules"
  ON compatibility_rules FOR SELECT
  USING (true);

CREATE POLICY "Public read access on components"
  ON components FOR SELECT
  USING (true);

CREATE POLICY "Public read access on groupsets"
  ON groupsets FOR SELECT
  USING (true);

CREATE POLICY "Public read access on measurement_conversions"
  ON measurement_conversions FOR SELECT
  USING (true);

-- ============================================================
-- Write policies (service role only — owner manages data via
-- Supabase Table Editor or service role key)
-- ============================================================
-- No INSERT/UPDATE/DELETE policies for anon/authenticated roles.
-- The service role bypasses RLS entirely, so the owner can
-- manage data through the Supabase dashboard without additional
-- policies.
