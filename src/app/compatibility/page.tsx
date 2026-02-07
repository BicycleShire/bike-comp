import type { Metadata } from "next";
import { CategoryPicker } from "@/components/compatibility/CategoryPicker";
import { StandardPicker } from "@/components/compatibility/StandardPicker";
import { ResultsList } from "@/components/compatibility/ResultsList";
import { getCategoryBySlug } from "@/lib/constants";
import {
  getStandardsByCategory,
  getStandardById,
  getRulesForStandard,
} from "@/lib/compatibility";

interface Props {
  searchParams: Promise<{
    category?: string;
    standard?: string;
    rule?: string;
  }>;
}

export async function generateMetadata({ searchParams }: Props): Promise<Metadata> {
  const params = await searchParams;
  const cat = params.category ? getCategoryBySlug(params.category) : undefined;

  if (params.standard) {
    const std = await getStandardById(params.standard);
    if (std) {
      return {
        title: `${std.name} Compatibility — Bike Part Compatibility Database`,
        description: `Check what's compatible with ${std.name}. ${std.description}`,
      };
    }
  }

  if (cat) {
    return {
      title: `${cat.label} — Bike Part Compatibility Database`,
      description: `Browse ${cat.label.toLowerCase()} standards. ${cat.description}`,
    };
  }

  return {
    title: "Compatibility Checker — Bike Part Compatibility Database",
    description:
      "Select a category and standard to see what bicycle parts are compatible, with caveats and source citations.",
  };
}

export default async function CompatibilityPage({ searchParams }: Props) {
  const params = await searchParams;
  const { category, standard: standardId, rule: ruleId } = params;

  const cat = category ? getCategoryBySlug(category) : undefined;
  const standards = cat ? await getStandardsByCategory(cat.slug) : [];
  const selectedStandard = standardId
    ? await getStandardById(standardId)
    : null;
  const rules =
    selectedStandard ? await getRulesForStandard(selectedStandard.id) : [];

  return (
    <div className="space-y-8">
      {/* Header */}
      <div>
        <h2 className="text-2xl font-semibold tracking-tight">
          Compatibility Checker
        </h2>
        <p className="text-[var(--color-muted)] mt-2 font-[family-name:var(--font-serif)]">
          Select a category and standard to see what&apos;s compatible.
        </p>
      </div>

      {/* Step 1: Category picker */}
      <section>
        <h3 className="text-xs font-semibold uppercase tracking-wide text-[var(--color-muted)] mb-3">
          {cat ? "Category" : "Choose a category"}
        </h3>
        <CategoryPicker selected={category} />
      </section>

      {/* Step 2: Standard picker (shown when category is selected) */}
      {cat && (
        <section>
          <h3 className="text-xs font-semibold uppercase tracking-wide text-[var(--color-muted)] mb-3">
            {selectedStandard
              ? `Standard in ${cat.label}`
              : `Choose a standard in ${cat.label}`}
          </h3>
          <StandardPicker
            standards={standards}
            category={cat.slug}
            selectedId={standardId}
          />
        </section>
      )}

      {/* Step 3: Results (shown when standard is selected) */}
      {selectedStandard && cat && (
        <section>
          <h3 className="text-xs font-semibold uppercase tracking-wide text-[var(--color-muted)] mb-3">
            Compatibility results for {selectedStandard.name}
          </h3>
          <ResultsList
            rules={rules}
            selectedStandardId={selectedStandard.id}
            category={cat.slug}
            expandedRuleId={ruleId}
          />
        </section>
      )}
    </div>
  );
}
