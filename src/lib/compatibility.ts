import { createServerClient } from "@/lib/supabase/server";
import type { Standard, CompatibilityRule } from "@/lib/supabase/types";

export type RuleWithStandards = CompatibilityRule & {
  standard_a: Standard;
  standard_b: Standard;
};

export async function getStandardsByCategory(
  category: string
): Promise<Standard[]> {
  const supabase = createServerClient();
  const { data, error } = await supabase
    .from("standards")
    .select("*")
    .eq("category", category)
    .order("name");

  if (error) throw error;
  return data;
}

export async function getStandardById(
  id: string
): Promise<Standard | null> {
  const supabase = createServerClient();
  const { data, error } = await supabase
    .from("standards")
    .select("*")
    .eq("id", id)
    .single();

  if (error) return null;
  return data;
}

export async function getRulesForStandard(
  standardId: string
): Promise<RuleWithStandards[]> {
  const supabase = createServerClient();
  const { data, error } = await supabase
    .from("compatibility_rules")
    .select(
      "*, standard_a:standards!standard_a_id(*), standard_b:standards!standard_b_id(*)"
    )
    .or(`standard_a_id.eq.${standardId},standard_b_id.eq.${standardId}`);

  if (error) throw error;
  return data as RuleWithStandards[];
}
