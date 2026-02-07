import { createServerClient } from "@/lib/supabase/server";
import type { Standard } from "@/lib/supabase/types";

export async function getAllStandards(
  category?: string,
  query?: string
): Promise<Standard[]> {
  const supabase = createServerClient();
  let q = supabase.from("standards").select("*");

  if (category) {
    q = q.eq("category", category);
  }

  if (query) {
    q = q.or(`name.ilike.%${query}%,description.ilike.%${query}%`);
  }

  q = q.order("category").order("name");

  const { data, error } = await q;
  if (error) throw error;
  return data;
}
