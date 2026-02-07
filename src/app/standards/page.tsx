import type { Metadata } from "next";
import Link from "next/link";
import { CATEGORIES, getCategoryBySlug } from "@/lib/constants";
import { getAllStandards } from "@/lib/standards";
import { SearchBar } from "@/components/standards/SearchBar";
import { StandardCard } from "@/components/standards/StandardCard";
import type { Standard } from "@/lib/supabase/types";

interface Props {
  searchParams: Promise<{
    category?: string;
    q?: string;
  }>;
}

export async function generateMetadata({
  searchParams,
}: Props): Promise<Metadata> {
  const params = await searchParams;
  const cat = params.category
    ? getCategoryBySlug(params.category)
    : undefined;

  if (params.q) {
    return {
      title: `Search "${params.q}" — Standards — Bike Part Compatibility Database`,
      description: `Standards matching "${params.q}".`,
    };
  }

  if (cat) {
    return {
      title: `${cat.label} Standards — Bike Part Compatibility Database`,
      description: `Browse ${cat.label.toLowerCase()} standards. ${cat.description}`,
    };
  }

  return {
    title: "Browse Standards — Bike Part Compatibility Database",
    description:
      "All bicycle interface standards organized by category — threading, spindles, headsets, spacing, and more.",
  };
}

function groupByCategory(standards: Standard[]) {
  const groups = new Map<string, Standard[]>();
  for (const std of standards) {
    const list = groups.get(std.category) || [];
    list.push(std);
    groups.set(std.category, list);
  }
  return groups;
}

export default async function StandardsPage({ searchParams }: Props) {
  const params = await searchParams;
  const { category, q } = params;

  const cat = category ? getCategoryBySlug(category) : undefined;
  const standards = await getAllStandards(category, q);

  const showGrouped = !category;
  const grouped = showGrouped ? groupByCategory(standards) : null;

  return (
    <div className="space-y-8">
      {/* Header */}
      <div>
        <h2 className="text-2xl font-semibold tracking-tight">
          Browse Standards
        </h2>
        <p className="text-[var(--color-muted)] mt-2 font-[family-name:var(--font-serif)]">
          {cat
            ? cat.description
            : "Interface standards organized by category."}
        </p>
      </div>

      {/* Search bar */}
      <SearchBar category={category} query={q} />

      {/* Category filter pills */}
      <nav className="flex flex-wrap gap-2">
        <Link
          href={q ? `/standards?q=${encodeURIComponent(q)}` : "/standards"}
          className={`inline-block px-3 py-1.5 text-xs font-medium rounded-full no-underline transition-colors ${
            !category
              ? "bg-[var(--color-accent)] text-white"
              : "border border-[var(--color-border)] text-[var(--color-muted)] hover:bg-[var(--color-surface-hover)]"
          }`}
        >
          All
        </Link>
        {CATEGORIES.map((c) => {
          const isSelected = c.slug === category;
          const href = isSelected
            ? q
              ? `/standards?q=${encodeURIComponent(q)}`
              : "/standards"
            : q
              ? `/standards?category=${c.slug}&q=${encodeURIComponent(q)}`
              : `/standards?category=${c.slug}`;
          return (
            <Link
              key={c.slug}
              href={href}
              className={`inline-block px-3 py-1.5 text-xs font-medium rounded-full no-underline transition-colors ${
                isSelected
                  ? "bg-[var(--color-accent)] text-white"
                  : "border border-[var(--color-border)] text-[var(--color-muted)] hover:bg-[var(--color-surface-hover)]"
              }`}
            >
              {c.label}
            </Link>
          );
        })}
      </nav>

      {/* Results */}
      {standards.length === 0 ? (
        <div className="border border-dashed border-[var(--color-border)] rounded-lg p-8 text-center text-[var(--color-muted)] text-sm">
          No standards found{q ? ` matching "${q}"` : ""}.
        </div>
      ) : showGrouped && grouped ? (
        /* Grouped by category */
        <div className="space-y-10">
          {CATEGORIES.map((c) => {
            const items = grouped.get(c.slug);
            if (!items || items.length === 0) return null;
            return (
              <section key={c.slug}>
                <h3 className="text-xs font-semibold uppercase tracking-wide text-[var(--color-muted)] mb-3">
                  {c.label}
                </h3>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                  {items.map((std) => (
                    <StandardCard key={std.id} standard={std} />
                  ))}
                </div>
              </section>
            );
          })}
        </div>
      ) : (
        /* Flat list (filtered to one category) */
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
          {standards.map((std) => (
            <StandardCard key={std.id} standard={std} />
          ))}
        </div>
      )}
    </div>
  );
}
