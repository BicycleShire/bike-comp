import Link from "next/link";
import { CompatibilityBadge } from "./CompatibilityBadge";
import type { RuleWithStandards } from "@/lib/compatibility";

const TYPE_ORDER: Record<string, number> = {
  direct_fit: 0,
  with_adapter: 1,
  partial: 2,
  incompatible: 3,
};

export function ResultsList({
  rules,
  selectedStandardId,
  category,
  expandedRuleId,
}: {
  rules: RuleWithStandards[];
  selectedStandardId: string;
  category: string;
  expandedRuleId?: string;
}) {
  const sorted = [...rules].sort(
    (a, b) =>
      (TYPE_ORDER[a.compatibility_type] ?? 99) -
      (TYPE_ORDER[b.compatibility_type] ?? 99)
  );

  if (sorted.length === 0) {
    return (
      <p className="text-sm text-[var(--color-muted)]">
        No compatibility rules found for this standard yet.
      </p>
    );
  }

  return (
    <div className="space-y-3">
      {sorted.map((rule) => {
        const other =
          rule.standard_a_id === selectedStandardId
            ? rule.standard_b
            : rule.standard_a;
        const isExpanded = rule.id === expandedRuleId;

        return (
          <div
            key={rule.id}
            className="border border-[var(--color-border)] rounded-lg bg-[var(--color-surface)]"
          >
            <Link
              href={
                isExpanded
                  ? `/compatibility?category=${category}&standard=${selectedStandardId}`
                  : `/compatibility?category=${category}&standard=${selectedStandardId}&rule=${rule.id}`
              }
              className="flex items-start justify-between p-5 no-underline gap-4"
            >
              <div className="min-w-0">
                <h4 className="text-sm font-semibold">{other.name}</h4>
                <p className="text-xs text-[var(--color-muted)] mt-1 font-[family-name:var(--font-serif)] line-clamp-2">
                  {other.description}
                </p>
              </div>
              <div className="shrink-0">
                <CompatibilityBadge type={rule.compatibility_type} />
              </div>
            </Link>

            {isExpanded && (
              <div className="border-t border-[var(--color-border)] px-5 py-4 space-y-4 text-sm">
                {rule.caveats && (
                  <div>
                    <h5 className="text-xs font-semibold uppercase tracking-wide text-[var(--color-muted)] mb-1">
                      Details
                    </h5>
                    <p className="font-[family-name:var(--font-serif)] text-[var(--color-foreground)] leading-relaxed">
                      {rule.caveats}
                    </p>
                  </div>
                )}

                {rule.adapter_needed && (
                  <div>
                    <h5 className="text-xs font-semibold uppercase tracking-wide text-[var(--color-muted)] mb-1">
                      Adapter Needed
                    </h5>
                    <p className="font-[family-name:var(--font-serif)]">
                      {rule.adapter_needed}
                    </p>
                  </div>
                )}

                <div className="flex flex-wrap gap-x-6 gap-y-2 text-xs text-[var(--color-muted)]">
                  <span>
                    Confidence:{" "}
                    <span className="font-medium text-[var(--color-foreground)]">
                      {rule.confidence}
                    </span>
                  </span>
                  {rule.source_url && (
                    <a
                      href={rule.source_url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="underline hover:text-[var(--color-foreground)]"
                    >
                      Source
                    </a>
                  )}
                </div>

                {rule.source_notes && (
                  <p className="text-xs text-[var(--color-muted)] italic font-[family-name:var(--font-serif)]">
                    {rule.source_notes}
                  </p>
                )}
              </div>
            )}
          </div>
        );
      })}
    </div>
  );
}
